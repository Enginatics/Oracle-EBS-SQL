/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: WF Queue Backlog
-- Description: Number of messages per Workflow Business Event System queue table, correlation id and state, with the age of the oldest message.
-- A large number of Ready messages with an old Oldest Message shows that the agent listener, notification mailer or Workflow Background Process serving the queue is down or cannot keep up. The correlation id contains the business event or notification message name, and for WFDEFERREDTABLEM the item type processed by the Workflow Background Process.
-- Excel Example Output: https://www.enginatics.com/example/wf-queue-backlog/
-- Library Link: https://www.enginatics.com/reports/wf-queue-backlog/
-- Run Report: https://demo.enginatics.com/

select
x.queue_table,
x.corrid correlation_id,
decode(x.state,0,'Ready',1,'Waiting',2,'Processed',3,'Expired') state,
x.message_count,
xxen_util.client_time(x.oldest_message) oldest_message,
xxen_util.time((sysdate-x.oldest_message)*86400) oldest_message_age,
xxen_util.client_time(x.newest_message) newest_message
from
(
select 'WF_DEFERRED' queue_table, wd.corrid, wd.state, count(*) message_count, cast(min(wd.enq_time) as date) oldest_message, cast(max(wd.enq_time) as date) newest_message from wf_deferred wd group by wd.corrid, wd.state union all
select 'WF_DEFERRED_TABLE_M' queue_table, wdtm.corrid, wdtm.state, count(*) message_count, cast(min(wdtm.enq_time) as date) oldest_message, cast(max(wdtm.enq_time) as date) newest_message from wf_deferred_table_m wdtm group by wdtm.corrid, wdtm.state union all
select 'WF_ERROR' queue_table, we.corrid, we.state, count(*) message_count, cast(min(we.enq_time) as date) oldest_message, cast(max(we.enq_time) as date) newest_message from wf_error we group by we.corrid, we.state union all
select 'WF_JAVA_DEFERRED' queue_table, wjd.corrid, wjd.state, count(*) message_count, cast(min(wjd.enq_time) as date) oldest_message, cast(max(wjd.enq_time) as date) newest_message from wf_java_deferred wjd group by wjd.corrid, wjd.state union all
select 'WF_JAVA_ERROR' queue_table, wje.corrid, wje.state, count(*) message_count, cast(min(wje.enq_time) as date) oldest_message, cast(max(wje.enq_time) as date) newest_message from wf_java_error wje group by wje.corrid, wje.state union all
select 'WF_NOTIFICATION_OUT' queue_table, wno.corrid, wno.state, count(*) message_count, cast(min(wno.enq_time) as date) oldest_message, cast(max(wno.enq_time) as date) newest_message from wf_notification_out wno group by wno.corrid, wno.state union all
select 'WF_NOTIFICATION_IN' queue_table, wni.corrid, wni.state, count(*) message_count, cast(min(wni.enq_time) as date) oldest_message, cast(max(wni.enq_time) as date) newest_message from wf_notification_in wni group by wni.corrid, wni.state union all
select 'WF_INBOUND_TABLE' queue_table, wit.corrid, wit.state, count(*) message_count, cast(min(wit.enq_time) as date) oldest_message, cast(max(wit.enq_time) as date) newest_message from wf_inbound_table wit group by wit.corrid, wit.state union all
select 'WF_OUTBOUND_TABLE' queue_table, wot.corrid, wot.state, count(*) message_count, cast(min(wot.enq_time) as date) oldest_message, cast(max(wot.enq_time) as date) newest_message from wf_outbound_table wot group by wot.corrid, wot.state
) x
where
1=1
order by
x.message_count desc
