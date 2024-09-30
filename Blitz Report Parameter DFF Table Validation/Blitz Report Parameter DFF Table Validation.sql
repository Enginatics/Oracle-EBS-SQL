/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter DFF Table Validation
-- Description: Shows any parameters using the xxen_util.dff_columns function, which reference an incorrect DFF table name.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameter-dff-table-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-dff-table-validation/
-- Run Report: https://demo.enginatics.com/

select
y.*
from
(
select
xrpv.report_name,
xrpv.display_sequence,
xrpv.parameter_name,
dbms_lob.substr(regexp_substr(xrpv.sql_text,'xxen_util\.dff_columns\((p_table_name=>)?''(\w+)''',1,x.column_value,'i',2)) dff_table_name,
dbms_lob.substr(xrpv.sql_text) sql_text,
xxen_util.user_name(xrpv.created_by) created_by,
xxen_util.client_time(xrpv.creation_date) creation_date,
xxen_util.user_name(xrpv.last_updated_by) last_updated_by,
xxen_util.client_time(xrpv.last_update_date) last_update_date,
xrpv.sort_order
from
xxen_report_parameters_v xrpv,
table(xxen_util.rowgen(regexp_count(xrpv.sql_text,'xxen_util\.dff_columns\((p_table_name=>)?''(\w+)'''))) x
where
lower(xrpv.sql_text) like '%xxen_util.dff_columns%'
) y
where
upper(y.dff_table_name) not in (select fdfv.application_table_name from fnd_descriptive_flexs_vl fdfv where fdfv.descriptive_flexfield_name not like '$SRS$%')
order by
y.report_name,
y.parameter_name,
y.sort_order