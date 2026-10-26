/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: WSH Transit Time Upload
-- Description: Creates, updates and deletes transit times - the Transit Times form (Shipping > Setup > Regions and Zones > Transit Times). A row is one ship method of a lane, which is an origin and destination pair of locations, regions or zones, with the intransit time in days and the optional daily capacities and cost per unit.
-- The origin and destination of a downloaded row cannot be changed. Changing its Ship Method changes the ship method of that row. To remove a ship method from a lane, enter Yes in Delete Transit Time.
-- Setting Default Method to Yes removes the flag from the lane's other ship methods, as the form does, and the Message names them.
-- Regions are the country, state, city and postal code regions already defined in Regions and Zones; the upload does not create regions. A location or region name that occurs more than once is followed by its description in brackets.
-- An internal location that belongs to an organization accepts only the ship methods of the carrier services enabled for its inventory organization, as the form's list does. Lanes between inventory organizations defined in Shipping Networks are downloaded as well, when their organizations' locations are set.
-- Excel Example Output: https://www.enginatics.com/example/wsh-transit-time-upload/
-- Library Link: https://www.enginatics.com/reports/wsh-transit-time-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
xxen_util.meaning(x.origin_type,'WSH_ORIGIN_DEST_TYPE',665) origin_type,
tp_o.value origin,
tp_o.description origin_description,
xxen_util.meaning(x.destination_type,'WSH_ORIGIN_DEST_TYPE',665) destination_type,
tp_d.value destination,
tp_d.description destination_description,
xxen_util.meaning(x.ship_method,'SHIP_METHOD',3) ship_method,
x.intransit_time,
x.daily_load_weight_capacity daily_weight_capacity,
x.load_weight_uom_code weight_uom,
x.cost_per_unit_load_weight cost_per_unit_weight,
x.currency_code currency,
x.daily_volume_capacity,
x.volume_uom_code volume_uom,
xxen_util.yes(decode(x.default_flag,1,'Y')) default_method,
null delete_transit_time,
xxen_util.display_flexfield_context(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category) attribute_category,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE1',x.mism_rowid,x.attribute1) tt_attribute1,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE2',x.mism_rowid,x.attribute2) tt_attribute2,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE3',x.mism_rowid,x.attribute3) tt_attribute3,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE4',x.mism_rowid,x.attribute4) tt_attribute4,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE5',x.mism_rowid,x.attribute5) tt_attribute5,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE6',x.mism_rowid,x.attribute6) tt_attribute6,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE7',x.mism_rowid,x.attribute7) tt_attribute7,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE8',x.mism_rowid,x.attribute8) tt_attribute8,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE9',x.mism_rowid,x.attribute9) tt_attribute9,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE10',x.mism_rowid,x.attribute10) tt_attribute10,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE11',x.mism_rowid,x.attribute11) tt_attribute11,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE12',x.mism_rowid,x.attribute12) tt_attribute12,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE13',x.mism_rowid,x.attribute13) tt_attribute13,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE14',x.mism_rowid,x.attribute14) tt_attribute14,
xxen_util.display_flexfield_value(401,'MTL_INTERORG_SHIP_METHODS',x.attribute_category,'ATTRIBUTE15',x.mism_rowid,x.attribute15) tt_attribute15,
rowidtochar(x.mism_rowid) row_id,
to_number(null) upload_row
from
(
select
mism.rowid mism_rowid,
nvl(mism.origin_type,'L') origin_type,
nvl(mism.from_location_id,mism.from_region_id) origin_id,
nvl(mism.destination_type,'L') destination_type,
nvl(mism.to_location_id,mism.to_region_id) destination_id,
mism.ship_method,
mism.intransit_time,
mism.daily_load_weight_capacity,
mism.load_weight_uom_code,
mism.cost_per_unit_load_weight,
mism.currency_code,
mism.daily_volume_capacity,
mism.volume_uom_code,
mism.default_flag,
mism.attribute_category,
mism.attribute1,
mism.attribute2,
mism.attribute3,
mism.attribute4,
mism.attribute5,
mism.attribute6,
mism.attribute7,
mism.attribute8,
mism.attribute9,
mism.attribute10,
mism.attribute11,
mism.attribute12,
mism.attribute13,
mism.attribute14,
mism.attribute15
from
mtl_interorg_ship_methods mism
) x,
table(xxen_wsh_upload.transit_points(null)) tp_o,
table(xxen_wsh_upload.transit_points(null)) tp_d
where
1=1 and
x.origin_type=tp_o.point_type and
x.origin_id=tp_o.id and
x.destination_type=tp_d.point_type and
x.destination_id=tp_d.id
