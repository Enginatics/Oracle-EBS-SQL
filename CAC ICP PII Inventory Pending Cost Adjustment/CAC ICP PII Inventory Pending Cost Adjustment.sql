/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII Inventory Pending Cost Adjustment
-- Description: Report showing potential standard cost changes for onhand and intransit inventory value which you own, for gross, profit in inventory and net inventory values.  If you enter a period name this report uses quantities from the month-end snapshot; if you leave the period name blank it uses the real-time quantities.  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.), the Currency Conversion Dates default to the current accounting period, and the To Currency Code and the Organization Code default from the organization code set for this session.  And to use the quantities from the month-end snapshot, you can only choose closed accounting periods as the month-end snapshot is created when you close the inventory accounting period.

Note:  If using this report for reporting after the standard cost update this report requires both the before and after cost types available after the standard cost update is run.
           Please save your frozen costs to another Cost Type before running the standard cost update, using the item cost copy.

Hidden Parameters:
Sign PII:  hidden parameter to set the sign of the profit in inventory amounts.  This parameter determines if PII is normally entered as a positive or negative amount.
Default value for this report assumes PII costs are entered as positive amounts.

Displayed Parameters:
Cost Type (New):  the new cost type to be reported, mandatory
Cost Type (Old):  the old cost type to be reported, mandatory
PII Cost Type (New):  the new PII Cost Type you wish to report, such as PII or ICP, mandatory
PII Cost Type (Old):  the prior or old PII Cost Type you wish to report, such as PII or ICP, mandatory
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP, mandatory
Currency Conversion Date(New):  the new currency conversion date, mandatory
Currency Conversion Date (Old):  the old currency conversion date, mandatory
Currency Conversion Type (New):  the desired currency conversion type to use for cost type 1, mandatory
Currency Conversion Type (Old):  the desired currency conversion type to use for cost type 2, mandatory
To Currency Code:  the currency you are converting into
Period Name:  enter a Period Name to use the month-end snapshot; if no  period name is entered will use the real-time quantities
Category Set1:  the first item category set to report, typically the  Cost or Product Line Category Set
Category Set2:  the second item category set to report, typically the Inventory Category Set
Include Zero Quantities:  include items with no onhand or no intransit quantities
Only Items in Cost Type:  only report items in the New Cost Type
Item Number:  specific item number to report, leave blank for all operating units, optional
Organization Code:  specific inventory organization you wish to report, optional
Operating Unit:  Operating Unit you wish to report, leave blank for all operating units, optional
Ledger:  general ledger you wish to report, leave blank for all ledgers, optional

-- |  Copyright 2008-2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.

-- |  Version Modified on  Modified  by   Desc
-- |  ======= =========== ============== =========================================
-- |      1.0 21 Nov 2010 Douglas Volz   Created initial Report for prior client based on BBCI_INV_VALUE_STD_ADJ_FX_REPT1.7.sql
-- |     1.14 07 Feb 2024 Douglas Volz   Add item master and costing lot sizes, use default controls,
-- |                                     based on rollup and shrinkage rate columns.  Added in GL and OU security restrictions.
-- |     1.15 25 Jun 2024 Douglas Volz   Reinstalled missing parameter, To Currency Code.  Commented out GL and OU security restrictions.
-- +=============================================================================

-- Excel Examle Output: https://www.enginatics.com/example/cac-icp-pii-inventory-pending-cost-adjustment/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-inventory-pending-cost-adjustment/
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
         and    1=1                             -- p_operating_unit, p_ledger
         -- Revision for version 1.12
         and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         -- Revision for version 1.14 and 1.15
         -- and    gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
         -- and    haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
         -- End revision for version 1.14 and 1.15
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
        -- Revision for version 1.14
        msiv.std_lot_size                                                Std_Lot_Size,
        -- Revision for version 1.5
&category_columns
        -- Revision for version 1.14
        ml2.meaning                                                      Use_Default_Controls,
        ml3.meaning                                                      Based_on_Rollup,
        cic1.lot_size                                                    Costing_Lot_Size,
        cic1.shrinkage_rate                                              Shrinkage_Rate,
        -- End revision for version 1.14
        -- Revision for version 1.11
        mp.currency_code                                                 Currency_Code,
-- ==========================================================
-- Select the new and old item costs from Cost Type 1 and 2
-- ==========================================================
        round(nvl(cic1.material_cost,0),5)                               New_Material_Cost,
        round(nvl(cic2.material_cost,0),5)                               Old_Material_Cost,
        round(nvl(cic1.material_overhead_cost,0),5)                      New_Material_Overhead_Cost,
        round(nvl(cic2.material_overhead_cost,0),5)                      Old_Material_Overhead_Cost,
        round(nvl(cic1.resource_cost,0),5)                               New_Resource_Cost,
        round(nvl(cic2.resource_cost,0),5)                               Old_Resource_Cost,
        round(nvl(cic1.outside_processing_cost,0),5)                     New_Outside_Processing_Cost,
        round(nvl(cic2.outside_processing_cost,0),5)                     Old_Outside_Processing_Cost,
        round(nvl(cic1.overhead_cost,0),5)                               New_Overhead_Cost,
        round(nvl(cic2.overhead_cost,0),5)                               Old_Overhead_Cost,
        round(nvl(cic1.item_cost,0),5)                                   New_Item_Cost,
        round(nvl(cic2.item_cost,0),5)                                   Old_Item_Cost,
-- Revision for version 1.11 for PII
-- ========================================================
-- Select the PII item costs from Cost Type 1 and 2
-- ========================================================
        round(nvl(pii1.item_cost,0),5)                                   New_PII_Cost,
        round(nvl(pii2.item_cost,0),5)                                   Old_PII_Cost,
-- ========================================================
-- Select the net item costs from Cost Type 1 and 2
-- ========================================================
        round(nvl(cic1.item_cost,0),5) - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii1.item_cost,0),5) New_Net_Item_Cost,
        round(nvl(cic2.item_cost,0),5) - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii2.item_cost,0),5) Old_Net_Item_Cost,
-- End revision for version 1.11 for PII
-- ========================================================
-- Select the gross item costs from Cost Type 1 and 2 and compare
-- ========================================================
        round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5) Gross_Item_Cost_Difference,
        -- Revision for version 1.9
        -- round((nvl(cic1.item_cost,0) -nvl(cic2.item_cost,0))
        --     /
        -- (decode(nvl(cic2.item_cost,0),0,1,cic2.item_cost)) * 100,1)  Gross_Percent_Difference,
        case
           when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = 0 then 0
           when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic1.item_cost,0),5) then  100
           when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic2.item_cost,0),5) then -100
          else round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) / nvl(cic2.item_cost,0) * 100,1)
        end                                                             Gross_Percent_Difference,
-- Revision for version 1.11 for PII
-- ========================================================
-- Select the PII costs from Cost Type 1 and 2 and compare
-- ========================================================
        round(nvl(pii1.item_cost,0),5) - round(nvl(pii2.item_cost,0),5) PII_Item_Cost_Difference,
        case
           when round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)),5) = 0 then 0
           when round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)),5) = round(nvl(pii1.item_cost,0),5) then  100
           when round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)),5) = round(nvl(pii2.item_cost,0),5) then -100
          else round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) / nvl(pii2.item_cost,0) * 100,1)
        end                                                             PII_Percent_Difference,
-- ========================================================
-- Select the net item costs from Cost Type 1 and 2 and compare
-- ========================================================
        (round(nvl(cic1.item_cost,0),5) - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii1.item_cost,0),5)) -
        (round(nvl(cic2.item_cost,0),5) - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii2.item_cost,0),5)) Net_Item_Cost_Difference,
-- End revision for version 1.11 for PII
-- ===========================================================
-- Select the onhand and intransit quantities and values
-- ===========================================================
        sumqty.subinventory_code                                        Subinventory_or_Intransit,
        -- Revision for version 1.11
        sumqty.subinv_description                                       Subinventory_Description,
        -- Revision for version 1.7
        -- msiv.primary_uom_code                                        UOM_Code,
        muomv.uom_code                                                  UOM_Code,
        -- End revision for version 1.7
        nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0) Onhand_Quantity,
        round(nvl(cic1.item_cost,0) * 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) New_Gross_Onhand_Value,
-- Revision for version 1.11 for PII
        round(nvl(pii1.item_cost,0) * decode(sign(:p_sign_pii),1,1,-1,-1,1) * 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) New_PII_Value,
        round((nvl(cic1.item_cost,0) - decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii1.item_cost,0)) *
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) New_Net_Onhand_Value,
-- End revision for version 1.11 for PII
        round(nvl(cic2.item_cost,0) * 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) Old_Gross_Onhand_Value,
-- Revision for version 1.11 for PII
        round(nvl(pii2.ITEM_COST,0) * 
                (sumqty.intransit_quantity + sumqty.onhand_quantity),2)               Old_PII_Value,
        round((nvl(cic2.item_cost,0)  - decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii2.item_cost,0)) *
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) Old_Net_Onhand_Value,
-- End revision for version 1.11 for PII
        round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) * 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  Gross_Onhand_Value_Diff,
-- Revision for version 1.11 for PII
        round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) * 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  PII_Value_Difference,
        -- Onhand item cost diff
        round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0) -
        -- PII item cost diff
             decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0))) *
        -- onhand quantity
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  Net_Onhand_Value_Difference,
-- End revision for version 1.11 for PII
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
        nvl(gdr1.conversion_rate,1)                                            New_FX_Rate,
        nvl(gdr2.conversion_rate,1)                                            Old_FX_Rate,
        nvl(gdr1.conversion_rate,1) - nvl(gdr2.conversion_rate,1)              Exchange_Rate_Difference,
-- ===========================================================
-- Select To Currency onhand and intransit quantities and values
-- ===========================================================
-- ===========================================================
-- Costs in To Currency by Cost Element, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        round(nvl(cic1.material_cost,0) * nvl(gdr1.conversion_rate,1)
        * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code New Material Value",
        round(nvl(cic2.material_cost,0) * nvl(gdr2.conversion_rate,1)
        * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code Old Material Value",
        round(nvl(cic1.material_overhead_cost,0) * nvl(gdr1.conversion_rate,1)        
        * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code New Material Ovhd Value",
        round(nvl(cic2.material_overhead_cost,0) * nvl(gdr2.conversion_rate,1)
        * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code Old Material Ovhd Value",
        round(nvl(cic1.resource_cost,0) * nvl(gdr1.conversion_rate,1)
        * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code New Resource Value",
        round(nvl(cic2.resource_cost,0) * nvl(gdr2.conversion_rate,1)
        * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code Old Resource Value",
        round(nvl(cic1.outside_processing_cost,0) * nvl(gdr1.conversion_rate,1)
        * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code New OSP Value",
        round(nvl(cic2.outside_processing_cost,0) * nvl(gdr2.conversion_rate,1)
        * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code Old OSP Value",
        round(nvl(cic1.overhead_cost,0) * nvl(gdr1.conversion_rate,1)
        * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code New Overhead Value",
        round(nvl(cic2.overhead_cost,0) * nvl(gdr2.conversion_rate,1)
        * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code Old Overhead Value",
-- ===========================================================
-- Onhand Values in To Currency, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        round(nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1) *
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code New Gross Onhand Value",
        round(nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1) *
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code Old Gross Onhand Value",
        -- USD New Onhand Cost - USD Old Onhand Cost
        round(( (nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1)) -
                (nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
        -- multiplied by the total onhand quantity 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code Gross Onhand Value Diff",
-- Revision for version 1.11 for PII
-- ===========================================================
-- PII Values in USD, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        round(nvl(pii1.item_cost,0) * nvl(gdr1.conversion_rate,1) * 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code New PII Value",
        round(nvl(pii2.item_cost,0) * nvl(gdr2.conversion_rate,1) * 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code Old PII Value",
        -- USD New PII Cost - USD Old PII Cost
        round(( (nvl(pii1.item_cost,0) * nvl(gdr1.conversion_rate,1)) -
                (nvl(pii2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
        -- multiplied by the total onhand quantity 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code PII Value Difference",
-- ===========================================================
-- Net Values in USD, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        -- USD New Gross Onhand Cost - USD New PII Cost
        round(( (nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1)) -
                decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * nvl(gdr1.conversion_rate,1))) *
        -- multiplied by the total onhand quantity 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  "&p_to_currency_code New Net Value",
        -- USD Old Gross Onhand Cost - USD Old PII Cost
        round(( (nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1)) -
                decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
        -- multiplied by the total onhand quantity 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  "&p_to_currency_code Old Net Value",
        -- USD New Net Value less USD Old Net Value
        -- USD New Gross Onhand Cost - USD Old PII Cost
        round((((nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1)) -
                decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * nvl(gdr1.conversion_rate,1)))  - 
        -- USD Old Gross Onhand Cost - USD Old PII Cost
               ((nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1)) -
                decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * nvl(gdr2.conversion_rate,1)))) *
        -- multiplied by the total onhand quantity 
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  "&p_to_currency_code Net Value Difference",
-- End revision for version 1.11 for PII
-- ===========================================================
-- Value Differences in To Currency using the new rate
-- New and Old costs at New Fx Rate
-- ===========================================================
        -- NEW COST at new fx conversion rate minus OLD COST at new fx conversion rate
        round(( (nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1)) - 
                (nvl(cic2.item_cost,0) * nvl(gdr1.conversion_rate,1))) *
        -- multiplied by the total onhand quantity
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  "&p_to_currency_code Gross Value Diff-New Rate",
-- Revision for version 1.11 for PII
        -- NEW PII at new fx conversion rate minus OLD PII at new fx conversion rate
        round(( (nvl(pii1.item_cost,0) * nvl(gdr1.conversion_rate,1)) - 
                (nvl(pii2.item_cost,0) * nvl(gdr1.conversion_rate,1))) *
        -- multiplied by the total onhand quantity
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  "&p_to_currency_code PII Value Diff-New Rate",
        -- USD Gross Value Diff-New Rate less USD PII Value Diff-New Rate
        -- USD Gross Value Diff-New Rate
        round(( (nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1)) - 
                (nvl(cic2.item_cost,0) * nvl(gdr1.conversion_rate,1))) *
        -- multiplied by the total onhand quantity
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) -
        round(( decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * nvl(gdr1.conversion_rate,1)) - 
                decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * nvl(gdr1.conversion_rate,1))) *
        -- multiplied by the total onhand quantity
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code Net Value Diff-New Rate",
-- End revision for version 1.11 for PII
-- ===========================================================
-- Value Differences in To Currency using the old rate
-- New and Old costs at Old Fx Rate
-- ===========================================================
        -- NEW COST at old fx conversion rate minus OLD COST at old fx conversion rate
        round(( (nvl(cic1.item_cost,0) * nvl(gdr2.conversion_rate,1)) - 
                (nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
        -- multiplied by the total onhand quantity
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code Gross Value Diff-Old Rate",
-- Revision for version 1.11 for PII
        -- NEW PII at old fx conversion rate minus OLD PII at old fx conversion rate
        round(( (nvl(pii1.item_cost,0) * nvl(gdr2.conversion_rate,1)) - 
                (nvl(pii2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
        -- multiplied by the total onhand quantity
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  "&p_to_currency_code PII Value Diff-Old Rate",
        -- USD Gross Value Diff-Old Rate less USD PII Value Diff-Old Rate
        -- USD Gross Value Diff-Old Rate
        round(( (nvl(cic1.item_cost,0) * nvl(gdr2.conversion_rate,1)) - 
                (nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) -
        -- USD PII Value Diff-Old Rate
        round(( decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * nvl(gdr2.conversion_rate,1)) - 
                decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
        -- multiplied by the total onhand quantity
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)   "&p_to_currency_code Net Value Diff-Old Rate",
-- End revision for version 1.11 for PII
-- ===========================================================
-- Value Differences comparing the new less the old rate differences
-- ===========================================================
        -- USD Value Diff-New Rate less USD Value Diff-Old Rate
        -- USD Value Diff-New Rate
        round(( (nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1)) - 
                (nvl(cic2.item_cost,0) * nvl(gdr1.conversion_rate,1))) *
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) -
        -- USD Value Diff-Old Rate
        round(( (nvl(cic1.item_cost,0) * nvl(gdr2.conversion_rate,1)) - 
                (nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  "&p_to_currency_code Gross Value FX Diff",
-- Revision for version 1.11 for PII
     