/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC User-Defined and Rolled Up Costs
-- Description: Use this report to find items with both user-defined (manually entered) and rolled up costs.  Useful to find assemblies where the item costs have been accidentally doubled-up.

/* +=============================================================================+
-- |  Copyright 2010-2021 Douglas Volz Consulting, Inc.                          |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_user_defined_rolled_up_cost_rept.sql
-- |
-- |  Parameters:
-- | 
-- |  p_assignment_set        -- The assignment set for the sourcing rules (optional)
-- |  p_cost_type             -- Desired cost type, mandatory
-- |  p_item_number           -- Specific item number, to get all values enter a
-- |                             null or blank value (optional)
-- |  p_org_code             -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit       -- Operating_Unit you wish to report, leave blank for all
-- |                            operating units (optional) 
-- |  p_ledger               -- general ledger you wish to report, leave blank for all
-- |                            ledgers (optional)
-- | 
-- |  Description:
-- |  Use the below SQL script to find items with both user-defined and rolled up
-- |  item costs.  For material and other cost elements.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     29 Dec 2010 Douglas Volz   Create new report to find items with
-- |                                     both manually entered and rolled up material costs
-- |  1.1     24 May 2011 Douglas Volz   Bug fix for the resource code column
-- |  1.2     19 Oct 2019 Douglas Volz   Add columns for non-material costs
-- |  1.3     27 Jan 2020 Douglas Volz   Added Operating_Unit parameter and outer
-- |                                     join for Item_Type.
-- |  1.4     07 May 2021 Douglas Volz   Modify for multi-language tables.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-user-defined-and-rolled-up-costs/
-- Library Link: https://www.enginatics.com/reports/cac-user-defined-and-rolled-up-costs/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	cct.cost_type Cost_Type,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.4
	muomv.uom_code UOM_Code,
	fcl.meaning Item_Type,
	-- Revision for version 1.4
	misv.inventory_item_status_code Item_Status,
	ml1.meaning Make_Buy_Code,
&category_columns
	-- Revision for version 1.2 and 1.4
	nvl((select	max(ml2.meaning)
	 from	bom_resources br,
		cst_item_cost_details cicd,
		mfg_lookups ml2 -- rollup source type
	 where	br.resource_id         = cicd.resource_id
	 and	cicd.inventory_item_id = cic.inventory_item_id
	 and	cicd.organization_id   = cic.organization_id
	 and	cicd.cost_type_id      = cic.cost_type_id
	 and	cicd.item_cost        <> 0
	 and	cicd.cost_element_id   = 1
	 and	ml2.lookup_type        = 'CST_SOURCE_TYPE'
	 and	ml2.lookup_code        = cicd.rollup_source_type),'')  Rollup_Source_Type,
	-- End revision for version 1.2
	-- Bug fix for version 1.1
	-- (select distinct br.resource_code
	(select	max(br.resource_code)
	-- End bug fix for version 1.1
	 from	bom_resources br,
		cst_item_cost_details cicd
	 where	br.resource_id         = cicd.resource_id
	 and	cicd.inventory_item_id = cic.inventory_item_id
	 and	cicd.organization_id   = cic.organization_id
	 and	cicd.cost_type_id      = cic.cost_type_id
	 and	cicd.item_cost        <> 0
	-- Bug fix for version 1.14
	-- and	cicd.cost_element_id   = 1 -- Material_Costs
	-- End bug fix for version 1.1
	 and	cicd.cost_element_id   = 1)  Material_Sub_Element,
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
	      and	2=2),                  -- p_assignment_set
	'N')
	) Sourcing_Rule,
	-- Revision for version 1.4
	ml2.meaning Based_on_Rollup,
	ml3.meaning Inventory_Asset,
	-- End revision for version 1.4
	gl.currency_code Currency_Code,
	cic.item_cost Item_Cost,
	nvl((select	sum(nvl(cicd.item_cost,0))
	 from	bom_resources br,
		cst_item_cost_details cicd
	 where	br.resource_id          = cicd.resource_id
	 and	cicd.inventory_item_id  = cic.inventory_item_id
	 and	cicd.organization_id    = cic.organization_id
	 and	cicd.cost_type_id       = cic.cost_type_id
	 and	cicd.item_cost         <> 0
	 and	cicd.cost_element_id    = 1 -- Material_Costs
	 and	cicd.level_type         = 1 -- This Level
	 and	cicd.rollup_source_type in (1,2) -- manually entered or defaulted
	 and	cicd.cost_element_id    = 1),0) Manual_Material_Costs,
	nvl((select	sum(nvl(cicd.item_cost,0))
	 from	cst_item_cost_details cicd
	 where	cicd.inventory_item_id  = cic.inventory_item_id
	 and	cicd.organization_id    = cic.organization_id
	 and	cicd.cost_type_id       = cic.cost_type_id
	 and	cicd.item_cost         <> 0
	 and	cicd.cost_element_id    = 1 -- Material_Costs
	 and	cicd.level_type         = 2 -- Previous Level
	 and	cicd.rollup_source_type = 3 -- rolled up material costs
	 and	cicd.cost_element_id    = 1),0) Rolled_Up_Material_Costs,
	-- Revision for version 1.2
	nvl((select	sum(nvl(cicd.item_cost,0))
	     from	bom_resources br,
			cst_item_cost_details cicd
	 where	br.resource_id          = cicd.resource_id
	 and	cicd.inventory_item_id  = cic.inventory_item_id
	 and	cicd.organization_id    = cic.organization_id
	 and	cicd.cost_type_id       = cic.cost_type_id
	 and	cicd.item_cost         <> 0
	 and	cicd.cost_element_id   <> 1 -- Material_Costs
	 and	cicd.level_type         = 1 -- This Level
	 and	cicd.rollup_source_type in (1,2) -- manually entered or defaulted
	 and	cicd.cost_element_id    = 1),0) Manual_Other_Costs,
	nvl((select	sum(nvl(cicd.item_cost,0))
	 from	cst_item_cost_details cicd
	 where	cicd.inventory_item_id  = cic.inventory_item_id
	 and	cicd.organization_id    = cic.organization_id
	 and	cicd.cost_type_id       = cic.cost_type_id
	 and	cicd.item_cost         <> 0
	 and	cicd.cost_element_id   <> 1 -- Material_Costs
	 and	cicd.level_type         = 2 -- Previous Level
	 and	cicd.rollup_source_type = 3 -- rolled up material costs
	 and	cicd.cost_element_id    = 1),0) Rolled_Up_Other_Costs,
	msiv.creation_date Item_Creation_Date
	-- End revision for version 1.2
from	mtl_parameters mp,
	mtl_system_items_vl msiv,
	-- Revision for version 1.4
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv, 
	-- End revision for version 1.4
	cst_item_costs cic,
	cst_cost_types cct,
	mfg_lookups ml1, -- planning make buy code
	-- Revision for version 1.4
	mfg_lookups ml2, -- based on rollup, CST_BONROLLUP_VAL
	mfg_lookups ml3, -- Cost inventory_asset_flag, SYS_YES_NO
	-- End revision for version 1.4
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units haou,  -- inv_organization_id
	hr_all_organization_units haou2, -- operating unit
	gl_ledgers gl
-- ===================================================================
-- Cost type, organization, item master and report specific controls
-- ===================================================================
where	cic.cost_type_id                = cct.cost_type_id
and	mp.organization_id              = cic.organization_id
and	msiv.organization_id            = cic.organization_id
and	msiv.inventory_item_id          = cic.inventory_item_id
and	cic.based_on_rollup_flag        = 1 -- rolled up
-- Revision for version 1.2
and	msiv.inventory_item_status_code <> 'Inactive'
-- Revision for version 1.4
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.4
-- Avoid master inventory organizations
and	mp.organization_id             <> mp.master_organization_id -- the item master org usually does not have costs
-- ===================================================================
-- Joins for the lookup codes
-- ===================================================================
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code	                = msiv.planning_make_buy_code
-- Revision for version 1.4
and	ml2.lookup_type                 = 'CST_BONROLLUP_VAL'
and	ml2.lookup_code                 = cic.based_on_rollup_flag
and	ml3.lookup_type                 = 'SYS_YES_NO'
and	ml3.lookup_code                 = cic.inventory_asset_flag
-- End revision for version 1.4
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- Using the base tables to HR organization information
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id            -- this gets the organization name
-- avoid selecting disabled inventory organizations
and	sysdate                         < nvl(haou.date_to, sysdate +1)
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	hoi.org_information1            = gl.ledger_id                    -- this gets the ledger id                              
and	1=1                             -- p_cost_type, p_item_number, p_org_code, p_operating_unit, p_ledger
-- ===================================================================
-- Check to see if BOMS or Routings or Sourcing_Rules exist
-- ===================================================================
and	exists 
		-- check to see if a BOM exists
		((select 'x' 
		  from 	bom_structures_b bsb
		  where	bsb.organization_id        = cic.organization_id
		  and	bsb.assembly_item_id       = cic.inventory_item_id
		  and	bsb.alternate_bom_designator is null)
		union all
                  -- check to see if a routing exists
		 (select 'x' 
		  from 	bom_operational_routings bor
		  where	bor.organization_id        = cic.organization_id
		  and	bor.assembly_item_id       = cic.inventory_item_id)
		union all
		 (select 'x' from mrp_sr_receipt_org msro,
				  mrp_sr_source_org msso,
				  mrp_sourcing_rules msr,
				  mrp_sr_assignments msa,
				  mrp_assignment_sets mas
		  where msr.sourcing_rule_id    = msro.SOURCING_RULE_ID
		 -- fix for version 1.4, check to see if the sourcing rule is
		 -- for an inventory org, not a vendor
		  and	msso.sr_receipt_id      = msro.sr_receipt_id
		  and	msso.source_organization_id is  not null	
		  and	msa.sourcing_rule_id    = msr.sourcing_rule_id
		  and	msa.assignment_set_id   = mas.assignment_set_id
		  and	msiv.organization_id    = msa.organization_id
		  and	msiv.inventory_item_id  = msa.inventory_item_id
		  and	2=2)                    -- p_assignment_set
		)
-- ===================================================================
-- Check to see if manually entered costs exist for This Level Costs
-- ===================================================================
and	exists 
		(select 'x'
		 from	cst_item_cost_details cicd
		 where	cicd.organization_id    = cic.organization_id
		 and	cicd.inventory_item_id  = cic.inventory_item_id
		 -- fix for version 1.5
		 and	cicd.cost_type_id       = cic.cost_type_id
		 and	cicd.item_cost         <> 0
		 and	cicd.level_type         = 1 -- This Level
		 and	cicd.cost_element_id    = 1 -- Material_Costs
		 and	cicd.rollup_source_type in (1,2)) -- manually entered or defaulted
-- ===================================================================
-- Check to see if costs exist for Previous Levels / Rolled Up Costs
-- ===================================================================
and	exists 
		(select 'x'
		 from	cst_item_cost_details cicd
		 where	cicd.organization_id    = cic.organization_id
		 and	cicd.inventory_item_id  = cic.inventory_item_id
		 -- fix for version 1.5
		 and	cicd.cost_type_id       = cic.cost_type_id
		 and	cicd.item_cost         <> 0
		 and	cicd.cost_element_id    = 1 -- Material_Costs
		 and	cicd.level_type         = 2 -- Previous Level
		 and	cicd.rollup_source_type in (3)) -- rolled up
-- Order by Ledger, Operating_Unit, Org_Code, Cost_Type, Item_Number
order by
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	cct.cost_type,
	msiv.concatenated_segments