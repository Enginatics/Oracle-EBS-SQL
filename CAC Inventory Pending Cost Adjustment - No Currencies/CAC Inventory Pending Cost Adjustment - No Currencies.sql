/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Pending Cost Adjustment - No Currencies
-- Description: Report showing the potential standard cost changes for onhand and intransit inventory value which you own.  If you enter a period name this report uses the quantities from the month-end snapshot; if you leave the period name blank it uses the real-time quantities.  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); and the To Currency Code and the Organization Code default from the organization code set for this session.  Unlike the CAC Inventory Pending Cost Adjustment report, this version does not display any cost differences due to changes in foreign currency rates (FX).  If you want to see the impact of FX changes, please use the CAC Inventory Pending Cost Adjustment report.

If using this report for reporting after the standard cost update has run this report requires both the before and after cost types available for reporting purposes.  Using the item cost copy please save your Frozen costs before running the standard cost update.

Parameters:
===========
Period Name (Closed):  to use the month-end quantities, choose a closed inventory accounting period (optional).
Cost Type (New):  enter the Cost Type that has the revised or new item costs (mandatory).
Cost Type (Old):  enter the Cost Type that has the existing or current item costs, defaults to the Frozen Cost Type (mandatory).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  The second item category set to report, typically the Inventory Category Set (optional).
Only Items in New Cost Type:  enter Yes to only report the items in the New Cost Type.  Specify No if you want to use this report to reconcile overall inventory value (mandatory).
Include Items With No Quantities:  enter Yes to report items that do not have onhand quantities (mandatory).
Include Zero Item Cost Differences:  enter Yes to include items with a zero item cost difference (mandatory).
Item Number:  specific buy or make item you wish to report (optional).
Organization Code:  enter the inventory organization(s) you wish to report, defaults to your session's inventory organization (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2008-2023 Douglas Volz Consulting, Inc
-- |  All rights reserved
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_std_cost_pending_adj_rept.sql
-- | 
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 21 Nov 2010 Douglas Volz   Created initial Report for prior client
-- |     1.11 05 Jun 2022 Douglas Volz   Fix for category accounts (valuation accounts) and
-- |                                     added subinventory description.
-- |     1.12 23 Sep 2023 Douglas Volz   Add parameter to not include zero item cost differences,
-- |                                     removed tabs and added org access controls.
-- |     1.13 09 Nov 2023 Douglas Volz   Add item master and costing lot sizes, use default controls, 
-- |                                     based on rollup and shrinkage rate columns
-- |     1.14 04 Dec 2023 Douglas Volz   Added G/L and Operating Unit security restrictions.
-- +=============================================================================+*/


-- Excel Examle Output: https://www.enginatics.com/example/cac-inventory-pending-cost-adjustment-no-currencies/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-pending-cost-adjustment-no-currencies/
-- Run Report: https://demo.enginatics.com/

with inv_organizations as
-- Revision for version 1.11
-- Get the list of organizations
        (select nvl(gl.short_name, gl.name) ledger,
                gl.ledger_id,
                haou2.name operating_unit,
                haou2.organization_id operating_unit_id,
                mp.organization_code,
                haou.name organization_name,
                mp.organization_id,
                mca.organization_id category_organization_id,
                -- Revision for version 1.18
                mca.category_set_id, 
                mp.material_account,
                mp.cost_group_accounting,
                mp.primary_cost_method,
                mp.default_cost_group_id,
                haou.date_to disable_date,
                -- Revision for version 1.11
                gl.currency_code
         from   mtl_category_accounts mca,
                mtl_parameters mp,
                hr_organization_information hoi,
                hr_all_organization_units_vl haou, -- inv_organization_id
                hr_all_organization_units_vl haou2, -- operating unit
                gl_ledgers gl
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
         -- Revision for version 1.14
         and    gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
         and    haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
         -- End revision for version 1.14
         and    1=1                             -- p_operating_unit, p_ledger
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    9=9                             -- p_org_code
         group by
                nvl(gl.short_name, gl.name),
                gl.ledger_id,
                haou2.name, -- operating_unit
                haou2.organization_id, -- operating_unit_id
                mp.organization_code,
                haou.name, -- organization_name
                mp.organization_id,
                mca.organization_id, -- category_organization_id
                -- Revision for version 1.18
                mca.category_set_id,
                mp.material_account,
                mp.cost_group_accounting,
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
         and    3=3                             -- p_subinventory
         union all
         -- Not Standard Costing, no Cost Group Accounting
         select 'Not Std Cost No Cost Group Accounting' valuation_type,
                msub.organization_id,
                msub.secondary_inventory_name,
                null category_id,
                null category_set_id,
                mp.material_account,
                msub.asset_inventory,
                msub.quantity_tracked,
                msub.default_cost_group_id cost_group_id
         from   mtl_secondary_inventories msub,
                inv_organizations mp
         where  msub.organization_id = mp.organization_id
         and    nvl(mp.cost_group_accounting,2) = 2 -- No
         and    mp.primary_cost_method         <> 1 -- not Standard Costing
         -- Avoid organizations with category accounts
         and    mp.category_organization_id is null
         and    3=3                             -- p_subinventory
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
         and    ccga.cost_group_id              = nvl(msub.default_cost_group_id, mp.default_cost_group_id)
         and    ccga.cost_group_id              = ccg.cost_group_id
         and    ccga.organization_id            = mp.organization_id
         -- Avoid organizations with category accounts
         and    mp.category_organization_id is null
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
-- End revision for version 1.11

----------------main query starts here--------------

-- ====================================================
-- Select operating unit and organization information
-- ====================================================

-- Revision for version 1.11
select  mp.ledger                                                        Ledger,
        mp.operating_unit                                                Operating_Unit,
        mp.organization_code                                             Org_Code,
        mp.organization_name                                             Organization_Name,
-- End revision for version 1.11
        :p_period_name                                                   Period_Name,
        &segment_columns
        msiv.concatenated_segments                                       Item_Number,
        msiv.description                                                 Item_Description,
        fcl.meaning                                                      Item_Type,
        -- Revision for version 1.7
        misv.inventory_item_status_code_tl                               Item_Status,
        ml1.meaning                                                      Make_Buy_Code,
        -- Revision for version 1.13
        msiv.std_lot_size                                                Std_Lot_Size,
        -- Revision for version 1.5
&category_columns
        -- Revision for version 1.13
        ml2.meaning                                                      Use_Default_Controls,
        ml3.meaning                                                      Based_on_Rollup,
        cic1.lot_size                                                    Costing_Lot_Size,
        cic1.shrinkage_rate                                              Shrinkage_Rate,
        -- End revision for version 1.13
        -- Revision for version 1.11
        mp.currency_code                                                 Currency_Code,
-- ==========================================================
-- Select the new and old item costs from Cost Type 1 and 2
-- ==========================================================
        round(nvl(cic1.material_cost,0),5)                               New_Material_Cost,
        round(nvl(cic2.material_cost,0),5)                               Old_Material_Cost,
        round(nvl(cic1.material_cost,0),5) - round(nvl(cic2.material_cost,0),5) Material_Cost_Diff,
        case
          when round((nvl(cic1.material_cost,0) - nvl(cic2.material_cost,0)),5) = 0 then 0
          when round((nvl(cic1.material_cost,0) - nvl(cic2.material_cost,0)),5) = round(nvl(cic1.material_cost,0),5) then  100
          when round((nvl(cic1.material_cost,0) - nvl(cic2.material_cost,0)),5) = round(nvl(cic2.material_cost,0),5) then -100
          else round((nvl(cic1.material_cost,0) - nvl(cic2.material_cost,0)) / nvl(cic2.material_cost,0) * 100,1)
        end                                                              Material_Percent_Diff,
        round(nvl(cic1.material_overhead_cost,0),5)                      New_Material_Overhead_Cost,
        round(nvl(cic2.material_overhead_cost,0),5)                      Old_Material_Overhead_Cost,
        round(nvl(cic1.material_overhead_cost,0),5) - round(nvl(cic2.material_overhead_cost,0),5) Material_Overhead_Cost_Diff,
        case
          when round((nvl(cic1.material_overhead_cost,0) - nvl(cic2.material_overhead_cost,0)),5) = 0 then 0
          when round((nvl(cic1.material_overhead_cost,0) - nvl(cic2.material_overhead_cost,0)),5) = round(nvl(cic1.material_overhead_cost,0),5) then  100
          when round((nvl(cic1.material_overhead_cost,0) - nvl(cic2.material_overhead_cost,0)),5) = round(nvl(cic2.material_overhead_cost,0),5) then -100
          else round((nvl(cic1.material_overhead_cost,0) - nvl(cic2.material_overhead_cost,0)) / nvl(cic2.material_overhead_cost,0) * 100,1)
        end                                                              Material_Ovhd_Percent_Diff,
        round(nvl(cic1.resource_cost,0),5)                               New_Resource_Cost,
        round(nvl(cic2.resource_cost,0),5)                               Old_Resource_Cost,
        round(nvl(cic1.resource_cost,0),5) - round(nvl(cic2.resource_cost,0),5) Resource_Cost_Diff,
        case
          when round((nvl(cic1.resource_cost,0) - nvl(cic2.resource_cost,0)),5) = 0 then 0
          when round((nvl(cic1.resource_cost,0) - nvl(cic2.resource_cost,0)),5) = round(nvl(cic1.resource_cost,0),5) then  100
          when round((nvl(cic1.resource_cost,0) - nvl(cic2.resource_cost,0)),5) = round(nvl(cic2.resource_cost,0),5) then -100
          else round((nvl(cic1.resource_cost,0) - nvl(cic2.resource_cost,0)) / nvl(cic2.resource_cost,0) * 100,1)
        end                                                              Resource_Percent_Diff,
        round(nvl(cic1.outside_processing_cost,0),5)                     New_Outside_Processing_Cost,
        round(nvl(cic2.outside_processing_cost,0),5)                     Old_Outside_Processing_Cost,
        round(nvl(cic1.outside_processing_cost,0),5) - round(nvl(cic2.outside_processing_cost,0),5) OSP_Cost_Diff,
        case
          when round((nvl(cic1.outside_processing_cost,0) - nvl(cic2.outside_processing_cost,0)),5) = 0 then 0
          when round((nvl(cic1.outside_processing_cost,0) - nvl(cic2.outside_processing_cost,0)),5) = round(nvl(cic1.outside_processing_cost,0),5) then  100
          when round((nvl(cic1.outside_processing_cost,0) - nvl(cic2.outside_processing_cost,0)),5) = round(nvl(cic2.outside_processing_cost,0),5) then -100
          else round((nvl(cic1.outside_processing_cost,0) - nvl(cic2.outside_processing_cost,0)) / nvl(cic2.outside_processing_cost,0) * 100,1)
        end                                                              OSP_Percent_Diff,
        round(nvl(cic1.overhead_cost,0),5)                               New_Overhead_Cost,
        round(nvl(cic2.overhead_cost,0),5)                               Old_Overhead_Cost,
        round(nvl(cic1.overhead_cost,0),5) - round(nvl(cic2.overhead_cost,0),5) Overhead_Cost_Diff,
        case
          when round((nvl(cic1.overhead_cost,0) - nvl(cic2.overhead_cost,0)),5) = 0 then 0
          when round((nvl(cic1.overhead_cost,0) - nvl(cic2.overhead_cost,0)),5) = round(nvl(cic1.overhead_cost,0),5) then  100
          when round((nvl(cic1.overhead_cost,0) - nvl(cic2.overhead_cost,0)),5) = round(nvl(cic2.overhead_cost,0),5) then -100
          else round((nvl(cic1.overhead_cost,0) - nvl(cic2.overhead_cost,0)) / nvl(cic2.overhead_cost,0) * 100,1)
        end                                                              Overhead_Percent_Diff,
        round(nvl(cic1.item_cost,0),5)                                   New_Item_Cost,
        round(nvl(cic2.item_cost,0),5)                                   Old_Item_Cost,
-- ========================================================
-- Select the item costs from Cost Type 1 and 2 and compare
-- ========================================================
        round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5)  Item_Cost_Difference,
        -- Revision for version 1.9
        -- round((nvl(cic1.item_cost,0) -nvl(cic2.item_cost,0))
        --     /
         -- (decode(nvl(cic2.item_cost,0),0,1,cic2.item_cost)) * 100,1)  Percent_Difference,
        case
          when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = 0 then 0
          when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic1.item_cost,0),5) then  100
          when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic2.item_cost,0),5) then -100
          else round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) / nvl(cic2.item_cost,0) * 100,1)
        end                                                              Percent_Difference,
        -- End revision for version 1.9
-- ===========================================================
-- Select the onhand and intransit quantities and values
-- ===========================================================
        sumqty.subinventory_code                                         Subinventory_or_Intransit,
        -- Revision for version 1.11
        sumqty.subinv_description                                        Subinventory_Description,
        -- Revision for version 1.7
        -- msiv.primary_uom_code                                         UOM_Code,
        muomv.uom_code                                                   UOM_Code,
        -- End revision for version 1.7
        nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0) Onhand_Quantity,
        round(nvl(cic1.item_cost,0) * 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  New_Onhand_Value,
        round(nvl(cic2.item_cost,0) * 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  Old_Onhand_Value,
        round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) * 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  Onhand_Value_Difference
from    mtl_system_items_vl msiv,
        -- Revision for version 1.7
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv, 
        -- End revision for version 1.7
        -- Revision for version 1.3
        -- org_acct_periods oap,
        mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
        -- Revision for version 1.13
        mfg_lookups ml2, -- defaulted_flag, SYS_YES_NO
        mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
        -- End revision for version 1.13
        fnd_common_lookups fcl,
        -- Revision for version 1.11
        gl_code_combinations gcc,
        inv_organizations mp,
        -- End revision for version 1.11
        -- ===========================================================================
        -- GET THE ITEM COSTS FOR COST TYPE 1
        -- ===========================================================================
        (select cic1.organization_id                     organization_id,
                cic1.inventory_item_id                   inventory_item_id,
                nvl(cic1.material_cost,0)                material_cost,
                nvl(cic1.material_overhead_cost,0)       material_overhead_cost,
                nvl(cic1.resource_cost,0)                resource_cost,
                nvl(cic1.outside_processing_cost,0)      outside_processing_cost,
                nvl(cic1.overhead_cost,0)                overhead_cost,
                nvl(cic1.item_cost,0)                    item_cost,
                -- Revision for version 1.13
                cic1.based_on_rollup_flag                based_on_rollup_flag,
                cic1.defaulted_flag                      defaulted_flag,
                cic1.lot_size                            lot_size,
                cic1.shrinkage_rate                      shrinkage_rate
                -- End revision for version 1.13
         from   cst_item_costs cic1,
                cst_cost_types cct1,
                 -- Revision for version 1.11
                mtl_system_items_vl msiv,
                inv_organizations mp
                -- End revision for version 1.11
         where  cct1.cost_type_id           = cic1.cost_type_id
         and    cic1.organization_id        = mp.organization_id
         -- Revision for version 1.11
         and    msiv.organization_id        = cic1.organization_id
         and    msiv.inventory_item_id      = cic1.inventory_item_id
         -- End revision for version 1.11
         and    8=8                         -- p_cost_type1
         -- Revision for version 1.11
         and    15=15                       -- p_item_number
         union all
         -- =============================================================
         -- Get the costs from the frozen cost type that is not in cost
         -- type 1 so that all of the inventory value is reported
         -- =============================================================
         select cic_frozen.organization_id                organization_id,
                cic_frozen.inventory_item_id              inventory_item_id,
                nvl(cic_frozen.material_cost,0)           material_cost,
                nvl(cic_frozen.material_overhead_cost,0)  material_overhead_cost,
                nvl(cic_frozen.resource_cost,0)           resource_cost,
                nvl(cic_frozen.outside_processing_cost,0) outside_processing_cost,
                nvl(cic_frozen.overhead_cost,0)           overhead_cost,
                nvl(cic_frozen.item_cost,0)               item_cost,
                -- Revision for version 1.13
                cic_frozen.based_on_rollup_flag           based_on_rollup_flag,
                cic_frozen.defaulted_flag                 defaulted_flag,
                cic_frozen.lot_size                       lot_size,
                cic_frozen.shrinkage_rate                 shrinkage_rate
                -- End revision for version 1.13
         from   cst_item_costs cic_frozen,
                cst_cost_types cct1,
                 -- Revision for version 1.11
                mtl_system_items_vl msiv,
                inv_organizations mp
                -- End revision for version 1.11
         -- Revision for version 1.8 
         where  cic_frozen.cost_type_id     = mp.primary_cost_method   -- get the frozen costs for the standard cost update
         -- Revision for version 1.11
         and    msiv.organization_id        = cic_frozen.organization_id
         and    msiv.inventory_item_id      = cic_frozen.inventory_item_id
         -- End revision for version 1.11
         and    8=8                         -- p_cost_type1
         -- =============================================================
         -- If p_cost_type1 = frozen cost_type_id then we have all the 
         -- costs and don't need this union all statement
         -- Changed the default cost type from 1 (Frozen) to the primary_
         -- cost_method so you can use this report for any Costing Method.
         -- =============================================================
         and    cct1.cost_type_id           <> mp.primary_cost_method   -- frozen cost type
         and    cic_frozen.organization_id  = mp.organization_id
         -- Revision for version 1.10, parameter to only_items_in_cost_type
         and    14=14
         -- Revision for version 1.11
         and    15=15                       -- p_item_number
         -- =============================================================
         -- Check to see if the costs exist in cost type 1 
         -- =============================================================
         and not exists (
                        select 'x'
                        from   cst_item_costs cic1
                        where  cic1.cost_type_id      = cct1.cost_type_id
                        and    cic1.organization_id   = cic_frozen.organization_id
                        and    cic1.inventory_item_id = cic_frozen.inventory_item_id
                    )
         ) cic1,
        -- ===========================================================================
        -- GET THE ITEM COSTS FOR COST TYPE 2
        -- ===========================================================================
        (select cic2.organization_id                     organization_id,
                cic2.inventory_item_id                   inventory_item_id,
                nvl(cic2.material_cost,0)                material_cost,
                nvl(cic2.material_overhead_cost,0)       material_overhead_cost,
                nvl(cic2.resource_cost,0)                resource_cost,
                nvl(cic2.outside_processing_cost,0)      outside_processing_cost,
                nvl(cic2.overhead_cost,0)                overhead_cost,
                nvl(cic2.item_cost,0)                    item_cost
         from   cst_item_costs cic2,
                cst_cost_types cct2,
                -- Revision for version 1.11
                mtl_system_items_vl msiv,
                inv_organizations mp
                -- End revision for version 1.11
         where  cct2.cost_type_id           = cic2.cost_type_id
         and    cic2.organization_id        = mp.organization_id
         -- Revision for version 1.11
         and    msiv.organization_id        = cic2.organization_id
         and    msiv.inventory_item_id      = cic2.inventory_item_id
         -- End revision for version 1.11
         and    10=10                       -- p_cost_type2
         -- Revision for version 1.11
         and    15=15                       -- p_item_number
         union all
         -- =============================================================
         -- Get the costs from the frozen cost type that is not in cost
         -- type 2 so that all of the inventory value is reported
         -- =============================================================
         select cic_frozen.organization_id                      organization_id,
                cic_frozen.inventory_item_id                    inventory_item_id,
                nvl(cic_frozen.material_cost,0)                 material_cost,
                nvl(cic_frozen.material_overhead_cost,0)        material_overhead_cost,
                nvl(cic_frozen.resource_cost,0)                 resource_cost,
                nvl(cic_frozen.outside_processing_cost,0)       outside_processing_cost,
                nvl(cic_frozen.overhead_cost,0)                 overhead_cost,
                nvl(cic_frozen.item_cost,0)                     item_cost
         from   cst_item_costs cic_frozen,
                cst_cost_types cct2,
                 -- Revision for version 1.11
                mtl_system_items_vl msiv,
                inv_organizations mp
                -- End revision for version 1.11
         -- Revision for version 1.8
         where  cic_frozen.cost_type_id     = mp.primary_cost_method  -- get the frozen costs for the standard cost update
         -- Revision for version 1.11
         and    msiv.organization_id        = cic_frozen.organization_id
         and    msiv.inventory_item_id      = cic_frozen.inventory_item_id
         -- End revision for version 1.11
         -- =============================================================
         -- If p_cost_type2 = frozen cost_type_id then we have all the 
         -- costs and don't need this union all statement
         -- Changed the default cost type from 1 (Frozen) to the primary_
         -- cost_method so you can use this report for any Costing Method.
         -- =============================================================
         and    cct2.cost_type_id           <> mp.primary_cost_method  -- frozen cost type
         and    cic_frozen.organization_id  = mp.organization_id
         and    10=10                       -- p_cost_type2
         -- Revision for version 1.11
         and    15=15                       -- p_item_number
         -- =============================================================
         -- Check to see if the costs exist in cost type 1 
         -- =============================================================
         and not exists (
                         select 'x'
                         from   cst_item_costs cic2
                         where  cic2.cost_type_id      = cct2.cost_type_id
                         and    cic2.organization_id   = cic_frozen.organization_id
                         and    cic2.inventory_item_id = cic_frozen.inventory_item_id
                        )
         ) cic2,
         -- ===========================
        -- end of getting cost 
         -- ===========================
        -- ==================================================================================
        -- Get Intransit and Onhand quantities from the month-end snapshot or from the
        -- real-time intransit and onhand tables
         -- ==================================================================================
         -- ===================================================================
         -- Part 1: Get the month-end snapshot
         -- ===================================================================
         -- Part 1a: Get the month-end snapshot for non-category accounting
         -- ===================================================================
        (select cpcs.organization_id organization_id,
                 -- Revision for version 1.11
                mp.category_organization_id,
                mp.category_set_id,
             