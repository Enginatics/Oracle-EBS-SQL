/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter Default Values
-- Description: Blitz Report's user or template specific parameter default values
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameter-default-values/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-default-values/
-- Run Report: https://demo.enginatics.com/

select
xrpv.report_name,
xrpv.category,
nvl2(xrpdv.user_id,'User','Template') type,
xxen_util.user_name(xrpdv.user_id) user_name,
xrtv.template_name,
xrpv.display_sequence,
xrpv.parameter_name,
xrpdv.default_value,
xxen_util.user_name(xrpdv.created_by) created_by,
xxen_util.client_time(xrpdv.creation_date) creation_date,
xxen_util.user_name(xrpdv.last_updated_by) last_updated_by,
xxen_util.client_time(xrpdv.last_update_date) last_update_date
from
xxen_report_parameters_v xrpv,
xxen_report_param_default_vals xrpdv,
xxen_report_templates_v xrtv
where
1=1 and
xrpv.parameter_id=xrpdv.parameter_id and
xrpdv.template_id=xrtv.template_id(+)
order by
user_name,
xrpv.report_name,
xrpv.display_sequence