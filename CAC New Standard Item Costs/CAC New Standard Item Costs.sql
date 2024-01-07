/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC New Standard Item Costs
-- Description: Report to show items which have recent item cost changes, including various item controls, last cost update submission, new standard item cost, prior item cost and current (Frozen) item cost, by cost update date.  And whether or not BOMs, routings or (inventory organization) sourcing rules exist for the item.  As allowed with no onhand or intransit quantities, if an item cost has been directly entered into the Frozen Cost Type, the Cost Update Request Id, Cost Update Description, Cost Update Status and related cost update submission columns will be blank or empty.

Parameters:
Cost Update Date From:  starting cost update date, based on standard cost submission history (required).
Cost Update Date To: ending cost update date, based on standard cost submission history (required).
From Cost Type:  enter the cost type implemented by the Standard Cost Update into the Frozen costs (optional).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2023 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_new_standard_item_cost_rept.sql
-- | 
-- | Version Modified on Modified by    Description
-- | ======= =========== ============== =========================================
-- |  1.0    29 Sep 2023 Douglas Volz   Initial coding based on the Cost Update
-- |                                    Submissions report.
-- |  1.1    30 Oct 2023 Douglas Volz   Added Item Created By, Last Updated By 
-- |                                    and BOM/Routing/Sourcing Rules exist columns.
-- |  1.2    22 Nov 2023 Douglas Volz   Add item master and costing lot sizes, and 
-- |                                    use default controls columns.
-- |  1.3    05 Dec 2023 Douglas Volz   Added G/L and Operating Unit security restrictions. 
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-new-standard-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-new-standard-item-costs/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        fcl.meaning Item_Type,
        msiv.creation_date Item_Creation_Date,
        msiv.last_update_date Item_Last_Update_Date,
        -- Revision for version 1.1
        fu_item.user_name Item_Created_By,
        prior_fu_item.user_name Item_Last_Updated_By,
        -- End revision for version 1.1
        misv.inventory_item_status_code_tl Item_Status,
        ml1.meaning Make_Buy_Code,
        -- Revision for version 1.2
        msiv.std_lot_size Std_Lot_Size,
        -- Revision for version 1.1
        fl2.meaning BOM,
        fl3.meaning Routing,
        fl4.meaning Sourcing_Rule,
        -- End revision for version 1.1
&category_columns
        fl1.meaning Allow_Costs,
        ml2.meaning Inventory_Asset,
       -- Revision for version 1.2
        ml9.meaning Use_Default_Controls,
        ml3.meaning Based_on_Rollup,
       -- Revision for version 1.2
        cic.lot_size Costing_Lot_Size,
        cic.shrinkage_rate Shrinkage_Rate,
        csc.standard_cost_revision_date Cost_Update_Date,
        csc.cost_update_id Cost_Update_Id,
        fu.user_name Cost_Update_Created_By,
        ccu.request_id Cost_Update_Request_Id,
        csc.standard_cost New_Standard_Cost,
        prior_cu.prior_standard_cost Prior_Standard_Cost,
        cic.item_cost Current_Standard_Cost,
        muomv.uom_code UOM_Code,
        csc.inventory_adjustment_quantity Inventory_Adjustment_Qty,
        csc.inventory_adjustment_value Inventory_Adjustment_Value,
        csc.intransit_adjustment_quantity Intransit_Adjustment_Qty,
        csc.intransit_adjustment_value Intransit_Adjustment_Value,
        csc.wip_adjustment_quantity WIP_Adjustment_Qty,
        csc.wip_adjustment_value WIP_Adjustment_Value,
        decode(ccu.cost_type_id, mp.primary_cost_method, null, cct.cost_type)  From_Cost_Type,
        ccu.description Cost_Update_Description,
        ml4.meaning Cost_Update_Status,
        ml5.meaning Cost_Update_Range,
        ccu.concatenated_segments Specific_Item_Number,
        ccu.single_item_description Specific_Item_Description,
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
        gl.currency_code, 
        ml6.meaning Cost_Details_Saved,
        ml7.meaning Updated_Resources_Overheads,
        ml8.meaning Updated_Activity_Costs,
        prior_cu.prior_cost_update_id Prior_Cost_Update_Id,
        prior_cu.prior_cost_update_date Prior_Cost_Update_Date,
        prior_fu.user_name Prior_Created_By,
        &segment_columns
        gcc.concatenated_segments Adjustment_Account
from    cst_standard_costs csc,
        cst_item_costs cic,
        cst_cost_types cct,
        mtl_parameters mp,
        mtl_system_items_vl msiv,
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
        -- Revision for version 1.2
        mfg_lookups ml9, -- defaulted_flag, SYS_YES_NO
        fnd_lookups fl1, -- allow costs, YES_NO
        -- Revision for version 1.1
        fnd_lookups fl2, -- BOM, YES_NO
        fnd_lookups fl3, -- Routing, YES_NO
        fnd_lookups fl4, -- Sourcing rule, YES_NO
        -- End revision for version 1.1
        fnd_user fu,
        fnd_user prior_fu,
        -- Revision for version 1.1
        fnd_user fu_item,
        fnd_user prior_fu_item,
        -- End revision for version 1.1
        gl_ledgers gl,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2, -- operating unit
        -- When there is no onhand quantity, you can directly update the item's
        -- Frozen cost.  When this happens there are no rows in cst_cost_updates.
        (select ccu.cost_update_id,
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
                msiv.inventory_item_id,
                msiv.concatenated_segments,
                msiv.description single_item_description
         from   cst_cost_updates ccu,
                cst_cost_types cct,
                mtl_system_items_vl msiv,
                mtl_parameters mp
         where  ccu.organization_id             = mp.organization_id
         and    ccu.cost_type_id                = cct.cost_type_id
         and    ccu.single_item                 = msiv.inventory_item_id (+)
         and    ccu.organization_id             = msiv.organization_id (+)
         and    3=3                             -- p_org_code
         and    4=4                             -- p_cost_type
         and    5=5                             -- p_cost_update_date_from, p_cost_update_date_to
        ) ccu,
        -- When you directly update the Frozen item costs, the csc.last_cost_update_id
        -- column is null.  Instead, use this sql logic to find the last standard cost update.
        (select distinct
                csc.inventory_item_id,
                csc.organization_id organization_id,
                csc.cost_update_id,
                max(csc2.cost_update_id) keep (dense_rank last order by csc2.standard_cost_revision_date) over (partition by csc2.organization_id, csc2.inventory_item_id)  prior_cost_update_id,
                max(csc2.standard_cost_revision_date) over (partition by csc2.organization_id, csc2.inventory_item_id) prior_cost_update_date,
                max(csc2.created_by) keep (dense_rank last order by csc2.standard_cost_revision_date) over (partition by csc2.organization_id, csc2.inventory_item_id) prior_created_by,
                max(csc2.standard_cost) keep (dense_rank last order by csc2.standard_cost_revision_date) over (partition by csc2.organization_id, csc2.inventory_item_id) prior_standard_cost,
                -- Revision for version 1.1
                -- check to see if a bom exists
                nvl((select distinct 'Y'
                     from   bom_structures_b bom
                     where  bom.organization_id     = mp.organization_id
                     and    bom.assembly_item_id    = csc.inventory_item_id
                     and    bom.alternate_bom_designator is null),'N') bom,
                -- check to see if a routing exists
                nvl((select distinct 'Y'
                     from   bom_operational_routings bor
                     where  bor.organization_id     = mp.organization_id
                     and    bor.assembly_item_id    = csc.inventory_item_id
                     and    bor.alternate_routing_designator is null),'N') routing,
                -- check to see if a sourcing rule exists for the receipt org
                nvl((select distinct 'Y'
                     from   mrp_sr_receipt_org msro,
                            mrp_sr_source_org msso,
                            mrp_sourcing_rules msr,
                            mrp_sr_assignments msa,
                            mrp_assignment_sets mas
                     where  msr.sourcing_rule_id    = msro.sourcing_rule_id
                     and    msso.sr_receipt_id      = msro.sr_receipt_id
                     and    msso.source_organization_id is not null
                     and    msa.sourcing_rule_id    = msr.sourcing_rule_id
                     and    msa.assignment_set_id   = mas.assignment_set_id
                     and    csc.organization_id     = msa.organization_id
                     and    csc.inventory_item_id   = msa.inventory_item_id
                     and    mp.organization_id      = msa.organization_id
                     and    mas.assignment_set_name = ('&p_assignment_set')
                     and    7=7),'N') sourcing_rule -- p_assignment_set
                -- End revision for version 1.1
         from   cst_standard_costs csc2, -- prior cost update
                cst_standard_costs csc,
                mtl_parameters mp
         where  csc.cost_update_id              > csc2.cost_update_id (+)
         and    csc.inventory_item_id           = csc2.inventory_item_id (+)
         and    csc.organization_id             = csc2.organization_id (+)
         and    mp.organization_id              = csc.organization_id
         and    2=2                             -- p_cost_update_date_from, p_cost_update_date_to
         and    3=3                             -- p_org_code
         and    6=6                             -- p_item_number
        ) prior_cu      
where   cct.cost_type_id                = nvl(ccu.cost_type_id, mp.primary_cost_method)
and     cic.inventory_item_id           = msiv.inventory_item_id
and     cic.organization_id             = msiv.organization_id
and     cic.cost_type_id                = mp.primary_cost_method -- for current item costs
and     csc.inventory_item_id           = msiv.inventory_item_id
and     csc.organization_id             = msiv.organization_id
and     msiv.organization_id            = mp.organization_id
and     fu.user_id (+)                  = csc.created_by
-- Revision for version 1.1
and     fu_item.user_id (+)             = msiv.created_by
and     prior_fu_item.user_id (+)       = msiv.last_updated_by
-- End revision for version 1.1
-- Add joins for prior cost updates
and     csc.cost_update_id              = prior_cu.cost_update_id
and     csc.inventory_item_id           = prior_cu.inventory_item_id
and     csc.organization_id             = prior_cu.organization_id
and     prior_fu.user_id (+)            = prior_cu.prior_created_by
-- End joins for prior cost updates
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
and     msiv.primary_uom_code           = muomv.uom_code
and     msiv.inventory_item_status_code = misv.inventory_item_status_code
-- When you directly update the Frozen item costs, there are no rows in cst_cost_updates.
and     csc.cost_update_id              = ccu.cost_update_id (+)
and     csc.organization_id             = ccu.organization_id (+)
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
-- Revision for version 1.2
and     ml9.lookup_type                 = 'SYS_YES_NO'
and     ml9.lookup_code                 = cic.defaulted_flag
-- End revision for version 1.2
and     fl1.lookup_type                 = 'YES_NO'
and     fl1.lookup_code                 = msiv.costing_enabled_flag
-- Revision for version 1.1
and     fl2.lookup_type                 = 'YES_NO'
and     fl2.lookup_code                 = prior_cu.bom
and     fl3.lookup_type                 = 'YES_NO'
and     fl3.lookup_code                 = prior_cu.routing
and     fl4.lookup_type                 = 'YES_NO'
and     fl4.lookup_code                 = prior_cu.sourcing_rule
-- End revision for version 1.1
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = csc.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.3
and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and     haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
-- End revision for version 1.3
and     1=1                             -- p_operating_unit, p_ledger
and     2=2                             -- p_cost_update_date_from, p_cost_update_date_to
and     3=3                             -- p_org_code
and     4=4                             -- p_cost_type
-- order by ledger, operating unit, org code, item number, cost update revision date and cost update id
order by
        nvl(gl.short_name, gl.name), -- Ledger
        haou2.name, -- Operating_Unit
        mp.organization_code, -- Org_Code
        msiv.concatenated_segments, -- Item_Number
        csc.standard_cost_revision_date,
        csc.cost_update_id