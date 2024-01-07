/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Items, Folders and Formulas
-- Description: Discoverer items (expressions) and folders (objects), including join conditions and formulas (calculated items)
-- Excel Examle Output: https://www.enginatics.com/example/dis-items-folders-and-formulas/
-- Library Link: https://www.enginatics.com/reports/dis-items-folders-and-formulas/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.dis_business_area(eo.obj_id,:eul) business_area,
eo.obj_id,
ee.exp_id,
xxen_util.dis_folder_type(eo.obj_type) folder_type,
eo.obj_name folder_name,
nvl2(eo.sobj_ext_table,nvl2(uv.view_name,'View','Table'),null) object_type,
eo.sobj_ext_table object_name,
&sql_text_columns
xxen_util.dis_item_type(ee.exp_type) item_type,
ee.exp_name item_name,
eo3.obj_name join_folder_name,
xxen_util.meaning(ee.fk_mstr_no_detail,'SYS_YES_NO',700) outer_join,
ee.key_name join_name,
ee.fk_obj_id_remote,
ee.key_obj_id,
decode(ee.exp_data_type,1,'Varchar',2,'Number',3,'Long',4,'Date',5,'Raw',6,'Large binary object',8,'Char',10,null,ee.exp_data_type) data_type,
xxen_api.dis_formula_sql(ee.exp_id,:eul) formula,
ee.it_ext_column db_column_name,
eo2.obj_name lov_folder,
xxen_util.dis_folder_type(eo2.obj_type) lov_folder_type,
ee2.exp_name lov_item,
ee2.lov_query,
&lov_validation_error
edo.dom_name lov_item_class,
ee.exp_formula1,
ee.exp_type,
ee2.it_obj_id lov_obj_id,
ee2.exp_id lov_exp_id,
ee2.exp_type lov_exp_type,
ee2.it_ext_column lov_column_name
from
(
select
ee.*,
ekc.key_name,
ekc.key_obj_id,
ekc.fk_obj_id_remote,
ekc.fk_mstr_no_detail
from
&eul.eul5_expressions ee,
&eul.eul5_key_cons ekc
where
decode(ee.exp_type,'JP',ee.jp_key_id)=ekc.key_id(+)
) ee,
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
user_views uv,
&eul.eul5_domains edo,
(select xxen_util.dis_lov_query(ee2.exp_id,:eul) lov_query, ee2.* from &eul.eul5_expressions ee2) ee2,
&eul.eul5_objs eo2,
&eul.eul5_objs eo3
where
1=1 and
decode(ee.exp_type,'FIL',ee.fil_obj_id,'CI',ee.it_obj_id,'CO',ee.it_obj_id,'JP',ee.key_obj_id)=eo.obj_id(+) and
ee.it_dom_id=edo.dom_id(+) and
edo.dom_it_id_lov=ee2.exp_id(+) and
ee2.it_obj_id=eo2.obj_id(+) and
ee.fk_obj_id_remote=eo3.obj_id(+) and
eo.sobj_ext_table=uv.view_name(+)
order by
eo.obj_name,
decode(ee.exp_type,'CO',1,'CI',2,'FIL',3,'JP',4),
ee.exp_sequence