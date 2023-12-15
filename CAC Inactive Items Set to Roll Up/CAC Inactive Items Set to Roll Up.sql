/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inactive Items Set to Roll Up
-- Description: Report to show items which are set to roll up even though these items have an inactive status.  The Cost Rollup uses the Based on Rollup Flag to control if an item is rolled up, as opposed to the item status.

Parameters:
===========
Cost Type:  enter the cost type to report (mandatory).  Defaults to your Costing Method cost type.
Inactive Item Status:  enter the item statuses which should not be rolled up (mandatory).  Defaults to 'Inactive'.
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
-- | Program Name: xxx_inactive_items_set_to_rollup_rept.sql
-- |
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 15 Nov 2023 Douglas Volz   Initial version
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-inactive-items-set-to-roll-up/
-- Library Link: https://www.enginatics.com/reports/cac-inactive-items-set-to-roll-up/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        cct.cost_type Cost_Type,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        muomv.uom_code UOM_Code,
        fcl.meaning Item_Type,
        misv.inventory_item_status_code_tl Item_Status_Code,
        ml1.meaning Make_Buy_Code,
        msiv.std_lot_size Std_Lot_Size,
&category_columns
        fl1.meaning Allow_Costs,
        ml2.meaning Inventory_Asset,
        ml3.meaning Use_Default_Controls,
        ml4.meaning Based_on_Rollup,
        cic.lot_size Costing_Lot_Size,
        cic.shrinkage_rate Shrinkage_Rate,
        gl.currency_code Currency_Code,
        cic.item_cost Item_Cost
from    cst_item_costs cic,
        cst_cost_types cct,
        mtl_parameters mp,
        mtl_system_items_vl msiv,
        mtl_item_status_vl misv,
        mtl_units_of_measure_vl muomv,
        mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
        mfg_lookups ml2, -- inventory_asset_flag, SYS_YES_NO
        mfg_lookups ml3, -- defaulted_flag, SYS_YES_NO
        mfg_lookups ml4, -- based on rollup, CST_BONROLLUP_VAL
        fnd_lookups fl1, -- allow costs, YES_NO
        fnd_common_lookups fcl, -- Item Type
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2, -- operating unit
        gl_ledgers gl
where   cic.cost_type_id                = cct.cost_type_id
and     cic.organization_id             = msiv.organization_id
and     cic.inventory_item_id           = msiv.inventory_item_id
and     msiv.primary_uom_code           = muomv.uom_code
and     msiv.inventory_item_status_code = misv.inventory_item_status_code
and     mp.organization_id              = msiv.organization_id
-- ===================================================================
-- Don't report the unused or disabled inventory organizations
-- ===================================================================
and     mp.organization_id             <> mp.master_organization_id    -- remove the global master org
and     sysdate                        < nvl(haou.date_to, sysdate + 1)
-- ===================================================================
-- Find items to be rolled up
-- ===================================================================
and     cic.based_on_rollup_flag       = 1 -- Yes
-- ===================================================================
-- Lookup codes
-- ===================================================================
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = msiv.planning_make_buy_code
and     ml2.lookup_type                 = 'SYS_YES_NO'
and     ml2.lookup_code                 = to_char(cic.inventory_asset_flag)
and     ml3.lookup_type                 = 'SYS_YES_NO'
and     ml3.lookup_code                 = cic.defaulted_flag
and     ml4.lookup_type                 = 'CST_BONROLLUP_VAL'
and     ml4.lookup_code                 = cic.based_on_rollup_flag
and     fl1.lookup_type                 = 'YES_NO'
and     fl1.lookup_code                 = msiv.costing_enabled_flag
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
and     gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                             -- p_inactive_item_status, p_cost_type, p_item_number, p_org_code, p_operating_unit, p_ledger
-- ===================================================================
-- Order by Ledger, Operating Unit, Org Code, Cost Type and Item Number
order by 1,2,3,4,5