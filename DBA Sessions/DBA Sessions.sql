/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Sessions
-- Description: Current database sessions with their Oracle EBS user, responsibility, form or concurrent request, the SQL being executed, wait event, blocking session, and PGA, temp and undo usage. All sizes are shown in MB.
-- Status Duration is the time since the session last changed between active and inactive, so for an active session it is the run time of the current call. Temp Used and Undo Used are the space the session holds at the time of the report.
-- For a Blitz Report run inside a web service call, from the Excel add-in or a Blitz FSG drilldown, the user and responsibility are those of the run. Blitz Report Webservice Runs only lists the runs still executing. The Excel clients stop waiting after 15 minutes, so such a run active for longer has no client reading its result. Schedule the report with Active only, Blitz Report Webservice Runs only and Status Duration Minutes From 15 to be notified of them.
-- The Kill DB Session, Disconnect DB Session and Kill Server Process columns contain the commands to end a session.
-- Excel Example Output: https://www.enginatics.com/example/dba-sessions/
-- Library Link: https://www.enginatics.com/reports/dba-sessions/
-- Run Report: https://demo.enginatics.com/

select
gs.inst_id,
gs.sid||' - '||gs.serial# sid_serial#,
coalesce(xxen_util.user_name(xrr.created_by),xxen_util.user_name(gs.module,gs.action,gs.client_identifier)) user_name,
coalesce((select frv.responsibility_name from fnd_responsibility_vl frv where xrr.responsibility_application_id=frv.application_id and xrr.responsibility_id=frv.responsibility_id),xxen_util.responsibility(gs.module,gs.action)) responsibility,
xxen_util.module_type(gs.module,gs.action) module_type,
xxen_util.module_name(gs.module,gs.program) module_name,
fcr.request_id,
fcr.user_concurrent_program_name concurrent_program,
gs.status,
xxen_util.time(gs.last_call_et) status_duration,
gs.last_call_et status_seconds,
xxen_util.client_time(gs.logon_time) logon_time,
decode(gs.state,'WAITING',gs.event,'ON CPU') event,
decode(gs.state,'WAITING',gs.wait_class) wait_class,
decode(gs.state,'WAITING',xxen_util.time(gs.wait_time_micro/1000000)) wait_time,
gs.blocking_instance blocking_inst_id,
gs.blocking_session blocking_sid,
gs.sql_id,
&sql_text
xxen_util.client_time(gs.sql_exec_start) sql_exec_start,
(select dp.object_name||case when dp.procedure_name is not null then '.'||dp.procedure_name end from dba_procedures dp where gs.plsql_entry_object_id=dp.object_id and gs.plsql_entry_subprogram_id=dp.subprogram_id) entry_procedure,
gs.prev_sql_id,
gp.pga_used_mem/1000000 pga_used,
gp.pga_alloc_mem/1000000 pga_allocated,
gtu.temp_used,
gt.undo_used,
gt.undo_records,
xxen_util.client_time(gt.transaction_start) transaction_start,
gsi.logical_reads,
gsi.physical_reads,
gs.username db_user,
gs.osuser,
gs.machine,
gs.program,
gs.module,
gs.action,
gs.client_identifier client_id,
gs.service_name,
gs.type session_type,
gp.spid os_process_db,
gs.process client_process,
case when gs.type<>'BACKGROUND' then 'alter system kill session '''||gs.sid||','||gs.serial#||',@'||gs.inst_id||''' immediate;' end kill_db_session,
case when gs.type<>'BACKGROUND' then 'alter system disconnect session '''||gs.sid||','||gs.serial#||',@'||gs.inst_id||''' immediate;' end disconnect_db_session,
case when gs.type<>'BACKGROUND' then 'kill -9 '||gp.spid end kill_server_process
from
gv$session gs,
gv$process gp,
xxen_report_runs xrr,
(
select
fcr.request_id,
fcr.oracle_session_id,
fcpv.user_concurrent_program_name
from
fnd_concurrent_requests fcr,
fnd_concurrent_programs_vl fcpv
where
fcr.phase_code='R' and
fcr.program_application_id=fcpv.application_id and
fcr.concurrent_program_id=fcpv.concurrent_program_id
) fcr,
(
select
gtu.inst_id,
gtu.session_addr,
sum(gtu.blocks*(select dt.block_size from dba_tablespaces dt where gtu.tablespace=dt.tablespace_name))/1000000 temp_used
from
gv$tempseg_usage gtu
group by
gtu.inst_id,
gtu.session_addr
) gtu,
(
select
gt.inst_id,
gt.ses_addr,
sum(gt.used_ublk)*(select to_number(vp.value) from v$parameter vp where vp.name='db_block_size')/1000000 undo_used,
sum(gt.used_urec) undo_records,
min(gt.start_date) transaction_start
from
gv$transaction gt
group by
gt.inst_id,
gt.ses_addr
) gt,
(select gsi.inst_id, gsi.sid, gsi.block_gets+gsi.consistent_gets logical_reads, gsi.physical_reads from gv$sess_io gsi) gsi
where
1=1 and
gs.inst_id=gp.inst_id(+) and
gs.paddr=gp.addr(+) and
case when gs.module like 'XXEN_REPORT - %' then to_number(regexp_substr(gs.action,'^[0-9]+')) end=xrr.run_id(+) and
gs.audsid=fcr.oracle_session_id(+) and
gs.inst_id=gtu.inst_id(+) and
gs.saddr=gtu.session_addr(+) and
gs.inst_id=gt.inst_id(+) and
gs.saddr=gt.ses_addr(+) and
gs.inst_id=gsi.inst_id(+) and
gs.sid=gsi.sid(+)
order by
decode(gs.status,'ACTIVE',1,2),
gs.last_call_et desc
