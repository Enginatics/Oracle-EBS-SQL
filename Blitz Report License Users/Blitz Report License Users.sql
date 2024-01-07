/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report License Users
-- Description: Currently active Blitz Report users (running reports within the past 60 days) and their most frequently executeds reports.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-license-users/
-- Library Link: https://www.enginatics.com/reports/blitz-report-license-users/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.user_name(xrlu.user_id) user_name,
fu.start_date user_start_date,
xxen_util.client_time(y.first_run_date) first_run_date,
xxen_util.client_time(xrlu.last_run_date) last_run_date,
y.run_count,
y.distinct_reports,
xrv.report_name most_popular,
y.most_popular_count
from
xxen_report_license_users xrlu,
fnd_user fu,
(
select distinct
x.created_by,
x.first_run_date,
x.run_count,
x.distinct_reports,
max(x.report_id) keep (dense_rank last order by x.count) over (partition by x.created_by) most_popular,
max(x.count) keep (dense_rank last order by x.count) over (partition by x.created_by) most_popular_count
from
(
select distinct
xrr.created_by,
xrr.first_run_date,
xrr.report_id,
count(*) over (partition by xrr.created_by) run_count,
count(distinct xrr.report_id) over (partition by xrr.created_by) distinct_reports,
count(*) over (partition by xrr.created_by, xrr.report_id) count
from
(select min(xrr.creation_date) over (partition by xrr.created_by) first_run_date,  xrr.* from xxen_report_runs xrr) xrr
where
nvl(xrr.type,'x')<>'S' and
xrr.creation_date>sysdate-60
) x
) y,
xxen_reports_v xrv
where
xrlu.last_run_date>sysdate-60 and
xrlu.user_id=fu.user_id and
nvl(fu.end_date,sysdate)>=sysdate and
xrlu.user_id=y.created_by(+) and
y.most_popular=xrv.report_id(+)
order by
xrlu.last_run_date desc