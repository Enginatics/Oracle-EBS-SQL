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
  bom_bomrboms_xmlp_pkg.cf_org_nameformula(bbom.organization_id) assembly_organization,
  mif.item_number assembly,
  bom_bomrboms_xmlp_pkg.cf_item_descformula(mif.item_id, bbom.organization_id) assembly_description,
  xxen_util.meaning(mif.bom_item_type,'BOM_ITEM_TYPE',700) bom_item_type,
  mlu.meaning engineering_bill,
  mif.primary_uom_code assembly_uom,
  bbom.alternate_bom_designator alt_bom_designator,
  bad.description alt_bom_designator_desc,
  rev.revision assembly_revision,
  fnd_date.date_to_displaydt(:lp_revision_date) assembly_revision_date,
  (select
    listagg(mck.concatenated_segments,', ') within group (order by mck.concatenated_segments)
   from
    mtl_item_categories mic,
    mtl_categories_b_kfv mck
   where
       mic.category_set_id = :p_category_set_id
   and mic.organization_id = bbom.organization_id
   and mic.inventory_item_id = bbom.assembly_item_id
   and mck.category_id = mic.category_id
  ) category,
  (select
    rtrim(dbms_lob.substr(xmlagg(
      xmlelement(name delem,bdde.element_name ||
                            nvl2(bom_bomrboms_xmlp_pkg.get_ele_desc(mif.bom_item_type, bdde.element_name, mif.item_catalog_group_id),': ' || bom_bomrboms_xmlp_pkg.get_ele_desc(mif.bom_item_type, bdde.element_name, mif.item_catalog_group_id),null)
                ,', ').extract('//text()') order by bdde.element_name).GetClobVal(),4000,1),', ')
   from
    bom_dependent_desc_elements bdde
   where
    bdde.bill_sequence_id=bet.top_bill_sequence_id
  ) descriptive_elements,
  xxen_util.meaning(bet.loop_flag,'SYS_YES_NO',700) assembly_has_loop,
  --
  to_char(bet.top_bill_sequence_id ) top_bill_sequence_id,
  mif.item_id assembly_item_id,
  bbom.organization_id assembly_organization_id,
  mif.item_catalog_group_id assembly_item_catalog_group_id
 from
  bom_explosion_temp bet,
  bom_bill_of_materials bbom,
  bom_lists blist,
  mtl_item_flexfields mif,
  mtl_item_revisions_b rev,
  mfg_lookups mlu,
  bom_alternate_designators bad
 where
      bet.group_id = :p_group_id
  and bet.plan_level = 0
  and bet.top_bill_sequence_id = bbom.bill_sequence_id
  and blist.sequence_id = :p_sequence_id1
  and blist.organization_id = bbom.organization_id
  and bbom.assembly_item_id = mif.item_id
  and mif.organization_id = blist.organization_id
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
 select /*+ push_pred(mic) */
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
  decode(bom.common_bill_sequence_id, bom.bill_sequence_id, bev.supply_subinventory, parent.wip_supply_subinventory) comp_supply_subinventory,
  milk.concatenated_segments comp_locator,
  round(bev.manufacturing_lead_time,:p_qty_precision) mfg_lead_time,
  bev.operation_lead_time_percent operation_lead_time_percent,
  round((1-(bev.operation_lead_time_percent/100))*parent.full_lead_time,:p_qty_precision) operation_offset,
  round(bev.cum_manufacturing_lead_time,:p_qty_precision) cumulative_mfg_lead_time,
  round(bev.cumulative_total_lead_time,:p_qty_precision) cumulative_total_lead_time,
  round(bev.minimum_quantity,:p_qty_precision) comp_minimum_quantity,
  round(bev.maximum_quantity,:p_qty_precision) comp_maximum_quantity,
  mck.concatenated_segments comp_category,
  msi.inventory_item_status_code comp_item_status,
  bom_bomrboms_xmlp_pkg.cf_comp_descformula(bev.component_item_id, bev.organization_id) comp_description,
  bom_bomrboms_xmlp_pkg.get_rev(bev.organization_id, bev.component_item_id) comp_revision,
  bom_bomrboms_xmlp_pkg.cf_revision_descformula(bev.component_item_id, bom_bomrboms_xmlp_pkg.get_rev(bev.organization_id, bev.component_item_id)) comp_revision_desc,
  bom_bomrboms_xmlp_pkg.supply_type_dispformula(decode ( bom.common_bill_sequence_id , bom.bill_sequence_id , bev.wip_supply_type , parent.wip_supply_type )) comp_supply_type,
  bev.so_basis so_basis,
  bom_bomrboms_xmlp_pkg.eng_bill_dispformula(bev.eng_bill) eng_bill,
  bom_bomrboms_xmlp_pkg.optional_dispformula(bev.optional) optional,
  bom_bomrboms_xmlp_pkg.mutually_dispformula(bev.mutually_exclusive_options) mutually_excl_options,
  bom_bomrboms_xmlp_pkg.check_atp_dispformula(bev.check_atp) check_atp,
  bom_bomrboms_xmlp_pkg.required_to_ship_dispformula(bev.required_to_ship) required_to_ship,
  bom_bomrboms_xmlp_pkg.required_for_revenue_dispformu(bev.required_for_revenue) required_for_revenue,
  bom_bomrboms_xmlp_pkg.include_on_ship_docs_dispformu(bev.include_on_ship_docs) include_on_ship_docs,
  (select
    rtrim(dbms_lob.substr(xmlagg(xmlelement(name refd,brd.component_reference_designator || nvl2(brd.ref_designator_comment,': ' || brd.ref_designator_comment,null),', ').extract('//text()') order by brd.component_reference_designator).GetClobVal(),4000,1),', ')
   from
    bom_ref_designators_view brd
   where brd.component_sequence_id = bev.component_sequence_id
  ) reference_designators,
  xxen_util.meaning(bev.loop_flag,'SYS_YES_NO',700) component_has_loop,
  --
  parent.organization_id assembly_organization_id,
  bev.parent_item_id assembly_item_id,
  bev.organization_id comp_org_id,
  bev.top_bill_sequence_id top_bill_sequence_id,
  bev.component_sequence_id,
  bev.component_item_id,
  decode(bom.common_bill_sequence_id, bom.bill_sequence_id, bev.supply_locator_id, parent.wip_supply_locator_id) supply_locator_id
 from
  bom_explosion_view bev,
  mtl_item_locations_kfv milk,
  bom_bill_of_materials bom,
  mtl_system_items parent,
  mtl_system_items msi,
  (select
   mic.*
   from
   mtl_default_category_sets mdcs,
   mtl_item_categories mic
   where
   mdcs.functional_area_id = 1 and
   mdcs.category_set_id = mic.category_set_id
  ) mic,
  mtl_categories_b_kfv mck
 where
      bev.group_id = :p_group_id
  and bev.plan_level > 0
  and bev.supply_locator_id = milk.inventory_location_id(+)
  and milk.organization_id(+) = bev.organization_id
  and bev.parent_item_id = parent.inventory_item_id
  and bev.component_item_id = msi.inventory_item_id
  and msi.organization_id = bev.organization_id
  and msi.inventory_item_id = mic.inventory_item_id (+)
  and msi.organization_id = mic.organization_id (+)
  and mic.category_id = mck.category_id (+)
  and bom.bill_sequence_id = bev.bill_sequence_id
  and ( ( (:p_verify_flag is null) or (:p_verify_flag <> 1) ) or ( (:p_verify_flag = 1) and (bev.loop_flag = 1) ) )
),
q_subst_comp as
(select
  mif.item_number substitute_component,
  bom_bomrboms_xmlp_pkg.cf_subcomp_descformula(mif.item_id, mif.organization_id) substitute_description,
  bsc.substitute_item_quantity substitute_quantity,
  mif.primary_uom_code substitute_uom,
  --
  bsc.component_sequence_id,
  mif.organization_id organization_id,
  mif.item_id item_id
 from
  bom_sub_components_view bsc,
  mtl_item_flexfields mif
 where
     mif.item_id = bsc.substitute_component_id
 and :p_print_option5_flag = 1
)
--
-- Main Query Starts Here
--
select
 qa.assembly_organization,
 qa.assembly,
 qa.assembly_description,
 qa.bom_item_type,
 qa.engineering_bill,
 qa.assembly_uom,
 qa.alt_bom_designator,
 qa.alt_bom_designator_desc,
 qa.assembly_revision,
 qa.assembly_revision_date,
 qa.category,
 qa.descriptive_elements,
 --
 qc.plan_level "level",
 qc.comp_item_seq_num item_seq,
 qc.comp_operation_seq_num op_seq,
 qc.comp_number component,
 qc.comp_description component_description,
 qc.comp_revision revision,
 qc.comp_revision_desc revision_description,
 qc.comp_item_uom uom,
 qc.comp_quantity quantity,
 qc.comp_extended_quantity extended_quantity,
 qc.comp_item_status item_status,
 qc.comp_category item_category,
 qc.comp_eng_item_flag engineering_item,
 qc.comp_alternate alternate,
 qc.comp_planning_factor planning_percent,
 qc.comp_yield_factor yield,
 qc.comp_supply_type supply_type,
 qc.comp_supply_subinventory supply_subinventory,
 qc.comp_locator supply_locator,
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
 qsc.substitute_component,
 qsc.substitute_description,
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