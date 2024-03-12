/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Rollup Groups
-- Description: Flex value sets with rollup groups (FND Flex Hierarchies)
-- Excel Examle Output: https://www.enginatics.com/example/gl-rollup-groups/
-- Library Link: https://www.enginatics.com/reports/gl-rollup-groups/
-- Run Report: https://demo.enginatics.com/

select
ffvs.flex_value_set_name,
ffhv.hierarchy_code,
ffhv.hierarchy_name,
ffhv.description,
xxen_util.user_name(ffhv.created_by) created_by,
xxen_util.client_time(ffhv.creation_date) creation_date,
xxen_util.user_name(ffhv.last_updated_by) last_updated_by,
xxen_util.client_time(ffhv.last_update_date) last_update_date,
ffvs.flex_value_set_id
from
fnd_flex_value_sets ffvs,
fnd_flex_hierarchies_vl ffhv
where
ffvs.flex_value_set_id=ffhv.flex_value_set_id
order by
ffvs.flex_value_set_name,
ffhv.hierarchy_name