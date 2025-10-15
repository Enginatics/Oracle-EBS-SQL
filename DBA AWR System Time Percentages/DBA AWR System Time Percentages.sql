/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR System Time Percentages
-- Description: Historic system time model values from the automated workload repository showing a breakdown of how much percent of the database time was spent e.g. on excuting SQL, PL/SQL or Java code, parsing statements etc..

To see data in this report based on dba_hist_sys_time_model, set the following:
alter session set container=PDB1;
alter system set awr_pdb_autoflush_enabled=true;

<a href="https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/" rel="nofollow" target="_blank">https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/</a>
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-system-time-percentages/
-- Library Link: https://www.enginatics.com/reports/dba-awr-system-time-percentages/
-- Run Report: https://demo.enginatics.com/

select
*
from
(
select
&pivot_time1
y.stat_name,
nvl(100*y.delta/xxen_util.zero_to_null(sum(y.delta) over (&pivot_partition1)),0) percentage
from
(
select distinct
&pivot_time2
x.stat_name,
greatest(0, max(x.value) over (partition by x.stat_id, x.dbid, x.instance_number &pivot_partition2)-
&delta_prev_value) delta
from
(
select
to_char(xxen_util.client_time(dhs.end_interval_time),'Day') day_of_week,
xxen_util.client_time(dhs.end_interval_time) end_interval_time,
dhstm.stat_id,
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
dba_hist_sys_time_model dhstm
where
1=1 and
dhstm.stat_name not in (
'DB time',
'DB CPU',
'hard parse (sharing criteria) elapsed time',
'hard parse (bind mismatch) elapsed time',
'failed parse (out of shared memory) elapsed time'
) and
dhs.snap_id=dhstm.snap_id and
dhs.dbid=dhstm.dbid and
dhs.instance_number=dhstm.instance_number
) x
) y
order by
percentage desc
)
&pivot