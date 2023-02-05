/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Receiving Activity Summary
-- Description: Especially for companies who do not use separate inspection receipt processes, this report nets the initial purchase order receipt into receiving against the delivery into stock and WIP outside processing (OSP).  By comparing the Purchasing Receipt transactions with the Purchasing Delivery transactions (for the purchasing receipts, material deliveries and WIP OSP deliveries).  Enter the date range you wish to compare, typically a monthly date range.  Differences may be due to the initial receipt occurring in the prior month, not running Create Accounting in the current month (as this report uses the Subledger Accounting rules to report your Receiving Valuation Activity), the goods never delivered into stock or OSP or perhaps the delivery into stock or into WIP OSP was not processed by Create Accounting.

/* +=============================================================================+
-- |  Copyright 2010 - 2022 Douglas Volz Consulting, Inc.                        |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_rcv_activity_rept.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from      -- starting transaction date for icp related transactions
-- |  p_trx_date_to        -- ending transaction date for icp related transactions
-- |  p_org_code           -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit     -- Operating_Unit you wish to report, leave blank for all
-- |                          operating units (optional) 
-- |  p_ledger             -- general ledger you wish to report, leave blank for all
-- |                          ledgers (optional)
-- |
-- |  Description:
-- |  Report to figure out what is left in Receiving Inspection, by comparing
-- |  the Purchasing Receipt transactions with the Purchasing Delivery
-- |  transactions (for the purchasing receipts, material deliveries and WIP (OSP)
-- |  deliveries).
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0      6 Jan 2010 Douglas Volz   Initial Coding
-- |  1.1     05 Apr 2010 Douglas Volz   Added PO number, PO Distribution id to query
-- |  1.2     25 Oct 2017 Douglas Volz   Now use the receiving parameter Receiving ccid
-- |                                     and added transaction source.
-- |  1.3     13 Mar 2018 Douglas Volz   Added Ledger parameter
-- |  1.4     08 Jul 2022 Douglas Volz   Multi-language tables for item master.
-- +=============================================================================+*/

-- Excel Examle Output: https://www.enginatics.com/example/cac-receiving-activity-summary/
-- Library Link: https://www.enginatics.com/reports/cac-receiving-activity-summary/
-- Run Report: https://demo.enginatics.com/

select	rcv_sum. Destination_Type,
-- =============================================================
-- Get summary of net PO receiving activity by PO Distribution
-- =============================================================
	rcv_sum.Ledger,
	rcv_sum.Operating_Unit,
	rcv_sum.Org_Code,
	rcv_sum.Period_Name,
	rcv_sum.Accounting_Line_Type,
	rcv_sum.PO_Number,
	rcv_sum.PO_Line,
	rcv_sum.PO_Distribution_Id,
	&segment_columns
	rcv_sum.WIP_Job,
	rcv_sum.Item_Number,
	rcv_sum.Item_Description,
	sum(rcv_sum.Amount) Amount
from	gl_code_combinations_kfv gcc1,
	gl_code_combinations_kfv gcc2,
	-- =============================================================
	-- Get the Receipts into Receiving Inspection and the Deliveries
	-- out of Receiving Inspection from Purchasing
	-- =============================================================
	(select	pod.destination_type_code Destination_Type,
		nvl(gl.short_name, gl.name) Ledger,
		haou2.name Operating_Unit,
		mp.organization_code Org_Code,
		oap.period_name Period_Name,
		-- Revision for version 1.2
		'RCV' Transaction_Source,
		rrsl.accounting_line_type Accounting_Line_Type,
		flv.meaning Transaction_Type,
		rt.transaction_id Transaction_Id,
		poh.segment1 PO_Number,
		pol.line_num PO_Line,
		pod.po_distribution_id PO_Distribution_Id,
		al.code_combination_id rcv_ccid,  -- gcc1
		pod.code_combination_id pod_ccid, -- gcc2
		nvl((select	we.wip_entity_name
			 from	wip_entities we
			 where	we.wip_entity_id = pod.wip_entity_id),'') WIP_Job,
		msiv.concatenated_segments Item_Number,
		msiv.description Item_Description,
		sum(nvl(al.accounted_dr,0) - nvl(al.accounted_cr,0)) Amount
	 from	rcv_receiving_sub_ledger rrsl,
		rcv_transactions rt,
		po_headers_all poh,
		po_lines_all pol,
		rcv_shipment_lines rsl,
		po_distributions_all pod,
		fnd_lookup_values flv,
		mtl_system_items_vl msiv,
		org_acct_periods oap,
		mtl_parameters mp, 
		hr_organization_information hoi,
		hr_all_organization_units_vl haou, -- inv_organization_id
		hr_all_organization_units_vl haou2, -- operating unit
		gl_ledgers gl,
		-- Revision for version 1.4, remove tables to increase performance
		-- xla_transaction_entities ent,
		-- xla_events xe,
		-- End revision for version 1.4
		xla_distribution_links xdl,
		xla_ae_headers ah,
		xla_ae_lines al
	 -- ========================================================
	 -- Material Transaction, org and item joins
	 -- ========================================================
	 where	rrsl.rcv_transaction_id     = rt.transaction_id
	 and	rt.shipment_line_id         = rsl.shipment_line_id
	 and	rsl.item_id                 = msiv.inventory_item_id (+)
	 and	rsl.to_organization_id	    = msiv.organization_id   (+)
	 and	mp.organization_id	    = rt.organization_id
	 -- RMAs and REQs are not accounted for by Purchasing
	 and	rt.source_document_code not in ('RMA', 'REQ')
	 and	pod.po_distribution_id      = rsl.po_distribution_id
	 and	pod.po_header_id            = poh.po_header_id
	 and	pod.po_line_id              = pol.po_line_id
	 and	rrsl.accounting_line_type  <> 'Accrual'
	 -- ========================================================
	 -- Inventory Org accounting period joins
	 -- ========================================================
	 and	oap.period_name             = ah.period_name
	 and	oap.organization_id         = rt.organization_id
	 -- ========================================================
	 -- Version 1.3, added lookup values to see more detail
	 -- ========================================================
	 and	flv.lookup_type             = 'RCV TRANSACTION TYPE'
	 and	flv.lookup_code             = rt.transaction_type
	 -- Revision for version 1.2
	 -- and	source_lang                 = 'US'
	 -- and	language                    = 'US'
	 and	flv.language                = userenv('LANG')
	 -- ========================================================
	 -- using the base tables to avoid the performance issues
	 -- with org_organization_definitions and hr_operating_units
	 -- ========================================================
	 and	hoi.org_information_context = 'Accounting Information'
	 and	hoi.organization_id         = rt.organization_id
	 and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
	 and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
	 and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
	 and	1=1                         -- p_trx_date_from, p_trx_date_to, p_org_code, p_operating_unit, p_ledger
	 -- ========================================================
	 -- SLA table joins to get the exact account numbers
	 -- ========================================================
	 -- Revision for version 1.4, performance improvements
	 -- and	ent.entity_code                  = 'RCV_ACCOUNTING_EVENTS'
	 -- and	ent.application_id               = 707
	 -- and	xe.application_id                = ent.application_id
	 -- and	xe.event_id                      = xdl.event_id
	 -- and	ah.entity_id                     = ent.entity_id
	 -- and	ah.ledger_id                     = ent.ledger_id
	 -- and	ah.event_id                      = xe.event_id
	 -- and	al.application_id                = ent.application_id
	 -- and	xdl.application_id               = ent.application_id
	 and	ah.ledger_id                     = gl.ledger_id
	 -- End revisions for version 1.4
	 and	ah.application_id                = al.application_id
	 and	ah.application_id                = 707
	 and	ah.ae_header_id                  = al.ae_header_id
	 and	al.ledger_id                     = ah.ledger_id
	 and	al.ae_header_id                  = xdl.ae_header_id
	 and	al.ae_line_num 	                 = xdl.ae_line_num
	 and	xdl.application_id               = 707
	 and	xdl.source_distribution_type = 'RCV_RECEIVING_SUB_LEDGER'
	 and	xdl.source_distribution_id_num_1 = rrsl.rcv_sub_ledger_id
	 -- Revision for version 1.4, outer join for CCIDs
	 -- ========================================================
	 -- Account code combination id joins
	 -- ========================================================
	 -- Revision for version 1.2
	 -- and	gcc1.segment3 = '1449'
	 and	rrsl.code_combination_id in
		(select	rp.receiving_account_id
		 from	rcv_parameters rp
		 where	rp.organization_id      = mp.organization_id)
	 -- Revision for version 1.4, outer join for CCIDs
	 and	rrsl.code_combination_id (+)    = al.code_combination_id
	 -- ==========================================================
	 group by pod.destination_type_code,
		nvl(gl.short_name, gl.name),
		haou2.name,
		mp.organization_code,
		oap.period_name,
		 -- Revision for version 1.2
		'RCV',
		rrsl.accounting_line_type,
		flv.meaning,
		rt.transaction_id,
		poh.segment1,
		pol.line_num,
		pod.po_distribution_id,
		al.code_combination_id, -- rcv_ccid,  -- gcc1
		pod.code_combination_id, -- pod_ccid, -- gcc2
		pod.wip_entity_id,
		msiv.concatenated_segments,
		msiv.description
	 -- =============================================================
	 -- Get the Deliveries from Receiving Inspection to WIP for
	 -- outside processing
	 -- =============================================================
	 union all
	 select	pod.destination_type_code Destination_Type,
		nvl(gl.short_name, gl.name) Ledger,
		haou2.name Operating_Unit,
		mp.organization_code Org_Code,
		oap.period_name Period_Name,
		 -- Revision for version 1.2
		'WIP' Transaction_Source,
		ml.meaning Accounting_Line_Type,
		ml2.meaning Transaction_Type,
		wt.transaction_id Transaction_Id,
		poh.segment1 PO_Number,
		pol.line_num PO_Line,
		pod.po_distribution_id PO_Distribution_Id,
		al.code_combination_id rcv_ccid,  -- gcc1
		pod.code_combination_id pod_ccid, -- gcc2
		nvl((select	we.wip_entity_name
			 from	wip_entities we
			 where	we.wip_entity_id = pod.wip_entity_id),'') WIP_Job,
		msiv.concatenated_segments Item_Number,
		msiv.description Item_Description,
		sum(nvl(al.accounted_dr,0) - nvl(al.accounted_cr,0)) Amount
	 from	wip_transaction_accounts wta,
		wip_transactions wt,
		wip_accounting_classes wac,
		wip_discrete_jobs wdj,
		rcv_transactions rt,
		rcv_shipment_lines rsl,
		po_headers_all poh,
		po_lines_all pol,
		po_distributions_all pod,
		mfg_lookups ml2,
		mtl_system_items_vl msiv,
		org_acct_periods oap,
		mtl_parameters mp, 
		mfg_lookups ml, 
		hr_organization_information hoi,
		hr_all_organization_units_vl haou, -- inv_organization_id
		hr_all_organization_units_vl haou2, -- operating unit
		gl_ledgers gl,
		-- Revision for version 1.4, remove tables to increase performance
		-- xla_transaction_entities ent,
		-- xla_events xe,
		-- End revision for version 1.4
		xla_distribution_links xdl,
		xla_ae_headers ah,
		xla_ae_lines al
	 -- ========================================================
	 -- Material Transaction, org and item joins
	 -- ========================================================
	 where	wta.transaction_id 	    = wt.transaction_id
	 and	wta.organization_id	    = msiv.organization_id
	 and	mp.organization_id	    = msiv.organization_id
	 -- Oracle bug=> the accounting line type used is 4 (res absorption) and should be 5 (receiving)
	 and	wta.accounting_line_type   in (4,5)
	 -- get all of them to see the offset accounts
	 and	wt.rcv_transaction_id	    = rt.transaction_id
	 and	rt.shipment_line_id         = rsl.shipment_line_id
	 and	rsl.item_id                 = msiv.inventory_item_id (+)
	 and	rsl.to_organization_id	    = msiv.organization_id   (+)
	 and	mp.organization_id	    = rt.organization_id
	 -- RMAs and REQs are not accounted for by Purchasing
	 and	rt.source_document_code not in ('RMA', 'REQ')
	 and	pod.po_distribution_id      = rsl.po_distribution_id
	 and	pod.po_header_id            = poh.po_header_id
	 and	pod.po_line_id              = pol.po_line_id
	 -- ========================================================
	 -- WIP class and WIP job joins
	 -- ========================================================
	 and	wac.class_code              = wdj.class_code
	 and	wdj.wip_entity_id           = wt.wip_entity_id
	 and	wdj.organization_id         = wac.organization_id
	 -- ========================================================
	 -- Inventory Org accounting period joins
	 -- ========================================================
	 and	oap.acct_period_id          = wt.acct_period_id
	 and	oap.organization_id         = wt.organization_id
	 -- ========================================================
	 -- Version 1.3, added lookup values to see more detail
	 -- ========================================================
	 and	ml.lookup_type              = 'CST_ACCOUNTING_LINE_TYPE'
	 and	ml.lookup_code              = wta.accounting_line_type
	 and	ml2.lookup_type             = 'WIP_TRANSACTION_TYPE_SHORT'
	 and	ml2.lookup_code             = wt.transaction_type
	 -- ========================================================
	 -- using the base tables to avoid the performance issues
	 -- with org_organization_definitions and hr_operating_units
	 -- ========================================================
	 and	hoi.org_information_context = 'Accounting Information'
	 and	hoi.organization_id         = wta.organization_id
	 and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
	 and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
	 and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
	 and	2=2                         -- p_trx_date_from, p_trx_date_to, p_org_code, p_operating_unit, p_ledger
	 -- ========================================================
	 -- SLA table joins to get the exact account numbers
	 -- ========================================================
	 -- Revision for version 1.4, performance improvements
	 -- and	ent.entity_code                  = 'WIP_ACCOUNTING_EVENTS'
	 -- and	ent.application_id               = 707
	 -- and	xe.application_id                = ent.application_id
	 -- and	xe.event_id                      = xdl.event_id
	 -- and	ah.entity_id                     = ent.entity_id
	 -- and	ah.ledger_id                     = ent.ledger_id
	 -- and	ah.event_id                      = xe.event_id
	 -- and	al.application_id                = ent.application_id
	 -- and	xdl.application_id               = ent.application_id
	 and	ah.ledger_id                     = gl.ledger_id
	 -- End revisions for version 1.4
	 and	ah.application_id                = al.application_id
	 and	ah.application_id                = 707
	 and	ah.ae_header_id                  = al.ae_header_id
	 and	al.ledger_id                     = ah.ledger_id
	 and	al.ae_header_id                  = xdl.ae_header_id
	 and	al.ae_line_num 	                 = xdl.ae_line_num
	 and	xdl.application_id               = 707
	 and	xdl.source_distribution_type     = 'WIP_TRANSACTION_ACCOUNTS'
	 and	xdl.source_distribution_id_num_1 = wta.wip_sub_ledger_id
	 and	wta.reference_account in
		(select	rp.receiving_account_id
		 from	rcv_parameters rp
		 where	mp.organization_id       = mp.organization_id)
	 -- Revision for version 1.4, outer join for CCIDs
	 and	wta.reference_account (+)        = al.code_combination_id
	 -- ==========================================================
	 group by 
		pod.destination_type_code,
		nvl(gl.short_name, gl.name),
		haou2.name,
		mp.organization_code,
		oap.period_name,
		-- Revision for version 1.2
		'WIP',
		ml.meaning,
		ml2.meaning,
		wt.transaction_id,
		poh.segment1,
		pol.line_num,
		pod.po_distribution_id,
		al.code_combination_id, -- rcv_ccid,  -- gcc1
		pod.code_combination_id, -- pod_ccid, -- gcc2
		pod.wip_entity_id,
		msiv.concatenated_segments,
		msiv.description
	 -- =============================================================
	 -- Get the Deliveries from Receiving Inspection to Stores
	 -- inventory for purchase order receipt transactions
	 -- =============================================================
	 union all
	 select	pod.destination_type_code Destination_Type,
		nvl(gl.short_name, gl.name) Ledger,
		haou2.name Operating_Unit,
		mp.organization_code Org_Code,
		oap.period_name Period_Name,
		-- Revision for version 1.2
		'INV' Transaction_Source,
		ml.meaning Accounting_Line_Type,
		mtt.transaction_type_name Transaction_Type,
		mmt.transaction_id Transaction_Id,
		poh.segment1 PO_Number,
		pol.line_num PO_Line,
		pod.po_distribution_id PO_Distribution_Id,
		al.code_combination_id rcv_ccid,  -- gcc1
		pod.code_combination_id pod_ccid, -- gcc2
		nvl((select	we.wip_entity_name
			 from	wip_entities we
			 where	we.wip_entity_id = pod.wip_entity_id),'') WIP_Job,
		msiv.concatenated_segments Item_Number,
		msiv.description Item_Description,
		sum(nvl(al.accounted_dr,0) - nvl(al.accounted_cr,0)) Amount
	 from	mtl_transaction_accounts mta,
		mtl_material_transactions mmt,
		rcv_transactions rt,
		rcv_shipment_lines rsl,
		po_headers_all poh,
		po_lines_all pol,
		po_distributions_all pod,
		mtl_transaction_types mtt,
		mtl_system_items_vl msiv,
		org_acct_periods oap,
		mtl_parameters mp, 
		mfg_lookups ml, 
		hr_organization_information hoi,
		hr_all_organization_units_vl haou, -- inv_organization_id
		hr_all_organization_units_vl haou2, -- operating unit
		gl_ledgers gl,
		-- Revision for version 1.4, remove tables to increase performance
		-- xla_transaction_entities ent,
		-- xla_events xe,
		-- End revision for version 1.4
		xla_distribution_links xdl,
		xla_ae_headers ah,
		xla_ae_lines al
	 -- ========================================================
	 -- Material Transaction, org and item joins
	 -- ========================================================
	 where	mta.transaction_id 	    = mmt.transaction_id
	 and	mmt.transaction_type_id     = mtt.transaction_type_id
	 and	mta.organization_id	    = msiv.organization_id
	 and	mta.inventory_item_id	    = msiv.inventory_item_id
	 and	mp.organization_id	    = msiv.organization_id
	 and	mmt.transaction_source_type_id = 1 -- Purchasing
	 and	mta.accounting_line_type    = 5
	 and	mmt.rcv_transaction_id      = rt.transaction_id
	 and	rt.shipment_line_id         = rsl.shipment_line_id
	 and	rsl.item_id                 = msiv.inventory_item_id (+)
	 and	rsl.to_organization_id      = msiv.organization_id   (+)
	 -- RMAs and REQs are not accounted for by Purchasing
	 and	rt.source_document_code not in ('RMA', 'REQ')
	 and	pod.po_distribution_id      = rsl.po_distribution_id
	 and	pod.po_header_id            = poh.po_header_id
	 and	pod.po_line_id              = pol.po_line_id
	 -- ========================================================
	 -- Inventory Org accounting period joins
	 -- ========================================================
	 and	oap.period_name             = ah.period_name
	 and	oap.organization_id         = mta.organization_id
	 -- ========================================================
	 -- Version 1.3, added lookup values to see more detail
	 -- ========================================================
	 and	ml.lookup_type              = 'CST_ACCOUNTING_LINE_TYPE'
	 and	ml.lookup_code              = mta.accounting_line_type
	 -- ========================================================
	 -- using the base tables to avoid the performance issues
	 -- with org_organization_definitions and hr_operating_units
	 -- ========================================================
	 and	hoi.org_information_context = 'Accounting Information'
	 and	hoi.organization_id         = mta.organization_id
	 and	hoi.organization_id         = haou.organization_id   -- this gets the organization name
	 and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
	 and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
	 and	3=3                         -- p_trx_date_from, p_trx_date_to, p_org_code, p_operating_unit, p_ledger
	 -- ========================================================
	 -- SLA table joins to get the exact account numbers
	 -- ========================================================
	 -- Revision for version 1.23, performance improvements
	 -- and	ent.entity_code                  = 'MTL_ACCOUNTING_EVENTS'
	 -- and	ent.application_id               = 707
	 -- and	xe.application_id                = ent.application_id
	 -- and	xe.event_id                      = xdl.event_id
	 -- and	ah.entity_id                     = ent.entity_id
	 -- and	ah.ledger_id                     = ent.ledger_id
	 -- and	ah.event_id                      = xe.event_id
	 -- and	al.application_id                = ent.application_id
	 -- and	xdl.application_id               = ent.application_id
	 and	ah.ledger_id                     = gl.ledger_id
	 -- End revisions for version 1.23
	 and	ah.application_id                = al.application_id
	 and	ah.application_id                = 707
	 and	ah.ae_header_id                  = al.ae_header_id
	 and	al.ledger_id                     = ah.ledger_id
	 and	al.ae_header_id                  = xdl.ae_header_id
	 and	al.ae_line_num 	                 = xdl.ae_line_num
	 and	xdl.application_id               = 707
	 and	xdl.source_distribution_type     = 'MTL_TRANSACTION_ACCOUNTS'
	 and	xdl.source_distribution_id_num_1 = mta.inv_sub_ledger_id
	 -- Revision for version 1.4, for performance improvements
	 and	mta.reference_account in
		(select	rp.receiving_account_id
		 from	rcv_parameters rp
		 where	rp.organization_id       = mp.organization_id)
	 -- Revision for version 1.4, outer join for CCIDs
	 and	mta.reference_account (+)        = al.code_combination_id
	 -- ==========================================================
	 group by 
		pod.destination_type_code,
		nvl(gl.short_name, gl.name),
		haou2.name,
		mp.organization_code,
		oap.period_name,
		-- Revision for version 1.2
		'INV',
		ml.meaning,
		mtt.transaction_type_name,
		mmt.transaction_id,
		poh.segment1,
		pol.line_num,
		pod.po_distribution_id,
		al.code_combination_id, -- rcv_ccid,  -- gcc1
		pod.code_combination_id, -- pod_ccid, -- gcc2
		pod.wip_entity_id,
		msiv.concatenated_segments,
		msiv.description
	) rcv_sum
-- Revision for version 1.4, outer join for CCIDs
where	gcc1.code_combination_id (+)     = rcv_sum.rcv_ccid
and	gcc2.code_combination_id (+)     = rcv_sum.pod_ccid
group by
	rcv_sum.Destination_Type,
	rcv_sum.Ledger,
	rcv_sum.Operating_Unit,
	rcv_sum.Org_Code,
	rcv_sum.Period_Name,
	rcv_sum.Accounting_Line_Type,
	rcv_sum.PO_Number,
	rcv_sum.PO_Line,
	rcv_sum.PO_Distribution_Id,
	&segment_columns_grp
	rcv_sum.WIP_Job,
	rcv_sum.Item_Number,
	rcv_sum.Item_Description
having 	round(sum(rcv_sum.Amount),3)    <> 0
order by 1,2,3,4,6,7,8,9