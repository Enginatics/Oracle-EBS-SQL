/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Profile Option Values
-- Description: Profile option values on all setup levels.
Unlike Oracle's SQL script from note 201945.1, this report also shows the user visible profile option value in addition to the internal system profile option value.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-profile-option-values/
-- Library Link: https://www.enginatics.com/reports/fnd-profile-option-values/
-- Run Report: https://demo.enginatics.com/

select
fav0.application_name,
fpo.user_profile_option_name,
decode(fpov.level_id,10001,'Site',10002,'Application', 10003,'Responsibility', 10004,'User', 10005,'Server',10006,'Operating Unit',
10007,decode(to_char(fpov.level_value2),'-1','Responsibility',decode(to_char(fpov.level_value),'-1','Server','Server+Resp'))
) level_,
decode(fpov.level_id,10001,null,10002,fav.application_name,10003,frv.responsibility_name,10004,xxen_util.user_name(decode(fpov.level_id,10004,fpov.level_value)),10005,fn.node_name,10006,haouv.name,
10007,decode(to_char(fpov.level_value2),'-1',frv.responsibility_name,decode(to_char(fpov.level_value),'-1',fn.node_name,fn.node_name||' - '||frv.responsibility_name))
) level_name,
xxen_util.display_profile_option_value(fpo.application_id,fpo.profile_option_id,fpov.profile_option_value) profile_option_value,
fpov.profile_option_value system_profile_option_value,
xxen_util.user_name(fpov.last_updated_by) last_updated_by,
xxen_util.client_time(fpov.last_update_date) last_update_date,
fpo.profile_option_name system_profile_option_name,
fpo.profile_option_id,
fpov.level_value,
fpov.level_value2,
xxen_util.user_name(fpov.created_by) created_by,
xxen_util.client_time(fpov.creation_date) creation_date
from
fnd_application_vl fav0,
fnd_profile_options_vl fpo,
fnd_profile_option_values fpov,
fnd_responsibility_vl frv,
fnd_user fu,
fnd_application_vl fav,
hr_all_organization_units_vl haouv,
fnd_nodes fn
where
1=1 and
fav0.application_id=fpo.application_id and
fpo.profile_option_id=fpov.profile_option_id and
fpo.application_id=fpov.application_id and
decode(fpov.level_id,10002,fpov.level_value)=fav.application_id(+) and
case when fpov.level_id in (10003,10007) then fpov.level_value end=frv.responsibility_id(+) and
case when fpov.level_id in (10003,10007) then fpov.level_value_application_id end=frv.application_id(+) and
decode(fpov.level_id,10004,fpov.level_value)=fu.user_id(+) and
decode(fpov.level_id,10005,fpov.level_value,10007,fpov.level_value2)=fn.node_id(+) and
decode(fpov.level_id,10006,fpov.level_value)=haouv.organization_id(+)
order by
fpo.user_profile_option_name,
fpov.level_id,
decode(fpov.level_id,10001,null,10002,fav.application_name, 10003,frv.responsibility_name, 10004,xxen_util.user_name(decode(fpov.level_id,10004,fpov.level_value)), 10005,fn.node_name,10006,haouv.name)