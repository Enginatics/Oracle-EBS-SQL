/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Calculate ICP PII Item Costs by Where Used
-- Description: Report to identify the intercompany "To Org" profit in inventory (also known as PII or ICP) for each inventory organization and item.  Gets the PII item costs by joining the sourcing rule information from the first "hop" from the sourcing rule information to the second "hop".  In addition, if an item has a source org in the item master, but the sourcing rule does not exist, this item relationship will still be reported.  This report also assumes that the first hop may have profit in inventory from another source organization and will not include any profit in inventory from the source org for the "To Org" profit in inventory calculations.  Likewise for the "To Org", any this level material overheads, resources, outside processing or overhead costs are ignored for the profit in inventory calculations.  In addition, inactive items and disabled organizations are ignored.  And while calculating the profit in inventory item costs, this report also shows where these components are being used on the To Org bills of material.

Parameters:
Assignment Set:  the set of sourcing rules to use with calculating the PII item costs (mandatory).
From (Source) Organization:  the source organization where the goods come from (optional).
To Organization:  the organization where the goods are being shipped to (optional).
Cost Type:  the cost type to use for the item costs, such as Frozen or Pending (mandatory).
PII Cost Type:  the profit in inventory cost type you wish to report (mandatory).
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (mandatory).
Currency Conversion Date:  the exchange rate conversion date that was used to set the standard costs (mandatory).
Currency Conversion Type:  the exchange rate conversion type that was used to set the standard costs (mandatory).
Period Name:   the accounting period you wish to report for; this value does not change any PII or item costs, it is merely a reference value for reporting purposes (mandatory).
Include Transfers to Same OU:  allows you to include or exclude transfers within the same Operating Unit (OU).  Defaulted to not include these internal transfers.
Include Expense Items:  enter Yes or No to indicate if you want to include expense items on the bills of material (mandatory).  Defaulted to No.
Include Uncosted Items:  enter Yes or No to indicate if you want to include uncosted items on the bills of material (mandatory).  Defaulted to No. 
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Component Number:  enter the specific component(s) you wish to report (optional).
Assembly Number:  enter the specific assembly or assemblies you wish to report (optional).
Include Unimplemented ECOs:  enter Yes or No to indicate if you want to include engineering changes which have not been implemented (mandatory).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

Hidden Parameters:
Numeric Sign for PII:  to set the sign of the profit in inventory amounts.  This parameter determines if PII is normally entered as a positive or negative amount (mandatory).

-- |  Copyright 2018 - 2024 Douglas Volz Consulting, Inc., all rights reserved.
-- |  Permission to use this code is granted provided the original author is  acknowledged. No warranties, express or otherwise is included in this permission. 
-- |  
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.6     29 Jan 2024 Doug Volz      Remove tabs, add org access controls, fix for G/L Daily Rates,
-- |                                     Make three parameters non-hidden:  Include Transfers to Same OU, Include Expense Items and Include Uncosted Items.

-- Excel Examle Output: https://www.enginatics.com/example/cac-calculate-icp-pii-item-costs-by-where-used/
-- Library Link: https://www.enginatics.com/reports/cac-calculate-icp-pii-item-costs-by-where-used/
-- Run Report: https://demo.enginatics.com/

select  rpt.period_name Period_Name,
        rpt.source_ledger Source_Ledger,
        rpt.to_ledger To_Ledger,
        rpt.source_operating_unit Source_Operating_Unit,
        rpt.to_operating_unit To_Operating_Unit,
        rpt.src_org Src_Org, 
        rpt.to_org To_Org,
        rpt.assignment_set Assignment_Set,
        rpt.sourcing_rule Sourcing_Rule,
        rpt.assembly Assembly,
        rpt.assembly_description Assembly_Description,
        rpt.assembly_item_type Assembly_Item_Type,
        rpt.assembly_status_code Assembly_Status_Code,
        rpt.assembly_make_buy_code Assembly_Make_Buy_Code,
        rpt.uom_code UOM_Code,
        rpt.bom_type BOM_Type,
        rpt.date_implemented Date_Implemented,
        rpt.item_revision Item_Revision,
&category_columns
        rpt.item_seq Item_Seq,
        rpt.op_seq Op_Seq,
        rpt.component Component,
        rpt.component_description Component_Description,
        rpt.source_item_type Source_Item_Type,
        rpt.source_status_code Source_Status_Code,
        rpt.source_make_buy_code Source_Make_Buy_Code,
        rpt.source_uom Source_UOM,
        rpt.to_org_item_type To_Org_Item_Type,
        rpt.to_org_status_code To_Org_Status_Code,
        rpt.to_org_make_buy_code To_Org_Make_Buy_Code,
        rpt.to_org_uom To_Org_UOM,
        rpt.quantity_per_assembly Quantity_per_Assembly,
        rpt.effective_from Effective_From,
        rpt.effective_to Effective_To,
        rpt.planning_percent Planning_Percent,
        rpt.yield Component_Yield,
        rpt.include_in_cost_rollup Include_in_Cost_Rollup,
        rpt.wip_supply_type WIP_Supply_Type,
        rpt.source_component_onhand_qty Source_Component_Onhand_Qty,
        rpt.src_currency_code Src_Currency_Code,
        rpt.src_component_item_cost Src_Component_Item_Cost,
        rpt.src_component_onhand_value Src_Component_Onhand_Value,
        rpt.source_item_cost Source_Item_Cost,
        :p_conversion_date Currency_Conversion_Date,
        nvl(gdr.conversion_rate,1) Currency_Conversion_Rate,
        gdr.to_currency To_Org_Currency_Code,
        round(nvl(gdr.conversion_rate,1) * rpt.source_item_cost,5) Converted_Source_Item_Cost,
        rpt.to_org_net_item_cost To_Org_Net_Item_Cost,
        -- To Org Item Cost minus Converted Source Item Cost = Calculated To Org PII
        rpt.to_org_net_item_cost - round(nvl(gdr.conversion_rate,1) * rpt.source_item_cost,5) Calculated_To_Org_PII,
        -- Calculated To Org PII / Converted Source Item Cost = Source PII Percent 
        round(rpt.to_org_net_item_cost - round(nvl(gdr.conversion_rate,1) * rpt.source_item_cost,5)
                / (decode(round(nvl(gdr.conversion_rate,1) * rpt.source_item_cost,5),
                0, 1, round(nvl(gdr.conversion_rate,1) * rpt.source_item_cost,5)))
                * 100 -- turn into a percent
           ,1) Source_PII_Percent,
        -- Revision for version 1.5, divide by To Org Total Item Cost
        -- Calculated To Org PII / To Org Total Item Cost = To Org PII Percent
        round(rpt.to_org_net_item_cost - round(nvl(gdr.conversion_rate,1) * rpt.source_item_cost,5)
                / decode(rpt.to_org_item_cost, 0, 1, rpt.to_org_item_cost)
                * 100 -- turn into a percent
           ,1) To_Org_PII_Percent,
        rpt.cost_type_pii_item_cost Cost_Type_PII_Item_Cost,
        -- Calculated To Org PII minus Cost Type To Org PII Item Cost = PII Difference
        rpt.to_org_net_item_cost - round(nvl(gdr.conversion_rate,1) * rpt.source_item_cost,5) - rpt.cost_type_pii_item_cost PII_Cost_Difference,
        rpt.to_org_assembly_onhand_qty To_Org_Assembly_Onhand_Qty,
        rpt.to_org_component_onhand_qty To_Org_Component_Onhand_Qty,
        rpt.to_org_item_cost To_Org_Total_Item_Cost,
        rpt.to_org_component_onhand_value To_Org_Component_Onhand_Value
        -- End revision for version 1.5
from    (select :p_period_name Period_Name,
                -- Revision for version 1.6
                -- gp.period_name Period_Name,
                -- Revision for version 1.4
                nvl(inv_src_org.gl_short_name, inv_src_org.gl_name) Source_Ledger,
                nvl(inv_to_org.gl_short_name, inv_to_org.gl_name) To_Ledger,
                inv_src_org.operating_unit Source_Operating_Unit,
                inv_to_org.operating_unit To_Operating_Unit,
                -- End revision for version 1.4
                item_sourcing.src_org_code Src_Org, 
                item_sourcing.to_org_code To_Org,
                item_sourcing.assignment_set Assignment_Set,
                item_sourcing.sourcing_rule Sourcing_Rule,
                to_org_wu.assembly_item Assembly,
                to_org_wu.assembly_description Assembly_Description,
                -- Revision for version 1.4
                fcl_bom.meaning Assembly_Item_Type,
                misv_bom.inventory_item_status_code_tl Assembly_Status_Code,
                ml_bom.meaning Assembly_Make_Buy_Code,
                muomv_bom.uom_code UOM_Code,
                ml_bom2.meaning BOM_Type,
                -- End revision for version 1.4
                to_org_wu.bom_date_implemented Date_Implemented,
                to_org_wu.bom_item_revision Item_Revision,
                -- Revision for version 1.2
                to_org_wu.component_item_id,
                to_org_wu.organization_id,
                to_org_wu.comp_item_seq Item_Seq,
                to_org_wu.comp_op_seq Op_Seq,
                to_org_wu.component_item Component,
                to_org_wu.component_description Component_Description,
                -- Revision for version 1.5
                fcl_src.meaning Source_Item_Type,
                misv_src.inventory_item_status_code_tl Source_Status_Code,
                ml_src.meaning Source_Make_Buy_Code,
                muomv_src.uom_code Source_UOM,
                -- End revision for version 1.5
                fcl_comp.meaning To_Org_Item_Type,
                misv_comp.inventory_item_status_code_tl To_Org_Status_Code,
                -- Revision for version 1.3
                ml_comp.meaning To_Org_Make_Buy_Code,
                muomv_comp.uom_code To_Org_UOM,
                to_org_wu.component_quantity Quantity_per_Assembly,
                to_org_wu.comp_effective_from Effective_From,
                to_org_wu.comp_effective_to Effective_To,
                to_org_wu.comp_planning_percent Planning_Percent,
                to_org_wu.component_yield Yield,
                -- Revision for version 1.4
                ml_comp2.meaning Include_in_Cost_Rollup,
                ml_comp3.meaning WIP_Supply_Type,
                -- End revision for version 1.4
                nvl((select  sum(mohd.transaction_quantity)
                     from    mtl_onhand_quantities_detail mohd
                     where   mohd.inventory_item_id  = item_sourcing.src_item_id
                     and     mohd.organization_id    = item_sourcing.src_org_id),0) Source_Component_Onhand_Qty,
                nvl(src_org_costs.item_cost,0) Src_Component_Item_Cost,
                nvl((select  sum(mohd.transaction_quantity)
                     from    mtl_onhand_quantities_detail mohd
                     where   mohd.inventory_item_id  = item_sourcing.src_item_id
                     and     mohd.organization_id    = item_sourcing.src_org_id),0) 
                     * nvl(src_org_costs.item_cost,0) Src_Component_Onhand_Value,
                -- Revision for version 1.6
                inv_to_org.currency_code To_Org_Currency_Code,
                inv_src_org.currency_code Src_Currency_Code,
                -- End revision for version 1.6
                -- Revision for version 1.1
                -- Add in item costs and PII costs, 
                -- Revision for version 1.3
                -- Use the Planning Make/Buy Code, not the MFG Org Code
                -- round(decode(item_sourcing.src_org_code,
                -- ======================================================================
                -- Revision for version 1.1, 1.3, 1.5
                -- For comparison purposes take away Source Org PII. Assumes the transfer
                -- price is marked up at each hop, including any This Level costs.
                -- Revision for version 1.5, PII may be a negative or positive value, use a parameter to resolve
                -- ======================================================================
                round(nvl(src_org_costs.item_cost,0) - sign(:p_sign_pii) * nvl(src_org_costs.pii_cost,0),5) Source_Item_Cost,
                round(nvl(to_org_costs.net_cost,0),5) To_Org_Net_Item_Cost,
                to_org_costs.pii_cost Cost_Type_PII_Item_Cost,
                -- Revision for version 1.5
                nvl((select  sum(mohd.transaction_quantity)
                     from    mtl_onhand_quantities_detail mohd
                     where   mohd.inventory_item_id  = to_org_wu.assembly_item_id
                     and     mohd.organization_id    = to_org_wu.organization_id),0) To_Org_Assembly_Onhand_Qty,
                nvl((select  sum(mohd.transaction_quantity)
                     from    mtl_onhand_quantities_detail mohd
                     where   mohd.inventory_item_id  = to_org_wu.component_item_id
                     and     mohd.organization_id    = to_org_wu.organization_id),0) To_Org_Component_Onhand_Qty,
                nvl(to_org_costs.item_cost,0) To_Org_Item_Cost,
                nvl((select  sum(mohd.transaction_quantity)
                     from    mtl_onhand_quantities_detail mohd
                     where   mohd.inventory_item_id  = to_org_wu.component_item_id
                     and     mohd.organization_id    = to_org_wu.organization_id),0) 
                        * nvl(src_org_costs.item_cost,0) To_Org_Component_Onhand_Value
                -- End revision for version 1.5
         from   -- Revision for version 1.4
                mtl_units_of_measure_vl muomv_bom,
                mtl_item_status_vl misv_bom,
                mtl_units_of_measure_vl muomv_comp,
                mtl_item_status_vl misv_comp,
                mtl_units_of_measure_vl muomv_src,
                mtl_item_status_vl misv_src,
                mfg_lookups ml_bom, -- Assembly Make Buy Code
                mfg_lookups ml_bom2, -- BOM Type
                mfg_lookups ml_comp, -- Component Make Buy Code
                mfg_lookups ml_comp2, -- Include in Cost Rollup
                mfg_lookups ml_comp3, -- WIP Supply Type
                mfg_lookups ml_src, -- Source Make Buy Code
                fnd_common_lookups fcl_bom, -- Assembly Item Type
                fnd_common_lookups fcl_comp, -- Component Item Type
                fnd_common_lookups fcl_src, -- Source Item Type
                -- End revision for version 1.4
                -- Revision for version         1.6
                -- gl_periods gp,
                -- Revision for version 1.5, from CAC Where Used by Cost Type
                (select nvl(gl.short_name, gl.name) ledger,
                        haou2.name operating_unit,
                        mp_to_org.organization_id organization_id,        
                        mp_to_org.organization_code org_code,
                        msiv.inventory_item_id assembly_item_id,
                        msiv.concatenated_segments assembly_item,
                        msiv.description assembly_description,
                        msiv.item_type assembly_item_type,
                        msiv.inventory_item_status_code assembly_status_code,
                        msiv.planning_make_buy_code assembly_mb_code,
                        msiv.inventory_asset_flag assembly_asset_flag,
                        msiv.primary_uom_code assembly_uom,
                        bom.assembly_type assembly_type,
                        bom.implementation_date bom_date_implemented,
                        mir.revision_code bom_item_revision,
                        comp.item_num comp_item_seq,
                        comp.operation_seq_num comp_op_seq,
                        msiv2.inventory_item_id component_item_id,
                        msiv2.concatenated_segments component_item,
                        msiv2.description component_description,
                        msiv2.primary_uom_code component_uom,
                        msiv2.item_type component_item_type,
                        msiv2.inventory_item_status_code component_status_code,
                        msiv2.planning_make_buy_code component_mb_code,
                        comp.component_quantity,
                        comp.effectivity_date comp_effective_from,
                        comp.disable_date comp_effective_to,
                        nvl(comp.planning_factor,0) comp_planning_percent,
                        comp.component_yield_factor component_yield,
                        comp.include_in_cost_rollup,
                        comp.wip_supply_type
                 from   mtl_parameters mp_to_org,
                        mtl_system_items_vl msiv,  -- Assembly
                        mtl_system_items_vl msiv2, -- Component
                        bom_structures_b bom,
                        hr_organization_information hoi,
                        hr_all_organization_units_vl haou,  -- inv_organization_id
                        hr_all_organization_units_vl haou2, -- operating unit
                        gl_ledgers gl,
                        -- Get the BOM Components
                        (select comp.bill_sequence_id,
                                comp.item_num,
                                comp.operation_seq_num,
                                comp.component_item_id,
                                comp.component_quantity,
                                max(comp.effectivity_date) effectivity_date,
                                comp.disable_date,
                                comp.planning_factor,
                                comp.component_yield_factor,
                                comp.include_in_cost_rollup,
                                comp.wip_supply_type,
                                comp.supply_subinventory,
                                comp.supply_locator_id
                         from   bom_components_b comp,
                                -- Add BOM table to only look at primary components
                                bom_structures_b bom_comp,
                                mtl_parameters mp_to_org,
                                mtl_system_items_vl msiv2
                         where  comp.effectivity_date       <= sysdate
                         and    nvl(comp.disable_date, sysdate+1) >  sysdate        
                         and    bom_comp.alternate_bom_designator is null
                         and    bom_comp.common_assembly_item_id is null
                         and    bom_comp.assembly_type       = 1   -- Manufacturing
                         and    bom_comp.bill_sequence_id    = comp.bill_sequence_id
                         and    mp_to_org.organization_id    = bom_comp.organization_id
                         and    msiv2.organization_id        = bom_comp.organization_id
                         and    msiv2.inventory_item_id      = comp.component_item_id
                         and    mp_to_org.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                         and    4=4                        -- p_to_org
                         and    5=5                        -- p_component_number
                         and    6=6                        -- p_include_unimplemented_ECOs
                         group by
                                comp.bill_sequence_id,
                                comp.item_num,
                                comp.operation_seq_num,
                                comp.component_item_id,
                                comp.component_quantity,
                                comp.disable_date,
                                comp.planning_factor,
                                comp.component_yield_factor,
                                comp.include_in_cost_rollup,
                                comp.wip_supply_type,
                                comp.supply_subinventory,
                                comp.supply_locator_id) comp,
                        -- Get the Item Revisions
                        (select max(mir.revision)     revision_code,
                                mir.inventory_item_id inventory_item_id,
                                mir.organization_id   organization_id
                         from   mtl_item_revisions_b mir,
                                -- Add organization_parameters to limit by Org Code
                                mtl_parameters mp_to_org
                         where  mir.effectivity_date      <= sysdate
                         and    mp_to_org.organization_id  = mir.organization_id
                         and    mp_to_org.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                         and    4=4                        -- p_to_org
                         group by
                                mir.inventory_item_id,
                                mir.organization_id) mir
                 where   mp_to_org.organization_id          = msiv.organization_id
                 and     msiv.organization_id               = bom.organization_id
                 and     msiv.inventory_item_id             = bom.assembly_item_id
                 and     msiv2.organization_id              = mp_to_org.organization_id
                 and     msiv2.inventory_item_id            = comp.component_item_id
                 and     bom.alternate_bom_designator is null
                 and     bom.common_assembly_item_id is null
                 and     bom.assembly_type                  = 1   -- Manufacturing
                 and     bom.bill_sequence_id               = comp.bill_sequence_id
                 and     comp.effectivity_date             <= sysdate
                 and     nvl(comp.disable_date, sysdate+1) >  sysdate
                 and     msiv.organization_id               = mir.organization_id
                 and     msiv.inventory_item_id             = mir.inventory_item_id
                 -- Don't report obsolete or inactive items
                 and     msiv.inventory_item_status_code   <> 'Inactive'
                 and     msiv2.inventory_item_status_code  <> 'Inactive'
                 and     mp_to_org.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                 and     8=8                               -- p_include_expense_items, p_include_uncosted_items
                 and     1=1                               -- p_operating_unit, p_ledger
                 and     4=4                               -- p_to_org
                 and     5=5                               -- p_component_number
                 and     7=7                               -- p_assy_number
                 -- ===================================================================
                 -- using the base tables to avoid using
                 -- org_organization_definitions and hr_operating_units
                 -- ===================================================================
                 and     hoi.org_information_context        = 'Accounting Information'
                 and     hoi.organization_id                = mp_to_org.organization_id
                 and     hoi.organization_id                = haou.organization_id   -- this gets the organization name
                 and     haou2.organization_id              = hoi.org_information3   -- this gets the operating unit id
                 and     gl.ledger_id                       = to_number(hoi.org_information1) -- get the ledger_id
                 -- Avoid selecting disabled inventory organizations
                 and     sysdate < nvl(haou.date_to, sysdate + 1)
                ) to_org_wu,
                -- Source of Components
                (select mp_to_org.organization_code to_org_code,
                        mp_src_org.organization_code src_org_code,
                        mp_to_org.organization_id to_org_id,
                        mp_src_org.organization_id src_org_id,
                        mas.assignment_set_name assignment_set,
                        msr.sourcing_rule_name sourcing_rule,
                        msiv2.concatenated_segments src_item_number,
                        msiv2.inventory_item_id src_item_id,
                        msiv2.primary_uom_code src_uom_code,
                        msiv2.description src_description,
                        msiv2.inventory_item_status_code src_item_status_code,
                        msiv2.item_type src_item_type,
                        -- Revision for version 1.3
                        msiv2.planning_make_buy_code src_mb_code
                 from   mrp_sr_source_org msso,
                        mrp_sr_receipt_org msro,
                        mrp_sourcing_rules msr,
                        mrp_sr_assignments msa,
                        mrp_assignment_sets mas,
                        mtl_system_items_vl msiv2,
                        mtl_parameters mp_to_org,
                        mtl_parameters mp_src_org
                 -- ====================================
                 -- Sourcing_Rule Joins
                 -- ====================================
                 where  msso.sr_receipt_id            = msro.sr_receipt_id
                 and    msr.sourcing_rule_id          = msro.sourcing_rule_id
                 and    msa.sourcing_rule_id          = msro.sourcing_rule_id
                 and    msa.assignment_set_id         = mas.assignment_set_id
                 -- Want the source organization item information
                 and    msiv2.organization_id         = msso.source_organization_id
                 and    msiv2.inventory_item_id       = msa.inventory_item_id
                 -- Only choose organization sourcing rules
                 and    msso.source_organization_id is not null
                 -- Client only has one Assignment Set
                 and    2=2                           -- p_assignment_set                             -- p_assignment_set
                 -- Don't report obsolete or inactive items
                 and    msiv2.inventory_item_status_code <> 'Inactive'
                 -- ====================================
                 -- Material Parameter joins
                 -- ====================================
                 and    mp_to_org.organization_id     = msa.organization_id
                 and    mp_src_org.organization_id    = msso.source_organization_id
                 -- ====================================
                 -- Org To and From Parameters
                 -- ====================================
                 and    mp_to_org.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                 and    3=3                           -- p_src_org
                 and    4=4                           -- p_to_org
                 union all
                 select mp_to_org.organization_code to_org_code,
                        mp_src_org.organization_code src_org_code,
                        mp_to_org.organization_id to_org_id,
                        msiv2.source_organization_id src_org_id,
                        '' assignment_set,
                        '' sourcing_rule,
                        msiv2.concatenated_segments src_item_number,
                        msiv2.inventory_item_id src_item_id,
                        msiv2.primary_uom_code src_uom_code,
                        msiv2.description src_description,
                        msiv2.inventory_item_status_code src_item_status_code,
                        msiv2.item_type src_item_type,
                        -- Revision for version 1.3
                        msiv2.planning_make_buy_code to_org_mb_code
                 from   mtl_system_items_vl msiv2,
                        mtl_parameters mp_to_org,
                        mtl_parameters mp_src_org
                 -- ====================================
                 -- Sourcing_Rule Joins
                 -- ====================================
                 where  msiv2.organization_id         = mp_to_org.organization_id
                 and    msiv2.source_organization_id is not null
                 -- Don't report obsolete or inactive items
                 and    msiv2.inventory_item_status_code <> 'Inactive'
                 -- ====================================
                 -- Material Parameter joins for to_org
                 -- ====================================
                 and    msiv2.organization_id         = mp_to_org.organization_id
                 and    msiv2.source_organization_id  = mp_src_org.organization_id
                 and    msiv2.organization_id        <> mp_to_org.master_organization_id
                 and    msiv2.source_organization_id <> mp_src_org.master_organization_id
                 -- ====================================
                 -- Org To and From Parameters
                 -- ====================================
                 and    mp_to_org.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                 and    3=3                           -- p_src_org
                 and    4=4                           -- p_to_org
                 and     not exists (
                                     select 'x'
                                     from   mrp_sr_source_org msso,
                                            mrp_sr_receipt_org msro,
                                            -- Revision for version 1.6
                                            -- mrp_sourcing_rules msr,
                                            mrp_sr_assignments msa,
                                            mrp_assignment_sets mas
                                     where  msso.sr_receipt_id            = msro.sr_receipt_id
                                     -- Revision for version         1.6
                                     -- and    msr.sourcing_rule_id          = msro.sourcing_rule_id
                                     and    msa.sourcing_rule_id          = msro.sourcing_rule_id
                                     -- Client only has one Assignment Set
                                     and    2=2                           -- p_assignment_set
                                     and    msa.assignment_set_id         = mas.assignment_set_id
                                     and    msiv2.organization_id         = msa.organization_id
                                     and    msiv2.inventory_item_id       = msa.inventory_item_id
                                     -- ====================================
                                     -- Material Parameter joins for to_org
                                     -- ====================================
                                     and    msa.organization_id           = mp_to_org.organization_id
                                     and    msso.source_organization_id   = mp_src_org.organization_id
                                    )
                ) item_sourcing,
                -- =================================================
                -- Revision for version 1.1, add PII amounts
                -- Get To Org Cost information
                -- =================================================
                (select cic.organization_id,
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
                             and    9=9                    -- p_pii_cost_type, p_pii_resource_code
                             and    cicd.inventory_item_id = cic.inventory_item_id
                             and    cicd.organization_id   = cic.organization_id
                             and    cicd.resource_id       = br.resource_id
                            ),0) pii_cost
                 from   cst_item_costs cic,
                        cst_cost_types cct
                 -- ====================================
                 -- Item Cost Joins for the To Org
                 -- ====================================
                 where  cic.cost_type_id              = cct.cost_type_id
                 and    10=10                         -- p_cost_type
                 and    cic.inventory_item_id in 
                                (select msiv2.inventory_item_id
                                 from   mtl_system_items_vl msiv2,
                                        mtl_parameters mp_to_org
                                 where  msiv2.organization_id       = mp_to_org.organization_id
                                 and    mp_to_org.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                                 and    4=4                         -- p_to_org
                                 and    5=5                         -- p_component_number
                                )
                 union all
                 select cic.organization_id,
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
                             and    9=9                    -- p_pii_cost_type, p_pii_resource_code
                             and    cicd.inventory_item_id = cic.inventory_item_id
                             and    cicd.organization_id   = cic.organization_id
                             and    cicd.resource_id       = br.resource_id
                             -- Revision for version 1.4
                            ),0) pii_cost
                 from   cst_item_costs cic,
                        cst_cost_types cct,
                        mtl_parameters mp_to_org
                 -- ====================================
                 -- Item Cost Joins for the To Org
                 -- ====================================
                 where  cic.organization_id           = mp_to_org.organization_id
                 and    mp_to_org.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                 and    cic.cost_type_id              = mp_to_org.primary_cost_method  -- this gets the Frozen Costs
                 and    cct.cost_type_id             <> mp_to_org.primary_cost_method  -- this avoids getting the Frozen costs twice
                 and