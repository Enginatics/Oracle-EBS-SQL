/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM Asset Activity Association Upload
-- Description: Create and update the associations of maintenance activities with assets and rebuildables, including the activity defaults that work orders take from the association: priority, cause, type, shutdown type, source, owning department, WIP accounting class and tagging.
-- An association is for an Asset Number (an asset or a serialized rebuildable), or for a non-serialized Rebuildable item without an asset number. Asset group template associations, which Oracle copies to new assets of the group, are not supported.
-- An existing association is found by activity and asset number, or by activity and rebuildable item. Owning department, accounting class, cause, type, source, shutdown type and tagging are kept per maintenance organization, so a row updates them for the organization in its Maintenance Organization column.
-- Associations cannot be deleted. End-date them with To Date.
-- Excel Example Output: https://www.enginatics.com/example/eam-asset-activity-association-upload/
-- Library Link: https://www.enginatics.com/reports/eam-asset-activity-association-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
x.organization_code maintenance_organization,
x.activity,
xxen_util.meaning(to_char(decode(x.maintenance_object_type,2,decode(msi_grp.eam_item_type,1,1,3),3,decode(msi_grp.eam_item_type,1,1,3),nvl(msi_grp.eam_item_type,1))),'MTL_EAM_ITEM_TYPE',700) asset_type,
msi_grp.concatenated_segments asset_group,
x.instance_number asset_number,
x.start_date_active from_date,
x.end_date_active to_date,
xxen_util.meaning(x.priority_code,'WIP_EAM_ACTIVITY_PRIORITY',700) priority,
xxen_util.meaning(x.eomd_activity_cause_code,'MTL_EAM_ACTIVITY_CAUSE',700) activity_cause,
xxen_util.meaning(x.eomd_activity_type_code,'MTL_EAM_ACTIVITY_TYPE',700) activity_type,
xxen_util.meaning(x.eomd_shutdown_type_code,'BOM_EAM_SHUTDOWN_TYPE',700) shutdown_type,
xxen_util.meaning(x.eomd_activity_source_code,'MTL_EAM_ACTIVITY_SOURCE',700) activity_source,
bd.department_code owning_department,
x.eomd_accounting_class_code wip_accounting_class,
xxen_util.yes(x.eomd_tagging_required_flag) tagging_required,
xxen_util.display_flexfield_context(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category) attribute_category,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE1',x.row_id,x.attribute1) attribute1,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE2',x.row_id,x.attribute2) attribute2,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE3',x.row_id,x.attribute3) attribute3,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE4',x.row_id,x.attribute4) attribute4,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE5',x.row_id,x.attribute5) attribute5,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE6',x.row_id,x.attribute6) attribute6,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE7',x.row_id,x.attribute7) attribute7,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE8',x.row_id,x.attribute8) attribute8,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE9',x.row_id,x.attribute9) attribute9,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE10',x.row_id,x.attribute10) attribute10,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE11',x.row_id,x.attribute11) attribute11,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE12',x.row_id,x.attribute12) attribute12,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE13',x.row_id,x.attribute13) attribute13,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE14',x.row_id,x.attribute14) attribute14,
xxen_util.display_flexfield_value(401,'MTL_EAM_ASSET_ACTIVITIES',x.attribute_category,'ATTRIBUTE15',x.row_id,x.attribute15) attribute15,
x.activity_association_id assoc_row_id,
to_number(null) upload_row
from
(
select
meaa.*,
meaa.rowid row_id,
mp.organization_id maint_organization_id,
mp.organization_code,
msi_act.concatenated_segments activity,
cii.instance_number,
decode(meaa.maintenance_object_type,3,cii.inventory_item_id,2,meaa.maintenance_object_id) asset_group_id,
eomd.owning_department_id eomd_owning_department_id,
eomd.accounting_class_code eomd_accounting_class_code,
eomd.activity_cause_code eomd_activity_cause_code,
eomd.activity_type_code eomd_activity_type_code,
eomd.activity_source_code eomd_activity_source_code,
eomd.shutdown_type_code eomd_shutdown_type_code,
eomd.tagging_required_flag eomd_tagging_required_flag
from
inv.mtl_eam_asset_activities meaa,
eam_org_maint_defaults eomd,
mtl_parameters mp,
mtl_system_items_b_kfv msi_act,
csi_item_instances cii
where
:p_upload_mode like '%' || xxen_upload.action_update and
nvl(meaa.tmpl_flag,'N')='N' and
decode(meaa.maintenance_object_type,2,40,60)=eomd.object_type(+) and
meaa.activity_association_id=eomd.object_id(+) and
nvl(eomd.organization_id,meaa.organization_id)=mp.organization_id and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
meaa.asset_activity_id=msi_act.inventory_item_id and
mp.organization_id=msi_act.organization_id and
decode(meaa.maintenance_object_type,3,meaa.maintenance_object_id)=cii.instance_id(+) and
1=1
) x,
mtl_system_items_b_kfv msi_grp,
bom_departments bd
where
x.asset_group_id=msi_grp.inventory_item_id(+) and
x.maint_organization_id=msi_grp.organization_id(+) and
x.eomd_owning_department_id=bd.department_id(+)
