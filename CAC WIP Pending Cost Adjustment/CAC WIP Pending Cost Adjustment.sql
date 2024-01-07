/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
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

select  nvl(gl.short_name, gl.name)     Ledger,
-- ==========================================================
-- Get the Material_Cost and Value Cost Adjustments
-- ==========================================================
 haou2.name       Operating_Unit,
 mp.organization_code      Org_Code,
 haou.name       Organization_Name,
 sumwip.class_code      WIP_Class,
 ml1.meaning       Class_Type,
 we.wip_entity_name      WIP_Job,
 ml2.meaning       Job_Status,
 sumwip.date_released      Date_Released,
 sumwip.date_completed      Date_Completed,
 sumwip.last_update_date      Last_Update_Date,
 msiv.concatenated_segments     Item_Number,
 msiv.description      Item_Description,
&category_columns
 fcl.meaning       Item_Type,
 misv.inventory_item_status_code_tl    Item_Status,
 ml3.meaning       Make_Buy_Code,
 ml4.meaning       Supply_Type,
 sumwip.transaction_type      Transaction_Type,
 sumwip.resource_code      Resource_Code,
 sumwip.op_seq_num      Operation_Seq_Number,
 sumwip.res_seq_num      Resource_Seq_Number,
 ml5.meaning       Basis_Type,
 gl.currency_code      Currency_Code,
 muomv.uom_code       UOM_Code,
-- ==========================================================
-- Select the new and old item costs from Cost_Type 1 and 2
-- ==========================================================
 round(nvl(cic1.material_cost,0),5)    New_Material_Cost,
 round(nvl(cic2.material_cost,0),5)    Old_Material_Cost,
 -- Revision for version 1.1, remove tl_material_overhead for
 -- assembly completions and only for WIP Standard Discrete Jobs
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.material_overhead_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.material_overhead_cost,0),5)  
 end        New_Material_Overhead_Cost,
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.material_overhead_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.material_overhead_cost,0),5)  
 end        Old_Material_Overhead_Cost,
 -- End revision for version 1.1
 round(nvl(cic1.resource_cost,0),5)    New_Resource_Cost,
 round(nvl(cic2.resource_cost,0),5)    Old_Resource_Cost,
 round(nvl(cic1.outside_processing_cost,0),5)   New_Outside_Processing_Cost,
 round(nvl(cic2.outside_processing_cost,0),5)   Old_Outside_Processing_Cost,
 round(nvl(cic1.overhead_cost,0),5)    New_Overhead_Cost,
 round(nvl(cic2.overhead_cost,0),5)    Old_Overhead_Cost,
 -- Revision for version 1.1, remove tl_material_overhead for
 -- assembly completions and only for WIP Standard Discrete Jobs
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
 end        New_Item_Cost,
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end        Old_Item_Cost,
-- ========================================================
-- Select the item costs from Cost_Type 1 and 2 and compare
-- ========================================================
 -- New_Item_Cost - Old_Item_Cost = Item_Cost_Difference
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
 end -
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end        Item_Cost_Difference,
 --case
 --  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = 0 then 0
 --  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic1.item_cost,0),5) then  100
 --  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic2.item_cost,0),5) then -100
 --  else round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) / nvl(cic2.item_cost,0) * 100,1)
 --end        Percent_Difference,
 round(
 case
    -- when new cost - old cost = 0 then 0
    when case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
     else round(nvl(cic1.item_cost,0),5)  
  end -
  case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
     else round(nvl(cic2.item_cost,0),5)
  end
  = 0 then 0
    -- when new cost - old cost = new cost then 100
    when case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
     else round(nvl(cic1.item_cost,0),5)  
  end -
  case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
     else round(nvl(cic2.item_cost,0),5)
  end =
  case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
     else round(nvl(cic1.item_cost,0),5)
  end
  then 100
     -- when new cost - old cost = old cost then -100
    when case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
     else round(nvl(cic1.item_cost,0),5)  
  end -
  case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
     else round(nvl(cic2.item_cost,0),5)
  end =
  case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
     else round(nvl(cic2.item_cost,0),5)
  end
  then -100
    -- else (new cost - old cost) / old cost
    else 
  (case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
     else round(nvl(cic1.item_cost,0),5)  
   end -
   case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
     else round(nvl(cic2.item_cost,0),5)
   end) /
   case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
     else round(nvl(cic2.item_cost,0),5)
   end
 end,2)        Percent_Difference,
 -- End of revision for version 1.1
-- ===========================================================
-- Select the WIP quantities and values
-- ===========================================================
 muomv.uom_code       UOM_Code,
 -- Revision for version 1.2
 -- Show the WIP Completion Quantity as a positive number
 -- to match the Oracle WIP Std Cost Adjustment Report
 -- decode(sumwip.txn_source, 'WIP Completion', -1 * sumwip.quantity, sumwip.quantity) WIP_Quantity,
 sumwip.quantity       WIP_Quantity,
 -- End revision for version 1.2
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- Revision for version 1.1
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
 end * sumwip.quantity
    ,2))        New_Onhand_Value,
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end * sumwip.quantity
    ,2))        Old_Onhand_Value,
 -- Revision for version 1.2
 -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- New_Onhand_Value - Old_Onhand_Value = Onhand_Value_Difference
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
 end * sumwip.quantity
    ,2) -
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end * sumwip.quantity
    ,2))        Onhand_Value_Difference,
 -- End revision for version 1.1
 -- Revision for version 1.4, show absolute difference
 -- Revision for version 1.2
 -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
 abs(decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- New_Onhand_Value - Old_Onhand_Value = Onhand_Value_Difference
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
 end * sumwip.quantity
    ,2) -
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end * sumwip.quantity
    ,2)))       Abs_Onhand_Value_Difference,
 -- End revision for version 1.4
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
 nvl(gdr1.conversion_rate,1)      New_FX_Rate,
 nvl(gdr2.conversion_rate,1)      Old_FX_Rate,
 nvl(gdr1.conversion_rate,1) - nvl(gdr2.conversion_rate,1)   Exchange_Rate_Difference,
-- ===========================================================
-- Select To Currency WIP quantities and values
-- ===========================================================
-- ===========================================================
-- Costs in To Currency by Cost_Element, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic1.material_cost,0) * nvl(gdr1.conversion_rate,1)
 * sumwip.quantity,2))      "&p_to_currency_code New Material Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic2.material_cost,0) * nvl(gdr2.conversion_rate,1)
 * sumwip.quantity,2))      "&p_to_currency_code Old Material Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- Revision for version 1.1
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.material_overhead_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.material_overhead_cost,0),5)  
 end * sumwip.quantity * nvl(gdr1.conversion_rate,1)
    ,2))        "&p_to_currency_code New Material Ovhd Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.material_overhead_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.material_overhead_cost,0),5)  
 end * sumwip.quantity * nvl(gdr2.conversion_rate,1)
    ,2))        "&p_to_currency_code Old Material Ovhd Value",
 -- End revision for version 1.1
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic1.resource_cost,0) * nvl(gdr1.conversion_rate,1)
 * sumwip.quantity,2))      "&p_to_currency_code New Resource Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic2.resource_cost,0) * nvl(gdr2.conversion_rate,1)
 * sumwip.quantity,2))      "&p_to_currency_code Old Resource Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic1.outside_processing_cost,0) * nvl(gdr1.conversion_rate,1)
 * sumwip.quantity,2))      "&p_to_currency_code New OSP Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic2.outside_processing_cost,0) * nvl(gdr2.conversion_rate,1)
 * sumwip.quantity,2))      "&p_to_currency_code Old OSP Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic1.overhead_cost,0) * nvl(gdr1.conversion_rate,1)
 * sumwip.quantity,2))      "&p_to_currency_code New Overhead Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic2.overhead_cost,0) * nvl(gdr2.conversion_rate,1)
 * sumwip.quantity,2))      "&p_to_currency_code Old Overhead Value",
-- ===========================================================
-- WIP Values expressed in the To Currency, new values at 
-- the new Fx rate and old values at old Fx rate
-- ===========================================================
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- Revision for version 1.1
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
 end * sumwip.quantity * nvl(gdr1.conversion_rate,1)
    ,2))        "&p_to_currency_code New Onhand Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end * sumwip.quantity * nvl(gdr2.conversion_rate,1)
    ,2))        "&p_to_currency_code Old Onhand Value",
 -- Revision for version 1.2
 -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- USD New Onhand Cost - USD Old Onhand Cost
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
 end * sumwip.quantity * nvl(gdr1.conversion_rate,1)
    ,2) -
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end * sumwip.quantity * nvl(gdr2.conversion_rate,1)
    ,2))        "&p_to_currency_code Onhand Value Difference",
 -- End revision for version 1.1
 -- Revision for version 1.4, show absolute difference
 -- Revision for version 1.2
 -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
 abs(decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- USD New Onhand Cost - USD Old Onhand Cost
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
 end * sumwip.quantity * nvl(gdr1.conversion_rate,1)
    ,2) -
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end * sumwip.quantity * nvl(gdr2.conversion_rate,1)
    ,2)))        "&p_to_currency_code Abs Onhand Value Diff",
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
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * nvl(gdr1.conversion_rate,1) 
    else round(nvl(cic1.item_cost,0),5) * nvl(gdr1.conversion_rate,1) 
 end -
 -- Old_Item_Cost      
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * nvl(gdr1.conversion_rate,1)
    else round(nvl(cic2.item_cost,0),5) * nvl(gdr1.conversion_rate,1) 
 end) *
 -- multiplied by the total onhand quantity
 sumwip.quantity,2))      "&p_to_currency_code Value Difference-New Rate",
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
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * nvl(gdr2.conversion_rate,1)
    else round(nvl(cic1.item_cost,0),5) * nvl(gdr2.conversion_rate,1) 
 end -
 -- Old_Item_Cost      
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * nvl(gdr2.conversion_rate,1)
    else round(nvl(cic2.item_cost,0),5) * nvl(gdr2.conversion_rate,1) 
 end) *
 -- multiplied by the total onhand quantity
 sumwip.quantity,2))      "&p_to_currency_code Value Difference-Old Rate",
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
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * nvl(gdr1.conversion_rate,1) 
    else round(nvl(cic1.item_cost,0),5) * nvl(gdr1.conversion_rate,1) 
 end -
 -- Old_Item_Cost      
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * nvl(gdr1.conversion_rate,1) 
    else round(nvl(cic2.item_cost,0),5) * nvl(gdr1.conversion_rate,1) 
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
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * nvl(gdr2.conversion_rate,1)
    else round(nvl(cic1.item_cost,0),5) * nvl(gdr2.conversion_rate,1) 
 end -
 -- Old_Item_Cost      
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * nvl(gdr2.conversion_rate,1)
    else round(nvl(cic2.item_cost,0),5) * nvl(gdr2.conversion_rate,1) 
 end) *
 -- multiplied by the total onhand quantity
 sumwip.quantity,2))      "&p_to_currency_code Value FX Difference"
from mtl_system_items_vl msiv,
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
(select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:conversion_date1 and gdct.user_conversion_type=:user_conversion_type1 and gdr.to_currency=:to_currency and gdct.conversion_type=gdr.conversion_type) gdr1, -- NEW Currency Rates
 -- ===========================================================================
 -- Select Old Currency Rates based on the old concurrency conversion date
 -- ===========================================================================
(select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:conversion_date2 and gdct.user_conversion_type=:user_conversion_type2 and gdr.to_currency=:to_currency and gdct.conversion_type=gdr.conversion_type) gdr2,  -- OLD Currency Rates
 -- =================================================
 -- Get the item costs for Cost_Type 1 - New Costs
 -- =================================================
 (select cic1.organization_id    organization_id,
  cic1.inventory_item_id    inventory_item_id,
  -999     resource_id,
  nvl(cic1.material_cost,0)  material_cost,
   nvl(cic1.material_overhead_cost,0) material_overhead_cost,
  nvl(cic1.resource_cost,0)  resource_cost,
  nvl(cic1.outside_processing_cost,0) outside_processing_cost,
  nvl(cic1.overhead_cost,0)  overhead_cost,
  nvl(cic1.item_cost,0)   item_cost,
  -- Revision for version 1.1
  nvl(cic1.tl_material_overhead,0) tl_material_overhead
  from cst_item_costs cic1,
  cst_cost_types cct1,
  mtl_parameters mp
  where cct1.cost_type_id           = cic1.cost_type_id
  and cic1.organization_id        = mp.organization_id
  -- Do not report the master inventory organization
  and mp.organization_id   <> mp.master_organization_id
  and 8=8                         -- p_cost_type1
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                         -- p_org_code
  union all
  -- =============================================================
  -- Get the costs from the frozen cost type that is not in cost
  -- type 1 so that all of the inventory value is reported
  -- =============================================================
  select cic_frozen.organization_id    organization_id,
  cic_frozen.inventory_item_id    inventory_item_id,
  -999      resource_id,
  nvl(cic_frozen.material_cost,0)   material_cost,
   nvl(cic_frozen.material_overhead_cost,0) material_overhead_cost,
  nvl(cic_frozen.resource_cost,0)   resource_cost,
  nvl(cic_frozen.outside_processing_cost,0) outside_processing_cost,
  nvl(cic_frozen.overhead_cost,0)   overhead_cost,
  nvl(cic_frozen.item_cost,0)   item_cost,
  -- Revision for version 1.1
  nvl(cic_frozen.tl_material_overhead,0)  tl_material_overhead
  from cst_item_costs cic_frozen,
  cst_cost_types cct1,
  mtl_parameters mp
  where cic_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
  -- Do not report the master inventory organization
  and mp.organization_id   <> mp.master_organization_id
  and 8=8                         -- p_cost_type1
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                         -- p_org_code
  -- =============================================================
  -- If p_cost_type1 = frozen cost_type_id then we have all the 
  -- costs and don't need this union all statement
  -- =============================================================
  and cct1.cost_type_id    <> 1  -- frozen cost type
  and cic_frozen.organization_id  = mp.organization_id
  -- Revision for version 1.2, parameter to only_items_in_cost_type
  and 13=13
  -- =============================================================
  -- Check to see if the costs exist in cost type 1 
  -- =============================================================
  and not exists (
   select 'x'
   from cst_item_costs cic1
   where cic1.cost_type_id      = cct1.cost_type_id
   and cic1.organization_id   = cic_frozen.organization_id
   and cic1.inventory_item_id = cic_frozen.inventory_item_id
      )
  ) cic1,
 -- =================================================
 -- Get the item costs for Cost_Type 2 - Old Costs
 -- =================================================
 (select cic2.organization_id    organization_id,
  cic2.inventory_item_id    inventory_item_id,
  -999     resource_id,
  nvl(cic2.material_cost,0)  material_cost,
   nvl(cic2.material_overhead_cost,0) material_overhead_cost,
  nvl(cic2.resource_cost,0)  resource_cost,
  nvl(cic2.outside_processing_cost,0) outside_processing_cost,
  nvl(cic2.overhead_cost,0)  overhead_cost,
  nvl(cic2.item_cost,0)   item_cost,
  -- Revision for version 1.1
  nvl(cic2.tl_material_overhead,0) tl_material_overhead
  from cst_item_costs cic2,
  cst_cost_types cct2,
  mtl_parameters mp
  where cct2.cost_type_id           = cic2.cost_type_id
  and cic2.organization_id        = mp.organization_id
  -- Do not report the master inventory organization
  and mp.organization_id   <> mp.master_organization_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                         -- p_org_code
  and 10=10                       -- p_cost_type2
  union all
  -- =============================================================
  -- Get the costs from the frozen cost type that is not in cost
  -- type 2 so that all of the inventory value is reported
  -- =============================================================
  select cic_frozen.organization_id    organization_id,
  cic_frozen.inventory_item_id    inventory_item_id,
  -999      resource_id,
  nvl(cic_frozen.material_cost,0)   material_cost,
   nvl(cic_frozen.material_overhead_cost,0) material_overhead_cost,
  nvl(cic_frozen.resource_cost,0)   resource_cost,
  nvl(cic_frozen.outside_processing_cost,0) outside_processing_cost,
  nvl(cic_frozen.overhead_cost,0)   overhead_cost,
  nvl(cic_frozen.item_cost,0)   item_cost,
  -- Revision for version 1.1
  nvl(cic_frozen.tl_material_overhead,0)  tl_material_overhead
  from cst_item_costs cic_frozen,
  cst_cost_types cct2,
  mtl_parameters mp
  where cic_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
  -- Do not report the master inventory organization
  and mp.organization_id   <> mp.master_organization_id
  -- =============================================================
  -- If p_cost_type2 = frozen cost_type_id then we have all the 
  -- costs and don't need this union all statement
  -- =============================================================
  and cct2.cost_type_id    <> 1 -- frozen cost type
  and cic_frozen.organization_id  = mp.organization_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                         -- p_org_code
  and 10=10                       -- p_cost_type2
  -- =============================================================
  -- Check to see if the costs exist in cost type 1 
  -- =============================================================
  and not exists (
   select 'x'
   from cst_item_costs cic2
   where cic2.cost_type_id      = cct2.cost_type_id
   and cic2.organization_id   = cic_frozen.organization_id
   and cic2.inventory_item_id = cic_frozen.inventory_item_id
      )
  ) cic2,
  -- ===========================
 -- end of getting item costs 
  -- ===========================
 -- ==================================================================================
 -- Get WIP component and assembly completion from the WIP job information in
 -- wip_discrete_jobs (completions), wip_operation_resources (resources) and
 -- wip_requirement_operations (components).
  -- ==================================================================================
 -- ==============================================
 -- Part III: Get the WIP Component Quantities
 -- ==============================================
 -- ================================================
 -- Condense down to Org, Items, WIP_Jobs and Op
 -- ================================================
 (select wip.txn_source,
  wip.organization_id,
  wip.inventory_item_id,
  wip.wip_entity_id,
  wip.class_code,
  wip.class_type,
  wip.status_type,
  wip.date_released,
  wip.date_completed,
  wip.last_update_date,
  wip.resource_code,
  wip.resource_id,
  wip.transaction_type,
  max(wip.wip_supply_type) wip_supply_type,
  wip.op_seq_num,
  wip.res_seq_num,
  wip.basis_type,
  wip.quantity,
  wip.resource_value,
  wip.scrapped_quantity
  from (
   -- ==============================================
   -- Part I: Get the WIP Completion Quantities
   -- ==============================================
   select 'WIP Completion' txn_source,
   wdj.organization_id,
   wdj.primary_item_id inventory_item_id,
   wdj.wip_entity_id,
   wdj.class_code,
   wac.class_type,
   wdj.status_type,
   wdj.date_released,
   wdj.date_completed,
   wdj.last_update_date,
   null resource_code,
   -999 resource_id,
   mtt.transaction_type_name transaction_type,
   null wip_supply_type,
   null op_seq_num,
   null res_seq_num,
   -- WIP completion quantities always has a basis of Item
   1 basis_type, -- 1 - item
   -- Revision for version 1.2
   -- sum(wdj.quantity_completed * -1) quantity,
   sum(wdj.quantity_completed) quantity,
   sum(0) resource_value,
   sum(wdj.quantity_scrapped) scrapped_quantity
    from wip_discrete_jobs wdj,
   wip_accounting_classes wac,
   mtl_parameters mp,
   mtl_transaction_types mtt
   where mp.organization_id              = wdj.organization_id
   and mtt.transaction_type_id         = 44 -- WIP Completion
   and wac.class_code                  = wdj.class_code
   and wac.organization_id             = wdj.organization_id
   -- Only want asset jobs
   and wac.class_type not in (4,6,7)
   -- ===========================================
   -- Expense WIP Accounting Classes
   -- 4 - Expense Non-standard
   -- 6 - Maintenance
   -- 7 - Expense Non-standard Lot Based
   -- ===========================================
   -- Avoid assemblies issued from expense subinventories at zero cost
   and nvl(wdj.issue_zero_cost_flag, 'N') = 'N'
   -- Only want open WIP jobs
   and wdj.date_closed is null
   -- Do not report the master inventory organization
   and mp.organization_id             <> mp.master_organization_id
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                             -- p_org_code
   group by
   'WIP Completion', -- txn_source,
   wdj.organization_id,
   wdj.primary_item_id,
   wdj.wip_entity_id,
   wdj.class_code,
   wac.class_type,
   wdj.status_type,
   wdj.date_released,
   wdj.date_completed,
   wdj.last_update_date,
   null, -- resource_code
   -999, -- resource_id
   mtt.transaction_type_name,
   null, -- wip_supply_type
   null, -- op_seq_num
   null, -- res_seq_num
   1 -- basis_type 1 -- item
   having sum(wdj.quantity_completed) + sum(wdj.quantity_scrapped) <> 0
   union all
   -- =