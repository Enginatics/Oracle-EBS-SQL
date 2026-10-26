/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: ENG Engineering Change Order Upload
-- Description: Creates and updates engineering change orders (ECOs) with their revised items and revised components - the Engineering Change Orders form (Engineering > ECOs > ECOs).
-- Each row holds one ECO, optionally one of its revised items and one revised component of that revised item. The ECO and revised item columns repeat on every row, and a change in any of these rows is applied. A new ECO is created with status Open.
-- A revised item is identified by item and alternate. An Effective Date in the past is moved to the current date, as in the form. Changing the Effective Date of an existing revised item reschedules it with its revised components, and changing New Item Revision renames the new revision. Revised items are not deleted; set their status to Cancelled instead.
-- Component Action Add adds a component to the bill. Change and Disable refer to the implemented component of the revised item's bill at Old Operation Seq (or Operation Seq when Old Operation Seq is blank) effective at the revised item's effective date; for Change enter only the values that change. Delete Component removes a pending revised component from the ECO.
-- Approval, implementation, substitute components, reference designators and revised operations are maintained in the form.
-- Excel Example Output: https://www.enginatics.com/example/eng-engineering-change-order-upload/
-- Library Link: https://www.enginatics.com/reports/eng-engineering-change-order-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
eri.revised_item_sequence_id revised_item_seq_id,
bcb.component_sequence_id component_seq_id,
mp.organization_code,
eec.change_notice eco,
ecotv.change_order_type eco_type,
ecsv.status_name eco_status,
xxen_eng_upload.requestor(eec.requestor_id) requestor,
haouv.name eco_department,
eec.reason_code reason,
eec.priority_code priority,
xxen_util.meaning(eec.approval_status_type,'ENG_ECN_APPROVAL_STATUS',700) approval_status,
eec.description eco_description,
eec.estimated_eng_cost engineering_cost,
eec.estimated_mfg_cost manufacturing_cost,
xxen_util.display_flexfield_context(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category) eco_attribute_category,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE1',eec.rowid,eec.attribute1) eco_attribute1,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE2',eec.rowid,eec.attribute2) eco_attribute2,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE3',eec.rowid,eec.attribute3) eco_attribute3,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE4',eec.rowid,eec.attribute4) eco_attribute4,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE5',eec.rowid,eec.attribute5) eco_attribute5,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE6',eec.rowid,eec.attribute6) eco_attribute6,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE7',eec.rowid,eec.attribute7) eco_attribute7,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE8',eec.rowid,eec.attribute8) eco_attribute8,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE9',eec.rowid,eec.attribute9) eco_attribute9,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE10',eec.rowid,eec.attribute10) eco_attribute10,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE11',eec.rowid,eec.attribute11) eco_attribute11,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE12',eec.rowid,eec.attribute12) eco_attribute12,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE13',eec.rowid,eec.attribute13) eco_attribute13,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE14',eec.rowid,eec.attribute14) eco_attribute14,
xxen_util.display_flexfield_value(703,'ENG_ENGINEERING_CHANGES',eec.attribute_category,'ATTRIBUTE15',eec.rowid,eec.attribute15) eco_attribute15,
msiv.concatenated_segments revised_item,
msiv.description revised_item_description,
eri.alternate_bom_designator alternate,
eri.new_item_revision,
mirv.description item_revision_description,
eri.new_routing_revision,
eri.scheduled_date effective_date,
xxen_util.meaning(eri.status_type,'ECG_ECN_STATUS',700) revised_item_status,
decode(eri.mrp_active,1,xxen_util.meaning('1','SYS_YES_NO',700)) mrp_active,
eri.early_schedule_date early_effective_date,
eri.implementation_date implemented_date,
decode(eri.update_wip,1,xxen_util.meaning('1','SYS_YES_NO',700)) update_jobs,
xxen_util.meaning(eri.disposition_type,'ECG_MATERIAL_DISPOSITION',700) disposition,
eri.descriptive_text change_description,
xxen_util.display_flexfield_context(703,'ENG_REVISED_ITEMS',eri.attribute_category) ri_attribute_category,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE1',eri.rowid,eri.attribute1) ri_attribute1,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE2',eri.rowid,eri.attribute2) ri_attribute2,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE3',eri.rowid,eri.attribute3) ri_attribute3,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE4',eri.rowid,eri.attribute4) ri_attribute4,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE5',eri.rowid,eri.attribute5) ri_attribute5,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE6',eri.rowid,eri.attribute6) ri_attribute6,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE7',eri.rowid,eri.attribute7) ri_attribute7,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE8',eri.rowid,eri.attribute8) ri_attribute8,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE9',eri.rowid,eri.attribute9) ri_attribute9,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE10',eri.rowid,eri.attribute10) ri_attribute10,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE11',eri.rowid,eri.attribute11) ri_attribute11,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE12',eri.rowid,eri.attribute12) ri_attribute12,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE13',eri.rowid,eri.attribute13) ri_attribute13,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE14',eri.rowid,eri.attribute14) ri_attribute14,
xxen_util.display_flexfield_value(703,'ENG_REVISED_ITEMS',eri.attribute_category,'ATTRIBUTE15',eri.rowid,eri.attribute15) ri_attribute15,
xxen_util.meaning(bcb.acd_type,'ECG_ACTION',700) component_action,
(select msiv_c.concatenated_segments from mtl_system_items_vl msiv_c where bcb.component_item_id=msiv_c.inventory_item_id and eri.organization_id=msiv_c.organization_id) component,
(select msiv_c.description from mtl_system_items_vl msiv_c where bcb.component_item_id=msiv_c.inventory_item_id and eri.organization_id=msiv_c.organization_id) component_description,
decode(bcb.acd_type,1,to_number(null),bcb_old.operation_seq_num) old_operation_seq,
bcb.operation_seq_num operation_seq,
bcb.item_num item_seq,
xxen_util.meaning(bcb.basis_type,'BOM_BASIS_TYPE',700) basis,
bcb.component_quantity quantity,
bcb.disable_date,
bcb.planning_factor planning_percent,
bcb.component_yield_factor yield,
xxen_util.meaning(bcb.enforce_int_requirements,'BOM_ENFORCE_INT_REQUIREMENTS',700) enforce_int_requirements,
decode(bcb.include_in_cost_rollup,1,xxen_util.meaning('1','SYS_YES_NO',700)) include_in_cost_rollup,
xxen_util.meaning(bcb.wip_supply_type,'WIP_SUPPLY',700) supply_type,
bcb.supply_subinventory,
decode(bcb.check_atp,1,xxen_util.meaning('1','SYS_YES_NO',700)) check_atp,
decode(bcb.optional,1,xxen_util.meaning('1','SYS_YES_NO',700)) optional,
decode(bcb.mutually_exclusive_options,1,xxen_util.meaning('1','SYS_YES_NO',700)) mutually_exclusive,
bcb.low_quantity minimum_quantity,
bcb.high_quantity maximum_quantity,
decode(bcb.include_on_ship_docs,1,xxen_util.meaning('1','SYS_YES_NO',700)) include_on_ship_docs,
decode(bcb.required_to_ship,1,xxen_util.meaning('1','SYS_YES_NO',700)) required_to_ship,
decode(bcb.required_for_revenue,1,xxen_util.meaning('1','SYS_YES_NO',700)) required_for_revenue,
bcb.component_remarks component_comments,
null delete_component,
xxen_util.display_flexfield_context(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category) comp_attribute_category,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE1',bcb.rowid,bcb.attribute1) comp_attribute1,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE2',bcb.rowid,bcb.attribute2) comp_attribute2,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE3',bcb.rowid,bcb.attribute3) comp_attribute3,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE4',bcb.rowid,bcb.attribute4) comp_attribute4,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE5',bcb.rowid,bcb.attribute5) comp_attribute5,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE6',bcb.rowid,bcb.attribute6) comp_attribute6,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE7',bcb.rowid,bcb.attribute7) comp_attribute7,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE8',bcb.rowid,bcb.attribute8) comp_attribute8,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE9',bcb.rowid,bcb.attribute9) comp_attribute9,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE10',bcb.rowid,bcb.attribute10) comp_attribute10,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE11',bcb.rowid,bcb.attribute11) comp_attribute11,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE12',bcb.rowid,bcb.attribute12) comp_attribute12,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE13',bcb.rowid,bcb.attribute13) comp_attribute13,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE14',bcb.rowid,bcb.attribute14) comp_attribute14,
xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bcb.attribute_category,'ATTRIBUTE15',bcb.rowid,bcb.attribute15) comp_attribute15,
to_number(null) upload_row
from
mtl_parameters mp,
eng_engineering_changes eec,
eng_change_order_types_vl ecotv,
eng_change_statuses_vl ecsv,
hr_all_organization_units_vl haouv,
(select eri.* from eng_revised_items eri where eri.transfer_or_copy in ('L','O') or eri.transfer_or_copy is null) eri,
mtl_system_items_vl msiv,
mtl_item_revisions_vl mirv,
bom_components_b bcb,
bom_components_b bcb_old
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=eec.organization_id and
eec.change_order_type_id=ecotv.change_order_type_id and
ecotv.base_change_mgmt_type_code='CHANGE_ORDER' and
eec.status_type=ecsv.status_code(+) and
eec.responsible_organization_id=haouv.organization_id(+) and
eec.change_notice=eri.change_notice(+) and
eec.organization_id=eri.organization_id(+) and
eri.revised_item_id=msiv.inventory_item_id(+) and
eri.organization_id=msiv.organization_id(+) and
eri.new_item_revision_id=mirv.revision_id(+) and
eri.revised_item_sequence_id=bcb.revised_item_sequence_id(+) and
bcb.old_component_sequence_id=bcb_old.component_sequence_id(+)
