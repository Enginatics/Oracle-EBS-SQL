/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Pending Cost Adjustment
-- Description: Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues and WIP resource (labor) transactions.  (Note that resource overheads / production overheads are not included in this report version.)  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session.   And if you choose Yes for "Include All WIP Jobs" all WIP jobs will be reported even if there are no valuation changes.

-- |  Copyright 2020 Douglas Volz Consulting, Inc.                               |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged                                                               |                                                  |
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Parameters:
-- |  p_cost_type1        -- The new cost type to be reported, mandatory
-- |  p_cost_type2        -- The old cost type to be reported, mandatory
-- |  p_curr_conv_date1   -- the new currency conversion date, mandatory
-- |  p_curr_conv_date2   -- the old currency conversion date, mandatory
-- |  p_curr_conv_type1   -- the desired currency conversion type to use for cost type 1, mandatory
-- |  p_curr_conv_type2   -- the desired currency conversion type to use for cost type 2, mandatory
-- |  p_to_currency_code  -- the currency you are converting into
-- |  p_category_set1     -- The first item category set to report, typically the
-- |                         Cost or Product Line Category_Set
-- |  p_category_set2     -- The second item category set to report, typically the
-- |                         Inventory Category_Set
-- |  p_all_wip_jobs      -- Enter No to only report WIP jobs with valuation changes, enter
-- |                         Yes to report all WIP jobs.
-- |  p_assembly_number   -- Enter the specific assembly number you wish to report (optional)
-- |  p_component_number  -- Enter the specific component number you wish to report (optional)
-- |  p_wip_job           -- Specific WIP job (optional)
-- |  p_wip_class_code    -- Specific WIP class code (optional)
-- |  p_org_code          -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit    -- Operating_Unit you wish to report, leave blank for all
-- |                         operating units (optional) 
-- |  p_ledger            -- general ledger you wish to report, leave blank for all
-- |                         ledgers (optional)
-- |  Description:
-- |  Report to show the standard cost adjustments for work in process.  For 
-- |  assemblies, components, resources (both labor and outside processing) and
-- |  assembly completions cost changes.  With the material, material mark-up, 
-- |  material overhead, resource, OSP and overhead cost information broken out.  
-- |
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 05 Dec 2020 Douglas Volz   Created initial Report based on the Pending
-- |                                     Cost Adjustment Report for Inventory and Intransit.                         
-- |      1.3 10 Feb 2021 Douglas Volz   Fixes for WIP completion quantities, needed to
-- |                                     change the SIGN of completion quantities.
-- |      1.4 17 Feb 2021 Douglas Volz   Add absolute difference column.
-- |      1.5 13 Dec 2021 Douglas Volz   Add parameter to report all WIP jobs, even
-- |                                     if there is no valuation change.

-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-pending-cost-adjustment/
-- Library Link: https://www.enginatics.com/reports/cac-wip-pending-cost-adjustment/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name)					Ledger,
-- ==========================================================
-- Get the Material_Cost and Value Cost Adjustments
-- ==========================================================
	haou2.name							Operating_Unit,
	mp.organization_code						Org_Code,
	haou.name							Organization_Name,
	sumwip.class_code						WIP_Class,
	ml1.meaning							Class_Type,
	we.wip_entity_name						WIP_Job,
	ml2.meaning							Job_Status,
	sumwip.date_released						Date_Released,
	sumwip.date_completed						Date_Completed,
	sumwip.last_update_date						Last_Update_Date,
	msiv.concatenated_segments					Item_Number,
	msiv.description						Item_Description,
&category_columns
	fcl.meaning							Item_Type,
	misv.inventory_item_status_code_tl				Item_Status,
	ml3.meaning							Make_Buy_Code,
	ml4.meaning							Supply_Type,
	sumwip.transaction_type						Transaction_Type,
	sumwip.resource_code						Resource_Code,
	sumwip.op_seq_num						Operation_Seq_Number,
	sumwip.res_seq_num						Resource_Seq_Number,
	ml5.meaning							Basis_Type,
	gl.currency_code						Currency_Code,
	muomv.uom_code							UOM_Code,
-- ==========================================================
-- Select the new and old item costs from Cost_Type 1 and 2
-- ==========================================================
	round(nvl(cic1.material_cost,0),5)				New_Material_Cost,
	round(nvl(cic2.material_cost,0),5)				Old_Material_Cost,
	-- Revision for version 1.1, remove tl_material_overhead for
	-- assembly completions and only for WIP Standard Discrete Jobs
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.material_overhead_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.material_overhead_cost,0),5)		
	end								New_Material_Overhead_Cost,
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.material_overhead_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.material_overhead_cost,0),5)		
	end								Old_Material_Overhead_Cost,
	-- End revision for version 1.1
	round(nvl(cic1.resource_cost,0),5)				New_Resource_Cost,
	round(nvl(cic2.resource_cost,0),5)				Old_Resource_Cost,
	round(nvl(cic1.outside_processing_cost,0),5)			New_Outside_Processing_Cost,
	round(nvl(cic2.outside_processing_cost,0),5)			Old_Outside_Processing_Cost,
	round(nvl(cic1.overhead_cost,0),5)				New_Overhead_Cost,
	round(nvl(cic2.overhead_cost,0),5)				Old_Overhead_Cost,
	-- Revision for version 1.1, remove tl_material_overhead for
	-- assembly completions and only for WIP Standard Discrete Jobs
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.item_cost,0),5)		
	end								New_Item_Cost,
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)		
	end								Old_Item_Cost,
-- ========================================================
-- Select the item costs from Cost_Type 1 and 2 and compare
-- ========================================================
	-- New_Item_Cost - Old_Item_Cost = Item_Cost_Difference
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.item_cost,0),5)		
	end	-
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)		
	end								Item_Cost_Difference,
	--case
	--  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = 0 then 0
	--  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic1.item_cost,0),5) then  100
	--  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic2.item_cost,0),5) then -100
	--  else round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) / nvl(cic2.item_cost,0) * 100,1)
	--end								Percent_Difference,
	round(
	case
	   -- when new cost - old cost = 0 then 0
	   when	case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
		   else round(nvl(cic1.item_cost,0),5)		
		end	-
		case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
		   else round(nvl(cic2.item_cost,0),5)
		end
		= 0 then 0
	   -- when new cost - old cost = new cost then 100
	   when	case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
		   else round(nvl(cic1.item_cost,0),5)		
		end	-
		case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
		   else round(nvl(cic2.item_cost,0),5)
		end	=
		case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
		   else round(nvl(cic1.item_cost,0),5)
		end
		then 100
 	   -- when new cost - old cost = old cost then -100
	   when	case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
		   else round(nvl(cic1.item_cost,0),5)		
		end	-
		case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
		   else round(nvl(cic2.item_cost,0),5)
		end	=
		case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
		   else round(nvl(cic2.item_cost,0),5)
		end
		then -100
	   -- else (new cost - old cost) / old cost
	   else	
		(case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
		   else round(nvl(cic1.item_cost,0),5)		
		 end	-
		 case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
		   else round(nvl(cic2.item_cost,0),5)
		 end) /
		 case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
		   else round(nvl(cic2.item_cost,0),5)
		 end
	end,2)								Percent_Difference,
	-- End of revision for version 1.1
-- ===========================================================
-- Select the WIP quantities and values
-- ===========================================================
	muomv.uom_code							UOM_Code,
	-- Revision for version 1.2
	-- Show the WIP Completion Quantity as a positive number
	-- to match the Oracle WIP Std Cost Adjustment Report
	-- decode(sumwip.txn_source, 'WIP Completion', -1 * sumwip.quantity, sumwip.quantity) WIP_Quantity,
	sumwip.quantity							WIP_Quantity,
	-- End revision for version 1.2
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- Revision for version 1.1
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.item_cost,0),5)		
	end * sumwip.quantity
	   ,2))								New_Onhand_Value,
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)		
	end * sumwip.quantity
	   ,2))								Old_Onhand_Value,
	-- Revision for version 1.2
	-- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- New_Onhand_Value - Old_Onhand_Value = Onhand_Value_Difference
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.item_cost,0),5)		
	end * sumwip.quantity
	   ,2) -
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)		
	end * sumwip.quantity
	   ,2))								Onhand_Value_Difference,
	-- End revision for version 1.1
	-- Revision for version 1.4, show absolute difference
	-- Revision for version 1.2
	-- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	abs(decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- New_Onhand_Value - Old_Onhand_Value = Onhand_Value_Difference
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.item_cost,0),5)		
	end * sumwip.quantity
	   ,2) -
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)		
	end * sumwip.quantity
	   ,2)))							Abs_Onhand_Value_Difference,
	-- End revision for version 1.4
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
	gdr1.conversion_rate						New_FX_Rate,
	gdr2.conversion_rate						Old_FX_Rate,
	gdr1.conversion_rate - gdr2.conversion_rate			Exchange_Rate_Difference,
-- ===========================================================
-- Select To Currency WIP quantities and values
-- ===========================================================
-- ===========================================================
-- Costs in To Currency by Cost_Element, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(nvl(cic1.material_cost,0) * gdr1.conversion_rate
	* sumwip.quantity,2))						"&p_to_currency_code New Material Value",
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(nvl(cic2.material_cost,0) * gdr2.conversion_rate
	* sumwip.quantity,2))						"&p_to_currency_code Old Material Value",
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- Revision for version 1.1
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.material_overhead_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.material_overhead_cost,0),5)		
	end * sumwip.quantity * gdr1.conversion_rate
	   ,2))								"&p_to_currency_code New Material Ovhd Value",
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.material_overhead_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.material_overhead_cost,0),5)		
	end * sumwip.quantity * gdr2.conversion_rate
	   ,2))								"&p_to_currency_code Old Material Ovhd Value",
	-- End revision for version 1.1
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(nvl(cic1.resource_cost,0) * gdr1.conversion_rate
	* sumwip.quantity,2))						"&p_to_currency_code New Resource Value",
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(nvl(cic2.resource_cost,0) * gdr2.conversion_rate
	* sumwip.quantity,2))						"&p_to_currency_code Old Resource Value",
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(nvl(cic1.outside_processing_cost,0) * gdr1.conversion_rate
	* sumwip.quantity,2))						"&p_to_currency_code New OSP Value",
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(nvl(cic2.outside_processing_cost,0) * gdr2.conversion_rate
	* sumwip.quantity,2))						"&p_to_currency_code Old OSP Value",
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(nvl(cic1.overhead_cost,0) * gdr1.conversion_rate
	* sumwip.quantity,2))						"&p_to_currency_code New Overhead Value",
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(nvl(cic2.overhead_cost,0) * gdr2.conversion_rate
	* sumwip.quantity,2))						"&p_to_currency_code Old Overhead Value",
-- ===========================================================
-- WIP Values expressed in the To Currency, new values at 
-- the new Fx rate and old values at old Fx rate
-- ===========================================================
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- Revision for version 1.1
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.item_cost,0),5)		
	end * sumwip.quantity * gdr1.conversion_rate
	   ,2))								"&p_to_currency_code New Onhand Value",
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)		
	end * sumwip.quantity * gdr2.conversion_rate
	   ,2))								"&p_to_currency_code Old Onhand Value",
	-- Revision for version 1.2
	-- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- USD New Onhand Cost - USD Old Onhand Cost
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.item_cost,0),5)		
	end * sumwip.quantity * gdr1.conversion_rate
	   ,2)	-
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)		
	end * sumwip.quantity * gdr2.conversion_rate
	   ,2))								"&p_to_currency_code Onhand Value Difference",
	-- End revision for version 1.1
	-- Revision for version 1.4, show absolute difference
	-- Revision for version 1.2
	-- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	abs(decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- USD New Onhand Cost - USD Old Onhand Cost
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.item_cost,0),5)		
	end * sumwip.quantity * gdr1.conversion_rate
	   ,2)	-
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)		
	end * sumwip.quantity * gdr2.conversion_rate
	   ,2)))								"&p_to_currency_code Abs Onhand Value Diff",
	-- End revision for version 1.4
-- ===========================================================
-- Value Differences in To Currency using the new rate
-- New and Old costs at New Fx Rate
-- ===========================================================
	-- Revision for version 1.2
	-- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- Revision for version 1.1
	-- NEW COST at new fx conversion rate minus OLD COST at new fx conversion rate
	-- New_Item_Cost
	round(
	(case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr1.conversion_rate	
	   else round(nvl(cic1.item_cost,0),5) * gdr1.conversion_rate	
	end -
	-- Old_Item_Cost						
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr1.conversion_rate
	   else round(nvl(cic2.item_cost,0),5) * gdr1.conversion_rate	
	end) *
	-- multiplied by the total onhand quantity
	sumwip.quantity,2))						"&p_to_currency_code Value Difference-New Rate",
-- ===========================================================
-- Value Differences in To Currency using the old rate
-- New and Old costs at Old Fx Rate
-- ===========================================================
	-- Revision for version 1.2
	-- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- NEW COST at old fx conversion rate minus OLD COST at old fx conversion rate
	-- New_Item_Cost
	round(
	(case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr2.conversion_rate
	   else round(nvl(cic1.item_cost,0),5) * gdr2.conversion_rate	
	end -
	-- Old_Item_Cost						
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr2.conversion_rate
	   else round(nvl(cic2.item_cost,0),5) * gdr2.conversion_rate	
	end) *
	-- multiplied by the total onhand quantity
	sumwip.quantity,2))						"&p_to_currency_code Value Difference-Old Rate",
-- ===========================================================
-- Value Differences comparing the new less the old rate differences
-- ===========================================================
	-- Revision for version 1.2
	-- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- USD Value Diff-New Rate less USD Value Diff-Old Rate
	-- NEW COST at new fx conversion rate minus OLD COST at new fx conversion rate
	-- New_Item_Cost
	round(
	(case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr1.conversion_rate	
	   else round(nvl(cic1.item_cost,0),5) * gdr1.conversion_rate	
	end -
	-- Old_Item_Cost						
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr1.conversion_rate	
	   else round(nvl(cic2.item_cost,0),5) * gdr1.conversion_rate	
	end) *
	-- multiplied by the total onhand quantity
	sumwip.quantity,2)) -
	-- Revision for version 1.2
	-- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- NEW COST at old fx conversion rate minus OLD COST at old fx conversion rate
	-- New_Item_Cost
	round(
	(case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr2.conversion_rate
	   else round(nvl(cic1.item_cost,0),5) * gdr2.conversion_rate	
	end -
	-- Old_Item_Cost						
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr2.conversion_rate
	   else round(nvl(cic2.item_cost,0),5) * gdr2.conversion_rate	
	end) *
	-- multiplied by the total onhand quantity
	sumwip.quantity,2))						"&p_to_currency_code Value FX Difference"
from	mtl_system_items_vl msiv,
	mtl_units_of_measure_vl muomv,
	mtl_item_status_vl misv,
	wip_entities we,
	mtl_parameters mp,
	mfg_lookups ml1,  -- WIP_Class_Type
	mfg_lookups ml2,  -- WIP_Job_Status
	mfg_lookups ml3,  -- Planning Make_Buy_Code
	mfg_lookups ml4,  -- WIP_Supply_Type
	mfg_lookups ml5,  -- WIP Basis_Type
	fnd_common_lookups fcl,
	hr_organization_information hoi,
	hr_all_organization_units_vl haou,  -- inv_organization_id
	hr_all_organization_units_vl haou2, -- operating unit
	-- gl_code_combinations gcc,
	gl_ledgers gl,
	-- ===========================================================================
	-- Select New Currency Rates based on the new concurrency conversion date
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
	 and	exists (
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
			and	gdr1.from_currency            = gl.currency_code
			-- Do not report the master inventory organization
			and	mp.organization_id           <> mp.master_organization_id
			   )
	 and	gdr1.conversion_type       = gdct1.conversion_type
	 and	4=4                        -- p_curr_conv_date1
	 and	5=5                        -- p_curr_conv_type1
	 union all
	 select	gl.currency_code,              -- from_currency
		gl.currency_code,              -- to_currency
		gdct1.user_conversion_type,    -- user_conversion_type                                        -- p_curr_conv_date1
		:p_curr_conv_date1,            -- conversion_date                                             -- p_curr_conv_date1
		1                              -- conversion_rate
	 from	gl_ledgers gl,
		gl_daily_conversion_types gdct1
	 where	5=5                            -- user_conversion_type                                        -- p_user_conversion_type
	 group by
		gl.currency_code,
		gl.currency_code,
		gdct1.user_conversion_type,
		:p_curr_conv_date1,            -- conversion_date                                             -- p_curr_conv_date1
		1
	) gdr1, -- NEW Currency Rates
	-- ===========================================================================
	-- Select Old Currency Rates based on the old concurrency conversion date
	-- ===========================================================================
	(select	gdr2.from_currency,
		gdr2.to_currency,
		gdct2.USER_CONVERSION_TYPE,
		gdr2.conversion_date,
		gdr2.conversion_rate
	 from	gl_daily_rates gdr2,
		gl_daily_conversion_types gdct2
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
			 and	gdr2.to_currency              = gl.currency_code
			 -- Do not report the master inventory organization
			 and	mp.organization_id   <> mp.master_organization_id
			)
	 and	exists (
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
			and	gdr2.from_currency            = gl.currency_code
			-- Do not report the master inventory organization
			and	mp.organization_id   <> mp.master_organization_id
			   )
	 and	gdr2.conversion_type       = gdct2.conversion_type
	 and	6=6                        -- p_curr_conv_date2 
	 and	7=7                        -- p_curr_conv_type2
	 union all
	 select	gl.currency_code,              -- from_currency
		gl.currency_code,              -- to_currency
		gdct2.user_conversion_type,    -- user_conversion_type
		:p_curr_conv_date2,            -- conversion_date                                             -- p_curr_conv_date2
		1                              -- conversion_rate	
	 from	gl_ledgers gl,
		gl_daily_conversion_types gdct2
	 where	7=7                            -- user_conversion_type                                        -- p_user_conversion_type
	 group by
		gl.currency_code,
		gl.currency_code,
		gdct2.user_conversion_type,
		:p_curr_conv_date2,            -- conversion_date                                             -- p_curr_conv_date2
		1
	) gdr2,  -- OLD Currency Rates
	-- =================================================
	-- Get the item costs for Cost_Type 1 - New Costs
	-- =================================================
	(select	cic1.organization_id 			organization_id,
		cic1.inventory_item_id 			inventory_item_id,
		-999					resource_id,
		nvl(cic1.material_cost,0)		material_cost,
	 	nvl(cic1.material_overhead_cost,0)	material_overhead_cost,
		nvl(cic1.resource_cost,0)		resource_cost,
		nvl(cic1.outside_processing_cost,0)	outside_processing_cost,
		nvl(cic1.overhead_cost,0)		overhead_cost,
		nvl(cic1.item_cost,0)			item_cost,
		-- Revision for version 1.1
		nvl(cic1.tl_material_overhead,0)	tl_material_overhead
	 from	cst_item_costs	cic1,
		cst_cost_types	cct1,
		mtl_parameters	mp
	 where	cct1.cost_type_id           = cic1.cost_type_id
	 and	cic1.organization_id        = mp.organization_id
	 -- Do not report the master inventory organization
	 and	mp.organization_id   <> mp.master_organization_id
	 and	8=8                         -- p_cost_type1
	 and	9=9                         -- p_org_code
	 union all
	 -- =============================================================
	 -- Get the costs from the frozen cost type that is not in cost
	 -- type 1 so that all of the inventory value is reported
	 -- =============================================================
	 select	cic_frozen.organization_id 			organization_id,
		cic_frozen.inventory_item_id 			inventory_item_id,
		-999						resource_id,
		nvl(cic_frozen.material_cost,0)			material_cost,
	 	nvl(cic_frozen.material_overhead_cost,0)	material_overhead_cost,
		nvl(cic_frozen.resource_cost,0)			resource_cost,
		nvl(cic_frozen.outside_processing_cost,0)	outside_processing_cost,
		nvl(cic_frozen.overhead_cost,0)			overhead_cost,
		nvl(cic_frozen.item_cost,0)			item_cost,
		-- Revision for version 1.1
		nvl(cic_frozen.tl_material_overhead,0)		tl_material_overhead
	 from	cst_item_costs	cic_frozen,
		cst_cost_types	cct1,
		mtl_parameters	mp
	 where	cic_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
	 -- Do not report the master inventory organization
	 and	mp.organization_id   <> mp.master_organization_id
	 and	8=8                         -- p_cost_type1
	 and	9=9                         -- p_org_code
	 -- =============================================================
	 -- If p_cost_type1 = frozen cost_type_id then we have all the 
	 -- costs and don't need this union all statement
	 -- =============================================================
	 and	cct1.cost_type_id	   <> 1  -- frozen cost type
	 and	cic_frozen.organization_id  = mp.organization_id
	 -- Revision for version 1.2, parameter to only_items_in_cost_type
	 and	13=13
	 -- =============================================================
	 -- Check to see if the costs exist in cost type 1 
	 -- =============================================================
	 and not exists (
			select	'x'
			from	cst_item_costs cic1
			where	cic1.cost_type_id      = cct1.cost_type_id
			and	cic1.organization_id   = cic_frozen.organization_id
			and	cic1.inventory_item_id = cic_frozen.inventory_item_id
		    )
	 ) cic1,
	-- =================================================
	-- Get the item costs for Cost_Type 2 - Old Costs
	-- =================================================
	(select	cic2.organization_id 			organization_id,
		cic2.inventory_item_id 			inventory_item_id,
		-999					resource_id,
		nvl(cic2.material_cost,0)		material_cost,
	 	nvl(cic2.material_overhead_cost,0)	material_overhead_cost,
		nvl(cic2.resource_cost,0)		resource_cost,
		nvl(cic2.outside_processing_cost,0)	outside_processing_cost,
		nvl(cic2.overhead_cost,0)		overhead_cost,
		nvl(cic2.item_cost,0)			item_cost,
		-- Revision for version 1.1
		nvl(cic2.tl_material_overhead,0)	tl_material_overhead
	 from	cst_item_costs	cic2,
		cst_cost_types	cct2,
		mtl_parameters	mp
	 where	cct2.cost_type_id           = cic2.cost_type_id
	 and	cic2.organization_id        = mp.organization_id
	 -- Do not report the master inventory organization
	 and	mp.organization_id   <> mp.master_organization_id
	 and	9=9                         -- p_org_code
	 and	10=10                       -- p_cost_type2
	 union all
	 -- =============================================================
	 -- Get the costs from the frozen cost type that is not in cost
	 -- type 2 so that all of the inventory value is reported
	 -- =============================================================
	 select	cic_frozen.organization_id 			organization_id,
		cic_frozen.inventory_item_id 			inventory_item_id,
		-999						resource_id,
		nvl(cic_frozen.material_cost,0)			material_cost,
	 	nvl(cic_frozen.material_overhead_cost,0)	material_overhead_cost,
		nvl(cic_frozen.resource_cost,0)			resource_cost,
		nvl(cic_frozen.outside_processing_cost,0)	outside_processing_cost,
		nvl(cic_frozen.overhead_cost,0)			overhead_cost,
		nvl(cic_frozen.item_cost,0)			item_cost,
		-- Revision for version 1.1
		nvl(cic_frozen.tl_material_overhead,0)		tl_material_overhead
	 from	cst_item_costs	cic_frozen,
		cst_cost_types	cct2,
		mtl_parameters	mp
	 where	cic_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
	 -- Do not report the master inventory organization
	 and	mp.organization_id   <> mp.master_organization_id
	 -- ===========================