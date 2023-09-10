/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Assignments
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-assignments/
-- Library Link: https://www.enginatics.com/reports/blitz-report-assignments/
-- Run Report: https://demo.enginatics.com/

select distinct
xrav.report_name,
xrv.type_dsp type,
xrv.category,
xxen_util.meaning(xrv.enabled,'YES_NO',0) enabled,
xxen_util.meaning(xrav.include_exclude,'INCLUDE_EXCLUDE',0) include_exclude,
xrav.assignment_level_desc level_name,
xrav.level_value value,
xrav.description,
xrav.block_name form_block,
&columns
xxen_util.user_name(xrav.created_by) created_by,
xxen_util.client_time(xrav.creation_date) creation_date,
xxen_util.user_name(xrav.last_updated_by) last_updated_by,
xxen_util.client_time(xrav.last_update_date) last_update_date,
xrav.report_id,
xrav.id1
from
xxen_reports_v xrv,
xxen_report_assignments_v xrav,
(select xrzpvv.* from xxen_report_zoom_param_vals_v xrzpvv where '&show_form_parameter_defaults'='Y') xrzpvv
where
1=1 and
xrv.report_id=xrav.report_id and
xrav.assignment_id=xrzpvv.assignment_id(+)
order by
xrav.report_name,
xrav.assignment_level_desc,
xrav.level_value,
xrav.block_name
&order_by