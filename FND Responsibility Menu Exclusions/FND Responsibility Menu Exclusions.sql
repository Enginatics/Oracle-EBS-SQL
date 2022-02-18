/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Responsibility Menu Exclusions
-- Description: Responsibility menu exclusions
-- Excel Examle Output: https://www.enginatics.com/example/fnd-responsibility-menu-exclusions/
-- Library Link: https://www.enginatics.com/reports/fnd-responsibility-menu-exclusions/
-- Run Report: https://demo.enginatics.com/

select
frv.responsibility_name,
fav.application_name application,
xxen_util.meaning(frf.rule_type,'FND_RESP_FUNC_RULE_TYPE',0) type,
decode(frf.rule_type,'F',fffv.user_function_name,fmv.user_menu_name) name,
decode(frf.rule_type,'F',fffv.function_name,fmv.menu_name) system_name,
decode(frf.rule_type,'F',fffv.description,fmv.description) description
from
fnd_application_vl fav,
fnd_responsibility_vl frv,
fnd_resp_functions frf,
fnd_form_functions_vl fffv,
fnd_menus_vl fmv
where
1=1 and
fav.application_id=frv.application_id and
frv.application_id=frf.application_id and
frv.responsibility_id=frf.responsibility_id and
decode(frf.rule_type,'F',frf.action_id)=fffv.function_id(+) and
decode(frf.rule_type,'M',frf.action_id)=fmv.menu_id(+)
order by
frv.responsibility_name,
type,
name