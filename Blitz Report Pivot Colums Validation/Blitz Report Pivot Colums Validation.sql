/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Pivot Colums Validation
-- Description: Checks if records in xxen_report_template_pivot have a corresponding record in xxen_report_template_columns
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-pivot-colums-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-pivot-colums-validation/
-- Run Report: https://demo.enginatics.com/

select
xrtv.report_name,
xrtv.category,
xrtv.template_name,
nvl2(xrtc.template_id,'column exists','corrupt') template_column_check,
xrtp.column_name,
xrtp.field_type,
xrtp.display_sequence,
xrtp.aggregation,
xxen_util.user_name(xrtp.created_by) created_by,
xxen_util.client_time(xrtp.creation_date) creation_date,
xxen_util.user_name(xrtp.last_updated_by) last_updated_by,
xxen_util.client_time(xrtp.last_update_date) last_update_date,
xrtp.template_id
from
xxen_report_templates_v xrtv,
xxen_report_template_pivot xrtp,
xxen_report_template_columns xrtc
where
1=1 and
xrtv.template_id=xrtp.template_id and
xrtp.template_id=xrtc.template_id(+) and
xrtp.column_name=xrtc.column_name(+)
order by
xrtv.category,
xrtv.report_name,
xrtv.template_name,
xrtp.column_name