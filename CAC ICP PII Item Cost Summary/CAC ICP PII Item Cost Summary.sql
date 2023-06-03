/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII Item Cost Summary
-- Description: Report to show item costs in any cost type, including the profit in inventory costs (also known as ICP or PII).  For one or more inventory organizations.

/* +=============================================================================+
-- | Copyright 2009-2022 Douglas Volz Consulting, Inc.                           |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_cost_rept.sql
-- |
-- |  Parameters:
-- |  p_cost_type              -- The cost type you wish to report
-- |  p_pii_cost_type          -- The new PII Cost Type you wish to report
-- |  p_pii_sub_element        -- The sub-element or resource for profit in inventory,
-- |                              such as PII or ICP (mandatory)
-- |  p_ledger                 -- general ledger you wish to report, works with
-- |                              null or valid ledger names
-- |  p_item_number            -- Enter the specific item number you wish to report
-- |  p_org_code               -- specific organization code, works with
-- |                              null or valid organization codes
-- |  p_include_uncosted_items -- Yes/No flag to include or not include non-costed resources
-- |  p_category_set1          -- The first item category set to report, typically the
-- |                              Cost or Product Line Category Set
-- |  p_category_set2          -- The second item category set to report, typically the
-- |                              Inventory Category Set
-- |
-- | Description:
-- | Report to show item costs in any cost type
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0     06 Oct 2009 Douglas Volz  Initial Coding
-- |  1.1     16 Mar 2010 Douglas Volz  Updated with Make/Buy flags
-- |  1.2     08 Nov 2010 Douglas Volz  Updated with additional columns and parameters
-- |  1.3     07 Feb 2011 Douglas Volz  Added COGS and Revenue default accounts
-- |  1.4     15 Nov 2016 Douglas Volz  Added category information
-- |  1.5     27 Jan 2020 Douglas Volz  Added Org Code and Operating Unit parameters
-- |  1.6     27 Apr 2020 Douglas Volz  Changed to multi-language views for the item
-- |                                    master, inventory orgs and operating units.
-- |  1.7     21 Jun 2020 Douglas Volz  Changed to multi-language views for item 
-- |                                    status and UOM.
-- |  1.8     24 Sep 2020 Douglas Volz  Added List Price to report
-- |  1.9     29 Jan 2021 Douglas Volz  Added item master dates and Inactive Items parameter
+=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-icp-pii-item-cost-summary/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-item-cost-summary/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
-- ===================================================================
-- First get the items which are costing enabled 
-- ===================================================================
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 cct.cost_type Cost_Type,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 -- Revision for version 1.7
 muomv.uom_code UOM_Code,
 fcl.meaning Item_Type,
 misv.inventory_item_status_code Item_Status,
 -- End revision for version 1.7
 ml1.meaning Make_Buy_Code,
 -- Revision for version 1.4
&category_columns
 fl1.meaning Allow_Costs,
 ml2.meaning Inventory_Asset,
 ml3.meaning Based_on_Rollup,
 cic.shrinkage_rate Shrinkage_Rate,
 gl.currency_code Currency_Code,
 -- Revision for version 1.8
 msiv.market_price Market_Price,
 msiv.list_price_per_unit Target_or_PO_List_Price,
 -- End revision for version 1.8
 nvl(cic.material_cost,0) Material_Cost,
 nvl(cic.material_overhead_cost,0) Material_Overhead_Cost,
 nvl(cic.resource_cost,0) Resource_Cost,
 nvl(cic.outside_processing_cost,0) Outside_Processing_Cost,
 nvl(cic.overhead_cost,0) Overhead_Cost,
        nvl(cic.item_cost,0) Item_Cost,
 -- ==========================================================================
 -- Revision for version 1.5, add in ICP or PII unit costs
 -- ==========================================================================
 round(
     nvl((select sum(nvl(cicd.item_cost,0))
   from cst_item_cost_details cicd,
   cst_cost_types cct,
   bom_resources br
   where cicd.inventory_item_id = msiv.inventory_item_id
   and cicd.organization_id   = msiv.organization_id
   and br.resource_id         = cicd.resource_id
   and cct.cost_type_id       = cicd.cost_type_id
   and 6=6                    -- pii_cost_type
   and 7=7                    -- p_pii_sub_element
  ), 0),5) PII_Costs,
 -- ==========================================================================
 -- End revision for version 1.5
 -- ========================================================================== 
 -- Fix for version 1.3
 &segment_columns
 -- End fix for version 1.3
 cic.creation_date Cost_Creation_Date,
 cic.last_update_date Last_Cost_Update_Date,
 -- Revision for version 1.9
 msiv.creation_date Item_Creation_Date,
 msiv.last_update_date Item_Last_Update_Date
from cst_item_costs cic,
 cst_cost_types cct,
 mtl_system_items_vl msiv,
 -- Revision for version 1.7
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 -- End revision for version 1.7
 mtl_parameters mp,
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 mfg_lookups ml2, -- inventory_asset_flag, SYS_YES_NO
 mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
 fnd_lookups fl1, -- allow costs, YES_NO
 fnd_common_lookups fcl,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl,
 -- Fix for version 1.3
 gl_code_combinations gcc1,
 gl_code_combinations gcc2
 -- End fix for version 1.3
-- ===================================================================
-- Item master, organization and item master to cost joins
-- ===================================================================
where mp.organization_id           = msiv.organization_id
and msiv.inventory_item_id       = cic.inventory_item_id
and msiv.organization_id         = cic.organization_id
-- Revision for version 1.7
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.7
and cic.cost_type_id             = cct.cost_type_id
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and 1=1                          -- p_item_number, p_org_code, p_operating_unit, p_ledger
and 4=4                          -- p_cost_type
-- ===================================================================
-- Don't report the unused inventory organizations
-- ===================================================================
and mp.organization_id          <> mp.master_organization_id    -- remove the global master org
-- ===================================================================
-- Lookup codes
-- ===================================================================
and ml1.lookup_type              = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code              = msiv.planning_make_buy_code
and ml2.lookup_type              = 'SYS_YES_NO'
and ml2.lookup_code              = to_char(cic.inventory_asset_flag)
and ml3.lookup_type              = 'CST_BONROLLUP_VAL'
and ml3.lookup_code              = cic.based_on_rollup_flag
and fl1.lookup_type              = 'YES_NO'
and fl1.lookup_code              = msiv.costing_enabled_flag
and fcl.lookup_code (+)          = msiv.item_type
and fcl.lookup_type (+)          = 'ITEM_TYPE'
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and hoi.org_information_context  = 'Accounting Information'
and hoi.organization_id          = mp.organization_id
and hoi.organization_id          = haou.organization_id   -- this gets the organization name
and haou2.organization_id        = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                 = to_number(hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- ===================================================================
-- Fix for version 1.3
-- joins to get the COGS and revenue accounts
-- ===================================================================
and gcc1.code_combination_id (+) = msiv.cost_of_sales_account
and gcc2.code_combination_id (+) = msiv.sales_account
-- End fix for version 1.3
union all
-- ===================================================================
-- Now get the items which are not costing enabled 
-- ===================================================================
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 null Cost_Type,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 -- Revision for version 1.7
 muomv.uom_code UOM_Code,
 fcl.meaning Item_Type,
 misv.inventory_item_status_code Item_Status,
 -- End revision for version 1.7
 ml1.meaning Make_Buy_Code,
 -- Revision for version 1.4
&category_columns
 fl1.meaning Allow_Costs,
 fl2.meaning Inventory_Asset,
 'N/A' Based_on_Rollup,
 null Shrinkage_Rate,
 gl.currency_code Currency_Code,
 -- Revision for version 1.8
 msiv.market_price Market_Price,
 msiv.list_price_per_unit Target_or_PO_List_Price,
 -- End revision for version 1.8
 null Material_Cost,
 null Material_Overhead_Cost,
 null Resource_Cost,
 null Outside_Processing_Cost,
 null Overhead_Cost,
        null Item_Cost,
        -- Revision for version 1.5
        null PII_Costs,
 -- Fix for version 1.3
 &segment_columns
 null Cost_Creation_Date,
 null Last_Cost_Update_Date,
 -- Revision for version 1.9
 msiv.creation_date Item_Creation_Date,
 msiv.last_update_date Item_Last_Update_Date
from mtl_system_items_vl msiv,
 -- Revision for version 1.7
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 -- End revision for version 1.7
 mtl_parameters mp,
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 fnd_lookups fl1, -- inventory_asset_flag, YES_NO
 fnd_lookups fl2, -- allow costs, YES_NO
 fnd_common_lookups fcl,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl,
 -- Fix for version 1.3
 gl_code_combinations gcc1,
 gl_code_combinations gcc2
 -- End fix for version 1.3
-- ===================================================================
-- Item master, organization and item master to cost joins
-- ===================================================================
where mp.organization_id              = msiv.organization_id
-- Revision for version 1.7
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.7
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and 1=1                             -- p_item_number, p_org_code, p_operating_unit, p_ledger
-- Include or exclude uncosted items
and 5=5                             -- p_include_uncosted_items
-- ===================================================================
-- Find items where the item has no cost information
-- ===================================================================
and msiv.costing_enabled_flag       = 'N'
-- ===================================================================
-- Don't report the unused inventory organizations
and    mp.organization_id              <> mp.master_organization_id    -- remove the global master org
-- ===================================================================
-- Lookup codes
-- ===================================================================
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                 = msiv.planning_make_buy_code
and fl1.lookup_type                 = 'YES_NO'
and fl1.lookup_code                 = msiv.costing_enabled_flag
and fl2.lookup_type                 = 'YES_NO'
and fl2.lookup_code                 = msiv.inventory_asset_flag
and fcl.lookup_code (+)             = msiv.item_type
and fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id   -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- ===================================================================
-- Fix for version 1.3
-- joins to get the COGS and revenue accounts
-- ===================================================================
and gcc1.code_combination_id (+)    = msiv.cost_of_sales_account
and gcc2.code_combination_id (+)    = msiv.sales_account
-- order by Ledger, Operating_Unit, Org_Code, Item and Cost_Type
order by 1,2,3,4,5