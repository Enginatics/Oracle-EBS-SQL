/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Cycle Count Upload
-- Description: Enters counts for open cycle count requests and unscheduled counts, as the Cycle Count Entries window (Inventory > Counting > Cycle Counting > Cycle Count Entries).
-- Download the open count requests of a cycle count, enter Count Quantity, Counted By and Count Date, and upload. The counts are processed by the cycle count open interface api: counts within the approval tolerances are adjusted right away, others go to Pending Approval or Recount according to the cycle count setup. Count Date must be in an open inventory period.
-- New rows without a count request create an unscheduled count, where the cycle count allows unscheduled entries. Approving counts is done in the Approve Adjustments window.
-- Excel Example Output: https://www.enginatics.com/example/inv-cycle-count-upload/
-- Library Link: https://www.enginatics.com/reports/inv-cycle-count-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
mcce.cycle_count_entry_id,
mp.organization_code,
mcch.cycle_count_header_name cycle_count,
mcce.count_list_sequence count_sequence,
msiv.concatenated_segments item,
msiv.description item_description,
mcce.revision,
mcce.subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where mcce.locator_id=milk.inventory_location_id and mcce.organization_id=milk.organization_id) locator,
mcce.lot_number,
mcce.serial_number,
nvl(mcce.count_uom_current,msiv.primary_uom_code) uom,
mcce.count_quantity_current count_quantity,
msiv.secondary_uom_code secondary_uom,
mcce.secondary_uom_quantity_current secondary_count_quantity,
(select mtr.reason_name from mtl_transaction_reasons mtr where mcce.transaction_reason_id=mtr.reason_id) reason,
mcce.reference_current reference,
(select mecv.full_name||case when (select count(*) from mtl_employees_current_view mecv2 where mecv.organization_id=mecv2.organization_id and mecv.full_name=mecv2.full_name)>1 then ' ('||mecv.employee_num||')' end from mtl_employees_current_view mecv where mcce.organization_id=mecv.organization_id and mcce.counted_by_employee_id_current=mecv.employee_id) counted_by,
mcce.count_date_current count_date,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where nvl(mcce.inventory_adjustment_account,mcch.inventory_adjustment_account)=gcck.code_combination_id) adjustment_account,
xxen_util.meaning(mcce.entry_status_code,'MTL_CC_ENTRY_STATUSES',700) entry_status,
xxen_util.display_flexfield_context(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category) flexfield_context,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE1',mcce.rowid,mcce.attribute1) cc_attribute1,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE2',mcce.rowid,mcce.attribute2) cc_attribute2,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE3',mcce.rowid,mcce.attribute3) cc_attribute3,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE4',mcce.rowid,mcce.attribute4) cc_attribute4,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE5',mcce.rowid,mcce.attribute5) cc_attribute5,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE6',mcce.rowid,mcce.attribute6) cc_attribute6,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE7',mcce.rowid,mcce.attribute7) cc_attribute7,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE8',mcce.rowid,mcce.attribute8) cc_attribute8,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE9',mcce.rowid,mcce.attribute9) cc_attribute9,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE10',mcce.rowid,mcce.attribute10) cc_attribute10,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE11',mcce.rowid,mcce.attribute11) cc_attribute11,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE12',mcce.rowid,mcce.attribute12) cc_attribute12,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE13',mcce.rowid,mcce.attribute13) cc_attribute13,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE14',mcce.rowid,mcce.attribute14) cc_attribute14,
xxen_util.display_flexfield_value(401,'MTL_CYCLE_COUNT_ENTRIES',mcce.attribute_category,'ATTRIBUTE15',mcce.rowid,mcce.attribute15) cc_attribute15,
to_number(null) upload_row
from
mtl_parameters mp,
mtl_cycle_count_headers mcch,
mtl_cycle_count_entries mcce,
mtl_system_items_vl msiv
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=mcch.organization_id and
mcch.cycle_count_header_id=mcce.cycle_count_header_id and
mcce.entry_status_code in (1,3) and
nvl(mcce.export_flag,2)=2 and
mcce.inventory_item_id=msiv.inventory_item_id and
mcce.organization_id=msiv.organization_id
