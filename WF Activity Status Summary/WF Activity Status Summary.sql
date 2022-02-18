/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WF Activity Status Summary
-- Description: Summary counts of stuck and errored workflow activities to monitor required housekeeping activities
-- Excel Examle Output: https://www.enginatics.com/example/wf-activity-status-summary/
-- Library Link: https://www.enginatics.com/reports/wf-activity-status-summary/
-- Run Report: https://demo.enginatics.com/

select
count (*) count,
wias.item_type,
witv.display_name type_display_name,
wpa.instance_label,
wias.activity_result_code,
wias.activity_status
from
wf_item_activity_statuses wias,
wf_process_activities wpa,
wf_item_types_vl witv
where
1=1 and
wias.process_activity=wpa.instance_id and
wias.item_type=witv.name(+)
group by
wias.item_type,
witv.display_name,
wpa.instance_label,
wias.activity_result_code,
wias.activity_status
order by count (*) desc