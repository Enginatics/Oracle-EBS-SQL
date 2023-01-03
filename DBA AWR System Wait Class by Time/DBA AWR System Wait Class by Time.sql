/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR System Wait Class by Time
-- Description: Non idle session wait times by wait class over time.
Each row shows the system-wide wait time per wait class of one AWR snapshot interval to identify unusual wait events that occured at specific times.
Use the Session Type parameter to restrict either to foreground, background or all server processes.
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-system-wait-class-by-time/
-- Library Link: https://www.enginatics.com/reports/dba-awr-system-wait-class-by-time/
-- Run Report: https://demo.enginatics.com/

select
x.day_of_week,
x.end_interval_time,
x.instance_number,
xxen_util.time(x.user_io) user_io_,
xxen_util.time(x.application) application_,
xxen_util.time(x.network) network_,
xxen_util.time(x.concurrency) concurrency_,
xxen_util.time(x.commit) commit_,
xxen_util.time(x.other) other_,
xxen_util.time(x.configuration) configuration_,
xxen_util.time(x.scheduler) scheduler_,
xxen_util.time(x.system_io) system_io_,
xxen_util.time(x.administrative) administrative_,
x.user_io,
x.user_io_waits,
x.user_io_timeouts,
x.application,
x.application_waits,
x.application_timeouts,
x.network,
x.network_waits,
x.network_timeouts,
x.concurrency,
x.concurrency_waits,
x.concurrency_timeouts,
x.commit,
x.commit_waits,
x.commit_timeouts,
x.other,
x.other_waits,
x.other_timeouts,
x.configuration,
x.configuration_waits,
x.configuration_timeouts,
x.scheduler,
x.scheduler_waits,
x.scheduler_timeouts,
x.system_io,
x.system_io_waits,
x.system_io_timeouts,
x.administrative,
x.administrative_waits,
x.administrative_timeouts
from
(
select
to_char(xxen_util.client_time(dhs.end_interval_time),'Day') day_of_week,
xxen_util.client_time(dhs.end_interval_time) end_interval_time,
dhs.instance_number,
dhse.wait_class,
case when dhse.time_delta<0 then dhse.time_micro else dhse.time_delta end/1000000 seconds,
case when dhse.waits_delta<0 then dhse.waits else dhse.waits_delta end waits,
case when dhse.timeouts_delta<0 then dhse.timeouts else dhse.timeouts_delta end timeouts
from
dba_hist_snapshot dhs,
(
select
dhse.time_micro-lag(dhse.time_micro) over (partition by dhse.dbid, dhse.instance_number, dhse.wait_class, dhse.event_name order by dhse.snap_id) time_delta,
dhse.waits-lag(dhse.waits) over (partition by dhse.dbid, dhse.instance_number, dhse.wait_class, dhse.event_name order by dhse.snap_id) waits_delta,
dhse.timeouts-lag(dhse.timeouts) over (partition by dhse.dbid, dhse.instance_number, dhse.wait_class, dhse.event_name order by dhse.snap_id) timeouts_delta,
dhse.*
from
(
select
decode(:session_type,'Foreground',dhse.time_waited_micro_fg,'Background',dhse.time_waited_micro-dhse.time_waited_micro_fg,dhse.time_waited_micro) time_micro,
decode(:session_type,'Foreground',dhse.total_waits_fg,'Background',dhse.total_waits-dhse.total_waits_fg,dhse.total_waits) waits,
decode(:session_type,'Foreground',dhse.total_timeouts_fg,'Background',dhse.total_timeouts-dhse.total_timeouts_fg,dhse.total_timeouts) timeouts,
dhse.*
from
dba_hist_system_event dhse
) dhse
) dhse
where
1=1 and
dhse.wait_class<>'Idle' and
dhs.dbid=dhse.dbid and
dhs.instance_number=dhse.instance_number and
dhs.snap_id=dhse.snap_id
)
pivot (
sum(case when seconds>0 then seconds end),
sum(case when waits>0 then waits end) waits,
sum(case when timeouts>0 then timeouts end) timeouts
for
wait_class in (
'User I/O' user_io,
'Application' application,
'Network' network,
'Concurrency' concurrency,
'Commit' commit,
'Other' other,
'Configuration' configuration,
'Scheduler' scheduler,
'System I/O' system_io,
'Administrative' administrative
)
) x
order by
x.end_interval_time desc,
x.instance_number