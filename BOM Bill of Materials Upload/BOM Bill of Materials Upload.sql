/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
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
  --
  bic.component_sequence_id,
  bic.component_item_id,
  bic.item_num item_seq,
  bic.operation_seq_num operation_seq,
  bic.component_quantity,
  bic.effectivity_date  date_effective_from,
  bic.disable_date      date_effective_to,
  bic.from_end_item_unit_number end_item_unit_number_from,
  bic.to_end_item_unit_number end_item_unit_number_to,
  nvl(bic.basis_type,1) basis_type,
  xxen_util.meaning(nvl(bic.basis_type,1),'BOM_BASIS_TYPE',700) basis,
  xxen_util.meaning(decode(bic.implementation_date,null,2,1),'SYS_YES_NO',700) component_implemented_flag,
  bic.implementation_date component_implementation_date
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
  --
  msiv2.concatenated_segments component_item,
  msiv2.description component_description,
  bom.item_seq,
  bom.operation_seq,
  bom.component_quantity,
  bom.date_effective_from,
  bom.date_effective_to,
  bom.end_item_unit_number_from,
  bom.end_item_unit_number_to,
  bom.basis_type,
  bom.basis,
  bom.component_implemented_flag,
  bom.component_implementation_date,
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
     msiv.bom_item_type in (1,2,4) and
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
  xxen_util.meaning(bsc.enforce_int_requirements,'BOM_ENFORCE_INT_REQUIREMENTS',700) subst_integer_requirements
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
),
item_dff as
(
 select
  rowidtochar(msib.rowid) row_id,
  msib.attribute_category,
  msib.inventory_item_id,
  msib.organization_id
 from
  mtl_system_items_b msib
 where
  :p_show_comp_item_dff is not null
)
&processed_sub_query1
&processed_sub_query2
--
-- Main Query Starts Here
select /*+ push_pred(item_dff) */
 x.*
 &lp_component_item_dffs
from
(
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
 --
 bom_tree.item_seq,
 bom_tree.operation_seq operation_seq_old,
 bom_tree.operation_seq,
 bom_tree.component_item,
 bom_tree.component_description,
 bom_tree.component_quantity,
 bom_tree.date_effective_from date_effective_from_old,
 bom_tree.date_effective_from date_effective_from,
 bom_tree.date_effective_to date_effective_to,
 bom_tree.end_item_unit_number_from end_item_unit_number_from_old,
 bom_tree.end_item_unit_number_from,
 bom_tree.end_item_unit_number_to,
 bom_tree.basis_type,
 bom_tree.basis,
 bom_tree.component_implemented_flag,
 bom_tree.component_implementation_date component_implementation_date,
 --
 bom_subst.substitute_item substitute_item_old,
 bom_subst.substitute_item,
 bom_subst.substitute_description,
 bom_subst.substitute_quantity,
 bom_subst.subst_integer_requirements,
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
--
&not_use_first_block
&report_table_select1
&report_table_select2 
&report_table_name &report_table_where_clause 
&processed_run
) x,
item_dff cidff
where
 x.organization_id = cidff.organization_id(+) and
 x.component_item_id = cidff.inventory_item_id(+)
order by
 organization_code,
 assembly_item,
 operation_seq,
 item_seq,
 component_item,
 substitute_item