/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Calculate ICP PII Item Costs by Where Used
-- Description: Use this report to find where components from one source organization are being used in another manufacturing organization, as a single-level BOM report.  Based on sourcing rules and bills of materials.

/* +=============================================================================+
-- |  Copyright 2018 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_where_used_by_source.sql
-- |
-- |  Parameters:
-- |  
-- |  p_assignment_set    - Name of the assignment set to report (mandatory)
-- |                        You can enter a null or valid assignment set name.
-- |  p_cost_type         - cost type name for the costs you want to report
-- |  p_pii_cost_type     - The PII cost type name you want to report
-- |  p_pii_resource_code -- The sub-element or resource for profit in inventory,
-- |                         such as PII or ICP 
-- |  p_curr_conv_date    - The currency conversion date
-- |  p_curr_conv_type    - The currency conversion type
-- |  p_period_name       - The accounting period you are reporting for
-- |  p_src_org           - organization code where components are sourced from
-- |                        You can enter a null or Cost Type name.
-- |  p_to_org            - organization code where the goods or assemblies are made
-- |                        You can enter a null or Cost Type name.
-- |  p_period_set_name   - Hard coded to Accounting
-- | 
-- |  Description:
-- |  Use the below SQL script to report where components from one source organization
-- |  is being used in another manufacturing organization, as a single-level BOM report,
-- |  based on sourcing rules and bills of materials.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     05 Nov 2018 Douglas Volz   Initial Coding based on xxx_where_used_by_cost_type.sql
-- |  1.1     06 Nov 2018 Douglas Volz   Add in PII and item cost calculations
-- |  1.2     10 Jul 2019 Douglas Volz   Update to latest PII calculation logic
-- |  1.3     09 Sep 2019 Douglas Volz   Added a max(mc.segment1) for the category
-- |                                     column select statements due to having
-- |                                     multiple category values for the same org,
-- |                                     item and category set id (Inventory).
-- |                                     -- Add Assy MB Code and Comp MB Code columns
-- |  1.4     01 Jun 2020 Douglas Volz   Use multi-language tables for UOM_Code, Status 
-- |                                     Code, Categories and Orgs.  Removed hard-coding
-- |                                     for period set name and period  type.  Changed
-- |                                     the PII Resource_Code into a parameter.  Added
-- |                                     Source and To Ledgers and Operating Units.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-calculate-icp-pii-item-costs-by-where-used/
-- Library Link: https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs-by-where-used/
-- Run Report: https://demo.enginatics.com/

select    gp.period_name Period_Name,
    -- Revision for version 1.4
    nvl(inv_src_org.gl_short_name, inv_src_org.gl_name) Src_Ledger,
    nvl(inv_to_org.gl_short_name, inv_to_org.gl_name) To_Ledger,
    inv_src_org.operating_unit Src_Operating_Unit,
    inv_to_org.operating_unit To_Operating_Unit,
    -- End revision for version 1.4
    item_sourcing.to_org_code Assy_To_Org,
    item_sourcing.src_org_code Comp_Src_Org, 
    item_sourcing.assignment_set Assignment_Set,
    item_sourcing.sourcing_rule Sourcing_Rule,
    msiv.concatenated_segments Assembly,
    msiv.description Assembly_Description,
    -- Revision for version 1.4
    fcl_bom.meaning Assembly_Item_Type,
    misv_bom.inventory_item_status_code_tl Assembly_Status_Code,
    ml_bom.meaning Assembly_Make_Buy_Code,
    muomv_bom.uom_code UOM_Code,
    ml_bom2.meaning BOM_Type,
    -- End revision for version 1.4
    bom.implementation_date Date_Implemented,
    mir.revision_code Item_Revision,
&category_columns
    comp.item_num Item_Seq,
    comp.operation_seq_num Op_Seq,
    item_sourcing.comp_item_number Component,
    item_sourcing.comp_description Component_Description,
    item_sourcing.comp_uom_code Component_UOM,
    fcl_comp.meaning Component_Item_Type,
    item_sourcing.item_status_code Component_Status_Code,
    -- Revision for version 1.3
    item_sourcing.to_org_mb_code Component_Make_Buy_Code,
    comp.component_quantity Quantity_per_Assembly,
    max(comp.effectivity_date) Effective_From,
    comp.disable_date Effective_To,
    nvl(comp.planning_factor,0) Planning_Percent,
    comp.component_yield_factor Yield,
    -- Revision for version 1.4
    ml_comp2.meaning Include_in_Cost_Rollup,
    ml_comp2.meaning WIP_Supply_Type,
    -- End revision for version 1.4
    nvl((select    sum(mohd.transaction_quantity)
        from    mtl_onhand_quantities_detail mohd
        where    mohd.inventory_item_id  = msiv.inventory_item_id
        and    mohd.organization_id    = msiv.organization_id),0) Assembly_Onhand_Quantity,
    nvl((select    sum(mohd.transaction_quantity)
        from    mtl_onhand_quantities_detail mohd
        where    mohd.inventory_item_id  = item_sourcing.comp_item_id
        and    mohd.organization_id    = msiv.organization_id),0) Src_Component_Onhand_Quantity,
    gdr.from_currency Src_Curr_Code,
    nvl(src_org_costs.item_cost,0) Src_Component_Item_Cost,
    nvl((select    sum(mohd.transaction_quantity)
        from    mtl_onhand_quantities_detail mohd
        where    mohd.inventory_item_id  = item_sourcing.comp_item_id
        and    mohd.organization_id    = msiv.organization_id),0) 
        * nvl(src_org_costs.item_cost,0) Src_Component_Onhand_Value,
    -- Revision for version 1.1
    -- Add in item costs and PII costs, 
    -- Revision for version 1.3
    -- Use the Planning Make/Buy Code, not the MFG Org_Code
    -- round(decode(item_sourcing.src_org_code,
    round(decode(msiv.planning_make_buy_code,
    -- End revision for version 1.3
            -- ======================================================================
            -- Revision for version 1.1, 1.3
            -- 1 = Make, 2 = Buy
            -- If Make or buy item, take away Source Org PII for comparison purposes
            -- This assumes the transfer price is marked up at each hop, including any TL costs
            -- Note that PII is a negative value so we add the two together
            -- ======================================================================
            1, nvl(src_org_costs.item_cost,0) + nvl(src_org_costs.pii_cost,0),
            2, nvl(src_org_costs.item_cost,0) + nvl(src_org_costs.pii_cost,0),
            nvl(src_org_costs.item_cost,0)    + nvl(src_org_costs.pii_cost,0)
            -- End revision for version 1.1, 1.3
            )
      ,5)                                                                                   Source_Item_Cost,
    gdr.conversion_date Curr_Conv_Date,
    gdr.conversion_rate  Curr_Conv_Rate,
    gdr.to_currency To_Org_Curr_Code,
    round(gdr.conversion_rate * 
        -- Revision for version 1.3
        -- Use the Planning Make/Buy Code, not the MFG Org_Code
        --  decode(item_sourcing.src_org_code,
        decode(msiv.planning_make_buy_code,
        -- End revision for version 1.3
             -- ======================================================================
             -- Revision for version 1.1, 1.3
             -- 1 = Make, 2 = Buy
             -- If Make or buy item, take away Source Org PII for comparison purposes
             -- This assumes the transfer price is marked up at each hop, including any TL costs
             -- Note that PII is a negative value so we add the two together
             -- ======================================================================
             1, nvl(src_org_costs.item_cost,0) + nvl(src_org_costs.pii_cost,0),
             2, nvl(src_org_costs.item_cost,0) + nvl(src_org_costs.pii_cost,0),
             nvl(src_org_costs.item_cost,0)    + nvl(src_org_costs.pii_cost,0)
             -- End revision for version 1.1, 1.3
            )
       ,5)                                                                                  Converted_Source_Item_Cost,
    item_sourcing.to_org_code To_Org,
    -- Revision for version 1.3
    -- Use the Planning Make/Buy Code, not the MFG Org_Code
    -- round(decode(item_sourcing.to_org_code,
    round(decode(item_sourcing.to_org_mb_code,
    -- End revision for version 1.3
            -- ======================================================================
            -- Revision for version 1.1, 1.3
            -- 1 = Make, 2 = Buy
            -- If Make or buy item, take away To_Org This Level Costs for comparison purposes
            -- This assumes the transfer price is marked up at each hop, including any TL costs
            -- Note that PII is a negative value so we add the two together
            -- ======================================================================
            1, nvl(to_org_costs.net_cost,0),
            2, nvl(to_org_costs.net_cost,0),
            nvl(to_org_costs.net_cost,0)
            -- End revision for version 1.1, 1.3
            )
       ,5)                                                                                     To_Org_Item_Cost,
    -- Conv. Src_Item_Cost minus the To_Org_Item_Cost = Calculated_To_Org_PII
    --  Conv. Src_Item_Cost
    round(gdr.conversion_rate *
        -- Revision for version 1.3
        -- Use the Planning Make/Buy Code, not the MFG Org_Code
        --  decode(item_sourcing.src_org_code,
        decode(msiv.planning_make_buy_code,
        -- End revision for version 1.3
            -- ======================================================================
            -- Revision for version 1.1, 1.3
            -- 1 = Make, 2 = Buy
            -- If Make or buy item, take away Source Org PII for comparison purposes
            -- This assumes the transfer price is marked up at each hop, including any TL costs
            -- Note that PII is a negative value so we add the two together
            -- ======================================================================
            1, nvl(src_org_costs.item_cost,0) + nvl(src_org_costs.pii_cost,0),
            2, nvl(src_org_costs.item_cost,0) + nvl(src_org_costs.pii_cost,0),
            nvl(src_org_costs.item_cost,0)    + nvl(src_org_costs.pii_cost,0)
            -- End revision for version 1.1, 1.3
              ) -
    -- minus the To_Org_Item_Cost
        -- Revision for version 1.3
        -- Use the Planning Make/Buy Code, not the MFG Org_Code
        -- round(decode(item_sourcing.to_org_code,
        round(decode(item_sourcing.to_org_mb_code,
        -- End revision for version 1.3
                -- ======================================================================
                -- Revision for version 1.1, 1.3
                -- 1 = Make, 2 = Buy
                -- If Make or buy item, take away To_Org This Level Costs for comparison purposes
                -- This assumes the transfer price is marked up at each hop, including any TL costs
                -- Note that PII is a negative value so we add the two together
                -- ======================================================================
                1, nvl(to_org_costs.net_cost,0),
                2, nvl(to_org_costs.net_cost,0),
                nvl(to_org_costs.net_cost,0)
                -- End revision for version 1.1, 1.3
                )
             )
      ,5)                                                                                 Calculated_To_Org_PII,
    -- Calculated_To_Org_PII / To_Org_Item_Cost = PII_Percent 
    round(
    -- Calculated_To_Org_PII
        (gdr.conversion_rate * 
         -- Revision for version 1.3
         -- Use the Planning Make/Buy Code, not the MFG Org_Code
         --  (decode(item_sourcing.src_org_code,
         (decode(msiv.planning_make_buy_code,
         -- End revision for version 1.3
             -- ======================================================================
             -- Revision for version 1.1, 1.3
             -- 1 = Make, 2 = Buy
             -- If Make or buy item, take away Source Org PII for comparison purposes
             -- This assumes the transfer price is marked up at each hop, including any TL costs
             -- Note that PII is a negative value so we add the two together
             -- ======================================================================
             1, nvl(src_org_costs.item_cost,0) + nvl(src_org_costs.pii_cost,0),
             2, nvl(src_org_costs.item_cost,0) + nvl(src_org_costs.pii_cost,0),
             nvl(src_org_costs.item_cost,0)    + nvl(src_org_costs.pii_cost,0)
             -- End revision for version 1.1, 1.3
                ) -
         -- Revision for version 1.3
         -- Use the Planning Make/Buy Code, not the MFG Org_Code
         -- decode(item_sourcing.to_org_code,
         decode(item_sourcing.to_org_mb_code,
         -- End revision for version 1.3
            -- ======================================================================
            -- Revision for version 1.1, 1.3
            -- 1 = Make, 2 = Buy
            -- If Make or buy item, take away To_Org This Level Costs for comparison purposes
            -- This assumes the transfer price is marked up at each hop, including any TL costs
            -- Note that PII is a negative value so we add the two together
            -- ======================================================================
            1, nvl(to_org_costs.net_cost,0),
            2, nvl(to_org_costs.net_cost,0),
            nvl(to_org_costs.net_cost,0)
            -- End revision for version 1.1, 1.3
              )
         )
        )
        -- Revision for version 1.3
        -- Use the Planning Make/Buy Code, not the MFG Org_Code
        -- / decode(decode(item_sourcing.to_org_code,
        / decode(decode(item_sourcing.to_org_mb_code,
        -- End revision for version 1.3
                -- ======================================================================
                -- Revision for version 1.1, 1.3
                -- 1 = Make, 2 = Buy
                -- If Make or buy item, take away To_Org This Level Costs for comparison purposes
                -- This assumes the transfer price is marked up at each hop, including any TL costs
                -- Note that PII is a negative value so we add the two together
                -- ======================================================================
                1, nvl(to_org_costs.net_cost,0),
                2, nvl(to_org_costs.net_cost,0),
                nvl(to_org_costs.net_cost,0)
                -- End revision for version 1.1, 1.3
                   ), 0, 1,
            -- Revision for version 1.3
            -- Use the Planning Make/Buy Code, not the MFG Org_Code
            -- decode(item_sourcing.to_org_code,
            decode(item_sourcing.to_org_mb_code,
            -- End revision for version 1.3
                -- ======================================================================
                -- Revision for version 1.1, 1.3
                -- 1 = Make, 2 = Buy
                -- If Make or buy item, take away To_Org This Level Costs for comparison purposes
                -- This assumes the transfer price is marked up at each hop, including any TL costs
                -- Note that PII is a negative value so we add the two together
                -- ======================================================================
                1, nvl(to_org_costs.net_cost,0),
                2, nvl(to_org_costs.net_cost,0),
                nvl(to_org_costs.net_cost,0)
                -- End revision for version 1.1, 1.3
                   )
            )
       ,5) PII_Percent,
    to_org_costs.pii_cost PII_Item_Cost,
    -- Calculated_To_Org_PII minus PII_Item_Cost = PII_Difference
    -- Conv. Src_Item_Cost minus the To_Org_Item_Cost = Calculated_To_Org_PII
    -- Conv. Src_Item_Cost
    round(gdr.conversion_rate * 
        -- Revision for version 1.3
        -- decode(item_sourcing.src_org_code,
        decode(item_sourcing.to_org_mb_code,
        -- End revision for version 1.3
            -- ======================================================================
            -- Revision for version 1.1, 1.3
            -- 1 = Make, 2 = Buy
            -- If Make or buy item, take away Source Org PII for comparison purposes
            -- This assumes the transfer price is marked up at each hop, including any TL costs
            -- Note that PII is a negative value so we add the two together
            -- ======================================================================
            1, nvl(src_org_costs.item_cost,0) + nvl(src_org_costs.pii_cost,0),
            2, nvl(src_org_costs.item_cost,0) + nvl(src_org_costs.pii_cost,0),
            nvl(src_org_costs.item_cost,0)    + nvl(src_org_costs.pii_cost,0)
            -- End revision for version 1.1, 1.3
              ) -
        -- To_Org_Item_Cost
        -- Revision for version 1.3
        -- decode(item_sourcing.to_org_code,
        decode(item_sourcing.to_org_mb_code,
        -- End revision for version 1.3
            -- ======================================================================
            -- Revision for version 1.1, 1.3
            -- 1 = Make, 2 = Buy
            -- If Make or buy item, take away To_Org This Level Costs for comparison purposes
            -- This assumes the transfer price is marked up at each hop, including any TL costs
            -- Note that PII is a negative value so we add the two together
            -- ======================================================================
            1, nvl(to_org_costs.net_cost,0),
            2, nvl(to_org_costs.net_cost,0),
            nvl(to_org_costs.net_cost,0)
            -- End revision for version 1.1, 1.3
              )
        - to_org_costs.pii_cost,5)  PII_Cost_Difference
from    bom_components_b comp,
    bom_structures_b bom,
    mtl_system_items_vl msiv,
    -- Revision for version 1.4
    mtl_units_of_measure_vl muomv_bom,
    mtl_item_status_vl misv_bom,
    mfg_lookups ml_bom,
    mfg_lookups ml_bom2,
    mfg_lookups ml_comp,
    mfg_lookups ml_comp2,
    mfg_lookups ml_comp3,
    fnd_common_lookups fcl_bom,
    fnd_common_lookups fcl_comp,
    -- End revision for version 1.4
    gl_periods gp,
    -- Get the Item_Revisions
    (select max(mir.revision)     revision_code,
        mir.inventory_item_id inventory_item_id,
        mir.organization_id   organization_id
     from    mtl_item_revisions_b mir
     where    mir.effectivity_date <= sysdate
     group by
        mir.inventory_item_id,
        mir.organization_id ) mir,
    -- Source of Components
    (select    mp_to_org.organization_code to_org_code,
        mp_src_org.organization_code src_org_code,
        mp_to_org.organization_id to_org_id,
        mp_src_org.organization_id src_org_id,
        mas.assignment_set_name assignment_set,
        msr.sourcing_rule_name sourcing_rule,
        msiv.segment1 comp_item_number,
        msiv.inventory_item_id comp_item_id,
        msiv.primary_uom_code comp_uom_code,
        msiv.description comp_description,
        msiv.inventory_item_status_code item_status_code,
        msiv.item_type comp_item_type,
        -- Revision for version 1.3
        msiv.planning_make_buy_code to_org_mb_code
     from    mrp_sr_source_org msso,
        mrp_sr_receipt_org msro,
        mrp_sourcing_rules msr,
        mrp_sr_assignments msa,
        mrp_assignment_sets mas,
        mtl_system_items_vl msiv,
        mtl_parameters mp_to_org,
        mtl_parameters mp_src_org
     -- ====================================
     -- Sourcing_Rule Joins
     -- ====================================
     where    msso.sr_receipt_id            = msro.sr_receipt_id
     and    msr.sourcing_rule_id          = msro.sourcing_rule_id
     and    msa.sourcing_rule_id          = msr.sourcing_rule_id
     and    msa.assignment_set_id         = mas.assignment_set_id
     -- Want the source organization item information
     and    msiv.organization_id           = msso.source_organization_id
     and    msiv.inventory_item_id         = msa.inventory_item_id
     -- Only choose organization sourcing rules
     and    msso.source_organization_id is not null
     -- Client only has one Assignment_Set
     and    1=1                -- p_assignment_set
     and    2=2                -- p_src_org, p_to_org 
     -- Don't report obsolete or inactive items
     and    msiv.inventory_item_status_code <> 'Inactive'
     -- ====================================
     -- Material Parameter joins
     -- ====================================
     and    mp_to_org.organization_id     = msa.organization_id
     and    mp_src_org.organization_id    = msso.source_organization_id
     union all
     select    mp_to_org.organization_code to_org_code,
        mp_src_org.organization_code src_org_code,
        mp_to_org.organization_id to_org_id,
        msiv.source_organization_id src_org_id,
        '' assignment_set,
        '' sourcing_rule,
        msiv.segment1 comp_item_number,
        msiv.inventory_item_id comp_item_id,
        msiv.primary_uom_code comp_uom_code,
        msiv.description comp_description,
        msiv.inventory_item_status_code comp_item_status,
        msiv.item_type comp_item_type,
        -- Revision for version 1.3
        msiv.planning_make_buy_code to_org_mb_code
     from mtl_system_items_vl msiv,
        mtl_parameters mp_to_org,
        mtl_parameters mp_src_org
     -- ====================================
     -- Sourcing_Rule Joins
     -- ====================================
     where    msiv.organization_id           = mp_to_org.organization_id
     and    msiv.source_organization_id is not null
     -- Don't report obsolete or inactive items
     and    msiv.inventory_item_status_code <> 'Inactive'
     -- ====================================
     -- Material Parameter joins for to_org
     -- ====================================
     and    msiv.organization_id           = mp_to_org.organization_id
     and    msiv.source_organization_id    = mp_src_org.organization_id
     and    msiv.organization_id          <> mp_to_org.master_organization_id
     and    msiv.source_organization_id   <> mp_src_org.master_organization_id
     and    2=2                -- p_src_org, p_to_org 
     and    not exists (
                select    'x'
                from    mrp_sr_source_org msso,
                    mrp_sr_receipt_org msro,
                    mrp_sourcing_rules msr,
                    mrp_sr_assignments msa,
                    mrp_assignment_sets mas
                where    msso.sr_receipt_id            = msro.sr_receipt_id
                and        msr.sourcing_rule_id          = msro.sourcing_rule_id
                and        msa.sourcing_rule_id          = msr.sourcing_rule_id
                -- Client only has one Assignment_Set
                and        1=1                -- p_assignment_set
                and        msa.assignment_set_id         = mas.assignment_set_id
                and        msiv.organization_id           = msa.organization_id
                and        msiv.inventory_item_id         = msa.inventory_item_id
                -- ====================================
                -- Material Parameter joins for to_org
                -- ====================================
                and        msa.organization_id           = mp_to_org.organization_id
                and        msso.source_organization_id   = mp_src_org.organization_id
               )
    ) item_sourcing,
    -- =================================================
    -- Revision for version 1.1, add PII amounts
    -- Get To_Org Cost information
    -- =================================================
     (select    cic.organization_id,
            cic.inventory_item_id,
            cic.cost_type_id,
            cic.item_cost,
            cic.material_cost,
            cic.tl_material_overhead,
            cic.tl_resource,
            cic.tl_outside_processing,
            cic.tl_overhead,
            cic.item_cost - cic.tl_material_overhead - cic.tl_resource - 
                cic.tl_outside_processing - cic.tl_overhead net_cost,
            nvl((select sum(cicd.item_cost)
                 from   cst_item_cost_details cicd,
                    cst_cost_types cct,
                    bom_resources br
                 where  cicd.cost_type_id      = cct.cost_type_id
                 and    3=3            -- p_pii_cost_type, p_pii_resource_code
                 and    cicd.inventory_item_id = cic.inventory_item_id
                 and    cicd.organization_id   = cic.organization_id
                 and    cicd.resource_id       = br.resource_id
                    ),0) pii_cost
     from        cst_item_costs cic,
            cst_cost_types cct
     -- ====================================
     -- Item_Cost Joins for the To_Org
     -- ====================================
     where        cic.cost_type_id              = cct.cost_type_id
     and        4=4                -- p_cost_type
     union all
     select        cic.organization_id,
            cic.inventory_item_id,
            cic.cost_type_id,
            cic.item_cost,
            cic.material_cost,
            cic.tl_material_overhead,
            cic.tl_resource,
            cic.tl_outside_processing,
            cic.tl_overhead,
            cic.item_cost - cic.tl_material_overhead - cic.tl_resource - 
                cic.tl_outside_processing - cic.tl_overhead net_cost,
            nvl((select sum(cicd.item_cost)
                 from   cst_item_cost_details cicd,
                    cst_cost_types cct,
                    bom_resources br
                 where  cicd.cost_type_id      = cct.cost_type_id
                 and    3=3            -- p_pii_cost_type, p_pii_resource_code
                 and    cicd.inventory_item_id = cic.inventory_item_id
                 and    cicd.organization_id   = cic.organization_id
                 and    cicd.resource_id       = br.resource_id
                    ),0) pii_cost
     from        cst_item_costs cic,
            cst_cost_types cct,
            mtl_parameters mp
     -- ====================================
     -- Item_Cost Joins for the To_Org
     -- ====================================
     where        cic.organization_id           = mp.organization_id
     and        cic.cost_type_id              = mp.primary_cost_method  -- this gets the Frozen Costs
     and        cct.cost_type_id             <> mp.primary_cost_method  -- this avoids getting the Frozen costs twice
     and        4=4                -- p_cost_type
     -- ====================================
     -- Find all the Frozen costs not in the
     -- Pending or unimplemented cost type
     -- ====================================
     and        not exists (
                select    'x'
                from    cst_item_costs cic2
                where    cic2.organization_id   = cic.organization_id
                and    cic2.inventory_item_id = cic.inventory_item_id
                and    cic2.cost_type_id      = cct.cost_type_id)
    ) to_org_costs,
    -- =================================================
    -- Get Source Org Cost information
    -- =================================================
     (select    cic.organization_id,
            cic.inventory_item_id,
            cic.cost_type_id,
            cic.item_cost,
            cic.material_cost,
            cic.tl_material_overhead,
            cic.tl_resource,
            cic.tl_outside_processing,
            cic.tl_overhead,
            cic.item_cost - cic.tl_material_overhead - cic.tl_resource - 
                cic.tl_outside_processing - cic.tl_overhead net_cost,
            nvl((select sum(cicd.item_cost)
                 from   cst_item_cost_details cicd,
                    cst_cost_types cct,
                    bom_resources br
                 where  cicd.cost_type_id      = cct.cost_type_id
                 and    3=3            -- p_pii_cost_type, p_pii_resource_code
                 and    cicd.inventory_item_id = cic.inventory_item_id
                 and    cicd.organization_id   = cic.organization_id
                 and    cicd.resource_id       = br.resource_id
                    ),0) pii_cost
     from        cst_item_costs cic,
            cst_cost_types cct
     -- ====================================
     -- Item_Cost Joins for the Source Org
     -- ====================================
     where        cic.cost_type_id              = cct.cost_type_id
     and        4=4                -- p_cost_type
     union all
     select        cic.organization_id,
            cic.inventory_item_id,
            cic.cost_type_id,
            cic.item_cost,
            cic.material_cost,
            cic.tl_material_overhead,
            cic.tl_resource,
            cic.tl_outside_processing,
            cic.tl_overhead,
            cic.item_cost - cic.tl_material_overhead - cic.tl_resource - 
                cic.tl_outside_processing - cic.tl_overhead net_cost,
            nvl((select sum(cicd.item_cost)
                 from   cst_item_cost_details cicd,
                    cst_cost_types cct,
                    bom_resources br
                 where  cicd.cost_type_id      = cct.cost_type_id
                 and    3=3            -- p_pii_cost_type, p_pii_resource_code
                 and    cicd.inventory_item_id = cic.inventory_item_id
                 and    cicd.organization_id   = cic.organization_id
                 and    cicd.resource_id       = br.resource_id
                    ),0) pii_cost
     from        cst_item_costs cic,
            cst_cost_types cct,
            mtl_parameters mp
     -- ====================================
     -- Item_Cost Joins for the Source Org
     -- ====================================
     where        cic.organization_id           = mp.organization_id
     and        cic.cost_type_id              = mp.primary_cost_method  -- this gets the Frozen Costs
     and        cct.cost_type_id             <> mp.primary_cost_method  -- this avoids getting the Frozen costs twice
     and        4=4                -- p_cost_type
     -- ====================================
     -- Find all the Frozen costs not in the
     -- Pending or unimplemented cost type
     -- ====================================
     and        not exists (
                select    'x'
                from    cst_item_costs cic2
                where    cic2.organization_id   = cic.organization_id
                and    cic2.inventory_item_id = cic.inventory_item_id
                and    cic2.cost_type_id      = cct.cost_type_id)
    ) src_org_costs,    
    -- =================================================
    -- Get To_Org Currency information
    -- =================================================
     (select    mp.organization_id,
            gl.ledger_id,
            gl.name gl_name,
            gl.currency_code,
            haou2.organization_id operating_unit_id,
            haou2.name operating_unit,
            -- Revision for version 1.4
            gl.short_name gl_short_name
         from    mtl_parameters mp,
            hr_organization_information hoi,
            hr_all_organization_units_vl haou,
            hr_all_organization_units_vl haou2,
            gl_ledgers gl
         -- =================================================
         -- Get inventory ledger and operating unit information
         -- =================================================
         where    hoi.org_information_context   = 'Accounting Information'
         and    hoi.organization_id           = mp.organization_id
         and    hoi.organization_id           = haou.organization_id            -- this gets the organization name
         and    haou2.organization_id         = to_number(hoi.org_information3) -- this gets the operating unit id
         and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
         -- End revision for version 1.1
         and    mp.organization_id <> mp.master_organization_id
         -- Revision for version 1.4
         -- Avoid selecting disabled inventory organizations
         and    sysdate < nvl(haou.date_to, sysdate + 1)
        ) inv_to_org,
    -- =================================================
    -- Get Src_Org Currency information
    -- =================================================
     (select    mp.organization_id,
            gl.ledger_id,
            gl.name gl_name,
            gl.currency_code,
            haou2.organization_id operating_unit_id,
            haou2.name operating_unit,
            -- Revision for version 1.4
            gl.short_name gl_short_name,
            gl.period_set_name,
            gl.accounted_period_type
            -- End revision for version 1.4
         from    mtl_parameters mp,
            hr_organization_information hoi,
            hr_all_organization_units_vl haou,
            hr_all_organization_units_vl haou2,
            gl_ledgers gl
         -- =================================================
         -- Get inventory ledger and operating unit information
         -- =================================================
         where    hoi.org_information_context   = 'Accounting Information'
         and    hoi.organization_id           = mp.organization_id
         and    hoi.organization_id           = haou.organization_id            -- this gets the organization name
         and    haou2.organization_id         = to_number(hoi.org_information3) -- this gets the operating unit id
         and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
         and    mp.organization_id           <> mp.master_organization_id
         -- Revision for version 1.4
         -- Avoid selecting disabled inventory organizations
         and    sysdate < nvl(haou.date_to, sysdate + 1)
        ) inv_src_org,
    -- ===========================================================================
    -- Tables to get currency exchange rate information for the inventory orgs
    -- Select Currency Rates based on the currency conversion date and type
    -- ===========================================================================
    (select    gdr.from_currency,
        gdr.to_currency,
        gdct.user_conversion_type,
        gdr.conversion_date,
        gdr.conversion_rate
     from    gl_daily_rates gdr,
        gl_daily_conversion_types gdct
     -- =================================================
     -- Check for the currencies needed for the To_Orgs
     -- =================================================
     where    exists (
            select 'x'
            from    mtl_parameters mp,
                hr_organization_information hoi,
                gl_ledgers gl
            -- =================================================
            -- Get inventory ledger and operating unit information
            -- =================================================
            where    hoi.org_information_context   = 'Accounting Information'
            and    hoi.organization_id           = mp.organization_id
            and    gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
            and    gdr.to_currency               = gl.currency_code
            and    mp.organization_id           <> mp.master_organization_id
               )
     -- ===============================================