/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter Dependencies
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameter-dependencies/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-dependencies/
-- Run Report: https://demo.enginatics.com/

select
xrpv1.report_name,
xrpv1.category,
xrpv1.parameter_name,
xrpv2.parameter_name dependent_parameter_name,
':$flex$.'||xrpd.flex_bind flex_bind,
xrpv1.display_sequence,
xrpv2.display_sequence dependent_display_sequence,
xrpd.created_by,
xrpd.creation_date,
xrpd.last_updated_by,
xrpd.last_update_date,
xrpd.report_id,
xrpd.parameter_id,
xrpd.dependent_parameter_id
from
xxen_report_param_dependencies xrpd,
xxen_report_parameters_v xrpv1,
xxen_report_parameters_v xrpv2
where
1=1 and
xrpd.parameter_id=xrpv1.parameter_id and
xrpd.dependent_parameter_id=xrpv2.parameter_id