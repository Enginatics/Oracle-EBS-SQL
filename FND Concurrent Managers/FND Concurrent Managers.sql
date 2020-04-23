/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Concurrent Managers
-- Description: Concurrent managers' setup and current status, e.g. processes and requests running, pending etc.
Shows the same information as Concurrent->Manager->Administer and Concurrent->Manager->Define
-- Excel Examle Output: https://www.enginatics.com/example/fnd-concurrent-managers
-- Library Link: https://www.enginatics.com/reports/fnd-concurrent-managers
-- Run Report: https://demo.enginatics.com/


select
fcqv.user_concurrent_queue_name manager,
fcqv.concurrent_queue_name short_name,
xxen_util.meaning(fcqv.enabled_flag,'YES_NO',0) enabled_flag,
fav.application_name,
fcsv.service_name type,
fcqv.target_node,
fcqv.running_processes actual,
fcqv.target_processes target,
fcwr0.running,
fcwr0.pending,
fcwr0.on_hold,
fcwr0.scheduled,
xxen_util.meaning(fcqv.control_code,'CP_CONTROL_CODE',0) status,
&columns
fcqv.cache_size,
fcqv.sleep_seconds,
fcqv.node_name primary_node,
fcqv.node_name2 secondary_node,
fcqv.concurrent_queue_id
from
fnd_concurrent_queues_vl fcqv,
fnd_application_vl fav,
fnd_cp_services_vl fcsv,
(
select
fcwr.concurrent_queue_id,
fcwr.queue_application_id,
sum(case when fcwr.phase_code='R' then 1 end) running,
sum(case when fcwr.phase_code='P' and fcwr.hold_flag<>'Y' and fcwr.requested_start_date<=sysdate then 1 end) pending,
sum(case when fcwr.hold_flag='Y' then 1 end) on_hold,
sum(case when fcwr.phase_code='P' and fcwr.hold_flag<>'Y' and fcwr.requested_start_date>sysdate then 1 end) scheduled
from
fnd_concurrent_worker_requests fcwr
where
fcwr.phase_code in ('R','P')
group by
fcwr.concurrent_queue_id,
fcwr.queue_application_id
) fcwr0,
(
select
fcwr.queue_application_id,
fcwr.concurrent_queue_id,
row_number() over (partition by fcwr.queue_application_id,fcwr.concurrent_queue_id order by fcwr.priority,fcwr.priority_request_id,fcwr.request_id) position,
fcwr.request_id,
fnd_amp_private.get_phase (fcwr.phase_code,fcwr.status_code,fcwr.hold_flag,fcwr.enabled_flag,fcwr.requested_start_date,fcwr.request_id) phase,
fnd_amp_private.get_status (fcwr.phase_code,fcwr.status_code,fcwr.hold_flag,fcwr.enabled_flag,fcwr.requested_start_date,fcwr.request_id) status,
fcwr.request_description program,
xxen_util.user_name(fcwr.requested_by) requestor,
fcwr.argument_text request_parameters
from
fnd_concurrent_worker_requests fcwr
where
'&show_requests'='Y' and
(fcwr.phase_code='P' or fcwr.phase_code='R') and
fcwr.hold_flag!='Y' and
fcwr.requested_start_date<=sysdate
) fcwr,
(select fcqc.* from fnd_concurrent_queue_content fcqc where '&show_specialization_rules'='Y') fcqc,
fnd_concurrent_programs_vl fcpv,
(select fcpr.* from fnd_concurrent_processes fcpr where '&show_processes'='Y') fcpr,
(
select distinct
fcr.controlling_manager,
decode(fcr.status_code,'R','A','T','A','X','K') process_status_code,
max(fcr.request_id) over (partition by fcr.controlling_manager,decode(fcr.status_code,'R','A','T','A','X','K')) request_id,
max(fcr.os_process_id) keep (dense_rank last order by fcr.request_id) over (partition by fcr.controlling_manager,decode(fcr.status_code,'R','A','T','A','X','K')) os_process_id
from
fnd_concurrent_requests fcr
where
'&show_processes'='Y' and
fcr.status_code in ('R','T')
) fcr
where
1=1 and
fcqv.application_id=fav.application_id and
fcqv.manager_type=fcsv.service_id(+) and
fcqv.application_id=fcwr0.queue_application_id(+) and
fcqv.concurrent_queue_id=fcwr0.concurrent_queue_id(+) and
fcqv.application_id=fcwr.queue_application_id(+) and
fcqv.concurrent_queue_id=fcwr.concurrent_queue_id(+) and
fcqv.application_id=fcqc.queue_application_id(+) and
fcqv.concurrent_queue_id=fcqc.concurrent_queue_id(+) and
decode(fcqc.type_code,'P',fcqc.type_application_id)=fcpv.application_id(+) and
decode(fcqc.type_code,'P',fcqc.type_id)=fcpv.concurrent_program_id(+) and
fcqv.application_id=fcpr.queue_application_id(+) and
fcqv.concurrent_queue_id=fcpr.concurrent_queue_id(+) and
fcpr.concurrent_process_id=fcr.controlling_manager(+) and
fcpr.process_status_code=fcr.process_status_code(+)
order by
fcqv.enabled_flag desc,
decode (fcqv.application_id,0,decode(fcqv.concurrent_queue_id,1,1,4,2)),
sign(fcqv.max_processes) desc,
fcqv.concurrent_queue_name,
fcqv.application_id,
&order_by
1