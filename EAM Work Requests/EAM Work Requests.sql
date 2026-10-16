/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM Work Requests
-- Description: Maintenance work requests with their asset, priority, requester and the work order created for them, one row per work request.
-- Days Open and Overdue apply to requests that are neither rejected nor complete. Overdue means the expected resolution date has passed.
-- Work order status is the system status of the linked work order.
-- Excel Example Output: https://www.enginatics.com/example/eam-work-requests/
-- Library Link: https://www.enginatics.com/reports/eam-work-requests/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
wewr.work_request_number,
wewr.description,
xxen_util.meaning(wewr.work_request_status_id,'WIP_EAM_WORK_REQ_STATUS',700) status,
xxen_util.meaning(wewr.work_request_priority_id,'WIP_EAM_ACTIVITY_PRIORITY',700) priority,
xxen_util.meaning(wewr.work_request_type_id,'WIP_EAM_WORK_REQ_TYPE',700) request_type,
wewr.asset_number,
msiv.concatenated_segments asset_group,
msiv.description asset_group_description,
bd.department_code owning_department,
wewr.creation_date,
wewr.expected_resolution_date,
case when wewr.work_request_status_id not in (5,6) then round(sysdate-wewr.creation_date,1) end days_open,
xxen_util.yes(case when wewr.work_request_status_id not in (5,6) and wewr.expected_resolution_date<sysdate then 'Y' end) overdue,
xxen_util.user_name(wewr.work_request_created_by) requested_by,
xxen_util.user_name(wewr.created_for) created_for,
xxen_util.meaning(wewr.contact_preference,'WIP_EAM_CONTACT_PREFERENCE',700) contact_preference,
wewr.phone_number,
wewr.e_mail email,
we.wip_entity_name work_order,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) work_order_status,
wdj.scheduled_start_date,
wdj.scheduled_completion_date,
wdj.date_completed,
wdj.date_closed,
xxen_util.user_name(wewr.created_by) created_by,
wewr.last_update_date,
xxen_util.user_name(wewr.last_updated_by) last_updated_by
from
wip_eam_work_requests wewr,
mtl_parameters mp,
mtl_system_items_vl msiv,
bom_departments bd,
wip_entities we,
wip_discrete_jobs wdj
where
1=1 and
wewr.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
wewr.organization_id=mp.organization_id and
wewr.asset_group=msiv.inventory_item_id(+) and
wewr.organization_id=msiv.organization_id(+) and
wewr.work_request_owning_dept=bd.department_id(+) and
wewr.wip_entity_id=we.wip_entity_id(+) and
wewr.wip_entity_id=wdj.wip_entity_id(+)
order by
mp.organization_code,
wewr.creation_date desc,
wewr.work_request_number
