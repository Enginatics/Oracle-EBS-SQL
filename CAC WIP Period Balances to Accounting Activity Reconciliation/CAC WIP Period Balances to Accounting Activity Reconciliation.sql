/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Period Balances to Accounting Activity Reconciliation
-- Description: Report to compare the monthly WIP Period Balances with the pre-Create Accounting WIP accounting entries for material, resource, overhead, outside processing, job close variance and standard cost update transactions. With WIP class, job status, name and other details. This report shows both WIP jobs which were open during the accounting period as well as jobs closed during the accounting period. If the stored WIP period balances agree to the period WIP accounting activity, the "Difference" columns have a zero amount.
-- // +=============================================================================+
-- -- | Copyright 2022 Douglas Volz Consulting, Inc. |
-- -- | All rights reserved. |
-- -- | Permission to use this code is granted provided the original author is |
-- -- | acknowledged. No warranties, express or otherwise is included in this |
-- -- | permission. |
-- -- +=============================================================================+
-- -- |
-- -- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- |
-- -- | Program Name: xxxreconcilewipbalances.sql
-- -- |
-- -- | Parameters:
-- -- | pperiodname -- The desired accounting period you wish to report
-- -- | porgcode -- Specific inventory organization you wish to report (optional)
-- -- | poperatingunit -- Operating Unit you wish to report, leave blank for all
-- -- | operating units (optional)
-- -- | pledger -- general ledger you wish to report, leave blank for all
-- -- | ledgers (optional)
-- -- | Description:
-- -- | Report to compare the monthly WIP transactions against the WIP period balances.
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 07 Apr 2021 Douglas Volz Initial Coding based on itemcosthistory.sql
-- -- | 1.1 10 Jul 2022 Douglas Volz Add Ledger and Operating Unit columns
-- -- | 1.2 19 Oct 2022 Douglas Volz Bug fix for missing organization join
-- -- | 1.3 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-wip-period-balances-to-accounting-activity-reconciliation/
-- Library Link: https://www.enginatics.com/reports/cac-wip-period-balances-to-accounting-activity-reconciliation/
-- Run Report: https://demo.enginatics.com/

with o as (
select /*+ materialize*/
mp.organization_id,
mp.organization_code,
oap.acct_period_id,
oap.period_name,
oap.period_start_date,
oap.schedule_close_date
from
mtl_parameters mp,
org_acct_periods oap
where
2=2 and
3=3 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=oap.organization_id
)
select
x.period_name,
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
x.organization_code org_code,
x.organization_id org_id,
msiv.concatenated_segments assembly_number,
msiv.description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
x.class_code wip_class,
xxen_util.meaning(wac.class_type,'WIP_CLASS_TYPE',700) class_type,
xxen_util.meaning(x.entity_type,'WIP_ENTITY',700) wip_type,
x.wip_entity_name wip_job,
x.date_closed,
x.status job_status,
x.date_released,
x.date_completed,
msiv.primary_uom_code uom_code,
x.start_quantity,
x.quantity_completed,
x.quantity_scrapped,
y.wip_costs_in,
y.wip_costs_out,
y.wip_close_var wip_relief,
y.wip_value,
y.wip_acct_in wip_accounted_costs_in,
y.wip_acct_out wip_accounted_costs_out,
y.wip_acct_var wip_accounted_relief,
y.wip_acct_value wip_accounted_value,
y.wip_costs_in-y.wip_acct_in wip_costs_in_difference,
y.wip_costs_out-y.wip_acct_out wip_costs_out_difference,
y.wip_close_var-y.wip_acct_var wip_relief_difference,
y.wip_value-y.wip_acct_value wip_value_difference
from
(
select
o.organization_id,
o.organization_code,
o.acct_period_id,
o.period_name,
we.wip_entity_name,
wdj.wip_entity_id,
we.entity_type,
wdj.class_code,
wdj.date_closed,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) status,
wdj.date_released,
wdj.date_completed,
wdj.start_quantity,
wdj.quantity_completed,
wdj.quantity_scrapped,
wdj.primary_item_id
from
o,
wip_discrete_jobs wdj,
wip_entities we
where
o.organization_id=wdj.organization_id and
(
wdj.date_closed is null and trunc(wdj.creation_date)<=o.schedule_close_date or
trunc(wdj.date_closed)>o.schedule_close_date or
wdj.date_closed>=o.period_start_date and trunc(wdj.date_closed)<o.schedule_close_date+1
) and
wdj.wip_entity_id=we.wip_entity_id
union all
select
o.organization_id,
o.organization_code,
o.acct_period_id,
o.period_name,
we.wip_entity_name,
wfs.wip_entity_id,
we.entity_type,
wfs.class_code,
wfs.date_closed,
xxen_util.meaning(wfs.status,'WIP_FLOW_SCHEDULE_STATUS',700) status,
wfs.creation_date date_released,
wfs.date_closed date_completed,
wfs.planned_quantity start_quantity,
wfs.quantity_completed,
0 quantity_scrapped,
wfs.primary_item_id
from
o,
wip_flow_schedules wfs,
wip_entities we
where
o.organization_id=wfs.organization_id and
(
wfs.date_closed is null and trunc(wfs.creation_date)<=o.schedule_close_date or
trunc(wfs.date_closed)>o.schedule_close_date or
wfs.date_closed>=o.period_start_date and trunc(wfs.date_closed)<o.schedule_close_date+1
) and
wfs.wip_entity_id=we.wip_entity_id and
we.entity_type=4
) x,
(
select
z.organization_id,
z.wip_entity_id,
z.acct_period_id,
sum(z.wip_costs_in) wip_costs_in,
sum(z.wip_costs_out) wip_costs_out,
sum(z.wip_close_var) wip_close_var,
sum(z.wip_value) wip_value,
sum(round(z.wip_acct_in,2)) wip_acct_in,
sum(round(z.wip_acct_out,2)) wip_acct_out,
sum(round(z.wip_acct_var,2)) wip_acct_var,
sum(round(z.wip_acct_value,2)) wip_acct_value
from
(
select
o.organization_id,
wpb.wip_entity_id,
o.acct_period_id,
sum(nvl(wpb.tl_scrap_in,0)+nvl(wpb.pl_material_in,0)+nvl(wpb.pl_material_overhead_in,0)+nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)+nvl(wpb.tl_outside_processing_in,0)+nvl(wpb.pl_outside_processing_in,0)+nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)) wip_costs_in,
sum(nvl(wpb.tl_material_out,0)+nvl(wpb.tl_scrap_out,0)+nvl(wpb.pl_material_out,0)+nvl(wpb.tl_material_overhead_out,0)+nvl(wpb.pl_material_overhead_out,0)+nvl(wpb.tl_resource_out,0)+nvl(wpb.pl_resource_out,0)+nvl(wpb.tl_outside_processing_out,0)+nvl(wpb.pl_outside_processing_out,0)+nvl(wpb.tl_overhead_out,0)+nvl(wpb.pl_overhead_out,0)) wip_costs_out,
sum(nvl(wpb.tl_material_var,0)+nvl(wpb.tl_scrap_var,0)+nvl(wpb.pl_material_var,0)+nvl(wpb.tl_material_overhead_var,0)+nvl(wpb.pl_material_overhead_var,0)+nvl(wpb.tl_resource_var,0)+nvl(wpb.pl_resource_var,0)+nvl(wpb.tl_outside_processing_var,0)+nvl(wpb.pl_outside_processing_var,0)+nvl(wpb.tl_overhead_var,0)+nvl(wpb.pl_overhead_var,0)) wip_close_var,
sum(nvl(wpb.tl_scrap_in,0)+nvl(wpb.pl_material_in,0)-nvl(wpb.tl_material_out,0)-nvl(wpb.tl_scrap_out,0)-nvl(wpb.pl_material_out,0)-nvl(wpb.tl_material_var,0)-nvl(wpb.tl_scrap_var,0)-nvl(wpb.pl_material_var,0)+
nvl(wpb.pl_material_overhead_in,0)-nvl(wpb.tl_material_overhead_out,0)-nvl(wpb.pl_material_overhead_out,0)-nvl(wpb.tl_material_overhead_var,0)-nvl(wpb.pl_material_overhead_var,0)+
nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)-nvl(wpb.tl_resource_out,0)-nvl(wpb.pl_resource_out,0)-nvl(wpb.tl_resource_var,0)-nvl(wpb.pl_resource_var,0)+
nvl(wpb.tl_outside_processing_in,0)+nvl(wpb.pl_outside_processing_in,0)-nvl(wpb.tl_outside_processing_out,0)-nvl(wpb.pl_outside_processing_out,0)-nvl(wpb.tl_outside_processing_var,0)-nvl(wpb.pl_outside_processing_var,0)+
nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)-nvl(wpb.tl_overhead_out,0)-nvl(wpb.pl_overhead_out,0)-nvl(wpb.tl_overhead_var,0)-nvl(wpb.pl_overhead_var,0)) wip_value,
0 wip_acct_in,
0 wip_acct_out,
0 wip_acct_var,
0 wip_acct_value
from
o,
wip_period_balances wpb
where
o.organization_id=wpb.organization_id and
o.acct_period_id=wpb.acct_period_id
group by
o.organization_id,
wpb.wip_entity_id,
o.acct_period_id
union all
select
o.organization_id,
mmt.transaction_source_id,
o.acct_period_id,
0,
0,
0,
0,
sum(decode(mmt.transaction_type_id,35,mta.base_transaction_value,38,mta.base_transaction_value,43,mta.base_transaction_value,48,mta.base_transaction_value,55,mta.base_transaction_value,56,mta.base_transaction_value,57,mta.base_transaction_value,0)),
sum(decode(mmt.transaction_type_id,17,-mta.base_transaction_value,44,-mta.base_transaction_value,90,-mta.base_transaction_value,91,-mta.base_transaction_value,92,-mta.base_transaction_value,1002,-mta.base_transaction_value,1003,-mta.base_transaction_value,0)),
0,
sum(decode(mmt.transaction_type_id,35,mta.base_transaction_value,38,mta.base_transaction_value,43,mta.base_transaction_value,48,mta.base_transaction_value,55,mta.base_transaction_value,56,mta.base_transaction_value,57,mta.base_transaction_value,17,mta.base_transaction_value,44,mta.base_transaction_value,90,mta.base_transaction_value,91,mta.base_transaction_value,92,mta.base_transaction_value,1002,mta.base_transaction_value,1003,mta.base_transaction_value,0))
from
o,
mtl_material_transactions mmt,
mtl_transaction_accounts mta
where
o.acct_period_id=mmt.acct_period_id and
mmt.transaction_date>=o.period_start_date and
mmt.transaction_date<o.schedule_close_date+1 and
mmt.transaction_id=mta.transaction_id and
o.organization_id=mta.organization_id and
mta.transaction_source_type_id=5 and
mta.accounting_line_type=7 and
mta.transaction_date>=o.period_start_date and
mta.transaction_date<o.schedule_close_date+1
group by
o.organization_id,
mmt.transaction_source_id,
o.acct_period_id
union all
select
o.organization_id,
wt.wip_entity_id,
o.acct_period_id,
0,
0,
0,
0,
sum(decode(wt.transaction_type,1,wta.base_transaction_value,2,wta.base_transaction_value,3,wta.base_transaction_value,11,wta.base_transaction_value,12,wta.base_transaction_value,13,wta.base_transaction_value,14,wta.base_transaction_value,0)),
sum(decode(wt.transaction_type,15,wta.base_transaction_value,16,wta.base_transaction_value,17,wta.base_transaction_value,0)),
sum(decode(wt.transaction_type,5,-wta.base_transaction_value,6,-wta.base_transaction_value,7,-wta.base_transaction_value,0)),
sum(decode(wt.transaction_type,1,wta.base_transaction_value,2,wta.base_transaction_value,3,wta.base_transaction_value,11,wta.base_transaction_value,12,wta.base_transaction_value,13,wta.base_transaction_value,14,wta.base_transaction_value,15,wta.base_transaction_value,16,wta.base_transaction_value,17,wta.base_transaction_value,5,wta.base_transaction_value,6,wta.base_transaction_value,7,wta.base_transaction_value,0))
from
o,
wip_transactions wt,
wip_transaction_accounts wta
where
o.acct_period_id=wt.acct_period_id and
wt.transaction_date>=o.period_start_date and
wt.transaction_date<o.schedule_close_date+1 and
wt.transaction_id=wta.transaction_id and
o.organization_id=wta.organization_id and
wta.accounting_line_type=7 and
wta.transaction_date>=o.period_start_date and
wta.transaction_date<o.schedule_close_date+1
group by
o.organization_id,
wt.wip_entity_id,
o.acct_period_id
union all
select
o.organization_id,
cscav.wip_entity_id,
o.acct_period_id,
0,
0,
0,
0,
round(sum(decode(cscav.transaction_type,3,1,6,1,7,1,8,1,9,1,10,1,0)*cscav.adjustment_quantity*(cscav.new_unit_cost-cscav.old_unit_cost)),2),
round(sum(decode(cscav.transaction_type,4,1,5,1,0)*cscav.adjustment_quantity*(cscav.new_unit_cost-cscav.old_unit_cost)),2),
0,
round(sum(decode(cscav.transaction_type,3,1,6,1,7,1,8,1,9,1,10,1,4,cscav.in_out_flag,5,cscav.in_out_flag,0)*cscav.adjustment_quantity*(cscav.new_unit_cost-cscav.old_unit_cost)),2)
from
o,
cst_cost_updates ccu,
cst_std_cost_adj_values cscav
where
o.organization_id=ccu.organization_id and
ccu.update_date>=o.period_start_date and
ccu.update_date<o.schedule_close_date+1 and
ccu.cost_update_id=cscav.cost_update_id
group by
o.organization_id,
cscav.wip_entity_id,
o.acct_period_id
) z
group by
z.organization_id,
z.wip_entity_id,
z.acct_period_id
) y,
wip_accounting_classes wac,
mtl_system_items_vl msiv,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl
where
1=1 and
x.wip_entity_id=y.wip_entity_id and
x.acct_period_id=y.acct_period_id and
x.organization_id=wac.organization_id and
x.class_code=wac.class_code and
x.organization_id=msiv.organization_id and
x.primary_item_id=msiv.inventory_item_id and
x.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id
order by
x.period_name,
ledger,
operating_unit,
org_code,
assembly_number,
wip_job
