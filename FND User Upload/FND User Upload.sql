/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND User Upload
-- Description: Upload to create and update application users and their responsibility assignments, as in the Users form.
-- Each row is one responsibility assignment of a user. A user that does not exist is created, together with an employee when a Business Group is entered and no person with the same name and employee number exists in it. The user and person columns of an existing user are applied from the first row of that user in the file.
-- A responsibility not yet assigned to the user is assigned; for an assigned one, the row's dates and description update the assignment. Assignments are not removed: enter an end date to end one.
-- Clearing Description, Email Address, Fax or User End Date of an existing user clears the stored value.
-- Excel Example Output: https://www.enginatics.com/example/fnd-user-upload/
-- Library Link: https://www.enginatics.com/reports/fnd-user-upload/
-- Run Report: https://demo.enginatics.com/

select
y.*
from
(
select
null action_,
null status_,
null message_,
null modified_columns_,
fu.user_name,
null unencrypted_password,
fu.description,
papf.business_group,
papf.full_name person,
papf.employee_number,
papf.first_name,
papf.last_name,
papf.sex gender,
papf.date_of_birth,
fu.email_address,
fu.fax,
fu.start_date user_start_date,
fu.end_date user_end_date,
fu.last_logon_date,
xxen_util.user_name(fu.created_by) created_by,
xxen_util.client_time(fu.creation_date) user_creation_date,
xxen_util.user_name(fu.last_updated_by) user_last_updated_by,
xxen_util.client_time(fu.last_update_date) user_last_update_date,
frv.responsibility_name,
frv.application_name responsiblity_application,
frv.start_date responsiblity_start,
frv.end_date responsiblity_end,
frv.description assignment_description,
0 upload_row
from
fnd_user fu,
(select pbg.name business_group, papf.* from per_all_people_f papf, per_business_groups pbg where papf.business_group_id=pbg.business_group_id and nvl(papf.effective_end_date,sysdate)>=trunc(sysdate)) papf,
(
select
furgd.user_id,
frv.responsibility_name,
fa.application_short_name application_name,
furgd.start_date,
furgd.end_date,
furgd.description
from
fnd_responsibility_vl frv,
fnd_application fa,
fnd_user_resp_groups_direct furgd
where
2=2 and
frv.application_id=fa.application_id and
frv.application_id=furgd.responsibility_application_id and
frv.responsibility_id=furgd.responsibility_id
) frv
where
1=1 and
fu.employee_id=papf.person_id(+) and
fu.user_id=frv.user_id(+)
) y
