/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Receiving Value (Period-End)
-- Description: Report to show receiving value for all locations, as of the end of an accounting period. You may run this report for open or closed accounting periods. With parameters to display or not display WIP outside processing information (WIP job, status, close date and OSP resource code). If run for a prior period the report automatically rolls back the quantities and values to the prior period's period end date. In addition, for any receipt with an item number, this report displays Inventory, Shop Floor (Outside Processing) and Expense destination types.
-- Note: The Adjustment Amount column show differences between the PO unit price for the Receipt and Deliver transactions, which currently is not included in the receiving accounting entries.
-- Reconciliation Notes to Oracle Reports:
-- The Oracle All Inventory Values Report does not display Shop Floor (Outside Processing) or Expense destination types.
-- If the PO line is closed, the Oracle Receiving Value Report does not display Expense destination types, even if the receipt is still in receiving and has not been delivered.
-- / +=============================================================================+
-- -- | Copyright 2009 - 2025 Douglas Volz Consulting, Inc. and Enginatics GmbH
-- -- | All rights reserved.
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 25 Nov 2009 Douglas Volz Created initial Report for client
-- -- | based on xxxinvvalue.sql
-- -- | 1.36 10 Aug 2022 Douglas Volz Performance improvements for main query. Allow expense
-- -- | receipts with items, add PO line status column.
-- -- | 1.37 12 Aug 2022 Douglas Volz Add parameter to Show WIP OSP columns and remove extra
-- -- | join to the item master table.
-- -- | 1.38 16 Aug 2022 Douglas Volz Fixes for quantities for Correction transactions and
-- -- | for when the PO unit price is zero.
-- -- | 1.39 02 Jun 2025 Douglas Volz Removed tabs.
-- -- | 1.40 05 Jun 2025 Douglas Volz Added section 1.6 for PO unit price differences between
-- -- | Piyush Khandelwal the PO Receipt and the PO Deliver transactions. Put
-- -- | this into an "Adjustment Amount" column, as this is
-- -- | included in the Oracle Receiving Value Report but is
-- -- | not recorded on any Receiving Accounting entry.
-- -- | Also added in inventory org access, XXEN G/L and OU security profiles.
-- -- | 1.44 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-receiving-value-period-end/
-- Library Link: https://www.enginatics.com/reports/cac-receiving-value-period-end/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.operating_unit,
x.org_code,
x.period_name,
&column_segments
aps.vendor_name supplier,
(select he.full_name from hr_employees he where pha.agent_id=he.employee_id) buyer,
x.item_number,
nvl(x.item_description,pla.item_description) item_description,
xxen_util.meaning(x.item_type,'ITEM_TYPE',3) item_type,
misv.inventory_item_status_code_tl item_status,
xxen_util.meaning(x.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
xxen_util.meaning(x.destination_type_code,'DESTINATION TYPE',201) destination_type,
pha.segment1 po_number,
pla.line_num po_line,
xxen_util.meaning(coalesce(plla.closed_code,pla.closed_code,pha.closed_code),'DOCUMENT STATE',201) po_line_status,
pra.release_num po_release,
ppa.segment1 project_number,
ppa.name project_name,
(select /*+ no_unnest*/ max(prha.segment1) from po_requisition_lines_all prla, po_requisition_headers_all prha where x.po_line_location_id=prla.line_location_id and prla.requisition_header_id=prha.requisition_header_id) requisition_number,
(select /*+ no_unnest*/ max(he.full_name) from po_requisition_lines_all prla, po_requisition_headers_all prha, hr_employees he where x.po_line_location_id=prla.line_location_id and prla.requisition_header_id=prha.requisition_header_id and prha.preparer_id=he.employee_id) requestor,
(select /*+ no_unnest*/ max(he.email_address) from po_requisition_lines_all prla, po_requisition_headers_all prha, hr_employees he where x.po_line_location_id=prla.line_location_id and prla.requisition_header_id=prha.requisition_header_id and prha.preparer_id=he.employee_id) requestor_email,
x.receipt_num receipt_number,
x.transaction_date earliest_receipt_date,
case
when sysdate-x.transaction_date<31 then '30 days'
when sysdate-x.transaction_date<61 then '60 days'
when sysdate-x.transaction_date<91 then '90 days'
when sysdate-x.transaction_date<121 then '120 days'
when sysdate-x.transaction_date<151 then '150 days'
when sysdate-x.transaction_date<181 then '180 days'
else 'Over 180 days'
end aging_date,
&p_show_wip_osp
x.primary_uom_code uom_code,
x.quantity onhand_quantity,
x.currency_code,
x.amount onhand_value,
x.adjustment_amount,
x.amount+x.adjustment_amount total_onhand_value
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
oap.period_name,
gl.currency_code,
n.organization_id,
n.inventory_item_id,
msiv.concatenated_segments item_number,
msiv.description item_description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
msiv.primary_uom_code,
decode(:p_product_line_accounting,'Y',nvl((select gcc2.code_combination_id from gl_code_combinations gcc_item, gl_code_combinations gcc, gl_code_combinations gcc2, fnd_lookups fl where fl.lookup_type='INV_ITEM_ATTRIBUTES' and fl.meaning=:p_item_master_account_type and decode(fl.lookup_code,'SALES_ACCOUNT',msiv.sales_account,'COST_OF_SALES_ACCOUNT',msiv.cost_of_sales_account,'EXPENSE_ACCOUNT',msiv.expense_account)=gcc_item.code_combination_id and rp.receiving_account_id=gcc.code_combination_id and &gcc_product_line_where_clause gcc.chart_of_accounts_id=gcc2.chart_of_accounts_id),rp.receiving_account_id),rp.receiving_account_id) receiving_account_id,
n.destination_type_code,
n.po_header_id,
n.po_line_id,
n.po_line_location_id,
n.po_release_id,
n.project_id,
n.receipt_num,
(select /*+ no_unnest*/ min(rta.transaction_date) from rcv_shipment_headers rsha, rcv_transactions rta where n.shipment_header_id=rsha.shipment_header_id and n.receipt_num=rsha.receipt_num and rsha.shipment_header_id=rta.shipment_header_id and n.organization_id=rta.organization_id) transaction_date,
n.wip_entity_id,
n.bom_resource_id,
sum(n.quantity) quantity,
sum(n.amount) amount,
sum(n.adjustment_amount) adjustment_amount
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
org_acct_periods oap,
rcv_parameters rp,
(
select
rs.rcv_transaction_id transaction_id,
rs.to_organization_id organization_id,
rs.item_id inventory_item_id,
rs.destination_type_code,
rs.po_header_id,
rs.po_line_id,
rs.po_line_location_id,
rs.po_release_id,
rs.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
round(rs.to_org_primary_quantity,3) quantity,
rs.amount,
0 adjustment_amount
from
(
select
ms.to_organization_id,
ms.item_id,
ms.destination_type_code,
ms.po_header_id,
ms.po_line_id,
ms.po_line_location_id,
ms.po_distribution_id,
ms.po_release_id,
ms.shipment_header_id,
ms.shipment_line_id,
ms.rcv_transaction_id,
ms.to_org_primary_quantity,
round(ms.to_org_primary_quantity*round(sum(case when nvl(rt_correct.po_unit_price,nvl(rt_deliver.po_unit_price,0))<>nvl(rae.unit_price,0) then nvl(plla.price_override,nvl(rae.unit_price,0)) else nvl(rae.unit_price,0) end*nvl(rae.currency_conversion_rate,1)*rae.source_doc_quantity)/sum(rae.primary_quantity),8),2) amount
from
mtl_supply ms,
po_line_locations_all plla,
(
select
x.parent_transaction_id,
x.organization_id,
x.child_transaction_id
from
(
select
rt.transaction_id parent_transaction_id,
rt.organization_id,
connect_by_root rt.transaction_id child_transaction_id,
connect_by_isleaf isleaf
from
rcv_transactions rt
connect by
prior rt.parent_transaction_id=rt.transaction_id
start with
rt.transaction_id in (select ms.rcv_transaction_id from mtl_supply ms where ms.supply_type_code='RECEIVING' and 5=5) and
nvl(rt.consigned_flag,'N')='N' and
2=2
) x
where
x.isleaf=1
) rt,
rcv_accounting_events rae,
rcv_transactions rt_deliver,
rcv_transactions rt_correct
where
ms.rcv_transaction_id=rt.child_transaction_id and
ms.to_organization_id=rt.organization_id and
rt.parent_transaction_id=rae.rcv_transaction_id and
rt.organization_id=rae.organization_id and
ms.po_line_location_id=plla.line_location_id(+) and
ms.rcv_transaction_id=rt_deliver.parent_transaction_id(+) and
rt_deliver.transaction_type(+)='DELIVER' and
rt_deliver.transaction_id=rt_correct.parent_transaction_id(+) and
rt_correct.transaction_type(+)='CORRECT'
group by
ms.to_organization_id,
ms.item_id,
ms.destination_type_code,
ms.po_header_id,
ms.po_line_id,
ms.po_line_location_id,
ms.po_distribution_id,
ms.po_release_id,
ms.shipment_header_id,
ms.shipment_line_id,
ms.rcv_transaction_id,
ms.to_org_primary_quantity
) rs,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
po_distributions_all pda
where
rs.shipment_header_id=rsh.shipment_header_id and
rs.shipment_line_id=rsl.shipment_line_id and
rsl.source_document_code<>'REQ' and
rs.po_distribution_id=pda.po_distribution_id(+)
union all
select distinct
rt.transaction_id,
rae.organization_id,
rae.inventory_item_id,
pda.destination_type_code,
rae.po_header_id,
rae.po_line_id,
rae.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
round(case when rt.transaction_type in ('RECEIVE','MATCH') or rt.transaction_type='CORRECT' and rt_parent.transaction_type='RECEIVE' then -rt.primary_quantity when rt.transaction_type='RETURN TO VENDOR' or rt.transaction_type='CORRECT' and rt_parent.transaction_type='RETURN TO VENDOR' then rt.primary_quantity else 0 end,3) quantity,
round(round(decode(sign(nvl(rrsl.accounted_dr,0)-nvl(rrsl.accounted_cr,0)),1,-abs(rae.primary_quantity),-1,abs(rae.primary_quantity),rae.primary_quantity),3)*nvl(rt.po_unit_price,0)*nvl(rt.currency_conversion_rate,1)*rt.source_doc_quantity/rt.primary_quantity,2) amount,
0 adjustment_amount
from
org_acct_periods oap,
rcv_transactions rt,
rcv_transactions rt_parent,
rcv_accounting_events rae,
rcv_receiving_sub_ledger rrsl,
po_distributions_all pda,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl
where
2=2 and
3=3 and
oap.organization_id=rt.organization_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.transaction_type<>'DELIVER' and
rt.parent_transaction_id=rt_parent.transaction_id(+) and
rt.organization_id=rt_parent.organization_id(+) and
rt.transaction_id=rae.rcv_transaction_id and
rae.accounting_event_id=rrsl.accounting_event_id and
rt.transaction_id=rrsl.rcv_transaction_id and
rrsl.accounting_line_type in ('Clearing','Receiving Inspection') and
rrsl.transaction_date>=oap.schedule_close_date+1 and
rrsl.reference3=pda.po_distribution_id and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id
union all
select
rt.transaction_id,
mmt.organization_id,
rsl.item_id inventory_item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
round(sum(mmt.primary_quantity),3) quantity,
round(sum(mmt.primary_quantity*rt.source_doc_quantity/rt.primary_quantity*nvl(rt.po_unit_price,0)*nvl(rt.currency_conversion_rate,1)),2) amount,
0 adjustment_amount
from
org_acct_periods oap,
mtl_material_transactions mmt,
rcv_parameters rp,
rcv_transactions rt,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
po_distributions_all pda
where
2=2 and
3=3 and
oap.organization_id=mmt.organization_id and
mmt.transaction_date>=oap.schedule_close_date+1 and
mmt.transaction_source_type_id=1 and
mmt.organization_id=rp.organization_id and
mmt.distribution_account_id=rp.receiving_account_id and
mmt.rcv_transaction_id=rt.transaction_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id and
rt.po_line_location_id=pda.line_location_id and
nvl(rsl.po_distribution_id,pda.po_distribution_id)=pda.po_distribution_id
group by
rt.transaction_id,
mmt.organization_id,
rsl.item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id
union all
select
rt.transaction_id,
wta.organization_id,
rsl.item_id inventory_item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
round(case when rt.transaction_type='DELIVER' or rt.transaction_type='CORRECT' and rt_parent.transaction_type='DELIVER' then rt.primary_quantity when rt.transaction_type='RETURN TO RECEIVING' or rt.transaction_type='CORRECT' and rt_parent.transaction_type in ('RETURN TO RECEIVING','MATCH') then -rt.primary_quantity else 0 end,3) quantity,
round(-sum(wta.base_transaction_value),2) amount,
0 adjustment_amount
from
org_acct_periods oap,
wip_transaction_accounts wta,
rcv_parameters rp,
wip_transactions wt,
rcv_transactions rt,
rcv_transactions rt_parent,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
po_distributions_all pda
where
2=2 and
3=3 and
oap.organization_id=wta.organization_id and
wta.transaction_date>=oap.schedule_close_date+1 and
wta.accounting_line_type in (4,5) and
wta.organization_id=rp.organization_id and
wta.reference_account=rp.receiving_account_id and
wta.transaction_id=wt.transaction_id and
wt.transaction_date>=oap.schedule_close_date+1 and
wt.rcv_transaction_id=rt.transaction_id and
wt.organization_id=rt.organization_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.parent_transaction_id=rt_parent.transaction_id(+) and
rt.organization_id=rt_parent.organization_id(+) and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id and
rt.po_line_location_id=pda.line_location_id and
nvl(rsl.po_distribution_id,pda.po_distribution_id)=pda.po_distribution_id and
pda.destination_type_code<>'EXPENSE' and
wta.wip_entity_id=pda.wip_entity_id
group by
rt.transaction_id,
rt.transaction_type,
rt_parent.transaction_type,
rt.primary_quantity,
wta.organization_id,
rsl.item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id
union all
select
rt.transaction_id,
wcti.organization_id,
rsl.item_id inventory_item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
round(sum(wcti.primary_quantity),3) quantity,
round(sum(wcti.primary_quantity*rt.source_doc_quantity/rt.primary_quantity*nvl(rt.po_unit_price,0)*nvl(rt.currency_conversion_rate,1)),2) amount,
0 adjustment_amount
from
org_acct_periods oap,
wip_cost_txn_interface wcti,
rcv_parameters rp,
rcv_transactions rt,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
po_distributions_all pda
where
2=2 and
3=3 and
oap.organization_id=wcti.organization_id and
wcti.transaction_date>=oap.schedule_close_date+1 and
wcti.transaction_type=3 and
wcti.organization_id=rp.organization_id and
wcti.receiving_account_id=rp.receiving_account_id and
wcti.rcv_transaction_id=rt.transaction_id and
wcti.organization_id=rt.organization_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id and
rt.po_line_location_id=pda.line_location_id and
nvl(rsl.po_distribution_id,pda.po_distribution_id)=pda.po_distribution_id and
pda.destination_type_code<>'EXPENSE' and
wcti.wip_entity_id=pda.wip_entity_id
group by
rt.transaction_id,
wcti.organization_id,
rsl.item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id
union all
select
rt.transaction_id,
rt.organization_id,
rsl.item_id inventory_item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
0 quantity,
round(-sum(nvl(rrsl.accounted_dr,0)-nvl(rrsl.accounted_cr,0)),2) amount,
0 adjustment_amount
from
org_acct_periods oap,
rcv_transactions rt,
rcv_parameters rp,
rcv_receiving_sub_ledger rrsl,
po_distributions_all pda,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl
where
2=2 and
3=3 and
oap.organization_id=rt.organization_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.transaction_type='DELIVER' and
rt.organization_id=rp.organization_id and
rt.transaction_id=rrsl.rcv_transaction_id and
rrsl.accounting_line_type in ('Clearing','Receiving Inspection') and
rrsl.transaction_date>=oap.schedule_close_date+1 and
rrsl.code_combination_id=rp.receiving_account_id and
rrsl.reference3=pda.po_distribution_id and
rt.po_line_location_id=pda.line_location_id and
pda.destination_type_code<>'EXPENSE' and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id
group by
rt.transaction_id,
rt.organization_id,
rsl.item_id,
pda.destination_type_code,
rt.po_header_id,
rt.po_line_id,
rt.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id
union all
select distinct
rt.transaction_id,
rae.organization_id,
rae.inventory_item_id,
pda.destination_type_code,
rae.po_header_id,
rae.po_line_id,
rae.po_line_location_id,
rsl.po_release_id,
rsh.shipment_header_id,
pda.project_id,
rsh.receipt_num,
pda.wip_entity_id,
pda.bom_resource_id,
0 quantity,
0 amount,
round(case when rt.transaction_type in ('RECEIVE','MATCH') or rt.transaction_type='CORRECT' and rt_parent.transaction_type='RECEIVE' then -rt.primary_quantity when rt.transaction_type='RETURN TO VENDOR' or rt.transaction_type='CORRECT' and rt_parent.transaction_type='RETURN TO VENDOR' then rt.primary_quantity else 0 end*
(nvl(rt_deliver.po_unit_price,0)*nvl(rt_deliver.currency_conversion_rate,1)*rt_deliver.source_doc_quantity/rt_deliver.primary_quantity-nvl(rt.po_unit_price,0)*nvl(rt.currency_conversion_rate,1)*rt.source_doc_quantity/rt.primary_quantity),2) adjustment_amount
from
org_acct_periods oap,
rcv_transactions rt,
rcv_transactions rt_parent,
rcv_transactions rt_deliver,
rcv_parameters rp,
rcv_accounting_events rae,
rcv_receiving_sub_ledger rrsl,
po_distributions_all pda,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl
where
2=2 and
3=3 and
oap.organization_id=rt.organization_id and
rt.transaction_date>=oap.schedule_close_date+1 and
rt.transaction_type<>'DELIVER' and
rt.parent_transaction_id=rt_parent.transaction_id(+) and
rt.organization_id=rt_parent.organization_id(+) and
rt.transaction_id=rt_deliver.parent_transaction_id and
rt_deliver.transaction_type='DELIVER' and
rt_deliver.po_unit_price<>rt.po_unit_price and
rt_deliver.transaction_date>=oap.schedule_close_date+1 and
rt.organization_id=rp.organization_id and
rp.retroprice_adj_account_id is null and
rt.transaction_id=rae.rcv_transaction_id and
rae.accounting_event_id=rrsl.accounting_event_id and
rt.transaction_id=rrsl.rcv_transaction_id and
rrsl.accounting_line_type in ('Clearing','Receiving Inspection') and
rrsl.transaction_date>=oap.schedule_close_date+1 and
rrsl.reference3=pda.po_distribution_id and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id
) n,
mtl_system_items_vl msiv
where
1=1 and
3=3 and
4=4 and
6=6 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=oap.organization_id and
mp.organization_id=rp.organization_id and
mp.organization_id=n.organization_id and
n.organization_id=msiv.organization_id(+) and
n.inventory_item_id=msiv.inventory_item_id(+)
group by
gl.short_name,
gl.name,
haouv_ou.name,
mp.organization_code,
oap.period_name,
gl.currency_code,
n.organization_id,
n.inventory_item_id,
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
msiv.primary_uom_code,
msiv.sales_account,
msiv.cost_of_sales_account,
msiv.expense_account,
rp.receiving_account_id,
n.destination_type_code,
n.po_header_id,
n.po_line_id,
n.po_line_location_id,
n.po_release_id,
n.project_id,
n.receipt_num,
n.shipment_header_id,
n.wip_entity_id,
n.bom_resource_id
having
abs(sum(nvl(n.quantity,0)+nvl(n.amount,0)))>.01
) x,
mtl_item_status_vl misv,
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
po_releases_all pra,
ap_suppliers aps,
pa_projects_all ppa,
gl_code_combinations gcc
where
x.inventory_item_status_code=misv.inventory_item_status_code(+) and
x.po_header_id=pha.po_header_id and
x.po_line_id=pla.po_line_id and
x.po_line_location_id=plla.line_location_id and
x.po_release_id=pra.po_release_id(+) and
pha.vendor_id=aps.vendor_id and
x.project_id=ppa.project_id(+) and
x.receiving_account_id=gcc.code_combination_id(+)
order by
x.ledger,
x.operating_unit,
x.org_code,
supplier,
x.item_number,
po_number,
po_line,
po_release,
earliest_receipt_date
