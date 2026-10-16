/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Catalog Descriptive Elements
-- Description: Report showing item catalog group descriptive elements with their values, descriptions, required and default flags
-- Excel Example Output: https://www.enginatics.com/example/inv-item-catalog-descriptive-elements/
-- Library Link: https://www.enginatics.com/reports/inv-item-catalog-descriptive-elements/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code organization,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
(select misv.inventory_item_status_code_tl from mtl_item_status_vl misv where msiv.inventory_item_status_code=misv.inventory_item_status_code) item_status,
micgbk.concatenated_segments catalog_group,
micg.description catalog_description,
xxen_util.meaning(msiv.catalog_status_flag,'YES_NO',0) catalog_complete,
mde.element_sequence,
mde.element_name,
mdev.element_value,
mde.description element_description,
xxen_util.meaning(mde.required_element_flag,'YES_NO',0) required,
xxen_util.meaning(mdev.default_element_flag,'YES_NO',0) default_value
from
mtl_descr_element_values mdev,
mtl_system_items_vl msiv,
mtl_parameters mp,
mtl_item_catalog_groups_b_kfv micgbk,
mtl_item_catalog_groups micg,
mtl_descriptive_elements mde
where
mdev.inventory_item_id=msiv.inventory_item_id and
msiv.organization_id=mp.organization_id and
msiv.item_catalog_group_id=micgbk.item_catalog_group_id and
mde.item_catalog_group_id=micgbk.item_catalog_group_id and
micg.item_catalog_group_id=micgbk.item_catalog_group_id and
mdev.element_name=mde.element_name and
1=1
order by
mp.organization_code,
msiv.concatenated_segments,
mde.element_sequence
