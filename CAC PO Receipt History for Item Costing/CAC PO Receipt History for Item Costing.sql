/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC PO Receipt History for Item Costing
-- Description: Report to show Purchase Order (PO) Receipt History for inventory organizations, for a selected PO receipt date range.  If the Comparison Cost Type is not entered the report uses the Cost Type from the Primary Costing Method, such as Frozen, Average, FIFO or LIFO.  And note you may use this report for any discrete costing method but the CAC PO Receipt History for Non-Standard Costing report may be a better choice for Average, FIFO and LIFO Costing, as additional information is available, such as the prior costed quantity, prior cost and new onhand quantity.

Parameters:
===========
Transaction Date From:  enter the starting transaction date for PO Receipt History (mandatory).
Transaction Date To:  enter the ending transaction date for PO Receipt History (mandatory).
Comparison Cost Type: enter the cost type to compare against the PO receipts (optional).  If the Comparison Cost Type is not entered the report uses Cost Type from the Primary Costing Method.
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2006 - 2022 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.                                                                 
-- +=============================================================================+
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     28 May 2006 Douglas Volz   Initial Coding based on item_cost_history.sql
-- | 1.1     04 Jan 2019 Douglas Volz   Added transaction date range, inventory
-- |                                    org and specific item parameters.
-- | 1.2     30 Aug 2019 Douglas Volz   Add Ledger, Operating Unit, Item Type, Status
-- |                                    and item categories for cost and inventory.
-- | 1.3     27 Jan 2020 Douglas Volz   Added Org_Code and Operating_Unit parameters.
-- | 1.4     05 Jul 2022 Douglas Volz   Modify for multi-language tables, change UOM to
-- |                                    primary, and changes for Standard Costing.
-- | 1.5     01 Sep 2022 Douglas Volz   Add supplier information to report.
-- | 1.6     13 Dec 2022 Douglas Volz   Fix supplier type and cost type logic.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-po-receipt-history-for-item-costing/
-- Library Link: https://www.enginatics.com/reports/cac-po-receipt-history-for-item-costing/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	he.full_name Buyer,
	mmt.transaction_id Transaction_Id,
	msiv.concatenated_segments Item,
	msiv.description Item_Description,
	-- Revision for version 1.2
	fcl.meaning Item_Type,
	-- Revision for version 1.4
	-- msiv.inventory_item_status_code Item_Status,
	misv.inventory_item_status_code Item_Status,
	ml1.meaning Make_Buy_Code,
	-- End revision for version 1.4
	-- Revision for version 1.2
&category_columns
	-- Revision for version 1.6
	mmt.transaction_date Transaction_Date,
	-- Revision for version 1.5
	pv.vendor_name Supplier,
	pv.segment1 Supplier_Number,
	flvv.meaning Supplier_Type,
	-- End revision for version 1.5
	poh.segment1 PO_Number, 
	pol.line_num PO_Line,
	pr.release_num PO_Release,
	-- Revision for version 1.4
	-- msiv.primary_uom_code UOM,
	muomv.uom_code Primary_UOM_Code,
	-- Revision for version 1.4
	-- Remove, not available for Standard Costing
	-- mmt.prior_costed_quantity Prior_Costed_Quantity,
	-- Revision for version 1.4, change to primary quantity
	-- mmt.transaction_quantity Transaction_Quantity,
	mmt.primary_quantity Primary_Quantity,
	-- Revision for version 1.4, remove, not available for Standard Costing
	-- mmt.transaction_quantity + mmt.prior_costed_quantity New_Onhand_Quantity,	
	-- round(nvl(mcacd.prior_cost,0),5) Prior_Cost,
	-- Revision for version 1.4, change for standard costing
	-- round(nvl(mcacd.actual_cost,0),5) PO_Unit_Price,
	round(nvl(mmt.transaction_cost,0),5)  PO_Unit_Price,
	-- Revision for version 1.4, changes for Standard Costing
	-- round(nvl(mcacd.new_cost,0),5) Comparison_Item_Cost,
	-- round(nvl(mcacd.new_cost,0) - nvl(mcacd.prior_cost,0),5) Cost_Difference
	-- Revision for version 1.6
	cct.cost_type "Comparison Cost Type",
	round(nvl(cic.item_cost,0),5)- round(nvl(cic.tl_material_overhead,0),5) Comparison_Material_Item_Cost,
	round(nvl(cic.item_cost,0),5)- round(nvl(cic.tl_material_overhead,0),5) - round(nvl(mmt.transaction_cost,0),5) Cost_Difference
from	mtl_material_transactions mmt,
	-- Revision for version 1.4
	-- Remove mtl_cst_actual_cost_details, not needed for standard costing
	-- mtl_cst_actual_cost_details mcacd,
	cst_item_costs cic,
	cst_cost_types cct,
	-- End revision for version 1.4
	rcv_transactions rt,
	-- Revision for version 1.5
	po_vendors pv,
	fnd_lookup_values_vl flvv,
	-- End revision for version 1.5
	mtl_system_items_vl msiv,
	-- Revision for version 1.4
	mtl_item_status_vl misv,
	mtl_units_of_measure_vl muomv,
	mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
	-- End revision for version 1.4
	po_headers_all poh,
	po_lines_all pol,
	po_line_locations_all pll,
	po_releases_all pr,
	hr_employees he,
	mtl_parameters mp,
	-- Revision for version 1.2
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2,  -- operating unit
	gl_ledgers gl
where	mmt.inventory_item_id 	 	= msiv.inventory_item_id
and	mmt.organization_id	 	= msiv.organization_id
and	mmt.transaction_source_type_id	= 1 -- purchase orders
-- Revision for version 1.5
and	pv.vendor_id (+)                = rt.vendor_id
and	flvv.lookup_code (+)            = pv.vendor_type_lookup_code
-- End revision for version 1.5
-- Revision for version 1.6
-- and	cic.cost_type_id                = nvl(cct.cost_type_id, mp.primary_cost_method)
and	flvv.lookup_type (+)            = 'VENDOR TYPE'
and	cic.cost_type_id                = cct.cost_type_id
and	cct.cost_type_id                =
		case
		   when :p_cost_type is null then mp.primary_cost_method
		   when :p_cost_type is not null then (select cct2.cost_type_id from cst_cost_types cct2 where cct2.cost_type = :p_cost_type)
		   else mp.primary_cost_method
		end
-- End revision for version 1.6
-- Revision for version 1.4
-- Remove mtl_cst_actual_cost_details, not complete for standard costing
-- and	mmt.transaction_id		= mcacd.transaction_id
-- and	mcacd.cost_element_id		= 1 -- material costs
and	cic.organization_id             = rt.organization_id
and	cic.inventory_item_id           = mmt.inventory_item_id
-- End revision for version 1.4
and	mmt.rcv_transaction_id          = rt.transaction_id
and	he.employee_id (+)              = msiv.buyer_id -- Need the outer join in employee id, not always defined
and	rt.po_header_id                 = poh.po_header_id
and	rt.po_line_id                   = pol.po_line_id
and	rt.po_line_location_id          = pll.line_location_id
and	poh.po_header_id                = pol.po_header_id  
and	pll.po_release_id               = pr.po_release_id (+)
and	mp.organization_id              = rt.organization_id
-- Revision for version 1.4
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.4
-- Revision for version 1.2
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                 = msiv.planning_make_buy_code
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = hoi.org_information3   -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                             -- p_trx_date_from, p_trx_date_to, p_cost_type, p_item_number, p_org_code, p_operating_unit, p_ledger
-- Order by Ledger, Operating Unit, Org Code, Item, Transaction Date, PO Number, PO line and Release
order by
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	msiv.concatenated_segments,
	mmt.transaction_date,
	pv.vendor_name,
	poh.segment1,
	pol.line_num,
	pr.release_num