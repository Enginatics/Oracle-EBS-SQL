/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Cost & Routing
-- Description: Report to show detailed item costs for buy and make items for one or any two cost types.  If you enter the second cost type you get a row-by-row comparison in detail.

/* +=============================================================================+
-- | Copyright 2010 - 2019 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_costs_routing_rept.sql
-- |
-- |  Parameters:
-- |  p_cost_type               The cost type you wish to report
-- |  p_cost_type2              Name for the second cost type you wish to review.
-- |                            If you leave this blank you only report the first
-- |                            cost type.
-- |  p_ledger                  The ledger you wish to report
-- |  p_item_number             Enter the specific item number you wish to report
-- |
-- | Description:
-- | Report to show detailed item costs for buy and make items for any two cost types.
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0     06 Oct 2009 Douglas Volz  Initial Coding
-- |  1.1     16 Mar 2010 Douglas Volz  Updated with Make/Buy flags
-- |  1.2     26 Aug 2010 Douglas Volz  Added two cost types and effectivity date
-- |                                    parameters.
-- |  1.3     12 Oct 2010 Douglas Volz  Added parameters for business objects
-- |  1.4     26 Oct 2010 Douglas Volz  Added parameter for specific Item Number
-- |  1.5     01 Feb 2017 Douglas Volz  Added Resource Activity and Cost Category
-- |  1.6     22 May 2017 Douglas Volz  Added inventory item category
-- |  1.7     30 Aug 2019 Douglas Volz  Removed non-costed resources
-- |  1.8     26 Apr 2020 Douglas Volz  Changed to multi-language views for the item
-- |                                    master, inventory orgs and operating units
-- |  1.9     21 Oct 2020 Douglas Volz  Added Category1, Category2, Cost Creation
-- |                                    Date, Last Cost Update Date, screen out
-- |                                    the item master orgs.
-- |  1.10    17 Mar 2021 Douglas Volz  Add parameter for Inactive Items.
.+=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-item-cost-routing/
-- Library Link: https://www.enginatics.com/reports/cac-item-cost-routing/
-- Run Report: https://demo.enginatics.com/

select costs.ledger Ledger,
 costs.operating_unit Operating_Unit,
 costs.organization_code Org_Code,
 costs.item Item_Number,
 costs.item_description Item_Description,
 costs.primary_uom_code UOM_Code,
 -- Revision for version 1.5
&category_columns
 -- End revision for version 1.6
 costs.item_type Item_Type,
 costs.inventory_item_status_code Item_Status,
 costs.based_on_rollup Based_on_Rollup,
 costs.planning_make_buy_code Make_Buy_Code,
 costs.department_code Department,
 costs.level_type Level_Type,
 costs.cost_element Cost_Element,
 costs.operation_seq_num Operation_Seq_Number,
 costs.resource_seq_num Resource_Seq_Number,
 costs.source_organization Source_Org,
 costs.allocation_percent Allocation_Percent,
 costs.resource_code Sub_Element,
 costs.res_unit_of_measure Sub_Element_UOM,
 -- Revision for version 1.5
 costs.activity Activity,
 costs.cost_type Cost_Type,
 costs.rollup_source_type Cost_Source,
 costs.cost_basis Basis_Type,
 costs.lot_size Lot_Size,
 costs.shrinkage_rate Shrinkage_Rate,
 costs.basis_factor Basis_Factor,
 costs.net_yield_or_shrinkage_factor Shrinkage_Factor,
 costs.resource_rate Resource_Rate,
 costs.usage_rate_or_amount Rate_or_Amount,
 costs.currency_code Currency_Code,
 costs.detailed_item_cost Detailed_Item_Cost,
 costs.total_item_cost Total_Item_Cost,
 -- Revision for version 1.9
 costs.cost_creation_date Cost_Creation_Date,
 costs.cost_last_update_date Cost_Last_Update_Date,
 costs.item_creation_date Item_Creation_Date,
 costs.item_last_update_date Item_Last_Update_Date
 -- End revision for version 1.9
from (
  -- ===================================================
  -- Get the item costs from your buy and routing costs
  -- for your pending cost type
  -- ===================================================
  select nvl(gl.short_name, gl.name) ledger,
  haou2.name operating_unit,
  mp.organization_code,
  msiv.concatenated_segments item,
  msiv.description item_description,
  -- Revision for version 1.8
  muomv.uom_code primary_uom_code,
  fcl.meaning item_type,
  -- Revision for version 1.5 and 1.6
  msiv.organization_id,
  msiv.inventory_item_id,
  -- End revision for version 1.5 and 1.6
  -- Revision for version 1.8
  misv.inventory_item_status_code,
  ml1.meaning based_on_rollup,
  ml2.meaning planning_make_buy_code,
  bd.department_code,
  ml3.meaning level_type,
  cce.cost_element,
  cicd.operation_seq_num,
  cicd.resource_seq_num,
  mp2.organization_code source_organization,
  cicd.allocation_percent,
  br.resource_code,
  br.unit_of_measure res_unit_of_measure,
  -- Revision for version 1.5
  nvl((select ca.activity
       from cst_activities ca
       where ca.activity_id = br.default_activity_id),'') activity,
  -- End revision for version 1.5
  cct.cost_type,
  ml4.meaning rollup_source_type,
  ml5.meaning cost_basis,
  cic.lot_size,
  cic.shrinkage_rate shrinkage_rate,
  cicd.basis_factor,
  cicd.net_yield_or_shrinkage_factor,
  cicd.resource_rate,
  cicd.usage_rate_or_amount,
  gl.currency_code,
  cicd.item_cost detailed_item_cost,
  nvl(cic.item_cost,0) total_item_cost,
  -- Revision for version 1.9
  cic.creation_date cost_creation_date,
  cic.last_update_date cost_last_update_date,
  msiv.creation_date item_creation_date,
  msiv.last_update_date item_last_update_date
  -- End revision for version 1.9
  from cst_item_costs cic,
  cst_item_cost_details cicd,
  mtl_system_items_vl msiv,
  -- Revision for version 1.8
  mtl_item_status_vl misv,
  mtl_units_of_measure_vl muomv,
  -- End revision for version 1.8
  mtl_parameters mp,               -- target inventory org
  mtl_parameters mp2,              -- source inventory org
  cst_cost_elements cce,
  bom_resources br,
  bom_departments bd,
  cst_cost_types cct,
  mfg_lookups ml1, -- based on rollup, CST_BONROLLUP_VAL
  mfg_lookups ml2, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
  mfg_lookups ml3, -- level_type, CST_LEVEL
  mfg_lookups ml4, -- rollup source type, CST_SOURCE_TYPE
  mfg_lookups ml5, -- basis_type, CST_BASIS_SHORT
  fnd_common_lookups fcl,
  hr_organization_information hoi,
  hr_all_organization_units_vl haou,  -- inv_organization_id
  hr_all_organization_units_vl haou2, -- operating unit
  gl_ledgers gl
  where msiv.inventory_item_id          = cic.inventory_item_id
  -- Revision for version 1.8
  and msiv.primary_uom_code           = muomv.uom_code
  and msiv.inventory_item_status_code = misv.inventory_item_status_code
  -- End revision for version 1.8
  -- =============================
  -- Add parameter for version 1.4
  -- =============================
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 1=1                         -- p_item_number, p_org_code, p_operating_unit, p_ledger
  and 4=4                         -- p_cost_type1
  and 6=6                         -- p_include_inactive_items
  and mp.organization_id              = cic.organization_id
  and cic.cost_type_id                = cct.cost_type_id
  and msiv.organization_id            = mp.organization_id
  and cicd.source_organization_id     = mp2.organization_id (+)
  and cic.cost_type_id                = cicd.cost_type_id
  and cic.organization_id             = cicd.organization_id
  and cic.inventory_item_id           = cicd.inventory_item_id
  and cicd.cost_element_id            = cce.cost_element_id
  and cicd.resource_id                = br.resource_id (+)
  and cicd.department_id              = bd.department_id (+)
  -- =======================================
  -- Lookup codes
  -- =======================================
  and ml1.lookup_type                 = 'CST_BONROLLUP_VAL'
  and ml1.lookup_code                 = cic.based_on_rollup_flag
  and ml2.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
  and ml2.lookup_code                 = msiv.planning_make_buy_code
  and ml3.lookup_type                 = 'CST_LEVEL'
  and ml3.lookup_code                 = cicd.level_type
  and ml4.lookup_type                 = 'CST_SOURCE_TYPE'
  and ml4.lookup_code                 = cicd.rollup_source_type
  and ml5.lookup_type                 = 'CST_BASIS_SHORT'
  and ml5.lookup_code                 = cicd.basis_type
  and fcl.lookup_code (+)             = msiv.item_type
  and fcl.lookup_type (+)             = 'ITEM_TYPE'
  -- =======================================
  -- using the base tables for organization
  --  and operating unit definitions.
  -- =======================================
  and hoi.org_information_context     = 'Accounting Information'
  and hoi.organization_id             = mp.organization_id
  and hoi.organization_id             = haou.organization_id            -- this gets the organization name
  and haou2.organization_id           = hoi.org_information3            -- this gets the operating unit id
  and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
  -- =======================================
  -- Screen out master and disabled inventory orgs
  -- =======================================
  and mp.organization_id             <> mp.master_organization_id
  and sysdate                        <  nvl(haou.date_to, sysdate +1)
  -- ===================================================================
  union all
  -- ===================================================
  -- Get the item costs from your buy and routing costs
  -- for your comparison or second cost type
  -- ===================================================
  select nvl(gl.short_name, gl.name) ledger,
  haou2.name operating_unit,
  mp.organization_code,
  msiv.concatenated_segments item,
  msiv.description item_description,
  -- Revision for version 1.8
  muomv.uom_code primary_uom_code,
  fcl.meaning item_type,
  -- Revision for version 1.5 and 1.6
  msiv.organization_id,
  msiv.inventory_item_id,
  -- End revision for version 1.5 and 1.6
  -- Revision for version 1.8
  misv.inventory_item_status_code,
  ml1.meaning based_on_rollup,
  ml2.meaning planning_make_buy_code,
  bd.department_code,
  ml3.meaning level_type,
  cce.cost_element,
  cicd.operation_seq_num,
  cicd.resource_seq_num,
  mp2.organization_code source_organization,
  cicd.allocation_percent,
  br.resource_code,
  br.unit_of_measure res_unit_of_measure,
  -- Revision for version 1.5
  nvl((select ca.activity
   from cst_activities ca
   where ca.activity_id = br.default_activity_id),'') activity,
  -- End revision for version 1.5
  cct.cost_type,
  ml4.meaning rollup_source_type,
  ml5.meaning cost_basis,
  cic.lot_size,
  cic.shrinkage_rate shrinkage_rate,
  cicd.basis_factor,
  cicd.net_yield_or_shrinkage_factor,
  cicd.resource_rate,
  cicd.usage_rate_or_amount,
  gl.currency_code,
  cicd.item_cost detailed_item_cost,
  nvl(cic.item_cost,0) total_item_cost,
  -- Revision for version 1.9
  cic.creation_date cost_creation_date,
  cic.last_update_date cost_last_update_date,
  msiv.creation_date item_creation_date,
  msiv.last_update_date item_last_update_date
  -- End revision for version 1.9
  from cst_item_costs cic,
  cst_item_cost_details cicd,
  mtl_system_items_vl msiv,
  -- Revision for version 1.8
  mtl_item_status_vl misv,
  mtl_units_of_measure_vl muomv,
  -- End revision for version 1.8
  mtl_parameters mp,               -- target inventory org
  mtl_parameters mp2,              -- source inventory org
  cst_cost_elements cce,
  bom_resources br,
  bom_departments bd,
  cst_cost_types cct,
  mfg_lookups ml1, -- based on rollup, CST_BONROLLUP_VAL
  mfg_lookups ml2, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
  mfg_lookups ml3, -- level_type, CST_LEVEL
  mfg_lookups ml4, -- rollup source type, CST_SOURCE_TYPE
  mfg_lookups ml5, -- basis_type, CST_BASIS_SHORT
  fnd_common_lookups fcl,
  hr_organization_information hoi,
  hr_all_organization_units_vl haou,  -- inv_organization_id
  hr_all_organization_units_vl haou2, -- operating unit
  gl_ledgers gl
  where msiv.inventory_item_id          = cic.inventory_item_id
  -- Revision for version 1.8
  and msiv.primary_uom_code           = muomv.uom_code
  and msiv.inventory_item_status_code = misv.inventory_item_status_code
  -- End revision for version 1.8
  -- Add parameter for version 1.
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 1=1                         -- p_item_number, p_org_code, p_operating_unit, p_ledger
  and 5=5                         -- p_cost_type2
  and 6=6                         -- p_include_inactive_items
  and :p_cost_type2 is not null
  and mp.organization_id              = cic.organization_id
  and cic.cost_type_id                = cct.cost_type_id
  and msiv.organization_id            = mp.organization_id
  and cicd.source_organization_id     = mp2.organization_id (+)
  and cic.cost_type_id                = cicd.cost_type_id
  and cic.organization_id             = cicd.organization_id
  and cic.inventory_item_id           = cicd.inventory_item_id
  and cicd.cost_element_id            = cce.cost_element_id
  and cicd.resource_id                = br.resource_id (+)
  and cicd.department_id              = bd.department_id (+)
  -- =======================================
  -- Lookup codes
  -- =======================================
  and ml1.lookup_type                 = 'CST_BONROLLUP_VAL'
  and ml1.lookup_code                 = cic.based_on_rollup_flag
  and ml2.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
  and ml2.lookup_code                 = msiv.planning_make_buy_code
  and ml3.lookup_type                 = 'CST_LEVEL'
  and ml3.lookup_code                 = cicd.level_type
  and ml4.lookup_type                 = 'CST_SOURCE_TYPE'
  and ml4.lookup_code                 = cicd.rollup_source_type
  and ml5.lookup_type                 = 'CST_BASIS_SHORT'
  and ml5.lookup_code                 = cicd.basis_type
  and fcl.lookup_code (+)             = msiv.item_type
  and fcl.lookup_type (+)             = 'ITEM_TYPE'
  -- =======================================
  -- using the base tables for organization
  -- and operating unit definitions.
  -- =======================================
  and hoi.org_information_context     = 'Accounting Information'
  and hoi.organization_id             = mp.organization_id
  and hoi.organization_id             = haou.organization_id            -- this gets the organization name
  and haou2.organization_id           = hoi.org_information3            -- this gets the operating unit id
  and gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
  -- =======================================
  -- Screen out master and disabled inventory orgs
  -- =======================================
  and mp.organization_id             <> mp.master_organization_id
  and sysdate                        <  nvl(haou.date_to, sysdate +1)
  -- =======================================
 ) costs
order by 
 costs.ledger, -- Ledger
 costs.operating_unit, -- Operating_Unit
 costs.organization_code, -- Org_Code
        costs.item, -- Item_Number
 costs.department_code, -- Dept
 costs.level_type, -- Level
 costs.cost_element, -- Cost_Element
 costs.operation_seq_num, -- Op_Seq Num
 costs.resource_seq_num, -- Res Seq Num
 costs.resource_code, -- Sub-Element
 costs.cost_type -- Cost_Type