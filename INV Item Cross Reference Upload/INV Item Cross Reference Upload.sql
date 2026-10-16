/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Cross Reference Upload
-- Description: Creates, updates and deletes item cross references - the Cross Reference Types form (Inventory > Setup > Items > Cross-Reference Types), also reached from the Item form via Tools > Cross References.
-- A cross reference is either organization independent (Applicable To All Organizations is set and Org is blank) or specific to one organization (Org is entered). The organization must be one the item is assigned to.
-- Revision and Unit of Measure only apply to the GTIN cross reference type named by the profile option INV: GTIN Cross Reference Type, and Revision additionally requires an organization. Entering them for any other type is rejected.
-- Descriptions are translatable and are downloaded in the session language.
-- To remove a cross reference, enter Yes in Delete Cross Reference on a downloaded row.
-- Excel Example Output: https://www.enginatics.com/example/inv-item-cross-reference-upload/
-- Library Link: https://www.enginatics.com/reports/inv-item-cross-reference-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
to_number(null) request_id_,
null modified_columns_,
mcrv.cross_reference_id cross_reference_row_id,
--
mp.organization_code item_master_org,
msiv.concatenated_segments item,
msiv.description item_description,
mcrv.cross_reference_type,
xxen_util.yes(mcrv.org_independent_flag) applicable_to_all_orgs,
mp_xref.organization_code org,
mir.revision,
mcrv.uom_code unit_of_measure,
mcrv.cross_reference,
mcrv.description,
null delete_cross_reference,
--
xxen_util.display_flexfield_context(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category) xref_attribute_category,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE1',mcrv.rowid,mcrv.attribute1) xref_attribute1,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE2',mcrv.rowid,mcrv.attribute2) xref_attribute2,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE3',mcrv.rowid,mcrv.attribute3) xref_attribute3,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE4',mcrv.rowid,mcrv.attribute4) xref_attribute4,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE5',mcrv.rowid,mcrv.attribute5) xref_attribute5,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE6',mcrv.rowid,mcrv.attribute6) xref_attribute6,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE7',mcrv.rowid,mcrv.attribute7) xref_attribute7,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE8',mcrv.rowid,mcrv.attribute8) xref_attribute8,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE9',mcrv.rowid,mcrv.attribute9) xref_attribute9,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE10',mcrv.rowid,mcrv.attribute10) xref_attribute10,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE11',mcrv.rowid,mcrv.attribute11) xref_attribute11,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE12',mcrv.rowid,mcrv.attribute12) xref_attribute12,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE13',mcrv.rowid,mcrv.attribute13) xref_attribute13,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE14',mcrv.rowid,mcrv.attribute14) xref_attribute14,
xxen_util.display_flexfield_value(401,'MTL_CROSS_REFERENCES',mcrv.attribute_category,'ATTRIBUTE15',mcrv.rowid,mcrv.attribute15) xref_attribute15,

to_number(null) upload_row
from
mtl_cross_references_vl mcrv,
mtl_system_items_vl msiv,
mtl_parameters mp,
mtl_parameters mp_xref,
mtl_item_revisions_b mir
where
mcrv.inventory_item_id=msiv.inventory_item_id and
msiv.organization_id=mp.organization_id and
mp.organization_id=mp.master_organization_id and
mcrv.organization_id=mp_xref.organization_id(+) and
mcrv.revision_id=mir.revision_id(+) and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
:p_upload_mode like '%'||xxen_upload.action_update and
1=1
