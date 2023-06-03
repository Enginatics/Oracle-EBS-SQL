/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Where Used by Cost Type
-- Description: Report to download the single-level bills of materials and related component information, by organization by cost type.  And while exploding the bills of material you can also compare with two cost types, as well as limit the report to only assemblies and component items with a zero item cost.

/* +=============================================================================+
-- |  Copyright 2013 - 2019 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_where_used_by_cost_type_rept.sql
-- |
-- |  Parameters:
-- |  p_cost_type              -- Cost type costs to report, enter a cost type name.
-- |                              Required.
-- |  p_category_set1          -- The first item category set to report, typically the
-- |                              Cost or Product Line Category Set
-- |  p_category_set2          -- The second item category set to report, typically the
-- |                              Inventory Category Set
-- |  p_assembly_number        -- Enter the specific assembly number you wish to report (optional)
-- |  p_component_number       -- Enter the specific component number you wish to report (optional)
-- |  p_only_zero_costs        -- Show assemblies and components with a zero cost (optional)
-- |  p_include_expense_items  -- Yes/No flag to include or not include non-asset (not valued)
-- |  p_include_uncosted_items -- Yes/No flag to include or not costing not enabled items (optional)
-- |  p_org_code               -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit         -- Operating Unit you wish to report, leave blank for all
-- |                              operating units (optional) 
-- |  p_ledger                 -- general ledger you wish to report, leave blank for all
-- |                              ledgers (optional)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     08-Jun-2017 Douglas Volz   Initial Coding based on xxx_sl_bom_extract.sql
-- |  1.1     05-Nov-2018 Douglas Volz   Modified to client's item categories, don't
-- |                                     report obsolete items and remove location info.
-- |  1.2     03 Sep 2019 Douglas Volz   Add Ledger, Operating Unit, Item Type, Status
-- |                                     and item categories for cost and inventory.
-- |  1.3     27 Jan 2020 Douglas Volz   Added Operating Unit and Ledger parameters.
-- |  1.4     13 Jul 2020 Douglas Volz   Added item costs, parameters for components
-- |                                     and assemblies at a zero item cost, and
-- |                                     changed to multi-language views for translation.
-- |  1.5     24 Aug 2020 Douglas Volz   Component WIP Supply Type not always populated,
-- |                                     needed to add an outer join on the lookup code.
-- |  1.6     01 Sep 2020 Douglas Volz   Revision to avoid getting other cost type
-- |                                     entries for non-asset and uncosted items.
-- |  1.7     14 Sep 2020 Douglas Volz   Revision for faster queries by item number.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-where-used-by-cost-type/
-- Library Link: https://www.enginatics.com/reports/cac-where-used-by-cost-type/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 msiv.concatenated_segments Assembly,
 msiv.description Assembly_Description,
 -- Revision for version 1.2
 fcl_assy.meaning Assembly_Item_Type,
 -- Revision for version 1.4
 misv.inventory_item_status_code Assembly_Status_Code,
 ml_assy.meaning Assembly_Make_Buy_Code,
 fl_assy.meaning Assembly_Costing_Enabled,
 fl_assy2.meaning Assembly_Asset,
 muomv.uom_code UOM_Code,
 ml_assy2.meaning BOM_Type,
 -- End for revision 1.4
 bom.implementation_date Date_Implemented,
 mir.revision_code Item_Revision,
 -- End revision for version 1.2
&category_columns
 -- Revision for version 1.8
 nvl(cic_assy2.item_cost,0) "&p_cost_type2 Assembly Cost",
 nvl(cic_assy.item_cost,0) "&p_cost_type Assembly Cost",
 nvl(cic_assy2.item_cost,0) - nvl(cic_assy.item_cost,0) Assembly_Cost_Difference,
 -- Calculate the percentage
 -- case
 --   when difference = 0 then 0
 --   when new = 0 then 100%
 --   when old = 0 then -100%
 --   else old - new / old
 round(
 case
    when round((nvl(cic_assy2.item_cost,0) - nvl(cic_assy.item_cost,0)),5) = 0 then 0
    when round(nvl(cic_assy2.item_cost,0),5) = 0 then -100
    when round(nvl(cic_assy.item_cost,0),5) = 0 then  100
    -- else New - Old / Old
    else round((nvl(cic_assy2.item_cost,0) - nvl(cic_assy.item_cost,0)),5) / round(nvl(cic_assy.item_cost,0),5) * 100
 end,2) Assembly_Percent_Difference,
 -- End revision for version 1.8
 comp.operation_seq_num Op_Seq,
 comp.item_num Item_Seq,
 msiv2.concatenated_segments Component,
 msiv2.description Component_Description,
 msiv2.primary_uom_code Component_UOM,
 fcl_comp.meaning Component_Item_Type,
 -- Revision for version 1.4
 misv2.inventory_item_status_code Component_Status_Code,
 ml_comp.meaning Component_Make_Buy_Code,
 fl_comp.meaning Component_Costing_Enabled,
 fl_comp2.meaning Component_Asset,
 -- End revision for version 1.4
 comp.component_quantity Quantity_per_Assembly,
 comp.effectivity_date Effective_From,
 comp.disable_date Effective_To,
 nvl(comp.planning_factor,0) Planning_Percent,
 comp.component_yield_factor Yield,
 -- Revision for version 1.4
 ml_comp2.meaning Include_in_Cost_Rollup,
 ml_comp3.meaning WIP_Supply_Type,
 -- Revision for version 1.8
 nvl(cic_comp2.item_cost,0) "&p_cost_type2 Component Cost",
 nvl(cic_comp.item_cost,0) "&p_cost_type Component Cost",
 nvl(cic_comp2.item_cost,0) - nvl(cic_comp.item_cost,0) Component_Cost_Difference,
 -- Calculate the percentage
 -- case
 --   when difference = 0 then 0
 --   when new = 0 then 100%
 --   when old = 0 then -100%
 --   else old - new / old
 round(
 case
    when round((nvl(cic_comp2.item_cost,0) - nvl(cic_comp.item_cost,0)),5) = 0 then 0
    when round(nvl(cic_comp2.item_cost,0),5) = 0 then -100
    when round(nvl(cic_comp.item_cost,0),5) = 0 then  100
    -- else New - Old / Old
    else round((nvl(cic_comp2.item_cost,0) - nvl(cic_comp.item_cost,0)),5) / round(nvl(cic_comp.item_cost,0),5) * 100
 end,2) Component_Percent_Difference,
 -- End revision for version 1.8
 -- End revision for version 1.4
 nvl((select sum(mohd.transaction_quantity)
      from mtl_onhand_quantities_detail mohd,
   mtl_parameters mp
      where mohd.inventory_item_id  = msiv.inventory_item_id
      and mp.organization_id      = mohd.organization_id),0) Assembly_Onhand_Quantity,
 nvl((select sum(mohd.transaction_quantity)
      from mtl_onhand_quantities_detail mohd,
   mtl_parameters mp
      where mohd.inventory_item_id  = msiv2.inventory_item_id
      and mp.organization_id      = mohd.organization_id
      and mohd.organization_id    = msiv2.organization_id),0) Component_Onhand_Quantity
from mtl_parameters mp,
 mtl_system_items_vl msiv,  -- Assembly
 mtl_system_items_vl msiv2, -- Component
 bom_structures_b bom,
 -- Revision for version 1.4 
 mtl_item_status_vl misv,  -- Assembly
 mtl_item_status_vl misv2, -- Component
 mtl_units_of_measure_vl muomv,
 mtl_units_of_measure_vl muomv2,
 mfg_lookups ml_assy,
 mfg_lookups ml_assy2,
 fnd_lookups fl_assy,
 fnd_lookups fl_assy2,
 mfg_lookups ml_comp,
 mfg_lookups ml_comp2,
 mfg_lookups ml_comp3,
 fnd_lookups fl_comp,
 fnd_lookups fl_comp2,
 -- End revision for version 1.4
 -- Revision for version 1.2
 fnd_common_lookups fcl_assy,
 fnd_common_lookups fcl_comp,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl,
 -- End revision for version 1.2
 -- Get the BOM Components
 (select comp.bill_sequence_id,
  comp.item_num,
  comp.operation_seq_num,
  comp.component_item_id,
  comp.component_quantity,
  max(comp.effectivity_date) effectivity_date,
  comp.disable_date,
  comp.planning_factor,
  comp.component_yield_factor,
  comp.include_in_cost_rollup,
  comp.wip_supply_type,
  comp.supply_subinventory,
  comp.supply_locator_id
  from bom_components_b comp,
  -- Revision for version 1.1
  -- Add BOM table to only look at primary components
  bom_structures_b bom_comp,
  -- Revision for version 1.5
  -- Add organization_parameters to limit by Org Code
  mtl_parameters mp,
  -- Revision for version 1.7
  mtl_system_items_vl msiv2
  where comp.effectivity_date       <= sysdate
  and nvl(comp.disable_date, sysdate+1) >  sysdate 
  and bom_comp.alternate_bom_designator is null
  and bom_comp.common_assembly_item_id is null
  and bom_comp.assembly_type       = 1   -- Manufacturing
  and bom_comp.bill_sequence_id    = comp.bill_sequence_id
  -- Revision for version 1.5
  and mp.organization_id           = bom_comp.organization_id
  -- Revision for version 1.7
  and msiv2.organization_id        = bom_comp.organization_id
  and msiv2.inventory_item_id      = comp.component_item_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 5=5                        -- p_org_code
  and 6=6                        -- p_comp_number
  -- Revision for version 1.9
  and 8=8                        -- p_include_unimplemented_ECOs   
  group by
  comp.bill_sequence_id,
  comp.item_num,
  comp.operation_seq_num,
  comp.component_item_id,
  comp.component_quantity,
  comp.disable_date,
  comp.planning_factor,
  comp.component_yield_factor,
  comp.include_in_cost_rollup,
  comp.wip_supply_type,
  comp.supply_subinventory,
  comp.supply_locator_id) comp,
 -- Get the Item_Revisions
 (select max(mir.revision)     revision_code,
  mir.inventory_item_id inventory_item_id,
  mir.organization_id   organization_id
  from mtl_item_revisions_b mir,
  -- Revision for version 1.5
  -- Add organization_parameters to limit by Org Code
  mtl_parameters mp
  where mir.effectivity_date      <= sysdate
  -- Revision for version 1.5
  and mp.organization_id         = mir.organization_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 5=5                        -- p_org_code
  group by
  mir.inventory_item_id,
  mir.organization_id) mir,
 -- Revision for version 1.1
 -- inv.mtl_item_locations mil
 -- Revision for version 1.4
 -- Need table select statements to avoid 2nd outer join
 (select cic.cost_type_id,
  cct.cost_type,
  cic.inventory_item_id,
  cic.organization_id,
  cic.item_cost
  from cst_cost_types cct,
  cst_item_costs cic,
  -- Revision for version 1.4
  mtl_parameters mp,
  -- Revision for version 1.7
  mtl_system_items_vl msiv
  where cct.cost_type_id           = cic.cost_type_id
  -- Revision for version 1.7
  and msiv.organization_id       = cic.organization_id
  and msiv.inventory_item_id     = cic.inventory_item_id
  -- Revision for version 1.9
  and mp.organization_id         = msiv.organization_id
  -- End revision for version 1.9
  and 4=4                        -- p_cost_type
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 5=5                        -- p_org_code
  and 7=7                        -- p_assy_number
 ) cic_assy,
 (select cic.cost_type_id,
  cct.cost_type,
  cic.inventory_item_id,
  cic.organization_id,
  cic.item_cost
  from cst_cost_types cct,
  cst_item_costs cic,
  -- Revision for version 1.4
  mtl_parameters mp,
  -- Revision for version 1.7
  mtl_system_items_vl msiv2
  where cct.cost_type_id           = cic.cost_type_id
  -- Revision for version 1.4
  and mp.organization_id         = cic.organization_id
  -- Revision for version 1.7
  and msiv2.organization_id      = cic.organization_id
  and msiv2.inventory_item_id    = cic.inventory_item_id
  and 4=4                        -- p_cost_type
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 5=5                        -- p_org_code
  and 6=6                        -- p_comp_number
 ) cic_comp,
 -- End of revision for version 1.4
 -- Revision for version 1.8
 (select cic.cost_type_id,
  cct.cost_type,
  cic.inventory_item_id,
  cic.organization_id,
  cic.item_cost
  from cst_cost_types cct,
  cst_item_costs cic,
  -- Revision for version 1.4
  mtl_parameters mp,
  -- Revision for version 1.7
  mtl_system_items_vl msiv
  where cct.cost_type_id           = cic.cost_type_id
  and msiv.organization_id       = cic.organization_id
  and msiv.inventory_item_id     = cic.inventory_item_id
  -- Revision for version 1.9
  and mp.organization_id         = msiv.organization_id 
  and 9=9                        -- p_cost_type2
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 5=5                        -- p_org_code
  and 7=7                        -- p_assy_number
 ) cic_assy2, -- comparison assembly cost type
 (select cic.cost_type_id,
  cct.cost_type,
  cic.inventory_item_id,
  cic.organization_id,
  cic.item_cost
  from cst_cost_types cct,
  cst_item_costs cic,
  mtl_parameters mp,
  mtl_system_items_vl msiv2
  where cct.cost_type_id           = cic.cost_type_id
  and msiv2.organization_id      = cic.organization_id
  and msiv2.inventory_item_id    = cic.inventory_item_id
  -- Revision for version 1.9
  and mp.organization_id         = msiv2.organization_id 
  and 9=9                        -- p_cost_type
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 5=5                        -- p_org_code
  and 6=6                        -- p_comp_number
 ) cic_comp2 -- comparison component cost type
 -- End revision for version 1.8
where mp.organization_id                 = msiv.organization_id
and msiv.organization_id               = bom.organization_id
and msiv.inventory_item_id             = bom.assembly_item_id
and msiv2.organization_id              = mp.organization_id
and msiv2.inventory_item_id            = comp.component_item_id
and bom.alternate_bom_designator is null
and bom.common_assembly_item_id is null
and bom.assembly_type                  = 1   -- Manufacturing
and bom.bill_sequence_id               = comp.bill_sequence_id
and comp.effectivity_date             <= sysdate
and nvl(comp.disable_date, sysdate+1) >  sysdate
and msiv.organization_id               = mir.organization_id
and msiv.inventory_item_id             = mir.inventory_item_id
-- Revision for version 1.1
-- and comp.supply_locator_id             = mil.inventory_location_id (+)
-- Revision for version 1.1
-- Don't report obsolete or inactive items
and msiv.inventory_item_status_code   <> 'Inactive'
and msiv2.inventory_item_status_code  <> 'Inactive'
-- Revision for version 1.4
and muomv.uom_code                     = msiv.primary_uom_code
and misv.inventory_item_status_code    = msiv.inventory_item_status_code
and muomv2.uom_code                    = msiv2.primary_uom_code
and misv2.inventory_item_status_code   = msiv2.inventory_item_status_code
-- Revision for version 1.8
and cic_assy.inventory_item_id (+)     = msiv.inventory_item_id
and cic_assy.organization_id (+)       = msiv.organization_id
and cic_comp.inventory_item_id (+)     = msiv2.inventory_item_id
and cic_comp.organization_id (+)       = msiv2.organization_id
and cic_assy2.inventory_item_id (+)    = msiv.inventory_item_id
and cic_assy2.organization_id (+)      = msiv.organization_id
and cic_comp2.inventory_item_id (+)    = msiv2.inventory_item_id
and cic_comp2.organization_id (+)      = msiv2.organization_id
-- End revision for version 1.8
-- End revision for version 1.8
-- End revision for version 1.4
-- End for revision 1.2
-- =======================================
-- Lookup codes for Item_Types
and fcl_comp.lookup_code (+)           = msiv2.item_type -- components
and fcl_comp.lookup_type (+)           = 'ITEM_TYPE'
-- Revision for version 1.2
and fcl_assy.lookup_code (+)           = msiv.item_type -- assemblies
and fcl_assy.lookup_type (+)           = 'ITEM_TYPE'
-- Revision for version 1.4
and ml_assy.lookup_type                = 'MTL_PLANNING_MAKE_BUY'
and ml_assy.lookup_code                = msiv.planning_make_buy_code
and ml_assy2.lookup_type               = 'BOM_TRANSITION_TYPE'
and ml_assy2.lookup_code               = 1 -- Primary
and fl_assy.lookup_type                = 'YES_NO'
and fl_assy.lookup_code                = msiv.costing_enabled_flag
and fl_assy2.lookup_type               = 'YES_NO'
and fl_assy2.lookup_code               = msiv.inventory_asset_flag
and ml_comp.lookup_type                = 'MTL_PLANNING_MAKE_BUY'
and ml_comp.lookup_code                = msiv2.planning_make_buy_code
and ml_comp2.lookup_type               = 'SYS_YES_NO'
and ml_comp2.lookup_code               = comp.include_in_cost_rollup
-- Revision for version 1.5
and ml_comp3.lookup_type (+)           = 'WIP_SUPPLY'
and ml_comp3.lookup_code (+)           = comp.wip_supply_type
-- End revision for version 1.5
and fl_comp.lookup_type                = 'YES_NO'
and fl_comp.lookup_code                = msiv2.costing_enabled_flag
and fl_comp2.lookup_type               = 'YES_NO'
and fl_comp2.lookup_code               = msiv2.inventory_asset_flag
-- ===================================================================
-- using the base tables to avoid using
-- org_organization_definitions and hr_operating_units
-- ===================================================================
and hoi.org_information_context        = 'Accounting Information'
and hoi.organization_id                = mp.organization_id
and hoi.organization_id                = haou.organization_id   -- this gets the organization name
and haou2.organization_id              = hoi.org_information3   -- this gets the operating unit id
and gl.ledger_id                       = to_number(hoi.org_information1) -- get the ledger_id
and 1=1                               -- p_include_expense_items, p_only_zero_costs, p_operating_unit, p_ledger
and 5=5                               -- p_org_code
and 6=6                               -- p_comp_number
and 7=7                               -- p_assy_number
-- Revision for version 1.4
-- Avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
-- Revision for version 1.8, comment this section out
-- Revision for version 1.6
-- Avoid getting item costs from other cost types when
-- the item is not costing enabled or not an inventory asset
-- and not exists
--  (select 'x'
--   from cst_item_costs cic
--   where cic.organization_id   = cic_assy.organization_id
--   and cic.inventory_item_id = cic_assy.inventory_item_id
--   and (msiv.inventory_asset_flag = 'N' or msiv.costing_enabled_flag = 'N')
--   and cic.cost_type_id     <> cic_assy.cost_type_id
--  )
-- and not exists
--  (select 'x'
--   from cst_item_costs cic
--   where cic.organization_id   = cic_comp.organization_id
--   and cic.inventory_item_id = cic_comp.inventory_item_id
--   and (msiv2.inventory_asset_flag = 'N' or msiv2.costing_enabled_flag = 'N')
--   and cic.cost_type_id     <> cic_comp.cost_type_id
--  )
-- End for revision 1.6 and 1.7 and 1.8
order by
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating_Unit
 mp.organization_code, -- Org_Code
 msiv.concatenated_segments, -- Assembly
 comp.operation_seq_num, -- Op_Seq
 comp.item_num, -- Item_Seq
 msiv2.concatenated_segments -- Component