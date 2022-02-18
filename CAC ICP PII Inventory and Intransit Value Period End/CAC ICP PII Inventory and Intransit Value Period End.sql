/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII Inventory and Intransit Value (Period-End)
-- Description: Report showing amount of profit in inventory at the end of the month.  If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.  In either case this report uses the month-end quantities, based on the entered period name.   (Note:  Profit in inventory is abbreviated as PII or sometimes as ICP - InterCompany Profit.)

Note:  if you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.

/* +=============================================================================+
-- | Copyright 2009 - 2020 Douglas Volz Consulting, Inc.                         |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_pii_inventory_val_rept.sql
-- |
-- |  Parameters:
-- |  p_period_name         -- Accounting period you wish to report for
-- |  p_pii_cost_type       -- The name of the cost type that has that 
-- |                           month's PII costs
-- |  p_pii_resource_code   -- The sub-element or resource for profit in inventory,
-- |                           such as PII or ICP 
-- |  p_org_code            -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit      -- Operating Unit you wish to report, leave blank for all
-- |                           operating units (optional) 
-- |  p_ledger              -- general ledger you wish to report, leave blank for all
-- |                           ledgers (optional)
-- |  p_cost_type           -- Enter a Cost Type to value the quantities
-- |                           using the Cost Type Item Costs; or, if 
-- |                           Cost Type is blank or null the report will 
-- |                           use the stored month-end snapshot values
-- |  p_category_set1       -- The first item category set to report, typically the
-- |                           Cost or Product Line Category Set
-- |  p_category_set2       -- The second item category set to report, typically the
-- |                           Inventory Category Set 
-- |
-- | ===================================================================
-- | Note:  if you enter a cost type this script uses the item costs 
-- |        from the cost type; if you leave the cost type 
-- |        blank it uses the item costs from the month-end snapshot.
-- | ===================================================================
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     27 Sep 2009 Douglas Volz Initial Coding
-- | 1.1     28 Sep 2009 Douglas Volz Added a sum for the ICP costs from cicd
-- | 1.16    23 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- |                                  master, item categories and operating units.
-- |                                  Changed the PII Resource Code into a parameter.
-- |                                  Used mfg_lookups for "Intransit".
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-icp-pii-inventory-and-intransit-value-period-end/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-inventory-and-intransit-value-period-end/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
-- =======================================================================
-- The first select gets the period-end quantities from the subinventories
-- =======================================================================
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	oap.period_name Period_Name,
	&segment_columns
	msiv.concatenated_segments  Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.13
	fcl.meaning Item_Type,
	-- Revision for version 1.14 and 1.16
	misv.inventory_item_status_code_tl Item_Status,
&category_columns
	gl.currency_code Curr_Code,
	round((nvl(cpcs.rollback_value,0)) /
	decode(nvl(cpcs.rollback_quantity,0), 0, 1,
	nvl(cpcs.rollback_quantity,0)),5) Gross_Item_Cost,
	-- Revision for version 1.1
	round(nvl((select sum(nvl(cicd.item_cost,0))
		   from   cst_item_cost_details cicd,
			  cst_cost_types cct,
			  bom_resources br
		   where  cicd.inventory_item_id = msiv.inventory_item_id
		   and    cicd.organization_id   = msiv.organization_id
		   and    br.resource_id         = cicd.resource_id
		   and    5=5                                                           -- p_pii_resource_code
		   and    cct.cost_type_id       = cicd.cost_type_id
		   and    4=4),0),5) PII_Item_Cost,					-- p_pii_cost_type
	round((nvl(cpcs.rollback_value,0)) /
		decode(nvl(cpcs.rollback_quantity,0), 0, 1,
		-- Revision for version 1.13, PII is a negative value
		nvl(cpcs.rollback_quantity,0)),5) + 
		--        nvl(cpcs.rollback_quantity,0)),5) -
		-- Revision for version 1.1
		round(nvl((select sum(nvl(cicd.item_cost,0))
		from	cst_item_cost_details cicd,
			cst_cost_types cct,
			bom_resources br
        where	cicd.inventory_item_id = msiv.inventory_item_id
        and	cicd.organization_id   = msiv.organization_id
        and	br.resource_id         = cicd.resource_id
        and	5=5                                                                     -- p_pii_resource_code
        and	cct.cost_type_id       = cicd.cost_type_id
        and	4=4),0),5) Net_Item_Cost,						-- p_pii_cost_type
	cpcs.subinventory_code Subinventory_or_Intransit,
	-- Revision for version 1.16
	muomv.uom_code UOM_Code,
	round(sum(nvl(cpcs.rollback_quantity,0)),3) Onhand_Quantity,
	round(sum(nvl(cpcs.rollback_value,0)),2) Onhand_Value,
	round(sum(nvl(cpcs.rollback_quantity,0)) * 
	-- Revision for version 1.1
		nvl((select sum(nvl(cicd.item_cost,0))
		     from   cst_item_cost_details cicd,
			    cst_cost_types cct,
			    bom_resources br
		     where  cicd.inventory_item_id = msiv.inventory_item_id
		     and    cicd.organization_id   = msiv.organization_id
		     and    br.resource_id         = cicd.resource_id
		     and    5=5                                                           -- p_pii_resource_code
		     and    cct.cost_type_id       = cicd.cost_type_id
		     and    4=4),0),2) PII_Onhand_Value,				  -- p_pii_cost_type
	round(sum(nvl(cpcs.rollback_value,0)),2) +
	-- Revision for version 1.1
	-- Revision for version 1.13, PII already a negative value
		round(sum(nvl(cpcs.rollback_quantity,0)) *
		nvl((select sum(nvl(cicd.item_cost,0))
		     from   cst_item_cost_details cicd,
			    cst_cost_types cct,
			    bom_resources br
		     where  cicd.inventory_item_id = msiv.inventory_item_id
		     and    cicd.organization_id   = msiv.organization_id
		     and    br.resource_id         = cicd.resource_id
		     and    5=5                                                           -- p_pii_resource_code
		     and    cct.cost_type_id       = cicd.cost_type_id
		     and    4=4),0),2) Net_Onhand_Value				          -- p_pii_cost_type
from	cst_period_close_summary cpcs,
	org_acct_periods oap,
	mtl_parameters mp,
	-- Revision for version 1.16
	mtl_system_items_vl msiv,
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	-- End Revision for version 1.16
	mtl_secondary_inventories msub,
	gl_code_combinations gcc,  -- subinventory accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_common_lookups fcl
	-- ===========================================
	-- Inventory accounting period joins
	-- ===========================================
where	oap.acct_period_id              = cpcs.acct_period_id
and	oap.organization_id             = mp.organization_id 
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
and	msub.secondary_inventory_name   = cpcs.subinventory_code
and	msub.organization_id            = cpcs.organization_id
and	mp.organization_id              = cpcs.organization_id
-- Revision for version 1.16
and	mp.organization_id              = msiv.organization_id
and	msiv.organization_id            = cpcs.organization_id
and	msiv.inventory_item_id          = cpcs.inventory_item_id
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End for revision for version 1.16
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	msub.material_account         = gcc.code_combination_id (+)
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context   = 'Accounting Information'
and	hoi.organization_id           = mp.organization_id
and	hoi.organization_id           = haou.organization_id   -- this gets the organization name
and	haou2.organization_id         = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
and	1=1								-- p_period_name, p_item_number, p_org_code, p_operating_unit, p_ledger
-- ===========================================
-- For Item_Type
-- ===========================================
and	fcl.lookup_code (+)           = msiv.item_type
and	fcl.lookup_type (+)           = 'ITEM_TYPE'
-- End revision for version 1.13
-- ===========================================
-- limit the rows returned-don't get zero rows
-- ===========================================
and	nvl(cpcs.rollback_quantity,0) <> 0
-- Don't report expense subinventories or expense items
and	msub.asset_inventory          <> 2
and	msiv.inventory_asset_flag     = 'Y'
-- ===========================================
-- Revision for version 1.12
-- Run this query if the Cost Type parameter 
-- is null, to get the snapshot inventory value.
-- ===========================================
and	decode('&p_cost_type',							-- p_cost_type
		null, 'use snapshot values', 
		'do not use snapshot values') =  'use snapshot values'
group by
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	oap.period_name,
	&segment_columns_grp        
	msiv.concatenated_segments,
	msiv.description,
	-- Revision for version 1.13
	fcl.meaning,
	-- Revision for version 1.14 and 1.16
	misv.inventory_item_status_code_tl,
	gl.currency_code,
	round((nvl(cpcs.rollback_value,0)) /
		decode(nvl(cpcs.rollback_quantity,0), 0, 1,
		nvl(cpcs.rollback_quantity,0)),5),
	msiv.inventory_item_id,
	msiv.organization_id,
	cpcs.subinventory_code,
	-- Revision for version 1.16
	muomv.uom_code
union all
-- =======================================================================
-- The second select gets the period-end quantities from intransit
-- =======================================================================
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	oap.period_name Period_Name,
	&segment_columns
	msiv.concatenated_segments  Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.13
	fcl.meaning Item_Type,
	-- Revision for version 1.14 and 1.16
	misv.inventory_item_status_code_tl Item_Status,
&category_columns
	gl.currency_code Curr_Code,
	round((nvl(cpcs.rollback_intransit_value,0)) /
		decode(nvl(cpcs.rollback_quantity,0), 0, 1,
		nvl(cpcs.rollback_quantity,0)),5) Gross_Item_Cost,
	-- Revision for version 1.1
	round(nvl((select sum(nvl(cicd.item_cost,0))
		   from   cst_item_cost_details cicd,
			  cst_cost_types cct,
			  bom_resources br
		   where  cicd.inventory_item_id = msiv.inventory_item_id
		   and    cicd.organization_id   = msiv.organization_id
		   and    br.resource_id         = cicd.resource_id
		   and    5=5                                                           -- p_pii_resource_code
		   and    cct.cost_type_id       = cicd.cost_type_id
		   and    4=4),0),5) PII_Item_Cost,					-- p_pii_cost_type
	round((nvl(cpcs.rollback_intransit_value,0)) /
		decode(nvl(cpcs.rollback_quantity,0), 0, 1,
		-- Revision for version 1.13, PII is a negative value
		nvl(cpcs.rollback_quantity,0)),5) -
		-- Revision for version 1.1
		round(nvl((select sum(nvl(cicd.item_cost,0))
			   from   cst_item_cost_details cicd,
				  cst_cost_types cct,
				  bom_resources br
			   where  cicd.inventory_item_id = msiv.inventory_item_id
			   and    cicd.organization_id   = msiv.organization_id
			   and    br.resource_id         = cicd.resource_id
			   and    5=5                                                    -- p_pii_resource_code
			   and    cct.cost_type_id       = cicd.cost_type_id
			   and    4=4),0),5) Net_Item_Cost,				 -- p_pii_cost_type
	-- Revision for version 1.16
	ml.meaning Subinventory_or_Intransit,
	muomv.uom_code UOM_Code,
	round(sum(nvl(cpcs.rollback_quantity,0)),3) Quantity,
	round(sum(nvl(cpcs.rollback_intransit_value,0)),2) Onhand_Value,
	round(sum(nvl(cpcs.rollback_quantity,0)) * 
	-- Revision for version 1.1
	nvl((select sum(nvl(cicd.item_cost,0))
	     from   cst_item_cost_details cicd,
		    cst_cost_types cct,
		    bom_resources br
	     where  cicd.inventory_item_id = msiv.inventory_item_id
	     and    cicd.organization_id   = msiv.organization_id
	     and    br.resource_id         = cicd.resource_id
	     and    5=5                                                                 -- p_pii_resource_code
	     and    cct.cost_type_id       = cicd.cost_type_id
	     and    4=4),0),2)     PII_Onhand_Value,					-- p_pii_cost_type
	round(sum(nvl(cpcs.rollback_intransit_value,0)),2) +
	-- Revision for version 1.1
	-- Revision for version 1.13, PII is a negative value
	round(sum(nvl(cpcs.rollback_quantity,0)) * 
		nvl((select sum(nvl(cicd.item_cost,0))
		     from   cst_item_cost_details cicd,
		            cst_cost_types cct,
			    bom_resources br
		     where  cicd.inventory_item_id = msiv.inventory_item_id
		     and    cicd.organization_id   = msiv.organization_id
		     and    br.resource_id         = cicd.resource_id
		     and    5=5                                                           -- p_pii_resource_code
		     and    cct.cost_type_id       = cicd.cost_type_id
		     and    4=4),0),2) Net_Onhand_Value				          -- p_pii_cost_type                                                                      -- p_pii_cost_type
from	cst_period_close_summary cpcs,
	org_acct_periods oap,
	mtl_parameters mp,
	-- Revision for version 1.16
	mtl_system_items_vl msiv,
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	mfg_lookups ml,
	-- End Revision for version 1.16
	gl_code_combinations gcc,  -- subinventory accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_common_lookups fcl,
	-- Revision for version 1.14
	-- Revision for version 1.10
	-- If the Inventory Parameters is missing the Intransit Account
	-- Need to get the Intransit Account from the Shipping Network
	(select	ic.code_combination_id,
		ic.organization_id
	 from	(select	gcc.code_combination_id,
			mip.to_organization_id organization_id
		 from	mtl_interorg_parameters mip,
			mtl_parameters mp,
			gl_code_combinations gcc
		 where	mip.fob_point               = 1 -- shipment
		 and	mp.organization_id          = mip.to_organization_id
		 and	mp.intransit_inv_account is null
		 and	gcc.code_combination_id (+) = mip.intransit_inv_account
		 union all
		 select	gcc.code_combination_id,
			mip.from_organization_id organization_id
		 from	mtl_interorg_parameters mip,
			mtl_parameters mp,
			gl_code_combinations gcc
		 where	mip.fob_point               = 2 -- receipt
		 and	mp.organization_id          = mip.from_organization_id
		 and	mp.intransit_inv_account is null
		 and	gcc.code_combination_id (+) = mip.intransit_inv_account
		 union all
		 select	gcc.code_combination_id,
			mp.organization_id organization_id
		 from	mtl_parameters mp,
			gl_code_combinations gcc
		 where	mp.intransit_inv_account is not null
		 and	gcc.code_combination_id (+) = mp.intransit_inv_account
		) ic
	 group by
		ic.code_combination_id,
		ic.organization_id
	) interco
	-- End revision for version 1.0
-- ===========================================
-- Inventory accounting period joins
-- ===========================================
where	oap.acct_period_id              = cpcs.acct_period_id
and	oap.organization_id             = mp.organization_id 
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
and	cpcs.subinventory_code is null
and	mp.organization_id              = cpcs.organization_id
-- Revision for version 1.16
and	mp.organization_id              = msiv.organization_id
and	msiv.organization_id            = cpcs.organization_id
and	msiv.inventory_item_id          = cpcs.inventory_item_id
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End for revision for version 1.16
-- ===========================================
-- Accounting code combination joins
-- ===========================================
-- Revision for version 1.9
-- and  mp.intransit_inv_account        = gcc.code_combination_id
-- Revision for version 1.14
-- -- Use the material account as a default for segments 1,3,4,5,6
-- -- and	mp.material_account     = gcc.code_combination_id
-- Revision for version 1.14
and	interco.code_combination_id     = gcc.code_combination_id (+)
and	interco.organization_id         = mp.organization_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and	1=1								-- p_period_name, p_item_number, p_org_code, p_operating_unit, p_ledger
-- ===========================================
-- For Item_Type
-- Revision for version 1.13
-- ===========================================
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- Revision for version 1.16
and	ml.lookup_code                  = 3
and	ml.lookup_type                  = 'MSC_CALENDAR_TYPE'
-- ===========================================
-- limit the rows returned-don't get zero rows
-- ===========================================
and	nvl(cpcs.rollback_quantity,0) <> 0
-- ===========================================
-- Revision for version 1.12
-- Run this query if the Cost Type parameter 
-- is null, to get the snapshot inventory value.
-- ===========================================
and	decode('&p_cost_type',							-- p_cost_type
		null, 'use snapshot values', 
		'do not use snapshot values') =  'use snapshot values'
group by
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	oap.period_name,
	&segment_columns_grp        
	msiv.concatenated_segments,
	msiv.description,
	-- Revision for version 1.13
	fcl.meaning,
	-- Revision for version 1.14 and 1.16
	misv.inventory_item_status_code_tl,
	gl.currency_code,
	round(nvl(cpcs.rollback_intransit_value,0) /
		decode(nvl(cpcs.rollback_quantity,0), 0, 1,
		nvl(cpcs.rollback_quantity,0)),5),
	msiv.inventory_item_id,
	msiv.organization_id,
	-- Revision for version 1.16
	ml.meaning,
	muomv.uom_code
union all
-- =======================================================================
-- Revision for version 1.12
-- Get the inventory values from the entered Cost Type
-- but use the quantities from the month-end snapshot
-- =======================================================================
-- =======================================================================
-- The first select gets the period-end quantities from the subinventories
-- =======================================================================
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	oap.period_name Period_Name,
	&segment_columns
	msiv.concatenated_segments  Item_Number,
	msiv.description Item_Description,
	fcl.meaning Item_Type,
	-- Revision for version 1.14 and 1.16
	misv.inventory_item_status_code_tl Item_Status,
&category_columns
	gl.currency_code Curr_Code,
	round(nvl(cic.item_cost,0),5) Gross_Item_Cost,
	-- Revision for version 1.1
	round(nvl((select sum(nvl(cicd.item_cost,0))
		   from   cst_item_cost_details cicd,
			  cst_cost_types cct,
			  bom_resources br
		   where  cicd.inventory_item_id = msiv.inventory_item_id
		   and    cicd.organization_id   = msiv.organization_id
		   and    br.resource_id         = cicd.resource_id
		   and    5=5                                                           -- p_pii_resource_code
		   and    cct.cost_type_id       = cicd.cost_type_id
		   and    4=4),0),5)      PII_Item_Cost,				-- p_pii_cost_type
	-- Revision for version 1.13, PII is negative
	round(nvl(cic.item_cost,0),5) +
	-- Revision for version 1.1
	round(nvl((select sum(nvl(cicd.item_cost,0))
		   from   cst_item_cost_details cicd,
			  cst_cost_types cct,
			  bom_resources br
		   where  cicd.inventory_item_id = msiv.inventory_item_id
		   and    cicd.organization_id   = msiv.organization_id
		   and    br.resource_id         = cicd.resource_id
		   and    5=5                                                           -- p_pii_resource_code
		   and    cct.cost_type_id       = cicd.cost_type_id
		   and    4=4),0),5) Net_Item_Cost,					-- p_pii_cost_type
	cpcs.subinventory_code Subinventory_or_Intransit,
	-- Revision for version 1.16
	muomv.uom_code UOM_Code,
	round(sum(nvl(cpcs.rollback_quantity,0)),3) Onhand_Quantity,
	-- Use the Cost Type Costs instead of the rollback_value
	-- sum(nvl(cpcs.rollback_value,0)) Onhand_Value,
	round(sum(nvl(cpcs.rollback_quantity,0) * nvl(cic.item_cost,0)),2) Onhand_Value,
	round(sum(nvl(cpcs.rollback_quantity,0)) * 
	-- Revision for version 1.1
	nvl((select sum(nvl(cicd.item_cost,0))
	     from   cst_item_cost_details cicd,
		    cst_cost_types cct,
		    bom_resources br
	     where  cicd.inventory_item_id = msiv.inventory_item_id
	     and    cicd.organization_id   = msiv.organization_id
	     and    br.resource_id         = cicd.resource_id
	     and    5=5                                                                 -- p_pii_resource_code
	     and    cct.cost_type_id       = cicd.cost_type_id
	     and    4=4),0),2) PII_Onhand_Value,					-- p_pii_cost_type
	-- Use the Cost Type Costs instead of the rollback_value
	-- sum(nvl(cpcs.rollback_value,0)) +
	round(sum(nvl(cpcs.rollback_quantity,0) * nvl(cic.item_cost,0)),2) + 
	-- Revision for version 1.1
	-- Revision for version 1.13, PII is negative
		round(sum(nvl(cpcs.rollback_quantity,0)) * 
		nvl((select sum(nvl(cicd.item_cost,0))
		     from   cst_item_cost_details cicd,
			    cst_cost_types cct,
			    bom_resources br
		     where  cicd.inventory_item_id = msiv.inventory_item_id
		     and    cicd.organization_id   = msiv.organization_id
		     and    br.resource_id         = cicd.resource_id
		     and    5=5                                                           -- p_pii_resource_code
		     and    cct.cost_type_id       = cicd.cost_type_id
		     and    4=4),0),2) Net_Onhand_Value				          -- p_pii_cost_type
from	cst_period_close_summary cpcs,
	org_acct_periods oap,
	mtl_parameters mp,
	-- Revision for version 1.16
	mtl_system_items_vl msiv,
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	-- End Revision for version 1.16
	mtl_secondary_inventories msub,
	-- Revision for version 1.12
	cst_cost_types cct,
	cst_item_costs cic,
	-- End revision for version 1.12
	gl_code_combinations gcc,  -- subinventory accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	-- Revision for version 1.13
	-- Revision for version 1.9
	-- fnd_lookup_values flv
	fnd_common_lookups fcl
-- ===========================================
-- Inventory accounting period joins
-- ===========================================
where	oap.acct_period_id            = cpcs.acct_period_id
and	oap.organization_id           = mp.organization_id 
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
and	msub.secondary_inventory_name = cpcs.subinventory_code
and	msub.organization_id          = cpcs.organization_id
and	mp.organization_id            = cpcs.organization_id
-- Revision for version 1.16
and	mp.organization_id              = msiv.organization_id
and	msiv.organization_id            = cpcs.organization_id
and	msiv.inventory_item_id          = cpcs.inventory_item_id
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End for revision for version 1.16
-- ===========================================
-- Accounting code combination joins
-- ===========================================
and	msub.material_account         = gcc.code_combination_id (+)
-- ===========================================
-- Cost Type Joins
-- Revision for version 1.12
-- ===========================================
and	6=6										-- p_cost_type
and	cct.cost_type_id              = cic.cost_type_id
and	cic.organization_id           = msiv.organization_id
and	cic.inventory_item_id         = msiv.inventory_item_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context   = 'Accounting Information'
and	hoi.organization_id           = mp.organization_id
and	hoi.organization_id           = haou.organization_id   -- this gets the organization name
and	haou2.organization_id         = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
and	1=1								-- p_period_name, p_item_number, p_org_code, p_operating_unit, p_ledger
-- ===========================================
-- For Item_Type
-- ===========================================
and	fcl.lookup_code (+)           = msiv.item_type
and	fcl.lookup_type (+)           = 'ITEM_TYPE'
-- End revision for version 1.13
-- ===========================================
-- limit the rows returned-don't get zero rows
-- ===========================================
and	nvl(cpcs.rollback_quantity,0) <> 0
-- Don't report expense subinventories or expense items
and	msub.asset_inventory          <> 2
and	msiv.inventory_asset_flag     = 'Y'
-- ===========================================
-- Revision for version 1.12
-- Run this query if the Cost Type parameter 
-- is not null, use the Cost Type Costs
-- to get the reported inventory value.
-- ===========================================
and	decode('&p_cost_type', 
		null, 'do not use snapshot values', 
		'use cost type values') =  'use cost type values'
group by
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	oap.period_name,
	&segment_columns_grp        
	msiv.concatenated_segments,
	msiv.description,
	fcl.meaning,
	-- Revision for version 1.14 and 1.16
	misv.inventory_item_status_code_tl,
	gl.currency_code,
	round((nvl(cpcs.rollback_value,0)) /
		decode(nvl(cpcs.rollback_quantity,0), 0, 1,
		nvl(cpcs.rollback_quantity,0)),5),
	msiv.inventory_item_id,
	msiv.organization_id,
	cpcs.subinventory_code,
	-- Revision for version 1.16
	muomv.uom_code,
	-- Revision for version 1.12
	-- Added for valuing based on the item costs
	cic.item_cost
union all
-- =======================================================================
-- The second select gets the period-end quantities from intransit
-- and the item costs from the entered cost type.
-- =======================================================================
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	oap.period_name Period_Name,
	&segment_columns
	msiv.concatenated_segments  Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.13
	fcl.meaning Item_Type,
	-- Revision for version 1.14 and 1.16
	misv.inventory_item_status_code_tl Item_Status,
&category_columns
	gl.currency_code Curr_Code,
	-- Get the item costs from the item costs table
	-- round((nvl(cpcs.rollback_intransit_value,0)) /
	--     decode(nvl(cpcs.rollback_quantity,0), 0, 1,
	--      nvl(cpcs.rollback_quantity,0)),5) Gross_Item_Cost,
	round(nvl(cic.item_cost,0),5) Gross_Item_Cost,
	-- Revision for version 1.1
	round(nvl((select sum(nvl(cicd.item_cost,0))
		   from   cst_item_cost_details cicd,
			  cst_cost_types cct,
			  bom_resources br
		   where  cicd.inventory_item_id = msiv.inventory_item_id
		   and    cicd.organization_id   = msiv.organization_id
		   and    br.resource_id         = cicd.resource_id
		   and    5=5                                                           -- p_pii_resource_code
		   and    cct.cost_type_id       = cicd.cost_type_id
		   and    4=4),0),5) PII_Item_Cost,					-- p_pii_cost_type
	-- Get the item costs from the item costs table
	-- round((nvl(cpcs.rollback_intransit_value,0)) /
	--     decode(nvl(cpcs.rollback_quantity,0), 0, 1,
	-- Revision for version 1.13
	-- Using a negative PII amount
	round(nvl(cic.item_cost,0),5) +
	-- Revision for version 1.1
		round(nvl((select sum(nvl(cicd.item_cost,0))
			   from   cst_item_cost_details cicd,
				  cst_cost_types cct,
				  bom_resources br
			   where  cicd.inventory_item_id = msiv.inventory_item_id
			   and    cicd.organization_id   = msiv.organization_id
			   and    br.resource_id         = cicd.resource_id
			   and    5=5                                                           -- p_pii_resource_code
			   and    cct.cost_type_id       = cicd.cost_type_id
			   and    4=4),0),5)  Net_Item_Cost,				        -- p_pii_cost_type
	-- Revision for version 1.16
	ml.meaning   Subinventory_or_Intransit,
	muomv.uom_code UOM_Code,
	round(sum(nvl(cpcs.rollback_quantity,0)),3) Quantity,
	-- Use the item costs from the Cost Type
	-- to value the Intransit inventory
	-- sum(nvl(cpcs.rollback_intransit_value,0)) Onhand_Value,
	round(sum(nvl(cic.item_cost,0) * nvl(cpcs.rollback_quantity,0)),2) Onhand_Value,
	round(sum(nvl(cpcs.rollback_quantity,0)) * 
	-- Revision for version 1.1
		nvl((select sum(nvl(cicd.item_cost,0))
		     from   cst_item_cost_details cicd,
			    cst_cost_types cct,
			    bom_resources br
		     where  cicd.inventory_item_id = msiv.inventory_item_id
		     and    cicd.organization_id   = msiv.organization_id
		     and    br.resource_id         = cicd.resource_id
		     and    5=5                                                           -- p_pii_resource_code
		     and    cct.cost_type_id       = cicd.cost_type_id
		     and    4=4),0),2)     PII_Onhand_Value,				  -- p_pii_cost_type
	-- Use the item costs from the Cost Type
	-- to value the Intransit inventory
	-- sum(nvl(cpcs.rollback_intransit_value,0)) +
		round(sum(nvl(cic.item_cost,0) * nvl(cpcs.rollback_quantity,0)),2) +
		-- Revision for version 1.1
		-- Revision for version 1.13
		-- PII item costs are negative
		round(sum(nvl(cpcs.rollback_quantity,0)) * 
			nvl((select sum(nvl(cicd.item_cost,0))
			     from   bom.cst_item_cost_details cicd,
				    bom.cst_cost_types cct,
				    bom.bom_resources br
			     where  cicd.inventory_item_id = msiv.inventory_item_id
			     and    cicd.organization_id   = msiv.organization_id
			     and    br.resource_id         = cicd.resource_id
			     and    5=5                                                      -- p_pii_resource_code
			     and    cct.cost_type_id       = cicd.cost_type_id
			     and    4=4),0),2) Net_Onhand_Value			             -- p_pii_cost_type
from	cst_period_close_summary cpcs,
	org_acct_periods oap,
	mtl_parameters mp,
	-- Revision for version 1.16
	mtl_system_items_vl msiv,
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	mfg_lookups ml,
	-- End Revision for version 1.16
	-- Revision for version 1.12
	cst_cost_types cct,
	cst_item_costs cic,
	-- End revision for version 1.12
	gl_code_combinations gcc,  -- subinventory accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	fnd_common_lookups fcl,
	-- Revision for version 1.10
	-- Need to get the Intransit Account from the Shipping Network
	-- as the inventory parameters Intransit Account is not always populated
	(select	ic.code_combination_id,
		ic.organization_id
	 from	(select	gcc.code_combination_id,
			mip.to_organization_id organization_id
		 from	mtl_interorg_parameters mip,
			mtl_parameters mp,
			gl_code_combinations gcc
		 where	mip.fob_point               = 1 -- shipment
		 and	mp.organization_id          = mip.to_organization_id
		 and	gcc.code_combination_id (+) = mip.intransit_inv_account
		 union all
		 select	gcc.code_combination_id,
			mip.from_organization_id organization_id
		 from	mtl_interorg_parameters mip,
			mtl_parameters mp,
			gl_code_combinations gcc
		 where	mip.fob_point               = 2 -- receipt
		 and	mp.organization_id          = mip.from_organization_id
		 and	gcc.code_combination_id (+) = mip.intransit_inv_account
		) ic
	 group by
		ic.code_combination_id,
		ic.organization_id
	) interco
  -- End revision for version 1.0
-- ===========================================
-- Inventory accounting period joins
-- ===========================================
where	oap.acct_period_id              = cpcs.acct_period_id
and	oap.organization_id             = mp.organization_id 
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
and	cpcs.subinventory_code is null
and	mp.organization_id              = cpcs.organization_id
-- Revision for version 1.16
and	mp.organization_id              = msiv.organization_id
and	msiv.organization_id            = cpcs.organization_id
and	msiv.inventory_item_id          = cpcs.inventory_item_id
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End for revision for version 1.16
-- ===========================================
-- Accounting code combination joins
-- ===========================================
-- Revision for version 1.9
-- and  mp.intransit_inv_account        = gcc.code_combination_id
--- Revision for version 1.14
-- -- Use the material account as a default for segments 1,3,4,5,6
-- and	mp.material_account             = gcc.code_combination_id
-- Revision for version 1.14
and	interco.code_combination_id     = gcc.code_combination_id (+)
and	interco.organization_id         = mp.organization_id
-- ===========================================
-- Cost Type Joins
-- Revision for version 1.12
-- ===========================================
and	6=6										-- p_cost_type
and	cct.cost_type_id                = cic.cost_type_id
and	cic.organization_id             = msiv.organization_id
and	cic.inventory_item_id           = msiv.inventory_item_id
-- ===========================================
-- Organization joins to the HR org model
-- ===========================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id   