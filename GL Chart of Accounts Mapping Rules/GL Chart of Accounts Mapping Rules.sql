/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Chart of Accounts Mapping Rules
-- Description: Lists the segment mapping rules and code combination mappings defined for a Global Consolidation System (GCS) chart of accounts mapping. Converted from the Oracle BI Publisher report 'Chart of Accounts - Mapping Rules (XML)' (GLXCOCRR_XML).
-- Excel Examle Output: https://www.enginatics.com/example/gl-chart-of-accounts-mapping-rules(1)/
-- Library Link: https://www.enginatics.com/reports/gl-chart-of-accounts-mapping-rules(1)/
-- Run Report: https://demo.enginatics.com/

select
gcm.name coa_mapping,
gcm.description coa_mapping_description,
fifsv_from.id_flex_structure_name from_chart_of_accounts,
fifsv_to.id_flex_structure_name to_chart_of_accounts,
gcm.start_date_active,
gcm.end_date_active,
x.rule_type,
x.segment_number,
x.target_segment,
x.segment_map_type,
x.source_segment,
x.source_value,
x.target_value,
x.target_parent_rollup_value,
x.source_range_from,
x.source_range_to,
x.from_code_combination_low,
x.from_code_combination_high,
x.to_code_combination,
xxen_util.user_name(x.last_updated_by) last_updated_by,
xxen_util.client_time(x.last_update_date) last_update_date
from
gl_coa_mappings gcm,
fnd_id_flex_structures_vl fifsv_from,
fnd_id_flex_structures_vl fifsv_to,
(
select
'Segment Rule' rule_type,
gcm.coa_mapping_id,
fsp.segment_num segment_number,
fsp.segment_name target_segment,
xxen_util.meaning(csm.segment_map_type,'SEGMENT_MAP_TYPE',101) segment_map_type,
fss.segment_name source_segment,
case csm.segment_map_type when 'S' then csm.single_value end source_value,
case csm.segment_map_type when 'C' then null when 'S' then null else csm.single_value end target_value,
csm.parent_rollup_value target_parent_rollup_value,
coalesce(gcfh.child_flex_value_low,ffvh.child_flex_value_low) source_range_from,
coalesce(gcfh.child_flex_value_high,ffvh.child_flex_value_high) source_range_to,
cast(null as varchar2(800)) from_code_combination_low,
cast(null as varchar2(800)) from_code_combination_high,
cast(null as varchar2(800)) to_code_combination,
csm.last_updated_by,
csm.last_update_date
from
gl_coa_mappings gcm,
fnd_id_flex_segments fsp,
gl_cons_segment_map csm,
fnd_id_flex_segments fss,
gl_cons_flex_hierarchies gcfh,
fnd_flex_value_hierarchies ffvh
where
1=1 and
fsp.application_id=101 and
fsp.id_flex_code='GL#' and
fsp.id_flex_num=gcm.to_coa_id and
fsp.enabled_flag='Y' and
csm.to_value_set_id(+)=fsp.flex_value_set_id and
csm.to_application_column_name(+)=fsp.application_column_name and
csm.coa_mapping_id(+)=gcm.coa_mapping_id and
fss.application_id(+)=101 and
fss.id_flex_code(+)='GL#' and
fss.id_flex_num(+)=gcm.from_coa_id and
fss.enabled_flag(+)='Y' and
fss.application_column_name(+)=csm.from_application_column_name and
gcfh.segment_map_id(+)=decode(csm.segment_map_type,'R',csm.segment_map_id,'U',csm.segment_map_id,-1) and
gcfh.parent_flex_value(+)=csm.single_value and
ffvh.flex_value_set_id(+)=decode(csm.segment_map_type,'P',csm.from_value_set_id,-1) and
ffvh.parent_flex_value(+)=csm.parent_rollup_value
union all
select
'Code Combination Rule' rule_type,
gcm.coa_mapping_id,
to_number(null) segment_number,
cast(null as varchar2(60)) target_segment,
cast(null as varchar2(80)) segment_map_type,
cast(null as varchar2(60)) source_segment,
cast(null as varchar2(25)) source_value,
cast(null as varchar2(25)) target_value,
cast(null as varchar2(25)) target_parent_rollup_value,
cast(null as varchar2(25)) source_range_from,
cast(null as varchar2(25)) source_range_to,
(select rtrim(
nvl2(cfm.segment1_low,cfm.segment1_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment2_low,cfm.segment2_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment3_low,cfm.segment3_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment4_low,cfm.segment4_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment5_low,cfm.segment5_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment6_low,cfm.segment6_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment7_low,cfm.segment7_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment8_low,cfm.segment8_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment9_low,cfm.segment9_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment10_low,cfm.segment10_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment11_low,cfm.segment11_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment12_low,cfm.segment12_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment13_low,cfm.segment13_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment14_low,cfm.segment14_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment15_low,cfm.segment15_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment16_low,cfm.segment16_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment17_low,cfm.segment17_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment18_low,cfm.segment18_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment19_low,cfm.segment19_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment20_low,cfm.segment20_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment21_low,cfm.segment21_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment22_low,cfm.segment22_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment23_low,cfm.segment23_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment24_low,cfm.segment24_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment25_low,cfm.segment25_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment26_low,cfm.segment26_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment27_low,cfm.segment27_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment28_low,cfm.segment28_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment29_low,cfm.segment29_low||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment30_low,cfm.segment30_low||fifsv2.concatenated_segment_delimiter,null),
fifsv2.concatenated_segment_delimiter)
from fnd_id_flex_structures_vl fifsv2
where fifsv2.application_id=101 and fifsv2.id_flex_code='GL#' and fifsv2.id_flex_num=gcm.from_coa_id) from_code_combination_low,
(select rtrim(
nvl2(cfm.segment1_high,cfm.segment1_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment2_high,cfm.segment2_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment3_high,cfm.segment3_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment4_high,cfm.segment4_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment5_high,cfm.segment5_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment6_high,cfm.segment6_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment7_high,cfm.segment7_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment8_high,cfm.segment8_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment9_high,cfm.segment9_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment10_high,cfm.segment10_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment11_high,cfm.segment11_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment12_high,cfm.segment12_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment13_high,cfm.segment13_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment14_high,cfm.segment14_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment15_high,cfm.segment15_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment16_high,cfm.segment16_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment17_high,cfm.segment17_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment18_high,cfm.segment18_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment19_high,cfm.segment19_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment20_high,cfm.segment20_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment21_high,cfm.segment21_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment22_high,cfm.segment22_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment23_high,cfm.segment23_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment24_high,cfm.segment24_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment25_high,cfm.segment25_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment26_high,cfm.segment26_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment27_high,cfm.segment27_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment28_high,cfm.segment28_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment29_high,cfm.segment29_high||fifsv2.concatenated_segment_delimiter,null)||
nvl2(cfm.segment30_high,cfm.segment30_high||fifsv2.concatenated_segment_delimiter,null),
fifsv2.concatenated_segment_delimiter)
from fnd_id_flex_structures_vl fifsv2
where fifsv2.application_id=101 and fifsv2.id_flex_code='GL#' and fifsv2.id_flex_num=gcm.from_coa_id) from_code_combination_high,
gcck.concatenated_segments to_code_combination,
cfm.last_updated_by,
cfm.last_update_date
from
gl_coa_mappings gcm,
gl_cons_flexfield_map cfm,
gl_code_combinations_kfv gcck
where
2=2 and
gcm.coa_mapping_id=cfm.coa_mapping_id and
cfm.to_code_combination_id=gcck.code_combination_id and
gcck.enabled_flag='Y'
) x
where
gcm.coa_mapping_id=x.coa_mapping_id and
gcm.from_coa_id=fifsv_from.id_flex_num and
fifsv_from.application_id=101 and
fifsv_from.id_flex_code='GL#' and
gcm.to_coa_id=fifsv_to.id_flex_num and
fifsv_to.application_id=101 and
fifsv_to.id_flex_code='GL#'
order by
gcm.name,
case x.rule_type when 'Segment Rule' then 1 else 2 end,
x.segment_number,
x.source_segment,
x.target_value,
x.target_parent_rollup_value,
x.source_range_from,
x.source_range_to,
x.to_code_combination