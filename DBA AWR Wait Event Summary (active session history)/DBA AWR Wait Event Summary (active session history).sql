/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR Wait Event Summary (active session history)
-- Description: Wait event and CPU usage summary from the AWR active session history.
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-wait-event-summary-active-session-history/
-- Library Link: https://www.enginatics.com/reports/dba-awr-wait-event-summary-active-session-history/
-- Run Report: https://demo.enginatics.com/

select
100*dhash.seconds/xxen_util.zero_to_null(sum(dhash.seconds) over (partition by &dhash_instance_number 1)) percentage,
dhash.seconds/dhash.total_seconds active_sessions,
xxen_util.time(dhash.seconds) time,
&dhash_instance_number
dhash.seconds,
dhash.wait_class,
&dhash_event
xxen_util.time(dhash.total_seconds) time_window
from
(
select distinct
&dhash_instance_number
count(*) over (partition by &dhash_instance_number dhash.wait_class,&dhash_event 1)*10 seconds,
nvl(dhash.wait_class,'ON CPU') wait_class,
&dhash_event
(max(cast(dhash.sample_time as date)) over (partition by &dhash_instance_number 1)-min(cast(dhash.sample_time as date)) over (partition by &dhash_instance_number 1))*86400 total_seconds
from
dba_hist_active_sess_history dhash
where
1=1
) dhash
order by
&dhash_instance_number
seconds desc