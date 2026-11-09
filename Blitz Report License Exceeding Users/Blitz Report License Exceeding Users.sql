/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report License Exceeding Users
-- Description: Users whose Blitz Report runs were refused with 'Invalid License: maximum users exceeded' within the past 60 days, and who do not hold one of the licensed user seats now.
-- The row count is the number of additional user licenses needed to admit all of them. A user who has since obtained a seat, because another licensed user did not run reports for 60 days, is not listed.
-- Excel Example Output: https://www.enginatics.com/example/blitz-report-license-exceeding-users/
-- Library Link: https://www.enginatics.com/reports/blitz-report-license-exceeding-users/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.user_name(x.created_by) user_name,
fu.start_date user_start_date,
xxen_util.client_time(x.first_attempt_date) first_attempt_date,
xxen_util.client_time(x.last_attempt_date) last_attempt_date,
x.attempt_count,
x.distinct_reports,
xrv.report_name last_report
from
(
select
xrr.created_by,
min(xrr.creation_date) first_attempt_date,
max(xrr.creation_date) last_attempt_date,
count(*) attempt_count,
count(distinct xrr.report_id) distinct_reports,
max(xrr.report_id) keep (dense_rank last order by xrr.creation_date) last_report_id
from
xxen_report_runs xrr
where
xrr.creation_date>sysdate-60 and
xrr.completion_message='maximum users exceeded'
group by
xrr.created_by
) x,
fnd_user fu,
xxen_reports_v xrv
where
x.created_by=fu.user_id and
nvl(fu.end_date,sysdate)>=sysdate and
x.created_by not in (select xrlu.user_id from xxen_report_license_users xrlu where xrlu.last_run_date>sysdate-60) and
x.last_report_id=xrv.report_id(+)
order by
x.last_attempt_date desc
