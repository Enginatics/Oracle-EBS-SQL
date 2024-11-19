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
case when xud.upload_parameter_id>0 then 'Upload query' else decode(xud.upload_parameter_id,null,'LOV query',-1,'Column comment',-2,'Excel validation',-3,'Default value') end dependency_type,
xrpv.parameter_name,
xup.parameter_name upload_parameter_name,
xup.column_name xup_column_name,
xud.column_name,
xud.dependent_column_name,
xxen_util.meaning(nvl2(xud.upload_parameter_id,null,xucv.validate_from_list_dsp),'YES_NO',0) lov_validate_from_list,
xxen_util.meaning(nvl2(xud.upload_parameter_id,null,xucv.filter_before_display_dsp),'YES_NO',0) lov_filter_before_display,
case when xud.upload_parameter_id>0 then to_clob(xup.upload_query) else decode(xud.upload_parameter_id,null,xucv.lov_query_dsp,-1,xucv.comments,-2,xrv.upload_excel_validation,-3,xucv.default_value) end dependent_sql,
xud.upload_parameter_id,
xxen_util.user_name(xud.created_by) created_by,
xxen_util.client_time(xud.creation_date) creation_date,
xxen_util.user_name(xud.last_updated_by) last_updated_by,
xxen_util.client_time(xud.last_update_date) last_update_date
from
xxen_upload_dependencies xud,
xxen_reports_v xrv,
xxen_report_parameters_v xrpv,
xxen_upload_parameters xup,
xxen_upload_columns_v xucv
where
1=1 and
xud.report_id=xrv.report_id and
xud.report_parameter_id=xrpv.parameter_id(+) and
xud.upload_parameter_id=xup.parameter_id(+) and
xud.report_id=xucv.report_id(+) and
xud.dependent_column_name=xucv.column_name(+)
order by
xrv.report_name,
xrpv.parameter_name,
xup.parameter_name,
xup.column_name,
xud.dependent_column_name