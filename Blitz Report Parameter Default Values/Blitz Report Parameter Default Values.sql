/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter Default Values
-- Description: Blitz Report's user specific parameter default values
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameter-default-values/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-default-values/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.user_name(xrpdv.user_id) user_name,
xrpv.report_name,
xrpv.display_sequence,
xrpv.parameter_name,
xrpdv.default_value,
xxen_util.client_time(xrpdv.last_update_date) last_update_date
from
xxen_report_parameters_v xrpv,
xxen_report_param_default_vals xrpdv
where
xrpv.parameter_id=xrpdv.parameter_id
order by
user_name,
xrpv.report_name,
xrpv.display_sequence