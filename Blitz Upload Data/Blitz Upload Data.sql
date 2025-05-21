/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Upload Data
-- Description: History of uploaded data, which is kept for profile option Blitz Upload Data Retention Days number of days.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-upload-data/
-- Library Link: https://www.enginatics.com/reports/blitz-upload-data/
-- Run Report: https://demo.enginatics.com/

select
xrr.request_id,
xrr.creation_date,
xxen_util.user_name(xrr.created_by) user_name,
frt.responsibility_name responsibility,
xrv.report_name,
'begin xxen_upload.g_run_id:='||xud.run_id||'; end;' init_sql,
xud.*
from
xxen_upload_data xud,
xxen_report_runs xrr,
xxen_reports_v xrv,
fnd_responsibility_tl frt
where
1=1 and
xud.run_id=xrr.run_id(+) and
xrr.report_id=xrv.report_id and
xrr.responsibility_application_id=frt.application_id(+) and
xrr.responsibility_id=frt.responsibility_id(+) and
frt.language(+)=userenv('lang')
order by
xud.run_id desc,
xud.upload_row