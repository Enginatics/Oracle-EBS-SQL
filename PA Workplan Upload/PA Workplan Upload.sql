/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Workplan Upload
-- Description: Creates, updates and deletes the resource assignments of workplan tasks as on the Projects HTML workplan pages (Workplan > Tasks > Task Assignments), using pataskassignmentspub.
-- The assignments are maintained on the current working workplan version, or on the published version when workplan versioning is disabled for the project. Planning resources come from the resource list of the workplan plan type. Planned cost of a rate based resource is calculated from the planned quantity.
-- The resource of an existing assignment cannot be changed: delete the assignment and create a new one. Publish Workplan publishes the workplan version once all rows of the project uploaded successfully.
-- Excel Example Output: https://www.enginatics.com/example/pa-workplan-upload/
-- Library Link: https://www.enginatics.com/reports/pa-workplan-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
pfptv.name plan_type,
ppevs.name workplan_version,
ppe.element_number task_number,
ppe.name task_name,
prlm.alias planning_resource,
prcv.name resource_class,
pra.assignment_description,
pra.total_plan_quantity planned_quantity,
xxen_util.meaning(pra.unit_of_measure,'UNIT',275) unit_of_measure,
pra.total_plan_raw_cost planned_raw_cost,
pra.total_plan_burdened_cost planned_burdened_cost,
xxen_util.yes(pra.use_task_schedule_flag) use_task_schedule,
pra.planning_start_date start_date,
pra.planning_end_date end_date,
null delete_assignment,
null publish_workplan,
null publish_message_,
pra.resource_assignment_id task_assignment_id,
to_number(null) upload_row
from
hr_all_organization_units_vl haouv,
pa_projects_all ppa,
pa_budget_versions pbv,
pa_proj_elem_ver_structure ppevs,
pa_fin_plan_types_vl pfptv,
pa_resource_assignments pra,
pa_proj_elements ppe,
pa_resource_list_members prlm,
pa_resource_classes_vl prcv
where
1=1 and
:p_upload_mode like '%'||xxen_upload.action_update and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
haouv.organization_id=ppa.org_id and
nvl(ppa.template_flag,'N')='N' and
ppa.project_id=pbv.project_id and
pbv.wp_version_flag='Y' and
pbv.project_structure_version_id=xxen_pa_upload.workplan_version_id(ppa.project_id) and
pbv.project_id=ppevs.project_id and
pbv.project_structure_version_id=ppevs.element_version_id and
pbv.fin_plan_type_id=pfptv.fin_plan_type_id and
pbv.budget_version_id=pra.budget_version_id and
pra.ta_display_flag='Y' and
pra.task_id=ppe.proj_element_id and
pra.resource_list_member_id=prlm.resource_list_member_id and
prlm.resource_class_code=prcv.resource_class_code(+)
