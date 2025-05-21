/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Session Longops
-- Description: Estimated time to completion for long running sessions based on gv$session_longops
-- Excel Examle Output: https://www.enginatics.com/example/dba-session-longops/
-- Library Link: https://www.enginatics.com/reports/dba-session-longops/
-- Run Report: https://demo.enginatics.com/

select
gsl.inst_id,
gsl.sid||' - '||gsl.serial# sid_serial#,
xxen_util.user_name(gs.module,gs.action,gs.client_identifier) user_name,
xxen_util.responsibility(gs.module,gs.action) responsibility,
xxen_util.module_type(gs.module,gs.action) module_type,
xxen_util.module_name(gs.module,gs.program) module_name,
gsl.start_time,
gsl.last_update_time,
xxen_util.time(gsl.elapsed_seconds) elapsed_time,
xxen_util.time(gsl.time_remaining) time_remaining,
gsl.sofar/xxen_util.zero_to_null(gsl.totalwork)*100 percentage,
gsl.sofar,
gsl.totalwork,
gsl.units,
gsl.message,
gsl.opname,
gsl.target,
gsl.target_desc,
gsl.sql_id,
gsl.sql_plan_hash_value,
gsl.sql_exec_start,
gsl.sql_plan_operation,
gsl.sql_plan_options,
gsl.username,
gs.module,
gs.machine,
gs.action,
gs.module,
gs.program
from
gv$session_longops gsl,
gv$session gs
where
1=1 and
gsl.inst_id=gs.inst_id(+) and
gsl.sid=gs.sid(+) and
gsl.serial#=gs.serial#(+)
order by
gsl.start_time desc