/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA SGA Wait Event Summary (active session history)
-- Description: Wait event and CPU usage summary from the SGA active session history.
-- Excel Examle Output: https://www.enginatics.com/example/dba-sga-wait-event-summary-active-session-history/
-- Library Link: https://www.enginatics.com/reports/dba-sga-wait-event-summary-active-session-history/
-- Run Report: https://demo.enginatics.com/

select
100*gash.seconds/xxen_util.zero_to_null(sum(gash.seconds) over (partition by &gash_inst_id 1)) percentage,
gash.seconds/gash.total_seconds active_sessions,
xxen_util.time(gash.seconds) time,
&gash_inst_id
gash.seconds,
gash.wait_class,
&gash_event
xxen_util.time(gash.total_seconds) time_window
from
(
select distinct
&gash_inst_id
count(*) over (partition by &gash_inst_id gash.wait_class,&gash_event 1) seconds,
nvl(gash.wait_class,'ON CPU') wait_class,
&gash_event
(max(cast(gash.sample_time as date)) over (partition by &gash_inst_id 1)-min(cast(gash.sample_time as date)) over (partition by &gash_inst_id 1))*86400 total_seconds
from
gv$active_session_history gash
where
1=1
) gash
order by
&gash_inst_id
seconds desc