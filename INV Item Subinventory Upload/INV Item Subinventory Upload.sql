/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Subinventory Upload
-- Description: Create, update and delete item-to-subinventory assignments (plus their optional item-subinventory-locator ties) across accessible inventory organizations.

Each row is one (Organization, Item, Subinventory, Locator?) combination. When the Locator column is blank, only the item-subinventory header is processed. When the Locator column is populated, the item-subinventory header (if not already processed in this run) AND the locator tie are processed. When multiple rows share the same Organization/Item/Subinventory triple, the header is processed only on the first row of the triple (siblings contribute only their locator portion); header cells on subsequent rows are silently ignored. Order data by Organization, Item, Subinventory, Locator to make sibling grouping deterministic.

Subinventory selection is restricted to Storage subinventories (Receiving subinventories cannot hold item assignments).

Download Locator Assignments controls whether the template pulls in existing locator ties. Choose Yes (the default) to see the current locator ties alongside each item-subinventory assignment. Leave blank to suppress them — useful when you only want to update item-subinventory header data without duplicated rows for each existing locator.

Min-Max Planning is a Yes/No flag matching the form's Min-Max checkbox: Yes enables Min-Max planning (and makes Min Qty / Max Qty required); blank means Not Planned. This choice is independent of the subinventory's own planning level.

PAR Level is only meaningful when the parent Subinventory has PAR Level planning enabled. If the Subinventory is not PAR-enabled, any PAR Level value supplied on the row is silently ignored on create, and any legacy stored value is cleared on update.

Source Type drives the conditional requirement on Source Organization and Source Subinventory. Inventory and Subinventory source types require Source Organization; Subinventory source type additionally restricts Source Organization to the row's own organization (same-org self-sourcing only). Supplier and blank source types must leave both source fields blank.

Delete Option lets you specify what to delete. Choose Subinventory to delete the item-subinventory assignment (cascades to all locator ties for that item-subinventory). Choose Locator to delete just the locator assignment on this row (only offered when Locator is populated). Once a row deletes an item-subinventory, any subsequent rows for the same Organization/Item/Subinventory triple are rejected with a clear error to prevent orphaned inserts on the deleted parent.

Organization, Item, Subinventory and Locator are read-only on existing rows — to change a key column, delete the row and create a new one.

Stock locators referenced here must already exist in the chosen Subinventory (use the INV Stock Locator Upload to create them).
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-subinventory-upload/
-- Library Link: https://www.enginatics.com/reports/inv-item-subinventory-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
null modified_columns_,
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
msiv.primary_uom_code uom,
misi.secondary_inventory subinventory,
msec.description subinventory_description,
decode(misi.inventory_planning_code,2,xxen_util.meaning('Y','YES_NO',0)) min_max_planning,
misi.min_minmax_quantity,
misi.max_minmax_quantity,
misi.fixed_lot_multiple,
misi.minimum_order_quantity,
misi.maximum_order_quantity,
xxen_util.meaning(to_char(misi.source_type),'MTL_SOURCE_TYPES',700) source_type,
mp_src.organization_code source_organization,
misi.source_subinventory,
misi.preprocessing_lead_time,
misi.processing_lead_time,
misi.postprocessing_lead_time,
xxen_util.display_flexfield_context(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category) item_sub_attribute_category,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE1',misi.rowid,misi.attribute1) item_sub_attribute1,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE2',misi.rowid,misi.attribute2) item_sub_attribute2,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE3',misi.rowid,misi.attribute3) item_sub_attribute3,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE4',misi.rowid,misi.attribute4) item_sub_attribute4,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE5',misi.rowid,misi.attribute5) item_sub_attribute5,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE6',misi.rowid,misi.attribute6) item_sub_attribute6,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE7',misi.rowid,misi.attribute7) item_sub_attribute7,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE8',misi.rowid,misi.attribute8) item_sub_attribute8,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE9',misi.rowid,misi.attribute9) item_sub_attribute9,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE10',misi.rowid,misi.attribute10) item_sub_attribute10,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE11',misi.rowid,misi.attribute11) item_sub_attribute11,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE12',misi.rowid,misi.attribute12) item_sub_attribute12,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE13',misi.rowid,misi.attribute13) item_sub_attribute13,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE14',misi.rowid,misi.attribute14) item_sub_attribute14,
xxen_util.display_flexfield_value(401,'MTL_ITEM_SUB_INVENTORIES',misi.attribute_category,'ATTRIBUTE15',misi.rowid,misi.attribute15) item_sub_attribute15,
milk.concatenated_segments locator,
milk.description locator_description,
msl.maximum_quantity par_level,
to_char(null) delete_option,
to_number(null) upload_row
from
mtl_item_sub_inventories misi,
mtl_parameters mp,
mtl_system_items_vl msiv,
mtl_secondary_inventories msec,
mtl_parameters mp_src,
(select msl.* from mtl_secondary_locators msl where nvl(:p_download_locators,'N')='Y') msl,
mtl_item_locations_kfv milk
where
1=1 and
mp.organization_id=misi.organization_id and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
msiv.inventory_item_id=misi.inventory_item_id and
msiv.organization_id=misi.organization_id and
msec.organization_id=misi.organization_id and
msec.secondary_inventory_name=misi.secondary_inventory and
mp_src.organization_id(+)=misi.source_organization_id and
msl.inventory_item_id(+)=misi.inventory_item_id and
msl.organization_id(+)=misi.organization_id and
msl.subinventory_code(+)=misi.secondary_inventory and
milk.organization_id(+)=msl.organization_id and
milk.subinventory_code(+)=msl.subinventory_code and
milk.inventory_location_id(+)=msl.secondary_locator