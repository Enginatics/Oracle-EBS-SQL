/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Inventory and Intransit Value (Period-End)
-- Description: Report showing amount of inventory at the end of the month.  If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.  In either case this report uses the month-end quantities, based on the entered period name.  And as these quantities come from the month-end snapshot (created when you close the inventory accounting period) and this snapshot is only by inventory organization, subinventory and item and not split out by cost element, this report only shows the Material Account, based upon your Costing Method.

Note:  if you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.

/* +=============================================================================+
-- | Copyright 2009 - 2022 Douglas Volz Consulting, Inc.                         |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Parameters:
-- |  p_period_name         -- Accounting period you wish to report for
-- |  p_org_code            -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit      -- Operating Unit you wish to report, leave blank for all operating units (optional) 
-- |  p_ledger              -- general ledger you wish to report, leave blank for all ledgers (optional)
-- |  p_cost_type           -- Enter a Cost Type to value the quantities using the Cost Type Item Costs; or, if 
-- |                           Cost Type is blank or null the report will use the stored month-end snapshot values
-- |  p_category_set1       -- The first item category set to report, typically the Cost or Product Line Category Set
-- |  p_category_set2       -- The second item category set to report, typically the Inventory Category Set 
-- |  p_item_number         -- The part or item number you wish to report (optional)
-- |  p_subinventory        -- The specific subinventory you wish to report (optional)
-- |
-- | ===================================================================
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     27 Sep 2009 Douglas Volz Initial Coding
-- | 1.1     28 Sep 2009 Douglas Volz Added a sum for the ICP costs from cicd
-- | 1.16    23 Apr 2020 Douglas Volz Changed to multi-language views for the item master,
-- |                                  item categories and operating units.  Used mfg_lookups for "Intransit".
-- | 1.17    05 Mar 2022 Douglas Volz Use With statement for category, subinventory and intransit valuation accounts.
-- |                                  And changed from four union all statements to only two.
-- | 1.18    11 Mar 2022 Douglas Volz Performance improvements for category accounting
-- | 1.19    20 Mar 2022 Douglas Volz Fix for category accounts (valuation accounts) and
-- |                                  added subinventory description.
-- | 1.20    19 Oct 2022 Douglas Volz Fix for valuation accounts, causing duplicate rows.
-- | 1.21    21 Oct 2022 Douglas Volz Fix for detecting Cost Group Accounting.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-inventory-and-intransit-value-period-end/
-- Library Link: https://www.enginatics.com/reports/cac-inventory-and-intransit-value-period-end/
-- Run Report: https://demo.enginatics.com/

with inv_organizations as
-- Revision for version 1.17
-- Get the list of organizations
	(select	nvl(gl.short_name, gl.name) ledger,
		gl.ledger_id,
		haou2.name operating_unit,
		haou2.organization_id operating_unit_id,
		mp.organization_code,
		mp.organization_id,
		mca.organization_id category_organization_id,
		-- Revision for version 1.18
		mca.category_set_id, 
		mp.material_account,
		-- Revision for version 1.21, better logic for Cost Group Accounting
	 	-- mp.cost_group_accounting,
		case
		   when nvl(mp.cost_group_accounting,2) = 1 then 1
		   when	exists (select 'x'
				from   pjm_org_parameters pop
				where  mp.organization_id = pop.organization_id) then 1 -- Project MFG Enabled
		   when mp.primary_cost_method in (2,5,6) then 1 -- Average, FIFO or LIFO use Cost Group Accounting
		   when nvl(mp.process_enabled_flag, 'N') = 'Y' then 2 -- Avoid OPM and Process Costing
		   when nvl(mp.wms_enabled_flag, 'N') = 'Y' then 1 -- WMS uses Cost Group Accounting
		   else 2
		end cost_group_accounting,
		-- End revision for version 1.21
		mp.primary_cost_method,
		mp.default_cost_group_id,
		haou.date_to disable_date,
		gl.currency_code
	 from	mtl_category_accounts mca,
		mtl_parameters mp,
		hr_organization_information hoi,
		hr_all_organization_units_vl haou, -- inv_organization_id
		hr_all_organization_units_vl haou2, -- operating unit
		gl_ledgers gl
	 where	mp.organization_id              = mca.organization_id (+)
	 -- Avoid the item master organization
	 and	mp.organization_id             <> mp.master_organization_id
	 -- Avoid disabled inventory organizations
	 and	sysdate                        <  nvl(haou.date_to, sysdate +1)
	 and	hoi.org_information_context     = 'Accounting Information'
	 and	hoi.organization_id             = mp.organization_id
	 and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
	 and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
	 and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
	 and	1=1                             -- p_operating_unit, p_ledger
	 and	2=2                             -- p_org_code
	 group by
		nvl(gl.short_name, gl.name),
		gl.ledger_id,
		haou2.name, -- operating_unit
		haou2.organization_id, -- operating_unit_id
		mp.organization_code,
		mp.organization_id,
		mca.organization_id, -- category_organization_id
		-- Revision for version 1.18
		mca.category_set_id,
		mp.material_account,
		-- Revision for version 1.21
		-- mp.cost_group_accounting,
		case
		   when nvl(mp.cost_group_accounting,2) = 1 then 1
		   when	exists (select 'x'
				from   pjm_org_parameters pop
				where  mp.organization_id = pop.organization_id) then 1 -- Project MFG Enabled
		   when mp.primary_cost_method in (2,5,6) then 1 -- Average, FIFO or LIFO use Cost Group Accounting
		   when nvl(mp.process_enabled_flag, 'N') = 'Y' then 2 -- Avoid OPM and Process Costing
		   when nvl(mp.wms_enabled_flag, 'N') = 'Y' then 1 -- WMS uses Cost Group Accounting
		   else 2
		end, -- cost_group_accounting
		-- End revision for version 1.21
		mp.primary_cost_method,
		mp.default_cost_group_id,
		haou.date_to,
		gl.currency_code
	),
-- Get the inventory valuation accounts by organization, subinventory and category
valuation_accounts as
	(-- Standard Costing, no Cost Group Accounting
	 select 'Std Cost No Cost Group Accounting' valuation_type,
		msub.organization_id,
		msub.secondary_inventory_name,
		null category_id,
		null category_set_id,
		msub.material_account,
		msub.asset_inventory,
		msub.quantity_tracked,
		msub.default_cost_group_id cost_group_id
	 from	mtl_secondary_inventories msub,
		inv_organizations mp
	 where	msub.organization_id = mp.organization_id
	 and	nvl(mp.cost_group_accounting,2) = 2 -- No
	 -- Avoid organizations with category accounts
	 and	mp.category_organization_id is null
	 and	3=3                             -- p_subinventory
	 -- Revision for version 1.20
	 -- Causing duplicate rows with Average Costing
	 -- union all
	 -- -- Not Standard Costing, no Cost Group Accounting
	 -- select	'Not Std Cost No Cost Group Accounting' valuation_type,
	 -- 	msub.organization_id,
	 -- 	msub.secondary_inventory_name,
	 -- 	null category_id,
	 -- 	null category_set_id,
	 -- 	mp.material_account,
	 -- 	msub.asset_inventory,
	 -- 	msub.quantity_tracked,
	 -- 	msub.default_cost_group_id cost_group_id
	 -- from	mtl_secondary_inventories msub,
	 -- 	inv_organizations mp
	 -- where	msub.organization_id = mp.organization_id
	 -- and	nvl(mp.cost_group_accounting,2) = 2 -- No
	 -- and	mp.primary_cost_method         <> 1 -- not Standard Costing
	 -- -- Avoid organizations with category accounts
	 -- and	mp.category_organization_id is null
	 -- End revision for version 1.20
	 union all
	 -- With Cost Group Accounting
	 select	'Cost Group Accounting' valuation_type,
		msub.organization_id,
		msub.secondary_inventory_name,
		null category_id,
		null category_set_id,
		ccga.material_account,
		msub.asset_inventory,
		msub.quantity_tracked,
		msub.default_cost_group_id cost_group_id
	 from	mtl_secondary_inventories msub,
		cst_cost_group_accounts ccga,
		cst_cost_groups ccg,
		inv_organizations mp
	 where	msub.organization_id            = mp.organization_id
	 and	mp.cost_group_accounting        = 1 -- Yes
	 -- Avoid organizations with category accounts
	 and	mp.category_organization_id is null
	 and	ccga.cost_group_id              = nvl(msub.default_cost_group_id, mp.default_cost_group_id)
	 and	ccga.cost_group_id              = ccg.cost_group_id
	 and	ccga.organization_id            = mp.organization_id
	 and	3=3                             -- p_subinventory
	 union all
	 -- Category Accounting
	 -- Revision for version 1.19
	 select	'Category Accounting' valuation_type,
		mp.organization_id,
		cat_subinv.subinventory_code secondary_inventory_name,
		mc.category_id,
		mp.category_set_id,
		cat_subinv.material_account,
		cat_subinv.asset_inventory,
		cat_subinv.quantity_tracked,
		cat_subinv.cost_group_id
	 from	inv_organizations mp,
		mtl_categories_b mc,
		mtl_category_sets_b mcs,
		mtl_item_categories mic,
		(select	msub.organization_id,
			nvl(mca.subinventory_code, msub.secondary_inventory_name) subinventory_code,
			mca.category_id,
			mp.category_set_id,
			mca.material_account,
			msub.asset_inventory,
			msub.quantity_tracked,
			msub.default_cost_group_id cost_group_id
		 from	mtl_secondary_inventories msub,
			mtl_category_accounts mca,
			inv_organizations mp
		 where	msub.organization_id            = mp.organization_id
		 and	msub.organization_id            = mca.organization_id (+)
		 -- Revision for version 1.19
		 -- and	msub.secondary_inventory_name   = mca.subinventory_code (+)
		 and	msub.secondary_inventory_name   = nvl(mca.subinventory_code, msub.secondary_inventory_name)
		 -- Only get organizations with category accounts
		 and	mp.category_organization_id is not null
		 and	3=3                             -- p_subinventory
		 -- For a given category_id, if a subinventory-specific category account exists
		 -- exclude the category account with a null subinventory, to avoid double-counting  
		 and not exists
				(select	'x'
				 from	mtl_category_accounts mca2
				 where	mca.subinventory_code is null
				 and	mca2.subinventory_code is not null
				 and	mca2.organization_id = mca.organization_id
				 and	mca2.category_id     = mca.category_id
				)
		 group by
			msub.organization_id,
			nvl(mca.subinventory_code, msub.secondary_inventory_name),
			mca.category_id,
			mp.category_set_id,
			mca.material_account,
			msub.asset_inventory,
			msub.quantity_tracked,
			msub.default_cost_group_id
		) cat_subinv
	 where	mp.organization_id              = mic.organization_id
	 and	mp.category_set_id              = mic.category_set_id
	 and	mic.category_id                 = mc.category_id
	 and	mic.category_set_id             = mcs.category_set_id
	 and	mc.category_id                  = mic.category_id
	 and	mic.organization_id             = cat_subinv.organization_id (+)
	 and	mic.category_id                 = cat_subinv.category_id (+)
	 group by
		'Category Accounting',
		mp.organization_id,
		cat_subinv.subinventory_code,
		mc.category_id,
		mp.category_set_id,
		cat_subinv.material_account,
		cat_subinv.asset_inventory,
		cat_subinv.quantity_tracked,
		cat_subinv.cost_group_id
	 -- End revision for version 1.19
	 union all
	 select	'Intransit Accounting' valuation_type,
		interco.organization_id,
		'Intransit' secondary_inventory_name,
		null category_id,
		null category_set_id,
		interco.intransit_inv_account material_account,
		1 asset_inventory,
		1 quantity_tracked,
		mp.default_cost_group_id cost_group_id
	 from	inv_organizations mp,
		(select	ic.intransit_inv_account,
			ic.organization_id
		 from	(select	mip.intransit_inv_account,
				mip.to_organization_id organization_id
			 from	mtl_interorg_parameters mip,
				inv_organizations mp
			 where	mip.fob_point               = 1 -- shipment
			 and	mp.organization_id          = mip.to_organization_id
			 union all
			 select	mip.intransit_inv_account,
				mip.from_organization_id organization_id
			 from	mtl_interorg_parameters mip,
				inv_organizations mp
			 where	mip.fob_point               = 2 -- receipt
			 and	mp.organization_id          = mip.from_organization_id
			) ic
		 group by
			ic.intransit_inv_account,
			ic.organization_id
		) interco
	 where	mp.organization_id = interco.organization_id
	)
-- End revision for version 1.17

----------------main query starts here--------------

-- =======================================================================
-- Section I.  For non-category accounting, get period-end quantities and
--             values based solely on the month-end inventory snapshot.
-- =======================================================================
select	mp.ledger Ledger,
	mp.operating_unit Operating_Unit,
	mp.organization_code Org_Code,
	onhand.period_name Period_Name,
	&segment_columns
	onhand.concatenated_segments Item_Number,
	onhand.description Item_Description,
	-- Revision for version 1.13
	-- flv.meaning Item_Type,
	fcl.meaning Item_Type,
	-- Revision for version 1.14 and 1.16
	misv.inventory_item_status_code_tl Item_Status,
	-- Revision for version 1.11
&category_columns
	mp.currency_code Currency_Code,
	decode(onhand.subinventory_code,
			null, round(nvl(onhand.rollback_intransit_value,0) /
				decode(nvl(onhand.rollback_quantity,0), 0, 1,
				nvl(onhand.rollback_quantity,0)),5),
			round((nvl(onhand.rollback_value,0)) /
				decode(nvl(onhand.rollback_quantity,0), 0, 1,
				nvl(onhand.rollback_quantity,0)),5)
	      ) Item_Cost,
	nvl(onhand.subinventory_code, ml1.meaning) Subinventory_or_Intransit,
	-- Revision for version 1.19
	nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml1.meaning) Description,
	-- Revision for version 1.18
	ml2.meaning Asset,
	-- Revision for version 1.16
	muomv.uom_code UOM_Code,
	round(nvl(onhand.rollback_quantity,0),3) Onhand_Quantity,
	decode(onhand.subinventory_code,
		null, round(nvl(onhand.rollback_intransit_value,0),2),
		round(nvl(onhand.rollback_value,0),2)
	      ) Onhand_Value
from	inv_organizations mp,
	valuation_accounts va,
	-- Revision for version 1.16
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	-- End revision for version 1.16
	gl_code_combinations gcc,
	fnd_common_lookups fcl, -- Item Type
	mfg_lookups ml1, -- Intransit
	-- Revision for version 1.18
	mfg_lookups ml2, -- Inventory Asset
	-- Revision for version 1.19
	mtl_secondary_inventories msub,
	-- Revision for version 1.18
	-- Inner query for onhand quantities and values
	(-- For non-category accounting
	 select	mp.organization_id,
		msiv.inventory_item_id,
		msiv.concatenated_segments,
		-- Revision for version 1.19
		regexp_replace(msiv.description,'[^[:alnum:]'' '']', null) description,
		msiv.primary_uom_code,
		msiv.inventory_item_status_code,
		msiv.item_type,
		msiv.inventory_asset_flag,
		oap.period_name,
		cpcs.acct_period_id,
		nvl(cpcs.subinventory_code, 'Intransit') subinventory_code,
		sum(cpcs.rollback_quantity) rollback_quantity,
		sum(cpcs.rollback_value) rollback_value,
		sum(cpcs.rollback_intransit_value) rollback_intransit_value		
	 from	mtl_system_items_vl msiv,
		cst_period_close_summary cpcs,
		org_acct_periods oap,
		inv_organizations mp
	 where	mp.organization_id              = msiv.organization_id
	 and	oap.acct_period_id              = cpcs.acct_period_id
	 and	oap.organization_id             = mp.organization_id
	 and	msiv.organization_id            = cpcs.organization_id
	 and	msiv.inventory_item_id          = cpcs.inventory_item_id
	 and	mp.category_organization_id is null
	 -- Don't get zero quantities
	 and	nvl(cpcs.rollback_quantity,0)  <> 0
	 -- Don't report expense items
	 and	msiv.inventory_asset_flag       = 'Y'
	 and	4=4                             -- p_period_name, p_item_number
	 -- Need to group by due to possibility for having multiple cost groups by subinventory
	 group by
		mp.organization_id,
		msiv.inventory_item_id,
		msiv.concatenated_segments,
		regexp_replace(msiv.description,'[^[:alnum:]'' '']', null),
		msiv.primary_uom_code,
		msiv.inventory_item_status_code,
		msiv.item_type,
		msiv.inventory_asset_flag,
		oap.period_name,
		cpcs.acct_period_id,
		cpcs.subinventory_code
	) onhand
	-- End revision for version 1.18
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
where	mp.organization_id              = onhand.organization_id
and	muomv.uom_code                  = onhand.primary_uom_code
and	misv.inventory_item_status_code = onhand.inventory_item_status_code
and	mp.category_organization_id is null
-- Revision for version 1.19
and	onhand.subinventory_code        = msub.secondary_inventory_name (+)
and	onhand.organization_id          = msub.organization_id (+)
-- End revision for version 1.19
-- ===========================================
-- Accounting code combination joins
-- ===========================================
-- Revision for version 1.18
-- and	msub.material_account           = gcc.code_combination_id (+)
and	va.material_account             = gcc.code_combination_id (+)
and	va.secondary_inventory_name (+) = onhand.subinventory_code
and	va.organization_id (+)          = onhand.organization_id
and	va.valuation_type              <> 'Category Accounting'
-- End revision for version 1.18
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.13
and	fcl.lookup_code (+)             = onhand.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- Revision for version 1.16
and	ml1.lookup_code                 = 3 -- Intransit
and	ml1.lookup_type                 = 'MSC_CALENDAR_TYPE'
-- Revision for version 1.19
and	ml2.lookup_code                 = nvl(msub.asset_inventory,1)
and	ml2.lookup_type                 = 'SYS_YES_NO'
-- ===========================================
-- Revision for version 1.12
-- Run this query if the Cost Type parameter 
-- is null, to get the snapshot inventory value.
-- ===========================================
and	decode(:p_cost_type,            -- p_cost_type
		null, 'use snapshot values', 
		'do not use snapshot values') =  'use snapshot values'
union all
-- =======================================================================
-- Section II. For non-category accounting, get period-end quantities
--             based on the month-end inventory snapshot but get item
--             costs and values from the entered cost type.
-- =======================================================================
select	mp.ledger Ledger,
	mp.operating_unit Operating_Unit,
	mp.organization_code Org_Code,
	onhand.period_name Period_Name,
	&segment_columns
	onhand.concatenated_segments Item_Number,
	onhand.description Item_Description,
	-- Revision for version 1.13
	-- flv.meaning Item_Type,
	fcl.meaning Item_Type,
	-- Revision for version 1.14 and 1.16
	misv.inventory_item_status_code_tl Item_Status,
	-- Revision for version 1.11
&category_columns
	mp.currency_code Currency_Code,
	round(nvl(cic.item_cost,0),5) Item_Cost,
	nvl(onhand.subinventory_code, ml1.meaning) Subinventory_or_Intransit,
	-- Revision for version 1.19
	nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml1.meaning) Description,
	-- Revision for version 1.18
	ml2.meaning Asset,
	-- Revision for version 1.16
	muomv.uom_code UOM_Code,
	round(nvl(onhand.rollback_quantity,0),3) Onhand_Quantity,
	-- Use the Cost Type Costs instead of the rollback_value
	round(nvl(onhand.rollback_quantity,0) * nvl(cic.item_cost,0),2) Onhand_Value
from	inv_organizations mp,
	valuation_accounts va,
	-- Revision for version 1.16
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	-- End revision for version 1.16
	-- Revision for version 1.12
	cst_cost_types cct,
	cst_item_costs cic,
	-- End revision for version 1.12
	gl_code_combinations gcc,
	-- Revision for version 1.13
	fnd_common_lookups fcl, -- Item Type
	-- Revision for version 1.17
	mfg_lookups ml1, -- Intransit
	-- Revision for version 1.18
	mfg_lookups ml2, -- Inventory Asset Flag
	-- Revision for version 1.19
	mtl_secondary_inventories msub,
	-- Inner query for onhand quantities and values
	(-- For non-category accounting
	 select	mp.organization_id,
		msiv.inventory_item_id,
		msiv.concatenated_segments,
		regexp_replace(msiv.description,'[^[:alnum:]'' '']', null) description,
		msiv.primary_uom_code,
		msiv.inventory_item_status_code,
		msiv.item_type,
		msiv.inventory_asset_flag,
		oap.period_name,
		cpcs.acct_period_id,
		nvl(cpcs.subinventory_code, 'Intransit') subinventory_code,
		sum(cpcs.rollback_quantity) rollback_quantity,
		sum(cpcs.rollback_value) rollback_value,
		sum(cpcs.rollback_intransit_value) rollback_intransit_value		
	 from	mtl_system_items_vl msiv,
		cst_period_close_summary cpcs,
		org_acct_periods oap,
		inv_organizations mp
	 where	mp.organization_id              = msiv.organization_id
	 and	oap.acct_period_id              = cpcs.acct_period_id
	 and	oap.organization_id             = mp.organization_id
	 and	msiv.organization_id            = cpcs.organization_id
	 and	msiv.inventory_item_id          = cpcs.inventory_item_id
	 and	mp.category_organization_id is null
	 -- Don't report zero quantities
	 and	nvl(cpcs.rollback_quantity,0)  <> 0
	 -- Don't report expense items
	 and	msiv.inventory_asset_flag       = 'Y'
	 and	4=4                             -- p_period_name, p_item_number
	 -- Need to group by due to possibility for having multiple cost groups by subinventory
	 group by
		mp.organization_id,
		msiv.inventory_item_id,
		msiv.concatenated_segments,
		regexp_replace(msiv.description,'[^[:alnum:]'' '']', null),
		msiv.primary_uom_code,
		msiv.inventory_item_status_code,
		msiv.item_type,
		msiv.inventory_asset_flag,
		oap.period_name,
		cpcs.acct_period_id,
		cpcs.subinventory_code
	) onhand
	-- End revision for version 1.19
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
where	mp.organization_id              = onhand.organization_id
and	muomv.uom_code                  = onhand.primary_uom_code
and	misv.inventory_item_status_code = onhand.inventory_item_status_code
and	mp.category_organization_id is null
-- Revision for version 1.19
and	onhand.subinventory_code        = msub.secondary_inventory_name (+)
and	onhand.organization_id          = msub.organization_id (+)
-- ===========================================
-- Accounting code combination joins
-- ===========================================
-- Revision for version 1.18
-- and	msub.material_account           = gcc.code_combination_id (+)
and	va.material_account             = gcc.code_combination_id (+)
and	va.secondary_inventory_name (+) = onhand.subinventory_code
and	va.organization_id (+)          = onhand.organization_id
and	va.valuation_type              <> 'Category Accounting'
-- End revision for version 1.18
-- ===========================================
-- Cost Type Joins
-- Revision for version 1.12
-- ===========================================
and	5=5                             -- p_cost_type
and	cct.cost_type_id                = cic.cost_type_id
-- Revision for version 1.16
and	cic.organization_id             = onhand.organization_id
and	cic.inventory_item_id           = onhand.inventory_item_id
-- End for revision for version 1.16
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.13
and	fcl.lookup_code (+)             = onhand.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- Revision for version 1.16
and	ml1.lookup_code                 = 3 -- Intransit
and	ml1.lookup_type                 = 'MSC_CALENDAR_TYPE'
-- Revision for version 1.19
and	ml2.lookup_code                 = nvl(msub.asset_inventory,1)
and	ml2.lookup_type                 = 'SYS_YES_NO'
-- ===========================================
-- Revision for version 1.12
-- Run this query if the Cost Type parameter 
-- is not null, use the Cost Type Costs
-- to get the reported inventory value.
-- ===========================================
and	decode(:p_cost_type,            -- p_cost_type
		null, 'do not use snapshot values', 
		'use cost type values') =  'use cost type values'
union all
-- =======================================================================
-- Section III.  For category accounting, get period-end quantities and
--               values based solely on the month-end inventory snapshot.
-- =======================================================================
select	mp.ledger Ledger,
	mp.operating_unit Operating_Unit,
	mp.organization_code Org_Code,
	onhand.period_name Period_Name,
	&segment_columns
	onhand.concatenated_segments Item_Number,
	onhand.description Item_Description,
	-- Revision for version 1.13
	-- flv.meaning Item_Type,
	fcl.meaning Item_Type,
	-- Revision for version 1.14 and 1.16
	misv.inventory_item_status_code_tl Item_Status,
	-- Revision for version 1.11
&category_columns
	mp.currency_code Currency_Code,
	decode(onhand.subinventory_code,
			null, round(nvl(onhand.rollback_intransit_value,0) /
				decode(nvl(onhand.rollback_quantity,0), 0, 1,
				nvl(onhand.rollback_quantity,0)),5),
			round((nvl(onhand.rollback_value,0)) /
				decode(nvl(onhand.rollback_quantity,0), 0, 1,
				nvl(onhand.rollback_quantity,0)),5)
	      ) Item_Cost,
	nvl(onhand.subinventory_code, ml1.meaning) Subinventory_or_Intransit,
	-- Revision for version 1.19
	nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml1.meaning) Description,
	-- Revision for version 1.18
	ml2.meaning Asset,
	-- Revision for version 1.16
	muomv.uom_code UOM_Code,
	round(nvl(onhand.rollback_quantity,0),3) Onhand_Quantity,
	decode(onhand.subinventory_code,
		null, round(nvl(onhand.rollback_intransit_value,0),2),
		round(nvl(onhand.rollback_value,0),2)
	      ) Onhand_Value
from	inv_organizations mp,
	valuation_accounts va,
	-- Revision for version 1.16
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	-- End revision for version 1.16
	gl_code_combinations gcc,
	fnd_common_lookups fcl, -- Item Type
	mfg_lookups ml1, -- Intransit
	-- Revision for version 1.18
	mfg_lookups ml2, -- Inventory Asset
	-- Revision for version 1.19
	mtl_secondary_inventories msub,
	(-- This onhand inner query is for category accounting
	 select	onhand2.organization_id,
		onhand2.category_organization_id,
		onhand2.category_set_id,
		mic.category_id,
		onhand2.inventory_item_id,
		onhand2.concatenated_segments,
		onhand2.description,
		onhand2.primary_uom_code,
		onhand2.inventory_item_status_code,
		onhand2.item_type,
		onhand2.period_name,
		onhand2.subinventory_code,
		sum(onhand2.rollback_quantity) rollback_quantity,
		sum(onhand2.rollback_value) rollback_value,
		sum(onhand2.rollback_intransit_value) rollback_intransit_value		
	 from	mtl_item_categories mic,
		-- Inner select to have consistent outer joins with categories
		(select	mp.organization_id,
			mp.category_set_id,
			mp.category_organization_id,
			msiv.inventory_item_id,
			msiv.concatenated_segments,
			regexp_replace(msiv.description,'[^[:alnum:]'' '']', null) description,
			msiv.primary_uom_code,
 			msiv.inventory_item_status_code,
			msiv.item_type,
			oap.period_name,
			nvl(cpcs.subinventory_code, 'Intransit') subinventory_code,
			sum(cpcs.rollback_quantity) rollback_quantity,
			sum(cpcs.rollback_value) rollback_value,
			sum(cpcs.rollback_intransit_value) rollback_intransit_value
		 from	mtl_system_items_vl msiv,
			cst_period_close_summary cpcs,
			org_acct_periods oap,
			inv_organizations mp
		 where	mp.organization_id              = msiv.organization_id
		 and	mp.category_organization_id is not null
		 and	oap.organization_id             = mp.organization_id
		 and	oap.acct_period_id              = cpcs.acct_period_id
		 and	cpcs.organization_id            = msiv.organization_id
		 and	cpcs.inventory_item_id          = msiv.inventory_item_id
		 -- Don't get zero quantities
		 and	nvl(cpcs.rollback_quantity,0)  <> 0
		 and	4=4                             -- p_period_name, p_item_number
		 group by
			mp.organization_id,
			mp.category_set_id,
			mp.category_organization_id,
			msiv.inventory_item_id,
			msiv.concatenated_segments,
			regexp_replace(msiv.description,'[^[:alnum:]'' '']', null),
			msiv.primary_uom_code,
 			msiv.inventory_item_status_code,
			msiv.item_type,
			oap.period_name,
			nvl(cpcs.subinventory_code, 'Intransit') -- subinventory_code
		) onhand2
	 where	mic.inventory_item_id (+)       = onhand2.inventory_item_id
	 and	mic.organization_id (+)         = onhand2.organization_id
	 and	mic.category_set_id (+)         = onhand2.category_set_id
	 -- Need to group by due to possibility for having multiple cost groups by subinventory
	 group by
		onhand2.organization_id,
		onhand2.category_organization_id,
		onhand2.category_set_id,
		mic.category_id,
		onhand2.inventory_item_id,
		onhand2.concatenated_segments,
		onhand2.description,
		onhand2.primary_uom_code,
		onhand2.inventory_item_status_code,
		onhand2.item_type,
		onhand2.period_name,
		onhand2.subinventory_code
	) onhand
	-- End revision for version 1.19
-- ========================================================================
-- Subinventory, mtl parameter, item master and period close snapshot joins
-- ========================================================================
where	mp.organization_id              = onhand.organization_id
and	muomv.uom_code                  = onhand.primary_uom_code
and	misv.inventory_item_status_code = onhand.inventory_item_status_code
and	mp.category_organization_id is not null
-- Revision for version 1.19
and	onhand.subinventory_code        = msub.secondary_inventory_name (+)
and	onhand.organization_id          = msub.organization_id (+)
-- End revision for version 1.19
-- ===========================================
-- Accounting code combination joins
-- ===========================================
-- Revision for version 1.19
and	va.material_account             = gcc.code_combination_id (+)
and	va.secondary_inventory_name (+) = onhand.subinventory_code 
and	va.organization_id (+)          = onhand.organization_id
and	va.category_set_id (+)          = onhand.category_set_id
and	va.category_id (+)              = onhand.category_id
and	va.valuation_type (+)           = 'Category Accounting'
-- End revision for version 1.19
-- ===========================================
-- Lookup Codes
-- ===========================================
-- Revision for version 1.13
and	fcl.lookup_code (+)             = onhand.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- Revision for version 1.16
and	ml1.lookup_code                 = 3 -- Intransit
and	ml1.lookup_type                 = 'MSC_CALENDAR_TYPE'
-- Revision for version 1.19
and	ml2.lookup_code                 = nvl(msub.asset_inventory,1)
and	ml2.lookup_type                 = 'SYS_YES_NO'
-- ===========================================
-- Revision for version 1.12
-- Run this query if the Cost Type parameter 
-- is null, to get the snapshot inventory value.
-- ===========================================
and	decode(:p_cost_type,            -- p_cost_type
		null, 'use snapshot values', 
		'do not use snapshot values') =  'use snapshot values'
union all
-- =======================================================================
-- Section IV. For category accounting, get period-end quantities from the
--             month-end snapshot but get item costs from entered cost type.
-- =======================================================================
select	mp.ledger Ledger,
	mp.operating_unit Operating_Unit,
	mp.organization_code Org_Code,
	onhand.period_name Period_Name,
	&segment_columns
	onhand.concatenated_segments Item_Number,
	onhand.description Item_Description,
	-- Revision for version 1.13
	-- flv.meaning Item_Type,
	fcl.meaning Item_Type,
	-- Revision for version 1.14 and 1.16
	misv.inventory_item_status_code_tl Item_Status,
	-- Revision for version 1.11
&category_columns
	mp.currency_code Currency_Code,
	round(nvl(cic.item_cost,0),5) Item_Cost,
	nvl(onhand.subinventory_code, ml1.meaning) Subinventory_or_Intransit,
	-- Revision for version 1.19
	nvl(regexp_replace(msub.description,'[^[:alnum:]'' '']', null), ml1.meaning) Description,
	-- Revision for version 1.18
	ml2.meaning Asset,
	-- Revision for version 1.16
	muomv.uom_code UOM_Code,
	round(nvl(onhand.rollback_quantity,0),3) Onhand_Quantity,
	-- Use the Cost Type Costs instead of the rollback_value
	round(nvl(onhand.rollback_quantity,0) * nvl(cic.item_cost,0),2) Onhand_Value
from	inv_organizations mp,
	valuation_accounts va,
	-- Revision for version 1.16
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	-- End revision for version 1.16
	-- Revision for version 1.12
	cst_cost_types cct,
	cst_item_costs cic,
	-- End revision for version 1.12
	gl_code_combinations gcc,
	-- Revision for version 1.13
	fnd_common_lookups fcl, -- Item Type
	-- Revision for version 1.17
	mfg_lookups ml1, -- Intransit
	-- Revision for version 1.18
	mfg_lookups ml2, -- Inventory Asset Flag
	-- Revision for version 1.19
	mtl_secondary_inventories msub,
	(-- This onhand inner query is for category accounting
	 select	onhand2.organization_id,
		onhand2.category_organization_id,
		onhand2.category_set_id,
		mic.category_id,
		onhand2.inventory_item_id,
		onhand2.concatenated_segments,
		onhand2.description,
		onhand2.primary_uom_code,
		onhand2.inventory_item_status_code,
		onhand2.item_type,
		onhand2.period_name,
		onhand2.subinventory_code,
		sum(onhand2.rollback_quantity) rollback_quantity	
	 from	mtl_item_categories mic,
		-- Inner select to have consistent outer joins with categories
		(select	mp.organization_id,
			mp.category_set_id,
			mp.category_organization_id,
			msiv.inventory_item_id,
			msiv.concatenated_segments,
			regexp_replace(msiv.description,'[^[:alnum:]'' '']', null) description,
			msiv.primary_uom_code,
 			msiv.inventory_item_status_code,
			msiv.item_type,
			oap.period_name,
			nvl(cpcs.subinventory_code, 'Intransit') subinventory_code,
			sum(cpcs.rollback_quantity) rollback_quantity
		 from	mtl_system_items_vl msiv,
			cst_period_close_summary cpcs,
			org_acct_periods oap,
			inv_organizations mp
		 where	mp.organization_id              = msiv.organization_id
		 and	mp.category_organization_id is not null
		 and	oap.organization_id             = mp.organization_id
		 and	oap.acct_period_id              = cpcs.acct_period_id
		 and	cpcs.organization_id            = msiv.organization_id
		 and	cpcs.inventory_item_id          = msiv.inventory_item_id
		 -- Don't get zero quantities
		 and	nvl(cpcs.rollback_quantity,0)  <> 0
		 and	4=4                             -- p_period_name, p_item_number
		 group by
			mp.organization_id,
			mp.category_set_id,
			mp.category_organization_id,
			msiv.inventory_item_id,
			msiv.concatenated_segments,
			regexp_replace(msiv.description,'[^[:alnum:]'' '']', null),
			msiv.primary_uom_code,
 			msiv.inventory_item_status_code,
			msiv.item_type,
			oap.period_name,
			nvl(cpcs.subinventory_code, 'Intransit') -- subinventory_code
		) onhand2
	 where	mic.inventory_item_id (+)       = onhand2.inventory_item_id
	 and	mic.organization_id (+)         = onhand2.organization_id
	 and	mic.category_set_id (+)         = onhand2.category_set_id
	 -- N