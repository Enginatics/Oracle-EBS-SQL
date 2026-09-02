/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM Asset Activity Association Upload
-- Description: EAM Asset Activity Association Upload
=====================================
- Create new associations between an Activity item and an Asset Group, specific Asset Number (serial instance), or Rebuildable item.
- Update existing association attributes (dates, priority, owning department, WIP class, DFF, etc.).
- Deletion is not supported by the public API in v1.

Prerequisites
=============
- The Activity item (eam_item_type=2) must already exist in the maintenance organization. Use the INV Item Upload to create Activity items.
- For Asset Group associations, the Asset Group (eam_item_type=1) and its serialised instance (csi_item_instances) must exist.
- For Rebuildable (serial) associations, the Rebuildable item (eam_item_type=3) and instance must exist.
- For Rebuildable (non-serial) associations, only the Rebuildable item is required.

Natural business key for create/update detection:
(Asset Activity + Maintenance Object Type + Maintenance Object Id)
which maps to (Activity + Asset Group or Asset Number).

-- Excel Examle Output: https://www.enginatics.com/example/eam-asset-activity-association-upload/
-- Library Link: https://www.enginatics.com/reports/eam-asset-activity-association-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
mp.organization_code maintenance_organization,
msi_act.concatenated_segments activity,
xxen_util.meaning(to_char(decode(meaa.maintenance_object_type,2,decode(msi_grp.eam_item_type,1,1,3),3,decode(msi_grp.eam_item_type,1,1,3),nvl(msi_grp.eam_item_type,1))),'MTL_EAM_ITEM_TYPE',700) asset_type,
msi_grp.concatenated_segments asset_group,
cii.instance_number asset_number,
meaa.start_date_active from_date,
meaa.end_date_active to_date,
xxen_util.meaning(meaa.priority_code,'WIP_EAM_ACTIVITY_PRIORITY',700) priority,
xxen_util.meaning(meaa.activity_cause_code,'MTL_EAM_ACTIVITY_CAUSE',700) activity_cause,
xxen_util.meaning(meaa.activity_type_code,'MTL_EAM_ACTIVITY_TYPE',700) activity_type,
xxen_util.meaning(meaa.shutdown_type_code,'BOM_EAM_SHUTDOWN_TYPE',700) shutdown_type,
xxen_util.meaning(meaa.activity_source_code,'MTL_EAM_ACTIVITY_SOURCE',700) activity_source,
bd.department_code owning_department,
meaa.class_code wip_accounting_class,
decode(meaa.tagging_required_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) tagging_required,
xxen_util.display_flexfield_context(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category) attribute_category,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE1',meaa.rowid,meaa.attribute1) attribute1,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE2',meaa.rowid,meaa.attribute2) attribute2,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE3',meaa.rowid,meaa.attribute3) attribute3,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE4',meaa.rowid,meaa.attribute4) attribute4,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE5',meaa.rowid,meaa.attribute5) attribute5,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE6',meaa.rowid,meaa.attribute6) attribute6,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE7',meaa.rowid,meaa.attribute7) attribute7,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE8',meaa.rowid,meaa.attribute8) attribute8,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE9',meaa.rowid,meaa.attribute9) attribute9,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE10',meaa.rowid,meaa.attribute10) attribute10,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE11',meaa.rowid,meaa.attribute11) attribute11,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE12',meaa.rowid,meaa.attribute12) attribute12,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE13',meaa.rowid,meaa.attribute13) attribute13,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE14',meaa.rowid,meaa.attribute14) attribute14,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',meaa.attribute_category,'ATTRIBUTE15',meaa.rowid,meaa.attribute15) attribute15,
meaa.activity_association_id assoc_row_id,
to_number(null) upload_row
from
inv.mtl_eam_asset_activities meaa,
mtl_parameters mp,
mtl_system_items_b_kfv msi_act,
mtl_system_items_b_kfv msi_grp,
csi_item_instances cii,
bom_departments bd
where
:p_upload_mode like '%' || xxen_upload.action_update and
nvl(meaa.tmpl_flag,'N')='N' and
meaa.organization_id=mp.organization_id and
meaa.asset_activity_id=msi_act.inventory_item_id and
meaa.organization_id=msi_act.organization_id and
meaa.inventory_item_id=msi_grp.inventory_item_id(+) and
meaa.organization_id=msi_grp.organization_id(+) and
decode(meaa.maintenance_object_type,3,meaa.maintenance_object_id,null)=cii.instance_id(+) and
meaa.owning_department_id=bd.department_id(+) and
1=1