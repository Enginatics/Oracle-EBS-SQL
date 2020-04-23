/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Folders, Busines Areas, Items and LOVs
-- Description: Discoverer folders, business areas and items.
Columns 'Access Count' and 'Last Accessed' shows how many times a folder was accessed by a worksheet within the past x days.
Parameter 'Show Active Only' restricts to folders which have been accessed by worksheet executions within the past x days.
-- Excel Examle Output: https://www.enginatics.com/example/dis-folders-busines-areas-items-and-lovs
-- Library Link: https://www.enginatics.com/reports/dis-folders-busines-areas-items-and-lovs
-- Run Report: https://demo.enginatics.com/


select
(
select distinct
listagg(eb.ba_name,chr(10)) within group (order by eb.ba_name) over (partition by ebol.bol_obj_id) business_area
from
&eul.eul5_ba_obj_links ebol,
&eul.eul5_bas eb
where
eo.obj_id=ebol.bol_obj_id and
ebol.bol_ba_id=eb.ba_id
) business_area,
eo.obj_name folder,
eo.obj_developer_key folder_identifier,
decode(eo.obj_type,'SOBJ','Standard','COBJ','Complex','CUO','Custom') folder_type,
nvl2(eo.sobj_ext_table,nvl2((select dv.view_name from dba_views dv where eo.sobj_ext_table=dv.view_name and dv.owner='APPS'),'View','Table'),null) object_type,
eo.sobj_ext_table object_name,
eqs.access_count,
eqs.last_accessed,
&sql_text_columns
eo.obj_description folder_description,
&item_columns
eo.obj_id folder_id,
xxen_util.dis_user_name(eo.obj_created_by) created_by,
xxen_util.client_time(eo.obj_created_date) creation_date,
xxen_util.dis_user_name(eo.obj_updated_by) last_updated_by,
xxen_util.client_time(eo.obj_updated_date) last_update_date
from
(
select
(
select
xxen_util.long_to_clob('SYS.VIEW$', 'TEXT', v.rowid) text
from
sys."_CURRENT_EDITION_OBJ" o,
sys.view$ v,
sys.user$ u
where
u.name='APPS' and
eo.sobj_ext_table=o.name and
o.obj#=v.obj# and
o.owner#=u.user#
) text,
eo.*
from
&eul.eul5_objs eo
) eo,
(
select ee.it_obj_id obj_id, ee.* from &eul.eul5_expressions ee where '&show_items'='Y' and ee.exp_type in ('CI','CO') and ee.fil_obj_id is null union all
select ee.fil_obj_id obj_id, ee.* from &eul.eul5_expressions ee where '&show_items'='Y' and ee.exp_type='FIL' and ee.it_obj_id is null
) ee,
&eul.eul5_domains edo,
(
select
eqs.obj_id,
count(*) access_count,
max(eqs.qs_created_date) last_accessed
from
(
select
trim(regexp_substr(eqs.qs_object_use_key,'[^\.]+',1,rowgen.column_value)) obj_id,
eqs.*
from
&eul.eul5_qpp_stats eqs,
table(xxen_util.rowgen(regexp_count(eqs.qs_object_use_key,'\.')+1)) rowgen
where
2=2
) eqs
where
translate(eqs.obj_id,'x0123456789','x') is null
group by
eqs.obj_id
) eqs
where
1=1 and
eo.obj_id=ee.obj_id(+) and
ee.it_dom_id=edo.dom_id(+) and
eo.obj_id=eqs.obj_id(+)
order by
eo.obj_name,
decode(ee.exp_type,'FIL',2,1),
ee.exp_sequence