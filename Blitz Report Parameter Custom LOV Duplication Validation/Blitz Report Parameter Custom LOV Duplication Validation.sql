/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter Custom LOV Duplication Validation
-- Description: Blitz report parameters using custom LOVs with the same query more than once so that they should be set up as a shared LOV instead
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameter-custom-lov-duplication-validation/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-custom-lov-duplication-validation/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
count(*) over (partition by dbms_lob.substr(xrpv.lov_query_dsp,4000,1)) dupl_count,
count(nvl2(xrpv.lov_id,null,1)) over (partition by dbms_lob.substr(xrpv.lov_query_dsp,4000,1)) custom_count,
xrpv.report_name,
xrpv.category,
xrpv.display_sequence,
xrpv.parameter_name,
xrpv.parameter_type_dsp,
xrpv.lov_name,
dbms_lob.substr(xrpv.lov_query_dsp,4000,1) lov_query_dsp 
from
xxen_report_parameters_v xrpv
where
1=1 and
xrpv.parameter_type='LOV'
) x
where
x.dupl_count>1 and
x.custom_count>0
order by
x.dupl_count desc,
x.lov_query_dsp