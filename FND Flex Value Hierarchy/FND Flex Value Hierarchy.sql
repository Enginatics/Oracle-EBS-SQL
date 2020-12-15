/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Flex Value Hierarchy
-- Description: Flexfield value hierarchy showing a hierarchical tree of parent and child relations and child ranges.
Parameter 'Parents without Child only' can be used to validate the hierarchy for nodes where the child range does not include a single child value.

The query is based on a treewalk through table fnd_flex_value_norm_hierarchy, which contains one record for every parent node, and a range_attribute column to indicate if the child value low/high range should match either parent nodes or child values.

Where table fnd_flex_value_norm_hierarchy contains one record for each hierarchy node, table fnd_flex_value_hierarchies shows a flat representation of all hierarchy nodes and their lowest child ranges (range_attribute=C). For any lowest child range value, it contains one record for every higher hierarchy, that this child range is included in, up to the topmost hierarchy node. It can be used for example to validate directly, if a child value is included in a top level hierarchy node.

For GL flex value hierarchies, there are additional tables gl_seg_val_norm_hierarchy and gl_seg_val_hierarchies, which store one record for each matching child value for parent nodes, instead of just the range.
These tables are updated automatically after each flex value hierarchy change by concurrent 'General Ledger Accounting Setup Program' (GLSTFL).
gl_seg_val_norm_hierarchy stores one record for every child and their direct parent.
gl_seg_val_hierarchies stores one record for every node in the hierarchy (regardless if child or parent) and all their parent records, regardless on which level. It can be used for example to directly find all childs of one parent node.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-flex-value-hierarchy/
-- Library Link: https://www.enginatics.com/reports/fnd-flex-value-hierarchy/
-- Run Report: https://demo.enginatics.com/

select
lpad(' ',2*(level-1))||level level_,
lpad(' ',2*(level-1))||ffvnh.parent_flex_value value,
ffvv.description,
xxen_util.meaning(ffvnh.range_attribute,'RANGE_ATTRIBUTE',0) range_attribute,
ffvnh.child_flex_value_low,
ffvnh.child_flex_value_high,
xxen_util.meaning(connect_by_isleaf,'SYS_YES_NO',700) is_leaf,
connect_by_root ffvnh.parent_flex_value root_value,
substr(sys_connect_by_path(ffvnh.parent_flex_value,'-> '),4) path,
ffvnh.parent_flex_value value_flat,
&value_attributes
ffvv.compiled_value_attributes,
xxen_util.user_name(ffvnh.created_by) created_by,
xxen_util.client_time(ffvnh.creation_date) creation_date,
xxen_util.user_name(ffvnh.last_updated_by) last_updated_by,
xxen_util.client_time(ffvnh.last_update_date) last_update_date,
ffvnh.flex_value_set_id
from
(
select
ffvnh.parent_flex_value,
ffvnh.child_flex_value_low,
ffvnh.child_flex_value_high,
ffvnh.range_attribute,
ffvnh.flex_value_set_id,
ffvnh.created_by,
ffvnh.creation_date,
ffvnh.last_updated_by,
ffvnh.last_update_date
from
fnd_flex_value_norm_hierarchy ffvnh
where
ffvnh.flex_value_set_id=(select ffvs.flex_value_set_id from fnd_flex_value_sets ffvs where ffvs.flex_value_set_name=:flex_value_set_name)
union all
select
ffv2.flex_value parent_flex_value,
null child_flex_value_low,
null child_flex_value_high,
'x' range_attribute,
ffv2.flex_value_set_id,
ffv2.created_by,
ffv2.creation_date,
ffv2.last_updated_by,
ffv2.last_update_date
from
fnd_flex_values ffv2
where
(:show_child_values='Y' or :parents_without_child is not null) and
2=2 and
ffv2.summary_flag='N' and
ffv2.flex_value_set_id=(select ffvs.flex_value_set_id from fnd_flex_value_sets ffvs where ffvs.flex_value_set_name=:flex_value_set_name)
) ffvnh,
fnd_flex_values_vl ffvv
where
3=3 and
ffvnh.parent_flex_value=ffvv.flex_value and
ffvnh.flex_value_set_id=ffvv.flex_value_set_id
connect by nocycle
ffvnh.parent_flex_value between prior ffvnh.child_flex_value_low and prior ffvnh.child_flex_value_high and
decode(nvl(prior ffvnh.range_attribute,'P'),'P','Y','N')=ffvv.summary_flag
start with
1=1 and
(:parent_flex_value is not null or
not exists (select null from
fnd_flex_value_norm_hierarchy ffvnh0
where
ffvnh0.flex_value_set_id=(select ffvs.flex_value_set_id from fnd_flex_value_sets ffvs where ffvs.flex_value_set_name=:flex_value_set_name) and
ffvnh.parent_flex_value between ffvnh0.child_flex_value_low and ffvnh0.child_flex_value_high and
ffvv.summary_flag=decode(ffvnh0.range_attribute,'P','Y','N')
)
)