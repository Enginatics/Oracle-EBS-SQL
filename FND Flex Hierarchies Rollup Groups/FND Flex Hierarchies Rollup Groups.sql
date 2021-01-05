/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Flex Hierarchies (Rollup Groups)
-- Description: Flex value sets with rollup groups
-- Excel Examle Output: https://www.enginatics.com/example/fnd-flex-hierarchies-rollup-groups/
-- Library Link: https://www.enginatics.com/reports/fnd-flex-hierarchies-rollup-groups/
-- Run Report: https://demo.enginatics.com/

select
ffvs.flex_value_set_name,
ffhv.hierarchy_code,
ffhv.hierarchy_name,
ffhv.description,
xxen_util.user_name(ffhv.created_by) created_by,
ffhv.creation_date,
xxen_util.user_name(ffhv.last_updated_by) last_updated_by,
ffhv.last_update_date,
ffvs.flex_value_set_id
from
fnd_flex_value_sets ffvs,
fnd_flex_hierarchies_vl ffhv
where
ffvs.flex_value_set_id=ffhv.flex_value_set_id
order by
ffvs.flex_value_set_name,
ffhv.hierarchy_code