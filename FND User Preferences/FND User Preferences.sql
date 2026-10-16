/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND User Preferences
-- Description: User preferences from table fnduserpreferences
-- Excel Example Output: https://www.enginatics.com/example/fnd-user-preferences/
-- Library Link: https://www.enginatics.com/reports/fnd-user-preferences/
-- Run Report: https://demo.enginatics.com/

select
fup.user_name,
fup.module_name,
fup.preference_name,
fup.preference_value
from
fnd_user_preferences fup
where
1=1
order by
fup.user_name,
fup.module_name,
fup.preference_name
