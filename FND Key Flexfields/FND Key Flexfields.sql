/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
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
xxen_util.meaning(decode(fifsv.enabled_flag,'Y','Y'),'YES_NO',0) structure_enabled,
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
xxen_util.meaning(decode(fifsgv.enabled_flag,'Y','Y'),'YES_NO',0) enabled,
xxen_util.meaning(decode(fifsgv.display_flag,'Y','Y'),'YES_NO',0) displayed,
xxen_util.meaning(decode(fifsgv.required_flag,'Y','Y'),'YES_NO',0) required,
xxen_util.meaning(decode(fifsgv.security_enabled_flag,'Y','Y'),'YES_NO',0) security_enabled,
xxen_util.meaning(ffvs.validation_type,'SEG_VAL_TYPES',0) validation_type,
ffvt.application_table_name validation_table,
ffvt.additional_where_clause where_clause,
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