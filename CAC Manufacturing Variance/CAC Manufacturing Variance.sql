/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Manufacturing Variance
-- Description: Report your summary or detail manufacturing variances for open and closed WIP jobs. If the job is open the Report Type column displays "Valuation", as this WIP job and potential variances are still in your WIP inventory balances. If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction. You can report prior periods and the report will automatically adjust the assembly completion, assembly scrap, component issue and resource quantities to reflect the reported accounting period, as well as report only jobs which were open or closed during that prior period.
-- Closed, Pending Close, Cancelled, Complete and Complete No Charges WIP job statuses use the completion quantities. All other WIP jobs use the parameter "Use Completion Quantities". And if you use Standard Costing, for standard discrete jobs this report also shows your configuration and method variances; the difference between your WIP BOM/routing and your standard BOM/routing. Non-standard jobs usually do not have configuration variances, as they are "non-standard" without standard BOM or routing requirements.
-- -- | Copyright 2011-25 Douglas Volz Consulting, Inc.
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== =============== =========================================
-- -- | 1.36 21 Dec 2024 Douglas Volz Fixes for Configuration and Method Variances.
-- -- | 1.37 02 Jan 2025 Douglas Volz Add Scrap Variance column, to avoid double-counting assy scrap.
-- -- | 1.38 04 Feb 2025 Douglas Volz Consolidate Summary and Detail reports into one report.
-- -- | 1.39 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- Excel Example Output: https://www.enginatics.com/example/cac-manufacturing-variance/
-- Library Link: https://www.enginatics.com/reports/cac-manufacturing-variance/
-- Run Report: https://demo.enginatics.com/

with j as (
select /*+ materialize*/
x.*,
x.quantity_completed+x.quantity_scrapped fg_total_qty,
x.quantity_completed+decode(:p_include_scrap,'Y',x.quantity_scrapped,0) completion_quantity,
case when x.status_type in (4,5,7,12,14,15) then 'Y' else :p_use_completion_qtys end use_completion,
case
when x.status_type in (4,5,7,12,14,15) or :p_use_completion_qtys='Y' then decode(x.class_type,5,x.quantity_completed,x.quantity_completed+decode(:p_include_scrap,'Y',x.quantity_scrapped,0))
when :p_use_completion_qtys='N' then x.start_quantity
end item_factor
from
(
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
haouv.name organization_name,
mp.organization_code,
mp.primary_cost_method,
mp.avg_rates_cost_type_id,
cct.cost_type_id,
cct.cost_type,
gl.currency_code,
oap.acct_period_id,
oap.period_name,
oap.schedule_close_date,
case when wdj.date_closed>=oap.period_start_date and wdj.date_closed<oap.schedule_close_date+1 then 'Variance' else 'Valuation' end report_type,
wdj.wip_entity_id,
wdj.organization_id,
wdj.class_code,
wac.class_type,
wdj.status_type,
wdj.project_id,
wdj.primary_item_id,
msiv.concatenated_segments assembly_number,
msiv.description assy_description,
msiv.item_type assy_item_type,
msiv.inventory_item_status_code assy_item_status_code,
msiv.primary_uom_code assy_uom_code,
msiv.planning_make_buy_code,
msiv.std_lot_size,
wdj.lot_number,
wdj.creation_date,
wdj.scheduled_start_date,
wdj.date_released,
wdj.date_completed,
trunc(wdj.date_closed) date_closed,
wdj.last_update_date,
wdj.start_quantity,
wdj.material_account,
wdj.resource_account,
wdj.outside_processing_account,
wdj.overhead_account,
wp.mandatory_scrap_flag,
(select max(badv.alternate_designator_code) from bom_alternate_designators_vl badv where badv.display_name=:p_alt_bom_designator and badv.organization_id in (wdj.organization_id,-1)) alternate_bom_designator,
wdj.quantity_completed-nvl((select sum(mmt.primary_quantity) from mtl_material_transactions mmt where wdj.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and wdj.organization_id=mmt.organization_id and mmt.transaction_type_id in (17,44) and mmt.transaction_date>=oap.schedule_close_date+1),0) quantity_completed,
wdj.quantity_scrapped-nvl((select sum(mmt.primary_quantity) from mtl_material_transactions mmt where wdj.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and wdj.organization_id=mmt.organization_id and mmt.transaction_type_id in (90,91) and mmt.transaction_date>=oap.schedule_close_date+1),0) quantity_scrapped
from
mtl_parameters mp,
wip_parameters wp,
hr_organization_information hoi,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
cst_cost_types cct,
org_acct_periods oap,
wip_discrete_jobs wdj,
wip_accounting_classes wac,
mtl_system_items_vl msiv
where
1=1 and
2=2 and
3=3 and
4=4 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=wp.organization_id and
mp.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
hoi.organization_id=haouv.organization_id and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
cct.cost_type_id=nvl((select cct2.cost_type_id from cst_cost_types cct2 where cct2.cost_type=:p_cost_type),mp.primary_cost_method) and
mp.organization_id=oap.organization_id and
mp.organization_id=wdj.organization_id and
wdj.class_code=wac.class_code and
wdj.organization_id=wac.organization_id and
wac.class_type in (1,3,5) and
wdj.organization_id=msiv.organization_id and
wdj.primary_item_id=msiv.inventory_item_id and
wdj.creation_date<oap.schedule_close_date+1 and
(
wdj.date_closed>=oap.period_start_date and wdj.date_closed<oap.schedule_close_date+1 and :p_report_option in ('Closed jobs','All jobs') or
(wdj.date_closed is null or wdj.date_closed>=oap.schedule_close_date+1) and :p_report_option in ('Open jobs','All jobs')
)
) x
),
ca as (
select /*+ materialize*/
x.organization_id,
x.primary_item_id,
x.cost_type,
cic.cost_type_id,
nvl(cic.shrinkage_rate,0) shrinkage_rate,
nvl(cic.lot_size,1) lot_size,
decode(count(case when cic.based_on_rollup_flag=1 and cicd.rollup_source_type=3 and cicd.attribute15 is null then 1 end),0,'N','Y') rolled_up,
max(case when cic.based_on_rollup_flag=1 and cicd.rollup_source_type=3 and cicd.attribute15 is null then cicd.creation_date end) last_rollup_date
from
(select distinct j.organization_id, j.primary_item_id, j.cost_type_id, j.cost_type, j.primary_cost_method from j) x,
cst_item_costs cic,
cst_item_cost_details cicd
where
x.organization_id=cic.organization_id and
x.primary_item_id=cic.inventory_item_id and
cic.cost_type_id=nvl((select cic2.cost_type_id from cst_item_costs cic2 where x.organization_id=cic2.organization_id and x.primary_item_id=cic2.inventory_item_id and x.cost_type_id=cic2.cost_type_id),x.primary_cost_method) and
cic.organization_id=cicd.organization_id(+) and
cic.inventory_item_id=cicd.inventory_item_id(+) and
cic.cost_type_id=cicd.cost_type_id(+)
group by
x.organization_id,
x.primary_item_id,
x.cost_type,
cic.cost_type_id,
nvl(cic.shrinkage_rate,0),
nvl(cic.lot_size,1)
),
wro as (
select /*+ materialize*/
wro.wip_entity_id,
wro.organization_id,
wro.inventory_item_id,
wro.operation_seq_num,
wro.component_sequence_id,
wro.quantity_per_assembly,
wro.required_quantity,
wro.component_yield_factor,
nvl(wro.basis_type,1) basis_type,
wro.wip_supply_type,
nvl(wro.quantity_issued,0)+nvl((select sum(mmt.primary_quantity) from mtl_material_transactions mmt where wro.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and wro.organization_id=mmt.organization_id and wro.operation_seq_num=mmt.operation_seq_num and wro.inventory_item_id=mmt.inventory_item_id and mmt.transaction_type_id in (35,43) and mmt.transaction_date>=j.schedule_close_date+1),0) quantity_issued
from
j,
wip_requirement_operations wro
where
j.wip_entity_id=wro.wip_entity_id and
j.organization_id=wro.organization_id and
wro.wip_supply_type<>6
),
sb (wip_entity_id,organization_id,alternate_bom_designator,effective_before,date_closed,level_num,component_item_id,component_sequence_id,operation_seq_num,item_num,component_quantity,component_yield_factor,basis_type,include_in_cost_rollup,wip_supply_type) as (
select
j.wip_entity_id,
j.organization_id,
j.alternate_bom_designator,
least(nvl(j.date_closed,sysdate),j.schedule_close_date)+1,
j.date_closed,
1,
bcb.component_item_id,
bcb.component_sequence_id,
bcb.operation_seq_num,
bcb.item_num,
bcb.component_quantity,
bcb.component_yield_factor,
bcb.basis_type,
bcb.include_in_cost_rollup,
coalesce(bcb.wip_supply_type,msib.wip_supply_type,0)
from
j,
bom_structures_b bsb,
bom_components_b bcb,
mtl_system_items_b msib
where
j.primary_item_id=bsb.assembly_item_id and
j.organization_id=bsb.organization_id and
nvl(bsb.alternate_bom_designator,'~')=nvl((select bsb2.alternate_bom_designator from bom_structures_b bsb2 where bsb.assembly_item_id=bsb2.assembly_item_id and bsb.organization_id=bsb2.organization_id and j.alternate_bom_designator=bsb2.alternate_bom_designator),'~') and
bsb.assembly_type=1 and
bsb.common_bill_sequence_id=bcb.bill_sequence_id and
bcb.component_quantity<>0 and
bcb.effectivity_date<least(nvl(j.date_closed,sysdate),j.schedule_close_date)+1 and
(bcb.disable_date is null or bcb.disable_date>sysdate or bcb.disable_date>j.date_closed) and
(bcb.implementation_date is not null or :p_include_unimplemented_ecos='Y') and
bcb.component_item_id=msib.inventory_item_id and
j.organization_id=msib.organization_id
union all
select
sb.wip_entity_id,
sb.organization_id,
sb.alternate_bom_designator,
sb.effective_before,
sb.date_closed,
sb.level_num+1,
bcb.component_item_id,
bcb.component_sequence_id,
bcb.operation_seq_num,
bcb.item_num,
sb.component_quantity*bcb.component_quantity,
bcb.component_yield_factor,
bcb.basis_type,
bcb.include_in_cost_rollup,
coalesce(bcb.wip_supply_type,msib.wip_supply_type,0)
from
sb,
bom_structures_b bsb_alt,
bom_structures_b bsb,
bom_components_b bcb,
mtl_system_items_b msib
where
sb.level_num<4 and
sb.wip_supply_type=6 and
sb.include_in_cost_rollup=1 and
sb.component_item_id=bsb_alt.assembly_item_id(+) and
sb.organization_id=bsb_alt.organization_id(+) and
sb.alternate_bom_designator=bsb_alt.alternate_bom_designator(+) and
sb.component_item_id=bsb.assembly_item_id and
sb.organization_id=bsb.organization_id and
(bsb.alternate_bom_designator=sb.alternate_bom_designator or bsb.alternate_bom_designator is null and bsb_alt.bill_sequence_id is null) and
bsb.assembly_type=1 and
bsb.common_bill_sequence_id=bcb.bill_sequence_id and
bcb.include_in_cost_rollup=1 and
bcb.component_quantity<>0 and
bcb.effectivity_date<sb.effective_before and
(bcb.disable_date is null or bcb.disable_date>sysdate or bcb.disable_date>sb.date_closed) and
(bcb.implementation_date is not null or :p_include_unimplemented_ecos='Y') and
bcb.component_item_id=msib.inventory_item_id and
sb.organization_id=msib.organization_id
),
wc as (
select /*+ materialize*/
wro.wip_entity_id,
wro.organization_id,
wro.inventory_item_id,
wro.operation_seq_num,
wro.component_sequence_id,
(select min(bcb.item_num) from bom_components_b bcb where wro.component_sequence_id=bcb.component_sequence_id and wro.inventory_item_id=bcb.component_item_id) item_num,
wro.quantity_per_assembly,
wro.required_quantity,
wro.component_yield_factor,
wro.quantity_issued,
wro.basis_type,
wro.wip_supply_type
from
wro
union all
select
wro.wip_entity_id,
wro.organization_id,
bcb.component_item_id,
wro.operation_seq_num,
wro.component_sequence_id,
bcb.item_num,
decode(nvl(bcb.basis_type,1),2,nvl(bcb.component_quantity,1)*wro.quantity_per_assembly,nvl(bcb.component_quantity,0)*wro.quantity_per_assembly/nvl(bcb.component_yield_factor,1)),
round(decode(nvl(bcb.basis_type,1),2,nvl(bcb.component_quantity,0)*wro.quantity_per_assembly,nvl(bcb.component_quantity,0)*wro.quantity_per_assembly/nvl(bcb.component_yield_factor,1)*j.item_factor),6),
bcb.component_yield_factor,
round(decode(nvl(bcb.basis_type,1),2,nvl(bcb.component_quantity,1),nvl(bcb.component_quantity,0)/nvl(bcb.component_yield_factor,1))*wro.quantity_issued,6),
nvl(bcb.basis_type,1),
coalesce(bcb.wip_supply_type,msib.wip_supply_type,wro.wip_supply_type)
from
j,
wro,
mtl_system_items_b msib,
bom_structures_b bsb,
bom_components_b bcb
where
j.wip_entity_id=wro.wip_entity_id and
wro.inventory_item_id=msib.inventory_item_id and
wro.organization_id=msib.organization_id and
wro.inventory_item_id=bsb.assembly_item_id and
wro.organization_id=bsb.organization_id and
nvl(bsb.alternate_bom_designator,'~')=nvl((select bsb2.alternate_bom_designator from bom_structures_b bsb2 where bsb.assembly_item_id=bsb2.assembly_item_id and bsb.organization_id=bsb2.organization_id and j.alternate_bom_designator=bsb2.alternate_bom_designator),'~') and
bsb.assembly_type=1 and
bsb.common_bill_sequence_id=bcb.bill_sequence_id and
coalesce(bcb.wip_supply_type,msib.wip_supply_type,0)=6 and
bcb.component_quantity<>0 and
bcb.effectivity_date<least(nvl(j.date_closed,sysdate),j.schedule_close_date)+1 and
(bcb.disable_date is null or bcb.disable_date>sysdate or bcb.disable_date>j.date_closed) and
(bcb.implementation_date is not null or :p_include_unimplemented_ecos='Y')
),
cc as (
select /*+ materialize*/
y.wip_entity_id,
y.organization_id,
y.inventory_item_id,
y.assembly_flag,
y.cost_type,
max(y.lot_size) lot_size,
max(y.item_cost) item_cost,
decode(count(case when cicd.basis_type=2 and (cicd.level_type=2 or cicd.cost_element_id in (1,2)) then 1 end),0,'N','Y') lot_basis_type,
sum(case when cicd.basis_type=2 and (cicd.level_type=2 or cicd.cost_element_id in (1,2)) then cicd.item_cost else 0 end) lot_basis_cost,
sum(case when cicd.basis_type=2 and (cicd.level_type=2 or cicd.cost_element_id in (1,2)) then 0 else cicd.item_cost end) item_basis_cost
from
(
select
x.*,
case when x.cost_update_id is not null then decode(x.assembly_flag,'Y',x.primary_cost_method,x.cost_type_id) else x.primary_cost_method end cic_cost_type_id,
case
when x.cost_update_id is not null then decode(x.assembly_flag,'Y',nvl(cic.lot_size,1),(select nvl(cic2.lot_size,1) from cst_item_costs cic2 where x.organization_id=cic2.organization_id and x.inventory_item_id=cic2.inventory_item_id and x.cost_type_id=cic2.cost_type_id))
else nvl(cic.lot_size,1)
end lot_size,
case
when x.cost_update_id is not null then nvl((select csc.standard_cost from cst_standard_costs csc where x.cost_update_id=csc.cost_update_id and x.organization_id=csc.organization_id and x.inventory_item_id=csc.inventory_item_id),0)
else nvl(cic.item_cost,0)
end item_cost
from
(
select
w.wip_entity_id,
w.organization_id,
w.inventory_item_id,
w.assembly_flag,
j.cost_type_id,
j.cost_type,
j.primary_cost_method,
(
select
max(csc.cost_update_id)
from
cst_standard_costs csc
where
w.inventory_item_id=csc.inventory_item_id and
w.organization_id=csc.organization_id and
csc.standard_cost_revision_date<
case
when j.date_closed is null and cic.last_update_date<j.schedule_close_date+1 then cic.last_update_date+interval '1' second
when j.date_closed is null and cic.last_update_date>j.schedule_close_date+1 then j.schedule_close_date+1
when j.date_closed is not null and cic.last_update_date<j.schedule_close_date+1 and j.date_closed<j.last_update_date then j.date_closed+interval '1' second
when j.date_closed is not null and cic.last_update_date<j.schedule_close_date+1 and j.date_closed>cic.last_update_date then cic.last_update_date+interval '1' second
when j.date_closed is not null and cic.last_update_date>=j.schedule_close_date+1 and j.date_closed<j.schedule_close_date+1 then j.date_closed+interval '1' second
else j.schedule_close_date+1
end
) cost_update_id
from
(
select distinct wc.wip_entity_id, wc.organization_id, wc.inventory_item_id, 'N' assembly_flag from wc
union
select sb.wip_entity_id, sb.organization_id, sb.component_item_id, 'N' assembly_flag from sb where sb.wip_supply_type<>6
union all
select j.wip_entity_id, j.organization_id, j.primary_item_id, 'Y' assembly_flag from j
) w,
j,
cst_item_costs cic
where
w.wip_entity_id=j.wip_entity_id and
w.organization_id=cic.organization_id and
w.inventory_item_id=cic.inventory_item_id and
j.primary_cost_method=cic.cost_type_id
) x,
cst_item_costs cic
where
x.organization_id=cic.organization_id and
x.inventory_item_id=cic.inventory_item_id and
x.primary_cost_method=cic.cost_type_id and
(x.cost_update_id is not null or x.cost_type_id<>x.primary_cost_method) and
(x.cost_update_id is null or x.assembly_flag='Y' or x.cost_type_id in (select cic3.cost_type_id from cst_item_costs cic3 where x.organization_id=cic3.organization_id and x.inventory_item_id=cic3.inventory_item_id))
) y,
cst_item_cost_details cicd
where
y.organization_id=cicd.organization_id(+) and
y.inventory_item_id=cicd.inventory_item_id(+) and
y.cic_cost_type_id=cicd.cost_type_id(+)
group by
y.wip_entity_id,
y.organization_id,
y.inventory_item_id,
y.assembly_flag,
y.cost_type
),
rt as (
select /*+ materialize*/
x.organization_id,
x.cost_type,
x.rate_cost_type_id,
decode(x.cost_type_id,x.default_cost_type_id,-99,x.default_cost_type_id) default_cost_type_id
from
(
select distinct
j.organization_id,
j.cost_type_id,
j.cost_type,
decode(j.cost_type_id,2,j.avg_rates_cost_type_id,5,j.avg_rates_cost_type_id,6,j.avg_rates_cost_type_id,j.cost_type_id) rate_cost_type_id,
decode(j.primary_cost_method,1,1,2,j.avg_rates_cost_type_id,5,j.avg_rates_cost_type_id,6,j.avg_rates_cost_type_id,-99) default_cost_type_id
from
j
) x
),
crc as (
select /*+ materialize*/
crc.organization_id,
crc.resource_id,
crc.cost_type_id,
rt.cost_type,
crc.resource_rate
from
rt,
cst_resource_costs crc
where
rt.organization_id=crc.organization_id and
(
crc.cost_type_id=rt.rate_cost_type_id or
crc.cost_type_id=rt.default_cost_type_id and crc.resource_id not in (select crc2.resource_id from cst_resource_costs crc2 where rt.organization_id=crc2.organization_id and rt.rate_cost_type_id=crc2.cost_type_id)
)
),
cdo as (
select /*+ materialize*/
cdo.organization_id,
cdo.department_id,
cdo.overhead_id,
rt.cost_type,
cdo.basis_type,
cdo.rate_or_amount
from
rt,
cst_department_overheads cdo
where
rt.organization_id=cdo.organization_id and
(
cdo.cost_type_id=rt.rate_cost_type_id or
cdo.cost_type_id=rt.default_cost_type_id and (cdo.department_id,cdo.overhead_id) not in (select cdo2.department_id, cdo2.overhead_id from cst_department_overheads cdo2 where rt.organization_id=cdo2.organization_id and rt.rate_cost_type_id=cdo2.cost_type_id)
)
),
cro as (
select /*+ materialize*/
cro.organization_id,
cro.resource_id,
cro.overhead_id
from
rt,
cst_resource_overheads cro
where
rt.organization_id=cro.organization_id and
(
cro.cost_type_id=rt.rate_cost_type_id or
cro.cost_type_id=rt.default_cost_type_id and (cro.resource_id,cro.overhead_id) not in (select cro2.resource_id, cro2.overhead_id from cst_resource_overheads cro2 where rt.organization_id=cro2.organization_id and rt.rate_cost_type_id=cro2.cost_type_id)
)
),
rs as (
select /*+ materialize*/
x.wip_entity_id,
x.organization_id,
x.department_id,
x.operation_seq_num,
x.resource_seq_num,
x.resource_id,
x.basis_type,
br.resource_code,
br.description,
br.unit_of_measure,
br.cost_element_id,
br.purchase_item_id,
crc.cost_type,
nvl(crc.resource_rate,0) resource_rate,
max(x.wip_flag) wip_flag,
sum(x.usage_rate_or_amount) usage_rate_or_amount,
sum(x.total_req_quantity) total_req_quantity,
sum(x.applied_resource_units) applied_resource_units,
sum(x.total_req_quantity*decode(br.functional_currency_flag,1,1,nvl(crc.resource_rate,0))) wip_std_resource_value,
sum(x.applied_resource_value) applied_resource_value,
sum(x.std_usage_rate_or_amount) std_usage_rate_or_amount,
sum(x.std_total_req_quantity) std_total_req_quantity
from
(
select
1 wip_flag,
wor.wip_entity_id,
wor.organization_id,
wo.department_id,
wo.operation_seq_num,
wor.resource_seq_num,
wor.resource_id,
wor.basis_type,
nvl(wor.usage_rate_or_amount,0) usage_rate_or_amount,
nvl(round(decode(wor.basis_type,2,nvl(wor.usage_rate_or_amount,0),nvl(wor.usage_rate_or_amount,0)*j.item_factor),6),0) total_req_quantity,
nvl(wor.applied_resource_units,0) applied_resource_units,
nvl(wor.applied_resource_value,0) applied_resource_value,
0 std_usage_rate_or_amount,
0 std_total_req_quantity
from
j,
wip_operations wo,
wip_operation_resources wor
where
j.wip_entity_id=wo.wip_entity_id and
j.organization_id=wo.organization_id and
wo.wip_entity_id=wor.wip_entity_id and
wo.organization_id=wor.organization_id and
wo.operation_seq_num=wor.operation_seq_num
union all
select
1 wip_flag,
wt.wip_entity_id,
wt.organization_id,
wt.department_id,
wt.operation_seq_num,
wt.resource_seq_num,
wt.resource_id,
wt.basis_type,
0 usage_rate_or_amount,
0 total_req_quantity,
-nvl(wt.primary_quantity,0) applied_resource_units,
-wt.primary_quantity*decode(wt.standard_rate_flag,1,decode(br.functional_currency_flag,1,1,nvl(crc.resource_rate,0)),2,nvl(wt.currency_actual_resource_rate,wt.actual_resource_rate)*nvl(wt.currency_conversion_rate,1)) applied_resource_value,
0 std_usage_rate_or_amount,
0 std_total_req_quantity
from
j,
wip_transactions wt,
bom_resources br,
crc
where
j.wip_entity_id=wt.wip_entity_id and
j.organization_id=wt.organization_id and
wt.transaction_date>=j.schedule_close_date+1 and
wt.resource_id=br.resource_id and
br.cost_element_id in (3,4) and
wt.organization_id=crc.organization_id(+) and
wt.resource_id=crc.resource_id(+)
union all
select
0 wip_flag,
j.wip_entity_id,
j.organization_id,
bos.department_id,
bos.operation_seq_num,
bor.resource_seq_num,
bor.resource_id,
bor.basis_type,
0 usage_rate_or_amount,
0 total_req_quantity,
0 applied_resource_units,
0 applied_resource_value,
nvl(bor.usage_rate_or_amount,0) std_usage_rate_or_amount,
nvl(round(decode(bor.basis_type,2,nvl(bor.usage_rate_or_amount,0),nvl(bor.usage_rate_or_amount,0)*j.item_factor),6),0) std_total_req_quantity
from
j,
ca,
bom_operational_routings bor2,
bom_operation_sequences bos,
bom_operation_resources bor
where
j.organization_id=ca.organization_id and
j.primary_item_id=ca.primary_item_id and
(ca.last_rollup_date is null or ca.last_rollup_date>j.schedule_close_date+1) and
j.primary_item_id=bor2.assembly_item_id and
j.organization_id=bor2.organization_id and
bor2.alternate_routing_designator is null and
bor2.routing_type=1 and
nvl(bor2.common_routing_sequence_id,bor2.routing_sequence_id)=bos.routing_sequence_id and
bos.effectivity_date<j.creation_date and
(bos.disable_date is null or bos.disable_date>j.creation_date) and
bos.operation_sequence_id=bor.operation_sequence_id
union all
select
0 wip_flag,
j.wip_entity_id,
j.organization_id,
bos.department_id,
bos.operation_seq_num,
nvl((select min(wor.resource_seq_num) from wip_operation_resources wor where sb.wip_entity_id=wor.wip_entity_id and sb.organization_id=wor.organization_id and sb.operation_seq_num=wor.operation_seq_num and bos.operation_seq_num=wor.operation_seq_num and bor.resource_id=wor.resource_id and wor.phantom_flag=1 and sb.operation_seq_num=wor.phantom_op_seq_num),bor.resource_seq_num) resource_seq_num,
bor.resource_id,
bor.basis_type,
0 usage_rate_or_amount,
0 total_req_quantity,
0 applied_resource_units,
0 applied_resource_value,
nvl(bor.usage_rate_or_amount,0) std_usage_rate_or_amount,
nvl(round(decode(bor.basis_type,2,nvl(bor.usage_rate_or_amount,0),nvl(bor.usage_rate_or_amount,0)*j.item_factor),6),0) std_total_req_quantity
from
j,
ca,
bom_parameters bp,
sb,
bom_operational_routings bor2,
bom_operation_sequences bos,
bom_operation_resources bor
where
j.organization_id=ca.organization_id and
j.primary_item_id=ca.primary_item_id and
(ca.last_rollup_date is null or ca.last_rollup_date>j.schedule_close_date+1) and
j.organization_id=bp.organization_id and
bp.use_phantom_routings=1 and
j.wip_entity_id=sb.wip_entity_id and
sb.wip_supply_type=6 and
sb.component_item_id=bor2.assembly_item_id and
sb.organization_id=bor2.organization_id and
bor2.alternate_routing_designator is null and
bor2.routing_type=1 and
nvl(bor2.common_routing_sequence_id,bor2.routing_sequence_id)=bos.routing_sequence_id and
bos.effectivity_date<j.creation_date and
(bos.disable_date is null or bos.disable_date>j.creation_date) and
bos.operation_sequence_id=bor.operation_sequence_id
union all
select
0 wip_flag,
j.wip_entity_id,
j.organization_id,
cicd.department_id,
cicd.operation_seq_num,
cicd.resource_seq_num,
cicd.resource_id,
cicd.basis_type,
0 usage_rate_or_amount,
0 total_req_quantity,
0 applied_resource_units,
0 applied_resource_value,
nvl(cicd.usage_rate_or_amount,0) std_usage_rate_or_amount,
nvl(round(decode(cicd.basis_type,2,nvl(cicd.usage_rate_or_amount,0),nvl(cicd.usage_rate_or_amount,0)*j.item_factor),6),0) std_total_req_quantity
from
j,
cst_item_cost_details cicd,
crc
where
j.organization_id=cicd.organization_id and
j.primary_item_id=cicd.inventory_item_id and
cicd.rollup_source_type=3 and
cicd.cost_element_id=3 and
cicd.level_type=1 and
cicd.item_cost<>0 and
cicd.last_update_date<j.schedule_close_date+1 and
(j.date_closed is null or j.date_closed>cicd.last_update_date) and
cicd.organization_id=crc.organization_id and
cicd.resource_id=crc.resource_id and
cicd.cost_type_id=crc.cost_type_id
) x,
bom_resources br,
crc
where
8=8 and
x.resource_id=br.resource_id and
x.organization_id=crc.organization_id(+) and
x.resource_id=crc.resource_id(+) and
(
x.wip_flag=0 or
br.purchase_item_id is null and br.cost_element_id=3 or
exists (select null from po_distributions_all pda where x.wip_entity_id=pda.wip_entity_id and x.resource_id=pda.bom_resource_id and x.resource_seq_num=pda.wip_resource_seq_num and x.operation_seq_num=pda.wip_operation_seq_num and x.organization_id=pda.destination_organization_id)
)
group by
x.wip_entity_id,
x.organization_id,
x.department_id,
x.operation_seq_num,
x.resource_seq_num,
x.resource_id,
x.basis_type,
br.resource_code,
br.description,
br.unit_of_measure,
br.cost_element_id,
br.purchase_item_id,
crc.cost_type,
nvl(crc.resource_rate,0)
),
m as (
select /*+ materialize*/
x.wip_entity_id,
x.organization_id,
x.inventory_item_id,
x.item_num,
cc.cost_type,
nvl(cc.item_cost,0) item_cost,
nvl(cc.lot_basis_type,'N') lot_basis_type,
nvl(cc.lot_size,1) comp_lot_size,
nvl(cc.lot_basis_cost,0) lot_basis_cost,
nvl(cc.item_basis_cost,0) item_basis_cost,
min(
case when x.department_id=0 then
(select min(nvl(wro.department_id,wo.department_id)) from wip_requirement_operations wro, wip_operations wo where x.wip_entity_id=wro.wip_entity_id and x.organization_id=wro.organization_id and x.inventory_item_id=wro.inventory_item_id and wro.wip_entity_id=wo.wip_entity_id and wro.organization_id=wo.organization_id and wro.operation_seq_num=wo.operation_seq_num)
else x.department_id
end) department_id,
min(x.operation_seq_num) operation_seq_num,
nvl(max(nullif(x.wip_supply_type,0)),max(x.comp_wip_supply_type)) wip_supply_type,
case when max(x.wip_basis_type)=0 then decode(max(x.comp_basis_type),2,2,1) else decode(max(x.wip_basis_type),2,2,1) end basis_type,
max(x.include_in_cost_rollup) include_in_cost_rollup,
sum(x.quantity_per_assembly) quantity_per_assembly,
sum(x.total_req_quantity) total_req_quantity,
sum(x.quantity_issued) quantity_issued,
sum(x.total_req_quantity*nvl(cc.item_cost,0)) wip_std_value,
sum(x.quantity_issued*nvl(cc.item_cost,0)) applied_value,
sum(x.std_quantity_per_assembly) std_quantity_per_assembly,
sum(x.std_total_req_quantity) std_total_req_quantity
from
(
select
wc.wip_entity_id,
wc.organization_id,
wc.inventory_item_id,
wc.item_num,
wo.department_id,
wc.operation_seq_num,
wc.wip_supply_type,
0 comp_wip_supply_type,
wc.basis_type wip_basis_type,
0 comp_basis_type,
0 include_in_cost_rollup,
decode(wc.basis_type,2,nvl(wc.required_quantity,1),nvl(wc.quantity_per_assembly,0)/nvl(wc.component_yield_factor,1)) quantity_per_assembly,
round(
case when wc.basis_type=2 then nvl(wc.quantity_per_assembly,0)*case j.use_completion when 'Y' then case when j.completion_quantity>0 then 1 else 0 end when 'N' then 1 end
else nvl(wc.quantity_per_assembly,0)/nvl(wc.component_yield_factor,1)*j.item_factor
end,6) total_req_quantity,
nvl(wc.quantity_issued,0) quantity_issued,
0 std_quantity_per_assembly,
0 std_total_req_quantity
from
j,
wc,
wip_operations wo
where
j.wip_entity_id=wc.wip_entity_id and
wc.wip_entity_id=wo.wip_entity_id(+) and
wc.organization_id=wo.organization_id(+) and
wc.operation_seq_num=wo.operation_seq_num(+)
union all
select
sb.wip_entity_id,
sb.organization_id,
sb.component_item_id inventory_item_id,
sb.item_num,
nvl((select min(rs.department_id) from rs where sb.wip_entity_id=rs.wip_entity_id and sb.operation_seq_num=rs.operation_seq_num),0) department_id,
nvl((select min(wro.operation_seq_num) from wip_requirement_operations wro where sb.wip_entity_id=wro.wip_entity_id and sb.organization_id=wro.organization_id and sb.component_item_id=wro.inventory_item_id and sb.component_sequence_id=wro.component_sequence_id),sb.operation_seq_num) operation_seq_num,
0 wip_supply_type,
sb.wip_supply_type comp_wip_supply_type,
0 wip_basis_type,
nvl(sb.basis_type,1) comp_basis_type,
sb.include_in_cost_rollup,
0 quantity_per_assembly,
0 total_req_quantity,
0 quantity_issued,
decode(nvl(sb.basis_type,1),2,nvl(sb.component_quantity,1),nvl(sb.component_quantity,0)/nvl(sb.component_yield_factor,1))/(1-ca.shrinkage_rate) std_quantity_per_assembly,
round(
case when nvl(sb.basis_type,1)=2 then nvl(sb.component_quantity,0)*case j.use_completion when 'Y' then case when j.quantity_completed+decode(ca.shrinkage_rate,0,decode(:p_include_scrap,'Y',j.quantity_scrapped,0),0)>0 then 1 else 0 end when 'N' then 1 end
else nvl(sb.component_quantity,0)/nvl(sb.component_yield_factor,1)*case j.use_completion when 'Y' then decode(j.class_type,5,j.quantity_completed,j.quantity_completed+decode(ca.shrinkage_rate,0,decode(:p_include_scrap,'Y',j.quantity_scrapped,0),0)) when 'N' then j.start_quantity end
end,6) std_total_req_quantity
from
j,
ca,
sb
where
j.organization_id=ca.organization_id and
j.primary_item_id=ca.primary_item_id and
j.wip_entity_id=sb.wip_entity_id and
sb.wip_supply_type<>6
) x,
cc
where
x.wip_entity_id=cc.wip_entity_id(+) and
x.inventory_item_id=cc.inventory_item_id(+) and
cc.assembly_flag(+)='N'
group by
x.wip_entity_id,
x.organization_id,
x.inventory_item_id,
x.item_num,
cc.cost_type,
nvl(cc.item_cost,0),
nvl(cc.lot_basis_type,'N'),
nvl(cc.lot_size,1),
nvl(cc.lot_basis_cost,0),
nvl(cc.item_basis_cost,0)
),
w as (
select
m.wip_entity_id,
1 report_sort,
j.material_account account,
m.department_id,
m.operation_seq_num,
m.item_num item_or_res_op_seq,
msiv.concatenated_segments item_or_resource,
msiv.description item_or_res_description,
null resource_uom_code,
null overhead,
null ovhd_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) component_item_type,
msiv.inventory_item_status_code component_status_code,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) component_make_buy_code,
xxen_util.meaning(nullif(m.wip_supply_type,0),'WIP_SUPPLY',700) wip_supply_type,
xxen_util.meaning(m.basis_type,'CST_BASIS',700) basis_type,
xxen_util.yes(decode(m.include_in_cost_rollup,1,'Y')) include_in_rollup,
m.cost_type,
m.item_cost item_or_resource_cost,
m.lot_basis_cost,
m.comp_lot_size component_cost_lot_size,
0 overhead_rate,
msiv.primary_uom_code uom_code,
m.quantity_per_assembly,
m.total_req_quantity,
(select max(mmt.transaction_date) from mtl_material_transactions mmt where m.inventory_item_id=mmt.inventory_item_id and m.organization_id=mmt.organization_id and m.wip_entity_id=mmt.transaction_source_id and mmt.transaction_source_type_id=5 and mmt.transaction_date<j.schedule_close_date+1) last_txn_date,
m.quantity_issued,
m.wip_std_value wip_std_comp_or_res_value,
m.applied_value applied_comp_or_res_value,
m.std_quantity_per_assembly,
m.std_total_req_quantity,
nvl(
case
when m.basis_type=1 then 0
when j.class_type=3 and :p_nsj_config_lot_var='N' then 0
when ca.rolled_up='N' then 0
when m.quantity_per_assembly=0 then 0
when j.status_type in (4,5,7,12,14,15) or j.quantity_completed<>0 and :p_use_completion_qtys='Y' then round(m.quantity_per_assembly*m.lot_basis_cost/(decode(j.quantity_completed,0,1,j.quantity_completed)+decode(:p_include_scrap,'Y',j.quantity_scrapped,0)),5)
else round(m.quantity_per_assembly*m.lot_basis_cost/decode(j.start_quantity,0,1,j.start_quantity),5)
end,0) wip_matl_lot_charges_per_unit,
nvl(
case
when m.lot_basis_type='N' then 0
when j.class_type=3 and :p_nsj_config_lot_var='N' then 0
when ca.rolled_up='N' then 0
when m.std_quantity_per_assembly=0 then 0
else round(m.std_quantity_per_assembly*m.lot_basis_cost/m.comp_lot_size,5)
end,0) std_matl_lot_charges_per_unit,
0 wip_res_lot_charges_per_unit,
0 std_res_lot_charges_per_unit,
0 wip_osp_lot_charges_per_unit,
0 std_osp_lot_charges_per_unit,
case when j.fg_total_qty=0 and round(m.applied_value,2)=0 then 0 else round(m.applied_value-m.wip_std_value,2) end matl_usage_var,
case
when m.basis_type=2 then 0
when j.class_type=3 and :p_nsj_config_lot_var='N' then 0
when ca.rolled_up='N' then 0
when nvl(m.std_total_req_quantity,0)+nvl(m.total_req_quantity,0)=0 then 0
when nvl(m.std_total_req_quantity,0)-nvl(m.total_req_quantity,0)=0 then 0
when j.primary_cost_method<>1 then 0
when j.fg_total_qty=0 and round(m.applied_value,2)=0 then 0
else round((nvl(m.total_req_quantity,0)-nvl(m.std_total_req_quantity,0))*m.item_basis_cost,2)
end matl_config_var,
nvl(
case
when j.primary_cost_method<>1 then 0
when m.basis_type=1 then 0
when j.class_type=3 and :p_nsj_config_lot_var='N' then 0
when ca.rolled_up='N' then 0
when m.std_quantity_per_assembly=0 then 0
when j.status_type in (4,5,7,12,14,15) or j.quantity_completed<>0 and :p_use_completion_qtys='Y' then round(m.quantity_per_assembly*m.lot_basis_cost-m.std_quantity_per_assembly*m.lot_basis_cost/nvl(ca.lot_size,1)*(j.quantity_completed+decode(:p_include_scrap,'Y',j.quantity_scrapped,0)),2)
else round(m.quantity_per_assembly*m.lot_basis_cost-m.std_quantity_per_assembly*m.lot_basis_cost/nvl(ca.lot_size,1)*decode(j.start_quantity,0,1,j.start_quantity),2)
end,0) matl_lot_var,
0 res_efficiency_var,
0 res_methods_var,
0 res_lot_var,
0 osp_efficiency_var,
0 osp_methods_var,
0 osp_lot_var,
0 ovhd_efficiency_var,
0 scrap_variance,
0 material_variance,
0 res_variance,
0 osp_variance,
0 ovhd_variance,
0 total_variance,
0 wip_costs_in,
0 wip_costs_out,
0 wip_relief,
0 wip_value
from
j,
m,
mtl_system_items_vl msiv,
ca
where
6=6 and
9=9 and
j.wip_entity_id=m.wip_entity_id and
m.inventory_item_id=msiv.inventory_item_id and
m.organization_id=msiv.organization_id and
j.organization_id=ca.organization_id(+) and
j.primary_item_id=ca.primary_item_id(+) and
j.primary_cost_method=ca.cost_type_id(+) and
nvl(m.operation_seq_num,1)>0 and
nvl(m.quantity_per_assembly,0)+nvl(m.std_quantity_per_assembly,0)+round(m.quantity_issued,3)<>0
union all
select
z.wip_entity_id,
z.report_sort,
z.account,
z.department_id,
z.operation_seq_num,
z.item_or_res_op_seq,
z.item_or_resource,
z.item_or_res_description,
z.resource_uom_code,
z.overhead,
z.ovhd_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) component_item_type,
msiv.inventory_item_status_code component_status_code,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) component_make_buy_code,
null wip_supply_type,
xxen_util.meaning(z.basis_type,'CST_BASIS',700) basis_type,
null include_in_rollup,
z.cost_type,
z.resource_rate item_or_resource_cost,
z.lot_basis_cost,
to_number(null) component_cost_lot_size,
z.overhead_rate,
msiv.primary_uom_code uom_code,
z.usage_rate_or_amount quantity_per_assembly,
z.total_req_quantity,
z.last_txn_date,
z.applied_resource_units quantity_issued,
z.wip_std_resource_value wip_std_comp_or_res_value,
z.applied_resource_value applied_comp_or_res_value,
round(z.std_usage_rate_or_amount,3) std_quantity_per_assembly,
round(z.std_total_req_quantity,3) std_total_req_quantity,
0 wip_matl_lot_charges_per_unit,
0 std_matl_lot_charges_per_unit,
decode(z.cost_element_id,4,0,z.wip_lot_charges_per_unit) wip_res_lot_charges_per_unit,
decode(z.cost_element_id,4,0,z.std_lot_charges_per_unit) std_res_lot_charges_per_unit,
decode(z.cost_element_id,3,0,z.wip_lot_charges_per_unit) wip_osp_lot_charges_per_unit,
decode(z.cost_element_id,3,0,z.std_lot_charges_per_unit) std_osp_lot_charges_per_unit,
0 matl_usage_var,
0 matl_config_var,
0 matl_lot_var,
decode(z.cost_element_id,4,0,z.efficiency_var) res_efficiency_var,
decode(z.cost_element_id,4,0,z.methods_var) res_methods_var,
decode(z.cost_element_id,4,0,z.lot_var) res_lot_var,
decode(z.cost_element_id,3,0,z.efficiency_var) osp_efficiency_var,
decode(z.cost_element_id,3,0,z.methods_var) osp_methods_var,
decode(z.cost_element_id,3,0,z.lot_var) osp_lot_var,
z.ovhd_efficiency_var,
0 scrap_variance,
0 material_variance,
0 res_variance,
0 osp_variance,
0 ovhd_variance,
0 total_variance,
0 wip_costs_in,
0 wip_costs_out,
0 wip_relief,
0 wip_value
from
(
select
rs.wip_entity_id,
rs.organization_id,
2 report_sort,
decode(rs.cost_element_id,4,j.outside_processing_account,j.resource_account) account,
rs.department_id,
rs.operation_seq_num,
rs.resource_seq_num item_or_res_op_seq,
rs.resource_code item_or_resource,
rs.description item_or_res_description,
rs.unit_of_measure resource_uom_code,
null overhead,
null ovhd_description,
rs.purchase_item_id,
rs.basis_type,
rs.cost_type,
rs.resource_rate,
decode(rs.basis_type,2,rs.resource_rate,0) lot_basis_cost,
0 overhead_rate,
rs.usage_rate_or_amount,
rs.total_req_quantity,
(select max(wt.transaction_date) from wip_transactions wt where rs.resource_id=wt.resource_id and rs.organization_id=wt.organization_id and rs.wip_entity_id=wt.wip_entity_id and wt.transaction_type in (1,3) and wt.transaction_date<j.schedule_close_date+1) last_txn_date,
rs.applied_resource_units,
rs.wip_std_resource_value,
rs.applied_resource_value,
rs.std_usage_rate_or_amount,
rs.std_total_req_quantity,
rs.cost_element_id,
case
when ca.lot_size is null then 0
when nvl(rs.basis_type,1)<>2 then 0
when j.class_type=3 and :p_nsj_config_lot_var='N' then 0
when rs.usage_rate_or_amount=0 then 0
when ca.rolled_up='N' then 0
when j.status_type in (4,5,7,12,14,15) or j.quantity_completed<>0 and :p_use_completion_qtys='Y' then round(rs.usage_rate_or_amount*rs.resource_rate/(decode(j.quantity_completed,0,1,j.quantity_completed)+decode(:p_include_scrap,'Y',j.quantity_scrapped,0)),5)
else round(rs.usage_rate_or_amount*rs.resource_rate/decode(j.start_quantity,0,1,j.start_quantity),5)
end wip_lot_charges_per_unit,
case
when ca.lot_size is null then 0
when nvl(rs.basis_type,1)<>2 then 0
when j.class_type=3 and :p_nsj_config_lot_var='N' then 0
when ca.rolled_up='N' then 0
when rs.std_usage_rate_or_amount=0 then 0
else round(rs.std_usage_rate_or_amount*rs.resource_rate/ca.lot_size,5)
end std_lot_charges_per_unit,
round(rs.applied_resource_value-rs.wip_std_resource_value,2) efficiency_var,
case
when nvl(rs.basis_type,1)<>1 then 0
when j.class_type=3 and :p_nsj_config_lot_var='N' then 0
when j.fg_total_qty=0 and round(rs.applied_resource_value,2)=0 then -round(rs.applied_resource_value-rs.wip_std_resource_value,2)
when ca.rolled_up='N' then 0
when nvl(rs.std_total_req_quantity,0)=0 and nvl(rs.total_req_quantity,0)=0 then 0
else round((nvl(rs.total_req_quantity,0)-nvl(rs.std_total_req_quantity,0))*rs.resource_rate,2)
end methods_var,
case
when j.primary_cost_method<>1 then 0
when ca.lot_size is null then 0
when nvl(rs.basis_type,1)<>2 then 0
when j.class_type=3 and :p_nsj_config_lot_var='N' then 0
when ca.rolled_up='N' then 0
when rs.std_usage_rate_or_amount=0 then 0
when j.status_type in (4,5,7,12,14,15) or j.quantity_completed<>0 and :p_use_completion_qtys='Y' then round(rs.usage_rate_or_amount*rs.resource_rate-rs.std_usage_rate_or_amount*rs.resource_rate/ca.lot_size*(j.quantity_completed+decode(:p_include_scrap,'Y',j.quantity_scrapped,0)),2)
else round(rs.usage_rate_or_amount*rs.resource_rate-rs.std_usage_rate_or_amount*rs.resource_rate/ca.lot_size*decode(j.start_quantity,0,1,j.start_quantity),2)
end lot_var,
0 ovhd_efficiency_var
from
j,
rs,
ca
where
j.wip_entity_id=rs.wip_entity_id and
j.organization_id=ca.organization_id(+) and
j.primary_item_id=ca.primary_item_id(+) and
j.primary_cost_method=ca.cost_type_id(+)
union all
select
x.wip_entity_id,
x.organization_id,
3 report_sort,
j.overhead_account account,
x.department_id,
x.operation_seq_num,
x.resource_seq_num item_or_res_op_seq,
x.resource_code item_or_resource,
x.description item_or_res_description,
x.unit_of_measure resource_uom_code,
br.resource_code overhead,
br.description ovhd_description,
x.purchase_item_id,
x.basis_type,
x.cost_type,
nvl(x.resource_rate,0) resource_rate,
decode(x.basis_type,2,x.resource_rate,0) lot_basis_cost,
x.rate_or_amount overhead_rate,
x.usage_rate_or_amount,
x.total_req_quantity,
(select max(wt.transaction_date) from wip_transactions wt where x.overhead_id=wt.resource_id and x.organization_id=wt.organization_id and x.wip_entity_id=wt.wip_entity_id and wt.transaction_type=2 and wt.transaction_date<j.schedule_close_date+1) last_txn_date,
x.applied_resource_units,
x.wip_std_resource_value,
x.applied_resource_value,
0 std_usage_rate_or_amount,
0 std_total_req_quantity,
null cost_element_id,
0 wip_lot_charges_per_unit,
0 std_lot_charges_per_unit,
0 efficiency_var,
0 methods_var,
0 lot_var,
x.ovhd_efficiency_var
from
(
select
rs.wip_entity_id,
rs.organization_id,
rs.department_id,
rs.operation_seq_num,
rs.resource_seq_num,
rs.resource_code,
rs.description,
rs.unit_of_measure,
cdo.overhead_id,
cdo.basis_type ovhd_basis_type,
rs.purchase_item_id,
rs.basis_type,
rs.cost_type,
rs.resource_rate,
cdo.rate_or_amount,
rs.usage_rate_or_amount,
rs.total_req_quantity,
rs.applied_resource_units,
rs.wip_std_resource_value,
rs.applied_resource_value,
round(nvl(cdo.rate_or_amount,0)*decode(cdo.basis_type,3,rs.applied_resource_units,4,rs.applied_resource_value),2)-round(nvl(cdo.rate_or_amount,0)*decode(cdo.basis_type,3,rs.total_req_quantity,4,rs.wip_std_resource_value),2) ovhd_efficiency_var
from
rs,
cro,
cdo
where
rs.wip_flag=1 and
rs.organization_id=cro.organization_id and
rs.resource_id=cro.resource_id and
cro.organization_id=cdo.organization_id and
cro.overhead_id=cdo.overhead_id and
rs.department_id=cdo.department_id and
cdo.basis_type in (3,4)
union all
select
wo.wip_entity_id,
wo.organization_id,
wo.department_id,
wo.operation_seq_num,
to_number(null) resource_seq_num,
null resource_code,
null description,
null unit_of_measure,
cdo.overhead_id,
cdo.basis_type ovhd_basis_type,
to_number(null) purchase_item_id,
cdo.basis_type,
cdo.cost_type,
to_number(null) resource_rate,
cdo.rate_or_amount,
to_number(null) usage_rate_or_amount,
nvl(round(case j.use_completion when 'Y' then decode(cdo.basis_type,2,decode(j.completion_quantity,0,0,1),decode(j.class_type,5,j.quantity_completed,j.completion_quantity)) when 'N' then decode(cdo.basis_type,2,decode(j.start_quantity,0,0,1),j.start_quantity) else 0 end,6),0) total_req_quantity,
decode(cdo.basis_type,2,decode(wo.quantity_completed,0,0,1),nvl(wo.quantity_completed,0)) applied_resource_units,
nvl(round(case j.use_completion when 'Y' then decode(cdo.basis_type,2,decode(j.completion_quantity,0,0,1),decode(j.class_type,5,j.quantity_completed,j.completion_quantity)) when 'N' then decode(cdo.basis_type,2,decode(j.start_quantity,0,0,1),j.start_quantity) else 0 end,2),0) wip_std_resource_value,
round(decode(cdo.basis_type,2,decode(wo.quantity_completed,0,0,1),nvl(wo.quantity_completed,0))*cdo.rate_or_amount,2) applied_resource_value,
nvl(round(decode(cdo.basis_type,2,decode(wo.quantity_completed,0,0,1),nvl(wo.quantity_completed,0))*cdo.rate_or_amount-case j.use_completion when 'Y' then decode(cdo.basis_type,2,decode(j.completion_quantity,0,0,1),decode(j.class_type,5,j.quantity_completed,j.completion_quantity)) when 'N' then decode(cdo.basis_type,2,decode(j.start_quantity,0,0,1),j.start_quantity) else 0 end*nvl(cdo.rate_or_amount,0),2),0) ovhd_efficiency_var
from
j,
wip_operations wo,
cdo
where
j.wip_entity_id=wo.wip_entity_id and
j.organization_id=wo.organization_id and
wo.organization_id=cdo.organization_id and
wo.department_id=cdo.department_id and
cdo.basis_type in (1,2)
) x,
j,
bom_resources br
where
x.wip_entity_id=j.wip_entity_id and
x.overhead_id=br.resource_id
) z,
mtl_system_items_vl msiv
where
5=5 and
z.purchase_item_id=msiv.inventory_item_id(+) and
z.organization_id=msiv.organization_id(+)
union all
select
j.wip_entity_id,
4 report_sort,
j.overhead_account account,
to_number(null) department_id,
to_number(null) operation_seq_num,
to_number(null) item_or_res_op_seq,
null item_or_resource,
null item_or_res_description,
null resource_uom_code,
null overhead,
null ovhd_description,
null component_item_type,
null component_status_code,
null component_make_buy_code,
null wip_supply_type,
null basis_type,
null include_in_rollup,
null cost_type,
to_number(null) item_or_resource_cost,
to_number(null) lot_basis_cost,
to_number(null) component_cost_lot_size,
to_number(null) overhead_rate,
null uom_code,
0 quantity_per_assembly,
0 total_req_quantity,
to_date(null) last_txn_date,
0 quantity_issued,
0 wip_std_comp_or_res_value,
0 applied_comp_or_res_value,
0 std_quantity_per_assembly,
0 std_total_req_quantity,
0 wip_matl_lot_charges_per_unit,
0 std_matl_lot_charges_per_unit,
0 wip_res_lot_charges_per_unit,
0 std_res_lot_charges_per_unit,
0 wip_osp_lot_charges_per_unit,
0 std_osp_lot_charges_per_unit,
0 matl_usage_var,
0 matl_config_var,
0 matl_lot_var,
0 res_efficiency_var,
0 res_methods_var,
0 res_lot_var,
0 osp_efficiency_var,
0 osp_methods_var,
0 osp_lot_var,
0 ovhd_efficiency_var,
0 scrap_variance,
sum(nvl(wpb.tl_scrap_in,0)+nvl(wpb.pl_material_in,0)+nvl(wpb.pl_material_overhead_in,0)+nvl(wpb.pl_resource_in,0)+nvl(wpb.pl_outside_processing_in,0)+nvl(wpb.pl_overhead_in,0)-nvl(wpb.tl_scrap_out,0)-nvl(wpb.tl_material_out,0)-nvl(wpb.pl_material_out,0)-nvl(wpb.tl_material_overhead_out,0)-nvl(wpb.pl_material_overhead_out,0)-nvl(wpb.pl_resource_out,0)-nvl(wpb.pl_outside_processing_out,0)-nvl(wpb.pl_overhead_out,0)) material_variance,
sum(nvl(wpb.tl_resource_in,0)-nvl(wpb.tl_resource_out,0)) res_variance,
sum(nvl(wpb.tl_outside_processing_in,0)-nvl(wpb.tl_outside_processing_out,0)) osp_variance,
sum(nvl(wpb.tl_overhead_in,0)-nvl(wpb.tl_overhead_out,0)) ovhd_variance,
sum(nvl(wpb.tl_scrap_in,0)+nvl(wpb.pl_material_in,0)+nvl(wpb.pl_material_overhead_in,0)+nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)+nvl(wpb.tl_outside_processing_in,0)+nvl(wpb.pl_outside_processing_in,0)+nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)-nvl(wpb.tl_scrap_out,0)-nvl(wpb.tl_material_out,0)-nvl(wpb.pl_material_out,0)-nvl(wpb.tl_material_overhead_out,0)-nvl(wpb.pl_material_overhead_out,0)-nvl(wpb.tl_resource_out,0)-nvl(wpb.pl_resource_out,0)-nvl(wpb.tl_outside_processing_out,0)-nvl(wpb.pl_outside_processing_out,0)-nvl(wpb.tl_overhead_out,0)-nvl(wpb.pl_overhead_out,0)) total_variance,
sum(nvl(wpb.tl_scrap_in,0)+nvl(wpb.pl_material_in,0)+nvl(wpb.pl_material_overhead_in,0)+nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)+nvl(wpb.tl_outside_processing_in,0)+nvl(wpb.pl_outside_processing_in,0)+nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)) wip_costs_in,
sum(nvl(wpb.tl_scrap_out,0)+nvl(wpb.tl_material_out,0)+nvl(wpb.pl_material_out,0)+nvl(wpb.tl_material_overhead_out,0)+nvl(wpb.pl_material_overhead_out,0)+nvl(wpb.tl_resource_out,0)+nvl(wpb.pl_resource_out,0)+nvl(wpb.tl_outside_processing_out,0)+nvl(wpb.pl_outside_processing_out,0)+nvl(wpb.tl_overhead_out,0)+nvl(wpb.pl_overhead_out,0)) wip_costs_out,
sum(nvl(wpb.tl_scrap_var,0)+nvl(wpb.tl_material_var,0)+nvl(wpb.pl_material_var,0)+nvl(wpb.tl_material_overhead_var,0)+nvl(wpb.pl_material_overhead_var,0)+nvl(wpb.tl_resource_var,0)+nvl(wpb.pl_resource_var,0)+nvl(wpb.tl_outside_processing_var,0)+nvl(wpb.pl_outside_processing_var,0)+nvl(wpb.tl_overhead_var,0)+nvl(wpb.pl_overhead_var,0)) wip_relief,
sum(nvl(wpb.tl_scrap_in,0)+nvl(wpb.pl_material_in,0)+nvl(wpb.pl_material_overhead_in,0)+nvl(wpb.tl_resource_in,0)+nvl(wpb.pl_resource_in,0)+nvl(wpb.tl_outside_processing_in,0)+nvl(wpb.pl_outside_processing_in,0)+nvl(wpb.tl_overhead_in,0)+nvl(wpb.pl_overhead_in,0)-nvl(wpb.tl_scrap_out,0)-nvl(wpb.tl_material_out,0)-nvl(wpb.pl_material_out,0)-nvl(wpb.tl_material_overhead_out,0)-nvl(wpb.pl_material_overhead_out,0)-nvl(wpb.tl_resource_out,0)-nvl(wpb.pl_resource_out,0)-nvl(wpb.tl_outside_processing_out,0)-nvl(wpb.pl_outside_processing_out,0)-nvl(wpb.tl_overhead_out,0)-nvl(wpb.pl_overhead_out,0)-nvl(wpb.tl_scrap_var,0)-nvl(wpb.tl_material_var,0)-nvl(wpb.pl_material_var,0)-nvl(wpb.tl_material_overhead_var,0)-nvl(wpb.pl_material_overhead_var,0)-nvl(wpb.tl_resource_var,0)-nvl(wpb.pl_resource_var,0)-nvl(wpb.tl_outside_processing_var,0)-nvl(wpb.pl_outside_processing_var,0)-nvl(wpb.tl_overhead_var,0)-nvl(wpb.pl_overhead_var,0)) wip_value
from
j,
wip_period_balances wpb
where
(select xxen_util.lookup_code(:p_report_mode,'CST_RPT_DETAIL_OPTION',700) from dual)='2' and
j.wip_entity_id=wpb.wip_entity_id and
j.organization_id=wpb.organization_id and
wpb.acct_period_id<=j.acct_period_id
group by
j.wip_entity_id,
j.overhead_account
union all
select
j.wip_entity_id,
5 report_sort,
j.overhead_account account,
to_number(null) department_id,
to_number(null) operation_seq_num,
to_number(null) item_or_res_op_seq,
null item_or_resource,
null item_or_res_description,
null resource_uom_code,
null overhead,
null ovhd_description,
null component_item_type,
null component_status_code,
null component_make_buy_code,
null wip_supply_type,
null basis_type,
null include_in_rollup,
null cost_type,
to_number(null) item_or_resource_cost,
to_number(null) lot_basis_cost,
to_number(null) component_cost_lot_size,
to_number(null) overhead_rate,
null uom_code,
0 quantity_per_assembly,
0 total_req_quantity,
to_date(null) last_txn_date,
0 quantity_issued,
0 wip_std_comp_or_res_value,
0 applied_comp_or_res_value,
0 std_quantity_per_assembly,
0 std_total_req_quantity,
0 wip_matl_lot_charges_per_unit,
0 std_matl_lot_charges_per_unit,
0 wip_res_lot_charges_per_unit,
0 std_res_lot_charges_per_unit,
0 wip_osp_lot_charges_per_unit,
0 std_osp_lot_charges_per_unit,
0 matl_usage_var,
0 matl_config_var,
0 matl_lot_var,
0 res_efficiency_var,
0 res_methods_var,
0 res_lot_var,
0 osp_efficiency_var,
0 osp_methods_var,
0 osp_lot_var,
0 ovhd_efficiency_var,
-nvl(cc.item_cost*j.quantity_scrapped,0) scrap_variance,
0 material_variance,
0 res_variance,
0 osp_variance,
0 ovhd_variance,
0 total_variance,
0 wip_costs_in,
0 wip_costs_out,
0 wip_relief,
0 wip_value
from
j,
cc
where
(select xxen_util.lookup_code(:p_report_mode,'CST_RPT_DETAIL_OPTION',700) from dual)='2' and
j.mandatory_scrap_flag=1 and
j.wip_entity_id=cc.wip_entity_id(+) and
cc.assembly_flag(+)='Y'
),
y as (
select
w.wip_entity_id,
decode(x.mode_code,'1',w.report_sort) report_sort,
decode(x.mode_code,'1',w.account) account,
decode(x.mode_code,'1',w.department_id) department_id,
decode(x.mode_code,'1',w.operation_seq_num) operation_seq_num,
decode(x.mode_code,'1',w.item_or_res_op_seq) item_or_res_op_seq,
decode(x.mode_code,'1',w.item_or_resource) item_or_resource,
decode(x.mode_code,'1',w.item_or_res_description) item_or_res_description,
decode(x.mode_code,'1',w.resource_uom_code) resource_uom_code,
decode(x.mode_code,'1',w.overhead) overhead,
decode(x.mode_code,'1',w.ovhd_description) ovhd_description,
decode(x.mode_code,'1',w.component_item_type) component_item_type,
decode(x.mode_code,'1',w.component_status_code) component_status_code,
decode(x.mode_code,'1',w.component_make_buy_code) component_make_buy_code,
decode(x.mode_code,'1',w.wip_supply_type) wip_supply_type,
decode(x.mode_code,'1',w.basis_type) basis_type,
decode(x.mode_code,'1',w.include_in_rollup) include_in_rollup,
decode(x.mode_code,'1',w.cost_type) cost_type,
decode(x.mode_code,'1',w.item_or_resource_cost) item_or_resource_cost,
decode(x.mode_code,'1',w.lot_basis_cost) lot_basis_cost,
decode(x.mode_code,'1',w.component_cost_lot_size) component_cost_lot_size,
decode(x.mode_code,'1',w.overhead_rate) overhead_rate,
decode(x.mode_code,'1',w.uom_code) uom_code,
decode(x.mode_code,'1',w.quantity_per_assembly) quantity_per_assembly,
decode(x.mode_code,'1',w.total_req_quantity) total_req_quantity,
decode(x.mode_code,'1',w.last_txn_date) last_txn_date,
decode(x.mode_code,'1',w.quantity_issued) quantity_issued,
decode(x.mode_code,'1',w.std_quantity_per_assembly) std_quantity_per_assembly,
decode(x.mode_code,'1',w.std_total_req_quantity) std_total_req_quantity,
round(sum(w.wip_std_comp_or_res_value),2) wip_std_comp_or_res_value,
round(sum(w.applied_comp_or_res_value),2) applied_comp_or_res_value,
round(sum(w.wip_matl_lot_charges_per_unit),5) wip_matl_lot_charges_per_unit,
round(sum(w.std_matl_lot_charges_per_unit),5) std_matl_lot_charges_per_unit,
round(sum(w.wip_res_lot_charges_per_unit),5) wip_res_lot_charges_per_unit,
round(sum(w.std_res_lot_charges_per_unit),5) std_res_lot_charges_per_unit,
round(sum(w.wip_osp_lot_charges_per_unit),5) wip_osp_lot_charges_per_unit,
round(sum(w.std_osp_lot_charges_per_unit),5) std_osp_lot_charges_per_unit,
round(sum(w.matl_usage_var),2) matl_usage_var,
round(sum(w.matl_config_var),2) matl_config_var,
round(sum(w.matl_lot_var),2) matl_lot_var,
round(sum(w.res_efficiency_var),2) res_efficiency_var,
round(sum(w.res_methods_var),2) res_methods_var,
round(sum(w.res_lot_var),2) res_lot_var,
round(sum(w.osp_efficiency_var),2) osp_efficiency_var,
round(sum(w.osp_methods_var),2) osp_methods_var,
round(sum(w.osp_lot_var),2) osp_lot_var,
round(sum(w.ovhd_efficiency_var),2) ovhd_efficiency_var,
round(sum(w.scrap_variance),2) scrap_variance,
round(sum(w.material_variance),2) material_variance,
round(sum(w.res_variance),2) res_variance,
round(sum(w.osp_variance),2) osp_variance,
round(sum(w.ovhd_variance),2) ovhd_variance,
round(sum(w.total_variance),2) total_variance,
round(sum(w.wip_costs_in),2) wip_costs_in,
round(sum(w.wip_costs_out),2) wip_costs_out,
round(sum(w.wip_relief),2) wip_relief,
round(sum(w.wip_value),2) wip_value
from
w,
(select xxen_util.lookup_code(:p_report_mode,'CST_RPT_DETAIL_OPTION',700) mode_code from dual) x
group by
w.wip_entity_id,
x.mode_code,
decode(x.mode_code,'1',w.report_sort),
decode(x.mode_code,'1',w.account),
decode(x.mode_code,'1',w.department_id),
decode(x.mode_code,'1',w.operation_seq_num),
decode(x.mode_code,'1',w.item_or_res_op_seq),
decode(x.mode_code,'1',w.item_or_resource),
decode(x.mode_code,'1',w.item_or_res_description),
decode(x.mode_code,'1',w.resource_uom_code),
decode(x.mode_code,'1',w.overhead),
decode(x.mode_code,'1',w.ovhd_description),
decode(x.mode_code,'1',w.component_item_type),
decode(x.mode_code,'1',w.component_status_code),
decode(x.mode_code,'1',w.component_make_buy_code),
decode(x.mode_code,'1',w.wip_supply_type),
decode(x.mode_code,'1',w.basis_type),
decode(x.mode_code,'1',w.include_in_rollup),
decode(x.mode_code,'1',w.cost_type),
decode(x.mode_code,'1',w.item_or_resource_cost),
decode(x.mode_code,'1',w.lot_basis_cost),
decode(x.mode_code,'1',w.component_cost_lot_size),
decode(x.mode_code,'1',w.overhead_rate),
decode(x.mode_code,'1',w.uom_code),
decode(x.mode_code,'1',w.quantity_per_assembly),
decode(x.mode_code,'1',w.total_req_quantity),
decode(x.mode_code,'1',w.last_txn_date),
decode(x.mode_code,'1',w.quantity_issued),
decode(x.mode_code,'1',w.std_quantity_per_assembly),
decode(x.mode_code,'1',w.std_total_req_quantity)
)
select
j.report_type,
:p_report_mode report_mode,
j.ledger,
j.operating_unit,
j.organization_code org_code,
j.organization_name,
j.period_name,
j.class_code wip_class,
xxen_util.meaning(j.class_type,'WIP_CLASS_TYPE',700) class_type,
we.wip_entity_name wip_job,
(select ppa.segment1 from pa_projects_all ppa where j.project_id=ppa.project_id) project_number,
xxen_util.meaning(j.status_type,'WIP_JOB_STATUS',700) job_status,
j.creation_date,
j.scheduled_start_date,
j.date_released,
j.date_completed,
j.date_closed,
j.last_update_date,
j.assy_uom_code uom_code,
j.std_lot_size item_std_lot_size,
ca.cost_type lot_size_cost_type,
nvl(ca.lot_size,1) assembly_cost_lot_size,
j.start_quantity,
j.quantity_completed assembly_quantity_completed,
j.quantity_scrapped assembly_quantity_scrapped,
j.fg_total_qty total_assembly_quantity,
j.assembly_number assembly,
j.assy_description assembly_description,
xxen_util.meaning(j.assy_item_type,'ITEM_TYPE',3) item_type,
j.assy_item_status_code item_status,
xxen_util.meaning(j.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
j.lot_number,
&p_det1_cols
j.currency_code,
&p_det2_cols
y.matl_usage_var material_usage_variance,
&p_det3_cols
y.matl_config_var configuration_variance,
&p_det4_cols
y.matl_lot_var material_lot_variance,
y.matl_usage_var+y.matl_config_var+y.matl_lot_var total_material_variance,
y.res_efficiency_var resource_efficiency_variance,
y.res_methods_var resource_methods_variance,
&p_det5_cols
y.res_lot_var resource_lot_variance,
y.res_efficiency_var+y.res_methods_var+y.res_lot_var total_resource_variance,
y.osp_efficiency_var OSP_efficiency_variance,
y.osp_methods_var OSP_methods_variance,
&p_det6_cols
y.osp_lot_var OSP_lot_variance,
y.osp_efficiency_var+y.osp_methods_var+y.osp_lot_var total_OSP_variance,
&p_sum_cols
xxen_util.yes(ca.rolled_up) rolled_up,
ca.last_rollup_date last_cost_rollup
from
j,
(
select
y.*,
y.matl_usage_var+y.matl_config_var+y.matl_lot_var+y.res_efficiency_var+y.res_methods_var+y.res_lot_var+y.osp_efficiency_var+y.osp_methods_var+y.osp_lot_var+y.ovhd_efficiency_var+y.scrap_variance explained_variance
from
y
) y,
ca,
wip_entities we,
bom_departments bd,
mtl_system_items_vl msiv
where
j.wip_entity_id=y.wip_entity_id and
j.organization_id=ca.organization_id(+) and
j.primary_item_id=ca.primary_item_id(+) and
j.primary_cost_method=ca.cost_type_id(+) and
j.wip_entity_id=we.wip_entity_id and
y.department_id=bd.department_id(+) and
j.primary_item_id=msiv.inventory_item_id and
j.organization_id=msiv.organization_id
order by
j.report_type,
j.ledger,
j.operating_unit,
j.organization_code,
j.class_code,
we.wip_entity_name
&p_det_order_by
