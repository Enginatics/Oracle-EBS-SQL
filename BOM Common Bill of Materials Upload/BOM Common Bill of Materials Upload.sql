/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Common Bill of Materials Upload
-- Description: BOM Common Bill of Materials Upload
============================================
The upload can be used to create Common BOM from the BOMS defined in the specified source organization in one or more target organizations as determined by the Scope Parameter:

All - All Organizations 
BOMs will made Common to all other Organizations that share the same Master Organization as the Source Organization and to which the current responsibility has access to.
 
Hierarchy – Organization Hierarchy
BOMs will made Common to all Organizations the current responsibility has access to and which are below the Source Organization in the specified Hierarchy.

Organization – Specific Organizations
BOMs will be made Common to the specified Target Organizations. The Target Organizations must share the same Master Organization as the Source Organization.

Unlike the Oracle standard Create Common BOM process which requires all sub-component BOMS and substitute component BOMs to be made common individually, this upload process will iterate through the sub-assemblies and substitute assemblies and make them common in the Target Organization if they have not already been defined.

A prerequisite however, as with the BOM Bill of Materials Upload (Amazon), is that all the items are already assigned in the Target Organization.

If any component Items are not defined in the Target Organization, these will be identified in the upload Excel.

Usage
=====
- Specify the Source Organization in which the BOMS are defined
- Specify the Scope to determine the Target Organizations
- Use the Report Parameters to select the BOMS to be made common
- The generated Excel will contain one row per BOM and Target Organization combination

- The generated Excel Identifies if the BOM Item is defined in the Target Organization, if it already exists as a BOM in the Target Organization, if it is a Common BOM in the target organization already, and if the BOM has any component items which are not defined in the Target Organization. These will prevent the BOM upload process from attempting to make the BOM common in the target organization.

- In the generated Excel, set the ‘Create Common Bom’ column to Yes against the BOM/Target Organization combinations to be made Common.
- Save and upload the Excel to process the selections made back into Oracle
- After upload, a new Excel is generated showing the success/error status of the creation of the Common BOMS in each target organization.

Templates
=========
Common BOM Upload Template
In this template, the user must review and manually select the BOM/Target Organization combinations to be made Common. Setting the ‘Create Common Bom’ flag against a BOM/Target Organization combination will trigger the row for update and processing during upload.

Automatic Common BOM Upload Template
In this template, the excel is generated with the ‘Create Common Bom’ flag set against all BOM/Target Organization combinations and the rows already flagged for update and processing. In this template the user can opt out of creating a common BOM for specific BOM/Target Organization combinations by either de-selecting (clearing) the ‘Create Common Bom’ flag column or by deleting the row from the spreadsheet. 

-- Excel Examle Output: https://www.enginatics.com/example/bom-common-bill-of-materials-upload/
-- Library Link: https://www.enginatics.com/reports/bom-common-bill-of-materials-upload/
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
  xxen_util.meaning(nvl2(bbom.common_assembly_item_id,'Y','N'),'SYS_YES_NO',700) common_bill_flag,
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
  mp.attribute1 organization_region,
  mp.attribute2 organization_country,
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
  bom.component_item_id,
  mp.master_organization_id
 from
   bom
 , mtl_system_items_vl msiv1
 , mtl_system_items_vl msiv2
 , mtl_parameters mp
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
     msiv.bom_item_type != 5 and -- Exclude Product Family
     bbom.assembly_type = 1 and -- BOM
     nvl(bbom.effectivity_control,1) < 3 and
     nvl(bbom.alternate_bom_designator,'?') = nvl(:p_alternate_bom,'?') and
     -- exclude common boms
     bbom.bill_sequence_id = bbom.common_bill_sequence_id and 
     bbom.common_organization_id is null and
     bbom.common_assembly_item_id is null and 
     mp.organization_code = :p_source_organization_code and
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
)
--
-- Main Query Starts Here
select
 x.*
from
(
select /*+ push_pred(bom_subst) */
 --process--
 case when nvl2(:p_autopopulate_upload_status,'Y','N') = 'Y' then xxen_upload.action_meaning(xxen_upload.action_update) else null end action_,
 case when nvl2(:p_autopopulate_upload_status,'Y','N') = 'Y' then xxen_upload.status_meaning(xxen_upload.status_new) else null end status_,
 case when nvl2(:p_autopopulate_upload_status,'Y','N') = 'Y' then xxen_util.description('U_EXCEL_MSG_VALIDATION_PENDING', 'XXEN_REPORT_TRANSLATIONS', 0) else null end message_,
 null request_id_,
 to_char(null) row_id,
 :p_enable_attrs_update enable_attrs_update,
 case when nvl2(:p_autopopulate_upload_status,'Y','N') = 'Y' then xxen_util.meaning('Y','YES_NO',0) else null end create_common_bom,
 boms.source_organization,
 boms.assembly_item,
 boms.assembly_description,
 boms.alternate_bom,
 boms.target_organization,
 boms.is_item_defined_in_tgt,
 boms.is_bom_defined_in_tgt,
 boms.is_common_bom_in_tgt,
 boms.comp_items_not_defined_in_tgt || nvl2(comp_items_not_defined_in_tgt,nvl2(subst_items_not_defined_in_tgt,',',null),null) || subst_items_not_defined_in_tgt comp_items_not_defined_in_tgt,
 boms.bill_sequence_id,
 boms.assembly_item_id,
 boms.source_organization_id,
 boms.target_organization_id
from
(
 select
  bom_tree.organization_code source_organization,
  bom_tree.assembly_item,
  bom_tree.assembly_description,
  bom_tree.alternate_bom,
  --
  mp.organization_code target_organization,
  --
  nvl((select 'Yes' from mtl_system_items_vl msiv2 where msiv2.organization_id = mp.organization_id and msiv2.inventory_item_id = bom_tree.assembly_item_id),'No') is_item_defined_in_tgt,
  nvl((select 'Yes' from bom_bill_of_materials bbom2 where bbom2.organization_id = mp.organization_id and bbom2.assembly_item_id = bom_tree.assembly_item_id and nvl(bbom2.alternate_bom_designator,'?') = nvl(bom_tree.alternate_bom,'?') and rownum <= 1),'No') is_bom_defined_in_tgt,
  nvl((select 'Yes' from bom_bill_of_materials bbom2 where bbom2.organization_id = mp.organization_id and bbom2.common_organization_id = bom_tree.organization_id and bbom2.common_assembly_item_id = bom_tree.assembly_item_id and rownum <= 1),'No') is_common_bom_in_tgt,
  (select distinct
          listagg(msiv.concatenated_segments,',') within group (order by msiv.concatenated_segments)
   from   bom_inventory_components bic,
          mtl_system_items_vl msiv
   where  bic.bill_sequence_id = bom_tree.bill_sequence_id and
          msiv.organization_id = bom_tree.organization_id and
          msiv.inventory_item_id = bic.component_item_id and
          not exists (select null from mtl_system_items_vl msiv2 where msiv2.organization_id = mp.organization_id and msiv2.inventory_item_id = bic.component_item_id)
   ) comp_items_not_defined_in_tgt,
  (select distinct
          listagg(msiv.concatenated_segments,',') within group (order by msiv.concatenated_segments)
   from   bom_inventory_components bic,
          bom_substitute_components bsc,
          mtl_system_items_vl msiv
   where  bic.bill_sequence_id = bom_tree.bill_sequence_id and
          bsc.component_sequence_id = bic.component_sequence_id and
          msiv.organization_id = bom_tree.organization_id and
          msiv.inventory_item_id = bsc.substitute_component_id and
          not exists (select null from mtl_system_items_vl msiv2 where msiv2.organization_id = mp.organization_id and msiv2.inventory_item_id = bsc.substitute_component_id)
   ) subst_items_not_defined_in_tgt,
  --
  bom_tree.bill_sequence_id,
  bom_tree.assembly_item_id,
  bom_tree.organization_id source_organization_id,
  mp.organization_id target_organization_id
 from
  bom_tree,
  mtl_parameters mp
 where
 mp.master_organization_id = bom_tree.master_organization_id and
 mp.organization_id != bom_tree.organization_id and
 mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
 2=2
 union -- substitutes
 select
  bom_tree.organization_code source_organization,
  bom_subst.substitute_item,
  bom_subst.substitute_description,
  bbom.alternate_bom_designator alternate_bom,
  --
  mp.organization_code target_organization,
  --
  nvl((select 'Yes' from mtl_system_items_vl msiv2 where msiv2.organization_id = mp.organization_id and msiv2.inventory_item_id = bom_subst.substitute_component_id),'No') is_item_defined_in_tgt,
  nvl((select 'Yes' from bom_bill_of_materials bbom2 where bbom2.organization_id = mp.organization_id and bbom2.assembly_item_id = bom_subst.substitute_component_id and rownum <= 1),'No') is_bom_defined_in_tgt,
  nvl((select 'Yes' from bom_bill_of_materials bbom2 where bbom2.organization_id = mp.organization_id and bbom2.common_organization_id = bbom.organization_id and bbom2.common_assembly_item_id = bbom.assembly_item_id and rownum <= 1),'No') is_common_bom_in_tgt,
  (select distinct
          listagg(msiv.concatenated_segments,',') within group (order by msiv.concatenated_segments)
   from   bom_inventory_components bic,
          mtl_system_items_vl msiv
   where  bic.bill_sequence_id = bbom.bill_sequence_id and
          msiv.organization_id = bbom.organization_id and
          msiv.inventory_item_id = bom_subst.substitute_component_id and
          not exists (select null from mtl_system_items_vl msiv2 where msiv2.organization_id = mp.organization_id and msiv2.inventory_item_id = bom_subst.substitute_component_id)
   ) comp_items_not_defined_in_tgt,
  (select distinct
          listagg(msiv.concatenated_segments,',') within group (order by msiv.concatenated_segments)
   from   bom_inventory_components bic,
          bom_substitute_components bsc,
          mtl_system_items_vl msiv
   where  bic.bill_sequence_id = bbom.bill_sequence_id and
          bsc.component_sequence_id = bic.component_sequence_id and
          msiv.organization_id = bbom.organization_id and
          msiv.inventory_item_id = bsc.substitute_component_id and
          not exists (select null from mtl_system_items_vl msiv2 where msiv2.organization_id = mp.organization_id and msiv2.inventory_item_id = bsc.substitute_component_id)
   ) subst_items_not_defined_in_tgt,
  --
  bbom.bill_sequence_id,
  bom_subst.substitute_component_id,
  bom_tree.organization_id source_organization_id,
  mp.organization_id target_organization_id
 from
  bom_tree,
  bom_subst,
  bom_bill_of_materials bbom,
  mtl_parameters mp
 where
 :p_explode_bom = 'Y' and
 bom_tree.component_sequence_id = bom_subst.component_sequence_id and
 bbom.organization_id = bom_tree.organization_id and
 bbom.assembly_item_id =  bom_subst.substitute_component_id and
 mp.master_organization_id = bom_tree.master_organization_id and
 mp.organization_id != bom_tree.organization_id and
 mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
 2=2
) boms
where
 :p_display_option = :p_display_option and
 :p_scope = :p_scope and
 3=3
--
&not_use_first_block
&report_table_select
&report_table_name &report_table_where_clause
&processed_run
) x
order by
 source_organization,
 target_organization,
 decode(is_bom_defined_in_tgt,'Yes',2,1),
 assembly_item,
 assembly_description,
 alternate_bom