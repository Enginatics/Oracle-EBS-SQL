/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Enginatics Blitz Reports and Uploads
-- Description: Catalog of standard Enginatics uploads and reports.

All Enginatics report details can be seen here:
<a href="https://www.enginatics.com/library/?pg=1&category[]=Enginatics" rel="nofollow" target="_blank">https://www.enginatics.com/library/?pg=1&category[]=Enginatics</a>
-- Excel Examle Output: https://www.enginatics.com/example/enginatics-blitz-reports-and-uploads/
-- Library Link: https://www.enginatics.com/reports/enginatics-blitz-reports-and-uploads/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.application_name(substr(xrv.report_name,1,instr(xrv.report_name,' ')-1)) application,
nvl2(xwrv.web_report_name,'HYPERLINK("https://www.enginatics.com/reports/'||xwrv.web_report_name||'","'||replace(xrv.report_name,'"','""')||'")',xrv.report_name) report_name,
nvl2(xwrv.example_file_name,'HYPERLINK("https://www.enginatics.com/example/'||xwrv.web_report_name||'","'||replace(xwrv.example_file_name,'"','""')||'")',null) example_file,
nvl(xrv.type_dsp,'Report') type,
&release_columns
xrv.description,
xrv.report_name report_name_sort
from
xxen_reports_v xrv,
xxen_reports@demo xr,
xxen_web_reports_v@demo xwrv
where
1=1 and
xrv.category like '%Enginatics%' and
xrv.guid=xr.guid(+) and
xr.report_id=xwrv.report_id(+)
order by
xrv.type_dsp,
xrv.report_name