/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Text Search
-- Description: This report can be used to understand which reports, parameters or LOVs contain a certain SQL Text string, or which reports currently use a specific LOV.

It is used to preview all records that would be changed through the Blitz Report mass change functionality in Setup Window>Tools>Mass Change
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-text-search/
-- Library Link: https://www.enginatics.com/reports/blitz-report-text-search/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
xrv.report_name,
xrv.type_dsp report_type,
xrv.category,
'Report SQL' record_type,
xrv.report_name name,
xrv.sql_text text,
xxen_util.user_name(xrv.created_by) created_by,
xxen_util.client_time(xrv.creation_date) creation_date,
xxen_util.user_name(xrv.last_updated_by) last_updated_by,
xxen_util.client_time(xrv.last_update_date) last_update_date
from
xxen_reports_v xrv
where
1=1 and
regexp_like(xrv.sql_text_full,&regexp_escape(:sql_text)&insensitive) and
(:not_sql_text is null or not regexp_like(xrv.sql_text_full,&regexp_escape(:not_sql_text)&insensitive))
union all
select
xrv.report_name,
xrv.type_dsp report_type,
xrv.category,
'Upload Excel Validation' record_type,
xrv.report_name name,
to_clob(xrv.upload_excel_validation) text,
xxen_util.user_name(xrv.created_by) created_by,
xxen_util.client_time(xrv.creation_date) creation_date,
xxen_util.user_name(xrv.last_updated_by) last_updated_by,
xxen_util.client_time(xrv.last_update_date) last_update_date
from
xxen_reports_v xrv
where
1=1 and
regexp_like(xrv.upload_excel_validation,&regexp_escape(:sql_text)&insensitive) and
(:not_sql_text is null or not regexp_like(xrv.upload_excel_validation,&regexp_escape(:not_sql_text)&insensitive))
union all
select
xrpv.report_name,
xrpv.type_dsp,
xrpv.category,
'Parameter SQL Text' record_type,
xrpv.parameter_name name,
xrpv.sql_text text,
xxen_util.user_name(xrpv.created_by) created_by,
xxen_util.client_time(xrpv.creation_date) creation_date,
xxen_util.user_name(xrpv.last_updated_by) last_updated_by,
xxen_util.client_time(xrpv.last_update_date) last_update_date
from
xxen_report_parameters_v xrpv
where
2=2 and
regexp_like(xrpv.sql_text,&regexp_escape(:sql_text)&insensitive) and
(:not_sql_text is null or not regexp_like(xrpv.sql_text,&regexp_escape(:not_sql_text)&insensitive))
union all
select
xrpv.report_name,
xrpv.type_dsp,
xrpv.category,
'Parameter Custom LOV Query' record_type,
xrpv.parameter_name name,
xrpv.lov_query text,
xxen_util.user_name(xrpv.created_by) created_by,
xxen_util.client_time(xrpv.creation_date) creation_date,
xxen_util.user_name(xrpv.last_updated_by) last_updated_by,
xxen_util.client_time(xrpv.last_update_date) last_update_date
from
xxen_report_parameters_v xrpv
where
2=2 and
regexp_like(xrpv.lov_query,&regexp_escape(:sql_text)&insensitive) and
(:not_sql_text is null or not regexp_like(xrpv.lov_query,&regexp_escape(:not_sql_text)&insensitive))
union all
select
xrpv.report_name,
xrpv.type_dsp,
xrpv.category,
'Parameter Default Value' record_type,
xrpv.parameter_name name,
to_clob(xrpv.default_value) text,
xxen_util.user_name(xrpv.created_by) created_by,
xxen_util.client_time(xrpv.creation_date) creation_date,
xxen_util.user_name(xrpv.last_updated_by) last_updated_by,
xxen_util.client_time(xrpv.last_update_date) last_update_date
from
xxen_report_parameters_v xrpv
where
2=2 and
regexp_like(xrpv.default_value,&regexp_escape(:sql_text)&insensitive) and
(:not_sql_text is null or not regexp_like(xrpv.default_value,&regexp_escape(:not_sql_text)&insensitive))
union all
select
null report_name,
null report_type,
null category,
'LOV Query' record_type,
xrpl.lov_name name,
xrpl.lov_query text,
xxen_util.user_name(xrpl.created_by) created_by,
xxen_util.client_time(xrpl.creation_date) creation_date,
xxen_util.user_name(xrpl.last_updated_by) last_updated_by,
xxen_util.client_time(xrpl.last_update_date) last_update_date
from
xxen_report_parameter_lovs xrpl
where
3=3 and
regexp_like(xrpl.lov_query,&regexp_escape(:sql_text)&insensitive) and
(:not_sql_text is null or not regexp_like(xrpl.lov_query,&regexp_escape(:not_sql_text)&insensitive))
union all
select
null report_name,
null report_type,
null category,
'LOV Value to Id Query' record_type,
xrpl.lov_name name,
to_clob(xrpl.value_to_id_query) text,
xxen_util.user_name(xrpl.created_by) created_by,
xxen_util.client_time(xrpl.creation_date) creation_date,
xxen_util.user_name(xrpl.last_updated_by) last_updated_by,
xxen_util.client_time(xrpl.last_update_date) last_update_date
from
xxen_report_parameter_lovs xrpl
where
3=3 and
regexp_like(xrpl.value_to_id_query,&regexp_escape(:sql_text)&insensitive) and
(:not_sql_text is null or not regexp_like(xrpl.value_to_id_query,&regexp_escape(:not_sql_text)&insensitive))
union all
select
xucv.report_name,
'Upload' report_type,
xucv.category,
'Upload Column Custom LOV Query' record_type,
xucv.column_name name,
xucv.lov_query text,
xxen_util.user_name(xucv.created_by) created_by,
xxen_util.client_time(xucv.creation_date) creation_date,
xxen_util.user_name(xucv.last_updated_by) last_updated_by,
xxen_util.client_time(xucv.last_update_date) last_update_date
from
xxen_upload_columns_v xucv
where
4=4 and
regexp_like(xucv.lov_query,&regexp_escape(:sql_text)&insensitive) and
(:not_sql_text is null or not regexp_like(xucv.lov_query,&regexp_escape(:not_sql_text)&insensitive))
union all
select
xucv.report_name,
'Upload' report_type,
xucv.category,
'Upload Column Value to Id Query' record_type,
xucv.column_name name,
to_clob(xucv.value_to_id_query) text,
xxen_util.user_name(xucv.created_by) created_by,
xxen_util.client_time(xucv.creation_date) creation_date,
xxen_util.user_name(xucv.last_updated_by) last_updated_by,
xxen_util.client_time(xucv.last_update_date) last_update_date
from
xxen_upload_columns_v xucv
where
4=4 and
regexp_like(xucv.value_to_id_query,&regexp_escape(:sql_text)&insensitive) and
(:not_sql_text is null or not regexp_like(xucv.value_to_id_query,&regexp_escape(:not_sql_text)&insensitive))
union all
select
xucv.report_name,
'Upload' report_type,
xucv.category,
'Upload Column Default Value' record_type,
xucv.column_name name,
to_clob(xucv.default_value) text,
xxen_util.user_name(xucv.created_by) created_by,
xxen_util.client_time(xucv.creation_date) creation_date,
xxen_util.user_name(xucv.last_updated_by) last_updated_by,
xxen_util.client_time(xucv.last_update_date) last_update_date
from
xxen_upload_columns_v xucv
where
4=4 and
regexp_like(xucv.default_value,&regexp_escape(:sql_text)&insensitive) and
(:not_sql_text is null or not regexp_like(xucv.default_value,&regexp_escape(:not_sql_text)&insensitive))
union all
select
xucv.report_name,
'Upload' report_type,
xucv.category,
'Upload Column Comments' record_type,
xucv.column_name name,
to_clob(xucv.comments) text,
xxen_util.user_name(xucv.created_by) created_by,
xxen_util.client_time(xucv.creation_date) creation_date,
xxen_util.user_name(xucv.last_updated_by) last_updated_by,
xxen_util.client_time(xucv.last_update_date) last_update_date
from
xxen_upload_columns_v xucv
where
4=4 and
regexp_like(xucv.comments,&regexp_escape(:sql_text)&insensitive) and
(:not_sql_text is null or not regexp_like(xucv.comments,&regexp_escape(:not_sql_text)&insensitive))
) x
where
10=10
order by
x.record_type,
x.report_name,
x.name