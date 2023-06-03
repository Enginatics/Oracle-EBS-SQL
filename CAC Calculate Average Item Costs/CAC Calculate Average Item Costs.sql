/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Calculate Average Item Costs
-- Description: Using purchase order receipts, calculate average item costs over a specified transaction date range and compare against the Comparison Cost Type.  In addition, with the Use Default Material Overheads parameter you can choose which material overheads to use on this report.  Select Yes to use the Default Material Overhead setups.  Set to No to use the material overheads from the specified Comparison Cost Type.  And if planning to use roll up these item costs, to avoid doubling up rolled up material costs on assemblies, choose Yes for the parameter Exclude Rolled Up Items, to avoid having manually defined material costs and rolled up material costs.   

Parameters:
===========
Transaction Date From:  enter the starting transaction date for PO Receipt History (mandatory).
Transaction Date To:  enter the ending transaction date for PO Receipt History (mandatory).
Comparison Cost Type: enter the cost type to compare against the calculated average item costs (mandatory).  If the costs are not found in the Comparison Cost Type get them from the Costing Method Cost Type.
Use Default Material Overheads:  set to Yes to report the material overheads based on the Default Material Overhead setups.  Set to No to use the material overheads from the specified Comparison Cost type (mandatory).
Only Active Rates:  Set to Yes to only get active, enabled default material overhead rates (mandatory).
Exclude Rolled Up Items: To avoid doubling up rolled up material costs, choose Yes for this parameter, to avoid having manually defined material costs and rolled up material costs (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Supplier Type to Exclude:  enter the specific supplier(s) you wish to exclude from the average cost calculations (optional).
Item Status to Exclude:  enter the item number status you want to exclude.  Defaulted to 'Inactive'.
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2006 - 2023 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     05 Jan 2019 Douglas Volz   Initial Coding based on item_cost_history.sql
-- | 1.6     03 Jun 2020 Douglas Volz   Changed to multi-language views.
-- | 1.7     13 Jul 2020 Douglas Volz   Added item costs to report
-- | 1.8     29 Jun 2022 Douglas Volz   Default Cost Type parameter to Costing Method.
-- | 1.10    14 Nov 2022 Douglas Volz   Add logic and parameter for material overheads.
-- | 1.11    17 Nov 2022 Douglas Volz   Add parameter for excluding rolled up items.
-- | 1.12    18 Nov 2022 Douglas Volz   Get item costs from the cost type or primary cost method.
-- | 1.13    01 Dec 2022 Douglas Volz   Correct basis type calculations.
-- | 1.14    07 Dec 2022 Douglas Volz   Performance improvements.  Added Item Status parameter.
-- | 1.15    10 Jan 2023 Douglas Volz   Fix for Average Cost calculations, UOM issue.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-calculate-average-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-calculate-average-item-costs/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 cicd_moh.organization_code Org_Code,
 cicd_moh.concatenated_segments Item_Number,
 cicd_moh.description Item_Description,
 -- Revision for version 1.2
 fcl.meaning Item_Type,
 -- Revision for version 1.10
 ml1.meaning Make_Buy_Code,
 -- Revision for version 1.11
 ml2.meaning Based_on_Rollup,
 -- Revision for version 1.6
 misv.inventory_item_status_code_tl Item_Status,
 cic.lot_size Lot_Size,
 -- Revision for version 1.3
&category_columns
 -- Revision for version 1.6
 muomv.uom_code UOM_Code,
 receipts.sum_primary_quantity Sum_Primary_Quantity,
 -- Revision for version 1.4
 gl.currency_code Currency_Code,
 receipts.sum_po_receipts Sum_PO_Receipts,
 receipts.average_material_cost Average_Material_Cost,
 -- Revision for version 1.12
 cic.cost_type Comparison_Cost_Type,
 -- Revision for version 1.7 
 round(nvl(cic.unburdened_cost,0),5) Comparison_Material_Cost,
 -- Difference = Avg Item Cost - Item Cost
 receipts.average_material_cost - round(nvl(cic.unburdened_cost,0),5) Material_Cost_Difference,
 -- Revision for version 1.10
 -- case
 --   when difference = 0 then 0
 --   when comparison item cost = 0 then 100%
 --   when average PO unit price = 0 then -100%
 --   else (average PO unit price - comparison item cost) / comparison item cost
 round(case
  when receipts.average_material_cost - nvl(cic.unburdened_cost,0) = 0 then 0
  when nvl(cic.unburdened_cost,0) = 0 then 100
  when receipts.average_material_cost = 0 then -100
  else (receipts.average_material_cost - nvl(cic.unburdened_cost,0)) / nvl(cic.unburdened_cost,0) * 100
       end,3) Percent_Difference,
 -- End of revision for version 1.7 and 1.10
 -- Revision for version 1.10
 -- Add in material overheads
 -- sum((so much per item) + (lot/lot size) + ((item cost - TL moh4) X rate))
 decode(:p_use_default_matl_ovhds,
  'Y', decode(cicd_moh.planning_make_buy_code,
   1, nvl((round(default_moh.make_item_rate,5) + round(default_moh.make_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.make_total_value_rate,5) + round(default_moh.make_activity_rate,5) +
    round(default_moh.all_item_rate,5) + round(default_moh.all_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.all_total_value_rate,5) + round(default_moh.all_activity_rate,5)),0),
   2, nvl((round(default_moh.buy_item_rate,5) + round(default_moh.buy_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.buy_total_value_rate,5) + round(default_moh.buy_activity_rate,5) +
    round(default_moh.all_item_rate,5) + round(default_moh.all_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.all_total_value_rate,5) + round(default_moh.all_activity_rate,5)),0)),
  'N', nvl((round(cicd_moh.item_rate,5) + round(cicd_moh.lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
   round(receipts.average_material_cost * cicd_moh.total_value_rate,5) + round(cicd_moh.activity_rate,5)),0)
     ,0) Material_Overhead_Cost,
 receipts.average_material_cost +
 decode(:p_use_default_matl_ovhds,
  'Y', decode(cicd_moh.planning_make_buy_code,
   1, nvl((round(default_moh.make_item_rate,5) + round(default_moh.make_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.make_total_value_rate,5) + round(default_moh.make_activity_rate,5) +
    round(default_moh.all_item_rate,5) + round(default_moh.all_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.all_total_value_rate,5) + round(default_moh.all_activity_rate,5)),0),
   2, nvl((round(default_moh.buy_item_rate,5) + round(default_moh.buy_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.buy_total_value_rate,5) + round(default_moh.buy_activity_rate,5) +
    round(default_moh.all_item_rate,5) + round(default_moh.all_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.all_total_value_rate,5) + round(default_moh.all_activity_rate,5)),0)),
  'N', nvl((round(cicd_moh.item_rate,5) + round(cicd_moh.lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
   round(receipts.average_material_cost * cicd_moh.total_value_rate,5) + round(cicd_moh.activity_rate,5)),0)
     ,0) Total_Average_Item_Cost,
 nvl(cic.item_cost,0) Total_Comparison_Item_Cost,
 receipts.average_material_cost +
 decode(:p_use_default_matl_ovhds,
  'Y', decode(cicd_moh.planning_make_buy_code,
   1, nvl((round(default_moh.make_item_rate,5) + round(default_moh.make_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.make_total_value_rate,5) + round(default_moh.make_activity_rate,5) +
    round(default_moh.all_item_rate,5) + round(default_moh.all_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.all_total_value_rate,5) + round(default_moh.all_activity_rate,5)),0),
   2, nvl((round(default_moh.buy_item_rate,5) + round(default_moh.buy_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.buy_total_value_rate,5) + round(default_moh.buy_activity_rate,5) +
    round(default_moh.all_item_rate,5) + round(default_moh.all_lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
    round(receipts.average_material_cost * default_moh.all_total_value_rate,5) + round(default_moh.all_activity_rate,5)),0)),
  'N', nvl((round(cicd_moh.item_rate,5) + round(cicd_moh.lot_rate/decode(cic.lot_size,0, 1, null, 1, cic.lot_size),5) +
   round(receipts.average_material_cost * cicd_moh.total_value_rate,5) + round(cicd_moh.activity_rate,5)),0)
     ,0) - nvl(cic.item_cost,0) Total_Cost_Difference
from -- Revision for version 1.6
 mtl_units_of_measure_vl muomv,
 mtl_item_status_vl misv, 
 -- End revision for version 1.6
 -- Revision for version 1.2
 fnd_common_lookups fcl,
 -- Revision for version 1.10
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 mfg_lookups ml2, -- based on rollup, CST_BONROLLUP_VAL
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl,
 -- Revision for version 1.10
 -- Calculate the Average PO Receipt Costs
 -- Add Hint from Oracle's 12.2.4 package cstpmecs, procedure cstpapor
 (select /*+ NO_UNNEST */
  mmt.organization_id,
  mmt.inventory_item_id,
  sum(mmt.primary_quantity) sum_primary_quantity,
  -- Revision for version 1.15
  -- PO Unit Price * Conversion to Primary UOM * Primary Quantity
  -- round(sum(nvl(mmt.transaction_cost,0) * mmt.transaction_quantity/mmt.primary_quantity * mmt.primary_quantity),2) sum_po_receipts,
  -- round(sum(nvl(mmt.transaction_cost,0) * mmt.transaction_quantity/mmt.primary_quantity * mmt.primary_quantity) /
  --  decode(sum(mmt.transaction_quantity * mmt.transaction_quantity/mmt.primary_quantity),
  --   0,1,
  --   sum(mmt.transaction_quantity * mmt.transaction_quantity/mmt.primary_quantity)
  --        ),5) average_material_cost
  -- PO Unit Price in Primary UOM * Primary Quantity
  round(sum(nvl(mmt.transaction_cost,0) * mmt.primary_quantity),2) sum_po_receipts,
  round(sum(nvl(mmt.transaction_cost,0) * mmt.primary_quantity) /
   decode(sum(mmt.primary_quantity),
    0,1,
    sum(mmt.primary_quantity)
         ),5) average_material_cost
  -- End revision for version 1.15
  from mtl_material_transactions mmt,
  rcv_transactions rt,
  mtl_system_items_vl msiv,
  mtl_parameters mp,
  po_vendors pv,
  fnd_lookup_values_vl flvv
  -- Revision for version 1.10, from Oracle's 12.2.4 Cost Mass Edit for PO Receipts, package cstpmecs, procedure cstpapor
  -- mmt.transaction_source_type_id = 1 -- purchase orders
  where (
   (    mmt.transaction_source_type_id  = 1
    and mmt.transaction_action_id       = 27
    and mmt.transaction_type_id         = 18 -- PO Receipts
   )
   or
   (    mmt.transaction_source_type_id  = 1
    and mmt.transaction_action_id       = 29
    and mmt.transaction_type_id         = 71 -- PO Rcpt Adjust
   )
   or
   (    mmt.transaction_source_type_id  = 1
    and mmt.transaction_action_id       = 1
    and mmt.transaction_type_id         = 36 -- Return to Vendor
   )
   or
   (    mmt.transaction_source_type_id  = 1
    and mmt.transaction_action_id       = 6
    and mmt.transaction_type_id         = 74 -- Transfer for Regular
   )
   or
   (    mmt.transaction_source_type_id = 13
    and mmt.transaction_action_id      = 6
    and mmt.transaction_type_id        = 75 -- Transfer to Consigned
   )
  )
  and mmt.rcv_transaction_id          = rt.transaction_id
  and mmt.inventory_item_id           = msiv.inventory_item_id
  and mmt.organization_id             = msiv.organization_id
  and msiv.inventory_asset_flag       = 'Y'
  -- Revision for version 1.14
  -- and msiv.inventory_item_status_code <> 'Inactive'
  and 9=9                             -- p_item_status_to_exclude
  -- End revision for version 1.14
  and mmt.organization_id             = mp.organization_id
  and nvl(mmt.transaction_cost,0)    <> 0
  -- Revision for version 1.9
  and pv.vendor_id (+)                = rt.vendor_id
  and flvv.lookup_code (+)            = pv.vendor_type_lookup_code
  -- Revision for version 1.13
  and flvv.lookup_type                = 'VENDOR TYPE'
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code
  and 3=3                             -- p_trx_date_from, p_trx_date_to, p_exclude_supplier_type
  and 5=5                             -- p_item_number
  group by
  mmt.organization_id,
  mmt.inventory_item_id
  -- Revision for version 1.11
  -- Avoid negative quantities due to returns
  having sum(mmt.primary_quantity) > 0
 ) receipts,
 -- Revision for version 1.12
 -- Get the comparison item costs by cost type and item
 (select cic.cost_type_id,
  cct.cost_type,
  -- Revision for version 1.14
  -- msiv.organization_id,
  -- msiv.inventory_item_id,
  -- msiv.inventory_asset_flag,
  cic.organization_id,
  cic.inventory_item_id,
  -- End revision for version 1.14
  cic.lot_size,
  cic.unburdened_cost,
  cic.item_cost,
  nvl(cic.based_on_rollup_flag,2) based_on_rollup_flag
  from cst_cost_types cct,
  cst_item_costs cic,
  -- Revision for version 1.14
  -- mtl_system_items_vl msiv,
  mtl_parameters mp
  -- Revision for version 1.14
  -- where mp.organization_id              = msiv.organization_id
  -- and msiv.organization_id            = cic.organization_id
  -- and msiv.inventory_item_id          = cic.inventory_item_id
  -- and msiv.inventory_asset_flag       = 'Y'
  -- and msiv.inventory_item_status_code <> 'Inactive'
  where mp.organization_id              = cic.organization_id
  -- End revision for version 1.14
  and cct.cost_type_id                = cic.cost_type_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code
  and 4=4                             -- p_cost_type
  and 7=7                             -- p_item_number
  and 6=6                             -- p_exclude_rolled_up_items
  union all
  select cic.cost_type_id,
  cct_primary.cost_type,
  -- Revision for version 1.14
  -- msiv.organization_id,
  -- msiv.inventory_item_id,
  -- msiv.inventory_asset_flag,
  cic.organization_id,
  cic.inventory_item_id,
  -- End revision for version 1.14
  cic.lot_size,
  cic.unburdened_cost,
  cic.item_cost,
  nvl(cic.based_on_rollup_flag,2) based_on_rollup_flag
  from cst_item_costs cic,
  cst_cost_types cct,
  cst_cost_types cct_primary,
  -- Revision for version 1.14
  -- mtl_system_items_vl msiv,
  mtl_parameters mp
  -- Revision for version 1.14
  -- where mp.organization_id              = msiv.organization_id
  -- and msiv.organization_id            = cic.organization_id
  -- and msiv.inventory_item_id          = cic.inventory_item_id
  -- and msiv.inventory_asset_flag       = 'Y'
  -- and msiv.inventory_item_status_code <> 'Inactive'
  where mp.organization_id              = cic.organization_id
  -- End revision for version 1.14
  and cic.cost_type_id                = mp.primary_cost_method  -- this gets the Frozen Costs
  and cct.cost_type_id               <> mp.primary_cost_method  -- this avoids getting the costs twice
  and cct_primary.cost_type_id        = mp.primary_cost_method
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code
  and 4=4                             -- p_cost_type
  and 7=7                             -- p_item_number
  and 6=6                             -- p_exclude_rolled_up_items
  -- ====================================
  -- Find the Costing Method costs not in
  -- the pending or unimplemented cost type
  -- ====================================
  and not exists
   (select 'x'
    from cst_item_costs cic2
    where cic2.organization_id   = cic.organization_id
    and cic2.inventory_item_id = cic.inventory_item_id
    and cic2.cost_type_id      = cct.cost_type_id)
 ) cic,
 -- End revision for version 1.12  
 -- Get the comparison material overhead rates by cost type and sum up by item
 (select cicd_moh2.cost_type_id,
  cicd_moh2.cost_type,
  msiv.organization_id,
  mp.organization_code,
  mp.primary_cost_method,
  msiv.inventory_item_id,
  msiv.concatenated_segments,
  msiv.description,
  msiv.item_type,
  msiv.planning_make_buy_code,
  msiv.inventory_item_status_code,
  msiv.primary_uom_code,
  nvl(cicd_moh2.item_rate,0) item_rate,
  nvl(cicd_moh2.lot_rate,0) lot_rate,
  nvl(cicd_moh2.total_value_rate,0) total_value_rate,
  nvl(cicd_moh2.activity_rate,0) activity_rate
  from mtl_system_items_vl msiv,
  mtl_parameters mp,
  (select cct.cost_type_id,
   cct.cost_type,
   mp.organization_id,
   cicd.inventory_item_id,
   -- ==========
   -- cicd.basis_type, 
   -- 1 -- Item
   -- 2 -- Lot
   -- 3 -- Resource Units - not in use for material overhead
   -- 4 -- Resource Value - not in use for material overhead
   -- 5 -- Total Value
   -- 6 -- Activity
   -- cicd.level_type
   --      1 -- This
   --      2 -- Previous
   -- ==========
   sum(decode(cicd.basis_type,
     1, nvl(cicd.usage_rate_or_amount,0),
     2, 0,
     5, 0,
     6, 0,
     0
       )
      ) item_rate,
   sum(decode(cicd.basis_type,
     1, 0,
     2, nvl(cicd.usage_rate_or_amount,0),
     5, 0,
     6, 0,
     0
       )
      ) lot_rate,
   sum(decode(cicd.basis_type,
     1, 0,
     2, 0,
     5, nvl(cicd.usage_rate_or_amount,0),
     6, 0,
     0
       )
      ) total_value_rate,
   sum(decode(cicd.basis_type,
     1, 0,
     2, 0,
     5, nvl(cicd.usage_rate_or_amount,0),
     6, nvl(cicd.usage_rate_or_amount,0) * nvl(cicd.activity_units,0) / decode(nvl(cicd.item_units,0), 0, 1, cicd.item_units),
     0
       )
      ) activity_rate
   from cst_item_cost_details cicd,
   cst_cost_types cct,
   -- Revision for version 1.14
   -- mtl_system_items_vl msiv,
   mtl_parameters mp
   -- Revision for version 1.14
   -- where mp.organization_id       = msiv.organization_id
   where cicd.level_type          = 1 -- this level
   and cicd.cost_element_id     = 2 -- material overhead
   and cicd.cost_type_id        = cct.cost_type_id
   and cct.cost_type_id         =
   case
   -- Revision for version 1.12
      when mp.primary_cost_method = 1 and cct.cost_type_id = mp.primary_cost_method then mp.primary_cost_method -- Frozen Standard Costs
      when mp.primary_cost_method = 2 and cct.cost_type_id = mp.primary_cost_method then nvl(mp.avg_rates_cost_type_id, -99) -- Average Costs
      when mp.primary_cost_method = 5 and cct.cost_type_id = mp.primary_cost_method then nvl(mp.avg_rates_cost_type_id, -99) -- FIFO Costs
      when mp.primary_cost_method = 6 and cct.cost_type_id = mp.primary_cost_method then nvl(mp.avg_rates_cost_type_id, -99) -- LIFO Costs
      else cct.cost_type_id
   -- End revision for version 1.12
   end
   -- Revision for version 1.14
   -- and msiv.organization_id     = cicd.organization_id
   -- and msiv.inventory_item_id   = cicd.inventory_item_id
   -- End revision for version 1.14
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                      -- p_org_code
   and 4=4                      -- p_cost_type
   and 8=8                      -- p_item_number
   group by
   cct.cost_type_id,
   cct.cost_type,
   mp.organization_id,
   cicd.inventory_item_id
  ) cicd_moh2
  where mp.organization_id              = msiv.organization_id
  and msiv.organization_id            = cicd_moh2.organization_id (+) 
  and msiv.inventory_item_id          = cicd_moh2.inventory_item_id (+)
  -- Revision for version 1.1
  and msiv.inventory_asset_flag       = 'Y'
  -- Revision for version 1.14
  -- and msiv.inventory_item_status_code <> 'Inactive'
  and 9=9                             -- p_item_status_to_exclude
  -- End revision for version 1.14
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code
  and 5=5                             -- p_item_number
 ) cicd_moh,
 -- Get default material overheads and sum up the overhead rates by type, make, buy or all items
 (select moh2.organization_id,
  moh2.inventory_item_id,
  -- moh2.basis_type, 
  -- 1 -- Item
  -- 2 -- Lot
  -- 3 -- Resource Units - not in use for material overhead
  -- 4 -- Resource Value - not in use for material overhead
  -- 5 -- Total Value
  -- 6 -- Activity
  -- moh2.default_item_type,
  -- 1 -- Make items
  -- 2 -- Buy items
  -- 3 -- All items
  -- ==========
  -- Make items
  -- ==========
  sum(decode(moh2.default_item_type,
   -- Revision for version 1.13
   -- 1, decode(moh2.default_basis_type,
   1, decode(moh2.basis_type,
     1, moh2.default_rate_or_amount,
     0
     ),
   2, 0,
   3, 0
     )
     ) make_item_rate,
  sum(decode(moh2.default_item_type,
   -- Revision for version 1.13
   -- 1, decode(moh2.default_basis_type,
   1, decode(moh2.basis_type,
     2, moh2.default_rate_or_amount,
     0
     ),
   2, 0,
   3, 0
     )
     ) make_lot_rate,
  sum(decode(moh2.default_item_type,
   -- Revision for version 1.13
   -- 1, decode(moh2.default_basis_type,
   1, decode(moh2.basis_type,
     5, moh2.default_rate_or_amount,
     0
     ),
   2, 0,
   3, 0
     )
     ) make_total_value_rate,
  sum(decode(moh2.default_item_type,
   -- Revision for version 1.13
   -- 1, decode(moh2.default_basis_type,
   1, decode(moh2.basis_type,
     6, nvl(moh2.default_rate_or_amount,0) * nvl(moh2.activity_units,0) / 
     decode(nvl(moh2.item_units,0), 0, 1, moh2.item_units),
     0
     ),
   2, 0,
   3, 0
     )
     ) make_activity_rate,
  -- ==========
  -- Buy Items
  -- ==========
  sum(decode(moh2.default_item_type,
   1, 0,
   -- Revision for version 1.13
   -- 2, decode(moh2.default_basis_type,
   2, decode(moh2.basis_type,
     1, moh2.default_rate_or_amount,
     0
     ),
   3, 0
     )
     ) buy_item_rate,
  sum(decode(moh2.default_item_type,
   1, 0,
   -- Revision for version 1.13
   -- 2, decode(moh2.default_basis_type,
   2, decode(moh2.basis_type,
     2, moh2.default_rate_or_amount,
     0
     ),
   3, 0
     )
     ) buy_lot_rate,
  sum(decode(moh2.default_item_type,
   1, 0,
   -- Revision for version 1.13
   -- 2, decode(moh2.default_basis_type,
   2, decode(moh2.basis_type,
     5, moh2.default_rate_or_amount,
     0
     ),
   3, 0
     )
     ) buy_total_value_rate,
  sum(decode(moh2.default_item_type,
   1, 0,
   -- Revision for version 1.13
   -- 2, decode(moh2.default_basis_type,
   2, decode(moh2.basis_type,
     6, nvl(moh2.default_rate_or_amount,0) * nvl(moh2.activity_units,0) / 
     decode(nvl(moh2.item_units,0), 0, 1, moh2.item_units),
     0
     ),
   3, 0
     )
     ) buy_activity_rate,
  -- ==========
  -- All Items
  -- ==========
  sum(decode(moh2.default_item_type,
   1, 0,
   2, 0,
   -- Revision for version 1.13
   -- 3, decode(moh2.default_basis_type,
   3, decode(moh2.basis_type,
     1, moh2.default_rate_or_amount,
     0
     )
     )
     ) all_item_rate,
  sum(decode(moh2.default_item_type,
   1, 0,
   2, 0,
   -- Revision for version 1.13
   -- 3, decode(moh2.default_basis_type,
   3, decode(moh2.basis_type,
     2, moh2.default_rate_or_amount,
     0
     )
     )
     ) all_lot_rate,
  sum(decode(moh2.default_item_type,
   1, 0,
   2, 0,
   -- Revision for version 1.13
   -- 3, decode(moh2.default_basis_type,
   3, decode(moh2.basis_type,
     5, moh2.default_rate_or_amount,
     0
     )
     )
     ) all_total_value_rate,
  sum(decode(moh2.default_item_type,
   1, 0,
   2, 0,
   -- Revision for version 1.13
   -- 3, decode(moh2.default_basis_type,
   3, decode(moh2.basis_type,
     6, nvl(moh2.default_rate_or_amount,0) * nvl(moh2.activity_units,0) / 
     decode(nvl(moh2.item_units,0), 0, 1, moh2.item_units),
     0
     )
     )
     ) all_activity_rate
  from  -- ================================================
    -- Get the Resource Information for those resources
    -- with org level default material overheads
    -- ================================================
   (select br.resource_code,
    br.resource_id,
    br.organization_id,
    br.unit_of_measure,
    br.functional_currency_flag,
    br.default_basis_type,
    br.absorption_account,
    br.disable_date,
    decode(ciod.category_set_id, null, 'Org', 'Category') default_level,
    ciod.item_type default_item_type,
    msiv.inventory_item_id,
    null default_category_set_id,
    null default_category_id,
    ciod.basis_type,
    ciod.usage_rate_or_amount default_rate_or_amount,
    ciod.item_units,
    ciod.activity_units
    from bom_resources br,
    cst_item_overhead_defaults ciod,
    -- Revision for version 1.14
    -- mtl_system_items_vl msiv,
    mtl_system_items_b msiv,
    -- End revision for version 1.14
    mtl_parameters mp
    -- ================================================
    -- joins for the resources and organizations
    -- ================================================
    where br.resource_id                  = ciod.material_overhead_id
    and br.organization_id              = ciod.organization_id
    and br.cost_element_id              = 2 -- material overhead
    -- Revision for version 1.4
    -- Change to <= and use trunc(sysdate) as a comparison
    and decode(:p_only_active,                                                            -- p_only_active
     'N',  nvl(br.disable_date, '01-jan-1961'),
     'Y',  trunc(sysdate)
        ) <=
    decode(:p_only_active,                                                              -- p_only_active
     'N',   nvl(br.disable_date, '01-jan-1961'),
     'Y',   decode(br.disable_date, null, trunc(sysdate), br.disable_date)
       )
    and ciod.category_set_id is null
    and ciod.organization_id            = mp.organization_id
    and ciod.organization_id            = msiv.organization_id
    -- Revision for version 1.1
    and msiv.inventory_asset_flag       = 'Y'
    -- Revision for version 1.14
    -- and msiv.inventory_item_status_code <> 'Inactive'
    and 9=9                             -- p_item_status_to_exclude
    -- End revision for version 1.14
    and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code
    and 5=5                             -- p_item_number
    union all
    -- ================================================
    -- Get the Resource Information for those resources
    -- with category level default material overheads
    -- ================================================
    select br.resource_code,
    br.resource_id,
    br.organization_id,
    br.unit_of_measure,
    br.functional_currency_flag,
    br.default_basis_type,
    br.absorption_account,
    br.disable_date,
    decode(ciod.category_set_id, null, 'Org', 'Category') default_level,
    ciod.item_type default_item_type,
    msiv.inventory_item_id,
    ciod.category_set_id default_category_set_id,
    ciod.category_id default_category_id,
    ciod.basis_type,
    ciod.usage_rate_or_amount default_rate_or_amount,
    ciod.item_units,
    ciod.activity_units
    from bom_resources br,
    cst_item_overhead_defaults ciod,
    -- Revision for version 1.14
    -- mtl_system_items_vl msiv,
    mtl_system_items_b msiv,
    -- End revision for version 1.14
    mtl_item_categories mic,
    mtl_parameters mp
    -- ================================================
    -- joins for the resources and organizations
    -- ================================================
    where br.resource_id              = ciod.material_overhead_id
    and br.organization_id          = ciod.organization_id
    and br.cost_element_id          = 2 -- material overhead
    -- Revision for version 1.4
    -- Change to <= and use trunc(sysdate) as a comparison
    and decode(:p_only_active,                                                -- p_only_active
     'N',   nvl(br.disable_date, '01-jan-1961'),
     'Y',  trunc(sysdate)
       ) <=
    decode(:p_only_active,                                                -- p_only_active
     'N',   nvl(br.disable_date, '01-jan-1961'),
     'Y',   decode(br.disable_date, null, trunc(sysdate), br.disable_date)
       )
    and ciod.category_set_id is not null
    and ciod.organization_id            = mp.organization_id
    and ciod.organization_id            = mic.organization_id
    and ciod.category_set_id            = mic.category_set_id
    and ciod.category_id                = mic.category_id
    and msiv.inventory_item_id          = mic.inventory_item_id
    and msiv.organization_id            = mic.organization_id
    -- Revision for version 1.1
    and msiv.inventory_asset_flag       = 'Y'
    -- Revision for version 1.14
    -- and msiv.inventory_item_status_code <> 'Inactive'
    and 9=9                             -- p_item_status_to_exclude
    -- End revision for version 1.14
    and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code
    and 5=5                             -- p_item_number
   ) moh2
   group by
   moh2.organization_id,
   moh2.inventory_item_id
 ) default_moh
where  receipts.inventory_item_id      = cicd_moh.inventory_item_id
and receipts.organization_id        = cicd_moh.organization_id
and cicd_moh.organization_id        = default_moh.organization_id (+)
and cicd_moh.inventory_item_id      = default_moh.inventory_item_id (+)
-- End revision for version 1.10
-- Revision for version 1.7
and cic.inventory_item_id           = receipts.inventory_item_id
and cic.organization_id             = receipts.organization_id
-- End revision for version 1.7
-- Revision for version 1.2
and fcl.lookup_code (+)             =  cicd_moh.item_type
and fcl.lookup_type (+)             = 'ITEM_TYPE'
-- Revision for version 1.10
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                 = cicd_moh.planning_make_buy_code
-- Revision for version 1.11
and ml2.lookup_type                 = 'CST_BONROLLUP_VAL'
and ml2.lookup_code                 = cic.based_on_rollup_flag
-- Revision for version 1.6
and cicd_moh.primary_uom_code       = muomv.uom_code
and misv.inventory_item_status_code = cicd_moh.inventory_item_status_code
-- ===================================================================
-- using the base tables for organization definition
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = cicd_moh.organization_id
and hoi.organization_id             = haou.organization_id   -- this gets the organization name
and haou2.organization_id           = hoi.org_information3   -- this gets the operating unit id
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and 1=1                             -- p_operating_unit, p_ledger
order by
 nvl(gl.short_name, gl.name),
 haou2.name,
 cicd_moh.organization_code,
 cicd_moh.concatenated_segments