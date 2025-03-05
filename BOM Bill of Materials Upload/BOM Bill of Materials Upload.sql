/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Bill of Materials Upload
-- Description: Report: BOM Bill of Materials Upload
Description: 
This upload can be used to create and/or update existing standard BOMs, including
- BOM Header
- BOM Components
- BOM Component Substitutes

The functionality supports the creation and update of Alternate Bills. 
The functionality does not support the creation and update of Common Bills.
-- Excel Examle Output: https://www.enginatics.com/example/bom-bill-of-materials-upload/
-- Library Link: https://www.enginatics.com/reports/bom-bill-of-materials-upload/
-- Run Report: https://demo.enginatics.com/

with bom as
(
 select
  bbom.bill_sequence_id,
  bbom.organization_id,
  bbom.assembly_item_id,
  bbom.specific_assembly_comment bill_comment,
  xxen_util.meaning(decode(bbom.implementation_date,null,2,1),'SYS_YES_NO',700) bill_implemented_flag,
  bbom.implementation_date bill_implementation_date,
  bbom.effectivity_control effectivity_control_code,
  xxen_util.meaning(bbom.effectivity_control,'MTL_EFFECTIVITY_CONTROL',700) effectivity_control,
  bbom.alternate_bom_designator alternate_bom,
  xxen_util.meaning(nvl2(bbom.common_assembly_item_id,1,2),'SYS_YES_NO',700) common_bill_flag,
  xxen_util.display_flexfield_context(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category) bill_attribute_category,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE1',bbom.rowid) bom_bill_attribute1,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE2',bbom.rowid) bom_bill_attribute2,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE3',bbom.rowid) bom_bill_attribute3,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE4',bbom.rowid) bom_bill_attribute4,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE5',bbom.rowid) bom_bill_attribute5,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE6',bbom.rowid) bom_bill_attribute6,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE7',bbom.rowid) bom_bill_attribute7,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE8',bbom.rowid) bom_bill_attribute8,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE9',bbom.rowid) bom_bill_attribute9,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE10',bbom.rowid) bom_bill_attribute10,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE11',bbom.rowid) bom_bill_attribute11,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE12',bbom.rowid) bom_bill_attribute12,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE13',bbom.rowid) bom_bill_attribute13,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE14',bbom.rowid) bom_bill_attribute14,
  xxen_util.display_flexfield_value(702,'BOM_BILL_OF_MATERIALS',bbom.attribute_category,'ATTRIBUTE15',bbom.rowid) bom_bill_attribute15,
  --
  bic.component_sequence_id,
  bic.component_item_id,
  bic.item_num item_seq,
  bic.operation_seq_num operation_seq,
  bic.component_quantity,
  round(decode(bic.component_quantity,0,0,1/bic.component_quantity),37) inverse_quantity,
  bic.effectivity_date  date_effective_from,
  bic.disable_date      date_effective_to,
  bic.from_end_item_unit_number end_item_unit_number_from,
  bic.to_end_item_unit_number end_item_unit_number_to,
  nvl(bic.basis_type,1) basis_type,
  xxen_util.meaning(nvl(bic.basis_type,1),'BOM_BASIS_TYPE',700) basis,
  bic.planning_factor planning_percent,
  bic.component_yield_factor yield,
  xxen_util.meaning(bic.enforce_int_requirements,'BOM_ENFORCE_INT_REQUIREMENTS',700) enforce_integer_quantity,
  xxen_util.meaning(bic.include_in_cost_rollup,'SYS_YES_NO',700) include_in_cost_rollup,
  xxen_util.meaning(bic.wip_supply_type,'WIP_SUPPLY',700) supply_type,
  bic.supply_subinventory,
  (select milk.concatenated_segments from mtl_item_locations_kfv milk where milk.inventory_location_id = bic.supply_locator_id) supply_locator,
  xxen_util.meaning(decode(bic.implementation_date,null,2,1),'SYS_YES_NO',700) component_implemented_flag,
  bic.implementation_date component_implementation_date,
  xxen_util.display_flexfield_context(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category) component_attribute_category,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE1',bic.rowid) bom_comp_attribute1,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE2',bic.rowid) bom_comp_attribute2,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE3',bic.rowid) bom_comp_attribute3,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE4',bic.rowid) bom_comp_attribute4,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE5',bic.rowid) bom_comp_attribute5,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE6',bic.rowid) bom_comp_attribute6,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE7',bic.rowid) bom_comp_attribute7,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE8',bic.rowid) bom_comp_attribute8,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE9',bic.rowid) bom_comp_attribute9,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE10',bic.rowid) bom_comp_attribute10,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE11',bic.rowid) bom_comp_attribute11,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE12',bic.rowid) bom_comp_attribute12,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE13',bic.rowid) bom_comp_attribute13,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE14',bic.rowid) bom_comp_attribute14,
  xxen_util.display_flexfield_value(702,'BOM_INVENTORY_COMPONENTS',bic.attribute_category,'ATTRIBUTE15',bic.rowid) bom_comp_attribute15
 from
  bom_bill_of_materials    bbom
 ,bom_inventory_components bic
 where
  bbom.common_bill_sequence_id = bic.bill_sequence_id (+) and
  bbom.assembly_type = 1 and -- BOM
  nvl(bbom.effectivity_control,1) < 3 and
  nvl(bic.eco_for_production,2) = 2 and
  --
  &lp_effective_display_clause1
  &lp_effective_display_clause2
  --
  nvl(bbom.alternate_bom_designator,'?') = nvl(:p_alternate_bom,'?') and
  -- exclude common boms for the moment
  bbom.bill_sequence_id = bbom.common_bill_sequence_id and
  bbom.common_organization_id is null and
  bbom.common_assembly_item_id is null
),
bom_tree as
(
 select distinct
  mp.organization_code,
  msiv1.concatenated_segments assembly_item,
  msiv1.description assembly_description,
  bom.bill_comment,
  bom.bill_implemented_flag,
  bom.bill_implementation_date,
  bom.effectivity_control_code,
  bom.effectivity_control,
  bom.alternate_bom,
  bom.common_bill_flag,
  bom.bill_attribute_category,
  bom.bom_bill_attribute1,
  bom.bom_bill_attribute2,
  bom.bom_bill_attribute3,
  bom.bom_bill_attribute4,
  bom.bom_bill_attribute5,
  bom.bom_bill_attribute6,
  bom.bom_bill_attribute7,
  bom.bom_bill_attribute8,
  bom.bom_bill_attribute9,
  bom.bom_bill_attribute10,
  bom.bom_bill_attribute11,
  bom.bom_bill_attribute12,
  bom.bom_bill_attribute13,
  bom.bom_bill_attribute14,
  bom.bom_bill_attribute15,
  --
  msiv2.concatenated_segments component_item,
  msiv2.description component_description,
  bom.item_seq,
  bom.operation_seq,
  bom.component_quantity,
  bom.inverse_quantity,
  bom.date_effective_from,
  bom.date_effective_to,
  bom.end_item_unit_number_from,
  bom.end_item_unit_number_to,
  bom.basis_type,
  bom.basis,
  bom.planning_percent,
  bom.yield,
  bom.enforce_integer_quantity,
  bom.include_in_cost_rollup,
  bom.supply_type,
  bom.supply_subinventory,
  bom.supply_locator,
  bom.component_implemented_flag,
  bom.component_implementation_date,
  bom.component_attribute_category,
  bom.bom_comp_attribute1,
  bom.bom_comp_attribute2,
  bom.bom_comp_attribute3,
  bom.bom_comp_attribute4,
  bom.bom_comp_attribute5,
  bom.bom_comp_attribute6,
  bom.bom_comp_attribute7,
  bom.bom_comp_attribute8,
  bom.bom_comp_attribute9,
  bom.bom_comp_attribute10,
  bom.bom_comp_attribute11,
  bom.bom_comp_attribute12,
  bom.bom_comp_attribute13,
  bom.bom_comp_attribute14,
  bom.bom_comp_attribute15,
  --
  bom.bill_sequence_id,
  bom.organization_id,
  bom.assembly_item_id,
  bom.component_sequence_id,
  bom.component_item_id
 from
   bom
 , (select msiv.* from mtl_system_items_vl msiv where msiv.organization_id = :p_organization_id) msiv1
 , (select msiv.* from mtl_system_items_vl msiv where msiv.organization_id = :p_organization_id) msiv2
 , (select mp.* from mtl_parameters mp where mp.organization_id = :p_organization_id) mp
 where
  bom.organization_id = mp.organization_id and
  bom.assembly_item_id = msiv1.inventory_item_id and
  bom.organization_id = msiv1.organization_id and
  bom.component_item_id = msiv2.inventory_item_id (+) and
  bom.organization_id = msiv2.organization_id (+)
 connect by nocycle
  prior decode(:p_explode_bom,'Y',bom.component_item_id,null) = bom.assembly_item_id and
  prior decode(:p_explode_bom,'Y',bom.organization_id,null) = bom.organization_id
 start with
  (bom.assembly_item_id,bom.organization_id) in
  (select
    bbom.assembly_item_id,bbom.organization_id
   from
    mtl_parameters mp,
    mtl_system_items_vl msiv,
    bom_bill_of_materials bbom
   where
     mp.organization_id = msiv.organization_id and
     msiv.organization_id = bbom.organization_id and
     msiv.inventory_item_id = bbom.assembly_item_id and
     msiv.bom_enabled_flag = 'Y' and
     msiv.bom_item_type != 5 and -- exclude product family
     bbom.assembly_type = 1 and -- BOM
     nvl(bbom.effectivity_control,1) < 3 and
     nvl(bbom.alternate_bom_designator,'?') = nvl(:p_alternate_bom,'?') and
     -- exclude common boms for the moment
     bbom.bill_sequence_id = bbom.common_bill_sequence_id and
     bbom.common_organization_id is null and
     bbom.common_assembly_item_id is null and
     mp.organization_code = :p_organization_code and
     1=1
  )
),
bom_subst as
( --from bom_substitute_components_v
 select
  bic2.component_sequence_id,
  bsc.substitute_component_id,
  msiv.concatenated_segments substitute_item,
  msiv.description substitute_description,
  bsc.substitute_item_quantity substitute_quantity,
  round(decode(bsc.substitute_item_quantity,0,0,1/bsc.substitute_item_quantity),37) substitute_inverse_quantity,
  xxen_util.meaning(bsc.enforce_int_requirements,'BOM_ENFORCE_INT_REQUIREMENTS',700) subst_integer_requirements,
  xxen_util.display_flexfield_context(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category) substitute_attribute_category,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE1',bsc.rowid) bom_sub_attribute1,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE2',bsc.rowid) bom_sub_attribute2,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE3',bsc.rowid) bom_sub_attribute3,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE4',bsc.rowid) bom_sub_attribute4,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE5',bsc.rowid) bom_sub_attribute5,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE6',bsc.rowid) bom_sub_attribute6,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE7',bsc.rowid) bom_sub_attribute7,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE8',bsc.rowid) bom_sub_attribute8,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE9',bsc.rowid) bom_sub_attribute9,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE10',bsc.rowid) bom_sub_attribute10,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE11',bsc.rowid) bom_sub_attribute11,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE12',bsc.rowid) bom_sub_attribute12,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE13',bsc.rowid) bom_sub_attribute13,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE14',bsc.rowid) bom_sub_attribute14,
  xxen_util.display_flexfield_value(702,'BOM_SUBSTITUTE_COMPONENTS',bsc.attribute_category,'ATTRIBUTE15',bsc.rowid) bom_sub_attribute15
 from
  bom_substitute_components bsc,
  bom_bill_of_materials bbom,
  bom_inventory_components bic1,
  bom_inventory_components bic2, /* current component record */
  mtl_system_items_vl msiv /* component being referenced */
 where
  bsc.component_sequence_id = bic1.component_sequence_id and
  bic1.bill_sequence_id = bbom.bill_sequence_id and
  bsc.substitute_component_id = msiv.inventory_item_id and
  bbom.organization_id = msiv.organization_id and
  nvl(bsc.acd_type, 1) <> 3 and
  bic2.bill_sequence_id = bic1.bill_sequence_id and
  decode(bic2.implementation_date, null, bic2.old_component_sequence_id, bic2.component_sequence_id) = decode(bic1.implementation_date, null, bic1.old_component_sequence_id, bic1.component_sequence_id) and
  bic1.effectivity_date =
  (select
    max(bic3.effectivity_date)
   from
    bom_substitute_components bsc3,
    bom_inventory_components bic3
   where
    bic3.component_sequence_id = bsc3.component_sequence_id and
    decode(bic3.implementation_date, null, bic3.old_component_sequence_id, bic3.component_sequence_id) = decode(bic1.implementation_date, null, bic1.old_component_sequence_id, bic1.component_sequence_id) and
    bic3.bill_sequence_id = bic1.bill_sequence_id and
    bsc3.substitute_component_id = bsc.substitute_component_id and
    bic3.effectivity_date <= bic2.effectivity_date
  )
)
&processed_sub_query1
&processed_sub_query2
--
-- Main Query Starts Here
select /*+ push_pred(bom_subst) */
 --process--
 null action_,
 null status_,
 null message_,
 null request_id_,
 :p_upload_mode upload_mode,
 :p_enable_attrs_update enable_attrs_update,
 --
 case row_number() over (partition by bom_tree.bill_sequence_id,bom_tree.component_sequence_id order by bom_tree.bill_sequence_id,bom_tree.component_sequence_id,bom_subst.substitute_item)
 when 1 then 'Component' else 'Substitute'
 end line_type,
 --
 bom_tree.organization_code,
 bom_tree.assembly_item,
 bom_tree.assembly_description,
 bom_tree.bill_comment,
 bom_tree.alternate_bom,
 bom_tree.bill_implementation_date bill_implementation_date,
 bom_tree.bill_implemented_flag,
 bom_tree.common_bill_flag,
 bom_tree.effectivity_control,
 bom_tree.effectivity_control_code,
 bom_tree.bill_attribute_category,
 bom_tree.bom_bill_attribute1,
 bom_tree.bom_bill_attribute2,
 bom_tree.bom_bill_attribute3,
 bom_tree.bom_bill_attribute4,
 bom_tree.bom_bill_attribute5,
 bom_tree.bom_bill_attribute6,
 bom_tree.bom_bill_attribute7,
 bom_tree.bom_bill_attribute8,
 bom_tree.bom_bill_attribute9,
 bom_tree.bom_bill_attribute10,
 bom_tree.bom_bill_attribute11,
 bom_tree.bom_bill_attribute12,
 bom_tree.bom_bill_attribute13,
 bom_tree.bom_bill_attribute14,
 bom_tree.bom_bill_attribute15,
 --
 bom_tree.item_seq,
 bom_tree.operation_seq operation_seq_old,
 bom_tree.operation_seq,
 bom_tree.component_item,
 bom_tree.component_description,
 bom_tree.component_quantity,
 bom_tree.inverse_quantity,
 bom_tree.date_effective_from date_effective_from_old,
 bom_tree.date_effective_from date_effective_from,
 bom_tree.date_effective_to date_effective_to,
 bom_tree.end_item_unit_number_from end_item_unit_number_from_old,
 bom_tree.end_item_unit_number_from,
 bom_tree.end_item_unit_number_to,
 bom_tree.basis_type,
 bom_tree.basis,
 bom_tree.planning_percent,
 bom_tree.yield,
 bom_tree.enforce_integer_quantity,
 bom_tree.include_in_cost_rollup,
 bom_tree.supply_type,
 bom_tree.supply_subinventory,
 bom_tree.supply_locator,
 bom_tree.component_implemented_flag,
 bom_tree.component_implementation_date component_implementation_date,
 bom_tree.component_attribute_category,
 bom_tree.bom_comp_attribute1,
 bom_tree.bom_comp_attribute2,
 bom_tree.bom_comp_attribute3,
 bom_tree.bom_comp_attribute4,
 bom_tree.bom_comp_attribute5,
 bom_tree.bom_comp_attribute6,
 bom_tree.bom_comp_attribute7,
 bom_tree.bom_comp_attribute8,
 bom_tree.bom_comp_attribute9,
 bom_tree.bom_comp_attribute10,
 bom_tree.bom_comp_attribute11,
 bom_tree.bom_comp_attribute12,
 bom_tree.bom_comp_attribute13,
 bom_tree.bom_comp_attribute14,
 bom_tree.bom_comp_attribute15,
 --
 bom_subst.substitute_item substitute_item_old,
 bom_subst.substitute_item,
 bom_subst.substitute_description,
 bom_subst.substitute_quantity,
 bom_subst.substitute_inverse_quantity,
 bom_subst.subst_integer_requirements,
 bom_subst.substitute_attribute_category,
 bom_subst.bom_sub_attribute1,
 bom_subst.bom_sub_attribute2,
 bom_subst.bom_sub_attribute3,
 bom_subst.bom_sub_attribute4,
 bom_subst.bom_sub_attribute5,
 bom_subst.bom_sub_attribute6,
 bom_subst.bom_sub_attribute7,
 bom_subst.bom_sub_attribute8,
 bom_subst.bom_sub_attribute9,
 bom_subst.bom_sub_attribute10,
 bom_subst.bom_sub_attribute11,
 bom_subst.bom_sub_attribute12,
 bom_subst.bom_sub_attribute13,
 bom_subst.bom_sub_attribute14,
 bom_subst.bom_sub_attribute15,
 --
 bom_tree.bill_sequence_id,
 bom_tree.organization_id,
 bom_tree.assembly_item_id,
 bom_tree.component_sequence_id,
 bom_tree.component_item_id,
 bom_subst.substitute_component_id,
 to_char(null) row_id
from
 bom_tree,
 bom_subst
where
 :p_display_option = :p_display_option and
 nvl(:p_restrict_org,'?') = nvl(:p_restrict_org,'?') and
 bom_tree.component_sequence_id = bom_subst.component_sequence_id (+)