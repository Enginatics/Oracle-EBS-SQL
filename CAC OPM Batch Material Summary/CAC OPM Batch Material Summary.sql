/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC OPM Batch Material Summary
-- Description: Report showing Batch materials in summary for each product, byproduct and ingredient. Displaying batches which were open during the monthly inventory accounting period or batches which were closed during the monthly inventory accounting period. If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end item costs.
-- Parameters:
-- ==========
-- Period Name: enter the monthly inventory accounting period you wish to report (mandatory).
-- Cost Type: enter a Cost Type to value the quantities using the Cost Type item costs; if Cost Type is not entered the report will use the Cost Type from your Fiscal Policies (optional).
-- OPM Calendar Code: choose the OPM Calendar Code which corresponds to the period costs you wish to report (mandatory).
-- OPM Period Code: enter the OPM Period Code which corresponds to the period costs and OPM Calendar Code you wish to report (mandatory).
-- Category Sets 1 - 3: enter up to three item category sets you wish to report (optional).
-- Item Number: specific Product, By-Product or Ingredient you wish to report (optional).
-- Batch Number: enter any batch number which is open or was closed within the date range of the OPM Period Code and Calendar Code (optional).
-- Batch Status: to minimize the report size, specify the batch statuses you wish to report (optional).
-- Batch Number From: (optional).
-- Batch Number To: (optional).
-- Organization Code: enter the inventory organization(s), defaults to your session's inventory organization (optional).
-- Operating Unit: enter the operating unit(s) you wish to report (optional).
-- Ledger: enter the ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2025 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 22 Jan 2025 Douglas Volz Initial Coding based on client's sample report.
-- -- | 1.1 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================/
-- Excel Example Output: https://www.enginatics.com/example/cac-opm-batch-material-summary/
-- Library Link: https://www.enginatics.com/reports/cac-opm-batch-material-summary/
-- Run Report: https://demo.enginatics.com/

with ic as (
select /*+ materialize*/
x.organization_id,
x.inventory_item_id,
x.cost_type,
x.cost_type_desc,
round(sum(x.item_cost),9) item_cost
from
(
select
mp.organization_id,
gic.inventory_item_id,
cmm.cost_mthd_code cost_type,
cmm.cost_mthd_desc cost_type_desc,
gic.acctg_cost item_cost
from
mtl_parameters mp,
hr_organization_information hoi,
cm_whse_asc cwa,
gmf_fiscal_policies gfp,
gmf_period_statuses gps,
cm_mthd_mst cmm,
gl_item_cst gic
where
:p_cost_type is null and
2=2 and
4=4 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
mp.organization_id=cwa.organization_id(+) and
to_number(hoi.org_information2)=gfp.legal_entity_id and
gfp.legal_entity_id=gps.legal_entity_id and
gfp.cost_type_id=gps.cost_type_id and
gps.cost_type_id=cmm.cost_type_id and
gps.period_id=gic.period_id and
gps.cost_type_id=gic.cost_type_id and
nvl(cwa.cost_organization_id,mp.organization_id)=gic.organization_id and
gic.delete_mark=0
union all
select
mp.organization_id,
ccd.inventory_item_id,
cmm.cost_mthd_code cost_type,
cmm.cost_mthd_desc cost_type_desc,
ccd.cmpnt_cost item_cost
from
mtl_parameters mp,
hr_organization_information hoi,
cm_whse_asc cwa,
gmf_period_statuses gps,
cm_mthd_mst cmm,
cm_cmpt_dtl ccd,
cm_cmpt_mst_b ccmb
where
:p_cost_type is not null and
2=2 and
3=3 and
4=4 and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
mp.organization_id=cwa.organization_id(+) and
to_number(hoi.org_information2)=gps.legal_entity_id and
gps.cost_type_id=cmm.cost_type_id and
gps.period_id=ccd.period_id and
gps.cost_type_id=ccd.cost_type_id and
nvl(cwa.cost_organization_id,mp.organization_id)=ccd.organization_id and
ccd.delete_mark=0 and
ccd.cost_cmpntcls_id=ccmb.cost_cmpntcls_id and
ccmb.product_cost_ind=1
) x
group by
x.organization_id,
x.inventory_item_id,
x.cost_type,
x.cost_type_desc
)
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code org_code,
:p_calendar_code calendar_code,
:p_period_code period_code,
gbh.batch_no batch_number,
gbh.plan_start_date batch_start_date,
gbh.plan_cmplt_date planned_completion_date,
gbh.actual_cmplt_date actual_completion_date,
gbh.batch_close_date closed_date,
xxen_util.meaning(gbh.batch_status,'GME_BATCH_STATUS',553) batch_status,
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(gmd.line_type,'LINE_TYPE',555) row_type,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
(select misv.inventory_item_status_code_tl from mtl_item_status_vl misv where msiv.inventory_item_status_code=misv.inventory_item_status_code) item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_segments1
&category_segments2
&category_segments3
gmd.original_qty*mucv.conversion_rate primary_original_quantity,
gmd.plan_qty*mucv.conversion_rate primary_planned_quantity,
msiv.primary_uom_code,
gmd.original_qty original_transacted_quantity,
gmd.plan_qty planned_transacted_quantity,
gmd.dtl_um planned_transacted_uom,
gmd.actual_qty actual_transacted_quantity,
gmd.actual_qty*mucv.conversion_rate primary_actual_quantity,
ic.cost_type,
ic.cost_type_desc cost_type_description,
ic.item_cost
from
mtl_parameters mp,
org_acct_periods oap,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
gme_batch_header gbh,
gme_material_details gmd,
mtl_system_items_vl msiv,
mtl_uom_conversions_view mucv,
ic
where
1=1 and
2=2 and
5=5 and
6=6 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.process_enabled_flag='Y' and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=oap.organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
sysdate<nvl(haouv.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
mp.organization_id=gbh.organization_id and
gbh.delete_mark=0 and
(gbh.batch_close_date is null and nvl(gbh.actual_start_date,sysdate)<oap.schedule_close_date+1 or gbh.batch_close_date>=oap.period_start_date) and
gbh.batch_id=gmd.batch_id and
gmd.organization_id=msiv.organization_id and
gmd.inventory_item_id=msiv.inventory_item_id and
gmd.organization_id=mucv.organization_id and
gmd.inventory_item_id=mucv.inventory_item_id and
gmd.dtl_um=mucv.uom_code and
gmd.organization_id=ic.organization_id(+) and
gmd.inventory_item_id=ic.inventory_item_id(+)
order by
ledger,
operating_unit,
org_code,
batch_number,
row_type,
item_number
