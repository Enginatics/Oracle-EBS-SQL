/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameters with more than one :bind variable
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameters-with-more-than-one-bind-variable/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameters-with-more-than-one-bind-variable/
-- Run Report: https://demo.enginatics.com/

select
xrpv.report_name,
xrpv.category,
xrpv.display_sequence,
xrpv.parameter_name,
xrpv.anchor,
xxen_api.bindvar_name(xrpv.parameter_id) bindvar,
z.binds,
xrpv.sql_text
from
xxen_report_parameters_v xrpv,
(
select y.* from (
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
(select xrplv.parameter_id_display, xxen_report.clear_text(xrplv.sql_text) sql_text from xxen_report_parameters_link_v xrplv where xrplv.anchor not like ':%') xrplv,
table(xxen_util.rowgen(regexp_count(xrplv.sql_text,':\w+'))) rowgen
) x
) y
where
y.bind_count>1
) z
where
1=1 and
xrpv.display_sequence is not null and
xrpv.parameter_id=z.parameter_id_display
order by
xrpv.report_name,
xrpv.sort_order