/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR System Metrics Summary
-- Description: Historic system statistics from the automated workload repository showing CPU load, wait time percentage, logical (buffer/RAM) and physical read and write IO figures, summarized in snapshot time intervals. All IO figures are measured in MB/s.

-CPU%: Total CPU usage percentage. If this is low, the hardware is underused and performance could potentially get improved by using it better e.g. by resolving IO bottlenecks (bigger RAM, faster storage) or parallelization of SQLs and user processes.
-WAIT%: Percentage of time that the DB process spends waiting rather than processing. If the wait% is high and most of the wait time is spend e.g. waiting for IO, then the storage is too slow compared to CPU speed.
-BUFF_READ: Logical IO read from the buffer cache (RAM) in MB/s
-PHYS_READ: Physical IO read from the storage in MB/s
-PHYS_WRITE:  Physical IO written to the storage in MB/s

Note: The UOM calculation from LIOs to MB uses the database default block size and doesn't support different block sizes for different tablespaces.
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-system-metrics-summary/
-- Library Link: https://www.enginatics.com/reports/dba-awr-system-metrics-summary/
-- Run Report: https://demo.enginatics.com/

select
*
from
(
select
x.*
&day_avg1
from
(
select
to_char(xxen_util.client_time(gs.end_time),'Day') day_of_week,
xxen_util.client_time(gs.end_time) end_interval_time,
gs.inst_id instance_number,
gs.metric_name,
gs.unit_factor*gs.value average_,
null maxval_
from
(
select
gs.*,
case
when gs.metric_unit like 'Blocks %' or gs.metric_unit like 'Reads %' or gs.metric_unit like 'Writes %' then vp.value/1000000
when gs.metric_unit like '%Bytes%' then 1/1000000
else 1 end unit_factor
from
(select vp.value from v$parameter vp where vp.name='db_block_size') vp,
(select x.* from (select max(gs.intsize_csec) over (partition by gs.inst_id, gs.metric_id) max_intsize_csec, gs.* from &sysmetric_view) x where x.intsize_csec=x.max_intsize_csec) gs
where
gs.metric_name in (
'Host CPU Utilization (%)',
'Database Wait Time Ratio',
'Average Active Sessions',
'Logical Reads Per Sec',
'Physical Read Total Bytes Per Sec',
'Physical Write Total Bytes Per Sec',
'Redo Generated Per Sec',
'Redo Writes Per Sec',
'User Commits Per Sec',
'Hard Parse Count Per Sec',
'Network Traffic Volume Per Sec'
)
) gs
union all
select
to_char(xxen_util.client_time(dhs.end_interval_time),'Day') day_of_week,
xxen_util.client_time(dhs.end_interval_time) end_interval_time,
dhss.instance_number,
dhss.metric_name,
dhss.average_,
dhss.maxval_
from
dba_hist_snapshot dhs,
(
select
dhss.unit_factor*dhss.average average_,
dhss.unit_factor*dhss.maxval maxval_,
dhss.*
from
(
select
case
when dhss.metric_unit like 'Blocks %' or dhss.metric_unit like 'Reads %' or dhss.metric_unit like 'Writes %' then vp.value/1000000
when dhss.metric_unit like '%Bytes%' then 1/1000000
else 1 end unit_factor,
dhss.*
from
v$parameter vp,
&sysmetric_symmary_view
where
vp.name='db_block_size' and
dhss.metric_name in (
'Host CPU Utilization (%)',
'Database Wait Time Ratio',
'Average Active Sessions',
'Logical Reads Per Sec',
'Physical Read Total Bytes Per Sec',
'Physical Write Total Bytes Per Sec',
'Redo Generated Per Sec',
'Redo Writes Per Sec',
'User Commits Per Sec',
'Hard Parse Count Per Sec',
'Network Traffic Volume Per Sec'
)
) dhss
) dhss
where
1=1 and
dhs.snap_id=dhss.snap_id and
dhs.dbid=dhss.dbid and
dhs.instance_number=dhss.instance_number
) x
)
pivot (
sum(average_) avg,
sum(maxval_) max
&day_avg2
for
metric_name in (
'Host CPU Utilization (%)' "CPU%",
'Database Wait Time Ratio' "WAIT%",
'Average Active Sessions' act_sess,
'Logical Reads Per Sec' buff_read,
'Physical Read Total Bytes Per Sec' phys_read,
'Physical Write Total Bytes Per Sec' phys_write,
'Redo Generated Per Sec' redo_rate,
'Redo Writes Per Sec' redo_writes,
'User Commits Per Sec' commits,
'Hard Parse Count Per Sec' hard_parses,
'Network Traffic Volume Per Sec' network_traffic
)
)
order by
instance_number,
cast(end_interval_time as date) desc