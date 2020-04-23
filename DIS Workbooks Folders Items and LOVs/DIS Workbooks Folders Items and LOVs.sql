/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DIS Workbooks, Folders, Items and LOVs
-- Description: Discoverer workbooks, their owners, folders, items and item class LOVs, derived from dependency table eul5_elem_xrefs.
-- Excel Examle Output: https://www.enginatics.com/example/dis-workbooks-folders-items-and-lovs
-- Library Link: https://www.enginatics.com/reports/dis-workbooks-folders-items-and-lovs
-- Run Report: https://demo.enginatics.com/


select distinct
x.workbook,
x.description,
x.owner,
x.identifier workbook_identifier,
x.access_count,
x.last_accessed,
x.last_updated_by,
x.last_update_date
&folder_columns
&item_columns
from
(
select
ed.doc_name workbook,
ed.doc_description description,
xxen_util.dis_user_name(ed.doc_eu_id,'&eul') owner,
ed.doc_developer_key identifier,
eqs.access_count,
eqs.last_accessed,
xxen_util.dis_user_name(ed.doc_updated_by) last_updated_by,
ed.doc_updated_date last_update_date,
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
eo.obj_id,
eex.ex_to_devkey,
eex.ex_to_type
from
&eul.eul5_documents ed,
(select eex.* from &eul.eul5_elem_xrefs eex where :display_level in ('Folders','Items')) eex,
&eul.eul5_objs eo,
(
select
eqs.qs_doc_name,
count(*) access_count,
max(eqs.qs_created_date) last_accessed
from
&eul.eul5_qpp_stats eqs
where
2=2
group by
eqs.qs_doc_name
) eqs
where
1=1 and
ed.doc_id=eex.ex_from_id(+) and
eex.ex_from_type(+)='DOC' and
eex.ex_to_par_devkey=eo.obj_developer_key(+) and
ed.doc_name=eqs.qs_doc_name(+)
) x,
(
select ee.it_obj_id obj_id, ee.* from &eul.eul5_expressions ee where ee.exp_type in ('CI','CO') and ee.fil_obj_id is null and :display_level='Items' union all
select ee.fil_obj_id obj_id, ee.* from &eul.eul5_expressions ee where ee.exp_type='FIL' and ee.it_obj_id is null and :display_level='Items'
) ee,
&eul.eul5_domains edo,
(select ekc.* from &eul.eul5_key_cons ekc where :display_level='Items') ekc,
(select ef.* from &eul.eul5_functions ef where :display_level='Items') ef
where
x.obj_id=ee.obj_id(+) and
case when x.ex_to_type in ('ITE','FIL') then x.ex_to_devkey end=ee.exp_developer_key(+) and
ee.it_dom_id=edo.dom_id(+) and
decode(x.ex_to_type,'JOI',x.ex_to_devkey)=ekc.key_developer_key(+) and
decode(x.ex_to_type,'FUN',x.ex_to_devkey)=ef.fun_developer_key(+)
order by
x.workbook
&order_by_folder