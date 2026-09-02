/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Subinventory Upload
-- Description: Create and update Subinventories across accessible inventory organizations.

Accounts and Default Cost Group are tightly linked; the behavior depends on the organization's configuration:

- WMS=No + Standard cost method (with no on-hand or transaction history): the accounts drive the Cost Group. Enter any valid GL detail accounts and the upload auto-resolves the Cost Group — switching to an existing Cost Group whose 7 accounts match, or creating a new one when none matches. The Cost Group action taken is reported in the success message.

- WMS=Yes (any cost method): the Cost Group drives the accounts. Selecting a Cost Group sets all 7 accounts (Material, Outside Processing, Material Overhead, Overhead, Resource, Expense, Encumbrance) to its assigned values. Changing the Cost Group on an existing Subinventory automatically switches all 7 accounts, including clearing accounts that are NULL on the new Cost Group.

- WMS=No + (non-Standard cost method OR the subinventory has on-hand/transaction history): the Cost Group is fixed (existing value on Update, organization default on Create) and the accounts follow it.

All account LOVs restrict to enabled detail (non-summary) GL accounts in the organization's chart of accounts. The Cost Group LOV likewise restricts to selectable Cost Groups per the rules above.

Material Status changes require Oracle's electronic signature workflow when ERES is enabled — those changes must be made via the Subinventories form to preserve the e-signature audit trail.

There is no Delete option — Subinventories can only be inactivated (set Inactive On to a past date).
-- Excel Examle Output: https://www.enginatics.com/example/inv-subinventory-upload/
-- Library Link: https://www.enginatics.com/reports/inv-subinventory-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
null modified_columns_,
mp.organization_code,
msi.secondary_inventory_name name,
msi.description,
mmsv.status_code status,
cg.cost_group default_cost_group,
xxen_util.meaning(msi.subinventory_type,'MTL_SUB_TYPE',700) type,
decode(msi.inventory_atp_code,1,xxen_util.meaning('Y','YES_NO',0)) include_in_atp,
decode(msi.reservable_type,1,xxen_util.meaning('Y','YES_NO',0)) allow_reservation,
decode(msi.availability_type,1,xxen_util.meaning('Y','YES_NO',0)) nettable,
decode(msi.quantity_tracked,1,xxen_util.meaning('Y','YES_NO',0)) quantity_tracked,
decode(msi.asset_inventory,1,xxen_util.meaning('Y','YES_NO',0)) asset_subinventory,
decode(msi.depreciable_flag,1,xxen_util.meaning('Y','YES_NO',0)) depreciable,
decode(msi.planning_level,1,xxen_util.meaning('Y','YES_NO',0)) enable_par_level_planning,
xxen_util.meaning(to_char(msi.locator_type),'MTL_LOCATION_CONTROL',700) locator_control,
mmsv_loc.status_code default_locator_status,
decode(msi.enable_locator_alias,'Y',xxen_util.meaning('Y','YES_NO',0)) enable_locator_alias,
decode(msi.enforce_alias_uniqueness,'Y',xxen_util.meaning('Y','YES_NO',0)) enforce_alias_uniqueness,
msi.picking_order,
msi.dropping_order,
case
when msi.subinventory_type=2 and trunc(msi.disable_date)=to_date('01-01-1700','dd-mm-yyyy') then null
when msi.subinventory_type=2 then msi.disable_date+300*365
else msi.disable_date
end inactive_on,
eeal.approval_list_name notify,
hl.location_code location,
msi.pick_uom_code picking_uom,
xxen_util.meaning(to_char(msi.default_count_type_code),'MTL_COUNT_TYPES',700) default_replenishment_count_type,
xxen_util.meaning(to_char(msi.source_type),'MTL_SOURCE_TYPES',700) source_type,
mp_src.organization_code source_organization,
msi.source_subinventory,
msi.preprocessing_lead_time pre_processing_lt,
msi.processing_lead_time processing_lt,
msi.postprocessing_lead_time post_processing_lt,
gcck_mat.concatenated_segments material,
gcck_op.concatenated_segments outside_processing,
gcck_mo.concatenated_segments material_overhead,
gcck_oh.concatenated_segments overhead,
gcck_res.concatenated_segments resource_account,
gcck_exp.concatenated_segments expense,
gcck_enc.concatenated_segments encumbrance,
decode(msi.lpn_controlled_flag,1,xxen_util.meaning('Y','YES_NO',0)) lpn_controlled,
decode(msi.cartonization_flag,1,xxen_util.meaning('Y','YES_NO',0)) enable_cartonization,
decode(msi.enable_bulk_pick,'Y',xxen_util.meaning('Y','YES_NO',0)) enable_bulk_pick,
decode(msi.enable_opp_cyc_count,'Y',xxen_util.meaning('Y','YES_NO',0)) enable_opportunistic_cycle_count,
mcch.cycle_count_header_name opportunistic_cycle_count_header,
msi.opp_cyc_count_quantity opportunistic_cycle_count_trigger_quantity,
msi.opp_cyc_count_days opportunistic_cycle_count_days_threshold,
xxen_util.display_flexfield_context(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category) attribute_category,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE1',msi.rowid,msi.attribute1) sub_attribute1,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE2',msi.rowid,msi.attribute2) sub_attribute2,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE3',msi.rowid,msi.attribute3) sub_attribute3,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE4',msi.rowid,msi.attribute4) sub_attribute4,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE5',msi.rowid,msi.attribute5) sub_attribute5,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE6',msi.rowid,msi.attribute6) sub_attribute6,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE7',msi.rowid,msi.attribute7) sub_attribute7,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE8',msi.rowid,msi.attribute8) sub_attribute8,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE9',msi.rowid,msi.attribute9) sub_attribute9,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE10',msi.rowid,msi.attribute10) sub_attribute10,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE11',msi.rowid,msi.attribute11) sub_attribute11,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE12',msi.rowid,msi.attribute12) sub_attribute12,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE13',msi.rowid,msi.attribute13) sub_attribute13,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE14',msi.rowid,msi.attribute14) sub_attribute14,
xxen_util.display_flexfield_value(401,'MTL_SECONDARY_INVENTORIES',msi.attribute_category,'ATTRIBUTE15',msi.rowid,msi.attribute15) sub_attribute15,
to_number(null) upload_row
from
mtl_secondary_inventories msi,
mtl_parameters mp,
mtl_material_statuses_vl mmsv,
cst_cost_groups cg,
mtl_material_statuses_vl mmsv_loc,
eng_ecn_approval_lists eeal,
hr_locations hl,
mtl_parameters mp_src,
mtl_cycle_count_headers mcch,
gl_code_combinations_kfv gcck_mat,
gl_code_combinations_kfv gcck_op,
gl_code_combinations_kfv gcck_mo,
gl_code_combinations_kfv gcck_oh,
gl_code_combinations_kfv gcck_res,
gl_code_combinations_kfv gcck_exp,
gl_code_combinations_kfv gcck_enc
where
1=1 and
msi.secondary_inventory_name<>'AX_INTRANS' and
mp.organization_id=msi.organization_id and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mmsv.status_id(+)=msi.status_id and
cg.cost_group_id(+)=msi.default_cost_group_id and
mmsv_loc.status_id(+)=msi.default_loc_status_id and
eeal.approval_list_id(+)=msi.notify_list_id and
hl.location_id(+)=msi.location_id and
mp_src.organization_id(+)=msi.source_organization_id and
mcch.cycle_count_header_id(+)=msi.opp_cyc_count_header_id and
gcck_mat.code_combination_id(+)=msi.material_account and
gcck_op.code_combination_id(+)=msi.outside_processing_account and
gcck_mo.code_combination_id(+)=msi.material_overhead_account and
gcck_oh.code_combination_id(+)=msi.overhead_account and
gcck_res.code_combination_id(+)=msi.resource_account and
gcck_exp.code_combination_id(+)=msi.expense_account and
gcck_enc.code_combination_id(+)=msi.encumbrance_account