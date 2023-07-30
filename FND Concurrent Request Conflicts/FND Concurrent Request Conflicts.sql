/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Concurrent Request Conflicts
-- Description: Lists concurrent requests that were held by the conflict resolution manager and shows their conflicting / blocking requests which were running at the time between the requested start date and conflict release date.
This might not work 100% (it doesn't consider request set conflicts yet), but should give a good indication of most conflicting scenarios.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-concurrent-request-conflicts/
-- Library Link: https://www.enginatics.com/reports/fnd-concurrent-request-conflicts/
-- Run Report: https://demo.enginatics.com/

select
fcr.request_id,
case when fcr.program_application_id=160 and fcr.concurrent_program_id=20392 /*alecdc*/ or fcr.request_type='M' then fcr.description else fcpv.user_concurrent_program_name end program,
xxen_util.user_name(fcr.requested_by) user_name,
xxen_util.client_time(fcr.requested_start_date) requested_start_date,
xxen_util.time(fcr.conflict_wait_seconds) conflict_wait_time,
fcr.conflict_wait_seconds,
xxen_util.client_time(fcr.actual_start_date) start_date,
xxen_util.client_time(fcr.actual_completion_date) completion_date,
xxen_util.time(fcr.seconds) run_time,
fcr2.request_id blocking_request_id,
case when fcr2.program_application_id=160 and fcr2.concurrent_program_id=20392 /*alecdc*/ or fcr2.request_type='M' then fcr2.description else fcpv2.user_concurrent_program_name end blocking_program,
xxen_util.user_name(fcr2.requested_by) blocking_user_name,
xxen_util.client_time(fcr2.actual_start_date) blocking_start_date,
xxen_util.client_time(fcr2.actual_completion_date) blocking_completion_date,
xxen_util.time(fcr2.seconds) blocking_run_time,
fcr2.seconds blocking_run_seconds
from
(
select
86400*greatest(0,nvl(fcr.actual_completion_date,sysdate)-fcr.actual_start_date) seconds,
86400*greatest(0,nvl(fcr.actual_start_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' then sysdate end)-greatest(fcr.request_date,fcr.requested_start_date)) wait_seconds,
86400*greatest(0,nvl(fcr.actual_start_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' then sysdate end)-nvl(nvl(fcr.crm_release_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' and fcr.status_code='Q' and fcr.crm_tstmp is not null then sysdate end),greatest(fcr.request_date,fcr.requested_start_date))) non_conflict_wait_seconds,
86400*greatest(0,nvl(fcr.crm_release_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' and fcr.status_code='Q' and fcr.crm_tstmp is not null then sysdate end)-greatest(fcr.request_date,fcr.requested_start_date)) conflict_wait_seconds,
fcr.*
from
fnd_concurrent_requests fcr
where
1=1 and
fcr.hold_flag='N' and
fcr.crm_tstmp is not null
) fcr,
fnd_concurrent_program_serial fcps,
(
select
86400*greatest(0,nvl(fcr.actual_completion_date,sysdate)-fcr.actual_start_date) seconds,
86400*greatest(0,nvl(fcr.actual_start_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' then sysdate end)-greatest(fcr.request_date,fcr.requested_start_date)) wait_seconds,
86400*greatest(0,nvl(fcr.actual_start_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' then sysdate end)-nvl(nvl(fcr.crm_release_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' and fcr.status_code='Q' and fcr.crm_tstmp is not null then sysdate end),greatest(fcr.request_date,fcr.requested_start_date))) non_conflict_wait_seconds,
86400*greatest(0,nvl(fcr.crm_release_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' and fcr.status_code='Q' and fcr.crm_tstmp is not null then sysdate end)-greatest(fcr.request_date,fcr.requested_start_date)) conflict_wait_seconds,
fcr.*
from
fnd_concurrent_requests fcr
where
1=1 and
fcr.hold_flag='N'
)fcr2,
fnd_concurrent_programs_vl fcpv,
fnd_concurrent_programs_vl fcpv2
where
2=2 and
fcr.program_application_id=fcps.running_application_id and
fcr.concurrent_program_id=fcps.running_concurrent_program_id and
fcps.to_run_application_id=fcr2.program_application_id and
fcps.to_run_concurrent_program_id=fcr2.concurrent_program_id and
fcr.request_id<>fcr2.request_id and
(fcr2.actual_completion_date>=fcr.requested_start_date or fcr2.phase_code='R' and fcr2.actual_completion_date is null) and
fcr2.actual_start_date<=nvl(fcr.crm_release_date,sysdate) and
fcr.program_application_id=fcpv.application_id(+) and
fcr.concurrent_program_id=fcpv.concurrent_program_id(+) and
fcr2.program_application_id=fcpv2.application_id(+) and
fcr2.concurrent_program_id=fcpv2.concurrent_program_id(+)
order by
fcr.requested_start_date desc,
fcr.request_id desc