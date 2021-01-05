/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Items, Folders and Formulas
-- Description: Discoverer items (expressions) and folders (objects), including join conditions and formulas (calculated items)
-- Excel Examle Output: https://www.enginatics.com/example/dis-items-folders-and-formulas/
-- Library Link: https://www.enginatics.com/reports/dis-items-folders-and-formulas/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.dis_business_area(eo.obj_id,'&eul') business_area,
eo.obj_name folder_name,
xxen_util.dis_folder_type(eo.obj_type) folder_type,
nvl2(eo.sobj_ext_table,nvl2(uv.view_name,'View','Table'),null) object_type,
eo.sobj_ext_table object_name,
&sql_text_columns
eo2.obj_name join_folder_name,
xxen_util.meaning(ee.fk_mstr_no_detail,'SYS_YES_NO',700) outer_join,
ee.exp_name item_name,
ee.key_name join_name,
xxen_util.dis_item_type(ee.exp_type) item_type,
decode(ee.exp_data_type,1,'Varchar',2,'Number',3,'Long',4,'Date',5,'Raw',6,'Large binary object',8,'Char',10,null,ee.exp_data_type) data_type,
ee.it_ext_column db_column_name,
xxen_util.dis_formula_sql(ee.exp_id,'&eul') formula,
ee.exp_formula1,
ee.exp_id,
ee.exp_type,
eo.obj_id
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
&eul.eul5_objs eo2,
user_views uv
where
1=1 and
decode(ee.exp_type,'FIL',ee.fil_obj_id,'CI',ee.it_obj_id,'CO',ee.it_obj_id,'JP',ee.key_obj_id)=eo.obj_id(+) and
ee.fk_obj_id_remote=eo2.obj_id(+) and
eo.sobj_ext_table=uv.view_name(+)
order by
eo.obj_name,
decode(ee.exp_type,'FIL',2,1),
ee.exp_sequence