/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Columns
-- Description: Report showing all SQL columns of selected Blitz Reports by parsing their SQL on the fly.
Use the Category or Report Name parameters to scope the results. Running without filters will parse all enabled reports, which may take several minutes.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-columns/
-- Library Link: https://www.enginatics.com/reports/blitz-report-columns/
-- Run Report: https://demo.enginatics.com/

select
xrv.report_name,
xxen_api.category(xrsc.id) category,
nvl(xrv.type_dsp,'Report') type,
xrsc.column_number,
xxen_report.column_translation(xrsc.column_name) column_header,
lower(xrsc.column_name) column_name,
xrsc.data_type
from
xxen_report_sql_columns xrsc,
xxen_reports_v xrv
where
1=1 and
xrsc.id=xrv.report_id
order by
xrv.report_name,
xrsc.column_number