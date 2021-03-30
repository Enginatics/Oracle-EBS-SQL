/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Descriptive Flexfields
-- Description: Descriptive flexfields table, context, column and validation information
-- Excel Examle Output: https://www.enginatics.com/example/fnd-descriptive-flexfields/
-- Library Link: https://www.enginatics.com/reports/fnd-descriptive-flexfields/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name application,
fdfv.title,
fdfv.application_table_name table_name,
fdfcv.descriptive_flex_context_code context_code,
fdfcv.descriptive_flex_context_name context_name,
fdfcv.description context_description,
fdfcuv.column_seq_num seq_num,
fdfcuv.form_left_prompt window_prompt,
fdfcuv.application_column_name table_column,
ffvs.flex_value_set_name value_set_name,
xxen_util.meaning(decode(fdfcuv.enabled_flag,'Y','Y'),'YES_NO',0) enabled,
xxen_util.meaning(decode(fdfcuv.display_flag,'Y','Y'),'YES_NO',0) displayed,
xxen_util.meaning(decode(fdfcuv.required_flag,'Y','Y'),'YES_NO',0) required,
xxen_util.meaning(decode(fdfcuv.security_enabled_flag,'Y','Y'),'YES_NO',0) security_enabled,
xxen_util.meaning(ffvs.validation_type,'SEG_VAL_TYPES',0) validation_type,
ffvt.application_table_name validation_table,
ffvt.additional_where_clause where_clause,
xxen_util.user_name(fdfcuv.created_by) created_by,
xxen_util.client_time(fdfcuv.creation_date) creation_date,
xxen_util.user_name(fdfcuv.last_updated_by) last_updated_by,
xxen_util.client_time(fdfcuv.last_update_date) last_update_date,
fdfv.application_id,
fdfv.descriptive_flexfield_name
from
fnd_application_vl fav,
fnd_descriptive_flexs_vl fdfv,
fnd_descr_flex_contexts_vl fdfcv,
fnd_descr_flex_col_usage_vl fdfcuv,
fnd_flex_value_sets ffvs,
fnd_flex_validation_tables ffvt
where
1=1 and
fdfv.descriptive_flexfield_name not like '$SRS$.%' and
fav.application_id=fdfv.application_id and
fdfv.application_id=fdfcv.application_id and
fdfv.descriptive_flexfield_name=fdfcv.descriptive_flexfield_name and
fdfcv.application_id=fdfcuv.application_id(+) and
fdfcv.descriptive_flexfield_name=fdfcuv.descriptive_flexfield_name(+) and
fdfcv.descriptive_flex_context_code=fdfcuv.descriptive_flex_context_code(+) and
fdfcuv.flex_value_set_id=ffvs.flex_value_set_id(+) and
decode(ffvs.validation_type,'F',ffvs.flex_value_set_id)=ffvt.flex_value_set_id(+)
order by
fav.application_name,
fdfv.title,
fdfcv.descriptive_flex_context_name,
fdfcuv.column_seq_num