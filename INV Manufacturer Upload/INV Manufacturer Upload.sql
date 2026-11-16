/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Manufacturer Upload
-- Description: INV Manufacturer Upload
-- ======================
-- This upload can be used to create, update and delete Manufacturers and their Manufacturer Part Numbers.
-- A row holds one manufacturer part number. The manufacturer columns repeat on each part number row of a manufacturer and are applied from the first of them. A row without Mfg Part Num and Item maintains the manufacturer only.
-- Manufacturer part numbers belong to the item master organization. An existing one is updated, also when its Mfg Part Num or Item is changed, and removed with Delete Mfg Part.
-- A manufacturer can only be deleted once it has no part numbers left.
-- Excel Example Output: https://www.enginatics.com/example/inv-manufacturer-upload/
-- Library Link: https://www.enginatics.com/reports/inv-manufacturer-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
to_number(null) request_id_,
null modified_columns_,
to_number(null) manufacturer_row_id,
null mfg_part_row_id,
--
mm.manufacturer_name manufacturer,
mm.description manufacturer_description,
null delete_manufacturer,
(select count(*) from mtl_mfg_part_numbers mmpn where mmpn.manufacturer_id = mm.manufacturer_id) mfg_part_number_count,
--
xxen_util.display_flexfield_context(401,'MTL_MANUFACTURERS',mm.attribute_category) manufacturer_attribute_categry,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE1',mm.rowid,mm.attribute1) manufacturer_attribute1,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE2',mm.rowid,mm.attribute2) manufacturer_attribute2,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE3',mm.rowid,mm.attribute3) manufacturer_attribute3,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE4',mm.rowid,mm.attribute4) manufacturer_attribute4,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE5',mm.rowid,mm.attribute5) manufacturer_attribute5,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE6',mm.rowid,mm.attribute6) manufacturer_attribute6,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE7',mm.rowid,mm.attribute7) manufacturer_attribute7,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE8',mm.rowid,mm.attribute8) manufacturer_attribute8,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE9',mm.rowid,mm.attribute9) manufacturer_attribute9,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE10',mm.rowid,mm.attribute10) manufacturer_attribute10,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE11',mm.rowid,mm.attribute11) manufacturer_attribute11,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE12',mm.rowid,mm.attribute12) manufacturer_attribute12,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE13',mm.rowid,mm.attribute13) manufacturer_attribute13,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE14',mm.rowid,mm.attribute14) manufacturer_attribute14,
xxen_util.display_flexfield_value(401,'MTL_MANUFACTURERS',mm.attribute_category,'ATTRIBUTE15',mm.rowid,mm.attribute15) manufacturer_attribute15,
--
mp.organization_code item_master_org,
mmpn.mfg_part_num,
msiv.concatenated_segments item,
msiv.description item_description,
null delete_mfg_part,
xxen_util.display_flexfield_context(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category) mfg_part_attribute_category,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE1',mmpn.row_id,mmpn.attribute1) mfg_part_attribute1,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE2',mmpn.row_id,mmpn.attribute2) mfg_part_attribute2,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE3',mmpn.row_id,mmpn.attribute3) mfg_part_attribute3,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE4',mmpn.row_id,mmpn.attribute4) mfg_part_attribute4,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE5',mmpn.row_id,mmpn.attribute5) mfg_part_attribute5,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE6',mmpn.row_id,mmpn.attribute6) mfg_part_attribute6,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE7',mmpn.row_id,mmpn.attribute7) mfg_part_attribute7,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE8',mmpn.row_id,mmpn.attribute8) mfg_part_attribute8,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE9',mmpn.row_id,mmpn.attribute9) mfg_part_attribute9,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE10',mmpn.row_id,mmpn.attribute10) mfg_part_attribute10,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE11',mmpn.row_id,mmpn.attribute11) mfg_part_attribute11,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE12',mmpn.row_id,mmpn.attribute12) mfg_part_attribute12,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE13',mmpn.row_id,mmpn.attribute13) mfg_part_attribute13,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE14',mmpn.row_id,mmpn.attribute14) mfg_part_attribute14,
xxen_util.display_flexfield_value(401,'MTL_MFG_PART_NUMBERS',mmpn.attribute_category,'ATTRIBUTE15',mmpn.row_id,mmpn.attribute15) mfg_part_attribute15,
mm.manufacturer_id,
mmpn.mfg_part_num orig_mfg_part_num,
mmpn.inventory_item_id orig_inventory_item_id,
to_number(null) upload_row
from
mtl_manufacturers mm,
(
select
mmpn.rowid row_id,
mmpn.*
from
mtl_mfg_part_numbers mmpn
where
:p_show_mfg_part_numbers='Y' and
mmpn.organization_id in (select mp2.master_organization_id from mtl_parameters mp2 where mp2.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV'))
) mmpn,
mtl_parameters mp,
mtl_system_items_vl msiv
where
:p_upload_mode like '%' || xxen_upload.action_update and
1=1 and
mm.manufacturer_id=mmpn.manufacturer_id(+) and
mmpn.organization_id=mp.organization_id(+) and
mmpn.organization_id=msiv.organization_id(+) and
mmpn.inventory_item_id=msiv.inventory_item_id(+)
