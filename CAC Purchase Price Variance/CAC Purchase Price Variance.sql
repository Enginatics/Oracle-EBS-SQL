/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Purchase Price Variance
-- Description: Report for Purchase Price Variance accounting entries for external inventory purchases, external outside processing purchases, (internal) intransit shipments, (internal) direct organization transfers and transfer to regular (consignment) transactions.  The FOB point indicates when title passes to the receiving organization and it also determines which internal transfer transaction gets the PPV.  With FOB Shipment PPV happens on the Intransit Shipment transaction.  With FOB Receipt PPV happens on the Intransit Receipt transaction.

/* +=============================================================================+
-- | Copyright 2010-21 Douglas Volz Consulting, Inc.                             |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_ppv_lot_rept.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from    -- starting transaction date for ppv related transactions
-- |  p_trx_date_to      -- ending transaction date for ppv related transactions
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category_Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category_Set
-- |  p_item_number      -- Enter the specific item number you wish to report (optional)
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating_Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     26 Jan 2010 Douglas Volz   Initial Coding   
-- |  1.16    30 Dec 2020 Douglas Volz   Revise calculations for Percent Difference, to:
-- |                                       when difference = 0 then 0
-- |                                       when standard = 0 then 100%
-- |                                       when PO unit price = 0 then -100%
-- |                                       else PO - std / std
-- |                                     Performance improvements for Sections 3 and 4.
-- |  1.17    01 Jan 2021 Douglas Volz   Added Section 5 PPV for Transfer to Regular transactions.
-- |  1.18    08 Jan 2021 Douglas Volz   Removed redundant joins and tables to improve performance.
-- |  1.19    14 Dec 2021 Douglas Volz   Bug fix, Section I and V were both picking up
-- |                                     Transfer to Regular PPV transactions
-- |  1.20    21 Jun 2022 Douglas Volz   Add PO Line and PO Shipment Line Creation Date.
+=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-purchase-price-variance/
-- Library Link: https://www.enginatics.com/reports/cac-purchase-price-variance/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
-- =============================================================
-- Section I
-- Get the Deliveries from Receiving Inspection to Stores
-- inventory for purchase order receipt transactions
-- Revision for version 1.11 and 1.15, correct PPV calculation 
-- for Material Overhead, need the standard item cost to be net
-- of this level material overhead.
-- =============================================================
	haou2.name Operating_Unit,
	mp.organization_code Ship_To_Org,
	'' Ship_From_Org,
	oap.period_name Period_Name,
	&segment_columns
	pov.vendor_name Supplier,
	he.full_name Buyer,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.14
	fcl.meaning Item_Type,
	misv.inventory_item_status_code_tl Item_Status,
	ml2.meaning Make_Buy_Code,
	-- End Revision for version 1.14
	-- Revision for version 1.12
&category_columns
	-- End revision for version 1.12
	-- Fix for version 1.9
	'' WIP_Job,
	'' OSP_Resource,
	-- End fix for version 1.9
	ph.segment1 PR_or_PO_Number,
	to_char(pl.line_num)  Line_Number,
	-- Revision for version 1.20
	pl.creation_date Line_Creation_Date,
	to_char(pr.release_num) PO_Release,
	rsh.receipt_num Receipt_Number,
	rsh.shipment_num Shipment_Number,
	-- Revision for version 1.20
	pll.creation_date Shipment_Creation_Date,
	ml.meaning Accounting_Line_Type,
	mtt.transaction_type_name Transaction_Type,
	mmt.transaction_id Transaction_Id,
	trunc(mmt.transaction_date) Transaction_Date,
	mtln.lot_number Lot_Number,
	-- Revision for version 1.14
	muomv.uom_code UOM_Code,
	decode(mtln.lot_number, null, mmt.primary_quantity, mtln.primary_quantity) Received_Quantity,
	nvl(ph.currency_code, gl.currency_code) PO_Currency_Code,
	round(nvl(mmt.transaction_cost,0) / decode(nvl(mta.currency_conversion_rate,1),0,1,nvl(mta.currency_conversion_rate,1)),5) PO_Unit_Price,
	nvl(mta.currency_conversion_rate,1) PO_Exchange_Rate,
	gl.currency_code GL_Currency_Code,
	round(nvl(mmt.transaction_cost,0),5) Converted_PO_Unit_Price,
	-- Revision for version 1.15, use only the PPV row for these calculations
	-- mmt.transaction_cost is the total cost of the transaction, at standard
	-- mta.rate_of_amount is the unit PPV amount
	-- If PPV is positive, standard_unit_cost = mmt.transaction_cost - mta.rate_or_amount
	-- if PPV is negative, standard_unit_cost = mmt.transaction_cost + mta.rate_or_amount
	-- round(nvl(mta.rate_or_amount,0),8) Unit_Cost_Difference,
	round(decode(sign(mta.base_transaction_value),
				 1, nvl(mmt.transaction_cost,0) - nvl(mta.rate_or_amount,0),
				-1, nvl(mmt.transaction_cost,0) + nvl(mta.rate_or_amount,0)
		    )
	   ,8) Standard_Unit_Cost,
	round(decode(sign(mta.base_transaction_value),
				 1, nvl(mta.rate_or_amount,0),
				-1, -1 * nvl(mta.rate_or_amount,0)
		    )
	   ,8) Unit_Cost_Difference,
	-- End revision for version 1.15
	round(nvl(mmt.transaction_cost,0) * decode(mtln.lot_number, null, mmt.primary_quantity, mtln.primary_quantity),2) Total_Purchase_Amount,
	-- Revision for version 1.15, remove this level material overheads using the same PPV accounting entry
	round(decode(sign(mta.base_transaction_value),
				 1, nvl(mmt.transaction_cost,0) - nvl(mta.rate_or_amount,0),
				-1, nvl(mmt.transaction_cost,0) + nvl(mta.rate_or_amount,0)
		    ) *
		decode(mtln.lot_number, null, mmt.primary_quantity, mtln.primary_quantity),2) Total_Standard_Amount,
	-- PPV_Amount
	(round(nvl(mmt.transaction_cost,0) * decode(mtln.lot_number, null, mmt.primary_quantity, mtln.primary_quantity),2)) -    -- PO Amount
	-- Revision for version 1.15, remove this level material overheads using the same PPV accounting entry
		(round(decode(sign(mta.base_transaction_value),
				 1, nvl(mmt.transaction_cost,0) - nvl(mta.rate_or_amount,0),
				-1, nvl(mmt.transaction_cost,0) + nvl(mta.rate_or_amount,0)
			     ) *
	   -- End of revision for version 1.15
			decode(mtln.lot_number, null, mmt.primary_quantity, mtln.primary_quantity),2))      -- Standard Amount
	PPV_Amount,
	-- Revision for version 1.16, calculate the percentage
	-- case
	--   when difference = 0 then 0
	--   when standard = 0 then 100%
	--   when PO unit price = 0 then -100%
	--   else PO - std / std
	round(case
	   --   when difference = 0 then 0
	   when	round(decode(sign(mta.base_transaction_value),
				-1, -1 * nvl(mta.rate_or_amount,0),
				 1, nvl(mta.rate_or_amount,0)
			    )
		   ,8) = 0 then 0
	   -- when standard = 0 then 100%
	   when round(decode(sign(mta.base_transaction_value),
				 1, nvl(mmt.transaction_cost,0) - nvl(mta.rate_or_amount,0),
				-1, nvl(mmt.transaction_cost,0) + nvl(mta.rate_or_amount,0)
			    )
		   ,8) = 0 then 100
	   -- when PO unit price = 0 then -100%
	   when round(nvl(mmt.transaction_cost,0),5) = 0 then -100
	   -- else PO - std / std
	   else	round(decode(sign(mta.base_transaction_value),
				-1, -1 * nvl(mta.rate_or_amount,0),
				 1, nvl(mta.rate_or_amount,0)
			    )
		   ,8) / decode(
				 round(decode(sign(mta.base_transaction_value),
					 1, nvl(mmt.transaction_cost,0) - nvl(mta.rate_or_amount,0),
					-1, nvl(mmt.transaction_cost,0) + nvl(mta.rate_or_amount,0)
					     )
				    ,8),0,1,
				 round(decode(sign(mta.base_transaction_value),
					 1, nvl(mmt.transaction_cost,0) - nvl(mta.rate_or_amount,0),
					-1, nvl(mmt.transaction_cost,0) + nvl(mta.rate_or_amount,0)
					     )
				    ,8)
				) * 100
	end,2) Percent_Difference
from	mtl_transaction_accounts mta,
	mtl_material_transactions mmt,
	mtl_transaction_lot_numbers mtln,
	mtl_transaction_types mtt,
	rcv_transactions rt,
	rcv_shipment_headers rsh,
	po_vendors pov,
	po_headers_all ph,
	po_lines_all pl,
	po_releases_all pr,
	po_line_locations_all pll,
	po_distributions_all pod,
	mtl_system_items_vl msiv,
	-- Revision for version 1.8
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	-- End revision for version 1.8
	org_acct_periods oap,
	gl_code_combinations_kfv gcc,
	mtl_parameters mp, 
	hr_employees he,
	fnd_common_lookups fcl, -- item type
	mfg_lookups ml, -- accounting line type
	mfg_lookups ml2, -- planning make/buy code
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl,
	-- Revision for version 1.18, remove tables to increase performance
	-- xla.xla_transaction_entities ent,  -- apps synonym not working
	-- xla_events xe,
	-- End revision for version 1.18
	xla_distribution_links xdl,
	xla_ae_headers ah,
	xla_ae_lines al
-- ========================================================
-- Material transaction, receiving and item joins
-- ========================================================
where	mta.transaction_id              = mmt.transaction_id
and	mmt.transaction_id              = mtln.transaction_id (+)
and	mmt.transaction_type_id   	= mtt.transaction_type_id
and	rt.transaction_id               = mmt.rcv_transaction_id
and	mta.organization_id             = msiv.organization_id
and	mta.inventory_item_id           = msiv.inventory_item_id
and	mp.organization_id              = msiv.organization_id
-- Revision for version 1.14
and	msiv.primary_uom_code           = muomv.uom_code
and	misv.inventory_item_status_code = msiv.inventory_item_status_code
-- End revision for version 1.14
and	mta.accounting_line_type        = 6
and	mmt.transaction_source_type_id  = 1
-- Revision for version 1.18, performance improvements
and	mta.transaction_source_type_id  = 1
-- Revision for version 1.19
and	mmt.transaction_type_id        <> 74
-- ========================================================
-- Purchase Order Joins
-- ========================================================
-- Revision for version 1.18, performance improvements
-- and	ph.po_header_id                 = pl.po_header_id
and	pod.destination_type_code       = 'INVENTORY'
and	pod.po_distribution_id          = rt.po_distribution_id
and	rsh.shipment_header_id          = rt.shipment_header_id
and	pod.line_location_id            = pll.line_location_id
and	pl.po_line_id                   = pll.po_line_id
and	pll.po_release_id               = pr.po_release_id (+)
-- Revision for version 1.18, performance improvements
-- and	pl.item_id                      = msiv.inventory_item_id
-- and	rt.po_header_id                 = ph.po_header_id
-- End revision for version 1.14
and	mmt.transaction_source_id       = ph.po_header_id
and	rt.po_line_id                   = pl.po_line_id
and	pov.vendor_id                   = ph.vendor_id
and	ph.agent_id                     = he.employee_id
-- ========================================================
-- Inventory Org accounting period joins
-- ========================================================
and	oap.period_name                 = ah.period_name
and	oap.organization_id             = mta.organization_id
-- ========================================================
-- Version 1.3, 1.14 added lookup values to see more detail
-- ========================================================
and	ml.lookup_type                  = 'CST_ACCOUNTING_LINE_TYPE'
and	ml.lookup_code                  = mta.accounting_line_type
and	ml2.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml2.lookup_code                 = msiv.planning_make_buy_code
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
and	fcl.lookup_code (+)             = msiv.item_type
-- ========================================================
-- Material Transaction date, operating unit and ledger joins
-- ========================================================
and	4=4                             -- p_trx_date_from, p_trx_date_to
-- ========================================================
-- HR organizations, operating unit and ledger joins
-- ========================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mta.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                             -- p_item_number, p_org_code, operating_unit, p_ledger
-- ========================================================
-- SLA table joins to get the exact account numbers
-- ========================================================
-- Revision for version 1.18, performance improvements
-- and	ent.entity_code                 = 'MTL_ACCOUNTING_EVENTS'
-- and	ent.application_id              = 707
-- and	xe.application_id               = ent.application_id
-- and	xe.event_id                     = xdl.event_id
-- and	ah.entity_id                    = ent.entity_id
-- and	ah.ledger_id                    = ent.ledger_id
-- and	ah.event_id                     = xe.event_id
-- and	al.application_id               = ent.application_id
and	ah.ledger_id                    = gl.ledger_id
-- End revisions for version 1.18
and	ah.application_id               = al.application_id
and	ah.application_id               = 707
and	ah.ae_header_id                 = al.ae_header_id
and	al.ledger_id                    = ah.ledger_id
and	al.ae_header_id                 = xdl.ae_header_id
and	al.ae_line_num                  = xdl.ae_line_num
and	xdl.application_id              = 707
and	xdl.source_distribution_type    = 'MTL_TRANSACTION_ACCOUNTS'
and	mta.inv_sub_ledger_id           = xdl.source_distribution_id_num_1
and	gcc.code_combination_id (+)     = al.code_combination_id
union all
-- =============================================================
-- Section II - WIP PPV Entries
-- =============================================================
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Ship_To_Org,
	'' Ship_From_Org,
	oap.period_name Period_Name,
	&segment_columns
	pov.vendor_name Supplier,
	he.full_name Buyer,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.14
	fcl.meaning Item_Type,
	misv.inventory_item_status_code_tl Item_Status,
	ml2.meaning Make_Buy_Code,
	-- End Revision for version 1.14
	-- Revision for version 1.12
&category_columns
	-- End revision for version 1.12
	we.wip_entity_name WIP_Job,
	br.resource_code OSP_Resource,
	ph.segment1 PR_or_PO_Number,
	to_char(pl.line_num)  Line_Number,
	-- Revision for version 1.20
	pl.creation_date Line_Creation_Date,
	to_char(pr.release_num) PO_Release,
	rsh.receipt_num Receipt_Number,
	rsh.shipment_num Shipment_Number,
	-- Revision for version 1.20
	pll.creation_date Shipment_Creation_Date,
	ml.meaning Accounting_Line_Type,
	ml3.meaning Transaction_Type,
	wt.transaction_id Transaction_Id,
	trunc(wt.transaction_date) Transaction_Date,
	null Lot_Number,
	decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', muomv.uom_code,
		'RESOURCE',  br.unit_of_measure) UOM_Code,
	round(decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', rt.primary_quantity,
		'RESOURCE',  rt.primary_quantity * wt.usage_rate_or_amount),3) Received_Quantity,
	nvl(wta.currency_code, gl.currency_code) PO_Currency_Code,
	round(decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', wt.usage_rate_or_amount * wt.actual_resource_rate,
		'RESOURCE', wt.usage_rate_or_amount * wt.actual_resource_rate),5) PO_Unit_Price,
	nvl(wta.currency_conversion_rate,1) PO_Exchange_Rate, 
	gl.currency_code GL_Currency_Code,
	round(decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', wt.usage_rate_or_amount * wt.actual_resource_rate,
		'RESOURCE', wt.usage_rate_or_amount * wt.actual_resource_rate),5) * -- PO_Unit_Price X exchange rate
		nvl(wta.currency_conversion_rate,1) Converted_PO_Unit_Price,
	round(decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', wt.standard_resource_rate * wt.usage_rate_or_amount,
		'RESOURCE', wt.standard_resource_rate * wt.usage_rate_or_amount),5) Standard_Unit_Cost,
	round(decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', wt.usage_rate_or_amount * wt.actual_resource_rate,
		'RESOURCE', wt.usage_rate_or_amount * wt.actual_resource_rate),5) * -- PO_Unit_Price X exchange rate
		nvl(wta.currency_conversion_rate,1) - 
		  round((decode(msiv.outside_operation_uom_type, 
			'ASSEMBLY', wt.standard_resource_rate * wt.usage_rate_or_amount,
			'RESOURCE', wt.standard_resource_rate * wt.usage_rate_or_amount)),5) Unit_Cost_Difference,
	round(round(decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', wt.usage_rate_or_amount * wt.actual_resource_rate,
		'RESOURCE', wt.usage_rate_or_amount * wt.actual_resource_rate),5) * -- PO_Unit_Price X exchange rate
		nvl(wta.currency_conversion_rate,1) * 
		  round(decode(msiv.outside_operation_uom_type, 
			'ASSEMBLY', rt.primary_quantity,
			'RESOURCE',  rt.primary_quantity * wt.usage_rate_or_amount),3),2) Total_Purchase_Amount,
	round(decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', rt.primary_quantity * wt.standard_resource_rate * wt.usage_rate_or_amount,
		'RESOURCE', rt.primary_quantity * wt.usage_rate_or_amount * 
			    wt.standard_resource_rate * wt.usage_rate_or_amount),2) Total_Standard_Amount,
	nvl(al.accounted_dr,0) - nvl(al.accounted_cr,0) PPV_Amount,
	-- Revision for version 1.16, calculate the percentage
	-- case
	--   when difference = 0 then 0
	--   when standard = 0 then 100%
	--   when PO unit price = 0 then -100%
	--   else PO - std / std
	round(case
	   --   when difference = 0 then 0
	   when	round(decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', wt.usage_rate_or_amount * wt.actual_resource_rate,
		'RESOURCE', wt.usage_rate_or_amount * wt.actual_resource_rate),5) * -- PO_Unit_Price X exchange rate
		nvl(wta.currency_conversion_rate,1) - 
		  round((decode(msiv.outside_operation_uom_type, 
			'ASSEMBLY', wt.standard_resource_rate * wt.usage_rate_or_amount,
			'RESOURCE', wt.standard_resource_rate * wt.usage_rate_or_amount)),5) = 0 then 0
	   --   when standard = 0 then 100%
	   when	round(decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', wt.usage_rate_or_amount * wt.actual_resource_rate,
		'RESOURCE', wt.usage_rate_or_amount * wt.actual_resource_rate),5) * -- PO_Unit_Price X exchange rate
		nvl(wta.currency_conversion_rate,1) = 0 then 100
	   --   when PO = 0 then -100%
	   when	round(decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', wt.usage_rate_or_amount * wt.actual_resource_rate,
		'RESOURCE', wt.usage_rate_or_amount * wt.actual_resource_rate),5) * -- PO_Unit_Price X exchange rate
		nvl(wta.currency_conversion_rate,1) - 
		  round((decode(msiv.outside_operation_uom_type, 
			'ASSEMBLY', wt.standard_resource_rate * wt.usage_rate_or_amount,
			'RESOURCE', wt.standard_resource_rate * wt.usage_rate_or_amount)),5) = 0 then -100
	   else	round(decode(msiv.outside_operation_uom_type, 
		'ASSEMBLY', wt.usage_rate_or_amount * wt.actual_resource_rate,
		'RESOURCE', wt.usage_rate_or_amount * wt.actual_resource_rate),5) * -- PO_Unit_Price X exchange rate
		nvl(wta.currency_conversion_rate,1) - 
		  round((decode(msiv.outside_operation_uom_type, 
			'ASSEMBLY', wt.standard_resource_rate * wt.usage_rate_or_amount,
			'RESOURCE', wt.standard_resource_rate * wt.usage_rate_or_amount)),5) /
		  round((decode(msiv.outside_operation_uom_type, 
			'ASSEMBLY', wt.standard_resource_rate * wt.usage_rate_or_amount,
			'RESOURCE', wt.standard_resource_rate * wt.usage_rate_or_amount)),5) * 100
	end,2) Percent_Difference
from	wip_transaction_accounts wta,
	wip_transactions wt,
	rcv_transactions rt,
	wip_accounting_classes wac,
	wip_discrete_jobs wdj,
	wip_entities we,
	bom_resources br,
	po_vendors pov,
	po_headers_all ph,
	po_lines_all pl,
	po_line_locations_all pll,
	po_releases_all pr,
	po_distributions_all pod,
	rcv_shipment_headers rsh,
	mtl_system_items_vl msiv,
	-- Revision for version 1.8
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	-- End revision for version 1.8
	org_acct_periods oap,
	gl_code_combinations_kfv gcc,
	mtl_parameters mp, 
	hr_employees he,
	fnd_common_lookups fcl, -- item type
	mfg_lookups ml, -- accounting line type
	mfg_lookups ml2, -- planning make/buy code
	mfg_lookups ml3, -- WIP short transaction type
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl,
	-- Revision for version 1.18, remove tables to increase performance
	-- xla.xla_transaction_entities ent,  -- apps synonym not working
	-- xla_events xe,
	-- End revision for version 1.18
	xla_distribution_links xdl,
	xla_ae_headers ah,
	xla_ae_lines al
-- ========================================================
-- Material Transaction, organization and item joins
-- ========================================================
where	wta.transaction_id              = wt.transaction_id
and	wta.organization_id             = wdj.organization_id
and	mp.organization_id              = msiv.organization_id
-- Revision for version 1.14
and	msiv.primary_uom_code           = muomv.uom_code
and	misv.inventory_item_status_code = msiv.inventory_item_status_code
-- End revision for version 1.14
and	rt.transaction_id               = wt.rcv_transaction_id
and	wta.accounting_line_type        = 6 -- Purchase price variance
and	wta.resource_id                 = br.resource_id 
-- Only pick up OSP resources where the standard_rate_flag is checked
-- When the standard_rate_flag is checked PPV entries are created
-- 1 = Yes, 2 = No
and	wt.standard_rate_flag           = 1
and	br.cost_element_id              = 4 -- OSP cost element
-- ========================================================
-- Purchase Order Joins
-- ========================================================
and	ph.po_header_id                 = pl.po_header_id
and	pod.destination_type_code       = 'SHOP FLOOR'
and	pod.po_distribution_id          = rt.po_distribution_id
and	rsh.shipment_header_id          = rt.shipment_header_id
and	pod.line_location_id            = pll.line_location_id
and	pl.po_line_id                   = pll.po_line_id
and	pll.po_release_id               = pr.po_release_id (+)
and	pl.item_id                      = msiv.inventory_item_id
-- Revision for version 1.18, performance improvements
-- and	wt.po_header_id                 = ph.po_header_id
-- and	wt.po_line_id                   = pl.po_line_id
-- End revision for version 1.18
and	pov.vendor_id                   = ph.vendor_id
and	ph.agent_id                     = he.employee_id
-- ========================================================
-- WIP class, entity_id and organization joins
-- ========================================================
and	wac.class_code                  = wdj.class_code
and	wdj.wip_entity_id               = wt.wip_entity_id
and	wdj.wip_entity_id               = we.wip_entity_id
and	wdj.organization_id             = wac.organization_id
-- ========================================================
-- Inventory Org accounting period joins
-- ========================================================
and	oap.acct_period_id              = wt.acct_period_id
and	oap.organization_id             = wt.organization_id
-- ========================================================
-- Version 1.3, 1.14 added lookup values to see more detail
-- ========================================================
and	ml.lookup_type                  = 'CST_ACCOUNTING_LINE_TYPE'
and	ml.lookup_code                  = wta.accounting_line_type
and	ml2.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml2.lookup_code                 = msiv.planning_make_buy_code
and	ml3.lookup_type                 = 'WIP_TRANSACTION_TYPE_SHORT'
and	ml3.lookup_code                 = wt.transaction_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
and	fcl.lookup_code (+)             = msiv.item_type
-- ========================================================
-- WIP Transaction date joins
-- ========================================================
and	wta.transaction_date          >= :p_trx_date_from    -- p_trx_date_from
and	wta.transaction_date          <  :p_trx_date_to + 1  -- p_trx_date_to
-- ========================================================
-- HR organizations, operating unit and ledger joins
-- ========================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = wta.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                             -- p_item_number, p_org_code, operating_unit, p_ledger
-- ========================================================
-- SLA table joins to get the exact account numbers
-- ========================================================
-- Revision for version 1.18, performance improvements
-- and	ent.entity_code                 = 'WIP_ACCOUNTING_EVENTS'
-- and	ent.application_id              = 707
-- and	xe.application_id               = ent.application_id
-- and	xe.event_id                     = xdl.event_id
-- and	ah.entity_id                    = ent.entity_id
-- and	ah.ledger_id                    = ent.ledger_id
-- and	ah.event_id                     = xe.event_id
-- and	al.application_id               = ent.application_id
and	ah.ledger_id                    = gl.ledger_id
-- End revisions for version 1.18
and	ah.application_id               = al.application_id
and	ah.application_id               = 707
and	ah.ae_header_id                 = al.ae_header_id
and	al.ledger_id                    = ah.ledger_id
and	al.ae_header_id                 = xdl.ae_header_id
and	al.ae_line_num                  = xdl.ae_line_num
and	xdl.application_id              = 707
and	xdl.source_distribution_type    = 'WIP_TRANSACTION_ACCOUNTS'
and	wta.wip_sub_ledger_id           = xdl.source_distribution_id_num_1
and	gcc.code_combination_id (+)     = al.code_combination_id
union all
-- =============================================================
-- Section III
-- Get the PPV from inventory transactions from the intransit
-- shipment transactions and direct shipment transactions using 
-- internal requisitions
-- =============================================================
select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Ship_To_Org,
	mp2.organization_code Ship_From_Org,
	oap.period_name Period_Name,
	&segment_columns
	'' Supplier,
	fu.user_name Buyer,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.14
	fcl.meaning Item_Type,
	misv.inventory_item_status_code_tl Item_Status,
	ml2.meaning Make_Buy_Code,
	-- End Revision for version 1.14
	-- Revision for version 1.12
&category_columns
	-- End revision for version 1.12
	-- Fix for version 1.9
	'' WIP_Job,
	'' OSP_Resource,
	-- End fix for version 1.9
	'' PR_or_PO_Number,
	''  Line_Number,
	-- Revision for version 1.20
	rsl.creation_date Line_Creation_Date,
	'' PO_Release,
	-- Revision for version 1.14
	rsh.receipt_num Receipt_Number,
	-- End revision for version 1.14
	mmt.shipment_number Shipment_Number,
	-- Revision for version 1.20
	mmt.creation_date Shipment_Creation_Date,
	ml.meaning Accounting_Line_Type,
	mtt.transaction_type_name Transaction_Type,
	mmt.transaction_id Transaction_Id,
	trunc(mmt.transaction_date) Transaction_Date,
	mtln.lot_number Lot_Number,
	-- Revision for version 1.14
	muomv.uom_code UOM_Code,
	-- ================================================================
	-- Revision for version 1.16
	-- Check by fob_point to determine the sign of the quantity
	-- ================================================================   
	decode(mmt.fob_point, 
		1, (decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity)),
		2, (decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity))
	      ) Received_Quantity,
	nvl(mta.currency_code, gl.currency_code) PO_Currency_Code,
	round((nvl(mmt.variance_amount,0)/
		decode(mmt.fob_point, 
			1, (decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity)),
			2, (decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity))
		      )
		-- Fix for version 1.8
		--  + nvl(mmt.transaction_cost,0)
		  + nvl(mmt.actual_cost,0)
		-- End fix for version 1.8
	      )
	    / nvl(mta.currency_conversion_rate,1),5)  PO_Unit_Price,
	nvl(mta.currency_conversion_rate,1) PO_Exchange_Rate,
	gl.currency_code GL_Currency_Code,
	round((nvl(mmt.variance_amount,0)/
		decode(mmt.fob_point, 
			1, (decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity)),
			2, (decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity))
		      )
		-- Fix for version 1.8
		--  + nvl(mmt.transaction_cost,0)
		  + nvl(mmt.actual_cost,0)
		-- End fix for version 1.8
	      )
	   ,5) Converted_PO_Unit_Price,
	round(nvl(mmt.actual_cost,0),5) Standard_Unit_Cost,
	round((nvl(mmt.variance_amount,0)/
		decode(mmt.fob_point, 
			1, (decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity)),
			2, (decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity))
		      )
		-- Fix for version 1.8
		--  + nvl(mmt.transaction_cost,0)
		   + nvl(mmt.actual_cost,0)
		-- End fix for version 1.8
	      )
	    -  nvl(mmt.actual_cost,0),8) Unit_Cost_Difference,
	round(nvl(mmt.variance_amount,0) + 
		-- Fix for version 1.8
		--  (nvl(mmt.transaction_cost,0) *
		(nvl(mmt.actual_cost,0) *
		-- End fix for version 1.8 
		decode(mmt.fob_point, 
			1, (decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity)),
			2, (decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity))
		      )
		)
	   ,2) Total_Purchase_Amount,
	round(nvl(mmt.actual_cost,0) * 
		decode(mmt.fob_point, 
			1, (decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity)),
			2, (decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity))
		      )
	   ,2) Total_Standard_Amount,
	-- Fix for version 1.2
	-- 	sum(nvl(al.accounted_dr,0) - nvl(al.accounted_cr,0)) PPV_Amount
	(round(nvl(mmt.variance_amount,0) + 
		-- Fix for version 1.8
		--  (nvl(mmt.transaction_cost,0) *
		(nvl(mmt.actual_cost,0) *
		-- End fix for version 1.8 
		decode(mmt.fob_point, 
			1, (decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity)),
			2, (decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity))
		      )
		)
	   ,2) -- Total_Purchase_Amount
	) -
	(round(nvl(mmt.actual_cost,0) * 
		decode(mmt.fob_point, 
			1, (decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity)),
			2, (decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity))
		      )
	   ,2)   -- Standard Amount
	) PPV_Amount,
	-- Revision for version 1.16, calculate the percentage
	-- case
	--   when difference = 0 then 0
	--   when standard = 0 then 100%
	--   when PO unit price = 0 then -100%
	--   else PO - std / std
	round(case
	   when round((nvl(mmt.variance_amount,0)/
		decode(mmt.fob_point, 
			1, (decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity)),
			2, (decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity))
		      )
		-- Fix for version 1.8
		--  + nvl(mmt.transaction_cost,0)
		    + nvl(mmt.actual_cost,0)
		-- End fix for version 1.8
		      )
	    -  nvl(mmt.actual_cost,0),8) = 0 then 0
	   -- when standard = 0 then -100%
	   when round(nvl(mmt.actual_cost,0),5) = 0 then 100
	   --   when PO unit price = 0 then 100%
	   when	round((nvl(mmt.variance_amount,0)/
		decode(mmt.fob_point, 
			1, (decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity)),
			2, (decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity))
		      )
		-- Fix for version 1.8
		--  + nvl(mmt.transaction_cost,0)
		  + nvl(mmt.actual_cost,0)
		-- End fix for version 1.8
	      )
	   ,5)  = 0 then -100
	   -- else PO - std / std
	   else	(round((nvl(mmt.variance_amount,0)/
			decode(mmt.fob_point, 
				1, (decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity)),
				2, (decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity))
			      )
			-- Fix for version 1.8
			--  + nvl(mmt.transaction_cost,0)
			  + nvl(mmt.actual_cost,0)
			-- End fix for version 1.8
		      )
		    -  nvl(mmt.actual_cost,0),8)
		) / round(nvl(mmt.actual_cost,0),5) * 100
	end,2) Percent_Difference
	-- End revision for version 1.16
from	mtl_transaction_accounts mta,
	mtl_material_transactions mmt,
	mtl_transaction_lot_numbers mtln,
	mtl_transaction_types mtt,
	-- Fix for version 1.4
	-- rcv_transactions rt, -- commented out ver 1.4, was causing PPV to double up
	rcv_shipment_headers rsh, 
	rcv_shipment_lines rsl,
	-- Revision for version 1.14
	mtl_system_items_vl msiv,
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	-- End revision for version 1.14
	org_acct_periods oap,
	gl_code_combinations_kfv gcc,
	mtl_parameters mp,
	mtl_parameters mp2,
	fnd_common_lookups fcl, -- item type
	mfg_lookups ml, -- accounting line type
	mfg_lookups ml2, -- planning make/buy code
	fnd_user fu,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl,
	-- Revision for version 1.18, remove tables to increase performance
	-- xla.xla_transaction_entities ent,  -- apps synonym not working
	-- xla_events xe,
	-- End revision for version 1.18
	xla_distribution_links xdl,
	xla_ae_headers ah,
	xla_ae_lines al
-- ========================================================
-- Material Transaction, org and item joins
-- ========================================================
where	mta.transaction_id              = mmt.transaction_id
and	mmt.transaction_id              = mtln.transaction_id (+)
and	mmt.transaction_type_id	        = mtt.transaction_type_id
and	mta.organization_id             = msiv.organization_id
and	mta.inventory_item_id           = msiv.inventory_item_id -- also the transfer(to)_organization_id
and	mp.organization_id              = msiv.organization_id   -- transfer to organization_id
-- Revision for version 1.16, base this join on FOB point
-- and	mp2.organization_id             = mmt.organization_id
and	mp2.organization_id             = decode(mmt.fob_point, 1, mmt.organization