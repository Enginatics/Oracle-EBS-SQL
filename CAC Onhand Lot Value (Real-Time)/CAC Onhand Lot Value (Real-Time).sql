/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Onhand Lot Value (Real-Time)
-- Description: Report for onhand inventory at the time you run the report (real-time).  By organization, Lot and Subinventory.  If you leave the Cost Type blank the report will value the inventory using the inventory organization's Costing Method (Standard, Average, FIFO, LIFO).  If you enter a Cost Type the report will use these item costs, plus, if any item costs are missing from the entered Cost Type, get the remaining item costs from the Costing Method Cost Type.  Note that consigned quantities are reported but not valued.  And if you choose to report expense subinventories, they are not valued either.


/* +=============================================================================+
-- | Copyright 2009 - 2020 Douglas Volz Consulting, Inc.                         |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_inventory_val_rept.sql
-- |
-- |  Parameters:
-- |  p_period_name         -- Accounting period you wish to report for
-- |  p_org_code            -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit      -- Operating Unit you wish to report, leave blank for all
-- |                           operating units (optional) 
-- |  p_ledger              -- general ledger you wish to report, leave blank for all
-- |                           ledgers (optional)
-- |  p_cost_type           -- Enter a Cost Type to value the quantities
-- |                           using the Cost Type Item Costs; or, if 
-- |                           Cost Type is blank or null the report will 
-- |                           use the stored month-end snapshot values
-- |  p_category_set1       -- The first item category set to report, typically the
-- |                           Cost or Product Line Category Set
-- |  p_category_set2       -- The second item category set to report, typically the
-- |                           Inventory Category Set 
-- |
-- | ===================================================================
-- | Note:  if you enter a cost type this script uses the item costs 
-- |        from the cost type; if you leave the cost type 
-- |        blank it uses the item costs from the month-end snapshot.
-- | ===================================================================
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     27 Sep 2009 Douglas Volz Initial Coding
-- | 1.1     28 Sep 2009 Douglas Volz Added a sum for the ICP costs from cicd
-- | 1.16    23 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- |                                  master, item categories and operating units.
-- |                                  Used mfg_lookups for "Intransit".
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-onhand-lot-value-real-time/
-- Library Link: https://www.enginatics.com/reports/cac-onhand-lot-value-real-time/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 haou.name Organization_Name,
 &segment_columns
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 misv.inventory_item_status_code_tl Item_Status,
 fcl.meaning Item_Type,
 ml1.meaning Make_Buy_Code,
 -- Revision for version 1.19 and 1.20
 fl1.meaning Asset,
 ml2.meaning Consigned,
 -- Revision for version 1.12
&category_columns  
 -- End revision for version 1.12
 gl.currency_code Currency_Code,
 cic.item_cost Item_Cost,
 sumqty.lot_number Lot_Number,
 sumqty.expiration_date Expiration_Date,
 sumqty.subinventory_code Subinventory,
 -- Revision for version 1.14
 sumqty.asset_inventory Asset_Subinventory,
 -- Revision for version 1.19, add Cost_Group
 nvl((select cost_group
      from cst_cost_groups ccg
      where ccg.cost_group_id = sumqty.cost_group_id),'') Cost_Group,
 nvl((select pp.segment1
  from pa_projects_all pp,
  mtl_item_locations mil
  where mil.inventory_location_id = sumqty.locator_id
  and pp.project_id             = mil.project_id),'') Project,
 -- End of revision for version 1.19
 muomv.uom_code UOM_Code,
 sumqty.onhand_quantity + sumqty.intransit_quantity Onhand_Quantity,
 round(nvl(cic.material_cost,0) * decode(sumqty.is_consigned, 1, 0, 1)
  * (sumqty.onhand_quantity + sumqty.intransit_quantity),2) Material_Value,
 round(nvl(cic.material_overhead_cost,0) * decode(sumqty.is_consigned, 1, 0, 1)
  * (sumqty.onhand_quantity + sumqty.intransit_quantity),2) Material_Overhead_Value,
 round(nvl(cic.resource_cost,0) * decode(sumqty.is_consigned, 1, 0, 1)
  * (sumqty.onhand_quantity + sumqty.intransit_quantity),2) Resource_Value,
 round(nvl(cic.outside_processing_cost,0) * decode(sumqty.is_consigned, 1, 0, 1)
  * (sumqty.onhand_quantity + sumqty.intransit_quantity),2) Outside_Processing_Value,
 round(nvl(cic.overhead_cost,0) * decode(sumqty.is_consigned, 1, 0, 1)
  * (sumqty.onhand_quantity + sumqty.intransit_quantity),2) Overhead_Value,
 round(nvl(cic.item_cost,0) * decode(sumqty.is_consigned, 1, 0, 1)
  * (sumqty.onhand_quantity + sumqty.intransit_quantity),2) Onhand_Value
from mtl_system_items_vl msiv,
 mtl_units_of_measure_vl muomv,
 mtl_item_status_vl misv,
 mtl_parameters mp,
 mfg_lookups ml1, -- Make_Buy_Code
 -- Revision for version 1.20
 mfg_lookups ml2, -- Is Consigned, SYS_YES_NO
 fnd_common_lookups fcl,
 -- Revision for version 1.19
 fnd_lookups fl1, -- inventory_asset_flag, YES_NO
 hr_organization_information hoi,
 hr_all_organization_units haou,  -- inv_organization_id
 hr_all_organization_units haou2, -- operating unit
 gl_code_combinations gcc,
 gl_ledgers gl,
 -- ====================
 -- Get the item costs
 -- ====================
 (select cic.organization_id   organization_id,
  cic.inventory_item_id   inventory_item_id,
  cic.cost_type_id   cost_type_id,
  cct.cost_type    cost_type,
  nvl(cic.material_cost, 0)  material_cost,
  nvl(cic.material_overhead_cost, 0) material_overhead_cost,
  nvl(cic.resource_cost, 0)  resource_cost,
  nvl(cic.outside_processing_cost, 0) outside_processing_cost,
  nvl(cic.overhead_cost, 0)  overhead_cost,
  nvl(cic.item_cost,0)   item_cost
  from cst_cost_types cct,
  cst_item_costs cic,
  mtl_parameters mp
  where cct.cost_type_id           = cic.cost_type_id
  and mp.organization_id         = cic.organization_id
  and cct.cost_type              = nvl(:p_cost_type, decode(mp.primary_cost_method, 1,'Frozen', 2, 'Average', 3, 'FIFO', 4,'LIFO'))
  and 2=2                        -- p_cost_type
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 4=4                        -- p_org_code
  and mp.organization_id         = cic.organization_id
  and cic.cost_type_id           = cct.cost_type_id
  -- Revision for Version 1.8
  union all
  select cic.organization_id   organization_id,
  cic.inventory_item_id   inventory_item_id,
  cic.cost_type_id   cost_type_id,
  cct.cost_type    cost_type,
  nvl(cic.material_cost, 0)  material_cost,
  nvl(cic.material_overhead_cost, 0) material_overhead_cost,
  nvl(cic.resource_cost, 0)  resource_cost,
  nvl(cic.outside_processing_cost, 0) outside_processing_cost,
  nvl(cic.overhead_cost, 0)  overhead_cost,
  nvl(cic.item_cost,0)   item_cost
  from cst_item_costs cic,
  cst_cost_types cct,
  mtl_parameters mp
  where cic.organization_id        = mp.organization_id
  and cic.cost_type_id           = mp.primary_cost_method  -- this gets the Costing Method
  and :p_cost_type is not null
  and :p_cost_type not in decode(mp.primary_cost_method, 1,'Frozen', 2, 'Average', 3, 'FIFO', 4,'LIFO')
  and 2=2                        -- p_cost_type
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 4=4                        -- p_org_code
  -- ====================================
  -- Find all the Frozen costs not in the
  -- Pending or unimplemented cost type
  -- ====================================
  and not exists
   (select 'x'
    from cst_item_costs cic2
    where cic2.organization_id   = cic.organization_id
    and cic2.inventory_item_id = cic.inventory_item_id
    and cic2.cost_type_id      = cct.cost_type_id
   )
  ) cic,
  -- ===========================
 -- End of getting item costs 
  -- ===========================
 -- ===================================
 -- Get Onhand quantities
 -- ===================================
 -- ================================================
 -- part 4 
 -- Condense the Union down to individual Org/Items
 -- ================================================
  (select allqty.organization_id  organization_id,
   allqty.inventory_item_id inventory_item_id,
   allqty.lot_number              lot_number,
   allqty.expiration_date         expiration_date,
   -- Revision for version 1.17
   allqty.locator_id, 
   allqty.subinventory_code       subinventory_code,
   -- Revision for version 1.19
   allqty.cost_group_id,
   -- Revision for version 1.14
   allqty.asset_inventory         asset_inventory,
   allqty.code_combination_id     code_combination_id,
   sum(allqty.onhand_quantity) onhand_quantity,
   sum(allqty.intransit_quantity) intransit_quantity,
   -- Revision for version 1.20
   allqty.is_consigned
  -- ================================================
  -- part 3 Union all the Onhand and Intransit groups
  -- together to get one "quantity" table
  -- ================================================
       -- =============================================================     
       -- Part 2, identify Onhand and Intransit groupings for summation
       -- =============================================================     
   from (select matlqty.organization_id  organization_id,
   matlqty.inventory_item_id  inventory_item_id,
   matlqty.lot_number              lot_number,
   matlqty.expiration_date         expiration_date,
   -- Revision for version 1.17
   matlqty.locator_id, 
   matlqty.subinventory_code  subinventory_code,
   -- Revision for version 1.19
   matlqty.cost_group_id,
   -- Revision for version 1.14
   matlqty.asset_inventory         asset_inventory,
   matlqty.material_account        code_combination_id,
   decode(matlqty.subinventory_code, 'Intransit', 0, nvl(matlqty.quantity,0))  onhand_quantity,
   decode(matlqty.subinventory_code, 'Intransit', nvl(matlqty.quantity,0), 0)  intransit_quantity,
   -- Revision for version 1.20
   matlqty.is_consigned
   from (
    -- ===================================
    -- part 1 
    -- get the onhand inventory quantities
    -- ===================================
   select moqd.organization_id,
    moqd.inventory_item_id,
    moqd.lot_number,
    moqd.expiration_date,
    -- Revision for version 1.17
    moqd.locator_id, 
    moqd.subinventory_code,
    -- Revision for version 1.19
    moqd.cost_group_id,
    -- Revision for version 1.14
    moqd.asset_inventory,
    moqd.material_account,
     moqd.quantity,
    -- Revision for version 1.20
    moqd.is_consigned
    from (
     select moqd.organization_id,
     moqd.inventory_item_id,
     moqd.lot_number,
     mln.expiration_date,
     -- Revision for version 1.17
     moqd.locator_id,
      moqd.subinventory_code,
     -- Revision for version 1.19
     moqd.cost_group_id,
     -- Revision for version 1.14
     decode(msub.asset_inventory, 1, 'Yes', 2, 'No', 'Yes') asset_inventory,
     msub.material_account,
      sum(moqd.primary_transaction_quantity) quantity,
     -- Revision for version 1.20
     moqd.is_consigned
      from mtl_onhand_quantities_detail moqd,
     mtl_secondary_inventories msub,
     mtl_lot_numbers mln,
     mtl_parameters mp
     where moqd.lot_number        = mln.lot_number        (+)
     and moqd.organization_id   = mln.organization_id   (+)
     and moqd.inventory_item_id = mln.inventory_item_id (+)
     and moqd.inventory_item_id = mln.inventory_item_id (+)
     and moqd.subinventory_code = msub.secondary_inventory_name 
     and moqd.organization_id   = msub.organization_id
     and mp.organization_id     = moqd.organization_id
     and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 4=4                        -- p_org_code
     -- Revision for version 1.14
     and 3=3                        -- p_include_expense_subinv
     group by
     moqd.inventory_item_id,
     moqd.organization_id,
     moqd.lot_number,
     mln.expiration_date,
     -- Revision for version 1.17
     moqd.locator_id, 
     moqd.subinventory_code,
     -- Revision for version 1.19
     moqd.cost_group_id,
     -- Revision for version 1.14
     decode(msub.asset_inventory, 1, 'Yes', 2, 'No', 'Yes'),
     msub.material_account,
     -- Revision for version 1.20
     moqd.is_consigned
    ) moqd
   ) matlqty
  ) allqty
   group by
   allqty.organization_id,
   allqty.inventory_item_id,
   allqty.lot_number,
   allqty.expiration_date,
   -- Revision for version 1.17
   allqty.locator_id, -- locator_id
   allqty.subinventory_code,
   -- Revision for version 1.19
   allqty.cost_group_id,
   -- Revision for version 1.14
   allqty.asset_inventory,
   allqty.code_combination_id,
   -- Revision for version 1.20
   allqty.is_consigned
 ) sumqty
 -- ===========================
 -- End of getting quantities
 -- ===========================
-- ===================================================================
-- Item master to quantity and item master to cost joins
-- ===================================================================
where msiv.inventory_item_id          = sumqty.inventory_item_id
and msiv.organization_id            = sumqty.organization_id
and muomv.uom_code                  = msiv.primary_uom_code
and misv.inventory_item_status_code = msiv.inventory_item_status_code 
and msiv.inventory_item_id          = cic.inventory_item_id (+)
and msiv.organization_id            = cic.organization_id (+)
and mp.organization_id              = msiv.organization_id
and sumqty.onhand_quantity + sumqty.intransit_quantity <> 0
-- ===================================================================
-- Joins for the lookup codes
-- ===================================================================
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                = msiv.planning_make_buy_code
-- Revision for version 1.20
and ml2.lookup_type                 = 'SYS_YES_NO'
and ml2.lookup_code                = to_char(sumqty.is_consigned)
-- Revision for version 1.19
and fl1.lookup_type                 = 'YES_NO'
and fl1.lookup_code                 = msiv.inventory_asset_flag
and fcl.lookup_type (+)             = 'ITEM_TYPE'
and fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- Using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id             -- this gets the organization name
-- avoid selecting disabled inventory organizations
and sysdate                         < nvl(haou.date_to, sysdate +1)
and haou2.organization_id           = to_number(hoi.org_information3)   -- this gets the operating unit id
and hoi.org_information1            = gl.ledger_id                      -- this gets the ledger id                        
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                             -- p_org_code, p_operating_unit, p_ledger
-- ===================================================================
-- Joins for the Accounting information from the item master
-- ===================================================================
and gcc.code_combination_id (+) = sumqty.code_combination_id
-- Order by Ledger, Operating_Unit, Org_Code, Item, Subinv, Lot_Number
order by 1,2,3,5,6,7,8,9,10,11,12,23,21