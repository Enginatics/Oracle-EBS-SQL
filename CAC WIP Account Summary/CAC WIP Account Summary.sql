/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Account Summary
-- Description: Summary report to get the WIP accounting distributions by WIP job, resource, overhead and WIP cost update. For outside processing, will also include the purchase order number, line and release number.
-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-account-summary/
-- Library Link: https://www.enginatics.com/reports/cac-wip-account-summary/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	oap.period_name Period_Name,
	&segment_columns
	msiv.concatenated_segments Assembly_Number,
	msiv.description Assembly_Description,
	-- Revision for version 1.13
	fcl.meaning item_type,
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
         -- End revision for version 1.9
	ml.meaning Accounting_Line_Type,
	ml2.meaning Transaction_Type,
	wac.class_code WIP_Class,
	ml3.meaning Class_Type,
	we.wip_entity_name WIP_Job,
	-- Fix for version 1.6
	(select	br.resource_code
	 from	bom_resources br
	 where	wta.resource_id = br.resource_id) WIP_Resource,
	(select poh.segment1
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wt.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+)) PO_Number,
	(select pol.line_num
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wt.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+)) PO_Line,
	(select pr.release_num
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wt.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+)) PO_Rel,
	-- End fix for version 1.6
	-- Revision for version 1.12
	(select	max(pp.segment1)
	 from	apps.pa_projects_all pp
	 where	pp.project_id     = wdj.project_id) Project_Number,
	-- Revision for version 1.11 and 1.12
	(select	max(muomv.uom_code)
	 from	bom_resources br,
		mtl_units_of_measure_vl muomv
	 where	wta.resource_id = br.resource_id
	 and	muomv.uom_code = br.unit_of_measure) UOM_Code,
	round(sum(decode(wt.transaction_type, 
			 'Cost Update', 0,
			 nvl(wta.primary_quantity,0)
			)
		  )
	   ,3) Primary_Quantity,
	-- End revision for version 1.11
	gl.currency_code Curr_Code,
	-- Revision for version 1.11
	sum(decode(wta.cost_element_id,
			1, wta.base_transaction_value,
			0)) Material_Amount,
	sum(decode(wta.cost_element_id,
			2, wta.base_transaction_value,
			0)) Material_Overhead_Amount,
	sum(decode(wta.cost_element_id,
			3, wta.base_transaction_value,
			0)) Resource_Amount,
	sum(decode(wta.cost_element_id,
			4, wta.base_transaction_value,
			0)) Outside_Processing_Amount,
	sum(decode(wta.cost_element_id,
			5, wta.base_transaction_value,
			0)) Overhead_Amount,
	-- End revision for version 1.11
	sum(nvl(al.accounted_dr,0) - nvl(al.accounted_cr,0)) Amount
from	wip_transaction_accounts wta,
	wip_transactions wt,
	wip_accounting_classes wac,
	wip_discrete_jobs wdj,
	wip_entities we,
	mfg_lookups ml2,
	mfg_lookups ml3,
	-- Revision for version 1.10
	fnd_common_lookups fcl,
	mtl_system_items_vl msiv,
	org_acct_periods oap,
	gl_code_combinations gcc,
	mtl_parameters mp, 
	mfg_lookups ml, 
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl,
	xla.xla_transaction_entities ent, -- apps synonym is not working
	xla_events xe,
	xla_distribution_links xdl,
	xla_ae_headers ah,
	xla_ae_lines al
-- ========================================================
-- Material Transaction, org and item joins
-- ========================================================
where	wta.transaction_id           = wt.transaction_id
and	wta.organization_id          = msiv.organization_id
-- fix for version 1.1, use wdj not wt
and	wdj.primary_item_id          = msiv.inventory_item_id
and	mp.organization_id           = msiv.organization_id
-- ========================================================
and	wac.class_code               = wdj.class_code
-- Revision for version 1.2
and	wac.organization_id          = wdj.organization_id
and	wdj.wip_entity_id            = wt.wip_entity_id
and	wdj.wip_entity_id            = we.wip_entity_id
-- ========================================================
-- Inventory Org accounting period joins
-- ========================================================
and	oap.acct_period_id           = wt.acct_period_id
and	oap.organization_id          = wt.organization_id
-- ========================================================
-- Version 1.3, added lookup values to see more detail
-- ========================================================
and	ml.lookup_type               = 'CST_ACCOUNTING_LINE_TYPE'
and	ml.lookup_code               = wta.accounting_line_type
and	ml2.lookup_type              = 'WIP_TRANSACTION_TYPE_SHORT'
and	ml2.lookup_code              = wt.transaction_type
and	ml3.lookup_type              = 'WIP_CLASS_TYPE'
and	ml3.lookup_code              = wac.class_type
-- ========================================================
-- Version 1.10, added Item_Type lookup values
-- ========================================================
and	fcl.lookup_code (+)          = msiv.item_type
and	fcl.lookup_type (+)          = 'ITEM_TYPE'
-- End revision for version 1.10
-- ========================================================
-- Material Transaction date and accounting code joins
-- ========================================================
and	1=1                          -- p_trx_date_from, p_trx_date_to, p_item_number, p_org_code, p_operating_unit, p_ledger
-- ========================================================
-- using the base tables to avoid using
-- org_organization_definitions and hr_operating_units
-- ========================================================
and	hoi.org_information_context  = 'Accounting Information'
and	hoi.organization_id          = wta.organization_id
and	hoi.organization_id          = haou.organization_id   -- this gets the organization name
and	haou2.organization_id        = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                 = to_number(hoi.org_information1) -- get the ledger_id
-- ========================================================
-- SLA table joins to get the exact account numbers
-- ========================================================
and	ent.entity_code              = 'WIP_ACCOUNTING_EVENTS'
and	ent.application_id           = 707
and	xe.application_id            = ent.application_id
and	xe.event_id 	             = xdl.event_id
and	ah.entity_id 	             = ent.entity_id
and	ah.ledger_id 	             = ent.ledger_id
and	ah.application_id            = al.application_id
and	ah.event_id                  = xe.event_id
and	ah.ae_header_id              = al.ae_header_id
and	al.application_id            = ent.application_id
and	al.ledger_id                 = ah.ledger_id
and	al.ae_header_id              = xdl.ae_header_id
and	al.ae_line_num 	             = xdl.ae_line_num
and	xdl.application_id           = ent.application_id
and	xdl.source_distribution_type = 'WIP_TRANSACTION_ACCOUNTS'
and	xdl.source_distribution_id_num_1 = wta.wip_sub_ledger_id
and	gcc.code_combination_id (+)  = al.code_combination_id
-- ==========================================================
group by 
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	oap.period_name,
	&segment_columns_grp
	msiv.concatenated_segments,
	msiv.description,
	-- Revision for version 1.10
	fcl.meaning, -- item_type
	ml.meaning,
	ml2.meaning,
	wac.class_code,
	ml3.meaning,
	we.wip_entity_name,
	-- Fix for version 1.6
	-- Added for inline column selects
	wta.resource_id,
	wt.rcv_transaction_id,
	-- End fix for version 1.6
	-- Revision for version 1.8
	-- Added for inline column selects
	msiv.organization_id,
	msiv.inventory_item_id,
	-- End revision for version 1.8
	-- Revision for version 1.12
	wdj.project_id,
	gl.currency_code
order by 
	-- Fix for version 1.10
	-- 1,3,4,5,6,7,8,9,10,12,13
	nvl(gl.short_name, gl.name),
	haou2.name,
	mp.organization_code,
	oap.period_name,
	&segment_columns_grp
	msiv.concatenated_segments,
	ml.meaning, -- Accounting_Line_Type
	ml2.meaning, -- WIP Transaction_Type
	wac.class_code, -- WIP_Class
	we.wip_entity_name, -- WIP_Job
	(select	br.resource_code
	 from	bom_resources br
	 where	wta.resource_id = br.resource_id), -- WIP_Resource
	(select poh.segment1
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wt.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+)), -- PO_Number
	(select pol.line_num
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wt.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+)), -- PO_Line
	(select pr.release_num
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wt.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+))  -- PO_Rel