/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Roles
-- Description: Report of all User Management (UMX) roles, including number of active users for each role to help managing role-based access control (RBAC)
-- Excel Examle Output: https://www.enginatics.com/example/fnd-roles/
-- Library Link: https://www.enginatics.com/reports/fnd-roles/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
decode(wlr.orig_system,'FND_RESP',frv.responsibility_name,nvl(wlrt.display_name,wlr.display_name)) role_name,
wlr.name role_code,
decode(wlr.orig_system,'FND_RESP',fnd_message.get_string('FND','W3H_RESPONSIBILITY_ROLETYPE'),fnd_message.get_string('FND','W3H_ROLE_ROLETYPE')) role_type,
wlr.expiration_date,
(select count(*) from wf_user_role_assignments wura where wlr.name=wura.role_name and sysdate between wura.effective_start_date and nvl(wura.effective_end_date,sysdate)) assigned_users
from
wf_local_roles wlr,
wf_local_roles_tl wlrt,
fnd_responsibility_vl frv
where
1=1 and
wlr.orig_system in ('UMX','FND_RESP') and
wlr.name=wlrt.name(+) and
wlr.orig_system=wlrt.orig_system(+) and
wlr.orig_system_id=wlrt.orig_system_id(+) and
wlrt.language(+)=userenv('lang') and
wlr.partition_id=wlrt.partition_id(+) and
wlr.orig_system_id=frv.responsibility_id(+)
) x
where
2=2
order by
x.role_name