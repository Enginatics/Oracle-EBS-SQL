/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Responsibilities
-- Description: Active responsibilites with active user count and  related setup information such as menus, data access sets, security profiles and associated ledgers and operating units.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-responsibilities/
-- Library Link: https://www.enginatics.com/reports/fnd-responsibilities/
-- Run Report: https://demo.enginatics.com/

with
gl as (
select distinct
listagg(gl.name,chr(10)) within group (order by gl.object_type_code desc, gl.name) over (partition by gl.access_set_id) ledger,
listagg(gl.ledger_id,chr(10)) within group (order by gl.object_type_code desc, gl.name) over (partition by gl.access_set_id) ledger_id,
gl.access_set_id
from
(
select
sum(lengthb(gl.name)+1) over (partition by gl.access_set_id order by gl.object_type_code desc, gl.name rows between unbounded preceding and current row) total_length,
gl.*
from
(
select
gl.name||decode(gl.object_type_code,'S',' ('||xxen_util.meaning(gl.object_type_code,'LEDGERS',101)||')') name,
gl.ledger_id,
gl.object_type_code,
gasna.access_set_id
from
(
select gasna.access_set_id, gasna.ledger_id, gasna.status_code from gl_access_set_norm_assign gasna union
select gasna.access_set_id, glsnav.ledger_id, gasna.status_code from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.ledger_id=glsnav.ledger_set_id
) gasna,
gl_ledgers gl
where
nvl(gasna.status_code,'x') not in ('D','I') and
gasna.ledger_id=gl.ledger_id
) gl
) gl
where
gl.total_length<=4000
),
prof as
(
select /*+ materialize*/ distinct
y.security_profile_id,
y.security_profile,
decode('&expand_operating_units','Y',y.operating_unit,listagg(y.operating_unit,chr(10)) within group (order by y.operating_unit) over (partition by y.security_profile_id)) operating_unit,
decode('&expand_operating_units','Y',to_char(y.organization_id),listagg(y.organization_id,chr(10)) within group (order by y.operating_unit) over (partition by y.security_profile_id)) operating_unit_id
from
(
select
decode('&expand_operating_units','Y',0,sum(lengthb(haouv.name)+1) over (partition by x.security_profile_id order by haouv.name rows between unbounded preceding and current row)) total_length,
haouv.name operating_unit,
x.*
from
(
select
psp.security_profile_name security_profile,
psp.security_profile_id,
psp.business_group_id,
psp.view_all_flag,
coalesce(pol.organization_id,hou.organization_id,hou0.organization_id) organization_id
from
per_security_profiles psp,
(select pol.* from per_organization_list pol, hr_operating_units hou where pol.organization_id=hou.organization_id and hou.usable_flag is null) pol,
(select hou.* from hr_operating_units hou where hou.usable_flag is null) hou,
(select -1 view_all, hou.* from hr_operating_units hou where hou.usable_flag is null) hou0
where
decode(psp.view_all_flag,'N',psp.security_profile_id)=pol.security_profile_id(+) and
decode(psp.view_all_flag,'Y',psp.business_group_id)=hou.business_group_id(+) and
decode(psp.view_all_flag,'Y',nvl2(psp.business_group_id,null,-1))=hou0.view_all(+)
) x,
(select haouv.* from hr_all_organization_units_vl haouv where sysdate between haouv.date_from and nvl(haouv.date_to,sysdate)) haouv
where
x.organization_id=haouv.organization_id(+)
) y
where
y.total_length<=4000
),
org as (
select distinct
listagg(oav.organization_code,chr(10)) within group (order by oav.organization_code) over (partition by oav.resp_application_id, oav.responsibility_id) organization,
listagg(oav.organization_id,chr(10)) within group (order by oav.organization_code) over (partition by oav.resp_application_id, oav.responsibility_id) organization_id,
oav.resp_application_id,
oav.responsibility_id
from
(
select
sum(lengthb(oav.organization_code)+1) over (partition by oav.resp_application_id, oav.responsibility_id order by oav.organization_code rows between unbounded preceding and current row) total_length,
oav.*
from
org_access_view oav
) oav
where
oav.total_length<=4000
)
--------------SQL starts here-------------
select /*+ dynamic_sampling(3) */
z.responsibility_name responsibility,
z.application_name,
z.active_user_count,
z.request_group_application,
z.request_group_name,
z.user_menu_name,
z.gl_access_set,
z.ledger,
z.security_profile,
z.operating_unit,
z.organization,
z.responsibility_key,
z.menu_name,
z.responsibility_created_by,
z.responsibility_creation_date,
z.responsibility_last_updated_by,
z.responsibility_last_update_date,
z.resp_application_id application_id,
z.responsibility_id,
z.ledger_id,
z.operating_unit_id,
z.organization_id
from
(
select
y.*,
(select gasv.name from gl_access_sets_v gasv where y.gl_access_set_id=gasv.access_set_id) gl_access_set,
gl.ledger,
gl.ledger_id,
prof.security_profile,
case when prof.security_profile_id is not null then prof.operating_unit else (select haouv.name from hr_all_organization_units_vl haouv where y.org_id=haouv.organization_id) end operating_unit,
case when prof.security_profile_id is not null then prof.operating_unit_id else y.org_id end operating_unit_id,
org.organization,
org.organization_id
from
(
select
frv.responsibility_name,
fav.application_name,
furg.active_user_count,
fav3.application_name request_group_application,
frg.request_group_name,
fmv.user_menu_name,
frv.responsibility_key,
fmv.menu_name,
coalesce(
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=602 and fpov.profile_option_id=3796 and fpov.level_id=10003 and frv.responsibility_id=fpov.level_value and frv.application_id=fpov.level_value_application_id),
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=602 and fpov.profile_option_id=3796 and fpov.level_id=10001 and fpov.level_value=0)
) security_profile_id,
coalesce(
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=0 and fpov.profile_option_id=1991 and fpov.level_id=10003 and frv.responsibility_id=fpov.level_value and frv.application_id=fpov.level_value_application_id),
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=0 and fpov.profile_option_id=1991 and fpov.level_id=10001 and fpov.level_value=0)
) org_id,
coalesce(
(select to_number(fpov.profile_option_value) from fnd_profile_option_values fpov where fpov.application_id=101 and fpov.profile_option_id=(select fpo.profile_option_id from fnd_profile_options fpo where fpo.profile_option_name='GL_ACCESS_SET_ID') and fpov.level_id=10003 and frv.responsibility_id=fpov.level_value and frv.application_id=fpov.level_value_application_id),
(select to_number(fpov.profile_option_value) from fnd_profile_option_values fpov where fpov.application_id=101 and fpov.profile_option_id=(select fpo.profile_option_id from fnd_profile_options fpo where fpo.profile_option_name='GL_ACCESS_SET_ID') and fpov.level_id=10001 and fpov.level_value=0)
) gl_access_set_id,
xxen_util.user_name(frv.created_by) responsibility_created_by,
xxen_util.client_time(frv.creation_date) responsibility_creation_date,
xxen_util.user_name(frv.last_updated_by) responsibility_last_updated_by,
xxen_util.client_time(frv.last_update_date) responsibility_last_update_date,
frv.application_id resp_application_id,
frv.responsibility_id
from
fnd_application_vl fav,
fnd_responsibility_vl frv,
fnd_application_vl fav3,
fnd_request_groups frg,
fnd_menus_vl fmv,
(
select distinct
furg.responsibility_application_id,
furg.responsibility_id,
count(furg.user_id) over (partition by furg.responsibility_application_id, furg.responsibility_id) active_user_count
from
fnd_user_resp_groups furg
where
furg.user_id in (select fu.user_id from fnd_user fu where trunc(sysdate) between fu.start_date and nvl(fu.end_date,sysdate))
) furg,
fnd_mo_product_init fmpi
where
1=1 and
fav.application_id=frv.application_id and
frv.group_application_id=fav3.application_id(+) and
frv.group_application_id=frg.application_id(+) and
frv.request_group_id=frg.request_group_id(+) and
frv.responsibility_id=furg.responsibility_id(+) and
frv.application_id=furg.responsibility_application_id(+) and
frv.menu_id=fmv.menu_id(+) and
fav.application_short_name=fmpi.application_short_name(+)
) y,
prof,
org,
gl
where
y.gl_access_set_id=gl.access_set_id(+) and
y.security_profile_id=prof.security_profile_id(+) and
y.responsibility_id=org.responsibility_id(+) and
y.resp_application_id=org.resp_application_id(+)
) z
where
2=2
order by
z.application_name,
z.responsibility_name