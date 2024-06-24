/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: Blitz Report Access Upload
-- Description: Upload to update value for profile option 'Blitz Report Access' at user or responsibility level.

Someone having this upload assigned, can maintain the profile option values for other users or responsibilities up to their own access level.
He could, for example, set the value to 'User' for other users, but not to anything higher, such as 'Developer'.
Someone with Developer access could set the value for other users and developers, but not to the highest level 'System'.
-- Excel Examle Output: https://www.enginatics.com/example/blitz-report-access-upload/
-- Library Link: https://www.enginatics.com/reports/blitz-report-access-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
fpo.user_profile_option_name profile_option_name,
decode(fpov.level_id, 10003, 'Responsibility', 10004, 'User') level_,
decode(fpov.level_id, 10003, frv.responsibility_name, 10004, fu.user_name) value,
decode(fpov.level_id, 10003, frv.description, 10004, fu.description) description,
case
when fpov.profile_option_value='U' then 'User'
when fpov.profile_option_value='A' then 'User Admin'
when fpov.profile_option_value='D' then 'Developer'
when fpov.profile_option_value='S' then 'System'
end access_
from
fnd_profile_options_vl fpo,
fnd_profile_option_values fpov,
fnd_user fu,
fnd_responsibility_vl frv,
fnd_application_vl fav,
fnd_application_vl favr
where
1=1 and
fpov.level_id in (10003,10004) and
fpov.level_value=fu.user_id(+) and
fpov.level_value=frv.responsibility_id(+) and
frv.application_id=favr.application_id(+) and
fav.application_id=fpo.application_id and
fpo.profile_option_id=fpov.profile_option_id and
fpo.application_id=fpov.application_id and
fpo.profile_option_name='XXEN_REPORT_ACCESS'
&not_use_first_block
&report_table_select 
&report_table_name 
&report_table_where_clause 
&success_records
&processed_run
order by 5,6