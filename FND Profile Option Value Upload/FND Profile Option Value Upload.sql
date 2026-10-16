/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Profile Option Value Upload
-- Description: Upload to create, update and delete profile option values on site, application, responsibility, server, operating unit and user level, as in the System Profile Values form. Levels that the profile option definition does not allow to update are not offered.
-- The Value column shows and accepts the visible value of profile options validated by a list of values, e.g. a responsibility name instead of its id. Its list of values is derived from each profile option's SQL validation. A stored value is accepted as well. A few validations cannot be evaluated outside the profile form, e.g. because they depend on the responsibility being updated. These offer no list, save the value as entered and say so in the row message.
-- Clearing the Value of an existing row deletes the profile option value on that level.
-- The Server column is used only for profile options with the server and responsibility hierarchy, to set a value for a responsibility on a specific server.
-- Excel Example Output: https://www.enginatics.com/example/fnd-profile-option-value-upload/
-- Library Link: https://www.enginatics.com/reports/fnd-profile-option-value-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
x.*,
to_number(null) upload_row
from
(
select
rowidtochar(fpov.rowid) row_id,
fpo.user_profile_option_name profile_option,
fpo.profile_option_name profile_option_code,
decode(fpov.level_id,10001,'Site',10002,'Application',10003,'Responsibility',10004,'User',10005,'Server',10006,'Operating Unit',10007,decode(fpov.level_value,-1,'Server','Responsibility')) level_,
decode(fpov.level_id,10002,fav.application_name,10003,frv.responsibility_name,10004,fu.user_name,10005,fn.node_name,10006,haouv.name,10007,nvl(frv.responsibility_name,fn.node_name)) level_value,
fav_r.application_name responsibility_application,
decode(fpov.level_id,10007,decode(fpov.level_value,-1,null,fn.node_name)) server,
xxen_util.display_profile_option_value(fpov.application_id,fpov.profile_option_id,fpov.profile_option_value) profile_option_value
from
fnd_profile_options_vl fpo,
fnd_profile_option_values fpov,
fnd_application_vl fav,
fnd_responsibility_vl frv,
fnd_application_vl fav_r,
fnd_user fu,
fnd_nodes fn,
hr_all_organization_units_vl haouv
where
fpo.start_date_active<=sysdate and
nvl(fpo.end_date_active,sysdate)>=sysdate and
fpo.application_id=fpov.application_id and
fpo.profile_option_id=fpov.profile_option_id and
decode(fpov.level_id,10002,fpov.level_value)=fav.application_id(+) and
case when fpov.level_id in (10003,10007) then fpov.level_value end=frv.responsibility_id(+) and
case when fpov.level_id in (10003,10007) then fpov.level_value_application_id end=frv.application_id(+) and
frv.application_id=fav_r.application_id(+) and
decode(fpov.level_id,10004,fpov.level_value)=fu.user_id(+) and
decode(fpov.level_id,10005,fpov.level_value,10007,fpov.level_value2)=fn.node_id(+) and
decode(fpov.level_id,10006,fpov.level_value)=haouv.organization_id(+)
) x
where
1=1
