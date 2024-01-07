/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Users
-- Description: Listing of all EBS users
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
xxen_util.user_name(fu.created_by) created_by,
xxen_util.client_time(fu.creation_date) creation_date,
xxen_util.user_name(fu.last_updated_by) last_updated_by,
xxen_util.client_time(fu.last_update_date) last_update_date,
fu.user_id
from
fnd_user fu,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf
where
1=1 and
fu.employee_id=papf.person_id(+)
order by
case when nvl(fu.end_date,sysdate)>=trunc(sysdate) then 1 else 2 end,
fu.creation_date desc,
fu.user_name