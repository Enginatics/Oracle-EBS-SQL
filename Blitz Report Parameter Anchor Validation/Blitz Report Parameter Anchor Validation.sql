/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter Anchor Validation
-- Description: Checks if all parameter anchors exist in the xxen_report_parameter_anchors table.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameter-anchor-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-anchor-validation/
-- Run Report: https://demo.enginatics.com/

select
xrpv.category,
xrpv.report_name,
xrpv.display_sequence,
xrpv.parameter_name,
xrpv.anchor,
xrpv.sql_text,
xrpv.report_id,
(select count(*) from xxen_report_parameter_anchors xrpa where xrpv.report_id=xrpa.report_id) report_anchor_count
from
xxen_report_parameters_v xrpv
where
1=1 and
(xrpv.report_id,xrpv.anchor) not in (select xrpa.report_id, xrpa.anchor from xxen_report_parameter_anchors xrpa)
order by
xrpv.report_name,
xrpv.sort_order