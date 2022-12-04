/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Access Control
-- Description: Responsibilites and related data such as users, concurrent programs, menus, functions, forms, data access set and security profiles and associated ledgers and operating units.
This report basically answers all system access related questions. It shows which users or responsibilities have acess to which functions, forms, concurrent programs, ledgers, operating units or inventory organizations.

Depending on parameter selection, this report shows for example:

- responsibilities and related menus and request groups
- responsibilities, menus, included forms, functions and their full menu navigation path
- users and their assigned active responsibilities
- users, assigned responsibilities and the concurrent programs they have access to
- concurrent programs and the responsibilities that they can be run from
- forms or functions and the responsibilities and users that can access them
- responsibilities and navigation paths to access a certain form or function from a given user
- operating units that a particular responsibility or user has access to through MOAC security profiles or profile option 'MO: Operating Unit'

The parameters 'User', 'Form', 'Function' and 'Concurrent Program' are optional and can either be populated to filter records for a particular value only or entered with % to show all values or left blank to not show data related to that parameter. If the user parameter is left blank for example, then the report does not show any user names and shows information related to responsibility level only.

Example: To show all users having access to the user maintenance form, enter parameters as follows:
User Name: %
User Form Name: Define Application User

Please note that the SQL currently doesn't consider menu exclusions yet, which means that it's not 100% accurate as excluded functions would still show up in the report.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-access-control/
-- Library Link: https://www.enginatics.com/reports/fnd-access-control/
-- Run Report: https://demo.enginatics.com/

with
func as (
select /*+ materialize*/
fffv.function_id
from
fnd_form_functions_vl fffv,
fnd_form_vl ffv
where
2=2 and
'&enable_function'='Y' and
fffv.form_id=ffv.form_id(+) and
fffv.application_id=ffv.application_id(+)
),
nav as
(
select /*+ materialize*/
sys_connect_by_path(fmev.prompt,'-> ') navigation_path_orig_,
sys_connect_by_path(fmev.user_menu_name ,'-> ') menu_path_,
sys_connect_by_path(to_char(fmev.entry_sequence,'000000.0'),'>') entry_sequence_,
fmev.menu_id,
connect_by_root fmev.function_id function_id
from
(select fmt.user_menu_name, fmev.* from fnd_menu_entries_vl fmev, fnd_menus_tl fmt where '&enable_function'='Y' and fmev.sub_menu_id=fmt.menu_id(+) and fmt.language(+)=userenv('lang')) fmev
connect by nocycle
prior fmev.menu_id=fmev.sub_menu_id
start with
'&enable_function'='Y' and
fmev.function_id in (select func.function_id from func)
),
gl as (
select distinct
listagg(gl.name,chr(10)) within group (order by gl.object_type_code desc, gl.name) over (partition by gl.access_set_id) ledger,
listagg(gl.ledger_id,chr(10)) within group (order by gl.object_type_code desc, gl.name) over (partition by gl.access_set_id) ledger_id,
gl.access_set_id
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
),
prof as
(
select /*+ materialize*/ distinct
x.security_profile_id,
x.security_profile,
decode('&expand_operating_units','Y',haouv.name,listagg(haouv.name,chr(10)) within group (order by haouv.name) over (partition by x.security_profile_id)) operating_unit,
decode('&expand_operating_units','Y',to_char(haouv.organization_id),listagg(haouv.organization_id,chr(10)) within group (order by haouv.name) over (partition by x.security_profile_id)) operating_unit_id
from
(
select
psp.security_profile_name security_profile,
psp.security_profile_id,
psp.business_group_id,
psp.view_all_flag,
nvl(pol.organization_id,nvl(hou.organization_id,hou0.organization_id)) organization_id
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
hr_all_organization_units_vl haouv
where
x.organization_id=haouv.organization_id(+)
),
org as (
select distinct
listagg(oav.organization_code,chr(10)) within group (order by oav.organization_code) over (partition by oav.resp_application_id, oav.responsibility_id) organization,
listagg(oav.organization_id,chr(10)) within group (order by oav.organization_code) over (partition by oav.resp_application_id, oav.responsibility_id) organization_id,
oav.resp_application_id,
oav.responsibility_id
from
org_access_view oav
),
usr as
(
select /*+ materialize*/
furg.responsibility_application_id,
furg.responsibility_id,
furg.user_id,
xxen_util.user_name(furg.user_id) user_name,
nvl(fu.email_address,papf.email_address) email,
papf.global_name person,
haouv.name person_bg
from
fnd_user_resp_groups furg,
fnd_user fu,
(
select distinct
papf.person_id,
max(papf.email_address) keep (dense_rank last order by papf.effective_end_date) over (partition by papf.person_id) email_address,
max(papf.global_name) keep (dense_rank last order by papf.effective_end_date) over (partition by papf.person_id) global_name,
max(papf.business_group_id) keep (dense_rank last order by papf.effective_end_date) over (partition by papf.person_id) business_group_id
from
per_all_people_f papf
) papf,
hr_all_organization_units_vl haouv
where
3=3 and
'&enable_user'='Y' and
furg.user_id=fu.user_id and
fu.employee_id=papf.person_id(+) and
papf.business_group_id=haouv.organization_id(+)
)
--------------SQL starts here-------------
select /*+ dynamic_sampling(3) */
z.responsibility_name responsibility,
z.application_name,
&col1
z.request_group_application,
z.request_group_name,
&col_conc
z.user_menu_name,
z.gl_access_set,
z.ledger,
z.security_profile,
z.operating_unit,
z.organization,
z.responsibility_key,
&col2
z.menu_name,
z.sql_session_init,
z.resp_application_id application_id,
z.responsibility_id,
z.ledger_id,
z.operating_unit_id,
z.organization_id
from
(
select
y.*,
case when y.fffv_type<>'SUBFUNCTION' and y.navigation_path_orig not like '%-> ' and y.navigation_path_orig not like '%-> -> %' then substr(y.navigation_path_orig,4) end navigation_path,
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
usr.user_name,
usr.email,
usr.person,
usr.person_bg,
xxen_util.reverse(nav.navigation_path_orig_,'-> ') navigation_path_orig,
fffv.user_function_name,
xxen_util.meaning(fffv.type,'FORM_FUNCTION_TYPE',0) function_type,
ffv.user_form_name,
fffv.web_html_call html_call,
fav3.application_name request_group_application,
frg.request_group_name,
decode(frgu.request_unit_type,'P','Program','A','Application','S','Set') assignment_type,
decode(frgu.request_unit_type,
'P',fcpv.user_concurrent_program_name,
'A',fav2.application_name,
'S',frsv.user_request_set_name
) assignment_name,
fmv.user_menu_name,
frv.responsibility_key,
nvl(fcpv.user_concurrent_program_name,fcpv2.user_concurrent_program_name) concurrent_program,
nvl(fcpv.concurrent_program_name,fcpv2.concurrent_program_name) conc_program_code,
fmv.menu_name||'-> '||substr(xxen_util.reverse(nav.menu_path_,'-> '),4) menu_path,
fffv.function_name,
ffv.form_name,
fffv.parameters,
fmv.menu_name,
coalesce(
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=602 and fpov.profile_option_id=3796 and fpov.level_id=10004 and usr.user_id=fpov.level_value),
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=602 and fpov.profile_option_id=3796 and fpov.level_id=10003 and frv.responsibility_id=fpov.level_value and frv.application_id=fpov.level_value_application_id),
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=602 and fpov.profile_option_id=3796 and fpov.level_id=10001 and fpov.level_value=0)
) security_profile_id,
coalesce(
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=0 and fpov.profile_option_id=1991 and fpov.level_id=10004 and usr.user_id=fpov.level_value),
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=0 and fpov.profile_option_id=1991 and fpov.level_id=10003 and frv.responsibility_id=fpov.level_value and frv.application_id=fpov.level_value_application_id),
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=0 and fpov.profile_option_id=1991 and fpov.level_id=10001 and fpov.level_value=0)
) org_id,
coalesce(
(select to_number(fpov.profile_option_value) from fnd_profile_option_values fpov where fpov.application_id=101 and fpov.profile_option_id=(select fpo.profile_option_id from fnd_profile_options fpo where fpo.profile_option_name='GL_ACCESS_SET_ID') and fpov.level_id=10004 and usr.user_id=fpov.level_value),
(select to_number(fpov.profile_option_value) from fnd_profile_option_values fpov where fpov.application_id=101 and fpov.profile_option_id=(select fpo.profile_option_id from fnd_profile_options fpo where fpo.profile_option_name='GL_ACCESS_SET_ID') and fpov.level_id=10003 and frv.responsibility_id=fpov.level_value and frv.application_id=fpov.level_value_application_id),
(select to_number(fpov.profile_option_value) from fnd_profile_option_values fpov where fpov.application_id=101 and fpov.profile_option_id=(select fpo.profile_option_id from fnd_profile_options fpo where fpo.profile_option_name='GL_ACCESS_SET_ID') and fpov.level_id=10001 and fpov.level_value=0)
) gl_access_set_id,
fffv.type fffv_type,
xxen_util.reverse(nav.entry_sequence_,'>') entry_sequence,
frv.application_id resp_application_id,
frv.responsibility_id,
frgu.request_unit_type,
frgu.unit_application_id,
frgu.request_unit_id,
nvl(fcpv.application_id,fcpv2.application_id) conc_application_id,
nvl(fcpv.concurrent_program_id,fcpv2.concurrent_program_id) concurrent_program_id,
usr.user_id,
fcmf.function_id,
case when usr.user_id is not null then
'begin fnd_global.apps_initialize('||usr.user_id||','||usr.responsibility_id||','||usr.responsibility_application_id||'); mo_global.init('''||decode(fmpi.status,'Y','M','S')||'''); '||
nvl2(frv.default_mo_org,'fnd_profile.put(''MFG_ORGANIZATION_ID'','''||frv.default_mo_org||'''); ',null)||'gl_security_pkg.init; end;'
end sql_session_init
from
fnd_application_vl fav,
(select
(select oav.organization_id from org_access_view oav where frv.application_id=oav.resp_application_id and frv.responsibility_id=oav.responsibility_id and rownum=1) default_mo_org,
frv.*
from
fnd_responsibility_vl frv) frv,
fnd_application_vl fav3,
fnd_request_groups frg,
(select frgu.* from fnd_request_group_units frgu where '&enable_concurrent'='Y') frgu,
(select fcpv.* from fnd_concurrent_programs_vl fcpv where fcpv.srs_flag in ('Y','Q') and fcpv.enabled_flag='Y') fcpv,
(select fcpv2.* from fnd_concurrent_programs_vl fcpv2 where 4=4 and '&enable_concurrent'='Y' and fcpv2.srs_flag in ('Y','Q') and fcpv2.enabled_flag='Y') fcpv2,
fnd_application_vl fav2,
fnd_request_sets_vl frsv,
fnd_menus_vl fmv,
usr,
(select fcmf.* from fnd_compiled_menu_functions fcmf where '&enable_function'='Y' and fcmf.function_id in (select func.function_id from func) and nvl(fcmf.grant_flag,'Y')='Y') fcmf,
nav,
fnd_form_functions_vl fffv,
fnd_form_vl ffv,
fnd_mo_product_init fmpi
where
1=1 and
fav.application_id=frv.application_id and
frv.group_application_id=fav3.application_id(+) and
frv.group_application_id=frg.application_id(+) and
frv.request_group_id=frg.request_group_id(+) and
frg.application_id=frgu.application_id(+) and
frg.request_group_id=frgu.request_group_id(+) and
decode(frgu.request_unit_type,'P',frgu.unit_application_id)=fcpv.application_id(+) and
decode(frgu.request_unit_type,'P',frgu.request_unit_id)=fcpv.concurrent_program_id(+) and
decode(frgu.request_unit_type,'A',frgu.unit_application_id)=fav2.application_id(+) and
decode(frgu.request_unit_type,'A',frgu.unit_application_id)=fcpv2.application_id(+) and
decode(frgu.request_unit_type,'S',frgu.unit_application_id)=frsv.application_id(+) and
decode(frgu.request_unit_type,'S',frgu.request_unit_id)=frsv.request_set_id(+) and
frv.responsibility_id=usr.responsibility_id(+) and
frv.application_id=usr.responsibility_application_id(+) and
frv.menu_id=fmv.menu_id(+) and
frv.menu_id=fcmf.menu_id(+) and
fcmf.menu_id=nav.menu_id(+) and
fcmf.function_id=nav.function_id(+) and
fcmf.function_id=fffv.function_id(+) and
fffv.application_id=ffv.application_id(+) and
fffv.form_id=ffv.form_id(+) and
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
5=5
order by
z.application_name,
z.responsibility_name,
z.user_name,
case when z.navigation_path is not null and z.fffv_type<>'SUBFUNCTION' then 1 else 2 end,
z.entry_sequence,
z.menu_path,
z.user_function_name,
z.operating_unit