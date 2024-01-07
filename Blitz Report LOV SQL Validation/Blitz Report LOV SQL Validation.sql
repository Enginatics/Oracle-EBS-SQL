/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
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
z.*
from
(
select
y.*,
nvl2(y.error_message,'Error','Valid') validation_result
from
(
select
x.lov_name,
x.report_name,
x.parameter_name,
xxen_report.validate_sql(replace(x.lov_query,':$flex$.',':'),'parse') error_message,
x.lov_query
from
(
select
xrpl.lov_name,
null report_name,
null parameter_name,
xrpl.lov_query
from
xxen_report_parameter_lovs xrpl
where
1=1
union all
select
null lov_name,
xrpv.report_name,
xrpv.parameter_name,
xrpv.lov_query
from
xxen_report_parameters_v xrpv
where
2=2 and
xrpv.parameter_type='LOV' and
xrpv.lov_id is null
) x
) y
) z
where
3=3
order by
z.lov_name