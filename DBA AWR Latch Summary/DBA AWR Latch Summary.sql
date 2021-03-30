/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR Latch Summary
-- Description: Summary of latch statistics such as misses and wait times for a specified snapshot time interval
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-latch-summary/
-- Library Link: https://www.enginatics.com/reports/dba-awr-latch-summary/
-- Run Report: https://demo.enginatics.com/

select
x.seconds/xxen_util.zero_to_null(sum(x.seconds) over ())*100 percentage,
&columns
x.latch_name,
x.seconds,
xxen_util.time(x.seconds) time,
x.misses,
x.sleeps,
x.immediate_gets,
x.immediate_misses,
x.spin_gets,
x.level#
from
(
select distinct
&columns
dhl.latch_name,
round(sum(case when dhl.wait_time_<0 then dhl.wait_time else dhl.wait_time_ end) over (partition by dhl.latch_name &partition_by)/1000000) seconds,
sum(case when dhl.misses_<0 then dhl.misses else dhl.misses_ end) over (partition by dhl.latch_name &partition_by) misses,
sum(case when dhl.sleeps_<0 then dhl.sleeps else dhl.sleeps_ end) over (partition by dhl.latch_name &partition_by) sleeps,
sum(case when dhl.immediate_gets_<0 then dhl.immediate_gets else dhl.immediate_gets_ end) over (partition by dhl.latch_name &partition_by) immediate_gets,
sum(case when dhl.immediate_misses_<0 then dhl.immediate_misses else dhl.immediate_misses_ end) over (partition by dhl.latch_name &partition_by) immediate_misses,
sum(case when dhl.spin_gets_<0 then dhl.spin_gets else dhl.spin_gets_ end) over (partition by dhl.latch_name &partition_by) spin_gets,
dhl.level#
from
(
select
dhl.gets-lag(dhl.gets) over (partition by dhl.dbid, dhl.instance_number, dhl.latch_name order by dhl.snap_id) gets_,
dhl.misses-lag(dhl.misses) over (partition by dhl.dbid, dhl.instance_number, dhl.latch_name order by dhl.snap_id) misses_,
dhl.sleeps-lag(dhl.sleeps) over (partition by dhl.dbid, dhl.instance_number, dhl.latch_name order by dhl.snap_id) sleeps_,
dhl.immediate_gets-lag(dhl.immediate_gets) over (partition by dhl.dbid, dhl.instance_number, dhl.latch_name order by dhl.snap_id) immediate_gets_,
dhl.immediate_misses-lag(dhl.immediate_misses) over (partition by dhl.dbid, dhl.instance_number, dhl.latch_name order by dhl.snap_id) immediate_misses_,
dhl.spin_gets-lag(dhl.spin_gets) over (partition by dhl.dbid, dhl.instance_number, dhl.latch_name order by dhl.snap_id) spin_gets_,
dhl.wait_time-lag(dhl.wait_time) over (partition by dhl.dbid, dhl.instance_number, dhl.latch_name order by dhl.snap_id) wait_time_,
dhl.*
from
dba_hist_snapshot dhs,
dba_hist_latch dhl
where
1=1 and
dhs.dbid=(select vd.dbid from v$database vd) and
dhs.dbid=dhl.dbid and
dhs.instance_number=dhl.instance_number and
dhs.snap_id=dhl.snap_id
) dhl
where
dhl.wait_time_>=0
) x
where
x.seconds>0 or
x.misses>0
order by
x.seconds desc,
x.misses desc,
x.latch_name