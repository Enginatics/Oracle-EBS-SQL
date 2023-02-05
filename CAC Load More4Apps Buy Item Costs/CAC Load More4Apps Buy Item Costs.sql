/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Load More4Apps Buy Item Costs
-- Description: Report to fetch all buy items (based on rollup = No).   Used as a source of item costs for buy items. 
This report approximates the layout for the More4Apps Item Cost Wizard; run this report to get your buy item costs into Excel, make your changes in Excel then paste these costs into the More4Apps Item Cost Wizard.

/* +=============================================================================+
-- | Copyright 2017 - 2022 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_load_m4app_buy_item_costs.sql
-- |
-- |  Parameters:
-- |  p_org_code             -- The inventory organization to report from, if  
-- |                            enter a blank or null value you get all organizations
-- |  p_from_cost_type       -- The source cost type you wish to report
-- |  p_to_cost_type         -- The cost type you wish to load with More4Apps
-- |  p_operating_unit       -- Operating Unit you wish to report, leave blank for all
-- |                            operating units (optional) 
-- |  p_ledger               -- general ledger you wish to report, leave blank for all
-- |                            ledgers (optional)
-- |
-- | Description:
-- | Report to fetch all buy items (based on rollup = No).   Used as a source 
-- | of item costs for buy items. 
-- | This report approximates the layout for the More4Apps Item Cost Wizard; 
-- | run this report to get your buy item costs into Excel, make your changes in 
-- | Excel then paste these costs into the More4Apps Item Cost Wizard.
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0    07 Jun 2017 Douglas Volz  Initial Coding
-- |  1.1    16 Jun 2017 Douglas Volz  Only report based on rollup = No
-- |  1.2    12 Nov 2018 Douglas Volz  Remove prior client org restriction and
-- |                                   add Ledger parameter.
-- |  1.3    27 Jan 2020 Douglas Volz  Added Operating Unit parameter.
-- |  1.4    06 Jul 2022 Douglas Volz  Changed to multi-language views for the item
-- |                                   master and inventory orgs.
-- +=============================================================================+*/


-- Excel Examle Output: https://www.enginatics.com/example/cac-load-more4apps-buy-item-costs/
-- Library Link: https://www.enginatics.com/reports/cac-load-more4apps-buy-item-costs/
-- Run Report: https://demo.enginatics.com/

select	mp.organization_code Org_Code,
	:p_to_cost_type To_Cost_Type,                                                -- p_to_cost_type
	msiv.concatenated_segments Item_Number,
	cic.lot_size Lot_Size,
	decode(cic.based_on_rollup_flag,1,'Yes','No')  Based_on_Rollup,
	cic.shrinkage_rate MFG_Shrinkage,
	cce.cost_element Cost_Element,
	br.resource_code SubElement,
	ml.meaning Basis_Type,
	cicd.usage_rate_or_amount Rate_or_Amount,
	gl.currency_code Currency_Code
from	bom_resources br,
	mtl_system_items_vl msiv,
	mtl_parameters mp, 
	cst_cost_types cct,
	cst_cost_elements cce,
	cst_item_costs cic,
	cst_item_cost_details cicd,
	mfg_lookups ml,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl
where	mp.organization_id          = msiv.organization_id
and	decode (msiv.planning_make_buy_code, 1,'Make',2,'Buy','Unknown') = 'Buy'
and	msiv.inventory_asset_flag   = 'Y'  -- only valued items
-- ========================================================
-- Cost Type Joins
-- ========================================================
and	cic.inventory_item_id       = msiv.inventory_item_id
and	cic.organization_id         = msiv.organization_id
and	cic.cost_type_id            = cct.cost_type_id
and	cicd.cost_type_id           = cct.cost_type_id
and	cicd.organization_id        = cic.organization_id
and	cicd.inventory_item_id      = cic.inventory_item_id
and	cicd.level_type             = 1 -- This level
and	cicd.cost_type_id           = cct.cost_type_id
-- ========================================================
-- Organization, Bom Resources and Cost Element Joins
-- ========================================================
and	cicd.resource_id            = br.resource_id
and	cce.cost_element_id         = br.cost_element_id
and	br.cost_element_id          in (1,2)  -- Material and material overhead
and	mp.organization_id          = br.organization_id
-- Revision for version 1.1
and	cic.based_on_rollup_flag    = 2  -- 2 = No
-- ========================================================
-- Lookup Joins
-- ========================================================
and	ml.lookup_type              = 'CST_BASIS_SHORT'
and	ml.lookup_code              = cicd.basis_type
-- ========================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ========================================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id            -- this gets the organization name
and	haou2.organization_id       = hoi.org_information3            -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                         -- p_org_code, p_operating_unit, p_ledger
-- order by Org Code, Item, Cost Type, Cost Element and Sub-Element
order by 1,2,3,7,8