/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Flex Values
-- Description: Report for all flex values and the hierarchies they are included in.
Column 'Hierarchy Position' can be used to validate your account hierarchy setup and check which account segment values are not included in any (or a specific) hierarchy yet.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-flex-values/
-- Library Link: https://www.enginatics.com/reports/fnd-flex-values/
-- Run Report: https://demo.enginatics.com/

select
ffvs.flex_value_set_name,
xxen_util.meaning(ffvs.validation_type,'SEG_VAL_TYPES',0) validation_type,
ffvs0.flex_value_set_name parent_flex_value_set,
ffvv.parent_flex_value_low independent_value,
ffvv.flex_value,
ffvv.flex_value_meaning translated_value,
ffvv.description,
xxen_util.yes(ffvv.enabled_flag) enabled,
ffvv.start_date_active,
ffvv.end_date_active,
xxen_util.yes(ffvv.summary_flag) parent,
ffvnh.child_flex_value_low||nvl2(ffvnh.child_flex_value_low,'-',null)||ffvnh.child_flex_value_high child_range,
xxen_util.meaning(ffvnh.range_attribute,'RANGE_ATTRIBUTE',0) range_attribute,
ffhv.hierarchy_name rollup_group,
ffvv.hierarchy_level,
(select distinct listagg(ffvnh.parent_flex_value,', ') within group (order by ffvnh.parent_flex_value) over () from fnd_flex_value_norm_hierarchy ffvnh where 2=2 and ffvv.summary_flag=decode(ffvnh.range_attribute,'P','Y','N') and ffvv.flex_value between ffvnh.child_flex_value_low and ffvnh.child_flex_value_high and ffvs.flex_value_set_id=ffvnh.flex_value_set_id) parent_values,
&value_attributes
ffvv.compiled_value_attributes,
&dff_columns
xxen_util.user_name(ffvv.created_by) created_by,
xxen_util.client_time(ffvv.creation_date) creation_date,
xxen_util.user_name(ffvv.last_updated_by) last_updated_by,
xxen_util.client_time(ffvv.last_update_date) last_update_date,
ffvv.flex_value_set_id
from
fnd_flex_value_sets ffvs,
fnd_flex_value_sets ffvs0,
fnd_flex_values_vl ffvv,
fnd_flex_hierarchies_vl ffhv,
fnd_flex_value_norm_hierarchy ffvnh
where
1=1 and
ffvs.parent_flex_value_set_id=ffvs0.flex_value_set_id(+) and
ffvs.flex_value_set_id=ffvv.flex_value_set_id and
ffvv.structured_hierarchy_level=ffhv.hierarchy_id(+) and
ffvv.flex_value_set_id=ffvnh.flex_value_set_id(+) and
ffvv.flex_value=ffvnh.parent_flex_value(+)
order by
ffvs.flex_value_set_name,
ffvv.parent_flex_value_low,
ffvv.flex_value,
ffvnh.child_flex_value_low