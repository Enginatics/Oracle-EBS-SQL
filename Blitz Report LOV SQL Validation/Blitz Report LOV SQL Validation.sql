/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report LOV SQL Validation
-- Description: Validates Blitz Report LOV SQLs for valid syntax.
This can be useful after mass migrating reports from other tools such as Discoverer, Excl4apps, splashBI or Polaris Reporting Workbench into Blitz Report.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-lov-sql-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-lov-sql-validation/
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
xrpl.lov_name,
xxen_report.validate_sql(replace(xrpl.lov_query,':$flex$.',':'),'parse') error_message,
xrpl.lov_query
from
xxen_report_parameter_lovs xrpl
where
1=1
) x
) y
where
2=2
order by
y.lov_name