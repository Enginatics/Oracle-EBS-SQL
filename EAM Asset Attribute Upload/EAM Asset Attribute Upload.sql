/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM Asset Attribute Upload
-- Description: Create and update Oracle Enterprise Asset Management asset attribute values, the attribute group values of an asset or rebuildable number.
-- Attribute groups are assigned to an asset group (Enterprise Asset Management: Asset Groups, Attributes) and their values are entered per asset number in the Asset Attributes window. Each row uploads one attribute group of one asset number, so an asset with several attribute groups has one row per group.
-- The attribute columns follow the flexfield segments of the selected attribute group: Attribute 1-20 hold the character segments, Number Attribute 1-10 the number segments and Date Attribute 1-10 the date segments.
-- Excel Example Output: https://www.enginatics.com/example/eam-asset-attribute-upload/
-- Library Link: https://www.enginatics.com/reports/eam-asset-attribute-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
meanv.inv_organization_code organization,
meanv.instance_number asset_number,
meanv.concatenated_segments asset_group,
xxen_util.display_flexfield_context(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category) attribute_group,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE1',meaav.rowid,meaav.c_attribute1) attribute1,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE2',meaav.rowid,meaav.c_attribute2) attribute2,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE3',meaav.rowid,meaav.c_attribute3) attribute3,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE4',meaav.rowid,meaav.c_attribute4) attribute4,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE5',meaav.rowid,meaav.c_attribute5) attribute5,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE6',meaav.rowid,meaav.c_attribute6) attribute6,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE7',meaav.rowid,meaav.c_attribute7) attribute7,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE8',meaav.rowid,meaav.c_attribute8) attribute8,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE9',meaav.rowid,meaav.c_attribute9) attribute9,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE10',meaav.rowid,meaav.c_attribute10) attribute10,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE11',meaav.rowid,meaav.c_attribute11) attribute11,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE12',meaav.rowid,meaav.c_attribute12) attribute12,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE13',meaav.rowid,meaav.c_attribute13) attribute13,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE14',meaav.rowid,meaav.c_attribute14) attribute14,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE15',meaav.rowid,meaav.c_attribute15) attribute15,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE16',meaav.rowid,meaav.c_attribute16) attribute16,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE17',meaav.rowid,meaav.c_attribute17) attribute17,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE18',meaav.rowid,meaav.c_attribute18) attribute18,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE19',meaav.rowid,meaav.c_attribute19) attribute19,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ATTR_VALUES',meaav.attribute_category,'C_ATTRIBUTE20',meaav.rowid,meaav.c_attribute20) attribute20,
meaav.n_attribute1 number_attribute1,
meaav.n_attribute2 number_attribute2,
meaav.n_attribute3 number_attribute3,
meaav.n_attribute4 number_attribute4,
meaav.n_attribute5 number_attribute5,
meaav.n_attribute6 number_attribute6,
meaav.n_attribute7 number_attribute7,
meaav.n_attribute8 number_attribute8,
meaav.n_attribute9 number_attribute9,
meaav.n_attribute10 number_attribute10,
meaav.d_attribute1 date_attribute1,
meaav.d_attribute2 date_attribute2,
meaav.d_attribute3 date_attribute3,
meaav.d_attribute4 date_attribute4,
meaav.d_attribute5 date_attribute5,
meaav.d_attribute6 date_attribute6,
meaav.d_attribute7 date_attribute7,
meaav.d_attribute8 date_attribute8,
meaav.d_attribute9 date_attribute9,
meaav.d_attribute10 date_attribute10,
to_number(null) upload_row
from
mtl_eam_asset_numbers_all_v meanv,
mtl_eam_asset_attr_values meaav
where
1=1 and
meanv.inventory_item_id=meaav.inventory_item_id and
meanv.serial_number=meaav.serial_number
