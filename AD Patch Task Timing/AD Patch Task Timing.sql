/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AD Patch Task Timing
-- Description: Run time of each job of an adpatch, adop or upgrade session from ADTASKTIMING, to identify the jobs that took longest.
-- Session Percentage is the job's share of the total elapsed time of all jobs in the session. Jobs run in parallel by several workers, so the session's wall clock time is shorter than the sum of the job times.
-- Excel Example Output: https://www.enginatics.com/example/ad-patch-task-timing/
-- Library Link: https://www.enginatics.com/reports/ad-patch-task-timing/
-- Run Report: https://demo.enginatics.com/

select
x.session_id,
x.patches,
x.phase,
x.phase_name,
x.product,
x.job_name,
x.arguments,
x.worker_id,
xxen_util.client_time(x.start_time) start_time,
xxen_util.client_time(x.end_time) end_time,
xxen_util.time(x.elapsed_time*86400) elapsed_time,
x.elapsed_time*1440 elapsed_minutes,
x.session_percentage,
xxen_util.zero_to_null(x.restart_count) restarts,
xxen_util.zero_to_null(x.defer_count) deferrals,
x.program,
x.command,
x.subdirectory
from
(
select
att.*,
ratio_to_report(att.elapsed_time) over (partition by att.session_id)*100 session_percentage,
aprd.patches
from
ad_task_timing att,
(
select
apr.session_id,
listagg(apd.driver_file_name,', ') within group (order by apd.driver_file_name) patches
from
ad_patch_runs apr,
ad_patch_drivers apd
where
apr.patch_driver_id=apd.patch_driver_id
group by
apr.session_id
) aprd
where
1=1 and
att.session_id=aprd.session_id(+)
) x
where
2=2
order by
x.session_id desc,
x.elapsed_time desc nulls last
