/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Flex Value Sets, Usages and Values
-- Description: Value sets and values including usages, validation type, format type, validation table, columns etc.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-flex-value-sets-usages-and-values/
-- Library Link: https://www.enginatics.com/reports/fnd-flex-value-sets-usages-and-values/
-- Run Report: https://demo.enginatics.com/

select
ffvs.flex_value_set_name,
ffvs.description,
xxen_util.meaning(ffvs.longlist_flag,'FLEX_VALUESET_LONGLIST_FLAG',0) list_type,
xxen_util.meaning(ffvs.security_enabled_flag,'FLEX_VST_SECURITY_ENABLED_FLAG',0) security_type,
xxen_util.meaning(ffvs.format_type,'FIELD_TYPE',0) format_type,
ffvs.maximum_size,
xxen_util.meaning(decode(ffvs.alphanumeric_allowed_flag,'N','Y'),'YES_NO',0) numbers_only,
xxen_util.meaning(decode(ffvs.uppercase_only_flag,'Y','Y'),'YES_NO',0) uppercase_only,
xxen_util.meaning(ffvs.validation_type,'SEG_VAL_TYPES',0) validation_type,
(select ffvs0.flex_value_set_name from fnd_flex_value_sets ffvs0 where ffvs.parent_flex_value_set_id=ffvs0.flex_value_set_id) parent_value_set,
ffvs.dependant_default_value,
ffvs.dependant_default_meaning dependant_default_description,
&col_usages
&col_values
fav.application_name table_application,
ffvt.application_table_name table_name,
ffvt.value_column_name,
xxen_util.meaning(ffvt.value_column_type,'COLUMN_TYPE',0) value_column_type,
ffvt.value_column_size,
ffvt.meaning_column_name,
xxen_util.meaning(ffvt.meaning_column_type,'COLUMN_TYPE',0) meaning_column_type,
ffvt.meaning_column_size,
ffvt.id_column_name,
xxen_util.meaning(ffvt.id_column_type,'COLUMN_TYPE',0) id_column_type,
ffvt.id_column_size,
xxen_util.long_to_clob('fnd_flex_validation_tables','additional_where_clause',ffvt.rowid) where_order_by,
ffvt.additional_quickpick_columns additional_columns,
&lov_query
xxen_util.user_name(ffvs.created_by) created_by,
xxen_util.client_time(ffvs.creation_date) creation_date,
xxen_util.user_name(ffvs.last_updated_by) last_updated_by,
xxen_util.client_time(ffvs.last_update_date) last_update_date,
ffvs.flex_value_set_id
from
fnd_flex_value_sets ffvs,
fnd_flex_validation_tables ffvt,
fnd_application_vl fav,
(select ffvv.* from fnd_flex_values_vl ffvv where '&enable_values'='Y') ffvv,
(
select
fdfcuv.flex_value_set_id,
fav.application_name usage_application,
'Descriptive Flexfield' usage_type,
fdfv.title usage_title,
fdfcuv.descriptive_flex_context_code usage_context,
fdfcuv.end_user_column_name usage_column_name,
fdfcuv.form_left_prompt prompt
from
fnd_descr_flex_col_usage_vl fdfcuv,
fnd_descriptive_flexs_vl fdfv,
fnd_application_vl fav
where
'&enable_usages'='Y' and
fdfcuv.descriptive_flexfield_name not like '$SRS$.%' and
fdfcuv.application_id=fdfv.application_id and
fdfcuv.descriptive_flexfield_name=fdfv.descriptive_flexfield_name and
fdfcuv.application_id=fav.application_id
union all
select
fifs.flex_value_set_id,
fav.application_name usage_application,
'Key Flexfield' usage_type,
fif.id_flex_name usage_title,
fifsv.id_flex_structure_name usage_context,
fifs.segment_name usage_column_name,
fifs.form_left_prompt prompt
from
fnd_id_flex_segments_vl fifs,
fnd_id_flex_structures_vl fifsv,
fnd_id_flexs fif,
fnd_application_vl fav
where
'&enable_usages'='Y' and
fifs.application_id=fifsv.application_id and
fifs.id_flex_code=fifsv.id_flex_code and
fifs.id_flex_num=fifsv.id_flex_num and
fifs.application_id=fif.application_id and
fifs.id_flex_code=fif.id_flex_code and
fifs.application_id=fav.application_id
union all
select
fdfcuv.flex_value_set_id,
fav.application_name usage_application,
'Concurrent Program' usage_type,
fcpv.user_concurrent_program_name usage_title,
to_char(fdfcuv.column_seq_num) usage_context,
fdfcuv.end_user_column_name usage_column_name,
fdfcuv.form_left_prompt prompt
from
fnd_descr_flex_col_usage_vl fdfcuv,
fnd_concurrent_programs_vl fcpv,
fnd_application_vl fav
where
'&enable_usages'='Y' and
fdfcuv.descriptive_flexfield_name like '$SRS$.%' and
fdfcuv.application_id=fcpv.application_id and
substr(fdfcuv.descriptive_flexfield_name,7)=fcpv.concurrent_program_name and
fdfcuv.application_id=fav.application_id
) x
where
1=1 and
ffvs.flex_value_set_name not like '$FLEX$.%' and
ffvs.flex_value_set_id=ffvt.flex_value_set_id(+) and
ffvt.table_application_id=fav.application_id(+) and
ffvs.flex_value_set_id=ffvv.flex_value_set_id(+) and
ffvs.flex_value_set_id=x.flex_value_set_id(+)
order by
ffvs.flex_value_set_name,
x.usage_type,
x.usage_title,
x.usage_context,
x.usage_column_name,
ffvv.flex_value