/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
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
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
nvl(inv_project.get_locator(milk.inventory_location_id,milk.organization_id),milk.concatenated_segments) locator,
milk.description locator_description,
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
mtl_item_locations_kfv milk,
mfg_lookups ml,
cst_cost_groups ccg,
mtl_cc_interface_errors mcie,
org_organization_definitions ood
where
1=1 and
ood.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mceiv.inventory_item_id=msiv.inventory_item_id(+) and
mceiv.organization_id=msiv.organization_id(+) and
mceiv.organization_id=milk.organization_id(+) and
mceiv.locator_id=milk.inventory_location_id(+) and
mceiv.action_code=ml.lookup_code and
ml.lookup_type='MTL_CCEOI_ACTION_CODE' and
nvl(mceiv.error_flag,2)=1 and
mceiv.cost_group_id=ccg.cost_group_id (+) and 
mceiv.organization_id=ood.organization_id and
mceiv.cc_entry_interface_id=mcie.cc_entry_interface_id(+)