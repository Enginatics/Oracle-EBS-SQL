/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: WF Service Components
-- Description: Workflow service components, such as the notification mailer, agent listeners and web services agents, with their status, startup mode and the concurrent manager container running them.
-- Show Parameters lists the component's configuration parameters, for example the mailer's SMTP and IMAP servers, reply-to and test address. Encrypted values such as passwords are masked.
-- Schedule the report with Not Running only to get an email when the notification mailer or an agent listener stops.
-- Excel Example Output: https://www.enginatics.com/example/wf-service-components/
-- Library Link: https://www.enginatics.com/reports/wf-service-components/
-- Run Report: https://demo.enginatics.com/

select
fscttl.display_name component_type,
fsc.component_name,
initcap(replace(fsc.component_status,'_',' ')) status,
fsc.component_status_info status_info,
initcap(fsc.startup_mode) startup_mode,
fcqv.user_concurrent_queue_name container,
fcqv.running_processes container_processes,
fsc.inbound_agent_name,
fsc.outbound_agent_name,
fsc.correlation_id,
fsc.max_idle_time,
&parameter_columns
xxen_util.user_name(fsc.last_updated_by) last_updated_by,
xxen_util.client_time(fsc.last_update_date) last_update_date
from
fnd_svc_components fsc,
fnd_svc_comp_types_tl fscttl,
fnd_concurrent_queues_vl fcqv
&parameter_table
where
1=1 and
fsc.component_type=fscttl.component_type(+) and
fscttl.language(+)=userenv('lang') and
fsc.concurrent_queue_id=fcqv.concurrent_queue_id(+)
order by
component_type,
fsc.component_name
&parameter_order
