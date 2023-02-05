/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Cost Comparison
-- Description: Report to compare the item costs from two cost types in any two inventory orgs, converting the Org Code 1 (Source Org) into the currency of Org Code 2 (To Org).  Put the smallest cost type into Cost Type 1, as the values for cost type 1 are always reported even if not in cost type 2.  Note that the Source Org and the Compared To Org default from the inventory organization as set for your session.

/* +=============================================================================+
-- |  Copyright 2006 - 2020 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       | 
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Parameters:
-- |  p_org_code1            -- The inventory organization that is the source
-- |  p_org_code2            -- The inventory organization that is the target 
-- |  p_cost_type1           -- The source comparison cost type
-- |  p_cost_type2           -- The target comparison cost type
-- |  p_curr_conv_type       -- Conversion conversion type, to convert the Source
-- |                            org, org_code1, into the currency of the To_Org,
-- |                            org_code2
-- |  p_curr_conv_date       -- The currency conversion date, typically a month-end
-- |                            date
-- |  p_min_cost_diff        -- Minimum material cost diff. to show on the report
-- |  p_category_set1        -- The first item category set to report, typically the
-- |                            Cost or Product Line Category Set
-- |  p_category_set2        -- The second item category set to report, typically the
-- |                            Inventory Category Set
-- |
-- |  Description:
-- |  Report to compare the item costs from two cost types in any two inventory orgs,
-- |  converting the Org_Code 1 (Source_Org) into the currency of Org_Code 2 (To_Org).
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     02 APR 2006 Douglas Volz   Initial Coding
-- |  1.1     14 Apr 2006 Douglas Volz   Final Coding for client
-- |  1.4     13 JUN 2006 Douglas Volz   Added nvl to all material costs columns
-- |  1.5     02 NOV 2009 Douglas Volz   Changed to compare the item costs for two orgs
-- |                                     across different currencies
-- |  1.6     21 Nov 2016 Douglas Volz   Take out currencies, allow comparison within
-- |                                     the same inventory org but using different
-- |                                     cost types
-- |  1.7     18 Dec 2018 Douglas Volz   Add currencies back in
-- |  1.8     30 Aug 2019 Douglas Volz   Add cost and inventory item categories,
-- |                                     item type and item status.
-- |  1.9     01 Sep 2020 Douglas Volz   Added costs by cost element.
-- |  1.10    11 Sep 2020 Douglas Volz   Added ability to report cost type1 even when
-- |                                     the item is not in cost type1. Made cic2 a
-- |                                     table select to avoid sql outer join errors.
-- |  1.11    24 Oct 2020 Douglas Volz   Fix bug to convert into any currency, not just USD.
-- |  1.12    02 Nov 2020 Douglas Volz   Again, fix to report cost type 1 even when the
-- |                                     item is not in cost type 2.
-- |  1.13    05 Jan 2022 Douglas Volz   Add lot size, shrinkage rate, based on rollup
-- |                                     flags.  Change calc. for percent difference.
+=============================================================================+*/


-- Excel Examle Output: https://www.enginatics.com/example/cac-item-cost-comparison/
-- Library Link: https://www.enginatics.com/reports/cac-item-cost-comparison/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.8
	muomv.uom_code UOM_Code,
	fcl.meaning Item_Type,
	misv.inventory_item_status_code Item_Status,
	-- End of revision for version 1.8
	-- Revision for version 1.13
	ml1.meaning Make_Buy_Code,
	msiv.std_lot_size Std_Lot_Size,
	-- End revision for version 1.13
&category_columns
	mp.organization_code Org1,
	cct1.cost_type Cost_Type1,
	-- Revision for version 1.13
	ml2.meaning Org1_Inventory_Asset,
	ml3.meaning Org1_Based_on_Rollup,
	cic1.lot_size Org1_Lot_Size,
	cic1.shrinkage_rate Org1_Shrinkage_Rate,
	-- End revision for version 1.13
	gl.currency_code Currency_Code,
	-- Revision for version 1.9
	round(nvl(cic1.material_cost,0),5) Org1_Material_Cost,
	round(nvl(cic1.material_overhead_cost,0),5) Org1_Material_Overhead_Cost,
	round(nvl(cic1.resource_cost,0),5) Org1_Resource_Cost,
	round(nvl(cic1.outside_processing_cost,0),5) Org1_Outside_Processing_Cost,
	round(nvl(cic1.overhead_cost,0),5) Org1_Overhead_Cost,
	-- End of revision for version 1.9
	round(nvl(cic1.item_cost,0),5) Org1_Item_Cost,
	nvl(gdr.conversion_rate,1) Currency_Conversion_Rate,
	round(nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1) ,5) Converted_Org1_Cost,
	-- Revision for version 1.13
	cic2.ledger Ledger2,
	cic2.operating_unit Operating_Unit2,
	-- End revision for version 1.13
	-- Revision for version 1.10
	cic2.organization_code Org2,
	cic2.cost_type Cost_Type2,
	-- Revision for version 1.13
	ml4.meaning Org2_Inventory_Asset,
	ml5.meaning Org2_Based_on_Rollup,
	cic2.lot_size Org2_Lot_Size,
	cic2.shrinkage_rate Org2_Shrinkage_Rate,
	cic2.currency_code Org2_Currency_Code,
	-- End revision for version 1.13
	-- Revision for version 1.9
	round(nvl(cic2.material_cost,0),5) Org2_Material_Cost,
	round(nvl(cic2.material_overhead_cost,0),5) Org2_Material_Overhead_Cost,
	round(nvl(cic2.resource_cost,0),5) Org2_Resource_Cost,
	round(nvl(cic2.outside_processing_cost,0),5) Org2_Outside_Processing_Cost,
	round(nvl(cic2.overhead_cost,0),5) Org2_Overhead_Cost,
	-- End of revision for version 1.9
	round(nvl(cic2.item_cost,0),5) Org2_Item_Cost,
	-- Revision for version 1.13
	nvl(gdr.conversion_rate,1) Currency_Conversion_Rate,
	-- Revision for version 1.9
	round((nvl(cic1.material_cost,0) * nvl(gdr.conversion_rate,1)) - nvl(cic2.material_cost,0),5) Material_Difference,
	round((nvl(cic1.material_overhead_cost,0) * nvl(gdr.conversion_rate,1)) - nvl(cic2.material_overhead_cost,0),5) Material_Overhead_Difference,
	round((nvl(cic1.resource_cost,0) * nvl(gdr.conversion_rate,1)) - nvl(cic2.resource_cost,0),5) Resource_Difference,
	round((nvl(cic1.outside_processing_cost,0) * nvl(gdr.conversion_rate,1)) - nvl(cic2.outside_processing_cost,0),5) Outside_Processing_Difference,
	round((nvl(cic1.overhead_cost,0) * nvl(gdr.conversion_rate,1)) - nvl(cic2.overhead_cost,0),5) Overhead_Difference,
	-- End of revision for version 1.9
	round((nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1)) - nvl(cic2.item_cost,0),5) Item_Cost_Difference,
	-- Revision for version 1.13
  	-- round(round((nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1)) - nvl(cic2.item_cost,0),5)
	-- / decode((nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1)),0,1, (nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1))) * 100,1) Percent
	--  Case
	--  when difference = 0 then 0
	--  when difference = org2 then 100%
	--  when difference = org1 then -100%
	--  else org2 - org1 / org1
	case
	   when round((nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1)) - nvl(cic2.item_cost,0),5) = 0 then 0
	   when round((nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1)) - nvl(cic2.item_cost,0),5) = round(nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1),5) then 100
	   when round((nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1)) - nvl(cic2.item_cost,0),5) = round(nvl(cic2.item_cost,0),5) then -100
	   else round(round((nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1)) - nvl(cic2.item_cost,0),5)
		/ decode((nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1)),0,1, (nvl(cic1.item_cost,0) * nvl(gdr.conversion_rate,1))) * 100,1)
	end Percent
	-- End revision for version 1.13
from	cst_item_costs cic1, -- source item costs
	cst_cost_types cct1, -- source cost type
	mtl_system_items_vl msiv,
	-- Revision for version 1.8
	mtl_item_status_vl misv,
	mtl_units_of_measure_vl muomv,
	-- End revision for version 1.8
	mtl_parameters mp,   -- just the inventory cost type org
	-- Revision for version 1.10
	-- mtl_parameters mp2,  -- all inventory orgs
	-- Revision for version 1.7
	fnd_common_lookups fcl,
	-- Revision for version 1.13
	mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
	mfg_lookups ml2, -- inventory_asset_flag, SYS_YES_NO
	mfg_lookups ml3, -- based on rollup, CST_BONROLLUP_VAL
	mfg_lookups ml4, -- inventory_asset_flag, SYS_YES_NO
	mfg_lookups ml5, -- based on rollup, CST_BONROLLUP_VAL
	-- End revision for version 1.13
	-- Revision for version 1.10
	-- cst_item_costs cic2, -- target item costs
	-- cst_cost_types cct2, -- target cost type
	(select	cic2.cost_type_id,
		cct2.cost_type,
		cic2.organization_id,
		mp2.organization_code,
		cic2.inventory_item_id,
		cic2.material_cost,
		cic2.material_overhead_cost,
		cic2.resource_cost,
		cic2.outside_processing_cost,
		cic2.overhead_cost,
		cic2.item_cost,
		-- Revision for version 1.11
		gl.currency_code,
		-- Revision for version 1.13
		nvl(gl.short_name, gl.name) ledger,
		haou2.name operating_unit,
		cic2.inventory_asset_flag,
		cic2.based_on_rollup_flag,
		cic2.lot_size,
		cic2.shrinkage_rate
		-- End revision for version 1.13
	 from	cst_item_costs cic2,  -- target item costs
		cst_cost_types cct2,  -- target cost type
		-- Revision for version 1.11
		mtl_system_items_vl msiv,
		mtl_parameters mp2,
		hr_organization_information hoi,
		hr_all_organization_units_vl haou, -- inv_organization_id
		hr_all_organization_units_vl haou2,  -- operating unit
		gl_ledgers gl
		-- End revision for version 1.11 and 1.13
	 where	cct2.cost_type_id      = cic2.cost_type_id
	 and	mp2.organization_id    = cic2.organization_id
	 and	msiv.inventory_item_id = cic2.inventory_item_id
	 and	msiv.organization_id   = cic2.organization_id
	 -- Revision for version 1.11 and 1.13
	 and	hoi.org_information_context     = 'Accounting Information'
	 and	hoi.organization_id             = mp2.organization_id
	 and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
	 and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
	 and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
	 -- End revision for version 1.13
	 and	4=4                             -- p_org_code2 and p_cost_type2
	 and	5=5                             -- p_item_number
	) cic2,
	-- End revision for version 1.10
	-- Revision for version 1.11
	-- gl_daily_rates gdr,
	-- ===========================================================================
	-- Revision for version 1.11
	-- Tables to get currency exchange rate information for the inventory orgs
	-- Select Currency Rates based on the currency conversion date and type
	-- ===========================================================================
	(select	gdr.from_currency,
		gdr.to_currency,
		gdct.user_conversion_type,
		gdr.conversion_date,
		gdr.conversion_rate
	 from	gl_daily_rates gdr,
		gl_daily_conversion_types gdct
	 -- =================================================
	 -- Check for the currencies needed for the To Orgs
	 -- =================================================
	 where	exists  (
			 select 'x'
			 from	mtl_parameters mp,
				hr_organization_information hoi,
				gl_ledgers gl
			 where	hoi.org_information_context   = 'Accounting Information'
			 and	hoi.organization_id           = mp.organization_id
			 and	gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
			 and	gdr.to_currency               = gl.currency_code
			 and	mp.organization_id           <> mp.master_organization_id
			)
	 -- =================================================
	 -- Check for the currencies needed for the Src Orgs
	 -- =================================================
	 and	exists  (
			 select 'x'
			 from	mtl_parameters mp,
				hr_organization_information hoi,
				gl_ledgers gl
			 where	hoi.org_information_context   = 'Accounting Information'
			 and	hoi.organization_id           = mp.organization_id
			 and	gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
			 and	gdr.from_currency             = gl.currency_code
			 and	mp.organization_id           <> mp.master_organization_id
			)
	 and	gdr.conversion_type       = gdct.conversion_type
	 and	6=6                                           -- p_curr_conv_type
	 and	7=7                                           -- p_curr_conv_date
	 union all
	 -- =================================================
	 -- Get the currencies where the From and To is the 
	 -- same.  Example, where the From currency = USD 
	 -- and To currency = USD
	 -- =================================================
	 select	gl.currency_code,              -- from_currency
		gl.currency_code,              -- to_currency
		gdct.user_conversion_type,     -- conversion_type
		:p_curr_conv_date,             -- p_curr_conv_date
		1                              -- conversion_rate
	 from	gl_ledgers gl,
		gl_daily_conversion_types gdct
	 where	6=6                             -- p_curr_conv_type
	-- Revision for version 1.11
	 and	gl.accounted_period_type  =	(select	max(gl.accounted_period_type) 
						 from	mtl_parameters mp,
							hr_organization_information hoi,
							gl_ledgers gl
						 where	hoi.org_information_context   = 'Accounting Information'
						 and	hoi.organization_id           = mp.organization_id
						 and	gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
						 and	mp.organization_id           <> mp.master_organization_id
						)
	 group by
		gl.currency_code,
		gl.currency_code,
		gdct.user_conversion_type,
		:p_curr_conv_date,             -- p_curr_conv_date
		1
	) gdr, -- Currency Exchange Rates to use for all inventory orgs
	-- End revision for version 1.11
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2,  -- operating unit
	gl_ledgers gl
where	msiv.inventory_item_id          = cic1.inventory_item_id
and	msiv.organization_id            = cic1.organization_id
-- Revision for version 1.8
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.8
and	mp.organization_id              = cic1.organization_id
and	cct1.cost_type_id               = cic1.cost_type_id
and	1=1                             -- p_org_code1, p_cost_type1, p_min_cost_diff
and	5=5                             -- p_item_number
and	msiv.inventory_item_id          = cic2.inventory_item_id (+)
-- ===================================================================
-- Lookup codes
-- ===================================================================
-- Revision for version 1.7
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- End revision for version 1.7
-- Revision for version 1.13
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                 = msiv.planning_make_buy_code
and	ml2.lookup_type                 = 'SYS_YES_NO'
and	ml2.lookup_code                 = to_char(cic1.inventory_asset_flag)
and	ml3.lookup_type                 = 'CST_BONROLLUP_VAL'
and	ml3.lookup_code                 = cic1.based_on_rollup_flag
and	ml4.lookup_type                 = 'SYS_YES_NO'
and	ml4.lookup_code                 = to_char(cic2.inventory_asset_flag)
and	ml5.lookup_type                 = 'CST_BONROLLUP_VAL'
and	ml5.lookup_code                 = cic2.based_on_rollup_flag
-- End revision for version 1.13
-- ===================================================================
-- Joins for currency translation rate
-- ===================================================================
-- Revision for version 1.12
-- Revision for version 1.11
-- and	gdr.to_currency     (+)         = 'USD' -- version 1.10
-- and	gdr.to_currency                 = cic2.currency_code  -- version 1.11
and	gdr.to_currency                 = nvl(cic2.currency_code, gl.currency_code) -- version 1.12
-- End of revision for version 1.12
and	gdr.from_currency   (+)         = gl.currency_code
-- ===================================================================
-- using the base tables for HR organizations
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = hoi.org_information3   -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
order by
	nvl(gl.short_name, gl.name), -- Ledger
	haou2.name, -- Operating_Unit
	cct1.cost_type, --  Cost_Type1
	msiv.concatenated_segments, -- Item
	mp.organization_code -- Org1