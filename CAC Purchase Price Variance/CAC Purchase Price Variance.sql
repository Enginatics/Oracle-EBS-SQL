/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Purchase Price Variance
-- Description: Report for Purchase Price Variance accounting entries for external inventory purchases, external outside processing purchases, (internal) intransit shipments, (internal) direct organization transfers and transfer to regular (consignment) transactions. The FOB point indicates when title passes to the receiving organization and it also determines which internal transfer transaction gets the PPV. With FOB Shipment, PPV happens on the Intransit Shipment transaction. With FOB Receipt, PPV happens on the Intransit Receipt transaction. And if you enter PO receipts by lot numbers this report splits out the PPV variances by lot number. The PPV Cost Amount column indicates PPV due to only cost differences; the PPV FX Amount column indicates PPV due to differences between the original PO currency exchange rate and the material transaction's daily exchange rate.
-- Parameters:
-- ===========
-- Transaction Date From: enter the starting transaction date (mandatory).
-- Transaction Date To: enter the ending transaction date (mandatory).
-- Currency Conversion Type: enter the currency conversion type to use for converting foreign currency purchases into the currency of hhe general ledger (mandatory).
-- Category Sets 1-3: any item category you wish, typically the Cost, Product Line or Inventory category sets (optional).
-- Item Number: enter the specific item number(s) you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2010-25 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- | 1.28 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 26 Jan 2010 Douglas Volz Initial Coding
-- -- | 1.17 01 Jan 2021 Douglas Volz Added Section 5 PPV for Transfer to Regular transactions.
-- -- | 1.18 08 Jan 2021 Douglas Volz Removed redundant joins and tables to improve performance.
-- -- | 1.19 14 Dec 2021 Douglas Volz Bug fix, Section I and V were both picking up
-- -- | Transfer to Regular PPV transactions
-- -- | 1.20 21 Jun 2022 Douglas Volz Add PO Line and PO Shipment Line Creation Date.
-- -- | 1.21 04 Apr 2022 Andy Haack Added organization security restriction by orgaccessview oav.
-- -- | 1.22 10 May 2023 Douglas Volz Fix PPV calculations for RTV and Receipt Adjustment transactions.
-- -- | 1.23 13 Jan 2024 Douglas Volz Rewrite report code for single material and WIP transaction pass,
-- -- | add Transaction Exchange Rate, PPV Cost Amount and PPV FX columns,
-- -- | improve performance and fix PPV amount and percent calculations.
-- -- | 1.24 24 Jan 2024 Douglas Volz Rename column Standard Unit Cost to Standard Purchase Unit Cost.
-- -- | 1.25 30 May 2025 Douglas Volz Bug fix for PO Unit Price, added in Clearing Accounting Line Type.
-- -- | 1.26 16 Jun 2025 Douglas Volz Bug fix for Intransit Shipment and Internal Order Intransit
-- -- | Shipment transaction types.
-- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-purchase-price-variance/
-- Library Link: https://www.enginatics.com/reports/cac-purchase-price-variance/
-- Run Report: https://demo.enginatics.com/

with t as (
select /*+ materialize*/
y.*,
round(y.converted_po_unit_price_/y.po_exchange_rate,5) po_unit_price,
round(y.converted_po_unit_price_,5) converted_po_unit_price,
round(y.standard_unit_cost-y.moh_unit_cost,5) standard_purchase_unit_cost,
round(y.converted_po_unit_price_,5)-round(y.standard_unit_cost-y.moh_unit_cost,5) unit_cost_difference,
round(y.converted_po_unit_price_*y.quantity,2) total_purchase_amount,
round((y.standard_unit_cost-y.moh_unit_cost)*y.quantity,2) total_standard_amount,
round((y.converted_po_unit_price_-(y.standard_unit_cost-y.moh_unit_cost))*y.quantity,2) ppv_amount,
case
when round(y.ppv_rate_or_amount,5)=0 then 0
when round(y.standard_unit_cost-y.moh_unit_cost,5)=0 then 100
when round(y.converted_po_unit_price_,5)=0 then -100
else round((y.converted_po_unit_price_-(y.standard_unit_cost-y.moh_unit_cost))/(y.standard_unit_cost-y.moh_unit_cost),5)*sign(y.quantity)*100
end percent_difference,
round((y.converted_po_unit_price_-(y.standard_unit_cost-y.moh_unit_cost))*y.quantity,2)-round((y.daily_exchange_rate-y.po_exchange_rate)*round(y.converted_po_unit_price_/y.po_exchange_rate,5)*y.quantity,2) ppv_cost_amount,
round((y.daily_exchange_rate-y.po_exchange_rate)*round(y.converted_po_unit_price_/y.po_exchange_rate,5)*y.quantity,2) ppv_fx_amount
from
(
select
x.*,
decode(x.ppv_type,'WIP_OSP',x.wip_received_quantity,x.received_quantity) quantity,
decode(x.po_currency_code,x.gl_currency_code,1,(select round(gdr.conversion_rate,8) from gl_daily_conversion_types gdct, gl_daily_rates gdr where 4=4 and gdct.conversion_type=gdr.conversion_type and x.po_currency_code=gdr.from_currency and x.gl_currency_code=gdr.to_currency and x.transaction_date=gdr.conversion_date)) daily_exchange_rate
from
(
select
case
when mmt.transaction_action_id=3 and mmt.transaction_source_type_id=13 then 'Direct Transfer'
when mmt.transaction_action_id=6 and mmt.transaction_source_type_id=1 then 'Transfer to Regular'
when mmt.transaction_source_type_id=1 then 'Purchase Order'
when mmt.transaction_source_type_id=7 then 'Internal Requisitions'
when mmt.transaction_source_type_id=8 then 'Internal Orders'
when mmt.transaction_source_type_id=13 then 'Intransit'
end ppv_type,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
mp.organization_id,
case when mmt.transaction_action_id in (3,9,13,21,22) then nvl(mmt.transfer_organization_id,mmt.organization_id) when mmt.transaction_action_id in (10,12,15,17) then mmt.organization_id end ship_to_org_id,
case when mmt.transaction_action_id in (3,9,13,21,22) then mmt.organization_id when mmt.transaction_action_id in (10,12,15,17) then nvl(mmt.transfer_organization_id,mmt.organization_id) end ship_from_org_id,
ah.period_name,
max(decode(mta.accounting_line_type,6,al.code_combination_id)) code_combination_id,
msiv.inventory_item_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
to_char(null) wip_job,
to_char(null) osp_resource,
to_char(null) osp_unit_of_measure,
mmt.transaction_source_id,
mmt.source_line_id,
mmt.trx_source_line_id,
mmt.shipment_number,
mmt.created_by,
mmt.creation_date shipment_creation_date,
mtt.transaction_type_name transaction_type,
mmt.transaction_id,
mmt.rcv_transaction_id,
mmt.transfer_transaction_id,
mmt.move_transaction_id,
trunc(mmt.transaction_date) transaction_date,
mtln.lot_number,
msiv.primary_uom_code uom_code,
case
when mmt.fob_point=1 or mmt.fob_point is null and mmt.transaction_action_id=3 then -nvl(mtln.primary_quantity,mmt.primary_quantity)
else nvl(mtln.primary_quantity,mmt.primary_quantity)
end received_quantity,
0 wip_received_quantity,
gl.currency_code gl_currency_code,
nvl(mta.currency_code,gl.currency_code) po_currency_code,
sum(decode(mta.accounting_line_type,6,nvl(mta.rate_or_amount,0),0)) ppv_rate_or_amount,
round(nvl(mta.currency_conversion_rate,1),8) po_exchange_rate,
sum(case when mmt.transaction_action_id in (1,27,29) and mmt.transaction_source_type_id=1 and mta.accounting_line_type in (5,31) or mmt.transaction_action_id=3 and mmt.transaction_source_type_id in (8,13) and mta.accounting_line_type=9 or mmt.transaction_action_id=6 and mmt.transaction_source_type_id=1 and mta.accounting_line_type=16 or mmt.transaction_action_id=12 and mmt.transaction_source_type_id in (7,13) and mta.accounting_line_type=9 or mmt.transaction_action_id=21 and mmt.transaction_source_type_id=8 and mta.accounting_line_type in (2,9) or mmt.transaction_action_id=21 and mmt.transaction_source_type_id=13 and mta.accounting_line_type=9 then nvl(mta.rate_or_amount,0) else 0 end) converted_po_unit_price_,
sum(case when mta.accounting_line_type=1 and (mmt.transaction_action_id in (1,3,6,12,27,29) or mmt.transaction_action_id=21 and mmt.transaction_source_type_id in (8,13)) or mta.accounting_line_type=14 and (mmt.transaction_action_id in (1,3,12,21) and mmt.transaction_source_type_id in (7,8,13)) then nvl(mta.rate_or_amount,0) else 0 end) standard_unit_cost,
sum(case when mta.accounting_line_type=3 and mmt.transaction_action_id in (1,3,6,12,21,27,29) then nvl(mta.rate_or_amount,0) else 0 end) moh_unit_cost
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_transaction_accounts mta,
mtl_material_transactions mmt,
mtl_transaction_lot_numbers mtln,
mtl_transaction_types mtt,
mtl_system_items_vl msiv,
xla_distribution_links xdl,
xla_ae_lines al,
xla_ae_headers ah
where
1=1 and
2=2 and
3=3 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
(mta.transaction_id,mta.organization_id) in (select mta2.transaction_id, mta2.organization_id from mtl_transaction_accounts mta2 where mta2.transaction_date>=:p_trx_date_from and mta2.transaction_date<:p_trx_date_to+1 and mta2.transaction_source_type_id in (1,7,8,13) and mta2.accounting_line_type=6) and
mp.organization_id=mta.organization_id and
mta.transaction_id=mmt.transaction_id and
mmt.transaction_source_type_id in (1,7,8,13) and
mmt.transaction_id=mtln.transaction_id(+) and
mmt.inventory_item_id=mtln.inventory_item_id(+) and
mmt.organization_id=mtln.organization_id(+) and
mmt.transaction_type_id=mtt.transaction_type_id and
mmt.organization_id=msiv.organization_id and
mmt.inventory_item_id=msiv.inventory_item_id and
mta.inv_sub_ledger_id=xdl.source_distribution_id_num_1 and
xdl.source_distribution_type='MTL_TRANSACTION_ACCOUNTS' and
xdl.application_id=707 and
xdl.ae_header_id=al.ae_header_id and
xdl.ae_line_num=al.ae_line_num and
al.application_id=707 and
al.ae_header_id=ah.ae_header_id and
al.application_id=ah.application_id and
al.ledger_id=ah.ledger_id and
gl.ledger_id=ah.ledger_id
group by
gl.short_name,
gl.name,
haouv_ou.name,
mp.organization_code,
mp.organization_id,
mmt.transaction_action_id,
mmt.transaction_source_type_id,
mmt.transfer_organization_id,
mmt.organization_id,
ah.period_name,
msiv.inventory_item_id,
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
mmt.transaction_source_id,
mmt.source_line_id,
mmt.trx_source_line_id,
mmt.fob_point,
mmt.shipment_number,
mmt.created_by,
mmt.creation_date,
mtt.transaction_type_name,
mmt.transaction_id,
mmt.rcv_transaction_id,
mmt.transfer_transaction_id,
mmt.move_transaction_id,
mmt.transaction_date,
mtln.lot_number,
mtln.primary_quantity,
mmt.primary_quantity,
msiv.primary_uom_code,
gl.currency_code,
mta.currency_code,
mta.currency_conversion_rate
union all
select
'WIP_OSP' ppv_type,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
mp.organization_id,
mp.organization_id ship_to_org_id,
to_number(null) ship_from_org_id,
ah.period_name,
max(decode(wta.accounting_line_type,6,al.code_combination_id)) code_combination_id,
msiv.inventory_item_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
we.wip_entity_name wip_job,
br.resource_code osp_resource,
br.unit_of_measure osp_unit_of_measure,
wt.po_header_id transaction_source_id,
null source_line_id,
null trx_source_line_id,
null shipment_number,
wt.created_by,
wt.creation_date shipment_creation_date,
xxen_util.meaning(wt.transaction_type,'WIP_TRANSACTION_TYPE_SHORT',700) transaction_type,
wt.transaction_id,
wt.rcv_transaction_id,
null transfer_transaction_id,
null move_transaction_id,
trunc(wt.transaction_date) transaction_date,
null lot_number,
null uom_code,
0 received_quantity,
wt.primary_quantity wip_received_quantity,
gl.currency_code gl_currency_code,
nvl(wta.currency_code,gl.currency_code) po_currency_code,
sum(decode(wta.accounting_line_type,6,nvl(wta.rate_or_amount,0),0)) ppv_rate_or_amount,
round(nvl(wta.currency_conversion_rate,1),8) po_exchange_rate,
sum(case when wt.source_code='RCV' and wta.accounting_line_type in (4,5) then nvl(wta.rate_or_amount,0) else 0 end) converted_po_unit_price_,
sum(case when wt.source_code='RCV' and wta.accounting_line_type=7 then nvl(wta.rate_or_amount,0) else 0 end) standard_unit_cost,
sum(case when wt.source_code='RCV' and wta.accounting_line_type=3 then nvl(wta.rate_or_amount,0) else 0 end) moh_unit_cost
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
wip_transaction_accounts wta,
wip_transactions wt,
wip_entities we,
wip_discrete_jobs wdj,
bom_resources br,
mtl_system_items_vl msiv,
xla_distribution_links xdl,
xla_ae_lines al,
xla_ae_headers ah
where
1=1 and
3=3 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
(wta.transaction_id,wta.organization_id) in (select wta2.transaction_id, wta2.organization_id from wip_transaction_accounts wta2 where wta2.transaction_date>=:p_trx_date_from and wta2.transaction_date<:p_trx_date_to+1 and wta2.accounting_line_type=6) and
mp.organization_id=wta.organization_id and
wta.transaction_id=wt.transaction_id and
wt.transaction_date>=:p_trx_date_from and
wt.transaction_date<:p_trx_date_to+1 and
wt.standard_rate_flag=1 and
wta.resource_id=br.resource_id and
br.cost_element_id=4 and
wt.wip_entity_id=wdj.wip_entity_id and
wdj.wip_entity_id=we.wip_entity_id and
wdj.organization_id=msiv.organization_id and
wdj.primary_item_id=msiv.inventory_item_id and
wta.wip_sub_ledger_id=xdl.source_distribution_id_num_1 and
xdl.source_distribution_type='WIP_TRANSACTION_ACCOUNTS' and
xdl.application_id=707 and
xdl.ae_header_id=al.ae_header_id and
xdl.ae_line_num=al.ae_line_num and
al.application_id=707 and
al.ae_header_id=ah.ae_header_id and
al.application_id=ah.application_id and
al.ledger_id=ah.ledger_id and
gl.ledger_id=ah.ledger_id
group by
gl.short_name,
gl.name,
haouv_ou.name,
mp.organization_code,
mp.organization_id,
ah.period_name,
msiv.inventory_item_id,
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
we.wip_entity_name,
br.resource_code,
br.unit_of_measure,
wt.po_header_id,
wt.created_by,
wt.creation_date,
wt.transaction_type,
wt.transaction_id,
wt.rcv_transaction_id,
wt.transaction_date,
wt.primary_quantity,
gl.currency_code,
wta.currency_code,
wta.currency_conversion_rate
) x
) y
)
select
t.ledger,
t.operating_unit,
t.org_code ship_to_org,
(select mp.organization_code from mtl_parameters mp where t.ship_from_org_id=mp.organization_id) ship_from_org,
t.period_name,
&segment_columns
z.supplier,
z.buyer,
t.item_number,
t.item_description,
xxen_util.meaning(t.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(t.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
z.wip_job,
z.osp_resource,
z.pr_or_po_number,
z.line_number,
z.line_creation_date,
z.po_release,
z.receipt_number,
z.shipment_number,
z.shipment_creation_date,
xxen_util.meaning(6,'CST_ACCOUNTING_LINE_TYPE',700) accounting_line_type,
t.transaction_type,
t.transaction_id,
t.transaction_date,
t.lot_number,
z.uom_code,
z.received_quantity,
t.wip_received_quantity,
z.po_currency_code,
t.po_unit_price,
t.po_exchange_rate,
t.daily_exchange_rate,
t.gl_currency_code,
t.converted_po_unit_price,
t.standard_purchase_unit_cost,
t.unit_cost_difference,
t.total_purchase_amount,
t.total_standard_amount,
t.ppv_amount,
t.percent_difference,
t.ppv_cost_amount,
t.ppv_fx_amount
from
t,
(
select
t.transaction_id,
t.ppv_type,
t.lot_number,
aps.vendor_name supplier,
he.full_name buyer,
to_char(null) wip_job,
to_char(null) osp_resource,
pha.segment1 pr_or_po_number,
to_char(pla.line_num) line_number,
pla.creation_date line_creation_date,
to_char(pra.release_num) po_release,
rsh.receipt_num receipt_number,
rsh.shipment_num shipment_number,
plla.creation_date shipment_creation_date,
t.uom_code,
t.received_quantity,
nvl(pha.currency_code,t.po_currency_code) po_currency_code
from
t,
rcv_transactions rt,
po_distributions_all pda,
po_line_locations_all plla,
po_lines_all pla,
po_headers_all pha,
po_releases_all pra,
rcv_shipment_headers rsh,
ap_suppliers aps,
hr_employees he
where
t.ppv_type='Purchase Order' and
t.rcv_transaction_id=rt.transaction_id and
rt.po_distribution_id=pda.po_distribution_id and
pda.destination_type_code='INVENTORY' and
pda.line_location_id=plla.line_location_id and
plla.po_line_id=pla.po_line_id and
rt.po_line_id=pla.po_line_id and
t.transaction_source_id=pha.po_header_id and
plla.po_release_id=pra.po_release_id(+) and
rt.shipment_header_id=rsh.shipment_header_id and
pha.vendor_id=aps.vendor_id and
pha.agent_id=he.employee_id
union all
select
t.transaction_id,
t.ppv_type,
t.lot_number,
aps.vendor_name supplier,
he.full_name buyer,
t.wip_job,
t.osp_resource,
pha.segment1 pr_or_po_number,
to_char(pla.line_num) line_number,
pla.creation_date line_creation_date,
to_char(pra.release_num) po_release,
rsh.receipt_num receipt_number,
rsh.shipment_num shipment_number,
plla.creation_date shipment_creation_date,
decode(msiv_osp.outside_operation_uom_type,'ASSEMBLY',msiv_osp.primary_uom_code,'RESOURCE',t.osp_unit_of_measure) uom_code,
round(sign(t.wip_received_quantity)*rt.primary_quantity,3) received_quantity,
nvl(pha.currency_code,t.po_currency_code) po_currency_code
from
t,
rcv_transactions rt,
po_distributions_all pda,
po_line_locations_all plla,
po_lines_all pla,
po_headers_all pha,
po_releases_all pra,
rcv_shipment_headers rsh,
mtl_system_items_vl msiv_osp,
ap_suppliers aps,
hr_employees he
where
t.ppv_type='WIP_OSP' and
t.rcv_transaction_id=rt.transaction_id and
rt.po_distribution_id=pda.po_distribution_id and
pda.destination_type_code='SHOP FLOOR' and
pda.line_location_id=plla.line_location_id and
plla.po_line_id=pla.po_line_id and
pla.po_header_id=pha.po_header_id and
plla.po_release_id=pra.po_release_id(+) and
rt.shipment_header_id=rsh.shipment_header_id and
rt.organization_id=msiv_osp.organization_id and
pla.item_id=msiv_osp.inventory_item_id and
pha.vendor_id=aps.vendor_id and
pha.agent_id=he.employee_id
union all
select
t.transaction_id,
t.ppv_type,
t.lot_number,
null supplier,
fu.user_name buyer,
null wip_job,
null osp_resource,
(select prha.segment1 from po_requisition_headers_all prha where t.transaction_source_id=prha.requisition_header_id) pr_or_po_number,
(select to_char(prla.line_num) from rcv_transactions rt, po_requisition_lines_all prla where t.rcv_transaction_id=rt.transaction_id and rt.requisition_line_id=prla.requisition_line_id) line_number,
(
select prla.creation_date from rcv_transactions rt, po_requisition_lines_all prla where t.rcv_transaction_id=rt.transaction_id and rt.requisition_line_id=prla.requisition_line_id
union
select rsl.creation_date from rcv_shipment_lines rsl where rsh.shipment_header_id=rsl.shipment_header_id and nvl(t.transfer_transaction_id,t.transaction_id)=rsl.mmt_transaction_id and rsl.requisition_line_id is null
) line_creation_date,
null po_release,
rsh.receipt_num receipt_number,
t.shipment_number,
t.shipment_creation_date,
t.uom_code,
t.received_quantity,
t.po_currency_code
from
t,
rcv_shipment_headers rsh,
fnd_user fu
where
t.ppv_type in ('Direct Transfer','Internal Requisitions','Intransit') and
t.shipment_number=rsh.shipment_num(+) and
t.created_by=fu.user_id
union all
select
t.transaction_id,
t.ppv_type,
t.lot_number,
haouv_src.name supplier,
he.full_name buyer,
null wip_job,
null osp_resource,
decode(ooha.order_source_id,10,ooha.orig_sys_document_ref) pr_or_po_number,
decode(ooha.order_source_id,10,oola.orig_sys_line_ref) line_number,
prla.creation_date line_creation_date,
null po_release,
null receipt_number,
t.shipment_number,
t.shipment_creation_date,
t.uom_code,
t.received_quantity,
t.po_currency_code
from
t,
oe_order_lines_all oola,
oe_order_headers_all ooha,
po_requisition_lines_all prla,
po_requisition_headers_all prha,
hr_employees he,
hr_organization_information hoi_src,
hr_all_organization_units_vl haouv_src
where
t.ppv_type='Internal Orders' and
t.trx_source_line_id=oola.line_id and
oola.line_category_code='ORDER' and
oola.order_source_id=10 and
oola.header_id=ooha.header_id and
oola.source_document_line_id=prla.requisition_line_id and
t.ship_to_org_id=prla.destination_organization_id and
t.inventory_item_id=prla.item_id and
prla.requisition_header_id=prha.requisition_header_id and
prha.preparer_id=he.employee_id and
t.ship_from_org_id=hoi_src.organization_id and
hoi_src.org_information_context='Accounting Information' and
hoi_src.organization_id=haouv_src.organization_id
union all
select
t.transaction_id,
t.ppv_type,
t.lot_number,
aps.vendor_name supplier,
fu.user_name buyer,
(select we.wip_entity_name from wip_move_transactions wmt, wip_entities we where t.move_transaction_id=wmt.transaction_id and wmt.wip_entity_id=we.wip_entity_id) wip_job,
null osp_resource,
pha.segment1 pr_or_po_number,
to_char(pla.line_num) line_number,
pla.creation_date line_creation_date,
(select to_char(pra.release_num) from po_releases_all pra where pha.po_header_id=pra.po_header_id and t.source_line_id=pra.release_num) po_release,
null receipt_number,
t.shipment_number,
t.shipment_creation_date,
t.uom_code,
t.received_quantity,
nvl(pha.currency_code,t.po_currency_code) po_currency_code
from
t,
mtl_consumption_transactions mct,
po_lines_all pla,
po_headers_all pha,
ap_suppliers aps,
hr_employees he,
fnd_user fu
where
t.ppv_type='Transfer to Regular' and
t.transfer_transaction_id=mct.transaction_id and
mct.po_line_id=pla.po_line_id and
pla.po_header_id=pha.po_header_id and
pha.vendor_id=aps.vendor_id and
pha.agent_id=he.employee_id and
t.created_by=fu.user_id
) z,
mtl_item_status_vl misv,
gl_code_combinations gcc
where
t.transaction_id=z.transaction_id and
t.ppv_type=z.ppv_type and
nvl(t.lot_number,'~')=nvl(z.lot_number,'~') and
t.inventory_item_status_code=misv.inventory_item_status_code and
t.code_combination_id=gcc.code_combination_id(+)
order by
t.ledger,
t.operating_unit,
ship_to_org,
ship_from_org,
t.period_name,
t.item_number,
t.transaction_type,
t.transaction_id,
t.transaction_date,
t.lot_number
