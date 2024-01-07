/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Role Hierarchy
-- Description: User Management (UMX) role hierarchy to manage role-based access control (RBAC).
When run for a specified role, the report shows all hierarchies that contain or lead to inheriting that role.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-role-hierarchy/
-- Library Link: https://www.enginatics.com/reports/fnd-role-hierarchy/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.meaning(connect_by_root x.category_lookup_code,'UMX_CATEGORY_LOOKUP',0) category,
lpad(' ',2*(level-1))||level level_,
lpad(' ',2*(level-1))||wr.display_name role_name,
lpad(' ',2*(level-1))||x.role role_code,
fav.application_name application,
xxen_util.meaning(connect_by_root x.category_lookup_code,'UMX_CATEGORY_LOOKUP',0)||sys_connect_by_path(x.role,' > ') role_path
from
(
select urcv.category_lookup_code, null parent_role, urcv.wf_role_name role from umx_role_categories_v urcv union all
select null category_lookup_code, wrh.sub_name parent_role, wrh.super_name role from wf_role_hierarchies wrh where wrh.enabled_flag='Y'
) x,
wf_roles wr,
fnd_application_vl fav
where
x.role=wr.name and
wr.owner_tag=fav.application_short_name(+)
connect by
prior x.role=x.parent_role
start with
1=1 and
x.parent_role is null
order by
role_path