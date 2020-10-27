/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR System Wait Time Summary
-- Description: Summary of database CPU vs. wait times and average active sessions for a specified time frame
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-system-wait-time-summary/
-- Library Link: https://www.enginatics.com/reports/dba-awr-system-wait-time-summary/
-- Run Report: https://demo.enginatics.com/

select
&instance_number
y.seconds/xxen_util.zero_to_null(sum(decode(y.status,'Total DB time',y.seconds)) over ())*100 percentage,
y.status,
xxen_util.time(y.seconds) time,
y.seconds,
y.seconds/y.total_seconds average_active_sessions
from
(
select
&instance_number
nvl(x.stat_name,'WAITING') status,
abs(sum(decode(x.stat_name,'ON CPU',-x.seconds,x.seconds))) seconds,
x.total_seconds
from
(
select distinct
&instance_number
dhstm.stat_name,
sum(case when dhstm.time_delta<0 then dhstm.time_micro else dhstm.time_delta end) over (partition by dhstm.stat_name &partition_by)/1000000 seconds,
(max(dhstm.end_interval_time) over (partition by dhstm.stat_name &partition_by)-min(dhstm.end_interval_time) over (partition by dhstm.stat_name &partition_by))*86400 total_seconds
from
(
select
dhstm.instance_number,
cast(dhs.end_interval_time as date) end_interval_time,
decode(dhstm.stat_name,'DB CPU','ON CPU','Total DB time') stat_name,
dhstm.value time_micro,
dhstm.value-lag(dhstm.value) over (partition by dhstm.dbid, dhstm.instance_number, dhstm.stat_name order by dhstm.snap_id) time_delta
from
dba_hist_snapshot dhs,
dba_hist_sys_time_model dhstm
where
1=1 and
dhstm.stat_name in ('DB CPU','DB time') and
dhs.dbid=(select vd.dbid from v$database vd) and
dhs.dbid=dhstm.dbid and
dhs.instance_number=dhstm.instance_number and
dhs.snap_id=dhstm.snap_id
) dhstm
) x
where
x.seconds>0
group by
x.total_seconds,
rollup(x.stat_name)
) y
order by
seconds desc