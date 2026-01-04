/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Upload Dependencies
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/blitz-upload-dependencies/
-- Library Link: https://www.enginatics.com/reports/blitz-upload-dependencies/
-- Run Report: https://demo.enginatics.com/

select
xrv.report_name,
xrv.category,
xud.dependency_type,
xud.flex_bind,
xrpv.parameter_name report_parameter_name,
lower(xud.column_name) column_name,
lower(xud.dependent_column_name) dependent_column_name,
xupv.parameter_name dependent_upload_parameter_name,
xxen_util.meaning(nvl2(xud.dependent_upload_parameter_id,null,xucv.validate_from_list_dsp),'YES_NO',0) lov_validate_from_list,
xxen_util.meaning(nvl2(xud.dependent_upload_parameter_id,null,xucv.filter_before_display_dsp),'YES_NO',0) lov_filter_before_display,
decode(xud.dependency_type,'LOV query',xucv.lov_query_dsp,'Default value',xucv.default_value,'Comments',xucv.comments,'Value to id query',xupv.value_to_id_query_dsp,'Excel validation',xrv.upload_excel_validation) dependent_sql,
xxen_util.user_name(xud.created_by) created_by,
xxen_util.client_time(xud.creation_date) creation_date,
xxen_util.user_name(xud.last_updated_by) last_updated_by,
xxen_util.client_time(xud.last_update_date) last_update_date,
xud.dependent_upload_parameter_id
from
xxen_upload_dependencies xud,
xxen_reports_v xrv,
xxen_report_parameters_v xrpv,
xxen_upload_parameters_v xupv,
xxen_upload_columns_v xucv
where
1=1 and
xud.report_id=xrv.report_id and
xud.report_parameter_id=xrpv.parameter_id(+) and
xud.dependent_upload_parameter_id=xupv.parameter_id(+) and
xud.report_id=xucv.report_id(+) and
xud.dependent_column_name=xucv.column_name(+)
order by
xrv.report_name,
xud.dependency_type,
xrpv.parameter_name,
xupv.parameter_name,
xupv.column_name,
xud.dependent_column_name