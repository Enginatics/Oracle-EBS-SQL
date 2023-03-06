/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Workbooks, Folders, Items and LOVs
-- Description: Discoverer workbooks, their owners, folders, items and item class LOVs, derived from dependency table eul5_elem_xrefs.
-- Excel Examle Output: https://www.enginatics.com/example/dis-workbooks-folders-items-and-lovs/
-- Library Link: https://www.enginatics.com/reports/dis-workbooks-folders-items-and-lovs/
-- Run Report: https://demo.enginatics.com/

select
x.workbook,
x.description,
x.owner,
x.identifier workbook_identifier,
x.access_count,
x.last_accessed,
x.last_updated_by,
x.last_update_date,
&folder_columns
&item_columns
x.doc_id
from
(
select
ed.doc_name workbook,
ed.doc_description description,
nvl(xxen_util.dis_user_name(ed.doc_eu_id,:eul),xxen_util.dis_user(ed.doc_eu_id,:eul)) owner,
ed.doc_developer_key identifier,
eqs.access_count,
eqs.last_accessed,
xxen_util.dis_user_name(ed.doc_updated_by) last_updated_by,
ed.doc_updated_date last_update_date,
xxen_util.dis_business_area(eo.obj_id,:eul) business_area,
eo.obj_name folder,
eo.obj_developer_key folder_identifier,
xxen_util.dis_folder_type(eo.obj_type) folder_type,
nvl2(eo.sobj_ext_table,nvl2((select dv.view_name from dba_views dv where eo.sobj_ext_table=dv.view_name and dv.owner='APPS'),'View','Table'),null) object_type,
eo.sobj_ext_table object_name,
xxen_util.dis_folder_sql3(eo.obj_id,:eul) folder_sql,
case when lower(dbms_lob.substr(eo.text,15,length(eo.text)-14))=' with read only' then substr(eo.text,1,length(eo.text)-15) else eo.text end view_sql,
eo.obj_description folder_description,
eo.obj_id,
eex.ex_to_devkey,
eex.ex_to_type,
ed.doc_id
from
(
select
nvl(fu.user_name,eeu.eu_username) doc_owner,
ed.*
from
&eul.eul5_documents ed,
&eul.eul5_eul_users eeu,
fnd_user fu
where
ed.doc_eu_id=eeu.eu_id and
case when eeu.eu_username like '#%' then to_number(substr(eeu.eu_username,2)) end=fu.user_id
) ed,
(select distinct eex.ex_from_id, eex.ex_to_par_devkey, decode(:display_level,'Items',eex.ex_to_type) ex_to_type, decode(:display_level,'Items',eex.ex_to_devkey) ex_to_devkey from &eul.eul5_elem_xrefs eex where eex.ex_from_type='DOC' and :display_level in ('Folders','Items')) eex,
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
select
eqs.qs_doc_name,
upper(eqs.qs_doc_owner) qs_doc_owner,
count(*) access_count,
max(eqs.qs_created_date) last_accessed
from
&eul.eul5_qpp_stats eqs
where
2=2
group by
eqs.qs_doc_name,
eqs.qs_doc_owner
) eqs
where
1=1 and
ed.doc_id=eex.ex_from_id(+) and
eex.ex_to_par_devkey=eo.obj_developer_key(+) and
ed.doc_name=eqs.qs_doc_name(+) and
ed.doc_owner=eqs.qs_doc_owner(+)
) x,
(
select ee.it_obj_id obj_id, ee.* from &eul.eul5_expressions ee where ee.exp_type in ('CI','CO') and ee.fil_obj_id is null and :display_level='Items' union all
select ee.fil_obj_id obj_id, ee.* from &eul.eul5_expressions ee where ee.exp_type='FIL' and ee.it_obj_id is null and :display_level='Items'
) ee,
&eul.eul5_domains edo,
&eul.eul5_expressions ee2,
&eul.eul5_objs eo2,
(select ekc.* from &eul.eul5_key_cons ekc where :display_level='Items') ekc,
(select ef.* from &eul.eul5_functions ef where :display_level='Items') ef
where
x.obj_id=ee.obj_id(+) and
case when x.ex_to_type in ('ITE','FIL') then x.ex_to_devkey end=ee.exp_developer_key(+) and
ee.it_dom_id=edo.dom_id(+) and
edo.dom_it_id_lov=ee2.exp_id(+) and
ee2.it_obj_id=eo2.obj_id(+) and
decode(x.ex_to_type,'JOI',x.ex_to_devkey)=ekc.key_developer_key(+) and
decode(x.ex_to_type,'FUN',x.ex_to_devkey)=ef.fun_developer_key(+)
order by
x.workbook
&order_by_folder