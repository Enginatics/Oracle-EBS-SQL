/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Physical Inventory Tags
-- Description: Imported from BI Publisher
Description: Physical Inventory Tags
Application: Inventory
Source: Physical Inventory Tags (XML)
Short Name: INVARPTP_XML
DB package: INV_INVARPTP_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-physical-inventory-tags/
-- Library Link: https://www.enginatics.com/reports/inv-physical-inventory-tags/
-- Run Report: https://demo.enginatics.com/

select
x.organization_code,
x.organization_name,
x.physical_inventory,
x.tag,
x.item,
x.description,
x.primary_uom,
x.revision,
x.subinventory,
x.locator,
x.lot_number,
x.serial_number,
x.parent_lpn,
x.outermost_lpn,
x.cost_group
from
(
select
 mpi.physical_inventory_name physical_inventory,
 mp.organization_code organization_code,
 hou.name organization_name,
 mpit.tag_number tag,
 mpit.inventory_item_id item_id,
 null description,
 mpit.revision revision,
 null primary_uom,
 mpit.subinventory subinventory,
 mpit.locator_id locator_id,
 mpit.lot_number lot_number,
 mpit.serial_num serial_number,
 mpit.parent_lpn_id,
 mpit.outermost_lpn_id,
 mpit.cost_group_id,
 null item,
 null locator,
 decode(:p_wms_installed,'TRUE',inv_invarptp_xmlp_pkg.cf_parent_lpnformula(mpit.parent_lpn_id),null) parent_lpn,
 decode(:p_wms_installed,'TRUE',inv_invarptp_xmlp_pkg.cf_outermost_lpnformula(mpit.outermost_lpn_id,mpit.parent_lpn_id),null) outermost_lpn,
 decode(:p_wms_installed,'TRUE',inv_invarptp_xmlp_pkg.cf_cost_groupformula(mpit.cost_group_id),null) cost_group
from
 mtl_parameters mp,
 mtl_physical_inventories mpi,
 hr_organization_units hou,
 mtl_physical_inventory_tags mpit
where
 1=1 and
 mp.organization_id = mpit.organization_id and
 hou.organization_id = mp.organization_id and
 mpit.physical_inventory_id = mpi.physical_inventory_id and
 mpit.inventory_item_id is null and
 :p_item_lo || :p_item_high is null and
 :p_loc_lo || :p_loc_hi is null
union
select
 mpi.physical_inventory_name physical_inventory,
 mp.organization_code organization_code,
 hou.name organization_name,
 mpit.tag_number tag,
 mpit.inventory_item_id item_id,
 msi.description description,
 mpit.revision revision,
 msi.primary_uom_code primary_uom,
 mpit.subinventory subinventory,
 mpit.locator_id locator_id,
 mpit.lot_number lot_number,
 mpit.serial_num serial_number,
 mpit.parent_lpn_id,
 mpit.outermost_lpn_id,
 mpit.cost_group_id,
 msi.concatenated_segments item,
 mil.concatenated_segments locator,
 decode(:p_wms_installed,'TRUE',inv_invarptp_xmlp_pkg.cf_parent_lpnformula(mpit.parent_lpn_id),null) parent_lpn,
 decode(:p_wms_installed,'TRUE',inv_invarptp_xmlp_pkg.cf_outermost_lpnformula(mpit.outermost_lpn_id,mpit.parent_lpn_id),null) outermost_lpn,
 decode(:p_wms_installed,'TRUE',inv_invarptp_xmlp_pkg.cf_cost_groupformula(mpit.cost_group_id),null) cost_group
from
 mtl_system_items_vl msi,
 mtl_item_locations_kfv mil,
 mtl_parameters mp,
 mtl_physical_inventories mpi,
 hr_organization_units hou,
 mtl_physical_inventory_tags mpit
where
 1=1 and
 2=2 and
 msi.inventory_item_id = mpit.inventory_item_id and
 msi.organization_id = mpit.organization_id and
 mp.organization_id = msi.organization_id and
 hou.organization_id = mp.organization_id and
 mil.inventory_location_id (+)= mpit.locator_id and
 mil.organization_id (+)=  mpit.organization_id and
 mpit.physical_inventory_id = mpi.physical_inventory_id
) x
order by
&lp_order_by