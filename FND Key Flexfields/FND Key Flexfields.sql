/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Key Flexfields
-- Description: Key flexfields table, structure, column and validation information
-- Excel Examle Output: https://www.enginatics.com/example/fnd-key-flexfields/
-- Library Link: https://www.enginatics.com/reports/fnd-key-flexfields/
-- Run Report: https://demo.enginatics.com/

select
fav.application_name,
fif.id_flex_name title,
fif.description,
fif.id_flex_code,
fif.application_table_name,
fif.unique_id_column_name,
fif.set_defining_column_name,
xxen_util.yes(fifsv.freeze_flex_definition_flag) freeze_flexfield,
xxen_util.yes(fifsv.enabled_flag) structure_enabled,
fifsv.concatenated_segment_delimiter segment_separator,
xxen_util.yes(fifsv.cross_segment_validation_flag) cross_validate,
xxen_util.yes(fifsv.freeze_structured_hier_flag) freeze_rollup_group,
xxen_util.yes(fifsv.dynamic_inserts_allowed_flag) allow_dynamic_inserts,
fifsv.id_flex_structure_code structure_code,
fifsv.id_flex_structure_name structure_name,
fifsv.id_flex_num,
fifsv.concatenated_segment_delimiter delimiter,
fifsv.shorthand_prompt,
fifsgv.segment_num segment_number,
fifsgv.segment_name,
fifsgv.form_left_prompt window_prompt,
fifsgv.application_column_name column_name,
(
select distinct
listagg(xxen_util.meaning(fsav.segment_attribute_type,'XLA_FLEXFIELD_SEGMENTS_QUAL',602),', ') within group (order by xxen_util.meaning(fsav.segment_attribute_type,'XLA_FLEXFIELD_SEGMENTS_QUAL',602)) over (partition by fsav.application_id,fsav.id_flex_code,fsav.id_flex_num,fsav.application_column_name) segment_attributes
from
fnd_segment_attribute_values fsav
where
fifsgv.application_id=fsav.application_id and
fifsgv.id_flex_code=fsav.id_flex_code and
fifsgv.id_flex_num=fsav.id_flex_num and
fifsgv.application_column_name=fsav.application_column_name and
fsav.attribute_value='Y' and
fsav.segment_attribute_type<>'GL_GLOBAL'
) flexfield_qualifier,
(
select distinct
listagg(fsav.segment_attribute_type,', ') within group (order by fsav.segment_attribute_type) over (partition by fsav.application_id,fsav.id_flex_code,fsav.id_flex_num,fsav.application_column_name) segment_attributes
from
fnd_segment_attribute_values fsav
where
fifsgv.application_id=fsav.application_id and
fifsgv.id_flex_code=fsav.id_flex_code and
fifsgv.id_flex_num=fsav.id_flex_num and
fifsgv.application_column_name=fsav.application_column_name and
fsav.attribute_value='Y' and
fsav.segment_attribute_type<>'GL_GLOBAL'
) flexfield_qualifier_code,
ffvs.flex_value_set_name value_set_name,
xxen_util.yes(fifsgv.enabled_flag) enabled,
xxen_util.yes(fifsgv.display_flag) displayed,
xxen_util.yes(fifsgv.application_column_index_flag) indexed,
xxen_util.yes(fifsgv.required_flag) required,
xxen_util.yes(fifsgv.security_enabled_flag) security_enabled,
xxen_util.meaning(ffvs.validation_type,'SEG_VAL_TYPES',0) validation_type,
ffvt.application_table_name validation_table,
ffvt.additional_where_clause where_clause,
xxen_util.user_name(fifsgv.created_by) created_by,
xxen_util.client_time(fifsgv.creation_date) creation_date,
xxen_util.user_name(fifsgv.last_updated_by) last_updated_by,
xxen_util.client_time(fifsgv.last_update_date) last_update_date,
fifsgv.flex_value_set_id
from
fnd_application_vl fav,
fnd_id_flexs fif,
fnd_id_flex_structures_vl fifsv,
fnd_id_flex_segments_vl fifsgv,
fnd_flex_value_sets ffvs,
fnd_flex_validation_tables ffvt
where
1=1 and
fav.application_id=fif.application_id and
fif.application_id=fifsv.application_id(+) and
fif.id_flex_code=fifsv.id_flex_code(+) and
fifsv.application_id=fifsgv.application_id(+) and
fifsv.id_flex_code=fifsgv.id_flex_code(+) and
fifsv.id_flex_num=fifsgv.id_flex_num(+) and
fifsgv.flex_value_set_id=ffvs.flex_value_set_id(+) and
decode(ffvs.validation_type,'F',ffvs.flex_value_set_id)=ffvt.flex_value_set_id(+)
order by
fav.application_name,
fif.id_flex_name,
fifsv.id_flex_structure_name,
fifsgv.segment_num