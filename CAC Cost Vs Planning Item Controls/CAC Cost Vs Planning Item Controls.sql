/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Cost Vs. Planning Item Controls
-- Description: Detail report to compare item make/buy controls vs. costing based on rollup controls. 
There are five included reports:
1.	Based on Rollup Yes - No BOMS - Find make or buy items where the item is set to be rolled up but there are no BOMs, routings or sourcing rules. May roll up to a zero cost.
2.	Based On Rollup Yes - No Rollup - Find items where it is set to be rolled up but there are no rolled up costs
3.	Based on Rollup No - with BOMS - Find make or buy items where the item is not set to be rolled up but BOMS, routings or sourcing rules exist.
4.	4. User Defined Costs - Make Items - For make items, where the planning_make_buy_code is Make, find records where the detailed item costs are user-defined (rollup source type is user-defined) instead of rolled-up or based on the cost rollup. May indicate a doubling up of your item costs.
5.	Based on Rollup Yes - No Routing - Find items where the planning_make_buy_code is "Buy" or "Make", costs are based on the cost rollup, BOMs exist but routings do not.

-- Excel Examle Output: https://www.enginatics.com/example/cac-cost-vs-planning-item-controls/
-- Library Link: https://www.enginatics.com/reports/cac-cost-vs-planning-item-controls/
-- Run Report: https://demo.enginatics.com/

select	'Based on Rollup Yes - No BOMS' Report_Type,
-- ===================================================================
-- Report Worksheet 1 - Based on Rollup Yes - No BOMS
-- For buy parts, where the planning_make_buy_code is "BUY" or "Make", find records where
-- costs are based upon the cost rollup, but BOMS and/or routings do not exist, and
-- sourcing rules do not exist for the "receipt org" - where the item is rolled up.
-- ===================================================================
	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	cct.cost_type Cost_Type,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.28
	muomv.uom_code UOM_Code,
	-- Revision for version 1.20
	fcl.meaning Item_Type,
	misv.inventory_item_status_code_tl Item_Status,
	ml1.meaning Make_Buy_Code,
	'' Rollup_Source_Type,
	'' Resource_Code,
	fl.meaning BOM,     -- No
	fl.meaning Routing, -- No
	-- check to see if a sourcing rule exists for the receipt org
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
	 nvl((select	distinct 'Y'
	      from	mrp_sr_receipt_org msro,
			mrp_sr_source_org msso,
			mrp_sourcing_rules msr,
			mrp_sr_assignments msa,
			mrp_assignment_sets mas
	      where	msr.sourcing_rule_id   = msro.sourcing_rule_id
			-- fix for version 1.4, check to see if the sourcing rule is
			-- for an inventory org, not a vendor
	      and	msso.sr_receipt_id     = msro.sr_receipt_id
	      and 	msso.source_organization_id is not null
	      and 	msa.sourcing_rule_id   = msr.sourcing_rule_id
	      and 	msa.assignment_set_id  = mas.assignment_set_id
	      and 	msiv.organization_id   = msa.organization_id
	      and 	msiv.inventory_item_id = msa.inventory_item_id
	      and 	mp.organization_id     = msa.organization_id
	      and	1=1),'N')
	) Sourcing_Rule,							-- p_assignment_set
	ml2.meaning Based_on_Rollup,
	ml3.meaning Inv_Asset,
	gl.currency_code Curr_Code,
	cic.item_cost Item_Cost,
	msiv.creation_date Item_Creation_Date
from	mtl_parameters mp,
	mtl_system_items_vl msiv,
	-- Revision for version 1.28
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv, 
	cst_item_costs cic,
	cst_cost_types cct,
	mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
	mfg_lookups ml2, -- based on rollup, CST_BONROLLUP_VAL
	mfg_lookups ml3, -- inventory_asset_flag, SYS_YES_NO
	fnd_lookups fl,  -- BOM, Routing, YES_NO, No
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,	-- inv_organization_id
	hr_all_organization_units_vl haou2,	-- operating unit
	gl_ledgers gl
-- ===================================================================
-- Cost type, organization, item master and report specific controls
-- ===================================================================
where	cic.cost_type_id                = cct.cost_type_id
and	2=2
and	mp.organization_id              = cic.organization_id
and	msiv.organization_id            = cic.organization_id
and	msiv.inventory_item_id          = cic.inventory_item_id
-- Revision for version 1.28
and	msiv.primary_uom_code           = muomv.uom_code
and	misv.inventory_item_status_code = msiv.inventory_item_status_code
and	cic.based_on_rollup_flag        = 1   -- rolled up
and	msiv.planning_make_buy_code IN (1, 2) -- buy and make
-- Revision for version 1.24
and	msiv.inventory_item_status_code <> 'Inactive'
-- Fix for version 1.15
and	mp.organization_id <> mp.master_organization_id -- the item master org usually does not have costs
-- ===================================================================
-- Joins for the lookup codes
-- ===================================================================
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                 = msiv.planning_make_buy_code
and	ml2.lookup_type                 = 'CST_BONROLLUP_VAL'
and	ml2.lookup_code                 = cic.based_on_rollup_flag
and	ml3.lookup_type                 = 'SYS_YES_NO'
and	ml3.lookup_code                 = to_char(cic.inventory_asset_flag)
and	fl.lookup_type                  = 'YES_NO'
and	fl.lookup_code                  = 'N'
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- HR Organization table joins
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	hoi.org_information1            = gl.ledger_id      -- this gets the ledger id
-- ===================================================================
-- Check to see if BOMS or Routings or Sourcing_Rules exist
-- ===================================================================
and not exists
	-- check to see if a BOM exists
	((select 'x'
	  from	bom_structures_b bom
	  where	bom.organization_id     = cic.organization_id
	  and	bom.assembly_item_id    = cic.inventory_item_id
	  and	bom.alternate_bom_designator is null)
	  union all
	  -- check to see if a routing exists
	 (select 'x'
	  from bom_operational_routings bor
	  where     bor.organization_id = cic.organization_id
	  and bor.assembly_item_id      = cic.inventory_item_id
	  and bor.alternate_routing_designator is null)
	  union all
	 (select 'x'
	  from	mrp_sr_receipt_org msro,
		mrp_sr_source_org msso,
		mrp_sourcing_rules msr,
		mrp_sr_assignments msa,
		mrp_assignment_sets mas
	  where	msr.sourcing_rule_id = msro.sourcing_rule_id
	  -- fix for version 1.4, check to see if the sourcing rule is
	  -- for an inventory org, not a vendor
	  and	msso.sr_receipt_id      = msro.sr_receipt_id
	  and	msso.source_organization_id is not null
	  and	msa.sourcing_rule_id    = msr.sourcing_rule_id
	  and	msa.assignment_set_id   = mas.assignment_set_id
	  and	msiv.organization_id    = msa.organization_id
	  and	msiv.inventory_item_id  = msa.inventory_item_id
	  and 1=1
	 )
	)
union all
-- ===================================================================
-- Report Worksheet 2 - Based on Rollup Yes - No Rollup
-- This select statement checks that the summary and detail cost tables
-- have equivalent settings for rolling up make items.
-- For those summary costs that have a setting of costs based on the cost rollup,
-- this script checks the cost details table to see if any of the costs by sub-elements
-- are also based on the cost rollup.  If none are found these items are reported.
-- ===================================================================
select	'Based on Rollup Yes - No Rollup' Report_Type,
	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	cct.cost_type Cost_Type,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.28
	muomv.uom_code UOM_Code,
	fcl.meaning Item_Type,
	misv.inventory_item_status_code_tl Item_Status,
	ml1.meaning Make_Buy_Code,
	'' Rollup_Source_Type,
	'' Resource_Code,
	-- check to see if a bom exists
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
		nvl((select	distinct 'Y'
		     from	bom_structures_b bom
		     where	bom.organization_id      = mp.organization_id
		     and	bom.assembly_item_id     = cic.inventory_item_id
		     and	bom.alternate_bom_designator is null),
		'N')
	) BOM,
	-- check to see if a routing exists
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
		nvl((select	distinct 'Y'
		     from	bom_operational_routings bor
		     where	bor.organization_id      = mp.organization_id
		     and	bor.assembly_item_id     = cic.inventory_item_id
		     and	bor.alternate_routing_designator is null),
		'N')
	) Routing,
	-- check to see if a sourcing rule exists for the receipt org
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
		nvl((select	distinct 'Y'
		     from	mrp_sr_receipt_org msro,
				mrp_sr_source_org msso,
				mrp_sourcing_rules msr,
				mrp_sr_assignments msa,
				mrp_assignment_sets mas
		     where	msr.sourcing_rule_id    = msro.sourcing_rule_id
		     -- fix for version 1.4, check to see if the sourcing rule is
		     -- for an inventory org, not a vendor
		     and	msso.sr_receipt_id      = msro.sr_receipt_id
		     and	msso.source_organization_id is not null
		     and	msa.sourcing_rule_id    = msr.sourcing_rule_id
		     and	msa.assignment_set_id   = mas.assignment_set_id
		     and	msiv.organization_id    = msa.organization_id
		     and	msiv.inventory_item_id  = msa.inventory_item_id
		     and	mp.organization_id      = msa.organization_id
		     and	1=1
		   ), 'N')
	) Sourcing_Rule,
	ml2.meaning Based_on_Rollup,
	ml3.meaning Inv_Asset,
	gl.currency_code Curr_Code,
	cic.item_cost Item_Cost,
	msiv.creation_date Item_Creation_Date
from	mtl_parameters mp,
	mtl_system_items_vl msiv,
	-- Revision for version 1.28
	mtl_item_status_vl misv, 
	mtl_units_of_measure_vl muomv,
	cst_item_costs cic,
	cst_cost_types cct,
	mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
	mfg_lookups ml2, -- based on rollup, CST_BONROLLUP_VAL
	mfg_lookups ml3, -- inventory_asset_flag, SYS_YES_NO
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl
 -- ===================================================================
 -- Cost type, organization, item master and report specific controls
 -- ===================================================================
where	cic.cost_type_id                = cct.cost_type_id
and	2=2
and	mp.organization_id              = cic.organization_id
and	msiv.organization_id            = cic.organization_id
and	msiv.inventory_item_id          = cic.inventory_item_id
-- Revision for version 1.28
and	msiv.primary_uom_code           = muomv.uom_code
and	misv.inventory_item_status_code = msiv.inventory_item_status_code
and	cic.based_on_rollup_flag        = 1 -- costs based on cost rollup
-- Revision for version 1.24
and	msiv.inventory_item_status_code <> 'Inactive'
-- Fix for version 1.15
and	mp.organization_id <> mp.master_organization_id -- the item master org usually does not have costs
-- ===================================================================
-- Joins for the lookup codes
-- ===================================================================
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                 = msiv.planning_make_buy_code
and	ml2.lookup_type                 = 'CST_BONROLLUP_VAL'
and	ml2.lookup_code                 = cic.based_on_rollup_flag
and	ml3.lookup_type                 = 'SYS_YES_NO'
and	ml3.lookup_code                 = to_char(cic.inventory_asset_flag)
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- HR Organization table joins
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	hoi.org_information1            = gl.ledger_id -- this gets the ledger id
-- ===================================================================
-- Check to see if the rolled up cost details are missing
-- ===================================================================
and not exists
	(select	'x'
	 from	cst_item_cost_details cicd
	 where	cicd.organization_id    = cic.organization_id
	 and	cicd.inventory_item_id  = cic.inventory_item_id
	 -- fix for version 1.5
	 and	cicd.cost_type_id       = cic.cost_type_id
	 and	cicd.rollup_source_type = 3) -- rolled up
union all
-- ===================================================================
-- Report Worksheet 3 - Based on Rollup No - with BOMS
-- For buy parts, where the planning_make_buy_code is BUY, find records where
-- costs are not based upon the cost rollup, but, BOMS and/or routings do exist, or
-- sourcing rules do exist for the receipt org - where the item is rolled up.
-- ===================================================================
select 'Based on Rollup No - with BOMS' Report_Type,
	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	cct.cost_type Cost_Type,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.28
	muomv.uom_code UOM_Code,
	fcl.meaning Item_Type,
	misv.inventory_item_status_code_tl Item_Status,
	ml1.meaning Make_Buy_Code,
	'' Rollup_Source_Type,
	'' Resource_Code,
	-- check to see if a bom exists
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
		nvl((select	distinct 'Y'
		     from	bom_structures_b bom
		     where	bom.organization_id      = mp.organization_id
		     and	bom.assembly_item_id     = cic.inventory_item_id
		     and	bom.alternate_bom_designator is null),
		'N')
	) BOM,
	-- check to see if a routing exists
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
		nvl((select	distinct 'Y'
		     from	bom_operational_routings bor
		     where	bor.organization_id      = mp.organization_id
		     and	bor.assembly_item_id     = cic.inventory_item_id
		     and	bor.alternate_routing_designator is null),
		'N')
	) Routing,
	-- check to see if a sourcing rule exists for the receipt org
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
		nvl((select	distinct 'Y'
		     from	mrp_sr_receipt_org msro,
				mrp_sr_source_org msso,
				mrp_sourcing_rules msr,
				mrp_sr_assignments msa,
				mrp_assignment_sets mas
		     where	msr.sourcing_rule_id    = msro.sourcing_rule_id
		     -- fix for version 1.4, check to see if the sourcing rule is
		     -- for an inventory org, not a vendor
		     and	msso.sr_receipt_id      = msro.sr_receipt_id
		     and	msso.source_organization_id is not null
		     and	msa.sourcing_rule_id    = msr.sourcing_rule_id
		     and	msa.assignment_set_id   = mas.assignment_set_id
		     and	msiv.organization_id    = msa.organization_id
		     and	msiv.inventory_item_id  = msa.inventory_item_id
		     and	mp.organization_id      = msa.organization_id
		     and	1=1
		   ), 'N')
	) Sourcing_Rule,
	ml2.meaning Based_on_Rollup,
	ml3.meaning Inv_Asset,
	gl.currency_code Curr_Code,
	cic.item_cost Item_Cost,
	msiv.creation_date Item_Creation_Date
from	mtl_parameters mp,
	mtl_system_items_vl msiv,
	-- Revision for version 1.28
	mtl_item_status_vl misv, 
	mtl_units_of_measure_vl muomv,
	cst_item_costs cic,
	cst_cost_types cct,
	mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
	mfg_lookups ml2, -- based on rollup, CST_BONROLLUP_VAL
	mfg_lookups ml3, -- inventory_asset_flag, SYS_YES_NO
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl
-- ===================================================================
-- Cost type, organization, item master and report specific controls
-- ===================================================================
where	cic.cost_type_id                = cct.cost_type_id
and	2=2
and	mp.organization_id              = cic.organization_id
and	msiv.organization_id            = cic.organization_id
and	msiv.inventory_item_id          = cic.inventory_item_id
-- Revision for version 1.28
and	msiv.primary_uom_code           = muomv.uom_code
and	misv.inventory_item_status_code = msiv.inventory_item_status_code
and	cic.based_on_rollup_flag        = 2   -- not rolled up
and	msiv.planning_make_buy_code IN (1, 2) -- buy or make
-- Revision for version 1.24
and	msiv.inventory_item_status_code <> 'Inactive'
-- Fix for version 1.15
and	mp.organization_id <> mp.master_organization_id -- the item master org usually does not have costs
-- ===================================================================
-- Joins for the lookup codes
-- ===================================================================
and	ml1.lookup_type                = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                = msiv.planning_make_buy_code
and	ml2.lookup_type                = 'CST_BONROLLUP_VAL'
and	ml2.lookup_code                = cic.based_on_rollup_flag
and	ml3.lookup_type                = 'SYS_YES_NO'
and	ml3.lookup_code                = to_char(cic.inventory_asset_flag)
and	fcl.lookup_code (+)            = msiv.item_type
and	fcl.lookup_type (+)            = 'ITEM_TYPE'
-- ===================================================================
-- HR Organization table joins
-- ===================================================================
and	hoi.org_information_context    = 'Accounting Information'
and	hoi.organization_id            = mp.organization_id
and	hoi.organization_id            = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and	hoi.org_information1           = gl.ledger_id -- this gets the ledger id
-- ===================================================================
-- Check to see if BOMS or Routings or Sourcing_Rules do exist
-- ===================================================================
and exists
	  -- check to see if a BOM exists
	((select 'x'
	  from	bom_structures_b bom
	  where	bom.organization_id     = cic.organization_id
	  and	bom.assembly_item_id    = cic.inventory_item_id
	  and	bom.alternate_bom_designator is null)
	  union all
	  -- check to see if a routing exists
	 (select 'x'
	  from	bom_operational_routings bor
	  where bor.organization_id     = cic.organization_id
	  and	bor.assembly_item_id    = cic.inventory_item_id)
	  union all
	  -- check to see if a sourcing rule exists for the receipt org
	 (select 'x'
	  from	mrp_sr_receipt_org msro,
		mrp_sr_source_org msso,
		mrp_sourcing_rules msr,
		mrp_sr_assignments msa,
		mrp_assignment_sets mas
	  where	msr.sourcing_rule_id    = msro.sourcing_rule_id
	  -- fix for version 1.4, check to see if the sourcing rule is
	  -- for an inventory org, not a vendor
	  and	msso.sr_receipt_id      = msro.sr_receipt_id
	  and	msso.source_organization_id is not null
	  and	msa.sourcing_rule_id    = msr.sourcing_rule_id
	  and	msa.assignment_set_id   = mas.assignment_set_id
	  and	msiv.organization_id    = msa.organization_id
	  and	msiv.inventory_item_id  = msa.inventory_item_id
	  and	1=1
	 )
	)
union all
-- ===================================================================
-- Report Worksheet 4 - Based on Rollup Yes - No Routing
-- Where the planning_make_buy_code is Buy or Make, find records where
-- costs are based upon the cost rollup, but routings do not exist.
-- ===================================================================
select	'Based on Rollup Yes - No Routing' Report_Type,
	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	cct.cost_type Cost_Type,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.28
	muomv.uom_code UOM_Code,
	-- Revision for version 1.20
	fcl.meaning Item_Type,
	misv.inventory_item_status_code_tl Item_Status,
	ml1.meaning Make_Buy_Code,
	'' Rollup_Source_Type,
	'' Resource_Code,
	-- check to see if a bom exists
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
		nvl((select	distinct 'Y'
		     from	bom_structures_b bom
		     where	bom.organization_id      = mp.organization_id
		     and	bom.assembly_item_id     = cic.inventory_item_id
		     and	bom.alternate_bom_designator is null),
		'N')
	) BOM,
	fl.meaning Routing, -- No
	-- check to see if a sourcing rule exists for the receipt org
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
		nvl((select	distinct 'Y'
		     from	mrp_sr_receipt_org msro,
				mrp_sr_source_org msso,
				mrp_sourcing_rules msr,
				mrp_sr_assignments msa,
				mrp_assignment_sets mas
		     where	msr.sourcing_rule_id    = msro.sourcing_rule_id
		     -- fix for version 1.4, check to see if the sourcing rule is
		     -- for an inventory org, not a vendor
		     and	msso.sr_receipt_id      = msro.sr_receipt_id
		     and	msso.source_organization_id is not null
		     and	msa.sourcing_rule_id    = msr.sourcing_rule_id
		     and	msa.assignment_set_id   = mas.assignment_set_id
		     and	msiv.organization_id    = msa.organization_id
		     and	msiv.inventory_item_id  = msa.inventory_item_id
		     and	mp.organization_id      = msa.organization_id
		     and	1=1
		   ), 'N')
	) Sourcing_Rule,
	ml2.meaning Based_on_Rollup,
	ml3.meaning Inv_Asset,
	gl.currency_code Curr_Code,
	cic.item_cost Item_Cost,
	msiv.creation_date Item_Creation_Date
from	mtl_parameters mp,
	mtl_system_items_vl msiv,
	-- Revision for version 1.28
	mtl_item_status_vl misv, 
	mtl_units_of_measure_vl muomv,
	cst_item_costs cic,
	cst_cost_types cct,
	mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
	mfg_lookups ml2, -- based on rollup, CST_BONROLLUP_VAL
	mfg_lookups ml3, -- inventory_asset_flag, SYS_YES_NO
	fnd_lookups fl,  -- Routing, YES_NO, No
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl
-- ===================================================================
-- Cost type, organization, item master and report specific controls
-- ===================================================================
where	cic.cost_type_id                = cct.cost_type_id
and	2=2
and	mp.organization_id              = cic.organization_id
and	msiv.organization_id            = cic.organization_id
and	msiv.inventory_item_id          = cic.inventory_item_id
-- Revision for version 1.28
and	msiv.primary_uom_code           = muomv.uom_code
and	misv.inventory_item_status_code = msiv.inventory_item_status_code
and	cic.based_on_rollup_flag        = 1   -- rolled up
and	msiv.planning_make_buy_code IN (1, 2) -- buy and make
-- Revision for version 1.24
and	msiv.inventory_item_status_code <> 'Inactive'
-- Fix for version 1.15
and	mp.organization_id <> mp.master_organization_id -- the item master org usually does not have costs
-- ===================================================================
-- Joins for the lookup codes
-- ===================================================================
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                 = msiv.planning_make_buy_code
and	ml2.lookup_type                 = 'CST_BONROLLUP_VAL'
and	ml2.lookup_code                 = cic.based_on_rollup_flag
and	ml3.lookup_type                 = 'SYS_YES_NO'
and	ml3.lookup_code                 = to_char(cic.inventory_asset_flag)
and	fl.lookup_type                  = 'YES_NO'
and	fl.lookup_code                  = 'N'
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- HR Organization table joins
-- ===================================================================
and	hoi.org_information_context    = 'Accounting Information'
and	hoi.organization_id            = mp.organization_id
and	hoi.organization_id            = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	haou2.organization_id          = to_number(hoi.org_information3) -- this gets the operating unit id
and	hoi.org_information1           = gl.ledger_id -- this gets the ledger id
-- ===================================================================
-- Check to see if BOMS or Routings or Sourcing_Rules exist
-- ===================================================================
and not exists
	-- check to see if a routing exists
	(select 'x'
	 from	bom_operational_routings bor
	 where	bor.organization_id  = cic.organization_id
	 and 	bor.assembly_item_id = cic.inventory_item_id
	 and	bor.alternate_routing_designator is null)
-- ===================================================================
-- Order by Report_Type, G/L Short Name, Organization Code, Item_Number
-- and Rollup Source Type
-- ===================================================================
union all
-- ===================================================================
-- Report Worksheet 5 - User Defined Costs - Make Items
-- For make items, for the assemblies, where the planning_make_buy_code is Make,
-- find records where the rollup source type is wrong, where the rollup source
-- type is user defined, as opposed to based on the cost rollup
-- ===================================================================

select	'User Defined Costs - Make Items' Report_Type,
	-- Fix for version 1.12, changed from gl.short_name to gl.short_name
	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	cct.cost_type Cost_Type,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.28
	muomv.uom_code UOM_Code,
	fcl.meaning Item_Type,
	msiv.inventory_item_status_code Item_Status,
	ml1.meaning Make_Buy_Code,
	ml4.meaning Rollup_Source_Type,
	nvl(br.resource_code, '') Resource_Code,
	-- check to see if a bom exists
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
		nvl((select	distinct 'Y'
		     from	bom_structures_b bom
		     where	bom.organization_id      = mp.organization_id
		     and	bom.assembly_item_id     = cic.inventory_item_id
		     and	bom.alternate_bom_designator is null),
		'N')
	) BOM,
	-- check to see if a routing exists
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
		nvl((select	distinct 'Y'
		     from	bom_operational_routings bor
		     where	bor.organization_id      = mp.organization_id
		     and	bor.assembly_item_id     = cic.inventory_item_id
		     and	bor.alternate_routing_designator is null),
		'N')
	) Routing,
	-- check to see if a sourcing rule exists for the receipt org
	(select	fl.meaning
	 from	fnd_lookups fl
	 where	fl.lookup_type = 'YES_NO'
	 and	fl.lookup_code =  
		nvl((select	distinct 'Y'
		     from	mrp_sr_receipt_org msro,
				mrp_sr_source_org msso,
				mrp_sourcing_rules msr,
				mrp_sr_assignments msa,
				mrp_assignment_sets mas
		     where	msr.sourcing_rule_id    = msro.sourcing_rule_id
		     -- fix for version 1.4, check to see if the sourcing rule is
		     -- for an inventory org, not a vendor
		     and	msso.sr_receipt_id      = msro.sr_receipt_id
		     and	msso.source_organization_id is not null
		     and	msa.sourcing_rule_id    = msr.sourcing_rule_id
		     and	msa.assignment_set_id   = mas.assignment_set_id
		     and	msiv.organization_id    = msa.organization_id
		     and	msiv.inventory_item_id  = msa.inventory_item_id
		     and	mp.organization_id      = msa.organization_id
		     and	1=1
		   ), 'N')
	) Sourcing_Rule,
	ml2.meaning Based_on_Rollup,
	ml3.meaning Inv_Asset,
	gl.currency_code Curr_Code,
	sum(cicd.item_cost) Item_Cost,
	msiv.creation_date Item_Creation_Date
from	mtl_parameters mp,
	mtl_system_items_vl msiv,
	-- Revision for version 1.28
	mtl_item_status_vl misv, 
	mtl_units_of_measure_vl muomv,
	cst_item_costs cic,
	cst_item_cost_details cicd,
	bom_resources br,
	cst_cost_types cct,
	mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
	mfg_lookups ml2, -- based on rollup, CST_BONROLLUP_VAL
	mfg_lookups ml3, -- inventory_asset_flag, SYS_YES_NO
	mfg_lookups ml4, -- rollup source type, CST_SOURCE_TYPE
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl
-- ===================================================================
-- Cost type, organization, item master and report specific controls
-- ===================================================================
where	cicd.cost_type_id               = cct.cost_type_id
and	2=2
and	mp.organization_id              = cicd.organization_id
and	msiv.organization_id            = cicd.organization_id
and	msiv.inventory_item_id          = cicd.inventory_item_id
-- Revision for version 1.28
and	msiv.primary_uom_code           = muomv.uom_code
and	misv.inventory_item_status_code = msiv.inventory_item_status_code
and	cic.organization_id             = cicd.organization_id
and	cic.inventory_item_id           = cicd.inventory_item_id
and	cic.cost_type_id                = cicd.cost_type_id
and	cicd.resource_id                = br.resource_id(+)
and	msiv.planning_make_buy_code     = 1 -- make item
and	cicd.rollup_source_type         = 1 -- user defined
-- Revision for version 1.24
and	msiv.inventory_item_status_code <> 'Inactive'
-- Fix for version 1.15
and mp.organization_id <> mp.master_organization_id -- the item master org usually does not have costs
-- ===================================================================
-- Joins for the lookup codes
-- ===================================================================
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                 = msiv.planning_make_buy_code
and	ml2.lookup_type                 = 'CST_BONROLLUP_VAL'
and	ml2.lookup_code                 = cic.based_on_rollup_flag
and	ml3.lookup_type                 = 'SYS_YES_NO'
and	ml3.lookup_code                 = to_char(cic.inventory_asset_flag)
and	ml4.lookup_type                 = 'CST_SOURCE_TYPE'
and	ml4.lookup_code                 = cicd.rollup_source_type
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- HR Organization table joins
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	hoi.org_information1            = gl.ledger_id -- this gets the ledger id
group by
	'User Defined Costs - Make Items',
	-- Fix for version 1.12, changed from gl.short_name to gl.short_name
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	mp.organization_id,
	cct.cost_type,
	msiv.concatenated_segments,
	cic.inventory_item_id,
	-- Added for inline select statement, revision for version 1.22
	msiv.inventory_item_id,
	msiv.organization_id,
	msiv.description,
	muomv.uom_code,
	fcl.meaning,
	msiv.inventory_item_status_code,
	ml1.meaning,
	ml4.meaning,
	nvl(br.resource_code, ''),
	ml2.meaning,
	ml3.meaning,
	gl.currency_code,
	cic.item_cost,
	msiv.creation_date
-- Order by Report Type, Ledger, Operating Unit, Org Code, Item, Rollup Source Type
order by
	1,2,3,4,5,6,12