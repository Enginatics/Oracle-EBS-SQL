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
lower(do.owner) schema_name,
do.created,
'create or replace synonym apps.ams_discoverer_sql for '||nvl((select lower(do.owner) from dba_tables dt where do.owner=dt.owner and dt.table_name='AMS_DISCOVERER_SQL'),'ams')||'.ams_discoverer_sql' ads_synonym_change,
'begin update xxen_report_parameter_lovs xrpl set xrpl.lov_query=replace(xrpl.lov_query,''eul_us1.'','''||lower(do.owner)||'.''),xrpl.last_updated_by=xxen_util.user_id(''ENGINATICS''),xrpl.last_update_date=sysdate where xrpl.lov_query like ''%eul_us%'' and xrpl.lov_name like ''DIS %''; commit; end;' lov_eul_change 
from
dba_objects do
where
1=1 and
do.object_type='TABLE' and
do.object_name='EUL5_VERSIONS'
order by
do.created desc