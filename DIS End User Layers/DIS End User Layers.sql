/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS End User Layers
-- Description: Discoverer end user layers
-- Excel Examle Output: https://www.enginatics.com/example/dis-end-user-layers/
-- Library Link: https://www.enginatics.com/reports/dis-end-user-layers/
-- Run Report: https://demo.enginatics.com/

select
x.schema_name,
x.created,
y.folder_count,
y.workbook_count,
y.ads_sql_count,
case when x.current_table_owner<>x.new_table_owner then 'create or replace synonym apps.ams_discoverer_sql for '||lower(x.new_table_owner)||'.ams_discoverer_sql;' end ads_synonym_change,
case when x.current_eul<>x.schema_name then 'begin update xxen_report_parameter_lovs xrpl set xrpl.lov_query=replace(xrpl.lov_query,'''||x.current_eul||'.'','''||x.schema_name||'.''),xrpl.last_updated_by=xxen_util.user_id(''ENGINATICS''),xrpl.last_update_date=sysdate where xrpl.lov_query like ''%'||x.current_eul||'%'' and xrpl.lov_name like ''DIS %''; commit; end;' end lov_eul_change
from
(
select
(select ds.table_owner from dba_synonyms ds where ds.owner='APPS' and ds.table_name='AMS_DISCOVERER_SQL') current_table_owner,
nvl((select do.owner from dba_tables dt where do.owner=dt.owner and dt.table_name='AMS_DISCOVERER_SQL'),'AMS') new_table_owner,
(select regexp_substr(dbms_lob.substr(xrpl.lov_query),'(\w+)\.eul5_bas eb',1,1,null,1) current_eul from xxen_report_parameter_lovs xrpl where xrpl.guid='8E2FF36EDF1179D2E0530100007F1FF2') current_eul,
lower(do.owner) schema_name,
do.owner,
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
) y
where
x.owner=y.owner(+)
order by
x.created desc