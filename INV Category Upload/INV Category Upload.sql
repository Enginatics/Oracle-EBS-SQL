/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Category Upload
-- Description: Creates and updates item category codes as the Categories window (Setup > Items > Categories > Category Codes): description, inactive date, iProcurement flags and the descriptive flexfield.
-- Enter the category as its concatenated segments, separated by the structure's segment delimiter (for example COMPUTER.MONITOR). Each segment is validated against its value set.
-- Categories cannot be deleted, and the segments of an existing category cannot be changed, as in the form. A category can only be made not viewable by suppliers in the purchasing category structure, and the default category of a category set cannot be made inactive.
-- Excel Example Output: https://www.enginatics.com/example/inv-category-upload/
-- Library Link: https://www.enginatics.com/reports/inv-category-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
fifsv.id_flex_structure_name structure_name,
mcbk.concatenated_segments category,
mcv.description,
mcv.disable_date inactive_on,
xxen_util.yes(mcv.web_status) enabled_for_iprocurement,
xxen_util.yes(decode(mcv.supplier_enabled_flag,'N',null,'Y')) viewable_by_supplier,
xxen_util.display_flexfield_context(401,'MTL_CATEGORIES',mcv.attribute_category) flexfield_context,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE1',mcv.row_id,mcv.attribute1) cat_attribute1,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE2',mcv.row_id,mcv.attribute2) cat_attribute2,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE3',mcv.row_id,mcv.attribute3) cat_attribute3,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE4',mcv.row_id,mcv.attribute4) cat_attribute4,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE5',mcv.row_id,mcv.attribute5) cat_attribute5,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE6',mcv.row_id,mcv.attribute6) cat_attribute6,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE7',mcv.row_id,mcv.attribute7) cat_attribute7,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE8',mcv.row_id,mcv.attribute8) cat_attribute8,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE9',mcv.row_id,mcv.attribute9) cat_attribute9,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE10',mcv.row_id,mcv.attribute10) cat_attribute10,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE11',mcv.row_id,mcv.attribute11) cat_attribute11,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE12',mcv.row_id,mcv.attribute12) cat_attribute12,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE13',mcv.row_id,mcv.attribute13) cat_attribute13,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE14',mcv.row_id,mcv.attribute14) cat_attribute14,
xxen_util.display_flexfield_value(401,'MTL_CATEGORIES',mcv.attribute_category,'ATTRIBUTE15',mcv.row_id,mcv.attribute15) cat_attribute15,
to_number(null) upload_row
from
fnd_id_flex_structures_vl fifsv,
mtl_categories_b_kfv mcbk,
mtl_categories_vl mcv
where
1=1 and
fifsv.application_id=401 and
fifsv.id_flex_code='MCAT' and
fifsv.id_flex_num=mcbk.structure_id and
mcbk.category_id=mcv.category_id
