/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Assignments and Responsibilities
-- Description: Lists all responsibilities, users, and the bitz reports that they can access, presumed they have their Blitz Report Access profile option set to 'User'
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-assignments-and-responsibilities/
-- Library Link: https://www.enginatics.com/reports/blitz-report-assignments-and-responsibilities/
-- Run Report: https://demo.enginatics.com/

with xroac as (
select distinct
x.user_id,
x.responsibility_id,
x.application_id,
x.request_group_id,
x.group_application_id
from
(
select
coalesce(
(select fpov.profile_option_value from fnd_profile_option_values fpov where furg.user_id=fpov.level_value and fpov.level_id=10004 and (fpov.application_id,fpov.profile_option_id) in (select fpo.application_id, fpo.profile_option_id from fnd_profile_options fpo where fpo.profile_option_name='XXEN_REPORT_ACCESS')),
(select fpov.profile_option_value from fnd_profile_option_values fpov where furg.responsibility_id=fpov.level_value and furg.responsibility_application_id=fpov.level_value_application_id and fpov.level_id=10003 and (fpov.application_id,fpov.profile_option_id) in (select fpo.application_id, fpo.profile_option_id from fnd_profile_options fpo where fpo.profile_option_name='XXEN_REPORT_ACCESS')),
(select fpov.profile_option_value from fnd_profile_option_values fpov where fpov.level_value=0 and fpov.level_id=10001 and (fpov.application_id,fpov.profile_option_id) in (select fpo.application_id, fpo.profile_option_id from fnd_profile_options fpo where fpo.profile_option_name='XXEN_REPORT_ACCESS'))
) blitz_report_access,
decode(:show_users,'Y',furg.user_id,-1) user_id,
furg.responsibility_id,
furg.responsibility_application_id application_id,
fr.request_group_id,
fr.group_application_id
from
fnd_user_resp_groups furg,
fnd_user fu,
fnd_responsibility fr
where
furg.user_id=fu.user_id and
trunc(sysdate) between fu.start_date and nvl(fu.end_date,sysdate) and
furg.responsibility_id=fr.responsibility_id and
furg.responsibility_application_id=fr.application_id and
trunc(sysdate) between fr.start_date and nvl(fr.end_date,sysdate) and
fr.menu_id in (select fcmf.menu_id from fnd_form_functions fff, fnd_compiled_menu_functions fcmf where fff.function_name like 'XXEN_REPORTS%' and fff.function_id=fcmf.function_id and fcmf.grant_flag='Y')
) x
where
x.blitz_report_access is not null
)
--------- SQL starts here ---------
select
&user_name
frv.responsibility_name responsibility,
fav.application_name,
xrv.report_name,
xrv.type_dsp type,
xrv.category
from
(
select distinct
x.report_id,
x.user_id,
x.responsibility_id,
x.application_id
from
(
select xroac.*, xra.report_id from xroac, xxen_report_assignments xra where xra.disabled is null and xra.include_exclude='I' and xra.assignment_level='Site' and xra.id1=0 and (not exists (select null from xxen_report_assignment_users xrau where xrau.assignment_id=xra.assignment_id) or exists (select null from xxen_report_assignment_users xrau, fnd_user_resp_groups furg2 where xrau.assignment_id=xra.assignment_id and furg2.user_id=xrau.user_id and furg2.responsibility_id=xroac.responsibility_id and furg2.responsibility_application_id=xroac.application_id and (:show_users is null or xrau.user_id=xroac.user_id))) union
select xroac.*, xra.report_id from xroac, xxen_report_assignments xra where xra.disabled is null and xra.include_exclude='I' and xra.assignment_level='Application' and xroac.application_id=xra.id1 and (not exists (select null from xxen_report_assignment_users xrau where xrau.assignment_id=xra.assignment_id) or exists (select null from xxen_report_assignment_users xrau, fnd_user_resp_groups furg2 where xrau.assignment_id=xra.assignment_id and furg2.user_id=xrau.user_id and furg2.responsibility_id=xroac.responsibility_id and furg2.responsibility_application_id=xroac.application_id and (:show_users is null or xrau.user_id=xroac.user_id))) union
select xroac.*, xra.report_id from xroac, xxen_report_assignments xra where xra.disabled is null and xra.include_exclude='I' and xra.assignment_level='Request Group' and xroac.request_group_id=xra.id1 and xroac.group_application_id=xra.id2 and (not exists (select null from xxen_report_assignment_users xrau where xrau.assignment_id=xra.assignment_id) or exists (select null from xxen_report_assignment_users xrau, fnd_user_resp_groups furg2 where xrau.assignment_id=xra.assignment_id and furg2.user_id=xrau.user_id and furg2.responsibility_id=xroac.responsibility_id and furg2.responsibility_application_id=xroac.application_id and (:show_users is null or xrau.user_id=xroac.user_id))) union
select xroac.*, xra.report_id from xroac, xxen_report_assignments xra where xra.disabled is null and xra.include_exclude='I' and xra.assignment_level='Responsibility' and xroac.responsibility_id=xra.id1 and xroac.application_id=xra.id2 and (not exists (select null from xxen_report_assignment_users xrau where xrau.assignment_id=xra.assignment_id) or exists (select null from xxen_report_assignment_users xrau, fnd_user_resp_groups furg2 where xrau.assignment_id=xra.assignment_id and furg2.user_id=xrau.user_id and furg2.responsibility_id=xroac.responsibility_id and furg2.responsibility_application_id=xroac.application_id and (:show_users is null or xrau.user_id=xroac.user_id))) union
select xroac.*, xra.report_id from xroac, xxen_report_assignments xra where xra.disabled is null and xra.include_exclude='I' and xra.assignment_level='User' and xroac.user_id=xra.id1 and :show_users='Y'
minus
(
select xroac.*, xra.report_id from xroac, xxen_report_assignments xra where xra.disabled is null and xra.include_exclude='E' and xra.assignment_level='Site' and xra.id1=0 union
select xroac.*, xra.report_id from xroac, xxen_report_assignments xra where xra.disabled is null and xra.include_exclude='E' and xra.assignment_level='Application' and xroac.application_id=xra.id1 union
select xroac.*, xra.report_id from xroac, xxen_report_assignments xra where xra.disabled is null and xra.include_exclude='E' and xra.assignment_level='Request Group' and xroac.request_group_id=xra.id1 and xroac.group_application_id=xra.id2 union
select xroac.*, xra.report_id from xroac, xxen_report_assignments xra where xra.disabled is null and xra.include_exclude='E' and xra.assignment_level='Responsibility' and xroac.responsibility_id=xra.id1 and xroac.application_id=xra.id2 union
select xroac.*, xra.report_id from xroac, xxen_report_assignments xra where xra.disabled is null and xra.include_exclude='E' and xra.assignment_level='User' and xroac.user_id=xra.id1 and :show_users='Y'
)
) x
) y,
xxen_reports_v xrv,
fnd_responsibility_vl frv,
fnd_application_vl fav
where
1=1 and
y.report_id=xrv.report_id and
xrv.disabled is null and
y.responsibility_id=frv.responsibility_id and
y.application_id=frv.application_id and
y.application_id=fav.application_id
order by 1,2,3,4