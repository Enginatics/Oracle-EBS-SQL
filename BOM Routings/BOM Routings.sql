/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Routings
-- Description: Master data report showing bill of material routings with item codes and sequences.

The report optionally shows the full routing detail matching the BOM Routing Upload: routing header attributes and revision, operation scheduling details, operation resources, substitute resources and flow routing operation networks. The detail levels are controlled by the Show Operations, Show Resources, Show Substitute Resources and Show Networks parameters, and the Record Type column identifies each row.

Descriptive flexfield attributes of the routing, routing revision and operation are shown as dynamic columns via the Show BOM DFF Attributes parameter.
-- Excel Examle Output: https://www.enginatics.com/example/bom-routings/
-- Library Link: https://www.enginatics.com/reports/bom-routings/
-- Run Report: https://demo.enginatics.com/

select
haouv.name org_name,
mp.organization_code,
case when br.resource_code is not null then 'Resource' when bos.operation_seq_num is not null then 'Operation' else 'Routing' end record_type,
msiv.concatenated_segments item,
msiv.description item_description,
(select misv2.inventory_item_status_code_tl from mtl_item_status_vl misv2 where misv2.inventory_item_status_code=msiv.inventory_item_status_code) item_status,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
msiv.primary_uom_code uom,
xxen_util.meaning(bor.routing_type,'BOM_ASSEMBLY_TYPE',700) type,
decode(bor.cfm_routing_flag,1,'Flow',2,'Discrete Job',3,'Lot Based',to_char(bor.cfm_routing_flag)) cfm_routing,
wl.line_code,
bor.alternate_routing_designator alternate,
xxen_util.meaning(bor.ctp_flag,'SYS_YES_NO',700) capable_to_promise,
bor.total_product_cycle_time total_cycle_time,
bor.priority,
bor.serialization_start_op serialization_start_op_seq,
xxen_util.meaning(bor.mixed_model_map_flag,'SYS_YES_NO',700) mixed_model_map,
bor.completion_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.organization_id=bor.organization_id and milk.inventory_location_id=bor.completion_locator_id) completion_locator,
bor.routing_comment,
(select msiv2.concatenated_segments from mtl_system_items_vl msiv2 where msiv2.organization_id=bor.organization_id and msiv2.inventory_item_id=bor.common_assembly_item_id) common_routing_item,
(select msiv2.description from mtl_system_items_vl msiv2 where msiv2.organization_id=bor.organization_id and msiv2.inventory_item_id=bor.common_assembly_item_id) common_routing_item_desc,
bor.original_system_reference routing_orig_sys_ref,
&routing_dff_columns
mrir.process_revision revision,
mrir.effectivity_date revision_effectivity_date,
mrir.implementation_date revision_implement_date,
&revision_dff_columns
bos.operation_seq_num operation_sequence,
bso.operation_code,
bos.operation_description,
xxen_util.meaning(bos.reference_flag,'SYS_YES_NO',700) referenced,
bd.department_code,
bd.description department_description,
xxen_util.meaning(bos.operation_type,'BOM_OPERATION_TYPE',700) operation_type,
bos.effectivity_date,
bos.disable_date,
bos.implementation_date operation_implementation_date,
bso1.operation_code process,
bos1.operation_seq_num process_seq,
bso2.operation_code line_op,
bos2.operation_seq_num line_op_seq,
xxen_util.meaning(bos.option_dependent_flag,'SYS_YES_NO',700) option_dependent,
bos.operation_lead_time_percent lead_time_pct,
xxen_util.meaning(bos.count_point_type,'SYS_YES_NO',700) count_point,
xxen_util.meaning(decode(bos.count_point_type,3,2,1),'SYS_YES_NO',700) autocharge,
xxen_util.meaning(bos.backflush_flag,'SYS_YES_NO',700) backflush,
xxen_util.meaning(bos.check_skill,'SYS_YES_NO',700) check_skill,
bos.minimum_transfer_quantity min_transfer_qty,
bos.yield,
bos.cumulative_yield,
bos.reverse_cumulative_yield reverse_cum_yield,
bos.net_planning_percent net_planning_pct,
bos.labor_time_calc calculated_labor_time,
bos.machine_time_calc calculated_machine_time,
bos.total_time_calc calculated_elapsed_time,
bos.labor_time_user user_labor_time,
bos.machine_time_user user_machine_time,
bos.total_time_user user_elapsed_time,
xxen_util.meaning(bos.include_in_rollup,'SYS_YES_NO',700) include_in_rollup,
bos.change_notice eco,
bos.original_system_reference operation_orig_sys_ref,
&operation_dff_columns
borsc.resource_seq_num resource_seq,
borsc.substitute_group_num,
to_number(null) replacement_group_num,
br.resource_code,
br.unit_of_measure resource_uom,
xxen_util.meaning(borsc.basis_type,'BOM_BASIS_TYPE',700) resource_basis,
borsc.usage_rate_or_amount,
borsc.usage_rate_or_amount_inverse inverse_rate_or_amount,
(select xxen_util.meaning(bdr.available_24_hours_flag,'SYS_YES_NO',700) from bom_department_resources bdr where bdr.department_id=bos.department_id and bdr.resource_id=borsc.resource_id) available_24_hours,
borsc.schedule_seq_num,
xxen_util.meaning(borsc.schedule_flag,'BOM_RESOURCE_SCHEDULE_TYPE',700) schedule,
borsc.assigned_units,
borsc.resource_offset_percent offset_pct,
xxen_util.meaning(borsc.principle_flag,'SYS_YES_NO',700) principle_flag,
(select bst.setup_code from bom_setup_types bst where bst.setup_id=borsc.setup_id) setup_type,
(select cavv.activity from cst_activities_val_v cavv where cavv.activity_id=borsc.activity_id and nvl(cavv.organization_id,mp.organization_id)=mp.organization_id) activity,
xxen_util.meaning(borsc.standard_rate_flag,'SYS_YES_NO',700) standard_rate,
xxen_util.meaning(borsc.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) charge_type,
borsc.original_system_reference resource_orig_sys_ref,
to_number(null) network_to_operation_seq,
null network_to_operation_code,
null network_to_department,
null network_to_operation_desc,
to_date(null) network_to_op_effectivity_date,
null network_transition_type,
to_number(null) network_planning_pct,
null network_orig_sys_ref
from
hr_all_organization_units_vl haouv,
mtl_parameters mp,
mtl_system_items_vl msiv,
bom_operational_routings bor,
(select
 mrir0.rowid row_id,
 mrir0.organization_id,
 mrir0.inventory_item_id,
 mrir0.process_revision,
 mrir0.effectivity_date,
 mrir0.implementation_date,
 mrir0.attribute_category,
 mrir0.attribute1,
 mrir0.attribute2,
 mrir0.attribute3,
 mrir0.attribute4,
 mrir0.attribute5,
 mrir0.attribute6,
 mrir0.attribute7,
 mrir0.attribute8,
 mrir0.attribute9,
 mrir0.attribute10,
 mrir0.attribute11,
 mrir0.attribute12,
 mrir0.attribute13,
 mrir0.attribute14,
 mrir0.attribute15,
 row_number() over (partition by mrir0.organization_id, mrir0.inventory_item_id order by case when mrir0.effectivity_date<=nvl(:p_effective_date,sysdate) then 1 else 2 end, case when mrir0.effectivity_date<=nvl(:p_effective_date,sysdate) then nvl(:p_effective_date,sysdate)-mrir0.effectivity_date else mrir0.effectivity_date-nvl(:p_effective_date,sysdate) end) rn
 from mtl_rtg_item_revisions mrir0
) mrir,
wip_lines wl,
bom_operation_sequences bos,
bom_departments bd,
bom_standard_operations bso,
bom_operation_sequences bos1,
bom_standard_operations bso1,
bom_operation_sequences bos2,
bom_standard_operations bso2,
bom_operation_resources borsc,
bom_resources br
where
1=1 and
haouv.organization_id=bor.organization_id and
mp.organization_id=bor.organization_id and
bor.assembly_item_id=msiv.inventory_item_id and
bor.organization_id=msiv.organization_id and
bor.organization_id=mrir.organization_id(+) and
bor.assembly_item_id=mrir.inventory_item_id(+) and
mrir.rn(+)=1 and
bor.line_id=wl.line_id(+) and
bor.organization_id=wl.organization_id(+) and
decode(:p_show_operations,'Y',bor.routing_sequence_id)=bos.routing_sequence_id(+) and
bos.department_id=bd.department_id(+) and
(:p_show_operations is null or
 (:p_com_routing_assign_flag<>'R' and
  bor.common_assembly_item_id is null and
  (:p_bom_display_type=1 or
   :p_bom_display_type=2 and bos.effectivity_date<=:p_effective_date and nvl(bos.disable_date,:p_effective_date+1)>=:p_effective_date or
   :p_bom_display_type=3 and nvl(bos.disable_date,:p_effective_date+1)>=:p_effective_date and bos.routing_sequence_id is not null
  ) and
  (:p_implemented_only='Y' and bos.implementation_date is not null or nvl(:p_implemented_only,'N')='N')
 ) or
 :p_com_routing_assign_flag in ('I','R') and bor.common_assembly_item_id is not null
) and
bos.standard_operation_id=bso.standard_operation_id(+) and
bos.process_op_seq_id=bos1.operation_sequence_id(+) and
bos1.standard_operation_id=bso1.standard_operation_id(+) and
bos.line_op_seq_id=bos2.operation_sequence_id(+) and
bos2.standard_operation_id=bso2.standard_operation_id(+) and
decode(:p_show_resources,'Y',decode(bos.operation_type,1,bos.operation_sequence_id))=borsc.operation_sequence_id(+) and
borsc.resource_id=br.resource_id(+) and
(br.resource_code is not null or
 :p_show_sub_resources is null and :p_show_networks is null or
 not exists
 (select 'Y' from bom_sub_operation_resources bsor where :p_show_sub_resources='Y' and bsor.operation_sequence_id=decode(bos.operation_type,1,bos.operation_sequence_id) and rownum=1 union
  select 'Y' from bom_operation_networks bon where :p_show_networks='Y' and bon.from_op_seq_id=decode(bos.operation_type,1,bos.operation_sequence_id) and rownum=1
 )
) and
(:p_sub_resource_exists is null or
 exists (select 'Y' from bom_operation_sequences bos9, bom_sub_operation_resources bsor where :p_show_sub_resources='Y' and bos9.routing_sequence_id=bor.routing_sequence_id and bsor.operation_sequence_id=decode(bos9.operation_type,1,bos9.operation_sequence_id) and rownum=1)
) and
(:p_network_exists is null or
 exists (select 'Y' from bom_operation_sequences bos9, bom_operation_networks bon where :p_show_networks='Y' and bos9.routing_sequence_id=bor.routing_sequence_id and bon.from_op_seq_id=decode(bos9.operation_type,1,bos9.operation_sequence_id) and rownum=1)
)
union all
select
haouv.name org_name,
mp.organization_code,
'Substitute Resource' record_type,
msiv.concatenated_segments item,
msiv.description item_description,
(select misv2.inventory_item_status_code_tl from mtl_item_status_vl misv2 where misv2.inventory_item_status_code=msiv.inventory_item_status_code) item_status,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
msiv.primary_uom_code uom,
xxen_util.meaning(bor.routing_type,'BOM_ASSEMBLY_TYPE',700) type,
decode(bor.cfm_routing_flag,1,'Flow',2,'Discrete Job',3,'Lot Based',to_char(bor.cfm_routing_flag)) cfm_routing,
wl.line_code,
bor.alternate_routing_designator alternate,
xxen_util.meaning(bor.ctp_flag,'SYS_YES_NO',700) capable_to_promise,
bor.total_product_cycle_time total_cycle_time,
bor.priority,
bor.serialization_start_op serialization_start_op_seq,
xxen_util.meaning(bor.mixed_model_map_flag,'SYS_YES_NO',700) mixed_model_map,
bor.completion_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.organization_id=bor.organization_id and milk.inventory_location_id=bor.completion_locator_id) completion_locator,
bor.routing_comment,
(select msiv2.concatenated_segments from mtl_system_items_vl msiv2 where msiv2.organization_id=bor.organization_id and msiv2.inventory_item_id=bor.common_assembly_item_id) common_routing_item,
(select msiv2.description from mtl_system_items_vl msiv2 where msiv2.organization_id=bor.organization_id and msiv2.inventory_item_id=bor.common_assembly_item_id) common_routing_item_desc,
bor.original_system_reference routing_orig_sys_ref,
&routing_dff_columns
mrir.process_revision revision,
mrir.effectivity_date revision_effectivity_date,
mrir.implementation_date revision_implement_date,
&revision_dff_columns
bos.operation_seq_num operation_sequence,
bso.operation_code,
bos.operation_description,
xxen_util.meaning(bos.reference_flag,'SYS_YES_NO',700) referenced,
bd.department_code,
bd.description department_description,
xxen_util.meaning(bos.operation_type,'BOM_OPERATION_TYPE',700) operation_type,
bos.effectivity_date,
bos.disable_date,
bos.implementation_date operation_implementation_date,
bso1.operation_code process,
bos1.operation_seq_num process_seq,
bso2.operation_code line_op,
bos2.operation_seq_num line_op_seq,
xxen_util.meaning(bos.option_dependent_flag,'SYS_YES_NO',700) option_dependent,
bos.operation_lead_time_percent lead_time_pct,
xxen_util.meaning(bos.count_point_type,'SYS_YES_NO',700) count_point,
xxen_util.meaning(decode(bos.count_point_type,3,2,1),'SYS_YES_NO',700) autocharge,
xxen_util.meaning(bos.backflush_flag,'SYS_YES_NO',700) backflush,
xxen_util.meaning(bos.check_skill,'SYS_YES_NO',700) check_skill,
bos.minimum_transfer_quantity min_transfer_qty,
bos.yield,
bos.cumulative_yield,
bos.reverse_cumulative_yield reverse_cum_yield,
bos.net_planning_percent net_planning_pct,
bos.labor_time_calc calculated_labor_time,
bos.machine_time_calc calculated_machine_time,
bos.total_time_calc calculated_elapsed_time,
bos.labor_time_user user_labor_time,
bos.machine_time_user user_machine_time,
bos.total_time_user user_elapsed_time,
xxen_util.meaning(bos.include_in_rollup,'SYS_YES_NO',700) include_in_rollup,
bos.change_notice eco,
bos.original_system_reference operation_orig_sys_ref,
&operation_dff_columns
to_number(null) resource_seq,
bsor.substitute_group_num,
bsor.replacement_group_num,
br.resource_code,
br.unit_of_measure resource_uom,
xxen_util.meaning(bsor.basis_type,'BOM_BASIS_TYPE',700) resource_basis,
bsor.usage_rate_or_amount,
bsor.usage_rate_or_amount_inverse inverse_rate_or_amount,
null available_24_hours,
bsor.schedule_seq_num,
xxen_util.meaning(bsor.schedule_flag,'BOM_RESOURCE_SCHEDULE_TYPE',700) schedule,
bsor.assigned_units,
bsor.resource_offset_percent offset_pct,
xxen_util.meaning(bsor.principle_flag,'SYS_YES_NO',700) principle_flag,
(select bst.setup_code from bom_setup_types bst where bst.setup_id=bsor.setup_id) setup_type,
(select cavv.activity from cst_activities_val_v cavv where cavv.activity_id=bsor.activity_id and nvl(cavv.organization_id,mp.organization_id)=mp.organization_id) activity,
xxen_util.meaning(bsor.standard_rate_flag,'SYS_YES_NO',700) standard_rate,
xxen_util.meaning(bsor.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) charge_type,
bsor.original_system_reference resource_orig_sys_ref,
to_number(null) network_to_operation_seq,
null network_to_operation_code,
null network_to_department,
null network_to_operation_desc,
to_date(null) network_to_op_effectivity_date,
null network_transition_type,
to_number(null) network_planning_pct,
null network_orig_sys_ref
from
hr_all_organization_units_vl haouv,
mtl_parameters mp,
mtl_system_items_vl msiv,
bom_operational_routings bor,
(select
 mrir0.rowid row_id,
 mrir0.organization_id,
 mrir0.inventory_item_id,
 mrir0.process_revision,
 mrir0.effectivity_date,
 mrir0.implementation_date,
 mrir0.attribute_category,
 mrir0.attribute1,
 mrir0.attribute2,
 mrir0.attribute3,
 mrir0.attribute4,
 mrir0.attribute5,
 mrir0.attribute6,
 mrir0.attribute7,
 mrir0.attribute8,
 mrir0.attribute9,
 mrir0.attribute10,
 mrir0.attribute11,
 mrir0.attribute12,
 mrir0.attribute13,
 mrir0.attribute14,
 mrir0.attribute15,
 row_number() over (partition by mrir0.organization_id, mrir0.inventory_item_id order by case when mrir0.effectivity_date<=nvl(:p_effective_date,sysdate) then 1 else 2 end, case when mrir0.effectivity_date<=nvl(:p_effective_date,sysdate) then nvl(:p_effective_date,sysdate)-mrir0.effectivity_date else mrir0.effectivity_date-nvl(:p_effective_date,sysdate) end) rn
 from mtl_rtg_item_revisions mrir0
) mrir,
wip_lines wl,
bom_operation_sequences bos,
bom_departments bd,
bom_standard_operations bso,
bom_operation_sequences bos1,
bom_standard_operations bso1,
bom_operation_sequences bos2,
bom_standard_operations bso2,
bom_sub_operation_resources bsor,
bom_resources br
where
1=1 and
:p_show_sub_resources='Y' and
haouv.organization_id=bor.organization_id and
mp.organization_id=bor.organization_id and
bor.assembly_item_id=msiv.inventory_item_id and
bor.organization_id=msiv.organization_id and
bor.organization_id=mrir.organization_id(+) and
bor.assembly_item_id=mrir.inventory_item_id(+) and
mrir.rn(+)=1 and
bor.line_id=wl.line_id(+) and
bor.organization_id=wl.organization_id(+) and
decode(:p_show_operations,'Y',bor.routing_sequence_id)=bos.routing_sequence_id and
bos.department_id=bd.department_id(+) and
(:p_com_routing_assign_flag<>'R' and
 bor.common_assembly_item_id is null and
 (:p_bom_display_type=1 or
  :p_bom_display_type=2 and bos.effectivity_date<=:p_effective_date and nvl(bos.disable_date,:p_effective_date+1)>=:p_effective_date or
  :p_bom_display_type=3 and nvl(bos.disable_date,:p_effective_date+1)>=:p_effective_date and bos.routing_sequence_id is not null
 ) and
 (:p_implemented_only='Y' and bos.implementation_date is not null or nvl(:p_implemented_only,'N')='N')
) and
bos.standard_operation_id=bso.standard_operation_id(+) and
bos.process_op_seq_id=bos1.operation_sequence_id(+) and
bos1.standard_operation_id=bso1.standard_operation_id(+) and
bos.line_op_seq_id=bos2.operation_sequence_id(+) and
bos2.standard_operation_id=bso2.standard_operation_id(+) and
decode(bos.operation_type,1,bos.operation_sequence_id)=bsor.operation_sequence_id and
bsor.resource_id=br.resource_id
union all
select
haouv.name org_name,
mp.organization_code,
'Network Link' record_type,
msiv.concatenated_segments item,
msiv.description item_description,
(select misv2.inventory_item_status_code_tl from mtl_item_status_vl misv2 where misv2.inventory_item_status_code=msiv.inventory_item_status_code) item_status,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
msiv.primary_uom_code uom,
xxen_util.meaning(bor.routing_type,'BOM_ASSEMBLY_TYPE',700) type,
decode(bor.cfm_routing_flag,1,'Flow',2,'Discrete Job',3,'Lot Based',to_char(bor.cfm_routing_flag)) cfm_routing,
wl.line_code,
bor.alternate_routing_designator alternate,
xxen_util.meaning(bor.ctp_flag,'SYS_YES_NO',700) capable_to_promise,
bor.total_product_cycle_time total_cycle_time,
bor.priority,
bor.serialization_start_op serialization_start_op_seq,
xxen_util.meaning(bor.mixed_model_map_flag,'SYS_YES_NO',700) mixed_model_map,
bor.completion_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.organization_id=bor.organization_id and milk.inventory_location_id=bor.completion_locator_id) completion_locator,
bor.routing_comment,
(select msiv2.concatenated_segments from mtl_system_items_vl msiv2 where msiv2.organization_id=bor.organization_id and msiv2.inventory_item_id=bor.common_assembly_item_id) common_routing_item,
(select msiv2.description from mtl_system_items_vl msiv2 where msiv2.organization_id=bor.organization_id and msiv2.inventory_item_id=bor.common_assembly_item_id) common_routing_item_desc,
bor.original_system_reference routing_orig_sys_ref,
&routing_dff_columns
mrir.process_revision revision,
mrir.effectivity_date revision_effectivity_date,
mrir.implementation_date revision_implement_date,
&revision_dff_columns
bos.operation_seq_num operation_sequence,
bso.operation_code,
bos.operation_description,
xxen_util.meaning(bos.reference_flag,'SYS_YES_NO',700) referenced,
bd.department_code,
bd.description department_description,
xxen_util.meaning(bos.operation_type,'BOM_OPERATION_TYPE',700) operation_type,
bos.effectivity_date,
bos.disable_date,
bos.implementation_date operation_implementation_date,
bso1.operation_code process,
bos1.operation_seq_num process_seq,
bso2.operation_code line_op,
bos2.operation_seq_num line_op_seq,
xxen_util.meaning(bos.option_dependent_flag,'SYS_YES_NO',700) option_dependent,
bos.operation_lead_time_percent lead_time_pct,
xxen_util.meaning(bos.count_point_type,'SYS_YES_NO',700) count_point,
xxen_util.meaning(decode(bos.count_point_type,3,2,1),'SYS_YES_NO',700) autocharge,
xxen_util.meaning(bos.backflush_flag,'SYS_YES_NO',700) backflush,
xxen_util.meaning(bos.check_skill,'SYS_YES_NO',700) check_skill,
bos.minimum_transfer_quantity min_transfer_qty,
bos.yield,
bos.cumulative_yield,
bos.reverse_cumulative_yield reverse_cum_yield,
bos.net_planning_percent net_planning_pct,
bos.labor_time_calc calculated_labor_time,
bos.machine_time_calc calculated_machine_time,
bos.total_time_calc calculated_elapsed_time,
bos.labor_time_user user_labor_time,
bos.machine_time_user user_machine_time,
bos.total_time_user user_elapsed_time,
xxen_util.meaning(bos.include_in_rollup,'SYS_YES_NO',700) include_in_rollup,
bos.change_notice eco,
bos.original_system_reference operation_orig_sys_ref,
&operation_dff_columns
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
bos3.operation_seq_num network_to_operation_seq,
(select bso9.operation_code from bom_standard_operations bso9 where bso9.standard_operation_id=bos3.standard_operation_id) network_to_operation_code,
(select bd9.department_code from bom_departments bd9 where bd9.department_id=bos3.department_id) network_to_department,
bos3.operation_description network_to_operation_desc,
bos3.effectivity_date network_to_op_effectivity_date,
xxen_util.meaning(bon.transition_type,'BOM_TRANSITION_TYPE',700) network_transition_type,
bon.planning_pct network_planning_pct,
bon.original_system_reference network_orig_sys_ref
from
hr_all_organization_units_vl haouv,
mtl_parameters mp,
mtl_system_items_vl msiv,
bom_operational_routings bor,
(select
 mrir0.rowid row_id,
 mrir0.organization_id,
 mrir0.inventory_item_id,
 mrir0.process_revision,
 mrir0.effectivity_date,
 mrir0.implementation_date,
 mrir0.attribute_category,
 mrir0.attribute1,
 mrir0.attribute2,
 mrir0.attribute3,
 mrir0.attribute4,
 mrir0.attribute5,
 mrir0.attribute6,
 mrir0.attribute7,
 mrir0.attribute8,
 mrir0.attribute9,
 mrir0.attribute10,
 mrir0.attribute11,
 mrir0.attribute12,
 mrir0.attribute13,
 mrir0.attribute14,
 mrir0.attribute15,
 row_number() over (partition by mrir0.organization_id, mrir0.inventory_item_id order by case when mrir0.effectivity_date<=nvl(:p_effective_date,sysdate) then 1 else 2 end, case when mrir0.effectivity_date<=nvl(:p_effective_date,sysdate) then nvl(:p_effective_date,sysdate)-mrir0.effectivity_date else mrir0.effectivity_date-nvl(:p_effective_date,sysdate) end) rn
 from mtl_rtg_item_revisions mrir0
) mrir,
wip_lines wl,
bom_operation_sequences bos,
bom_departments bd,
bom_standard_operations bso,
bom_operation_sequences bos1,
bom_standard_operations bso1,
bom_operation_sequences bos2,
bom_standard_operations bso2,
bom_operation_networks bon,
bom_operation_sequences bos3
where
1=1 and
:p_show_networks='Y' and
haouv.organization_id=bor.organization_id and
mp.organization_id=bor.organization_id and
bor.assembly_item_id=msiv.inventory_item_id and
bor.organization_id=msiv.organization_id and
bor.organization_id=mrir.organization_id(+) and
bor.assembly_item_id=mrir.inventory_item_id(+) and
mrir.rn(+)=1 and
bor.line_id=wl.line_id(+) and
bor.organization_id=wl.organization_id(+) and
decode(:p_show_operations,'Y',bor.routing_sequence_id)=bos.routing_sequence_id and
bos.department_id=bd.department_id(+) and
(:p_com_routing_assign_flag<>'R' and
 bor.common_assembly_item_id is null and
 (:p_bom_display_type=1 or
  :p_bom_display_type=2 and bos.effectivity_date<=:p_effective_date and nvl(bos.disable_date,:p_effective_date+1)>=:p_effective_date or
  :p_bom_display_type=3 and nvl(bos.disable_date,:p_effective_date+1)>=:p_effective_date and bos.routing_sequence_id is not null
 ) and
 (:p_implemented_only='Y' and bos.implementation_date is not null or nvl(:p_implemented_only,'N')='N')
) and
bos.standard_operation_id=bso.standard_operation_id(+) and
bos.process_op_seq_id=bos1.operation_sequence_id(+) and
bos1.standard_operation_id=bso1.standard_operation_id(+) and
bos.line_op_seq_id=bos2.operation_sequence_id(+) and
bos2.standard_operation_id=bso2.standard_operation_id(+) and
case when nvl(bor.cfm_routing_flag,2)=3 and bos.operation_type=1 or nvl(bor.cfm_routing_flag,2)=1 and bos.operation_type in (2,3) then bos.operation_sequence_id end=bon.from_op_seq_id and
bon.to_op_seq_id=bos3.operation_sequence_id
order by
org_name,
organization_code,
item,
alternate nulls first,
operation_sequence,
record_type,
resource_seq,
schedule_seq_num,
network_to_operation_seq