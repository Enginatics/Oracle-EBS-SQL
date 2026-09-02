/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: EAM Asset Number Upload
-- Description: Create and update Oracle Enterprise Asset Management asset numbers (maintenance assets).
-- Excel Examle Output: https://www.enginatics.com/example/eam-asset-number-upload/
-- Library Link: https://www.enginatics.com/reports/eam-asset-number-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
meanv.inv_organization_code organization,
meanv.instance_number asset_number,
meanv.maintenance_object_id asset_id,
meanv.concatenated_segments asset_group,
meanv.serial_number asset_serial_number,
meanv.descriptive_text description,
meanv.category_name asset_category,
meanv.owning_department,
meanv.asset_criticality criticality,
meanv.wip_accounting_class_code wip_accounting_class,
meanv.area,
decode(meanv.maintainable_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) maintainable,
decode(meanv.network_asset_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) asset_route,
decode(meanv.operational_log_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) operation_log,
meanv.supplier_warranty_exp_date warranty_expiration,
meanv.prod_organization_code production_organization,
(select msi.concatenated_segments from mtl_system_items_b_kfv msi where msi.inventory_item_id=meanv.equipment_item_id and msi.organization_id=meanv.prod_organization_id) equipment_item,
meanv.eqp_serial_number equipment_serial_number,
meanv.pn_location_code property_location_code,
meanv.fa_asset_number,
decode(meanv.fa_sync_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) fa_synchronized,
meanv.active_start_date,
meanv.active_end_date,
xxen_util.meaning(to_char(meanv.eam_item_type),'MTL_EAM_ASSET_TYPE',700) asset_type,
meanv.current_status_meaning asset_status,
meanv.current_location current_location_address,
meanv.parent_instance_number parent_asset_number,
meanv.parent_serial_number parent_asset_serial_number,
(select cii.instance_id from csi_item_instances cii where meanv.parent_instance_number=cii.instance_number) parent_asset_id,
xxen_util.display_flexfield_context(542,'Item Instance Flex Field',meanv.context) attribute_category,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE1',meanv.row_id,meanv.attribute1) attribute1,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE2',meanv.row_id,meanv.attribute2) attribute2,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE3',meanv.row_id,meanv.attribute3) attribute3,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE4',meanv.row_id,meanv.attribute4) attribute4,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE5',meanv.row_id,meanv.attribute5) attribute5,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE6',meanv.row_id,meanv.attribute6) attribute6,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE7',meanv.row_id,meanv.attribute7) attribute7,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE8',meanv.row_id,meanv.attribute8) attribute8,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE9',meanv.row_id,meanv.attribute9) attribute9,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE10',meanv.row_id,meanv.attribute10) attribute10,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE11',meanv.row_id,meanv.attribute11) attribute11,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE12',meanv.row_id,meanv.attribute12) attribute12,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE13',meanv.row_id,meanv.attribute13) attribute13,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE14',meanv.row_id,meanv.attribute14) attribute14,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE15',meanv.row_id,meanv.attribute15) attribute15,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE16',meanv.row_id,meanv.attribute16) attribute16,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE17',meanv.row_id,meanv.attribute17) attribute17,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE18',meanv.row_id,meanv.attribute18) attribute18,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE19',meanv.row_id,meanv.attribute19) attribute19,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE20',meanv.row_id,meanv.attribute20) attribute20,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE21',meanv.row_id,meanv.attribute21) attribute21,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE22',meanv.row_id,meanv.attribute22) attribute22,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE23',meanv.row_id,meanv.attribute23) attribute23,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE24',meanv.row_id,meanv.attribute24) attribute24,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE25',meanv.row_id,meanv.attribute25) attribute25,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE26',meanv.row_id,meanv.attribute26) attribute26,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE27',meanv.row_id,meanv.attribute27) attribute27,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE28',meanv.row_id,meanv.attribute28) attribute28,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE29',meanv.row_id,meanv.attribute29) attribute29,
xxen_util.display_flexfield_value(542,'Item Instance Flex Field',meanv.context,'ATTRIBUTE30',meanv.row_id,meanv.attribute30) attribute30,
to_number(null) upload_row
from
mtl_eam_asset_numbers_all_v meanv
where
1=1