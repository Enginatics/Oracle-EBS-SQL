/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Entities
-- Description: WIP Jobs
-- Excel Examle Output: https://www.enginatics.com/example/wip-entities
-- Library Link: https://www.enginatics.com/reports/wip-entities
-- Run Report: https://demo.enginatics.com/


select
we.wip_entity_name job,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) type,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) status,
msiv.planner_code,
mpl.description planner,
wsg.schedule_group_name schedule_group,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.mrp_planning_code,'MRP_PLANNING_CODE',700) planning_method,
xxen_util.meaning(msiv.end_assembly_pegging_flag,'ASSEMBLY_PEGGING_CODE',0) pegging,
we.description entity_description,
wdj.description job_description,
ppa.project_number,
pt.task_number,
wdj.source_code,
wdj.source_line_id,
xxen_util.meaning(wdj.firm_planned_flag,'SYS_YES_NO',700) firm,
xxen_util.meaning(wdj.job_type,'WIP_DISCRETE_JOB',700) job_type,
xxen_util.meaning(wdj.wip_supply_type,'WIP_SUPPLY',700) wip_supply_type,
wdj.class_code,
xxen_util.client_time(wdj.scheduled_start_date) scheduled_start_date,
xxen_util.client_time(wdj.scheduled_completion_date) scheduled_completion_date,
wdj.start_quantity,
decode(wdj.quantity_scrapped,0,null,wdj.quantity_scrapped) quantity_scrapped,
decode(wdj.quantity_completed,0,null,wdj.quantity_completed) quantity_completed,
decode(wdj.start_quantity-wdj.quantity_completed-wdj.quantity_scrapped,0,null,wdj.start_quantity-wdj.quantity_completed-wdj.quantity_scrapped) quantity_remaining,
wdj.completion_subinventory,
bd.department_code,
wo.operation_seq_num operation_sequence,
bso.operation_code,
wo.description operation_description,
br.resource_code,
br.description resource_description,
xxen_util.client_time(wo.date_last_moved) date_last_moved,
wo.in_queue,
wo.running,
wo.to_move,
wo.rejected,
wo.scrapped,
wo.completed,
xxen_util.client_time(wo.first_unit_start_date) first_unit_start_date,
xxen_util.client_time(wo.last_unit_completion_date) last_unit_completion_date,
xxen_util.user_name(wo.last_updated_by) operation_last_updated_by,
haou.name organization,
mp.organization_code,
xxen_util.user_name(we.created_by) created_by,
xxen_util.client_time(we.creation_date) creation_date,
we.wip_entity_id
from
hr_all_organization_units haou,
mtl_parameters mp,
wip_entities we,
mtl_system_items_vl msiv,
mtl_planners mpl,
wip_discrete_jobs wdj,
wip_schedule_groups wsg,
(
select ppa.project_id, ppa.segment1 project_number from pa_projects_all ppa union
select psm.project_id, psm.project_number from pjm_seiban_numbers psm
) ppa,
&xrrpv_table
pa_tasks pt,
(
select distinct
wo.wip_entity_id,
wo.organization_id,
wo.repetitive_schedule_id,
min(wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) operation_seq_num,
max(wo.department_id) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) department_id,
max(wo.standard_operation_id) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) standard_operation_id,
max(wo.description) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) description,
max(wo.date_last_moved) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) date_last_moved,
max(decode(wo.quantity_in_queue,0,null,wo.quantity_in_queue)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) in_queue,
max(decode(wo.quantity_running,0,null,wo.quantity_running)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) running,
max(decode(wo.quantity_waiting_to_move,0,null,wo.quantity_waiting_to_move)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) to_move,
max(decode(wo.quantity_rejected,0,null,wo.quantity_rejected)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) rejected,
max(decode(wo.quantity_scrapped,0,null,wo.quantity_scrapped)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) scrapped,
max(decode(wo.quantity_completed,0,null,wo.quantity_completed)) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) completed,
max(wo.first_unit_start_date) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) first_unit_start_date,
max(wo.last_unit_completion_date) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) last_unit_completion_date,
max(wo.last_updated_by) keep (dense_rank first order by wo.operation_seq_num) over (partition by wo.wip_entity_id, wo.organization_id, wo.repetitive_schedule_id) last_updated_by
from
wip_operations wo
where
wo.quantity_in_queue>0 or wo.quantity_running>0 or wo.quantity_waiting_to_move>0
) wo,
bom_departments bd,
(select bso.* from bom_standard_operations bso where nvl(bso.operation_type,1)=1 and bso.line_id is null) bso,
(
select distinct
wor.organization_id,
wor.wip_entity_id,
wor.operation_seq_num,
max(wor.resource_id) keep (dense_rank first order by wor.resource_seq_num) over (partition by wor.wip_entity_id, wor.organization_id, wor.operation_seq_num, wor.repetitive_schedule_id) resource_id
from
wip_operation_resources wor
) wor,
bom_resources br
where
1=1 and
haou.organization_id=mp.organization_id and
mp.organization_id=we.organization_id and
we.primary_item_id=msiv.inventory_item_id(+) and
we.organization_id=msiv.organization_id(+) and
msiv.planner_code=mpl.planner_code(+) and
msiv.organization_id=mpl.organization_id(+) and
we.wip_entity_id=wdj.wip_entity_id(+) and
we.organization_id=wdj.organization_id(+) and
wdj.schedule_group_id=wsg.schedule_group_id(+) and
wdj.project_id=ppa.project_id(+) and
wdj.task_id=pt.task_id(+) and
wdj.wip_entity_id=wo.wip_entity_id(+) and
wdj.organization_id=wo.organization_id(+) and
wo.department_id=bd.department_id(+) and
wo.standard_operation_id=bso.standard_operation_id(+) and
wo.wip_entity_id=wor.wip_entity_id(+) and
wo.organization_id=wor.organization_id(+) and
wo.operation_seq_num=wor.operation_seq_num(+) and
wor.resource_id=br.resource_id(+)
order by
we.creation_date desc