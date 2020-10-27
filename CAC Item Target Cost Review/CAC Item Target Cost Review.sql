/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Item Target Cost Review
-- Description: Compare PO target price against any Comparison Cost Type and also list the Standard Price (Market Price), Last PO Price, Converted Last PO Price and a Secondary Cost Type.  The Converted Last PO Price has been converted to the primary UOM and inventory organization's currency code.

/* +=============================================================================+
-- | Copyright 2020 Douglas Volz Consulting, Inc.                                |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_target_cost_review_rept.sql
-- |
-- |  Parameters:
-- |  p_cost_type1             -- The first comparison cost type you wish to report
-- |  p_cost_type2             -- The second comparison cost type you wish to report
-- |  p_item_number            -- Enter the specific item number you wish to report
-- |  p_org_code               -- specific organization code, works with
-- |                              null or valid organization codes
-- |  p_operating_unit         -- Operating Unit you wish to report, leave blank for all
-- |                              operating units (optional) 
-- |  p_ledger                 -- general ledger you wish to report, leave blank for all
-- |                              ledgers (optional)
-- |  p_include_uncosted_items -- Yes/No flag to include or not include non-costed items
-- |  p_category_set1          -- The first item category set to report, typically the
-- |                              Cost or Product Line Category Set
-- |  p_category_set2          -- The second item category set to report, typically the
-- |                              Inventory Category Set
-- |
-- | Description:
-- | Report to show item costs in any cost type
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0    29 Sep 2020 Douglas Volz   Initial Coding based on Item Cost Summary Report
-- |  1.1    
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-item-target-cost-review/
-- Library Link: https://www.enginatics.com/reports/cac-item-target-cost-review/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
-- ===================================================================
-- First get the items which are costing enabled 
-- ===================================================================
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	muomv.uom_code UOM_Code,
	fcl.meaning Item_Type,
	misv.inventory_item_status_code Item_Status,
	ml1.meaning Make_Buy_Code,
	nvl((select	max(mc.category_concat_segs)
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
	nvl((select	max(mc.category_concat_segs)
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
	fl1.meaning Allow_Costs,
	ml2.meaning Inventory_Asset,
	ml3.meaning Based_on_Rollup,
	cic1.shrinkage_rate Shrinkage_Rate,
	gl.currency_code Currency_Code,
	msiv.market_price Market_Price,
	msiv.list_price_per_unit Target_or_PO_List_Price,
	nvl(cic1.unburdened_cost,0) "&Cost_Type1 Unburdened Cost",
	nvl(msiv.list_price_per_unit,0) - nvl(cic1.unburdened_cost,0) Target_Price_Difference,
	(select	max(round(nvl(pll.price_override, pol.unit_price),6))
	 from	po_headers_all poh,
		po_lines_all pol,
		po_line_locations_all pll,
		po_distributions_all pod,
		mtl_uom_conversions_view ucr		
	 where 	poh.po_header_id            = pol.po_header_id
	 and	pol.po_line_id              = pll.po_line_id
	 and	pod.line_location_id        = pll.line_location_id 
	 and	pod.destination_type_code   = 'INVENTORY'
	 and	ucr.inventory_item_id       = msiv.inventory_item_id
	 and	ucr.organization_id         = msiv.organization_id
	 and	ucr.unit_of_measure         = pol.unit_meas_lookup_code
	 and	pll.ship_to_organization_id = mp.organization_id
	 and	pol.item_id                 = msiv.inventory_item_id
	) Last_PO_Price,
	(select	max(round(nvl(pll.price_override, pol.unit_price),6) *
	 -- Convert to primary UOM code
	 ucr.conversion_rate *
	 -- Convert to inventory org currency code
	 nvl(pod.rate,nvl(poh.rate,1)))
	 from	po_headers_all poh,
		po_lines_all pol,
		po_line_locations_all pll,
		po_distributions_all pod,
		mtl_uom_conversions_view ucr		
	 where 	poh.po_header_id            = pol.po_header_id
	 and	pol.po_line_id              = pll.po_line_id
	 and	pod.line_location_id        = pll.line_location_id 
	 and	pod.destination_type_code   = 'INVENTORY'
	 and	ucr.inventory_item_id       = msiv.inventory_item_id
	 and	ucr.organization_id         = msiv.organization_id
	 and	ucr.unit_of_measure         = pol.unit_meas_lookup_code
	 and	pll.ship_to_organization_id = mp.organization_id
	 and	pol.item_id                 = msiv.inventory_item_id
	) Converted_Last_PO_Price,
	cct1.cost_type Comparison_Cost_Type,
	nvl(cic1.material_cost,0) Material_Cost,
	nvl(cic1.material_overhead_cost,0) Material_Overhead_Cost,
	nvl(cic1.resource_cost,0) Resource_Cost,
	nvl(cic1.outside_processing_cost,0) Outside_Processing_Cost,
	nvl(cic1.overhead_cost,0) Overhead_Cost,
        nvl(cic1.item_cost,0) Item_Cost,
	cic1.creation_date Cost_Creation_Date,
	cic1.last_update_date Last_Cost_Update_Date,
	cic2.cost_type Second_Cost_Type,
	nvl(cic2.unburdened_cost,0) Unburdened_Cost2,
	nvl(cic2.material_cost,0) Material_Cost2,
	nvl(cic2.material_overhead_cost,0) Material_Overhead_Cost2,
	nvl(cic2.resource_cost,0) Resource_Cost2,
	nvl(cic2.outside_processing_cost,0) Outside_Processing_Cost2,
	nvl(cic2.overhead_cost,0) Overhead_Cost2,
        nvl(cic2.item_cost,0) Item_Cost2,
	cic2.creation_date Cost_Creation_Date2,
	cic2.last_update_date Last_Cost_Update_Date2
from	cst_item_costs cic1,
	cst_cost_types cct1,
	(select	cic2.cost_type_id,
		cct2.cost_type,
		cic2.organization_id,
		mp.organization_code,
		cic2.inventory_item_id,
		cic2.unburdened_cost,
		cic2.material_cost,
		cic2.material_overhead_cost,
		cic2.resource_cost,
		cic2.outside_processing_cost,
		cic2.overhead_cost,
		cic2.item_cost,
		cic2.creation_date,
		cic2.last_update_date
	 from	cst_item_costs cic2,  -- target item costs
		cst_cost_types cct2,  -- target cost type
		mtl_system_items_vl msiv,
		mtl_parameters mp
		where	cct2.cost_type_id      = cic2.cost_type_id
		and	mp.organization_id     = cic2.organization_id
		and	msiv.inventory_item_id = cic2.inventory_item_id
		and	msiv.organization_id   = cic2.organization_id
		and	5=5                             -- p_cost_type2
		and	6=6                             -- p_item_number
		and	7=7                             -- p_org_code
	) cic2,
	mtl_system_items_vl msiv,
	mtl_item_status_vl misv,
	mtl_units_of_measure_vl muomv,
	mtl_parameters mp,
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
where	mp.organization_id              = msiv.organization_id
and	msiv.inventory_item_id          = cic1.inventory_item_id
and	msiv.organization_id            = cic1.organization_id
and	cic1.inventory_item_id (+)      = cic2.inventory_item_id
and	cic1.organization_id (+)        = cic2.organization_id
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
and	cic1.cost_type_id               = cct1.cost_type_id
and	1=1                          -- p_operating_unit, p_ledger
and	4=4                          -- p_cost_type1
and	6=6                          -- p_item_number
and	7=7                          -- p_org_code
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
and	ml2.lookup_code                 = to_char(cic1.inventory_asset_flag)
and	ml3.lookup_type                 = 'CST_BONROLLUP_VAL'
and	ml3.lookup_code                 = cic1.based_on_rollup_flag
and	fl1.lookup_type                 = 'YES_NO'
and	fl1.lookup_code                 = msiv.costing_enabled_flag
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
and	fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
union all
-- ===================================================================
-- Now get the items which are not costing enabled 
-- ===================================================================
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	muomv.uom_code UOM_Code,
	fcl.meaning Item_Type,
	misv.inventory_item_status_code Item_Status,
	ml1.meaning Make_Buy_Code,
	nvl((select	max(mc.category_concat_segs)
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
	nvl((select	max(mc.category_concat_segs)
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
	fl1.meaning Allow_Costs,
	fl2.meaning Inventory_Asset,
	'N/A' Based_on_Rollup,
	null Shrinkage_Rate,
	gl.currency_code Currency_Code,
	msiv.market_price Market_Price,
	msiv.list_price_per_unit Target_or_PO_List_Price,
	null "&Cost_Type1 Unburdened Cost",
	nvl(msiv.list_price_per_unit,0) - 0 Target_Price_Difference,
	(select	max(round(nvl(pll.price_override, pol.unit_price),6))
	 from	po_headers_all poh,
		po_lines_all pol,
		po_line_locations_all pll,
		po_distributions_all pod,
		mtl_uom_conversions_view ucr		
	 where 	poh.po_header_id            = pol.po_header_id
	 and	pol.po_line_id              = pll.po_line_id
	 and	pod.line_location_id        = pll.line_location_id 
	 and	pod.destination_type_code   = 'INVENTORY'
	 and	ucr.inventory_item_id       = msiv.inventory_item_id
	 and	ucr.organization_id         = msiv.organization_id
	 and	ucr.unit_of_measure         = pol.unit_meas_lookup_code
	 and	pll.ship_to_organization_id = mp.organization_id
	 and	pol.item_id                 = msiv.inventory_item_id
	) Last_PO_Price,
	(select	max(round(nvl(pll.price_override, pol.unit_price),6) *
	 -- Convert to primary UOM code
	 ucr.conversion_rate *
	 -- Convert to inventory org currency code
	 nvl(pod.rate,nvl(poh.rate,1)))
	 from	po_headers_all poh,
		po_lines_all pol,
		po_line_locations_all pll,
		po_distributions_all pod,
		mtl_uom_conversions_view ucr		
	 where 	poh.po_header_id            = pol.po_header_id
	 and	pol.po_line_id              = pll.po_line_id
	 and	pod.line_location_id        = pll.line_location_id 
	 and	pod.destination_type_code   = 'INVENTORY'
	 and	ucr.inventory_item_id       = msiv.inventory_item_id
	 and	ucr.organization_id         = msiv.organization_id
	 and	ucr.unit_of_measure         = pol.unit_meas_lookup_code
	 and	pll.ship_to_organization_id = mp.organization_id
	 and	pol.item_id                 = msiv.inventory_item_id
	) Converted_Last_PO_Price,
	null Comparison_Cost_Type,
	null Unburdened_Cost,
	null Material_Cost,
	null Material_Overhead_Cost,
	null Resource_Cost,
	null Outside_Processing_Cost,
	null Overhead_Cost,
        null Item_Cost,
	null Cost_Creation_Date,
	null Last_Cost_Update_Date,
	null Second_Cost_Type,
	null Material_Cost2,
	null Material_Overhead_Cost2,
	null Resource_Cost2,
	null Outside_Processing_Cost2,
	null Overhead_Cost2,
        null Item_Cost2,
	null Cost_Creation_Date2,
	null Last_Cost_Update_Date2
from	mtl_system_items_vl msiv,
	mtl_item_status_vl misv,
	mtl_units_of_measure_vl muomv,
	mtl_parameters mp,
	mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
	fnd_lookups fl1, -- inventory_asset_flag, YES_NO
	fnd_lookups fl2, -- allow costs, YES_NO
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl
-- ===================================================================
-- Item master, organization and item master to cost joins
-- ===================================================================
where	mp.organization_id              = msiv.organization_id
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
and	1=1                          -- p_operating_unit, p_ledger
and	6=6                          -- p_item_number
and	7=7                          -- p_org_code
and	8=8                          -- Include or exclude uncosted items
-- ===================================================================
-- Find items where the item has no cost information
-- ===================================================================
and	msiv.costing_enabled_flag       = 'N'
-- ===================================================================
-- Don't report the unused inventory organizations
-- ===================================================================
and	mp.organization_id             <> mp.master_organization_id    -- remove the global master org
-- ===================================================================
-- Lookup codes
-- ===================================================================
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                 = msiv.planning_make_buy_code
and	fl1.lookup_type                 = 'YES_NO'
and	fl1.lookup_code                 = msiv.costing_enabled_flag
and	fl2.lookup_type                 = 'YES_NO'
and	fl2.lookup_code                 = msiv.inventory_asset_flag
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
and	fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- Using the base tables to avoid using org_organization_definitions
-- and hr_operating_units
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
-- order by Ledger, Operating_Unit, Org_Code, Item and Cost_Type
order by 1,2,3,4,5