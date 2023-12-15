/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Cost vs. Planning Item Controls
-- Description: Compare item make/buy controls vs. costing based on rollup controls.  There are twelve included reports, see below description for more information.

/* +=============================================================================+
-- |  Copyright 2008-2022 Douglas Volz Consulting, Inc.                          |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Description:
-- |  Use the below SQL scripts to compare the item costing rollup flags
-- |  with the item's make / buy flag. For the any Cost_Type.
-- |  Report to show cost rollup flags which may be incorrect:
-- |     1.  Based on Rollup Yes - No BOMS
-- |         Find make items where the item is set to be rolled up
-- |         but there are no BOMs.  May roll up to a zero cost.
-- |     2.  Based on Rollup Yes - No Routing
-- |         Find make items costs are based on the cost rollup, but there are no routings.
-- |     3.  Based on Rollup Yes - No Rollup
-- |         Find make items where it is set to be rolled up but there are
-- |         no rolled up costs
-- |     4.  Based on Rollup Yes - Buy Items
-- |         Find buy items where the item is set to rolled up 
-- |     5.  Based on Rollup No - With BOMS
-- |         Find make items where the item is not set to be rolled up
-- |         but BOMS or routings exist.
-- |     6.  Based on Rollup No - With Sourcing Rules
-- |         Find buy items where costs are not based on the cost rollup, but
-- |         sourcing rules exist.
-- |     7.  Based on Rollup No - Make Items
-- |         Find make items where the item is not set to rolled up, whether
-- |         or not BOMs or routings exist.
-- |     8.  Lot-Based Resources With Lot Size One
-- |         Find make items where there are charges based on Lot but the lot
-- |         size is one.  Duplicates the setup charges for each item you make.
-- |     9.  BOMs With No Components
-- |         Find make items with BOMS that have no components.
-- |    10.  Item Costing vs. Item Asset Controls
-- |         Find items where the item master costed flag (costed enabled) and
-- |         the item asset flag do not match.
-- |    11.  Item Asset vs. Costing Asset Controls
-- |         Find items where the item master asset and the costing asset flags do not match.
-- |    12.  Based on Rollup No - Defaulted Costs
-- |         Find items where the item is not rolled up but the defaulted flag says Yes.
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     15 Oct 2008 Douglas Volz   Initial Coding
-- |  1.35    23 Apr 2022 Douglas Volz   Add new column "Defaulted Costs" and new report type
-- |                                     "Based on Rollup No - Defaulted Costs".  The defaulted flag indicates
-- |                                     whether the cost of the item is defaulted from the default cost
-- |                                     type during the cost rollup.
+=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-cost-vs-planning-item-controls/
-- Library Link: https://www.enginatics.com/reports/cac-cost-vs-planning-item-controls/
-- Run Report: https://demo.enginatics.com/

with rept as
 (select mp.organization_code,
  cct.cost_type,
  cct.cost_type_id,
  msiv.concatenated_segments,
  msiv.description,
  muomv.uom_code,
  msiv.item_type,
  misv.inventory_item_status_code_tl,
  msiv.planning_make_buy_code,
  msiv.inventory_item_id,
  msiv.organization_id,
  -- check to see if a bom exists
  nvl((select distinct 'Y'
       from bom_structures_b bom
       where bom.organization_id     = mp.organization_id
       and bom.assembly_item_id    = msiv.inventory_item_id
       and bom.alternate_bom_designator is null),
  'N') BOM,
  -- check to see if a routing exists
  nvl((select distinct 'Y'
       from bom_operational_routings bor
       where bor.organization_id     = mp.organization_id
       and bor.assembly_item_id    = msiv.inventory_item_id
       and bor.alternate_routing_designator is null),
  'N') Routing,
   -- check to see if a sourcing rule exists for the receipt org
  nvl((select distinct 'Y'
       from mrp_sr_receipt_org msro,
    mrp_sr_source_org msso,
    mrp_sourcing_rules msr,
    mrp_sr_assignments msa,
    mrp_assignment_sets mas
       where msr.sourcing_rule_id    = msro.sourcing_rule_id
       -- fix for version 1.4, check to see if the sourcing rule is
       -- for an inventory org, not a vendor
       and msso.sr_receipt_id      = msro.sr_receipt_id
       and msso.source_organization_id is not null
       and msa.sourcing_rule_id    = msr.sourcing_rule_id
       and msa.assignment_set_id   = mas.assignment_set_id
       and msiv.organization_id    = msa.organization_id
       and msiv.inventory_item_id  = msa.inventory_item_id
       and 3=3                     -- p_assignment_set
       and mp.organization_id      = msa.organization_id),'N') Sourcing_Rule,
  cic.based_on_rollup_flag,
  -- Revision for version 1.35
  cic.defaulted_flag,
  msiv.costing_enabled_flag,
  msiv.inventory_asset_flag,
  to_char(cic.inventory_asset_flag) cost_asset_flag,
  msiv.std_lot_size,
  cic.lot_size cost_lot_size,
  cic.item_cost,
  msiv.creation_date
  from mtl_system_items_vl msiv,
  mtl_units_of_measure_vl muomv,
  mtl_item_status_vl misv, 
  cst_item_costs cic,
  cst_cost_types cct,
  mtl_parameters mp
  -- ===================================================================
  -- Cost type, organization, item master and report specific controls
  -- ===================================================================
  where cic.cost_type_id                = cct.cost_type_id
  and mp.organization_id              = cic.organization_id
  and msiv.organization_id            = cic.organization_id
  and msiv.inventory_item_id          = cic.inventory_item_id
  and msiv.primary_uom_code           = muomv.uom_code
  and misv.inventory_item_status_code = msiv.inventory_item_status_code
  and msiv.inventory_item_status_code <> 'Inactive'
  -- Avoid unused inventory organizations
  and mp.organization_id             <> mp.master_organization_id -- the item master org usually does not have costs
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 2=2                             -- p_cost_type, p_item_number, p_org_code
 )
select rept_all.report_type,
 nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 rept_all.organization_code Org_Code,
 rept_all.cost_type Cost_Type,
 rept_all.concatenated_segments Item_Number,
 rept_all.description Item_Description,
 rept_all.uom_code UOM_Code,
 fcl.meaning Item_Type,
 rept_all.inventory_item_status_code_tl Item_Status,
 ml1.meaning Make_Buy_Code,
&category_columns
 fl1.meaning BOM,
 fl2.meaning Routing,
 fl3.meaning Sourcing_Rule,       -- p_assignment_set
 ml2.meaning Based_on_Rollup,
 -- Revision for version 1.35
 ml4.meaning Defaulted_Flag,
 fl4.meaning Costing_Enabled,
 fl5.meaning Item_Inventory_Asset,
 ml3.meaning Cost_Inventory_Asset,
 rept_all.std_lot_size Item_Std_Lot_Size,
 rept_all.cost_lot_size Cost_Lot_Size,
 gl.currency_code Currency_Code,
 rept_all.Item_Cost,
 rept_all.creation_date Item_Creation_Date
from mfg_lookups ml1, -- Make/buy code, MTL_PLANNING_MAKE_BUY
 mfg_lookups ml2, -- based on rollup, CST_BONROLLUP_VAL
 mfg_lookups ml3, -- Cost inventory_asset_flag, SYS_YES_NO
 -- Revision for version 1.35
 mfg_lookups ml4, -- Cost defaulted_flag, SYS_YES_NO
 fnd_lookups fl1, -- BOM, YES_NO
 fnd_lookups fl2, -- Routing, YES_NO
 fnd_lookups fl3, -- Sourcing_Rule, YES_NO
 fnd_lookups fl4, -- Item costing enabled, YES_NO
 fnd_lookups fl5, -- Item inventory asset, YES_NO
 fnd_common_lookups fcl, -- Item Type
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl,
 (
  -- ===============================================
  -- Report 1 - 'Based on Rollup Yes - No BOMs'
  -- ===============================================
  select 'Based on Rollup Yes - No BOMs' report_type, rept.* from rept where rept.costing_enabled_flag = 'Y' and rept.planning_make_buy_code = 1 and rept.based_on_rollup_flag = 1 and rept.bom = 'N' 
  union all
  -- ===============================================
  -- Report 2 - 'Based on Rollup Yes - No Routing'
  -- ===============================================
  select 'Based on Rollup Yes - No Routing' report_type, rept.* from rept where rept.costing_enabled_flag = 'Y' and rept.planning_make_buy_code = 1 and rept.based_on_rollup_flag = 1 and rept.routing = 'N'
  union all
  -- ===============================================
  -- Report 3 - 'Based on Rollup Yes - No Rollup'
  -- ===============================================
  select 'Based on Rollup Yes - No Rollup' report_type, rept.* from rept where rept.costing_enabled_flag = 'Y' and (rept.planning_make_buy_code = 1 or (rept.planning_make_buy_code = 2 and rept.sourcing_rule = 'Y')) and rept.based_on_rollup_flag = 1
  and not exists
   (select 'x'
    from cst_item_cost_details cicd
    where cicd.organization_id    = rept.organization_id
    and cicd.inventory_item_id  = rept.inventory_item_id
    and cicd.cost_type_id       = rept.cost_type_id
    and cicd.rollup_source_type = 3 -- rolled up
   )
  union all
  -- ===============================================
  -- Report 4 - 'Based on Rollup Yes - Buy Items'
  -- ===============================================
  select 'Based on Rollup Yes - Buy Items' report_type, rept.* from rept where rept.costing_enabled_flag = 'Y' and rept.planning_make_buy_code = 2 and rept.based_on_rollup_flag = 1 and rept.sourcing_rule = 'N'
  union all
  -- ===============================================
  -- Report 5 - 'Based on Rollup No - With BOMs'
  -- ===============================================
  select 'Based on Rollup No - With BOMs' report_type, rept.* from rept where rept.costing_enabled_flag = 'Y' and rept.planning_make_buy_code = 1 and rept.based_on_rollup_flag = 2 and (rept.bom = 'Y' or rept.routing = 'Y')
  union all 
  -- ===============================================
  -- Report 6 - 'Based on Rollup No - With Sourcing Rules'
  -- ===============================================
  select 'Based on Rollup No - With Sourcing Rules' report_type, rept.* from rept where rept.costing_enabled_flag = 'Y' and rept.based_on_rollup_flag = 2 and rept.sourcing_rule = 'Y'
  union all
  -- ===============================================
  -- Report 7 - 'Based on Rollup No - Make Items'
  -- ===============================================
  select 'Based on Rollup No - Make Items' report_type, rept.* from rept where rept.costing_enabled_flag = 'Y' and rept.planning_make_buy_code = 1 and rept.based_on_rollup_flag = 2
  union all
  -- ===============================================
  -- Report 8 - 'Lot-Based Resources With Lot Size 1'
  -- ===============================================
  select 'Lot-Based Resources With Lot Size 1' report_type, rept.* from rept where rept.costing_enabled_flag = 'Y' and nvl(rept.cost_lot_size,1) = 1 and rept.planning_make_buy_code = 1
  and exists
   -- check to see if there are material or resource charges based on Lot
   (select 'x'
    from cst_item_cost_details cicd
    where cicd.organization_id    = rept.organization_id
    and cicd.inventory_item_id  = rept.inventory_item_id
    and cicd.cost_type_id       = rept.cost_type_id
    and cicd.basis_type         = 2 -- Lot
   )
  union all
  -- ===============================================
  -- Report 9 - BOMs With No Components
  -- ===============================================
  select 'BOMs With No Components' report_type, rept.* from rept where rept.costing_enabled_flag = 'Y' and rept.based_on_rollup_flag = 1 and rept.bom = 'Y'
  and not exists
   -- check to see if a BOM exists with components
   (select 'x'
    from bom_structures_b bom,
    bom_components_b comp
    where bom.organization_id     = rept.organization_id
    and bom.assembly_item_id    = rept.inventory_item_id
    and bom.bill_sequence_id    = comp.bill_sequence_id
    and comp.effectivity_date  <= sysdate
    and nvl(comp.disable_date, sysdate+1) >  sysdate 
   )
  union all
  -- ==========================================
  -- Report 10 - Item Costing vs. Item Asset Controls
  -- ==========================================
  -- Costing_Enabled <> Item_Inventory_Asset
  select 'Item Costing vs. Item Asset Controls' report_type, rept.* from rept where rept.costing_enabled_flag <> rept.inventory_asset_flag
  union all
  -- ===============================================
  -- Report 11 - Item Asset vs. Costing Asset Controls
  -- ===============================================
  -- Item_Inventory_Asset <> Cost Inventory_Asset
  select 'Item Asset vs. Costing Asset Controls' report_type, rept.* from rept where rept.inventory_asset_flag <> decode(rept.cost_asset_flag, 1, 'Y', 'N')
  -- Revision for version 1.35
  union all
  -- ===============================================
  -- Report 12 - Based on Rollup No - Defaulted Costs
  -- ===============================================
  select 'Based on Rollup No - Defaulted Costs' report_type, rept.* from rept where rept.defaulted_flag = 1 and rept.based_on_rollup_flag = 2
 -- End revision for version 1.35
 ) rept_all
-- ===================================================================
-- Joins for the lookup codes
-- ===================================================================
where ml1.lookup_type             = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code             = rept_all.planning_make_buy_code
and ml2.lookup_type             = 'CST_BONROLLUP_VAL'
and ml2.lookup_code             = rept_all.based_on_rollup_flag
and ml3.lookup_type             = 'SYS_YES_NO'
and ml3.lookup_code             = rept_all.cost_asset_flag
-- Revision for version 1.35
and ml4.lookup_type             = 'SYS_YES_NO'
and ml4.lookup_code             = rept_all.defaulted_flag
-- End revision for version 1.35
and fl1.lookup_type             = 'YES_NO'
and fl1.lookup_code             = rept_all.bom
and fl2.lookup_type             = 'YES_NO'
and fl2.lookup_code             = rept_all.routing
and fl3.lookup_type             = 'YES_NO'
and fl3.lookup_code             = rept_all.sourcing_rule
and fl4.lookup_type             = 'YES_NO'
and fl4.lookup_code             = rept_all.costing_enabled_flag
and fl5.lookup_type             = 'YES_NO'
and fl5.lookup_code             = rept_all.inventory_asset_flag
and fcl.lookup_type (+)         = 'ITEM_TYPE'
and fcl.lookup_code (+)         = rept_all.item_type
-- ===================================================================
-- using the base tables to avoid hr views
-- ===================================================================
and hoi.org_information_context = 'Accounting Information'
and hoi.organization_id         = rept_all.organization_id
and hoi.organization_id         = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
and haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and hoi.org_information1        = gl.ledger_id      -- this gets the ledger id
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                         -- p_operating_unit, p_ledger
-- Order by Report Type, Ledger, Operating_Unit, Org_Code, Cost_Type, Item_Number
order by
 rept_all.report_type,
 nvl(gl.short_name, gl.name),
 haou2.name,
 rept_all.organization_code,
 rept_all.cost_type,
 rept_all.concatenated_segments