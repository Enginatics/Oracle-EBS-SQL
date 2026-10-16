/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM PM Schedule Upload
-- Description: EAM Preventive Maintenance Schedule Upload
-- =========================================
-- Create or update Oracle EAM Preventive Maintenance schedule definitions, including:
-- - PM Schedule header (asset or asset group, activity, schedule name, set name, type, rescheduling point, etc.)
-- - Activity group (for Rule Based schedules: list of activities with interval multiples)
-- - Scheduling rules: Day Interval, Runtime / Meter, and List Date rules
-- - Optional Last Service info (per meter)
-- Row Model
-- =========
-- Each spreadsheet row can contain PM header values plus any populated child-object columns. The upload infers the object levels from populated column groups:
-- - Header columns identify and define the PM schedule.
-- - Act Activity columns add PM activity-group entries. If no Act Activity is entered for a new Rule Based schedule, the header Activity is used as the first activity entry.
-- - Rule columns add Day Interval, Runtime Meter, or List Date scheduling rules.
-- - LSI columns add optional last-service readings.
-- Act Last Svc Start and Act Last Svc End show the last service dates that work order completion records on the activity association. They are read-only and not uploaded.
-- The upload saves schedules, activities and rules as the Preventive Maintenance form does: a changed rule is updated in place, Delete Rule removes it, and a rule row without a rule id is added. Rule Last Service Reading is derived from the last service information on save and is read-only.
-- Rows belonging to the same PM must repeat the same Organization Code + Schedule Name + Asset + Activity and remain contiguous. The header is processed once per PM; repeated rows are used for additional activities, rules, and last-service readings.
-- Upload Modes
-- ============
-- Create - empty spreadsheet for new PM schedules.
-- Create, Update - downloads existing PM schedules for review/edit and allows adding new ones.
-- IMPORTANT on Update
-- -------------------
-- In Create, Update mode, use Update Activities / Update Rules / Update Last Service to include those child details in the downloaded template. Update Activities defaults to Yes; the other child sections are optional.
-- PM Set Name
-- ===========
-- - Reference an existing Set Name, or
-- - Enter a new Set Name together with Set Name Description / End Date / Local Flag; the upload will auto-create it via EAMSetNamePUB.
-- After Upload
-- ============
-- Schedule and run the "XMLSG - Create Preventive Maintenance Work Order" concurrent program - uploading a PM schedule alone does not generate work orders.
-- Excel Example Output: https://www.enginatics.com/example/eam-pm-schedule-upload/
-- Library Link: https://www.enginatics.com/reports/eam-pm-schedule-upload/
-- Run Report: https://demo.enginatics.com/

with q_base as (
select
eps.pm_schedule_id,
mp.organization_code,
mp.organization_id,
eps.name schedule_name,
xxen_util.meaning(to_char(nvl(msibk_asset.eam_item_type,msibk_group.eam_item_type)),'MTL_EAM_ASSET_TYPE',700) asset_type,
case when eps.maintenance_object_type=3 then cii.instance_number end asset_number,
nvl(msibk_asset.concatenated_segments,msibk_group.concatenated_segments) asset_group,
nvl(msibk_asset.inventory_item_id,msibk_group.inventory_item_id) asset_group_id,
msibk_act.concatenated_segments activity,
eps.pm_activity_association_id activity_id,
epsn.set_name,
to_char(null) set_name_description,
to_date(null) set_name_end_date,
to_char(null) set_name_local_flag,
decode(eps.type_code,10,'Rule Based',17,'Day Interval',20,'List Dates',xxen_util.meaning(to_char(eps.type_code),'EAM_PM_TYPE',700)) schedule_type,
eps.type_code schedule_type_code,
eps.from_effective_date effective_from,
eps.to_effective_date effective_to,
eps.lead_time lead_time_in_days,
ewsv.work_order_status,
ewsv.status_id work_order_status_id,
xxen_util.meaning(eps.generate_next_work_order,'YES_NO',0) next_wo_only,
eps.generate_next_work_order generate_next_wo,
eps.day_tolerance,
decode(eps.rescheduling_point,1,'Actual Start Date',2,'Actual End Date',3,'Scheduled Start Date',4,'Scheduled End Date',5,'Base Date',6,'Base Meter Reading') use,
eps.rescheduling_point,
eps.base_date,
eps.base_reading,
decode(eps.scheduling_method_code,10,'Start Date',20,'End Date',xxen_util.meaning(to_char(eps.scheduling_method_code),'EAM_PM_SCHEDULING_METHOD',700)) suggest_next_service,
eps.scheduling_method_code scheduling_method,
decode(eps.whichever_first,'Y','First','N','Last') use_date_that_comes,
eps.whichever_first,
eps.interval_per_cycle intervals_per_cycle,
xxen_util.meaning(eps.include_manual,'YES_NO',0) reschedule_manual_work_orders,
eps.include_manual,
xxen_util.meaning(eps.non_scheduled_flag,'YES_NO',0) run_to_failure,
eps.non_scheduled_flag,
xxen_util.meaning(eps.default_implement,'YES_NO',0) default_schedule,
eps.default_implement,
xxen_util.meaning(eps.auto_instantiation_flag,'YES_NO',0) automatic_instantiation,
eps.auto_instantiation_flag auto_instantiation
from
(
select
eps.*,
nvl(eps.activity_association_id,(select min(epa.activity_association_id) from eam_pm_activities epa where eps.pm_schedule_id=epa.pm_schedule_id)) pm_activity_association_id
from
eam_pm_schedulings eps
) eps
left join csi_item_instances cii on eps.maintenance_object_type=3 and eps.maintenance_object_id=cii.instance_id and sysdate between nvl(cii.active_start_date,sysdate) and nvl(cii.active_end_date,sysdate)
left join mtl_eam_asset_activities mea on eps.pm_activity_association_id=mea.activity_association_id
left join mtl_system_items_b_kfv msibk_act on mea.asset_activity_id=msibk_act.inventory_item_id and mea.organization_id=msibk_act.organization_id
left join mtl_system_items_b_kfv msibk_asset on cii.inventory_item_id=msibk_asset.inventory_item_id and cii.last_vld_organization_id=msibk_asset.organization_id
left join mtl_system_items_b_kfv msibk_group on eps.maintenance_object_type=2 and eps.maintenance_object_id=msibk_group.inventory_item_id and mea.organization_id=msibk_group.organization_id
join mtl_parameters mp on mp.organization_id=nvl(cii.last_vld_organization_id,mea.organization_id)
left join eam_pm_set_names epsn on eps.set_name_id=epsn.set_name_id
left join eam_wo_statuses_v ewsv on ewsv.status_id=eps.generate_wo_status
where
nvl(eps.tmpl_flag,'N')='N' and
mp.eam_enabled_flag='Y' and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
)
select
null action_,
null status_,
null message_,
null modified_columns_,
row_number() over (order by x.organization_code,x.schedule_name,x.pm_schedule_id,x.row_sort,x.child_sort) upload_row,
x.organization_code,
x.organization_id,
x.schedule_name,
x.asset_type,
x.asset_number,
x.asset_group,
x.asset_group_id,
x.activity,
x.activity_id,
x.set_name,
x.set_name_description,
x.set_name_end_date,
x.set_name_local_flag,
x.schedule_type,
x.schedule_type_code,
x.effective_from,
x.effective_to,
x.lead_time_in_days,
x.work_order_status,
x.work_order_status_id,
x.next_wo_only,
x.generate_next_wo,
x.day_tolerance,
x.use,
x.rescheduling_point,
x.base_date,
x.base_reading,
x.suggest_next_service,
x.scheduling_method,
x.use_date_that_comes,
x.whichever_first,
x.intervals_per_cycle,
x.reschedule_manual_work_orders,
x.include_manual,
x.run_to_failure,
x.non_scheduled_flag,
x.default_schedule,
x.default_implement,
x.automatic_instantiation,
x.auto_instantiation,
x.act_activity,
x.act_activity_id,
x.act_interval_multiple,
x.act_allow_repeat,
x.act_day_tolerance,
x.act_next_svc_start,
x.act_next_svc_end,
x.act_last_svc_start,
x.act_last_svc_end,
x.rule_type_dsp,
x.rule_type,
x.rule_day_interval,
x.rule_meter,
x.rule_meter_id,
x.rule_runtime_interval,
x.rule_last_service_reading,
x.rule_effective_reading_from,
x.rule_effective_reading_to,
x.rule_effective_date_from,
x.rule_effective_date_to,
x.rule_list_date,
x.rule_list_date_desc,
x.rule_base_date,
x.delete_rule,
x.rule_id,
x.lsi_meter,
x.lsi_meter_id,
x.lsi_last_service_reading,
x.lsi_prev_service_reading,
x.lsi_wip_job,
x.lsi_wip_entity_id
from
(
select
qb.*,
to_char(null) act_activity,
to_number(null) act_activity_id,
to_number(null) act_interval_multiple,
to_char(null) act_allow_repeat,
to_number(null) act_day_tolerance,
to_date(null) act_next_svc_start,
to_date(null) act_next_svc_end,
to_date(null) act_last_svc_start,
to_date(null) act_last_svc_end,
to_char(null) rule_type_dsp,
to_number(null) rule_type,
to_number(null) rule_day_interval,
to_char(null) rule_meter,
to_number(null) rule_meter_id,
to_number(null) rule_runtime_interval,
to_number(null) rule_last_service_reading,
to_number(null) rule_effective_reading_from,
to_number(null) rule_effective_reading_to,
to_date(null) rule_effective_date_from,
to_date(null) rule_effective_date_to,
to_date(null) rule_list_date,
to_char(null) rule_list_date_desc,
to_date(null) rule_base_date,
to_char(null) delete_rule,
to_number(null) rule_id,
to_char(null) lsi_meter,
to_number(null) lsi_meter_id,
to_number(null) lsi_last_service_reading,
to_number(null) lsi_prev_service_reading,
to_char(null) lsi_wip_job,
to_number(null) lsi_wip_entity_id,
0 row_sort,
0 child_sort
from
q_base qb
union all
select
qb.*,
msibk_act.concatenated_segments act_activity,
epa.activity_association_id act_activity_id,
epa.interval_multiple act_interval_multiple,
xxen_util.meaning(epa.allow_repeat_in_cycle,'YES_NO',0) act_allow_repeat,
epa.day_tolerance act_day_tolerance,
epa.next_service_start_date act_next_svc_start,
epa.next_service_end_date act_next_svc_end,
mea.last_service_start_date act_last_svc_start,
mea.last_service_end_date act_last_svc_end,
to_char(null) rule_type_dsp,
to_number(null) rule_type,
to_number(null) rule_day_interval,
to_char(null) rule_meter,
to_number(null) rule_meter_id,
to_number(null) rule_runtime_interval,
to_number(null) rule_last_service_reading,
to_number(null) rule_effective_reading_from,
to_number(null) rule_effective_reading_to,
to_date(null) rule_effective_date_from,
to_date(null) rule_effective_date_to,
to_date(null) rule_list_date,
to_char(null) rule_list_date_desc,
to_date(null) rule_base_date,
to_char(null) delete_rule,
to_number(null) rule_id,
to_char(null) lsi_meter,
to_number(null) lsi_meter_id,
to_number(null) lsi_last_service_reading,
to_number(null) lsi_prev_service_reading,
to_char(null) lsi_wip_job,
to_number(null) lsi_wip_entity_id,
1 row_sort,
epa.activity_association_id child_sort
from
q_base qb,
eam_pm_activities epa,
mtl_eam_asset_activities mea,
mtl_system_items_b_kfv msibk_act
where
qb.pm_schedule_id=epa.pm_schedule_id and
epa.activity_association_id=mea.activity_association_id and
mea.asset_activity_id=msibk_act.inventory_item_id and
mea.organization_id=msibk_act.organization_id and
:p_update_activities='Y'
union all
select
qb.*,
to_char(null) act_activity,
to_number(null) act_activity_id,
to_number(null) act_interval_multiple,
to_char(null) act_allow_repeat,
to_number(null) act_day_tolerance,
to_date(null) act_next_svc_start,
to_date(null) act_next_svc_end,
to_date(null) act_last_svc_start,
to_date(null) act_last_svc_end,
decode(epsr.rule_type,1,'Day Interval',2,'Runtime Meter',3,'List Date') rule_type_dsp,
epsr.rule_type,
epsr.day_interval rule_day_interval,
ccv.name rule_meter,
epsr.meter_id rule_meter_id,
epsr.runtime_interval rule_runtime_interval,
epsr.last_service_reading rule_last_service_reading,
epsr.effective_reading_from rule_effective_reading_from,
epsr.effective_reading_to rule_effective_reading_to,
epsr.effective_date_from rule_effective_date_from,
epsr.effective_date_to rule_effective_date_to,
epsr.list_date rule_list_date,
epsr.list_date_desc rule_list_date_desc,
epsr.base_date rule_base_date,
to_char(null) delete_rule,
epsr.rule_id,
to_char(null) lsi_meter,
to_number(null) lsi_meter_id,
to_number(null) lsi_last_service_reading,
to_number(null) lsi_prev_service_reading,
to_char(null) lsi_wip_job,
to_number(null) lsi_wip_entity_id,
2 row_sort,
epsr.rule_id child_sort
from
q_base qb,
eam_pm_scheduling_rules epsr,
csi_counters_vl ccv
where
qb.pm_schedule_id=epsr.pm_schedule_id and
epsr.meter_id=ccv.counter_id(+) and
:p_update_rules='Y'
union all
select
qb.*,
to_char(null) act_activity,
to_number(null) act_activity_id,
to_number(null) act_interval_multiple,
to_char(null) act_allow_repeat,
to_number(null) act_day_tolerance,
to_date(null) act_next_svc_start,
to_date(null) act_next_svc_end,
to_date(null) act_last_svc_start,
to_date(null) act_last_svc_end,
to_char(null) rule_type_dsp,
to_number(null) rule_type,
to_number(null) rule_day_interval,
to_char(null) rule_meter,
to_number(null) rule_meter_id,
to_number(null) rule_runtime_interval,
to_number(null) rule_last_service_reading,
to_number(null) rule_effective_reading_from,
to_number(null) rule_effective_reading_to,
to_date(null) rule_effective_date_from,
to_date(null) rule_effective_date_to,
to_date(null) rule_list_date,
to_char(null) rule_list_date_desc,
to_date(null) rule_base_date,
to_char(null) delete_rule,
to_number(null) rule_id,
ccv.name lsi_meter,
epls.meter_id lsi_meter_id,
epls.last_service_reading lsi_last_service_reading,
epls.prev_service_reading lsi_prev_service_reading,
we.wip_entity_name lsi_wip_job,
epls.wip_entity_id lsi_wip_entity_id,
3 row_sort,
epls.meter_id child_sort
from
q_base qb,
eam_pm_last_service epls,
csi_counters_vl ccv,
wip_entities we
where
qb.activity_id=epls.activity_association_id and
epls.meter_id=ccv.counter_id(+) and
epls.wip_entity_id=we.wip_entity_id(+) and
:p_update_last_service='Y'
) x
where
1=1
