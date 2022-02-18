/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Account Summary No SLA
-- Description: Report to get the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update.  And for outside processing, including the purchase order number, line and release number.  For Discrete, Flow and Workorderless WIP but not Repetitive Schedules).  This report version does not use the Release 12 Subledger Accounting (Create Accounting) information; no need to run Create Accounting in order to see transactions on this report.

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
-- |   1.13   11 Mar 2021 Douglas Volz   Added Flow Schedules and Workorderless WIP
-- |                                     and removed redundant joins and tables to 
-- |                                     improve performance.
-- |   1.14   22 Mar 2021 Douglas Volz   Add WIP Job parameter.
-- |   1.15   20 Dec 2021 Douglas Volz   Add WIP Department.
-- +=============================================================================+*/




-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-account-summary-no-sla/
-- Library Link: https://www.enginatics.com/reports/cac-wip-account-summary-no-sla/
-- Run Report: https://demo.enginatics.com/

select	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	wip.organization_code Org_Code,
	oap.period_name Period_Name,
	&segment_columns
	msiv.concatenated_segments Assembly_Number,
	msiv.description Assembly_Description,
	-- Revision for version 1.13
	fcl.meaning item_type,
	-- Revision for version 1.9
&category_columns
         -- End revision for version 1.9
	ml1.meaning Accounting_Line_Type,
	ml2.meaning Transaction_Type,
	wac.class_code WIP_Class,
	ml3.meaning Class_Type,
	-- Revision for version 1.13
	ml4.meaning WIP_Type,
	we.wip_entity_name WIP_Job,
	-- Revision for version 1.15
	bd.department_code WIP_Department,
	-- Fix for version 1.6
	(select	br.resource_code
	 from	bom_resources br
	 where	wip.resource_id = br.resource_id) WIP_Resource,
	(select poh.segment1
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wip.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+)) PO_Number,
	(select pol.line_num
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wip.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+)) PO_Line,
	(select pr.release_num
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wip.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+)) PO_Release,
	-- End fix for version 1.6
	-- Revision for version 1.12
	(select	max(pp.segment1)
	 from	pa_projects_all pp
	 where	pp.project_id     = wip.project_id) Project_Number,
	-- Revision for version 1.11 and 1.12
	(select	max(nvl(muomv.uom_code, br.unit_of_measure))
	 from	bom_resources br,
		mtl_units_of_measure_vl muomv
	 where	wip.resource_id    = br.resource_id
	 and	muomv.uom_code (+) = br.unit_of_measure) UOM_Code,
	round(sum(decode(wip.transaction_type, 
			 'Cost Update', 0,
			 nvl(wip.primary_quantity,0)
			)
		  )
	   ,3) Primary_Quantity,
	-- End revision for version 1.11
	gl.currency_code Currency_Code,
	-- Revision for version 1.11
	sum(decode(wip.cost_element_id,
			1, wip.base_transaction_value,
			0)) Material_Amount,
	sum(decode(wip.cost_element_id,
			2, wip.base_transaction_value,
			0)) Material_Overhead_Amount,
	sum(decode(wip.cost_element_id,
			3, wip.base_transaction_value,
			0)) Resource_Amount,
	sum(decode(wip.cost_element_id,
			4, wip.base_transaction_value,
			0)) Outside_Processing_Amount,
	sum(decode(wip.cost_element_id,
			5, wip.base_transaction_value,
			0)) Overhead_Amount,
	-- End revision for version 1.11
	sum(wip.base_transaction_value) Amount
from	wip_entities we,
	wip_accounting_classes wac,
	mtl_system_items_vl msiv,
	-- Revision for version 1.15
	bom_departments bd,
	org_acct_periods oap,
	gl_code_combinations gcc,
	mfg_lookups ml1,
	mfg_lookups ml2,
	mfg_lookups ml3,
	-- Revision for version 1.13
	mfg_lookups ml4,
	-- Revision for version 1.10
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou, -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl,
	(select	mp.organization_code,
		mp.organization_id,
		wt.acct_period_id,
		wta.reference_account,
		wdj.primary_item_id,
		wta.accounting_line_type,
		wt.transaction_type,
		wdj.class_code,
		wdj.wip_entity_id,
		wta.resource_id,
		-- Revision for version 1.15
		wt.department_id,
		wt.rcv_transaction_id,
		wdj.project_id,
		wta.primary_quantity,
		wta.cost_element_id,
		wta.base_transaction_value,
		wta.wip_sub_ledger_id
	 from	wip_transaction_accounts wta,
		wip_transactions wt,
		wip_discrete_jobs wdj,
		mtl_parameters mp
	 -- ========================================================
	 -- WIP Transaction, org and item joins
	 -- ========================================================
	 where	wt.transaction_id                = wta.transaction_id
	 and	wdj.wip_entity_id                = wta.wip_entity_id
	 and	wdj.organization_id              = wta.organization_id
	 and	mp.organization_id               = wta.organization_id
	 and	2=2                              -- p_org_code, p_wip_Job
	 and	3=3                              -- p_trx_date_from, p_trx_date_to
	 and	4=4                              -- p_wip_job
	 union all
	 select	mp.organization_code,
		mp.organization_id,
		wt.acct_period_id,
		wta.reference_account,
		wfs.primary_item_id,
		wta.accounting_line_type,
		wt.transaction_type,
		wfs.class_code,
		wfs.wip_entity_id,
		wta.resource_id,
		-- Revision for version 1.15
		wt.department_id,
		wt.rcv_transaction_id,
		wfs.project_id,
		wta.primary_quantity,
		wta.cost_element_id,
		wta.base_transaction_value,
		wta.wip_sub_ledger_id
	 from	wip_transaction_accounts wta,
		wip_transactions wt,
		wip_flow_schedules wfs,
		mtl_parameters mp
	 -- ========================================================
	 -- WIP Transaction, org and item joins
	 -- ========================================================
	 where	wt.transaction_id                = wta.transaction_id
	 and	wfs.wip_entity_id                = wta.wip_entity_id
	 and	wfs.organization_id              = wta.organization_id
	 and	mp.organization_id               = wta.organization_id
	 and	2=2                              -- p_org_code, p_wip_Job
	 and	3=3                              -- p_trx_date_from, p_trx_date_to
	 and	4=4                              -- p_wip_job
	) wip
-- ========================================================
-- WIP Transaction, org and item joins
-- ========================================================
where	msiv.organization_id             = wip.organization_id
and	msiv.inventory_item_id           = wip.primary_item_id
-- Revision for version 1.15
and	bd.department_id (+)             = wip.department_id
-- ========================================================
and	wac.class_code                   = wip.class_code
-- Revision for version 1.2
and	wac.organization_id              = wip.organization_id
and	we.wip_entity_id                 = wip.wip_entity_id
-- ========================================================
-- Inventory Org accounting period joins
-- ========================================================
and	oap.acct_period_id               = wip.acct_period_id
and	oap.organization_id              = wip.organization_id
-- ========================================================
-- Version 1.3, added lookup values to see more detail
-- ========================================================
and	ml1.lookup_type                  = 'CST_ACCOUNTING_LINE_TYPE'
and	ml1.lookup_code                  = wip.accounting_line_type
and	ml2.lookup_type                  = 'WIP_TRANSACTION_TYPE_SHORT'
and	ml2.lookup_code                  = wip.transaction_type
and	ml3.lookup_type                  = 'WIP_CLASS_TYPE'
and	ml3.lookup_code                  = wac.class_type
-- Revision for version 1.13
and	ml4.lookup_type                  = 'WIP_ENTITY'
and	ml4.lookup_code                  = we.entity_type
-- ========================================================
-- Version 1.10, added Item_Type lookup values
-- ========================================================
and	fcl.lookup_code (+)              = msiv.item_type
and	fcl.lookup_type (+)              = 'ITEM_TYPE'
-- End revision for version 1.10
-- ========================================================
-- using the base tables to avoid using
-- org_organization_definitions and hr_operating_units
-- ========================================================
and	hoi.org_information_context      = 'Accounting Information'
and	hoi.organization_id              = wip.organization_id
and	hoi.organization_id              = haou.organization_id   -- this gets the organization name
and	haou2.organization_id            = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                     = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                              -- p_assembly_number, p_operating_unit, p_ledger
and	gcc.code_combination_id (+)      = wip.reference_account
-- ==========================================================
group by 
	nvl(gl.short_name, gl.name),
	haou2.name,
	wip.organization_code,
	oap.period_name,
	&segment_columns_grp
	msiv.concatenated_segments,
	msiv.description,
	-- Revision for version 1.10
	fcl.meaning, -- item_type
	ml1.meaning, -- Accounting Line Type
	ml2.meaning, -- WIP Transaction Type
	wac.class_code,
	ml3.meaning, -- WIP Class Type
	-- Revision for version 1.13
	ml4.meaning, -- WIP Entity Type
	we.wip_entity_name,
	-- Fix for version 1.6
	-- Added for inline column selects
	wip.resource_id,
	-- Revision for version 1.15
	bd.department_code,
	wip.rcv_transaction_id,
	-- End fix for version 1.6
	-- Revision for version 1.8
	-- Added for inline column selects
	-- Revision for version 1.12
	wip.project_id,
	msiv.organization_id,
	msiv.inventory_item_id,
	-- End revision for version 1.8
	gl.currency_code
order by 
	-- Fix for version 1.10
	-- 1,3,4,5,6,7,8,9,10,12,13
	nvl(gl.short_name, gl.name),
	haou2.name,
	wip.organization_code,
	oap.period_name,
	&segment_columns_grp
	gcc.segment5,
	msiv.concatenated_segments,
	ml1.meaning, -- Accounting_Line_Type
	ml2.meaning, -- Transaction_Type
	wac.class_code, -- WIP_Class
	-- Revision for version 1.13
	ml4.meaning, -- WIP Entity Type
	we.wip_entity_name, -- WIP_Job
	(select	br.resource_code
	 from	bom_resources br
	 where	wip.resource_id = br.resource_id), -- WIP_Resource
	(select poh.segment1
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wip.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+)), -- PO_Number
	(select pol.line_num
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wip.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+)), -- PO_Line
	(select pr.release_num
	 from	po_headers_all poh,
		po_lines_all pol,
		po_releases_all pr,
		rcv_transactions rt
	 where	rt.transaction_id = wip.rcv_transaction_id
	 and	rt.po_header_id   = poh.po_header_id
	 and	rt.po_line_id     = pol.po_line_id
	 and	rt.po_release_id  = pr.po_release_id (+))