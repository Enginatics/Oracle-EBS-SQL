/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Open Purchase Orders
-- Description: Report to show open purchase orders and related information.  This report will convert any foreign currency purchases into the currency of the general ledger.  The currency defaults from the inventory organization for this session.  Use the To and From Transaction Date parameters to create an average receipt cost and use the Cost Type parameter to show a comparison amounts from another cost type.

/* +=============================================================================+
-- | Copyright 2020 - 2022 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  open_po_rept.sql
-- |
-- |  Parameters:
-- |  p_comparison_cost_type    -- set of costs to compare against the purchase order unit prices.
-- |  p_transaction_date_from     -- starting transaction date for averaging the purchase order receipts.
-- |  p_transaction_date_to       -- ending transaction date for averaging the purchase order receipts.
-- |  p_vendor_name            -- Vendor you want to report (optional)
-- |  p_item_number            -- part or item number you want to report (optional)
-- |  p_org_code               -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit         -- Operating Unit you wish to report, leave blank for all
-- |                              operating units (optional) 
-- |  p_ledger                 -- ledger parameter, optional
-- |
-- |  Description:
-- |  Report for open purchase orders for external inventory purchases and 
-- |  external outside processing purchases.
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     09 Sep 2020 Douglas Volz   Initial Coding based on Purchase Price 
-- |                                     variance report, xxx_ppv_lot_rept.sql
-- |  1.1     10 Sep 2020 Douglas Volz   Added inspection flag.
-- |  1.2     01 Dec 2020 Douglas Volz   Added variance and charge accounts
-- |  1.3     20 Dec 2020 Douglas Volz   Added promise date, Need By Date, project,
-- |                                     Expected Receipt Date, Target Price (PO List Price),
-- |                                     Customer Name and difference columns.
-- |                                     And added Minimum Cost Difference parameter.
-- |  1.4     03 Feb 2020 Douglas Volz   Merged OSP union with stock purchase orders.
-- |  1.5     05 Feb 2021 Douglas Volz   Added PO averages and item cost information.
-- |  1.6     07 Jul 2022 Douglas Volz   Add multi-language item status.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-open-purchase-orders/
-- Library Link: https://www.enginatics.com/reports/cac-open-purchase-orders/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	pov.vendor_name Supplier,
	hr.full_name Buyer,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	fcl.meaning Item_Type,
	-- Revision for version 1.6
	misv.inventory_item_status_code Item_Status,
&category_columns
	pl1.displayed_field PO_Destination_Type,
	--we.wip_entity_name WIP_Job,
	cic.resource_code OSP_Resource,
	pl.vendor_product_num Supplier_Item,
	round(msiv.list_price_per_unit,5) Target_or_List_Price,
	ph.segment1 PO_Number,
        to_char(pl.line_num)  PO_Line,
	nvl(pl4.displayed_field,nvl(pl3.displayed_field, pl2.displayed_field))  PO_Line_Status,
	pp.segment1 Project_Number,
	pp.name Project_Name,
	pll.creation_date Creation_Date,
	-- Revision for version 1.2
	pll.promised_date Promise_Date,
	pll.need_by_date Need_by_Date,
	to_char(pr.release_num) PO_Release,
	pr.release_date Release_Date,
	(select	max(ms.expected_delivery_date)
	 from	mtl_supply ms
	 where	ms.supply_type_code in ('PO','RECEIVING','SHIPMENT')
	 and	ms.item_id                      = msiv.inventory_item_id
	 and	ms.to_organization_id           = msiv.organization_id
	 and	ms.destination_type_code        in ('INVENTORY','SHOP FLOOR')
	 and	ms.po_distribution_id           = pod.po_distribution_id
	) Expected_Receipt_Date,
	-- Revision for version 1.1
	fcl.meaning Inspection_Required,
	muomv_po.uom_code PO_UOM,
	nvl(ph.currency_code, gl.currency_code) PO_Currency_Code,
	nvl(pll.price_override, pl.unit_price) PO_Unit_Price,
	decode(pll.match_option, 
		'P', trunc(nvl(pod.rate_date, pll.creation_date)),
		'R', trunc(nvl(gdr_po.conversion_date, sysdate)),
		trunc(nvl(gdr_po.conversion_date, sysdate))) Currency_Rate_Date,
	round(decode(pll.match_option, 
		'P', nvl(pod.rate,1),
		'R', gdr_po.conversion_rate,
		gdr_po.conversion_rate),6) PO_Exchange_Rate,
	gl.currency_code GL_Currency_Code,
	round(decode(pll.match_option, 
		'P', nvl(pod.rate,1),
		'R', gdr_po.conversion_rate,
		gdr_po.conversion_rate) * nvl(pll.price_override, pl.unit_price),6) Converted_PO_Unit_Price,
	ucr.conversion_rate PO_UOM_Conversion_Rate,
	round(decode(pll.match_option, 
		'P', nvl(pod.rate,1),
		'R', gdr_po.conversion_rate,
		gdr_po.conversion_rate) * nvl(pll.price_override, pl.unit_price) * ucr.conversion_rate,6) Converted_PO_at_Primary_UOM,
	-- Revision for version 1.4
	muomv_msi.uom_code UOM_Code,
	round(nvl(cic.unburdened_cost,0),5) Unburdened_Unit_Cost,
	-- Revision for version 1.20
	-- PO Price - Unburdened Cost = Unit_Cost_Difference
	round((decode(pll.match_option, 
		'P', nvl(pod.rate,1),
		'R', gdr_po.conversion_rate,
		gdr_po.conversion_rate) * 
		nvl(pll.price_override, pl.unit_price)) - nvl(cic.unburdened_cost,0),5) Unit_Cost_Difference,
	-- Revision for version 1.20
	-- (PO Price - Unburdened Cost) * nvl(pll.quantity,0) = Extended_Cost_Difference
	round(((decode(pll.match_option, 
		'P', nvl(pod.rate,1),
		'R', gdr_po.conversion_rate,
		gdr_po.conversion_rate) * 
		nvl(pll.price_override, pl.unit_price)) - nvl(cic.unburdened_cost,0)) * nvl(pll.quantity,0),2) Extended_Cost_Difference,
	-- Calculate the Percent Difference
	--   when difference = 0 then 0
	--   when item cost = 0 then 100%
	--   when PO unit price = 0 then -100%
	--   else PO Price - item cost / item cost
	case
	   when	round((decode(pll.match_option, 
		'P', nvl(pod.rate,1),
		'R', gdr_po.conversion_rate,
		gdr_po.conversion_rate) * 
		nvl(pll.price_override, pl.unit_price)) - nvl(cic.unburdened_cost,0),5) = 0
		then 0
	   when round(nvl(cic.unburdened_cost,0),5) = 0
		then 100
	   when round(decode(pll.match_option, 
			'P', nvl(pod.rate,1), 
			'R', gdr_po.conversion_rate,
			gdr_po.conversion_rate
			    ) * nvl(pll.price_override, pl.unit_price),5) = 0
		then -100
	   else 
		round(((decode(pll.match_option, 
			'P', nvl(pod.rate,1),
			'R', gdr_po.conversion_rate,
			gdr_po.conversion_rate) * 
			nvl(pll.price_override, pl.unit_price)) - nvl(cic.unburdened_cost,0)) /
		nvl(cic.unburdened_cost,0) * 100,2)
	end Percent_Difference,
	-- End revision for version 1.20
	cct_curr.cost_type Current_Cost_Type,
	-- Revision for version 1.5
	round(cic.material_cost,5)           Material_Cost,
	round(cic.material_overhead_cost,5)  Material_Overhead_Cost,
	round(cic.resource_cost,5)           Resource_Cost,
	round(cic.outside_processing_cost,5) Outside_Processing_Cost,
	round(cic.overhead_cost,5)           Overhead_Cost,
	round(cic.item_cost,5)               Current_Item_Cost,
	-- Revision for version 1.5
	(select	round(cic.material_cost,5) - round(cic.tl_material_overhead,5)
	 from	cst_item_costs cic,
		cst_cost_types cct,
		mtl_parameters mp		
	 where	cic.inventory_item_id = msiv.inventory_item_id
	 and	cic.organization_id   = msiv.organization_id
	 and	cic.cost_type_id      = cct.cost_type_id
	 and	mp.organization_id    = cic.organization_id
	 and 6=6                   -- p_org_code
	 and 10=10                 -- p_cost_type
	) Comparison_Material_Cost,
	receipts.receipt_qty Average_Receipt_Quantity,
	receipts.receipt_amount Average_Receipt_Amount,
	receipts.avg_receipt_cost Average_Receipt_Cost,
	-- End revision for version 1.5
	pll.quantity Quantity_Ordered,
	pll.quantity_received Quantity_Received,
	pll.quantity_billed Quantity_Invoiced,
	round(nvl(pod.rate,1) * pll.price_override * (pll.quantity * ucr.conversion_rate),2) Total_PO_Amount,
	-- Revision for version 1.1
	&segment_columns
	pl.creation_date PO_Line_Creation_Date
from	po_vendors                  pov,
	wip_entities                we,
	po_headers_all              ph,
	po_lines_all                pl,
	po_line_locations_all       pll,
	po_releases_all             pr,
	po_distributions_all        pod,
	mtl_system_items_vl         msiv,
	-- Revision for version 1.5
	cst_cost_types              cct_curr,
	mtl_uom_conversions_view    ucr,
	-- Revision for version 1.4
	mtl_units_of_measure_vl     muomv_msi,
	mtl_units_of_measure_vl     muomv_po,
	pa_projects_all             pp,
	-- End revision for version 1.4
	-- Revision for version 1.6
	mtl_item_status_vl          misv,
	-- Revision for version 1.4
	(select crc.organization_id,
		msiv.inventory_item_id purchase_item_id,
		br.resource_code,
		br.resource_id,
		crc.cost_type_id,
		0 material_cost,
		0 material_overhead_cost,
		0 resource_cost,
		nvl(crc.resource_rate,0) outside_processing_cost,
		0 overhead_cost,
		nvl(crc.resource_rate,0) item_cost,
		nvl(crc.resource_rate,0) unburdened_cost
	 from	cst_resource_costs  crc,
		bom_resources       br,
		mtl_system_items_vl msiv,
		mtl_parameters      mp
	 where  crc.cost_type_id      = mp.primary_cost_method
	 and    crc.resource_id       = br.resource_id
	 and    crc.organization_id   = mp.organization_id
	 and    br.purchase_item_id   = msiv.inventory_item_id
	 and    br.organization_id    = msiv.organization_id
	 and	br.cost_element_id    = 4 -- OSP cost element
	 and	mp.organization_id    = msiv.organization_id
	 and	msiv.item_type        = 'OP'
	 and	6=6                  -- p_org_code
	 and	7=7                  -- p_item_number
	 union
	 select	cic.organization_id,
		cic.inventory_item_id purchase_item_id,
		null resource_code,
		-999 resource_id,
		cic.cost_type_id,
		cic.material_cost,
		cic.material_overhead_cost,
		cic.resource_cost,
		cic.outside_processing_cost,
		cic.overhead_cost,
		cic.item_cost,
		cic.unburdened_cost
	 from	cst_item_costs cic,
		mtl_system_items_vl msiv,
		mtl_parameters mp
	 where	cic.organization_id   = mp.organization_id
	 and	cic.organization_id   = msiv.organization_id
	 and	cic.inventory_item_id = msiv.inventory_item_id
	 and	cic.cost_type_id      = mp.primary_cost_method
	 and	6=6                  -- p_org_code
	 and	7=7                  -- p_item_number
	) cic, -- item costs
	-- End revision for version 1.4
	-- Revision for version 1.5
	-- ===========================================================================
	-- Get the average PO receipt cost over a date range
	-- ===========================================================================
	(select	mp.organization_id,
		mmt.inventory_item_id,
		sum(mmt.primary_quantity) receipt_qty,
		round(sum(nvl(mmt.transaction_cost,0) * mmt.primary_quantity),2)  receipt_amount,
		round(sum(nvl(mmt.transaction_cost,0) * mmt.primary_quantity) /
			decode(sum(mmt.primary_quantity),
					0,1,
					sum(mmt.primary_quantity)),5) avg_receipt_cost
	 from	mtl_material_transactions mmt,
		mtl_system_items_vl msiv,
		mtl_parameters mp
	 where 	mmt.inventory_item_id 	 	= msiv.inventory_item_id
	 and	mmt.organization_id	 	= msiv.organization_id
	 and	11=11                           -- p_trx_date_from, p_trx_date_to
	 and	mmt.transaction_source_type_id	= 1 -- purchase orders
	 and	6=6                  -- p_org_code
	 and	7=7                  -- p_item_number
	 and	mmt.organization_id             = mp.organization_id
	 and	nvl(mmt.transaction_cost,0)    <> 0
	 and	msiv.inventory_asset_flag       = 'Y'
	 group by
		mp.organization_id,
		mmt.inventory_item_id
	) receipts,
	-- ===========================================================================
	-- Get a set of currency rates to translate the PO Price into the G/L Currency
	-- ===========================================================================
	(select	gdr1.from_currency,
		gdr1.to_currency,
		gdct1.user_conversion_type,
		gdr1.conversion_date,
		gdr1.conversion_rate
	 from	gl_daily_rates gdr1,
		gl_daily_conversion_types gdct1
	 where	exists (
			select 'x'
			from	mtl_parameters mp,
				hr_organization_information hoi,
				hr_all_organization_units_vl haou,
				hr_all_organization_units_vl haou2,
				gl_ledgers gl
			-- =================================================
			-- Get inventory ledger and operating unit information
			-- =================================================
			where	hoi.org_information_context   = 'Accounting Information'
			and	hoi.organization_id           = mp.organization_id
			and	hoi.organization_id           = haou.organization_id            -- this gets the organization name
			and	haou2.organization_id         = to_number(hoi.org_information3) -- this gets the operating unit id
			and	gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
			and	gdr1.to_currency              = gl.currency_code
			-- Do not report the master inventory organization
			and	mp.organization_id           <> mp.master_organization_id
			   )
	 and	gdr1.conversion_type       = gdct1.conversion_type
	 and	4=4                        -- p_curr_conv_date1
	 and	5=5                        -- p_curr_conv_type1
	 union all
	 select	gl.currency_code,              -- from_currency
		gl.currency_code,              -- to_currency
		gdct1.user_conversion_type,    -- user_conversion_type
		:p_curr_conv_date1,            -- conversion_date                                              -- p_curr_conv_date1
		1                              -- conversion_rate
	 from	gl_ledgers gl,
		gl_daily_conversion_types gdct1
	 where	5=5    -- user_conversion_type
	 group by
		gl.currency_code,
		gl.currency_code,
		gdct1.user_conversion_type,                                                                  -- p_curr_conv_date1
		:p_curr_conv_date1,           -- conversion_date                                             -- p_curr_conv_date1
		1
	) gdr_po, -- NEW Currency Rates
	-- End revision for version 1.5
	-- ===========================================================================
	-- Select current Currency Rates based on the currency conversion date
	-- ===========================================================================
	(select	gdr1.from_currency,
		gdr1.to_currency,
		gdct1.user_conversion_type,
		gdr1.conversion_date,
		gdr1.conversion_rate
	 from	gl_daily_rates gdr1,
		gl_daily_conversion_types gdct1
	 where	exists (
			select 'x'
			from	mtl_parameters mp,
				hr_organization_information hoi,
				hr_all_organization_units_vl haou,
				hr_all_organization_units_vl haou2,
				gl_ledgers gl
			-- =================================================
			-- Get inventory ledger and operating unit information
			-- =================================================
			where	hoi.org_information_context   = 'Accounting Information'
			and	hoi.organization_id           = mp.organization_id
			and	hoi.organization_id           = haou.organization_id            -- this gets the organization name
			and	haou2.organization_id         = to_number(hoi.org_information3) -- this gets the operating unit id
			and	gl.ledger_id                  = to_number(hoi.org_information1) -- get the ledger_id
			and	gdr1.to_currency              = gl.currency_code
			-- Do not report the master inventory organization
			and	mp.organization_id           <> mp.master_organization_id
			   )
	 and	gdr1.conversion_type       = gdct1.conversion_type
	 and	4=4                        -- p_curr_conv_date1
	 and	5=5                        -- p_curr_conv_type1
	 union all
	 select	gl.currency_code,              -- from_currency
		gl.currency_code,              -- to_currency
		gdct1.user_conversion_type,    -- user_conversion_type
		:p_curr_conv_date1,            -- conversion_date                                              -- p_curr_conv_date1
		1                              -- conversion_rate
	 from	gl_ledgers gl,
		gl_daily_conversion_types gdct1
	 where	5=5    -- user_conversion_type
	 group by
		gl.currency_code,
		gl.currency_code,
		gdct1.user_conversion_type,                                                                  -- p_curr_conv_date1
		:p_curr_conv_date1,           -- conversion_date                                             -- p_curr_conv_date1
		1
	) gdr1, -- Current Currency Rates
	-- End for revision 1.20
	mtl_parameters              mp, 
	hr_employees                hr,
	fnd_common_lookups          fcl,
	-- Revision for version 1.1
	fnd_common_lookups          fcl2,
	po_lookup_codes             pl1,  -- Destination_Type
	po_lookup_codes             pl2,  -- Header
	po_lookup_codes             pl3,  -- Line
	po_lookup_codes             pl4,  -- Line location
	hr_organization_information hoi,
	hr_all_organization_units   haou, -- inv_organization_id
	hr_all_organization_units   haou2, -- operating unit
	gl_ledgers                  gl,
	gl_code_combinations        gcc1,
	gl_code_combinations        gcc2,
	gl_code_combinations        gcc3
-- ========================================================
-- Organization, resource, item, costs and PO joins
-- ========================================================
where	msiv.inventory_item_id          = pl.item_id
and	msiv.organization_id            = pll.ship_to_organization_id
and	ucr.inventory_item_id           = msiv.inventory_item_id
and	ucr.organization_id             = msiv.organization_id
and	ucr.unit_of_measure             = pl.unit_meas_lookup_code
-- Revision for version 1.6
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- Revision for version 1.4
and	msiv.primary_uom_code           = muomv_msi.uom_code
and	ucr.uom_code                    = muomv_po.uom_code
and	mp.organization_id              = msiv.organization_id
-- Revision for version 1.5
and	cct_curr.cost_type_id           = mp.primary_cost_method
and	nvl(cic.resource_id,-999)       = nvl(pod.bom_resource_id,-999)
and	we.wip_entity_id (+)            = pod.wip_entity_id
and	ph.po_header_id                 = pl.po_header_id
and	pl.po_line_id                   = pll.po_line_id
and	pll.po_release_id               = pr.po_release_id (+)
and	pod.line_location_id            = pll.line_location_id
and	pod.destination_type_code in ('SHOP FLOOR', 'INVENTORY')
and	pp.project_id (+)               = pod.project_id
and	pov.vendor_id                   = ph.vendor_id
and	ph.agent_id                     = hr.employee_id
and	ph.closed_date is null
and	pl.closed_date is null
and	pll.closed_date is null
and	cic.organization_id             = msiv.organization_id (+)
and	cic.purchase_item_id            = msiv.inventory_item_id (+)
-- ========================================================
-- Lookup values to see more detail
-- ========================================================
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
and	fcl.lookup_code (+)             = msiv.item_type
-- Revision for version 1.1
and	fcl2.lookup_type (+)            = 'YES_NO'
and	fcl2.lookup_code (+)            = pll.inspection_required_flag
and	pl1.lookup_type                 = 'DESTINATION TYPE'
and	pl1.lookup_code                 = pod.destination_type_code
and	pl2.lookup_type (+)             = 'DOCUMENT STATE'
and	pl2.lookup_code (+)             = ph.closed_code
and	pl3.lookup_type (+)             = 'DOCUMENT STATE'
and	pl3.lookup_code (+)             = pl.closed_code
and	pl4.lookup_type (+)             = 'DOCUMENT STATE'
and	pl4.lookup_code (+)             = pll.closed_code
-- ===================================================================
-- Joins for the currency exchange rates
-- ===================================================================
and	gdr1.from_currency              = nvl(ph.currency_code, gl.currency_code)
and	9=9                             -- p_to_currency_code
-- Revision for version 1.5
and	gdr_po.from_currency            = nvl(ph.currency_code, gl.currency_code)
and	gdr_po.to_currency              = gl.currency_code
and	receipts.organization_id (+)    = cic.organization_id
and	receipts.inventory_item_id (+)  = cic.purchase_item_id
-- End revision for version 1.5
-- ========================================================
-- using the base tables instead of org_organization_definitions
-- and hr_operating_units
-- ========================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and	1=1 -- p_creation_date_from, p_creation_date_to, p_operating_unit, p_ledger
and	7=7                             -- p_item_number
and	8=8                             -- p_vendor_name
-- ========================================================
-- Accounting information
-- ========================================================
and	gcc1.code_combination_id (+)    = pod.code_combination_id
and	gcc2.code_combination_id (+)    = pod.variance_account_id
and	gcc3.code_combination_id (+)    = pod.accrual_account_id