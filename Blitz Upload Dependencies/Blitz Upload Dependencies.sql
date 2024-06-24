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
xud.upload_parameter_id,
xxen_util.user_name(xud.created_by) created_by,
xxen_util.client_time(xud.creation_date) creation_date,
xxen_util.user_name(xud.last_updated_by) last_updated_by,
xxen_util.client_time(xud.last_update_date) last_update_date
from
xxen_upload_dependencies xud,
xxen_reports_v xrv,
xxen_report_parameters_v xrpv,
xxen_upload_parameters xup
where
1=1 and
xud.report_id=xrv.report_id and
xud.report_parameter_id=xrpv.parameter_id(+) and
xud.upload_parameter_id=xup.parameter_id(+)
order by
xrv.report_name,
xrpv.parameter_name,
xup.parameter_name,
xup.column_name,
xud.dependent_column_name