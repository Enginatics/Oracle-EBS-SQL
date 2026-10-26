/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Material Usage Variance
-- Description: Report your material usage variances for your open and closed WIP jobs. This report replicates the Material Variance Section for the Oracle Discrete Job Value - Standard Costing report.
-- If the job is open the Report Type column displays "Valuation", as this WIP job and potential material usage variance is still in your WIP inventory balances. If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction. You can report prior periods and this report will automatically adjust the assembly completion quantities and component issue quantities to reflect the quantities for the specified accounting period, as well as report only jobs which were open or closed during that prior period.
-- Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities. All other WIP jobs use the parameter "Use Completion Quantities".
-- Parameters:
-- ==========
-- Report Option: Open jobs, Closed jobs or All jobs. Use this to limit the size of the report. (mandatory)
-- Period Name: the accounting period you wish to report. (mandatory)
-- Cost Type: defaults to your Costing Method; if the cost type is missing component costs the report will find any missing item costs from your Costing Method cost type. (optional)
-- Include Scrap Quantities: for calculating your completion quantities and component quantity requirements, include or exclude any scrapped assembly quantities. (mandatory)
-- Include Unreleased Jobs: include jobs which have not been released and are not started. (mandatory)
-- Include Bulk Supply Items: include Bulk items to match the results from the Oracle Discrete Job Value Report; exclude knowing that Bulk items are usually not issued to the WIP job. (mandatory)
-- Use Completion Qtys: for jobs in a released status, use the completion quantities for the material usage and configuration variance calculations. Useful if you backflush your materials based on your completion quantities. Complete, Complete - No Charges, Cancelled, Closed, Pending Close or Failed Close alway use the completion quantities for the variance calculations. (mandatory)
-- Category Set 1: any item category you wish (optional).
-- Category Set 2: any item category you wish (optional).
-- Class Code: specific type of WIP class to report (optional).
-- Job Status: specific WIP job status (optional).
-- WIP Job: specific WIP job (optional).
-- Assembly Number: specific assembly number you wish to report (optional)
-- Component Number: specific component item you wish to report (optional)
-- Organization Code: any inventory organization, defaults to your session's inventory organization (optional).
-- Operating Unit: specific operating unit (optional)
-- Ledger: specific ledger (optional)
-- / +=============================================================================+
-- -- | Copyright 2009 - 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is acknowledged.
-- -- | 1.26 23 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== =============== =========================================
-- -- | 1.0 12 Oct 2020 Douglas Volz Initial Coding Based on ICP WIP Component
-- -- | Variances and ICP WIP Component Valuation
-- -- | 1.24 02 Feb 2022 Douglas Volz Fix for non-standard jobs, there are no rows in wipoperations if there is no routing.
-- -- | 1.25 20 Jun 2024 Douglas Volz Remove tabs, reinstall parameters and inventory org access controls.
-- -- | ======= =========== =============== =========================================
-- Excel Example Output: https://www.enginatics.com/example/cac-wip-material-usage-variance/
-- Library Link: https://www.enginatics.com/reports/cac-wip-material-usage-variance/
-- Run Report: https://demo.enginatics.com/

with j as (
select /*+ materialize*/
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
mp.organization_code,
gl.currency_code,
oap.period_name,
oap.period_start_date,
oap.schedule_close_date,
case when wdj.date_closed>=oap.period_start_date and wdj.date_closed<oap.schedule_close_date+1 then 'Variance' else 'Valuation' end report_type,
wdj.organization_id,
wdj.wip_entity_id,
wdj.class_code,
wac.class_type,
wdj.status_type,
wdj.project_id,
wdj.primary_item_id,
wdj.lot_number,
wdj.creation_date,
wdj.scheduled_start_date,
wdj.date_released,
wdj.date_completed,
trunc(wdj.date_closed) date_closed,
wdj.last_update_date,
wdj.start_quantity,
wdj.material_account,
wdj.material_overhead_account,
wdj.resource_account,
wdj.outside_processing_account,
wdj.overhead_account,
wdj.quantity_completed-nvl((select sum(mmt.primary_quantity) from mtl_material_transactions mmt where wdj.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and wdj.organization_id=mmt.organization_id and mmt.transaction_type_id in (17,44) and mmt.transaction_date>=oap.schedule_close_date+1),0) quantity_completed,
wdj.quantity_scrapped-nvl((select sum(mmt.primary_quantity) from mtl_material_transactions mmt where wdj.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and wdj.organization_id=mmt.organization_id and mmt.transaction_type_id in (90,91) and mmt.transaction_date>=oap.schedule_close_date+1),0) quantity_scrapped,
cct.cost_type_id,
cct.cost_type,
mp.primary_cost_method,
nvl((select cic.cost_type_id from cst_item_costs cic where cct.cost_type_id=cic.cost_type_id and wdj.organization_id=cic.organization_id and wdj.primary_item_id=cic.inventory_item_id),mp.primary_cost_method) assembly_cost_type_id
from
mtl_parameters mp,
hr_organization_information hoi,
hr_all_organization_units haou,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_cost_types cct,
org_acct_periods oap,
wip_discrete_jobs wdj,
wip_accounting_classes wac
where
1=1 and
2=2 and
3=3 and
4=4 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id<>mp.master_organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haou.organization_id and
sysdate<nvl(haou.date_to,sysdate+1) and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
cct.cost_type_id=nvl((select cct2.cost_type_id from cst_cost_types cct2 where cct2.cost_type=:p_cost_type),mp.primary_cost_method) and
mp.organization_id=oap.organization_id and
mp.organization_id=wdj.organization_id and
wdj.class_code=wac.class_code and
wdj.organization_id=wac.organization_id and
wac.class_type in (1,3,5) and
(
wdj.date_closed>=oap.period_start_date and wdj.date_closed<oap.schedule_close_date+1 and :p_report_option in ('Closed jobs','All jobs') or
(wdj.date_closed is null or wdj.date_closed>=oap.schedule_close_date+1) and :p_report_option in ('Open jobs','All jobs') and
(
exists (select null from mtl_material_transactions mmt where wdj.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and wdj.organization_id=mmt.organization_id and mmt.transaction_date>=oap.period_start_date and mmt.transaction_date<oap.schedule_close_date+1) or
wdj.creation_date<oap.schedule_close_date+1 and not exists (select null from mtl_material_transactions mmt where wdj.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and wdj.organization_id=mmt.organization_id)
)
)
),
c as (
select /*+ materialize*/
j.wip_entity_id,
j.organization_id,
wro.operation_seq_num,
wro.inventory_item_id,
wro.wip_supply_type,
nvl(wro.basis_type,1) basis_type,
decode(nvl(wro.basis_type,1),2,nvl(wro.required_quantity,1),nvl(wro.quantity_per_assembly,0)/nvl(wro.component_yield_factor,1)) quantity_per_assembly,
round(
case
when :p_use_completion_qtys='Y' then decode(nvl(wro.basis_type,1),2,nvl(wro.quantity_per_assembly,0),nvl(wro.quantity_per_assembly,0)/nvl(wro.component_yield_factor,1)*decode(j.class_type,5,j.quantity_completed,j.quantity_completed+decode(:p_include_scrap,'Y',j.quantity_scrapped,0)))
else wro.required_quantity-decode(:p_include_scrap,'Y',0,nvl(wro.quantity_per_assembly,0)*j.quantity_scrapped)
end,6) total_req_quantity,
nvl(wro.quantity_issued,0)+nvl((select sum(mmt.primary_quantity) from mtl_material_transactions mmt where wro.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and wro.organization_id=mmt.organization_id and wro.operation_seq_num=mmt.operation_seq_num and wro.inventory_item_id=mmt.inventory_item_id and mmt.transaction_type_id in (35,43) and mmt.transaction_date>=j.schedule_close_date+1),0) quantity_issued,
case when not exists (select null from mtl_material_transactions mmt, mtl_cst_actual_cost_details mcacd where wro.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and wro.organization_id=mmt.organization_id and wro.inventory_item_id=mmt.inventory_item_id and mmt.transaction_date>=j.period_start_date and mmt.transaction_date<j.schedule_close_date+1 and mmt.transaction_id=mcacd.transaction_id) then
nvl((select cic.cost_type_id from cst_item_costs cic where j.cost_type_id=cic.cost_type_id and wro.organization_id=cic.organization_id and wro.inventory_item_id=cic.inventory_item_id),j.primary_cost_method)
end standard_cost_type_id
from
j,
wip_requirement_operations wro
where
6=6 and
j.wip_entity_id=wro.wip_entity_id and
j.organization_id=wro.organization_id and
wro.wip_supply_type<>6 and
wro.operation_seq_num>0
)
select
x.report_type,
x.ledger,
x.operating_unit,
x.organization_code org_code,
x.period_name,
&segment_columns
x.class_code wip_class,
xxen_util.meaning(x.class_type,'WIP_CLASS_TYPE',700) class_type,
we.wip_entity_name wip_job,
(select ppa.segment1 from pa_projects_all ppa where x.project_id=ppa.project_id) project_number,
xxen_util.meaning(x.status_type,'WIP_JOB_STATUS',700) job_status,
x.creation_date,
x.scheduled_start_date,
x.date_released,
x.date_completed,
x.date_closed,
x.last_update_date,
msiv.primary_uom_code uom_code,
msiv.std_lot_size item_std_lot_size,
x.cost_type lot_size_cost_type,
nvl(cic.lot_size,1) costing_lot_size,
x.start_quantity,
x.quantity_completed assembly_quantity_completed,
x.quantity_scrapped assembly_quantity_scrapped,
x.quantity_completed+x.quantity_scrapped total_assembly_quantity,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.inventory_item_status_code item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
x.lot_number,
x.operation_seq_num operation_seq_number,
bd.department_code department,
msiv_comp.concatenated_segments component_number,
msiv_comp.description component_description,
xxen_util.meaning(msiv_comp.item_type,'ITEM_TYPE',3) component_item_type,
msiv_comp.inventory_item_status_code component_status_code,
xxen_util.meaning(msiv_comp.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) component_make_buy_code,
xxen_util.meaning(x.wip_supply_type,'WIP_SUPPLY',700) wip_supply_type,
xxen_util.meaning(x.basis_type,'CST_BASIS',700) component_basis_type,
nvl2(x.cost_element_id,x.cost_type,null) cost_type,
x.currency_code,
nvl(xxen_util.meaning(x.cost_element_id,'CST_COST_CODE_TYPE',700),'No Cost') cost_element_type,
x.item_cost,
msiv_comp.primary_uom_code uom_code,
x.quantity_per_assembly,
round(x.total_req_quantity,3) total_required_quantity,
nvl(to_char(x.last_transaction_date,'DD-Mon-RRRR HH24:MI:SS'),'No WIP Issue') last_transaction_date,
nvl(x.last_transaction_type,'No WIP Issue') last_transaction_type,
round(x.quantity_issued,3) quantity_issued,
round(x.quantity_issued-x.total_req_quantity,3) quantity_left_in_wip,
round(x.total_req_quantity*x.item_cost,fc.precision) wip_standard_component_value,
round(x.quantity_issued*x.item_cost,fc.precision) applied_component_value,
case when x.quantity_completed+x.quantity_scrapped=0 and x.quantity_issued*x.item_cost=0 then 0 else (x.quantity_issued-x.total_req_quantity)*x.item_cost end material_usage_variance,
xxen_util.yes(nvl2(cicd.last_rollup_date,'Y',null)) rolled_up,
cicd.last_rollup_date last_cost_rollup
from
(
select
j.*,
c.operation_seq_num,
c.inventory_item_id,
c.wip_supply_type,
c.basis_type,
c.quantity_per_assembly,
c.total_req_quantity,
c.quantity_issued,
e.cost_element_id,
nvl(e.item_cost,0) item_cost,
(select max(mmt.transaction_date) from mtl_material_transactions mmt where c.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and c.organization_id=mmt.organization_id and c.inventory_item_id=mmt.inventory_item_id and mmt.transaction_date<j.schedule_close_date+1) last_transaction_date,
(select max(mtt.transaction_type_name) keep (dense_rank last order by mmt.transaction_date) from mtl_material_transactions mmt, mtl_transaction_types mtt where c.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and c.organization_id=mmt.organization_id and c.inventory_item_id=mmt.inventory_item_id and mmt.transaction_date<j.schedule_close_date+1 and mmt.transaction_type_id=mtt.transaction_type_id) last_transaction_type,
(select wo.department_id from wip_operations wo where c.wip_entity_id=wo.wip_entity_id and c.operation_seq_num=wo.operation_seq_num) department_id,
decode(e.cost_element_id,2,j.material_overhead_account,3,j.resource_account,4,j.outside_processing_account,5,j.overhead_account,j.material_account) account
from
j,
c,
(
select
y.wip_entity_id,
y.inventory_item_id,
y.cost_element_id,
sum(y.item_cost) item_cost
from
(
select
mmt.transaction_source_id wip_entity_id,
mmt.inventory_item_id,
mcacd.cost_element_id,
max(nvl(mcacd.actual_cost,0)) item_cost
from
j,
mtl_material_transactions mmt,
mtl_cst_actual_cost_details mcacd
where
j.wip_entity_id=mmt.transaction_source_id and
mmt.transaction_source_type_id=5 and
j.organization_id=mmt.organization_id and
mmt.transaction_date>=j.period_start_date and
mmt.transaction_date<j.schedule_close_date+1 and
mmt.transaction_id=mcacd.transaction_id
group by
mmt.transaction_source_id,
mmt.inventory_item_id,
mcacd.cost_element_id,
mcacd.level_type
union all
select
c.wip_entity_id,
c.inventory_item_id,
cicd.cost_element_id,
cicd.item_cost
from
c,
cst_item_cost_details cicd
where
c.organization_id=cicd.organization_id and
c.inventory_item_id=cicd.inventory_item_id and
c.standard_cost_type_id=cicd.cost_type_id
) y
group by
y.wip_entity_id,
y.inventory_item_id,
y.cost_element_id
) e
where
j.wip_entity_id=c.wip_entity_id and
c.wip_entity_id=e.wip_entity_id(+) and
c.inventory_item_id=e.inventory_item_id(+)
) x,
wip_entities we,
mtl_system_items_vl msiv,
mtl_system_items_vl msiv_comp,
cst_item_costs cic,
(select cicd.organization_id, cicd.inventory_item_id, cicd.cost_type_id, max(cicd.creation_date) last_rollup_date from cst_item_cost_details cicd where cicd.rollup_source_type=3 and cicd.attribute15 is null group by cicd.organization_id, cicd.inventory_item_id, cicd.cost_type_id) cicd,
bom_departments bd,
fnd_currencies fc,
gl_code_combinations gcc
where
5=5 and
x.quantity_per_assembly+round(x.quantity_issued,3)<>0 and
x.wip_entity_id=we.wip_entity_id and
x.organization_id=msiv.organization_id and
x.primary_item_id=msiv.inventory_item_id and
x.organization_id=msiv_comp.organization_id and
x.inventory_item_id=msiv_comp.inventory_item_id and
x.organization_id=cic.organization_id and
x.primary_item_id=cic.inventory_item_id and
x.assembly_cost_type_id=cic.cost_type_id and
decode(cic.based_on_rollup_flag,1,cic.organization_id)=cicd.organization_id(+) and
cic.inventory_item_id=cicd.inventory_item_id(+) and
cic.cost_type_id=cicd.cost_type_id(+) and
x.department_id=bd.department_id(+) and
x.currency_code=fc.currency_code and
x.account=gcc.code_combination_id(+)
order by
x.report_type,
x.ledger,
x.operating_unit,
x.organization_code,
x.class_code,
we.wip_entity_name,
x.operation_seq_num,
component_number,
department
