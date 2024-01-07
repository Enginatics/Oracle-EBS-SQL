/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC New Items
-- Description: Report to show items which have been recently created, including various item controls, item costs (per your Costing Method), item master accounts, last transaction and onhand stock, based on the item master creation date.

Parameters:
===========
Creation Date From:  starting item master creation date (required).
Creation Date To: ending item master creation date (required).
Include Uncosted Items:  enter Yes to display items which are set to not be costed in your Costing Method Cost Type, defaulted as Yes (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).S
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2010 - 2023 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_new_items_rept.sql
-- |
-- |
-- | Description:
-- | Report to show zero item costs in the "costing method" cost type, 
-- | the creation date and any onhand stock.
-- | 
-- | version modified on modified by description
-- | ======= =========== ============== =========================================
-- |  1.0    14 jun 2017 Douglas Volz   Initial coding based on the zero item cost
-- |                                    report, xxx_zero_item_cost_report.sql, version 1.3
-- |  1.1    20 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters.
-- |  1.2    07 Jul 2022 Douglas Volz   Changed to multi-language views for the item
-- |                                    master and inventory orgs.  Added item master
-- |                                    accounts and costs by cost element.
-- |  1.3    09 Jul 2023 Douglas Volz   Remove tabs and restrict to only orgs you have
-- |                                    access to, using the org access view.
-- |  1.4    08 Aug 2023 Douglas Volz   Fix item status code to use translated values.
-- |  1.5    22 Nov 2023 Douglas Volz   Add BOM/Routing/Sourcing Rule columns, item master
-- |                                    created by and std lot size and costing created by,
-- |                                    costing lot size and defaulted flag. 
-- |  1.6    05 Dec 2023 Douglas Volz   Added G/L and Operating Unit security restrictions. 
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-new-items/
-- Library Link: https://www.enginatics.com/reports/cac-new-items/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        msiv.organization_code Org_Code,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        fcl.meaning Item_Type,
        msiv.creation_date Item_Creation_Date,
        -- Revision for version 1.5
        fu_item.user_name Item_Created_by,
        -- Revision for version 1.4
        misv.inventory_item_status_code_tl Item_Status,
        ml1.meaning Make_Buy_Code,
        -- End revision for version 1.2
        -- Revision for version 1.5
        msiv.std_lot_size Std_Lot_Size,
        fl2.meaning BOM,
        fl3.meaning Routing,
        fl4.meaning Sourcing_Rule,
        -- End revision for version 1.5
&category_columns
        -- Revision for version 1.2
        fl1.meaning Allow_Costs,
        ml2.meaning Inventory_Asset,
       -- Revision for version 1.5
        ml4.meaning Use_Default_Controls,
        ml3.meaning Based_on_Rollup,
       -- Revision for version 1.2
        cic.lot_size Costing_Lot_Size,
        cic.shrinkage_rate Shrinkage_Rate,
        gl.currency_code Currency_Code,
        msiv.market_price Market_Price,
        msiv.list_price_per_unit Target_or_PO_List_Price,
        cic.material_cost Material_Cost,
        cic.material_overhead_cost Material_Overhead_Cost,
        cic.resource_cost Resource_Cost,
        cic.outside_processing_cost Outside_Processing_Cost,
        cic.overhead_cost Overhead_Cost,
        -- End revision for version 1.2
        cic.item_cost Item_Cost,
        (select max(mmt.transaction_id)
         from    mtl_material_transactions mmt
         where  mmt.organization_id     = msiv.organization_id
         and    mmt.inventory_item_id   = msiv.inventory_item_id) Last_Transaction_Number,
        (select mmt.transaction_date
         from   mtl_material_transactions mmt
         where  mmt.transaction_id in
                (select max(mmt2.transaction_id)
                 from   mtl_material_transactions mmt2
                 where  mmt2.organization_id     = msiv.organization_id
                 and    mmt2.inventory_item_id   = msiv.inventory_item_id)) Last_Transaction_Date,
        (select mtt.transaction_type_name
         from   mtl_material_transactions mmt,
                mtl_transaction_types mtt
                where  mtt.transaction_type_id = mmt.transaction_type_id
                and    mmt.transaction_id in
                (select max(mmt2.transaction_id)
                 from   mtl_material_transactions mmt2
                 where  mmt2.organization_id     = msiv.organization_id
                 and    mmt2.inventory_item_id   = msiv.inventory_item_id)) Last_Transaction_Type,
        -- Revision for version 1.2
        muomv.uom_code UOM_Code,
        nvl((select sum(mohd.transaction_quantity)
             from   mtl_onhand_quantities_detail mohd
             where  mohd.inventory_item_id   = msiv.inventory_item_id
             and    mohd.organization_id     = msiv.organization_id),0) Onhand_Quantity,
        -- Revision for version 1.2
        &segment_columns
        cic.creation_date Cost_Creation_Date,
        -- End revision for version 1.2
        -- Revision for version 1.5
        fu_cost.user_name Cost_Created_By
from    -- Revision for version 1.5
        (select mp.organization_code,
                msiv.organization_id,
                msiv.inventory_item_id,
                msiv.concatenated_segments,
                msiv.description,
                cct.cost_type,
                cct.cost_type_id,
                msiv.item_type,
                msiv.creation_date,
                msiv.created_by,
                msiv.inventory_item_status_code,
                msiv.planning_make_buy_code,
                msiv.std_lot_size,
                msiv.market_price,
                msiv.list_price_per_unit,
                msiv.costing_enabled_flag,
                msiv.primary_uom_code,
                msiv.cost_of_sales_account,
                msiv.sales_account,
                msiv.expense_account,
                -- Revision for version 1.5
                -- check to see if a bom exists
                nvl((select distinct 'Y'
                     from   bom_structures_b bom
                     where  bom.organization_id     = msiv.organization_id
                     and    bom.assembly_item_id    = msiv.inventory_item_id
                     and    bom.alternate_bom_designator is null),'N') bom,
                -- check to see if a routing exists
                nvl((select distinct 'Y'
                     from   bom_operational_routings bor
                     where  bor.organization_id     = msiv.organization_id
                     and    bor.assembly_item_id    = msiv.inventory_item_id
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
                     and    msiv.organization_id    = msa.organization_id
                     and    msiv.inventory_item_id  = msa.inventory_item_id
                     and    mp.organization_id      = msa.organization_id
                     and    mas.assignment_set_name = ('&p_assignment_set')
                     and    4=4),'N') sourcing_rule -- p_assignment_set
                -- End revision for version 1.5
         from   mtl_system_items_vl msiv,
                mtl_parameters mp,
                cst_cost_types cct
         where  mp.organization_id              = msiv.organization_id
         and    mp.primary_cost_method          = cct.cost_type_id
         and    mp.organization_id             <> mp.master_organization_id     -- remove the global master org
         and    1=1                             -- p_creation_date_from, p_creation_date_to, p_org_code
         and    2=2                             -- p_include_uncosted_items
         -- Revision for version 1.3
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
        ) msiv,
        cst_item_costs cic,
        -- Revision for version 1.2
        mtl_item_status_vl misv,
        mtl_units_of_measure_vl muomv,
        -- End revision for version 1.2
        fnd_common_lookups fcl,
        -- Revision for version 1.2
        mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
        mfg_lookups ml2, -- inventory_asset_flag, SYS_YES_NO
        mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
        -- Revision for version 1.5
        mfg_lookups ml4, -- defaulted_flag, SYS_YES_NO
        fnd_lookups fl1, -- allow costs, YES_NO
        -- Revision for version 1.5
        fnd_lookups fl2, -- BOM, YES_NO
        fnd_lookups fl3, -- Routing, YES_NO
        fnd_lookups fl4, -- Sourcing rule, YES_NO
        -- End revision for version 1.5
        gl_code_combinations gcc1,
        gl_code_combinations gcc2,
        gl_code_combinations gcc3,
        -- End revision for version 1.2
        -- Revision for version 1.5
        fnd_user fu_item,
        fnd_user fu_cost,
        -- End revision for version 1.5
        gl_ledgers gl,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2  -- operating unit
where   msiv.inventory_item_id          = cic.inventory_item_id (+)
and     msiv.organization_id            = cic.organization_id (+)
and     msiv.cost_type_id               = cic.cost_type_id (+)
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
-- Revision for version 1.2
and     msiv.primary_uom_code           = muomv.uom_code
and     msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.2
-- ===================================================================
-- Revision for version 1.2, joins to get the item master accounts
-- ===================================================================
and     gcc1.code_combination_id (+)    = msiv.cost_of_sales_account
and     gcc2.code_combination_id (+)    = msiv.sales_account
and     gcc3.code_combination_id (+)    = msiv.expense_account
-- ===================================================================
-- Lookup codes, revision for version 1.2
-- ===================================================================
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = msiv.planning_make_buy_code
and     ml2.lookup_type (+)             = 'SYS_YES_NO'
and     ml2.lookup_code (+)             = to_char(cic.inventory_asset_flag)
and     ml3.lookup_type (+)             = 'CST_BONROLLUP_VAL'
and     ml3.lookup_code (+)             = cic.based_on_rollup_flag
-- Revision for version 1.5
and     ml4.lookup_type (+)             = 'SYS_YES_NO'
and     ml4.lookup_code (+)             = cic.defaulted_flag
-- End revision for version 1.5
and     fl1.lookup_type                 = 'YES_NO'
and     fl1.lookup_code                 = msiv.costing_enabled_flag
-- Revision for version 1.5
and     fl2.lookup_type                 = 'YES_NO'
and     fl2.lookup_code                 = msiv.bom
and     fl3.lookup_type                 = 'YES_NO'
and     fl3.lookup_code                 = msiv.routing
and     fl4.lookup_type                 = 'YES_NO'
and     fl4.lookup_code                 = msiv.sourcing_rule
and     fu_item.user_id                 = msiv.created_by
and     fu_cost.user_id (+)             = cic.created_by
-- End revision for version 1.5
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = msiv.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- Revision for version 1.6
and     gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and     haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
-- End revision for version 1.6
and     3=3                             -- p_operating_unit, p_ledger
-- ===================================================================
-- order by ledger, operating unit, org code and item
order by 1,2,3,4,5