/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Execution Summary
-- Description: Count and performance summary of historic Blitz Report executions
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-execution-summary/
-- Library Link: https://www.enginatics.com/reports/blitz-report-execution-summary/
-- Run Report: https://demo.enginatics.com/

select
y.report_name,
y.count,
y.type_dsp type,
y.category,
xxen_util.time(avg_seconds) avg_time,
xxen_util.time(max_seconds) max_time,
xxen_util.time(sum_seconds) sum_time,
y.avg_seconds,
y.max_seconds,
y.sum_seconds,
y.users,
y.most_frequent,
y.created_by,
xxen_util.client_time(y.creation_date) creation_date,
y.last_updated_by,
xxen_util.client_time(y.last_update_date) last_update_date,
y.total_users
from
(
select distinct
count(x.run_id) over (partition by x.report_id) count,
x.report_name,
round(sum(x.seconds) over (partition by x.report_id)/count(*) over (partition by x.report_id),2) avg_seconds,
round(max(x.seconds) over (partition by x.report_id),2) max_seconds,
round(sum(x.seconds) over (partition by x.report_id),2) sum_seconds,
count(distinct x.xrr_created_by) over (partition by x.report_id) users,
max(xxen_util.user_name(x.xrr_created_by)) keep (dense_rank last order by x.count_per_user, x.xrr_created_by) over (partition by x.report_id) most_frequent,
x.category,
x.created_by,
x.creation_date,
x.last_updated_by,
x.last_update_date,
x.type_dsp,
count(distinct x.xrr_created_by) over () total_users
from
(
select
xrv.report_name,
xrv.type_dsp,
xxen_util.user_name(xrv.created_by) created_by,
xrv.creation_date,
xxen_util.user_name(xrv.last_updated_by) last_updated_by,
xrv.last_update_date,
(xrr.completion_date-xrr.creation_date)*86400 seconds,
xrr.run_id,
xrr.report_id,
xrr.created_by xrr_created_by,
xxen_api.category(xrv.report_id) category,
count(xrr.run_id) over (partition by xrr.report_id, xrr.created_by) count_per_user
from
xxen_reports_v xrv,
xxen_report_runs xrr
where
1=1 and
xrr.completion_date is not null and
xrr.completion_message is null and
xrv.report_id=xrr.report_id(+)
) x
) y
order by
y.count desc nulls last