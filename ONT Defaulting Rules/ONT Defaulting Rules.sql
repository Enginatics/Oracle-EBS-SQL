/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: ONT Defaulting Rules
-- Description: Shows the complete Order Management defaulting rules setup
-- Excel Examle Output: https://www.enginatics.com/example/ont-defaulting-rules/
-- Library Link: https://www.enginatics.com/reports/ont-defaulting-rules/
-- Run Report: https://demo.enginatics.com/

select
odaoev.application_name application,
odaoev.name entity,
odaaev.defaulting_sequence,
odaaev.name attribute,
xxen_util.yes(odaaev.defaulting_condn_ref_flag) include_in_building_conditions,
odacv.display_name condition,
(select listagg(odcev.attribute_display_name||odcev.value_op||odcev.value_string,chr(10)) within group (order by odcev.group_number, odcev.attribute_code) from oe_def_condn_elems_v odcev where odacv.condition_id=odcev.condition_id and rownum=1) validation_rule,
odacv.precedence,
xxen_util.yes(odacv.enabled_flag) enabled,
xxen_util.yes(odacv.system_flag) seeded,
odadr.sequence_no sequence,
xxen_util.meaning(odadr.src_type,'DEFAULTING_SOURCE_TYPE',660) source_type,
case odadr.src_type
when 'CONSTANT' then odadr.src_constant_value
when 'PROFILE_OPTION' then odadr.src_profile_option
when 'API' then odadr.src_api_pkg||'.'||odadr.src_api_fn
when 'API_MULTIREC' then odadr.src_api_pkg||'.'||odadr.src_api_fn
when 'SYSTEM' then odadr.src_system_variable_expr
when 'RELATED_RECORD' then (select odaaev2.database_object_display_name||'.'||odaaev2.name from oe_def_ak_attr_ext_v odaaev2 where odadr.src_database_object_name=odaaev2.database_object_name and odadr.src_attribute_code=odaaev2.attribute_code)
when 'SAME_RECORD' then (select odaaev2.name from oe_def_ak_attr_ext_v odaaev2 where odadr.src_database_object_name=odaaev2.database_object_name and odadr.src_attribute_code=odaaev2.attribute_code)
end source_value,
xxen_util.user_name(odacv.created_by) created_by,
xxen_util.client_time(odacv.creation_date) creation_date,
xxen_util.user_name(odacv.last_updated_by) last_updated_by,
xxen_util.client_time(odacv.last_update_date) last_update_date,
xxen_util.user_name(odadr.created_by) rule_created_by,
xxen_util.client_time(odadr.creation_date) rule_creation_date,
xxen_util.user_name(odadr.last_updated_by) rule_last_updated_by,
xxen_util.client_time(odadr.last_update_date) rule_last_update_date,
odaoev.application_id,
odaaev.database_object_name,
odaaev.attribute_code,
odacv.attr_def_condition_id,
odadr.attr_def_rule_id
from
oe_def_ak_obj_ext_v odaoev,
oe_def_ak_attr_ext_v odaaev,
oe_def_attr_condns_v odacv,
oe_def_attr_def_rules odadr
where
1=1 and
odaoev.database_object_name=odaaev.database_object_name and
odaaev.defaulting_enabled_flag='Y' and
odaaev.database_object_name=odacv.database_object_name(+) and
odaaev.attribute_code=odacv.attribute_code(+) and
odacv.attr_def_condition_id=odadr.attr_def_condition_id(+)
order by
odaoev.application_name,
odaoev.name,
odaaev.defaulting_sequence,
odaaev.name,
odacv.precedence,
odadr.sequence_no