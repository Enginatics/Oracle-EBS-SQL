/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
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

select
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
x.organization
from
(
select
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
) organization
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
gv$session gs
where
x.resp_appl_id=frv.application_id(+) and
x.responsibility_id=frv.responsibility_id(+) and
x.audsid=gs.audsid(+)
order by
x.login_id desc,
x.start_time desc