/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Manufacturer Upload
-- Description: INV Manufacturer Upload
======================
This upload can be used to create, update and delete Manufacturers.


-- Excel Examle Output: https://www.enginatics.com/example/inv-manufacturer-upload/
-- Library Link: https://www.enginatics.com/reports/inv-manufacturer-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
to_number(null) request_id_,
null modified_columns_,
to_number(null) manufacturer_row_id,
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
mm.manufacturer_id,
to_number(null) upload_row
from
mtl_manufacturers mm
where
:p_upload_mode like '%' || xxen_upload.action_update and
1=1