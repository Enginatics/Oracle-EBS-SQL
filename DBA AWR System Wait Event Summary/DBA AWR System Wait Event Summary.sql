/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR System Wait Event Summary
-- Description: Summary of wait times by wait event and event class for a specified snapshot time interval.
Use the Session Type parameter to restrict either to foreground, background or all server processes.
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-system-wait-event-summary/
-- Library Link: https://www.enginatics.com/reports/dba-awr-system-wait-event-summary/
-- Run Report: https://demo.enginatics.com/

select
x.seconds/xxen_util.zero_to_null(sum(x.seconds) over ())*100 percentage,
x.*
from
(
select distinct
&columns2
dhse.wait_class,
&columns
xxen_util.time(sum(case when dhse.time_delta<0 then dhse.time_micro else dhse.time_delta end) over (partition by dhse.wait_class &partition_by)/1000000) time,
sum(case when dhse.time_delta<0 then dhse.time_micro else dhse.time_delta end) over (partition by dhse.wait_class &partition_by)/1000000 seconds,
sum(case when dhse.waits_delta<0 then dhse.waits else dhse.waits_delta end) over (partition by dhse.wait_class &partition_by) waits,
sum(case when dhse.timeouts_delta<0 then dhse.timeouts else dhse.timeouts_delta end) over (partition by dhse.wait_class &partition_by) timeouts
from
(
select
dhse.time_micro-lag(dhse.time_micro) over (partition by dhse.dbid, dhse.instance_number, dhse.event_name order by dhse.snap_id) time_delta,
dhse.waits-lag(dhse.waits) over (partition by dhse.dbid, dhse.instance_number, dhse.event_name order by dhse.snap_id) waits_delta,
dhse.timeouts-lag(dhse.timeouts) over (partition by dhse.dbid, dhse.instance_number, dhse.event_name order by dhse.snap_id) timeouts_delta,
dhse.*
from
(
select
decode(:session_type,'Foreground',dhse.time_waited_micro_fg,'Background',dhse.time_waited_micro-dhse.time_waited_micro_fg,dhse.time_waited_micro) time_micro,
decode(:session_type,'Foreground',dhse.total_waits_fg,'Background',dhse.total_waits-dhse.total_waits_fg,dhse.total_waits) waits,
decode(:session_type,'Foreground',dhse.total_timeouts_fg,'Background',dhse.total_timeouts-dhse.total_timeouts_fg,dhse.total_waits) timeouts,
dhse.*
from
dba_hist_snapshot dhs,
dba_hist_system_event dhse
where
1=1 and
dhs.dbid=dhse.dbid and
dhs.instance_number=dhse.instance_number and
dhs.snap_id=dhse.snap_id
) dhse
) dhse
) x
where
x.seconds>0
order by
x.seconds desc,
x.wait_class