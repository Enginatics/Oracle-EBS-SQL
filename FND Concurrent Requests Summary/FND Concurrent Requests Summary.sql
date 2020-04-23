/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
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
x.sum_conflict_wait_seconds
&time_percentage
from
(
select distinct
fcpt.user_concurrent_program_name,
fcr.description_ description,
fcp.concurrent_program_name,
fe.executable_name,
fe.execution_method_code,
fe.execution_file_name,
&col_argument
count(*) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name) executions,
count(distinct fcr.requested_by) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) users,
min(fcr.seconds) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) min_seconds,
max(fcr.seconds) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) max_seconds,
avg(fcr.seconds) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) avg_seconds,
sum(fcr.seconds) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) sum_seconds,
avg(fcr.wait_seconds) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) avg_wait_seconds,
sum(fcr.wait_seconds) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) sum_wait_seconds,
avg(fcr.non_conflict_wait_seconds) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) avg_non_conflict_wait_seconds,
sum(fcr.non_conflict_wait_seconds) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) sum_non_conflict_wait_seconds,
avg(fcr.conflict_wait_seconds) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) avg_conflict_wait_seconds,
sum(fcr.conflict_wait_seconds) over (partition by fcpt.user_concurrent_program_name,fcr.description_,fcp.concurrent_program_name,fe.executable_name,fe.execution_file_name &partition_argument) sum_conflict_wait_seconds
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
fnd_concurrent_programs fcp,
fnd_concurrent_programs_tl fcpt,
fnd_user fu,
fnd_executables fe
where
1=1 and
fcr.actual_completion_date is not null and
fcr.requested_by=fu.user_id and
fcr.concurrent_program_id=fcpt.concurrent_program_id and
fcr.concurrent_program_id=fcp.concurrent_program_id and
fcr.program_application_id=fcpt.application_id and
fcpt.language=userenv('lang') and
fcp.executable_application_id=fe.application_id and
fcp.executable_id=fe.executable_id
) x
order by
x.sum_seconds desc