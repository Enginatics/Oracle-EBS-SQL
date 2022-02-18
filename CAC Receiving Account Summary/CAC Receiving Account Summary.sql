/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Receiving Account Summary
-- Description: Report to get the receiving accounting distributions, in summary, by item, purchase order, purchase order line, release and project number.  For outside processing, including the WIP job, OSP item number and the OSP resource code.  And for expense destinations, even when there is no item number on the purchase order line, this report will get the expense category information, into the first category column.  (Note: this report has not been tested with encumbrance entries.)

/* +=============================================================================+
-- |  Copyright 2009- 2020 Douglas Volz Consulting, Inc.                         |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_wip_dist_xla_sum_rept.sql
-- |
-- |  Parameters:
-- |  p_trx_date_from    -- starting transaction date for WIP accounting transactions,
-- |                        mandatory.
-- |  p_trx_date_to      -- ending transaction date for WIP accounting transactions,
-- |                        mandatory.
-- |  p_item_number      -- Enter the specific item number you wish to report (optional)
-- |  p_org_code         -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit   -- Operating Unit you wish to report, leave blank for all
-- |                        operating units (optional) 
-- |  p_ledger           -- general ledger you wish to report, leave blank for all
-- |                        ledgers (optional)
-- |  p_category_set1    -- The first item category set to report, typically the
-- |                        Cost or Product Line Category Set
-- |  p_category_set2    -- The second item category set to report, typically the
-- |                        Inventory Category Set
-- |
-- |  Description:
-- |  Report to get the WIP accounting distributions, in summary, by WIP job,
-- |  resource, overhead and WIP cost update.  And for outside processing, 
-- |  including the purchase order number, line and release number.  
-- | 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |  1.0     06 Nov 2009 Douglas Volz   Initial Coding
-- |  1.11    05 Jul 2019 Douglas Volz   Added:
-- |                                     a) Added the breakout of transaction mounts by cost 
-- |                                        element.
-- |                                     b) Added the sum of resource / overhead hours or
-- |                                        amounts to a primary quantity column, plus,
-- |                                        added the quantity UOM field.
-- |  1.12    23 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                     master, item categories and operating units.
-- |                                     Added Project Number.
-- +=============================================================================+*/




-- Excel Examle Output: https://www.enginatics.com/example/cac-receiving-account-summary/
-- Library Link: https://www.enginatics.com/reports/cac-receiving-account-summary/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	rcv_acct.organization_code Org_Code,
	oap.period_name Period_Name,
	&segment_columns
	rcv_acct.item_number Item_Number,
	rcv_acct.item_description Item_Description,
	-- Revision for version 1.13
	rcv_acct.item_type Item_Type,
         -- Revision for version 1.12
	rcv_acct.category1 "&p_category_set1",
	rcv_acct.category2 "&p_category_set2",
         -- End revision for version 1.12
	rcv_acct.accounting_line_type Accounting_Line_Type,
	flv.meaning Transaction_Type,
	pl.displayed_field Destination_Type,
	-- Fix for version 1.9
	rcv_acct.po_num PO_Number,
	rcv_acct.po_line PO_Line,
	rcv_acct.release_num PO_Release,
	-- End fix for version 1.9
	-- Revision for version 1.11
	pp.name Project_Number,
	-- Fix for version 1.9
	rcv_acct.wip_job WIP_Job,
	rcv_acct.bom_resource Resource_Code,
	-- End fix for version 1.9
	rcv_acct.primary_uom_code UOM_Code,
	sum(rcv_acct.primary_quantity) Quantity,
	gl.currency_code Currency_Code,
	sum(rcv_acct.amount) Amount
from	org_acct_periods oap,
	pa_projects_all pp,
	gl_code_combinations gcc,
	fnd_lookup_values flv, 
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl,
	po_lookup_codes pl,
	xla.xla_transaction_entities ent,  -- apps synomyn not working
	xla_events xe,
	xla_distribution_links xdl,
	xla_ae_headers ah,
	xla_ae_lines al,
	-- ==========================================================================
	-- Use this inline table to fetch the receiving transactions
	-- ==========================================================================
	(select	mp.organization_code organization_code,
		rt.organization_id organization_id,
		rrsl.period_name period_name,
		rrsl.code_combination_id code_combination_id,
		rrsl.rcv_sub_ledger_id rcv_sub_ledger_id,
		msiv.concatenated_segments item_number,
		msiv.description item_description,
		-- Revision for version 1.13
		fcl.meaning item_type,
		-- Revision for version 1.12
		-- Revision for version 1.14
		-- Take off the max(mc.category_concat_segs), it causes sql error with the
		-- union all:  single-row subquery returns more than one row
		nvl((select	mc.category_concat_segs
		     from	mtl_categories_v mc,
				mtl_item_categories mic,
				mtl_category_sets_b mcs,
				mtl_category_sets_tl mcs_tl
		     where	mic.category_set_id         = mcs.category_set_id
		     and	2=2 
		     and	mic.inventory_item_id       = rsl.item_id
		     and	mic.organization_id         = rsl.to_organization_id
		     and	mc.category_id              = mic.category_id
		     and	mcs.category_set_id         = mcs_tl.category_set_id
		     and	mcs_tl.language             = userenv('lang')
		     -- You can have more than one category assignment per item
		     and	rownum < 2
		     union
		     -- Revision for version 1.14
		     -- This union gets the category for expense destinations
		     -- when the PO line does not have an item
		     select	mc.category_concat_segs
		     from	mtl_categories_v mc
		     where	mc.category_id              = pol.category_id
		     and	rsl.item_id is null
		   ),'') category1,
		nvl((select	max(mc.category_concat_segs)
		     from	mtl_categories_v mc,
				mtl_item_categories mic,
				mtl_category_sets_b mcs,
				mtl_category_sets_tl mcs_tl
		     where	mic.category_set_id         = mcs.category_set_id
		     and	3=3 
		     and	mic.inventory_item_id       = rsl.item_id
		     and	mic.organization_id         = rsl.to_organization_id
		     and	mc.category_id              = mic.category_id
		     and	mcs.category_set_id         = mcs_tl.category_set_id
		     and	mcs_tl.language             = userenv('lang')
		   ),'') category2,
		-- End revision for version 1.12
		-- Revision for version 1.14
		pol.category_id,
		rrsl.accounting_line_type accounting_line_type,
		rt.transaction_type transaction_type,
		pod.destination_type_code destination_type_code,
		-- Fix for version 1.9
		poh.segment1 po_num,
		pol.line_num po_line,
		(select	pr.release_num
		 from	po_releases_all pr
		 where	pr.po_release_id  = rt.po_release_id) release_num,
		-- End fix for version 1.9
		pod.project_id project_id,
		-- Fix for version 1.9
		(select	we.wip_entity_name
		 from	wip_entities we
		 where	we.wip_entity_id  = rt.wip_entity_id) wip_job,
		(select	br.resource_code
		 from	bom_resources br
		 where	br.resource_id    = rt.bom_resource_id) bom_resource,
		-- End fix for version 1.9
		-- Revision for version 1.14
		muomv.uom_code primary_uom_code,
		decode(sign(nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0)),
		-- =============================================
		-- Fix for version 1.8
		-- SIGN of qty incorrect on CORRECTION transactions
		-- =============================================
		--		 1, rt.primary_quantity, 
		--		-1, -1 * rt.primary_quantity,
				 1,  1 * abs(rt.primary_quantity), 
				-1, -1 * abs(rt.primary_quantity),
		-- End fix for version 1.8
		-- =============================================
				    rt.primary_quantity
			  ) primary_quantity,
		nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0) amount
	 from	rcv_receiving_sub_ledger rrsl,
		-- Fix for version 1.10
		rcv_accounting_events rae,
		rcv_transactions rt,
		rcv_shipment_lines rsl,
		-- Fix for version 1.9
		po_headers_all poh,
		po_lines_all pol,
		-- Fix for version 1.9
		po_distributions_all pod,
		mtl_system_items_vl msiv,
		mtl_units_of_measure_vl muomv,
		mtl_parameters mp,
		-- Revision for version 1.13
		fnd_common_lookups fcl
	 -- ========================================================
	 -- Material Transaction, org and item joins
	 -- ========================================================
	 where	rrsl.rcv_transaction_id = rt.transaction_id
	-- Fix for version 1.10
	 and	rae.accounting_event_id = rrsl.accounting_event_id
	 and	rae.rcv_transaction_id  = rt.transaction_id
	-- End fix for version 1.10
	 and	rt.shipment_line_id     = rsl.shipment_line_id
	 -- Expense destinations may not always have an item_id
	 and	rsl.item_id             = msiv.inventory_item_id (+) 
	 and	rsl.to_organization_id  = msiv.organization_id (+)
	 and	muomv.uom_code          = nvl(msiv.primary_uom_code, rt.uom_code)
	 and	pod.po_distribution_id  = nvl(rt.po_distribution_id, to_number(rrsl.reference3))
	 and	mp.organization_id      = rt.organization_id
	 -- ========================================================
	 -- Fix for version 1.9
	 -- ========================================================
	 and	rt.po_header_id         = poh.po_header_id
	 and	rt.po_line_id           = pol.po_line_id
	 -- ========================================================
	 -- Receiving Transaction date joins
	 -- Fix for version 1.7
	 -- ========================================================
	 -- Fix for version 1.10
	 and	4=4			-- p_trx_date_from, p_trx_date_to
	 -- ========================================================
	 -- For Item_Type
	 -- Revision for version 1.13
	 -- ========================================================
	 and	fcl.lookup_code  (+)   = msiv.item_type
	 and	fcl.lookup_type  (+)   = 'ITEM_TYPE'
	) rcv_acct
-- ========================================================
-- Inventory Org accounting period joins
-- ========================================================
-- Revision for version 1.13
where	oap.period_name                  = rcv_acct.period_name
and	oap.organization_id              = rcv_acct.organization_id
-- ========================================================
-- Version 1.3, added lookup values to see more detail
-- ========================================================
and	flv.lookup_type                  = 'RCV TRANSACTION TYPE'
and	flv.lookup_code                  = rcv_acct.transaction_type
and	flv.language                     = userenv('lang')
and	pl.lookup_type                   = 'DESTINATION TYPE'
and	pl.lookup_code                   = rcv_acct.destination_type_code
-- ========================================================
-- Project number join
-- ========================================================
and	rcv_acct.project_id              = pp.project_id (+)
-- ========================================================
-- using the base tables to avoid using
-- org_organization_definitions and hr_operating_units
-- ========================================================
and	hoi.org_information_context      = 'Accounting Information'
and	hoi.organization_id              = rcv_acct.organization_id
and	hoi.organization_id              = haou.organization_id   -- this gets the organization name
and	haou2.organization_id            = to_number(hoi.org_information3)  -- this gets the operating unit id
and	gl.ledger_id                     = to_number(hoi.org_information1)  -- get the ledger_id
and	1=1				 -- p_dest_type_code, p_item_number, p_org_code, p_operating_unit, p_ledger
-- ========================================================
-- SLA table joins to get the exact account numbers
-- ========================================================
and	ent.entity_code                  = 'RCV_ACCOUNTING_EVENTS'
and	ent.application_id               = 707
and	xe.application_id                = ent.application_id
and	xe.event_id                      = xdl.event_id
and	ah.entity_id                     = ent.entity_id
and	ah.ledger_id                     = ent.ledger_id
and	ah.application_id                = al.application_id
and	ah.application_id                = 707
and	ah.event_id                      = xe.event_id
and	ah.ae_header_id                  = al.ae_header_id
and	al.application_id                = ent.application_id
and	al.ledger_id                     = ah.ledger_id
and	al.ae_header_id                  = xdl.ae_header_id
and	al.ae_line_num                   = xdl.ae_line_num
and	xdl.application_id               = ent.application_id
and	xdl.source_distribution_type     = 'RCV_RECEIVING_SUB_LEDGER'
and	xdl.source_distribution_id_num_1 = rcv_acct.rcv_sub_ledger_id
and	gcc.code_combination_id (+)      = al.code_combination_id
-- ==========================================================
group by 
	nvl(gl.short_name, gl.name),
	haou2.name,
	rcv_acct.organization_code,
	oap.period_name,
	&segment_columns_grp
	rcv_acct.item_number,
	rcv_acct.item_description,
	-- Revision for version 1.13
	rcv_acct.item_type,
	-- Revision for version 1.12
	rcv_acct.category1,
	rcv_acct.category2,
         -- End revision for version 1.12
	rcv_acct.accounting_line_type,
	flv.meaning,
	pl.displayed_field,
	-- Fix for version 1.9
	rcv_acct.po_num,
	rcv_acct.po_line,
	rcv_acct.release_num,
	-- End fix for version 1.9
	pp.name,
	-- Fix for version 1.9
	rcv_acct.wip_job,
	rcv_acct.bom_resource,
	-- End fix for version 1.9
	rcv_acct.primary_uom_code,
	gl.currency_code
-- Revision for version 1.13
order by
	nvl(gl.short_name, gl.name), -- Ledger
	haou2.name, -- Operating_Unit
	rcv_acct.organization_code, -- Org_Code
	oap.period_name, -- Period_Name
	&segment_columns_grp
	rcv_acct.item_number, -- Item_Number
	rcv_acct.accounting_line_type, -- Accounting_Line_Type
	flv.meaning, -- Transaction_Type
	pl.displayed_field, -- Destination Type
	rcv_acct.po_num, -- PO_Number
	rcv_acct.po_line, -- PO_Line
	rcv_acct.release_num, -- Rel Num
	rcv_acct.wip_job, -- WIP_Job
	rcv_acct.bom_resource -- Resource_Code