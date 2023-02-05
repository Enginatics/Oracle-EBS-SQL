/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII WIP Pending Cost Adjustment
-- Description: Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues and WIP resource (labor) transactions, including gross costs, profit in inventory (commonly abbreviated as PII or ICP - InterCompany Profit).  (Note that resource overheads / production overheads are not included in this report version.)  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session.   And if you choose Yes for "Include All WIP Jobs" all WIP jobs will be reported even if there are no valuation changes.

-- =================================================================
Copyright 2022 Douglas Volz Consulting, Inc.
All rights reserved.
Permission to use this code is granted provided the original author is  acknowledged
Original Author: Douglas Volz (doug@volzconsulting.com)
-- =================================================================

Hidden Parameters:
p_sign_pii:  Hidden parameter to set the sign of the profit in inventory amounts.  This parameter determines if PII is normally entered as a positive or negative amount.

Displayed Parameters:
Cost Type (New):  the new cost type to be reported, mandatory
Cost Type (Old):  the old cost type to be reported, mandatory
PII Cost Type (New):  the new PII_Cost_Type you wish to report
PII Cost Type(Old):  the prior or old PII_Cost_Type you wish to report such as PII or ICP (mandatory)
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (mandatory)
Currency Conversion Date (New):  the new currency conversion date, mandatory
Currency Conversion Date (Old):   the old currency conversion date, mandatory
Currency Conversion Type (New):  the desired currency conversion type to use for cost type 1, mandatory
Currency Conversion Type (Old ):  the desired currency conversion type to use for cost type 2, mandatory
To Currency Code:  the currency you are converting into
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category_Set
Category Set 2:  the second item category set to report, typically the Inventory Category_Set
All WIP Jobs:  enter No to only report WIP jobs with valuation changes, enter Yes to report all WIP jobs.
Org Code:  specific inventory organization you wish to report (optional)
Operating Unit:  operating unit you wish to report, leave blank for all operating units (optional) 
Ledger:  general ledger you wish to report, leave blank for all ledgers (optional)

-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.6 08 Jun 2022 Douglas Volz   Create PII version based on WIP Pending Cost Adjust Rept.

-- Excel Examle Output: https://www.enginatics.com/example/cac-icp-pii-wip-pending-cost-adjustment/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-wip-pending-cost-adjustment/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name)					Ledger,
-- ==========================================================
-- Get the Material_Cost and Value Cost Adjustments
-- ==========================================================
	haou2.name							Operating_Unit,
	mp.organization_code						Org_Code,
	haou.name							Organization_Name,
-- End revision for version 1.6
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
	-- End revision for version 1.1,
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
	end								New_Gross_Item_Cost,
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)
	end								Old_Gross_Item_Cost,
	-- End revision for version 1.1
-- Revision for version 1.6 for PII
-- ========================================================
-- Select the PII item costs from Cost_Type 1 and 2
-- ========================================================
	round(nvl(pii1.item_cost,0),5)					New_PII_Cost,
	round(nvl(pii2.item_cost,0),5)					Old_PII_Cost,
-- ========================================================
-- Select the net item costs from Cost_Type 1 and 2
-- ========================================================
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.item_cost,0),5)		
	end - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii1.item_cost,0),5)	New_Net_Item_Cost,
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)
	end - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii2.item_cost,0),5)	Old_Net_Item_Cost,
-- End revision for version 1.6 for PII		
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
	end								Gross_Item_Cost_Difference,
	--case
	--  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = 0 then 0
	--  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic1.item_cost,0),5) then  100
	--  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic2.item_cost,0),5) then -100
	--  else round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) / nvl(cic2.item_cost,0) * 100,1)
	--end								Gross_Percent Difference,
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
	end,2)								Gross_Percent_Difference,
	-- End of revision for version 1.1
-- Revision for version 1.6 for PII
-- ========================================================
-- Select the PII costs from Cost_Type 1 and 2 and compare
-- ========================================================
	round(nvl(pii1.item_cost,0),5) - round(nvl(pii2.item_cost,0),5)	PII_Item_Cost_Difference,
	case
	  when round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)),5) = 0 then 0
	  when round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)),5) = round(nvl(pii1.item_cost,0),5) then  100
	  when round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)),5) = round(nvl(pii2.item_cost,0),5) then -100
	  else round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) / nvl(pii2.item_cost,0) * 100,1)
	end								PII_Percent_Difference,
-- ========================================================
-- Select the net item costs from Cost_Type 1 and 2 and compare
-- ========================================================
	(case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
	   else round(nvl(cic1.item_cost,0),5)		
	 end - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii1.item_cost,0),5)
	) -
	(case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)
	 end - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii2.item_cost,0),5)
	)								Net_Item_Cost_Difference,
-- End revision for version 1.6 for PII
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
	   ,2))								New_Gross_WIP_Value,

-- Revision for version 1.6 for PII
	round(nvl(pii1.item_cost,0) * decode(sign(:p_sign_pii),1,1,-1,-1,1) * sumwip.quantity,2) New_PII_Value,
	round(( case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
		   else round(nvl(cic1.item_cost,0),5)		
		end - decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii1.item_cost,0)) * sumwip.quantity,2) New_Net_WIP_Value,
-- End revision for version 1.6 for PII
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)		
	end * sumwip.quantity
	   ,2))								Old_Gross_WIP_Value,
-- Revision for version 1.6 for PII
	round(nvl(pii2.ITEM_COST,0) * decode(sign(:p_sign_pii),1,1,-1,-1,1) * sumwip.quantity,2) Old_PII_Value,
	round(( case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
		   else round(nvl(cic2.item_cost,0),5)		
		end - decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii2.item_cost,0)) * sumwip.quantity,2) Old_Net_WIP_Value,
-- End revision for version 1.6 for PII
	-- Revision for version 1.2
	-- WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- New_WIP_Value - Old_WIP_Value = WIP_Value_Difference
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
	   ,2))								Gross_WIP_Value_Difference,
	-- End revision for version 1.1
	-- Revision for version 1.4, show absolute difference
	-- Revision for version 1.2
	-- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	abs(decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- New_WIP_Value - Old_WIP_Value = WIP_Value_Difference
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
	   ,2)))							Abs_WIP_Value_Difference,
	-- End revision for version 1.4
-- Revision for version 1.6 for PII
	round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) * sumwip.quantity,2) PII_Value_Difference,
	-- WIP item cost diff
	round(( case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
		   else round(nvl(cic1.item_cost,0),5)		
		end -
	 	case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
		   else round(nvl(cic2.item_cost,0),5)		
		end -
	-- PII item cost diff
	     decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0))) *
	-- WIP quantity
		sumwip.quantity,2)					Net_WIP_Value_Difference,
-- End revision for version 1.6 for PII
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
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- End revision for version 1.1
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
-- WIP_Values expressed in the To Currency, new values at 
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
	   ,2))								"&p_to_currency_code New Gross WIP Value",
	-- Revision for version 1.3
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	round(
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
	   else round(nvl(cic2.item_cost,0),5)		
	end * sumwip.quantity * gdr2.conversion_rate
	   ,2))								"&p_to_currency_code Old Gross WIP Value",
	-- Revision for version 1.2
	-- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- USD New WIP Cost - USD Old WIP Cost
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
	   ,2))								"&p_to_currency_code Gross WIP Value Diff",
	-- End revision for version 1.1
	-- Revision for version 1.4, show absolute difference
	-- Revision for version 1.2
	-- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
	abs(decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
	-- USD New WIP Cost - USD Old WIP Cost
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
	   ,2)))							"&p_to_currency_code Abs WIP Value Diff",
	-- End revision for version 1.4
-- Revision for version 1.6 for PII
-- ===========================================================
-- PII Values in USD, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
	round(nvl(pii1.item_cost,0) * gdr1.conversion_rate * sumwip.quantity,2) "&p_to_currency_code New PII Value",
	round(nvl(pii2.item_cost,0) * gdr2.conversion_rate * sumwip.quantity,2) "&p_to_currency_code Old PII Value",
	-- USD New PII Cost - USD Old PII Cost
	round(( (nvl(pii1.item_cost,0) * gdr1.conversion_rate) -
		(nvl(pii2.item_cost,0) * gdr2.conversion_rate)) *
	-- multiplied by the total WIP quantity 
		sumwip.quantity,2)					"&p_to_currency_code PII Value Difference",
-- ===========================================================
-- Net Values in USD, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
	-- USD New Gross WIP Cost - USD New PII Cost
	round(((case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
		   else round(nvl(cic1.item_cost,0),5)		
		end * gdr1.conversion_rate) -
		decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * gdr1.conversion_rate)) *
	-- multiplied by the total WIP quantity 
		sumwip.quantity,2)					"&p_to_currency_code New Net Value",
	-- USD Old Gross WIP Cost - USD Old PII Cost
	round(((case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
		   else round(nvl(cic2.item_cost,0),5)		
		end * gdr2.conversion_rate) -
		decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * gdr2.conversion_rate)) *
	-- multiplied by the total WIP quantity 
		sumwip.quantity,2)					"&p_to_currency_code Old Net Value",
	-- USD New Net Value less USD Old Net Value
	-- USD New Gross WIP Cost - USD Old PII Cost
	round((((case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
		   else round(nvl(cic1.item_cost,0),5)		
		end * gdr1.conversion_rate) -
		decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * gdr1.conversion_rate))  - 
	-- USD Old Gross WIP Cost - USD Old PII Cost
	       ((case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
		   else round(nvl(cic2.item_cost,0),5)		
		end * gdr2.conversion_rate) -
		decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * gdr2.conversion_rate))) *
	-- multiplied by the total WIP quantity 
		sumwip.quantity,2)					"&p_to_currency_code Net Value Difference",
-- End revision for version 1.6 for PII
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
	-- multiplied by the total WIP quantity
	sumwip.quantity,2))						"&p_to_currency_code Gross Value Diff-New Rate",
-- Revision for version 1.6 for PII
	-- NEW PII at new fx conversion rate minus OLD PII at new fx conversion rate
	round(( (nvl(pii1.item_cost,0) * gdr1.conversion_rate) - 
		(nvl(pii2.item_cost,0) * gdr1.conversion_rate)) *
	-- multiplied by the total WIP quantity
	sumwip.quantity,2)						"&p_to_currency_code PII Value Diff-New Rate",
	-- USD Gross Value Diff-New Rate less USD PII Value Diff-New Rate
	-- USD Gross Value Diff-New Rate
	round(((case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr1.conversion_rate
		   else round(nvl(cic1.item_cost,0),5) * gdr1.conversion_rate	
		end * gdr1.conversion_rate) - 
		(case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr1.conversion_rate
		   else round(nvl(cic2.item_cost,0),5) * gdr1.conversion_rate	
		 end * gdr1.conversion_rate)) *
	-- multiplied by the total WIP quantity
		sumwip.quantity,2) -
	round(( decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * gdr1.conversion_rate) - 
		decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * gdr1.conversion_rate)) *
	-- multiplied by the total WIP quantity
		sumwip.quantity,2)					"&p_to_currency_code Net Value Diff-New Rate",
-- End revision for version 1.6 for PII
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
	-- multiplied by the total WIP quantity
	sumwip.quantity,2))						"&p_to_currency_code Gross Value Diff-Old Rate",
-- Revision for version 1.6 for PII
	-- NEW PII at old fx conversion rate minus OLD PII at old fx conversion rate
	round(( (nvl(pii1.item_cost,0) * gdr2.conversion_rate) - 
		(nvl(pii2.item_cost,0) * gdr2.conversion_rate)) *
	-- multiplied by the total WIP quantity
		sumwip.quantity,2)					"&p_to_currency_code PII Value Diff-Old Rate",
	-- USD Gross Value Diff-Old Rate less USD PII Value Diff-Old Rate
	-- USD Gross Value Diff-Old Rate
	round(((case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr2.conversion_rate	
		   else round(nvl(cic1.item_cost,0),5) * gdr2.conversion_rate	
		end * gdr2.conversion_rate) - 
		(case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr2.conversion_rate	
		   else round(nvl(cic2.item_cost,0),5) * gdr2.conversion_rate	
		 end * gdr2.conversion_rate)) * sumwip.quantity,2) -
	-- USD PII Value Diff-Old Rate
	round(( decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * gdr2.conversion_rate) - 
		decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * gdr2.conversion_rate)) *
	-- multiplied by the total WIP quantity
		sumwip.quantity,2)					"&p_to_currency_code Net Value Diff-Old Rate",
-- End revision for version 1.6 for PII
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
		round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)  * gdr1.conversion_rate
	   else round(nvl(cic1.item_cost,0),5) * gdr1.conversion_rate	
	end -
	-- Old_Item_Cost						
	case
	   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr1.conversion_rate	
	   else round(nvl(cic2.item_cost,0),5) * gdr1.conversion_rate	
	end) *
	-- multiplied by the total WIP quantity
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
		round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)  * gdr2.conversion_rate	
	   else round(nvl(cic2.item_cost,0),5) * gdr2.conversion_rate	
	end) *
	-- multiplied by the total WIP quantity
	sumwip.quantity,2))						"&p_to_currency_code Gross Value FX Diff",
-- Revision for version 1.6 for PII
	-- USD PII Value Diff-New Rate less USD PII Value Diff-Old Rate
	-- USD PII Value Diff-New Rate
	round(( (nvl(pii1.item_cost,0) * gdr1.conversion_rate) - 
		(nvl(pii2.item_cost,0) * gdr1.conversion_rate)) *
		sumwip.quantity,2) -
	-- USD PII Value Diff-Old Rate
	round(( (nvl(pii1.item_cost,0) * gdr2.conversion_rate) - 
		(nvl(pii2.item_cost,0) * gdr2.conversion_rate)) *
		sumwip.quantity,2) 					"&p_to_currency_code PII Value FX Diff",
	-- USD Gross Value FX Diff. less USD PII Value FX Diff
	-- USD Gross Value FX Diff.
	round(((case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr1.conversion_rate	
		   else round(nvl(cic1.item_cost,0),5) * gdr1.conversion_rate	
		end * gdr1.conversion_rate) - 
		(case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)  * gdr1.conversion_rate	
		   else round(nvl(cic2.item_cost,0),5) * gdr1.conversion_rate	
		 end * gdr1.conversion_rate)) * sumwip.quantity,2) -
	round(((case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr2.conversion_rate	
		   else round(nvl(cic1.item_cost,0),5) * gdr2.conversion_rate	
		end * gdr2.conversion_rate) - 
		(case
		   when	sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
			round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)  * gdr2.conversion_rate	
		   else round(nvl(cic2.item_cost,0),5) * gdr2.conversion_rate	
		 end * gdr2.conversion_rate)) * sumwip.quantity,2) -
	-- USD PII Value FX Diff
	round(( decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * gdr1.conversion_rate) - 
		decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * gdr1.conversion_rate)) * sumwip.quantity,2) -
	-- USD PII Value Diff-Old Rate
	round(( decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * gdr2.conversion_rate) - 
		decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii2.item_cost,0) * gdr2.conversion_rate)) *
	sumwip.quantity,2)						"&p_to_currency_code Net Value FX Diff"
--