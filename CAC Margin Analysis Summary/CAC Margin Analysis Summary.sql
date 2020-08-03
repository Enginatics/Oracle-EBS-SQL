/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Margin Analysis Summary
-- Description: Summary report for the margin from the customer invoices and shipments, based on the standard Oracle Margin table, cst_margin_summary. Does not show the COGS and Sales Accounts. You first need to run the Margin Analysis Build request, to populate this table.
-- Excel Examle Output: https://www.enginatics.com/example/cac-margin-analysis-summary/
-- Library Link: https://www.enginatics.com/reports/cac-margin-analysis-summary/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	-- Revision for version 1.7
	-- mas.sold_to_customer_name Sold_To_Customer,
	-- Revision for version 1.10
	cms.customer_class_code Customer_Class_Code,
	hz.party_name Customer,
	hca.account_number Customer_Number,
	-- Revision for version 1.8
	-- Not useful at client site
	-- rsa.name Sales_Rep,
	cms.order_number Order_Number,
	cms.line_number Order_Line,
	-- Revision for version 1.10
	-- sot.name Order_Type,
	ottt.name Order_Type,
	-- Revision for version 1.7
	-- COGS entry has a timestamp, causing two rows
	trunc(cms.gl_date) Transaction_Date,
	msiv.concatenated_segments Item,
	msiv.description  Item_Description,
	-- Revision for version 1.10
	fcl.meaning Item_Type,
	-- Revision for version 1.9
	nvl((select	max(mc.segment1)
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
	nvl((select	max(mc.segment1)
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
	-- End revision for version 1.9 & 1.10
	muomv.uom_code UOM_Code,
        round(sum(nvl(cms.invoiced_amount,0)) / 
            decode(sum(nvl(cms.invoice_line_quantity,0)), 0, 1, sum(nvl(cms.invoice_line_quantity,0))),5) Unit_Price,
        round(sum(nvl(cms.cogs_amount,0)) /
            decode(sum(nvl(cms.ship_quantity,0)),0,1, sum(nvl(cms.ship_quantity,0))),5) Unit_Cost,
	sum(nvl(cms.invoice_line_quantity,0)) 				Invoice_Quantity,
	sum(nvl(cms.ship_quantity,0)) 					Ship_Quantity,
	sum(nvl(cms.invoiced_amount,0))					Sales_Amount,
	sum(nvl(cms.cogs_amount,0)) 					COGS_Amount,
	sum(nvl(cms.invoiced_amount,0)) - sum(nvl(cms.cogs_amount,0)) 	Margin,
	round((sum(nvl(cms.invoiced_amount,0)) - sum(nvl(cms.cogs_amount,0))) /
		decode(sum(nvl(cms.invoiced_amount,0)), 0, 1, sum(nvl(cms.invoiced_amount,0))) * 100,1) Percent
from	cst_margin_summary cms,
	-- Revision for version 1.10
	mtl_system_items_vl msiv,
	mtl_units_of_measure_vl muomv,
	fnd_common_lookups fcl,
	-- End for revision for version 1.10
	mtl_parameters mp,
	so_order_types_all sot,
	-- Revision for version 1.10
	oe_transaction_types_tl ottt,
	-- Revision for version 1.7
	-- ra_customers rc,
	hz_cust_accounts_all hca,
	hz_parties hz,
	-- End revision for version 1.7
	-- Revision for version 1.8
	-- Causing cross-joining
	-- ra_salesreps_all rsa,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl
-- Revision for version 1.10
where	msiv.organization_id         = mp.organization_id
and	msiv.organization_id         = cms.parent_organization_id
and	msiv.inventory_item_id       = cms.parent_inventory_item_id
and	muomv.uom_code               = msiv.primary_uom_code
and	fcl.lookup_code (+)          = msiv.item_type
and	fcl.lookup_type (+)          = 'ITEM_TYPE'
and	ottt.transaction_type_id     = sot.order_type_id
and	ottt.language                = userenv('lang')
-- End for revision for version 1.10
and	sot.order_type_id            = cms.order_type_id
-- Performance improvement, comment this out
-- and	sot.org_id  = cms.org_id
-- Revision for version 1.7
-- and	rc.customer_id               = cms.customer_id
and	hca.cust_account_id          = cms.customer_id
and	hz.party_id                  = hca.party_id
-- Revision for version 1.8
-- Causing cross-joining
-- and	rsa.salesrep_id              = cms.primary_salesrep_id
and	1=1			 -- p_trx_date_from, p_trx_date_to, p_customer, p_item_number, p_org_code, p_operating_unit, p_ledger			-- 
-- End revision for version 1.5
-- ===================================================================
-- using the base tables to avoid using
-- org_organization_definitions and hr_operating_units
-- ===================================================================
and	hoi.org_information_context  = 'Accounting Information'
and	hoi.organization_id          = mp.organization_id
and	hoi.organization_id          = haou.organization_id   -- this gets the organization name
and	cms.org_id                   = haou2.organization_id
and	haou2.organization_id        = hoi.org_information3 -- this gets the operating unit id
and	gl.ledger_id                 = to_number(hoi.org_information1) -- get the ledger_id
-- ===================================================================
group by 
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	-- Revision for version 1.10
	cms.customer_class_code,
	cms.sold_to_customer_name,
	hz.party_name,
	hca.account_number,
	cms.order_number,
	cms.line_number,
	-- Revision for version 1.10
	ottt.name,
	-- Revision for version 1.7
	-- COGS entry has a timestamp, causing two rows
	trunc(cms.gl_date),
	msiv.concatenated_segments,
	msiv.description,
	fcl.meaning, -- Item_Type
	-- Revision for version 1.10
	muomv.uom_code,
	-- Revision for version 1.9, needed for inline select
	msiv.inventory_item_id,
	msiv.organization_id
order by
	nvl(gl.short_name, gl.name), -- Ledger
	haou2.name, -- Operating_Unit
	mp.organization_code, -- Org_Code
	hz.party_name, -- Customer
	cms.order_number, -- Order_Number
	cms.line_number -- Order_Line