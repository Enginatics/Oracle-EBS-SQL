/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Last Standard Item Cost
-- Description: Report to show the last standard item cost as of a specified cost update date; expecially useful if you have not saved off your Frozen costs at year-end, before updating to your new standard costs for the following year.  Including various item controls, last cost update submission, last standard item cost and current (Frozen) item cost.  And whether or not BOMs, routings or (inventory organization) sourcing rules exist for the item as of the specified cost update date.  And as allowed with no onhand or intransit quantities, if an item cost has been directly entered into the Frozen Cost Type, the Cost Update Request Id, Cost Update Description, Cost Update Status and related cost update submission columns will be blank or empty.

This report complements the CAC New Standard Item Cost report.  The CAC New Standard Item Cost report shows you the cost update history over a range of  Standard Cost Revision Dates, useful to track standard cost changes on a weekly basis.  The CAC Last Standard Item Cost report shows you how each item got its last Standard Item Cost as of a given Standard Cost Revision Date.  Useful to assess when the current standard costs were created and by whom.

Parameters:
==========
Cost Update Date To: ending cost update revision date, based on standard cost submission history (required).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Status to Exclude:  enter the item status to exclude from this report, defaults to Inactive (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2024 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_last_standard_item_cost_rept.sql
-- |
-- | Description:
-- | Report to show the last standard cost for all items in an inventory organization,
-- | up to the entered Cost Update Date parameter.
-- | 
-- | Version Modified on Modified by    Description
-- | ======= =========== ============== =========================================
-- |  1.0    15 Jan 2024 Douglas Volz   Initial coding based on the New Standard Item Cost report.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-last-standard-item-cost/
-- Library Link: https://www.enginatics.com/reports/cac-last-standard-item-cost/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        fcl.meaning Item_Type,
        msiv.creation_date Item_Creation_Date,
        msiv.last_update_date Item_Last_Update_Date,
        fu_item.user_name Item_Created_By,
        prior_fu_item.user_name Item_Last_Updated_By,
        misv.inventory_item_status_code_tl Item_Status,
        ml1.meaning Make_Buy_Code,
        msiv.std_lot_size Std_Lot_Size,
        fl2.meaning BOM,
        fl3.meaning Routing,
        fl4.meaning Sourcing_Rule,
&category_columns
        fl1.meaning Allow_Costs,
        ml2.meaning Inventory_Asset,
        ml3.meaning Based_on_Rollup,
        cic.lot_size Costing_Lot_Size,
        cic.shrinkage_rate Shrinkage_Rate,
        csc.standard_cost_revision_date Cost_Update_Date,
        csc.cost_update_id Cost_Update_Id,
        fu.user_name Cost_Update_Created_By,
        ccu.request_id Cost_Update_Request_Id,
        csc.standard_cost Last_Standard_Cost,
        cic.item_cost Current_Standard_Cost,
        muomv.uom_code UOM_Code,
        csc.inventory_adjustment_quantity Inventory_Adjustment_Qty,
        csc.inventory_adjustment_value Inventory_Adjustment_Value,
        csc.intransit_adjustment_quantity Intransit_Adjustment_Qty,
        csc.intransit_adjustment_value Intransit_Adjustment_Value,
        csc.wip_adjustment_quantity WIP_Adjustment_Qty,
        csc.wip_adjustment_value WIP_Adjustment_Value,
        decode(ccu.cost_type_id, null, cct.cost_type, ccu.cost_type)  "From Cost Type",
        ccu.description "Cost Update Description",
        ml4.meaning Cost_Update_Status,
        ml5.meaning Cost_Update_Range,
        msiv_ccu.concatenated_segments Single_Item_Number,
        msiv_ccu.description Single_Item_Description,
        ccu.item_range_low Item_Range_Low,
        ccu.item_range_high Item_Range_High,
        (select   mcsv.category_set_name
         from     mtl_category_sets_vl mcsv
         where    mcsv.category_set_id        = ccu.category_set_id
         and      ccu.category_set_id is not null
        ) Category_Set,
        (select   mcv.category_concat_segs
         from     mtl_categories_v mcv
         where    mcv.category_id             = ccu.category_id
         and      ccu.category_id is not null
        ) Category_Name,
        ml6.meaning Cost_Details_Saved,
        ml7.meaning Updated_Resources_Overheads,
        ml8.meaning Updated_Activity_Costs,
        &segment_columns
        gcc.concatenated_segments Adjustment_Account
from    cst_item_costs cic,
        cst_cost_types cct,
        mtl_parameters mp,
        mtl_system_items_vl msiv,
        mtl_system_items_vl msiv_ccu,
        mtl_item_status_vl misv,
        mtl_units_of_measure_vl muomv,
        gl_code_combinations_kfv gcc,
        fnd_common_lookups fcl,
        mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
        mfg_lookups ml2, -- inventory_asset_flag, SYS_YES_NO
        mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
        mfg_lookups ml4, -- cost update status
        mfg_lookups ml5, -- cost update submission range
        mfg_lookups ml6, -- snapshot saved, YES_NO
        mfg_lookups ml7, -- update resource overheads, YES_NO
        mfg_lookups ml8, -- activity costs saved, YES_NO
        mfg_lookups ml9, -- defaulted_flag, SYS_YES_NO
        fnd_lookups fl1, -- allow costs, YES_NO
        fnd_lookups fl2, -- BOM, YES_NO
        fnd_lookups fl3, -- Routing, YES_NO
        fnd_lookups fl4, -- Sourcing rule, YES_NO
        fnd_user fu,
        fnd_user fu_item,
        fnd_user prior_fu_item,
        gl_ledgers gl,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2, -- operating unit
        (select csc.inventory_item_id,
                csc.organization_id organization_id,
                csc.cost_update_id cost_update_id,
                csc.standard_cost_revision_date,
                csc.created_by,
                csc.standard_cost,
                csc.inventory_adjustment_quantity,
                csc.inventory_adjustment_value,
                csc.intransit_adjustment_quantity,
                csc.intransit_adjustment_value,
                csc.wip_adjustment_quantity,
                csc.wip_adjustment_value,
                -- check to see if a bom exists
                max(nvl((select distinct 'Y'
                     from   bom_structures_b bom
                     where  bom.organization_id      = csc.organization_id
                     and    bom.assembly_item_id     = csc.inventory_item_id
                     and    bom.implementation_date <  :p_cost_update_date_to + 1
                     and    bom.alternate_bom_designator is null),'N')) bom,
                -- check to see if a routing exists
                max(nvl((select distinct 'Y'
                     from   bom_operational_routings bor
                     where  bor.organization_id      = csc.organization_id
                     and    bor.assembly_item_id     = csc.inventory_item_id
                     and    bor.creation_date       <  :p_cost_update_date_to + 1
                     and    bor.alternate_routing_designator is null),'N')) routing,
                -- check to see if a sourcing rule exists for the receipt org
                max(nvl((select distinct 'Y'
                     from   mrp_sr_receipt_org msro,
                            mrp_sr_source_org msso,
                            mrp_sourcing_rules msr,
                            mrp_sr_assignments msa,
                            mrp_assignment_sets mas
                     where  msr.sourcing_rule_id     = msro.sourcing_rule_id
                     and    msso.sr_receipt_id       = msro.sr_receipt_id
                     and    msso.source_organization_id is not null
                     and    msa.sourcing_rule_id     = msr.sourcing_rule_id
                     and    msa.assignment_set_id    = mas.assignment_set_id
                     and    csc.organization_id      = msa.organization_id
                     and    csc.inventory_item_id    = msa.inventory_item_id
                     and    msa.creation_date       <  :p_cost_update_date_to + 1
                     and    5=5),'N')) sourcing_rule -- p_assignment_set
         from   cst_standard_costs csc,
                -- Get the maximum cost_update_id
                (select csc2.inventory_item_id, 
                        csc2.organization_id, 
                        max(csc2.cost_update_id) cost_update_id
                 from   cst_standard_costs csc2,
                        mtl_parameters mp
                 where  mp.organization_id                = csc2.organization_id
                 and    2=2                               -- p_cost_update_date_to
                 and    3=3                               -- p_org_code
                 and    4=4                               -- p_item_number
                 group by
                        csc2.inventory_item_id,
                        csc2.organization_id
                ) csc2
         where  csc.cost_update_id             = csc2.cost_update_id
         and    csc.organization_id            = csc2.organization_id
         and    csc.inventory_item_id          = csc2.inventory_item_id
         group by
                csc.inventory_item_id,
                csc.organization_id, 
                csc.cost_update_id,
                csc.standard_cost_revision_date,
                csc.created_by,
                csc.standard_cost,
                csc.inventory_adjustment_quantity,
                csc.inventory_adjustment_value,
                csc.intransit_adjustment_quantity,
                csc.intransit_adjustment_value,
                csc.wip_adjustment_quantity,
                csc.wip_adjustment_value
        ) csc,
        -- When there is no onhand quantity, you can directly update the item's
        -- Frozen cost.  When this happens there are no rows in cst_cost_updates.
        (select csc2.cost_update_id,
                csc2.inventory_item_id csc2_inventory_item_id,
                ccu.last_update_date,
                ccu.last_updated_by,
                ccu.creation_date,
                ccu.last_update_login,
                ccu.created_by,
                ccu.status,
                ccu.organization_id,
                ccu.cost_type_id,
                ccu.update_date,
                ccu.description,
                ccu.range_option,
                ccu.update_resource_ovhd_flag,
                ccu.update_activity_flag,
                ccu.snapshot_saved_flag,
                ccu.inv_adjustment_account,
                ccu.single_item,
                ccu.category_set_id,
                ccu.category_id,
                ccu.item_range_low,
                ccu.item_range_high,
                ccu.inventory_adjustment_value,
                ccu.intransit_adjustment_value,
                ccu.wip_adjustment_value,
                ccu.scrap_adjustment_value,
                ccu.request_id,
                cct.cost_type,
                msiv.concatenated_segments,
                msiv.description single_item_description
         from   cst_cost_updates ccu,
                cst_cost_types cct,
                mtl_system_items_vl msiv,
                mtl_parameters mp,
                -- Get the maximum cost_update_id
                (select csc2.inventory_item_id, 
                        csc2.organization_id, 
                        max(csc2.cost_update_id) cost_update_id
                 from   cst_standard_costs csc2,
                        mtl_parameters mp
                 where  mp.organization_id                = csc2.organization_id
                 and    2=2                               -- p_cost_update_date_to
                 and    3=3                               -- p_org_code
                 and    4=4                               -- p_item_number
                 group by
                        csc2.inventory_item_id,
                        csc2.organization_id
                ) csc2
         where  ccu.organization_id             = mp.organization_id
         and    ccu.cost_type_id                = cct.cost_type_id
         and    ccu.single_item                 = msiv.inventory_item_id (+)
         and    ccu.organization_id             = msiv.organization_id (+)
         and    3=3                             -- p_org_code
         and    ccu.cost_update_id              = csc2.cost_update_id
        ) ccu    
where   mp.organization_id              = cic.organization_id
and     cct.cost_type_id                = mp.primary_cost_method
and     msiv.inventory_item_id          = cic.inventory_item_id
and     msiv.organization_id            = cic.organization_id
and     cic.cost_type_id                = mp.primary_cost_method -- for current item costs
and     csc.inventory_item_id (+)       = msiv.inventory_item_id
and     csc.organization_id (+)         = msiv.organization_id
and     msiv.organization_id            = mp.organization_id
and     fu.user_id (+)                  = csc.created_by
and     fu_item.user_id (+)             = msiv.created_by
and     prior_fu_item.user_id (+)       = msiv.last_updated_by
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
and     msiv.primary_uom_code           = muomv.uom_code
and     msiv.inventory_item_status_code = misv.inventory_item_status_code
-- When you directly update the Frozen item costs, there are no rows in cst_cost_updates.
and     csc.cost_update_id              = ccu.cost_update_id (+)
and     csc.organization_id             = ccu.organization_id (+)
and     csc.inventory_item_id           = ccu.csc2_inventory_item_id (+) 
and     msiv_ccu.inventory_item_id (+)  = ccu.single_item
and     msiv_ccu.organization_id (+)    = ccu.organization_id
and     gcc.code_combination_id (+)     = ccu.inv_adjustment_account
-- ===================================================================
-- Lookup codes
-- ===================================================================
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = msiv.planning_make_buy_code
and     ml2.lookup_type                 = 'SYS_YES_NO'
and     ml2.lookup_code                 = cic.inventory_asset_flag
and     ml3.lookup_type                 = 'CST_BONROLLUP_VAL'
and     ml3.lookup_code                 = cic.based_on_rollup_flag
and     ml4.lookup_type (+)             = 'CST_COST_UPDATE_STATUS'
and     ml4.lookup_code (+)             = ccu.status
and     ml5.lookup_type (+)             = 'CST_ITEM_RANGE'
and     ml5.lookup_code (+)             = ccu.range_option
and     ml6.lookup_type (+)             = 'SYS_YES_NO'
and     ml6.lookup_code (+)             = ccu.snapshot_saved_flag
and     ml7.lookup_type (+)             = 'SYS_YES_NO'
and     ml7.lookup_code (+)             = ccu.update_resource_ovhd_flag
and     ml8.lookup_type (+)             = 'SYS_YES_NO'
and     ml8.lookup_code (+)             = ccu.update_activity_flag
and     ml9.lookup_type                 = 'SYS_YES_NO'
and     ml9.lookup_code                 = cic.defaulted_flag
and     fl1.lookup_type                 = 'YES_NO'
and     fl1.lookup_code                 = msiv.costing_enabled_flag
and     fl2.lookup_type (+)             = 'YES_NO'
and     fl2.lookup_code (+)             = csc.bom
and     fl3.lookup_type (+)             = 'YES_NO'
and     fl3.lookup_code (+)             = csc.routing
and     fl4.lookup_type (+)             = 'YES_NO'
and     fl4.lookup_code (+)             = csc.sourcing_rule
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     1=1                             -- p_item_status_to_exclude, p_operating_unit, p_ledger
and     3=3                             -- p_org_code
-- order by ledger, operating unit, org code, item number, cost update revision date and cost update id
order by
        nvl(gl.short_name, gl.name), -- Ledger
        haou2.name, -- Operating Unit
        mp.organization_code, -- Org Code
        msiv.concatenated_segments, -- Item Number
        csc.standard_cost_revision_date,
        csc.cost_update_id