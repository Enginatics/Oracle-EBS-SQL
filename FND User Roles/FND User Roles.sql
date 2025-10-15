/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND User Roles
-- Description: Report for User Management (UMX) roles and their assigned users to manage role-based access control (RBAC).
User uoles are maintained from the User Management responsibility, but you would require the UMX|SECURITY_ADMIN role for this. If you do not have this role but apps DB access, you can add it from the backend:

begin
  wf_local_synch.propagateuserrole(
  p_user_name=>'ANDY.HAACK',
  p_role_name=>'UMX|SECURITY_ADMIN'
  );
  commit;
end;
-- Excel Examle Output: https://www.enginatics.com/example/fnd-user-roles/
-- Library Link: https://www.enginatics.com/reports/fnd-user-roles/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
xxen_util.user_name(wlur.user_name) user_name,
decode(wlur.role_orig_system,'FND_RESP',frv.responsibility_name,nvl(wlrt.display_name,wlr.display_name)) role_name,
wlr.name role_code,
decode(wlur.role_orig_system,'FND_RESP',fnd_message.get_string('FND','W3H_RESPONSIBILITY_ROLETYPE'),fnd_message.get_string('FND','W3H_ROLE_ROLETYPE')) role_type,
decode(wlur.assignment_type,'D',fnd_message.get_string('FND','W3H_DIRECT_ASSIGNMENTTYPE'),'I',fnd_message.get_string('FND', 'W3H_INDIRECT_ASSIGNMENTTYPE'),'B',fnd_message.get_string('FND','W3H_BOTH_ASSIGNMENTTYPE')) assignment_type,
decode(umx_w3h_utl.isfunctionaccessible(wlur.user_name,wlur.role_name),'true',fnd_message.get_string('FND','W3H_SHOW_ACTIVE_FUNCTIONS'),fnd_message.get_string('FND','W3H_SHOW_INACTIVE_FUNCTIONS')) assignment_status,
(
select
decode(wlr.orig_system,'FND_RESP',frv.responsibility_name,nvl(wlrt.display_name,wlr.display_name)) assigning_role_name
from
wf_local_roles wlr0,
wf_local_roles_tl wlrt0,
fnd_responsibility_vl frv0
where
nullif(wura.assigning_role,wlr.name)=wlr0.name and
wlr0.orig_system in ('UMX','FND_RESP') and
wlr0.name=wlrt0.name(+) and
wlr0.orig_system=wlrt0.orig_system(+) and
wlr0.orig_system_id=wlrt0.orig_system_id(+) and
wlrt0.language(+)=userenv('lang') and
wlr0.partition_id=wlrt0.partition_id(+) and
wlr0.orig_system_id=frv0.responsibility_id(+)
) assigning_role_name,
nullif(wura.assigning_role,wlr.name) assigning_role_code,
wura.effective_start_date,
wura.effective_end_date,
wura.role_start_date,
wura.role_end_date,
xxen_util.user_name(wura.created_by) assigned_by,
wura.assignment_reason
from
wf_local_user_roles wlur,
wf_user_role_assignments wura,
fnd_responsibility_vl frv,
wf_local_roles wlr,
wf_local_roles_tl wlrt
where
1=1 and
wlur.role_orig_system in ('UMX','FND_RESP') and
wlur.role_orig_system_id=frv.responsibility_id(+) and
wlur.role_name=wlr.name and
wlr.orig_system in ('UMX','FND_RESP') and
wlur.user_name=wura.user_name and
wlur.role_name=wura.role_name and
wlr.name=wlrt.name(+) and
wlr.orig_system=wlrt.orig_system(+) and
wlr.orig_system_id=wlrt.orig_system_id(+) and
wlrt.language(+)=userenv('lang') and
wlr.partition_id=wlrt.partition_id(+)
) x
where
2=2
order by
x.user_name,
x.role_name