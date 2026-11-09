/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report SQL Validation
-- Description: Validates Blitz Reports for valid SQL syntax.
-- This can be useful after mass migrating reports from other tools such as Discoverer, Excl4apps, splashBI or Polaris Reporting Workbench into Blitz Report.
-- Excel Example Output: https://www.enginatics.com/example/blitz-report-sql-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-sql-validation/
-- Run Report: https://demo.enginatics.com/

select
y.*
from
(
select
x.*,
nvl2(x.error_message,'Error','Valid') validation_result
from
(
select
xrv.report_name,
xxen_report.validate_sql(case when :remove_lexicals='Y' then regexp_replace(xrv.sql_text_full,'&\w+') else xrv.sql_text_full end,'parse') error_message,
xrv.type_dsp type,
xrv.category,
xrv.sql_text,
regexp_substr(xrv.description,'Report ID: (\d+)',1,1,null,1) orig_report_id
from
xxen_reports_v xrv
where
1=1
) x
) y
where
2=2
order by
y.report_name
