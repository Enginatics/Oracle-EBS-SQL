/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA SGA Blocking Session Summary
-- Description: Summary of blocked and blocking sessions based on the active session history from the SGA.
The link to blocking sessions is deliberately nonunique without jointing to sample_id to increase the chance to fetch the blocking session's additional information such as module, action and client_id.
In some cases, such as row lock scenarios, the blocking session is idle and does not show up in the ASH.

We recommend doing further analysis with a pivot in Excel rather than by SQL, as Excel's drag- and drop is a lot faster than typing commands manually.
-- Excel Examle Output: https://www.enginatics.com/example/dba-sga-blocking-session-summary/
-- Library Link: https://www.enginatics.com/reports/dba-sga-blocking-session-summary/
-- Run Report: https://demo.enginatics.com/

with y as (
select /*+ materialize*/ distinct
count(*) over (partition by
x.inst_id,
x.sid_serial#,
x.ui_type,
x.code,
x.code_line#,
x.sql_id,
x.plan_hash_value,
x.session_type,
x.session_state,
x.event,
x.wait_class,
x.time_model,
x.sql_plan_operation,
x.sql_plan_options,
x.object,
x.blocking_inst_id,
x.blocking_sid_serial#,
x.blocking_client_id,
x.blocking_action,
x.blocking_module,
x.blocking_program,
x.blocking_session_type,
x.blocking_machine,
x.machine,
x.command_type,
x.schema,
x.client_id,
x.action,
x.module,
x.program
) seconds,
x.inst_id,
x.sid_serial#,
x.ui_type,
x.code,
x.code_line#,
x.sql_id,
x.plan_hash_value,
x.session_type,
x.session_state,
x.event,
x.wait_class,
x.time_model,
x.sql_plan_operation,
x.sql_plan_options,
x.object,
x.blocking_inst_id,
x.blocking_sid_serial#,
x.blocking_client_id,
x.blocking_action,
x.blocking_module,
x.blocking_program,
x.blocking_session_type,
x.blocking_machine,
x.machine,
x.command_type,
x.schema,
x.client_id,
x.action,
x.module,
x.program
from
(
select
gash.sample_time_,
gash.inst_id,
gash.session_id||' - '||gash.session_serial# sid_serial#,
case when lower(gash.module) like '%frm%' then 'Forms' when lower(gash.module) like '%fwk%' then 'OAF' end ui_type,
(select so.name from sys.obj$ so where gsa.program_id=so.obj#) code,
case when gsa.program_line#>0 then gsa.program_line# end code_line#,
gash.sql_id,
gash.sql_plan_hash_value plan_hash_value,
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
gash.sql_plan_operation,
gash.sql_plan_options,
(select do.owner||'.'||do.object_name||' ('||do.object_type||')' from dba_objects do where gash.current_obj#=do.object_id) object,
gash.blocking_inst_id,
nvl2(gash.blocking_session,gash.blocking_session||' - '||gash.blocking_session_serial#,null) blocking_sid_serial#,
gash0.client_id blocking_client_id,
gash0.action blocking_action,
gash0.module blocking_module,
gash0.program blocking_program,
gash0.session_type blocking_session_type,
gash0.machine blocking_machine,
gash.machine,
lower(gash.sql_opname) command_type,
du.username schema,
gash.client_id,
gash.action,
gash.module,
gash.program
from
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
) gash0,
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
gash.blocking_session is not null and
gash.sql_id=gsa0.sql_id(+) and
gsa0.sql_id=gsa.sql_id(+) and
gsa0.inst_id=gsa.inst_id(+) and
gsa0.plan_hash_value=gsa.plan_hash_value(+) and
gash.user_id=du.user_id(+) and
gash.blocking_inst_id=gash0.inst_id(+) and
gash.blocking_session=gash0.session_id(+) and
gash.blocking_session_serial#=gash0.session_serial#(+)
) x
)
select
y.seconds,
y.inst_id,
y.sid_serial#,
xxen_util.user_name(y.module,y.action,y.client_id) user_name,
xxen_util.responsibility(y.module,y.action) responsibility,
xxen_util.module_type(y.module,y.action) module_type,
xxen_util.module_name(y.module,y.program) module_name,
y.ui_type,
y.code,
y.code_line#,
y.sql_id,
y.plan_hash_value,
y.session_type,
y.session_state,
y.event,
y.wait_class,
y.time_model,
y.sql_plan_operation,
y.sql_plan_options,
y.object,
y.blocking_inst_id,
y.blocking_sid_serial#,
xxen_util.user_name(y.blocking_module,y.blocking_action,y.blocking_client_id) blocking_user_name,
xxen_util.responsibility(y.blocking_module,y.blocking_action) blocking_responsibility,
xxen_util.module_type(y.blocking_module,y.blocking_action) blocking_module_type,
xxen_util.module_name(y.blocking_module,y.blocking_program) blocking_module_name,
y.blocking_session_type,
y.blocking_machine,
y.machine,
y.command_type,
y.schema,
y.client_id,
y.action,
y.module,
y.program,
y.blocking_client_id,
y.blocking_action,
y.blocking_module,
y.blocking_program
from
y
order by
y.seconds desc