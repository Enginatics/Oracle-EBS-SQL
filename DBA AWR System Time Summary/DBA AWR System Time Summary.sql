/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR System Time Summary
-- Description: Historic system time model values from the automated workload repository showing how the database time was spent e.g. on excuting SQL, PL/SQL or Java code, parsing statements etc..
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-system-time-summary/
-- Library Link: https://www.enginatics.com/reports/dba-awr-system-time-summary/
-- Run Report: https://demo.enginatics.com/

select
*
from
(
select
&pivot_time1
y.instance_number,
y.stat_name,
&elapsed_time
case when y.stat_name in ('active sessions','active CPU sessions') then to_char(y.delta/1000000/y.time_interval,'fm999g990d00') else xxen_util.time(nvl(y.delta/1000000,0)) end time_
from
(
select distinct
&pivot_time2
x.instance_number,
x.stat_name,
greatest(0, max(x.value) over (partition by x.stat_name, x.dbid, x.instance_number &pivot_partition2)-
&delta_prev_value) delta,
sum(x.time_interval) over (partition by x.stat_name, x.dbid, x.instance_number &time_partition_by) time_interval
from
(
select
to_char(xxen_util.client_time(dhs.end_interval_time),'Day') day_of_week,
xxen_util.client_time(dhs.end_interval_time) end_interval_time,
(cast(dhs.end_interval_time as date)-cast(dhs.begin_interval_time as date))*86400 time_interval,
dhstm.dbid,
dhstm.instance_number,
case
when dhstm.stat_name='parse time elapsed' then 'soft parse elapsed time'
when dhstm.stat_name='background elapsed time' then 'background elapsed other'
when dhstm.stat_name='background cpu time' then 'background cpu other'
else dhstm.stat_name end stat_name,
case
when dhstm.stat_name='parse time elapsed' then greatest(0,dhstm.value-sum(case when dhstm.stat_name in ('hard parse elapsed time','failed parse elapsed time') then dhstm.value end) over (partition by dhstm.snap_id,dhstm.dbid,dhstm.instance_number))
when dhstm.stat_name='background elapsed time' then greatest(0,dhstm.value-sum(case when dhstm.stat_name='background cpu time' then dhstm.value end) over (partition by dhstm.snap_id,dhstm.dbid,dhstm.instance_number))
when dhstm.stat_name='background cpu time' then greatest(0,dhstm.value-sum(case when dhstm.stat_name='RMAN cpu time (backup/restore)' then dhstm.value end) over (partition by dhstm.snap_id,dhstm.dbid,dhstm.instance_number))
else dhstm.value end value
from
dba_hist_snapshot dhs,
(
select dhstm.dbid, dhstm.instance_number, dhstm.snap_id, dhstm.stat_name, dhstm.value from dba_hist_sys_time_model dhstm union all
select dhstm.dbid, dhstm.instance_number, dhstm.snap_id, decode(dhstm.stat_name,'DB time','active sessions','active CPU sessions') stat_name, dhstm.value from dba_hist_sys_time_model dhstm where dhstm.stat_name in ('DB time','DB CPU')
) dhstm
where
1=1 and
dhstm.stat_name not in (
'hard parse (sharing criteria) elapsed time',
'hard parse (bind mismatch) elapsed time',
'failed parse (out of shared memory) elapsed time'
) and
dhs.snap_id=dhstm.snap_id and
dhs.dbid=dhstm.dbid and
dhs.instance_number=dhstm.instance_number
) x
) y
order by nvl(y.delta,0) desc
)
&pivot