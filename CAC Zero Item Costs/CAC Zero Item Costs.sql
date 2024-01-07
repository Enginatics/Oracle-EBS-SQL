/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Zero Item Costs
-- Description: Report to show zero item costs in the Costing Method cost type, the creation date, the last transaction id, last transaction date and any onhand stock, based on the item master creation date.

Parameters:
Creation Date From:  starting item master creation date (required).
Creation Date To: ending item master creation date (required).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).S
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2010 - 2023 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged.  No warranties, express or otherwise is included in this      |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_zero_item_cost_rept.sql
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0    11 Mar 2010 Douglas Volz   Initial Coding
-- |  1.1    29 Mar 2010 Douglas Volz   Added item status and item type to the 
-- |                                    report and removed 9xx inventory orgs
-- |  1.2    05 Oct 2010 Douglas Volz   Added Ledger parameter, updated column headings,
-- |                                    added UOM_Code column, added union all to
-- |                                    select items with no costs at all
-- |  1.3    10 Feb 2017 Douglas Volz   Removed client-specific org restrictions
-- |  1.4    22 May 2017 Douglas Volz   Added product type, business code, product family,
-- |                                    product line and package code item categories
-- |  1.5    17 Jul 2018 Douglas Volz   Revised to report any two item categories.
-- |  1.6    27 Jan 2020 Douglas Volz   Added Org_Code and Operating_Unit parameters.
-- |  1.7    27 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                    master, inventory orgs and operating units
-- |  1.8    07 Nov 2020 Douglas Volz   Changed to multi-language for status and UOM
-- |  1.9    09 Jul 2023 Douglas Volz   Remove tabs and restrict to only orgs you have
-- |                                    access to, using the org access view.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-zero-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-zero-item-costs/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        fcl.meaning Item_Type,
        -- Revision for version 1.8
        misv.inventory_item_status_code_tl Item_Status,
        ml.meaning Make_Buy_Code,
        -- Revision for version 1.3
&category_columns
        fl1.meaning Allow_Costs,
        fl2.meaning Inventory_Asset,
        msiv.creation_date Creation_Date,
        nvl(cic1.item_cost,0) Item_Cost,
        (select max(mmt.transaction_id)
         from   mtl_material_transactions mmt
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
        -- Revision for version 1.8
        muomv.uom_code UOM_Code,
        nvl((select sum(mohd.transaction_quantity)
             from   mtl_onhand_quantities_detail mohd
             where  mohd.inventory_item_id  = msiv.inventory_item_id
             and    mohd.organization_id    = msiv.organization_id),0) Onhand_Quantity        
from    cst_item_costs cic1,
        mtl_system_items_vl msiv,
        -- Revision for version 1.8
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv, 
        -- End revision for version 1.8
        mtl_parameters mp,
        mfg_lookups ml,  -- planning make/buy code, MTL_PLANNING_MAKE_BUY
        fnd_lookups fl1, -- allow costs, YES_NO
        fnd_lookups fl2, -- inventory_asset_flag, YES_NO
        fnd_common_lookups fcl,
        gl_ledgers gl,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2  -- operating unit
where   msiv.inventory_item_id          = cic1.inventory_item_id
and     mp.organization_id              = cic1.organization_id
and     mp.primary_cost_method          = cic1.cost_type_id -- this gets the Cost Method
and     cic1.item_cost                  = 0
-- Revision for version 1.8
and     msiv.primary_uom_code           = muomv.uom_code
and     misv.inventory_item_status_code = msiv.inventory_item_status_code
-- End revision for version 1.8
and     ml.lookup_type                  = 'MTL_PLANNING_MAKE_BUY'
and     ml.lookup_code                  = msiv.planning_make_buy_code
and     fl1.lookup_type                 = 'YES_NO'
and     fl1.lookup_code                 = msiv.costing_enabled_flag
and     fl2.lookup_type                 = 'YES_NO'
and     fl2.lookup_code                 = msiv.inventory_asset_flag
and     fcl.lookup_type                 = 'ITEM_TYPE'
and     fcl.lookup_code                 = msiv.item_type
-- Revision for version 1.3
and     mp.organization_id             <> mp.master_organization_id     -- remove the global master org
-- End revision for version 1.3
and     msiv.organization_id            = mp.organization_id
and     gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1
-- Revision for version 1.9
and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id        
-- ===================================================================
union all
-- Now get the items where they are defined in the item master but not
-- in the cost master.  These items have no cost at all, not even zero.
-- ===================================================================
select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        fcl.meaning Item_Type,
        -- Revision for version 1.8
        misv.inventory_item_status_code_tl Item_Status,
        ml.meaning Make_Buy_Code,
        -- Revision for version 1.3
&category_columns
        fl1.meaning Allow_Costs,
        fl2.meaning Inventory_Asset,
        msiv.creation_date Creation_Date,
        null Item_Cost,
        (select max(mmt.transaction_id)
         from   mtl_material_transactions mmt
         where  mmt.organization_id     = msiv.organization_id
         and    mmt.inventory_item_id   = msiv.inventory_item_id) Last_Transaction_Number,
        (select mmt.transaction_date
         from   mtl_material_transactions mmt
         where  mmt.transaction_id in
                                (select max(mmt2.transaction_id)
                                 from   mtl_material_transactions mmt2
                                 where  mmt2.organization_id     = msiv.organization_id
                                 and    mmt2.inventory_item_id   = msiv.inventory_item_id)) Last_Transaction_Date,
        (select  mtt.transaction_type_name
         from    mtl_material_transactions mmt,
                 mtl_transaction_types mtt
         where  mtt.transaction_type_id = mmt.transaction_type_id
         and    mmt.transaction_id in
                                (select max(mmt2.transaction_id)
                                 from   mtl_material_transactions mmt2
                                 where  mmt2.organization_id     = msiv.organization_id
                                 and    mmt2.inventory_item_id   = msiv.inventory_item_id)) Last_Transaction_Type,
        -- Revision for version 1.8
        muomv.uom_code UOM_Code,
        nvl((select sum(mohd.transaction_quantity)
                from    mtl_onhand_quantities_detail mohd
                where  mohd.inventory_item_id  = msiv.inventory_item_id
                and    mohd.organization_id    = msiv.organization_id),0) Onhand_Quantity        
from    mtl_system_items_vl msiv,
        -- Revision for version 1.8
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv, 
        -- End revision for version 1.8
        mtl_parameters mp,
        mfg_lookups ml,  -- planning make/buy code, MTL_PLANNING_MAKE_BUY
        fnd_lookups fl1, -- allow costs, YES_NO
        fnd_lookups fl2, -- inventory_asset_flag, YES_NO
        fnd_common_lookups fcl,
        gl_ledgers gl,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2  -- operating unit
where   msiv.organization_id            = mp.organization_id
-- Revision for version 1.8
and     msiv.primary_uom_code           = muomv.uom_code
and     misv.inventory_item_status_code = msiv.inventory_item_status_code
-- End revision for version 1.8
and     ml.lookup_type                  = 'MTL_PLANNING_MAKE_BUY'
and     ml.lookup_code                  = msiv.planning_make_buy_code
and     fl1.lookup_type                 = 'YES_NO'
and     fl1.lookup_code                 = msiv.costing_enabled_flag
and     fl2.lookup_type                 = 'YES_NO'
and     fl2.lookup_code                 = msiv.inventory_asset_flag
and     fcl.lookup_type                 = 'ITEM_TYPE'
and     fcl.lookup_code                 = msiv.item_type
-- Revision for version 1.3
and     mp.organization_id             <> mp.master_organization_id     -- remove the global master org
-- End revision for version 1.3
and     gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1
-- Revision for version 1.9
and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     not exists (
        select  'x'
        from    cst_item_costs cic
        where   cic.organization_id   = msiv.organization_id
        and     cic.inventory_item_id = msiv.inventory_item_id
        and     cic.cost_type_id      = mp.primary_cost_method     -- this gets the Cost Method
                   )
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp.organization_id
and     hoi.organization_id             = haou.organization_id   -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id        
-- ===================================================================
-- Order by Ledger, Operating_Unit, Org_Code and Item_Number
order by 1,2,3,4