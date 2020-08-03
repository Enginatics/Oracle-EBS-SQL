/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Stock Locators
-- Description: Summary report for Inventory locations, showing locator number, description, type, status, subinventory, picking order, dropping order and unit, volume, weight, dimension and co-ordinate information.
-- Excel Examle Output: https://www.enginatics.com/example/inv-stock-locators/
-- Library Link: https://www.enginatics.com/reports/inv-stock-locators/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
haout.name organization,
inv_project.get_locator(mil.inventory_location_id,mil.organization_id) locator,
mil.description locator_description,
xxen_util.meaning(mil.inventory_location_type,'MTL_LOCATOR_TYPES',700) locator_type,
mmsv.status_code status,
mil.subinventory_code subinventory,
mil.picking_order,
mil.dropping_order,
mil.alias,
mil.disable_date inactive_on,
mil.location_maximum_units maximum_units,
mil.location_current_units current_units,
mil.location_suggested_units suggested_units,
mil.location_available_units available_units,
mil.volume_uom_code volume_uom,
mil.max_cubic_area maximum_volume,
mil.current_cubic_area current_volume,
mil.suggested_cubic_area suggested_volume,
mil.available_cubic_area available_volume,
mil.location_weight_uom_code weight_uom,
mil.max_weight maximum_weight,
mil.current_weight,
mil.suggested_weight,
mil.available_weight,
mil.pick_uom_code pick_uom,
mil.dimension_uom_code dimension_uom,
mil.length,
mil.width,
mil.height,
mil.x_coordinate,
mil.y_coordinate,
mil.z_coordinate,
xxen_util.user_name(mil.created_by) created_by,
xxen_util.client_time(mil.creation_date) creation_date,
xxen_util.user_name(mil.last_updated_by) last_updated_by,
xxen_util.client_time(mil.last_update_date) last_update_date
from
hr_all_organization_units_tl haout,
mtl_parameters mp,
mtl_item_locations mil,
mtl_material_statuses_vl mmsv
where
1=1 and
mil.organization_id=haout.organization_id and
haout.language=userenv('lang') and
mil.organization_id=mp.organization_id and
mil.status_id=mmsv.status_id(+)
order by
organization_code,
subinventory_code,
locator