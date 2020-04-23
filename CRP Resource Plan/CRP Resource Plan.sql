/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CRP Resource Plan
-- Description: Capacity plans resource load hours including load source e.g. planned order or WIP job number, date and required hours.
-- Excel Examle Output: https://www.enginatics.com/example/crp-resource-plan/
-- Library Link: https://www.enginatics.com/reports/crp-resource-plan/
-- Run Report: https://demo.enginatics.com/

select distinct
y.order_number,
y.department_code,
y.department_description,
y.resource_code,
y.resource_description,
y.resource_date,
case when nvl(wro.row_number,1)=1 then
sum(y.resource_hours) over (partition by y.order_number,y.department_code,y.resource_code,y.resource_date,y.assembly,y.job_number,y.operation_seq_num,y.supply_type &partition_by)
end resource_hours,
min(y.start_date) over (partition by y.order_number,y.department_code,y.resource_code,y.resource_date,y.assembly,y.job_number,y.operation_seq_num,y.supply_type &partition_by) start_date,
max(y.end_date) over (partition by y.order_number,y.department_code,y.resource_code,y.resource_date,y.assembly,y.job_number,y.operation_seq_num,y.supply_type &partition_by) end_date,
y.supply_type,
y.assembly,
y.assembly_description,
y.job_number,
y.job_status,
y.schedule_group,
max(y.daily_rate) over (partition by y.order_number,y.department_code,y.resource_code,y.resource_date,y.assembly,y.job_number,y.operation_seq_num,y.supply_type &partition_by) daily_rate,
max(y.schedule_quantity) over (partition by y.order_number,y.department_code,y.resource_code,y.resource_date,y.assembly,y.job_number,y.operation_seq_num,y.supply_type &partition_by) schedule_quantity,
min(y.schedule_date) over (partition by y.order_number,y.department_code,y.resource_code,y.resource_date,y.assembly,y.job_number,y.operation_seq_num,y.supply_type &partition_by) schedule_date,
max(y.firm) over (partition by y.order_number,y.department_code,y.resource_code,y.resource_date,y.assembly,y.job_number,y.operation_seq_num,y.supply_type &partition_by) firm,
y.operation_seq_num operation_sequence,
&resource_sequence
wo.description operation_description,
xxen_util.client_time(wo.date_last_moved) date_last_moved,
y.start_quantity,
wo.quantity_in_queue in_queue,
wo.quantity_running running,
wo.quantity_waiting_to_move to_move,
wo.quantity_rejected rejected,
wo.quantity_scrapped scrapped,
wo.quantity_completed completed,
(y.start_quantity-wo.quantity_completed+wo.quantity_scrapped) remaining_open,
xxen_util.client_time(wo.first_unit_start_date) first_unit_start_date,
xxen_util.client_time(wo.last_unit_completion_date) last_unit_completion_date,
pha.segment1 po_number,
xxen_util.client_time(plla.need_by_date) need_by_date,
xxen_util.client_time(plla.promised_date) promised_date,
&component_columns
y.plan,
y.organization_code,
y.resource_id,
y.assembly_item_id,
y.wip_entity_id,
&transaction_id
y.organization_id
from
(
select
x.order_number,
bd.department_code,
bd.description department_description,
br.resource_code,
br.description resource_description,
(select xxen_util.calendar_date_offset(crp.resource_date,mp.calendar_code,rowgen.column_value-1) from dual) resource_date,
crp.daily_resource_hours resource_hours,
crp.resource_date start_date,
crp.resource_end_date end_date,
crp.resource_hours total_hours,
xxen_util.meaning(mr.order_type,'MRP_ORDER_TYPE',700) supply_type,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
we.wip_entity_name job_number,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) job_status,
wsg.schedule_group_name schedule_group,
wdj.start_quantity,
crp.operation_seq_num,
crp.resource_seq_num,
mr.daily_rate,
mr.new_order_quantity schedule_quantity,
mr.new_schedule_date schedule_date,
xxen_util.meaning(mr.firm_planned_type,'SYS_YES_NO',700) firm,
crp.designator plan,
mp.organization_code,
crp.resource_id,
crp.assembly_item_id,
we.wip_entity_id,
we.organization_id,
crp.transaction_id,
rowgen.column_value date_sequence
from
crp_resource_plan crp,
table(xxen_util.rowgen(crp.resource_hours/xxen_util.zero_to_null(crp.daily_resource_hours))) rowgen,
bom_departments bd,
bom_resources br,
mtl_parameters mp,
mtl_system_items_vl msiv,
mrp_recommendations mr,
wip_entities we,
wip_discrete_jobs wdj,
wip_schedule_groups wsg,
(
select distinct
mfp.transaction_id,
listagg(mfp.order_number,', ') within group (order by mfp.order_number) over (partition by mfp.transaction_id) order_number
from
(
select distinct
mfp.transaction_id,
ooha.order_number,
count(distinct ooha.order_number) over (partition by mfp.transaction_id) order_count
from
mrp_full_pegging mfp,
mrp_full_pegging mfp0,
mrp_gross_requirements mgr,
oe_order_lines_all oola,
oe_order_headers_all ooha
where
2=2 and
mfp.end_pegging_id=mfp0.pegging_id and
mfp0.demand_id=mgr.demand_id and
mgr.origination_type=6 and
mgr.reservation_id=oola.line_id and
oola.header_id=ooha.header_id
) mfp
where
mfp.order_count<440
) x
where
1=1 and
crp.repetitive_type=1 and
crp.department_id=bd.department_id and
crp.resource_id=br.resource_id and
crp.organization_id=mp.organization_id and
crp.organization_id=msiv.organization_id and
crp.assembly_item_id=msiv.inventory_item_id and
crp.source_transaction_id=mr.transaction_id and
case when mr.order_type in (3,7,14,15,27,28) then mr.disposition_id end=we.wip_entity_id(+) and
we.wip_entity_id=wdj.wip_entity_id(+) and
we.organization_id=wdj.organization_id(+) and
wdj.schedule_group_id=wsg.schedule_group_id(+) and
crp.source_transaction_id=x.transaction_id(+)
) y,
wip_operations wo,
(select row_number() over (partition by wro.wip_entity_id, wro.operation_seq_num, wro.organization_id order by wro.inventory_item_id) row_number, wro.* from wip_requirement_operations wro where '&enable_wro'='Y' and wro.wip_supply_type<>6) wro,
mtl_system_items_vl msiv2,
mtl_units_of_measure_tl muot,
mtl_item_locations_kfv milk,
(
select
sum(moqd.primary_transaction_quantity) on_hand,
moqd.organization_id,
moqd.inventory_item_id
from
mtl_onhand_quantities_detail moqd,
mtl_secondary_inventories msi
where
moqd.subinventory_code=msi.secondary_inventory_name and
moqd.organization_id=msi.organization_id and
msi.availability_type=1
group by
moqd.organization_id,
moqd.inventory_item_id
) moqd,
(
select distinct
pda.wip_entity_id,
pda.wip_operation_seq_num,
pda.destination_organization_id,
max(pda.line_location_id) keep (dense_rank last order by pda.po_distribution_id) over (partition by pda.wip_entity_id, pda.wip_operation_seq_num, pda.destination_organization_id) line_location_id,
max(pda.po_line_id) keep (dense_rank last order by pda.po_distribution_id) over (partition by pda.wip_entity_id, pda.wip_operation_seq_num, pda.destination_organization_id) po_line_id,
max(pda.po_header_id) keep (dense_rank last order by pda.po_distribution_id) over (partition by pda.wip_entity_id, pda.wip_operation_seq_num, pda.destination_organization_id) po_header_id
from
po_distributions_all pda
) pda,
po_lines_all pla,
po_line_locations_all plla,
po_headers_all pha
where
3=3 and
y.wip_entity_id=wo.wip_entity_id(+) and
y.operation_seq_num=wo.operation_seq_num(+) and
y.organization_id=wo.organization_id(+) and
y.wip_entity_id=wro.wip_entity_id(+) and
y.operation_seq_num=wro.operation_seq_num(+) and
y.organization_id=wro.organization_id(+) and
wro.organization_id=msiv2.organization_id(+) and
wro.inventory_item_id=msiv2.inventory_item_id(+) and
msiv2.primary_uom_code=muot.uom_code(+) and
muot.language(+)=userenv('lang') and
wro.supply_locator_id=milk.inventory_location_id(+) and
wro.organization_id=milk.organization_id(+) and
wro.inventory_item_id=moqd.inventory_item_id(+) and
wro.organization_id=moqd.organization_id(+) and
y.wip_entity_id=pda.wip_entity_id(+) and
y.operation_seq_num=pda.wip_operation_seq_num(+) and
y.organization_id=pda.destination_organization_id(+) and
pda.line_location_id=plla.line_location_id(+) and
pda.po_line_id=pla.po_line_id(+) and
pda.po_header_id=pha.po_header_id(+)
order by
y.organization_code,
y.plan,
y.department_code,
y.resource_code,
y.resource_date,
y.operation_seq_num
&component_order_by