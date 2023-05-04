/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA SGA+PGA Memory Configuration
-- Description: Current SGA and PGA memory configuration in gigabytes.

A frequent configuration problem is not making full use of the available hardware resources, especially the physical RAM of the database server.
This report shows the servers SGA, PGA and CPU configuration in comparison to the available hardware.
For maximum performance, configure the SGA+PGA to use the full available memory of your server minus a few gig for OS level caching, e.g. for writing and reading of PLSQL output files on the DB node and for process memory (an estimated 4MB per process, see below).

Oracle's performance tuning guide:
<a href="https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgdba/database-memory-allocation.html" rel="nofollow" target="_blank">https://docs.oracle.com/en/database/oracle/oracle-database/12.2/tgdba/database-memory-allocation.html</a>

Oracle's exadata best practices whitepaper:
SUM of databases (SGA_TARGET + PGA_AGGREGATE_TARGET) + 4 MB * (Maximum PROCESSES) < Physical Memory per Database Node

Tom Kyte's recommendation:
"... if you want it all automatic, give ALL FREE MEMORY on your machine to the SGA and be done with it. No more monitoring, no more thinking about how it could be, should be, would be used.
Set the PGA aggregate target and the SGA target to be a tad less than physical memory on the machine and you are done."
<a href="https://asktom.oracle.com/pls/asktom/f?p=100:11:0::::P11_QUESTION_ID:30011178429375" rel="nofollow" target="_blank">https://asktom.oracle.com/pls/asktom/f?p=100:11:0::::P11_QUESTION_ID:30011178429375</a>

The report also shows the status of system statistics.
select * from sys.aux_stats$

If CPUSPEEDNW still shows the default of 4096, it either means that the stats have never been gathered or it could also mean that your storage is too fast to gather them with the standard NOWORKLOAD method and you should set reasonable values manually then.
exec dbms_stats.gather_system_stats();
exec dbms_stats.set_system_stats('IOSEEKTIM',1);
exec dbms_stats.set_system_stats('IOTFRSPEED',85782);

There is also an Exadata mode, considering the faster storage correctly and updating the MBRC too
exec dbms_stats.gather_system_stats(‘EXADATA');

The following command checks if hugepages are configured and how many are in use:
grep Huge /proc/meminfo
<a href="https://access.redhat.com/solutions/320303" rel="nofollow" target="_blank">https://access.redhat.com/solutions/320303</a>

Check if all database parameters are set according to Oracle's requirement:
Database Initialization Parameters for Oracle E-Business Suite Release 12 (Note 396009.1)
<a href="https://support.oracle.com/rs?type=doc&id=396009.1" rel="nofollow" target="_blank">https://support.oracle.com/rs?type=doc&id=396009.1</a>

To perform this check automatically, install and run Oracle's 'Database Performance and Statistics Analyzer' concurrent program (Doc ID 2126712.1)
<a href="https://support.oracle.com/rs?type=doc&id=2126712.1" rel="nofollow" target="_blank">https://support.oracle.com/rs?type=doc&id=2126712.1</a>
-- Excel Examle Output: https://www.enginatics.com/example/dba-sga-pga-memory-configuration/
-- Library Link: https://www.enginatics.com/reports/dba-sga-pga-memory-configuration/
-- Run Report: https://demo.enginatics.com/

select
*
from
(
select
x.inst_id,
x.name,
case when x.name not like '%cpu%' then x.value/1024/1024/1024 else x.value end value
from
(
select go.inst_id, 'cpu physical' name, go.value, 11 order_by from gv$osstat go where go.stat_name='NUM_CPUS' union all
select go.inst_id, 'memory physical' name, go.value, 1 order_by from gv$osstat go where go.stat_name='PHYSICAL_MEMORY_BYTES' union all
select go.inst_id, 'memory unused' name, go.value-(select sum(gp.value) from gv$parameter gp where go.inst_id=gp.inst_id and gp.name in ('sga_target','memory_target','pga_aggregate_target')) value, 2 order_by from gv$osstat go where go.stat_name='PHYSICAL_MEMORY_BYTES' union all
select gp.inst_id, gp.name, to_number(gp.value) value,
decode(gp.name,
'cpu_count',12,
'sga_max_size',3,
'sga_target',4,
'pga_aggregate_target',5,
'pga_aggregate_limit',6,
'memory_max_target',7,
'memory_target',8,
'result_cache_max_size',9
) order_by
from gv$parameter gp where gp.name in ('cpu_count','pga_aggregate_limit','pga_aggregate_target','sga_max_size','sga_target','memory_max_target','memory_target','result_cache_max_size')
) x
order by
x.inst_id,
x.order_by
)
union all
select * from (select gsi.inst_id, 'free SGA', gsi.bytes/1024/1024/1024 value from gv$sgainfo gsi where gsi.name='Free SGA Memory Available' order by gsi.inst_id)
union all
select * from (
select
gi.inst_id,
'PGA record date: '||least(gi.startup_time,(select min(dhs.begin_interval_time) from dba_hist_snapshot dhs where vd.dbid=dhs.dbid and gi.instance_number=dhs.instance_number)) name,
null value
from
gv$instance gi,
v$database vd
order by gi.inst_id
)
union all
select * from (select
gi.inst_id,
'average PGA' name,
(select avg(dhp.value)/1024/1024/1024 from dba_hist_pgastat dhp where vd.dbid=dhp.dbid and gi.instance_number=dhp.instance_number and dhp.name='total PGA allocated') value
from
gv$instance gi,
v$database vd
order by gi.inst_id
)
union all
select * from (
select
gi.inst_id,
'maximum PGA' name,
(select max(dhp.value)/1024/1024/1024 from dba_hist_pgastat dhp where vd.dbid=dhp.dbid and gi.instance_number=dhp.instance_number and dhp.name='maximum PGA allocated') value
from
gv$instance gi,
v$database vd
order by gi.inst_id
)
union all
select * from (
select distinct dhss.instance_number inst_id, 'Wait IO percentage' name,
sum(dhss.iowait_delta) over (partition by dhss.instance_number)/(sum(dhss.iowait_delta) over (partition by dhss.instance_number)+sum(dhss.cpu_time_delta) over (partition by dhss.instance_number))*100 value
from
dba_hist_snapshot dhs,
dba_hist_sqlstat dhss,
dba_hist_sqltext dhst
where
1=1 and
dhs.begin_interval_time>=sysdate-7 and
dhst.command_type not in (47) and
dhs.dbid=dhss.dbid and
dhs.instance_number=dhss.instance_number and
dhs.snap_id=dhss.snap_id and
dhss.dbid=dhst.dbid and
dhss.sql_id=dhst.sql_id
order by dhss.instance_number
)
union all
select
to_number(null) inst_id,
case when ass.pname='DSTART' then 'System Stats record date: '||ass.pval2 else ass.pname end name,
to_number(decode(ass.pname,'DSTART',null,ass.pval1)) value
from sys.aux_stats$ ass
where
ass.pname in ('DSTART','CPUSPEEDNW','IOSEEKTIM','IOTFRSPEED','MBRC')
union all
select to_number(null) inst_id, 'Use large pages: '||vp.value name, null value from v$parameter vp where vp.name='use_large_pages' union all
select to_number(null) inst_id, 'Pack License: '||vp.value name, null value from v$parameter vp where vp.name='control_management_pack_access' union all
select distinct to_number(null) inst_id, 'AWR Report last usage date: '||max(dfus.last_usage_date) over () name, null value from dba_feature_usage_statistics dfus where dfus.name='AWR Report' and dfus.dbid in (select vd.dbid from v$database vd) union all
select distinct to_number(null) inst_id, 'AWR Report usages' name, sum(dfus.detected_usages) over () value from dba_feature_usage_statistics dfus where dfus.name='AWR Report' and dfus.dbid in (select vd.dbid from v$database vd) union all
select to_number(null) inst_id, 'Database size' name, sum((select vp.value from v$parameter vp where vp.name like 'db_block_size')*dtum.used_space)/1024/1024/1024 value from dba_tablespace_usage_metrics dtum