/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Stock Locator Upload
-- Description: Create, update and delete Stock Locators.

Note on entering a locator as a concatenated segment value: if a segment value contains the KFF delimiter character or a backslash (\), each such character must be preceded with a backslash. For example, with delimiter '.', the segment value '1\4\4.' must be written as '1\\4\\4\.'
-- Excel Examle Output: https://www.enginatics.com/example/inv-stock-locator-upload/
-- Library Link: https://www.enginatics.com/reports/inv-stock-locator-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
null modified_columns_,
milk.inventory_location_id,
mp.organization_code,
milk.subinventory_code subinventory,
fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'ALL','N','VALUE','ALL_ENABLED') concatenated_segments,
case when 1<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'1','N','VALUE','ALL_ENABLED') end loc_segment_dsp1,
case when 2<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'2','N','VALUE','ALL_ENABLED') end loc_segment_dsp2,
case when 3<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'3','N','VALUE','ALL_ENABLED') end loc_segment_dsp3,
case when 4<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'4','N','VALUE','ALL_ENABLED') end loc_segment_dsp4,
case when 5<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'5','N','VALUE','ALL_ENABLED') end loc_segment_dsp5,
case when 6<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'6','N','VALUE','ALL_ENABLED') end loc_segment_dsp6,
case when 7<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'7','N','VALUE','ALL_ENABLED') end loc_segment_dsp7,
case when 8<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'8','N','VALUE','ALL_ENABLED') end loc_segment_dsp8,
case when 9<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'9','N','VALUE','ALL_ENABLED') end loc_segment_dsp9,
case when 10<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'10','N','VALUE','ALL_ENABLED') end loc_segment_dsp10,
case when 11<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'11','N','VALUE','ALL_ENABLED') end loc_segment_dsp11,
case when 12<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'12','N','VALUE','ALL_ENABLED') end loc_segment_dsp12,
case when 13<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'13','N','VALUE','ALL_ENABLED') end loc_segment_dsp13,
case when 14<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'14','N','VALUE','ALL_ENABLED') end loc_segment_dsp14,
case when 15<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'15','N','VALUE','ALL_ENABLED') end loc_segment_dsp15,
case when 16<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'16','N','VALUE','ALL_ENABLED') end loc_segment_dsp16,
case when 17<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'17','N','VALUE','ALL_ENABLED') end loc_segment_dsp17,
case when 18<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'18','N','VALUE','ALL_ENABLED') end loc_segment_dsp18,
case when 19<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'19','N','VALUE','ALL_ENABLED') end loc_segment_dsp19,
case when 20<=:segment_count then fnd_flex_xml_publisher_apis.process_kff_combination_1('lov','INV','MTLL',101,milk.organization_id,milk.inventory_location_id,'20','N','VALUE','ALL_ENABLED') end loc_segment_dsp20,
milk.description,
xxen_util.meaning(to_char(milk.inventory_location_type),'MTL_LOCATOR_TYPES',700) type,
mmsv.status_code status,
milk.picking_order,
milk.dropping_order,
milk.alias,
milk.disable_date,
milk.location_maximum_units maximum_units,
milk.volume_uom_code volume_uom,
milk.max_cubic_area maximum_volume,
milk.location_weight_uom_code weight_uom,
milk.max_weight maximum_weight,
milk.pick_uom_code pick_uom,
milk.dimension_uom_code dimension_uom,
milk.length dimension_length,
milk.width dimension_width,
milk.height dimension_height,
milk.x_coordinate,
milk.y_coordinate,
milk.z_coordinate,
xxen_util.display_flexfield_context(401,'MTL_ITEM_LOCATIONS',milk.attribute_category) attribute_category,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE1',milk.rowid,milk.attribute1) loc_attribute1,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE2',milk.rowid,milk.attribute2) loc_attribute2,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE3',milk.rowid,milk.attribute3) loc_attribute3,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE4',milk.rowid,milk.attribute4) loc_attribute4,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE5',milk.rowid,milk.attribute5) loc_attribute5,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE6',milk.rowid,milk.attribute6) loc_attribute6,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE7',milk.rowid,milk.attribute7) loc_attribute7,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE8',milk.rowid,milk.attribute8) loc_attribute8,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE9',milk.rowid,milk.attribute9) loc_attribute9,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE10',milk.rowid,milk.attribute10) loc_attribute10,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE11',milk.rowid,milk.attribute11) loc_attribute11,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE12',milk.rowid,milk.attribute12) loc_attribute12,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE13',milk.rowid,milk.attribute13) loc_attribute13,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE14',milk.rowid,milk.attribute14) loc_attribute14,
xxen_util.display_flexfield_value(401,'MTL_ITEM_LOCATIONS',milk.attribute_category,'ATTRIBUTE15',milk.rowid,milk.attribute15) loc_attribute15,
to_char(null) delete_locator,
to_number(null) upload_row
from
mtl_item_locations_kfv milk,
mtl_parameters mp,
mtl_material_statuses_vl mmsv
where
1=1 and
mp.organization_id=milk.organization_id and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mmsv.status_id(+)=milk.status_id