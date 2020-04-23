/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Blocking Sessions
-- Description: Chain of currently blocking and blocked database sessions from v$wait_chains
-- Excel Examle Output: https://www.enginatics.com/example/dba-blocking-sessions
-- Library Link: https://www.enginatics.com/reports/dba-blocking-sessions
-- Run Report: https://demo.enginatics.com/


select
vwc.instance inst_id,
gs.sid||' - '||gs.serial# sid_serial#,
lpad(' ',2*(level-1))||level level_,
xxen_util.user_name(gs.module,gs.action,gs.client_identifier) user_name,
xxen_util.responsibility(gs.module,gs.action) responsibility,
xxen_util.module_type(gs.module,gs.action) module_type,
xxen_util.module_name(gs.module) module_name,
lpad(' ',2*(level-1))||gs.status||nvl2(vwc.blocker_sid,null,' - blocking') status,
xxen_util.time(vwc.in_wait_secs) time,
vwc.in_wait_secs seconds,
xxen_util.client_time(gs.prev_exec_start) prev_exec_start,
vwc.wait_event_text wait_event,
(select do.owner||'.'||do.object_name||' ('||do.object_type||')' from dba_objects do where case when vwc.wait_event_text like 'enq: TM%' then vwc.p2 when vwc.wait_event_text like 'enq: TX%' then vwc.row_wait_obj# end=do.object_id) object,
gs.sql_id,
gsa.sql_fulltext sql_text,
case when vwc.wait_event_text like 'enq: TX%' then (
select
'select * from '||do.owner||'.'||do.object_name||' where rowid='''||dbms_rowid.rowid_create(1,do.data_object_id,ddf.relative_fno,vwc.row_wait_block#,vwc.row_wait_row#)||'''' show_blocked_row
from
dba_objects do,
dba_data_files ddf
where
vwc.row_wait_obj#=do.object_id and
vwc.row_wait_file#=ddf.file_id
) end show_blocked_row,
lpad(' ',2*(level-1))||gs.module module,
gs.machine,
gs.username db_user,
gs.osuser,
gs.client_identifier client_id,
gs.action,
gs.program,
case when gs.type<>'BACKGROUND' then 'alter system disconnect session '''||gs.sid||','||gs.serial#||',@'||gs.inst_id||''' immediate;' end disconnect_db_session,
case when gs.type<>'BACKGROUND' then 'kill -9 '||gp.spid end kill_server_process,
connect_by_root vwc.sid root_blocking_sid
from
v$wait_chains vwc,
gv$session gs,
gv$process gp,
(
select distinct
gsa.sql_id,
min(gsa.inst_id) keep (dense_rank first order by gsa.inst_id, gsa.plan_hash_value) over (partition by gsa.sql_id) inst_id,
min(gsa.plan_hash_value) keep (dense_rank first order by gsa.inst_id, gsa.plan_hash_value) over (partition by gsa.sql_id) plan_hash_value
from
gv$sqlarea gsa
) gsa0,
gv$sqlarea gsa
where
(vwc.blocker_sid is not null or vwc.num_waiters>0) and
vwc.sid=gs.sid(+) and
vwc.sess_serial#=gs.serial#(+) and
vwc.instance=gs.inst_id(+) and
gs.inst_id=gp.inst_id(+) and
gs.paddr=gp.addr(+) and
gs.sql_id=gsa0.sql_id(+) and
gsa0.sql_id=gsa.sql_id(+) and
gsa0.inst_id=gsa.inst_id(+) and
gsa0.plan_hash_value=gsa.plan_hash_value(+)
connect by
prior vwc.sid=vwc.blocker_sid and
prior vwc.sess_serial#=vwc.blocker_sess_serial# and
prior vwc.instance=vwc.blocker_instance
start with
vwc.blocker_sid is null