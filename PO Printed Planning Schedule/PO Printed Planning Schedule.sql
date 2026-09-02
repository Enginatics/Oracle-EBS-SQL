/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Printed Planning Schedule
-- Description: Migration of the Oracle standard concurrent program Printed Planning Schedule (XML) (CHVPRSCH_XML) from Supplier Scheduling. Shows, for each confirmed planning/shipping schedule, the time-phased demand grid sent to the supplier - one row per schedule, item and time bucket - with forecast, released, total and cumulative (CUM+) quantities per bucket, plus the schedule header, item, CUM and authorization context. The horizontal schedule grid (chv_horizontal_schedules, up to 60 bucket columns) is un-pivoted into rows for analysis in Excel.
-- Excel Examle Output: https://www.enginatics.com/example/po-printed-planning-schedule/
-- Library Link: https://www.enginatics.com/reports/po-printed-planning-schedule/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code organization,
csh.schedule_num schedule_number,
decode(csh.schedule_type,'PLAN_SCHEDULE','Planning','SHIP_SCHEDULE','Shipping',csh.schedule_type) schedule_type,
xxen_util.meaning(csh.schedule_subtype,decode(csh.schedule_type,'PLAN_SCHEDULE','PLAN_SCHEDULE_SUBTYPE','SHIP_SCHEDULE_SUBTYPE'),201) subtype,
xxen_util.meaning(csh.schedule_status,'SCHEDULE_STATUS',201) status,
csh.schedule_revision revision,
cbp.bucket_pattern_name bucket_pattern,
csh.schedule_horizon_start horizon_start,
csh.schedule_horizon_end horizon_end,
csh.mrp_compile_designator mrp_plan,
csh.mps_schedule_designator mps_plan,
csh.drp_compile_designator drp_plan,
pov.vendor_name supplier,
povs.vendor_site_code supplier_site,
povs.address_line1||decode(povs.city,null,null,', '||povs.city)||decode(povs.state,null,null,', '||povs.state)||' '||povs.zip supplier_address,
msibk.concatenated_segments item,
msibk.description item_description,
csi.purchasing_unit_of_measure uom,
poh.segment1 supply_agreement,
xxen_util.meaning(csi.item_planning_method,'PLANNING_METHOD',201) planning_method,
(select ppf.full_name from per_all_people_f ppf where ppf.person_id=msibk.buyer_id and trunc(sysdate) between ppf.effective_start_date and ppf.effective_end_date and rownum=1) buyer,
(select ppf.full_name from po_asl_attributes paa, per_all_people_f ppf where paa.vendor_id=csh.vendor_id and paa.vendor_site_id=csh.vendor_site_id and paa.item_id=csi.item_id and paa.using_organization_id=(select max(paa2.using_organization_id) from po_asl_attributes paa2 where paa2.vendor_id=csh.vendor_id and paa2.vendor_site_id=csh.vendor_site_id and paa2.item_id=csi.item_id and paa2.using_organization_id in (csi.organization_id,-1)) and paa.scheduler_id=ppf.person_id and trunc(sysdate) between ppf.effective_start_date and ppf.effective_end_date and rownum=1) scheduler,
xxen_util.yes(coo.enable_cum_flag) enable_cum,
(select ccp.cum_period_start_date from chv_cum_periods ccp where ccp.organization_id=csi.organization_id and sysdate between ccp.cum_period_start_date and ccp.cum_period_end_date and rownum=1) cum_start_date,
csi.starting_cum_quantity starting_cum_quantity,
(select rsh.shipment_num from rcv_transactions rct, rcv_shipment_headers rsh where rct.transaction_id=csi.last_receipt_transaction_id and rct.shipment_header_id=rsh.shipment_header_id) last_receipt_number,
(select rct.quantity from rcv_transactions rct where rct.transaction_id=csi.last_receipt_transaction_id) last_receipt_quantity,
(select xxen_util.meaning(ca.authorization_code,'AUTHORIZATION_TYPE',201) from chv_authorizations ca where ca.reference_type='SCHEDULE_ITEMS' and ca.authorization_sequence=1 and ca.reference_id=csi.schedule_item_id and rownum=1) auth1_type,
(select ca.schedule_quantity from chv_authorizations ca where ca.reference_type='SCHEDULE_ITEMS' and ca.authorization_sequence=1 and ca.reference_id=csi.schedule_item_id and rownum=1) auth1_quantity,
(select xxen_util.meaning(ca.authorization_code,'AUTHORIZATION_TYPE',201) from chv_authorizations ca where ca.reference_type='SCHEDULE_ITEMS' and ca.authorization_sequence=2 and ca.reference_id=csi.schedule_item_id and rownum=1) auth2_type,
(select ca.schedule_quantity from chv_authorizations ca where ca.reference_type='SCHEDULE_ITEMS' and ca.authorization_sequence=2 and ca.reference_id=csi.schedule_item_id and rownum=1) auth2_quantity,
(select xxen_util.meaning(ca.authorization_code,'AUTHORIZATION_TYPE',201) from chv_authorizations ca where ca.reference_type='SCHEDULE_ITEMS' and ca.authorization_sequence=3 and ca.reference_id=csi.schedule_item_id and rownum=1) auth3_type,
(select ca.schedule_quantity from chv_authorizations ca where ca.reference_type='SCHEDULE_ITEMS' and ca.authorization_sequence=3 and ca.reference_id=csi.schedule_item_id and rownum=1) auth3_quantity,
(select xxen_util.meaning(ca.authorization_code,'AUTHORIZATION_TYPE',201) from chv_authorizations ca where ca.reference_type='SCHEDULE_ITEMS' and ca.authorization_sequence=4 and ca.reference_id=csi.schedule_item_id and rownum=1) auth4_type,
(select ca.schedule_quantity from chv_authorizations ca where ca.reference_type='SCHEDULE_ITEMS' and ca.authorization_sequence=4 and ca.reference_id=csi.schedule_item_id and rownum=1) auth4_quantity,
b.bucket_seq,
xxen_util.meaning(b.bucket_type_code,'SCHEDULE_BUCKET_TYPE',201) bucket_type,
to_date(b.bucket_start_str,'YYYY/MM/DD') bucket_start_date,
to_date(b.bucket_end_str,'YYYY/MM/DD') bucket_end_date,
to_number(b.forecast_qty_str) forecast_quantity,
to_number(b.release_qty_str) released_quantity,
to_number(b.total_qty_str) total_quantity,
to_number(b.cum_qty_str) cum_quantity
from
(
select
hs.schedule_id,
hs.schedule_item_id,
hs.bucket_seq,
max(case when hs.row_type='BUCKET_DESCRIPTOR' then hs.cell end) bucket_type_code,
max(case when hs.row_type='BUCKET_START_DATE' then hs.cell end) bucket_start_str,
max(case when hs.row_type='BUCKET_END_DATE' then hs.cell end) bucket_end_str,
max(case when hs.row_type='RELEASE_QUANTITY' then hs.cell end) release_qty_str,
max(case when hs.row_type='FORECAST_QUANTITY' then hs.cell end) forecast_qty_str,
max(case when hs.row_type='TOTAL_QUANTITY' then hs.cell end) total_qty_str,
max(case when hs.row_type='CUM_QUANTITY' then hs.cell end) cum_qty_str
from
(
select chs.schedule_id, chs.schedule_item_id, chs.row_type, rg.column_value bucket_seq, decode(rg.column_value,1,chs.column1,2,chs.column2,3,chs.column3,4,chs.column4,5,chs.column5,6,chs.column6,7,chs.column7,8,chs.column8,9,chs.column9,10,chs.column10,11,chs.column11,12,chs.column12,13,chs.column13,14,chs.column14,15,chs.column15,16,chs.column16,17,chs.column17,18,chs.column18,19,chs.column19,20,chs.column20,21,chs.column21,22,chs.column22,23,chs.column23,24,chs.column24,25,chs.column25,26,chs.column26,27,chs.column27,28,chs.column28,29,chs.column29,30,chs.column30,31,chs.column31,32,chs.column32,33,chs.column33,34,chs.column34,35,chs.column35,36,chs.column36,37,chs.column37,38,chs.column38,39,chs.column39,40,chs.column40,41,chs.column41,42,chs.column42,43,chs.column43,44,chs.column44,45,chs.column45,46,chs.column46,47,chs.column47,48,chs.column48,49,chs.column49,50,chs.column50,51,chs.column51,52,chs.column52,53,chs.column53,54,chs.column54,55,chs.column55,56,chs.column56,57,chs.column57,58,chs.column58,59,chs.column59,60,chs.column60) cell
from chv_horizontal_schedules chs, table(xxen_util.rowgen(60)) rg
where chs.row_type in ('BUCKET_DESCRIPTOR','BUCKET_START_DATE','BUCKET_END_DATE','RELEASE_QUANTITY','FORECAST_QUANTITY','TOTAL_QUANTITY','CUM_QUANTITY')
) hs
group by hs.schedule_id, hs.schedule_item_id, hs.bucket_seq
having max(case when hs.row_type='BUCKET_DESCRIPTOR' then hs.cell end) is not null
) b,
chv_schedule_items csi,
chv_schedule_headers csh,
chv_bucket_patterns cbp,
chv_org_options coo,
mtl_system_items_b_kfv msibk,
org_organization_definitions ood,
po_vendors pov,
po_vendor_sites_all povs,
po_headers_all poh
where
b.schedule_id=csi.schedule_id and
b.schedule_item_id=csi.schedule_item_id and
csi.schedule_id=csh.schedule_id and
csh.bucket_pattern_id=cbp.bucket_pattern_id and
csi.organization_id=coo.organization_id(+) and
csi.item_id=msibk.inventory_item_id and
csi.organization_id=msibk.organization_id and
csi.organization_id=ood.organization_id and
csh.vendor_id=pov.vendor_id and
csh.vendor_site_id=povs.vendor_site_id and
csi.po_header_id=poh.po_header_id(+) and
nvl(csi.item_purge_status,'ACTIVE')<>'PURGED' and
(
csi.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) or
not exists (select null from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
) and
1=1
order by
csh.schedule_num,
msibk.concatenated_segments,
b.bucket_seq