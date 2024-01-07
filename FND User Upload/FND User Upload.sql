/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND User Upload
-- Description: Listing and updating all EBS users and their responsiblities
-- Excel Examle Output: https://www.enginatics.com/example/fnd-user-upload/
-- Library Link: https://www.enginatics.com/reports/fnd-user-upload/
-- Run Report: https://demo.enginatics.com/

select y.* from
(
select
null action_,
null status_,
null message_,
fu.user_name,
null unencrypted_password,
fu.description,
papf.business_group,
papf.employee_number,
papf.first_name,
papf.last_name,
papf.sex gender,
papf.date_of_birth date_of_birth,
--papf.email_address employee_email_address,
fu.email_address,
fu.fax,
fu.start_date user_start_date,
fu.end_date user_end_date,
fu.last_logon_date last_logon_date,
xxen_util.user_name(fu.created_by) created_by,
xxen_util.client_time(fu.creation_date) user_creation_date,
xxen_util.user_name(fu.last_updated_by) user_last_updated_by,
xxen_util.client_time(fu.last_update_date) user_last_update_date,
frt.application_name responsiblity_application,
frt.responsibility_name,
frt.security_group_name,
frt.start_date responsiblity_start,
frt.end_date responsiblity_end,
frt.description responsiblity_description
from
fnd_user fu,
(select pbg.name business_group,pp.* from per_all_people_f pp, per_business_groups pbg where pbg.business_group_id=pp.business_group_id  and trunc(nvl(pp.effective_end_date,sysdate))>=trunc(sysdate)) papf,
(
select
furg.user_id,
--fat.application_name,
fa.application_short_name application_name,
frt.responsibility_name,
--fr.responsibility_key,
--fsgt.security_group_name,
frg.security_group_key security_group_name,
furg.start_date,
furg.end_date,
furg.description
from
fnd_responsibility fr,
fnd_application fa,
fnd_application_tl fat,
fnd_security_groups frg,
fnd_responsibility_tl frt,
fnd_user_resp_groups_direct furg,
fnd_security_groups_tl fsgt
where
fr.application_id=fa.application_id and
fr.data_group_id=frg.security_group_id and
fr.responsibility_id=frt.responsibility_id and
furg.responsibility_id=frt.responsibility_id and
frg.security_group_id=fsgt.security_group_id and
fsgt.language=userenv ('LANG') and
fat.application_id=fa.application_id and
trunc(nvl(furg.end_date,sysdate))>=trunc(sysdate) and
fat.language=userenv ('LANG') and
frt.language=userenv ('LANG')
)frt
where
1=1 and
fu.employee_id=papf.person_id(+) and
fu.user_id=frt.user_id(+)
&not_use_first_block
&report_table_select &report_table_name &report_table_where_clause
&processed_run
)y
order by
case when nvl(y.user_end_date,sysdate)>=trunc(sysdate) then 1 else 2 end,
to_date(y.user_creation_date) desc,
y.user_name