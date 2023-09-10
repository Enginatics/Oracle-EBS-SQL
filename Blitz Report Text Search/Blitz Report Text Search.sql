/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
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
xrv.type_dsp report_type,
xrv.category,
xrv.report_name,
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
(:case_sensitive is null and regexp_like(xrv.sql_text_full,xxen_util.regexp_escape(:sql_text),'i') or xrv.sql_text_full like '%'||replace(:sql_text,'_','\_')||'%' escape '\')
union all
select
xrpv.type_dsp,
xrpv.category,
xrpv.report_name,
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
5=5 and
(:case_sensitive is null and regexp_like(xrpv.sql_text,xxen_util.regexp_escape(:sql_text),'i') or xrpv.sql_text like '%'||replace(:sql_text,'_','\_')||'%' escape '\')
union all
select
xrpv.type_dsp,
xrpv.category,
xrpv.report_name,
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
6=6 and
(:case_sensitive is null and regexp_like(xrpv.lov_query,xxen_util.regexp_escape(:sql_text),'i') or xrpv.lov_query like '%'||replace(:sql_text,'_','\_')||'%' escape '\')
union all
select
xrpv.type_dsp,
xrpv.category,
xrpv.report_name,
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
7=7 and
(:case_sensitive is null and regexp_like(xrpv.default_value,xxen_util.regexp_escape(:sql_text),'i') or xrpv.default_value like '%'||replace(:sql_text,'_','\_')||'%' escape '\')
union all
select
null report_type,
null category,
null report_name,
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
(:case_sensitive is null and regexp_like(xrpl.lov_query,xxen_util.regexp_escape(:sql_text),'i') or xrpl.lov_query like '%'||replace(:sql_text,'_','\_')||'%' escape '\')
union all
select
xupcv.parameter_type,
xupcv.category,
xupcv.report_name,
'Upload Parameter Upload Query' record_type,
xupcv.parameter_name name,
xupcv.upload_query text,
xxen_util.user_name(xupcv.created_by) created_by,
xxen_util.client_time(xupcv.creation_date) creation_date,
xxen_util.user_name(xupcv.last_updated_by) last_updated_by,
xxen_util.client_time(xupcv.last_update_date) last_update_date
from
xxen_upload_parameter_cols_v xupcv
where
12=12 and
(:case_sensitive is null and regexp_like(xupcv.upload_query,xxen_util.regexp_escape(:sql_text),'i') or xupcv.upload_query like '%'||replace(:sql_text,'_','\_')||'%' escape '\')
union all
select
xucv.column_type_dsp,
xucv.category,
xucv.report_name,
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
8=8 and
9=9 and
(:case_sensitive is null and regexp_like(xucv.lov_query,xxen_util.regexp_escape(:sql_text),'i') or xucv.lov_query like '%'||replace(:sql_text,'_','\_')||'%' escape '\')
union all
select
xucv.column_type_dsp,
xucv.category,
xucv.report_name,
'Upload Column Default Value' record_type,
xucv.column_name name,
xucv.default_value text,
xxen_util.user_name(xucv.created_by) created_by,
xxen_util.client_time(xucv.creation_date) creation_date,
xxen_util.user_name(xucv.last_updated_by) last_updated_by,
xxen_util.client_time(xucv.last_update_date) last_update_date
from
xxen_upload_columns_v xucv
where
8=8 and
10=10 and
(:case_sensitive is null and regexp_like(xucv.default_value,xxen_util.regexp_escape(:sql_text),'i') or xucv.default_value like '%'||replace(:sql_text,'_','\_')||'%' escape '\')
union all
select
xucv.column_type_dsp,
xucv.category,
xucv.report_name,
'Upload Column Comments' record_type,
xucv.column_name name,
xucv.comments text,
xxen_util.user_name(xucv.created_by) created_by,
xxen_util.client_time(xucv.creation_date) creation_date,
xxen_util.user_name(xucv.last_updated_by) last_updated_by,
xxen_util.client_time(xucv.last_update_date) last_update_date
from
xxen_upload_columns_v xucv
where
8=8 and
11=11 and
(:case_sensitive is null and regexp_like(xucv.comments,xxen_util.regexp_escape(:sql_text),'i') or xucv.comments like '%'||replace(:sql_text,'_','\_')||'%' escape '\')
) x
where
4=4
order by
x.record_type,
x.report_name,
x.name