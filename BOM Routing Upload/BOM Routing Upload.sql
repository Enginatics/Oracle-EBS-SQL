/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Routing Upload
-- Description: Report: BOM Routing Upload

This upload can be used to create and/or update existing manufacturing BOM Routings.
- Create new Standard, Flow, and Lot Based (Network) Routings
- Update or Delete existing Standard, Flow, and Lot Based (Network) Routings
- Upload new Common Routing Assignments

-- Excel Examle Output: https://www.enginatics.com/example/bom-routing-upload/
-- Library Link: https://www.enginatics.com/reports/bom-routing-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
:p_upload_mode upload_mode,
:p_archive_deletes archive_deletes,
:p_end_date_matching_ops end_date_matching_ops,
--
rtg.*
from
(
--
-- Q1 = Resources
--
select
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
msiv.primary_uom_code uom,
--
-- routing
--
xxen_util.meaning(bor.routing_type,'BOM_ASSEMBLY_TYPE',700) assembly_type, -- 1-Standard Assembly 2-Engingeering Assembly (Default 1)
bor.alternate_routing_designator alternate,
xxen_util.meaning(bor.ctp_flag,'SYS_YES_NO',700) capable_to_promise,
--> flow
decode(bor.cfm_routing_flag,1,'Flow',2,'Standard',3,'Lot Based') routing_type,
bor.cfm_routing_flag cfm_routing_flag, -- 1-Flow, 2-Discrete, 3-Lot Based Network (Default 2)
wl.line_code line,
bor.total_product_cycle_time total_cycle_time,
--< flow
bor.priority,
bor.serialization_start_op serialization_start_op_seq,  -- not flow
xxen_util.meaning(bor.mixed_model_map_flag,'SYS_YES_NO',700) mixed_model_map, -- flow
bor.completion_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.organization_id = bor.organization_id and milk.inventory_location_id = bor.completion_locator_id) completion_locator,
bor.routing_comment,
bor.original_system_reference routing_orig_sys_ref,
(select msiv2.concatenated_segments from mtl_system_items_vl msiv2 where msiv2.organization_id = bor.organization_id and msiv2.inventory_item_id = bor.common_assembly_item_id) common_routing_item,
(select msiv2.description from mtl_system_items_vl msiv2 where msiv2.organization_id = bor.organization_id and msiv2.inventory_item_id = bor.common_assembly_item_id) common_routing_item_desc,
null delete_routing,
--
xxen_util.display_flexfield_context(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category) routing_attribute_category,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE1',null,bor.attribute1) bom_rtg_attribute1,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE2',null,bor.attribute2) bom_rtg_attribute2,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE3',null,bor.attribute3) bom_rtg_attribute3,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE4',null,bor.attribute4) bom_rtg_attribute4,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE5',null,bor.attribute5) bom_rtg_attribute5,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE6',null,bor.attribute6) bom_rtg_attribute6,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE7',null,bor.attribute7) bom_rtg_attribute7,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE8',null,bor.attribute8) bom_rtg_attribute8,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE9',null,bor.attribute9) bom_rtg_attribute9,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE10',null,bor.attribute10) bom_rtg_attribute10,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE11',null,bor.attribute11) bom_rtg_attribute11,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE12',null,bor.attribute12) bom_rtg_attribute12,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE13',null,bor.attribute13) bom_rtg_attribute13,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE14',null,bor.attribute14) bom_rtg_attribute14,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE15',null,bor.attribute15) bom_rtg_attribute15,
--
-- revision
--
mrir.process_revision revision,
mrir.effectivity_date revision_effectivity_date,
mrir.implementation_date revision_implement_date,
null delete_revision,
xxen_util.display_flexfield_context(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category) revision_attribute_category,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE1',null,mrir.attribute1) bom_rtg_rev_attribute1,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE2',null,mrir.attribute2) bom_rtg_rev_attribute2,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE3',null,mrir.attribute3) bom_rtg_rev_attribute3,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE4',null,mrir.attribute4) bom_rtg_rev_attribute4,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE5',null,mrir.attribute5) bom_rtg_rev_attribute5,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE6',null,mrir.attribute6) bom_rtg_rev_attribute6,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE7',null,mrir.attribute7) bom_rtg_rev_attribute7,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE8',null,mrir.attribute8) bom_rtg_rev_attribute8,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE9',null,mrir.attribute9) bom_rtg_rev_attribute9,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE10',null,mrir.attribute10) bom_rtg_rev_attribute10,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE11',null,mrir.attribute11) bom_rtg_rev_attribute11,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE12',null,mrir.attribute12) bom_rtg_rev_attribute12,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE13',null,mrir.attribute13) bom_rtg_rev_attribute13,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE14',null,mrir.attribute14) bom_rtg_rev_attribute14,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE15',null,mrir.attribute15) bom_rtg_rev_attribute15,
--
-- operations
--
bos.operation_seq_num operation_seq,
xxen_util.meaning(bos.operation_type,'BOM_OPERATION_TYPE',700) operation_type,
bos.effectivity_date operation_effectivity_date, -- discrete/flow event
bos.implementation_date operation_implementation_date, -- discrete/flow event
bos.disable_date operation_disable_date, -- discrete/flow event
bso.operation_code,
xxen_util.meaning(bos.reference_flag,'SYS_YES_NO',700) referenced,
bd.department_code department,
--> flow event type
bso1.operation_code process,
bos1.operation_seq_num process_seq,
bso2.operation_code line_op,
bos2.operation_seq_num line_op_seq,
--< flow event type
xxen_util.meaning(bos.option_dependent_flag,'SYS_YES_NO',700) option_dependent, -- discrete/flow event
bos.operation_lead_time_percent lead_time_pct,
xxen_util.meaning(bos.count_point_type,'SYS_YES_NO',700) count_point,
xxen_util.meaning(decode(bos.count_point_type,3,2,1),'SYS_YES_NO',700) autocharge,
xxen_util.meaning(bos.backflush_flag,'SYS_YES_NO',700) backflush,
xxen_util.meaning(bos.check_skill,'SYS_YES_NO',700) check_skill,
bos.minimum_transfer_quantity min_transfer_qty,
bos.yield,
bos.cumulative_yield,
--> flow
bos.reverse_cumulative_yield reverse_cum_yield,
bos.net_planning_percent net_planning_pct,
bos.labor_time_calc calculated_labor_time,
bos.machine_time_calc calculated_machine_time,
bos.total_time_calc calculated_elapsed_time,
bos.labor_time_user user_labor_time,
bos.machine_time_user user_machine_time,
bos.total_time_user user_elapsed_time,
--< flow
xxen_util.meaning(bos.include_in_rollup,'SYS_YES_NO',700) include_in_rollup, --discrete
bos.change_notice eco, -- discrete/flow event
bos.operation_description,
bos.original_system_reference operation_orig_sys_ref,
null delete_operation,
--
xxen_util.display_flexfield_context(702,'OPERATIONS',bos.attribute_category) operation_attribute_category,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE1',null,bos.attribute1) bom_rtg_op_attribute1,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE2',null,bos.attribute2) bom_rtg_op_attribute2,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE3',null,bos.attribute3) bom_rtg_op_attribute3,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE4',null,bos.attribute4) bom_rtg_op_attribute4,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE5',null,bos.attribute5) bom_rtg_op_attribute5,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE6',null,bos.attribute6) bom_rtg_op_attribute6,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE7',null,bos.attribute7) bom_rtg_op_attribute7,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE8',null,bos.attribute8) bom_rtg_op_attribute8,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE9',null,bos.attribute9) bom_rtg_op_attribute9,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE10',null,bos.attribute10) bom_rtg_op_attribute10,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE11',null,bos.attribute11) bom_rtg_op_attribute11,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE12',null,bos.attribute12) bom_rtg_op_attribute12,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE13',null,bos.attribute13) bom_rtg_op_attribute13,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE14',null,bos.attribute14) bom_rtg_op_attribute14,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE15',null,bos.attribute15) bom_rtg_op_attribute15,
--
-- operation resource
--
null substitute_resource_flag,
borsc.resource_seq_num resource_seq,
borsc.substitute_group_num,
to_number(null) replacement_group_num,
br.resource_code resource_code,
br.unit_of_measure resource_uom,
xxen_util.meaning(borsc.basis_type,'BOM_BASIS_TYPE',700) resource_basis,
borsc.usage_rate_or_amount usage_rate_or_amount,
borsc.usage_rate_or_amount_inverse inverse_rate_or_amount,
(select xxen_util.meaning(bdr.available_24_hours_flag,'SYS_YES_NO',700) from bom_department_resources bdr where bdr.department_id = bos.department_id and bdr.resource_id = borsc.resource_id) available_24_hours,
borsc.schedule_seq_num,
xxen_util.meaning(borsc.schedule_flag,'BOM_RESOURCE_SCHEDULE_TYPE',700) schedule,
borsc.assigned_units,
borsc.resource_offset_percent offset_pct,
xxen_util.meaning(borsc.principle_flag,'SYS_YES_NO',700) principle_flag,
(select bst.setup_code from bom_setup_types bst where bst.setup_id = borsc.setup_id) setup_type,
(select cavv.activity from cst_activities_val_v cavv where cavv.activity_id = borsc.activity_id and nvl(cavv.organization_id,mp.organization_id) = mp.organization_id) activity,
xxen_util.meaning(borsc.standard_rate_flag,'SYS_YES_NO',700) standard_rate,
xxen_util.meaning(borsc.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) charge_type,
borsc.original_system_reference resource_orig_sys_ref,
null delete_resource,
-- resource dffs
xxen_util.display_flexfield_context(702,'OPERATION_RESOURCES',borsc.attribute_category) resource_attribute_category,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE1',null,borsc.attribute1) bom_rtg_op_rsc_attribute1,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE2',null,borsc.attribute2) bom_rtg_op_rsc_attribute2,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE3',null,borsc.attribute3) bom_rtg_op_rsc_attribute3,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE4',null,borsc.attribute4) bom_rtg_op_rsc_attribute4,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE5',null,borsc.attribute5) bom_rtg_op_rsc_attribute5,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE6',null,borsc.attribute6) bom_rtg_op_rsc_attribute6,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE7',null,borsc.attribute7) bom_rtg_op_rsc_attribute7,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE8',null,borsc.attribute8) bom_rtg_op_rsc_attribute8,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE9',null,borsc.attribute9) bom_rtg_op_rsc_attribute9,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE10',null,borsc.attribute10) bom_rtg_op_rsc_attribute10,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE11',null,borsc.attribute11) bom_rtg_op_rsc_attribute11,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE12',null,borsc.attribute12) bom_rtg_op_rsc_attribute12,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE13',null,borsc.attribute13) bom_rtg_op_rsc_attribute13,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE14',null,borsc.attribute14) bom_rtg_op_rsc_attribute14,
xxen_util.display_flexfield_value(702,'OPERATION_RESOURCES',borsc.attribute_category,'ATTRIBUTE15',null,borsc.attribute15) bom_rtg_op_rsc_attribute15,
-- substitute resource dffs
null sub_rsc_attribute_category,
null bom_rtg_op_sub_rsc_attribute1,
null bom_rtg_op_sub_rsc_attribute2,
null bom_rtg_op_sub_rsc_attribute3,
null bom_rtg_op_sub_rsc_attribute4,
null bom_rtg_op_sub_rsc_attribute5,
null bom_rtg_op_sub_rsc_attribute6,
null bom_rtg_op_sub_rsc_attribute7,
null bom_rtg_op_sub_rsc_attribute8,
null bom_rtg_op_sub_rsc_attribute9,
null bom_rtg_op_sub_rsc_attribute10,
null bom_rtg_op_sub_rsc_attribute11,
null bom_rtg_op_sub_rsc_attribute12,
null bom_rtg_op_sub_rsc_attribute13,
null bom_rtg_op_sub_rsc_attribute14,
null bom_rtg_op_sub_rsc_attribute15,
--
-- routing network
--
to_number(null) network_to_operation_seq,
null network_transition_type,
to_number(null) network_planning_pct,
null network_orig_sys_ref,
null delete_network_link,
null network_to_operation_code,
null network_to_department,
null network_to_operation_desc,
to_date(null) network_to_op_effectivity_date,
--
-- ids
bor.organization_id,
bor.assembly_item_id,
bor.routing_sequence_id,
bos.operation_sequence_id,
rowidtochar(borsc.rowid) rsc_rowid,
null network_rowid,
to_number(null) upload_row
from
mtl_parameters mp,
mtl_system_items_vl msiv,
bom_operational_routings bor,
mtl_rtg_item_revisions mrir,
wip_lines wl,
--
bom_operation_sequences bos,
bom_departments bd,
bom_standard_operations bso,
bom_operation_sequences bos1,
bom_standard_operations bso1,
bom_operation_sequences bos2,
bom_standard_operations bso2,
--
bom_operation_resources borsc,
bom_resources br
where
1=1 and
mp.organization_code = :p_organization_code and
bor.routing_type = nvl(:p_bom_eng_flag,1) and -- Assembly Type
nvl(bor.cfm_routing_flag,2) = nvl(:p_cfm_routing_flag,2) and -- Routing Type
nvl(:p_revision,'?') = nvl(:p_revision,'?') and
nvl(:p_restrict_org,'?') = nvl(:p_restrict_org,'?') and
msiv.bom_enabled_flag = 'Y' and
nvl(msiv.eam_item_type,3) = 3 and -- excluding enterprise asset management maintenance routings
--
bor.organization_id = mp.organization_id and
bor.assembly_item_id = msiv.inventory_item_id and
bor.organization_id = msiv.organization_id and
bor.organization_id = mrir.organization_id and
bor.assembly_item_id = mrir.inventory_item_id and
mrir.effectivity_date = nvl((select max(mrir2.effectivity_date) from mtl_rtg_item_revisions mrir2 where mrir2.organization_id = bor.organization_id and mrir2.inventory_item_id = bor.assembly_item_id and mrir2.effectivity_date <= nvl(:p_effective_date,sysdate)),
                            (select min(mrir2.effectivity_date) from mtl_rtg_item_revisions mrir2 where mrir2.organization_id = bor.organization_id and mrir2.inventory_item_id = bor.assembly_item_id)
                           ) and
bor.line_id = wl.line_id(+) and
bor.organization_id = wl.organization_id(+) and
--
decode(:p_show_operations,'Y',bor.routing_sequence_id) = bos.routing_sequence_id(+) and
bos.department_id = bd.department_id (+) and
--
(:p_show_operations is null or
 ( :p_com_routing_assign_Flag != 'R' and
   bor.common_assembly_item_id is null and
   (:p_bom_display_type = 1 or  -- All
    (:p_bom_display_type = 2 and -- Current
     bos.effectivity_date <= :p_effective_date and
     nvl(bos.disable_date, :p_effective_date + 1) >= :p_effective_date
    ) or
    (:p_bom_display_type = 3 and -- Future and Current
     nvl(bos.disable_date, :p_effective_date + 1) >= :p_effective_date and
     bos.routing_sequence_id is not null
    )
   ) and
   ((:p_implemented_only = 'Y' and bos.implementation_date is not null) or
    nvl(:p_implemented_only,'N') = 'N'
   )
 ) or
 ( :p_com_routing_assign_Flag in ('I','R') and
   bor.common_assembly_item_id is not null
 )
) and
--
bos.standard_operation_id=bso.standard_operation_id(+) and
bos.process_op_seq_id = bos1.operation_sequence_id (+) and
bos1.standard_operation_id = bso1.standard_operation_id (+) and
bos.line_op_seq_id = bos2.operation_sequence_id (+) and
bos2.standard_operation_id = bso2.standard_operation_id (+) and
--
decode(:p_show_resources,'Y',decode(bos.operation_type,1,bos.operation_sequence_id)) = borsc.operation_sequence_id (+) and
borsc.resource_id = br.resource_id (+) and
-- to ensure the operation sequences are always displayed even if no subresources or networks exist for the operation sequence, but not duplicated
( br.resource_code is not null or
  (:p_show_sub_resources is null and :p_show_networks is null) or
  not exists
  (select 'Y' from bom_sub_operation_resources bsor where :p_show_sub_resources = 'Y' and bsor.operation_sequence_id = decode(bos.operation_type,1,bos.operation_sequence_id) and rownum = 1 union
   select 'Y' from bom_operation_networks bon where :p_show_networks = 'Y' and bon.from_op_seq_id = decode(bos.operation_type,1,bos.operation_sequence_id) and rownum = 1
  )
) and
( :p_sub_resource_exists is null or
  exists (select 'Y' from bom_operation_sequences bos2, bom_sub_operation_resources bsor where :p_show_sub_resources = 'Y' and bos2.routing_sequence_id = bor.routing_sequence_id and bsor.operation_sequence_id = decode(bos2.operation_type,1,bos2.operation_sequence_id) and rownum = 1)
) and
( :p_network_exists is null or
  exists (select 'Y' from bom_operation_sequences bos2, bom_operation_networks bon where :p_show_networks = 'Y' and bos2.routing_sequence_id = bor.routing_sequence_id and bon.from_op_seq_id = decode(bos2.operation_type,1,bos2.operation_sequence_id) and rownum = 1)
)
--
union all
--
-- Q2 = Substitute Resources
--
select
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
msiv.primary_uom_code uom,
--
-- routing
--
xxen_util.meaning(bor.routing_type,'BOM_ASSEMBLY_TYPE',700) assembly_type,
bor.alternate_routing_designator alternate,
xxen_util.meaning(bor.ctp_flag,'SYS_YES_NO',700) capable_to_promise,
--> flow
decode(bor.cfm_routing_flag,1,'Flow',2,'Standard',3,'Lot Based') routing_type,
bor.cfm_routing_flag cfm_routing_flag,
wl.line_code line,
bor.total_product_cycle_time total_cycle_time,
--< flow
bor.priority,
bor.serialization_start_op serialization_start_op_seq,  -- not flow
xxen_util.meaning(bor.mixed_model_map_flag,'SYS_YES_NO',700) mixed_model_map, -- flow
bor.completion_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.organization_id = bor.organization_id and milk.inventory_location_id = bor.completion_locator_id) completion_locator,
bor.routing_comment,
bor.original_system_reference routing_orig_sys_ref,
(select msiv2.concatenated_segments from mtl_system_items_vl msiv2 where msiv2.organization_id = bor.organization_id and msiv2.inventory_item_id = bor.common_assembly_item_id) common_routing_item,
(select msiv2.description from mtl_system_items_vl msiv2 where msiv2.organization_id = bor.organization_id and msiv2.inventory_item_id = bor.common_assembly_item_id) common_routing_item_desc,
null delete_routing,
--
xxen_util.display_flexfield_context(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category) routing_attribute_category,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE1',null,bor.attribute1) bom_rtg_attribute1,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE2',null,bor.attribute2) bom_rtg_attribute2,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE3',null,bor.attribute3) bom_rtg_attribute3,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE4',null,bor.attribute4) bom_rtg_attribute4,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE5',null,bor.attribute5) bom_rtg_attribute5,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE6',null,bor.attribute6) bom_rtg_attribute6,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE7',null,bor.attribute7) bom_rtg_attribute7,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE8',null,bor.attribute8) bom_rtg_attribute8,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE9',null,bor.attribute9) bom_rtg_attribute9,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE10',null,bor.attribute10) bom_rtg_attribute10,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE11',null,bor.attribute11) bom_rtg_attribute11,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE12',null,bor.attribute12) bom_rtg_attribute12,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE13',null,bor.attribute13) bom_rtg_attribute13,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE14',null,bor.attribute14) bom_rtg_attribute14,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE15',null,bor.attribute15) bom_rtg_attribute15,
--
-- revision
--
mrir.process_revision revision,
mrir.effectivity_date revision_effectivity_date,
mrir.implementation_date revision_implement_date,
null delete_revision,
xxen_util.display_flexfield_context(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category) revision_attribute_category,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE1',null,mrir.attribute1) bom_rtg_rev_attribute1,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE2',null,mrir.attribute2) bom_rtg_rev_attribute2,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE3',null,mrir.attribute3) bom_rtg_rev_attribute3,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE4',null,mrir.attribute4) bom_rtg_rev_attribute4,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE5',null,mrir.attribute5) bom_rtg_rev_attribute5,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE6',null,mrir.attribute6) bom_rtg_rev_attribute6,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE7',null,mrir.attribute7) bom_rtg_rev_attribute7,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE8',null,mrir.attribute8) bom_rtg_rev_attribute8,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE9',null,mrir.attribute9) bom_rtg_rev_attribute9,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE10',null,mrir.attribute10) bom_rtg_rev_attribute10,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE11',null,mrir.attribute11) bom_rtg_rev_attribute11,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE12',null,mrir.attribute12) bom_rtg_rev_attribute12,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE13',null,mrir.attribute13) bom_rtg_rev_attribute13,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE14',null,mrir.attribute14) bom_rtg_rev_attribute14,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE15',null,mrir.attribute15) bom_rtg_rev_attribute15,
--
-- operations
--
bos.operation_seq_num operation_seq,
xxen_util.meaning(bos.operation_type,'BOM_OPERATION_TYPE',700) operation_type,
bos.effectivity_date operation_effectivity_date, -- discrete/flow event
bos.implementation_date operation_implementation_date, -- discrete/flow event
bos.disable_date operation_disable_date, -- discrete/flow event
bso.operation_code,
xxen_util.meaning(bos.reference_flag,'SYS_YES_NO',700) referenced,
bd.department_code department,
--> flow event type
bso1.operation_code process,
bos1.operation_seq_num process_seq,
bso2.operation_code line_op,
bos2.operation_seq_num line_op_seq,
--< flow event type
xxen_util.meaning(bos.option_dependent_flag,'SYS_YES_NO',700) option_dependent, -- discrete/flow event
bos.operation_lead_time_percent lead_time_pct,
xxen_util.meaning(bos.count_point_type,'SYS_YES_NO',700) count_point,
xxen_util.meaning(decode(bos.count_point_type,3,2,1),'SYS_YES_NO',700) autocharge,
xxen_util.meaning(bos.backflush_flag,'SYS_YES_NO',700) backflush,
xxen_util.meaning(bos.check_skill,'SYS_YES_NO',700) check_skill,
bos.minimum_transfer_quantity min_transfer_qty,
bos.yield,
bos.cumulative_yield,
--> flow
bos.reverse_cumulative_yield reverse_cum_yield,
bos.net_planning_percent net_planning_pct,
bos.labor_time_calc calculated_labor_time,
bos.machine_time_calc calculated_machine_time,
bos.total_time_calc calculated_elapsed_time,
bos.labor_time_user user_labor_time,
bos.machine_time_user user_machine_time,
bos.total_time_user user_elapsed_time,
--< flow
xxen_util.meaning(bos.include_in_rollup,'SYS_YES_NO',700) include_in_rollup, --discrete
bos.change_notice eco, -- discrete/flow event
bos.operation_description,
bos.original_system_reference operation_orig_sys_ref,
null delete_operation,
--
xxen_util.display_flexfield_context(702,'OPERATIONS',bos.attribute_category) operation_attribute_category,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE1',null,bos.attribute1) bom_rtg_op_attribute1,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE2',null,bos.attribute2) bom_rtg_op_attribute2,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE3',null,bos.attribute3) bom_rtg_op_attribute3,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE4',null,bos.attribute4) bom_rtg_op_attribute4,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE5',null,bos.attribute5) bom_rtg_op_attribute5,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE6',null,bos.attribute6) bom_rtg_op_attribute6,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE7',null,bos.attribute7) bom_rtg_op_attribute7,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE8',null,bos.attribute8) bom_rtg_op_attribute8,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE9',null,bos.attribute9) bom_rtg_op_attribute9,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE10',null,bos.attribute10) bom_rtg_op_attribute10,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE11',null,bos.attribute11) bom_rtg_op_attribute11,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE12',null,bos.attribute12) bom_rtg_op_attribute12,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE13',null,bos.attribute13) bom_rtg_op_attribute13,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE14',null,bos.attribute14) bom_rtg_op_attribute14,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE15',null,bos.attribute15) bom_rtg_op_attribute15,
--
-- operation sub resource
--
xxen_util.meaning('Y','YES_NO',0) substitute_resource_flag,
to_number(null) resource_seq,
bsor.substitute_group_num,
bsor.replacement_group_num,
br.resource_code resource_code,
br.unit_of_measure resource_uom,
xxen_util.meaning(bsor.basis_type,'BOM_BASIS_TYPE',700) resource_basis,
bsor.usage_rate_or_amount usage_rate_or_amount,
bsor.usage_rate_or_amount_inverse inverse_rate_or_amount,
null available_24_hours,
bsor.schedule_seq_num,
xxen_util.meaning(bsor.schedule_flag,'BOM_RESOURCE_SCHEDULE_TYPE',700) schedule,
bsor.assigned_units,
bsor.resource_offset_percent offset_pct,
xxen_util.meaning(bsor.principle_flag,'SYS_YES_NO',700) principle_flag,
(select bst.setup_code from bom_setup_types bst where bst.setup_id = bsor.setup_id) setup_type,
(select cavv.activity from cst_activities_val_v cavv where cavv.activity_id = bsor.activity_id and nvl(cavv.organization_id,mp.organization_id) = mp.organization_id) activity,
xxen_util.meaning(bsor.standard_rate_flag,'SYS_YES_NO',700) standard_rate,
xxen_util.meaning(bsor.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) charge_type,
bsor.original_system_reference resource_orig_sys_ref,
null delete_resource,
-- resource dffs
null resource_attribute_category,
null bom_rtg_op_rsc_attribute1,
null bom_rtg_op_rsc_attribute2,
null bom_rtg_op_rsc_attribute3,
null bom_rtg_op_rsc_attribute4,
null bom_rtg_op_rsc_attribute5,
null bom_rtg_op_rsc_attribute6,
null bom_rtg_op_rsc_attribute7,
null bom_rtg_op_rsc_attribute8,
null bom_rtg_op_rsc_attribute9,
null bom_rtg_op_rsc_attribute10,
null bom_rtg_op_rsc_attribute11,
null bom_rtg_op_rsc_attribute12,
null bom_rtg_op_rsc_attribute13,
null bom_rtg_op_rsc_attribute14,
null bom_rtg_op_rsc_attribute15,
-- substitute ressource dffs
xxen_util.display_flexfield_context(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category) sub_rsc_attribute_category,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE1',null,bsor.attribute1) bom_rtg_op_sub_rsc_attribute1,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE2',null,bsor.attribute2) bom_rtg_op_sub_rsc_attribute2,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE3',null,bsor.attribute3) bom_rtg_op_sub_rsc_attribute3,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE4',null,bsor.attribute4) bom_rtg_op_sub_rsc_attribute4,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE5',null,bsor.attribute5) bom_rtg_op_sub_rsc_attribute5,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE6',null,bsor.attribute6) bom_rtg_op_sub_rsc_attribute6,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE7',null,bsor.attribute7) bom_rtg_op_sub_rsc_attribute7,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE8',null,bsor.attribute8) bom_rtg_op_sub_rsc_attribute8,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE9',null,bsor.attribute9) bom_rtg_op_sub_rsc_attribute9,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE10',null,bsor.attribute10) bom_rtg_op_sub_rsc_attribute10,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE11',null,bsor.attribute11) bom_rtg_op_sub_rsc_attribute11,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE12',null,bsor.attribute12) bom_rtg_op_sub_rsc_attribute12,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE13',null,bsor.attribute13) bom_rtg_op_sub_rsc_attribute13,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE14',null,bsor.attribute14) bom_rtg_op_sub_rsc_attribute14,
xxen_util.display_flexfield_value(702,'SUB_OPERATION_RESOURCES',bsor.attribute_category,'ATTRIBUTE15',null,bsor.attribute15) bom_rtg_op_sub_rsc_attribute15,
--
-- routing network
--
to_number(null) network_to_operation_seq,
null network_transition_type,
to_number(null) network_planning_pct,
null network_orig_sys_ref,
null delete_network_link,
null network_to_operation_code,
null network_to_department,
null network_to_operation_desc,
to_date(null) network_to_op_effectivity_date,
--
-- ids
bor.organization_id,
bor.assembly_item_id,
bor.routing_sequence_id,
bos.operation_sequence_id,
rowidtochar(bsor.rowid) rsc_rowid,
null network_rowid,
to_number(null) upload_row
from
mtl_parameters mp,
mtl_system_items_vl msiv,
bom_operational_routings bor,
mtl_rtg_item_revisions mrir,
wip_lines wl,
--
bom_operation_sequences bos,
bom_departments bd,
bom_standard_operations bso,
bom_operation_sequences bos1,
bom_standard_operations bso1,
bom_operation_sequences bos2,
bom_standard_operations bso2,
--
bom_sub_operation_resources bsor,
bom_resources br
where
1=1 and
:p_show_sub_resources = 'Y' and
mp.organization_code = :p_organization_code and
bor.routing_type = nvl(:p_bom_eng_flag,1) and -- Assembly Type
nvl(bor.cfm_routing_flag,2) = nvl(:p_cfm_routing_flag,2) and -- Routing Type
nvl(:p_restrict_org,'?') = nvl(:p_restrict_org,'?') and
msiv.bom_enabled_flag = 'Y' and
nvl(msiv.eam_item_type,3) = 3 and -- excluding enterprise asset management maintenance routings
--
bor.organization_id = mp.organization_id and
bor.assembly_item_id = msiv.inventory_item_id and
bor.organization_id = msiv.organization_id and
bor.organization_id = mrir.organization_id and
bor.assembly_item_id = mrir.inventory_item_id and
mrir.effectivity_date = nvl((select max(mrir2.effectivity_date) from mtl_rtg_item_revisions mrir2 where mrir2.organization_id = bor.organization_id and mrir2.inventory_item_id = bor.assembly_item_id and mrir2.effectivity_date <= nvl(:p_effective_date,sysdate)),
                            (select min(mrir2.effectivity_date) from mtl_rtg_item_revisions mrir2 where mrir2.organization_id = bor.organization_id and mrir2.inventory_item_id = bor.assembly_item_id)
                           ) and
bor.line_id = wl.line_id(+) and
bor.organization_id = wl.organization_id(+) and
--
decode(:p_show_operations,'Y',bor.routing_sequence_id) = bos.routing_sequence_id and
bos.department_id = bd.department_id and
--
(( :p_com_routing_assign_Flag != 'R' and
   bor.common_assembly_item_id is null and
   (:p_bom_display_type = 1 or  -- All
    (:p_bom_display_type = 2 and -- Current
     bos.effectivity_date <= :p_effective_date and
     nvl(bos.disable_date, :p_effective_date + 1) >= :p_effective_date
    ) or
    (:p_bom_display_type = 3 and -- Future and Current
     nvl(bos.disable_date, :p_effective_date + 1) >= :p_effective_date and
     bos.routing_sequence_id is not null
    )
   ) and
   ((:p_implemented_only = 'Y' and bos.implementation_date is not null) or
    nvl(:p_implemented_only,'N') = 'N'
   )
 )
) and
--
bos.standard_operation_id=bso.standard_operation_id(+) and
bos.process_op_seq_id = bos1.operation_sequence_id (+) and
bos1.standard_operation_id = bso1.standard_operation_id (+) and
bos.line_op_seq_id = bos2.operation_sequence_id (+) and
bos2.standard_operation_id = bso2.standard_operation_id (+) and
--
decode(bos.operation_type,1,bos.operation_sequence_id) = bsor.operation_sequence_id and
bsor.resource_id = br.resource_id
union all
--
-- Q3 = Routing_Network
--
select
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
msiv.primary_uom_code uom,
--
-- routing
--
xxen_util.meaning(bor.routing_type,'BOM_ASSEMBLY_TYPE',700) assembly_type,
bor.alternate_routing_designator alternate,
xxen_util.meaning(bor.ctp_flag,'SYS_YES_NO',700) capable_to_promise,
--> flow
decode(bor.cfm_routing_flag,1,'Flow',2,'Standard',3,'Lot Based') routing_type,
bor.cfm_routing_flag cfm_routing_flag,
wl.line_code line,
bor.total_product_cycle_time total_cycle_time,
--< flow
bor.priority,
bor.serialization_start_op serialization_start_op_seq,  -- not flow
xxen_util.meaning(bor.mixed_model_map_flag,'SYS_YES_NO',700) mixed_model_map, -- flow
bor.completion_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.organization_id = bor.organization_id and milk.inventory_location_id = bor.completion_locator_id) completion_locator,
bor.routing_comment,
bor.original_system_reference routing_orig_sys_ref,
(select msiv2.concatenated_segments from mtl_system_items_vl msiv2 where msiv2.organization_id = bor.organization_id and msiv2.inventory_item_id = bor.common_assembly_item_id) common_routing_item,
(select msiv2.description from mtl_system_items_vl msiv2 where msiv2.organization_id = bor.organization_id and msiv2.inventory_item_id = bor.common_assembly_item_id) common_routing_item_desc,
null delete_routing,
--
xxen_util.display_flexfield_context(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category) routing_attribute_category,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE1',null,bor.attribute1) bom_rtg_attribute1,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE2',null,bor.attribute2) bom_rtg_attribute2,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE3',null,bor.attribute3) bom_rtg_attribute3,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE4',null,bor.attribute4) bom_rtg_attribute4,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE5',null,bor.attribute5) bom_rtg_attribute5,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE6',null,bor.attribute6) bom_rtg_attribute6,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE7',null,bor.attribute7) bom_rtg_attribute7,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE8',null,bor.attribute8) bom_rtg_attribute8,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE9',null,bor.attribute9) bom_rtg_attribute9,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE10',null,bor.attribute10) bom_rtg_attribute10,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE11',null,bor.attribute11) bom_rtg_attribute11,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE12',null,bor.attribute12) bom_rtg_attribute12,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE13',null,bor.attribute13) bom_rtg_attribute13,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE14',null,bor.attribute14) bom_rtg_attribute14,
xxen_util.display_flexfield_value(702,'BOM_OPERATIONAL_ROUTINGS',bor.attribute_category,'ATTRIBUTE15',null,bor.attribute15) bom_rtg_attribute15,
--
-- revision
--
mrir.process_revision revision,
mrir.effectivity_date revision_effectivity_date,
mrir.implementation_date revision_implement_date,
null delete_revision,
xxen_util.display_flexfield_context(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category) revision_attribute_category,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE1',null,mrir.attribute1) bom_rtg_rev_attribute1,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE2',null,mrir.attribute2) bom_rtg_rev_attribute2,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE3',null,mrir.attribute3) bom_rtg_rev_attribute3,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE4',null,mrir.attribute4) bom_rtg_rev_attribute4,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE5',null,mrir.attribute5) bom_rtg_rev_attribute5,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE6',null,mrir.attribute6) bom_rtg_rev_attribute6,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE7',null,mrir.attribute7) bom_rtg_rev_attribute7,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE8',null,mrir.attribute8) bom_rtg_rev_attribute8,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE9',null,mrir.attribute9) bom_rtg_rev_attribute9,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE10',null,mrir.attribute10) bom_rtg_rev_attribute10,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE11',null,mrir.attribute11) bom_rtg_rev_attribute11,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE12',null,mrir.attribute12) bom_rtg_rev_attribute12,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE13',null,mrir.attribute13) bom_rtg_rev_attribute13,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE14',null,mrir.attribute14) bom_rtg_rev_attribute14,
xxen_util.display_flexfield_value(401,'MTL_RTG_ITEM_REVISIONS',mrir.attribute_category,'ATTRIBUTE15',null,mrir.attribute15) bom_rtg_rev_attribute15,
--
-- operations
--
bos.operation_seq_num operation_seq,
xxen_util.meaning(bos.operation_type,'BOM_OPERATION_TYPE',700) operation_type,
bos.effectivity_date operation_effectivity_date, -- discrete/flow event
bos.implementation_date operation_implementation_date, -- discrete/flow event
bos.disable_date operation_disable_date, -- discrete/flow event
bso.operation_code,
xxen_util.meaning(bos.reference_flag,'SYS_YES_NO',700) referenced,
bd.department_code department,
--> flow event type
bso1.operation_code process,
bos1.operation_seq_num process_seq,
bso2.operation_code line_op,
bos2.operation_seq_num line_op_seq,
--< flow event type
xxen_util.meaning(bos.option_dependent_flag,'SYS_YES_NO',700) option_dependent, -- discrete/flow event
bos.operation_lead_time_percent lead_time_pct,
xxen_util.meaning(bos.count_point_type,'SYS_YES_NO',700) count_point,
xxen_util.meaning(decode(bos.count_point_type,3,2,1),'SYS_YES_NO',700) autocharge,
xxen_util.meaning(bos.backflush_flag,'SYS_YES_NO',700) backflush,
xxen_util.meaning(bos.check_skill,'SYS_YES_NO',700) check_skill,
bos.minimum_transfer_quantity min_transfer_qty,
bos.yield,
bos.cumulative_yield,
--> flow
bos.reverse_cumulative_yield reverse_cum_yield,
bos.net_planning_percent net_planning_pct,
bos.labor_time_calc calculated_labor_time,
bos.machine_time_calc calculated_machine_time,
bos.total_time_calc calculated_elapsed_time,
bos.labor_time_user user_labor_time,
bos.machine_time_user user_machine_time,
bos.total_time_user user_elapsed_time,
--< flow
xxen_util.meaning(bos.include_in_rollup,'SYS_YES_NO',700) include_in_rollup, --discrete
bos.change_notice eco, -- discrete/flow event
bos.operation_description,
bos.original_system_reference operation_orig_sys_ref,
null delete_operation,
--
xxen_util.display_flexfield_context(702,'OPERATIONS',bos.attribute_category) operation_attribute_category,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE1',null,bos.attribute1) bom_rtg_op_attribute1,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE2',null,bos.attribute2) bom_rtg_op_attribute2,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE3',null,bos.attribute3) bom_rtg_op_attribute3,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE4',null,bos.attribute4) bom_rtg_op_attribute4,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE5',null,bos.attribute5) bom_rtg_op_attribute5,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE6',null,bos.attribute6) bom_rtg_op_attribute6,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE7',null,bos.attribute7) bom_rtg_op_attribute7,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE8',null,bos.attribute8) bom_rtg_op_attribute8,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE9',null,bos.attribute9) bom_rtg_op_attribute9,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE10',null,bos.attribute10) bom_rtg_op_attribute10,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE11',null,bos.attribute11) bom_rtg_op_attribute11,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE12',null,bos.attribute12) bom_rtg_op_attribute12,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE13',null,bos.attribute13) bom_rtg_op_attribute13,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE14',null,bos.attribute14) bom_rtg_op_attribute14,
xxen_util.display_flexfield_value(702,'OPERATIONS',bos.attribute_category,'ATTRIBUTE15',null,bos.attribute15) bom_rtg_op_attribute15,
--
-- operation sub resource
--
null substitute_resource_flag,
to_number(null) resource_seq,
to_number(null) substitute_group_num,
to_number(null) replacement_group_num,
null resource_code,
null resource_uom,
null resource_basis,
to_number(null) usage_rate_or_amount,
to_number(null) inverse_rate_or_amount,
null available_24_hours,
to_number(null) schedule_seq_num,
null schedule,
to_number(null) assigned_units,
to_number(null) offset_pct,
null principle_flag,
null setup_type,
null activity,
null standard_rate,
null charge_type,
null resource_orig_sys_ref,
null delete_resource,
-- resource dffs
null resource_attribute_category,
null bom_rtg_op_rsc_attribute1,
null bom_rtg_op_rsc_attribute2,
null bom_rtg_op_rsc_attribute3,
null bom_rtg_op_rsc_attribute4,
null bom_rtg_op_rsc_attribute5,
null bom_rtg_op_rsc_attribute6,
null bom_rtg_op_rsc_attribute7,
null bom_rtg_op_rsc_attribute8,
null bom_rtg_op_rsc_attribute9,
null bom_rtg_op_rsc_attribute10,
null bom_rtg_op_rsc_attribute11,
null bom_rtg_op_rsc_attribute12,
null bom_rtg_op_rsc_attribute13,
null bom_rtg_op_rsc_attribute14,
null bom_rtg_op_rsc_attribute15,
-- substitute ressource dffs
null sub_rsc_attribute_category,
null bom_rtg_op_sub_rsc_attribute1,
null bom_rtg_op_sub_rsc_attribute2,
null bom_rtg_op_sub_rsc_attribute3,
null bom_rtg_op_sub_rsc_attribute4,
null bom_rtg_op_sub_rsc_attribute5,
null bom_rtg_op_sub_rsc_attribute6,
null bom_rtg_op_sub_rsc_attribute7,
null bom_rtg_op_sub_rsc_attribute8,
null bom_rtg_op_sub_rsc_attribute9,
null bom_rtg_op_sub_rsc_attribute10,
null bom_rtg_op_sub_rsc_attribute11,
null bom_rtg_op_sub_rsc_attribute12,
null bom_rtg_op_sub_rsc_attribute13,
null bom_rtg_op_sub_rsc_attribute14,
null bom_rtg_op_sub_rsc_attribute15,
--
-- routing network
--
bos3.operation_seq_num network_to_operation_seq,
xxen_util.meaning(bon.transition_type,'BOM_TRANSITION_TYPE',700) network_transition_type,
bon.planning_pct network_planning_pct,
bon.original_system_reference network_orig_sys_ref,
null delete_network_link,
(select bso.operation_code from bom_standard_operations bso where bso.standard_operation_id = bos3.standard_operation_id) network_to_operation_code,
(select bd.department_code from bom_departments bd where bd.department_id = bos3.department_id) network_to_department,
bos3.operation_description network_to_operation_desc,
bos3.effectivity_date network_to_op_effectivity_date,
--
-- ids
bor.organization_id,
bor.assembly_item_id,
bor.routing_sequence_id,
bos.operation_sequence_id,
null rsc_rowid,
rowidtochar(bon.rowid) network_rowid,
to_number(null) upload_row
from
mtl_parameters mp,
mtl_system_items_vl msiv,
bom_operational_routings bor,
mtl_rtg_item_revisions mrir,
wip_lines wl,
--
bom_operation_sequences bos,
bom_departments bd,
bom_standard_operations bso,
bom_operation_sequences bos1,
bom_standard_operations bso1,
bom_operation_sequences bos2,
bom_standard_operations bso2,
--
bom_operation_networks bon,
bom_operation_sequences bos3
where
1=1 and
:p_show_networks = 'Y' and
mp.organization_code = :p_organization_code and
bor.routing_type = nvl(:p_bom_eng_flag,1) and -- Assembly Type
nvl(bor.cfm_routing_flag,2) = nvl(:p_cfm_routing_flag,2) and -- Routing Type
nvl(:p_revision,'?') = nvl(:p_revision,'?') and
nvl(:p_restrict_org,'?') = nvl(:p_restrict_org,'?') and
msiv.bom_enabled_flag = 'Y' and
nvl(msiv.eam_item_type,3) = 3 and -- excluding enterprise asset management maintenance routings
--
bor.organization_id = mp.organization_id and
bor.assembly_item_id = msiv.inventory_item_id and
bor.organization_id = msiv.organization_id and
bor.organization_id = mrir.organization_id and
bor.assembly_item_id = mrir.inventory_item_id and
mrir.effectivity_date = nvl((select max(mrir2.effectivity_date) from mtl_rtg_item_revisions mrir2 where mrir2.organization_id = bor.organization_id and mrir2.inventory_item_id = bor.assembly_item_id and mrir2.effectivity_date <= nvl(:p_effective_date,sysdate)),
                            (select min(mrir2.effectivity_date) from mtl_rtg_item_revisions mrir2 where mrir2.organization_id = bor.organization_id and mrir2.inventory_item_id = bor.assembly_item_id)
                           ) and
bor.line_id = wl.line_id(+) and
bor.organization_id = wl.organization_id(+) and
--
decode(:p_show_operations,'Y',bor.routing_sequence_id) = bos.routing_sequence_id and
bos.department_id = bd.department_id and
--
(( :p_com_routing_assign_Flag != 'R' and
   bor.common_assembly_item_id is null and
   (:p_bom_display_type = 1 or  -- All
    (:p_bom_display_type = 2 and -- Current
     bos.effectivity_date <= :p_effective_date and
     nvl(bos.disable_date, :p_effective_date + 1) >= :p_effective_date
    ) or
    (:p_bom_display_type = 3 and -- Future and Current
     nvl(bos.disable_date, :p_effective_date + 1) >= :p_effective_date and
     bos.routing_sequence_id is not null
    )
   ) and
   ((:p_implemented_only = 'Y' and bos.implementation_date is not null) or
    nvl(:p_implemented_only,'N') = 'N'
   )
 )
) and
--
bos.standard_operation_id=bso.standard_operation_id(+) and
bos.process_op_seq_id = bos1.operation_sequence_id (+) and
bos1.standard_operation_id = bso1.standard_operation_id (+) and
bos.line_op_seq_id = bos2.operation_sequence_id (+) and
bos2.standard_operation_id = bso2.standard_operation_id (+) and
--
case when (nvl(bor.cfm_routing_flag,2) = 3 and bos.operation_type = 1) or (nvl(bor.cfm_routing_flag,2) = 1 and bos.operation_type in (2,3)) then bos.operation_sequence_id end = bon.from_op_seq_id and
bon.to_op_seq_id = bos3.operation_sequence_id
) rtg