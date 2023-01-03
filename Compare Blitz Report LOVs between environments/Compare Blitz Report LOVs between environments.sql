/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Compare Blitz Report LOVs between environments
-- Description: Requires following view to be created on the remote environment to avoid ORA-64202: remote temporary or abstract LOB locator is encountered

create or replace view xxen_report_parameter_lovs_v_ as
select
xrplv.*,
dbms_lob.substr(xrplv.lov_query,4000,1) lov_query_short
from
xxen_report_parameter_lovs_v xrplv;
-- Excel Examle Output: https://www.enginatics.com/example/compare-blitz-report-lovs-between-environments/
-- Library Link: https://www.enginatics.com/reports/compare-blitz-report-lovs-between-environments/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
case
when xrplv.guid is not null and (select fu.user_name from fnd_user@&database_link fu where xrplv2.last_updated_by=fu.user_id) not in ('ANONYMOUS','ENGINATICS') then 'conflict'
when xrplv.guid is null and xrplv2.guid is not null then 'add to local database'
when xrplv.guid is not null and xrplv2.guid is null then 'transfer'
else 'update'
end result,
case when xrplv.lov_name<>xrplv2.lov_name then 'Y' end name_diff,
case when dbms_lob.substr(xrplv.lov_query,4000,1)<>xrplv2.lov_query_short then 'Y' end query_diff,
case when xrplv.description<>xrplv2.description then 'Y' end descr_diff,
xrplv.lov_name,
xrplv2.lov_name lov_name_remote,
xrplv.description,
xrplv2.description description_remote,
(
select distinct
listagg(xrv.report_name,chr(10)) within group (order by xrv.report_name) over (partition by xrplv.lov_id) report_names
from
xxen_report_parameters xrp,
xxen_reports_v xrv
where
xrplv.lov_id=xrp.lov_id and
xrp.parameter_type='LOV' and
xrp.report_id=xrv.report_id and
rownum<=60
) report_names,
(
select distinct
listagg(xrv.report_name,chr(10)) within group (order by xrv.report_name) over (partition by xrplv.lov_id) report_names
from
xxen_report_parameters@&database_link xrp,
xxen_reports_v@&database_link xrv
where
xrplv2.lov_id=xrp.lov_id and
xrp.parameter_type='LOV' and
xrp.report_id=xrv.report_id and
rownum<=60
) report_names_remote,
xxen_util.user_name(xrplv.last_updated_by) last_updated_by,
xrplv.last_update_date,
xxen_util.user_name@&database_link(xrplv2.last_updated_by) last_updated_by_remote,
xrplv2.last_update_date last_update_date_remote,
xxen_util.user_name(xrplv.created_by) created_by,
xrplv.creation_date,
xxen_util.user_name@&database_link(xrplv2.created_by) created_by_remote,
xrplv2.creation_date creation_date_remote,
xrplv.lov_query,
xrplv2.lov_query lov_query_remote
from
xxen_report_parameter_lovs_v xrplv
full join
xxen_report_parameter_lovs_v_@&database_link xrplv2
on
xrplv.guid=xrplv2.guid
where
1=1
) x
where
nvl(x.lov_name,'x')<>nvl(x.lov_name_remote,'x') or
x.name_diff is not null or
x.descr_diff is not null or
x.query_diff is not null
order by
coalesce(x.name_diff,x.descr_diff,x.query_diff),
x.last_update_date_remote desc nulls last,
x.last_update_date desc