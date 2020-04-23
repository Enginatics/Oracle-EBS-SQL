/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WF Business Events and Subscriptions
-- Description: Workflow business event and subscription details
-- Excel Examle Output: https://www.enginatics.com/example/wf-business-events-and-subscriptions
-- Library Link: https://www.enginatics.com/reports/wf-business-events-and-subscriptions
-- Run Report: https://demo.enginatics.com/


select
wev.owner_tag owner,
wev.owner_name,
wev.name event_name,
wev.display_name,
wev.description,
initcap(wev.type) type,
xxen_util.meaning(wes.status, 'FND_WF_BES_STATUS', 0) event_status,
wev.generate_function,
ws.name system,
xxen_util.meaning(wes.source_type, 'WF_BES_SOURCE_TYPE', 0) source_type,
xxen_util.meaning(wes.action_code, 'FND_WF_BES_RULE_FUNC', 0) action,
wes.rule_function function,
wa.name out_agent,
wa2.name to_agent,
wes.wf_process_type,
wes.wf_process_name,
wes.parameters,
wes.phase,
xxen_util.meaning(decode(wes.priority,100,'LOW',50,'NORMAL',1,'HIGH'), 'WF_BES_SUBSCRIPTION_PRIORITY', 0) priority,
initcap(wes.status) subscription_status,
initcap(wes.rule_data) rule_data,
xxen_util.meaning(wes.on_error_code, 'FND_WF_BES_ON_ERROR', 0) on_error,
wes.owner_tag subscription_owner,
wes.owner_name subscription_owner_name
from
wf_events_vl wev,
wf_event_subscriptions wes,
wf_systems ws,
wf_agents wa,
wf_agents wa2
where
1=1 and
wev.guid=wes.event_filter_guid(+) and
wes.system_guid=ws.guid(+) and
wes.out_agent_guid=wa.guid(+) and
wes.to_agent_guid=wa2.guid(+)