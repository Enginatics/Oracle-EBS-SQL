/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR Latch by Time
-- Description: Latch contention wait time history.
Each row shows the system-wide latch contention wait time per latch name of one AWR snapshot interval to identify high latch contention at specific times.
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-latch-by-time/
-- Library Link: https://www.enginatics.com/reports/dba-awr-latch-by-time/
-- Run Report: https://demo.enginatics.com/

select
x.day_of_week,
x.end_interval_time,
x.instance_number,
&columns
from
(
select
to_char(xxen_util.client_time(dhs.end_interval_time),'Day') day_of_week,
xxen_util.client_time(dhs.end_interval_time) end_interval_time,
dhs.instance_number,
dhl.latch_name,
case when dhl.time_delta<0 then dhl.wait_time else dhl.time_delta end/1000000 seconds
from
dba_hist_snapshot dhs,
(
select
dhl.wait_time-lag(dhl.wait_time) over (partition by dhl.dbid, dhl.instance_number, dhl.latch_name order by dhl.snap_id) time_delta,
dhl.*
from
dba_hist_latch dhl
) dhl
where
1=1 and
dhs.dbid=dhl.dbid and
dhs.instance_number=dhl.instance_number and
dhs.snap_id=dhl.snap_id
)
pivot (
sum(case when seconds>0 then seconds end)
for
latch_name in (
&pivot_columns
)
) x
order by
x.end_interval_time desc,
x.instance_number