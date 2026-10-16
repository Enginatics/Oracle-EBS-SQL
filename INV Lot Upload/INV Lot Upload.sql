/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Lot Upload
-- Description: Creates and updates lots as in the Lot Numbers form (Inventory > On-hand, Availability > Lots).
-- A row updates the lot when Organization Code, Item and Lot Number exist, and creates it otherwise. A new lot takes the item defaults for status, grade, origination type and the dates left blank, and copies the parent lot attributes where the item or organization is set up to copy them. A blank Origination Date on a new lot defaults to the current date. Parent Lot can only be entered for a new lot.
-- Expiration Date, Expiration Action Date and Retest Date can be changed only for items under shelf life control, and the Expiration Date of such an item cannot be cleared. Status requires a lot status enabled item, Grade a grade controlled item. Changing the Origination Date does not recalculate the other dates. Clearing the Expiration Action Date also clears the Expiration Action.
-- With profile INV: Global Lot Attributes set to Yes, a changed date or grade is applied to the same lot in all organizations, as in the form.
-- Excel Example Output: https://www.enginatics.com/example/inv-lot-upload/
-- Library Link: https://www.enginatics.com/reports/inv-lot-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
to_number(null) request_id_,
null modified_columns_,
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(msiv.shelf_life_code,'MTL_SHELF_LIFE',700) shelf_life_control,
mln.parent_lot_number parent_lot,
mln.lot_number,
xxen_util.yes(decode(mln.disable_flag,1,'Y')) disabled,
(select mmsv.status_code from mtl_material_statuses_vl mmsv where mln.status_id=mmsv.status_id) lot_status,
mln.grade_code grade,
xxen_util.meaning(mln.origination_type,'MTL_LOT_ORIGINATION_TYPE',700) origination_type,
mln.origination_date,
mln.maturity_date,
mln.hold_date,
mln.expiration_date,
mln.expiration_action_date,
mln.expiration_action_code expiration_action,
mln.retest_date,
xxen_util.display_flexfield_context(401,'Lot Attributes',mln.lot_attribute_category) lot_attributes_context,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'DESCRIPTION',mln.rowid,mln.description) lot_attr_description,
mln.vendor_id lot_attr_vendor_id,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'TERRITORY_CODE',mln.rowid,mln.territory_code) lot_attr_territory_code,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'DATE_CODE',mln.rowid,mln.date_code) lot_attr_date_code,
mln.change_date lot_attr_change_date,
mln.age lot_attr_age,
mln.item_size lot_attr_item_size,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'COLOR',mln.rowid,mln.color) lot_attr_color,
mln.volume lot_attr_volume,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'VOLUME_UOM',mln.rowid,mln.volume_uom) lot_attr_volume_uom,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'PLACE_OF_ORIGIN',mln.rowid,mln.place_of_origin) lot_attr_place_of_origin,
mln.best_by_date lot_attr_best_by_date,
mln.length lot_attr_length,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'LENGTH_UOM',mln.rowid,mln.length_uom) lot_attr_length_uom,
mln.recycled_content lot_attr_recycled_content,
mln.thickness lot_attr_thickness,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'THICKNESS_UOM',mln.rowid,mln.thickness_uom) lot_attr_thickness_uom,
mln.width lot_attr_width,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'WIDTH_UOM',mln.rowid,mln.width_uom) lot_attr_width_uom,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'CURL_WRINKLE_FOLD',mln.rowid,mln.curl_wrinkle_fold) lot_attr_curl_wrinkle_fold,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE1',mln.rowid,mln.c_attribute1) lot_attr_c_attribute1,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE2',mln.rowid,mln.c_attribute2) lot_attr_c_attribute2,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE3',mln.rowid,mln.c_attribute3) lot_attr_c_attribute3,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE4',mln.rowid,mln.c_attribute4) lot_attr_c_attribute4,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE5',mln.rowid,mln.c_attribute5) lot_attr_c_attribute5,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE6',mln.rowid,mln.c_attribute6) lot_attr_c_attribute6,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE7',mln.rowid,mln.c_attribute7) lot_attr_c_attribute7,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE8',mln.rowid,mln.c_attribute8) lot_attr_c_attribute8,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE9',mln.rowid,mln.c_attribute9) lot_attr_c_attribute9,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE10',mln.rowid,mln.c_attribute10) lot_attr_c_attribute10,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE11',mln.rowid,mln.c_attribute11) lot_attr_c_attribute11,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE12',mln.rowid,mln.c_attribute12) lot_attr_c_attribute12,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE13',mln.rowid,mln.c_attribute13) lot_attr_c_attribute13,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE14',mln.rowid,mln.c_attribute14) lot_attr_c_attribute14,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE15',mln.rowid,mln.c_attribute15) lot_attr_c_attribute15,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE16',mln.rowid,mln.c_attribute16) lot_attr_c_attribute16,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE17',mln.rowid,mln.c_attribute17) lot_attr_c_attribute17,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE18',mln.rowid,mln.c_attribute18) lot_attr_c_attribute18,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE19',mln.rowid,mln.c_attribute19) lot_attr_c_attribute19,
xxen_util.display_flexfield_value(401,'Lot Attributes',mln.lot_attribute_category,'C_ATTRIBUTE20',mln.rowid,mln.c_attribute20) lot_attr_c_attribute20,
mln.d_attribute1 lot_attr_d_attribute1,
mln.d_attribute2 lot_attr_d_attribute2,
mln.d_attribute3 lot_attr_d_attribute3,
mln.d_attribute4 lot_attr_d_attribute4,
mln.d_attribute5 lot_attr_d_attribute5,
mln.d_attribute6 lot_attr_d_attribute6,
mln.d_attribute7 lot_attr_d_attribute7,
mln.d_attribute8 lot_attr_d_attribute8,
mln.d_attribute9 lot_attr_d_attribute9,
mln.d_attribute10 lot_attr_d_attribute10,
mln.n_attribute1 lot_attr_n_attribute1,
mln.n_attribute2 lot_attr_n_attribute2,
mln.n_attribute3 lot_attr_n_attribute3,
mln.n_attribute4 lot_attr_n_attribute4,
mln.n_attribute5 lot_attr_n_attribute5,
mln.n_attribute6 lot_attr_n_attribute6,
mln.n_attribute7 lot_attr_n_attribute7,
mln.n_attribute8 lot_attr_n_attribute8,
mln.n_attribute9 lot_attr_n_attribute9,
mln.n_attribute10 lot_attr_n_attribute10,
xxen_util.display_flexfield_context(401,'MTL_LOT_NUMBERS',mln.attribute_category) lot_attribute_category,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE1',mln.rowid,mln.attribute1) lot_attribute1,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE2',mln.rowid,mln.attribute2) lot_attribute2,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE3',mln.rowid,mln.attribute3) lot_attribute3,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE4',mln.rowid,mln.attribute4) lot_attribute4,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE5',mln.rowid,mln.attribute5) lot_attribute5,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE6',mln.rowid,mln.attribute6) lot_attribute6,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE7',mln.rowid,mln.attribute7) lot_attribute7,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE8',mln.rowid,mln.attribute8) lot_attribute8,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE9',mln.rowid,mln.attribute9) lot_attribute9,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE10',mln.rowid,mln.attribute10) lot_attribute10,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE11',mln.rowid,mln.attribute11) lot_attribute11,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE12',mln.rowid,mln.attribute12) lot_attribute12,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE13',mln.rowid,mln.attribute13) lot_attribute13,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE14',mln.rowid,mln.attribute14) lot_attribute14,
xxen_util.display_flexfield_value(401,'MTL_LOT_NUMBERS',mln.attribute_category,'ATTRIBUTE15',mln.rowid,mln.attribute15) lot_attribute15,
(select sum(moqd.primary_transaction_quantity) from mtl_onhand_quantities_detail moqd where mln.organization_id=moqd.organization_id and mln.inventory_item_id=moqd.inventory_item_id and mln.lot_number=moqd.lot_number) onhand_quantity,
to_number(null) upload_row
from
mtl_parameters mp,
mtl_system_items_vl msiv,
mtl_lot_numbers mln
where
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=msiv.organization_id and
msiv.organization_id=mln.organization_id and
msiv.inventory_item_id=mln.inventory_item_id and
:p_upload_mode like '%'||xxen_upload.action_update and
1=1
