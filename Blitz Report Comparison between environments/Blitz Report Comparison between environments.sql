/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Comparison between environments
-- Description: Shows Blitz Report differences between the local and a remote database server.

Requires following view to be created on the remote environment to avoid ORA-64202: remote temporary or abstract LOB locator is encountered

create or replace view xxen_reports_v_ as
select
xrv.*,
dbms_lob.substr(xxen_util.clob_substrb(xrv.sql_text_full,4000,1)) sql_text_short
from
xxen_reports_v xrv;
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-comparison-between-environments/
-- Library Link: https://www.enginatics.com/reports/blitz-report-comparison-between-environments/
-- Run Report: https://demo.enginatics.com/

select
case
when x.report_name is not null and x.updated_remote='Y' and (x.name_diff='Y' or x.descr_diff='Y' or x.sql_diff='Y') then 'conflict'
when x.report_name is null and x.report_name_remote is not null then 'add to local database'
when x.report_name is not null and x.report_name_remote is null then 'transfer'
when x.name_diff='Y' or x.descr_diff='Y' or x.sql_diff='Y' then 'update'
end result,
x.*
from
(
select
(select 'Y' from fnd_user@&database_link fu where xrv2.last_updated_by=fu.user_id and fu.user_name not in ('ANONYMOUS','ENGINATICS')) updated_remote,
case when xrv.report_name<>xrv2.report_name then 'Y' end name_diff,
case when xrv.guid<>xrv2.guid then 'Y' end guid_diff,
case when xrv.sql_text_short<>xrv2.sql_text_short or xrv.sql_length<>xrv2.sql_length then 'Y' end sql_diff,
case when xrv.description<>xrv2.description then 'Y' end descr_diff,
case when xrv.report_name is not null and xrv2.report_name is not null and nvl(xrv.category,'x')<>nvl(xrv2.category,'x') then 'Y' end category_diff,
xrv.type_dsp type,
xrv.category,
xrv2.type_dsp type_remote,
xrv2.category category_remote,
xrv.report_name,
xrv2.report_name report_name_remote,
xrv.description,
xrv2.description description_remote,
(select count(*) from xxen_report_parameters xrp where xrv.report_id=xrp.report_id) parameter_count,
(select count(*) from xxen_report_parameters@&database_link xrp where xrv2.report_id=xrp.report_id) parameter_count_remote,
xxen_util.user_name(xrv.last_updated_by) last_updated_by,
xrv.last_update_date,
xxen_util.user_name@&database_link(xrv2.last_updated_by) last_updated_by_remote,
xrv2.last_update_date last_update_date_remote,
xxen_util.user_name(xrv.created_by) created_by,
xrv.creation_date,
xxen_util.user_name@&database_link(xrv2.created_by) created_by_remote, 
xrv2.creation_date creation_date_remote,
xrv.sql_text_short sql_text,
xrv2.sql_text_short sql_text_remote
from
(select xrv.*, dbms_lob.substr(xrv.sql_text,4000,1) sql_text_short from xxen_reports_v xrv where 1=1) xrv
full join
(select xrv.* from xxen_reports_v_@&database_link xrv where 1=1) xrv2
on
xrv.guid=xrv2.guid or
xrv.report_name=xrv2.report_name
) x
where
2=2
order by
coalesce(x.name_diff,x.descr_diff,x.sql_diff),
x.last_update_date_remote desc nulls last,
x.last_update_date desc