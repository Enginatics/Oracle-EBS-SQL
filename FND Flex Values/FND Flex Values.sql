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
ffvv.parent_flex_value_low independent_value,
ffvv.flex_value,
ffvv.flex_value_meaning translated_value,
ffvv.description,
xxen_util.meaning(decode(ffvv.enabled_flag,'Y','Y'),'YES_NO',0) enabled,
ffvv.start_date_active,
ffvv.end_date_active,
xxen_util.meaning(decode(ffvv.summary_flag,'Y','Y'),'YES_NO',0) parent,
ffhv.hierarchy_name rollup_group,
ffvv.hierarchy_level,
(select distinct listagg(ffvnh.parent_flex_value,', ') within group (order by ffvnh.parent_flex_value) over () from fnd_flex_value_norm_hierarchy ffvnh where 2=2 and ffvv.summary_flag=decode(ffvnh.range_attribute,'P','Y','N') and ffvv.flex_value between ffvnh.child_flex_value_low and ffvnh.child_flex_value_high and ffvs.flex_value_set_id=ffvnh.flex_value_set_id) parent_values,
&value_attributes
ffvv.compiled_value_attributes,
xxen_util.user_name(ffvv.created_by) created_by,
xxen_util.client_time(ffvv.creation_date) creation_date,
xxen_util.user_name(ffvv.last_updated_by) last_updated_by,
xxen_util.client_time(ffvv.last_update_date) last_update_date
from
fnd_flex_value_sets ffvs,
fnd_flex_values_vl ffvv,
fnd_flex_hierarchies_vl ffhv
where
1=1 and
ffvs.flex_value_set_id=ffvv.flex_value_set_id and
ffvv.structured_hierarchy_level=ffhv.hierarchy_id(+)
order by
ffvs.flex_value_set_name,
ffvv.parent_flex_value_low,
ffvv.flex_value