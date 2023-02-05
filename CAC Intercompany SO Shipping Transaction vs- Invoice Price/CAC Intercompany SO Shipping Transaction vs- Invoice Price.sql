/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Intercompany SO Shipping Transaction vs. Invoice Price
-- Description: Report to compare the transaction item cost from the selling internal org to the invoice sales price the selling internal organization is charging the internal receiving organization. 

/* +=============================================================================+
-- |  Copyright 2017 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_verify_so_price_vs_cost_txn.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from           -- starting shipping transaction date, mandatory
-- |  p_trx_date_to             -- ending shipping transaction date, mandatory
-- |
-- |  Description:
-- |  Report to compare the transaction item cost from the selling internal org
-- |  to the invoice sales price the selling internal organization is charging the
-- |  receiving organization. 
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     01 May 2017 Douglas Volz   Initial Coding
-- |  1.1     03 Sep 2019 Douglas Volz   Add Ledger, Operating Unit, Item Type, Status
-- |                                     and item categories for cost and inventory.
-- |  1.2     27 Jan 2020 Douglas Volz   Added Ledger, Operating Unit and Org Code 
-- |                                     parameters.
-- |  1.3     09 Jul 2022 Douglas Volz   Changes for multi-language lookup values.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-intercompany-so-shipping-transaction-vs-invoice-price/
-- Library Link: https://www.enginatics.com/reports/cac-intercompany-so-shipping-transaction-vs-invoice-price/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	msiv.concatenated_segments Item_Number,
	msiv.description Item_Description,
	-- Revision for version 1.1
	fcl.meaning Item_Type,
	-- Revision for version 1.3
	-- msiv.inventory_item_status_code Item_Status,
	misv.inventory_item_status_code Item_Status,
	ml1.meaning Make_Buy_Code,
	-- End revision for version 1.3
&category_columns
	mtt.transaction_type_name Transaction_Type,
	-- Revision for version 1.3
	fl1.meaning Item_Internal_Order_Flag,
	fl2.meaning Item_Internal_Order_Enabled, 
	fl3.meaning Item_Invoiceable,
	fl4.meaning Item_Invoice_Enabled,
	-- End revision for version 1.3
	to_char(mmt.transaction_id) Transaction_Id,
	mmt.transaction_date Transaction_Date,
	ooh.order_number Sales_Order_Number,
	ool.line_number SO_Line_Number,
	-- Revision for version 1.3
	muomv.uom_code UOM_Code,
	mmt.primary_quantity Ship_Quantity,
	mmt.new_cost Unit_Cost,
	(select	max(rctl.unit_selling_price)
	     from	ra_customer_trx_lines_all rctl
	     where	rctl.interface_line_context = ('INTERCOMPANY')
	     and	rctl.interface_line_attribute6 = ool.line_id) Sales_Unit_Price,
	nvl((select	max(rctl.unit_selling_price)
	     from	ra_customer_trx_lines_all rctl
	     where	rctl.interface_line_context = ('INTERCOMPANY')
	     and	rctl.interface_line_attribute6 = ool.line_id),0) - mmt.new_cost Unit_Margin,
	(select	rctl.quantity_invoiced
	     from	ra_customer_trx_lines_all rctl
	     where	rctl.interface_line_context = ('INTERCOMPANY')
	     and	rctl.interface_line_attribute6 = ool.line_id) Sales_Quantity_Invoiced
from	mtl_material_transactions mmt,
	mtl_transaction_types mtt,
	mtl_system_items_vl msiv,
	-- Revision for version 1.3
	mtl_item_status_vl misv,
	mtl_units_of_measure_vl muomv,
	-- End revision for version 1.3
	mtl_parameters mp,
	oe_order_headers_all ooh,
	oe_order_lines_all ool,
	-- Revision for version 1.1
	fnd_common_lookups fcl,
	-- Revision for version 1.3
	mfg_lookups ml1, -- planning make/buy code, MTL_PLANNING_MAKE_BUY
	fnd_lookups fl1, -- internal_order_flag, YES_NO
	fnd_lookups fl2, -- internal_order_enabled_flag, YES_NO
	fnd_lookups fl3, -- invoiceable_item_flag, YES_NO
	fnd_lookups fl4, -- invoice_enabled_flag, YES_NO
	-- End revision for version 1.3
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2,  -- operating unit
	gl_ledgers gl
	-- End revision for version 1.1
where	mmt.transaction_source_type_id  = 8  -- Internal Order
and	mmt.transaction_action_id not in (28)  -- do not select Internal Order Pick transactions
and	mtt.transaction_type_id         = mmt.transaction_type_id
and	msiv.inventory_item_id          = mmt.inventory_item_id
and	msiv.organization_id            = mmt.organization_id
and	mp.organization_id              = mmt.organization_id
and	ool.line_id                     = mmt.trx_source_line_id
and	ooh.header_id                   = ool.header_id
-- Revision for version 1.3
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
-- End revision for version 1.3
-- Revision for version 1.1
and	fcl.lookup_code (+)             = msiv.item_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
-- Revision for version 1.3
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                 = msiv.planning_make_buy_code
and	fl1.lookup_type                 = 'YES_NO'
and	fl1.lookup_code                 = msiv.internal_order_flag
and	fl2.lookup_type                 = 'YES_NO'
and	fl2.lookup_code                 = msiv.internal_order_enabled_flag
and	fl3.lookup_type                 = 'YES_NO'
and	fl3.lookup_code                 = msiv.invoiceable_item_flag
and	fl4.lookup_type                 = 'YES_NO'
and	fl4.lookup_code                 = msiv.invoice_enabled_flag
-- End revision for version 1.3
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = mp.organization_id
and	hoi.organization_id             = haou.organization_id   -- this gets the organization name
and	haou2.organization_id           = hoi.org_information3   -- this gets the operating unit id
and	gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                             -- p_trx_date_from, p_trx_date_to, p_org_code, p_operating_unit, p_ledger
order by
	nvl(gl.short_name, gl.name), -- Ledger
	haou2.name, -- Operating Unit
	mp.organization_code, -- Org Code
	msiv.concatenated_segments, -- Item
	mmt.transaction_date, -- Matl Txn Date
	ooh.order_number, -- Sales Order Number,
	ool.line_number -- SO Line Number