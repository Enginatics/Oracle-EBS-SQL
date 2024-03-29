/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Concurrent Requests Summary
-- Description: Concurrent programs sorted by the sum of their historic execution times
-- Excel Examle Output: https://www.enginatics.com/example/fnd-concurrent-requests-summary/
-- Library Link: https://www.enginatics.com/reports/fnd-concurrent-requests-summary/
-- Run Report: https://demo.enginatics.com/

select
x.user_concurrent_program_name program,
x.description,
x.concurrent_program_name short_name,
x.executable_name,
xxen_util.meaning(x.execution_method_code,'CP_EXECUTION_METHOD_CODE',0) method,
x.execution_file_name,
&col_argument2
x.executions,
x.users,
xxen_util.time(x.min_seconds) min_time,
xxen_util.time(x.max_seconds) max_time,
xxen_util.time(x.avg_seconds) avg_time,
xxen_util.time(x.sum_seconds) sum_time,
xxen_util.time(x.avg_wait_seconds) avg_wait_time,
xxen_util.time(x.sum_wait_seconds) sum_wait_time,
xxen_util.time(x.avg_non_conflict_wait_seconds) avg_non_conflict_wait_time,
xxen_util.time(x.sum_non_conflict_wait_seconds) sum_non_conflict_wait_time,
xxen_util.time(x.avg_conflict_wait_seconds) avg_conflict_wait_time,
xxen_util.time(x.sum_conflict_wait_seconds) sum_conflict_wait_time,
x.min_seconds,
x.max_seconds,
x.avg_seconds,
x.sum_seconds,
x.avg_wait_seconds,
x.sum_wait_seconds,
x.avg_non_conflict_wait_seconds,
x.sum_non_conflict_wait_seconds,
x.avg_conflict_wait_seconds,
x.sum_conflict_wait_seconds,
xxen_util.client_time(x.first_run_date) first_run_date,
xxen_util.client_time(x.last_run_date) last_run_date,
xxen_util.user_name(x.last_user) last_user,
x.last_responsibility,
x.execution_method_code,
x.total_users
&time_percentage
from
(
select distinct
fcpv.user_concurrent_program_name,
fcr.description_ description,
fcpv.concurrent_program_name,
fe.executable_name,
fe.execution_method_code,
fe.execution_file_name,
&col_argument
count(*) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name) executions,
count(distinct fcr.requested_by) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) users,
min(fcr.seconds) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) min_seconds,
max(fcr.seconds) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) max_seconds,
avg(fcr.seconds) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) avg_seconds,
sum(fcr.seconds) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) sum_seconds,
avg(fcr.wait_seconds) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) avg_wait_seconds,
sum(fcr.wait_seconds) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) sum_wait_seconds,
avg(fcr.non_conflict_wait_seconds) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) avg_non_conflict_wait_seconds,
sum(fcr.non_conflict_wait_seconds) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) sum_non_conflict_wait_seconds,
avg(fcr.conflict_wait_seconds) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) avg_conflict_wait_seconds,
sum(fcr.conflict_wait_seconds) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) sum_conflict_wait_seconds,
min(fcr.actual_start_date) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) first_run_date,
max(fcr.actual_start_date) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) last_run_date,
max(fcr.requested_by) keep (dense_rank last order by fcr.actual_start_date, fcr.request_id) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) last_user,
max(frv.responsibility_name) keep (dense_rank last order by fcr.actual_start_date, fcr.request_id) over (partition by fcpv.user_concurrent_program_name,fcr.description_,fcpv.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) last_responsibility,
count(distinct fcr.requested_by) over () total_users
from
(
select
86400*greatest(0,nvl(fcr.actual_completion_date,sysdate)-fcr.actual_start_date) seconds,
86400*greatest(0,nvl(fcr.actual_start_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' then sysdate end)-greatest(fcr.request_date,fcr.requested_start_date)) wait_seconds,
86400*greatest(0,nvl(fcr.actual_start_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' then sysdate end)-nvl(nvl(fcr.crm_release_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' and fcr.status_code='Q' and fcr.crm_tstmp is not null then sysdate end),greatest(fcr.request_date,fcr.requested_start_date))) non_conflict_wait_seconds,
86400*greatest(0,nvl(fcr.crm_release_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' and fcr.status_code='Q' and fcr.crm_tstmp is not null then sysdate end)-greatest(fcr.request_date,fcr.requested_start_date)) conflict_wait_seconds,
regexp_replace(fcr.description,'\d+', '%') description_,
fcr.*
from
fnd_concurrent_requests fcr
) fcr,
fnd_concurrent_programs_vl fcpv,
fnd_user fu,
fnd_executables fe,
fnd_responsibility_vl frv
where
1=1 and
fcr.actual_completion_date is not null and
fcr.requested_by=fu.user_id and
fcr.concurrent_program_id=fcpv.concurrent_program_id and
fcpv.executable_application_id=fe.application_id and
fcpv.executable_id=fe.executable_id and
fcr.responsibility_application_id=frv.application_id(+) and
fcr.responsibility_id=frv.responsibility_id(+)
) x
order by
x.executions desc,
x.sum_seconds desc