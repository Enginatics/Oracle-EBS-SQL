/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Category Assignment
-- Description: Imported from BI Publisher
Description: Item categories report
Application: Inventory
Source: Item categories report (XML)
Short Name: INVIRCAT_XML
DB package: INV_INVIRCAT_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-category-assignment/
-- Library Link: https://www.enginatics.com/reports/inv-item-category-assignment/
-- Run Report: https://demo.enginatics.com/

select
x.*,
case
when x.cat_set_control_level = xxen_util.meaning(1,'ITEM_CONTROL_LEVEL_GUI',700)
and  x.multi_item_cat_assign_allowed is null
and  x.mast_cat_set_item_assign_count > 1
then xxen_util.meaning('Y','YES_NO',0)
else null
end cat_set_control_level_violated
from
(
select
 mcsv.category_set_name category_set_name,
 mcsv.description category_set_description,
 msiv.concatenated_segments item,
 msiv.description item_description,
 mp2.organization_code master_organization,
 mp.organization_code organization,
 mck.concatenated_segments category,
 mck.description category_description,
 --
 mcsv.structure_name cat_set_flex_structure,
 mcsv.control_level_disp cat_set_control_level,
 (select mck2.concatenated_segments from mtl_categories_kfv mck2 where mck2.category_id = mcsv.default_category_id) cat_set_default_category,
 xxen_util.meaning(decode(mcsv.validate_flag,'Y','Y'),'YES_NO',0) enforce_valid_categories,
 xxen_util.meaning(decode(mcsv.mult_item_cat_assign_flag,'Y','Y'),'YES_NO',0) multi_item_cat_assign_allowed,
 (select count(*) from mtl_category_set_valid_cats mcsvc where mcsv.category_set_id = mcsvc.category_set_id) cat_set_valid_category_count,
 (select count(*) from mtl_categories_b mcb where mcsv.structure_id = mcb.structure_id) cat_set_category_count,
 --
 (select
   count(distinct mic2.category_id)
  from
   mtl_parameters mp2,
   mtl_item_categories mic2,
   mtl_system_items_b msib
  where
   mp2.master_organization_id = mp.master_organization_id and
   mic2.organization_id = mp2.organization_id and
   mic2.category_set_id = mcsv.category_set_id and
   mic2.inventory_item_id = msiv.inventory_item_id and
   msib.organization_id = mic2.organization_id and
   msib.inventory_item_id = mic2.inventory_item_id
  ) mast_cat_set_item_assign_count
from
 mtl_parameters mp,
 mtl_parameters mp2,
 mtl_system_items_vl msiv,
 mtl_category_sets_v mcsv,
 mtl_categories_kfv mck,
 mtl_item_categories mic
where
 1=1 and
 mic.organization_id = mp.organization_id and
 mp.master_organization_id = mp2.organization_id and
 mic.category_id = mck.category_id and
 mic.category_set_id = mcsv.category_set_id and
 msiv.organization_id = mic.organization_id and
 mic.inventory_item_id = msiv.inventory_item_id
) x
where
2=2
order by
 x.category_set_name,
 x.item,
 x.master_organization,
 x.organization,
 x.category