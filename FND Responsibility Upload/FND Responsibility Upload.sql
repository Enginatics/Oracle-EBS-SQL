/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Responsibility Upload
-- Description: Upload to create and update responsibilities and their menu and function exclusions, as in the Responsibilities form of the System Administrator responsibility.
-- Each row is one of two row types:
-- - Responsibility: creates or updates the responsibility definition. A responsibility is identified by Application and Responsibility Key and created when that combination does not exist. The key cannot be changed once created; to rename a responsibility, change its Responsibility Name.
-- - Menu/Function Exclusion: adds a menu or function exclusion to the responsibility identified by Application and Responsibility Key, or removes it with Exclude Yes. Exclusion Type selects Function or Menu, Exclusion Name the item. When creating a responsibility and its exclusions in one file, place the Responsibility row first.
-- Upload Mode Create opens an empty sheet. Create, Update downloads the responsibilities and their exclusions selected by Application and Responsibility Name; without either it downloads every responsibility of the instance.
-- Responsibilities are not deleted: enter an Effective Date To to end one.
-- Excel Example Output: https://www.enginatics.com/example/fnd-responsibility-upload/
-- Library Link: https://www.enginatics.com/reports/fnd-responsibility-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
x.row_type,
x.application,
x.responsibility_key,
x.responsibility_name,
x.description,
x.effective_date_from,
x.effective_date_to,
x.available_from,
x.data_group,
x.data_group_application,
x.menu,
x.request_group,
x.request_group_application,
x.web_host_name,
x.web_agent_name,
x.exclusion_type,
x.exclusion_name,
x.exclude,
row_number() over (order by decode(x.row_type,'Responsibility',1,2),x.application,x.responsibility_key) upload_row
from
(
select
'Responsibility' row_type,
fav.application_name application,
fr.responsibility_key,
frt.responsibility_name,
frt.description,
fr.start_date effective_date_from,
fr.end_date effective_date_to,
decode(fr.version,'4','Oracle Applications','W','Oracle Self Service Web Applications','M','Oracle Mobile Applications') available_from,
fdg.data_group_name data_group,
fav_dg.application_name data_group_application,
fmv.user_menu_name menu,
frg.request_group_name request_group,
fav_rg.application_name request_group_application,
fr.web_host_name,
fr.web_agent_name,
to_char(null) exclusion_type,
to_char(null) exclusion_name,
to_char(null) exclude
from
fnd_responsibility fr,
fnd_responsibility_tl frt,
fnd_application_vl fav,
fnd_data_groups_standard_view fdg,
fnd_application_vl fav_dg,
fnd_menus_vl fmv,
fnd_request_groups frg,
fnd_application_vl fav_rg
where
1=1 and
fr.application_id=fav.application_id and
frt.responsibility_id=fr.responsibility_id and
frt.application_id=fr.application_id and
frt.language=userenv('lang') and
fr.data_group_id=fdg.data_group_id and
fr.data_group_application_id=fav_dg.application_id and
fr.menu_id=fmv.menu_id and
fr.request_group_id=frg.request_group_id(+) and
fr.group_application_id=frg.application_id(+) and
frg.application_id=fav_rg.application_id(+)
union all
select
'Menu/Function Exclusion' row_type,
fav.application_name application,
fr.responsibility_key,
to_char(null) responsibility_name,
to_char(null) description,
to_date(null) effective_date_from,
to_date(null) effective_date_to,
to_char(null) available_from,
to_char(null) data_group,
to_char(null) data_group_application,
to_char(null) menu,
to_char(null) request_group,
to_char(null) request_group_application,
to_char(null) web_host_name,
to_char(null) web_agent_name,
xxen_util.meaning(rf.rule_type,'FND_RESP_FUNC_RULE_TYPE',0) exclusion_type,
case rf.rule_type when 'F' then (select fffv.user_function_name from fnd_form_functions_vl fffv where fffv.function_id=rf.action_id) when 'M' then (select fmv.user_menu_name from fnd_menus_vl fmv where fmv.menu_id=rf.action_id) end exclusion_name,
to_char(null) exclude
from
fnd_resp_functions rf,
fnd_responsibility fr,
fnd_responsibility_tl frt,
fnd_application_vl fav
where
2=2 and
rf.application_id=fr.application_id and
rf.responsibility_id=fr.responsibility_id and
frt.responsibility_id=fr.responsibility_id and
frt.application_id=fr.application_id and
frt.language=userenv('lang') and
fr.application_id=fav.application_id
) x
