/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Concurrent Requests
-- Description: Running, scheduled and historic concurrent requests including phase, status, parameters, schedule, timing, delivery and output option information.
For performance analysis of running requests, the report contains sid, currently executed sql_id and sql_text and distribution of wait time on different wait classes.

Use parameter 'Scheduled or Running' to get a list of all currently scheduled or running requests.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-concurrent-requests/
-- Library Link: https://www.enginatics.com/reports/fnd-concurrent-requests/
-- Run Report: https://demo.enginatics.com/

select
fcr.request_id id,
decode(fcr.priority_request_id,fcr.request_id,null,fcr.priority_request_id) priority_id,
decode(fcr.parent_request_id,-1,null,fcr.parent_request_id) parent_id,
case when fcr.program_application_id=160 and fcr.concurrent_program_id=20392 /*alecdc*/ or fcr.request_type='M' then fcr.description else fcpt.user_concurrent_program_name end program,
case when fcr.request_type='M' and fcr.frr_display_sequence is not null then fcpt.user_concurrent_program_name||' ('||fcr.frr_display_sequence||')' else fcr.description end description,
flv2.meaning phase,
flv1.meaning status,
xxen_util.user_name(fcr.requested_by) user_name,
haouv.name operating_unit,
frt.responsibility_name responsibility,
xxen_util.client_time(fcr.actual_start_date) start_date,
xxen_util.client_time(fcr.actual_completion_date) completion_date,
xxen_util.time(fcr.seconds) time,
fcr.seconds,
fcr.argument_text_ parameter_text,
&argument_display_values
xxen_util.client_time(fcr.requested_start_date) requested_start_date,
case
when nvl(fcrc.class_type,'P')='P' then
case
when fcr.resubmit_interval_unit_code in ('DAYS','MONTHS') then to_char(xxen_util.client_time(fcr.requested_start_date),'HH24:MI:SS ')||fcr.resubmit_interval||' '||fcr.resubmit_interval_unit_code||' '||fcr.resubmit_interval_type_code else
fcr.resubmit_interval||' '||fcr.resubmit_interval_unit_code||' '||fcr.resubmit_interval_type_code
end
else
to_char(xxen_util.client_time(fcr.requested_start_date),'HH24:MI:SS ')
||decode(substr(fcrc.class_info,1,1),'1',' 1 of month ')
||decode(substr(fcrc.class_info,2,1),'1',' 2 of month ')
||decode(substr(fcrc.class_info,3,1),'1',' 3 of month ')
||decode(substr(fcrc.class_info,4,1),'1',' 4 of month ')
||decode(substr(fcrc.class_info,5,1),'1',' 5 of month ')
||decode(substr(fcrc.class_info,6,1),'1',' 6 of month ')
||decode(substr(fcrc.class_info,7,1),'1',' 7 of month ')
||decode(substr(fcrc.class_info,8,1),'1',' 8 of month ')
||decode(substr(fcrc.class_info,9,1),'1',' 9 of month ')
||decode(substr(fcrc.class_info,10,1),'1','10 of month ')
||decode(substr(fcrc.class_info,11,1),'1','11 of month ')
||decode(substr(fcrc.class_info,12,1),'1','12 of month ')
||decode(substr(fcrc.class_info,13,1),'1','13 of month ')
||decode(substr(fcrc.class_info,14,1),'1','14 of month ')
||decode(substr(fcrc.class_info,15,1),'1','15 of month ')
||decode(substr(fcrc.class_info,16,1),'1','16 of month ')
||decode(substr(fcrc.class_info,17,1),'1','17 of month ')
||decode(substr(fcrc.class_info,18,1),'1','18 of month ')
||decode(substr(fcrc.class_info,19,1),'1','19 of month ')
||decode(substr(fcrc.class_info,20,1),'1','20 of month ')
||decode(substr(fcrc.class_info,21,1),'1','21 of month ')
||decode(substr(fcrc.class_info,22,1),'1','22 of month ')
||decode(substr(fcrc.class_info,23,1),'1','23 of month ')
||decode(substr(fcrc.class_info,24,1),'1','24 of month ')
||decode(substr(fcrc.class_info,25,1),'1','25 of month ')
||decode(substr(fcrc.class_info,26,1),'1','26 of month ')
||decode(substr(fcrc.class_info,27,1),'1','27 of month ')
||decode(substr(fcrc.class_info,28,1),'1','28 of month ')
||decode(substr(fcrc.class_info,29,1),'1','29 of month ')
||decode(substr(fcrc.class_info,30,1),'1','30 of month ')
||decode(substr(fcrc.class_info,31,1),'1','31 of month ')
||decode(substr(fcrc.class_info,32,1),'1','Last day of month ')
||decode(substr(fcrc.class_info,33,1),'1','Sun ')
||decode(substr(fcrc.class_info,34,1),'1','Mon ')
||decode(substr(fcrc.class_info,35,1),'1','Tue ')
||decode(substr(fcrc.class_info,36,1),'1','Wed ')
||decode(substr(fcrc.class_info,37,1),'1','Thu ')
||decode(substr(fcrc.class_info,38,1),'1','Fri ')
||decode(substr(fcrc.class_info,39,1),'1','Sat ')
end||decode(fcr.increment_dates,'Y',' - increment dates') schedule,
xxen_util.time(fcr.wait_seconds) wait_time,
fcr.wait_seconds,
xxen_util.time(fcr.non_conflict_wait_seconds) non_conflict_wait_time,
fcr.non_conflict_wait_seconds,
xxen_util.time(fcr.conflict_wait_seconds) conflict_wait_time,
fcr.conflict_wait_seconds,
case when fcr.program_application_id=160 and fcr.concurrent_program_id=20392 then 'Alert' else decode(fcr.request_type,'P','Req Set Child Program','S','Req Set Stage','M','Req Set','B','Multi Language Set','C','Multi Language Child Program',decode(fcr.priority_request_id,fcr.request_id,'Standalone','Other Subprogram')) end type,
fcp.concurrent_program_name short_name,
fev.executable_name executable_short_name,
xxen_util.meaning(fev.execution_method_code,'CP_EXECUTION_METHOD_CODE',0) method,
fev.execution_file_name,
case when fev.description is null and fev.user_executable_name<>fev.executable_name then fev.user_executable_name else fev.description end executable_description,
fcd.cd_name,
fcd.user_cd_name,
gs.sql_id,
&sql_text_column
gs.event,
gse.user_io_time,
gse.network_time,
gse.system_io_time,
gse.configuration_time,
gse.application_time,
gse.commit_time,
gse.concurrency_time,
gse.other_time,
&delivery_cols
fcr.output_file_type,
fcr.outfile_name,
fcr.ofile_size outfile_size,
fcr.logfile_name,
fcr.lfile_size logfile_size,
fcr.temp_out,
fcr.temp_log,
fcr.conc_manager,
fcr.node,
fcr.os_process_manager,
fcr.os_process_id os_process_apps,
fcr.oracle_process_id os_process_db,
fcr.instance_number,
fcr.audsid,
gs.sid,
gs.serial#,
case when fcr.program_application_id=160 and fcr.concurrent_program_id=20392 or fcr.request_type='M' then to_number(fcr.argument1) else fcr.program_application_id end app_id,
case when fcr.program_application_id=160 and fcr.concurrent_program_id=20392 or fcr.request_type='M' then to_number(fcr.argument2) else fcr.concurrent_program_id end prog_id
from
(
select
fcr.*,
nvl(fcr.org_id,
(
select
fpov.profile_option_value
from
fnd_profile_option_values fpov
where
fcr.responsibility_application_id=fpov.level_value_application_id and
fcr.responsibility_id=fpov.level_value and
fpov.level_value2 is null and
fpov.application_id=0 and
fpov.profile_option_id=1991 and
fpov.level_id=10003
)) org_id_,
86400*greatest(0,nvl(fcr.actual_completion_date,sysdate)-fcr.actual_start_date) seconds,
86400*greatest(0,nvl(fcr.actual_start_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' then sysdate end)-greatest(fcr.request_date,fcr.requested_start_date)) wait_seconds,
86400*greatest(0,nvl(fcr.actual_start_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' then sysdate end)-nvl(nvl(fcr.crm_release_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' and fcr.status_code='Q' and fcr.crm_tstmp is not null then sysdate end),greatest(fcr.request_date,fcr.requested_start_date))) non_conflict_wait_seconds,
86400*greatest(0,nvl(fcr.crm_release_date,case when fcr.requested_start_date<sysdate and fcr.phase_code='P' and fcr.hold_flag='N' and fcr.status_code='Q' and fcr.crm_tstmp is not null then sysdate end)-greatest(fcr.request_date,fcr.requested_start_date)) conflict_wait_seconds,
fcpr.plsql_dir||nvl2(fcpr.plsql_out,'/','')||fcpr.plsql_out temp_out,
fcpr.plsql_dir||nvl2(fcpr.plsql_log,'/','')||fcpr.plsql_log temp_log,
fcqv.user_concurrent_queue_name conc_manager,
fcqv.target_node node,
fcpr.os_process_id os_process_manager,
case when fcr.phase_code='R' and fcr.status_code='R' then fcpr.instance_number end instance_number,
case when fcr.phase_code='R' and fcr.status_code='R' then fcr.oracle_session_id end audsid,
frr.display_sequence frr_display_sequence,
nvl(frr.application_id,fcr.program_application_id) program_application_id_,
nvl(frr.concurrent_program_id,fcr.concurrent_program_id) concurrent_program_id_,
case when fcr.request_type='M' and frr.parent_request_id is not null then
rtrim(
replace(
frr.argument1||','||
frr.argument2||','||
frr.argument3||','||
frr.argument4||','||
frr.argument5||','||
frr.argument6||','||
frr.argument7||','||
frr.argument8||','||
frr.argument9||','||
frr.argument10||','||
frr.argument11||','||
frr.argument12||','||
frr.argument13||','||
frr.argument14||','||
frr.argument15||','||
frr.argument16||','||
frr.argument17||','||
frr.argument18||','||
frr.argument19||','||
frr.argument20||','||
frr.argument21||','||
frr.argument22||','||
frr.argument23||','||
frr.argument24||','||
frr.argument25||','||
frr.argument26||','||
frr.argument27||','||
frr.argument28||','||
frr.argument29||','||
frr.argument30||','||
frr.argument31||','||
frr.argument32||','||
frr.argument33||','||
frr.argument34||','||
frr.argument35||','||
frr.argument36||','||
frr.argument37||','||
frr.argument38||','||
frr.argument39||','||
frr.argument40||','||
frr.argument41||','||
frr.argument42||','||
frr.argument43||','||
frr.argument44||','||
frr.argument45||','||
frr.argument46||','||
frr.argument47||','||
frr.argument48||','||
frr.argument49||','||
frr.argument50||','||
frr.argument51||','||
frr.argument52||','||
frr.argument53||','||
frr.argument54||','||
frr.argument55||','||
frr.argument56||','||
frr.argument57||','||
frr.argument58||','||
frr.argument59||','||
frr.argument60||','||
frr.argument61||','||
frr.argument62||','||
frr.argument63||','||
frr.argument64||','||
frr.argument65||','||
frr.argument66||','||
frr.argument67||','||
frr.argument68||','||
frr.argument69||','||
frr.argument70||','||
frr.argument71||','||
frr.argument72||','||
frr.argument73||','||
frr.argument74||','||
frr.argument75||','||
frr.argument76||','||
frr.argument77||','||
frr.argument78||','||
frr.argument79||','||
frr.argument80||','||
frr.argument81||','||
frr.argument82||','||
frr.argument83||','||
frr.argument84||','||
frr.argument85||','||
frr.argument86||','||
frr.argument87||','||
frr.argument88||','||
frr.argument89||','||
frr.argument90||','||
frr.argument91||','||
frr.argument92||','||
frr.argument93||','||
frr.argument94||','||
frr.argument95||','||
frr.argument96||','||
frr.argument97||','||
frr.argument98||','||
frr.argument99||','||
frr.argument100,
chr(0)),
',') else
fcr.argument_text end argument_text_,
fcr.rowid row_id
from
fnd_concurrent_requests fcr,
fnd_concurrent_processes fcpr,
fnd_concurrent_queues_vl fcqv,
(
select
frss.display_sequence,
frr.*
from
fnd_run_requests frr,
fnd_request_set_programs frsp,
fnd_request_set_stages frss
where
frr.set_application_id=frsp.set_application_id and
frr.request_set_id=frsp.request_set_id and
frr.request_set_program_id=frsp.request_set_program_id and
frsp.set_application_id=frss.set_application_id and
frsp.request_set_id=frss.request_set_id and
frsp.request_set_stage_id=frss.request_set_stage_id and
not exists (select null from fnd_concurrent_requests fcr2 where frr.parent_request_id=fcr2.parent_request_id and fcr2.request_type='S' and fcr2.program_application_id=0 and fcr2.concurrent_program_id=36034)
) frr
where
1=1 and
fcr.controlling_manager=fcpr.concurrent_process_id(+) and
fcpr.queue_application_id=fcqv.application_id(+) and
fcpr.concurrent_queue_id=fcqv.concurrent_queue_id(+) and
case when fcr.request_type in ('B','M') then fcr.request_id end=frr.parent_request_id(+)
) fcr,
fnd_concurrent_programs fcp,
fnd_concurrent_programs_tl fcpt,
fnd_executables_vl fev,
fnd_responsibility_tl frt,
fnd_conc_release_classes fcrc,
hr_all_organization_units_vl haouv,
fnd_conflicts_domain fcd,
(select x.* from (select min(fcpa.sequence) over (partition by fcpa.concurrent_request_id,fcpa.action_type) min_sequence, fcpa.* from fnd_conc_pp_actions fcpa where '&enable_delivery'='Y' and fcpa.action_type=1 and fcpa.number_of_copies>0) x where x.sequence=x.min_sequence) fcpa1,
(select x.* from (select min(fcpa.sequence) over (partition by fcpa.concurrent_request_id,fcpa.action_type) min_sequence, fcpa.* from fnd_conc_pp_actions fcpa where '&enable_delivery'='Y' and fcpa.action_type=2) x where x.sequence=x.min_sequence) fcpa2,
(select x.* from (select min(fcpa.sequence) over (partition by fcpa.concurrent_request_id,fcpa.action_type) min_sequence, fcpa.* from fnd_conc_pp_actions fcpa where '&enable_delivery'='Y' and fcpa.action_type=6) x where x.sequence=x.min_sequence) fcpa6,
(select x.* from (select min(fcpa.sequence) over (partition by fcpa.concurrent_request_id,fcpa.action_type) min_sequence, fcpa.*, fcdo.delivery_name from fnd_conc_pp_actions fcpa, fnd_cp_delivery_options fcdo where '&enable_delivery'='Y' and fcpa.action_type=7 and fcpa.argument1='P' and fcpa.argument2=fcdo.delivery_id) x where x.sequence=x.min_sequence) fcpa7p,
(select x.* from (select min(fcpa.sequence) over (partition by fcpa.concurrent_request_id,fcpa.action_type) min_sequence, fcpa.*, fcdo.delivery_name from fnd_conc_pp_actions fcpa, fnd_cp_delivery_options fcdo where '&enable_delivery'='Y' and fcpa.action_type=7 and fcpa.argument1='F' and fcpa.argument2=fcdo.delivery_id) x where x.sequence=x.min_sequence) fcpa7f,
(select x.* from (select min(fcpa.sequence) over (partition by fcpa.concurrent_request_id,fcpa.action_type) min_sequence, fcpa.* from fnd_conc_pp_actions fcpa where '&enable_delivery'='Y' and fcpa.action_type=7 and fcpa.argument1 in ('T','S')) x where x.sequence=x.min_sequence) fcpa7t,
(select x.* from (select min(fcpa.sequence) over (partition by fcpa.concurrent_request_id,fcpa.action_type) min_sequence, fcpa.* from fnd_conc_pp_actions fcpa where '&enable_delivery'='Y' and fcpa.action_type=7 and fcpa.argument1='E') x where x.sequence=x.min_sequence) fcpa7e,
(select x.* from (select min(fcpa.sequence) over (partition by fcpa.concurrent_request_id,fcpa.action_type) min_sequence, fcpa.* from fnd_conc_pp_actions fcpa where '&enable_delivery'='Y' and fcpa.action_type=7 and fcpa.argument1='W') x where x.sequence=x.min_sequence) fcpa7w,
(select x.* from (select min(fcpa.sequence) over (partition by fcpa.concurrent_request_id,fcpa.action_type) min_sequence, fcpa.* from fnd_conc_pp_actions fcpa where '&enable_delivery'='Y' and fcpa.action_type=7 and fcpa.argument1='C') x where x.sequence=x.min_sequence) fcpa7c,
(select x.* from (select min(fcro.output_id) over (partition by fcro.concurrent_request_id) min_output_id, fcro.* from fnd_conc_req_outputs fcro where '&enable_delivery'='Y') x where x.output_id=x.min_output_id) fcro,
fnd_lookup_values flv1,
fnd_lookup_values flv2,
gv$session gs,
(
select
*
from
(
select
gse.inst_id,
gse.sid,
round(gse.time_waited_micro/1000000,2) time,
gse.wait_class
from
gv$session_event gse
) x
pivot (sum(x.time) time for wait_class in ('User I/O' user_io, 'Network' network, 'System I/O' system_io, 'Configuration' configuration, 'Application' application, 'Commit' commit, 'Concurrency' concurrency, 'Other' other))
) gse,
(select gsa.* from gv$sql gsa where '&enable_sql_text'='Y') gsa
where
2=2 and
fcr.program_application_id_=fcp.application_id(+) and
fcr.concurrent_program_id_=fcp.concurrent_program_id(+) and
fcr.program_application_id_=fcpt.application_id(+) and
fcr.concurrent_program_id_=fcpt.concurrent_program_id(+) and
fcpt.language(+)=userenv('lang') and
fcp.executable_application_id=fev.application_id(+) and
fcp.executable_id=fev.executable_id(+) and
fcr.responsibility_application_id=frt.application_id(+) and
fcr.responsibility_id=frt.responsibility_id(+) and
frt.language(+)=userenv('lang') and
fcr.release_class_app_id=fcrc.application_id(+) and
fcr.release_class_id=fcrc.release_class_id(+) and
fcr.org_id_=haouv.organization_id(+) and
fcr.cd_id=fcd.cd_id(+) and
fcr.request_id=fcpa1.concurrent_request_id(+) and
fcr.request_id=fcpa2.concurrent_request_id(+) and
fcr.request_id=fcpa6.concurrent_request_id(+) and
fcr.request_id=fcpa7p.concurrent_request_id(+) and
fcr.request_id=fcpa7f.concurrent_request_id(+) and
fcr.request_id=fcpa7t.concurrent_request_id(+) and
fcr.request_id=fcpa7e.concurrent_request_id(+) and
fcr.request_id=fcpa7w.concurrent_request_id(+) and
fcr.request_id=fcpa7c.concurrent_request_id(+) and
fcr.request_id=fcro.concurrent_request_id(+) and
decode(fcr.phase_code,
'P',decode(fcr.hold_flag,'Y','H',decode(fcp.enabled_flag,'N','U',case when fcr.requested_start_date>sysdate then 'P' else fcr.status_code end)),
'R',decode(fcr.hold_flag,'Y','S',decode(fcr.status_code,'Q','B','I','B',fcr.status_code)),
fcr.status_code)=flv1.lookup_code and
case when flv1.lookup_code in ('H','S','U','M') then 'I' else fcr.phase_code end=flv2.lookup_code and
flv1.lookup_type(+)='CP_STATUS_CODE' and
flv2.lookup_type(+)='CP_PHASE_CODE' and
flv1.language(+)=userenv('lang') and
flv2.language(+)=userenv('lang') and
flv1.view_application_id(+)=0 and
flv2.view_application_id(+)=0 and
flv1.security_group_id(+)=0 and
flv2.security_group_id(+)=0 and
fcr.instance_number=gs.inst_id(+) and
fcr.audsid=gs.audsid(+) and
gs.inst_id=gse.inst_id(+) and
gs.sid=gse.sid(+) and
gs.inst_id=gsa.inst_id(+) and
gs.sql_id=gsa.sql_id(+) and
gs.sql_child_number=gsa.child_number(+)
order by
decode(flv2.lookup_code,'R',1,'P',2,'I',3,'C',4),
nvl(fcr.actual_start_date,fcr.requested_start_date) desc,
fcr.request_id desc,
fcr.frr_display_sequence desc,
xxen_util.user_name(fcr.requested_by),
fcpt.user_concurrent_program_name,
frt.responsibility_name