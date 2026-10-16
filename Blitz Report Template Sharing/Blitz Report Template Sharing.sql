/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Template Sharing
-- Description: Lists the sharing records for Blitz Report templates - who each template is shared with at Site, Responsibility or User level. The Owner column shows the user who owns each template.
-- For a Responsibility-level share the Shared With column shows the responsibility name and the Application column shows its owning application; for a User-level share it shows the user name; a Site-level share is available to everyone.
-- For Responsibility-level shares the Menu Name column shows the responsibility's menu and Blitz Report Menu Entries counts the Blitz Report menu functions already on that menu (blank when none). A blank Blitz Report Menu Entries with a shared template flags a responsibility whose menu is still missing the Blitz Report function - run the Update Menu Entries program to add it.
-- Set the Assigned to EBS User parameter to a user to answer "which templates can this user actually use, and how". The report then shows one row per access path - a Site share (available to everyone), each Responsibility share on a responsibility the user holds, a direct User share, or ownership - but ONLY for reports the user is allowed to run: it applies the same report-access reach as the run screen (Site, Application, Request Group, Responsibility and User assignments), so a template shared with the user whose report is not assigned to the user is not listed (the user could not run it). The Assigned To User Via column names the level for that row (for example "Responsibility (AP Manager)" or "Owner"); the per-share administrative columns are blank in this mode.
-- Use the Report Name, Category, Template Name, Template Owner and Sharing Level parameters to narrow the list - for example set Category to Discoverer to pull the templates of all Discoverer reports, or Template Owner to list one user's templates. The Template Name list is filtered to the selected Report Name when one is chosen.
-- Excel Example Output: https://www.enginatics.com/example/blitz-report-template-sharing/
-- Library Link: https://www.enginatics.com/reports/blitz-report-template-sharing/
-- Run Report: https://demo.enginatics.com/

with user_resps as (
select distinct
furg.responsibility_id,
furg.application_id,
fr.request_group_id,
fr.group_application_id
from
(
select
wura.role_orig_system_id responsibility_id,
(select fa.application_id from fnd_application fa where xxen_util.instring(wura.role_name,'|',2)=fa.application_short_name) application_id
from
wf_user_role_assignments wura
where
wura.user_name=:assigned_to_ebs_user and
wura.effective_start_date<=xxen_util.trunc_sysdate and (wura.effective_end_date is null or wura.effective_end_date>=xxen_util.trunc_sysdate) and
wura.role_orig_system='FND_RESP' and
wura.partition_id in (2,13)
) furg,
fnd_responsibility fr
where
furg.responsibility_id=fr.responsibility_id and
furg.application_id=fr.application_id and
xxen_util.trunc_sysdate between fr.start_date and nvl(fr.end_date,xxen_util.trunc_sysdate) and
fr.menu_id in (select fcmf.menu_id from fnd_form_functions fff, fnd_compiled_menu_functions fcmf where fff.function_name like 'XXEN_REPORTS%' and fff.function_id=fcmf.function_id and fcmf.grant_flag='Y')
)
select
t.report_name,
t.type,
t.category,
t.template_name,
t.owner,
t.sharing_level,
t.shared_with,
t.assigned_to_user_via,
t.application_name,
t.menu_name,
t.blitz_report_menu_entries,
t.created_by,
t.creation_date,
t.last_updated_by,
t.last_update_date
from
(
select
xrv.report_name,
xrv.type_dsp type,
xrv.category,
xrtsv.template_name,
xxen_util.user_name(xrt.owner_id) owner,
xrv.report_id,
xrt.owner_id owner_id,
case when :assigned_to_ebs_user is null then xrtsv.sharing_level_desc end sharing_level,
xrtsv.sharing_level sharing_level_code,
case when :assigned_to_ebs_user is null then xrtsv.level_value end shared_with,
case when :assigned_to_ebs_user is not null then case xrtsv.sharing_level when 'S' then 'Site' when 'U' then 'User' when 'R' then 'Responsibility ('||xrtsv.level_value||')' end end assigned_to_user_via,
case when :assigned_to_ebs_user is null then fav.application_name end application_name,
case when :assigned_to_ebs_user is null then fm.menu_name end menu_name,
case when :assigned_to_ebs_user is null then xxen_util.zero_to_null((select count(*) from fnd_menu_entries fme where fme.menu_id=fr.menu_id and fme.function_id in (select fff.function_id from fnd_form_functions fff where fff.function_name in ('XXEN_REPORTS','XXEN_REPORTS_WEB')))) end blitz_report_menu_entries,
case when :assigned_to_ebs_user is null then xxen_util.user_name(xrtsv.created_by) end created_by,
case when :assigned_to_ebs_user is null then xxen_util.client_time(xrtsv.creation_date) end creation_date,
case when :assigned_to_ebs_user is null then xxen_util.user_name(xrtsv.last_updated_by) end last_updated_by,
case when :assigned_to_ebs_user is null then xxen_util.client_time(xrtsv.last_update_date) end last_update_date
from
xxen_report_template_sharing_v xrtsv,
xxen_report_templates xrt,
xxen_reports_v xrv,
fnd_application_vl fav,
fnd_responsibility fr,
fnd_menus fm
where
xrtsv.template_id=xrt.template_id and
xrt.report_id=xrv.report_id and
xrtsv.id2=fav.application_id(+) and
decode(xrtsv.sharing_level,'R',xrtsv.id1)=fr.responsibility_id(+) and
decode(xrtsv.sharing_level,'R',xrtsv.id2)=fr.application_id(+) and
fr.menu_id=fm.menu_id(+) and
(:assigned_to_ebs_user is null or
xrtsv.sharing_level='S' or
(xrtsv.sharing_level='U' and xrtsv.id1=(select fu.user_id from fnd_user fu where :assigned_to_ebs_user=fu.user_name)) or
(xrtsv.sharing_level='R' and exists (
select null from fnd_user_resp_groups_direct r where r.user_id=(select fu.user_id from fnd_user fu where :assigned_to_ebs_user=fu.user_name) and r.responsibility_id=xrtsv.id1 and r.responsibility_application_id=xrtsv.id2 and r.start_date<=sysdate and nvl(r.end_date,sysdate)>=sysdate
union all
select null from fnd_user_resp_groups_indirect r where r.user_id=(select fu.user_id from fnd_user fu where :assigned_to_ebs_user=fu.user_name) and r.responsibility_id=xrtsv.id1 and r.responsibility_application_id=xrtsv.id2 and r.start_date<=sysdate and nvl(r.end_date,sysdate)>=sysdate)))
union all
select
xrv.report_name,
xrv.type_dsp type,
xrv.category,
xrt.template_name,
xxen_util.user_name(xrt.owner_id) owner,
xrv.report_id,
xrt.owner_id owner_id,
to_char(null) sharing_level,
to_char(null) sharing_level_code,
to_char(null) shared_with,
'Owner' assigned_to_user_via,
to_char(null) application_name,
to_char(null) menu_name,
to_number(null) blitz_report_menu_entries,
to_char(null) created_by,
cast(null as date) creation_date,
to_char(null) last_updated_by,
cast(null as date) last_update_date
from
xxen_report_templates xrt,
xxen_reports_v xrv
where
:assigned_to_ebs_user is not null and
xrt.report_id=xrv.report_id and
xrt.owner_id=(select fu.user_id from fnd_user fu where :assigned_to_ebs_user=fu.user_name) and
not exists (
select null from xxen_report_template_sharing_v xrtsv2 where xrtsv2.template_id=xrt.template_id and
(xrtsv2.sharing_level='S' or
(xrtsv2.sharing_level='U' and xrtsv2.id1=xrt.owner_id) or
(xrtsv2.sharing_level='R' and exists (
select null from fnd_user_resp_groups_direct r where r.user_id=xrt.owner_id and r.responsibility_id=xrtsv2.id1 and r.responsibility_application_id=xrtsv2.id2 and r.start_date<=sysdate and nvl(r.end_date,sysdate)>=sysdate
union all
select null from fnd_user_resp_groups_indirect r where r.user_id=xrt.owner_id and r.responsibility_id=xrtsv2.id1 and r.responsibility_application_id=xrtsv2.id2 and r.start_date<=sysdate and nvl(r.end_date,sysdate)>=sysdate))))
) t
where
1=1 and
(:assigned_to_ebs_user is null or
exists (
select null
from
xxen_report_assignments xra,
user_resps ur
where
xra.report_id=t.report_id and
xra.disabled is null and
xra.include_exclude='I' and
(xra.assignment_level='Site' and xra.id1=0 or
xra.assignment_level='Application' and xra.id1=ur.application_id or
xra.assignment_level='Request Group' and xra.id1=ur.request_group_id and xra.id2=ur.group_application_id or
xra.assignment_level='Responsibility' and xra.id1=ur.responsibility_id and xra.id2=ur.application_id or
xra.assignment_level='User' and xra.id1=(select fu.user_id from fnd_user fu where :assigned_to_ebs_user=fu.user_name)) and
(xra.assignment_level='User' or
not exists (select null from xxen_report_assignment_users xrau where xrau.assignment_id=xra.assignment_id) or
exists (select null from xxen_report_assignment_users xrau where xrau.assignment_id=xra.assignment_id and xrau.user_id=(select fu.user_id from fnd_user fu where :assigned_to_ebs_user=fu.user_name)))
) and
not exists (
select null
from
xxen_report_assignments xra,
user_resps ur
where
xra.report_id=t.report_id and
xra.disabled is null and
xra.include_exclude='E' and
(xra.assignment_level='Site' and xra.id1=0 or
xra.assignment_level='Application' and xra.id1=ur.application_id or
xra.assignment_level='Request Group' and xra.id1=ur.request_group_id and xra.id2=ur.group_application_id or
xra.assignment_level='Responsibility' and xra.id1=ur.responsibility_id and xra.id2=ur.application_id or
xra.assignment_level='User' and xra.id1=(select fu.user_id from fnd_user fu where :assigned_to_ebs_user=fu.user_name))
))
order by
t.report_name,
t.template_name,
decode(t.sharing_level_code,'S',1,'R',2,'U',3,4),
t.shared_with
