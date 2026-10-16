/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: QA Quality Results
-- Description: One row per collection result and characteristic, so results from any number of collection plans stack in a single extract instead of one column per characteristic. Use Collection Plan like to pull a whole family of plans in one run, for example INCMRC%.
-- Oracle Quality stores every element value as a string in a generic column of qaresults, and the plan's element definition decides which column holds which characteristic. Result is therefore text. Result Number carries the numeric conversion for Number elements so the values can be charted or averaged, and Date elements arrive as YYYY/MM/DD.
-- Only the elements an operator fills in are listed as characteristic rows. The context elements a plan collects, being item, revision, lot, serial, subinventory, quantity, job, purchase order, supplier and customer, are columns on every row instead, so they can be filtered and pivoted without appearing as results.
-- Result Date is when the result was recorded. Exclude Empty Results defaults to Yes, so clear it to also list elements that are enabled on the plan but were left blank.
-- Excel Example Output: https://www.enginatics.com/example/qa-quality-results/
-- Library Link: https://www.enginatics.com/reports/qa-quality-results/
-- Run Report: https://demo.enginatics.com/

select
x.organization_code,
x.collection_plan,
x.plan_description,
x.item,
x.item_description,
x.revision,
x.lot_number,
x.serial_number,
x.subinventory,
x.quantity,
x.uom,
x.job,
x.po_number,
x.supplier,
x.customer,
x.characteristic,
x.element_name,
x.element_datatype,
x.element_uom,
x.result,
case when x.datatype=2 and regexp_like(x.result,'^[+-]?([0-9]+(\.[0-9]*)?|\.[0-9]+)$') then fnd_number.canonical_to_number(x.result) end result_number,
x.result_date,
x.transaction_date,
x.entered_by,
x.collection_id,
x.occurrence,
x.element_sequence
from
(
select
mp.organization_code,
qp.name collection_plan,
qp.description plan_description,
msiv.concatenated_segments item,
msiv.description item_description,
qr.revision,
qr.lot_number,
qr.serial_number,
qr.subinventory,
qr.quantity,
qr.uom,
(select we.wip_entity_name from wip_entities we where qr.wip_entity_id=we.wip_entity_id) job,
(select pha.segment1 from po_headers_all pha where qr.po_header_id=pha.po_header_id) po_number,
(select pv.vendor_name from po_vendors pv where qr.vendor_id=pv.vendor_id) supplier,
(select hp.party_name from hz_cust_accounts hca, hz_parties hp where qr.customer_id=hca.cust_account_id and hca.party_id=hp.party_id) customer,
nvl(qpc.prompt,qc.prompt) characteristic,
qc.name element_name,
xxen_util.meaning(to_char(qc.datatype),'QA_CHAR_DATATYPE',700) element_datatype,
nvl(qpc.uom_code,qc.uom_code) element_uom,
qc.datatype,
case
when qpc.result_column_name like 'CHARACTER%' then
decode(to_number(substr(qpc.result_column_name,10))
,1,qr.character1,2,qr.character2,3,qr.character3,4,qr.character4,5,qr.character5,6,qr.character6,7,qr.character7,8,qr.character8
,9,qr.character9,10,qr.character10,11,qr.character11,12,qr.character12,13,qr.character13,14,qr.character14,15,qr.character15,16,qr.character16
,17,qr.character17,18,qr.character18,19,qr.character19,20,qr.character20,21,qr.character21,22,qr.character22,23,qr.character23,24,qr.character24
,25,qr.character25,26,qr.character26,27,qr.character27,28,qr.character28,29,qr.character29,30,qr.character30,31,qr.character31,32,qr.character32
,33,qr.character33,34,qr.character34,35,qr.character35,36,qr.character36,37,qr.character37,38,qr.character38,39,qr.character39,40,qr.character40
,41,qr.character41,42,qr.character42,43,qr.character43,44,qr.character44,45,qr.character45,46,qr.character46,47,qr.character47,48,qr.character48
,49,qr.character49,50,qr.character50,51,qr.character51,52,qr.character52,53,qr.character53,54,qr.character54,55,qr.character55,56,qr.character56
,57,qr.character57,58,qr.character58,59,qr.character59,60,qr.character60,61,qr.character61,62,qr.character62,63,qr.character63,64,qr.character64
,65,qr.character65,66,qr.character66,67,qr.character67,68,qr.character68,69,qr.character69,70,qr.character70,71,qr.character71,72,qr.character72
,73,qr.character73,74,qr.character74,75,qr.character75,76,qr.character76,77,qr.character77,78,qr.character78,79,qr.character79,80,qr.character80
,81,qr.character81,82,qr.character82,83,qr.character83,84,qr.character84,85,qr.character85,86,qr.character86,87,qr.character87,88,qr.character88
,89,qr.character89,90,qr.character90,91,qr.character91,92,qr.character92,93,qr.character93,94,qr.character94,95,qr.character95,96,qr.character96
,97,qr.character97,98,qr.character98,99,qr.character99,100,qr.character100)
when qpc.result_column_name like 'COMMENT%' then
decode(to_number(substr(qpc.result_column_name,8))
,1,qr.comment1,2,qr.comment2,3,qr.comment3,4,qr.comment4,5,qr.comment5)
when qpc.result_column_name like 'SEQUENCE%' then
decode(to_number(substr(qpc.result_column_name,9))
,1,qr.sequence1,2,qr.sequence2,3,qr.sequence3,4,qr.sequence4,5,qr.sequence5,6,qr.sequence6,7,qr.sequence7,8,qr.sequence8
,9,qr.sequence9,10,qr.sequence10,11,qr.sequence11,12,qr.sequence12,13,qr.sequence13,14,qr.sequence14,15,qr.sequence15)
end result,
xxen_util.client_time(qr.creation_date) result_date,
xxen_util.client_time(qr.transaction_date) transaction_date,
xxen_util.user_name(qr.created_by) entered_by,
qr.collection_id,
qr.occurrence,
qpc.prompt_sequence element_sequence
from
qa_results qr,
qa_plans qp,
qa_plan_chars qpc,
qa_chars qc,
mtl_parameters mp,
mtl_system_items_vl msiv
where
qr.plan_id=qp.plan_id and
qr.plan_id=qpc.plan_id and
qpc.char_id=qc.char_id and
qpc.enabled_flag=1 and
(qpc.result_column_name like 'CHARACTER%' or qpc.result_column_name like 'COMMENT%' or qpc.result_column_name like 'SEQUENCE%') and
qr.organization_id=mp.organization_id(+) and
qr.item_id=msiv.inventory_item_id(+) and
qr.organization_id=msiv.organization_id(+) and
qr.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
1=1
) x
where
2=2
order by
x.organization_code,
x.collection_plan,
x.collection_id,
x.occurrence,
x.element_sequence
