/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Parameter Comparison between environments
-- Description: Shows Blitz Report parameter differences between the local and a remote database server.

Requires following view to be created on the remote environment to avoid ORA-64202: remote temporary or abstract LOB locator is encountered

create or replace view xxen_report_parameters_v_ as
select
xrpv.*,
dbms_lob.substr(xxen_util.clob_substrb(xrpv.sql_text,4000,1)) sql_text_short,
dbms_lob.substr(xxen_util.clob_substrb(xrpv.lov_query,4000,1)) lov_query_short,
length(xrpv.sql_text) sql_length,
count(*) over (partition by xrpv.report_id) parameter_count
from
xxen_report_parameters_v xrpv;
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-parameter-comparison-between-environments/
-- Library Link: https://www.enginatics.com/reports/blitz-report-parameter-comparison-between-environments/
-- Run Report: https://demo.enginatics.com/

select
case
when x.report_name is not null and x.updated_remote='Y' and (x.sql_diff='Y') then 'conflict'
when x.report_name is null and x.report_name_remote is not null then 'add to local database'
when x.report_name is not null and x.report_name_remote is null then 'transfer'
when 
x.display_sequence_diff='Y' or
x.sql_diff='Y' or
x.parameter_type_diff='Y' or
x.lov_query_diff='Y' or
x.matching_value_diff='Y' or
x.default_value_diff='Y' or
x.descr_diff='Y'
then 'update'
end result,
x.*
from
(
select
xrpv1.report_name,
xrpv2.report_name report_name_remote,
xrpv1.category,
xrpv2.category category_remote,
xrpv1.display_sequence,
xrpv2.display_sequence display_sequence_remote,
xrpv1.parameter_name,
xrpv2.parameter_name parameter_name_remote,
xrpv1.anchor,
xrpv2.anchor anchor_remote,
xrpv1.parameter_type_dsp parameter_type,
xrpv2.parameter_type_dsp parameter_type_remote,
xrpv1.matching_value,
xrpv2.matching_value matching_value_remote,
xrpv1.default_value,
xrpv2.default_value default_value_remote,
xrpv1.description,
xrpv2.description description_remote,
(select 'Y' from fnd_user@&database_link fu where xrpv2.last_updated_by=fu.user_id and fu.user_name not in ('ANONYMOUS','ENGINATICS')) updated_remote,
case when xrpv1.display_sequence<>xrpv2.display_sequence then 'Y' end display_sequence_diff,
case when xrpv1.sql_text_short<>xrpv2.sql_text_short or xrpv1.sql_length<>xrpv2.sql_length then 'Y' end sql_diff,
case when xrpv1.parameter_type_dsp<>xrpv2.parameter_type_dsp then 'Y' end parameter_type_diff,
case when xrpv1.lov_query_short<>xrpv2.lov_query_short then 'Y' end lov_query_diff,
case when xrpv1.matching_value<>xrpv1.matching_value then 'Y' end matching_value_diff,
case when xrpv1.default_value<>xrpv1.default_value then 'Y' end default_value_diff,
case when xrpv1.description<>xrpv2.description then 'Y' end descr_diff,
xrpv1.parameter_count,
xrpv2.parameter_count parameter_count_remote,
xxen_util.user_name(xrpv1.last_updated_by) last_updated_by,
xrpv1.last_update_date,
xxen_util.user_name@&database_link(xrpv2.last_updated_by) last_updated_by_remote,
xrpv2.last_update_date last_update_date_remote,
xxen_util.user_name(xrpv1.created_by) created_by,
xrpv1.creation_date,
xxen_util.user_name@&database_link(xrpv2.created_by) created_by_remote,
xrpv2.creation_date creation_date_remote,
xrpv1.sql_text_short sql_text,
xrpv2.sql_text_short sql_text_remote,
xrpv1.lov_query_short lov_query,
xrpv2.lov_query_short lov_query_remote
from
(
select
xrpv.*,
dbms_lob.substr(xxen_util.clob_substrb(xrpv.sql_text,4000,1)) sql_text_short,
dbms_lob.substr(xxen_util.clob_substrb(xrpv.lov_query,4000,1)) lov_query_short,
length(xrpv.sql_text) sql_length,
count(*) over (partition by xrpv.report_id) parameter_count
from
xxen_report_parameters_v xrpv
where
1=1
) xrpv1
full join
(select xrpv.* from xxen_report_parameters_v_@&database_link xrpv where 1=1) xrpv2
on
xrpv1.report_name=xrpv2.report_name and
xrpv1.parameter_name=xrpv2.parameter_name and
xrpv1.anchor=xrpv2.anchor and
nvl(xrpv1.matching_value,'x')=nvl(xrpv2.matching_value,'x')
) x
where
2=2
order by
x.sql_diff,
x.last_update_date_remote desc nulls last,
x.last_update_date desc