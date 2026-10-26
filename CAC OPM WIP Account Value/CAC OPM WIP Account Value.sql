/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC OPM WIP Account Value
-- Description: Report to show WIP values for process manufacturing (OPM), in summary by inventory organization and batch, with batch status, name and other details. The valuation accounts come from the cumulative WIP Valuation accounting entries, as processed by Create Accounting.
-- Parameters:
-- ===========
-- Period Name: the inventory accounting period you wish to report (mandatory).
-- Include Lab Batches: enter Yes to include laboratory batches. Enter No to exclude them. Defaults to No (mandatory).
-- Show Batch Details: enter Yes to display the formula, routing and recipe numbers and versions. Defaults to No (mandatory).
-- Show Transaction Details: enter Yes to show the Event Class, Transaction Type, Transaction ID and Transaction Date. Defaults to No (mandatory).
-- Batch Number: enter a specific batch number to report (optional).
-- Category Set 1: the first item category set to report, typically the Cost or Product Line Category Set (optional).
-- Category Set 2: The second item category set to report, typically the Inventory Category Set (optional).
-- Organization Code: any inventory organization, defaults to your session's inventory organization (optional).
-- Operating Unit: specific operating unit (optional).
-- Ledger: specific ledger (optional).
-- / +=============================================================================+
-- -- | Copyright 2014 - 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 22-Oct-2014 Douglas Volz Initial version.
-- -- | 1.1 06-Jul-2024 Douglas Volz Cumulative changes plus format for Blitz Report.
-- -- | 1.2 31-Jul-2024 Douglas Volz Fix to get current and prior month's transactions
-- -- | 1.3 06-Aug-2024 Douglas Volz Add Batch and Txn Detail parameters.
-- -- | 1.4 08-Aug-2024 Douglas Volz Add Product and Byproduct completion quantity columns.
-- -- | and inventory access control security.
-- -- | 1.5 17-Aug-2024 Douglas Volz Fix for reporting batches closed after the reported period.
-- -- | Add Batch Number parameter. Display the Ledger short name.
-- -- | 1.6 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-opm-wip-account-value/
-- Library Link: https://www.enginatics.com/reports/cac-opm-wip-account-value/
-- Run Report: https://demo.enginatics.com/

with b as (
select /*+ materialize*/
mp.organization_id,
mp.organization_code,
to_number(hoi.org_information2) legal_entity_id,
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
gbh.batch_id,
gbh.batch_no,
gbh.batch_status,
gbh.laboratory_ind,
gbh.formula_id,
gbh.routing_id,
gbh.recipe_validity_rule_id,
gbh.creation_date,
gbh.plan_start_date,
gbh.actual_start_date,
gbh.due_date,
gbh.actual_cmplt_date,
gbh.batch_close_date
from
mtl_parameters mp,
hr_organization_information hoi,
org_acct_periods oap,
gme_batch_header gbh
where
2=2 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.process_enabled_flag='Y' and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
mp.organization_id=oap.organization_id and
mp.organization_id=gbh.organization_id and
(gbh.batch_close_date is null and nvl(gbh.actual_start_date,sysdate)<oap.schedule_close_date+1 or gbh.batch_close_date>=oap.period_start_date)
)
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
y.organization_code org_code,
y.period_name,
&segment_columns
xxen_util.meaning(y.laboratory_ind,'GME_LABORATORY_IND',553) batch_type,
y.batch_no batch_number,
xxen_util.meaning(y.batch_status,'GME_BATCH_STATUS',553) batch_status,
&p_show_batch_dtls
y.creation_date,
y.plan_start_date planned_start_date,
y.actual_start_date,
y.due_date,
y.actual_cmplt_date actual_completion_date,
y.batch_close_date,
case
when y.schedule_close_date-y.creation_date<31 then '30 days'
when y.schedule_close_date-y.creation_date<61 then '60 days'
when y.schedule_close_date-y.creation_date<91 then '90 days'
when y.schedule_close_date-y.creation_date<121 then '120 days'
when y.schedule_close_date-y.creation_date<151 then '150 days'
when y.schedule_close_date-y.creation_date<181 then '180 days'
else 'Over 180 days'
end aged_creation_date,
case
when y.release_days<31 then '30 days'
when y.release_days<61 then '60 days'
when y.release_days<91 then '90 days'
when y.release_days<121 then '120 days'
when y.release_days<151 then '150 days'
when y.release_days<181 then '180 days'
else 'Over 180 days'
end aged_compln_vs_release_date,
case
when y.creation_days<31 then '30 days'
when y.creation_days<61 then '60 days'
when y.creation_days<91 then '90 days'
when y.creation_days<121 then '120 days'
when y.creation_days<151 then '150 days'
when y.creation_days<181 then '180 days'
else 'Over 180 days'
end aged_compln_vs_creation_date,
msiv.primary_uom_code uom_code,
(select sum(decode(mmt.transaction_type_id,44,mmt.primary_quantity,17,mmt.primary_quantity,0)) from mtl_material_transactions mmt where mmt.transaction_source_type_id=5 and y.organization_id=mmt.organization_id and y.batch_id=mmt.transaction_source_id and mmt.transaction_date<y.schedule_close_date+1) product_quantity_completed,
(select sum(decode(mmt.transaction_type_id,1002,mmt.primary_quantity,1003,mmt.primary_quantity,0)) from mtl_material_transactions mmt where mmt.transaction_source_type_id=5 and y.organization_id=mmt.organization_id and y.batch_id=mmt.transaction_source_id and mmt.transaction_date<y.schedule_close_date+1) byproduct_quantity_completed,
msiv.concatenated_segments "Product Number",
msiv.description "Product Description",
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
&category_columns
xxen_util.meaning(y.accounting_class_code,'XLA_ACCOUNTING_CLASS',602) accounting_class,
&p_show_txn_dtls
gl.currency_code,
y.wip_costs_in,
y.wip_costs_out,
y.wip_relief,
y.wip_value
from
(
select
b.organization_id,
b.organization_code,
b.period_name,
b.schedule_close_date,
b.batch_id,
b.batch_no,
b.batch_status,
b.laboratory_ind,
b.formula_id,
b.routing_id,
b.recipe_validity_rule_id,
b.creation_date,
b.plan_start_date,
b.actual_start_date,
b.due_date,
b.actual_cmplt_date,
b.batch_close_date,
nvl(b.actual_cmplt_date,b.schedule_close_date)-nvl(b.actual_start_date,nvl(b.actual_cmplt_date,sysdate)) release_days,
nvl(b.actual_cmplt_date,b.schedule_close_date)-b.creation_date creation_days,
a.inventory_item_id,
a.code_combination_id,
a.accounting_class_code,
&p_show_txn_dtls2
sum(a.wip_costs_in) wip_costs_in,
sum(a.wip_costs_out) wip_costs_out,
sum(a.wip_relief) wip_relief,
sum(a.wip_value) wip_value
from
b,
(
select
grt.doc_id batch_id,
gxeh.inventory_item_id,
xal.code_combination_id,
xal.accounting_class_code,
gxeh.event_class_code,
gxeh.transaction_type_id,
gxeh.transaction_id,
gxeh.transaction_date,
nvl(xal.accounted_dr,0)-nvl(xal.accounted_cr,0) wip_costs_in,
0 wip_costs_out,
0 wip_relief,
nvl(xal.accounted_dr,0)-nvl(xal.accounted_cr,0) wip_value
from
b,
gme_resource_txns grt,
gmf_xla_extract_headers gxeh,
gmf_fiscal_policies gfp,
xla_ae_headers xah,
xla_ae_lines xal
where
b.batch_id=grt.doc_id and
grt.trans_date>=b.actual_start_date and
grt.trans_date<b.schedule_close_date+1 and
grt.poc_trans_id=gxeh.transaction_id and
grt.doc_id=gxeh.source_document_id and
grt.line_id=gxeh.source_line_id and
grt.resources=gxeh.resources and
b.organization_id=gxeh.organization_id and
gxeh.txn_source='PM' and
gxeh.entity_code='PRODUCTION' and
gxeh.event_class_code='BATCH_RESOURCE' and
b.legal_entity_id=gfp.legal_entity_id and
gxeh.valuation_cost_type_id=gfp.cost_type_id and
gxeh.event_id=xah.event_id and
xah.application_id=555 and
gfp.ledger_id=xah.ledger_id and
xah.ae_header_id=xal.ae_header_id and
xah.application_id=xal.application_id and
xah.ledger_id=xal.ledger_id and
xal.accounting_class_code='WIP_VALUATION'
union all
select
b.batch_id,
we.primary_item_id inventory_item_id,
xal.code_combination_id,
xal.accounting_class_code,
gxeh.event_class_code,
gxeh.transaction_type_id,
gxeh.transaction_id,
gxeh.transaction_date,
0 wip_costs_in,
0 wip_costs_out,
-(nvl(xal.accounted_dr,0)-nvl(xal.accounted_cr,0)) wip_relief,
nvl(xal.accounted_dr,0)-nvl(xal.accounted_cr,0) wip_value
from
b,
wip_entities we,
gmf_xla_extract_headers gxeh,
gmf_fiscal_policies gfp,
xla_ae_headers xah,
xla_ae_lines xal
where
b.batch_status=4 and
b.batch_id=we.wip_entity_id and
b.organization_id=we.organization_id and
b.batch_id=gxeh.transaction_id and
b.batch_id=gxeh.source_document_id and
b.organization_id=gxeh.organization_id and
gxeh.txn_source='PM' and
gxeh.entity_code='PRODUCTION' and
gxeh.event_class_code='BATCH_CLOSE' and
gxeh.event_type_code='CLOS' and
gxeh.transaction_date>=b.period_start_date and
gxeh.transaction_date<b.schedule_close_date+1 and
b.legal_entity_id=gfp.legal_entity_id and
gxeh.valuation_cost_type_id=gfp.cost_type_id and
gxeh.event_id=xah.event_id and
xah.application_id=555 and
gfp.ledger_id=xah.ledger_id and
xah.ae_header_id=xal.ae_header_id and
xah.application_id=xal.application_id and
xah.ledger_id=xal.ledger_id and
xal.accounting_class_code='WIP_VALUATION'
union all
select
b.batch_id,
we.primary_item_id inventory_item_id,
xal.code_combination_id,
xal.accounting_class_code,
gxeh.event_class_code,
gxeh.transaction_type_id,
gxeh.transaction_id,
gxeh.transaction_date,
decode(mmt.transaction_action_id,31,0,32,0,nvl(xal.accounted_dr,0)-nvl(xal.accounted_cr,0)) wip_costs_in,
-decode(mmt.transaction_action_id,31,nvl(xal.accounted_dr,0)-nvl(xal.accounted_cr,0),32,nvl(xal.accounted_dr,0)-nvl(xal.accounted_cr,0),0) wip_costs_out,
0 wip_relief,
nvl(xal.accounted_dr,0)-nvl(xal.accounted_cr,0) wip_value
from
b,
wip_entities we,
mtl_material_transactions mmt,
gmf_xla_extract_headers gxeh,
gmf_fiscal_policies gfp,
xla_ae_headers xah,
xla_ae_lines xal
where
b.batch_id=we.wip_entity_id and
b.batch_id=mmt.transaction_source_id and
mmt.transaction_source_type_id=5 and
b.organization_id=mmt.organization_id and
mmt.transaction_date>=b.actual_start_date and
mmt.transaction_date<b.schedule_close_date+1 and
mmt.transaction_id=gxeh.transaction_id and
b.organization_id=gxeh.organization_id and
gxeh.txn_source='PM' and
gxeh.entity_code='PRODUCTION' and
gxeh.event_class_code='BATCH_MATERIAL' and
b.legal_entity_id=gfp.legal_entity_id and
gxeh.valuation_cost_type_id=gfp.cost_type_id and
gxeh.event_id=xah.event_id and
xah.application_id=555 and
gfp.ledger_id=xah.ledger_id and
xah.ae_header_id=xal.ae_header_id and
xah.application_id=xal.application_id and
xah.ledger_id=xal.ledger_id and
xal.accounting_class_code='WIP_VALUATION'
) a
where
b.batch_id=a.batch_id
group by
b.organization_id,
b.organization_code,
b.period_name,
b.schedule_close_date,
b.batch_id,
b.batch_no,
b.batch_status,
b.laboratory_ind,
b.formula_id,
b.routing_id,
b.recipe_validity_rule_id,
b.creation_date,
b.plan_start_date,
b.actual_start_date,
b.due_date,
b.actual_cmplt_date,
b.batch_close_date,
a.inventory_item_id,
a.code_combination_id,
&p_show_txn_dtls2_grp
a.accounting_class_code
) y,
mtl_system_items_vl msiv,
gl_code_combinations gcc,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl
where
1=1 and
y.organization_id=msiv.organization_id and
y.inventory_item_id=msiv.inventory_item_id and
y.code_combination_id=gcc.code_combination_id(+) and
y.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id
order by
ledger,
operating_unit,
org_code,
y.period_name,
batch_type,
batch_number,
"Product Number",
accounting_class
