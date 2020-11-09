/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR SQL Performance Summary
-- Description: Database SQL performance summary from the Automatic Workload Repository (AWR) tables to give an overview of top SQL load and performance issues.
The report shows the summarized execution stats such as elapsed time and IO figures for a certain timeframe for individual SQL_ID and plan hash value combinations.
All IO figures are shown in MB.

Parameter 'Level' can be switched to aggregate data either by Module or by individual SQL and to show summarised figures or to split them by day.
Parameter 'Time Restriction' can be set to show either daytime or nightbatch figures only.

For SQL IO tuning or database server load optimization, a sorting by IO is recommended to show the most IO intensive SQLs on top.
Non server or SQL IO related performance bottlenecks, such as wait time caused by Network e.g. 'SQL*Net message from dblink', can be spotted when sorting by 'elapsed time' instead of IO.

Columns:

- Responsibility: Derived from the SGA's action column for initialized EBS sessions.
- Module Name: Derived from the SGA's module column for initialized EBS sessions.
- Module: SGA's module. Please note that if the same SQL is executed by different modules, it appears only once in this report. Thus, the module name column could be misleading as it shows the name of the first module parsing the SQL only.
-Code and Code Line#: Code package and line number of the SQL, in case it is still in the cursor cache
-Sql Id: Hash identifier for an individual SQL.
-Plan Hash Value: Hash identifier for one particular execution plan. Please note that similar but different SQLs might share exactly the same plan hash value if their execution path is identical.
-Sql Text
-Executions: Total number of executions
-Elapsed Time: Total elapsed time in seconds
-Time: Total elapsed time in a readable format split into days, hours, minutes and seconds
-User Io Wait Time: Total elapsed time in seconds from wait event class 'User I/O'
-Cpu Time: Total elapsed time in seconds that the SQL spent on CPU. High figures here usually indicate that massive amounts of data are read from the buffer cache
-Plsql Exec Time: Total elapsed time in seconds for PLSQL execution
-Concurrency Wait Time: Total elapsed time in seconds from wait event class 'Concurrency' e.g. 'buffer busy waits' or 'enq: TX - index contention'
-Application Wait Time: Total elapsed time in seconds from wait event class 'Application' e.g. 'enq: TX - row lock contention', an uncommitted session's update blocking another session.
-Time Exec: Average elapsed time per execution
-Buffer IO: Total buffer IO in megabtes. This is the most important figure to look at from a server load perspective.
-Disk IO: Total physical IO
-IO Exec: Total IO per execution.
-Rows Exec: Average number of rows per execution
-IO Row: Average IO per individual row retrieved. For data extraction SQLs without any sort of data aggregation, the average IO per row is a good indication if the IO spent is reasonable or if the SQL executes efficiently or not.
-IO Sec: Average IO in MB per second during SQL execution time.
-IO Sec Avg: Average IO in MB per second per overall server time (to indicate the average IO server load of the individual SQL).
-Execs Per Hour: Number of SQL executions per hour
-Time Percentage: Average percentage of the overall server time that the SQL is running. 50% indicates a SQL is running half of the server time, 400% means the same SQL is running constantly 4 times in parallel
-Is Bind Sensitive: Indicates the DB's 'adaptive cursor sharing' feature. A value of 'Y' means, the DB might consider a different explainplan for different bind values. Note that for transactional SQLs such as the ones used by Oracle EBS, the execution path should usually not change. Thus, a value of 'Y' often indicates 'instable' SQLs or SQLs where the optimizer struggles to find the best execution path.
-Is Bind Aware: 'adaptive cursor sharing' feature. A value of 'Y' means, the DB considers a differ
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-sql-performance-summary/
-- Library Link: https://www.enginatics.com/reports/dba-awr-sql-performance-summary/
-- Run Report: https://demo.enginatics.com/

select
&column0
decode(x.row_number,null,
&order_by/sum(decode(x.row_number,null,&order_by)) over ()*100
) percentage,
&column1
xxen_util.responsibility(x.module,x.action) responsibility,
xxen_util.module_type(x.module,x.action) module_type,
xxen_util.module_name(x.module) module_name,
x.module,
&column2
&bind_columns
decode(x.row_number,null,x.executions) executions,
xxen_util.time(x.elapsed_time) time,
decode(x.row_number,null,x.elapsed_time) elapsed_time,
decode(x.row_number,null,x.user_io_wait_time) user_io_wait_time,
decode(x.row_number,null,x.cpu_time) cpu_time,
decode(x.row_number,null,x.plsql_exec_time) plsql_exec_time,
decode(x.row_number,null,x.concurrency_wait_time) concurrency_wait_time,
decode(x.row_number,null,x.application_wait_time) application_wait_time,
x.time_exec,
decode(x.row_number,null,x.buffer_io) buffer_io,
decode(x.row_number,null,x.disk_io) disk_io,
x.io_exec,
x.blocks_exec,
x.rows_processed,
x.rows_exec,
x.io_row,
x.blocks_row,
x.io_sec,
case when x.executions>100 then x.buffer_io/(decode(x.last_load_time,x.first_load_time,to_date(null),x.last_load_time)-x.first_load_time)/24/3600 end io_sec_avg,
x.buffer_rate,
x.disk_rate,
x.disk_percentage,
case when x.executions>100 then x.executions/(decode(x.last_load_time,x.first_load_time,to_date(null),x.last_load_time)-x.first_load_time)/24/3600 end execs_per_sec,
case when x.executions>100 then 100*x.elapsed_time/(decode(x.last_load_time,x.first_load_time,to_date(null),x.last_load_time)-x.first_load_time)/24/3600 end time_percentage,
&column3
x.parsing_schema_name schema,
x.parse_calls,
x.sorts,
xxen_util.client_time(x.first_load_time) first_load_time,
xxen_util.client_time(x.last_load_time) last_load_time,
&column4
x.action
from
(
select
decode(row_number() over (partition by x0.inst_num, x0.date_, x0.sql_id, x0.plan_hash_value, x0.capture_date order by x0.position),1,null,2) row_number,
x0.elapsed_time/xxen_util.zero_to_null(x0.executions) time_exec,
x0.buffer_io/xxen_util.zero_to_null(x0.executions) io_exec,
x0.buffer_gets/xxen_util.zero_to_null(x0.executions) blocks_exec,
x0.rows_processed/xxen_util.zero_to_null(x0.executions) rows_exec,
x0.buffer_io/xxen_util.zero_to_null(x0.rows_processed) io_row,
x0.buffer_gets/xxen_util.zero_to_null(x0.rows_processed) blocks_row,
x0.buffer_io/xxen_util.zero_to_null(x0.elapsed_time) io_sec,
(x0.buffer_io-x0.disk_io)/xxen_util.zero_to_null(x0.cpu_time) buffer_rate,
x0.disk_io/xxen_util.zero_to_null(x0.user_io_wait_time) disk_rate,
100*x0.disk_io/xxen_util.zero_to_null(x0.buffer_io) disk_percentage,
x0.*
from
(
select distinct
case when :aggregate_level like '% instance' then dhss.instance_number end inst_num,
case when :aggregate_level like '% per day%' then dhs.date_ end date_,
case when :aggregate_level like 'SQL%' then max(dhss.module) over (&partition_by) else dhss.module end module,
case when :aggregate_level like 'SQL%' then max(dhss.action) over (&partition_by) else dhss.action end action,
sum(dhss.elapsed_time_delta) over (&partition_by)/1000000 elapsed_time,
sum(dhss.iowait_delta) over (&partition_by)/1000000 user_io_wait_time,
sum(dhss.cpu_time_delta) over (&partition_by)/1000000 cpu_time,
sum(dhss.plsexec_time_delta) over (&partition_by)/1000000 plsql_exec_time,
sum(dhss.ccwait_delta) over (&partition_by)/1000000 concurrency_wait_time,
sum(dhss.apwait_delta) over (&partition_by)/1000000 application_wait_time,
vp.value*sum(dhss.buffer_gets_delta) over (&partition_by)/1000000 buffer_io,
sum(dhss.buffer_gets_delta) over (&partition_by) buffer_gets,
sum(dhss.physical_read_bytes_delta) over (&partition_by)/1000000 disk_io,
sum(dhss.executions_delta) over (&partition_by) executions,
sum(dhss.rows_processed_delta) over (&partition_by) rows_processed,
min(dhss.parsing_schema_name) over (&partition_by) parsing_schema_name,
sum(dhss.parse_calls_delta) over (&partition_by) parse_calls,
sum(dhss.sorts_delta) over (&partition_by) sorts,
min(dhs.begin_interval_time_) over (&partition_by) first_load_time,
max(dhs.end_interval_time_) over (&partition_by) last_load_time,
case when :aggregate_level like 'SQL%' then dhss.sql_id end sql_id,
case when :aggregate_level like 'SQL%' then dhss.plan_hash_value end plan_hash_value,
case when :aggregate_level like 'SQL%' then decode(dhst.command_type,1,'create table',2,'insert',3,'select',6,'update',7,'delete',9,'create index',11,'alter index',26,'lock table',42,'alter session',44,'commit',45,'rollback',46,'savepoint',47,'pl/sql block',48,'set transaction',50,'explain',62,'analyze table',90,'set constraints',170,'call',189,'merge','other') end command_type,
gsa.is_bind_sensitive,
gsa.is_bind_aware,
(select so.name from sys.obj$ so where gsa.program_id=so.obj#) code,
case when gsa.program_line#>0 then gsa.program_line# end code_line#,
dhsb.name bind,
dhsb.value_string bind_value,
dhsb.last_captured capture_date,
dhsb.position,
dhs.dbid
from
(
select trunc(dhs.begin_interval_time) date_,
cast(dhs.begin_interval_time as date) begin_interval_time_,
cast(dhs.end_interval_time as date) end_interval_time_,
dhs.*
from
dba_hist_snapshot dhs
) dhs,
dba_hist_sqlstat dhss,
dba_hist_sqltext dhst,
(
select
wsbm.bind.last_captured last_captured,
case
when wsbm.bind.datatype_string like 'TIMESTAMP%' then to_char(anydata.accesstimestamp(wsbm.bind.value_anydata))
when wsbm.bind.datatype_string='DATE' then to_char(anydata.accessdate(wsbm.bind.value_anydata))
else wsbm.bind.value_string
end value_string,
wsbm.*
from
(
select
ws.dbid,
ws.snap_id,
ws.instance_number,
ws.sql_id,
ws.plan_hash_value,
wsbm.name,
wsbm.position,
dbms_sqltune.extract_bind(ws.bind_data, wsbm.position) bind
from
sys.wrh$_sqlstat ws,
(
select distinct
min(wsbm.position) over (partition by wsbm.dbid, wsbm.sql_id, wsbm.name) position,
wsbm.dbid,
wsbm.sql_id,
wsbm.name
from
sys.wrh$_sql_bind_metadata wsbm
where
'&show_binds'='Y'
) wsbm
where
ws.dbid=wsbm.dbid and
ws.sql_id=wsbm.sql_id
) wsbm
where
wsbm.bind is not null
) dhsb,
(
select distinct
gsa.sql_id,
min(gsa.inst_id) keep (dense_rank first order by gsa.inst_id, gsa.plan_hash_value) over (partition by gsa.sql_id) inst_id,
min(gsa.plan_hash_value) keep (dense_rank first order by gsa.inst_id, gsa.plan_hash_value) over (partition by gsa.sql_id) plan_hash_value
from
gv$sqlarea gsa
where
2=2 and
'&enable_sql'='Y'
) gsa0,
gv$sqlarea gsa,
(select vp.value from v$parameter vp where vp.name like 'db_block_size') vp
where
1=1 and
dhs.dbid=(select vd.dbid from v$database vd) and
dhs.dbid=dhss.dbid and
dhs.instance_number=dhss.instance_number and
dhs.snap_id=dhss.snap_id and
dhss.dbid=dhst.dbid and
dhss.sql_id=dhst.sql_id and
dhss.sql_id=gsa0.sql_id(+) and
gsa0.sql_id=gsa.sql_id(+) and
gsa0.inst_id=gsa.inst_id(+) and
gsa0.plan_hash_value=gsa.plan_hash_value(+) and
dhss.dbid=dhsb.dbid(+) and
dhss.instance_number=dhsb.instance_number(+) and
dhss.snap_id=dhsb.snap_id(+) and
dhss.sql_id=dhsb.sql_id(+)
) x0
) x
order by
case when :aggregate_level in ('Module per day','SQL per day') then x.date_ end desc,
&order_by desc nulls last
&bind_order