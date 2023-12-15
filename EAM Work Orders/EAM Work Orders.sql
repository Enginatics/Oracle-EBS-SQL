/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM Work Orders
-- Description: Enterprise asset management work orders including asset and cost information
-- Excel Examle Output: https://www.enginatics.com/example/eam-work-orders/
-- Library Link: https://www.enginatics.com/reports/eam-work-orders/
-- Run Report: https://demo.enginatics.com/

select
wdj.organization_code,
wdj.wip_entity_name work_order,
cii.instance_number asset_number,
cii.instance_description,
msibk.concatenated_segments asset_group,
xxen_util.meaning(msibk.eam_item_type,'MTL_EAM_ASSET_TYPE',700) asset_type,
mcbk.concatenated_segments item_category,
bd.department_code department,
bd.description department_description,
mel.location_codes eam_location,
--cii.serial_number,
wdj.description work_order_description,
xxen_util.client_time(wdj.scheduled_start_date) scheduled_start_date,
xxen_util.client_time(wdj.scheduled_completion_date) scheduled_completion_date,
round((wdj.scheduled_completion_date-wdj.scheduled_start_date)*24,3) duration,
decode(ewod.pending_flag,'Y',ewsv.work_order_status||' - '||fnd_message.get_string('EAM','EAM_PENDING_TEXT'),ewsv.work_order_status) work_order_status,
&planner_maintenance
--xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) status,
xxen_util.user_name(wdj.created_by) created_by,
xxen_util.client_time(wdj.creation_date) creation_date,
xxen_util.user_name(wdj.last_updated_by) last_updated_by,
xxen_util.client_time(wdj.last_update_date) last_update_date,
xxen_util.meaning(wdj.shutdown_type,'BOM_EAM_SHUTDOWN_TYPE',700) shutdown_type,
xxen_util.meaning(wdj.priority,'WIP_EAM_ACTIVITY_PRIORITY',700) priority,
decode(ewod.pending_flag,'Y','Disabled',decode(wdj.status_type,3,'Complete',4,'Uncomplete','Disabled')) action_code,
ppa.segment1 project_number,
pt.task_number,
wdj.class_code,
eps.name pm_schedule_name,
xxen_util.meaning(wdj.work_order_type,'WIP_EAM_WORK_ORDER_TYPE',700) work_order_type,
xxen_util.meaning(wdj.activity_type,'MTL_EAM_ACTIVITY_TYPE',700) activity_type,
xxen_util.meaning(wdj.activity_cause,'MTL_EAM_ACTIVITY_CAUSE',700) activity_cause,
xxen_util.meaning(wdj.activity_source,'MTL_EAM_ACTIVITY_SOURCE',700) activity_source,
(select msibk.concatenated_segments from mtl_system_items_b_kfv msibk where wdj.primary_item_id=msibk.inventory_item_id and rownum=1) activity_name,
decode(efv.failure_code_required,'Y','Y') failure_code_required,
efv.failure_description failure,
efv.cause_description cause,
efv.resolution_description resolution,
efv.failure_date,
efv.comments,
efv.set_name failure_set,
nvl(wepb.actual_cost,0) actual_cost,
nvl(wepb.estimated_cost,0) estimated_cost,
nvl(wepb.variance_cost,0) variance_cost,
nvl(wepb.cumulative_actual_cost,0) cumulative_actual_cost,
nvl(wepb.cumulative_estimated_cost,0) cumulative_estimated_cost,
nvl(wepb.cumulative_variance_cost,0) cumulative_variance_cost,
xxen_util.meaning(nvl(wdj.estimation_status,1),'CST_EAM_ESTIMATION_STATUS',700) estimation_status,
(select ecm.estimate_number from eam_construction_estimates ecm where ewod.estimate_id=ecm.estimate_id and rownum=1) estimate_number,
&columns
nvl(sum(wecdv.actual_total_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) total_cost,
nvl(sum(wecdv.actual_material_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) material_cost,
nvl(sum(wecdv.actual_labor_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) labor_cost,
nvl(sum(wecdv.actual_equipment_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) equipment_cost,
nvl(sum(wecdv.estimated_total_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) estimated_total_cost,
nvl(sum(wecdv.estimated_material_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) estimated_material_cost,
nvl(sum(wecdv.estimated_labor_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) estimated_labor_cost,
nvl(sum(wecdv.estimated_equipment_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) estimated_equipment_cost,
nvl(sum(wecdv.variance_total_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) variance_total_cost,
nvl(sum(wecdv.variance_material_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) variance_material_cost,
nvl(sum(wecdv.variance_labor_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) variance_labor_cost,
nvl(sum(wecdv.variance_equipment_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) variance_equipment_cost,
wdj.wip_entity_id
--ewod.cycle_id,
--ewod.seq_id,
from
(
select
mp.organization_code,
we.wip_entity_name,
mp.maint_organization_id,
wdj.*
from
mtl_parameters mp,
wip_entities we,
wip_discrete_jobs wdj
where
1=1 and
wdj.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
wdj.status_type not in (7,5,12,14,15) and
mp.organization_id=we.organization_id and
we.entity_type in (6,7) and
wdj.maintenance_object_source<>2 and
we.wip_entity_id=wdj.wip_entity_id and
we.organization_id=wdj.organization_id
) wdj,
mtl_system_items_b_kfv msibk,
bom_departments bd,
pa_projects_all ppa,
pa_tasks pt,
eam_work_order_details ewod,
eam_wo_statuses_v ewsv,
eam_pm_schedulings eps,
eam_org_maint_defaults eomd,
mtl_eam_locations mel,
(select cii.* from csi_item_instances cii where sysdate between nvl(cii.active_start_date,sysdate) and nvl(cii.active_end_date,sysdate)) cii,
mtl_categories_b_kfv mcbk,
eam_failureinfo_v efv,
(
select
wepb.organization_id,
wepb.wip_entity_id,
nvl(sum(wepb.actual_mat_cost)+sum(wepb.actual_lab_cost)+sum(wepb.actual_eqp_cost),0) actual_cost,
nvl(sum(wepb.system_estimated_mat_cost)+sum(wepb.system_estimated_lab_cost)+sum(wepb.system_estimated_eqp_cost),0) estimated_cost,
nvl(-sum(wepb.actual_mat_cost)-sum(wepb.actual_lab_cost)-sum(wepb.actual_eqp_cost)+sum(wepb.system_estimated_mat_cost)+sum(wepb.system_estimated_lab_cost)+sum(wepb.system_estimated_eqp_cost),0) variance_cost,
nvl(sum(wepb.actual_mat_cost )+sum(wepb.actual_lab_cost)+sum(wepb.actual_eqp_cost),nvl(sum(wepb.actual_mat_cost)+sum(wepb.actual_lab_cost)+sum(wepb.actual_eqp_cost),0)) cumulative_actual_cost,
nvl(sum(wepb.system_estimated_mat_cost)+sum(wepb.system_estimated_lab_cost)+sum(wepb.system_estimated_eqp_cost),nvl(sum(wepb.system_estimated_mat_cost)+sum(wepb.system_estimated_lab_cost)+sum(wepb.system_estimated_eqp_cost),0)) cumulative_estimated_cost,
nvl(-sum(wepb.actual_mat_cost)-sum(wepb.actual_lab_cost)-sum(wepb.actual_eqp_cost)+sum(wepb.system_estimated_mat_cost)+sum(wepb.system_estimated_lab_cost)+sum(wepb.system_estimated_eqp_cost),nvl(-sum(wepb.actual_mat_cost)-sum(wepb.actual_lab_cost)-sum(wepb.actual_eqp_cost)+sum(wepb.system_estimated_mat_cost)+sum(wepb.system_estimated_lab_cost)+sum(wepb.system_estimated_eqp_cost),0)) cumulative_variance_cost
from
wip_eam_period_balances wepb
where
(wepb.period_name,wepb.period_set_name) in
(
select
period_name,
to_char(null) period_set_name
from
org_acct_periods oap
where
2=2
union all
select
gp.period_name,
gp.period_set_name
from
gl_periods gp
where
3=3 and
gp.adjustment_period_flag='N'
)
group by
wepb.organization_id,
wepb.wip_entity_id
) wepb,
(
select distinct
wecdv.organization_id,
wecdv.wip_entity_id,
&columns
nvl(sum(wecdv.actual_total_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) actual_total_cost,
nvl(sum(wecdv.actual_material_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) actual_material_cost,
nvl(sum(wecdv.actual_labor_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) actual_labor_cost,
nvl(sum(wecdv.actual_equipment_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) actual_equipment_cost,
nvl(sum(wecdv.estimated_total_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) estimated_total_cost,
nvl(sum(wecdv.estimated_material_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) estimated_material_cost,
nvl(sum(wecdv.estimated_labor_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) estimated_labor_cost,
nvl(sum(wecdv.estimated_equipment_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) estimated_equipment_cost,
nvl(sum(wecdv.variance_total_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) variance_total_cost,
nvl(sum(wecdv.variance_material_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) variance_material_cost,
nvl(sum(wecdv.variance_labor_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) variance_labor_cost,
nvl(sum(wecdv.variance_equipment_cost) over (partition by wecdv.organization_id, wecdv.wip_entity_id &partition_by),0) variance_equipment_cost
from
wip_eam_cost_details_v wecdv
where
(wecdv.period_set_name, wecdv.period_name) in
(
select
to_char(null) period_set_name,
period_name
from
org_acct_periods oap
where
2=2
union all
select
gp.period_set_name,
gp.period_name
from
gl_periods gp
where
3=3 and
gp.adjustment_period_flag='N'
)
) wecdv
where
4=4 and
nvl(wdj.asset_group_id,wdj.rebuild_item_id)=msibk.inventory_item_id(+) and
wdj.organization_id=msibk.organization_id(+) and
wdj.owning_department=bd.department_id(+) and
wdj.project_id=ppa.project_id(+) and
wdj.task_id=pt.task_id(+) and
wdj.wip_entity_id=ewod.wip_entity_id and
wdj.organization_id=ewod.organization_id and
ewsv.status_id=ewod.user_defined_status_id(+) and
wdj.pm_schedule_id=eps.pm_schedule_id(+) and
decode(wdj.maintenance_object_type,3,wdj.maintenance_object_id,null)=eomd.object_id(+) and
wdj.maint_organization_id=eomd.organization_id(+) and
eomd.object_type(+)=50 and
eomd.area_id=mel.location_id(+) and
decode(wdj.maintenance_object_type,3,wdj.maintenance_object_id,null)=cii.instance_id(+) and
cii.category_id=mcbk.category_id(+) and
wdj.wip_entity_id=efv.wip_entity_id(+) and
wdj.organization_id=wepb.organization_id(+) and
wdj.wip_entity_id=wepb.wip_entity_id(+) and
wdj.organization_id=wecdv.organization_id(+) and
wdj.wip_entity_id=wecdv.wip_entity_id(+)
order by
wdj.organization_code,
wdj.scheduled_start_date desc,
wdj.wip_entity_name