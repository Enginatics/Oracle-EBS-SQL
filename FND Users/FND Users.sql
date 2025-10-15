/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Users
-- Description: Listing of all EBS users, their status, responsibility count, and if they were using blitz reports
-- Excel Examle Output: https://www.enginatics.com/example/fnd-users/
-- Library Link: https://www.enginatics.com/reports/fnd-users/
-- Run Report: https://demo.enginatics.com/

select
fu.user_name,
fu.description,
papf.first_name,
papf.last_name,
fu.email_address,
papf.email_address hr_email_address, 
fu.start_date user_start_date,
fu.end_date user_end_date,
fu.last_logon_date,
xxen_util.client_time(fu.password_date) password_date,
(select count(*) from fnd_user_resp_groups furg where fu.user_id=furg.user_id) active_responsibilities,
(select 'Y' from fnd_user_resp_groups furg, fnd_responsibility fr where fu.user_id=furg.user_id and furg.responsibility_application_id=fr.application_id and furg.responsibility_id=fr.responsibility_id and fr.responsibility_key='SYSTEM_ADMINISTRATOR') has_sysadmin,
xrr.total blitz_report_runs,
xrr.runs_12m,
xrr.runs_6m,
xrr.runs_3m,
xrr.runs_1m,
xxen_util.user_name(fu.created_by) created_by,
xxen_util.client_time(fu.creation_date) creation_date,
xxen_util.user_name(fu.last_updated_by) last_updated_by,
xxen_util.client_time(fu.last_update_date) last_update_date,
fu.user_id
from
fnd_user fu,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf,
(
select distinct
xrr.created_by,
xxen_util.zero_to_null(count(*) over (partition by xrr.created_by)) total,
xxen_util.zero_to_null(count(case when xrr.creation_date>sysdate-365 then 1 end) over (partition by xrr.created_by)) runs_12m,
xxen_util.zero_to_null(count(case when xrr.creation_date>sysdate-182 then 1 end) over (partition by xrr.created_by)) runs_6m,
xxen_util.zero_to_null(count(case when xrr.creation_date>sysdate-91 then 1 end) over (partition by xrr.created_by)) runs_3m,
xxen_util.zero_to_null(count(case when xrr.creation_date>sysdate-30 then 1 end) over (partition by xrr.created_by)) runs_1m
from
xxen_report_runs xrr
) xrr
where
1=1 and
fu.employee_id=papf.person_id(+) and
fu.user_id=xrr.created_by(+)
order by
case when nvl(fu.end_date,sysdate)>=trunc(sysdate) then 1 else 2 end,
fu.creation_date desc,
fu.user_name