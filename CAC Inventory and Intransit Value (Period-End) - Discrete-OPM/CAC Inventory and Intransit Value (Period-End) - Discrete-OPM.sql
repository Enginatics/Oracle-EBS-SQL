/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory and Intransit Value (Period-End) - Discrete/OPM
-- Description: Report showing amount of inventory at the end of the month for both Discrete and Process Manufacturing (OPM) inventory organizations.  If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.  In either case this report uses the month-end quantities, based on the entered period name, OPM calendar code and OPM period code.  And as these quantities come from the month-end snapshot (created when you close the inventory accounting period or run the GMF Period Close Process) and this snapshot is only by inventory organization, subinventory and item and not split out by cost element, this report only shows the Material Account, based upon your Costing Method.

Notes:  
1)  OPM intransit balances based upon last two years of Intransit Shipments.  As of Release 12.2.13, OPM does not have a month-end snapshot for intransit quantities or balances.
2)  This report assumes you use both OPM and Discrete Manufacturing.  If you only use Discrete Manufacturing, use the CAC Inventory and Intransit Value (Period-End) report instead.

Discrete and OPM Parameters:
============================
Period Name (Closed):  the closed inventory accounting period you wish to report (mandatory).
Cost Type:  enter a Cost Type to value the quantities using the Cost Type item costs; or, if Cost Type is not entered the report will use the stored month-end snapshot values (optional).
OPM Calendar Code:  Choose the OPM Calendar Code which corresponds to the inventory accounting period you wish to report (mandatory).
OPM Period Code:  enter the OPM Period Code related to the inventory accounting period and OPM Calendar Code you wish to report (mandatory).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  The second item category set to report, typically the Inventory Category Set (optional).
Item Number:  specific buy or make item you wish to report (optional).
Subinventory:  specific area within the warehouse or inventory area you wish to report (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional).
Ledger:  specific ledger (optional).

/* +=============================================================================+
-- | Copyright 2009 - 2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.                                                                           
-- +=============================================================================+
-- | 1.0     27 Sep 2009 Douglas Volz Initial Coding
-- | 1.29    04 Jun 2024 Douglas Volz Fix SQL error for Intransit code section, due to duplicate transactions in GXEH
-- |                                  (ORA-01427: single-row subquery returns more than one row).
-- | 1.30    09 Jun 2024 Douglas Volz Fix Intransit joins for UOMs, organizations and for duplicate Intransit quantities.
-- | 1.31    25 Jun 2024 Douglas Volz Add Period Code join for Intransit, to avoid cross-joining.
-- | 1.32    27 Jun 2024 Douglas Volz Get intransit account based on the Shipping Network, to avoid duplicate quantities.
-- | 1.33    28 Jun 2024 Douglas Volz Base Intransit SQL logic on two years of Intransit Shipments, not on mtl_supply.
-- | 1.34    30 Jun 2024 Douglas Volz Get default intransit account in case the Shipping Network has been deleted or changed.
-- | 1.35    08 Aug 2024 Douglas Volz Add OPM Cost Organizations to get correct item costs and qtys.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-inventory-and-intransit-value-period-end-discrete-opm/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end-discrete-opm/
-- Run Report: https://demo.enginatics.com/

with inv_organizations as
-- Revision for version 1.17
-- Get the list of organizations, ledgers and operating units for Discrete and OPM organizations
        (select nvl(gl.short_name, gl.name) ledger,
                gl.ledger_id,
                -- Revision for version 1.22
                to_number(hoi.org_information2) legal_entity_id,
                haou2.name operating_unit,
                haou2.organization_id operating_unit_id,
                mp.organization_code,
                mp.organization_id,
                 -- Revision for version 1.35
                decode(nvl(mp.process_enabled_flag,'N'),
                                'Y', nvl(cwa.cost_organization_id, mp.organization_id), 
                                'N', nvl(mp.cost_organization_id, mp.organization_id)
                      ) cost_organization_id,
                -- End revision for version 1.35
                mca.organization_id category_organization_id,
                -- Revision for version 1.18
                mca.category_set_id, 
                mp.material_account,
                -- Revision for version 1.34
                mp.intransit_inv_account,
                -- Revision for version 1.21, better logic for Cost Group Accounting
                 -- mp.cost_group_accounting,
                case
                   when nvl(mp.cost_group_accounting,2) = 1 then 1
                   -- Revision for version 1.23
                   --  when exists (select 'x'
                   --               from   pjm_org_parameters pop
                   --               where  mp.organization_id = pop.organization_id) then 1 -- Project MFG Enabled
                   when pop.organization_id is not null then 1 -- Project MFG Enabled
                   -- End revision for version 1.23
                   when mp.primary_cost_method in (2,5,6) then 1 -- Average, FIFO or LIFO use Cost Group Accounting
                   -- Revision for version 1.22, comment this out
                   -- when nvl(mp.process_enabled_flag, 'N') = 'Y' then 2 -- Avoid OPM and Process Costing
                   when nvl(mp.wms_enabled_flag, 'N') = 'Y' then 1 -- WMS uses Cost Group Accounting
                   else 2
                end cost_group_accounting,
                -- End revision for version 1.21
                -- Revision for version 1.22
                nvl(mp.process_enabled_flag, 'N') process_enabled_flag,
                mp.primary_cost_method,
                mp.default_cost_group_id,
                haou.date_to disable_date,
                gl.currency_code
         from   mtl_category_accounts mca,
                mtl_parameters mp,
                -- Revision for version 1.35
                cm_whse_asc cwa,
                hr_organization_information hoi,
                hr_all_organization_units_vl haou, -- inv_organization_id
                hr_all_organization_units_vl haou2, -- operating unit
                gl_ledgers gl,
                -- Revision for version 1.23
                pjm_org_parameters pop
         where  mp.organization_id              = mca.organization_id (+)
         -- Avoid the item master organization
         and    mp.organization_id             <> mp.master_organization_id
         -- Avoid disabled inventory organizations
         and    sysdate                        <  nvl(haou.date_to, sysdate +1)
         -- Revision for version 1.35
         and    mp.organization_id              = cwa.organization_id (+)
         and    hoi.org_information_context     = 'Accounting Information'
         and    hoi.organization_id             = mp.organization_id
         and    hoi.organization_id             = haou.organization_id   -- this gets the organization name
         and    haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
         and    gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
         -- Revision for version 1.23
         and    mp.organization_id              = pop.organization_id (+)
         -- Revision for version 1.22
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) 
         and    1=1                             -- p_operating_unit, p_ledger
         and    2=2                             -- p_org_code
         group by
                nvl(gl.short_name, gl.name),
                gl.ledger_id,
                -- Revision for version 1.22
                to_number(hoi.org_information2),
                haou2.name, -- operating_unit
                haou2.organization_id, -- operating_unit_id
                mp.organization_code,
                mp.organization_id,
                -- Revision for version 1.35
                decode(nvl(mp.process_enabled_flag,'N'),
                                'Y', nvl(cwa.cost_organization_id, mp.organization_id), 
                                'N', nvl(mp.cost_organization_id, mp.organization_id)
                      ), -- cost_organization_id
                -- End revision for version 1.35
                mca.organization_id, -- category_organization_id
                -- Revision for version 1.18
                mca.category_set_id,
                mp.material_account,
                -- Revision for version 1.34
                mp.intransit_inv_account,
                -- Revision for version 1.21
                -- mp.cost_group_accounting,
                -- Revision for version 1.22
                case
                   when nvl(mp.cost_group_accounting,2) = 1 then 1
                   -- Revision for version 1.23
                   --  when exists (select 'x'
                   --               from   pjm_org_parameters pop
                   --               where  mp.organization_id = pop.organization_id) then 1 -- Project MFG Enabled
                   when pop.organization_id is not null then 1 -- Project MFG Enabled
                   -- End revision for version 1.23
                   when mp.primary_cost_method in (2,5,6) then 1 -- Average, FIFO or LIFO use Cost Group Accounting
                   -- Revision for version 1.22, comment this out
                   -- when nvl(mp.process_enabled_flag, 'N') = 'Y' then 2 -- Avoid OPM and Process Costing
                   when nvl(mp.wms_enabled_flag, 'N') = 'Y' then 1 -- WMS uses Cost Group Accounting
                   else 2
                end, -- cost_group_accounting
                -- End revision for version 1.21
                -- Revision for version 1.23
                nvl(mp.process_enabled_flag, 'N'), -- process_enabled_flag
                nvl(mp.cost_group_accounting,2), 
                nvl(mp.wms_enabled_flag, 'N'),
                -- End revision for version 1.23
                mp.primary_cost_method,
                mp.default_cost_group_id,
                haou.date_to,
                gl.currency_code
        ),
-- Get the inventory valuation accounts by organization, subinventory and category
valuation_accounts as
        (-- Standard Costing, no Cost Group Accounting
         select 'Std Cost No Cost Group Accounting' valuation_type,
                msub.organization_id,
                msub.secondary_inventory_name,
                null category_id,
                null category_set_id,
                msub.material_account,
                msub.asset_inventory,
                msub.quantity_tracked,
                msub.default_cost_group_id cost_group_id
         from   mtl_secondary_inventories msub,
                inv_organizations mp
         where  msub.organization_id = mp.organization_id
         and    nvl(mp.cost_group_accounting,2) = 2 -- No
         -- Avoid organizations with category accounts
         and    mp.category_organization_id is null
         -- Revision for version 1.27
         -- Avoid process organizations
         and    nvl(mp.process_enabled_flag, 'N') <> 'N'
         and    3=3                             -- p_subinventory
         -- Revision for version 1.20
         -- Causing duplicate rows with Average Costing
         -- union all
         -- -- Not Standard Costing, no Cost Group Accounting
         -- select  'Not Std Cost No Cost Group Accounting' valuation_type,
         --         msub.organization_id,
         --         msub.secondary_inventory_name,
         --         null category_id,
         --         null category_set_id,
         --         mp.material_account,
         --         msub.asset_inventory,
         --         msub.quantity_tracked,
         --         msub.default_cost_group_id cost_group_id
         -- from    mtl_secondary_inventories msub,
         --         inv_organizations mp
         -- where   msub.organization_id = mp.organization_id
         -- and     nvl(mp.cost_group_accounting,2) = 2 -- No
         -- and     mp.primary_cost_method         <> 1 -- not Standard Costing
         -- -- Avoid organizations with category accounts
         -- and     mp.category_organization_id is null
         -- End revision for version 1.20
         union all
         -- With Cost Group Accounting
         select 'Cost Group Accounting' valuation_type,
                msub.organization_id,
                msub.secondary_inventory_name,
                null category_id,
                null category_set_id,
                ccga.material_account,
                msub.asset_inventory,
                msub.quantity_tracked,
                msub.default_cost_group_id cost_group_id
         from   mtl_secondary_inventories msub,
                cst_cost_group_accounts ccga,
                cst_cost_groups ccg,
                inv_organizations mp
         where  msub.organization_id            = mp.organization_id
         and    mp.cost_group_accounting        = 1 -- Yes
         -- Avoid organizations with category accounts
         and    mp.category_organization_id is null
         and    ccga.cost_group_id              = nvl(msub.default_cost_group_id, mp.default_cost_group_id)
         and    ccga.cost_group_id              = ccg.cost_group_id
         and    ccga.organization_id            = mp.organization_id
         and    3=3                             -- p_subinventory
         union all
         -- Category Accounting
         -- Revision for version 1.19
         select 'Category Accounting' valuation_type,
                mp.organization_id,
                cat_subinv.subinventory_code secondary_inventory_name,
                mc.category_id,
                mp.category_set_id,
                cat_subinv.material_account,
                cat_subinv.asset_inventory,
                cat_subinv.quantity_tracked,
                cat_subinv.cost_group_id
         from   inv_organizations mp,
                mtl_categories_b mc,
                mtl_category_sets_b mcs,
                mtl_item_categories mic,
                (select msub.organization_id,
                        nvl(mca.subinventory_code, msub.secondary_inventory_name) subinventory_code,
                        mca.category_id,
                        mp.category_set_id,
                        mca.material_account,
                        msub.asset_inventory,
                        msub.quantity_tracked,
                        msub.default_cost_group_id cost_group_id
                 from   mtl_secondary_inventories msub,
                        mtl_category_accounts mca,
                        inv_organizations mp
                 where  msub.organization_id            = mp.organization_id
                 and    msub.organization_id            = mca.organization_id (+)
                 -- Revision for version 1.19
                 -- and msub.secondary_inventory_name   = mca.subinventory_code (+)
                 and    msub.secondary_inventory_name   = nvl(mca.subinventory_code, msub.secondary_inventory_name)
                 -- Only get organizations with category accounts
                 and    mp.category_organization_id is not null
                 and    3=3                             -- p_subinventory
                 -- For a given category_id, if a subinventory-specific category account exists
                 -- exclude the category account with a null subinventory, to avoid double-counting  
                 and not exists
                                (select 'x'
                                 from   mtl_category_accounts mca2
                                 where  mca.subinventory_code is null
                                 and    mca2.subinventory_code is not null
                                 and    mca2.organization_id = mca.organization_id
                                 and    mca2.category_id     = mca.category_id
                                )
                 group by
                        msub.organization_id,
                        nvl(mca.subinventory_code, msub.secondary_inventory_name),
                        mca.category_id,
                        mp.category_set_id,
                        mca.material_account,
                        msub.asset_inventory,
                        msub.quantity_tracked,
                        msub.default_cost_group_id
                ) cat_subinv
         where  mp.organization_id              = mic.organization_id
         and    mp.category_set_id              = mic.category_set_id
         and    mic.category_id                 = mc.category_id
         and    mic.category_set_id             = mcs.category_set_id
         and    mc.category_id                  = mic.category_id
         and    mic.organization_id             = cat_subinv.organization_id (+)
         and    mic.category_id                 = cat_subinv.category_id (+)
         group by
                'Category Accounting',
                mp.organization_id,
                cat_subinv.subinventory_code,
                mc.category_id,
                mp.category_set_id,
                cat_subinv.material_account,
                cat_subinv.asset_inventory,
                cat_subinv.quantity_tracked,
                cat_subinv.cost_group_id
         -- End revision for version 1.19
         union all
         select 'Intransit Accounting' valuation_type,
                interco.organization_id,
                'Intransit' secondary_inventory_name,
                null category_id,
                null category_set_id,
                interco.intransit_inv_account material_account,
                1 asset_inventory,
                1 quantity_tracked,
                mp.default_cost_group_id cost_group_id
         from   inv_organizations mp,
                (select ic.intransit_inv_account,
                        ic.organization_id
                 from   (select mip.intransit_inv_account,
                                mip.to_organization_id organization_id
                         from   mtl_interorg_parameters mip,
                                inv_organizations mp
                         where  mip.fob_point               = 1 -- shipment
                         and    mp.organization_id          = mip.to_organization_id
                         union all
                         select mip.intransit_inv_account,
                                mip.from_organization_id organization_id
                         from   mtl_interorg_parameters mip,
                                inv_organizations mp
                         where  mip.fob_point               = 2 -- receipt
                         and    mp.organization_id          = mip.from_organization_id
                        ) ic
                 group by
                        ic.intransit_inv_account,
                        ic.organization_id
                ) interco
         where  mp.organization_id = interco.organization_id
        )
-- End revision for version 1.17
-- Revision for version 1.33, remove Process Costing valuation_accounts from WITH statement

----------------main query starts here--------------

-- =======================================================================
-- Section I.  Discrete Costing
--             For non-category accounting, get period-end quantities and
--             values based solely on the month-end inventory snapshot.
-- =======================================================================
select  mp.ledger Ledger,
        mp.operating_unit Operating_Unit,
        mp.organization_code Org_Code,
        onhand.period_name Period_Name,
        &segment_columns
        onhand.concatenated_segments Item_Number,
        onhand.description Item_Description,
        -- Revision for version 1.13
        -- flv.meaning Item_Type,
        fcl.meaning Item_Type,
        -- Revision for version 1.14 and 1.16
        misv.inventory_item_status_code_tl Item_Status,
        -- Revision for version 1.22
        ml1.meaning Make_Buy_Code,
        -- Revision for version 1.11
&category_columns
        mp.currency_code Currency_Code,
        decode(onhand.subinventory_code,
                        null, round(nvl(onhand.rollback_intransit_value,0) /
                              decode(nvl(onhand.rollback_quantity,0), 0, 1,
                              nvl(onhand.rollback_quantity,0)),5),
                        round((nvl(onhand.rollback_value,0)) /
                               decode(nvl(onhand.rollback_quantity,0), 0, 1,
                               nvl(onhand.rollback_quantity,0)),5)
              ) Item_Cost,
        -- Revision for version 1.16
        nvl(onhand.subinventory_code, ml3.meaning) Subinventory_or_Intransit,
        -- Revision for version 1.19
        nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml4.meaning) Description,
        -- Revision for version 1.18
        ml2.meaning Asset,
        -- Revision for version 1.16
        muomv.uom_code UOM_Code,
        round(nvl(onhand.rollback_quantity,0),3) Onhand_Quantity,
        decode(onhand.subinventory_code,
                null, round(nvl(onhand.rollback_intransit_value,0),2),
                round(nvl(onhand.rollback_value,0),2)
              ) Onhand_Value
from    inv_organizations mp,
        valuation_accounts va,
        -- Revision for version 1.16
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv,
        -- End revision for version 1.16
        -- Revision for version 1.19
        mtl_secondary_inventories msub,
        gl_code_combinations gcc,
        -- Revision for version 1.13
        fnd_common_lookups fcl, -- Item Type
        -- Revision for version 1.22
        mfg_lookups ml1, -- Make Buy Code
        -- Revision for version 1.18
        mfg_lookups ml2, -- Inventory Asset
        -- Revision for version 1.16
        mfg_lookups ml3, -- Intransit Inventory
        -- Revision for version 1.22
        mfg_lookups ml4, -- Intransit Inventory Description
        -- Revision for version 1.18
        -- Inner query for onhand quantities and values
        (-- For non-category accounting
         select mp.organization_id,
                msiv.inventory_item_id,
                msiv.concatenated_segments,
                -- Revision for version 1.19
                regexp_replace(msiv.description,'[^[:alnum:]'' '']', null) description,
                msiv.primary_uom_code,
                msiv.inventory_item_status_code,
                msiv.item_type,
                -- Revision for version 1.22
                msiv.planning_make_buy_code,
                msiv.inventory_asset_flag,
                oap.period_name,
                cpcs.acct_period_id,
                nvl(cpcs.subinventory_code, 'Intransit') subinventory_code,
                sum(cpcs.rollback_quantity) rollback_quantity,
                sum(cpcs.rollback_value) rollback_value,
                sum(cpcs.rollback_intransit_value) rollback_intransit_value
         from   mtl_system_items_vl msiv,
                cst_period_close_summary cpcs,
                org_acct_periods oap,
                inv_organizations mp
         where  mp.organization_id              = msiv.organization_id
         and    oap.acct_period_id              = cpcs.acct_period_id
         and    oap.organization_id             = mp.organization_id
         and    msiv.organization_id            = cpcs.organization_id
         and    msiv.inventory_item_id          = cpcs.inventory_item_id
         -- Revision for version 1.23
         and    mp.process_enabled_flag         = 'N'
         and    mp.category_organization_id is null
         -- Don't get zero quantities
         and    nvl(cpcs.rollback_quantity,0)  <> 0
         -- Don't report expense items
         and    msiv.inventory_asset_flag       = 'Y'
         and    4=4                             -- p_period_name
         and    6=6                             -- p_item_number
         -- Need to group by due to possibility for having multiple cost groups by subinventory
         group by
                mp.organization_id,
                msiv.inventory_item_id,
                msiv.concatenated_segments,
                regexp_replace(msiv.description,'[^[:alnum:]'' '']', null),
                msiv.primary_uom_code,
                msiv.inventory_item_status_code,
                msiv.item_type,
                -- Revision for version 1.22
                msiv.planning_make_buy_code,
                msiv.inventory_asset_flag,
                oap.period_name,
                cpcs.acct_period_id,
                cpcs.subinventory_code
        ) onhand
        -- End revision for version 1.18
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
where   mp.organization_id              = onhand.organization_id
and     muomv.uom_code                  = onhand.primary_uom_code
and     misv.inventory_item_status_code = onhand.inventory_item_status_code
and     mp.category_organization_id is null
-- Revision for version 1.19
and     onhand.subinventory_code        = msub.secondary_inventory_name (+)
and     onhand.organization_id          = msub.organization_id (+)
-- End revision for version 1.19
-- ===========================================
-- Accounting code combination joins
-- ===========================================
-- Revision for version 1.18
-- and   msub.material_account           = gcc.code_combination_id (+)
and     va.material_account             = gcc.code_combination_id (+)
and     va.secondary_inventory_name (+) = onhand.subinventory_code
and     va.organization_id (+)          = onhand.organization_id
and     va.valuation_type              <> 'Category Accounting'
-- End revision for version 1.18
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.13
and     fcl.lookup_code (+)             = onhand.item_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
-- Revision for version 1.22
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = onhand.planning_make_buy_code
-- Revision for version 1.19
and     ml2.lookup_code                 = nvl(msub.asset_inventory,1)
and     ml2.lookup_type                 = 'SYS_YES_NO'
-- Revision for version 1.16
and     ml3.lookup_code                 = 3 -- Intransit
and     ml3.lookup_type                 = 'MSC_CALENDAR_TYPE'
-- Revision for version 1.22
and     ml4.lookup_type                 = 'CST_UPDATE_TXN_TYPE'
and     ml4.lookup_code                 = 2 -- Intransit Inventory
-- ===========================================
-- Revision for version 1.12
-- Run this query if the Cost Type parameter 
-- is null, to get the snapshot inventory value.
-- ===========================================
and     :p_cost_type is null            -- p_cost_type
union all
-- =======================================================================
-- Section II. Discrete Costing
--             For non-category accounting, get period-end quantities
--             based on the month-end inventory snapshot but get item
--             costs and values from the entered cost type.
-- =======================================================================
select  mp.ledger Ledger,
        mp.operating_unit Operating_Unit,
        mp.organization_code Org_Code,
        onhand.period_name Period_Name,
        &segment_columns
        onhand.concatenated_segments Item_Number,
        onhand.description Item_Description,
        -- Revision for version 1.13
        -- flv.meaning Item_Type,
        fcl.meaning Item_Type,
        -- Revision for version 1.14 and 1.16
        misv.inventory_item_status_code_tl Item_Status,
        -- Revision for version 1.22
        ml1.meaning Make_Buy_Code,
        -- Revision for version 1.11
&category_columns
        mp.currency_code Currency_Code,
        round(nvl(cic.item_cost,0),5) Item_Cost,
        -- Revision for version 1.16
        nvl(onhand.subinventory_code, ml3.meaning) Subinventory_or_Intransit,
        -- Revision for version 1.19
        nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml4.meaning) Description,
        -- Revision for version 1.18
        ml2.meaning Asset,
        -- Revision for version 1.16
        muomv.uom_code UOM_Code,
        round(nvl(onhand.rollback_quantity,0),3) Onhand_Quantity,
        -- Use the Cost Type Costs instead of the rollback_value
        round(nvl(onhand.rollback_quantity,0) * nvl(cic.item_cost,0),2) Onhand_Value
from    inv_organizations mp,
        valuation_accounts va,
        -- Revision for version 1.16
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv,
        -- End revision for version 1.16
        -- Revision for version 1.12
        cst_cost_types cct,
        cst_item_costs cic,
        -- End revision for version 1.12
        gl_code_combinations gcc,
        -- Revision for version 1.13
        fnd_common_lookups fcl, -- Item Type
        -- Revision for version 1.22
        mfg_lookups ml1, -- Make Buy Code
        -- Revision for version 1.18
        mfg_lookups ml2, -- Inventory Asset
        -- Revision for version 1.16
        mfg_lookups ml3, -- Intransit Inventory
        -- Revision for version 1.22
        mfg_lookups ml4, -- Intransit Inventory Description
        -- Revision for version 1.19
        mtl_secondary_inventories msub,
        -- Inner query for onhand quantities and values
        (-- For non-category accounting
         select mp.organization_id,
                msiv.inventory_item_id,
                msiv.concatenated_segments,
                regexp_replace(msiv.description,'[^[:alnum:]'' '']', null) description,
                msiv.primary_uom_code,
                msiv.inventory_item_status_code,
                msiv.item_type,
                -- Revision for version 1.22
                msiv.planning_make_buy_code,
                msiv.inventory_asset_flag,
                oap.period_name,
                cpcs.acct_period_id,
                nvl(cpcs.subinventory_code, 'Intransit') subinventory_code,
                sum(cpcs.rollback_quantity) rollback_quantity,
                sum(cpcs.rollback_value) rollback_value,
                sum(cpcs.rollback_intransit_value) rollback_intransit_value
         from   mtl_system_items_vl msiv,
                cst_period_close_summary cpcs,
                org_acct_periods oap,
                inv_organizations mp
         where  mp.organization_id              = msiv.organization_id
         and    oap.acct_period_id              = cpcs.acct_period_id
         and    oap.organization_id             = mp.organization_id
         and    msiv.organization_id            = cpcs.organization_id
         and    msiv.inventory_item_id          = cpcs.inventory_item_id
         -- Revision for version 1.23
         and    mp.process_enabled_flag         = 'N'
         and    mp.category_organization_id is null
         -- Don't report zero quantities
         and    nvl(cpcs.rollback_quantity,0)  <> 0
         -- Don't report expense items
         and    msiv.inventory_asset_flag       = 'Y'
         and    4=4                             -- p_period_name
         and    6=6                             -- p_item_number
         -- Need to group by due to possibility for having multiple cost groups by subinventory
         group by
                mp.organization_id,
                msiv.inventory_item_id,
                msiv.concatenated_segments,
                regexp_replace(msiv.description,'[^[:alnum:]'' '']', null),
                msiv.primary_uom_code,
                msiv.inventory_item_status_code,
                msiv.item_type,
                -- Revision for version 1.22
                msiv.planning_make_buy_code,
                msiv.inventory_asset_flag,
                oap.period_name,
                cpcs.acct_period_id,
                cpcs.subinventory_code
        ) onhand
        -- End revision for version 1.19
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
where   mp.organization_id              = onhand.organization_id
and     muomv.uom_code                  = onhand.primary_uom_code
and     misv.inventory_item_status_code = onhand.inventory_item_status_code
and     mp.category_organization_id is null
-- Revision for version 1.19
and     onhand.subinventory_code        = msub.secondary_inventory_name (+)
and     onhand.organization_id          = msub.organization_id (+)
-- ===========================================
-- Accounting code combination joins
-- ===========================================
-- Revision for version 1.18
-- and    msub.material_account           = gcc.code_combination_id (+)
and     va.material_account             = gcc.code_combination_id (+)
and     va.secondary_inventory_name (+) = onhand.subinventory_code
and     va.organization_id (+)          = onhand.organization_id
and     va.valuation_type              <> 'Category Accounting'
-- End revision for version 1.18
-- ===========================================
-- Cost Type Joins
-- Revision for version 1.12
-- ===========================================
and     5=5                             -- p_cost_type
and     cct.cost_type_id                = cic.cost_type_id
-- Revision for version 1.16
and     cic.organization_id             = onhand.organization_id
and     cic.inventory_item_id           = onhand.inventory_item_id
-- End for revision for version 1.16
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.13
and     fcl.lookup_code (+)             = onhand.item_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
-- Revision for version 1.22
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = onhand.planning_make_buy_code
-- Revision for version 1.19
and     ml2.lookup_code                 = nvl(msub.asset_inventory,1)
and     ml2.lookup_type                 = 'SYS_YES_NO'
-- Revision for version 1.16
and     ml3.lookup_code                 = 3 -- Intransit
and     ml3.lookup_type                 = 'MSC_CALENDAR_TYPE'
-- Revision for version 1.22
and     ml4.lookup_type                 = 'CST_UPDATE_TXN_TYPE'
and     ml4.lookup_code                 = 2 -- Intransit Inventory
-- ===========================================
-- Revision for version 1.12
-- Run this query if the Cost Type parameter 
-- is not null, use the Cost Type Costs
-- to get the reported inventory value.
-- ===========================================
and     :p_cost_type is not null        -- p_cost_type
union all
-- =======================================================================
-- Section III.  Discrete Costing
--               For category accounting, get period-end quantities and
--               values based solely on the month-end inventory snapshot.
-- =======================================================================
select  mp.ledger Ledger,
        mp.operating_unit Operating_Unit,
        mp.organization_code Org_Code,
        onhand.period_name Period_Name,
        &segment_columns
        onhand.concatenated_segments Item_Number,
        onhand.description Item_Description,
        -- Revision for version 1.13
        -- flv.meaning Item_Type,
        fcl.meaning Item_Type,
        -- Revision for version 1.14 and 1.16
        misv.inventory_item_status_code_tl Item_Status,
        -- Revision for version 1.22
        ml1.meaning Make_Buy_Code,
        -- Revision for version 1.11
&category_columns
        mp.currency_code Currency_Code,
        decode(onhand.subinventory_code,
                        null, round(nvl(onhand.rollback_intransit_value,0) /
                              decode(nvl(onhand.rollback_quantity,0), 0, 1,
                              nvl(onhand.rollback_quantity,0)),5),
                        round((nvl(onhand.rollback_value,0)) /
                               decode(nvl(onhand.rollback_quantity,0), 0, 1,
                               nvl(onhand.rollback_quantity,0)),5)
              ) Item_Cost,
        -- Revision for version 1.16
        nvl(onhand.subinventory_code, ml3.meaning) Subinventory_or_Intransit,
        -- Revision for version 1.19
        nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml4.meaning) Description,
        -- Revision for version 1.18
        ml2.meaning Asset,
        -- Revision for version 1.16
        muomv.uom_code UOM_Code,
        round(nvl(onhand.rollback_quantity,0),3) Onhand_Quantity,
        decode(onhand.subinventory_code,
                null, round(nvl(onhand.rollback_intransit_value,0),2),
                round(nvl(onhand.rollback_value,0),2)
              ) Onhand_Value
from    inv_organizations mp,
        valuation_accounts va,
        -- Revision for version 1.16
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv,
        -- End revision for version 1.16
        gl_code_combinations gcc,
        -- Revision for version 1.13
        fnd_common_lookups fcl, -- Item Type
        -- Revision for version 1.22
        mfg_lookups ml1, -- Make Buy Code
        -- Revision for version 1.18
        mfg_lookups ml2, -- Inventory Asset
        -- Revision for version 1.16
        mfg_lookups ml3, -- Intransit Inventory
        -- Revision for version 1.22
        mfg_lookups ml4, -- Intransit Inventory Description
        -- Revision for version 1.19
        mtl_secondary_inventories msub,
        (-- This onhand inner query is for category accounting
         select onhand2.organization_id,
                onhand2.category_organization_id,
                onhand2.category_set_id,
                mic.category_id,
                onhand2.inventory_item_id,
                onhand2.concatenated_segments,
                onhand2.description,
                onhand2.primary_uom_code,
                onhand2.inventory_item_status_code,
                onhand2.item_type,
                -- Revision for version 1.22
                onhand2.planning_make_buy_code,
                onhand2.period_name,
                onhand2.subinventory_code,
                sum(onhand2.rollback_quantity) rollback_quantity,
                sum(onhand2.rollback_value) rollback_value,
                sum(onhand2.rollback_intransit_value) rollback_intransit_value                
         from   mtl_item_categories mic,
                -- Inner select to have consistent outer joins with categories
                (select mp.organization_id,
                        mp.category_set_id,
                        mp.category_organization_id,
                        msiv.inventory_item_id,
                        msiv.concatenated_segments,
                        regexp_replace(msiv.description,'[^[:alnum:]'' '']', null) description,
                        msiv.primary_uom_code,
                        msiv.inventory_item_status_code,
                        msiv.item_type,
                        -- Revision for version 1.22
                        msiv.planning_make_buy_code,
                        oap.period_name,
                        nvl(cpcs.subinventory_code, 'Intransit') subinventory_code,
                        sum(cpcs.rollback_quantity) rollback_quantity,
                        sum(cpcs.rollback_value) rollback_value,
                        sum(cpcs.rollback_intransit_value) rollback_intransit_value
                 from   mtl_system_items_vl msiv,
                        cst_period_close_summary cpcs,
                        org_acct_periods oap,
                        inv_organizations mp
                 where  mp.organization_id              = msiv.organization_id
                 and    mp.category_organization_id is not null
                 and    oap.organization_id             = mp.organization_id
                 and    oap.acct_period_id              = cpcs.acct_period_id
                 and    cpcs.organization_id            = msiv.organization_id
                 and    cpcs.inventory_item_id          = msiv.inventory_item_id
                 -- Revision for version 1.23
                 and    mp.process_enabled_flag         = 'N'
                 -- Don't get zero quantities
                 and    nvl(cpcs.rollback_quantity,0)  <> 0
                 and    4=4                             -- p_period_name
                 and    6=6                             -- p_item_number
                 group by
                        mp.organization_id,
                        mp.category_set_id,
                        mp.category_organization_id,
                        msiv.inventory_item_id,
                        msiv.concatenated_segments,
                        regexp_replace(msiv.description,'[^[:alnum:]'' '']', null),
                        msiv.primary_uom_code,
                         msiv.inventory_item_status_code,
                        msiv.item_type,
                        -- Revision for version 1.22
                        msiv.planning_make_buy_code,
                        oap.period_name,
                        nvl(cpcs.subinventory_code, 'Intransit') -- subinventory_code
                ) onhand2
         where  mic.inventory_item_id (+)       = onhand2.inventory_item_id
         and    mic.organization_id (+)         = onhand2.organization_id
         and    mic.category_set_id (+)         = onhand2.category_set_id
         -- Need to group by due to possibility for having multiple cost groups by subinventory
         group by
                onhand2.organization_id,
                onhand2.category_organization_id,
                onhand2.category_set_id,
                mic.category_id,
                onhand2.inventory_item_id,
                onhand2.concatenated_segments,
                onhand2.description,
                onhand2.primary_uom_code,
                onhand2.inventory_item_status_code,
                onhand2.item_type,
                -- Revision for version 1.22
                onhand2.planning_make_buy_code,
                onhand2.period_name,
                onhand2.subinventory_code
        ) onhand
        -- End revision for version 1.19
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
where   mp.organization_id              = onhand.organization_id
and     muomv.uom_code                  = onhand.primary_uom_code
and     misv.inventory_item_status_code = onhand.inventory_item_status_code
and     mp.category_organization_id is not null
-- Revision for version 1.19
and     onhand.subinventory_code        = msub.secondary_inventory_name (+)
and     onhand.organization_id          = msub.organization_id (+)
-- End revision for version 1.19
-- ===========================================
-- Accounting code combination joins
-- ===========================================
-- Revision for version 1.19
and     va.material_account             = gcc.code_combination_id (+)
and     va.secondary_inventory_name (+) = onhand.subinventory_code 
and     va.organization_id (+)          = onhand.organization_id
and     va.category_set_id (+)          = onhand.category_set_id
and     va.category_id (+)              = onhand.category_id
and     va.valuation_type (+)           = 'Category Accounting'
-- End revision for version 1.19
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.13
and     fcl.lookup_code (+)             = onhand.item_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
-- Revision for version 1.22
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = onhand.planning_make_buy_code
-- Revision for version 1.19
and     ml2.lookup_code                 = nvl(msub.asset_inventory,1)
and     ml2.lookup_type                 = 'SYS_YES_NO'
-- Revision for version 1.16
and     ml3.lookup_code                 = 3 -- Intransit
and     ml3.lookup_type                 = 'MSC_CALENDAR_TYPE'
-- Revision for version 1.22
and     ml4.lookup_type                 = 'CST_UPDATE_TXN_TYPE'
and     ml4.lookup_code                 = 2 -- Intransit Inventory
-- ===========================================
-- Revision for version 1.12
-- Run this query if the Cost Type parameter 
-- is null, to get the snapshot inventory value.
-- ===========================================
and     :p_cost_type is null            -- p_cost_type
union all
-- =======================================================================
-- Section IV. Discrete Costing
--             For category accounting, get period-end quantities from the
--             month-end snapshot but get item costs from entered cost type.
-- =======================================================================
select  mp.ledger Ledger,
        mp.operating_unit Operating_Unit,
        mp.organization_code Org_Code,
        onhand.period_name Period_Name,
        &segment_columns
        onhand.concatenated_segments Item_Number,
        onhand.description Item_Description,
        -- Revision for version 1.13
        -- flv.meaning Item_Type,
        fcl.meaning Item_Type,
        -- Revision for version 1.14 and 1.16
        misv.inventory_item_status_code_tl Item_Status,
        -- Revision for version 1.22
        ml1.meaning Make_Buy_Code,
        -- Revision for version 1.11
&category_columns
        mp.currency_code Currency_Code,
        round(nvl(cic.item_cost,0),5) Item_Cost,
        -- Revision for version 1.16
        nvl(onhand.subinventory_code, ml3.meaning) Subinventory_or_Intransit,
        -- Revision for version 1.19
        nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml4.meaning) Description,
        -- Revision for version 1.18
        ml2.meaning Asset,
        -- Revision for version 1.16
        muomv.uom_code UOM_Code,
        round(nvl(onhand.rollback_quantity,0),3) Onhand_Quantity,
        -- Use the Cost Type Costs instead of the rollback_value
        round(nvl(onhand.rollback_quantity,0) * nvl(cic.item_cost,0),2) Onhand_Value
from    inv_organizations mp,
        valuation_accounts va,
        -- Revision for version 1.16
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv,
        -- End revision for version 1.16
        -- Revision for version 1.12
        cst_cost_types cct,
        cst_item_costs cic,
        -- End revision for version 1.12
        gl_code_combinations gcc,
        -- Revision for version 1.13
        fnd_common_lookups fcl, -- Item Type
        -- Revision for version 1.22
        mfg_lookups ml1, -- Make Buy Code
        -- Revision for version 1.18
        mfg_lookups ml2, -- Inventory Asset
        -- Revision for version 1.16
        mfg_lookups ml3, -- Intransit Inventory
        -- Revision for version 1.22
        mfg_lookups ml4, -- Intransit Inventory Description
        -- Revision for version 1.19
        mtl_secondary_inventories msub,
        (-- This onhand inner query is for category accounting
         select onhand2.organization_id,
                onhand2.category_organization_id,
                onhand2.category_set_id,
                mic.category_id,
                onhand2.inventory_item_id,
                onhand2.concatenated_segments,
                onhand2.description,
                onhand2.primary_uom_code,
                onhand2.inventory_item_status_code,
                onhand2.item_type,
                -- Revision for version 1.22
                onhand2.planning_make_buy_code,
                onhand2.period_name,
                onhand2.subinventory_code,
                sum(onhand2.rollback_quantity) rollback_quantity
         from   mtl_item_categories mic,
                -- Inner select to have consistent outer joins with categories
                (select mp.organization_id,
                        mp.category_set_id,
                        mp.category_organization_id,
                        msiv.inventory_item_id,
                        msiv.concatenated_segments,
                        regexp_replace(msiv.description,'[^[:alnum:]'' '']', null) description,
                        msiv.primary_uom_code,
                         msiv.inventory_item_status_code,
                        msiv.item_type,
                        -- Revision for version 1.22
                        msiv.planning_make_buy_code,
                        oap.period_name,
                        nvl(cpcs.subinventory_code, 'Intransit') subinventory_code,
                        sum(cpcs.rollback_quantity) rollback_quantity
                 from   mtl_system_items_vl msiv,
                        cst_period_close_summary cpcs,
                        org_acct_periods oap,
                        inv_organizations mp
                 where  mp.organization_id              = msiv.organization_id
                 and    mp.category_organization_id is not null
                 and    oap.organization_id             = mp.organization_id
                 and    oap.acct_period_id              = cpcs.acct_period_id
                 and    cpcs.organization_id            = msiv.organization_id
                 and    cpcs.inventory_item_id          = msiv.inventory_item_id
                 -- Revision for version 1.23
                 and    mp.process_enabled_flag         = 'N'
                 -- Don't get zero quantities
                 and    nvl(cpcs.rollback_quantity,0)  <> 0
                 and    4=4                             -- p_period_name
                 and    6=6                             -- p_item_number
                 group by
                        mp.organization_id,
                        mp.category_set_id,
                        mp.category_organization_id,
                        msiv.inventory_item_id,
                        msiv.concatenated_segments,
                        regexp_replace(msiv.description,'[^[:alnum:]'' '']', null),
                        msiv.primary_uom_code,
                         msiv.inventory_item_status_code,
                        msiv.item_type,
                        -- Revision for version 1.22
                        msiv.planning_make_buy_code,
                        oap.period_name,
                        nvl(cpcs.subinventory_code, 'Intransit') -- subinventory_code
                ) onhand2
         where  mic.inventory_item_id (+)       = onhand2.inventory_item_id
         and    mic.organization_id (+)         = onhand2.organization_id
         and    mic.category_set_id (+)         = onhand2.category_set_id
         -- Need to group by due to possibility for having multiple cost groups by subinventory
         group by
                onhand2.organization_id,
                onhand2.category_organization_id,
                onhand2.category_set_id,
                mic.category_id,
                onhand2.inventory_item_id,
                onhand2.concatenated_segments,
                onhand2.description,
                onhand2.primary_uom_code,
                onhand2.inventory_item_status_code,
                onhand2.item_type,
                -- Revision for version 1.22
                onhand2.planning_make_buy_code,
                onhand2.period_name,
                onhand2.subinventory_code
        ) onhand
        -- End revision for version 1.19
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
where   mp.organization_id              = onhand.organization_id
and     muomv.uom_code                  = onhand.primary_uom_code
and     misv.inventory_item_status_code = onhand.inventory_item_status_code
and     mp.category_organization_id is not null
-- Revision for version 1.19
and     onhand.subinventory_code        = msub.secondary_inventory_name (+)
and     onhand.organization_id          = msub.organization_id (+)
-- ===========================================
-- Accounting code combination joins
-- ===========================================
--- Revision for version 1.19
and     va.material_account             = gcc.code_combination_id (+)
and     va.secondary_inventory_name (+) = onhand.subinventory_code 
and     va.organization_id (+)          = onhand.organization_id
and     va.category_set_id (+)          = onhand.category_set_id
and     va.category_id (+)              = onhand.category_id
and     va.valuation_type (+)           = 'Category Accounting'
-- End revision for version 1.19
-- ===========================================
-- Cost Type Joins
-- Revision for version 1.12
-- ===========================================
and     5=5                             -- p_cost_type
and     cct.cost_type_id                = cic.cost_type_id
-- Revision for version 1.16 and 1.19
and     cic.organization_id (+)         = onhand.organization_id
and     cic.inventory_item_id (+)       = onhand.inventory_item_id
-- End for revision for version 1.16 and 1.19
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.13
and     fcl.lookup_code (+)             = onhand.item_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
-- Revision for version 1.22
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = onhand.planning_make_buy_code
-- Revision for version 1.19
and     ml2.lookup_code                 = nvl(msub.asset_inventory,1)
and     ml2.lookup_type                 = 'SYS_YES_NO'
-- Revision for version 1.16
and     ml3.lookup_code                 = 3 -- Intransit
and     ml3.lookup_type                 = 'MSC_CALENDAR_TYPE'
-- Revision for version 1.22
and     ml4.lookup_type                 = 'CST_UPDATE_TXN_TYPE'
and     ml4.lookup_code                 = 2 -- Intransit Inventory
-- ===========================================
-- Revision for version 1.12
-- Run this query if the Cost Type parameter 
-- is not null, use the Cost Type Costs
-- to get the reported inventory value.
-- ===========================================
and     :p_cost_type is not null        -- p_cost_type
union all
-- =======================================================================
-- Section V. For OPM / Process Manufacturing
--            Get onhand period-end quantities from the month-end snapshot.
--            If the Cost Type is not entered use the latest month-end
--            item costs from the gl_item_cst table.  But if the cost type
--            has been entered, use the item costs from the cost type.
--            Note:  Cost Calendar only required when entering a cost type.
-- =======================================================================
select  mp.ledger Ledger,
        mp.operating_unit Operating_Unit,
        mp.organization_code Org_Code,
        onhand.period_name Period_Name,
        &segment_columns
        onhand.concatenated_segments Item_Number,
        onhand.item_description Item_Description,
        fcl.meaning Item_Type,
        misv.inventory_item_status_code_tl Item_Status,
        ml1.meaning Make_Buy_Code,
&category_columns
        mp.currency_code Currency_Code,
        onhand.item_cost Item_Cost,
        decode(onhand.subinventory_code,'Intransit', ml1.meaning, onhand.subinventory_code) Subinventory_or_Intransit,
        nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml1.meaning) Description,
        ml2.meaning Asset,
        muomv.uom_code UOM_Code,
        onhand.primary_quantity Onhand_Quantity,
        round(onhand.primary_quantity * onhand.item_cost,2) Onhand_Value
from    inv_organizations mp,
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv,
        mtl_secondary_inventories msub,
        -- Revision for version 1.27 and 1.32
        -- valuation_accounts va,
        fnd_common_lookups fcl, -- Item Type
        mfg_lookups ml1, -- Planning Make Buy
        mfg_lookups ml2, -- Inventory Asset
        mfg_lookups ml3, -- Intransit Inventory
        mfg_lookups ml4, -- Intransit Inventory Description
        -- Revision for version 1.19
        gl_code_combinations gcc,
        (-- If the cost type is null, get the item
         -- costs from the month-end item costs.
         select gps.legal_entity_id,
                gic.cost_type_id,
                mp.organization_code,
                -- Revision for version 1.35
                -- gic.organization_id,
                mp.organization_id,
                -- End revision for version 1.35
                gic.inventory_item_id,
                msiv.concatenated_segments,
                msiv.description item_description,
                msiv.item_type,
                msiv.inventory_item_status_code,
                msiv.planning_make_buy_code,
                msiv.primary_uom_code,
                gps.period_code period_code,
                gps.period_id,
                oap.period_name,
                oap.acct_period_id,
                gpb.subinventory_code,
                sum(nvl(gpb.primary_quantity,0)) primary_quantity,
                -- Revision for version 1.25, change decimal precision from 5 to 9
                round(nvl(gic.acctg_cost,0),9) item_cost
         from   gl_item_cst gic,
                gmf_period_statuses gps,
                gmf_fiscal_policies gfp,
                gmf_calendar_assignments gca,
                -- Revision for version 1.22
                -- Added to minimize query data size
                gmf_period_balances gpb,
                mtl_system_items_vl msiv,
                -- Added to minimize query data size
                org_acct_periods oap,
                inv_organizations mp
         where  gic.period_id                   = gps.period_id
         and    gic.cost_type_id                = gfp.cost_type_id
         -- Revision for version 1.35
         -- and    gic.organization_id             = gpb.organization_id
         -- and    gic.organization_id             = msiv.organization_id
         -- and    mp.organization_id              = gic.organization_id
         and    mp.organization_id              = gpb.organization_id
         and    mp.organization_id              = msiv.organization_id
         and    mp.cost_organization_id         = gic.organization_id
         -- End revision for version 1.35
         and    gic.inventory_item_id           = gpb.inventory_item_id
         and    gic.inventory_item_id           = msiv.inventory_item_id
         -- Revision for version 1.28
         and    gic.delete_mark                 = 0
         and    msiv.inventory_asset_flag       = 'Y'
         and    gps.legal_entity_id             = gfp.legal_entity_id
         and    gps.cost_type_id                = gfp.cost_type_id
         and    gps.cost_type_id                = gca.cost_type_id
         and    gps.legal_entity_id             = gca.legal_entity_id
         and    gps.calendar_code               = gca.calendar_code
         -- Revision for version 1.23
         -- After running the Cost Update in Final Mode the gic.calendar_code
         -- is set to a null value.
         -- and    gps.calendar_code               = gic.calendar_code
         and    oap.acct_period_id              = gpb.acct_period_id
         and    oap.organization_id             = gpb.organization_id
         -- Revision for version 1.23
         and    mp.legal_entity_id              = gps.legal_entity_id
         and    mp.process_enabled_flag         = 'Y'
         and    nvl(:p_show_opm_inventory, 'N') = 'Y'
         and    :p_cost_type is null            -- p_cost_type
         -- The Inventory Accounting Period Name may be different from the OPM Period Code
         and    4=4                             -- p_period_name
         and    6=6                             -- p_item_number
         and    7=7                             -- p_calendar_code
         -- Revision for version 1.24
         -- The OPM Period Code may be different from the oap.period_name
         and    8=8                             -- p_period_code
         group by
                gps.legal_entity_id,
                gic.cost_type_id,
                mp.organization_code,
                -- Revision for version 1.35
                -- gic.organization_id,
                mp.organization_id,
                -- End revision for version 1.35
                gic.inventory_item_id,
                msiv.concatenated_segments,
                msiv.description, -- item description
                msiv.item_type,
                msiv.inventory_item_status_code,
                msiv.planning_make_buy_code,
                msiv.primary_uom_code,
                gps.period_code,
                gps.period_id,
                oap.period_name,
                oap.acct_period_id,
                gpb.subinventory_code,
                -- Revision for version 1.25, change decimal precision from 5 to 9
                round(nvl(gic.acctg_cost,0),9) -- item cost
         having sum(nvl(gpb.primary_quantity,0)) <> 0
         union all
         -- If the cost type is not null, get the item
         -- costs from entered cost type.
         select qty.legal_entity_id,
                cost.cost_type_id,
                qty.organization_code,
                qty.organization_id,
                qty.inventory_item_id,
                qty.concatenated_segments,
                qty.item_description item_description,
                qty.item_type,
                qty.inventory_item_status_code,
                qty.planning_make_buy_code,
                qty.primary_uom_code,
                qty.period_code period_code,
                qty.period_id,
                qty.period_name,
                qty.acct_period_id,
                qty.subinventory_code,
                qty.primary_quantity primary_quantity,
                cost.item_cost
         from   (select gps.legal_entity_id,
                        cmm.cost_type_id,
                        mp.organization_code,
                        -- Revision for version 1.35
                        -- ccd.organization_id,
                        mp.organization_id,
                        mp.cost_organization_id,
                        -- End revision for version 1.35
                        ccd.inventory_item_id,
                        msiv.primary_uom_code,
                        gps.period_code period_code,
                        gps.period_id,
                        -- Revision for version 1.25, change decimal precision from 5 to 9
                        round(sum(nvl(ccd.cmpnt_cost,0)),9) item_cost
                 from   cm_cmpt_dtl ccd,
                        cm_cmpt_mst_b ccm,
                        cm_mthd_mst cmm,
                        gmf_period_statuses gps,
                        gmf_calendar_assignments gca,
                        mtl_system_items_vl msiv,
                        inv_organizations mp
                 where  ccd.cost_cmpntcls_id            = ccm.cost_cmpntcls_id
                 and    ccm.product_cost_ind            = 1 -- Yes
                 and    ccd.cost_type_id                = cmm.cost_type_id
                 -- Revision for version 1.28, can't use ccd.calendar_code, null value after final cost update.
                 -- and    ccd.calendar_code               = gca.calendar_code
                 and    ccd.period_id                   = gps.period_id
                 -- End revision for version 1.28
                 -- Revision for version 1.35
                 -- and    ccd.organization_id             = mp.organization_id
                 and    ccd.organization_id             = mp.cost_organization_id
                 -- End revision for version 1.35
                 and    ccd.organization_id             = msiv.organization_id
                 and    ccd.inventory_item_id           = msiv.inventory_item_id
                 -- Revision for version 1.28
                 and    ccd.delete_mark                 = 0
                 and    msiv.inventory_asset_flag       = 'Y'
                 and    mp.process_enabled_flag         = 'Y'
                 and    nvl(:p_show_opm_inventory, 'N') = 'Y'
                 and    gps.cost_type_id                = ccd.cost_type_id
                 and    gps.cost_type_id                = gca.cost_type_id
                 and    gps.legal_entity_id             = gca.legal_entity_id
                 and    gps.legal_entity_id             = mp.legal_entity_id
                 and    gps.calendar_code               = gca.calendar_code
                 and    :p_cost_type is not null        -- p_cost_type
                 and    cmm.cost_mthd_code              = upper(:p_cost_type)
                 and    6=6                             -- p_item_number
                 and    7=7                             -- p_calendar_code
                 -- Revision for version 1.24
                 and    8=8                             -- p_period_code
                 group by
                        gps.legal_entity_id,
                        cmm.cost_type_id,
                        mp.organization_code,
                        -- Revision for version 1.35
                        -- ccd.organization_id,
                        mp.organization_id,
                        mp.cost_organization_id,
                        -- End revision for version 1.35
                        ccd.inventory_item_id,
                        msiv.primary_uom_code,
                        gps.period_code,
                        gps.period_id
                ) cost,
                (select gps.legal_entity_id,
                        mp.organization_code,
                        gpb.organization_id,
                        gpb.inventory_item_id,
                        msiv.concatenated_segments,
                        msiv.description item_description,
                        msiv.item_type,
                        msiv.inventory_item_status_code,
                        msiv.planning_make_buy_code,
                        msiv.primary_uom_code,
                        gps.period_code period_code,
                        gps.period_id,
                        oap.period_name,
                        gpb.acct_period_id,
                        gpb.subinventory_code,
                        sum(nvl(gpb.primary_quantity,0)) primary_quantity
                 from   gmf_period_balances gpb,
                        gmf_period_statuses gps,
                        gmf_calendar_assignments gca,
                        mtl_system_items_vl msiv,
                        org_acct_periods oap,
                        inv_organizations mp
                 where  gpb.organization_id             = msiv.organization_id
                 and    gpb.inventory_item_id           = msiv.inventory_item_id
                 and    oap.acct_period_id              = gpb.acct_period_id
                 and    oap.organization_id             = gpb.organization_id
                 -- Revision for version 1.23
                 and    mp.organization_id              = msiv.organization_id
                 and    msiv.inventory_asset_flag       = 'Y'
                 and    mp.process_enabled_flag         = 'Y'
                 and    nvl(:p_show_opm_inventory, 'N') = 'Y'
                 and    gps.cost_type_id                = gca.cost_type_id
                 and    gps.legal_entity_id             = gca.legal_entity_id
                 and    gps.legal_entity_id             = mp.legal_entity_id
                 and    gps.calendar_code               = gca.calendar_code
                 and    :p_cost_type is not null        -- p_cost_type
                 and    4=4                             -- p_period_name
                 and    6=6                             -- p_item_number
                 and    7=7                             -- p_calendar_code
                 -- Revision for version 1.24
                 -- The OPM Period Code may be different from the oap.period_name
                 and    8=8                             -- p_period_code
                 group by
                        gps.legal_entity_id,
                        mp.organization_code,
                        gpb.organization_id,
                        gpb.inventory_item_id,
                        msiv.concatenated_segments,
                        msiv.description,
                        msiv.item_type,
                        msiv.inventory_item_status_code,
                        msiv.planning_make_buy_code,
                        msiv.primary_uom_code,
                        gps.period_code,
                        gps.period_id,
                        oap.period_name,
                        gpb.acct_period_id,
                        gpb.subinventory_code
                ) qty
         where  qty.inventory_item_id = cost.inventory_item_id
         -- Revision for version 1.28, outer join for item costs
         and    qty.organization_id   = cost.organization_id (+)
         and    qty.period_id         = cost.period_id (+)
         and    qty.legal_entity_id   = cost.legal_entity_id
        ) onhand
where   mp.organization_id              = onhand.organization_id
and     msub.secondary_inventory_name   = onhand.subinventory_code (+)
and     msub.organization_id            = onhand.organization_id (+)
and     msub.asset_inventory           <> 2 -- Expense
and     muomv.uom_code                  = onhand.primary_uom_code
and     misv.inventory_item_status_code = onhand.inventory_item_status_code
-- ===========================================
-- Lookup Codes
-- ===========================================
and     fcl.lookup_code (+)             = onhand.item_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = onhand.planning_make_buy_code
and     ml2.lookup_code                 = nvl(msub.asset_inventory,1)
and     ml2.lookup_type                 = 'SYS_YES_NO'
and     ml3.lookup_code                 = 3 -- Intransit
and     ml3.lookup_type                 = 'MSC_CALENDAR_TYPE'
and     ml4.lookup_type                 = 'CST_UPDATE_TXN_TYPE'
and     ml4.lookup_code                 = 2 -- Intransit Inventory
-- ===========================================
-- For Inventory Valuation Accounts
-- ===========================================
-- Revision for version 1.27 and 1.32
and     msub.material_account           = gcc.code_combination_id (+)
-- and     va.material_account             = gcc.code_combination_id (+)
-- and     va.valuation_type               = 'Process Costing'
-- and     va.secondary_inventory_name     = msub.secondary_inventory_name
-- and     va.organization_id              = mp.organization_id
-- End revision for version 1.27 and 1.32
-- Revision for version 1.30
and     onhand.primary_quantity        <> 0
union all
-- =======================================
-- OPM Intransit Query based on the As of
-- Onhand Lot Value Report dated 8-Apr-15
-- =======================================
select  mp.ledger Ledger,
        mp.operating_unit Operating_Unit,
        mp.organization_code Org_Code,
        oap.period_name Period_Name,
        &segment_columns
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
        fcl.meaning Item_Type,
        misv.inventory_item_status_code_tl Item_Status,
        ml1.meaning Make_Buy_Code,
&category_columns
        mp.currency_code Currency_Code,
        -- Revision for version 1.25, change decimal precision from 5 to 9
        round (onhand.itr_item_cost, 9) Item_Cost,
        ml3.meaning Subinventory_or_Intransit,
        ml4.meaning Description,
        ml2.meaning Asset,
        muomv.uom_code UOM_Code,
        round(sum(onhand.intransit_quantity), 3) Onhand_Quantity,
        round(sum(onhand.itr_intransit_value), 2) Onhand_Value
from    inv_organizations mp,
        mtl_system_items_vl msiv,
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv,
        -- Revision for version 1.27 and 1.32
        -- valuation_accounts va,
        fnd_common_lookups fcl, -- Item Type
        mfg_lookups ml1, -- Planning Make Buy
        mfg_lookups ml2, -- Inventory Asset
        mfg_lookups ml3, -- Intransit Inventory
        mfg_lookups ml4, -- Intransit Description Lookup
        gl_code_combinations gcc,
        org_acct_periods oap,
        -- ================================================
        -- Part IV OPM Intransit Sub-Query
        -- From the As of Onhand Lot Value Report
        -- Version 1.27 dated 8-Apr-2015
        -- ================================================
        (select allqty.organization_id organization_id,
                allqty.from_organization_id from_organization_id,
                allqty.inventory_item_id inventory_item_id,
                allqty.subinventory_code subinventory_code,
                allqty.asset_inventory asset_inventory,
                allqty.code_combination_id code_combination_id,
                sum(allqty.onhand_quantity) onhand_quantity,
                sum(allqty.intransit_quantity) intransit_quantity,
                -- intransit cost and values columns
                sum(allqty.itr_intransit_value)/decode(sum(allqty.intransit_quantity), 0, 1, sum(allqty.intransit_quantity)) itr_item_cost,
                sum(allqty.itr_intransit_value) itr_intransit_value
                from  -- ==============================================================
                      -- Part IV.E
                      -- Calculate Intransit for OPM Process Organizations.
                      -- For Process orgs only, created new logic to calculate intransit quantities.
                      -- This new logic gets the mmt intransit shipments and receipts based on the
                      -- last two years of Intransit Shipments, as anything older than two years is
                      -- is probably not real.
                      -- ==============================================================
                      -- Part IV.E.1 Condense the information
                      -- Rollback the intransit transactions and get the cost information
                      -- for both intransit shipment and receipt transactions
                      -- ==============================================================
                      (select   itr_txn.organization_id organization_id,
                                itr_txn.from_organization_id from_organization_id,
                                itr_txn.inventory_item_id inventory_item_id,
                                itr_txn.subinventory_code subinventory_code,
                                itr_txn.asset_inventory asset_inventory,
                                -- Revision for version 1.32 and 1.34
                                -- itr_txn.code_combination_id code_combination_id,
                                nvl(mip.intransit_inv_account, itr_txn.intransit_inv_account) code_combination_id,
                                0 onhand_quantity,
                                decode(itr_txn.subinventory_code,'Intransit', itr_txn.intransit_quantity, 0) intransit_quantity,
                                itr_txn.transaction_id transaction_id,
                                -- Rules:
                                -- 1) If the Cost Type is null, and the Accounting PreProcessor has been run (opm_processed_flag='Y')
                                --    get the Intransit value from the GXEH transactions.
                                -- 2) If the Cost Type is null but the Accounting PreProcessor has not been run (opm_processed_flag='N')
                                --    get the Intransit value from the latest month-end costs.
                                -- 3) If the Cost Type is not null get the Intransit value from the Cost Type. 
                                decode((:p_cost_type),
                                        null, decode(itr_txn.opm_processed_flag,'Y', nvl(sum(itr_txn.itr_intransit_value), 0),
                                                                                'N', nvl(sum(itr_costs.item_cost * itr_txn.intransit_quantity), 0)),
                                        nvl(sum(itr_costs.item_cost * itr_txn.intransit_quantity),0)
                                      ) itr_intransit_value
                      from      -- Revision for version 1.32
                                -- Get Intransit Account by To and From Relationship, as Intransit Account may vary.
                                mtl_interorg_parameters mip,
                                -- ==============================================================
                                -- Part IV.E.1 Item Costs
                                -- ==============================================================
                                (-- If the Cost Type is null, get the OPM Intransit Item Costs based on the month-end costs.
                                 select gic.organization_id,
                                        gic.inventory_item_id,
                                        -- Revision for version 1.25, change decimal precision from 5 to 9
                                        round(nvl(gic.acctg_cost,0),9) item_cost
                                 from   gl_item_cst gic,
                                        gmf_period_statuses gps,
                                        gmf_fiscal_policies gfp,
                                        gmf_calendar_assignments gca,
                                        cm_mthd_mst cmm,
                                        mtl_system_items_vl msiv,
                                        inv_organizations mp
                                 -- Revision for version 1.35
                                 -- where  gic.organization_id             = msiv.organization_id
                                 -- and    mp.organization_id              = gic.organization_id
                                 where  mp.cost_organization_id         = gic.organization_id
                                 and    mp.organization_id              = msiv.organization_id
                                 -- End revision for version 1.35
                                 and    gic.inventory_item_id           = msiv.inventory_item_id
                                 and    gic.period_id                   = gps.period_id
                                 and    gic.cost_type_id                = gps.cost_type_id
                                 and    gic.cost_type_id                = gfp.cost_type_id
                                 -- Revision for version 1.28
                                 and    gic.delete_mark                 = 0
                                 and    gps.legal_entity_id             = mp.legal_entity_id
                                 and    gps.legal_entity_id             = gfp.legal_entity_id
                                 and    gps.cost_type_id                = gfp.cost_type_id
                                 and    gps.cost_type_id                = gca.cost_type_id
                                 and    gps.legal_entity_id             = gca.legal_entity_id
                                 and    gps.calendar_code               = gca.calendar_code
                                 -- Revision for version 1.23
                                 -- After running the Cost Update in Final Mode the gic.calendar_code
                                 -- is set to a null value.
                                 -- and    gps.calendar_code               = gic.calendar_code
                                 and    gic.cost_type_id                = cmm.cost_type_id
                                 and    mp.process_enabled_flag         = 'Y'
                                 and    nvl(:p_show_opm_inventory, 'N') = 'Y'
                                 and    :p_cost_type is null            -- p_cost_type
                                 -- Revision for version 1.23
                                 and    mp.organization_id              = msiv.organization_id
                                 and    6=6                             -- p_item_number
                                 and    7=7                             -- p_calendar_code
                                 -- Revision for version 1.31
                                 and    8=8                             -- p_period_code
                                 group by 
                                        gic.organization_id,
                                        gic.inventory_item_id,
                                        -- Revision for version 1.25, change decimal precision from 5 to 9
                                        round(nvl(gic.acctg_cost,0),9) -- item cost
                                 union all
                                 -- If the Cost Type is not null, get the OPM Intransit Item Costs based on the Cost Type.
                                 select ccd.organization_id,
                                        ccd.inventory_item_id,
                                        -- Revision for version 1.25, change decimal precision from 5 to 9
                                        round(sum(nvl(ccd.cmpnt_cost,0)),9) item_cost
                                 from   cm_cmpt_dtl ccd,
                                        cm_cmpt_mst_b ccm,
                                        cm_mthd_mst cmm,
                                        gmf_period_statuses gps,
                                        gmf_calendar_assignments gca,
                                        mtl_system_items_vl msiv,
                                        inv_organizations mp
                                 where  ccd.cost_cmpntcls_id            = ccm.cost_cmpntcls_id
                                 and    ccm.product_cost_ind            = 1 -- Yes
                                 and    ccd.cost_type_id                = cmm.cost_type_id
                                 -- Revision for version 1.28, can't use ccd.calendar_code
                                 -- and    ccd.calendar_code               = gca.calendar_code
                                 and    ccd.period_id                   = gps.period_id
                                 -- End revision for version 1.28
                                 -- Revision for version 1.35
                                 -- and    ccd.organization_id             = mp.organization_id
                                 -- and    ccd.organization_id             = msiv.organization_id
                                 and    ccd.organization_id             = mp.cost_organization_id
                                 and    mp.organization_id              = msiv.organization_id
                                 -- End revision for version 1.35
                                 and    ccd.inventory_item_id           = msiv.inventory_item_id
                                 -- Revision for version 1.28
                                 and    ccd.delete_mark                 = 0
                                 -- Revision for version 1.23
                                 and    mp.organization_id              = msiv.organization_id
                                 and    msiv.inventory_asset_flag       = 'Y'
                                 and    mp.process_enabled_flag         = 'Y'
                                 and    nvl(:p_show_opm_inventory, 'N') = 'Y'
                                 and    gps.cost_type_id                = ccd.cost_type_id
                                 and    gps.cost_type_id                = gca.cost_type_id
                                 and    gps.legal_entity_id             = gca.legal_entity_id
                                 and    gps.legal_entity_id             = mp.legal_entity_id
                                 and    gps.calendar_code               = gca.calendar_code
                                 and    :p_cost_type is not null        -- p_cost_type
                                 and    cmm.cost_mthd_code              = upper(:p_cost_type)
                                 and    6=6                             -- p_item_number
                                 and    7=7                             -- p_calendar_code
                                 -- Revision for version 1.31
                                 and    8=8                             -- p_period_code
                                 group by 
                                        ccd.organization_id,
                                        ccd.inventory_item_id
                                ) itr_costs,
                                (-- ============================================================
                                 -- Get the intransit related shipment and receipt transactions.
                                 -- As the Cost Update does not revalue OPM transactions, get
                                 -- the item costs from transactions.  If the GXEH transactions
                                 -- do not exist use then use OPM item costs.  If a Cost Type has
                                 -- been entered, instead, get the item costs from the Cost Type.
                                 -- ============================================================
                                 -- Part IV.E.2
                                 -- Get the intransit related shipment transactions.
                                 -- ============================================================
                                 select decode(mmt.fob_point,
                                                1, decode(mmt.transaction_action_id,
                                                                21, mmt.transfer_organization_id,
                                                                15, mmt.organization_id),
                                                2, mmt.organization_id) organization_id,
                                        decode(mmt.fob_point,
                                                1, decode(mmt.transaction_action_id,
                                                                21, mmt.organization_id,
                                                                15, mmt.transfer_organization_id),
                                                2, mmt.transfer_organization_id) from_organization_id,
                                        mmt.inventory_item_id inventory_item_id,
                                        'Intransit' subinventory_code,
                                        1 asset_inventory,
                                        -- Revision for version 1.32 and 1.34
                                        mp.intransit_inv_account,
                                        0 onhand_quantity,
                                        sum(decode(mmt.fob_point,
                                                -- invert the sign for quantities going into intransit
                                                1, inv_convert.inv_um_convert(mmt.inventory_item_id,
                                                                null, decode(mmt.transaction_action_id,
                                                                        21, -1 * mmt.primary_quantity,
                                                                        mmt.primary_quantity),
                                                                mmt.transaction_uom, msi_to.primary_uom_code, null, null),
                                                2, -1 * mmt.primary_quantity)) intransit_quantity,
                                        mmt.transaction_id,
                                        -- ====================================================================
                                        -- Either get the OPM intransit costs based on the original transactions,
                                        -- or if the Accounting Preprocessor has not been run, get the item costs
                                        -- from the latest OPM item cost details.  As the OPM Cost Update does
                                        -- not revalue Intransit, you have to value Intransit based on the 
                                        -- transactions from the Accounting Preprocessor or based on what the
                                        -- the Accounting Preprocessor values will be once it is run.  The
                                        -- Accounting Preprocessor gets its costs from the gl_item_cst and
                                        -- gl_item_dtl tables.  And in either case, these transactions will be
                                        -- valued by Cost Element, as derived by the Cost Component Group from
                                        -- table cm_cmpt_mst_b.
                                        -- ====================================================================
                                        nvl(decode(mmt.fob_point,
                                                -- Revision for version 1.29, ORA-01427: single-row subquery returns more than one row
                                                -- 1, (select 'Y'
                                                1, (select distinct 'Y'
                                                    from   gmf_xla_extract_headers gxeh
                                                    -- For FOB = 1, the parent Intransit Shipment transaction creates a
                                                    -- child logical transaction for the receipt into Intransit and this
                                                    -- child transaction has transaction_action_id = 15 and joins to gxeh
                                                    where  gxeh.transaction_id =
                                                                    (select mmt_child.transaction_id
                                                                     from   mtl_material_transactions mmt_child
                                                                     where  mmt_child.parent_transaction_id = mmt.transaction_id)),
                                                -- Revision for version 1.29, ORA-01427: single-row subquery returns more than one row
                                                -- 2, (select 'Y'
                                                2, (select distinct 'Y'
                                                    from   gmf_xla_extract_headers gxeh
                                                    -- For FOB = 2 use the Intransit Shipment material transaction directly
                                                    where  gxeh.transaction_id = mmt.transaction_id)),
                                               'N') opm_processed_flag,
                                        decode(mmt.fob_point,
                                                1, nvl((select  sum(nvl(gxel.component_cost, 0)) * 
                                                                inv_convert.inv_um_convert(mmt.inventory_item_id,
                                                                        null, decode(mmt.transaction_action_id,
                                                                                        21, -1 * mmt.primary_quantity,
                                                                                        mmt.primary_quantity),
                                                                mmt.transaction_uom, msi_to.primary_uom_code, null, null)
                                                        from    gmf_xla_extract_headers gxeh,
                                                                gmf_xla_extract_lines gxel,
                                                                gmf_fiscal_policies gfp
                                                        where   gxeh.transaction_id =
                                                                -- For FOB = 1, the parent Intransit Shipment transaction creates a
                                                                -- child logical transaction for the receipt into Intransit and this
                                                                -- child transaction has transaction_action_id = 15 and joins to gxeh
                                                                (select   mmt_child.transaction_id
                                                                 from     mtl_material_transactions mmt_child
                                                                 where    mmt_child.parent_transaction_id = mmt.transaction_id)
                                                        and     gxeh.header_id                  = gxel.header_id
                                                        and     gxel.journal_line_type          = 'ITR'
                                                        and     gfp.legal_entity_id             = gxeh.legal_entity_id
                                                        and     gfp.cost_type_id                =  gxeh.valuation_cost_type_id), 0),
                                                2, nvl((select  sum(nvl(gxel.component_cost,0)) * -1 * mmt.primary_quantity
                                                        from    gmf_xla_extract_headers gxeh,
                                                                gmf_xla_extract_lines gxel,
                                                                gmf_fiscal_policies gfp
                                                        -- for fob = 2 use the intransit shipment material transaction directly
                                                        where   gxeh.transaction_id             = mmt.transaction_id
                                                        and     gxeh.header_id                  = gxel.header_id
                                                        and     gxel.journal_line_type          = 'ITR'
                                                        and     gfp.legal_entity_id             = gxeh.legal_entity_id
                                                        and     gfp.cost_type_id                = gxeh.valuation_cost_type_id), 0)) itr_intransit_value
                                 from   mtl_material_transactions mmt,
                                        mtl_system_items_vl msi_to,
                                        inv_organizations mp,
                                        org_acct_periods oap
                                 -- ======================================================================================
                                 -- Standard Oracle package CSTVIVTB.pls only uses 12 and 21 transaction_action_id's for
                                 -- calculating intransit quantity, commenting out mmt.transaction_action_id 15. Transaction
                                 -- 15 is for Logical Receipts, spawned from the initial transaction_action_id 12.  If
                                 -- include both 12 and 15 transaction_action_id the code would double-count intransit.
                                 -- Note:  as of Release 12.2.13, OPM does not use IR/ISO returns, so no need to look
                                 --        at transaction types 401 (Internal RMA Receipt) and 402 (Return to Shipping Org). 
                                 -- ======================================================================================
                                 where  mmt.transaction_action_id       = 21
                                 -- cannot use as of date, need to use period schedule_close_date
                                 and    mmt.transaction_date           <  (oap.schedule_close_date + 1)
                                 and    4=4                              -- p_period_name
                                 -- added this condition to use a mmt index on acct_period_id and organization_id
                                 and    mp.organization_id              = oap.organization_id
                                 -- Revision for version 1.30
                                 -- and    msi_to.organization_id          = decode(mmt.transaction_action_id,
                                 --                                                21, mmt.transfer_organization_id,
                                 --                                                15, mmt.organization_id)
                                 and    msi_to.organization_id          = decode(mmt.fob_point,
                                                                                 1, decode(mmt.transaction_action_id,
                                                                                           21, mmt.transfer_organization_id,
                                                                                           15, mmt.organization_id),
                                                                                 2, mmt.organization_id)
                                 -- End revision to version 1.30
                                 and    msi_to.inventory_item_id        = mmt.inventory_item_id
                                 -- Revision for version 1.33
                                 -- Find the earliest date to start with, assume two years max in Intransit.
                                 -- Get the Intransit Shipments up to two years ago, based upon the oap.period_start_date.
                                 -- Cannot depend on mtl_supply, the items and quantities needed might not be present in a prior period.
                                 and    mmt.transaction_date           >= oap.period_start_date - 730
                                 and    msi_to.organization_id          = mp.organization_id
                                 and    mp.process_enabled_flag         = 'Y'
                                 -- End revision for version 1.33
                                 group by
                                        decode(mmt.fob_point,
                                                        1, decode(mmt.transaction_action_id,
                                                                        21, mmt.transfer_organization_id,
                                                                        15, mmt.organization_id),
                                                        2, mmt.organization_id),
                                       decode(mmt.fob_point,
                                                        1, decode(mmt.transaction_action_id,
                                                                        21, mmt.organization_id,
                                                                        15, mmt.transfer_organization_id),
                                                        2, mmt.transfer_organization_id),
                                       mmt.inventory_item_id,
                                       'Intransit',
                                       1,                    -- Asset Inventory
                                        -- Revision for version 1.32 and 1.34
                                       mp.intransit_inv_account,
                                       mmt.transaction_id,
                                       0,
                                       mmt.fob_point,
                                       mmt.transaction_action_id,
                                       mmt.primary_quantity,
                                       mmt.transaction_uom,
                                       msi_to.primary_uom_code,
                                       mmt.organization_id,
                                       -- needed for inline opm cost query
                                       mmt.parent_transaction_id
                                 union all
                                 -- ==============================================================
                                 -- Part IV.E.3
                                 -- Get the intransit related receipt transactions coming
                                 -- into the organization, for both costed and uncosted transactions
                                 -- Get the Process Costs from Preprocessor Accounting transactions.
                                 -- Remove joins to MIP, as rows from the shipment network may have
                                 -- been deleted which caused earlier versions of this code to fail.
                                 -- ==============================================================
                                 select decode(mmt.fob_point,
                                                1, mmt.organization_id,
                                                2, decode(mmt.transaction_action_id,
                                                                12, mmt.transfer_organization_id,
                                                                22, mmt.organization_id)) organization_id,
                                        decode(mmt.fob_point,
                                                1, decode(mmt.transaction_action_id,
                                                                12, mmt.transfer_organization_id,
                                                                22, mmt.organization_id),
                                                2, mmt.organization_id) from_organization_id,
                                        mmt.inventory_item_id inventory_item_id,
                                        'Intransit' subinventory_code,
                                        1 asset_inventory,
                                        -- Revision for version 1.32 and 1.34
                                        mp.intransit_inv_account,
                                        0 onhand_quantity,
                                        sum(decode(mmt.fob_point,
                                        -- For FOB 1 and 2 (1 = title owned at shipment), need to invert the SIGN of the quantity, as
                                        -- txn action 12 has a positive value, therefore need to multiple by -1, decreasing the
                                        -- shipments/balance in Intransit.  Txn action 22 has a negative value, so you
                                        -- do not need to invert the SIGN to reduce the receipts taken away from the intransit balance
                                                1, decode(mmt.transaction_action_id,
                                                                12, -1 * mmt.primary_quantity,
                                                                mmt.primary_quantity),
                                                2, inv_convert.inv_um_convert(mmt.inventory_item_id,
                                                                null, decode(mmt.transaction_action_id,
                                                                                        12, -1 * mmt.primary_quantity,
                                                                                        mmt.primary_quantity),
                                                                mmt.transaction_uom, msi_from.primary_uom_code, null, null))) intransit_quantity,
                                        mmt.transaction_id transaction_id,
                                        -- ====================================================================
                                        -- Either get the OPM intransit costs by Cost Element based on the original
                                        -- transactions,  or, if the Accounting Preprocessor has not been run,
                                        -- get the item costs from the latest OPM item cost details.  As the OPM
                                        -- Cost Update does not revalue Intransit, you have to value Intransit
                                        -- based on the transactions from the Accounting Preprocessor, or, based
                                        -- on what the Accounting Preprocessor values will be once it is run.
                                        -- Accounting Preprocessor gets its costs from the GL_ITEM_CST and
                                        -- GL_ITEM_DTL tables.  And in either case, these transactions will be
                                        -- valued by Cost Element, as derived by the Cost Component Group from
                                        -- table cm_cmpt_mst_b.
                                        -- ====================================================================
                                        nvl(decode(mmt.fob_point,
                                                -- Revision for version 1.29, ORA-01427: single-row subquery returns more than one row
                                                -- 1, (select 'Y'
                                                1, (select distinct 'Y'
                                                    from   gmf_xla_extract_headers gxeh
                                                    -- For FOB = 1, the parent Intransit Shipment transaction creates a
                                                    -- child logical transaction for the receipt into Intransit and this
                                                    -- child transaction has transaction_action_id = 15 and joins to gxeh
                                                    where  gxeh.transaction_id =
                                                                    (select mmt_child.transaction_id
                                                                     from   mtl_material_transactions mmt_child
                                                                     where  mmt_child.parent_transaction_id = mmt.transaction_id)),
                                                -- Revision for version 1.29, ORA-01427: single-row subquery returns more than one row
                                                -- 2, (select 'Y'
                                                2, (select distinct 'Y'
                                                    from  gmf_xla_extract_headers gxeh
                                                    -- For FOB = 2 use the Intransit Shipment material transaction directly
                                                    where gxeh.transaction_id = mmt.transaction_id)),
                                               'N') opm_processed_flag,
                                        sum(decode(mmt.fob_point,
                                        -- For FOB 1 and 2 (1 = title owned at shipment), need to invert the SIGN of the quantity, as
                                        -- txn action 12 has a positive value, therefore need to multiple by -1, decreasing the
                                        -- shipments/balance in Intransit.  Txn action 22 has a negative value, so you
                                        -- do not need to invert the SIGN to reduce the receipts taken away from the intransit balance
                                                1, decode(mmt.transaction_action_id,
                                                                12, -1 * mmt.primary_quantity,
                                                                mmt.primary_quantity),
                                                2, inv_convert.inv_um_convert(mmt.inventory_item_id,
                                                                null, decode(mmt.transaction_action_id,
                                                                                        12, -1 * mmt.primary_quantity,
                                                                                        mmt.primary_quantity),
                                                                mmt.transaction_uom, msi_from.primary_uom_code, null, null)))
                                             * -- For Intransit Receipts FOB Point does not change the OPM Cost Joins
                                                nvl((select     sum(nvl(gxel.component_cost, 0))
                                                     from       gmf_xla_extract_headers gxeh,
                                                                gmf_xla_extract_lines gxel,
                                                                gmf_fiscal_policies gfp
                                                     where      gxeh.transaction_id          = mmt.transaction_id
                                                     and        gxeh.header_id               = gxel.header_id
                                                     and        gxel.journal_line_type       = 'ITR'
                                                     and        gfp.legal_entity_id          = gxeh.legal_entity_id
                                                     and        gfp.cost_type_id             = gxeh.valuation_cost_type_id), 0) itr_intransit_value
                                 from   mtl_material_transactions mmt,
                                        mtl_system_items_vl msi_from,
                                        inv_organizations mp,
                                        org_acct_periods oap
                                 -- Removed mmt.transaction_action_id = 22 as it was double-counting intransit quantities for Process Orgs
                                 where  mmt.transaction_action_id       = 12
                                 -- Cannot use As of Date, need to use period schedule_close_date
                                 and    mmt.transaction_date           < (oap.schedule_close_date + 1)
                                 and    4=4                             -- p_period_name
                                 -- added this condition to use a mmt index on acct_period_id and organization_id
                                 and    mp.organization_id              = oap.organization_id
                                 and    msi_from.organization_id        = mmt.transfer_organization_id
                                 and    msi_from.inventory_item_id      = mmt.inventory_item_id
                                 and    decode(mmt.fob_point,
                                                1, mmt.organization_id,
                                                2, decode(mmt.transaction_action_id,
                                                              12, mmt.transfer_organization_id,
                                                              22, mmt.organization_id)) = mp.organization_id -- owning organization_id
                                 and    mp.process_enabled_flag         = 'Y'
                                 and    nvl(:p_show_opm_inventory, 'N') = 'Y'
                                 -- Revision for version 1.33
                                 -- Find the earliest date to start with, assume two years max in Intransit.
                                 -- Get the Intransit Receipts based upon the Intransit Shipments up to two years ago.
                                 and    mmt.transfer_transaction_id in 
                                                               -- Get the Intransit Shipments up to two years ago
                                                               (select  mmt2.transaction_id
                                                                from    mtl_material_transactions mmt2
                                                                where   mmt2.transaction_action_id = 21 -- Intransit Shipments
                                                                and     mmt2.transaction_id        = mmt.transfer_transaction_id
                                                                and     mmt2.transaction_date     <  (oap.schedule_close_date + 1)
                                                                and     mmt2.transaction_date     >= oap.period_start_date - 730
                                                                and     decode(mmt2.fob_point,
                                                                                 1, decode(mmt2.transaction_action_id,
                                                                                           21, mmt2.transfer_organization_id,
                                                                                           15, mmt2.organization_id),
                                                                                 2, mmt2.organization_id) = mp.organization_id
                                                               )
                                 -- End revision for version 1.33
                                 group by 
                                        decode(mmt.fob_point,
                                                1, mmt.organization_id,
                                                2, decode(mmt.transaction_action_id,
                                                                12, mmt.transfer_organization_id,
                                                                22, mmt.organization_id)),
                                        decode(mmt.fob_point,
                                                1, decode(mmt.transaction_action_id,
                                                                12, mmt.transfer_organization_id,
                                                                22, mmt.organization_id),
                                                2, mmt.organization_id),
                                        mmt.inventory_item_id,
                                        'Intransit',
                                        1,                   -- asset_inventory
                                        -- Revision for version 1.32 and 1.34
                                        mp.intransit_inv_account,
                                        0,
                                        mmt.transaction_id,
                                        mmt.fob_point,
                                        mmt.transaction_action_id,
                                        mmt.primary_quantity,
                                        mmt.transaction_uom,
                                        msi_from.primary_uom_code,
                                        mmt.organization_id
                                ) itr_txn
                       -- Revision for version 1.28, outer join to item costs
                       where    itr_txn.organization_id   = itr_costs.organization_id(+)
                       and      itr_txn.inventory_item_id = itr_costs.inventory_item_id(+)
                       -- Revision for version 1.32
                       and      mip.to_organization_id (+) = itr_txn.organization_id
                       and      mip.from_organization_id (+) = itr_txn.from_organization_id
                       -- End revision for version 1.32
                       group by
                             itr_txn.organization_id,
                             itr_txn.from_organization_id,
                             itr_txn.inventory_item_id,
                             itr_txn.subinventory_code,
                             itr_txn.asset_inventory,
                             -- Revision for version 1.32 and 1.34
                             -- itr_txn.code_combination_id,
                             nvl(mip.intransit_inv_account, itr_txn.intransit_inv_account), -- code_combination_id
                             0,
                             decode(itr_txn.subinventory_code,'Intransit', itr_txn.intransit_quantity, 0),
                             itr_txn.transaction_id,
                             itr_txn.opm_processed_flag
                     ) allqty
         group by
                allqty.organization_id,
                allqty.from_organization_id,
                allqty.inventory_item_id,
                allqty.subinventory_code,
                allqty.asset_inventory,
                allqty.code_combination_id
         -- Revision for version 1.30, remove 0 quantity rows
         having sum(allqty.intransit_quantity) <> 0
        ) onhand
where   oap.organization_id             = mp.organization_id
and     mp.organization_id              = msiv.organization_id
and     msiv.organization_id            = onhand.organization_id
and     msiv.inventory_item_id          = onhand.inventory_item_id
and     msiv.inventory_asset_flag       = 'Y'
-- Revision for version 1.30
and     muomv.uom_code                  = msiv.primary_uom_code
and     msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.30
-- ===========================================
-- For Lookup Codes
-- ===========================================
and     fcl.lookup_code (+)             = msiv.item_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                 = msiv.planning_make_buy_code
-- Revision for version 1.30
-- and     ml2.lookup_code                 = nvl(msub.asset_inventory,1)
and     ml2.lookup_code                 = 1 -- Yes
-- End revision for version 1.30
and     ml2.lookup_type                 = 'SYS_YES_NO'
and     ml3.lookup_code                 = 3 -- Intransit
and     ml3.lookup_type                 = 'MSC_CALENDAR_TYPE'
and     ml4.lookup_type                 = 'CST_UPDATE_TXN_TYPE'
and     ml4.lookup_code                 = 2 -- Intransit Inventory
-- ===========================================
-- For OPM to be enabled
-- ===========================================
and     mp.process_enabled_flag         = 'Y'
-- ===========================================
-- Accounting code combination joins
-- ===========================================
-- Revision for version 1.27
-- and     mp.material_account             = gcc.code_combination_id
-- Revision for version 1.32
-- and     va.material_account             = gcc.code_combination_id (+)
-- and     va.valuation_type               = 'Intransit Accounting'
-- and     va.secondary_inventory_name     = 'Intransit'
-- and     va.organization_id              = mp.organization_id
-- End revision for version 1.27 and 1.32
and     gcc.code_combination_id (+)     = onhand.code_combination_id
and     4=4                             -- p_period_name
and     6=6                             -- p_item_number
group by
        mp.ledger,
        mp.operating_unit,
        mp.organization_code,
        oap.period_name,
&segment_columns_grp
        msiv.concatenated_segments,
        msiv.description,
        fcl.meaning, -- Item Type
        misv.inventory_item_status_code_tl,
        ml1.meaning, -- Make Buy Code
        mp.currency_code,
        -- Revision for version 1.25, change decimal precision from 5 to 9
        round(onhand.itr_item_cost, 9),
        ml3.meaning, -- Subinventory or Intransit
        ml4.meaning, -- Subinventory Description
        muomv.uom_code,
        ml2.meaning, -- Asset
        -- For inline selects
        onhand.inventory_item_id,
        onhand.organization_id
order by 1,2,3,5,6,7,8,9,10,11,12,20