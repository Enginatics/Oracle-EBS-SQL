/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA SGA Active Session History
-- Description: Active session history from the SGA.

Parameter 'Blocked Sessions only' allows a blocking screnario root cause analysis, e.g. by doing a pivot in Excel (see example in the online library).
The link to blocking sessions is deliberately nonunique without jointing to sample_id to increase the chance to fetch the blocking session's additional information such as module, action and client_id.
In some cases, such as row lock scenarios, the blocking session is idle and does not show up in the ASH then.
For scenarios where the blocking sessions are active and part of the ASH, Tanel Poder has a treewalk ash_wait_chains.sql, showing the whole chain of ASH records linked by a unique join, including the sample_id:
https://blog.tanelpoder.com/2013/11/06/diagnosing-buffer-busy-waits-with-the-ash_wait_chains-sql-script-v0-2/

We recommend doing ASH performance analysis with a pivot in Excel rather than by SQL, as Excel's drag- and drop is a lot faster than typing commands manually.
A typical use case is to analyze which EBS application user waited for how many seconds in which forms UI and to drill down further into the SQL or wait event root causes then.

Column 'Module Name' shows either the translated EBS module display name or, e.g. for background sessions, the process name (from the program column) to enable pivoting by this column only.
Oracle's background process names are listed here:
https://docs.oracle.com/database/121/REFRN/GUID-86184690-5531-405F-AA05-BB935F57B76D.htm#REFRN104
-- Excel Examle Output: https://www.enginatics.com/example/dba-sga-active-session-history/
-- Library Link: https://www.enginatics.com/reports/dba-sga-active-session-history/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.client_time(gash.sample_time_) sample_time,
gash.inst_id,
gash.session_id||' - '||gash.session_serial# sid_serial#,
xxen_util.user_name(gash.module,gash.action,gash.client_id) user_name,
xxen_util.responsibility(gash.module,gash.action) responsibility,
xxen_util.module_type(gash.module,gash.action) module_type,
xxen_util.module_name(gash.module,gash.program) module_name,
case when lower(gash.module) like '%frm%' then 'Forms' when lower(gash.module) like '%fwk%' then 'OAF' end ui_type,
(select so.name from sys.obj$ so where gsa.program_id=so.obj#) code,
case when gsa.program_line#>0 then gsa.program_line# end code_line#,
gash.sql_id,
gash.sql_plan_hash_value plan_hash_value,
&sql_text
xxen_util.time(count(*) over (partition by gash.inst_id, gash.session_id, gash.session_serial#, gash.sql_id)) time_per_sql,
round(100*(count(*) over (partition by gash.inst_id, gash.session_id, gash.session_serial#, gash.sql_id)/count(*) over (partition by gash.inst_id, gash.session_id, gash.session_serial#)),2) percentage,
gash.sql_exec_id-16777216 execution_count,
xxen_util.client_time(gash.sql_exec_start) sql_exec_start,
dp0.object_name||case when dp0.procedure_name is not null then '.'||dp0.procedure_name end entry_procedure,
dp.object_name||case when dp.procedure_name is not null then '.'||dp.procedure_name end procedure,
xxen_util.time((max(gash.sample_time_) over (partition by gash.inst_id, gash.session_id, gash.session_serial#)-min(gash.sample_time_) over (partition by gash.inst_id, gash.session_id, gash.session_serial#))*86400) sess_duration,
xxen_util.time(count(*) over (partition by gash.inst_id, gash.session_id, gash.session_serial#)) sess_active,
xxen_util.client_time(min(gash.sample_time_) over (partition by gash.inst_id, gash.session_id, gash.session_serial#)) sess_first_time,
xxen_util.client_time(min(gash.sample_time_) over (partition by gash.inst_id, gash.session_id, gash.session_serial#, gash.sql_id)) sql_first_time,
gash.session_type,
gash.session_state,
nvl(gash.event,gash.session_state)||
case
when gash.event like 'enq%' and gash.session_state='WAITING' then ' (mode='||bitand(gash.p1,power(2,14)-1)||')'
when gash.event in ('buffer busy waits','gc buffer busy','gc buffer busy acquire','gc buffer busy release') then ' ('||
coalesce(
(select vw.class from (select vw.class, rownum row_num from v$waitstat vw) vw where gash.p3=vw.row_num),
(select decode(mod(bitand(gash.p3,to_number('FFFF','XXXX'))-17,2),0,'undo header',1,'undo data','error') from dual)
)||')'
end event,
gash.wait_class,
rtrim(
case when bitand(gash.time_model,power(2,01))=power(2,01) then 'DBTIME ' end||
case when bitand(gash.time_model,power(2,02))=power(2,02) then 'BACKGROUND ' end||
case when bitand(gash.time_model,power(2,03))=power(2,03) then 'CONNECTION_MGMT ' end||
case when bitand(gash.time_model,power(2,04))=power(2,04) then 'PARSE ' end||
case when bitand(gash.time_model,power(2,05))=power(2,05) then 'FAILED_PARSE ' end||
case when bitand(gash.time_model,power(2,06))=power(2,06) then 'NOMEM_PARSE ' end||
case when bitand(gash.time_model,power(2,07))=power(2,07) then 'HARD_PARSE ' end||
case when bitand(gash.time_model,power(2,08))=power(2,08) then 'NO_SHARERS_PARSE ' end||
case when bitand(gash.time_model,power(2,09))=power(2,09) then 'BIND_MISMATCH_PARSE ' end||
case when bitand(gash.time_model,power(2,10))=power(2,10) then 'SQL_EXECUTION ' end||
case when bitand(gash.time_model,power(2,11))=power(2,11) then 'PLSQL_EXECUTION ' end||
case when bitand(gash.time_model,power(2,12))=power(2,12) then 'PLSQL_RPC ' end||
case when bitand(gash.time_model,power(2,13))=power(2,13) then 'PLSQL_COMPILATION ' end||
case when bitand(gash.time_model,power(2,14))=power(2,14) then 'JAVA_EXECUTION ' end||
case when bitand(gash.time_model,power(2,15))=power(2,15) then 'BIND ' end||
case when bitand(gash.time_model,power(2,16))=power(2,16) then 'CURSOR_CLOSE ' end||
case when bitand(gash.time_model,power(2,17))=power(2,17) then 'SEQUENCE_LOAD ' end||
case when bitand(gash.time_model,power(2,18))=power(2,18) then 'INMEMORY_QUERY ' end||
case when bitand(gash.time_model,power(2,19))=power(2,19) then 'INMEMORY_POPULATE ' end||
case when bitand(gash.time_model,power(2,20))=power(2,20) then 'INMEMORY_PREPOPULATE ' end||
case when bitand(gash.time_model,power(2,21))=power(2,21) then 'INMEMORY_REPOPULATE ' end||
case when bitand(gash.time_model,power(2,22))=power(2,22) then 'INMEMORY_TREPOPULATE ' end||
case when bitand(gash.time_model,power(2,23))=power(2,23) then 'TABLESPACE_ENCRYPTION ' end
) time_model,
xxen_util.meaning(decode(gash.in_parse,'Y','Y'),'YES_NO',0) in_parse,
xxen_util.meaning(decode(gash.in_hard_parse,'Y','Y'),'YES_NO',0) in_hard_parse,
gash.qc_instance_id,
gash.qc_session_id||nvl2(gash.qc_session_serial#,' - '||gash.qc_session_serial#,null) qc_sid_serial#,
gash.sql_plan_operation,
gash.sql_plan_options,
(select do.owner||'.'||do.object_name||' ('||do.object_type||')' from dba_objects do where gash.current_obj#=do.object_id) object,
decode(gash.blocking_session_status,'VALID','blocked') blocked_status,
gash.blocking_inst_id,
nvl2(gash.blocking_session,gash.blocking_session||' - '||gash.blocking_session_serial#,null) blocking_sid_serial#,
&blocking_columns
gash.pga_allocated/1000000 pga_allocated,
sum(gash.pga_allocated) over (partition by gash.sample_time)/1000000 pga_total,
gash.pga_allocated/xxen_util.zero_to_null(sum(gash.pga_allocated) over (partition by gash.sample_time))*100 pga_percentage,
gash.temp_space_allocated/1000000 temp_space_allocated,
sum(gash.temp_space_allocated) over (partition by gash.sample_time)/1000000 temp_space_total,
gash.temp_space_allocated/xxen_util.zero_to_null(sum(gash.temp_space_allocated) over (partition by gash.sample_time))*100 temp_space_percentage,
count(*) over (partition by gash.sample_time) active_sessions,
gash.machine,
lower(gash.sql_opname) command_type,
du.username schema,
gash.action,
gash.module,
gash.program
from
&request_id_table
(select cast(gash.sample_time as date) sample_time_, gash.* from gv$active_session_history gash) gash,
(
select distinct
gash.inst_id,
gash.session_id,
gash.session_serial#,
max(gash.client_id) keep (dense_rank last order by gash.sample_id) over (partition by gash.inst_id,gash.session_id,gash.session_serial#) client_id,
max(gash.action) keep (dense_rank last order by gash.sample_id) over (partition by gash.inst_id,gash.session_id,gash.session_serial#) action,
max(gash.module) keep (dense_rank last order by gash.sample_id) over (partition by gash.inst_id,gash.session_id,gash.session_serial#) module,
max(gash.program) keep (dense_rank last order by gash.sample_id) over (partition by gash.inst_id,gash.session_id,gash.session_serial#) program,
max(gash.session_type) keep (dense_rank last order by gash.sample_id) over (partition by gash.inst_id,gash.session_id,gash.session_serial#) session_type,
max(gash.machine) keep (dense_rank last order by gash.sample_id) over (partition by gash.inst_id,gash.session_id,gash.session_serial#) machine
from
gv$active_session_history gash
where
'&show_blocking_session'='Y'
) gash0,
dba_procedures dp0,
dba_procedures dp,
(
select distinct
gsa.sql_id,
min(gsa.inst_id) keep (dense_rank first order by gsa.inst_id, gsa.plan_hash_value) over (partition by gsa.sql_id) inst_id,
min(gsa.plan_hash_value) keep (dense_rank first order by gsa.inst_id, gsa.plan_hash_value) over (partition by gsa.sql_id) plan_hash_value
from
gv$sqlarea gsa
) gsa0,
gv$sqlarea gsa,
dba_users du
where
1=1 and
gash.plsql_entry_object_id=dp0.object_id(+) and
gash.plsql_entry_subprogram_id=dp0.subprogram_id(+) and
gash.plsql_object_id=dp.object_id(+) and
gash.plsql_subprogram_id=dp.subprogram_id(+) and
gash.sql_id=gsa0.sql_id(+) and
gsa0.sql_id=gsa.sql_id(+) and
gsa0.inst_id=gsa.inst_id(+) and
gsa0.plan_hash_value=gsa.plan_hash_value(+) and
gash.user_id=du.user_id(+) and
gash.blocking_inst_id=gash0.inst_id(+) and
gash.blocking_session=gash0.session_id(+) and
gash.blocking_session_serial#=gash0.session_serial#(+)
order by
sample_time,
sess_first_time desc,
percentage desc,
sql_first_time desc