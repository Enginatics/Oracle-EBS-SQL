/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Subinventories
-- Description: Profile subinventory report with subinvnetory name, description, status, default cost group, type, restriction attributes, and general ledger account linkages. For BR100.
-- Excel Examle Output: https://www.enginatics.com/example/inv-subinventories/
-- Library Link: https://www.enginatics.com/reports/inv-subinventories/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
haouv.name organization_name,
msifv.secondary_inventory_name name,
msifv.description,
msifv.status_code status,
msifv.default_cost_group_name default_cost_group,
xxen_util.meaning(msifv.subinventory_type,'MTL_SUB_TYPES',700) subinventory_type,
xxen_util.meaning(msifv.inventory_atp_code,'SYS_YES_NO',700) include_in_atp,
xxen_util.meaning(msifv.reservable_type,'SYS_YES_NO',700) allow_reservation,
xxen_util.meaning(msifv.availability_type,'SYS_YES_NO',700) nettable,
xxen_util.meaning(msifv.quantity_tracked,'SYS_YES_NO',700) quantity_tracked,
xxen_util.meaning(msifv.asset_inventory,'SYS_YES_NO',700) asset_subinventory,
xxen_util.meaning(msifv.depreciable_flag,'SYS_YES_NO',700) depreciable,
xxen_util.meaning(msifv.planning_level,'SYS_YES_NO',700) enable_par_level_planning,
xxen_util.meaning(msifv.enable_locator_alias,'SYS_YES_NO',700) enable_locator_alias,
xxen_util.meaning(msifv.enforce_alias_uniqueness,'SYS_YES_NO',700) enforce_alias_uniqueness,
xxen_util.meaning(msifv.locator_type,'MTL_LOCATION_CONTROL',700) locator_control,
msifv.default_loc_status_code default_locator_status,
msifv.picking_order,
msifv.dropping_order,
msifv.disable_date inactive_on,
msifv.notify_list notify,
msifv.location_code location,
muot.unit_of_measure_tl picking_uom,
xxen_util.meaning(msifv.default_count_type_code,'MTL_COUNT_TYPES',700) default_repl_count_type,
msifv.preprocessing_lead_time,
msifv.processing_lead_time,
msifv.postprocessing_lead_time,
xxen_util.meaning(msifv.source_type,'MTL_SOURCE_TYPES',700) source_type,
msifv.source_organization_code,
haouv2.name source_organization_name,
msifv.source_subinventory,
hla.location_code,
hla.address_line_1,
hla.address_line_2,
hla.town_or_city,
ftv.territory_short_name country,
msifv.material_account,
xxen_util.concatenated_segments(msifv.material_account) material_account,
xxen_util.segments_description(msifv.material_account) material_account_description,
xxen_util.concatenated_segments(msifv.outside_processing_account) outside_processing_account,
xxen_util.segments_description(msifv.outside_processing_account) outside_process_account_desc,
xxen_util.concatenated_segments(msifv.material_overhead_account) material_overhead_account,
xxen_util.segments_description(msifv.material_overhead_account) material_overhead_account_desc,
xxen_util.concatenated_segments(msifv.overhead_account) overhead_account,
xxen_util.segments_description(msifv.overhead_account) overhead_account_desc,
xxen_util.concatenated_segments(msifv.resource_account) resource_account,
xxen_util.segments_description(msifv.resource_account) resource_account_desc,
xxen_util.concatenated_segments(msifv.expense_account) expense_account,
xxen_util.segments_description(msifv.expense_account) expense_account_desc,
xxen_util.concatenated_segments(msifv.encumbrance_account) encumbrance_account,
xxen_util.segments_description(msifv.encumbrance_account) encumbrance_account_desc
from
inv.mtl_parameters mp,
hr_all_organization_units_vl haouv,
mtl_secondary_inventories_fk_v msifv,
hr_all_organization_units_vl haouv2,
hr_locations_all hla,
fnd_territories_vl ftv,
mtl_units_of_measure_tl muot
where
1=1 and
haouv.organization_id=mp.organization_id and
mp.organization_id=msifv.organization_id and
msifv.location_id=hla.location_id(+) and
hla.country=ftv.territory_code(+) and
msifv.source_organization_id=haouv2.organization_id(+) and
msifv.pick_uom_code=muot.uom_code(+) and
muot.language(+)=userenv('lang')
order by
mp.organization_code,
msifv.secondary_inventory_name