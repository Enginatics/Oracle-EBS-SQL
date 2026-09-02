/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter Default Value Validation
-- Description: Lists report parameters whose LOV returns an id that differs from the displayed value, and shows whether the parameter's default value is stored as that id or as the display text.

Default Value Correct is the id the LOV resolves the stored default to. Where it differs from Default Value, the default was entered as the display value instead of the id. Use the 'Show non matching defaults only' parameter to list those cases.

The framework binds the id for such LOVs, so a report level default given as display text only works through a fallback validation, which costs an additional LOV execution every time the run screen opens and is ambiguous if the same text also exists as an id. Template and user level defaults are matched against the id only, so there the display text does not resolve at all.

Is Function and Is Select show whether the default is expressed as a function, e.g. fnd_profile.value, or as a select statement, and Dupl Count how many of the listed parameters share the identical default expression.

Use the Category and Report Name parameters to limit the scope.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameter-default-value-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-default-value-validation/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
xrpv.report_name,
xrpv.category,
xrpv.display_sequence,
xrpv.parameter_name,
xxen_report.is_function(xrpv.default_value,xrpv.parameter_type) is_function,
xxen_report.is_select_(xrpv.default_value) is_select,
xrpv.parameter_type_dsp,
xrpv.lov_name,
count(*) over (partition by xrpv.default_value) dupl_count,
xrpv.default_value,
xrpv.lov_query_dsp,
xxen_util.user_name(xrpv.last_updated_by) last_updated_by,
xxen_util.client_time(xrpv.last_update_date) last_update_date,
xxen_report.value_to_id(xrpv.parameter_id,xrpv.default_value) default_value_correct
from
xxen_report_parameters_v xrpv
where
1=1 and
xrpv.display_sequence is not null and
xxen_api.lov_value_equal_to_id(xrpv.parameter_id) is null and
xrpv.default_value is not null
) x
where
2=2
order by
1,2,3