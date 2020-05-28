/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Task Schedule
-- Excel Examle Output: https://www.enginatics.com/example/pa-task-schedule/
-- Library Link: https://www.enginatics.com/reports/pa-task-schedule/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ppa.segment1 project,
ppe.name task,
ppevs.scheduled_start_date,
ppevs.scheduled_finish_date,
xxen_util.user_name(ppevs.created_by) created_by,
case when ppevs.creation_date<>ppevs.last_update_date or ppevs.created_by<>ppevs.last_updated_by then xxen_util.user_name(ppevs.last_updated_by) end last_updated_by
from
hr_all_organization_units haouv,
pa_projects_all ppa,
pa_proj_elements ppe,
pa_proj_elem_ver_schedule ppevs
where
1=1 and
haouv.organization_id=ppa.org_id and
ppa.project_id=ppe.project_id and
ppe.object_type='PA_TASKS' and
ppe.baseline_finish_date is not null and
ppe.project_id=ppevs.project_id and
ppe.proj_element_id=ppevs.proj_element_id
order by
haouv.name,
ppa.segment1,
ppe.name