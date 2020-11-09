/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA SGA SQL Performance Summary
-- Description: Database SQL performance summary from the SGA to give an overview of top SQL load and performance issues.
The purpose of this report, compared to 'DBA AWR SQL Performance Summary' is to retrieve SQLs which are not in the AWR, either becasue they ran after the most recent snapshot or because their performance impact is too small to be written to the AWR (see topnsql https://docs.oracle.com/database/121/ARPLS/d_workload_repos.htm#ARPLS69140).
This is useful for example to:
-Identify SQLs executed by a particular program or UI function without running a trace. Navigate to the UI functionality first, then directly after, execute this report and restrict to the module name in question. Sort by column 'Last Active Time'
-Identify SQLs and example bind variables to reproduce a SQL execution in a DB access tool. Switch parameter 'Show Bind Values' to 'Yes'
-Identify SQLs incorrectly using literals instead of binds. Set parameter 'Literals Duplication Count' to a value bigger than zero to show all SQLs which are at least duplicated this numer of times.
-- Excel Examle Output: https://www.enginatics.com/example/dba-sga-sql-performance-summary/
-- Library Link: https://www.enginatics.com/reports/dba-sga-sql-performance-summary/
-- Run Report: https://demo.enginatics.com/

select
gsa.inst_id,
decode(gsbc.row_number,null,
&order_by/xxen_util.zero_to_null(sum(decode(gsbc.row_number,null,&order_by)) over (partition by gsa.inst_id))*100
) percentage,
xxen_util.responsibility(gsa.module,gsa.action) responsibility,
xxen_util.module_type(gsa.module,gsa.action) module_type,
xxen_util.module_name(gsa.module) module_name,
gsa.module,
gsa.code,
case when gsa.program_line#>0 then gsa.program_line# end code_line#,
&literals_columns
gsa.sql_id,
gsa.plan_hash_value,
gsa.sql_fulltext sql_text,
&bind_columns
decode(gsbc.row_number,null,gsa.executions*gsa.time_factor) executions,
xxen_util.time(gsa.elapsed_time*gsa.time_factor/1000000) time,
decode(gsbc.row_number,null,gsa.elapsed_time*gsa.time_factor/1000000) elapsed_time,
decode(gsbc.row_number,null,gsa.user_io_wait_time*gsa.time_factor/1000000) user_io_wait_time,
decode(gsbc.row_number,null,gsa.cpu_time*gsa.time_factor/1000000) cpu_time,
decode(gsbc.row_number,null,gsa.plsql_exec_time*gsa.time_factor/1000000) plsql_exec_time,
decode(gsbc.row_number,null,gsa.concurrency_wait_time*gsa.time_factor/1000000) concurrency_wait_time,
decode(gsbc.row_number,null,gsa.application_wait_time*gsa.time_factor/1000000) application_wait_time,
gsa.time_exec*gsa.time_factor time_exec,
decode(gsbc.row_number,null,gsa.buffer_io*gsa.time_factor) buffer_io,
decode(gsbc.row_number,null,gsa.disk_io*gsa.time_factor) disk_io,
gsa.io_exec,
gsa.blocks_exec,
gsa.rows_processed*gsa.time_factor rows_processed,
gsa.rows_processed/gsa.executions_ rows_exec,
gsa.buffer_io/gsa.rows_processed_ io_row,
gsa.buffer_gets/gsa.rows_processed_ blocks_row,
1000000*gsa.buffer_io/xxen_util.zero_to_null(gsa.elapsed_time) io_sec,
case when gsa.executions>100 then gsa.buffer_io/gsa.seconds end io_sec_avg,
1000000*(gsa.buffer_io-gsa.disk_io)/xxen_util.zero_to_null(gsa.cpu_time) buffer_rate,
1000000*gsa.disk_io/xxen_util.zero_to_null(gsa.user_io_wait_time) disk_rate,
100*gsa.disk_io/xxen_util.zero_to_null(gsa.buffer_io) disk_percentage,
case when gsa.executions>100 then gsa.executions/gsa.seconds*3600 end execs_per_hour,
case when gsa.executions>100 then 100*gsa.elapsed_time/1000000/gsa.seconds end time_percentage,
gsa.is_bind_sensitive,
gsa.is_bind_aware,
gsa.parsing_schema_name schema,
gsa.parse_calls,
gsa.sorts,
xxen_util.client_time(to_date(gsa.first_load_time,'YYYY-MM-DD/HH24:MI:SS')) first_load_time,
xxen_util.client_time(gsa.last_active_time) last_active_time,
decode(gsa.command_type,1,'create table',2,'insert',3,'select',6,'update',7,'delete',9,'create index',11,'alter index',26,'lock table',42,'alter session',44,'commit',45,'rollback',46,'savepoint',47,'pl/sql block',48,'set transaction',50,'explain',62,'analyze table',90,'set constraints',170,'call',189,'merge','other') command_type,
gsa.action
from
(
select
gsa.elapsed_time/1000000/xxen_util.zero_to_null(gsa.executions) time_exec,
vp.value*gsa.buffer_gets/1000000/xxen_util.zero_to_null(gsa.executions) io_exec,
gsa.buffer_gets/xxen_util.zero_to_null(gsa.executions) blocks_exec,
xxen_util.zero_to_null(gsa.executions) executions_,
xxen_util.zero_to_null(gsa.rows_processed) rows_processed_,
vp.value*gsa.buffer_gets/1000000 buffer_io,
vp.value*gsa.disk_reads/1000000 disk_io,
xxen_util.zero_to_null(sysdate-to_date(gsa.first_load_time,'YYYY-MM-DD/HH24:MI:SS'))*86400 seconds,
nvl2(:time_basis_days,:time_basis_days/xxen_util.zero_to_null(sysdate-to_date(gsa.first_load_time,'YYYY-MM-DD/HH24:MI:SS')),1) time_factor,
gsa.*,
(select so.name from sys.obj$ so where gsa.program_id=so.obj#) code,
count(distinct decode(gsa.force_matching_signature,0,null,gsa.sql_id)) over (partition by gsa.force_matching_signature) literals_dupl_count,
row_number() over (partition by gsa.force_matching_signature order by gsa.inst_id,gsa.sql_id,gsa.plan_hash_value) literals_row_number
from
(select vp.value from v$parameter vp where vp.name like 'db_block_size') vp,
gv$sqlarea gsa
where
1=1
) gsa,
(
select
decode(row_number() over (partition by gsbc.inst_id, gsbc.sql_id order by gsbc.child_number desc, gsbc.position),1,null,2) row_number,
gsbc.*
from
(
select distinct
gsbc.inst_id,
gsbc.sql_id,
gsbc.child_number,
gsbc.name,
case
when gsbc.datatype_string like 'TIMESTAMP%' then to_char(anydata.accesstimestamp(gsbc.value_anydata))
when gsbc.datatype_string='DATE' then to_char(anydata.accessdate(gsbc.value_anydata))
else gsbc.value_string
end value_string,
gsbc.last_captured,
min(gsbc.position) over (partition by gsbc.inst_id, gsbc.sql_id, gsbc.child_number, gsbc.name, gsbc.value_string, gsbc.last_captured) position
from
gv$sql_bind_capture gsbc
where
'&show_binds'='Y' and
gsbc.was_captured='YES'
) gsbc
) gsbc
where
2=2 and
gsa.inst_id=gsbc.inst_id(+) and
gsa.sql_id=gsbc.sql_id(+)
order by
&literals_order_by
&order_by desc nulls last,
gsa.sql_id
&bind_order