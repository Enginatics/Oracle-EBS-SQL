/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Responsibility Upload
-- Description: Create and update Oracle E-Business Suite responsibilities, and maintain their menu/function exclusions, replicating the System Administrator Responsibilities form (FNDSCRSP).

Each row is one of two entity types, chosen in the Row Type column:

- Responsibility: creates or updates the responsibility definition (Name, Application, Key, Description, Effective Dates, Available From, Data Group, Menu, Request Group, Web Host/Agent Name). Responsibilities are identified by Application + Responsibility Key. A responsibility is created when that combination does not yet exist, otherwise it is updated. The Responsibility Key is the stable identifier and is not editable once created - to rename a responsibility change its Name, not its Key.

- Menu/Function Exclusion: adds (or, with Exclude = Yes, removes) a menu or function exclusion for the responsibility identified by Application + Responsibility Key. Exclusion Type selects Function or Menu; Exclusion Name selects the item to exclude. When adding a new responsibility and its exclusions in the same upload, place the Responsibility row before its exclusion rows.

Upload Modes:
- Create opens an empty template.
- Create, Update downloads existing responsibilities (and their exclusions) matching the Application / Responsibility filters for review and update.

Responsibilities are not deleted by this upload; set an Effective Date To to disable one, matching Oracle best practice.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-responsibility-upload/
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