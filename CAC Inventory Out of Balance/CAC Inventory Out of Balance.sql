/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory Out-of-Balance
-- Description: Shows any differences in the period end snapshot that is created when you close the inventory periods.  This represents any differences between the cumulative inventory accounting entries and the onhand valuation of the subinventories and intransit stock locations.

/* +=============================================================================+
-- |  Copyright 2006-2020 Douglas Volz Consulting, Inc.                          |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_inv_snapshot_diff_rept.sql
-- |
-- |  Parameters:
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_period_name      -- the accounting period to report, mandatory
-- |  p_min_value_diff   -- minimum difference to add up by org  by period,
-- |                        this is set to default to a value of 1 if nothing is entered
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |
-- |  Description:
-- |  Report to show any differences in the period end snapshot that is created
-- |  when you close the inventory periods.  This represents any differences
-- |  between the cumulative inventory accounting entries and the onhand
-- |  valuation of the subinventories and intransit stock locations.
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     02 APR 2006 Douglas Volz   Initial Coding
-- |  1.14    19 Nov 2015 Douglas Volz   Commented out the Cost Group information.  Not Consistent.
-- |  1.15    17 Jul 2018 Douglas Volz   Now report G/L short name.
-- |  1.16    06 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters.
-- |  1.17    30 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, inventory orgs and operating units.
-- |  1.18    18 May 2020 Douglas Volz   Added language for item status.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-inventory-out-of-balance/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-out-of-balance/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
-- ==============================================
-- This first select gets the subinventory values
-- ==============================================
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	-- Revision for version 1.14
--	(select ccg.cost_group
--	 from   cst_cost_groups ccg
--	 where  ccg.cost_group_id  = cpcs.cost_group_id) Cost_Group,
	-- End revision for version 1.14
	oap.period_name Period_Name,
	&segment_columns
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.12
	fcl.meaning Item_Type,
	-- Revision for version 1.18
	misv.inventory_item_status_code_tl Item_Status,
	nvl((select	max(mc.segment1)
	     from	mtl_categories_b mc,
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
	     from	mtl_categories_b mc,
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
	-- Revision for version 1.18
	nvl(cpcs.subinventory_code, ml.meaning) Subinventory_or_Intransit,
	muomv.uom_code UOM_Code,
	round(sum(nvl(cpcs.rollback_quantity, 0)),3) Quantity,
	round(sum(nvl(cpcs.rollback_value, 0)),2) Onhand_Value,
	round(sum(nvl(cpcs.accounted_value, 0)),2) Accounted_Value,
	round(sum((nvl(cpcs.onhand_value_discrepancy, 0))
		+ (nvl(cpcs.intransit_value_discrepancy, 0))),2) Difference
	-- End revision for version 1.18
from	cst_period_close_summary cpcs,
	org_acct_periods oap,
	mtl_parameters mp,
	mtl_system_items_vl msiv,
	-- Revision for version 1.18
	mtl_item_status_vl misv,
	mtl_units_of_measure_vl muomv,
	mfg_lookups ml,
	-- End revision for version 1.18
	-- Revision for version 1.13
	-- Get valuation accounts based on Costing Method and Cost Group Accounting
	(-- Standard Costing, no Cost Group Accounting
	 select msub.organization_id,
		msub.secondary_inventory_name,
		msub.material_account
	 from	mtl_secondary_inventories msub,
		mtl_parameters mp
	 where	msub.organization_id            = mp.organization_id
	 and	nvl(mp.cost_group_accounting,2) = 2 -- No
	 and	mp.primary_cost_method          = 1 -- Standard Costing
	 union all
	 -- Not Standard Costing, no Cost Group Accounting
	 select msub.organization_id,
		msub.secondary_inventory_name,
		mp.material_account
	 from	mtl_secondary_inventories msub,
		mtl_parameters mp
	 where	msub.organization_id            = mp.organization_id
	 and	nvl(mp.cost_group_accounting,2) = 2 -- No
	 and	mp.primary_cost_method <> 1 -- not Standard Average Costing
	 union all
	 -- With Cost Group Accounting
	 select	msub.organization_id,
		msub.secondary_inventory_name,
		ccga.material_account
	 from	mtl_secondary_inventories msub,
		cst_cost_group_accounts ccga,
		mtl_parameters mp
	 where	msub.organization_id            = mp.organization_id
	 and	mp.cost_group_accounting        = 1 -- Yes
	 and	ccga.cost_group_id              = msub.default_cost_group_id
	 union all
	 -- Cost Group Accounting but the Subinventory Cost Group Id is null
	 select	msub.organization_id,
		msub.secondary_inventory_name,
		ccga.material_account
	 from	mtl_secondary_inventories msub,
		cst_cost_group_accounts ccga,
		mtl_parameters mp
	 where	msub.organization_id = mp.organization_id
	 and	mp.cost_group_accounting        = 1 -- Yes
	 and	msub.default_cost_group_id is null
	 and	ccga.cost_group_id              = mp.default_cost_group_id
	) msub,
	gl_code_combinations gcc,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl,
	-- Revsion for version 1.12
	fnd_common_lookups fcl
where	oap.acct_period_id              = cpcs.acct_period_id
and	oap.organization_id             = mp.organization_id
and	cpcs.subinventory_code          = msub.secondary_inventory_name
and	cpcs.organization_id            = msub.organization_id
and	mp.organization_id              = cpcs.organization_id
and	msiv.organization_id            = cpcs.organization_id
and	msiv.inventory_item_id          = cpcs.inventory_item_id
-- Revision for version 1.18
and	misv.inventory_item_status_code = msiv.inventory_item_status_code
and	msiv.primary_uom_code           = muomv.uom_code
and	ml.lookup_type                  = 'CST_ACCOUNTING_LINE_TYPE'
and	ml.lookup_code                  = 14 -- Intransit Inventory
and	msub.material_account           = gcc.code_combination_id (+)
-- End revision for version 1.18
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                             -- p_period_name, p_item_number, p_org_code, p_operating_unit, p_ledger
-- ===================================================================
-- Lookup Values, added for revision 1.12
-- ===================================================================
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
group by
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	-- Revision for version 1.14
--	cpcs.cost_group_id,
	oap.period_name,
	&segment_columns2
	msiv.concatenated_segments,
	msiv.description,
	-- Revision for version 1.12
	fcl.meaning,
	-- Revision for version 1.18
	misv.inventory_item_status_code_tl,
	nvl(cpcs.subinventory_code, ml.meaning),
	muomv.uom_code,
	-- End revision for version 1.18
	-- Needed for inline select
	msiv.inventory_item_id,
	msiv.organization_id
having abs(sum(nvl(cpcs.onhand_value_discrepancy, 0) +
	       nvl(cpcs.intransit_value_discrepancy, 0))) >= :p_min_value_diff	-- p_min_value_diff
-- ==============================================
-- This second select gets the intransit values
-- ==============================================
union all
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	-- Revision for version 1.14
--	(select ccg.cost_group
--	 from   cst_cost_groups ccg
--	 where  ccg.cost_group_id  = cpcs.cost_group_id) Cost_Group,
	-- End revision for version 1.14
	oap.period_name Period_Name,
	&segment_columns
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.12
	fcl.meaning Item_Type,
	-- Revision for version 1.18
	misv.inventory_item_status_code_tl Item_Status,
	nvl((select	max(mc.segment1)
	     from	mtl_categories_b mc,
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
	     from	mtl_categories_b mc,
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
	-- End revision for version 1.12
	-- Revision for version 1.18
	nvl(cpcs.subinventory_code, ml.meaning) Subinventory_or_Intransit,
	muomv.uom_code UOM_Code,
	round(sum(nvl(cpcs.rollback_quantity, 0)),3) Quantity,
	round(sum(nvl(cpcs.rollback_value, 0)),2) Onhand_Value,
	round(sum(nvl(cpcs.accounted_value, 0)),2) Accounted_Value,
	round(sum((nvl(cpcs.onhand_value_discrepancy, 0)) +
	    (nvl(cpcs.intransit_value_discrepancy, 0))),2) Difference
	-- End revision for version 1.18
from	cst_period_close_summary cpcs,
	org_acct_periods oap,
	mtl_parameters mp,
	mtl_system_items_vl msiv,
	-- Revision for version 1.18
	mtl_item_status_vl misv,
	mtl_units_of_measure_vl muomv,
	mfg_lookups ml,
	-- End revision for version 1.18
	-- Fix for version 1.11
	-- mtl_interorg_parameters mip,
	gl_code_combinations gcc,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2,  -- operating unit
	gl_ledgers gl,
	-- Revsion for version 1.12
	fnd_common_lookups fcl
where	oap.acct_period_id              = cpcs.acct_period_id
and	oap.organization_id             = mp.organization_id
-- Fix for version 1.11
-- and mp.organization_id               = mip.to_organization_id
-- End fix for version 1.11
and	cpcs.subinventory_code is null
and	mp.organization_id              = cpcs.organization_id
and	msiv.organization_id            = cpcs.organization_id
and	msiv.inventory_item_id          = cpcs.inventory_item_id
-- Revision for version 1.18
and	misv.inventory_item_status_code = msiv.inventory_item_status_code
and	msiv.primary_uom_code           = muomv.uom_code
and	ml.lookup_type                  = 'CST_ACCOUNTING_LINE_TYPE'
and	ml.lookup_code                  = 14 -- Intransit Inventory
-- End revision for version 1.18
-- Fix for version 1.11
-- and	mip.intransit_inv_account       = gcc.code_combination_id
and	mp.intransit_inv_account        = gcc.code_combination_id (+)
-- ===================================================================
-- using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                             -- p_period_name, p_item_number, p_org_code, p_operating_unit, p_ledger
-- ===================================================================
-- Lookup Values, added for revision 1.12
-- ===================================================================
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
group by
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	-- Revision for version 1.14
--	cpcs.cost_group_id,
	oap.period_name,
	&segment_columns2
	msiv.concatenated_segments,
	msiv.description,
	-- Revision for version 1.12
	fcl.meaning,
	misv.inventory_item_status_code_tl,
	-- End for version 1.12
	-- Revision for version 1.18
	nvl(cpcs.subinventory_code, ml.meaning),
	muomv.uom_code,
	-- End revision for version 1.18
	-- Needed for inline select
	msiv.inventory_item_id,
	msiv.organization_id
having abs(sum(nvl(cpcs.onhand_value_discrepancy, 0) +
	       nvl(cpcs.intransit_value_discrepancy, 0))) >= :p_min_value_diff	-- p_min_value_diff
-- Order by Ledger, Operating_Unit, Accounts, Item and Subinventory
order by 1,2,5,6,7,8,9,10,11,12,15