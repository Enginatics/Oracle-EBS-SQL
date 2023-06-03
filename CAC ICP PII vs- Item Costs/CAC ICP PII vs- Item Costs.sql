/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII vs. Item Costs
-- Description: Report to compare the Frozen or Pending Costs against the PII item costs.  If you enter a Period Name this report also shows the stored month-end from the period end snapshot (snapshot that is created when you close the inventory periods).  If you leave the Period Name blank or null you will report the real-time onhand quantities.  Also note that this report excludes inactive items.

Note:  there is a hidden parameter, Numeric Sign for PII, which allows you to set the sign of the profit in inventory amounts.  You can specify positive or negative values based on how you enter PII amounts into your PII Cost Type.  Defaulted as positive (+1).

Parameters:
==========
Cost Type:  defaults to your Costing Method; if the cost type is missing component costs the report will find any missing item costs from your Costing Method cost type.
PII Cost Type:  the profit in inventory cost type you wish to report
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (optional)
Period Name (Closed):  Accounting period you wish to report for the onhand quantities at month-end,  If you leave this value blank or null you get the real-time onhand quantities.
Category Set 1:  any item category you wish, typically the Product or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Cost category set (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009 - 2022 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- | Version Modified on Modified by Description
-- | ======= =========== =====================================================
-- | 1.0     29 Sep 2009 Douglas Volz   Initial Coding
-- | 1.4     01 May 2019 Douglas Volz   Period name is now optional, if left null
-- |                                    the real-time quantities are reported.
-- | 1.5     27 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters.
-- | 1.6     26 Feb 2022 Douglas Volz   Changed to multi-language views for items, 
-- |                                    item status and UOM.  Added List Price, 
-- |                                    Market Price and Currency Code to report. 
-- |                                    Exclude items with a status of Inactive.
-- | 1.7     26 Sep 2022 Douglas Volz   Performance improvements and removed group by.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-icp-pii-vs-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-vs-item-costs/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 -- Revision for version 1.6
 muomv.uom_code UOM_Code,
 fcl.meaning Item_Type,
 -- Revision for version 1.6
 misv.inventory_item_status_code Item_Status,
 ml1.meaning Make_Buy_Code,
&category_columns
 ml2.meaning Inventory_Asset,
 ml3.meaning Based_on_Rollup,
 gl.currency_code Currency_Code,
 msiv.market_price Market_Price,
 msiv.list_price_per_unit List_Price,
 cct.cost_type Cost_Type,
 pii.pii_cost_type PII_Cost_Type,
 -- Revision for version 1.7
 nvl(cic.item_cost, 0) Item_Cost,
 nvl(pii.pii_item_cost, 0) PII_Item_Cost,
 nvl(cic.item_cost, 0) - decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii.pii_item_cost,0) Net_Item_Cost,
 round(nvl(pii.pii_item_cost, 0)
  / decode(nvl(cic.item_cost, 0),
   0, 1,
   nvl(cic.item_cost, 0))
  * 100
    ,1) PII_Percent,
 -- End revision for version 1.6
 :p_period_name Period_Name,
 nvl(sum_qty.quantity,0) Quantity
 -- End revision for version 1.7
FROM cst_item_costs cic,
 mtl_system_items_vl msiv,
 -- Revision for version 1.6
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 mfg_lookups ml2, -- inventory_asset_flag, SYS_YES_NO
 mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
 fnd_common_lookups fcl, -- item type
 -- End revision for version 1.6
 mtl_parameters mp,
 cst_cost_types cct,
 hr_organization_information hoi,
 hr_all_organization_units haou,
 hr_all_organization_units haou2,
 gl_ledgers gl,
 -- ===========================================================
 -- Inline select for Profit in Inventory item costs
 -- ===========================================================
 -- Revision for version 1.6
 (select sum(nvl(cicd.item_cost, 0)) pii_item_cost,
  cicd.inventory_item_id,
  cicd.organization_id,
  cct.cost_type pii_cost_type
  from cst_item_cost_details cicd,
  bom_resources br,
  cst_cost_types cct,
  mtl_parameters mp
  where cicd.resource_id       = br.resource_id
  and cicd.cost_type_id      = cct.cost_type_id
  and mp.organization_id     = cicd.organization_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                    -- p_org_code
  and 4=4                    -- p_pii_cost_type, p_pii_sub_element
  group by
  cicd.inventory_item_id,
  cicd.organization_id,
  cct.cost_type) pii,
 -- ===========================================================
 -- Inline select for Quantities
 -- If the period name is null get the real-time quantities
 -- If the period name is entered, get the period-end quantities
 -- ===========================================================
 (select qty.organization_id,
  qty.inventory_item_id,
  sum(qty.quantity) quantity
  from 
  (select decode(mip.fob_point,
    1, ms.to_organization_id,
    2, ms.from_organization_id) organization_id,
   ms.item_id inventory_item_id,
   nvl(sum(ms.quantity), 0) quantity
   from mtl_supply ms, 
   mtl_interorg_parameters mip,
   -- Revision for version 1.6
   mtl_parameters mp
   where ms.supply_type_code in ('SHIPMENT', 'RECEIVING')
   and mip.from_organization_id        = ms.from_organization_id
   and mip.to_organization_id          = ms.to_organization_id 
   and :p_period_name is null
   -- Revision for version 1.6 and 1.7
   -- and mp.organization_id              = decode(mip.fob_point, 1, ms.to_organization_id, 2, ms.from_organization_id)
   and mp.organization_id              = decode(mip.fob_point, 1, mip.to_organization_id, 2, mip.from_organization_id)
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code,
   group by
   decode(mip.fob_point,
    1, ms.to_organization_id,
    2, ms.from_organization_id),
   ms.item_id
   union all
   select moqd.organization_id,
   moqd.inventory_item_id,
   nvl(sum(moqd.primary_transaction_quantity), 0) quantity
   from mtl_onhand_quantities_detail moqd,
   mtl_secondary_inventories msub,
   -- Revision for version 1.6
   mtl_parameters mp
   where moqd.organization_id            = msub.organization_id
   and moqd.subinventory_code          = msub.secondary_inventory_name
   -- Only want asset subinventories
   and msub.asset_inventory            = 1 -- Yes
   and :p_period_name is null
   -- Revision for version 1.6
   and mp.organization_id              = msub.organization_id
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code,
   group by
   moqd.organization_id,
   moqd.inventory_item_id
   union all
   select cpcs.organization_id,
   cpcs.inventory_item_id, 
   nvl(sum (cpcs.rollback_quantity), 0) quantity
   from org_acct_periods oap,
   cst_period_close_summary cpcs,
   -- Revision for version 1.6
   mtl_parameters mp
   where cpcs.acct_period_id             = oap.acct_period_id
   -- Added for performance to use the index in oap
   and cpcs.organization_id            = oap.organization_id
   and 5=5                             -- p_period_name
   -- Revision for version 1.7
   and :p_period_name is not null
   -- Revision for version 1.6
   and mp.organization_id              = cpcs.organization_id
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_org_code,
   group by
   cpcs.organization_id,
   cpcs.inventory_item_id
 ) qty
 group by 
  qty.organization_id,
  qty.inventory_item_id) sum_qty
where msiv.inventory_item_id          = cic.inventory_item_id
and msiv.organization_id            = cic.organization_id
and cct.cost_type_id                = cic.cost_type_id
and 3=3                             -- p_cost_type
and msiv.organization_id            = mp.organization_id
and msiv.inventory_asset_flag       = 'Y'
-- don't report disabled inventory orgs
and nvl(haou.date_to, sysdate)      > sysdate - 1
-- Revision for version 1.6
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
and msiv.inventory_item_status_code <> 'Inactive'
-- Revision for version 1.7
-- and cic.inventory_item_id           = pii.inventory_item_id (+)
-- and cic.organization_id             = pii.organization_id (+)
and msiv.inventory_item_id          = pii.inventory_item_id (+)
and msiv.organization_id            = pii.organization_id (+)
-- End revision for version 1.6 and 1.7
-- Joins for Item Master and Quantities
and msiv.inventory_item_id          = sum_qty.inventory_item_id (+)
and msiv.organization_id            = sum_qty.organization_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- ===========================================
-- Lookup joins
-- ===========================================
-- Revision for version 1.6
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                 = msiv.planning_make_buy_code
and ml2.lookup_type                 = 'SYS_YES_NO'
and ml2.lookup_code                 = to_char(cic.inventory_asset_flag)
and ml3.lookup_type                 = 'CST_BONROLLUP_VAL'
and ml3.lookup_code                 = cic.based_on_rollup_flag
-- End revision for version 1.6
and fcl.lookup_type (+)             = 'ITEM_TYPE'
and fcl.lookup_code (+)             = msiv.item_type
and 1=1                             -- p_operating_unit, p_ledger
and 2=2                             -- p_org_code
-- Revision for version 1.35
and 6=6                             -- p_item_number
and mp.organization_id             <> mp.master_organization_id
order by
 nvl(gl.short_name, gl.name),
 haou2.name,
 mp.organization_code,
 msiv.concatenated_segments