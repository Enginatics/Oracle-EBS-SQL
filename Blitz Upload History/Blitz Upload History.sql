/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Upload History
-- Description: History of uploaded data, which is kept for profile option Blitz Upload Data Retention Days number of days.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-upload-history/
-- Library Link: https://www.enginatics.com/reports/blitz-upload-history/
-- Run Report: https://demo.enginatics.com/

select
fcr.parent_request_id request_id,
xrr.creation_date,
xxen_util.user_name(xrr.created_by) user_name,
frt.responsibility_name responsibility,
xrv.report_name upload_name,
nullif(x.c_v,0) create_valid,
nullif(x.c_e,0) create_error,
nullif(x.c_s,0) create_success,
nullif(x.u_v,0) update_valid,
nullif(x.u_e,0) update_error,
nullif(x.u_s,0) update_success,
nullif(x.other,0) other,
x.c_v+x.c_e+x.c_s+x.u_v+x.u_e+x.u_s+x.other total,
dbms_lob.getlength(fl.file_data) file_size,
'begin xxen_upload.g_run_id:='||x.run_id||'; end;' init_sql,
'select'||chr(10)||'xu.*'||chr(10)||'from'||chr(10)||xrv.upload_view||' xu'||chr(10)||'order by'||chr(10)||'xu.upload_row' data_sql,
x.run_id,
xrr.report_id
from (
select
run_id,
case
when xud.column1 = 'C' and xud.column2 = 'V' then 'C_V'
when xud.column1 = 'C' and xud.column2 = 'E' then 'C_E'
when xud.column1 = 'C' and xud.column2 = 'S' then 'C_S'
when xud.column1 = 'U' and xud.column2 = 'V' then 'U_V'
when xud.column1 = 'U' and xud.column2 = 'E' then 'U_E'
when xud.column1 = 'U' and xud.column2 = 'S' then 'U_S'
else 'other'
end action_status
from
xxen_upload_data xud
)
pivot (
count(*) 
for action_status in (
'C_V' as c_v,
'C_E' as c_e,
'C_S' as c_s,
'U_V' as u_v,
'U_E' as u_e,
'U_S' as u_s,
'other' as other
)
) x,
xxen_report_runs xrr,
xxen_reports_v xrv,
fnd_responsibility_tl frt,
fnd_concurrent_requests fcr,
fnd_lobs fl
where
1=1 and
x.run_id=xrr.run_id(+) and
xrr.report_id=xrv.report_id and
xrr.responsibility_application_id=frt.application_id(+) and
xrr.responsibility_id=frt.responsibility_id(+) and
frt.language(+)=userenv('lang') and
xrr.request_id=fcr.request_id(+) and
fcr.argument2=fl.file_id(+)
order by
x.run_id desc