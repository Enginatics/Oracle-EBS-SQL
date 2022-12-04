/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Category Sets
-- Description: None
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-category-sets/
-- Library Link: https://www.enginatics.com/reports/inv-item-category-sets/
-- Run Report: https://demo.enginatics.com/

select
mcsv.category_set_name,
mcsv.description,
mcsv.structure_name flex_structure,
mcsv.control_level_disp,
(select mcbk.concatenated_segments from mtl_categories_b_kfv mcbk where mcsv.default_category_id=mcbk.category_id) default_category,
xxen_util.meaning(decode(mcsv.validate_flag,'Y','Y'),'YES_NO',0) enforce_valid_categories,
(select count(*) from mtl_category_set_valid_cats mcsvc where mcsv.category_set_id=mcsvc.category_set_id) valid_categories_count,
(select count(*) from mtl_categories_b mcb where mcsv.structure_id=mcb.structure_id) mcb_count
from
mtl_category_sets_v mcsv
where
1=1
order by
mcsv.category_set_name