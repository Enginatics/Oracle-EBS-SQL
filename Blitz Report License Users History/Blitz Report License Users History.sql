/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report License Users History
-- Description: Shows the history of active Blitz Report users at every at every month end, looking back the past 60 days.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-license-users-history/
-- Library Link: https://www.enginatics.com/reports/blitz-report-license-users-history/
-- Run Report: https://demo.enginatics.com/

select
z.month-1 month_end,
xxen_util.user_name(z.created_by) user_name,
fu.start_date user_start_date,
fu.end_date user_end_date,
xxen_util.client_time(z.first_run_date) first_run_date,
xxen_util.client_time(z.last_run_date) last_run_date,
z.run_count,
z.report_count,
xrv.report_name most_popular,
z.most_popular_count,
z.user_count,
z.total_run_count,
z.total_report_count
from
(
select distinct
y.month,
y.created_by,
y.first_run_date,
y.last_run_date,
y.run_count,
y.report_count,
max(y.report_id) keep (dense_rank last order by y.count) over (partition by y.month, y.created_by) most_popular,
max(y.count) keep (dense_rank last order by y.count) over (partition by y.month, y.created_by) most_popular_count,
y.user_count,
y.total_run_count,
y.total_report_count
from
(
select distinct
x.month,
xrr.created_by,
xrr.first_run_date,
xrr.last_run_date,
xrr.report_id,
count(*) over (partition by x.month, xrr.created_by) run_count,
count(distinct xrr.report_id) over (partition by x.month, xrr.created_by) report_count,
count(*) over (partition by x.month, xrr.created_by, xrr.report_id) count,
count(distinct xrr.created_by) over (partition by x.month) user_count,
count(*) over (partition by x.month) total_run_count,
count(distinct xrr.report_id) over (partition by x.month) total_report_count
from
(select add_months(trunc(sysdate,'month'),-level+1) month from dual connect by level<=ceil(months_between(trunc(sysdate,'month'),(select min(xrr.creation_date) from xxen_report_runs xrr where nvl(xrr.type,'x')<>'S')))) x,
(select min(xrr.creation_date) over (partition by xrr.created_by) first_run_date, max(xrr.creation_date) over (partition by xrr.created_by) last_run_date,  xrr.* from xxen_report_runs xrr where nvl(xrr.type,'x')<>'S') xrr
where
xrr.creation_date>=x.month-60 and
xrr.creation_date<x.month
) y
) z,
fnd_user fu,
xxen_reports_v xrv
where
z.created_by=fu.user_id and
z.most_popular=xrv.report_id(+)
order by
z.month desc,
z.run_count desc