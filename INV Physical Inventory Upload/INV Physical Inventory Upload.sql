/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Physical Inventory Upload
-- Description: This upload supports the creation of new Physical Inventories and the update of existing Physical Inventories that have not yet been frozen.

The upload supports the specification of the subinventories to be included in the Physical Inventory. 

When updating an existing Physical Inventory, the Delete Subinventory upload column allows for individual subinventories to be removed from the Physical Inventory subinventory list.

Replace Existing Subinventories
==========================
When the Replace Existing Subinventories report parameter is set to Yes, the existing physical inventory subinventories will be replaced by those specified in the upload.

When set to No, the upload will update the existing Physical Inventory subinventories, create additional subinventories, or delete specific subinventories as determined from the uploaded data.

Freeze Physical Inventory
===================== 
When set to Yes, the Freeze Physical Inventory concurrent program will be submitted after the upload is complete to freeze the uploaded Physical Inventories.

This will only occur for each uploaded Physical Inventory if no upload error has occurred in any upload row for that Physical Inventory.

Once a Physical Inventory has been frozen, it can no longer be updated by this upload.

The Snapshot Complete and Freeze Date columns in the upload excel are display only columns. They will be displayed after the upload when the Freeze Physical Inventory option is selected.  

-- Excel Examle Output: https://www.enginatics.com/example/inv-physical-inventory-upload/
-- Library Link: https://www.enginatics.com/reports/inv-physical-inventory-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
:p_replace_subinventories replace_subinventories,
:p_freeze_physical_inventory freeze_physical_inventory,
to_number(null) upload_seq_,
to_number(null) physical_inventory_row_id,
-- Physical Inventory
mp.organization_code,
mpiv.physical_inventory_name,
mpiv.description,
mpiv.physical_inventory_date,
decode(mpiv.approval_required,1,'Always',2,'Never',3,'If out of tolerance',mpiv.approval_required) approval_required,
mpiv.approval_tolerance_pos quantity_tolerance_plus,
mpiv.approval_tolerance_neg quantity_tolerance_minus,
mpiv.cost_variance_pos value_tolerance_plus,
mpiv.cost_variance_neg value_tolerance_minus,
&lp_serial_control_cols
xxen_util.meaning(decode(mpiv.dynamic_tag_entry_flag,1,1,null),'INV_YES_NO',3) allow_dynamic_tags,
xxen_util.meaning(decode(mpiv.exclude_zero_balance,'Y','Y',null),'YES_NO',0) exclude_zero_balance,
xxen_util.meaning(decode(mpiv.exclude_negative_balance,'Y','Y',null),'YES_NO',0) exclude_negative_balance,
xxen_util.meaning(decode(mpiv.all_subinventories_flag,1,1,null),'INV_YES_NO',3) all_subinventories,
-- DFF Attributes
xxen_util.display_flexfield_context(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category) attribute_category,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE1',mpiv.row_id,mpiv.attribute1) phys_inv_attribute1,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE2',mpiv.row_id,mpiv.attribute2) phys_inv_attribute2,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE3',mpiv.row_id,mpiv.attribute3) phys_inv_attribute3,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE4',mpiv.row_id,mpiv.attribute4) phys_inv_attribute4,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE5',mpiv.row_id,mpiv.attribute5) phys_inv_attribute5,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE6',mpiv.row_id,mpiv.attribute6) phys_inv_attribute6,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE7',mpiv.row_id,mpiv.attribute7) phys_inv_attribute7,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE8',mpiv.row_id,mpiv.attribute8) phys_inv_attribute8,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE9',mpiv.row_id,mpiv.attribute9) phys_inv_attribute9,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE10',mpiv.row_id,mpiv.attribute10) phys_inv_attribute10,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE11',mpiv.row_id,mpiv.attribute11) phys_inv_attribute11,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE12',mpiv.row_id,mpiv.attribute12) phys_inv_attribute12,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE13',mpiv.row_id,mpiv.attribute13) phys_inv_attribute13,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE14',mpiv.row_id,mpiv.attribute14) phys_inv_attribute14,
xxen_util.display_flexfield_value(401,'MTL_PHYSICAL_INVENTORIES',mpiv.attribute_category,'ATTRIBUTE15',mpiv.row_id,mpiv.attribute15) phys_inv_attribute15,
-- Subinventories
mps.subinventory,
null delete_subinventory,
--
xxen_util.meaning(decode(mpiv.snapshot_complete,1,1,null),'INV_YES_NO',3) snapshot_complete,
mpiv.freeze_date,
-- Ids
mpiv.physical_inventory_id
from
mtl_physical_inventories_v mpiv,
mtl_physical_subinventories mps,
mtl_parameters mp
where
1=1 and
mpiv.physical_inventory_id = mps.physical_inventory_id (+) and
mpiv.organization_id = mps.organization_id (+) and
mpiv.organization_id = mp.organization_id and
mpiv.snapshot_complete = 2 and -- No
mpiv.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)