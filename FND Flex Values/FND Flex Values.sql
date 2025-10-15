/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Flex Values
-- Description: Report for all flex values and the hierarchies they are included in.
Column 'Hierarchy Position' can be used to validate your account hierarchy setup and check which account segment values are not included in any (or a specific) hierarchy yet.

In EBS R12.2., there is new flexfield value security in place, which would require the UMX|FND_FLEX_VSET_ALL_PRIVS_ROLE role to maintain flexfield values.
If you do not have this role but apps DB access, you can add it from the backend:

begin
  wf_local_synch.propagateuserrole(
  p_user_name=>'ANDY.HAACK',
  p_role_name=>'UMX|FND_FLEX_VSET_ALL_PRIVS_ROLE'
  );
  commit;
end;
-- Excel Examle Output: https://www.enginatics.com/example/fnd-flex-values/
-- Library Link: https://www.enginatics.com/reports/fnd-flex-values/
-- Run Report: https://demo.enginatics.com/

select
ffvs.flex_value_set_name,
xxen_util.meaning(ffvs.validation_type,'SEG_VAL_TYPES',0) validation_type,
ffvs0.flex_value_set_name parent_flex_value_set,
ffv.parent_flex_value_low independent_value,
ffv.flex_value,
ffvt.flex_value_meaning translated_value,
ffvt.description,
xxen_util.yes(ffv.enabled_flag) enabled,
ffv.start_date_active,
ffv.end_date_active,
xxen_util.yes(ffv.summary_flag) parent,
ffvnh.child_flex_value_low||nvl2(ffvnh.child_flex_value_low,'-',null)||ffvnh.child_flex_value_high child_range,
xxen_util.meaning(ffvnh.range_attribute,'RANGE_ATTRIBUTE',0) range_attribute,
ffhv.hierarchy_name rollup_group,
ffv.hierarchy_level,
(select distinct listagg(ffvnh.parent_flex_value,', ') within group (order by ffvnh.parent_flex_value) over () from fnd_flex_value_norm_hierarchy ffvnh where 2=2 and ffv.summary_flag=decode(ffvnh.range_attribute,'P','Y','N') and ffv.flex_value between ffvnh.child_flex_value_low and ffvnh.child_flex_value_high and ffvs.flex_value_set_id=ffvnh.flex_value_set_id) parent_values,
&value_attributes
ffv.compiled_value_attributes,
&dff_columns
xxen_util.user_name(ffv.created_by) created_by,
xxen_util.client_time(ffv.creation_date) creation_date,
xxen_util.user_name(ffv.last_updated_by) last_updated_by,
xxen_util.client_time(ffv.last_update_date) last_update_date,
ffv.flex_value_set_id
from
fnd_flex_value_sets ffvs,
fnd_flex_value_sets ffvs0,
fnd_flex_values ffv,
fnd_flex_values_tl ffvt,
fnd_flex_hierarchies_vl ffhv,
fnd_flex_value_norm_hierarchy ffvnh
where
1=1 and
ffvs.parent_flex_value_set_id=ffvs0.flex_value_set_id(+) and
ffvs.flex_value_set_id=ffv.flex_value_set_id and
ffv.flex_value_id=ffvt.flex_value_id and
ffvt.language=userenv('lang') and
ffv.structured_hierarchy_level=ffhv.hierarchy_id(+) and
ffv.flex_value_set_id=ffvnh.flex_value_set_id(+) and
ffv.flex_value=ffvnh.parent_flex_value(+)
order by
ffvs.flex_value_set_name,
ffv.parent_flex_value_low,
ffv.flex_value,
ffvnh.child_flex_value_low