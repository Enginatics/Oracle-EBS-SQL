/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Print Cycle Count Entries Open Interface data
-- Description: Imported Oracle standard Print Cycle Count Entries Open Interface data report
Source :Print Cycle Count Entries Open Interface data (XML)
Short Name: INVCCIER_XML
DB package: INV_INVCCIER_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-print-cycle-count-entries-open-interface-data/
-- Library Link: https://www.enginatics.com/reports/inv-print-cycle-count-entries-open-interface-data/
-- Run Report: https://demo.enginatics.com/

select
ood.organization_code,
ood.organization_name,
mceiv.cycle_count_header_name cycle_count_name,
mceiv.count_list_sequence,
ml.meaning action_code,
msiv.concatenated_segments item_number,
msiv.description item_description,
inv_project.get_locator(mil.inventory_location_id,mil.organization_id) locator,
mil.description locator_description,
mceiv.revision,
mceiv.subinventory,
mceiv.lot_number,
mceiv.serial_number,
mceiv.count_unit_of_measure,
mceiv.count_date,
mceiv.count_quantity,
mceiv.employee_full_name,
mceiv.process_flag,
mceiv.process_mode,
mceiv.status_flag,
mceiv.error_flag,
mceiv.parent_lpn parent_license_plate_number,
mceiv.outermost_lpn outermost_license_plate_number,
ccg.cost_group,
mcie.creation_date error_date,
mcie.error_message
from
mtl_cc_entries_interface_v mceiv,
mtl_system_items_vl msiv,
mtl_item_locations mil,
mfg_lookups ml,
cst_cost_groups ccg,
mtl_cc_interface_errors mcie,
org_organization_definitions ood
where
1=1 and
mceiv.inventory_item_id=msiv.inventory_item_id(+) and
mceiv.organization_id=msiv.organization_id(+) and
mceiv.organization_id=mil.organization_id(+) and
mceiv.locator_id=mil.inventory_location_id(+) and
mceiv.action_code=ml.lookup_code and
ml.lookup_type='MTL_CCEOI_ACTION_CODE' and
nvl(mceiv.error_flag,2)=1 and
mceiv.cost_group_id=ccg.cost_group_id (+) and 
mceiv.organization_id=ood.organization_id and
mceiv.cc_entry_interface_id=mcie.cc_entry_interface_id(+)