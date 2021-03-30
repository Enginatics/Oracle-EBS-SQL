/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report User History
-- Description: Lists all active EBS users with their active responsibilities and blitz report execution counts.
The report can be used to analyze blitz report usage within the EBS user community e.g. to find the most active users or to spot the ones not using blitz report to it's full potential yet.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-user-history/
-- Library Link: https://www.enginatics.com/reports/blitz-report-user-history/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.user_name(fu.user_id) user_name,
fu.last_logon_date,
xrr.execution_count,
xrr.report_count,
frv.responsibility_name,
fav.application_name,
frg.request_group_name,
fav2.application_name group_application_name
from
fnd_user fu,
fnd_user_resp_groups furg,
fnd_responsibility_vl frv,
fnd_application_vl fav,
fnd_request_groups frg,
fnd_application_vl fav2,
(
select distinct
xrr.created_by,
count(*) over (partition by xrr.created_by) execution_count,
count(distinct xrr.report_id) over (partition by xrr.created_by) report_count
from
xxen_report_runs xrr
where
1=1
) xrr
where
2=2 and
fu.user_id=furg.user_id and
furg.responsibility_application_id=frv.application_id and
furg.responsibility_id=frv.responsibility_id and
furg.responsibility_application_id=fav.application_id and
frv.group_application_id=frg.application_id(+) and
frv.request_group_id=frg.request_group_id(+) and
frv.group_application_id=fav2.application_id(+) and
fu.user_id=xrr.created_by(+)
order by
xrr.execution_count desc nulls last,
user_name,
frv.responsibility_name