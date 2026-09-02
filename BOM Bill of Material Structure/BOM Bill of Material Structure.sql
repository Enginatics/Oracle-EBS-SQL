/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: BOM Bill of Material Structure
-- Description: Description: Bill of Material Structure Report

Provides equivalent functionality to the the following standard reports:
- Bill of Material Structure Report
  (Template 'Bill of Material Structure Report' with parameter 'Bills with Loop Errors Only' = No)
- Bill of Material Loop Report
  (Template Bill of Material Structure Report with parameter 'Bills with Loop Errors Only' = Yes)
- Consolidated Bills of Material Report
  (Template 'Consolidated Bill of Material Report')

Application: Bills of Material
Source: Bill of Material Structure Report GUI (XML)
Short Name: BOMRBOMSG_XML
DB package: BOM_BOMRBOMS_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/bom-bill-of-material-structure/
-- Library Link: https://www.enginatics.com/reports/bom-bill-of-material-structure/
-- Run Report: https://demo.enginatics.com/

with q_assemblies as
(
 select
  (select mp.organization_code from mtl_parameters mp where bbom.organization_id=mp.organization_id) assembly_organization_code,
  (select haouv.name from hr_all_organization_units_vl haouv where bbom.organization_id=haouv.organization_id) assembly_organization,
  msiv.concatenated_segments assembly,
  msiv.description assembly_description,
  msiv.long_description assembly_long_description,
  msiv.inventory_item_status_code assembly_item_status,
  xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) assembly_item_type,
  xxen_util.meaning(msiv.bom_item_type,'BOM_ITEM_TYPE',700) bom_item_type,
  mlu.meaning engineering_bill,
  msiv.primary_uom_code assembly_uom,
  bbom.alternate_bom_designator alt_bom_designator,
  bad.description alt_bom_designator_desc,
  rev.revision assembly_revision,
  fnd_date.date_to_displaydt(:lp_revision_date) assembly_revision_date,
  (select distinct
    listagg(bdde.element_name || nvl2(bom_bomrboms_xmlp_pkg.get_ele_desc(msiv.bom_item_type, bdde.element_name, msiv.item_catalog_group_id),': ' || bom_bomrboms_xmlp_pkg.get_ele_desc(msiv.bom_item_type, bdde.element_name, msiv.item_catalog_group_id),null),', ') within group (order by bdde.element_name)
   from
    bom_dependent_desc_elements bdde
   where
    bdde.bill_sequence_id=bet.top_bill_sequence_id and
    rownum <= 40 -- cap to ensure listagg doesnt exceed 4K
  ) descriptive_elements,
  xxen_util.meaning(bet.loop_flag,'SYS_YES_NO',700) assembly_has_loop,
  to_char(bet.top_bill_sequence_id ) top_bill_sequence_id,
  msiv.inventory_item_id assembly_item_id,
  bbom.organization_id assembly_organization_id,
  msiv.item_catalog_group_id assembly_item_catalog_group_id,
  --
  &assbly_dff_attributes1
  &assbly_item_dff_attributes1
  bbom.rowid  assembly_row_id,
  msiv.row_id assembly_item_row_id
 from
  bom_explosion_temp bet,
  bom_bill_of_materials bbom,
  bom_lists blist,
  mtl_system_items_vl msiv,
  mtl_item_revisions_b rev,
  mfg_lookups mlu,
  bom_alternate_designators bad
 where
      bet.group_id = :p_group_id
  and bet.plan_level = 0
  and bet.top_bill_sequence_id = bbom.bill_sequence_id
  and blist.sequence_id = :p_sequence_id1
  and blist.organization_id = bbom.organization_id
  and bbom.assembly_item_id = msiv.inventory_item_id
  and bbom.organization_id = msiv.organization_id
  and ( (bbom.alternate_bom_designator is null and bad.organization_id = -1) or
        (bbom.alternate_bom_designator is not null and bbom.alternate_bom_designator = bad.alternate_designator_code and bad.organization_id = blist.organization_id)
      )
  and mlu.lookup_type = 'BOM_NO_YES'
  and mlu.lookup_code = bbom.assembly_type
  and rev.organization_id = blist.organization_id
  and rev.inventory_item_id = bbom.assembly_item_id
  and rev.effectivity_date <= :lp_revision_date
  and not exists
   (select
     'MAX REV DATE'
    from
     mtl_item_revisions_b rev2
    where
     rev2.inventory_item_id = bbom.assembly_item_id
     and rev2.organization_id = bbom.organization_id
     and rev2.effectivity_date > rev.effectivity_date
     and rev2.effectivity_date <= :lp_revision_date)
  and not exists
   (select
     'MAX REV'
    from
     mtl_item_revisions_b rev3
    where
     rev3.inventory_item_id = bbom.assembly_item_id
     and rev3.organization_id = bbom.organization_id
     and rev3.effectivity_date = rev.effectivity_date
     and rev3.revision > rev.revision)
  and (((:p_verify_flag is null) or (:p_verify_flag <> 1)) or ((:p_verify_flag = 1) and (bet.loop_flag = 1)))
),
q_components as
(
 select
  bev.sort_order comp_sort_order,
  lpad(to_char(bev.plan_level), least(9,bev.plan_level),'.') plan_level,
  bev.item_num comp_item_seq_num,
  bev.operation_seq_num comp_operation_seq_num,
  bev.item_number comp_number,
  bev.unit_of_measure comp_item_uom,
  bev.effectivity_date comp_effectivity_date,
  to_char(bev.effectivity_date, 'HH24:MI') comp_effectivity_time,
  bev.disable_date comp_disable_date,
  to_char(bev.disable_date, 'HH24:MI') comp_disable_time,
  round(bev.component_quantity,:p_qty_precision) comp_quantity,
  round(bev.extended_quantity,:p_qty_precision) comp_extended_quantity,
  bev.change_notice comp_change_notice,
  xxen_util.meaning(bev.eng_item_flag,'YES_NO',3) comp_eng_item_flag,
  bev.parent_alternate comp_alternate,
  xxen_util.meaning(bev.item_type,'ITEM_TYPE',3) comp_item_type,
  bev.planning_factor comp_planning_factor,
  round(bev.component_yield_factor,:p_qty_precision) comp_yield_factor,
  bev.supply_subinventory comp_supply_subinventory,
  milk.concatenated_segments comp_locator,
  xxen_util.meaning(msiv.wip_supply_type,'WIP_SUPPLY',700) comp_item_supply_type,
  msiv.wip_supply_subinventory comp_item_supply_subinventory,
  (select milk2.concatenated_segments from mtl_item_locations_kfv milk2 where msiv.wip_supply_locator_id=milk2.inventory_location_id and msiv.organization_id=milk2.organization_id) comp_item_supply_locator,
  xxen_util.yes(case when decode(bev.wip_supply_type,msiv.wip_supply_type,0,1)+decode(bev.supply_subinventory,msiv.wip_supply_subinventory,0,1)+decode(bev.supply_locator_id,msiv.wip_supply_locator_id,0,1)>0 then 'Y' end) comp_supply_attributes_differ,
  round(bev.manufacturing_lead_time,:p_qty_precision) mfg_lead_time,
  bev.operation_lead_time_percent operation_lead_time_percent,
  round((1-(bev.operation_lead_time_percent/100))*msib_a.full_lead_time,:p_qty_precision) operation_offset,
  round(bev.cum_manufacturing_lead_time,:p_qty_precision) cumulative_mfg_lead_time,
  round(bev.cumulative_total_lead_time,:p_qty_precision) cumulative_total_lead_time,
  round(bev.minimum_quantity,:p_qty_precision) comp_minimum_quantity,
  round(bev.maximum_quantity,:p_qty_precision) comp_maximum_quantity,
  msiv.inventory_item_status_code comp_item_status,
  msiv.description comp_description,
  msiv.long_description comp_long_description,
  bom_bomrboms_xmlp_pkg.get_rev(bev.organization_id, bev.component_item_id) comp_revision,
  bom_bomrboms_xmlp_pkg.cf_revision_descformula(bev.component_item_id, bom_bomrboms_xmlp_pkg.get_rev(bev.organization_id, bev.component_item_id)) comp_revision_desc,
  bom_bomrboms_xmlp_pkg.supply_type_dispformula(bev.wip_supply_type) comp_supply_type,
  bev.so_basis so_basis,
  bom_bomrboms_xmlp_pkg.eng_bill_dispformula(bev.eng_bill) eng_bill,
  bom_bomrboms_xmlp_pkg.optional_dispformula(bev.optional) optional,
  bom_bomrboms_xmlp_pkg.mutually_dispformula(bev.mutually_exclusive_options) mutually_excl_options,
  bom_bomrboms_xmlp_pkg.check_atp_dispformula(bev.check_atp) check_atp,
  bom_bomrboms_xmlp_pkg.required_to_ship_dispformula(bev.required_to_ship) required_to_ship,
  bom_bomrboms_xmlp_pkg.required_for_revenue_dispformu(bev.required_for_revenue) required_for_revenue,
  bom_bomrboms_xmlp_pkg.include_on_ship_docs_dispformu(bev.include_on_ship_docs) include_on_ship_docs,
  (select distinct
    listagg(brd.component_reference_designator||nvl2(brd.ref_designator_comment,': '||brd.ref_designator_comment,null),', ') within group (order by brd.component_reference_designator)
   from
    bom_ref_designators_view brd
   where
    brd.component_sequence_id=bev.component_sequence_id and
    rownum <= 15 -- cap to ensure listagg doesnt exceed 4K
  ) reference_designators,
  xxen_util.meaning(bev.loop_flag,'SYS_YES_NO',700) component_has_loop,
  msib_a.organization_id assembly_organization_id,
  bev.parent_item_id assembly_item_id,
  bev.organization_id comp_org_id,
  bev.top_bill_sequence_id top_bill_sequence_id,
  bev.component_sequence_id,
  bev.component_item_id,
  &comp_dff_attributes1
  &comp_item_dff_attributes1
  bcb.rowid  component_row_id,
  msiv.rowid component_item_row_id
 from
  bom_explosion_view bev,
  mtl_item_locations_kfv milk,
  bom_bill_of_materials bom,
  bom_components_b bcb,
  mtl_system_items_b msib_a,
  mtl_system_items_vl msiv
 where
      bev.group_id = :p_group_id
  and bev.plan_level > 0
  and bev.supply_locator_id = milk.inventory_location_id(+)
  and milk.organization_id(+) = bev.organization_id
  and bev.parent_item_id = msib_a.inventory_item_id
  and bev.organization_id = msib_a.organization_id
  and bev.component_item_id = msiv.inventory_item_id
  and bev.organization_id = msiv.organization_id
  and bom.bill_sequence_id = bev.bill_sequence_id
  and bcb.component_sequence_id = bev.component_sequence_id
  and ( ( (:p_verify_flag is null) or (:p_verify_flag <> 1) ) or ( (:p_verify_flag = 1) and (bev.loop_flag = 1) ) )
),
q_subst_comp as
(select /*+ inline */
  msiv.concatenated_segments substitute_component,
  msiv.description substitute_description,
  msiv.long_description substitute_long_description,
  bsc.substitute_item_quantity substitute_quantity,
  msiv.primary_uom_code substitute_uom,
  bsc.component_sequence_id,
  msiv.organization_id organization_id,
  msiv.inventory_item_id item_id
 from
  bom_sub_components_view bsc,
  mtl_system_items_vl msiv
 where
     msiv.inventory_item_id = bsc.substitute_component_id
 and :p_print_option5_flag = 1
)
--
-- Main Query Starts Here
--
select
 qa.assembly_organization_code,
 qa.assembly_organization,
 qa.assembly,
 qa.assembly_description,
 qa.assembly_long_description,
 qa.assembly_item_status,
 qa.assembly_item_type,
 qa.bom_item_type,
 qa.engineering_bill,
 qa.assembly_uom,
 qa.alt_bom_designator,
 qa.alt_bom_designator_desc,
 qa.assembly_revision,
 qa.assembly_revision_date,
 &assembly_category_columns
 qa.descriptive_elements,
 &assbly_dff_attributes2
 &assbly_item_dff_attributes2
 qc.plan_level "level",
 qc.comp_item_seq_num item_seq,
 qc.comp_operation_seq_num op_seq,
 qc.comp_number component,
 qc.comp_description component_description,
 qc.comp_long_description component_long_description,
 qc.comp_revision revision,
 qc.comp_revision_desc revision_description,
 qc.comp_item_uom uom,
 qc.comp_quantity quantity,
 qc.comp_extended_quantity extended_quantity,
 qc.comp_item_status item_status,
 &component_category_columns
 qc.comp_eng_item_flag engineering_item,
 qc.comp_alternate alternate,
 qc.comp_planning_factor planning_percent,
 qc.comp_yield_factor yield,
 qc.comp_supply_type supply_type,
 qc.comp_supply_subinventory supply_subinventory,
 qc.comp_locator supply_locator,
 qc.comp_item_supply_type org_item_supply_type,
 qc.comp_item_supply_subinventory org_item_supply_subinventory,
 qc.comp_item_supply_locator org_item_supply_locator,
 qc.comp_supply_attributes_differ supply_attributes_differ,
 qc.mfg_lead_time,
 qc.operation_offset,
 qc.operation_lead_time_percent,
 qc.cumulative_mfg_lead_time,
 qc.cumulative_total_lead_time,
 qc.comp_item_type item_type,
 qc.optional,
 qc.mutually_excl_options mutually_exclusive,
 qc.check_atp,
 qc.so_basis,
 qc.required_to_ship,
 qc.required_for_revenue,
 qc.include_on_ship_docs,
 qc.comp_minimum_quantity min_qty,
 qc.comp_maximum_quantity max_qty,
 qc.comp_effectivity_date effectivity_date,
 qc.comp_disable_time disable_date,
 qc.comp_change_notice change_notice,
 qc.reference_designators,
 &comp_dff_attributes2
 &comp_item_dff_attributes2
 qsc.substitute_component,
 qsc.substitute_description,
 qsc.substitute_long_description,
 qsc.substitute_quantity,
 qsc.substitute_uom,
 qa.assembly_has_loop,
 qc.component_has_loop,
 nvl2(qa.alt_bom_designator,2,1) alt_sort_order,
 qc.comp_sort_order
from
 q_assemblies qa,
 q_components qc,
 q_subst_comp qsc
where
 1=1 and
 qa.top_bill_sequence_id = qc.top_bill_sequence_id and
 qa.assembly_organization_id = qc.assembly_organization_id and
 qc.component_sequence_id = qsc.component_sequence_id (+) and
 qc.comp_org_id = qsc.organization_id (+)
order by
 qa.assembly,
 nvl2(qa.alt_bom_designator,1,2),
 qa.alt_bom_designator,
 qa.assembly_organization,
 qc.comp_sort_order