/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND OAF Personalizations
-- Description: Oracle Application Framework (OAF) page personalizations stored in the MDS repository (JDR tables), with the personalization level and the page or region they apply to.
-- Level Name shows the responsibility, user, operating unit or function, or the stored level value where it is not an id, for example for localization or portlet.
-- A personalization document can be exported with the JDRUTILS.printDocument procedure or the XMLExporter utility for migration to another instance.
-- Excel Example Output: https://www.enginatics.com/example/fnd-oaf-personalizations/
-- Library Link: https://www.enginatics.com/reports/fnd-oaf-personalizations/
-- Run Report: https://demo.enginatics.com/

select
initcap(y.level_) level_,
nvl(
case y.level_
when 'responsibility' then (select min(frv.responsibility_name) from fnd_responsibility_vl frv where y.level_value=to_char(frv.responsibility_id))
when 'user' then (select xxen_util.user_name(fu.user_name) from fnd_user fu where y.level_value=to_char(fu.user_id))
when 'org' then (select haouv.name from hr_all_organization_units_vl haouv where y.level_value=to_char(haouv.organization_id))
when 'function' then (select fffv.user_function_name from fnd_form_functions_vl fffv where y.level_value=fffv.function_name)
end,
y.level_value
) level_name,
y.base_document,
y.document,
nvl(case when regexp_like(y.created_by,'^[0-9]+$') then xxen_util.user_name(to_number(y.created_by)) end,y.created_by) created_by,
xxen_util.client_time(y.creation_date) creation_date,
nvl(case when regexp_like(y.last_updated_by,'^[0-9]+$') then xxen_util.user_name(to_number(y.last_updated_by)) end,y.last_updated_by) last_updated_by,
xxen_util.client_time(y.last_update_date) last_update_date
from
(
select
regexp_substr(x.document,'/customizations/([^/]+)/',1,1,null,1) level_,
regexp_substr(x.document,'/customizations/[^/]+/([^/]+)/',1,1,null,1) level_value,
x.*
from
(
select
(select jdr_mds_internal.getdocumentname(jp.root_owner_docid) from dual)||jp.document document,
(select trim(ja.att_value) from jdr_attributes ja where jp.path_docid=ja.att_comp_docid and ja.att_comp_seq=0 and ja.att_name='customizes') base_document,
jp.created_by,
jp.creation_date,
jp.last_updated_by,
jp.last_update_date
from
(
select
jp.*,
connect_by_root jp.path_owner_docid root_owner_docid,
sys_connect_by_path(jp.path_name,'/') document
from
jdr_paths jp
start with
jp.path_name='customizations'
connect by
prior jp.path_docid=jp.path_owner_docid
) jp
where
jp.path_type='DOCUMENT' and
jp.path_docid in (select jc.comp_docid from jdr_components jc where jc.comp_element='customization' and jc.comp_seq=0)
) x
) y
where
1=1
order by
y.base_document,
y.level_,
level_name
