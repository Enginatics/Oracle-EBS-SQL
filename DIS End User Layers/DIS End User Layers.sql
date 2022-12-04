/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS End User Layers
-- Description: Discoverer end user layers
-- Excel Examle Output: https://www.enginatics.com/example/dis-end-user-layers/
-- Library Link: https://www.enginatics.com/reports/dis-end-user-layers/
-- Run Report: https://demo.enginatics.com/

select
x.owner,
decode(x.current_ads_table_owner,x.new_ads_table_owner,xxen_util.meaning('Y','YES_NO',0)) ads_table_owner,
decode(x.current_lov_eul,x.new_lov_eul,xxen_util.meaning('Y','YES_NO',0)) lov_schema,
x.created,
y.ads_sqls,
y.folders,
y.workbooks "Workbooks (ed)",
y.active_workbooks "Active Workbooks (eqs)",
xdwx.count "Uploaded Workbooks (xdwx)",
xdw.count "Flattened Workbooks (xdw)",
xds.count "Flattened Sheet (xds)",
xrtv.count "Imported Templates (xrt)",
xrv.count "Imported Reports (xr)",
'begin'||chr(10)||
'execute immediate ''create or replace synonym apps.ams_discoverer_sql for '||lower(x.new_ads_table_owner)||'.ams_discoverer_sql'';'||chr(10)||
'update xxen_report_parameter_lovs xrpl set xrpl.lov_query=replace(xrpl.lov_query,'''||x.current_lov_eul||'.'','''||x.new_lov_eul||'.''),xrpl.last_updated_by=xxen_util.user_id(''SYSADMIN''),xrpl.last_update_date=sysdate where xrpl.lov_query like ''%'||x.current_lov_eul||'.%'' and xrpl.lov_name like ''DIS %'';'||chr(10)||
'update xxen_report_parameters xrp set xrp.lov_query=replace(xrp.lov_query,'''||x.current_lov_eul||'.'','''||x.new_lov_eul||'.''),xrp.last_updated_by=xxen_util.user_id(''SYSADMIN''),xrp.last_update_date=sysdate where xrp.lov_query like ''%'||x.current_lov_eul||'.%'' and xrp.parameter_id in (select xrpv.parameter_id from xxen_report_parameters_v xrpv where xrpv.report_name like ''DIS %'');'||chr(10)||
'update xxen_report_parameters xrp set xrp.sql_text=replace(xrp.sql_text,'''||x.current_lov_eul||'.'','''||x.new_lov_eul||'.''),xrp.last_updated_by=xxen_util.user_id(''SYSADMIN''),xrp.last_update_date=sysdate where xrp.sql_text like ''%'||x.current_lov_eul||'.%'' and xrp.parameter_id in (select xrpv.parameter_id from xxen_report_parameters_v xrpv where xrpv.report_name like ''DIS %'');'||chr(10)||
'update fnd_profile_option_values fpov set fpov.profile_option_value='''||x.new_lov_eul||''', fpov.last_updated_by=xxen_util.user_id(''SYSADMIN''), fpov.last_update_date=sysdate where fpov.profile_option_id=(select fpo.profile_option_id from fnd_profile_options fpo where fpo.profile_option_name=''XXEN_REPORT_DISCOVERER_DEFAULT_EUL'');'||chr(10)||
'commit;'||chr(10)||
'end;' change_command
from
(
select
lower(do.owner) owner,
(select regexp_substr(dbms_lob.substr(xrpl.lov_query),'(\w+)\.eul5_bas eb',1,1,null,1) current_eul from xxen_report_parameter_lovs xrpl where xrpl.guid='8E2FF36EDF1179D2E0530100007F1FF2') current_lov_eul,
lower(do.owner) new_lov_eul,
(select ds.table_owner from dba_synonyms ds where ds.owner='APPS' and ds.table_name='AMS_DISCOVERER_SQL') current_ads_table_owner,
nvl((select do.owner from dba_tables dt where do.owner=dt.owner and dt.table_name='AMS_DISCOVERER_SQL'),'AMS') new_ads_table_owner,
do.created
from
dba_objects do
where
1=1 and
do.object_type='TABLE' and
do.object_name='EUL5_VERSIONS'
) x,
(
&eul_object_counts
) y,
(select count(*) count, xdwx.eul from xxen_discoverer_workbook_xmls xdwx group by xdwx.eul) xdwx,
(select count(distinct xdw.doc_name||'.'||xdw.doc_owner) count, xdw.eul from xxen_discoverer_workbooks xdw group by xdw.eul) xdw,
(select count(distinct xds.doc_name||'.'||xds.doc_owner||'.'||xds.sheet_name) count, xds.eul from xxen_discoverer_sheets xds group by xds.eul) xds,
(select count(*) count, regexp_substr(xrtv.report_description,chr(10)||'EUL: (\w+)',1,1,null,1) eul from xxen_report_templates_v xrtv where xrtv.report_description like 'Imported Discoverer folders:%Object IDs: %EUL: %' group by regexp_substr(xrtv.report_description,chr(10)||'EUL: (\w+)',1,1,null,1)) xrtv,
(select count(*) count, regexp_substr(xrv.description,chr(10)||'EUL: (\w+)',1,1,null,1) eul from xxen_reports_v xrv where xrv.description like 'Imported Discoverer folders:%Object IDs: %EUL: %' group by regexp_substr(xrv.description,chr(10)||'EUL: (\w+)',1,1,null,1)) xrv
where
x.owner=y.owner(+) and
x.owner=xdwx.eul(+) and
x.owner=xdw.eul(+) and
x.owner=xds.eul(+) and
x.owner=xrtv.eul(+) and
x.owner=xrv.eul(+)
order by
x.created desc