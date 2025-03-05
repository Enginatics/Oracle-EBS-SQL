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
        -- USD PII Value Diff-New Rate less USD PII Value Diff-Old Rate
        -- USD PII Value Diff-New Rate
        round(( (nvl(pii1.item_cost,0) * nvl(gdr1.conversion_rate,1)) - 
                (nvl(pii2.item_cost,0) * nvl(gdr1.conversion_rate,1))) *
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) -
        -- USD PII Value Diff-Old Rate
        round(( (nvl(pii1.item_cost,0) * nvl(gdr2.conversion_rate,1)) - 
                (nvl(pii2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)  "&p_to_currency_code PII Value FX Diff",
        -- USD Net Value FX Diff-NEW = (USD Net Value Diff-New Rate) - (USD Net Value Diff-Old Rate)
        -- USD Net Value FX Diff-NEW = (USD Net Value Diff-New Rate) - (USD Net Value Diff-Old Rate)
        -- USD Gross Value Diff-New Rate less USD PII Value Diff-New Rate = USD Net Value Diff-New Rate
        -- USD Gross Value Diff-New Rate
        (round(( (nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1)) - 
                (nvl(cic2.item_cost,0) * nvl(gdr1.conversion_rate,1))) *
         -- multiplied by the total onhand quantity
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) -
         round(( decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * nvl(gdr1.conversion_rate,1)) - 
                decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * nvl(gdr1.conversion_rate,1))) *
         -- multiplied by the total onhand quantity
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)
        ) -
        -- USD Gross Value Diff-Old Rate less USD PII Value Diff-Old Rate = USD Net Value Diff-Old Rate
        -- USD Gross Value Diff-Old Rate
        (round(( (nvl(cic1.item_cost,0) * nvl(gdr2.conversion_rate,1)) - 
                (nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) -
         -- USD PII Value Diff-Old Rate
         round(( decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * nvl(gdr2.conversion_rate,1)) - 
                decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
         -- multiplied by the total onhand quantity
                (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2)
        )                                                                              "&p_to_currency_code Net Value FX Diff"
-- End revision for version 1.11 for PII
from    mtl_system_items_vl msiv,
        -- Revision for version 1.7
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv, 
        -- End revision for version 1.7
        -- Revision for version 1.3
        -- org_acct_periods oap,
        mfg_lookups ml1,
        -- Revision for version 1.14
        mfg_lookups ml2, -- defaulted_flag, SYS_YES_NO
        mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
        -- End revision for version 1.14
        fnd_common_lookups fcl,
        -- Revision for version 1.11
        gl_code_combinations gcc,
        inv_organizations mp,
        -- End revision for version 1.11
        -- ===========================================================================
        -- Select New Currency Rates based on the new concurrency conversion date
        -- ===========================================================================
        -- Revision for version 1.13
        (select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:p_conversion_date1 and gdr.to_currency=:p_to_currency and gdct.user_conversion_type=:p_user_conversion_type1 and gdct.conversion_type=gdr.conversion_type) gdr1, -- NEW Currency Rates
        -- ===========================================================================
        -- Select Old Currency Rates based on the old concurrency conversion date
        -- ===========================================================================
        -- Revision for version 1.13
        (select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:conversion_date2 and gdr.to_currency=:p_to_currency and gdct.user_conversion_type=:p_user_conversion_type2 and gdct.conversion_type=gdr.conversion_type) gdr2,  -- OLD Currency Rates
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
                -- Revision for version 1.14
                cic1.based_on_rollup_flag                based_on_rollup_flag,
                cic1.defaulted_flag                      defaulted_flag,
                cic1.lot_size                            lot_size,
                cic1.shrinkage_rate                      shrinkage_rate
                -- End revision for version 1.14
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
                -- Revision for version 1.14
                cic_frozen.based_on_rollup_flag           based_on_rollup_flag,
                cic_frozen.defaulted_flag                 defaulted_flag,
                cic_frozen.lot_size                       lot_size,
                cic_frozen.shrinkage_rate                 shrinkage_rate
                -- End revision for version 1.14
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
-- Revision for version 1.11 - PII
        -- ===========================================================================
        -- GET THE PII ITEM COSTS FROM PII COST TYPE 1
        -- ===========================================================================
        (select msiv.organization_id                            organization_id,
                msiv.inventory_item_id                          inventory_item_id,
                nvl((select     sum(nvl(cicd.item_cost,0))
                     from       cst_item_cost_details cicd,
                                cst_cost_types cct,
                                bom_resources br
                     where      cicd.inventory_item_id = msiv.inventory_item_id
                     and        cicd.organization_id   = msiv.organization_id
                     and        br.resource_id         = cicd.resource_id
                     and        cct.cost_type_id       = cicd.cost_type_id
                     and        16=16                  -- p_pii_cost_type1_NEW
                     and        18=18                  -- p_pii_sub_element
                    ),0)   item_cost
         -- Revision for version 1.11
         from   inv_organizations mp,
                mtl_system_items_vl msiv
         where  msiv.organization_id        = mp.organization_id
         -- Revision for version 1.3
         and    msiv.inventory_asset_flag   = 'Y'
         -- Revision for version 1.11
         and    15=15                       -- p_item_number
        ) pii1,
        -- ===========================================================================
        -- GET THE PII ITEM COSTS FROM PII COST TYPE 2
        -- ===========================================================================
        (select msiv.organization_id                            organization_id,
                msiv.inventory_item_id                          inventory_item_id,
                nvl((select     sum(nvl(cicd.item_cost,0))
                     from       cst_item_cost_details cicd,
                                cst_cost_types cct,
                                bom_resources br
                     where      cicd.inventory_item_id = msiv.inventory_item_id
                     and        cicd.organization_id   = msiv.organization_id
                     and        br.resource_id         = cicd.resource_id
                     and        cct.cost_type_id       = cicd.cost_type_id
                     and        17=17                  -- p_pii_cost_type2_OLD
                     and        18=18                  -- p_pii_sub_element
                    ),0)   item_cost
         -- Revision for version 1.11
         from   inv_organizations mp,
                mtl_system_items_vl msiv
         where  msiv.organization_id        = mp.organization_id
         -- Revision for version 1.3
         and    msiv.inventory_asset_flag = 'Y'
         -- Revision for version 1.11
         and    15=15                       -- p_item_number
        ) pii2,
-- End revision for version 1.11 - PII
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
                null category_id,
                cpcs.inventory_item_id,
                nvl(cpcs.subinventory_code, ml2.meaning) subinventory_code,
                nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml2.meaning) subinv_description,
                va.material_account code_combination_id,
                -- End revision for version 1.11
                sum(decode(cpcs.subinventory_code, null, 0, cpcs.rollback_quantity)) onhand_quantity,
                sum(decode(cpcs.subinventory_code, null, cpcs.rollback_quantity, 0)) intransit_quantity
          from  cst_period_close_summary cpcs,
                org_acct_periods oap,
                mtl_secondary_inventories msub,
                -- Revision for version 1.11
                -- mtl_parameters mp
                mtl_system_items_vl msiv,
                inv_organizations mp,
                valuation_accounts va,
                mfg_lookups ml2
                -- End revision for version 1.11
         where  cpcs.acct_period_id             = oap.acct_period_id
         and    mp.organization_id              = oap.organization_id
         and    cpcs.subinventory_code          = msub.secondary_inventory_name (+)
         and    cpcs.organization_id            = msub.organization_id (+)
         -- Revision for version 1.11
         and    mp.category_organization_id is null
         and    cpcs.inventory_item_id          = msiv.inventory_item_id
         and    cpcs.organization_id            = msiv.organization_id
         and    va.secondary_inventory_name (+) = nvl(cpcs.subinventory_code,'Intransit')
         and    va.organization_id (+)          = cpcs.organization_id
         and    va.valuation_type              <> 'Category Accounting'
         and    ml2.lookup_code                 = 3 -- Intransit
         and    ml2.lookup_type                 = 'MSC_CALENDAR_TYPE'
         -- End revision for version 1.11
         -- Revision for version 1.3
         and    11=11                           -- p_period_name oap.period_name = :p_period_name
         and    :p_period_name is not null      -- p_period_name
         -- Revision for version 1.11
         and    15=15                           -- p_item_number
         and    nvl(cpcs.rollback_quantity,0) <> 0
         group by
                cpcs.organization_id,
                 -- Revision for version 1.11
                mp.category_organization_id,
                mp.category_set_id,
                null, -- category_id
                cpcs.inventory_item_id,
                nvl(cpcs.subinventory_code, ml2.meaning), -- Subinventory
                nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml2.meaning), -- subinv_description
                va.material_account -- code_combination_id
                -- End revision for version 1.11
        -- Revision for version 1.11
         union all
         -- ===================================================================
         -- Part 1b: Get the month-end snapshot for category accounting
         -- ===================================================================
         select cat_onhand.organization_id,
                cat_onhand.category_organization_id,
                cat_onhand.category_set_id,
                cat_onhand.category_id,
                cat_onhand.inventory_item_id,
                nvl(cat_onhand.subinventory_code, ml2.meaning) subinventory_code,
                nvl(cat_onhand.subinv_description, ml2.meaning) subinv_description,
                va.material_account code_combination_id,
                cat_onhand.onhand_quantity,
                cat_onhand.intransit_quantity
         from   -- Inner select to have consistent outer joins with valuation accounts
                valuation_accounts va,
                mfg_lookups ml2,
                (select onhand2.organization_id,
                        onhand2.category_organization_id,
                        onhand2.category_set_id,
                        mic.category_id,
                        onhand2.inventory_item_id,
                        onhand2.subinventory_code,
                        onhand2.subinv_description,
                        onhand2.onhand_quantity,
                        onhand2.intransit_quantity        
                 from   -- Inner select to have consistent outer joins with categories
                        mtl_item_categories mic,
                        (select mp.organization_id,
                                mp.category_organization_id,
                                mp.category_set_id,
                                msiv.inventory_item_id,
                                cpcs.subinventory_code,
                                regexp_replace(msub.description,'[^[:alnum:]'' '']', null) subinv_description,
                                sum(decode(cpcs.subinventory_code, null, 0, cpcs.rollback_quantity)) onhand_quantity,
                                sum(decode(cpcs.subinventory_code, null, cpcs.rollback_quantity, 0)) intransit_quantity
                         from   mtl_system_items_vl msiv,
                                cst_period_close_summary cpcs,
                                org_acct_periods oap,
                                mtl_secondary_inventories msub,
                                inv_organizations mp
                         where  mp.organization_id              = msiv.organization_id
                         and    mp.category_organization_id is not null
                         and    oap.organization_id             = mp.organization_id
                         and    oap.acct_period_id              = cpcs.acct_period_id
                         and    cpcs.organization_id            = msiv.organization_id
                         and    cpcs.inventory_item_id          = msiv.inventory_item_id
                         and    cpcs.subinventory_code          = msub.secondary_inventory_name (+)
                         and    cpcs.organization_id            = msub.organization_id (+)
                         -- Don't get zero quantities
                         and    nvl(cpcs.rollback_quantity,0)  <> 0
                         and    11=11                           -- p_period_name oap.period_name = :p_period_name
                         and    :p_period_name is not null      -- p_period_name
                         -- Revision for version 1.11
                         and    15=15                           -- p_item_number
                         group by
                                mp.organization_id,
                                mp.category_organization_id,
                                mp.category_set_id,
                                msiv.inventory_item_id,
                                cpcs.subinventory_code,
                                regexp_replace(msub.description,'[^[:alnum:]'' '']', null) -- subinv_description
                        ) onhand2
                 where  mic.inventory_item_id (+)       = onhand2.inventory_item_id
                 and    mic.organization_id (+)         = onhand2.organization_id
                 and    mic.category_set_id (+)         = onhand2.category_set_id
                ) cat_onhand
         where  va.secondary_inventory_name (+) = nvl(cat_onhand.subinventory_code, 'Intransit')
         and    va.organization_id (+)          = cat_onhand.organization_id
         and    va.category_set_id (+)          = cat_onhand.category_set_id
         and    va.category_id (+)              = cat_onhand.category_id
         and    va.valuation_type (+)           in ('Category Accounting', 'Intransit Accounting')
         and    ml2.lookup_code                 = 3 -- Intransit
         and    ml2.lookup_type                 = 'MSC_CALENDAR_TYPE'
         union all
         -- ===================================================================
        -- Part 2: Or get Real-Time Intransit and Onhand quantities
         -- ===================================================================
        -- ================================================
        -- Condense the Union down to individual Org/Items
        -- ================================================
         select allqty.organization_id,
                -- Revision for version 1.11
                allqty.category_organization_id,
                allqty.category_set_id,
                allqty.category_id,
                allqty.inventory_item_id,
                nvl(allqty.subinventory_code, ml2.meaning) subinventory_code,
                nvl(allqty.subinv_description, ml2.meaning) subinv_description,
                allqty.code_combination_id,
                sum(allqty.onhand_quantity) onhand_quantity,
                sum(allqty.intransit_quantity) intransit_quantity
         from   mfg_lookups ml2,
                 -- ===================================================================
                 -- Part 2a: Get real-time onhand quantities for non-category accounting
                 -- =================================================================== 
                (select moqd.organization_id,
                        -- Revision for version 1.11
                        mp.category_organization_id,
                        mp.category_set_id,
                        null category_id,
                        msiv.inventory_item_id,
                        moqd.subinventory_code,
                        regexp_replace(msub.description,'[^[:alnum:]'' '']', null) subinv_description,
                        va.material_account code_combination_id,
                        sum(moqd.primary_transaction_quantity) onhand_quantity,
                        min(0) intransit_quantity
                 from   mtl_onhand_quantities_detail moqd,
                        mtl_secondary_inventories msub,
                        -- Revision for version 1.11
                        mtl_system_items_vl msiv,
                        inv_organizations mp,
                        valuation_accounts va
                 -- End revision for version 1.11
                 where  moqd.subinventory_code          = msub.secondary_inventory_name 
                 and    moqd.organization_id            = msub.organization_id
                 and    moqd.organization_id            = mp.organization_id
                 -- Revision for version 1.8
                 and    moqd.is_consigned               = 2 -- No
                 -- Don't select expense subinventories
                 and    msub.asset_inventory            = 1
                 -- End revision for version 1.3
                 -- Revision for version 1.11
                 and    moqd.inventory_item_id          = msiv.inventory_item_id
                 and    moqd.organization_id            = msiv.organization_id
                 and    mp.category_organization_id is null
                 and    va.secondary_inventory_name (+) = moqd.subinventory_code
                 and    va.organization_id (+)          = moqd.organization_id
                 and    va.valuation_type              <> 'Category Accounting'
                 -- End revision for version 1.11
                 -- If Period Name is null get real-time onhand qtys
                 -- Revision for version 1.3
                 and    :p_period_name is null          -- p_period_name
                 -- Revision for version 1.11
                 and    15=15                           -- p_item_number
                group by
                        moqd.organization_id,
                        -- Revision for version 1.11
                        mp.category_organization_id,
                        mp.category_set_id,
                        null, -- category_id
                        msiv.inventory_item_id,
                        moqd.subinventory_code,
                        regexp_replace(msub.description,'[^[:alnum:]'' '']', null), -- subinv_description
                        va.material_account -- code_combination_id
                 -- Revision for version 1.11
                 union all
                 -- ===================================================================
                 -- Part 2b: Get real-time onhand quantities for category accounting
                 -- ===================================================================
                 select cat_onhand.organization_id,
                        cat_onhand.category_organization_id,
                        cat_onhand.category_set_id,
                        cat_onhand.category_id,
                        cat_onhand.inventory_item_id,
                        cat_onhand.subinventory_code,
                        cat_onhand.subinv_description,
                        va.material_account code_combination_id,
                        cat_onhand.onhand_quantity,
                        cat_onhand.intransit_quantity        
                 from   -- Inner select to have consistent outer joins with valuation accounts
                        valuation_accounts va,
                        (select onhand2.organization_id,
                                onhand2.category_organization_id,
                                onhand2.category_set_id,
                                mic.category_id,
                                onhand2.inventory_item_id,
                                onhand2.subinventory_code,
                                onhand2.subinv_description,
                                onhand2.onhand_quantity,
                                onhand2.intransit_quantity
                         from   -- Inner select to have consistent outer joins with categories
                                mtl_item_categories mic,
                                (select moqd.organization_id,
                                        -- Revision for version 1.11
                                        mp.category_organization_id,
                                        mp.category_set_id,
                                        msiv.inventory_item_id,
                                        moqd.subinventory_code,
                                        regexp_replace(msub.description,'[^[:alnum:]'' '']', null) subinv_description,
                                        sum(moqd.primary_transaction_quantity) onhand_quantity,
                                        min(0) intransit_quantity
                                 from   mtl_onhand_quantities_detail moqd,
                                        mtl_secondary_inventories msub,
                                        -- Revision for version 1.11
                                        mtl_system_items_vl msiv,
                                        inv_organizations mp
                                -- End revision for version 1.11
                                 where  moqd.subinventory_code          = msub.secondary_inventory_name 
                                 and    moqd.organization_id            = msub.organization_id
                                 and    moqd.organization_id            = mp.organization_id
                                 -- Revision for version 1.8
                                 and    moqd.is_consigned               = 2 -- No
                                 -- Don't select expense subinventories
                                 and    msub.asset_inventory            = 1
                                 -- End revision for version 1.3
                                 -- Revision for version 1.11
                                 and    moqd.inventory_item_id          = msiv.inventory_item_id
                                 and    moqd.organization_id            = msiv.organization_id
                                 and    mp.category_organization_id is not null
                                 -- End revision for version 1.11
                                 -- If Period Name is null get real-time onhand qtys
                                 -- Revision for version 1.3
                                 and    :p_period_name is null          -- p_period_name
                                 -- Revision for version 1.11
                                 and    15=15                           -- p_item_number
                                 group by moqd.organization_id,
                                        -- Revision for version 1.11
                                        mp.category_organization_id,
                                        mp.category_set_id,
                                        msiv.inventory_item_id,
                                        moqd.subinventory_code,
                                        regexp_replace(msub.description,'[^[:alnum:]'' '']', null) -- subinv_description
                                ) onhand2
                         where  mic.inventory_item_id (+)       = onhand2.inventory_item_id
                         and    mic.organization_id (+)         = onhand2.organization_id
                         and    mic.category_set_id (+)         = onhand2.category_set_id
                        ) cat_onhand
                 where  va.secondary_inventory_name (+) = cat_onhand.subinventory_code
                 and    va.organization_id (+)          = cat_onhand.organization_id
                 and    va.valuation_type               = 'Category Accounting'
                 -- End revision for version 1.11
                 union all
                 -- ===================================================================
                 -- Part 2b: Get real-time intransit quantities for category accounting
                 -- ===================================================================
                 -- Revision for version 1.8
                 -- Use intransit_owning_org_id instead of mip FOB point for 
                 -- ownership; when the shipping network is direct edited for  
                 -- FOB point without fixing mtl_supply, you cannot use mip.
                 -- select decode(mip.fob_point,1,sup.to_organization_id,2,sup.from_organization_id) organization_id,
                 select sup.intransit_owning_org_id organization_id,
                 -- End revision for version 1.8
                        -- Revision for version 1.11
                        mp.category_organization_id,
                        mp.category_set_id,
                        null category_id,
                        sup.item_id inventory_item_id,
                        null subinventory_code,
                        null subinv_description,
                        -- End revision for version 1.11
                        mip.intransit_inv_account code_combination_id,
                        min(0) onhand_quantity,
                        sum(sup.to_org_primary_quantity) intransit_quantity
                 from   mtl_interorg_parameters mip,
                        mtl_supply sup,
                        -- Revision for version 1.11
                        mtl_system_items_vl msiv,
                        inv_organizations mp
                 where  sup.supply_type_code in ('SHIPMENT', 'RECEIVING') 
                 and    mip.from_organization_id = sup.from_organization_id 
                 and    mip.to_organization_id   = sup.to_organization_id
                 and    sup.item_id is not null -- screen out expense receipts
                 -- Revision for version 1.11
                 and    sup.item_id                 = msiv.inventory_item_id
                 and    sup.intransit_owning_org_id = msiv.organization_id
                 -- End revision for version 1.3
                 -- Revision for version 1.8
                 -- and mp.organization_id     = decode(mip.fob_point,1,sup.to_organization_id,2,sup.from_organization_id)
                 and    mp.organization_id     = sup.intransit_owning_org_id
                 -- Revision for version 1.3
                 and    :p_period_name is null          -- p_period_name
                 -- Revision for version 1.11
                 and    15=15                           -- p_item_number
                 group by
                        -- Revision for version 1.8
                        -- decode(mip.fob_point,1,sup.to_organization_id,2,sup.from_organization_id),
                        sup.intransit_owning_org_id,
                        -- Revision for version 1.11
                        mp.category_organization_id,
                        mp.category_set_id,
                        null, -- category_id
                        sup.item_id, -- inventory_item_id
                        null, -- subinventory_code
                        null, -- subinv_description
                        -- End revision for version 1.11
                        mip.intransit_inv_account
                ) allqty
         where  ml2.lookup_code                        = 3 -- Intransit
         and    ml2.lookup_type                        = 'MSC_CALENDAR_TYPE'
         group by
                allqty.organization_id,
                -- Revision for version 1.11
                allqty.category_organization_id,
                allqty.category_set_id,
                allqty.category_id,
                allqty.inventory_item_id,
                nvl(allqty.subinventory_code, ml2.meaning), -- subinventory_code
                nvl(allqty.subinv_description, ml2.meaning), -- subinv_description
                allqty.code_combination_id
        ) sumqty
        -- ===========================
        -- End of getting quantities
        -- ===========================
-- ===================================================================
-- Joins for the item master, organization, and item costs
-- ===================================================================
-- Revision for version 1.10, needed outer join
where   msiv.inventory_item_id          = sumqty.inventory_item_id (+)
and     msiv.organization_id            = sumqty.organization_id (+)
-- Revision for version 1.12
and     13=13                           -- p_include_zero_onhand_quantities, p_include_zero_cost_differences
-- Revision for version 1.7
and     msiv.primary_uom_code           = muomv.uom_code
and     misv.inventory_item_status_code = msiv.inventory_item_status_code
-- End revision for version 1.7
and     msiv.inventory_item_id          = cic1.inventory_item_id
and     msiv.organization_id            = cic1.organization_id
-- Outer join as you may have newly costed items in the new cost
-- type which were never existed in the old cost type
and     msiv.inventory_item_id          = cic2.inventory_item_id (+)
and     msiv.organization_id            = cic2.organization_id   (+)
and     msiv.organization_id            = mp.organization_id
-- Revision for version 1.11 - PII
and     msiv.inventory_item_id          = pii1.inventory_item_id (+)
and     msiv.organization_id            = pii1.organization_id (+)
and     msiv.inventory_item_id          = pii2.inventory_item_id (+)
and     msiv.organization_id            = pii2.organization_id (+)
-- End revision for version 1.11 - PII
-- ===================================================================
-- Joins for the Lookup Codes
-- ===================================================================
-- Revision for version 1.11
and     ml1.lookup_type                  = 'MTL_PLANNING_MAKE_BUY'
and     ml1.lookup_code                  = msiv.planning_make_buy_code
-- End revision for version 1.11
-- Revision for version 1.14
and     ml2.lookup_type                 = 'SYS_YES_NO'
and     ml2.lookup_code                 = cic1.defaulted_flag
and     ml3.lookup_type                 = 'CST_BONROLLUP_VAL'
and     ml3.lookup_code                 = cic1.based_on_rollup_flag
-- End revision for version 1.14
-- Lookup codes for item types
and     fcl.lookup_code (+)             = msiv.item_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- Joins for the currency exchange rates
-- ===================================================================
-- new FX rate
-- Revision for version 1.11 and 1.13 - outer join
and     mp.currency_code                = gdr1.from_currency (+)
-- old FX rate
-- Revision for version 1.11 and 1.13 - outer join
and     mp.currency_code                = gdr2.from_currency (+)
-- ===================================================================
-- Inventory valuation account joins and org joins, material account only
-- ===================================================================
-- Revision for version 1.10, needed outer join
and     sumqty.code_combination_id      = gcc.code_combination_id (+)
-- Revision for version 1.11, remove hr organization tables
order by 1,2,3,4,5,6,7,8,9,10,11