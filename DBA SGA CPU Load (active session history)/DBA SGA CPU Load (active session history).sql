/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA SGA CPU Load (active session history)
-- Description: Aggregates active sessions by snapshot time to identify times with high CPU load over a specific 'CPU Sessions From' threshold value.
-- Excel Examle Output: https://www.enginatics.com/example/dba-sga-cpu-load-active-session-history/
-- Library Link: https://www.enginatics.com/reports/dba-sga-cpu-load-active-session-history/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.client_time(gash.sample_time_) sample_time,
gash.inst_id,
gash.sessions,
xxen_util.zero_to_null(gash.cpu_sessions) cpu_sessions,
xxen_util.zero_to_null(gash.waiting_sessions) waiting_sessions
from
(
select distinct
cast(gash.sample_time as date) sample_time_,
gash.inst_id,
count(*) over (partition by gash.sample_id) sessions,
count(decode(gash.session_state,'ON CPU',1)) over (partition by gash.sample_id) cpu_sessions,
count(decode(gash.session_state,'WAITING',1)) over (partition by gash.sample_id) waiting_sessions
from
gv$active_session_history gash
where
1=1
) gash
where
2=2
order by
sample_time,
inst_id