/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Default Transaction Locators
-- Description: Master data report of Inventory Items and the default locators for shipping, receiving or move order receipt transactions
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-default-transaction-locators/
-- Library Link: https://www.enginatics.com/reports/inv-item-default-transaction-locators/
-- Run Report: https://demo.enginatics.com/

select
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
xxen_util.meaning(mild.default_type,'MTL_DEFAULT_LOCATORS',700) default_type,
milk.subinventory_code subinventory,
nvl(inv_project.get_locator(milk.inventory_location_id,milk.organization_id),milk.concatenated_segments) locator,
milk.description locator_description,
mp.organization_code,
haouv.name organization,
xxen_util.user_name(mild.created_by) created_by,
xxen_util.client_time(mild.creation_date) creation_date,
xxen_util.user_name(mild.last_updated_by) last_updated_by,
xxen_util.client_time(mild.last_update_date) last_update_date
from
hr_all_organization_units_vl haouv,
mtl_parameters mp,
mtl_item_loc_defaults mild,
mtl_system_items_vl msiv,
mtl_item_locations_kfv milk
where
1=1 and
mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
haouv.organization_id=mild.organization_id and
mp.organization_id=mild.organization_id and
mild.inventory_item_id=msiv.inventory_item_id and
mild.organization_id=msiv.organization_id and
mild.organization_id=milk.organization_id and
mild.locator_id=milk.inventory_location_id
order by
msiv.concatenated_segments,
mp.organization_code,
default_type