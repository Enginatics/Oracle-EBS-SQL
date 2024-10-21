/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter Bind Variable Validation
-- Description: This report can be used to check which :bind variables were assigned to which Blitz Report parameter, in case there are more than one :binds in the parameter sql text, or in case the same :bind variable name is incorrectly used in different parameters.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameter-bind-variable-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-bind-variable-validation/
-- Run Report: https://demo.enginatics.com/

select z.* from (
select
xrpv.report_name,
xrpv.category,
xrpv.display_sequence,
xrpv.parameter_name,
xrpv.anchor,
xxen_api.bindvar_name(xrpv.parameter_id) bindvar_name,
xxen_report.is_select_(xrpv.sql_text) is_dynamic_sql_text,
xrpv.sql_text,
y.binds,
y.bind_count,
xrpv.parameter_id
from
xxen_report_parameters_v xrpv,
(
select distinct
x.parameter_id_display,
count(*) over (partition by x.parameter_id_display) bind_count,
listagg(x.bind,', ') within group (order by x.bind) over (partition by x.parameter_id_display) binds
from
(
select distinct
xrplv.parameter_id_display,
lower(dbms_lob.substr(regexp_substr(xrplv.sql_text,':\w+',1,rowgen.column_value))) bind
from
(select xrplv.parameter_id_display, xxen_report.clear_text(xrplv.sql_text) sql_text from xxen_report_parameters_link_v xrplv where 1=1) xrplv,
table(xxen_util.rowgen(regexp_count(xrplv.sql_text,':\w+'))) rowgen
) x
) y
where
2=2 and
xrpv.display_sequence is not null and
xrpv.parameter_id=y.parameter_id_display
) z
where
3=3
order by
z.report_name,
z.display_sequence