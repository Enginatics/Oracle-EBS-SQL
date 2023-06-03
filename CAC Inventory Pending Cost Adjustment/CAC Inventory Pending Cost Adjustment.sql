/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Pending Cost Adjustment
-- Description: Report showing the potential standard cost changes for onhand and intransit inventory value which you own.  If you enter a period name this report uses the quantities from the month-end snapshot; if you leave the period name blank it uses the real-time quantities.  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session.  And if you want to enter a period name to use the quantities from the month-end snapshot, you can only choose closed accounting periods; this is because the month-end snapshot is created when you close the inventory accounting period.

/* +=============================================================================+
-- |  Copyright 2008-2022 Douglas Volz Consulting, Inc.                          |
-- |  All rights reserved.                                                       |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Parameters:
-- |  p_cost_type1              -- The new cost type to be reported, mandatory
-- |  p_cost_type2              -- The old cost type to be reported, mandatory
-- |  p_curr_conv_date1         -- the new currency conversion date, mandatory
-- |  p_curr_conv_date2         -- the old currency conversion date, mandatory
-- |  p_curr_conv_type1         -- the desired currency conversion type to use for cost type 1, mandatory
-- |  p_curr_conv_type2         -- the desired currency conversion type to use for cost type 2, mandatory
-- |  p_to_currency_code        -- the currency you are converting into
-- |  p_period_name             -- Enter a Period Name to use the month-end snapshot; if no
-- |                               period name is entered will use the real-time quantities
-- |  p_category_set1           -- The first item category set to report, typically the
-- |                               Cost or Product Line Category Set
-- |  p_category_set2           -- The second item category set to report, typically the
-- |                               Inventory Category Set
-- |  p_include_zero_quantities -- Include items with no onhand or no intransit quantities
-- |  p_only_items_in_cost_type -- Only report items in the New Cost Type
-- |  p_item_number             -- specific item number to report, works with
-- |                               null or valid item numbers
-- |  p_org_code                -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit          -- Operating Unit you wish to report, leave blank for all
-- |                               operating units (optional) 
-- |  p_ledger                  -- general ledger you wish to report, leave blank for all
-- |                              ledgers (optional)
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 21 Nov 2010 Douglas Volz   Created initial Report for prior client
-- |                                     based on BBCI_INV_VALUE_STD_ADJ_FX_REPT1.7.sql
-- |     1.9   6 Dec 2020 Douglas Volz   Fixed logic for Percentage Difference  
-- |     1.10 15 Dec 2021 Douglas Volz   Added parameter to include zero onhand quantities
-- |     1.11 06 Jun 2022 Douglas Volz   Fix for category accounts (valuation accounts) and
-- |                                     added subinventory description.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-inventory-pending-cost-adjustment/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-pending-cost-adjustment/
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
  from mtl_category_accounts mca,
  mtl_parameters mp,
  hr_organization_information hoi,
  hr_all_organization_units_vl haou, -- inv_organization_id
  hr_all_organization_units_vl haou2, -- operating unit
  gl_ledgers gl
  where mp.organization_id              = mca.organization_id (+)
  -- Avoid the item master organization
  and mp.organization_id             <> mp.master_organization_id
  -- Avoid disabled inventory organizations
  and sysdate                        <  nvl(haou.date_to, sysdate +1)
  and hoi.org_information_context     = 'Accounting Information'
  and hoi.organization_id             = mp.organization_id
  and hoi.organization_id             = haou.organization_id   -- this gets the organization name
  and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
  and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
  and 1=1                             -- p_operating_unit, p_ledger
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                             -- p_org_code
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
  -- Revision for version 1.11
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
  from mtl_secondary_inventories msub,
  inv_organizations mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  -- Avoid organizations with category accounts
  and mp.category_organization_id is null
  and 3=3                             -- p_subinventory
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
  from mtl_secondary_inventories msub,
  inv_organizations mp
  where msub.organization_id = mp.organization_id
  and nvl(mp.cost_group_accounting,2) = 2 -- No
  and mp.primary_cost_method         <> 1 -- not Standard Costing
  -- Avoid organizations with category accounts
  and mp.category_organization_id is null
  and 3=3                             -- p_subinventory
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
  from mtl_secondary_inventories msub,
  cst_cost_group_accounts ccga,
  cst_cost_groups ccg,
  inv_organizations mp
  where msub.organization_id            = mp.organization_id
  and mp.cost_group_accounting        = 1 -- Yes
  and ccga.cost_group_id              = nvl(msub.default_cost_group_id, mp.default_cost_group_id)
  and ccga.cost_group_id              = ccg.cost_group_id
  and ccga.organization_id            = mp.organization_id
  -- Avoid organizations with category accounts
  and mp.category_organization_id is null
  and 3=3                             -- p_subinventory
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
  from inv_organizations mp,
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
   from mtl_secondary_inventories msub,
   mtl_category_accounts mca,
   inv_organizations mp
   where msub.organization_id            = mp.organization_id
   and msub.organization_id            = mca.organization_id (+)
   -- Revision for version 1.19
   -- and msub.secondary_inventory_name   = mca.subinventory_code (+)
   and msub.secondary_inventory_name   = nvl(mca.subinventory_code, msub.secondary_inventory_name)
   -- Only get organizations with category accounts
   and mp.category_organization_id is not null
   and 3=3                             -- p_subinventory
   -- For a given category_id, if a subinventory-specific category account exists
   -- exclude the category account with a null subinventory, to avoid double-counting  
   and not exists
    (select 'x'
     from mtl_category_accounts mca2
     where mca.subinventory_code is null
     and mca2.subinventory_code is not null
     and mca2.organization_id = mca.organization_id
     and mca2.category_id     = mca.category_id
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
  where mp.organization_id              = mic.organization_id
  and mp.category_set_id              = mic.category_set_id
  and mic.category_id                 = mc.category_id
  and mic.category_set_id             = mcs.category_set_id
  and mc.category_id                  = mic.category_id
  and mic.organization_id             = cat_subinv.organization_id (+)
  and mic.category_id                 = cat_subinv.category_id (+)
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
  from inv_organizations mp,
  (select ic.intransit_inv_account,
   ic.organization_id
   from (select mip.intransit_inv_account,
    mip.to_organization_id organization_id
    from mtl_interorg_parameters mip,
    inv_organizations mp
    where mip.fob_point               = 1 -- shipment
    and mp.organization_id          = mip.to_organization_id
    union all
    select mip.intransit_inv_account,
    mip.from_organization_id organization_id
    from mtl_interorg_parameters mip,
    inv_organizations mp
    where mip.fob_point               = 2 -- receipt
    and mp.organization_id          = mip.from_organization_id
   ) ic
   group by
   ic.intransit_inv_account,
   ic.organization_id
  ) interco
  where mp.organization_id = interco.organization_id
 )
-- End revision for version 1.11

----------------main query starts here--------------

-- ====================================================
-- Select operating unit and organization information
-- ====================================================

-- Revision for version 1.11
select mp.ledger       Ledger,
 mp.operating_unit      Operating_Unit,
 mp.organization_code      Org_Code,
 mp.organization_name      Organization_Name,
-- End revision for version 1.11
 :p_period_name       Period_Name,
 &segment_columns
 msiv.concatenated_segments     Item_Number,
 msiv.description      Item_Description,
 fcl.meaning       Item_Type,
 -- Revision for version 1.7
 misv.inventory_item_status_code_tl    Item_Status,
 ml1.meaning       Make_Buy_Code,
        -- Revision for version 1.5
&category_columns
 -- Revision for version 1.11
 mp.currency_code      Currency_Code,
-- ==========================================================
-- Select the new and old item costs from Cost Type 1 and 2
-- ==========================================================
 round(nvl(cic1.material_cost,0),5)    New_Material_Cost,
 round(nvl(cic2.material_cost,0),5)    Old_Material_Cost,
 round(nvl(cic1.material_overhead_cost,0),5)   New_Material_Overhead_Cost,
 round(nvl(cic2.material_overhead_cost,0),5)   Old_Material_Overhead_Cost,
 round(nvl(cic1.resource_cost,0),5)    New_Resource_Cost,
 round(nvl(cic2.resource_cost,0),5)    Old_Resource_Cost,
 round(nvl(cic1.outside_processing_cost,0),5)   New_Outside_Processing_Cost,
 round(nvl(cic2.outside_processing_cost,0),5)   Old_Outside_Processing_Cost,
 round(nvl(cic1.overhead_cost,0),5)    New_Overhead_Cost,
 round(nvl(cic2.overhead_cost,0),5)    Old_Overhead_Cost,
 round(nvl(cic1.item_cost,0),5)     New_Item_Cost,
 round(nvl(cic2.item_cost,0),5)     Old_Item_Cost,
-- ========================================================
-- Select the item costs from Cost Type 1 and 2 and compare
-- ========================================================
 round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5) Item_Cost_Difference,
 -- Revision for version 1.9
 -- round((nvl(cic1.item_cost,0) -nvl(cic2.item_cost,0))
 --     /
  -- (decode(nvl(cic2.item_cost,0),0,1,cic2.item_cost)) * 100,1) Percent_Difference,
 case
   when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = 0 then 0
   when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic1.item_cost,0),5) then  100
   when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic2.item_cost,0),5) then -100
   else round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) / nvl(cic2.item_cost,0) * 100,1)
 end        Percent_Difference,
 -- End revision for version 1.9
-- ===========================================================
-- Select the onhand and intransit quantities and values
-- ===========================================================
 sumqty.subinventory_code     Subinventory_or_Intransit,
 -- Revision for version 1.11
 sumqty.subinv_description     Subinventory_Description,
 -- Revision for version 1.7
 -- msiv.primary_uom_code      UOM_Code,
 muomv.uom_code       UOM_Code,
 -- End revision for version 1.7
 nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)  Onhand_Quantity,
 round(nvl(cic1.item_cost,0) * 
  (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) New_Onhand_Value,
 round(nvl(cic2.item_cost,0) * 
  (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) Old_Onhand_Value,
 round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) * 
  (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) Onhand_Value_Difference,
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
 gdr1.conversion_rate      New_FX_Rate,
 gdr2.conversion_rate      Old_FX_Rate,
 gdr1.conversion_rate - gdr2.conversion_rate   Exchange_Rate_Difference,
-- ===========================================================
-- Select To Currency onhand and intransit quantities and values
-- ===========================================================
-- ===========================================================
-- Costs in To Currency by Cost Element, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
 round(nvl(cic1.material_cost,0) * gdr1.conversion_rate
 * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code New Material Value",
 round(nvl(cic2.material_cost,0) * gdr2.conversion_rate
 * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code Old Material Value",
 round(nvl(cic1.material_overhead_cost,0) * gdr1.conversion_rate 
 * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code New Material Ovhd Value",
 round(nvl(cic2.material_overhead_cost,0) * gdr2.conversion_rate
 * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code Old Material Ovhd Value",
 round(nvl(cic1.resource_cost,0) * gdr1.conversion_rate
 * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code New Resource Value",
 round(nvl(cic2.resource_cost,0) * gdr2.conversion_rate
 * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code Old Resource Value",
 round(nvl(cic1.outside_processing_cost,0) * gdr1.conversion_rate
 * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code New OSP Value",
 round(nvl(cic2.outside_processing_cost,0) * gdr2.conversion_rate
 * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code Old OSP Value",
 round(nvl(cic1.overhead_cost,0) * gdr1.conversion_rate
 * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code New Overhead Value",
 round(nvl(cic2.overhead_cost,0) * gdr2.conversion_rate
 * (nvl(sumqty.onhand_quantity,0) + nvl(sumqty.intransit_quantity,0)),2) "&p_to_currency_code Old Overhead Value",
-- ===========================================================
-- Onhand Values in To Currency, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
 round(nvl(cic1.item_cost,0) * gdr1.conversion_rate *
  (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code New Onhand Value",
 round(nvl(cic2.item_cost,0) * gdr2.conversion_rate *
  (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code Old Onhand Value",
 -- USD New Onhand Cost - USD Old Onhand Cost
 round(( (nvl(cic1.item_cost,0) * gdr1.conversion_rate) -
  (nvl(cic2.item_cost,0) * gdr2.conversion_rate)) *
 -- multiplied by the total onhand quantity 
  (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code Onhand Value Diff.",
-- ===========================================================
-- Value Differences in To Currency using the new rate
-- New and Old costs at New Fx Rate
-- ===========================================================
 -- NEW COST at new fx conversion rate minus OLD COST at new fx conversion rate
 round(( (nvl(cic1.item_cost,0) * gdr1.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr1.conversion_rate)) *
 -- multiplied by the total onhand quantity
  (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code Value Difference-New Rate",
-- ===========================================================
-- Value Differences in To Currency using the old rate
-- New and Old costs at Old Fx Rate
-- ===========================================================
 -- NEW COST at old fx conversion rate minus OLD COST at old fx conversion rate
 round(( (nvl(cic1.item_cost,0) * gdr2.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr2.conversion_rate)) *
 -- multiplied by the total onhand quantity
  (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code Value Difference-Old Rate",
-- ===========================================================
-- Value Differences comparing the new less the old rate differences
-- ===========================================================
 -- USD Value Diff-New Rate less USD Value Diff-Old Rate
 -- USD Value Diff-New Rate
 round(( (nvl(cic1.item_cost,0) * gdr1.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr1.conversion_rate)) *
  (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) -
 -- USD Value Diff-Old Rate
 round(( (nvl(cic1.item_cost,0) * gdr2.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr2.conversion_rate)) *
  (nvl(sumqty.intransit_quantity,0) + nvl(sumqty.onhand_quantity,0)),2) "&p_to_currency_code Value FX Difference."
from mtl_system_items_vl msiv,
 -- Revision for version 1.7
 mtl_units_of_measure_vl muomv,
 mtl_item_status_vl misv, 
 -- End revision for version 1.7
 -- Revision for version 1.3
 -- org_acct_periods oap,
 mfg_lookups ml1,
 fnd_common_lookups fcl,
 -- Revision for version 1.11
 gl_code_combinations gcc,
 inv_organizations mp,
 -- End revision for version 1.11
 -- ===========================================================================
 -- Select New Currency Rates based on the new concurrency conversion date
 -- ===========================================================================
 (select gdr1.from_currency,
  gdr1.to_currency,
  gdct1.user_conversion_type,
  gdr1.conversion_date,
  gdr1.conversion_rate
  from gl_daily_rates gdr1,
  gl_daily_conversion_types gdct1
  where exists (
   select 'x'
   -- Revision for version 1.11, replace hr organization tables with inv_organizations
   from inv_organizations mp
   where gdr1.to_currency              = mp.currency_code
      )
  and exists (
   select 'x'
   -- Revision for version 1.11, replace hr organization tables with inv_organizations
   from inv_organizations mp
   where gdr1.from_currency            = mp.currency_code
      )
  and gdr1.conversion_type       = gdct1.conversion_type
  and 4=4                        -- p_curr_conv_date1
  and 5=5                        -- p_curr_conv_type1
  union all
  select gl.currency_code,              -- from_currency
  gl.currency_code,              -- to_currency
  gdct1.user_conversion_type,    -- user_conversion_type
  :p_curr_conv_date1,            -- conversion_date                                             -- p_curr_conv_date1
  1                              -- conversion_rate
  from gl_ledgers gl,
  gl_daily_conversion_types gdct1
  where 5=5                            -- p_curr_conv_type1
  group by
  gl.currency_code,
  gl.currency_code,
  gdct1.user_conversion_type,                                                                  -- p_curr_conv_date1
  :p_curr_conv_date1,           -- conversion_date                                             -- p_curr_conv_date1
  1
 ) gdr1, -- NEW Currency Rates
 -- ===========================================================================
 -- Select Old Currency Rates based on the old concurrency conversion date
 -- ===========================================================================
 (select gdr2.from_currency,
  gdr2.to_currency,
  gdct2.user_conversion_type,
  gdr2.conversion_date,
  gdr2.conversion_rate
  from gl_daily_rates gdr2,
  gl_daily_conversion_types gdct2
  where exists (
   select 'x'
   -- Revision for version 1.11, replace hr organization tables with inv_organizations
   from inv_organizations mp
   where gdr2.to_currency              = mp.currency_code
      )
  and exists (
   select 'x'
   -- Revision for version 1.11, replace hr organization tables with inv_organizations
   from inv_organizations mp
   where gdr2.from_currency            = mp.currency_code
      )
  and gdr2.conversion_type       = gdct2.conversion_type
  and 6=6                        -- p_curr_conv_date2 
  and 7=7                        -- p_curr_conv_type2
  union all
  select gl.currency_code,              -- from_currency
  gl.currency_code,              -- to_currency
  gdct2.user_conversion_type,    -- user_conversion_type
  :p_curr_conv_date2,            -- conversion_date                                             -- p_curr_conv_date2
  1                              -- conversion_rate 
  from gl_ledgers gl,
  gl_daily_conversion_types gdct2
  where 7=7                            -- p_curr_conv_type2
  group by
  gl.currency_code,
  gl.currency_code,
  gdct2.user_conversion_type,
  :p_curr_conv_date2,            -- conversion_date                                             -- p_curr_conv_date2
  1
 ) gdr2,  -- OLD Currency Rates
 -- ===========================================================================
 -- GET THE ITEM COSTS FOR COST TYPE 1
 -- ===========================================================================
 (select cic1.organization_id    organization_id,
  cic1.inventory_item_id    inventory_item_id,
  nvl(cic1.material_cost,0)  material_cost,
   nvl(cic1.material_overhead_cost,0) material_overhead_cost,
  nvl(cic1.resource_cost,0)  resource_cost,
  nvl(cic1.outside_processing_cost,0) outside_processing_cost,
  nvl(cic1.overhead_cost,0)  overhead_cost,
  nvl(cic1.item_cost,0)   item_cost
  from cst_item_costs cic1,
  cst_cost_types cct1,
   -- Revision for version 1.11
  mtl_system_items_vl msiv,
  inv_organizations mp
  -- End revision for version 1.11
  where cct1.cost_type_id           = cic1.cost_type_id
  and cic1.organization_id        = mp.organization_id
  -- Revision for version 1.11
  and msiv.organization_id        = cic1.organization_id
  and msiv.inventory_item_id      = cic1.inventory_item_id
  -- End revision for version 1.11
  and 8=8                         -- p_cost_type1
  -- Revision for version 1.11
  and 15=15                       -- p_item_number
  union all
  -- =============================================================
  -- Get the costs from the frozen cost type that is not in cost
  -- type 1 so that all of the inventory value is reported
  -- =============================================================
  select cic_frozen.organization_id    organization_id,
  cic_frozen.inventory_item_id    inventory_item_id,
  nvl(cic_frozen.material_cost,0)   material_cost,
   nvl(cic_frozen.material_overhead_cost,0) material_overhead_cost,
  nvl(cic_frozen.resource_cost,0)   resource_cost,
  nvl(cic_frozen.outside_processing_cost,0) outside_processing_cost,
  nvl(cic_frozen.overhead_cost,0)   overhead_cost,
  nvl(cic_frozen.item_cost,0)   item_cost
  from cst_item_costs cic_frozen,
  cst_cost_types cct1,
   -- Revision for version 1.11
  mtl_system_items_vl msiv,
  inv_organizations mp
  -- End revision for version 1.11
  -- Revision for version 1.8 
  where cic_frozen.cost_type_id     = mp.primary_cost_method   -- get the frozen costs for the standard cost update
  -- Revision for version 1.11
  and msiv.organization_id        = cic_frozen.organization_id
  and msiv.inventory_item_id      = cic_frozen.inventory_item_id
  -- End revision for version 1.11
  and 8=8                         -- p_cost_type1
  -- =============================================================
  -- If p_cost_type1 = frozen cost_type_id then we have all the 
  -- costs and don't need this union all statement
  -- Changed the default cost type from 1 (Frozen) to the primary_
  -- cost_method so you can use this report for any Costing Method.
  -- =============================================================
  and cct1.cost_type_id    <> mp.primary_cost_method   -- frozen cost type
  and cic_frozen.organization_id  = mp.organization_id
  -- Revision for version 1.10, parameter to only_items_in_cost_type
  and 14=14
  -- Revision for version 1.11
  and 15=15                       -- p_item_number
  -- =============================================================
  -- Check to see if the costs exist in cost type 1 
  -- =============================================================
  and not exists (
   select 'x'
   from cst_item_costs cic1
   where cic1.cost_type_id      = cct1.cost_type_id
   and cic1.organization_id   = cic_frozen.organization_id
   and cic1.inventory_item_id = cic_frozen.inventory_item_id
      )
  ) cic1,
 -- ===========================================================================
 -- GET THE ITEM COSTS FOR COST TYPE 2
 -- ===========================================================================
 (select cic2.organization_id    organization_id,
  cic2.inventory_item_id    inventory_item_id,
  nvl(cic2.material_cost,0)  material_cost,
   nvl(cic2.material_overhead_cost,0) material_overhead_cost,
  nvl(cic2.resource_cost,0)  resource_cost,
  nvl(cic2.outside_processing_cost,0) outside_processing_cost,
  nvl(cic2.overhead_cost,0)  overhead_cost,
  nvl(cic2.item_cost,0)   item_cost
  from cst_item_costs cic2,
  cst_cost_types cct2,
   -- Revision for version 1.11
  mtl_system_items_vl msiv,
  inv_organizations mp
  -- End revision for version 1.11
  where cct2.cost_type_id           = cic2.cost_type_id
  and cic2.organization_id        = mp.organization_id
  -- Revision for version 1.11
  and msiv.organization_id        = cic2.organization_id
  and msiv.inventory_item_id      = cic2.inventory_item_id
  -- End revision for version 1.11
  and 10=10                       -- p_cost_type2
  -- Revision for version 1.11
  and 15=15                       -- p_item_number
  union all
  -- =============================================================
  -- Get the costs from the frozen cost type that is not in cost
  -- type 2 so that all of the inventory value is reported
  -- =============================================================
  select cic_frozen.organization_id    organization_id,
  cic_frozen.inventory_item_id    inventory_item_id,
  nvl(cic_frozen.material_cost,0)   material_cost,
   nvl(cic_frozen.material_overhead_cost,0) material_overhead_cost,
  nvl(cic_frozen.resource_cost,0)   resource_cost,
  nvl(cic_frozen.outside_processing_cost,0) outside_processing_cost,
  nvl(cic_frozen.overhead_cost,0)   overhead_cost,
  nvl(cic_frozen.item_cost,0)   item_cost
  from cst_item_costs cic_frozen,
  cst_cost_types cct2,
   -- Revision for version 1.11
  mtl_system_items_vl msiv,
  inv_organizations mp
  -- End revision for version 1.11
  -- Revision for version 1.8
  where cic_frozen.cost_type_id     = mp.primary_cost_method  -- get the frozen costs for the standard cost update
  -- Revision for version 1.11
  and msiv.organization_id        = cic_frozen.organization_id
  and msiv.inventory_item_id      = cic_frozen.inventory_item_id
  -- End revision for version 1.11
  -- =============================================================
  -- If p_cost_type2 = frozen cost_type_id then we have all the 
  -- costs and don't need this union all statement
  -- Changed the default cost type from 1 (Frozen) to the primary_
  -- cost_method so you can use this report for any Costing Method.
  -- =============================================================
  and cct2.cost_type_id    <> mp.primary_cost_method  -- frozen cost type
  and cic_frozen.organization_id  = mp.organization_id
  and 10=10                       -- p_cost_type2
  -- Revision for version 1.11
  and 15=15                       -- p_item_number
  -- =============================================================
  -- Check to see if the costs exist in cost type 1 
  -- =============================================================
  and not exists (
   select 'x'
   from cst_item_costs cic2
   where cic2.cost_type_id      = cct2.cost_type_id
   and cic2.organization_id   = cic_frozen.organization_id
   and cic2.inventory_item_id = cic_frozen.inventory_item_id
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
  null category_id,
  cpcs.inventory_item_id,
  nvl(cpcs.subinventory_code, ml2.meaning) subinventory_code,
  nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml2.meaning) subinv_description,
  va.material_account code_combination_id,
  -- End revision for version 1.11
  sum(decode(cpcs.subinventory_code, null, 0, cpcs.rollback_quantity)) onhand_quantity,
  sum(decode(cpcs.subinventory_code, null, cpcs.rollback_quantity, 0)) intransit_quantity
   from cst_period_close_summary cpcs,
  org_acct_periods  oap,
  mtl_secondary_inventories msub,
  -- Revision for version 1.11
  -- mtl_parameters  mp
  mtl_system_items_vl  msiv,
  inv_organizations  mp,
  valuation_accounts  va,
  mfg_lookups   ml2
  -- End revision for version 1.11
  where cpcs.acct_period_id  = oap.acct_period_id
  and mp.organization_id  = oap.organization_id
  and cpcs.subinventory_code          = msub.secondary_inventory_name (+)
  and cpcs.organization_id            = msub.organization_id (+)
  -- Revision for version 1.11
  and mp.category_organization_id is null
  and cpcs.inventory_item_id          = msiv.inventory_item_id
  and cpcs.organization_id            = msiv.organization_id
  and va.secondary_inventory_name (+) = nvl(cpcs.subinventory_code,'Intransit')
  and va.organization_id (+)          = cpcs.organization_id
  and va.valuation_type              <> 'Category Accounting'
  and ml2.lookup_code   = 3 -- Intransit
  and ml2.lookup_type   = 'MSC_CALENDAR_TYPE'
  -- End revision for version 1.11
  -- Revision for version 1.3
  and 11=11                           -- p_period_name oap.period_name = :p_period_name
  and :p_period_name is not null      -- p_period_name
  -- Revision for version 1.11
  and 15=15                           -- p_item_number
  and nvl(cpcs.rollback_quantity,0) <> 0
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
  from -- Inner select to have consistent outer joins with valuation accounts
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
   from -- Inner select to have consistent outer joins with categories
   mtl_item_categories mic,
   (select mp.organization_id,
    mp.category_organization_id,
    mp.category_set_id,
    msiv.inventory_item_id,
    cpcs.subinventory_code,
    regexp_replace(msub.description,'[^[:alnum:]'' '']', null) subinv_description,
    sum(decode(cpcs.subinventory_code, null, 0, cpcs.rollback_