/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Receiving Expense Value (Period-End)
-- Description: Report to show receiving value for expense locations and expense destination types, for expenses accrued at time of receipt. You may run this report for open or closed accounting periods. If run for a prior period the report automatically rolls back the quantities and values to the prior period's period end date. if run for a current period, the report shows the real-time quantities and values. This report displays both the receiving valuation account as well as the offset (expense or CapEx) account.
-- Parameters:
-- Period Name: the accounting period you wish to report (mandatory).
-- Category Sets 1 - 3: any item category you wish (optional)
-- Supplier Name: enter a supplier name to report (optional)
-- Item Number: enter an item number to report (optional)
-- Organization Code: specific inventory organization to report (optional)
-- Operating Unit: specific operating unit (optional)
-- Ledger: specific ledger (optional)
-- / +=============================================================================+
-- -- | Copyright 2010-25 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 5 Jul 2010 Douglas Volz Created initial Report for Celgene
-- -- | based on XXXIPVRCVVALUEREPT.sql
-- -- | 1.1 5 Jul 2010 Douglas Volz Added requisition, requestor and requestor
-- -- | email address
-- -- | 1.2 15 Sep 2010 Douglas Volz Added unit of measure, supplier, buyer columns.
-- -- | Fix for parameter changes for BO Freehand SQL requirements,
-- -- | changing the code to accept null or % or value GL Ledger names.
-- -- | 1.3 27 Sep 2010 Douglas Volz Changed the report sort to include the offset accounts
-- -- | 1.4 04 Jan 2012 Douglas Volz Fixed quantities to sum up rcvreceivingsubledger,
-- -- | as the view rcvreceivingvalueview and
-- -- | rcvtransactions does not split out quantities by
-- -- | po distributions. For expenses you can have multiple expense
-- -- | accounts or distributions for each scheduled receipt
-- -- | in polinelocations
-- -- | 1.5 08 Feb 2012 Douglas Volz Rewrite code to fix quantity and amounts, mtlsupply does
-- -- | not handle split rcvtransations, split by multiple
-- -- | podistributionids. It only stores one of the PODs for
-- -- | expenses.
-- -- | 1.6 06 Jan 2020 Douglas Volz Added item categories, Org Code and Operating Unit parameters.
-- -- | 1.7 29 May 2025 Douglas Volz Removed tabs, added Blitz G/L and OU security..
-- -- | 1.8 15 Oct 2025 Douglas Volz Changed inventory periods to PO financial periods.
-- -- | Added non-recoverable tax amounts into PO prices.
-- -- | And changed Period Name parameter to use INV Periods
-- -- | which also include the master inventory org.
-- -- | 1.9 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-receiving-expense-value-period-end/
-- Library Link: https://www.enginatics.com/reports/cac-receiving-expense-value-period-end/
-- Run Report: https://demo.enginatics.com/

with op as (
select /*+ materialize*/
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code,
haou.name organization_name,
mp.organization_id,
gps.period_name,
gps.end_date,
gl.currency_code
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units_vl haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
gl_period_statuses gps
where
1=1 and
2=2 and
3=3 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
gl.ledger_id=gps.ledger_id and
gps.application_id=201
)
select
x.ledger,
x.operating_unit,
x.organization_code org_code,
x.organization_name,
x.period_name,
&segment_columns
aps.vendor_name supplier,
(select he.full_name from hr_employees he where x.agent_id=he.employee_id) buyer,
msiv.concatenated_segments item_number,
nvl(msiv.description,x.item_description) item_description,
&category_columns
xxen_util.meaning(x.destination_type_code,'DESTINATION TYPE',201) destination_type,
x.po_number,
x.po_line_num po_line,
x.release_num po_release,
ppa.name project_number,
(select /*+ no_unnest*/ max(prha.segment1) from po_requisition_lines_all prla, po_requisition_headers_all prha where x.po_line_location_id=prla.line_location_id and prla.requisition_header_id=prha.requisition_header_id) requisition_number,
(select /*+ no_unnest*/ max(he.full_name) from po_requisition_lines_all prla, po_requisition_headers_all prha, hr_employees he where x.po_line_location_id=prla.line_location_id and prla.requisition_header_id=prha.requisition_header_id and prha.preparer_id=he.employee_id) requestor,
(select /*+ no_unnest*/ max(he.email_address) from po_requisition_lines_all prla, po_requisition_headers_all prha, hr_employees he where x.po_line_location_id=prla.line_location_id and prla.requisition_header_id=prha.requisition_header_id and prha.preparer_id=he.employee_id) requestor_email,
x.receipt_num receipt_number,
x.transaction_date receipt_date,
case
when sysdate-x.transaction_date<31 then '30 days'
when sysdate-x.transaction_date<61 then '60 days'
when sysdate-x.transaction_date<91 then '90 days'
when sysdate-x.transaction_date<121 then '120 days'
when sysdate-x.transaction_date<151 then '150 days'
when sysdate-x.transaction_date<181 then '180 days'
else 'Over 180 days'
end aging_date,
x.unit_of_measure transaction_uom,
x.quantity onhand_quantity,
x.currency_code,
x.amount onhand_value
from
(
select
op.ledger,
op.operating_unit,
op.organization_code,
op.organization_name,
op.period_name,
op.currency_code,
n.organization_id,
n.inventory_item_id,
n.item_description,
n.destination_type_code,
n.po_number,
n.po_line_num,
n.vendor_id,
n.agent_id,
n.po_line_location_id,
n.release_num,
n.project_id,
n.receipt_num,
n.charge_account_id,
n.unit_of_measure,
rp.receiving_account_id,
min(trunc(n.transaction_date)) transaction_date,
sum(nvl(n.quantity,0)) quantity,
sum(nvl(n.amount,0)) amount
from
op,
rcv_parameters rp,
(
select
rs.rcv_transaction_id,
rs.to_organization_id organization_id,
rs.item_id inventory_item_id,
pla.item_description,
rs.destination_type_code,
pha.segment1 po_number,
pla.line_num po_line_num,
pha.vendor_id,
pha.agent_id,
rs.po_line_location_id,
pra.release_num,
pda.project_id,
rsh.receipt_num,
rt.transaction_date,
pda.code_combination_id charge_account_id,
rs.unit_of_measure,
sum(rs.to_org_primary_quantity) quantity,
round(decode(rsl.source_document_code,'PO',(plla.price_override*nvl(pha.rate,1)+decode(nvl(pda.nonrecoverable_tax,0),0,0,pda.nonrecoverable_tax/pda.quantity_ordered*nvl(pha.rate,1)))*rt.source_doc_quantity/rt.primary_quantity)*sum(rs.to_org_primary_quantity),2) amount
from
op,
mtl_supply rs,
rcv_transactions rt,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
po_distributions_all pda,
po_line_locations_all plla,
po_lines_all pla,
po_headers_all pha,
po_releases_all pra
where
op.organization_id=rs.to_organization_id and
rs.supply_type_code='RECEIVING' and
rs.destination_type_code='EXPENSE' and
rs.rcv_transaction_id=rt.transaction_id and
rs.shipment_header_id=rsh.shipment_header_id and
rs.shipment_line_id=rsl.shipment_line_id and
rs.po_distribution_id=pda.po_distribution_id and
pda.destination_type_code='EXPENSE' and
rs.po_line_location_id=plla.line_location_id(+) and
rs.po_line_id=pla.po_line_id(+) and
rs.po_header_id=pha.po_header_id(+) and
rs.po_release_id=pra.po_release_id(+)
group by
rs.rcv_transaction_id,
rs.to_organization_id,
rs.item_id,
pla.item_description,
rs.destination_type_code,
pha.segment1,
pla.line_num,
pha.vendor_id,
pha.agent_id,
rs.po_line_location_id,
pra.release_num,
pda.project_id,
pda.po_distribution_id,
rsh.receipt_num,
rsh.shipment_num,
rt.transaction_date,
rt.source_doc_quantity,
rt.primary_quantity,
pda.code_combination_id,
pda.nonrecoverable_tax,
pda.quantity_ordered,
rs.unit_of_measure,
rsl.source_document_code,
plla.price_override,
pha.rate
union all
select
rt.transaction_id,
rt.organization_id,
rsl.item_id inventory_item_id,
pla.item_description,
pda.destination_type_code,
pha.segment1 po_number,
pla.line_num po_line_num,
pha.vendor_id,
pha.agent_id,
rt.po_line_location_id,
pra.release_num,
pda.project_id,
rsh.receipt_num,
rt.transaction_date,
pda.code_combination_id charge_account_id,
rt.unit_of_measure,
abs(nvl(rt.primary_quantity,0))*decode(sign(rrsl.amount),-1,1,-1) quantity,
-rrsl.amount amount
from
op,
rcv_parameters rp,
(
select
rrsl.rcv_transaction_id,
rrsl.code_combination_id,
max(to_number(rrsl.reference3)) po_distribution_id,
sum(round(nvl(rrsl.accounted_dr,0)-nvl(rrsl.accounted_cr,0),2)) amount
from
op,
rcv_transactions rt,
rcv_receiving_sub_ledger rrsl
where
op.organization_id=rt.organization_id and
rt.transaction_date>=op.end_date+1 and
rt.transaction_id=rrsl.rcv_transaction_id and
rrsl.accounting_line_type='Receiving Inspection'
group by
rrsl.rcv_transaction_id,
rrsl.code_combination_id
) rrsl,
rcv_transactions rt,
po_distributions_all pda,
po_line_locations_all plla,
po_lines_all pla,
po_headers_all pha,
po_system_parameters_all pspa,
po_releases_all pra,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl
where
op.organization_id=rp.organization_id and
rp.receiving_account_id=rrsl.code_combination_id and
rrsl.rcv_transaction_id=rt.transaction_id and
op.organization_id=rt.organization_id and
rrsl.po_distribution_id=pda.po_distribution_id and
pda.destination_type_code='EXPENSE' and
rt.po_line_location_id=pda.line_location_id and
rt.po_line_location_id=plla.line_location_id and
rt.po_line_id=pla.po_line_id and
rt.po_header_id=pha.po_header_id and
pha.org_id=pspa.org_id and
pspa.expense_accrual_code='RECEIPT' and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id and
rsl.po_release_id=pra.po_release_id(+)
union all
select distinct
rt.transaction_id,
rae.organization_id,
rae.inventory_item_id,
pla.item_description,
pda.destination_type_code,
pha.segment1 po_number,
pla.line_num po_line_num,
pha.vendor_id,
pha.agent_id,
rae.po_line_location_id,
pra.release_num,
pda.project_id,
rsh.receipt_num,
rt.transaction_date,
pda.code_combination_id charge_account_id,
rt.unit_of_measure,
to_number(null) quantity,
round(case when rt.transaction_type in ('RECEIVE','MATCH') or rt.transaction_type='CORRECT' and rt_parent.transaction_type='RECEIVE' then -rt.primary_quantity when rt.transaction_type='RETURN TO VENDOR' or rt.transaction_type='CORRECT' and rt_parent.transaction_type='RETURN TO VENDOR' then rt.primary_quantity else 0 end*
(nvl(rt_deliver.po_unit_price,0)*nvl(rt_deliver.currency_conversion_rate,1)*rt_deliver.source_doc_quantity/rt_deliver.primary_quantity-nvl(rt.po_unit_price,0)*nvl(rt.currency_conversion_rate,1)*rt.source_doc_quantity/rt.primary_quantity),2) amount
from
op,
rcv_parameters rp,
rcv_transactions rt,
rcv_transactions rt_parent,
rcv_transactions rt_deliver,
rcv_accounting_events rae,
rcv_receiving_sub_ledger rrsl,
po_distributions_all pda,
po_lines_all pla,
po_headers_all pha,
po_releases_all pra,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl
where
op.organization_id=rp.organization_id and
rp.retroprice_adj_account_id is null and
op.organization_id=rt.organization_id and
rt.transaction_date>=op.end_date+1 and
rt.transaction_type<>'DELIVER' and
rt.parent_transaction_id=rt_parent.transaction_id(+) and
rt.organization_id=rt_parent.organization_id(+) and
rt.transaction_id=rt_deliver.parent_transaction_id and
rt_deliver.transaction_type='DELIVER' and
rt_deliver.po_unit_price<>rt.po_unit_price and
rt_deliver.transaction_date>=op.end_date+1 and
rt.transaction_id=rae.rcv_transaction_id and
rae.accounting_event_id=rrsl.accounting_event_id and
rt.transaction_id=rrsl.rcv_transaction_id and
rrsl.accounting_line_type in ('Clearing','Receiving Inspection') and
rrsl.transaction_date>=op.end_date+1 and
rrsl.reference3=pda.po_distribution_id and
pda.destination_type_code='EXPENSE' and
rae.po_line_id=pla.po_line_id and
rae.po_header_id=pha.po_header_id and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id and
rsl.po_release_id=pra.po_release_id(+)
) n
where
op.organization_id=rp.organization_id and
op.organization_id=n.organization_id
group by
op.ledger,
op.operating_unit,
op.organization_code,
op.organization_name,
op.period_name,
op.currency_code,
n.organization_id,
n.inventory_item_id,
n.item_description,
n.destination_type_code,
n.po_number,
n.po_line_num,
n.vendor_id,
n.agent_id,
n.po_line_location_id,
n.release_num,
n.project_id,
n.receipt_num,
n.charge_account_id,
n.unit_of_measure,
rp.receiving_account_id
having
sum(nvl(n.amount,0))<>0
) x,
ap_suppliers aps,
mtl_system_items_vl msiv,
pa_projects_all ppa,
gl_code_combinations gcc1,
gl_code_combinations gcc2
where
7=7 and
x.vendor_id=aps.vendor_id and
x.organization_id=msiv.organization_id(+) and
x.inventory_item_id=msiv.inventory_item_id(+) and
x.project_id=ppa.project_id(+) and
x.receiving_account_id=gcc1.code_combination_id(+) and
x.charge_account_id=gcc2.code_combination_id(+)
order by
x.ledger,
x.operating_unit,
x.organization_code,
x.organization_name,
x.period_name,
supplier,
buyer,
item_number,
x.po_number,
x.po_line_num,
x.release_num,
project_number,
x.receipt_num
