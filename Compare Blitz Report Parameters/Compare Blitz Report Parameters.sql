/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Compare Blitz Report Parameters
-- Description: Compares the paramaters of two reports for differences
-- Excel Examle Output: https://www.enginatics.com/example/compare-blitz-report-parameters/
-- Library Link: https://www.enginatics.com/reports/compare-blitz-report-parameters/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
xrpv1.display_sequence display_sequence1,
xrpv2.display_sequence display_sequence2,
xrpv1.parameter_name parameter_name1,
xrpv2.parameter_name parameter_name2,
xrpv1.anchor anchor1,
xrpv2.anchor anchor2,
xrpv1.sql_text sql_text1,
xrpv2.sql_text sql_text2,
case when nvl(dbms_lob.substr(xrpv1.sql_text,32767,1),'x')<>nvl(dbms_lob.substr(xrpv2.sql_text,32767,1),'x') then 'different' end sql_text_check,
xrpv1.parameter_type_dsp parameter_type1,
xrpv2.parameter_type_dsp parameter_type2,
case when nvl(xrpv1.parameter_type,'x')<>nvl(xrpv2.parameter_type,'x') then 'different' end parameter_type_check,
xrpv1.lov_name lov_name1,
xrpv2.lov_name lov_name2,
case when nvl(xrpv1.lov_name,'x')<>nvl(xrpv2.lov_name,'x') then 'different' end lov_name_check,
xrpv1.lov_query lov_query1,
xrpv2.lov_query lov_query2,
case when nvl(dbms_lob.substr(xrpv1.lov_query,32767,1),'x')<>nvl(dbms_lob.substr(xrpv2.lov_query,32767,1),'x') then 'different' end lov_query_check,
xrpv1.matching_value matching_value1,
xrpv2.matching_value matching_value2,
case when nvl(xrpv1.matching_value,'x')<>nvl(xrpv2.matching_value,'x') then 'different' end matching_value_check,
xrpv1.default_value default_value1,
xrpv2.default_value default_value2,
case when nvl(xrpv1.default_value,'x')<>nvl(xrpv2.default_value,'x') then 'different' end default_value_check,
xrpv1.description description1,
xrpv2.description description2,
case when nvl(xrpv1.description,'x')<>nvl(xrpv2.description,'x') then 'different' end description_check,
xrpv1.required required1,
xrpv2.required required2,
case when nvl(xrpv1.required,'x')<>nvl(xrpv2.required,'x') then 'different' end required_check
from
(select xrpv.* from xxen_report_parameters_v xrpv where xrpv.report_name=:report_name1) xrpv1
full join
(select xrpv.* from xxen_report_parameters_v xrpv where xrpv.report_name=:report_name2) xrpv2
on
(
xrpv1.parameter_name=xrpv2.parameter_name and
nvl(xrpv1.anchor,'x')=nvl(xrpv2.anchor,'x') and
nvl(xrpv1.matching_value,'x')=nvl(xrpv2.matching_value,'x')
)
) x
where
1=1