/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII WIP Material Usage Variance
-- Description: Report your material usage variances for your open and closed WIP jobs.  If the job is open the Report Type column displays "Valuation", as this WIP job and potential material usage variance is still in your WIP inventory balances.  If the job has been closed during the reporting period, the Report Type column displays "Variance", as this WIP job was written off on a WIP Job Close Variance transaction during the reporting period.  You can report period periods and this report will automatically adjust the assembly completion quantities and component issue quantities to reflect what it was for the specified reported accounting period.  And by specifying the profit in inventory (PII) cost type you can determine how much PII or ICP (intercompany profit) was either remaining on your balance sheet or how much was recorded as part of your WIP job close variances.


/* +=============================================================================+
-- |  Copyright 2009 - 2019 Douglas Volz Consulting, Inc.                        |
-- |  Permission to use this code is granted provided the original authors are   |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Authors: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_wip_mtl_usage_var_rept.sql.sql
-- |
-- |  Parameters:
-- |  p_period_name       -- Enter the Period Name you wish to report for WIP Period
-- |                         balances (mandatory)
-- |  p_pii_cost_type     -- The name of the cost type that has that 
-- |                         month's PII costs (mandatory)
-- |  p_pii_resource_code -- The sub-element or resource for profit in inventory,
-- |                         such as PII or ICP (mandatory)
-- |  p_report_type       -- You can choose to limit the report size with this
-- |                         parameter.  The choices are:  Open jobs, All jobs or
-- |                         Closed jobs. (mandatory)
-- |  p_assembly_number   -- Enter the specific assembly number you wish to report (optional)
-- |  p_component_number  -- Enter the specific component number you wish to report (optional)
-- |  p_show_phantom_comp -- Show phantom components, default to No (N) (mandatory)
-- |  p_wip_job           -- Specific WIP job (optional)
-- |  p_job_status        -- Specific WIP job status (optional)
-- |  p_wip_class_code    -- Specific WIP class code (optional)
-- |  p_org_code          -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit    -- Operating Unit you wish to report, leave blank for all
-- |                         operating units (optional) 
-- |  p_ledger            -- general ledger you wish to report, leave blank for all
-- |                         ledgers (optional)
-- |
-- |  Rules:
-- |  If component issue qty = zero, there is no PII as the components are in onhand inventory
-- |  If component issue qty - required qty > 0, PII = PII item cost X "Est. Qty in WIP"
-- |  If component issue qty - required qty < 0, PII = PII item cost X "Est. Qty in WIP"
-- |  This will offset the overstatement of PII in the onhand inventory.
-- |
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== =============== =========================================
-- |  1.0     11 Oct 2020 Douglas Volz    Initial Coding Based on ICP WIP Component 
-- |                                      Variances and ICP WIP Component Valuation 
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-icp-pii-wip-material-usage-variance/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-wip-material-usage-variance/
-- Run Report: https://demo.enginatics.com/

select	(case
	 when	wdj.date_closed >= oap.period_start_date
	   and	trunc (wdj.date_closed) < oap.schedule_close_date + 1
	   then	'Variance'
	 when	wdj.date_closed is null     -- the job is open
	   and	trunc (wdj.creation_date) <= oap.schedule_close_date
	   then	'Valuation'
	 when	wdj.date_closed is not null -- the job is closed and ...the job was closed after the accounting period
	   and	trunc (wdj.date_closed) > oap.schedule_close_date
	   then	'Valuation'
	end) Report_Type,
	gl.name Ledger,
	haou2.name Operating_Unit,
	mp.organization_code Org_Code,
	oap.period_name Period_Name,
	&segment_columns
	wac.class_code WIP_Class,
	ml1.meaning Class_Type,
	we.wip_entity_name WIP_Job,
	ml2.meaning Job_Status,
	wdj.date_completed Date_Completed,
	wdj.date_closed Date_Closed,
	wdj.last_update_date Last_Updated,
	muomv.uom_code UOM_Code,
	wdj.start_quantity Start_Quantity,
	wdj.quantity_completed Assembly_Quantity_Completed,
	wdj.quantity_scrapped Assembly_Quantity_Scrapped,
	wdj.quantity_completed + wdj.quantity_scrapped Total_Assembly_Quantity,
	msiv.concatenated_segments Assembly,
	msiv.description Assembly_Description,
	nvl((select	max(mc.category_concat_segs)
	     from	apps.mtl_categories_v mc,
			apps.mtl_item_categories mic,
			apps.mtl_category_sets_b mcs,
			apps.mtl_category_sets_tl mcs_tl
	     where	mic.category_set_id         = mcs.category_set_id
	     and	2=2				-- p_category_set1 
	     and	mic.inventory_item_id       = msiv.inventory_item_id
	     and	mic.organization_id         = msiv.organization_id
	     and	mc.category_id              = mic.category_id
	     and	mcs.category_set_id         = mcs_tl.category_set_id
	     and	mcs_tl.language             = userenv('lang')
	),'') "&p_category_set1",
	nvl((select	max(mc.category_concat_segs)
	     from	apps.mtl_categories_v mc,
			apps.mtl_item_categories mic,
			apps.mtl_category_sets_b mcs,
			apps.mtl_category_sets_tl mcs_tl
	     where	mic.category_set_id         = mcs.category_set_id
	     and	3=3				-- p_category_set2
	     and	mic.inventory_item_id       = msiv.inventory_item_id
	     and	mic.organization_id         = msiv.organization_id
	     and	mc.category_id              = mic.category_id
	     and	mcs.category_set_id         = mcs_tl.category_set_id
	     and	mcs_tl.language             = userenv('lang')
	),'') "&p_category_set2",
	msiv2.concatenated_segments Component,
	msiv2.description Component_Description,
	gl.currency_code Currency_Code,
	sum(nvl(cic.item_cost,0)) Gross_Item_Cost,
	sum(nvl(pii.item_cost,0)) PII_Item_Cost,
	muomv.uom_code UOM_Code,
	-- a basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
	sum((decode(wro.basis_type, 
			null, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1),
			1,    nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1),
			2,    nvl(wro.required_quantity,1),
			      nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1)
		   )
	    )
	   ) Quantity_Per_Assembly,
	-- ===========================================
	-- Total Required Quantity before any adjustments
	-- ===========================================
	-- If the job was open for the entered Period Name use the planned start quantities unless completion quantities exist
	-- If the job was closed for the entered Period Name use the quantity completed plus scrap quantities
	-- a basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
	round(
	(case
	  -- variance, job is closed in the reported period
	  when wdj.date_closed >= oap.period_start_date and trunc(wdj.date_closed) < oap.schedule_close_date + 1
		then	
		sum(decode(wro.basis_type,
				null, nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					 (nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped, 0)),
				1,    nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					 (nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped, 0)),
				2,    nvl(wro.required_quantity,1),
				      nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					 (nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0))
			  )
		   )                         
	  -- valuation, job is open and the job was created before the end of the accounting period
	  when wdj.date_closed is null and trunc(wdj.creation_date) <= oap.schedule_close_date
		then	
		sum(decode(wro.basis_type,
				null, nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				1,    nvl(wro.quantity_per_assembly, wdj.start_quantity) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				2,    nvl(wro.required_quantity,1),
				      nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0)))
			  )
		   )
	  -- valuation, job is closed but the job was closed after the accounting period scheduled close date
	  when wdj.date_closed is not null and trunc (wdj.date_closed) > oap.schedule_close_date
		then	
		sum(decode(wro.basis_type,
				null, nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				1,    nvl(wro.quantity_per_assembly, wdj.start_quantity) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				2,    nvl(wro.required_quantity,1),
				      nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0)))
			  )
		   )
	end) ,3) Total_Required_Quantity,
	sum(nvl(wro.quantity_issued,0)) Quantity_Issued,
	-- ===========================================
	-- Quantity Left in WIP = Quantity Issued minus the Quantity Required 
	-- ===========================================
	round(sum(nvl(wro.quantity_issued, 0)),3) -
	-- If the job was open for the entered Period Name use the planned start quantities unless completion quantities exist
	-- If the job was closed for the entered Period Name use the quantity completed plus scrap quantities
	-- a basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
	round(
	(case
	  -- variance, job is closed in the reported period
	  when wdj.date_closed >= oap.period_start_date and trunc(wdj.date_closed) < oap.schedule_close_date + 1
		then	
		sum(decode(wro.basis_type,
				null, nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					 (nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped, 0)),
				1,    nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					 (nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped, 0)),
				2,    nvl(wro.required_quantity,1),
				      nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					 (nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0))
			  )
		   )                         
	  -- valuation, job is open and the job was created before the end of the accounting period
	  when wdj.date_closed is null and trunc(wdj.creation_date) <= oap.schedule_close_date
		then	
		sum(decode(wro.basis_type,
				null, nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				1,    nvl(wro.quantity_per_assembly, wdj.start_quantity) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				2,    nvl(wro.required_quantity,1),
				      nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0)))
			  )
		   )
	  -- valuation, job is closed but the job was closed after the accounting period scheduled close date
	  when wdj.date_closed is not null and trunc (wdj.date_closed) > oap.schedule_close_date
		then	
		sum(decode(wro.basis_type,
				null, nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				1,    nvl(wro.quantity_per_assembly, wdj.start_quantity) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				2,    nvl(wro.required_quantity,1),
				      nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0)))
			  )
		   )
	end) ,3) Quantity_Left_in_WIP,
	-- ===========================================
	-- Material Usage Variance = Quantity Left in WIP X item cost
	-- ===========================================
	round(
	(round(sum(nvl(wro.quantity_issued, 0)),3) -
	-- If the job was open for the entered Period Name use the planned start quantities unless completion quantities exist
	-- If the job was closed for the entered Period Name use the quantity completed plus scrap quantities
	-- a basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
	 round(
	 (case
	  -- variance, job is closed in the reported period
	  when wdj.date_closed >= oap.period_start_date and trunc(wdj.date_closed) < oap.schedule_close_date + 1
		then	
		sum(decode(wro.basis_type,
				null, nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					 (nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped, 0)),
				1,    nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					 (nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped, 0)),
				2,    nvl(wro.required_quantity,1),
				      nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					 (nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0))
			  )
		   )                         
	  -- valuation, job is open and the job was created before the end of the accounting period
	  when wdj.date_closed is null and trunc(wdj.creation_date) <= oap.schedule_close_date
		then	
		sum(decode(wro.basis_type,
				null, nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				1,    nvl(wro.quantity_per_assembly, wdj.start_quantity) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				2,    nvl(wro.required_quantity,1),
				      nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0)))
			  )
		   )
	  -- valuation, job is closed but the job was closed after the accounting period scheduled close date
	  when wdj.date_closed is not null and trunc (wdj.date_closed) > oap.schedule_close_date
		then	
		sum(decode(wro.basis_type,
				null, nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				1,    nvl(wro.quantity_per_assembly, wdj.start_quantity) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0))),
				2,    nvl(wro.required_quantity,1),
				      nvl(wro.quantity_per_assembly, 0) * 1 / nvl(wro.component_yield_factor, 1) *
					decode(nvl(wdj.quantity_completed,0),
						0, wdj.start_quantity,
						(nvl(wdj.quantity_completed, 0) + nvl(wdj.quantity_scrapped, 0)))
			  )
		   )
	 end) ,3)
	) * sum(nvl(cic.item_cost,0)),2) Material_Usage_Variance,
	-- ===========================================
	-- Total Required Quantity after adjustments, if the qty issued is zero there is no PII
	-- ===========================================
	-- If the quantity issued is zero there is no PII as, there are no qtys in WIP and the components are still in onhand inventory
	-- If the job is open or closed for the entered Period Name use the quantity completed plus scrap quantities - based on actuals, not planned
	round(sum((nvl(wro.quantity_issued,0) - 
		-- a basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
		decode(wro.basis_type, 
			null, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
				(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
			1,    nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
				(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
			2,    nvl(wro.required_quantity,1), 
			      nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
				(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0))
		      ) * decode(nvl(wro.quantity_issued,0),0,0,1)
		  )
		 ) 
	   ,2) Adjusted_Quantity_in_WIP,
	-- ===========================================
	-- PII in WIP = Total Required Quantity after adjustments
	-- ===========================================
	-- If the quantity issued is zero there is no PII as there are no qtys in WIP and the components are still in onhand inventory
	-- If the job is open or closed for the entered Period Name use the quantity completed plus scrap quantities - based on actuals, not planned
	round(sum((nvl(wro.quantity_issued,0) - 
		-- a basis of 2 indicates the component is issued per lot not per assembly and the component yield factor is ignored
		decode(wro.basis_type, 
			null, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
				(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
			1,    nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
				(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
			2,    nvl(wro.required_quantity,1), 
			      nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
				(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0))
		      )
		  ) * nvl(pii.item_cost,0) * decode(nvl(wro.quantity_issued,0),0,0,1)
		 )
	   ,2) PII_in_WIP,
	round(sum((nvl(wro.quantity_issued,0) -
			-- a basis of 2 indicates the component is issued per lot not per assembly, and the component yield factor is ignored
			decode(wro.basis_type, 
				null, nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) * 
					(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
				1,    nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) *
					(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0)),
				2,    nvl(wro.required_quantity,1), 
				      nvl(wro.quantity_per_assembly,0) * 1/nvl(wro.component_yield_factor,1) * 
					(nvl(wdj.quantity_completed,0) + nvl(wdj.quantity_scrapped,0))
			      )
		  ) * (nvl(cic.item_cost,0) + nvl(pii.item_cost,0)) * decode(nvl(wro.quantity_issued,0),0,0,1)
		 )
	   ,2) Net_Material_Usage_Variance
from	org_acct_periods oap,
	wip_entities we,
	wip_accounting_classes wac,
	-- get the corrected wip qty completed and qty scrapped
	(select wdjsum.wip_entity_id,
	 wdjsum.organization_id,
	 wdjsum.class_code,
	 wdjsum.date_closed,
	 wdjsum.date_completed,
	 wdjsum.last_update_date,
	 wdjsum.creation_date,
	 wdjsum.primary_item_id,
	 wdjsum.status_type,
	 wdjsum.start_quantity,
	 wdjsum.net_quantity,
	 wdjsum.project_id,
	 sum (wdjsum.quantity_completed) quantity_completed,
	 sum (wdjsum.quantity_scrapped) quantity_scrapped
	 -- Get the corrected WIP Job quantities
	 from	(select	wdj.wip_entity_id,
			wdj.organization_id,
			wdj.class_code,
			wdj.date_closed,
			wdj.date_completed,
			wdj.last_update_date,
			wdj.creation_date,
			wdj.primary_item_id,
			wdj.status_type,
			wdj.start_quantity,
	 		wdj.net_quantity,
			wdj.project_id,
			wdj.quantity_completed,
			wdj.quantity_scrapped
		 from	wip_discrete_jobs wdj,
			org_acct_periods oap
		 where	oap.organization_id            = wdj.organization_id
		 and	7=7                            -- p_period_name
		 -- find jobs that were open or closed during or after the report period
			  -- the job is open or opened before the period close date
		 and	( (wdj.date_closed is null -- the job is open
			   and trunc(wdj.creation_date) <=  oap.schedule_close_date
			   and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_type
			  )
			  or -- the job is closed and ...the job was closed after the accounting period 
			  (wdj.date_closed is not null
			   and trunc(wdj.date_closed) > oap.schedule_close_date
			   and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_type
			  )
			  or -- find jobs that were closed during the report period
			  (wdj.date_closed >= oap.period_start_date
			   and trunc(wdj.date_closed) < oap.schedule_close_date + 1
			   and :p_report_option in ('Closed jobs', 'All jobs')  -- p_report_type
			  )
			)
		 union all
		 select	mmt.transaction_source_id,-- wip_entity_id
			mmt.organization_id,
			wdj.class_code,
			wdj.date_closed,
			wdj.date_completed,
			wdj.last_update_date,
			wdj.creation_date,
			wdj.primary_item_id,
			wdj.status_type,
			wdj.start_quantity,
	 		wdj.net_quantity,
			wdj.project_id,
			decode(mmt.transaction_type_id,
				90, 0,                         -- scrap assemblies from wip
				91, 0,                         -- return assemblies scrapped from wip
				44, -1 * mmt.primary_quantity, -- wip completion
				17, mmt.primary_quantity       -- wip completion return
			      ) quantity_completed,
			decode(mmt.transaction_type_id,
				90, mmt.primary_quantity,      -- scrap assemblies from wip
				91, -1 * mmt.primary_quantity, -- return assemblies scrapped from wip
				44, 0,                         -- wip completion
				17, 0                          -- wip completion return
			      ) quantity_scrapped
		 from	mtl_material_transactions mmt,
			wip_discrete_jobs wdj,
			org_acct_periods oap
		 where	mmt.transaction_source_type_id = 5
		 and	mmt.transaction_source_id      = wdj.wip_entity_id
		 and	mmt.transaction_date          >= oap.schedule_close_date + 1
		 and	7=7                            -- p_period_name
		 and	oap.organization_id            = mmt.organization_id
		 -- find jobs that were open or closed during or after the report period
		 and	( (wdj.date_closed is null -- the job is open
			   and trunc(wdj.creation_date) <=  oap.schedule_close_date
			   and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_type
			  )
			  or -- the job is closed and ...the job was closed after the accounting period 
			  (wdj.date_closed is not null
			   and trunc(wdj.date_closed) > oap.schedule_close_date
			   and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_type
			  )
			  or -- find jobs that were closed during the report period
			  (wdj.date_closed >= oap.period_start_date
			   and trunc(wdj.date_closed) < oap.schedule_close_date + 1
			   and :p_report_option in ('Closed jobs', 'All jobs')  -- p_report_type
			  )
			)
		 -- disable an index to increase performance
		 and oap.acct_period_id + 0 = mmt.acct_period_id) wdjsum
		 group by
			wdjsum.wip_entity_id,
			wdjsum.organization_id,
			wdjsum.class_code,
			wdjsum.date_closed,
			wdjsum.date_completed,
			wdjsum.last_update_date,
			wdjsum.creation_date,
			wdjsum.primary_item_id,
			wdjsum.status_type,
			wdjsum.start_quantity,
			wdjsum.net_quantity,
			wdjsum.project_id) wdj,
	-- get the corrected wip component issue quantities
	(select	wrosum.wip_entity_id,
		wrosum.organization_id,
		wrosum.inventory_item_id,
		wrosum.operation_seq_num,
		wrosum.quantity_per_assembly,
		sum(wrosum.required_quantity) required_quantity,
		wrosum.component_yield_factor,
		sum (wrosum.quantity_issued) quantity_issued,
		wrosum.basis_type basis_type,
		wrosum.wip_supply_type
	 from	(select	wro.wip_entity_id,
			wro.organization_id,
			wro.inventory_item_id,
			wro.operation_seq_num,
			wro.quantity_per_assembly,
			wro.required_quantity,
			wro.component_yield_factor,
			wro.quantity_issued,
			wro.basis_type,
			wro.wip_supply_type
		 from	wip_requirement_operations wro,
			wip_discrete_jobs wdj,
			org_acct_periods oap
		 where	wdj.wip_entity_id              = wro.wip_entity_id
		 and	wdj.organization_id            = wro.organization_id
		 and	wdj.organization_id            = oap.organization_id
		 and	7=7                            -- p_period_name
		 -- find jobs that were open or closed during or after the report period
		 and	( (wdj.date_closed is null -- the job is open
			   and trunc(wdj.creation_date) <=  oap.schedule_close_date
			   and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_type
			  )
			  or -- the job is closed and ...the job was closed after the accounting period 
			  (wdj.date_closed is not null
			   and trunc(wdj.date_closed) > oap.schedule_close_date
			   and :p_report_option in ('Open jobs', 'All jobs')    -- p_report_type
			  )
			  or -- find jobs that were closed during the report period
			  (wdj.date_closed >= oap.period_start_date
			   and trunc(wdj.date_closed) < oap.schedule_close_date + 1
			   and :p_report_option in ('Closed jobs', 'All jobs')  -- p_report_type
			  )
			)
		 union all
		 select	mmt.transaction_source_id,
			wro.organization_id,
			mmt.inventory_item_id,
			mmt.operation_seq_num,
			wro.quantity_per_assembly,
			wro.required_quantity,
			wro.component_yield_factor,
			decode(mmt.transaction_type_id,
				35, mmt.primary_quantity,     -- wip component issue
 				43, -1 * mmt.primary_quantity -- wip component return
			      ) quantity_issued,
			wro.basis_type,
			wro.wip_supply_type
		 from	mtl_material_transactions mmt,
			wip_discrete_jobs wdj,
			wip_requirement_operations wro,
			org_acct_periods oap
		 where	mmt.transaction_source_type_id = 5
		 and	mmt.transaction_source_id      = wdj.wip_entity_id
		 and	wro.wip_entity_id              = mmt.transaction_source_id
		 and	wro.organization_id            = mmt.organization_id
		 and	mmt.operation_seq_num          = wro.operation_seq_num
		 and	mmt.transaction_date          >= oap.schedule_close_date + 1
		 and	oap.organization_id            = mmt.organization_id
		 and	7=7                            -- p_period_name
		 -- find jobs that were open or closed during or after the report period
		 and	( (wdj.date_closed is null -- the job is open
			   and trunc(wdj.creation_date) <=  oap.schedule_close_date
			   and :p_report_option in ('Open jobs', 'All jobs')             -- p_report_type
			  )
			  or -- the job is closed and ...the job was closed after the accounting period 
			  (wdj.date_closed is not null
			   and trunc(wdj.date_closed) > oap.schedule_close_date
			   and :p_report_option in ('Open jobs', 'All jobs')             -- p_report_type
			  )
			  or -- find jobs that were closed during the report period
			  (wdj.date_closed >= oap.period_start_date
			   and trunc(wdj.date_closed) < oap.schedule_close_date + 1
			   and :p_report_option in ('Closed jobs', 'All jobs')           -- p_report_type
			  )
			)
		 -- disable an index to increase performance
		 and oap.acct_period_id + 0 = mmt.acct_period_id) wrosum
 	 group by
		wrosum.wip_entity_id,
		wrosum.organization_id,
		wrosum.inventory_item_id,
		wrosum.operation_seq_num,
		wrosum.quantity_per_assembly,
		wrosum.component_yield_factor,
		wrosum.basis_type,
		wrosum.wip_supply_type) wro,
	mtl_parameters mp,
	mtl_system_items_vl msiv,
	mtl_system_items_vl msiv2,
	cst_item_costs cic,
	mtl_units_of_measure_vl muomv,
	mtl_units_of_measure_vl muomv2,
	pa_projects_all pp,
	mfg_lookups ml1, -- WIP Class Code
	mfg_lookups ml2, -- WIP Job Status
	gl_code_combinations gcc,  -- wip class accounts
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,
	hr_all_organization_units_vl haou2,
	gl_ledgers gl,
	(select	cicd.inventory_item_id,
		cicd.organization_id,
		sum(cicd.item_cost) item_cost
	 from	cst_item_cost_details cicd,
		bom_resources br,
		cst_cost_types cct,
		mtl_parameters mp
	 where	cicd.resource_id     = br.resource_id
	 and	6=6                                            -- p_pii_resource_code
	 and	cicd.cost_type_id    = cct.cost_type_id 
	 and	5=5                                            -- p_pii_cost_type
	 and	cicd.organization_id = mp.organization_id
	 and	4=4                                            -- p_org_code
	 group by
		cicd.inventory_item_id,
		cicd.organization_id
	) pii
-- =================================================================
-- mtl parameter, item master, UOM, item cost and account joins
-- =================================================================
where	we.wip_entity_id            = wdj.wip_entity_id
and	we.organization_id          = wdj.organization_id
and	wdj.class_code              = wac.class_code
and	wdj.organization_id         = wac.organization_id
and	wdj.wip_entity_id           = wro.wip_entity_id
and	wdj.organization_id         = wro.organization_id
and	pp.project_id (+)           = wdj.project_id
and	mp.organization_id          = oap.organization_id
and	mp.organization_id          = we.organization_id
and	mp.organization_id          = msiv.organization_id
and	mp.organization_id          = wdj.organization_id
and	mp.organization_id          = wro.organization_id
and	msiv.organization_id        = we.organization_id
and	msiv.inventory_item_id      = we.primary_item_id    -- fg assembly item
and	msiv.organization_id        = msiv2.organization_id
and	msiv2.inventory_item_id     = wro.inventory_item_id -- component item
and	msiv2.organization_id       = cic.organization_id (+)
and	msiv2.inventory_item_id     = cic.inventory_item_id (+)  -- component item
and	cic.cost_type_id            = mp.primary_cost_method -- gets the costing method costs
and	msiv.primary_uom_code       = muomv.uom_code
and	msiv2.primary_uom_code      = muomv2.uom_code
and	wac.material_account        = gcc.code_combination_id
and	msiv2.inventory_item_id     = pii.inventory_item_id (+)
and	msiv2.organization_id       = pii.organization_id (+)
and	7=7                         -- p_period_name
-- ===========================================
-- Lookup Code joins
-- ===========================================
and	ml1.lookup_type             = 'WIP_CLASS_TYPE'
and	ml1.lookup_code             = wac.class_type
and	ml2.lookup_type             = 'WIP_JOB_STATUS'
and	ml2.lookup_code             = wdj.status_type
-- ===========================================
-- HR Organization joins
-- ===========================================
and	hoi.org_information_context = 'Accounting Information'
and	hoi.organization_id         = mp.organization_id
and	hoi.organization_id         = haou.organization_id  -- this gets the organization name
and	haou2.organization_id       = to_number(hoi.org_information3) -- this gets the operating unit id
and	gl.ledger_id                = to_number(hoi.org_information1) -- get the ledger_id
and	1=1                         -- p_item_number, p_assembly_number, p_component_number, p_show_phantoms, 
                                    -- p_wip_job, p_job_status, p_wip_class_code, p_operating_unit, p_ledger
and	4=4                         -- p_org_code
and	sysdate                    <  nvl(haou.date_to, sysdate +1)
group by
	(case
	 when	wdj.date_closed >= oap.period_start_date
	   and	trunc (wdj.date_closed) < oap.schedule_close_date + 1
	   then	'Variance'
	 when	wdj.date_closed is null     -- the job is open
	   and	trunc (wdj.creation_date) <= oap.schedule_close_date
	   then	'Valuation'
	 when	wdj.date_closed is not null -- the job is closed and ...the job was closed after the accounting period
	   and	trunc (wdj.date_closed) > oap.schedule_close_date
	   then	'Valuation'
	end), -- Report_Type
	gl.name,
	haou2.name,
	mp.organization_code,
	oap.period_name,
	&segment_columns_grp
	wac.class_code,
	we.wip_entity_name,
	ml1.meaning, -- WIP Class Code
	ml2.meaning, -- WIP Job Status
	wdj.date_completed,
	wdj.date_closed,
	wdj.last_update_date,
	muomv.uom_code,
	wdj.start_quantity,
	wdj.quantity_completed,
	wdj.quantity_scrapped,
	wdj.net_quantity,
	msiv.concatenated_segments,
	msiv.description,
	msiv2.concatenated_segments,
	msiv2.description,
	gl.currency_code,
	muomv2.uom_code,
	-- For column selects
	oap.period_start_date, 
	oap.schedule_close_date, 
	trunc(wdj.creation_date),
	msiv.inventory_item_id,
	msiv.organization_id,
	pii.item_cost
order by
	(case
	 when	wdj.date_closed >= oap.period_start_date
	   and	trunc (wdj.date_closed) < oap.schedule_close_date + 1
	   then	'Variance'
	 when	wdj.date_closed is null     -- the job is open
	   and	trunc (wdj.creation_date) <= oap.schedule_close_date
	   then	'Valuation'
	 when	wdj.date_closed is not null -- the job is closed and ...the job was closed after the accounting period
	   and	trunc (wdj.date_closed) > oap.schedule_close_date
	   then	'Valuation'
	end), -- Report_Type
	gl.name, -- Ledger
	haou2.name, -- Operating_Unit
	mp.organization_code, -- Org_Code
	oap.period_name, -- Period_Name
	&segment_columns_grp
	wac.class_code, -- WIP_Class
	we.wip_entity_name, -- WIP_Job
	msiv.concatenated_segments, -- Assembly
	msiv2.concatenated_segments -- Component