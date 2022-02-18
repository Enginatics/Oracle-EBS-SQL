/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item vs. Component Include in Rollup Controls
-- Description: Use this report to find items where the item default include in rollup does not match the BOM component include in rollup.  This report includes items which are available for costing, where the inventory costing enabled flag is Yes.  And excludes inactive items.  (This report was removed from the Cost vs. Planning Item Control Report, for performance reasons.)

/* +=============================================================================+
-- |  Copyright 2021 Douglas Volz Consulting, Inc.                               |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_item_include_in_bom_ctrls_repts.sql
-- |
-- |  Parameters:
-- |
-- |  p_cost_type	-- Desired cost type, mandatory
-- |  p_assignment_set	-- The assignment set you wish to report (optional)
-- |  p_item_number	-- Specific item number, to get all values enter a
-- |			   null value or blank value
-- |  p_org_code        -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit  -- Operating_Unit you wish to report, leave blank for all
-- |                       operating units (optional) 
-- |  p_ledger          -- general ledger you wish to report, leave blank for all
-- |                       ledgers (optional)
-- |
-- |  Description:
-- |  Use the below SQL scripts to find items where the item default include in
-- |  rollup does not match the BOM component include in rollup.  (Removed from
-- |  the Cost vs. Planning Item Control Report, for performance reasons.)
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     07 May 2021 Douglas Volz   Initial Coding, based on the Cost vs.
-- |                                     Planning Item Control Report, version 33.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-item-vs-component-include-in-rollup-controls/
-- Library Link: https://www.enginatics.com/reports/cac-item-vs-component-include-in-rollup-controls/
-- Run Report: https://demo.enginatics.com/

select	'Compare Item vs. Component Include in Rollup Controls' Report_Type,
	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	cic.cost_type Cost_Type,
	msiv.concatenated_segments Component_Number,
	msiv.description Component_Description,
	msiv2.concatenated_segments Assembly_Number,
	msiv2.description Assembly_Description,
	muomv.uom_code UOM_Code,
	fcl.meaning Item_Type,
	misv.inventory_item_status_code_tl Item_Status,
	ml1.meaning Make_Buy_Code,
&category_columns
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
	      and	3=3                    -- p_assignment_set
	     ),'N')	-- p_assignment_set
	) Sourcing_Rule,
	ml2.meaning Based_on_Rollup,
	fl1.meaning Costing_Enabled,
	fl2.meaning Item_Inventory_Asset,
	ml3.meaning Cost_Inventory_Asset,
	fl3.meaning Item_Include_in_Rollup,
	ml4.meaning BOM_Include_in_Rollup,
	ml5.meaning WIP_Supply_Type,
	gl.currency_code Currency_Code,
	cic.item_cost Item_Cost,
	msiv.creation_date Item_Creation_Date
from	mtl_parameters mp,
	mtl_system_items_vl msiv,
	mtl_system_items_vl msiv2,
	mtl_item_status_vl misv,
	mtl_units_of_measure_vl muomv,
	(select	cic.organization_id,
		cic.inventory_item_id,
		cic.inventory_asset_flag,
		cic.based_on_rollup_flag,
		cct.cost_type_id,
		cct.cost_type,
		cic.item_cost
	 from	cst_item_costs cic,
		cst_cost_types cct,
		mtl_parameters mp
	 where	2=2                    -- p_organization_code
	 and	4=4                    -- p_cost_type
	 and	mp.organization_id     = cic.organization_id	
	 and	cic.cost_type_id       = cct.cost_type_id) cic,
	bom_components_b comp,
	bom_structures_b bom,
	mfg_lookups ml1, -- Make/buy code, MTL_PLANNING_MAKE_BUY
	mfg_lookups ml2, -- Cost based on rollup, CST_BOMROLLUP_VAL
	mfg_lookups ml3, -- Cost inventory_asset_flag, SYS_YES_NO
	mfg_lookups ml4, -- Component include in rollup, SYS_YES_NO
	mfg_lookups ml5, -- WIP Supply Type
	fnd_lookups fl1, -- Item costing enabled, YES_NO
	fnd_lookups fl2, -- Item inventory asset, YES_NO
	fnd_lookups fl3, -- Item default include in rollup, YES_NO
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl
-- ===================================================================
-- Cost type, organization, item master and report specific controls
-- ===================================================================
where	mp.organization_id              = msiv.organization_id
and	cic.organization_id             = msiv.organization_id (+)
and	cic.inventory_item_id           = msiv.inventory_item_id (+)
and	msiv.primary_uom_code           = muomv.uom_code
and	misv.inventory_item_status_code = msiv.inventory_item_status_code
and	msiv.inventory_item_status_code <> 'Inactive'
and	msiv2.inventory_item_status_code <> 'Inactive'
and	msiv.costing_enabled_flag       = 'Y'
and	bom.assembly_item_id            = msiv2.inventory_item_id
and	bom.organization_id             = msiv2.organization_id
and	msiv.organization_id            = msiv2.organization_id
and	msiv.inventory_item_id          = comp.component_item_id
and	comp.bill_sequence_id           = bom.bill_sequence_id
and	comp.effectivity_date          <= sysdate
and	bom.assembly_type               = 1 -- Manufacturing
and	bom.alternate_bom_designator is null
and	bom.common_assembly_item_id is null
--      Item_Include_in_Rollup <> BOM Component Include in Rollup
and	fl3.meaning <> ml4.meaning
-- Avoid unused inventory organizations
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
and	ml4.lookup_type                 = 'SYS_YES_NO'
and	ml4.lookup_code                 = to_char(comp.include_in_cost_rollup)
and	ml5.lookup_type (+)             = 'WIP_SUPPLY'
and	ml5.lookup_code (+)             = comp.wip_supply_type
and	fl1.lookup_type                 = 'YES_NO'
and	fl1.lookup_code                 = msiv.costing_enabled_flag
and	fl2.lookup_type                 = 'YES_NO'
and	fl2.lookup_code                 = msiv.inventory_asset_flag
and	fl3.lookup_type                 = 'YES_NO'
and	fl3.lookup_code                 = nvl(msiv.default_include_in_rollup_flag,'N')
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
and	fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	hoi.org_information1            = gl.ledger_id -- this gets the ledger id
and	1=1                             -- p_item_number, p_operating_unit, p_ledger
and	2=2                             -- p_org_code
group by
	'Compare Item Vs. Component Include in Rollup Controls', -- Report_Type
	nvl(gl.short_name, gl.name), -- Ledger
	haou2.name, -- Operating_Unit
	mp.organization_code, -- Org_Code
	cic.cost_type, -- Cost_Type
	msiv.concatenated_segments, -- Item_Number
	msiv.description, -- Item_Description
	msiv2.concatenated_segments, -- Assembly_Number
	msiv2.description, -- Assembly_Description
	-- Added for inline select statement
	msiv.inventory_item_id,
	msiv.organization_id,
	muomv.uom_code, -- UOM_Code
	fcl.meaning , -- Item_Type
	misv.inventory_item_status_code_tl, -- Item_Status
	ml1.meaning, -- Make_Buy_Code
	-- for inline queries to check to see if a bom or routing exists
	mp.organization_id,
	cic.inventory_item_id,
	ml2.meaning, -- Based_on_Rollup
	fl1.meaning, -- Costing_Enabled
	fl2.meaning, -- Item_Inventory_Asset
	ml3.meaning, -- Cost_Inventory_Asset
	fl3.meaning, -- Item_Include_in_Rollup
	ml4.meaning, -- BOM_Include_in_Rollup
	ml5.meaning, -- WIP_Supply_Type,
	-- End revision for version 1.31
	gl.currency_code, -- Currency_Code
	cic.item_cost, -- Item_Cost
	msiv.creation_date -- Item_Creation_Date
-- Order by Report_Type, Ledger, Operating_Unit, Org_Code, Item
order by
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	cic.cost_type,
	msiv.concatenated_segments,
	msiv2.concatenated_segments