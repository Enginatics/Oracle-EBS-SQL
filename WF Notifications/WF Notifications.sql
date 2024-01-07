/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WF Notifications
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/wf-notifications/
-- Library Link: https://www.enginatics.com/reports/wf-notifications/
-- Run Report: https://demo.enginatics.com/

select
wn.message_type item_type,
witv.display_name workflow_type,
nvl(wn.item_key,wias.item_key) item_key,
xxen_util.meaning(wias.activity_status,'FND_WF_ACTIVITY_STATUS_LIST',0) activity_status,
wias.activity_result_code activity_result,
wias.error_message,
wias.error_stack,
wn.from_user,
nvl2(wn.more_info_role,wf_directory.getroledisplayname(wn.more_info_role),wn.to_user) to_user,
nvl2(wn.more_info_role,fnd_message.get_string('FND','FND_MORE_INFO_REQUESTED')||' '||wn.subject,wn.subject) subject,
wn.language,
nvl(wn.sent_date,wn.begin_date) begin_date,
wn.due_date,
wl.meaning status,
wn.end_date,
wn.from_role,
wn.original_recipient,
wn.recipient_role,
wn.more_info_role,
wn.message_name,
wn.mail_status,
wn.priority,
wn.notification_id
from
wf_notifications wn,
wf_item_types_vl witv,
wf_lookups wl,
wf_item_activity_statuses wias
where
1=1 and
wn.message_type=witv.name and
wl.lookup_type='WF_NOTIFICATION_STATUS' and
wn.status=wl.lookup_code and
wn.notification_id=wias.notification_id(+)
order by
nvl(wn.sent_date,wn.begin_date) desc