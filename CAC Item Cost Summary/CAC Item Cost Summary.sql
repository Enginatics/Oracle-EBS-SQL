/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Cost Summary
-- Description: Displays item costs in any cost type.  For one or more inventory organizations.

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
-- | Program Name: xxx_item_cost_rept.sql
-- |
-- |  Parameters:
-- |  p_cost_type              -- The cost type you wish to report
-- |  p_ledger                 -- general ledger you wish to report, works with
-- |                              null or valid ledger names
-- |  p_item_number            -- Enter the specific item number you wish to report
-- |  p_org_code               -- specific organization code, works with
-- |                              null or valid organization codes
-- |  p_include_uncosted_items -- Yes/No flag to include or not include non-costed resources
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
-- |                                    status and UOM.+=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-item-cost-summary/
-- Library Link: https://www.enginatics.com/reports/cac-item-cost-summary/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
-- ===================================================================
-- First get the items which are costing enabled 
-- ===================================================================
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	cct.cost_type Cost_Type,
	msiv.concatenated_segments Item_Number,
	msiv.description Description,
	-- Revision for version 1.7
	muomv.uom_code UOM_Code,
	fcl.meaning Item_Type,
	-- Revision for version 1.7
	misv.inventory_item_status_code Item_Status,
	ml1.meaning Make_Buy_Code,
	-- Revision for version 1.4
	nvl((select	max(mc.segment1)
	     from	mtl_categories_v mc,
			mtl_item_categories mic,
			mtl_category_sets_b mcs,
			mtl_category_sets_tl mcs_tl
	     where	mic.category_set_id         = mcs.category_set_id
	     and	2=2 
	     and	mic.inventory_item_id       = msiv.inventory_item_id
	     and	mic.organization_id         = msiv.organization_id
	     and	mc.category_id              = mic.category_id
	     and	mcs.category_set_id         = mcs_tl.category_set_id
	     and	mcs_tl.language             = userenv('lang')
	   ),'') "&p_category_set1",
	nvl((select	max(mc.segment1)
	     from	mtl_categories_v mc,
			mtl_item_categories mic,
			mtl_category_sets_b mcs,
			mtl_category_sets_tl mcs_tl
	     where	mic.category_set_id         = mcs.category_set_id
	     and	3=3  
	     and	mic.inventory_item_id       = msiv.inventory_item_id
	     and	mic.organization_id         = msiv.organization_id
	     and	mc.category_id              = mic.category_id
	     and	mcs.category_set_id         = mcs_tl.category_set_id
	     and	mcs_tl.language             = userenv('lang')
	   ),'') "&p_category_set2",
	-- End revision for version 1.4
	fl1.meaning Allow_Costs,
	ml2.meaning Inv_Asset,
	ml3.meaning Based_on_Rollup,
	cic.shrinkage_rate Shrinkage_Rate,
	gl.currency_code Curr_Code,
	nvl(cic.material_cost,0) Material_Cost,
	nvl(cic.material_overhead_cost,0) Material_Overhead_Cost,
	nvl(cic.resource_cost,0) Resource_Cost,
	nvl(cic.outside_processing_cost,0) Outside_Processing_Cost,
	nvl(cic.overhead_cost,0) Overhead_Cost,
        nvl(cic.item_cost,0) Item_Cost,
	-- Fix for version 1.3
	&segment_columns
	-- End fix for version 1.3
	cic.creation_date Cost_Creation_Date,
	cic.last_update_date Last_Cost_Update_Date
from	cst_item_costs cic,
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
where	mp.organization_id              = msiv.organization_id
and	msiv.inventory_item_id          = cic.inventory_item_id
and	msiv.organization_id            = cic.organization_id
-- Revision for version 1.7
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.7
and	cic.cost_type_id                = cct.cost_type_id
and	1=1                          -- p_item_number, p_org_code, p_operating_unit, p_ledger
and	4=4                          -- p_cost_type
-- ===================================================================
-- Don't report the unused inventory organizations
-- ===================================================================
and	mp.organization_id             <> mp.master_organization_id    -- remove the global master org
-- ===================================================================
-- Lookup codes
-- ===================================================================
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                 = msiv.planning_make_buy_code
and	ml2.lookup_type                 = 'SYS_YES_NO'
and	ml2.lookup_code                 = to_char(cic.inventory_asset_flag)
and	ml3.lookup_type                 = 'CST_BONROLLUP_VAL'
and	ml3.lookup_code                 = cic.based_on_rollup_flag
and	fl1.lookup_type                 = 'YES_NO'
and	fl1.lookup_code                 = msiv.costing_enabled_flag
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- ===================================================================
-- Fix for version 1.3
-- joins to get the COGS and revenue accounts
-- ===================================================================
and	gcc1.code_combination_id (+)    = msiv.cost_of_sales_account
and	gcc2.code_combination_id (+)    = msiv.sales_account
-- End fix for version 1.3
union all
-- ===================================================================
-- Now get the items which are not costing enabled 
-- ===================================================================
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	null Cost_Type,
	msiv.concatenated_segments Item_Number,
	msiv.description Description,
	-- Revision for version 1.7
	muomv.uom_code UOM_Code,
	fcl.meaning Item_Type,
	-- Revision for version 1.7
	misv.inventory_item_status_code Item_Status,
	ml1.meaning Make_Buy_Code,
	-- Revision for version 1.4
	nvl((select	max(mc.segment1)
	     from	mtl_categories_v mc,
			mtl_item_categories mic,
			mtl_category_sets_b mcs,
			mtl_category_sets_tl mcs_tl
	     where	mic.category_set_id         = mcs.category_set_id
	     and	2=2  
	     and	mic.inventory_item_id       = msiv.inventory_item_id
	     and	mic.organization_id         = msiv.organization_id
	     and	mc.category_id              = mic.category_id
	     and	mcs.category_set_id         = mcs_tl.category_set_id
	     and	mcs_tl.language             = userenv('lang')
	   ),'') "&p_category_set1",
	nvl((select	max(mc.segment1)
	     from	mtl_categories_v mc,
			mtl_item_categories mic,
			mtl_category_sets_b mcs,
			mtl_category_sets_tl mcs_tl
	     where	mic.category_set_id         = mcs.category_set_id
	     and	3=3 
	     and	mic.inventory_item_id       = msiv.inventory_item_id
	     and	mic.organization_id         = msiv.organization_id
	     and	mc.category_id              = mic.category_id
	     and	mcs.category_set_id         = mcs_tl.category_set_id
	     and	mcs_tl.language             = userenv('lang')
	   ),'') "&p_category_set2",
	-- End revision for version 1.4
	fl1.meaning Allow_Costs,
	fl2.meaning Inv_Asset,
	'N/A' Based_on_Rollup,
	null Shrinkage_Rate,
	gl.currency_code Curr_Code,
	null Material_Cost,
	null Material_Overhead_CostCost,
	null Resource_Cost,
	null Outside_Processing_Cost,
	null Overhead_Cost,
        null Item_Cost,
	-- Fix for version 1.3
	&segment_columns
	null Cost_Creation_Date,
	null Last_Cost_Update_Date
from	mtl_system_items_vl msiv,
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
where	mp.organization_id              = msiv.organization_id
-- Revision for version 1.7
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.7
and	1=1                          -- p_item_number, p_org_code, p_operating_unit, p_ledger
-- Include or exclude uncosted items
and	5=5
-- ===================================================================
-- Find items where the item has no cost information
-- ===================================================================
and	msiv.costing_enabled_flag       = 'N'
-- ===================================================================
-- Don't report the unused inventory organizations
and	mp.organization_id              <> mp.master_organization_id    -- remove the global master org
-- ===================================================================
-- Lookup codes
-- ===================================================================
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                 = msiv.planning_make_buy_code
and	fl1.lookup_type                 = 'YES_NO'
and	fl1.lookup_code                 = msiv.costing_enabled_flag
and	fl2.lookup_type                 = 'YES_NO'
and	fl2.lookup_code                 = msiv.inventory_asset_flag
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- ===================================================================
-- Fix for version 1.3
-- joins to get the COGS and revenue accounts
-- ===================================================================
and	gcc1.code_combination_id (+)    = msiv.cost_of_sales_account
and	gcc2.code_combination_id (+)    = msiv.sales_account
-- order by Ledger, Operating_Unit, Org_Code, Item and Cost_Type
order by 1,2,3,4,5