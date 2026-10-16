/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter Link Validation
-- Description: Lists orphaned parameter rows: additional-anchor (sub) parameter rows - those without a display sequence - that do not link to a visible parameter of the same name in the same report (parameterid not in xxenreportparameterslinkv).
-- These are typically left behind by an incomplete parameter rename (e.g. 'Show DFF Attributes' to 'DFF Display'), leaving the old-named multi-anchor sub-rows dangling.
-- The run-time SQL is assembled solely from xxenreportparameterslinkv, so an unlinked sub-row is never injected and is harmless at run time, but it clutters the parameter setup and would re-activate unexpectedly if a visible parameter with the old name were re-created.
-- Use the Category parameter to limit the scope.
-- Excel Example Output: https://www.enginatics.com/example/blitz-report-parameter-link-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-link-validation/
-- Run Report: https://demo.enginatics.com/

select
xrpv.report_name,
xrpv.category,
xrpv.display_sequence,
xrpv.parameter_name,
xrpv.anchor,
xrpv.sql_text,
xxen_util.user_name(xrpv.created_by) created_by,
xxen_util.client_time(xrpv.creation_date) creation_date,
xxen_util.user_name(xrpv.last_updated_by) last_updated_by,
xxen_util.client_time(xrpv.last_update_date) last_update_date,
xrpv.report_id,
xrpv.parameter_id
from
xxen_report_parameters_v xrpv
where
1=1 and
xrpv.parameter_id not in (select xrplv.parameter_id from xxen_report_parameters_link_v xrplv)
order by
xrpv.report_name,
xrpv.parameter_name,
xrpv.anchor
