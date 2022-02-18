/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Forms Personalizations
-- Description: Forms personalizations and actions
-- Excel Examle Output: https://www.enginatics.com/example/fnd-forms-personalizations/
-- Library Link: https://www.enginatics.com/reports/fnd-forms-personalizations/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name,
decode(ffcr.rule_type,'A','Function','F','Form',ffcr.rule_type) level_,
decode(ffcr.enabled,'Y','Y') enabled,
ffcr.form_name,
ffv.user_form_name,
decode(ffcr.rule_type,'A',ffcr.function_name) function_name,
decode(ffcr.rule_type,'A',fffv.user_function_name) user_function_name,
ffcr.sequence,
ffcr.description,
ffcr.trigger_event,
ffcr.trigger_object,
ffcr.condition,
decode(ffcr.fire_in_enter_query,'Y','Both','N','Not in Enter-Query Mode','O','Only in Enter-Query Mode') processing_mode,
xxen_util.user_name(nvl(ffca.last_updated_by,ffcr.last_updated_by)) last_updated_by,
xxen_util.client_time(nvl(ffca.last_update_date,ffcr.last_update_date)) last_update_date,
&context_columns
ffca.sequence action_sequence,
decode(ffca.action_type,'P','Property','M','Message','B','Builtin','S','Menu') action_type,
ffca.summary action_desc,
decode(ffca.language,'*','All',flv.description) language,
decode(ffca.enabled,'Y','Y') action_enabled,
decode(ffca.action_type,'P',decode(ffca.object_type,'VAR','Local Variable','LOV','LOV','GLOBAL','Global Variable','TAB','Tab Page',initcap(ffca.object_type))) property_object_type,
decode(ffca.action_type,'P',ffca.target_object) property_target_object,
decode(ffca.action_type,'P',ffcpl.property_name) property_name,
decode(ffca.action_type,'P',decode(ffcpl.argument_type,
'B',decode(ffca.property_value,'4','True','5','False'),
'L',(select ffcpv.property_value from fnd_form_custom_prop_values ffcpv where ffcpl.property_name=ffcpv.property_name and ffca.property_value=ffcpv.property_id),
ffca.property_value)
) property_value,
--decode(ffcpl.argument_type,'B','Boolean','C','Character','N','Number','L','LOV','T','Block','I','Item') argument_type
decode(ffca.action_type,'M',decode(ffca.message_type,'S','Show','H','Hint','E','Error','D','Debug','W','Warn')) message_type,
decode(ffca.action_type,'M',ffca.message_text) message_text,
decode(ffca.action_type,'B',decode(ffca.builtin_type,
'C','Launch SRS Form',
'E','Launch a Function',
'U','Launch a URL',
'D','DO_KEY',
'P','Execute a Procedure',
'G','GO_ITEM',
'B','GO_BLOCK',
'F','FORMS_DDL',
'R','RAISE FORM_TRIGGER_FAILURE',
'T','EXECUTE_TRIGGER',
'S','SYNCHRONIZE',
'L','Call Custom Library',
'Q','Create Record Group from Query',
'X','Set Profile Value in Cache'
)) builtin_type,
decode(ffca.action_type,'B',case
when ffca.builtin_type='C' then (select fcpv.user_concurrent_program_name from fnd_concurrent_programs_vl fcpv, fnd_application fa where substr(ffca.builtin_arguments,1,instr(ffca.builtin_arguments,':')-1)=fa.application_short_name and fa.application_id=fcpv.application_id and substr(ffca.builtin_arguments,instr(ffca.builtin_arguments,':')+1)=fcpv.concurrent_program_name)
when ffca.builtin_type='E' then (select fffv.user_function_name from fnd_form_functions_vl fffv where ffca.menu_argument_short=fffv.function_name)
when ffca.builtin_type in ('Q','X') then ffca.builtin_arguments
when ffca.builtin_type in ('U','D','P','G','B','F','T','L') then ffca.builtin_arguments
end) builtin_value,
decode(ffca.action_type,'B',case
when ffca.builtin_type in ('U','Q') then ffca.menu_argument_short
when ffca.builtin_type in ('E','X') then ffca.menu_argument_long
end)
builtin_value2,
ffca.menu_entry,
ffca.menu_label,
decode(ffca.menu_seperator,'Y','Y') render_line_before_menu,
ffca.menu_argument_short icon_name,
ffca.menu_enabled_in enabled_in_block,
ffcr.id
from
fnd_form_custom_rules ffcr,
fnd_form_functions_vl fffv,
fnd_form_vl ffv,
fnd_application_vl fav,
(select ffcs.* from fnd_form_custom_scopes ffcs where '&show_scope'='Y') ffcs,
fnd_industries fi,
fnd_responsibility_vl frv,
fnd_user fu,
fnd_form_custom_actions ffca,
fnd_languages_vl flv,
fnd_form_custom_prop_list ffcpl
where
1=1 and
ffcr.rule_key is null and
ffcr.function_name=fffv.function_name(+) and
fffv.application_id=ffv.application_id(+) and
fffv.form_id=ffv.form_id(+) and
fffv.application_id=fav.application_id(+) and
ffcr.id=ffcs.rule_id(+) and
decode(ffcs.level_id,10,ffcs.level_value)=fi.industry_id(+) and
fi.language(+)=userenv('lang') and
decode(ffcs.level_id,30,ffcs.level_value_application_id)=frv.application_id(+) and
decode(ffcs.level_id,30,ffcs.level_value)=frv.responsibility_id(+) and
decode(ffcs.level_id,40,ffcs.level_value)=fu.user_id(+) and
ffcr.id=ffca.rule_id(+) and
ffca.language=flv.language_code(+) and
decode(ffca.action_type,'P',ffca.object_type)=ffcpl.field_type(+) and
ffca.property_name=ffcpl.property_id(+)
order by
fav.application_name,
ffv.form_name,
level_,
function_name,
decode(ffcr.rule_type,'A',ffcr.function_name),
ffcr.sequence,
ffca.sequence