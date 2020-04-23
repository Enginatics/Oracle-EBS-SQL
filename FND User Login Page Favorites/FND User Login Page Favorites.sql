/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND User Login Page Favorites
-- Description: User's HTML favourites from table icx_custom_menu_entries
-- Excel Examle Output: https://www.enginatics.com/example/fnd-user-login-page-favorites/
-- Library Link: https://www.enginatics.com/reports/fnd-user-login-page-favorites/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.user_name(icme.user_id) user_name,
frv.responsibility_name responsibility,
icme.display_sequence,
icme.prompt,
icme.url,
nvl(xxen_util.meaning(fffv.type,'FORM_FUNCTION_TYPE',0),icme.function_type) type,
fffv.user_function_name,
fffv.function_name
from
icx_custom_menu_entries icme,
fnd_responsibility_vl frv,
fnd_form_functions_vl fffv
where
1=1 and
icme.responsibility_id=frv.responsibility_id(+) and
icme.responsibility_application_id=frv.application_id(+) and
icme.function_id=fffv.function_id(+)
order by
user_name,
icme.display_sequence