/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Reports
-- Description: Blitz Reports with parameters and assignments.
If you are using the free version of Blitz Report, column 'Free 30 Reports' shows which reports are currently included.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-reports/
-- Library Link: https://www.enginatics.com/reports/blitz-reports/
-- Run Report: https://demo.enginatics.com/

with
anchors as (
select distinct
y.report_id,
listagg(y.anchor,', ') within group (order by y.anchor) over (partition by y.report_id) anchors
from
(
select distinct
xr.report_id,
dbms_lob.substr(regexp_substr(regexp_substr(xr.sql_text,'(\D|^)(\d+)=\2(\D|$)',1,x.column_value),'\d+=\d+')) anchor
from
(select xr.report_id, regexp_replace(replace(xr.sql_text,''''''),'''[^'']*''','''x''') sql_text from xxen_reports xr where 3=3) xr,
table(xxen_util.rowgen(regexp_count(xr.sql_text,'(\D|^)(\d+)=\2(\D|$)'))) x
where '&enable_anchors_lexicals_binds'='Y'
) y),
lexicals as (
select distinct
y.report_id,
listagg(y.lexical,', ') within group (order by y.lexical) over (partition by y.report_id) lexicals
from
(
select distinct
xr.report_id,
lower(dbms_lob.substr(regexp_substr(xr.sql_text,'&\w+',1,x.column_value))) lexical
from
(select xr.report_id, xr.sql_text from xxen_reports xr where 3=3 and xr.sql_text like '%&%') xr,
table(xxen_util.rowgen(regexp_count(xr.sql_text,'&\w+'))) x
where '&enable_anchors_lexicals_binds'='Y'
) y),
binds as (
select distinct
y.report_id,
listagg(y.bind,', ') within group (order by y.bind) over (partition by y.report_id) binds
from
(
select distinct
xr.report_id,
lower(dbms_lob.substr(regexp_substr(xr.sql_text,':\w+',1,x.column_value))) bind
from
(select xr.report_id, regexp_replace(replace(xr.sql_text,''''''),'''[^'']*''','''x''') sql_text from xxen_reports xr where 3=3 and xr.sql_text like '%:%') xr,
table(xxen_util.rowgen(regexp_count(xr.sql_text,':\w+'))) x
where '&enable_anchors_lexicals_binds'='Y'
) y)
select
xrv.report_name,
xxen_util.application_name(substr(xrv.report_name,1,instr(xrv.report_name,' ')-1)) application,
xxen_api.category(xrv.report_id) category,
xxen_util.meaning(case when xrv.row_num<=30 or xrv.seeded_blitz_report_flag='Y' then 'Y' end,'YES_NO',0) free_30_reports,
&columns
xrv.description,
&modifications
xrv0.report_name copied_from,
(select max(xrh.creation_date) from xxen_reports_h xrh where xrv.copied_from_guid=xrh.guid) copied_from_last_update_date,
xrv.db_package,
xxen_util.user_name(xrv.created_by) created_by,
xxen_util.client_time(xrv.creation_date) creation_date,
xxen_util.user_name(xrv.last_updated_by) last_updated_by,
xxen_util.client_time(xrv.last_update_date) last_update_date,
xxen_util.meaning(nvl(xrv.enabled,'N'),'YES_NO',0) enabled,
decode(xrv.template_count,0,null,xrv.template_count) template_count,
(select count(distinct xra.id1||','||xra.id2) from xxen_report_assignments xra where xrv.report_id=xra.report_id and xra.include_exclude='I') assignments_count,
(select count(distinct xra.id1||','||xra.id2) from xxen_report_assignments xra where xrv.report_id=xra.report_id and xra.assignment_level='A' and xra.include_exclude='I') application_assignments,
(select count(distinct xra.id1||','||xra.id2) from xxen_report_assignments xra where xrv.report_id=xra.report_id and xra.assignment_level='G' and xra.include_exclude='I') request_group_assignments,
(select count(distinct xra.id1||','||xra.id2) from xxen_report_assignments xra where xrv.report_id=xra.report_id and xra.assignment_level='F' and xra.include_exclude='I') forms_assignments,
&anchors_lexicals_binds
xrv.sql_length,
xrv.sql_text,
xrv.report_id,
xrv.guid
from
(
select
x.*,
row_number() over (order by x.seeded_flag nulls first,x.seeded_blitz_report_flag nulls first,x.report_id desc) row_num
from
(
select
xrv.*,
(select count(*) from xxen_report_templates xrt where xrv.report_id=xrt.report_id) template_count,
(select 'Y' from fnd_user fu where fu.user_name in ('ANONYMOUS','ENGINATICS') and xrv.created_by=fu.user_id) seeded_flag,
xxen_report.is_seeded_blitz_report(xrv.guid) seeded_blitz_report_flag
from
xxen_reports_v xrv
) x
) xrv,
xxen_reports_v xrv0,
(select xrpv.* from xxen_report_parameters_v xrpv where '&enable_parameters'='Y' and xrpv.display_sequence is not null) xrpv,
(select xrav.* from xxen_report_assignments_v xrav where '&enable_assignments'='Y') xrav,
(select count(*) execution_count, xrr.report_id from xxen_report_runs xrr where 2=2 and '&enable_exec_count'='Y' group by xrr.report_id) y,
anchors,
lexicals,
binds
where
1=1 and
xrv.copied_from_guid=xrv0.guid(+) and
xrv.report_id=xrpv.report_id(+) and
xrv.report_id=xrav.report_id(+) and
xrv.report_id=y.report_id(+) and
xrv.report_id=anchors.report_id(+) and
xrv.report_id=lexicals.report_id(+) and
xrv.report_id=binds.report_id(+)
order by
&order_by_free_30_reports
y.execution_count desc nulls last,
xrv.report_name,
xrpv.display_sequence,
xrav.include_exclude desc,
decode(xrav.assignment_level_desc,
'Site',1,
'Application',2,
'Organization',3,
'Request Group',4,
'Responsibility',5,
'User',6
),
xrav.level_value