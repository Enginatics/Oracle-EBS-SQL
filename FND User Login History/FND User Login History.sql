/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND User Login History
-- Description: Audit history of application user logins.

EBS user logon audit is controlled by profile 'Sign-On:Audit Level'.
The most detailed audit level setting is 'FORM'.
Unfortunately, this audit tracks access to individual forms only, but not to different JSPs (HTML / OAF / ADF Pages).
As a workaround, the report SQL also joins to icx_sessions, which contains a record for each login (in fact, it also stores a record for each access to the login page before login. These records are marked with guest='Y').
The function retrieved from icx_session however, just shows the latest OAF function accessed by the user, not all individual JSP functions accessed within that session.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-user-login-history/
-- Library Link: https://www.enginatics.com/reports/fnd-user-login-history/
-- Run Report: https://demo.enginatics.com/

with prof as
(
select /*+ materialize*/ distinct
x.security_profile_id,
x.security_profile,
listagg(haouv.name,chr(10)) within group (order by haouv.name) over (partition by x.security_profile_id) operating_unit
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
(select -1 view_all, hou.* from hr_operating_units hou where hou.usable_flag is null) hou0,
(select hou.* from hr_operating_units hou where hou.usable_flag is null) hou,
(select pol.* from per_organization_list pol, hr_operating_units hou where pol.organization_id=hou.organization_id and hou.usable_flag is null) pol
where
decode(psp.view_all_flag,'N',psp.security_profile_id)=pol.security_profile_id(+) and
decode(psp.view_all_flag,'Y',psp.business_group_id)=hou.business_group_id(+) and
decode(psp.view_all_flag,'Y',nvl2(psp.business_group_id,null,-1))=hou0.view_all(+)
) x,
hr_all_organization_units_vl haouv
where
x.organization_id=haouv.organization_id(+)
)
--
select
&clientip2
x.first_connect,
xxen_util.client_time(x.start_time) start_time,
xxen_util.client_time(x.end_time) end_time,
x.user_name,
frv.responsibility_name responsibility,
x.form,
x.icx_function,
x.login_id,
x.audsid,
gs.inst_id,
gs.sid,
gs.serial#,
x.server_address,
x.webhost,
x.organization,
prof.security_profile,
case when prof.security_profile_id is not null then prof.operating_unit else (select haouv.name from hr_all_organization_units_vl haouv where x.org_id=haouv.organization_id) end operating_units,
x.user_id
from
(
select
&clientip1
ixs.first_connect,
nvl(flrf.start_time,nvl(flr.start_time,fl.start_time)) start_time,
nvl(flrf.end_time,nvl(flr.end_time,fl.end_time)) end_time,
xxen_util.user_name(fl.user_id) user_name,
ffv.user_form_name form,
fffv.user_function_name icx_function,
fl.login_id,
nvl(flr.resp_appl_id,ixs.responsibility_application_id) resp_appl_id,
nvl(flr.responsibility_id,ixs.responsibility_id) responsibility_id,
coalesce(flrf.audsid,flr.audsid,fas.audsid) audsid,
fn.server_address,
fn.webhost,
(
select distinct
listagg(haouv.name,', ') within group (order by haouv.name) over (partition by paaf.person_id) organization
from
per_all_assignments_f paaf,
hr_all_organization_units_vl haouv
where
fu.employee_id=paaf.person_id and
sysdate between nvl(paaf.effective_start_date,sysdate) and nvl(paaf.effective_end_date,sysdate) and
paaf.organization_id=haouv.organization_id
) organization,
fl.user_id,
coalesce(
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=602 and fpov.profile_option_id=3796 and fpov.level_id=10004 and fl.user_id=fpov.level_value),
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=602 and fpov.profile_option_id=3796 and fpov.level_id=10003 and nvl(flr.responsibility_id,ixs.responsibility_id)=fpov.level_value and nvl(flr.resp_appl_id,ixs.responsibility_application_id)=fpov.level_value_application_id),
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=602 and fpov.profile_option_id=3796 and fpov.level_id=10001 and fpov.level_value=0)
) security_profile_id,
coalesce(
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=0 and fpov.profile_option_id=1991 and fpov.level_id=10004 and fl.user_id=fpov.level_value),
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=0 and fpov.profile_option_id=1991 and fpov.level_id=10003 and nvl(flr.responsibility_id,ixs.responsibility_id)=fpov.level_value and nvl(flr.resp_appl_id,ixs.responsibility_application_id)=fpov.level_value_application_id),
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.application_id=0 and fpov.profile_option_id=1991 and fpov.level_id=10001 and fpov.level_value=0)
) org_id
from
fnd_logins fl,
fnd_login_responsibilities flr,
fnd_login_resp_forms flrf,
fnd_form_vl ffv,
fnd_appl_sessions fas,
icx_sessions ixs,
fnd_nodes fn,
fnd_form_functions_vl fffv,
fnd_user fu
where
1=1 and
fl.login_type='FORM' and
fl.login_id=flr.login_id(+) and
flr.login_id=flrf.login_id(+) and
flr.login_resp_id=flrf.login_resp_id(+) and
flrf.form_appl_id=ffv.application_id(+) and
flrf.form_id=ffv.form_id(+) and
fl.login_id=fas.login_id(+) and
fl.login_id=ixs.login_id(+) and
ixs.node_id=fn.node_id(+) and
ixs.function_id=fffv.function_id(+) and
fl.user_id=fu.user_id
) x,
fnd_responsibility_vl frv,
prof,
gv$session gs
where
2=2 and
x.resp_appl_id=frv.application_id(+) and
x.responsibility_id=frv.responsibility_id(+) and
x.security_profile_id=prof.security_profile_id(+) and
x.audsid=gs.audsid(+)
order by
x.login_id desc,
x.start_time desc