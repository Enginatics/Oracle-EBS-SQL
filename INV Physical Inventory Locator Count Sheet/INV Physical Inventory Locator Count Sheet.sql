/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Physical Inventory Locator Count Sheet
-- Description: Count sheet listing every active stock locator of the quantity tracked subinventories, as an alternative to printed physical inventory tags.
-- One row per item, revision, lot and LPN on hand in the locator. A locator without on hand stock is listed once with a blank item, so counters can record stock found in locations the system considers empty.
-- On hand held in project and task logical locators is shown against its physical locator, with the project and task.
-- System Quantity is the live on hand at run time, not the physical inventory snapshot. Leave Show System Quantity empty for a blind count.
-- Count Quantity, Counted By and Count Comments are blank for entry. Counts can be loaded with INV Physical Inventory Tag Count Upload with a blank tag number, which requires a physical inventory allowing dynamic tags.
-- Excel Example Output: https://www.enginatics.com/example/inv-physical-inventory-locator-count-sheet/
-- Library Link: https://www.enginatics.com/reports/inv-physical-inventory-locator-count-sheet/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
milk.subinventory_code subinventory,
milk.concatenated_segments locator,
milk.description locator_description,
mmsv.status_code locator_status,
pjm_project.all_proj_idtonum(mil.project_id) project,
pjm_project.all_task_idtonum(mil.task_id) task,
msiv.concatenated_segments item,
msiv.description item_description,
moqd.revision,
moqd.lot_number,
mln.expiration_date lot_expiration_date,
wlpn.license_plate_number lpn,
xxen_util.yes(case when msiv.serial_number_control_code in (2,5) then 'Y' end) serial_controlled,
msiv.primary_uom_code uom,
&system_quantity
to_number(null) count_quantity,
null counted_by,
null count_comments
from
mtl_parameters mp,
mtl_secondary_inventories msi,
mtl_item_locations_kfv milk,
mtl_material_statuses_vl mmsv,
mtl_item_locations mil,
mtl_onhand_quantities_detail moqd,
mtl_system_items_vl msiv,
mtl_lot_numbers mln,
wms_license_plate_numbers wlpn
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=msi.organization_id and
msi.quantity_tracked=1 and
nvl(msi.disable_date,sysdate)>=sysdate and
msi.organization_id=milk.organization_id and
msi.secondary_inventory_name=milk.subinventory_code and
nvl(milk.physical_location_id,milk.inventory_location_id)=milk.inventory_location_id and
nvl(milk.disable_date,sysdate)>=sysdate and
milk.status_id=mmsv.status_id(+) and
milk.organization_id=mil.organization_id(+) and
milk.inventory_location_id=nvl(mil.physical_location_id(+),mil.inventory_location_id(+)) and
mil.organization_id=moqd.organization_id(+) and
mil.inventory_location_id=moqd.locator_id(+) and
moqd.organization_id=msiv.organization_id(+) and
moqd.inventory_item_id=msiv.inventory_item_id(+) and
moqd.organization_id=mln.organization_id(+) and
moqd.inventory_item_id=mln.inventory_item_id(+) and
moqd.lot_number=mln.lot_number(+) and
moqd.lpn_id=wlpn.lpn_id(+)
group by
mp.organization_code,
milk.subinventory_code,
milk.concatenated_segments,
milk.description,
mmsv.status_code,
mil.project_id,
mil.task_id,
msiv.concatenated_segments,
msiv.description,
moqd.revision,
moqd.lot_number,
mln.expiration_date,
wlpn.license_plate_number,
msiv.serial_number_control_code,
msiv.primary_uom_code
order by
mp.organization_code,
milk.subinventory_code,
milk.concatenated_segments,
msiv.concatenated_segments,
moqd.revision,
moqd.lot_number,
wlpn.license_plate_number
