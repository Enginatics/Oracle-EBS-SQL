/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR CPU Load (active session history)
-- Description: Aggregates active sessions by snapshot time to identify times with high CPU load over a specific 'CPU Sessions From' threshold value.
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-cpu-load-active-session-history/
-- Library Link: https://www.enginatics.com/reports/dba-awr-cpu-load-active-session-history/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.client_time(dhash.sample_time_) sample_time,
dhash.instance_number,
dhash.sessions,
xxen_util.zero_to_null(dhash.cpu_sessions) cpu_sessions,
xxen_util.zero_to_null(dhash.waiting_sessions) waiting_sessions
from
(
select distinct
cast(dhash.sample_time as date) sample_time_,
dhash.instance_number,
count(*) over (partition by dhash.sample_id) sessions,
count(decode(dhash.session_state,'ON CPU',1)) over (partition by dhash.sample_id) cpu_sessions,
count(decode(dhash.session_state,'WAITING',1)) over (partition by dhash.sample_id) waiting_sessions
from
dba_hist_active_sess_history dhash
where
1=1
) dhash
where
2=2
order by
sample_time,
instance_number