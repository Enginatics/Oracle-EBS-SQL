/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Period Balances to Accounting Activity Reconciliation
-- Description: Report to compare the monthly WIP Period Balances with the pre-Create Accounting WIP accounting entries for material, resource, overhead, outside processing, job close variance and standard cost update transactions.  With WIP class, job status, name and other details.  This report shows both WIP jobs which were open during the accounting period as well as jobs closed during the accounting period.  If the stored WIP period balances agree to the period WIP accounting activity, the "Difference" columns have a zero amount.

//* +=============================================================================+
-- | Copyright 2022 Douglas Volz Consulting, Inc.                                |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_reconcile_wip_balances.sql
-- |
-- |  Parameters:
-- |  p_period_name          -- The desired accounting period you wish to report
-- |  p_org_code             -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit       -- Operating Unit you wish to report, leave blank for all
-- |                            operating units (optional) 
-- |  p_ledger               -- general ledger you wish to report, leave blank for all
-- |                            ledgers (optional)
-- | Description:
-- | Report to compare the monthly WIP transactions against the WIP period balances.
-- |
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     07 Apr 2021 Douglas Volz   Initial Coding based on item_cost_history.sql
-- | 1.1     10 Jul 2022 Douglas Volz   Add Ledger and Operating Unit columns
-- | 1.2     19 Oct 2022 Douglas Volz   Bug fix for missing organization join
-- +=============================================================================+*/



-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-period-balances-to-accounting-activity-reconciliation/
-- Library Link: https://www.enginatics.com/reports/cac-wip-period-balances-to-accounting-activity-reconciliation/
-- Run Report: https://demo.enginatics.com/

select	wipsum.period_name Period_Name,
	-- Revision for version 1.1
	nvl(gl.short_name, gl.name) Ledger,
	haou2.name Operating_Unit,
	-- End revision for version 1.1
	wip.organization_code Org_Code,
	wip.organization_id Org_Id,
	msiv.concatenated_segments Assembly_Number,
	msiv.description Description,
	fcl.meaning Item_Type,
	misv.inventory_item_status_code Item_Status,
	ml1.meaning Make_Buy_Code,
	wac.class_code WIP_Class,
	ml2.meaning Class_Type,
	ml3.meaning WIP_Type,
	wip.wip_entity_name WIP_Job,
	wip.date_closed Date_Closed,
	wip.status Job_Status,
	wip.date_released Date_Released,
	wip.date_completed Date_Completed,
	muomv.uom_code UOM_Code,
	wip.start_quantity Start_Quantity,
	wip.quantity_completed Quantity_Completed,
	wip.quantity_scrapped Quantity_Scrapped,
	wipsum.wip_costs_in WIP_Costs_In,
	wipsum.wip_costs_out WIP_Costs_Out,
	wipsum.wip_close_var WIP_Relief,
	wipsum.wip_value WIP_Value,
	wipsum.wip_acct_in WIP_Accounted_Costs_In,
	wipsum.wip_acct_out WIP_Accounted_Costs_Out,
	wipsum.wip_acct_var WIP_Accounted_Relief,
	wipsum.wip_acct_value WIP_Accounted_Value,
	wipsum.wip_costs_in - wipsum.wip_acct_in WIP_Costs_In_Difference,
	wipsum.wip_costs_out - wipsum.wip_acct_out WIP_Costs_Out_Difference,
	wipsum.wip_close_var  - wipsum.wip_acct_var WIP_Relief_Difference,
	wipsum.wip_value - wipsum.wip_acct_value WIP_Value_Difference
from	wip_accounting_classes wac,
	mtl_system_items_vl msiv,
	mtl_item_status_vl misv,
	mtl_units_of_measure_vl muomv,
	mfg_lookups ml1, -- planning make/buy code
	mfg_lookups ml2, -- class type
	mfg_lookups ml3, -- WIP type
	fnd_common_lookups fcl, -- item type
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	gl_ledgers gl,
	-- ===========================================
	-- Get WIP_Jobs and Flow Schedule information
	-- ===========================================
	(select	mp.organization_id,
		mp.organization_code,
		we.wip_entity_name,
		wdj.wip_entity_id,
		we.entity_type,
		wdj.class_code,
		wdj.date_closed,
		ml.meaning status,
		wdj.date_released,
		wdj.date_completed,
		wdj.start_quantity,
		wdj.quantity_completed,
		wdj.quantity_scrapped,
		wdj.primary_item_id
	 from	wip_discrete_jobs wdj,
		wip_entities we,
		org_acct_periods oap,
		mtl_parameters mp,
		mfg_lookups ml
	 where	we.wip_entity_id               = wdj.wip_entity_id
	 and	oap.organization_id            = wdj.organization_id
	 -- Revision for version 1.2
	 and	mp.organization_id             = wdj.organization_id
	 and	ml.lookup_type                 = 'WIP_JOB_STATUS'
	 and	ml.lookup_code                 = wdj.status_type
	 and	2=2                            -- p_org_code
	 and	3=3                            -- p_period_name
	 -- find jobs that were open or closed during or after the report period
	 -- the job is open or opened before the period close date
	 and	((wdj.date_closed is null -- the job is open
		  and trunc(wdj.creation_date) <=  oap.schedule_close_date
		 )
		  or -- the job is closed and ...the job was closed after the accounting period 
		 (wdj.date_closed is not null
		  and trunc(wdj.date_closed) > oap.schedule_close_date
		 )
		  or -- find jobs that were closed during the report period
		 (wdj.date_closed >= oap.period_start_date 
		  and trunc(wdj.date_closed) < oap.schedule_close_date + 1
		 )
		)
	 union all
	 select	mp.organization_id,
		mp.organization_code,
		we.wip_entity_name,
		wfs.wip_entity_id,
		we.entity_type,
		wfs.class_code,
		wfs.date_closed,
		ml.meaning status,
		wfs.creation_date date_released,
		wfs.date_closed date_completed,
		wfs.planned_quantity start_quantity,
		wfs.quantity_completed,
		0 quantity_scrapped,
		wfs.primary_item_id
	 from	wip_flow_schedules wfs,
		wip_entities we,
		org_acct_periods oap,
		mtl_parameters mp,
		mfg_lookups ml
	 where	we.wip_entity_id               = wfs.wip_entity_id
	 and	we.entity_type                 = 4 -- Flow schedule
	 and	oap.organization_id            = wfs.organization_id
	 -- Revision for version 1.2
	 and	mp.organization_id             = wfs.organization_id
	 and	ml.lookup_type                 = 'WIP_FLOW_SCHEDULE_STATUS'
	 and	ml.lookup_code                 = wfs.status
	 and	2=2                            -- p_org_code
	 and	3=3                            -- p_period_name
	 -- find jobs that were open or closed during or after the report period
	 -- the job is open or opened before the period close date
	 and	((wfs.date_closed is null -- the job is open
		  and trunc(wfs.creation_date) <=  oap.schedule_close_date
		 )
		  or -- the job is closed and ...the job was closed after the accounting period 
		 (wfs.date_closed is not null
		  and trunc(wfs.date_closed) > oap.schedule_close_date
		 )
		  or -- find jobs that were closed during the report period
		 (wfs.date_closed >= oap.period_start_date 
		  and trunc(wfs.date_closed) < oap.schedule_close_date + 1
		 )
		)
	) wip,
	-- ===========================================
	-- Condense WIP Balances and Accounting Entries
	-- ===========================================
	(select	wip.organization_id,
		wip.wip_entity_id,
		wip.period_name,
		wip.acct_period_id,
		sum(wip_costs_in) wip_costs_in,
		sum(wip_costs_out) wip_costs_out,
		sum(wip_close_var) wip_close_var,
		sum(wip_value) wip_value,
		sum(round(wip_acct_in,2)) wip_acct_in,
		sum(round(wip_acct_out,2)) wip_acct_out,
		sum(round(wip_acct_var,2)) wip_acct_var,
		sum(round(wip_acct_value,2)) wip_acct_value
	 from	(
		 -- ===========================================
		 -- Get the WIP Period Balances
		 -- ===========================================
		 select	mp.organization_id,
			wpb.wip_entity_id,
			oap.period_name,
			wpb.acct_period_id,
			sum(nvl(tl_scrap_in,0)+
			nvl(pl_material_in,0)+
			nvl(pl_material_overhead_in,0)+
			nvl(tl_resource_in,0)+
			nvl(pl_resource_in,0)+
			nvl(tl_outside_processing_in,0)+
			nvl(pl_outside_processing_in,0)+
			nvl(tl_overhead_in,0)+
			nvl(pl_overhead_in,0))  wip_costs_in,
			sum(nvl(tl_material_out,0)+
			nvl(tl_scrap_out,0)+
			nvl(pl_material_out,0)+
			nvl(tl_material_overhead_out,0)+
			nvl(pl_material_overhead_out,0)+
			nvl(tl_resource_out,0)+
			nvl(pl_resource_out,0)+
			nvl(tl_outside_processing_out,0)+
			nvl(pl_outside_processing_out,0)+
			nvl(tl_overhead_out,0)+
			nvl(pl_overhead_out,0)) wip_costs_out,
			sum(nvl(tl_material_var,0)+
			nvl(tl_scrap_var,0)+
			nvl(pl_material_var,0)+
			nvl(tl_material_overhead_var,0)+
			nvl(pl_material_overhead_var,0)+
			nvl(tl_resource_var,0)+
			nvl(pl_resource_var,0)+
			nvl(tl_outside_processing_var,0)+
			nvl(pl_outside_processing_var,0)+
			nvl(tl_overhead_var,0)+
			nvl(pl_overhead_var,0)) wip_close_var,
			sum(nvl(tl_scrap_in,0)+
			nvl(pl_material_in,0)-
			nvl(tl_material_out,0)-
			nvl(tl_scrap_out,0)-
			nvl(pl_material_out,0)-
			nvl(tl_material_var,0)-
			nvl(tl_scrap_var,0)-
			nvl(pl_material_var,0)+
			nvl(pl_material_overhead_in,0)-
			nvl(tl_material_overhead_out,0)-
			nvl(pl_material_overhead_out,0)-
			nvl(tl_material_overhead_var,0)-
			nvl(pl_material_overhead_var,0)+
			nvl(tl_resource_in,0)+
			nvl(pl_resource_in,0)-
			nvl(tl_resource_out,0)-
			nvl(pl_resource_out,0)-
			nvl(tl_resource_var,0)-
			nvl(pl_resource_var,0)+
			nvl(tl_outside_processing_in,0)+
			nvl(pl_outside_processing_in,0)-
			nvl(tl_outside_processing_out,0)-
			nvl(pl_outside_processing_out,0)-
			nvl(tl_outside_processing_var,0)-
			nvl(pl_outside_processing_var,0)+
			nvl(tl_overhead_in,0)+
			nvl(pl_overhead_in,0)-
			nvl(tl_overhead_out,0)-
			nvl(pl_overhead_out,0)-
			nvl(tl_overhead_var,0)-
			nvl(pl_overhead_var,0)) wip_value,
			sum(0) wip_acct_in,
			sum(0) wip_acct_out,
			sum(0) wip_acct_var,
			sum(0) wip_acct_value
		 from	wip_period_balances wpb,
			org_acct_periods oap,
			mtl_parameters mp
		 where	mp.organization_id             = wpb.organization_id
		 and	oap.acct_period_id             = wpb.acct_period_id
		 and	2=2                            -- p_org_code
		 and	3=3                            -- p_period_name
		 group by
			mp.organization_id,
			wpb.wip_entity_id,
			oap.period_name,
			wpb.acct_period_id
		 union all
		 -- ===========================================
		 -- Get the WIP Material Transactions
		 -- ===========================================
		 select	mp.organization_id,
			mmt.transaction_source_id wip_entity_id,
			oap.period_name,
			mmt.acct_period_id,
			sum(0) wip_costs_in,
			sum(0) wip_costs_out,
			sum(0) wip_close_var,
			sum(0) wip_value,
			sum(decode(mmt.transaction_type_id,
				35, mta.base_transaction_value, -- WIP Component Issue
				38, mta.base_transaction_value, -- WIP Component Negative Issue
				43, mta.base_transaction_value, -- WIP Return
				48, mta.base_transaction_value, -- WIP Negative Return
				55, mta.base_transaction_value, -- WIP Lot Split
				56, mta.base_transaction_value, -- WIP Lot Merge
				57, mta.base_transaction_value, -- WIP Lot Bonus
				 0)
			   ) wip_acct_in,
			sum(decode(mmt.transaction_type_id,
				17, mta.base_transaction_value * -1, -- WIP Completion Return
				44, mta.base_transaction_value * -1, -- WIP Completion
				90, mta.base_transaction_value * -1, -- WIP Assembly Scrap
				91, mta.base_transaction_value * -1, -- WIP return from scrap
				92, mta.base_transaction_value * -1, -- WIP estimated scrap
				1002, mta.base_transaction_value * -1, -- WIP Byproduct Completion
				1003, mta.base_transaction_value * -1, -- WIP Byproduct Return
				 0)
			   ) wip_acct_out,
			sum(0) wip_acct_var,
			sum(decode(mmt.transaction_type_id,
				35, mta.base_transaction_value, -- WIP Component Issue
				38, mta.base_transaction_value, -- WIP Component Negative Issue
				43, mta.base_transaction_value, -- WIP Return
				48, mta.base_transaction_value, -- WIP Negative Return
				55, mta.base_transaction_value, -- WIP Lot Split
				56, mta.base_transaction_value, -- WIP Lot Merge
				57, mta.base_transaction_value, -- WIP Lot Bonus
				17, mta.base_transaction_value, -- WIP Completion Return
				44, mta.base_transaction_value, -- WIP Completion
				90, mta.base_transaction_value, -- WIP Assembly Scrap
				91, mta.base_transaction_value, -- WIP return from scrap
				92, mta.base_transaction_value, -- WIP estimated scrap
				1002, mta.base_transaction_value, -- WIP Byproduct Completion
				1003, mta.base_transaction_value, -- WIP Byproduct Return
				 0)
			   ) wip_acct_value
		 from	mtl_transaction_accounts mta,
			mtl_material_transactions mmt,
			org_acct_periods oap,
			mtl_parameters mp
		 where	mta.transaction_id             = mmt.transaction_id
		 and	mp.organization_id             = mta.organization_id
		 and	mta.transaction_source_type_id = 5
		 and	mta.accounting_line_type       = 7 -- WIP valuation
		 and	mmt.transaction_date          >= oap.period_start_date
		 and	mmt.transaction_date          <  oap.schedule_close_date + 1
		 and	mta.transaction_date          >= oap.period_start_date
		 and	mta.transaction_date          <  oap.schedule_close_date + 1
		 and	oap.acct_period_id             = mmt.acct_period_id
		 and	2=2                            -- p_org_code
		 and	3=3                            -- p_period_name
		 group by
			mp.organization_id,
			mmt.transaction_source_id,
			oap.period_name,
			mmt.acct_period_id
		 union all
		 -- ===========================================
		 -- Get the WIP_Resource Transactions
		 -- ===========================================
		 select	mp.organization_id,
			wt.wip_entity_id,
			oap.period_name,
			wt.acct_period_id,
			sum(0) wip_costs_in,
			sum(0) wip_costs_out,
			sum(0) wip_close_var,
			sum(0) wip_value,
			sum(decode(wt.transaction_type,
				 1, wta.base_transaction_value, -- Resource transaction
				 2, wta.base_transaction_value, -- Overhead transaction
				 3, wta.base_transaction_value, -- Outside processing
				11, wta.base_transaction_value, -- WIP Lot Split
				12, wta.base_transaction_value, -- WIP Lot Merge
				13, wta.base_transaction_value, -- WIP Lot Bonus
				14, wta.base_transaction_value, -- WIP Lot Quantity Update
				 0)
			   ) wip_acct_in,
			sum(decode(wt.transaction_type,
				15, wta.base_transaction_value, -- Estimated Scrap Absorption
				16, wta.base_transaction_value, -- Estimated Scrap Reallocation
				17, wta.base_transaction_value, -- Direct Shopfloor Delivery
				 0)
			   ) wip_acct_out,
			sum(decode(wt.transaction_type,
				 5, wta.base_transaction_value * -1, -- Period close variance
				 6, wta.base_transaction_value * -1, -- Job close variance
				 7, wta.base_transaction_value * -1, -- Final completion variance
				 0)
			   ) wip_acct_var,
			sum(decode(wt.transaction_type,
				 1, wta.base_transaction_value, -- Resource transaction
				 2, wta.base_transaction_value, -- Overhead transaction
				 3, wta.base_transaction_value, -- Outside processing
				11, wta.base_transaction_value, -- WIP Lot Split
				12, wta.base_transaction_value, -- WIP Lot Merge
				13, wta.base_transaction_value, -- WIP Lot Bonus
				14, wta.base_transaction_value, -- WIP Lot Quantity Update
				15, wta.base_transaction_value, -- Estimated Scrap Absorption
				16, wta.base_transaction_value, -- Estimated Scrap Reallocation
				17, wta.base_transaction_value, -- Direct Shopfloor Delivery
				 5, wta.base_transaction_value, -- Period close variance
				 6, wta.base_transaction_value, -- Job close variance
				 7, wta.base_transaction_value, -- Final completion variance
				 0)
			   ) wip_acct_value
		 from	wip_transaction_accounts wta,
			wip_transactions wt,
			org_acct_periods oap,
			mtl_parameters mp
		 where	wta.transaction_id             = wt.transaction_id
		 and	mp.organization_id             = wta.organization_id
		 and	wta.accounting_line_type       = 7 -- WIP valuation
		 and	wta.transaction_date          >= oap.period_start_date
		 and	wta.transaction_date          <  oap.schedule_close_date + 1
		 and	wt.transaction_date           >= oap.period_start_date
		 and	wt.transaction_date           <  oap.schedule_close_date + 1
		 and	oap.acct_period_id             = wt.acct_period_id
		 and	2=2                            -- p_org_code
		 and	3=3                            -- p_period_name
		 group by
			mp.organization_id,
			wt.wip_entity_id,
			oap.period_name,
			wt.acct_period_id
		 union all
		 -- ===========================================
		 -- Get the WIP Cost Update Transactions
		 -- ===========================================
		 select	mp.organization_id,
			cscav.wip_entity_id,
			oap.period_name,
			oap.acct_period_id,
			sum(0) wip_costs_in,
			sum(0) wip_costs_out,
			sum(0) wip_close_var,
			sum(0) wip_value,
			round(sum(decode(cscav.transaction_type,
				 3, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- WIP component issue
				 6, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- Resource
				 7, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- Resource overhead
				 8, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- Item based overhead
				 9, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- Lot based overhead
				10, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- Resource / Overhead
				 0)
			   ),2) wip_acct_in,
			round(sum(decode(cscav.transaction_type,
				 4, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- WIP assembly completion
				 5, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- WIP scrap transaction
				 0)
			   ),2) wip_acct_out,
			sum(0) wip_acct_var,
			round(sum(decode(cscav.transaction_type,
				 3, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- WIP component issue
				 6, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- Resource
				 7, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- Resource overhead
				 8, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- Item based overhead
				 9, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- Lot based overhead
				10, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost), -- Resource / Overhead
				 4, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost) * cscav.in_out_flag, -- WIP assembly completion
				 5, cscav.adjustment_quantity * (new_unit_cost - old_unit_cost) * cscav.in_out_flag, -- WIP scrap transaction
				 0)
			   ),2) wip_acct_value
		 from	cst_std_cost_adj_values cscav,
			cst_cost_updates ccu,
			org_acct_periods oap,
			mtl_parameters mp
		 where	ccu.cost_update_id             = cscav.cost_update_id
		 and	mp.organization_id             = ccu.organization_id
		 and	ccu.update_date               >= oap.period_start_date
		 and	ccu.update_date               <  oap.schedule_close_date + 1
		 and	oap.organization_id            = ccu.organization_id
		 and	2=2                            -- p_org_code
		 and	3=3                            -- p_period_name
		 group by
			mp.organization_id,
			cscav.wip_entity_id,
			oap.period_name,
			oap.acct_period_id
		) wip
	 group by
	 	wip.organization_id,
		wip.wip_entity_id,
		wip.period_name,
		wip.acct_period_id
	) wipsum
-- ===========================================
-- WIP_Job Entity and accounting period joins
-- ===========================================
where	wip.wip_entity_id               = wipsum.wip_entity_id
and	wac.organization_id             = wip.organization_id
and	wac.class_code                  = wip.class_code
and	msiv.inventory_item_id          = wip.primary_item_id
and	msiv.organization_id            = wip.organization_id
and	msiv.primary_uom_code           = muomv.uom_code
and	msiv.inventory_item_status_code = misv.inventory_item_status_code
and	ml1.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and	ml1.lookup_code                 = msiv.planning_make_buy_code
and	ml2.lookup_type                 = 'WIP_CLASS_TYPE'
and	ml2.lookup_code                 = wac.class_type
and	ml3.lookup_type                 = 'WIP_ENTITY'
and	ml3.lookup_code                 = wip.entity_type
and	fcl.lookup_type (+)             = 'ITEM_TYPE'
and	fcl.lookup_code (+)             = msiv.item_type
-- ===================================================================
-- using the base tables for organizations
-- ===================================================================
and	hoi.org_information_context     = 'Accounting Information'
and	hoi.organization_id             = wip.organization_id
and	hoi.organization_id             = haou.organization_id -- this gets the organization name
-- avoid selecting disabled inventory organizations
and	sysdate < nvl(haou.date_to, sysdate + 1)
and	haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
and	hoi.org_information1            = gl.ledger_id      -- this gets the ledger id
and	1=1                             -- p_operating_unit, p_ledger