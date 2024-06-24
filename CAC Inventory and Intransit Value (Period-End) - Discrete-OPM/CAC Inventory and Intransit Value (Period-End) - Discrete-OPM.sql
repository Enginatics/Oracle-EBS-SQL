/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory and Intransit Value (Period-End) - Discrete/OPM
-- Description: Report showing amount of inventory at the end of the month for both Discrete and Process Manufacturing (OPM) inventory organizations.  If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.  In either case this report uses the month-end quantities, based on the entered period name (and calendar code and period code for OPM).  And as these quantities come from the month-end snapshot (created when you close the inventory accounting period or run the GMF Period Close Process) this snapshot is only by inventory organization, subinventory and item and not split out by cost element.  And to be consistent with DIscrete and OPM reporting, this report uses the Material Account, based upon your Costing Method and valuation options (Cost Group/Average, Subinventory/Standard, Cost Group/PJM, Cost Group/WMS, or Category Accounts).

Note:  if you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.

Discrete and OPM Parameters:
============================
Period Name (Closed):  the closed inventory accounting period you wish to report (mandatory).
Cost Type:  enter a Cost Type to value the quantities using the Cost Type item costs; or, if Cost Type is not entered the report will use the stored month-end snapshot values.
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  The second item category set to report, typically the Inventory Category Set (optional).
Item Number:  specific buy or make item you wish to report (optional).
Subinventory:  specific area within the warehouse or inventory area you wish to report (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional).
Ledger:  specific ledger (optional).

OPM Parameters:
==============
Show OPM Inventory:  Choose Yes to report OPM inventory month-end balances, choose No to ignore OPM inventory organizations (mandatory).
OPM Calendar Code:  Choose the OPM Calendar Code which corresponds to the inventory accounting period you wish to report (mandatory for reporting OPM results).
OPM Period Code:  enter the OPM Period Code related to the inventory accounting period and OPM Calendar Code you wish to report (mandatory for reporting OPM results).

-- | ===================================================================
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     27 Sep 2009 Douglas Volz Initial Coding
-- | 1.1     28 Sep 2009 Douglas Volz Added a sum for the ICP costs from cicd
-- | 1.24    02 Apr 2024 Douglas Volz Add Period Code parameter to prevent cross-joining with gmf_period_statuses.
-- | 1.25    23 Apr 2024 Douglas Volz To avoid rounding errors, change OPM item cost rounding from 5 to 8 decimals.
-- | 1.26    14 May 2024 Douglas Volz Remove lot number parameters and columns.
-- | 1.27    15 May 2024 Douglas Volz Fix for OPM intransit accounts.
-- | 1.28    27 May 2024 Douglas Volz Fix for OPM Calendar Code, OPM Period Code and OPM Cost Type parameters.
-- |                                  Check for OPM delete_mark (where the information is no longer shown).
-- |                                  Fix OPM Period Code and Cost Type parameters, remove duplicates.
-- | 1.29    04 Jun 2024 Douglas Volz Fix SQL error for Intransit code section, due to duplicate transactions in GXEH
-- |                                  (ORA-01427: single-row subquery returns more than one row).
-- | 1.30    09 Jun 2024 Douglas Volz Fix Intransit joins for UOMs, organizations and for duplicate Intransit quantities.
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
                mca.organization_id category_organization_id,
                -- Revision for version 1.18
                mca.category_set_id, 
                mp.material_account,
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
                mca.organization_id, -- category_organization_id
                -- Revision for version 1.18
                mca.category_set_id,
                mp.material_account,
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
         union all
         -- Revision for version 1.27
         -- Process Costing
         select 'Process Costing' valuation_type,
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
         -- Get process organizations
         and    nvl(mp.process_enabled_flag, 'N') = 'Y'
         and    3=3                             -- p_subinventory
         -- End revision for version 1.27
        )
-- End revision for version 1.17

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
                        null, roun