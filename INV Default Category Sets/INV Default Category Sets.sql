/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Default Category Sets
-- Description: Master data report that lists Inventory functional areas and their default category sets
-- Excel Examle Output: https://www.enginatics.com/example/inv-default-category-sets/
-- Library Link: https://www.enginatics.com/reports/inv-default-category-sets/
-- Run Report: https://demo.enginatics.com/

select
xxen_util.meaning(mdcs.functional_area_id,'MTL_FUNCTIONAL_AREAS',700) functional_area,
mcsv.category_set_name,
mdcs.functional_area_id,
mcsv.category_set_id
from
mtl_default_category_sets mdcs,
mtl_category_sets_v mcsv
where
mdcs.category_set_id=mcsv.category_set_id
order by
mdcs.functional_area_id