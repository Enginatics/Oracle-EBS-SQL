/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Execution History
-- Description: History of Blitz Report executions
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-execution-history/
-- Library Link: https://www.enginatics.com/reports/blitz-report-execution-history/
-- Run Report: https://demo.enginatics.com/

select
x.request_id,
xxen_util.client_time(x.start_date) start_date,
x.report_name,
x.category,
decode(x.type,'P','Protected','S','System','U','Upload','F','FSG') type,
x.user_name,
x.responsibility_name responsibility,
x.options,
x.parameters,
x.status,
xxen_util.client_time(x.completion_date) completion_date,
xxen_util.time(x.seconds) time,
x.seconds,
x.row_count,
round(x.row_count/decode(x.seconds,0,0.25,x.seconds),2) rows_second,
x.file_size,
xxen_util.client_time(x.actual_completion_date) request_completion_date,
(x.actual_completion_date-x.completion_date)*86400 file_writing_seconds,
x.run_id,
x.report_id
from
(
select
case when xrr.request_id>-1 then xrr.request_id end request_id,
xxen_util.user_name(xrr.created_by) user_name,
frt.responsibility_name,
coalesce(xrv.report_name,
(select distinct min(xrh.report_name||' (deleted)') keep (dense_rank last order by xrh.creation_date) over () report_name from xxen_reports_h xrh where xrr.report_id=xrh.report_id and xrr.creation_date>xrh.creation_date),
(select fcr.argument1||' (deleted)' from fnd_concurrent_requests fcr where xrr.request_id=fcr.request_id)
) report_name,
xrrpv0.options,
xxen_api.parameters(xrr.run_id) parameters,
coalesce(xrr.completion_message,
nvl2(fcr.request_id,
decode(fcr.phase_code,'P','Pending - ','R','Running - ')||trim(
xxen_util.meaning(case when not (fcr.phase_code='C' and fcr.status_code='C') then
decode(fcr.phase_code,'P',decode(fcr.hold_flag,'Y','H',decode(sign(fcr.requested_start_date-sysdate),1,'P',fcr.status_code)),'R',decode(fcr.hold_flag,'Y','S',decode(fcr.status_code,'Q', 'B','I', 'B',fcr.status_code)),fcr.status_code)
end,'CP_STATUS_CODE',0)
),
nvl2(xrr.completion_date,null,nvl2(xrr.active_session,'Running - Online','Error'))),
'Completed') status,
nvl(xrr.start_date,xrr.creation_date) start_date,
xrr.completion_date completion_date,
round((nvl(xrr.completion_date,nvl2(xrr.active_session,sysdate,fcr.actual_completion_date))-nvl(xrr.start_date,xrr.creation_date))*86400) seconds,
xrr.row_count,
xrr.file_size,
fcr.actual_completion_date,
xxen_api.category(xrv.report_id) category,
xrr.type,
xrr.run_id,
xrr.report_id
from
(
select
(select 'Y' from gv$session gs where gs.action like xrr.run_id||'|%' and gs.module like 'XXEN_REPORT - %' and gs.status='ACTIVE' and rownum=1) active_session,
xrr.*
from
xxen_report_runs xrr) xrr,
xxen_reports_v xrv,
fnd_concurrent_requests fcr,
fnd_responsibility_tl frt,
(
select distinct
x.run_id,
listagg(x.parameter_name||': '||x.value,chr(10)) within group (order by x.parameter_id desc) over (partition by x.run_id) options
from
(
select
xrrpv.run_id,
xrrpv.parameter_id,
(select flv.description from fnd_lookup_values flv where xrrpv.parameter_id=flv.tag and flv.lookup_type like 'XXEN_REPORT_TRANSLATIONS' and flv.meaning like 'RUNTIME_OPTIONS.%' and flv.language=userenv('lang') and flv.view_application_id=0) parameter_name,
xrrpv.value
from
xxen_report_run_param_values xrrpv
where
xrrpv.parameter_id<0
) x
) xrrpv0
where
1=1 and
xrr.report_id=xrv.report_id(+) and
xrr.request_id=fcr.request_id(+) and
xrr.responsibility_application_id=frt.application_id(+) and
xrr.responsibility_id=frt.responsibility_id(+) and
frt.language(+)=userenv('lang') and
xrr.run_id=xrrpv0.run_id(+)
) x
order by
x.run_id desc