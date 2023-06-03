/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC New Items
-- Description: Report to show items which have been recently created, including various item controls, item costs (per your Costing Method), item master accounts and onhand stock, by creation date.

/* +=============================================================================+
-- | Copyright 2010 - 2022 Douglas Volz Consulting, Inc.                         |
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
-- |  Parameters:
-- |  p_creation_date_from     -- starting transaction date
-- |  p_creation_date_to       -- ending transaction date
-- |  p_include_uncosted_items -- yes/no flag to include or not include non-costed items
-- |  p_org_code               -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit         -- Operating_Unit you wish to report, leave blank for all
-- |                              operating units (optional) 
-- |  p_ledger                 -- general ledger you wish to report, leave blank for all
-- |                              ledgers (optional)
-- |
-- | Description:
-- | Report to show zero item costs in the "costing method" cost type, 
-- | the creation date and any onhand stock.
-- | 
-- | version modified on modified by description
-- | ======= =========== ============== =========================================
-- |  1.0    14 jun 2017 douglas volz   Initial coding based on the zero item cost
-- |                                    report, xxx_zero_item_cost_report.sql, version 1.3
-- |  1.1    20 Jan 2020 Douglas Volz   Added Org_Code and Operating_Unit parameters.
-- |  1.2    07 Jul 2022 Douglas Volz   Changed to multi-language views for the item
-- |                                    master and inventory orgs.  Added item master
-- |                                    accounts and costs by cost element.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-new-items/
-- Library Link: https://www.enginatics.com/reports/cac-new-items/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 fcl.meaning Item_Type,
 msiv.creation_date Item_Creation_Date,
 -- Revision for version 1.2
 msiv.inventory_item_status_code Item_Status,
 ml1.meaning Make_Buy_Code,
 -- End revision for version 1.2
&category_columns
 -- Revision for version 1.2
 fl1.meaning Allow_Costs,
 ml2.meaning Inventory_Asset,
 ml3.meaning Based_on_Rollup,
 cic.shrinkage_rate Shrinkage_Rate,
 gl.currency_code Currency_Code,
 msiv.market_price Market_Price,
 msiv.list_price_per_unit Target_or_PO_List_Price,
 nvl(cic.material_cost,0) Material_Cost,
 nvl(cic.material_overhead_cost,0) Material_Overhead_Cost,
 nvl(cic.resource_cost,0) Resource_Cost,
 nvl(cic.outside_processing_cost,0) Outside_Processing_Cost,
 nvl(cic.overhead_cost,0) Overhead_Cost,
 -- End revision for version 1.2
 nvl(cic.item_cost,0) Item_Cost,
 (select max(mmt.transaction_id)
  from mtl_material_transactions mmt
  where mmt.organization_id     = msiv.organization_id
  and mmt.inventory_item_id   = msiv.inventory_item_id) Last_Transaction_Number,
 (select mmt.transaction_date
  from mtl_material_transactions mmt
  where mmt.transaction_id in
  (select max(mmt2.transaction_id)
   from mtl_material_transactions mmt2
   where mmt2.organization_id     = msiv.organization_id
   and mmt2.inventory_item_id   = msiv.inventory_item_id)) Last_Transaction_Date,
 (select mtt.transaction_type_name
  from mtl_material_transactions mmt,
  mtl_transaction_types mtt
  where mtt.transaction_type_id = mmt.transaction_type_id
  and mmt.transaction_id in
  (select max(mmt2.transaction_id)
   from mtl_material_transactions mmt2
   where mmt2.organization_id     = msiv.organization_id
   and mmt2.inventory_item_id   = msiv.inventory_item_id)) Last_Transaction_Type,
 -- Revision for version 1.2
 muomv.uom_code UOM_Code,
 nvl((select sum(mohd.transaction_quantity)
      from mtl_onhand_quantities_detail mohd
      where mohd.inventory_item_id   = msiv.inventory_item_id
      and mohd.organization_id     = msiv.organization_id),0) Onhand_Quantity,
 -- Revision for version 1.2
 &segment_columns
 cic.creation_date Cost_Creation_Date
 -- End revision for version 1.2
from cst_item_costs cic,
 mtl_system_items_vl msiv,
 -- Revision for version 1.2
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 -- End revision for version 1.2
 mtl_parameters mp,
 fnd_common_lookups fcl,
 -- Revision for version 1.2
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 mfg_lookups ml2, -- inventory_asset_flag, SYS_YES_NO
 mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
 fnd_lookups fl1, -- allow costs, YES_NO
 gl_code_combinations gcc1,
 gl_code_combinations gcc2,
 gl_code_combinations gcc3,
 -- End revision for version 1.2
 gl_ledgers gl,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2  -- operating unit
where msiv.inventory_item_id          = cic.inventory_item_id
and mp.organization_id              = cic.organization_id
and mp.primary_cost_method          = cic.cost_type_id -- this gets the cost method
and fcl.lookup_type (+)             = 'ITEM_TYPE'
and fcl.lookup_code (+)             = msiv.item_type
and mp.organization_id             <> mp.master_organization_id     -- remove the global master org
and msiv.organization_id            = mp.organization_id
-- Revision for version 1.2
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.2
-- ===================================================================
-- Revision for version 1.2, joins to get the item master accounts
-- ===================================================================
and gcc1.code_combination_id (+)    = msiv.cost_of_sales_account
and gcc2.code_combination_id (+)    = msiv.sales_account
and gcc3.code_combination_id (+)    = msiv.expense_account
-- ===================================================================
-- Lookup codes, revision for version 1.2
-- ===================================================================
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                 = msiv.planning_make_buy_code
and ml2.lookup_type                 = 'SYS_YES_NO'
and ml2.lookup_code                 = to_char(cic.inventory_asset_flag)
and ml3.lookup_type                 = 'CST_BONROLLUP_VAL'
and ml3.lookup_code                 = cic.based_on_rollup_flag
and fl1.lookup_type                 = 'YES_NO'
and fl1.lookup_code                 = msiv.costing_enabled_flag
and fcl.lookup_type (+)             = 'ITEM_TYPE'
and fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id   -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and 1=1                             -- p_creation_date_from, p_creation_date_to, p_org_code, p_operating_unit, p_ledger
union all
-- ===================================================================
-- Now get the items where they are defined in the item master but not
-- in the cost master.  These items have no cost at all, not even zero.
-- ===================================================================
select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 fcl.meaning Item_Type,
 msiv.creation_date Item_Creation_Date,
 -- Revision for version 1.2
 msiv.inventory_item_status_code Item_Status,
 ml1.meaning Make_Buy_Code,
 -- End revision for version 1.2
&category_columns
 -- Revision for version 1.2
 fl1.meaning Allow_Costs,
 ml2.meaning Inventory_Asset,
 ml3.meaning Based_on_Rollup,
 null Shrinkage_Rate,
 gl.currency_code Currency_Code,
 msiv.market_price Market_Price,
 msiv.list_price_per_unit Target_or_PO_List_Price,
 null Material_Cost,
 null Material_Overhead_Cost,
 null Resource_Cost,
 null Outside_Processing_Cost,
 null Overhead_Cost,
 -- End revision for version 1.2
 null Item_Cost,
 (select max(mmt.transaction_id)
  from mtl_material_transactions mmt
  where mmt.organization_id     = msiv.organization_id
  and mmt.inventory_item_id   = msiv.inventory_item_id) Last_Transaction_Number,
 (select mmt.transaction_date
  from mtl_material_transactions mmt
  where mmt.transaction_id in
  (select max(mmt2.transaction_id)
   from mtl_material_transactions mmt2
   where mmt2.organization_id     = msiv.organization_id
   and mmt2.inventory_item_id   = msiv.inventory_item_id)) Last_Transaction_Date,
 (select mtt.transaction_type_name
  from mtl_material_transactions mmt,
  mtl_transaction_types mtt
  where mtt.transaction_type_id = mmt.transaction_type_id
  and mmt.transaction_id in
  (select max(mmt2.transaction_id)
   from mtl_material_transactions mmt2
   where mmt2.organization_id     = msiv.organization_id
   and mmt2.inventory_item_id   = msiv.inventory_item_id)) Last_Transaction_Type,
 -- Revision for version 1.2
 muomv.uom_code UOM_Code,
 nvl((select sum(mohd.transaction_quantity)
      from mtl_onhand_quantities_detail mohd
      where mohd.inventory_item_id   = msiv.inventory_item_id
      and mohd.organization_id     = msiv.organization_id),0) Onhand_Quantity,
 -- Revision for version 1.2
 &segment_columns
 null Cost_Creation_Date
 -- End revision for version 1.2
from mtl_system_items_vl msiv,
 -- Revision for version 1.2
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 -- End revision for version 1.2
 mtl_parameters mp,
 fnd_common_lookups fcl,
 -- Revision for version 1.2
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 mfg_lookups ml2, -- inventory_asset_flag, SYS_YES_NO
 mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
 fnd_lookups fl1, -- allow costs, YES_NO
 gl_code_combinations gcc1,
 gl_code_combinations gcc2,
 gl_code_combinations gcc3,
 -- End revision for version 1.2
 gl_ledgers gl,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2  -- operating unit
where msiv.organization_id            = mp.organization_id
-- Revision for version 1.2
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.2
and fcl.lookup_type (+)             = 'ITEM_TYPE'
and fcl.lookup_code (+)             = msiv.item_type
and mp.organization_id             <> mp.master_organization_id     -- remove the global master org
-- End revision for version 1.3
and not exists (
 select 'x'
 from cst_item_costs cic
 where cic.organization_id     = msiv.organization_id
 and cic.inventory_item_id   = msiv.inventory_item_id
 and cic.cost_type_id        = mp.primary_cost_method     -- this gets the cost method
     )
-- ===================================================================
-- Revision for version 1.2, joins to get the item master accounts
-- ===================================================================
and gcc1.code_combination_id (+)    = msiv.cost_of_sales_account
and gcc2.code_combination_id (+)    = msiv.sales_account
and gcc3.code_combination_id (+)    = msiv.expense_account
-- ===================================================================
-- Lookup codes, revision for version 1.2
-- ===================================================================
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                 = msiv.planning_make_buy_code
and ml2.lookup_type                 = 'SYS_YES_NO'
and ml2.lookup_code                 = 2 --No
and ml3.lookup_type                 = 'CST_BONROLLUP_VAL'
and ml3.lookup_code                 = 2 -- No
and fl1.lookup_type                 = 'YES_NO'
and fl1.lookup_code                 = msiv.costing_enabled_flag
and fcl.lookup_type (+)             = 'ITEM_TYPE'
and fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id   -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and 1=1                             -- p_creation_date_from, p_creation_date_to, p_org_code, p_operating_unit, p_ledger
and 2=2                             -- p_include_uncosted_items
-- ===================================================================
-- order by ledger, operating unit, org code and item
order by 1,2,3,4,5