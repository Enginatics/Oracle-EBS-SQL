/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter Uniqueness Validation
-- Description: Validates if there are any duplicate blitz report parameters
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameter-uniqueness-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-uniqueness-validation/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
case
when xrpv.dupl_matching_value>1 then 'Duplicate matching value'
when xrpv.dupl_parameter_name>1 then 'Duplicate parameter name'
when xrpv.dupl_bind_anchor>1 then 'Duplicate bind anchor'
when xrpv.dupl_parameter>1 then 'Duplicated parameter sql text with the same anchor'
end problem,
xrpv.*
from
(
select
xrpv.report_name,
xrpv.category,
xrpv.display_sequence,
xrpv.parameter_name,
xrpv.anchor,
xrpv.matching_value,
xrpv.sort_order,
count(nvl2(xrpv.matching_value,xrpv.parameter_id,null)) over (partition by xrpv.report_id, xrpv.parameter_name, xrpv.anchor, xrpv.matching_value) dupl_matching_value,
count(nvl2(xrpv.display_sequence,xrpv.parameter_id,null)) over (partition by xrpv.report_id, xrpv.parameter_name) dupl_parameter_name,
count(case when xrpv.anchor like ':%' then xrpv.parameter_id end) over (partition by xrpv.report_id, xrpv.anchor) dupl_bind_anchor,
count(*) over (partition by xrpv.report_id, xrpv.parameter_name, xrpv.anchor, xrpv.matching_value) dupl_parameter,
xrpv.report_id,
xrpv.parameter_id
from
xxen_report_parameters_v xrpv
) xrpv
) x
where
1=1
order by
x.report_name,
x.sort_order