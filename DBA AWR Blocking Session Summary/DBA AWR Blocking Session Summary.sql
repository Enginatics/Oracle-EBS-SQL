/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR Blocking Session Summary
-- Description: Summary of blocked and blocking sessions based on the active session history from the AWR.
The link to blocking sessions is deliberately nonunique without jointing to sample_id to increase the chance to fetch the blocking session's additional information such as module, action and client_id.
In some cases, such as row lock scenarios, the blocking session is idle and does not show up in the ASH.

We recommend doing further analysis with a pivot in Excel rather than by SQL, as Excel's drag- and drop is a lot faster than typing commands manually.
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-blocking-session-summary/
-- Library Link: https://www.enginatics.com/reports/dba-awr-blocking-session-summary/
-- Run Report: https://demo.enginatics.com/

with y as (
select /*+ materialize*/ distinct
count(*) over (partition by
x.instance_number,
x.sid_serial#,
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
x.file_id,
x.block_id,
x.blocking_inst_id,
x.blocking_sid_serial#,
x.blocking_client_id,
x.blocking_action,
x.blocking_module,
x.blocking_program,
x.blocking_session_type,
x.blocking_machine,
x.blocking_file_id,
x.blocking_block_id,
x.machine,
x.command_type,
x.schema,
x.client_id,
x.action,
x.module,
x.program
) seconds,
x.instance_number,
x.sid_serial#,
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
x.file_id,
x.block_id,
x.blocking_inst_id,
x.blocking_sid_serial#,
x.blocking_client_id,
x.blocking_action,
x.blocking_module,
x.blocking_program,
x.blocking_session_type,
x.blocking_machine,
x.blocking_file_id,
x.blocking_block_id,
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
dhash.sample_time_ sample_time,
dhash.instance_number,
dhash.session_id||' - '||dhash.session_serial# sid_serial#,
dhash.client_id,
(select so.name from sys.obj$ so where gsa.program_id=so.obj#) code,
case when gsa.program_line#>0 then gsa.program_line# end code_line#,
dhash.sql_id,
dhash.sql_plan_hash_value plan_hash_value,
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
dhash.sql_plan_operation,
dhash.sql_plan_options,
(select do.owner||'.'||do.object_name||' ('||do.object_type||')' from dba_objects do where dhash.current_obj#=do.object_id) object,
decode(dhash.p1text,'file#',dhash.p1) file_id,
decode(dhash.p2text,'block#',dhash.p2) block_id,
dhash.blocking_inst_id blocking_inst_id,
nvl2(dhash.blocking_session,dhash.blocking_session||' - '||dhash.blocking_session_serial#,null) blocking_sid_serial#,
dhash0.client_id blocking_client_id,
dhash0.action blocking_action,
dhash0.module blocking_module,
dhash0.program blocking_program,
dhash0.session_type blocking_session_type,
dhash0.machine blocking_machine,
dhash0.file_id blocking_file_id,
dhash0.block_id blocking_block_id,
dhash.machine,
lower(dhash.sql_opname) command_type,
du.username schema,
dhash.action,
dhash.module,
dhash.program
from
dba_hist_snapshot dhs,
(select cast(dhash.sample_time as date) sample_time_, dhash.* from dba_hist_active_sess_history dhash) dhash,
(
select distinct
dhash.instance_number,
dhash.session_id,
dhash.session_serial#,
max(dhash.client_id) keep (dense_rank last order by dhash.sample_id) over (partition by dhash.instance_number,dhash.session_id,dhash.session_serial#) client_id,
max(dhash.action) keep (dense_rank last order by dhash.sample_id) over (partition by dhash.instance_number,dhash.session_id,dhash.session_serial#) action,
max(dhash.module) keep (dense_rank last order by dhash.sample_id) over (partition by dhash.instance_number,dhash.session_id,dhash.session_serial#) module,
max(dhash.program) keep (dense_rank last order by dhash.sample_id) over (partition by dhash.instance_number,dhash.session_id,dhash.session_serial#) program,
max(dhash.session_type) keep (dense_rank last order by dhash.sample_id) over (partition by dhash.instance_number,dhash.session_id,dhash.session_serial#) session_type,
max(dhash.machine) keep (dense_rank last order by dhash.sample_id) over (partition by dhash.instance_number,dhash.session_id,dhash.session_serial#) machine,
max(decode(dhash.p1text,'file#',dhash.p1)) keep (dense_rank last order by dhash.sample_id) over (partition by dhash.instance_number,dhash.session_id,dhash.session_serial#) file_id,
max(decode(dhash.p2text,'block#',dhash.p2)) keep (dense_rank last order by dhash.sample_id) over (partition by dhash.instance_number,dhash.session_id,dhash.session_serial#) block_id
from
dba_hist_active_sess_history dhash
) dhash0,
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
dhash.blocking_session is not null and
dhs.dbid=dhash.dbid and
dhs.snap_id=dhash.snap_id and
dhs.instance_number=dhash.instance_number and
dhash.sql_id=gsa0.sql_id(+) and
gsa0.sql_id=gsa.sql_id(+) and
gsa0.inst_id=gsa.inst_id(+) and
gsa0.plan_hash_value=gsa.plan_hash_value(+) and
dhash.user_id=du.user_id(+) and
dhash.blocking_inst_id=dhash0.instance_number(+) and
dhash.blocking_session=dhash0.session_id(+) and
dhash.blocking_session_serial#=dhash0.session_serial#(+)
) x
)
select
y.seconds,
y.instance_number,
y.sid_serial#,
xxen_util.user_name(y.module,y.action,y.client_id) user_name,
xxen_util.responsibility(y.module,y.action) responsibility,
xxen_util.module_type(y.module,y.action) module_type,
xxen_util.module_name(y.module,y.program) module_name,
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
y.file_id,
y.block_id,
y.blocking_inst_id,
y.blocking_sid_serial#,
xxen_util.user_name(y.blocking_module,y.blocking_action,y.blocking_client_id) blocking_user_name,
xxen_util.responsibility(y.blocking_module,y.blocking_action) blocking_responsibility,
xxen_util.module_type(y.blocking_module,y.blocking_action) blocking_module_type,
xxen_util.module_name(y.blocking_module,y.blocking_program) blocking_module_name,
y.blocking_session_type,
y.blocking_machine,
y.blocking_file_id,
y.blocking_block_id,
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