/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR Active Session History
-- Description: Active session history from the automatic workload repository
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-active-session-history/
-- Library Link: https://www.enginatics.com/reports/dba-awr-active-session-history/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.client_time(x.sample_time) sample_time,
x.instance_number inst_id,
x.active_sessions,
x.active_cpu_sessions,
x.active_waiting_sessions,
x.sid_serial#,
xxen_util.user_name(x.module,x.action,x.client_id) user_name,
xxen_util.responsibility(x.module,x.action) responsibility,
xxen_util.module_type(x.module,x.action) module_type,
xxen_util.module_name(x.module,x.program) module_name,
case when lower(x.module) like '%frm%' then 'Forms' when lower(x.module) like '%fwk%' then 'OAF' end ui_type,
x.code,
x.code_line#,
x.sql_id,
x.plan_hash_value,
&sql_text
xxen_util.time(case when x.count_sql_id>1 then 10*x.count_sql_id end) time_per_sql,
round(100*x.count_sql_id/x.count,2) percentage,
x.execution_count,
xxen_util.client_time(x.sql_exec_start) sql_exec_start,
x.entry_procedure,
x.procedure,
xxen_util.time(x.sess_duration) sess_duration,
xxen_util.time(x.sess_active*10) sess_active,
xxen_util.client_time(x.sess_first_time) sess_first_time,
xxen_util.client_time(x.sql_first_time) sql_first_time,
x.session_state,
x.event,
x.wait_class,
x.time_model,
x.in_parse,
x.in_hard_parse,
x.qc_instance_id,
x.qc_sid_serial#,
x.sql_plan_operation,
x.sql_plan_options,
x.object,
x.blocked_status,
x.blocking_inst_id,
x.blocking_sid_serial#,
&blocking_cols2
x.file_id,
x.block_id,
x.pga_allocated,
x.pga_total,
x.pga_percentage,
x.temp_space_allocated,
x.temp_space_total,
x.temp_space_percentage,
x.active_sessions,
x.machine,
x.command_type,
x.schema,
x.action,
x.module,
x.program,
x.p1text,
x.p1,
x.p2text,
x.p2,
x.p3text,
x.p3
from
(
select
dhash.sample_time_ sample_time,
dhash.instance_number,
count(*) over (partition by dhash.sample_id) active_sessions,
xxen_util.zero_to_null(count(decode(dhash.session_state,'ON CPU',1)) over (partition by dhash.sample_id)) active_cpu_sessions,
xxen_util.zero_to_null(count(decode(dhash.session_state,'WAITING',1)) over (partition by dhash.sample_id)) active_waiting_sessions,
dhash.session_id||' - '||dhash.session_serial# sid_serial#,
dhash.client_id,
xxen_util.instring(dhash.code_and_line,'|',1) code,
xxen_util.instring(dhash.code_and_line,'|',2) code_line#,
dhash.sql_id,
dhash.sql_plan_hash_value plan_hash_value,
count(*) over (partition by dhash.instance_number, dhash.session_id, dhash.session_serial#, dhash.sql_id) count_sql_id,
count(*) over (partition by dhash.instance_number, dhash.session_id, dhash.session_serial#) count,
dhst.sql_text,
dhash.sql_exec_id-16777216 execution_count,
dhash.sql_exec_start,
dp0.object_name||case when dp0.procedure_name is not null then '.'||dp0.procedure_name end entry_procedure,
dp.object_name||case when dp.procedure_name is not null then '.'||dp.procedure_name end procedure,
(max(dhash.sample_time_) over (partition by dhash.instance_number, dhash.session_id, dhash.session_serial#)-min(dhash.sample_time_) over (partition by dhash.instance_number, dhash.session_id, dhash.session_serial#))*86400 sess_duration,
count(*) over (partition by dhash.instance_number, dhash.session_id, dhash.session_serial#) sess_active,
min(dhash.sample_time_) over (partition by dhash.instance_number, dhash.session_id, dhash.session_serial#) sess_first_time,
min(dhash.sample_time_) over (partition by dhash.instance_number, dhash.session_id, dhash.session_serial#, dhash.sql_id) sql_first_time,
dhash.session_type,
dhash.session_state,
nvl(dhash.event,dhash.session_state)||
case
when dhash.event like 'enq%' and dhash.session_state='WAITING' then ' (mode='||bitand(dhash.p1,power(2,14)-1)||')'
when dhash.event in ('buffer busy waits','gc buffer busy','gc buffer busy acquire','gc buffer busy release') then ' ('||
coalesce(
(select vw.class from (select vw.class, rownum row_num from v$waitstat vw) vw where dhash.p3=vw.row_num),
(select decode(mod(bitand(dhash.p3,to_number('FFFF','XXXX'))-17,2),0,'undo header',1,'undo data','error') from dual)
)||')'
end event,
dhash.wait_class,
rtrim(
case when bitand(dhash.time_model,power(2,01))=power(2,01) then 'DBTIME ' end||
case when bitand(dhash.time_model,power(2,02))=power(2,02) then 'BACKGROUND ' end||
case when bitand(dhash.time_model,power(2,03))=power(2,03) then 'CONNECTION_MGMT ' end||
case when bitand(dhash.time_model,power(2,04))=power(2,04) then 'PARSE ' end||
case when bitand(dhash.time_model,power(2,05))=power(2,05) then 'FAILED_PARSE ' end||
case when bitand(dhash.time_model,power(2,06))=power(2,06) then 'NOMEM_PARSE ' end||
case when bitand(dhash.time_model,power(2,07))=power(2,07) then 'HARD_PARSE ' end||
case when bitand(dhash.time_model,power(2,08))=power(2,08) then 'NO_SHARERS_PARSE ' end||
case when bitand(dhash.time_model,power(2,09))=power(2,09) then 'BIND_MISMATCH_PARSE ' end||
case when bitand(dhash.time_model,power(2,10))=power(2,10) then 'SQL_EXECUTION ' end||
case when bitand(dhash.time_model,power(2,11))=power(2,11) then 'PLSQL_EXECUTION ' end||
case when bitand(dhash.time_model,power(2,12))=power(2,12) then 'PLSQL_RPC ' end||
case when bitand(dhash.time_model,power(2,13))=power(2,13) then 'PLSQL_COMPILATION ' end||
case when bitand(dhash.time_model,power(2,14))=power(2,14) then 'JAVA_EXECUTION ' end||
case when bitand(dhash.time_model,power(2,15))=power(2,15) then 'BIND ' end||
case when bitand(dhash.time_model,power(2,16))=power(2,16) then 'CURSOR_CLOSE ' end||
case when bitand(dhash.time_model,power(2,17))=power(2,17) then 'SEQUENCE_LOAD ' end||
case when bitand(dhash.time_model,power(2,18))=power(2,18) then 'INMEMORY_QUERY ' end||
case when bitand(dhash.time_model,power(2,19))=power(2,19) then 'INMEMORY_POPULATE ' end||
case when bitand(dhash.time_model,power(2,20))=power(2,20) then 'INMEMORY_PREPOPULATE ' end||
case when bitand(dhash.time_model,power(2,21))=power(2,21) then 'INMEMORY_REPOPULATE ' end||
case when bitand(dhash.time_model,power(2,22))=power(2,22) then 'INMEMORY_TREPOPULATE ' end||
case when bitand(dhash.time_model,power(2,23))=power(2,23) then 'TABLESPACE_ENCRYPTION ' end
) time_model,
xxen_util.yes(dhash.in_parse) in_parse,
xxen_util.yes(dhash.in_hard_parse) in_hard_parse,
dhash.qc_instance_id,
dhash.qc_session_id||nvl2(dhash.qc_session_serial#,' - '||dhash.qc_session_serial#,null) qc_sid_serial#,
dhash.sql_plan_operation,
dhash.sql_plan_options,
(select do.owner||'.'||do.object_name||' ('||do.object_type||')' from dba_objects do where dhash.current_obj#=do.object_id) object,
decode(dhash.blocking_session_status,'VALID','blocked') blocked_status,
dhash.blocking_inst_id blocking_inst_id,
nvl2(dhash.blocking_session,dhash.blocking_session||' - '||dhash.blocking_session_serial#,null) blocking_sid_serial#,
&blocking_columns
decode(dhash.p1text,'file#',dhash.p1) file_id,
decode(dhash.p2text,'block#',dhash.p2) block_id,
dhash.pga_allocated/1000000 pga_allocated,
sum(dhash.pga_allocated) over (partition by dhash.sample_id)/1000000 pga_total,
dhash.pga_allocated/xxen_util.zero_to_null(sum(dhash.pga_allocated) over (partition by dhash.sample_id))*100 pga_percentage,
dhash.temp_space_allocated/1000000 temp_space_allocated,
sum(dhash.temp_space_allocated) over (partition by dhash.sample_id)/1000000 temp_space_total,
dhash.temp_space_allocated/xxen_util.zero_to_null(sum(dhash.temp_space_allocated) over (partition by dhash.sample_id))*100 temp_space_percentage,
dhash.machine,
lower(dhash.sql_opname) command_type,
du.username schema,
dhash.action,
dhash.module,
dhash.program,
dhash.p1text,
dhash.p1,
dhash.p2text,
dhash.p2,
dhash.p3text,
dhash.p3
from
(
select
(select so.name||'|'||case when gsa.program_line#>0 then gsa.program_line# end from gv$sqlarea gsa, sys.obj$ so where dhash.sql_id=gsa.sql_id and gsa.program_id=so.obj#(+) and rownum=1) code_and_line,
cast(dhash.sample_time as date) sample_time_,
dhash.*
from
dba_hist_active_sess_history dhash
where
1=1
) dhash
&dynamic_tables
left join dba_hist_sqltext dhst on dhash.dbid=dhst.dbid and dhash.sql_id=dhst.sql_id
left join dba_procedures dp0 on dhash.plsql_entry_object_id=dp0.object_id and dhash.plsql_entry_subprogram_id=dp0.subprogram_id
left join dba_procedures dp on dhash.plsql_object_id=dp.object_id and dhash.plsql_subprogram_id=dp.subprogram_id
left join dba_users du on dhash.user_id=du.user_id
) x
order by
sample_time,
sess_first_time desc,
percentage desc,
sql_first_time desc