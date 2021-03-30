/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Users
-- Description: Similar to report FND Access Control, but also shows inactive / end dated user responsibilities while FND Access Control shows currently active assigned responsibilities only.
Same as Oracle's 'Active Users' report.
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
(select count(*) from fnd_user_resp_groups furg where fu.user_id=furg.user_id) active_responsibilities,
xxen_util.user_name(fu.created_by) user_created_by,
xxen_util.client_time(fu.creation_date) user_creation_date,
xxen_util.user_name(fu.last_updated_by) user_last_updated_by,
xxen_util.client_time(fu.last_update_date) user_last_update_date,
fu.user_id
from
fnd_user fu,
(select papf.* from per_all_people_f papf where sysdate between papf.effective_start_date and papf.effective_end_date) papf
where
1=1 and
fu.employee_id=papf.person_id(+)
order by
case when nvl(fu.end_date,sysdate)>=trunc(sysdate) then 1 else 2 end,
fu.user_name