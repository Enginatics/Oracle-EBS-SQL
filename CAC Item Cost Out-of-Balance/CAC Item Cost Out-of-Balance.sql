/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Cost Out-of-Balance
-- Description: Report to compare summary and detail item cost information and show any out-of-balances.  Any difference may cause an inventory reconciliation issue between the G/L and the inventory perpetual balances.

/* +=============================================================================+
-- | Copyright 2009-2020 Douglas Volz Consulting, Inc.                           |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_cost_diff_rept.sql
-- |
-- | Parameters:  None
-- |
-- | Description:
-- | Report to compare summary and detail item cost information and show any out-of-balances.
-- | Any difference may cause an inventory reconciliation issue between the G/L
-- | and the inventory perpetual balances.
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0     06 Oct 2009 Douglas Volz  Initial Coding
-- |  1.1     16 Mar 2010 Douglas Volz  Updated with Make/Buy flags
-- |  1.2     08 Nov 2010 Douglas Volz  Updated with additional columns and parameters
-- |  1.3     10 Dec 2012 Douglas Volz  Compare summary and detail item cost information.
-- |  1.4     29 Apr 2020 Douglas Volz  Changed to multi-language views for the item
-- |                                    master, operating unit and lookup values.  Add
-- |                                    Ledger and Operating Unit columns and parameters.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-item-cost-out-of-balance/
-- Library Link: https://www.enginatics.com/reports/cac-item-cost-out-of-balance/
-- Run Report: https://demo.enginatics.com/

select nvl(gl.short_name, gl.name) Ledger,
 haou2.name Operating_Unit,
 mp.organization_code Org_Code,
 cct.cost_type Cost_Type,
 msiv.concatenated_segments Item_Number,
 msiv.description Item_Description,
 -- Revision for version 1.5
&category_columns
 -- Revision for version 1.4
 muomv.uom_code UOM_Code,
 misv.inventory_item_status_code Item_Status,
 -- End revision for version 1.4
 fcl.meaning Item_Type,
 ml1.meaning Make_Buy_Code,
 fl1.meaning Allow_Costs,
 ml2.meaning Inventory_Asset,
 ml3.meaning Based_on_Rollup,
 cic.shrinkage_rate Shrinkage_Rate,
 max(nvl(cic.material_cost,0)) Sum_Material_Cost,
 max(nvl(cic.material_overhead_cost,0)) Sum_Material_Overhead_Cost,
 max(nvl(cic.resource_cost,0)) Sum_Resource_Cost,
 max(nvl(cic.outside_processing_cost,0)) Sum_Outside_Processing_Cost,
 max(nvl(cic.overhead_cost,0)) Sum_Overhead_Cost,
 max(nvl(cic.item_cost,0)) Sum_Item_Cost,
 sum(decode(cicd.cost_element_id, 1, nvl(cicd.item_cost,0),0)) Material_Cost,
 sum(decode(cicd.cost_element_id, 2, nvl(cicd.item_cost,0),0)) Material_Overhead_Cost,
 sum(decode(cicd.cost_element_id, 3, nvl(cicd.item_cost,0),0)) Resource_Cost,
 sum(decode(cicd.cost_element_id, 4, nvl(cicd.item_cost,0),0)) Outside_Processing_Cost,
 sum(decode(cicd.cost_element_id, 5, nvl(cicd.item_cost,0),0)) Overhead_Cost,
 sum(nvl(cicd.item_cost,0)) Detail_Item_Cost,
 max(nvl(cic.item_cost,0)) - sum(nvl(cicd.item_cost,0)) Item_Cost_Difference
from cst_item_costs cic,
 cst_item_cost_details cicd,
 cst_cost_types cct,
 mtl_system_items_vl msiv,
 -- Revision for version 1.4
 mtl_item_status_vl misv,
 mtl_units_of_measure_vl muomv,
 -- End revision for version 1.4
 mtl_parameters mp,
 -- Revision for version 1.4
 mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
 mfg_lookups ml2, -- inventory_asset_flag, SYS_YES_NO
 mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
 fnd_lookups fl1, -- allow costs, YES_NO
 fnd_common_lookups fcl,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl
-- ===================================================================
-- Item master, organization and item master to cost joins
-- ===================================================================
where mp.organization_id              = msiv.organization_id
and msiv.inventory_item_id          = cic.inventory_item_id
and msiv.organization_id            = cic.organization_id
-- Revision for version 1.4
and msiv.primary_uom_code           = muomv.uom_code
and msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.4
and cic.cost_type_id                = cct.cost_type_id
and cct.cost_type_id                = mp.primary_cost_method
-- Revision for version 1.5, outer join
and cic.inventory_item_id           = cicd.inventory_item_id (+)
and cic.organization_id             = cicd.organization_id (+)
and cic.cost_type_id                = cicd.cost_type_id (+)
-- ===================================================================
-- Lookup codes
-- ===================================================================
and ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml1.lookup_code                 = msiv.planning_make_buy_code
and ml2.lookup_type                 = 'SYS_YES_NO'
and ml2.lookup_code                 = to_char(cic.inventory_asset_flag)
and ml3.lookup_type                 = 'CST_BONROLLUP_VAL'
and ml3.lookup_code                 = cic.based_on_rollup_flag
and fl1.lookup_type                 = 'YES_NO'
and fl1.lookup_code                 = msiv.costing_enabled_flag
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
and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and 1=1                          -- p_org_code, p_operating_unit, p_ledger
-- avoid selecting disabled inventory organizations
and sysdate < nvl(haou.date_to, sysdate + 1)
group by
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating_Unit
  mp.organization_code,
 cct.cost_type,
        msiv.concatenated_segments,
        msiv.description,
 -- Revision for version 1.5
 msiv.inventory_item_id,
 msiv.organization_id,
 -- Revision for version 1.4
 muomv.uom_code, -- UOM_Code
 misv.inventory_item_status_code, -- Item_Status
 -- End revision for version 1.4
 fcl.meaning, -- Item_Type
 ml1.meaning, -- Make_Buy_Code
 fl1.meaning, -- Allow_Costs
 ml2.meaning, -- Inv_Asset
 ml3.meaning, -- Based_on_Rollup
 cic.shrinkage_rate
having abs(sum(nvl(cicd.item_cost,0)) - max(nvl(cic.item_cost,0))) > .00001
order by
 nvl(gl.short_name, gl.name), -- Ledger
 haou2.name, -- Operating_Unit
 mp.organization_code, -- Org_Code
 cct.cost_type, -- Cost_Type
 msiv.concatenated_segments -- Item_Number