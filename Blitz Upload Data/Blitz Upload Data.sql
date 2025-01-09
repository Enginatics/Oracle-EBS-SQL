/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Upload Data
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/blitz-upload-data/
-- Library Link: https://www.enginatics.com/reports/blitz-upload-data/
-- Run Report: https://demo.enginatics.com/

select
x.*,
'begin xxen_upload.g_run_id:='||x.run_id||'; end;' init_sql,
'select'||chr(10)||'xu.*'||chr(10)||'from'||chr(10)||x.upload_view||' xu'||chr(10)||'order by'||chr(10)||'xu.upload_row' data_sql
from
(
select
xud.run_id,
xrr.creation_date,
xxen_util.user_name(xrr.created_by) user_name,
count(*) count,
xxen_upload.status_meaning(xud.column2) status,
xrv.upload_view
from
xxen_upload_data xud,
xxen_report_runs xrr,
xxen_reports_v xrv
where
1=1 and
xud.run_id=xrr.run_id(+) and
xrr.report_id=xrv.report_id
group by
xud.run_id,
xrr.creation_date,
xrr.created_by,
xud.column2,
xrv.upload_view
) x
order by
x.run_id desc,
x.count desc