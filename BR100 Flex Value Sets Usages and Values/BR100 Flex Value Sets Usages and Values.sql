/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: BR100 - Flex Value Sets, Usages and Values
-- Description: Value sets and values including usages, validation type, format type, validation table, columns etc.
-- Excel Examle Output: https://www.enginatics.com/example/br100-flex-value-sets-usages-and-values/
-- Library Link: https://www.enginatics.com/reports/br100-flex-value-sets-usages-and-values/
-- Run Report: https://demo.enginatics.com/

select 
 q.rectype row_type
,q.flex_value_set_name value_set_name
,q.parent_value_set
,q.description
,q.format_type
,q.maximum_size
,q.validation_type
&col_usages_1
&col_values_1
 ,case when q.rectype = 'Value Set'
 then q.table_application
 end table_application
 ,case when q.rectype = 'Value Set'
 then q.table_name
 end table_name
,q.value_column_name
,q.value_column_type
,q.value_column_size
,q.meaning_column_name
,q.meaning_column_type
,q.meaning_column_size
,q.id_column_name
,q.id_column_type
,q.id_column_size
 ,case when q.rectype = 'Value Set'
 then xxen_report.ffvt_additional_where_clause(q.table_rowid)
 else to_clob(null) end where_order_by
,q.additional_columns
&show_lov_qry
from
(
select -- value sets
'Value Set' rectype,
ffvs.flex_value_set_name,
ffvs2.flex_value_set_name parent_value_set,
ffvs.description,
xxen_util.meaning(ffvs.format_type,'FIELD_TYPE',0) format_type,
ffvs.maximum_size,
xxen_util.meaning(ffvs.validation_type,'SEG_VAL_TYPES',0) validation_type,
'' usage_application,
'' usage_type,
'' usage_title,
'' usage_context,
'' usage_column_name,
'' prompt,
'' flex_value,
'' value_description,
'' value_enabled,
to_date(null) value_start_date,
to_date(null) value_end_date,
'' value_parent,
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
ffvt.additional_quickpick_columns additional_columns,
ffvs.flex_value_set_id,
ffvt.rowid table_rowid
from
fnd_flex_value_sets ffvs,
fnd_flex_validation_tables ffvt,
fnd_application_vl fav,
fnd_flex_value_sets ffvs2
where
    ffvs.flex_value_set_id=ffvt.flex_value_set_id(+)
and ffvt.table_application_id=fav.application_id(+)
and ffvs.parent_flex_value_set_id=ffvs2.flex_value_set_id(+)
UNION -- flex values
select
'Flex Value' rectype,
ffvs.flex_value_set_name,
ffvs2.flex_value_set_name parent_value_set,
ffvs.description,
xxen_util.meaning(ffvs.format_type,'FIELD_TYPE',0) format_type,
ffvs.maximum_size,
xxen_util.meaning(ffvs.validation_type,'SEG_VAL_TYPES',0) validation_type,
'' usage_application,
'' usage_type,
'' usage_title,
'' usage_context,
'' usage_column_name,
'' prompt,
ffvv.flex_value,
ffvv.description value_description,
ffvv.enabled_flag value_enabled,
ffvv.start_date_active value_start_date,
ffvv.end_date_active value_end_date,
ffvv.parent_flex_value_low value_parent,
'' table_application,
'' table_name,
'' value_column_name,
'' value_column_type,
to_number(null) value_column_size,
'' meaning_column_name,
'' meaning_column_type,
to_number(null) meaning_column_size,
'' id_column_name,
'' id_column_type,
to_number(null) id_column_size,
'' additional_columns,
ffvs.flex_value_set_id,
null table_rowid
from
fnd_flex_value_sets ffvs,
fnd_flex_values_vl  ffvv,
fnd_flex_value_sets ffvs2
where
    '&enable_values'='Y'
and ffvs.validation_type!=xxen_util.lookup_code('Table','SEG_VAL_TYPES',0)
and ffvv.flex_value_set_id=ffvs.flex_value_set_id
and ffvv.enabled_flag = NVL('&active_only',ffvv.enabled_flag)
and NVL2('&active_only',sysdate,nvl(ffvv.start_date_active,sysdate)) between nvl(ffvv.start_date_active,sysdate) and nvl(ffvv.end_date_active,sysdate)
and ffvs.parent_flex_value_set_id=ffvs2.flex_value_set_id(+)
UNION -- Flex Value Set Usage
select
'Usage' rectype,
ffvs.flex_value_set_name,
ffvs2.flex_value_set_name parent_value_set,
ffvs.description,
xxen_util.meaning(ffvs.format_type,'FIELD_TYPE',0) format_type,
ffvs.maximum_size,
xxen_util.meaning(ffvs.validation_type,'SEG_VAL_TYPES',0) validation_type,
ffvsu.usage_application,
ffvsu.usage_type,
ffvsu.usage_title,
ffvsu.usage_context,
ffvsu.usage_column_name,
ffvsu.prompt,
'' flex_value,
'' value_description,
'' value_enabled,
to_date(null) value_start_date,
to_date(null) value_end_date,
'' value_parent,
fav.application_name table_application,
ffvt.application_table_name table_name,
'' value_column_name,
'' value_column_type,
to_number(null) value_column_size,
'' meaning_column_name,
'' meaning_column_type,
to_number(null) meaning_column_size,
'' id_column_name,
'' id_column_type,
to_number(null) id_column_size,
'' additional_columns,
ffvs.flex_value_set_id,
null table_rowid
from
fnd_flex_value_sets ffvs,
fnd_flex_validation_tables ffvt,
fnd_application_vl fav,
fnd_flex_value_sets ffvs2,
(select
  fdfcuv.flex_value_set_id,
  fav2.application_name usage_application,
  'Descriptive Flexfield' usage_type,
  fdfv.title usage_title,
  fdfcuv.descriptive_flex_context_code usage_context,
  fdfcuv.end_user_column_name usage_column_name,
  fdfcuv.form_left_prompt prompt
 from
  fnd_descr_flex_col_usage_vl fdfcuv,
  fnd_descr_flex_contexts fdfc,
  fnd_descriptive_flexs_vl fdfv,
  fnd_application_vl fav2
 where
   fdfcuv.descriptive_flexfield_name not like '$SRS$.%'
 and fdfcuv.application_id = fdfc.application_id
 and fdfcuv.descriptive_flexfield_name = fdfc.descriptive_flexfield_name
 and fdfcuv.descriptive_flex_context_code = fdfc.descriptive_flex_context_code
 and fdfcuv.application_id=fdfv.application_id
 and fdfcuv.descriptive_flexfield_name=fdfv.descriptive_flexfield_name
 and fdfcuv.application_id=fav2.application_id
 and fdfcuv.enabled_flag = NVL('&active_only',fdfcuv.enabled_flag)
 and fdfc.enabled_flag = NVL('&active_only',fdfc.enabled_flag)  
 union
 select
  fifs.flex_value_set_id,
  fav2.application_name usage_application,
  'Key Flexfield' usage_type,
  fif.id_flex_name usage_title,
  fifsv.id_flex_structure_name usage_context,
  fifs.segment_name usage_column_name,
  fifs.form_left_prompt prompt
 from
  fnd_id_flex_segments_vl fifs,
  fnd_id_flex_structures_vl fifsv,
  fnd_id_flexs fif,
  fnd_application_vl fav2 
 where
     fifs.application_id=fifsv.application_id
 and fifs.id_flex_code=fifsv.id_flex_code
 and fifs.id_flex_num=fifsv.id_flex_num
 and fifs.application_id=fif.application_id
 and fifs.id_flex_code=fif.id_flex_code
 and fifs.application_id=fav2.application_id 
 and fifsv.enabled_flag = NVL('&active_only',fifsv.enabled_flag)
 and fifs.enabled_flag = NVL('&active_only',fifs.enabled_flag)  
 union
 select
  fdfcuv.flex_value_set_id,
  fav2.application_name usage_application,
  'Concurrent Program' usage_type,
  fcpv.user_concurrent_program_name usage_title,
  to_char(fdfcuv.column_seq_num) usage_context,
  fdfcuv.end_user_column_name usage_column_name,
  fdfcuv.form_left_prompt prompt
 from
  fnd_descr_flex_col_usage_vl fdfcuv,
  fnd_concurrent_programs_vl fcpv,
  fnd_application_vl fav2 
 where
     fdfcuv.application_id=fcpv.application_id
 and substr(fdfcuv.descriptive_flexfield_name,7)=fcpv.concurrent_program_name
 and fdfcuv.application_id=fav2.application_id 
 and fdfcuv.enabled_flag = NVL('&active_only',fdfcuv.enabled_flag)
 and fcpv.enabled_flag = NVL('&active_only',fcpv.enabled_flag)  
) ffvsu
where
    '&enable_usages'='Y'
and ffvs.flex_value_set_id = ffvsu.flex_value_set_id
and ffvs.flex_value_set_id=ffvt.flex_value_set_id(+)
and ffvt.table_application_id=fav.application_id(+)
and ffvs.parent_flex_value_set_id=ffvs2.flex_value_set_id(+)
) q
where
    1=1
and q.flex_value_set_name not like '$FLEX$.%'
order by
 q.flex_value_set_name
,case q.rectype
 when 'Value Set' then 1
 when 'Flex Value'  then  2
 else 3
 end
&ord_usages
&ord_values