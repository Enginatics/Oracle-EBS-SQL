/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Web Service Sessions
-- Description: Blitz Report runs that execute inside a web service call, from the Excel add-in or a Blitz FSG drilldown, and are still active, with the Oracle EBS user and responsibility that started them.
-- Running Minutes is the run time of the current database call. The Excel clients stop waiting after 15 minutes. A run that is still active after that has no client reading its result, but its database session and the middle-tier thread serving it stay busy until the query ends.
-- Kill Session holds the command that ends the session. Temp Used is in MB.
-- Schedule the report with Running Minutes From to be notified of such sessions.
-- Excel Example Output: https://www.enginatics.com/example/blitz-report-web-service-sessions/
-- Library Link: https://www.enginatics.com/reports/blitz-report-web-service-sessions/
-- Run Report: https://demo.enginatics.com/

select
gs.inst_id,
gs.sid,
gs.serial#,
xxen_util.user_name(xrr.created_by) user_name,
(select frv.responsibility_name from fnd_responsibility_vl frv where xrr.responsibility_application_id=frv.application_id and xrr.responsibility_id=frv.responsibility_id) responsibility,
xrv.report_name,
xrr.run_id,
round(gs.last_call_et/60,1) running_minutes,
gs.sql_id,
xxen_util.client_time(gs.sql_exec_start) sql_exec_start,
decode(gs.state,'WAITING',gs.event,'ON CPU') event,
gtu.temp_used,
gs.client_identifier,
gs.program,
gs.module,
gs.machine,
gp.spid os_process_db,
'alter system kill session '''||gs.sid||','||gs.serial#||',@'||gs.inst_id||''' immediate;' kill_session
from
gv$session gs,
gv$process gp,
xxen_report_runs xrr,
xxen_reports_v xrv,
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
) gtu
where
1=1 and
gs.module like 'XXEN_REPORT - %' and
gs.status='ACTIVE' and
gs.audsid not in (select fcr.oracle_session_id from fnd_concurrent_requests fcr where fcr.phase_code='R' and fcr.oracle_session_id is not null) and
gs.inst_id=gp.inst_id(+) and
gs.paddr=gp.addr(+) and
to_number(regexp_substr(gs.action,'^[0-9]+'))=xrr.run_id and
xrr.request_id is null and
xrr.completion_date is null and
xrr.completion_message is null and
xrr.report_id=xrv.report_id(+) and
gs.inst_id=gtu.inst_id(+) and
gs.saddr=gtu.session_addr(+)
order by
gs.last_call_et desc
