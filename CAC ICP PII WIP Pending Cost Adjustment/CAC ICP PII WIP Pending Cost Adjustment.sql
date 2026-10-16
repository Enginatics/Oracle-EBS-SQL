/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII WIP Pending Cost Adjustment
-- Description: Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues and WIP resource (labor) transactions, including gross costs, profit in inventory (commonly abbreviated as PII or ICP - InterCompany Profit).
-- Production overheads (resource overheads) are reported per WIP operation and overhead, from the department overhead rates of the two cost types. Move-based overheads earn on the operation quantity completed (Item basis) or once per operation (Lot basis); resource-based overheads earn on the applied resource units (Resource Units basis) or on the applied resource units at the resource rate of each cost type (Resource Value basis), for the overheads assigned to the resource. For these rows the WIP Quantity is this overhead basis quantity.
-- The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session. And if you choose Yes for "Include All WIP Jobs" all WIP jobs will be reported even if there are no valuation changes. The To Currency columns are blank when no conversion rate exists for the date and type.
-- -- =================================================================
-- Copyright 2022 Douglas Volz Consulting, Inc.
-- All rights reserved.
-- Permission to use this code is granted provided the original author is acknowledged
-- Original Author: Douglas Volz (doug@volzconsulting.com)
-- -- =================================================================
-- Hidden Parameters:
-- psignpii: Hidden parameter to set the sign of the profit in inventory amounts. This parameter determines if PII is normally entered as a positive or negative amount.
-- Displayed Parameters:
-- Cost Type (New): the new cost type to be reported, mandatory
-- Cost Type (Old): the old cost type to be reported, mandatory
-- PII Cost Type (New): the new PIICostType you wish to report
-- PII Cost Type(Old): the prior or old PIICostType you wish to report such as PII or ICP (mandatory)
-- PII Sub-Element: the sub-element or resource for profit in inventory, such as PII or ICP (mandatory)
-- Currency Conversion Date (New): the new currency conversion date, mandatory
-- Currency Conversion Date (Old): the old currency conversion date, mandatory
-- Currency Conversion Type (New): the desired currency conversion type to use for cost type 1, mandatory
-- Currency Conversion Type (Old ): the desired currency conversion type to use for cost type 2, mandatory
-- To Currency Code: the currency you are converting into
-- Category Set 1: the first item category set to report, typically the Cost or Product Line CategorySet
-- Category Set 2: the second item category set to report, typically the Inventory CategorySet
-- All WIP Jobs: enter No to only report WIP jobs with valuation changes, enter Yes to report all WIP jobs.
-- Org Code: specific inventory organization you wish to report (optional)
-- Operating Unit: operating unit you wish to report, leave blank for all operating units (optional)
-- Ledger: general ledger you wish to report, leave blank for all ledgers (optional)
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.6 08 Jun 2022 Douglas Volz Create PII version based on WIP Pending Cost Adjust Rept.
-- -- | 1.7 19 Sep 2026 Enginatics Add production (resource) overhead cost adjustments,
-- -- | correct the net value, percentage and FX columns.
-- -- | 1.8 28 Sep 2026 Enginatics Report rows without a currency conversion rate.
-- Excel Example Output: https://www.enginatics.com/example/cac-icp-pii-wip-pending-cost-adjustment/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-wip-pending-cost-adjustment/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name)     Ledger,
-- ==========================================================
-- Get the Material_Cost and Value Cost Adjustments
-- ==========================================================
 haou2.name       Operating_Unit,
 mp.organization_code      Org_Code,
 haou.name       Organization_Name,
-- End revision for version 1.6
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
 null        Overhead_Code,
 sumwip.op_seq_num      Operation_Seq_Number,
 sumwip.res_seq_num      Resource_Seq_Number,
 ml5.meaning       Basis_Type,
 null        Overhead_Basis_Type,
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
 -- End revision for version 1.1,
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
 end        New_Gross_Item_Cost,
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)
 end        Old_Gross_Item_Cost,
 -- End revision for version 1.1
-- Revision for version 1.6 for PII
-- ========================================================
-- Select the PII item costs from Cost_Type 1 and 2
-- ========================================================
 round(nvl(pii1.item_cost,0),5)     New_PII_Cost,
 round(nvl(pii2.item_cost,0),5)     Old_PII_Cost,
-- ========================================================
-- Select the net item costs from Cost_Type 1 and 2
-- ========================================================
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
 end - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii1.item_cost,0),5) New_Net_Item_Cost,
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)
 end - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii2.item_cost,0),5) Old_Net_Item_Cost,
-- End revision for version 1.6 for PII  
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
 end        Gross_Item_Cost_Difference,
 --case
 --  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = 0 then 0
 --  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic1.item_cost,0),5) then  100
 --  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic2.item_cost,0),5) then -100
 --  else round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) / nvl(cic2.item_cost,0) * 100,1)
 --end        Gross_Percent Difference,
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
     -- when old cost - new cost = old cost then -100
    when case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
     else round(nvl(cic2.item_cost,0),5)  
  end -
  case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
     else round(nvl(cic1.item_cost,0),5)
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
   end * 100
 end,2)        Gross_Percent_Difference,
 -- End of revision for version 1.1
-- Revision for version 1.6 for PII
-- ========================================================
-- Select the PII costs from Cost_Type 1 and 2 and compare
-- ========================================================
 round(nvl(pii1.item_cost,0),5) - round(nvl(pii2.item_cost,0),5) PII_Item_Cost_Difference,
 case
   when round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)),5) = 0 then 0
   when round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)),5) = round(nvl(pii1.item_cost,0),5) then  100
   when round((nvl(pii2.item_cost,0) - nvl(pii1.item_cost,0)),5) = round(nvl(pii2.item_cost,0),5) then -100
   else round((nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) / nvl(pii2.item_cost,0) * 100,1)
 end        PII_Percent_Difference,
-- ========================================================
-- Select the net item costs from Cost_Type 1 and 2 and compare
-- ========================================================
 (case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
  end - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii1.item_cost,0),5)
 ) -
 (case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)
  end - decode(sign(:p_sign_pii),1,1,-1,-1,1) * round(nvl(pii2.item_cost,0),5)
 )        Net_Item_Cost_Difference,
-- End revision for version 1.6 for PII
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
    ,2))        New_Gross_WIP_Value,

-- Revision for version 1.6 for PII
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii1.item_cost,0) * sumwip.quantity,2)) New_PII_Value,
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round((case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
     else round(nvl(cic1.item_cost,0),5)
  end -
  decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii1.item_cost,0)) * sumwip.quantity,2)) New_Net_WIP_Value,
-- End revision for version 1.6 for PII
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end * sumwip.quantity
    ,2))        Old_Gross_WIP_Value,
-- Revision for version 1.6 for PII
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii2.item_cost,0) * sumwip.quantity,2)) Old_PII_Value,
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round((case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
     else round(nvl(cic2.item_cost,0),5)
  end -
  decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii2.item_cost,0)) * sumwip.quantity,2)) Old_Net_WIP_Value,
-- End revision for version 1.6 for PII
 -- Revision for version 1.2
 -- WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- New_WIP_Value - Old_WIP_Value = WIP_Value_Difference
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
    ,2))        Gross_WIP_Value_Difference,
 -- End revision for version 1.1
 -- Revision for version 1.4, show absolute difference
 -- Revision for version 1.2
 -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
 abs(decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- New_WIP_Value - Old_WIP_Value = WIP_Value_Difference
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
    ,2)))       Abs_WIP_Value_Difference,
 -- End revision for version 1.4
-- Revision for version 1.6 for PII
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) * sumwip.quantity,2)) PII_Value_Difference,
 -- Gross item cost difference less the PII item cost difference, multiplied by the WIP quantity
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round((case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
     else round(nvl(cic1.item_cost,0),5)
  end -
  case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
     else round(nvl(cic2.item_cost,0),5)
  end -
  decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0))) * sumwip.quantity,2)) Net_WIP_Value_Difference,
-- End revision for version 1.6 for PII
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
 gdr1.conversion_rate      New_FX_Rate,
 gdr2.conversion_rate      Old_FX_Rate,
 gdr1.conversion_rate - gdr2.conversion_rate   Exchange_Rate_Difference,
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
 * sumwip.quantity,2))      "&p_to_currency_code New Material Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic2.material_cost,0) * gdr2.conversion_rate
 * sumwip.quantity,2))      "&p_to_currency_code Old Material Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- Revision for version 1.1
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.material_overhead_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.material_overhead_cost,0),5)  
 end * sumwip.quantity * gdr1.conversion_rate
    ,2))        "&p_to_currency_code New Material Ovhd Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.material_overhead_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.material_overhead_cost,0),5)  
 end * sumwip.quantity * gdr2.conversion_rate
    ,2))        "&p_to_currency_code Old Material Ovhd Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- End revision for version 1.1
 round(nvl(cic1.resource_cost,0) * gdr1.conversion_rate
 * sumwip.quantity,2))      "&p_to_currency_code New Resource Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic2.resource_cost,0) * gdr2.conversion_rate
 * sumwip.quantity,2))      "&p_to_currency_code Old Resource Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic1.outside_processing_cost,0) * gdr1.conversion_rate
 * sumwip.quantity,2))      "&p_to_currency_code New OSP Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic2.outside_processing_cost,0) * gdr2.conversion_rate
 * sumwip.quantity,2))      "&p_to_currency_code Old OSP Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic1.overhead_cost,0) * gdr1.conversion_rate
 * sumwip.quantity,2))      "&p_to_currency_code New Overhead Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(nvl(cic2.overhead_cost,0) * gdr2.conversion_rate
 * sumwip.quantity,2))      "&p_to_currency_code Old Overhead Value",
-- ===========================================================
-- WIP_Values expressed in the To Currency, new values at 
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
 end * sumwip.quantity * gdr1.conversion_rate
    ,2))        "&p_to_currency_code New Gross WIP Value",
 -- Revision for version 1.3
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end * sumwip.quantity * gdr2.conversion_rate
    ,2))        "&p_to_currency_code Old Gross WIP Value",
 -- Revision for version 1.2
 -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- USD New WIP Cost - USD Old WIP Cost
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
 end * sumwip.quantity * gdr1.conversion_rate
    ,2) -
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end * sumwip.quantity * gdr2.conversion_rate
    ,2))        "&p_to_currency_code Gross WIP Value Diff",
 -- End revision for version 1.1
 -- Revision for version 1.4, show absolute difference
 -- Revision for version 1.2
 -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
 abs(decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 -- USD New WIP Cost - USD Old WIP Cost
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
    else round(nvl(cic1.item_cost,0),5)  
 end * sumwip.quantity * gdr1.conversion_rate
    ,2) -
 round(
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
    else round(nvl(cic2.item_cost,0),5)  
 end * sumwip.quantity * gdr2.conversion_rate
    ,2)))       "&p_to_currency_code Abs WIP Value Diff",
 -- End revision for version 1.4
-- Revision for version 1.6 for PII
-- ===========================================================
-- PII Values in USD, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii1.item_cost,0) * gdr1.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code New PII Value",
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii2.item_cost,0) * gdr2.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code Old PII Value",
 -- New PII Value - Old PII Value
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) * gdr1.conversion_rate -
  nvl(pii2.item_cost,0) * gdr2.conversion_rate) * sumwip.quantity,2)) "&p_to_currency_code PII Value Difference",
-- ===========================================================
-- Net Values in To Currency, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
 -- New Gross WIP Cost - New PII Cost
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round((case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr1.conversion_rate
     else round(nvl(cic1.item_cost,0),5) * gdr1.conversion_rate
  end -
  decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii1.item_cost,0) * gdr1.conversion_rate) * sumwip.quantity,2)) "&p_to_currency_code New Net Value",
 -- Old Gross WIP Cost - Old PII Cost
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round((case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr2.conversion_rate
     else round(nvl(cic2.item_cost,0),5) * gdr2.conversion_rate
  end -
  decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii2.item_cost,0) * gdr2.conversion_rate) * sumwip.quantity,2)) "&p_to_currency_code Old Net Value",
 -- New Net Value less Old Net Value
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(((case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr1.conversion_rate
     else round(nvl(cic1.item_cost,0),5) * gdr1.conversion_rate
  end -
  decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii1.item_cost,0) * gdr1.conversion_rate) -
  (case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr2.conversion_rate
     else round(nvl(cic2.item_cost,0),5) * gdr2.conversion_rate
  end -
  decode(sign(:p_sign_pii),1,1,-1,-1,1) * nvl(pii2.item_cost,0) * gdr2.conversion_rate)) * sumwip.quantity,2)) "&p_to_currency_code Net Value Difference",
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
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr1.conversion_rate
    else round(nvl(cic1.item_cost,0),5) * gdr1.conversion_rate 
 end -
 -- Old_Item_Cost      
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr1.conversion_rate
    else round(nvl(cic2.item_cost,0),5) * gdr1.conversion_rate 
 end) *
 -- multiplied by the total WIP quantity
 sumwip.quantity,2))      "&p_to_currency_code Gross Value Diff-New Rate",
-- Revision for version 1.6 for PII
 -- NEW PII at new fx conversion rate minus OLD PII at new fx conversion rate
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) * gdr1.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code PII Value Diff-New Rate",
 -- Gross Value Diff-New Rate less PII Value Diff-New Rate
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round((case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr1.conversion_rate
     else round(nvl(cic1.item_cost,0),5) * gdr1.conversion_rate
  end -
  case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr1.conversion_rate
     else round(nvl(cic2.item_cost,0),5) * gdr1.conversion_rate
  end) * sumwip.quantity,2) -
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) * gdr1.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code Net Value Diff-New Rate",
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
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr2.conversion_rate 
    else round(nvl(cic1.item_cost,0),5) * gdr2.conversion_rate 
 end -
 -- Old_Item_Cost      
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr2.conversion_rate 
    else round(nvl(cic2.item_cost,0),5) * gdr2.conversion_rate 
 end) *
 -- multiplied by the total WIP quantity
 sumwip.quantity,2))      "&p_to_currency_code Gross Value Diff-Old Rate",
-- Revision for version 1.6 for PII
 -- NEW PII at old fx conversion rate minus OLD PII at old fx conversion rate
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) * gdr2.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code PII Value Diff-Old Rate",
 -- Gross Value Diff-Old Rate less PII Value Diff-Old Rate
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round((case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr2.conversion_rate
     else round(nvl(cic1.item_cost,0),5) * gdr2.conversion_rate
  end -
  case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr2.conversion_rate
     else round(nvl(cic2.item_cost,0),5) * gdr2.conversion_rate
  end) * sumwip.quantity,2) -
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) * gdr2.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code Net Value Diff-Old Rate",
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
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)  * gdr1.conversion_rate
    else round(nvl(cic1.item_cost,0),5) * gdr1.conversion_rate 
 end -
 -- Old_Item_Cost      
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
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
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr2.conversion_rate 
    else round(nvl(cic1.item_cost,0),5) * gdr2.conversion_rate 
 end -
 -- Old_Item_Cost      
 case
    when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
  round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)  * gdr2.conversion_rate 
    else round(nvl(cic2.item_cost,0),5) * gdr2.conversion_rate 
 end) *
 -- multiplied by the total WIP quantity
 sumwip.quantity,2))      "&p_to_currency_code Gross Value FX Diff",
-- Revision for version 1.6 for PII
 -- PII Value Diff-New Rate less PII Value Diff-Old Rate
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) * gdr1.conversion_rate * sumwip.quantity,2) -
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) * gdr2.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code PII Value FX Diff",
 -- Net Value Diff-New Rate less Net Value Diff-Old Rate
 decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
 (round((case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr1.conversion_rate
     else round(nvl(cic1.item_cost,0),5) * gdr1.conversion_rate
  end -
  case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr1.conversion_rate
     else round(nvl(cic2.item_cost,0),5) * gdr1.conversion_rate
  end) * sumwip.quantity,2) -
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) * gdr1.conversion_rate * sumwip.quantity,2)) -
 (round((case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5) * gdr2.conversion_rate
     else round(nvl(cic1.item_cost,0),5) * gdr2.conversion_rate
  end -
  case
     when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
   round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5) * gdr2.conversion_rate
     else round(nvl(cic2.item_cost,0),5) * gdr2.conversion_rate
  end) * sumwip.quantity,2) -
 round(decode(sign(:p_sign_pii),1,1,-1,-1,1) * (nvl(pii1.item_cost,0) - nvl(pii2.item_cost,0)) * gdr2.conversion_rate * sumwip.quantity,2))) "&p_to_currency_code Net Value FX Diff"
-- End revision for version 1.6 for PII
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
 gl_ledgers gl,
 -- ===========================================================================
 -- Select New Currency Rates based on the new currency conversion date
 -- ===========================================================================
 (select gl.currency_code from_currency,
  decode(gl.currency_code, :p_to_currency_code, 1,
  (select gdr1.conversion_rate
       from gl_daily_rates gdr1,
       gl_daily_conversion_types gdct1
       where gdr1.from_currency = gl.currency_code
       and gdr1.conversion_type = gdct1.conversion_type
       and 4=4                        -- p_curr_conv_date1
       and 5=5                        -- p_curr_conv_type1
       and 11=11                      -- p_to_currency_code
      )) conversion_rate
  from (select distinct gl.currency_code from gl_ledgers gl) gl
 ) gdr1, -- NEW Currency Rates, 1 for the same currency, blank when the rate is missing
 -- ===========================================================================
 -- Select Old Currency Rates based on the old currency conversion date
 -- ===========================================================================
 (select gl.currency_code from_currency,
  decode(gl.currency_code, :p_to_currency_code, 1,
  (select gdr2.conversion_rate
       from gl_daily_rates gdr2,
       gl_daily_conversion_types gdct2
       where gdr2.from_currency = gl.currency_code
       and gdr2.conversion_type = gdct2.conversion_type
       and 6=6                        -- p_curr_conv_date2
       and 7=7                        -- p_curr_conv_type2
       and gdr2.to_currency = :p_to_currency_code
      )) conversion_rate
  from (select distinct gl.currency_code from gl_ledgers gl) gl
 ) gdr2, -- OLD Currency Rates, 1 for the same currency, blank when the rate is missing
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
  and mp.organization_id         <> mp.master_organization_id
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
  and cic_frozen.organization_id  = mp.organization_id
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
  and mp.organization_id         <> mp.master_organization_id
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
  and cic_frozen.organization_id  = mp.organization_id
  -- =============================================================
  -- If p_cost_type2 = frozen cost_type_id then we have all the 
  -- costs and don't need this union all statement
  -- =============================================================
  and cct2.cost_type_id    <> 1 -- frozen cost type
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
-- Revision for version 1.6 - PII
 -- ===========================================================================
 -- GET THE PII ITEM COSTS FROM PII COST TYPE 1
 -- ===========================================================================
 (select msiv.organization_id     organization_id,
  msiv.inventory_item_id     inventory_item_id,
  nvl((select sum(nvl(cicd.item_cost,0))
       from cst_item_cost_details cicd,
       cst_cost_types cct,
    bom_resources br
       where cicd.inventory_item_id = msiv.inventory_item_id
       and cicd.organization_id   = msiv.organization_id
       and br.resource_id         = cicd.resource_id
       and cct.cost_type_id       = cicd.cost_type_id
       and 12=12                  -- p_pii_cost_type1_NEW
       and 14=14                  -- p_pii_sub_element
      ),0)   item_cost
  from mtl_parameters mp,
  mtl_system_items_vl msiv
  where msiv.organization_id        = mp.organization_id
  and msiv.inventory_asset_flag   = 'Y'
  -- Do not report the master inventory organization
  and mp.organization_id         <> mp.master_organization_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                         -- p_org_code
 ) pii1,
 -- ===========================================================================
 -- GET THE PII ITEM COSTS FROM PII COST TYPE 2
 -- ===========================================================================
 (select msiv.organization_id     organization_id,
  msiv.inventory_item_id     inventory_item_id,
  nvl((select sum(nvl(cicd.item_cost,0))
       from cst_item_cost_details cicd,
       cst_cost_types cct,
    bom_resources br
       where cicd.inventory_item_id = msiv.inventory_item_id
       and cicd.organization_id   = msiv.organization_id
       and br.resource_id         = cicd.resource_id
       and cct.cost_type_id       = cicd.cost_type_id
       and 13=13                  -- p_pii_cost_type2_OLD
       and 14=14                  -- p_pii_sub_element
      ),0)   item_cost                   -- p_pii_cost_type2_OLD
  from mtl_parameters mp,
  mtl_system_items_vl msiv
  where msiv.organization_id        = mp.organization_id
  and msiv.inventory_asset_flag   = 'Y'
  -- Do not report the master inventory organization
  and mp.organization_id         <> mp.master_organization_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                         -- p_org_code
 ) pii2,
-- End revision for version 1.6 - PII
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
   -- Notes for version 1.6, for performance reasons use mtl_parameters
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
   -- Notes for version 1.6, for performance reasons use mtl_parameters
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
   -- ==============================================
   -- Part II: Get the WIP Component Quantities
   -- ==============================================   
   select 'Material' txn_source,
   wro.organization_id,
   wro.inventory_item_id,
   wro.wip_entity_id,
   wdj.class_code,
   wac.class_type,
   wdj.status_type,
   wdj.date_released,
   wdj.date_completed,
   wdj.last_update_date,
   null resource_code,
   -999 resource_id,
   mtt.transaction_type_name transaction_type,
   wro.wip_supply_type,
   wro.operation_seq_num op_seq_num,
   null res_seq_num,
   -- WRO sometimes has a null basis type
   nvl(wro.basis_type, 1) basis_type,
   wro.quantity_issued quantity,
   0 resource_value,
   nvl(wro.relieved_matl_scrap_quantity,0) scrapped_quantity
    from wip_discrete_jobs wdj,
   wip_accounting_classes wac,
   wip_requirement_operations wro,
   -- Notes for version 1.6, for performance reasons use mtl_parameters
   mtl_parameters mp,
   mtl_transaction_types mtt
   where mp.organization_id              = wdj.organization_id
   and wro.wip_entity_id               = wdj.wip_entity_id
   and wro.organization_id             = wdj.organization_id
   and mp.organization_id              = wdj.organization_id
   and wac.class_code                  = wdj.class_code
   and wac.organization_id             = wdj.organization_id
   -- Only want asset jobs
   and wac.class_type not in (4,6,7)
   and mtt.transaction_type_id         =
    decode(sign(wro.quantity_issued),
      1, 35, -- WIP Issue
     -1, 43) -- WIP Return
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
   -- Only want open non-zero units
   and wro.quantity_issued <> 0
   -- Notes for version 1.6, for performance reasons use mtl_parameters
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                             -- p_org_code
  ) wip
  group by
  wip.txn_source,
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
  wip.op_seq_num,
  wip.res_seq_num,
  wip.basis_type,
  wip.quantity,
  wip.resource_value,
  wip.scrapped_quantity
 ) sumwip
 -- ===========================
 -- End of getting WIP quantities
  -- ===========================
-- ===================================================================
-- Joins for the item master, organization, item costs and pii costs
-- ===================================================================
where msiv.inventory_item_id          = sumwip.inventory_item_id
and msiv.organization_id            = sumwip.organization_id
and msiv.primary_uom_code           = muomv.uom_code
and misv.inventory_item_status_code = msiv.inventory_item_status_code
and we.wip_entity_id                = sumwip.wip_entity_id
and msiv.inventory_item_id          = cic1.inventory_item_id
and msiv.organization_id            = cic1.organization_id
and sumwip.resource_id              = cic1.resource_id
and sumwip.organization_id          = cic1.organization_id
-- Outer join as you may have newly costed items in the new cost
-- type which were never existed in the old cost type
and sumwip.inventory_item_id        = cic2.inventory_item_id (+)
and sumwip.organization_id          = cic2.organization_id (+)
and sumwip.resource_id              = cic2.resource_id (+)
and msiv.organization_id            = mp.organization_id
-- Revision for version 1.6 - PII
and msiv.inventory_item_id          = pii1.inventory_item_id (+)
and msiv.organization_id            = pii1.organization_id (+)
and msiv.inventory_item_id          = pii2.inventory_item_id (+)
and msiv.organization_id            = pii2.organization_id (+)
-- End revision for version 1.6 - PII
-- ===================================================================
-- joins for the Lookup Codes
-- ===================================================================
and ml1.lookup_type                 = 'WIP_CLASS_TYPE'
and ml1.lookup_code                 = sumwip.class_type
and ml2.lookup_type                 = 'WIP_JOB_STATUS'
and ml2.lookup_code                 = sumwip.status_type
and ml3.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml3.lookup_code                 = msiv.planning_make_buy_code
and ml4.lookup_type (+)             = 'WIP_SUPPLY'
and ml4.lookup_code (+)             = sumwip.wip_supply_type
and ml5.lookup_type                 = 'CST_BASIS'
and ml5.lookup_code                 = sumwip.basis_type
-- Lookup codes for item types
and fcl.lookup_code (+)             = msiv.item_type
and fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- Joins for the currency exchange rates
-- ===================================================================
-- new FX rate
and gl.currency_code                = gdr1.from_currency
-- old FX rate
and gl.currency_code                = gdr2.from_currency
-- ===================================================================
-- Use base tables instead of HR organization views
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id             -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3)  -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1)  -- get the ledger_id
-- avoid selecting disabled inventory organizations
and sysdate           < nvl(haou.date_to, sysdate +1)
and 9=9                             -- p_org_code
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                             -- p_ledger, p_operating_unit
-- ===================================================================
-- Only report non-zero results
-- ===================================================================
-- Revision for version 1.5, make this a parameter
-- Item_Cost_Difference + Exchange_Rate_Difference <> 0
-- and (round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5))  
--  +  (gdr1.conversion_rate - gdr2.conversion_rate) <> 0
and decode(:p_all_wip_jobs,
  -- without a conversion rate compare the ledger currency costs
  'N', nvl(abs(round(nvl(cic1.item_cost,0) * gdr1.conversion_rate,5) - round(nvl(cic2.item_cost,0) * gdr2.conversion_rate,5)) +
       abs(round(nvl(pii1.item_cost,0) * gdr1.conversion_rate,5) - round(nvl(pii2.item_cost,0) * gdr2.conversion_rate,5)),
       abs(round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5)) + abs(round(nvl(pii1.item_cost,0),5) - round(nvl(pii2.item_cost,0),5))),
  'Y', 1)               <> 0
-- End revision for version 1.5
union all
-- ==========================================================
-- Get the Resource_Cost and Value Cost Adjustments
-- ==========================================================
select  nvl(gl.short_name, gl.name)     Ledger,
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
 null        Overhead_Code,
 sumwip.op_seq_num      Operation_Seq_Number,
 sumwip.res_seq_num      Resource_Seq_Number,
 ml5.meaning       Basis_Type,
 null        Overhead_Basis_Type,
 -- Revision for version 1.6
 gl.currency_code      Currency_Code,
 muomv.uom_code       UOM_Code,
-- ==========================================================
-- Select the new and old item costs from Cost_Type 1 and 2
-- ==========================================================
 round(nvl(cic1.material_cost,0),5)    New_Material_Cost,
 round(nvl(cic2.material_cost,0),5)    Old_Material_Cost,
 round(nvl(cic1.material_overhead_cost,0),5)   New_Material_Overhead_Cost,
 round(nvl(cic2.material_overhead_cost,0),5)   Old_Material_Overhead_Cost,
 round(nvl(cic1.resource_cost,0),5)    New_Resource_Cost,
 round(nvl(cic2.resource_cost,0),5)    Old_Resource_Cost,
 round(nvl(cic1.outside_processing_cost,0),5)   New_Outside_Processing_Cost,
 round(nvl(cic2.outside_processing_cost,0),5)   Old_Outside_Processing_Cost,
 round(nvl(cic1.overhead_cost,0),5)    New_Overhead_Cost,
 round(nvl(cic2.overhead_cost,0),5)    Old_Overhead_Cost,
 round(nvl(cic1.item_cost,0),5)     New_Gross_Item_Cost,
 round(nvl(cic2.item_cost,0),5)     Old_Gross_Item_Cost,
-- Revision for version 1.6 for PII
-- ========================================================
-- Select the PII item costs from Cost_Type 1 and 2
-- WIP_Resources Do Not Have PII item costs
-- ========================================================
 0        New_PII_Cost,
 0        Old_PII_Cost,
-- ========================================================
-- Select the net item costs from Cost_Type 1 and 2
-- ========================================================
 round(nvl(cic1.item_cost,0),5)     New_Net_Item_Cost,
 round(nvl(cic2.item_cost,0),5)     Old_Net_Item_Cost,
-- End revision for version 1.6 for PII  
-- ========================================================
-- Select the item costs from Cost_Type 1 and 2 and compare
-- ========================================================
 round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5) Gross_Item_Cost_Difference,
 case
   when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = 0 then 0
   when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic1.item_cost,0),5) then  100
   when round((nvl(cic2.item_cost,0) - nvl(cic1.item_cost,0)),5) = round(nvl(cic2.item_cost,0),5) then -100
   else round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) / nvl(cic2.item_cost,0) * 100,2)
 end        Gross_Percent_Difference,
-- Revision for version 1.6 for PII
-- ========================================================
-- Select the PII costs from Cost_Type 1 and 2 and compare
-- ========================================================
 0        PII_Item_Cost_Difference,
 0        PII_Percent_Difference,
-- ========================================================
-- Select the net item costs from Cost_Type 1 and 2 and compare
-- ========================================================
 round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5) Net_Item_Cost_Difference,
-- End revision for version 1.6 for PII
-- ===========================================================
-- Select the WIP quantities and values
-- ===========================================================
 muomv.uom_code       UOM_Code,
 -- Show the WIP Completion Quantity as a positive number
 decode(sumwip.txn_source,
   'WIP Completion', -1 * sumwip.quantity,
   sumwip.quantity)    WIP_Quantity,
 round(nvl(cic1.item_cost,0) * sumwip.quantity,2)  New_Gross_WIP_Value,
 0        New_PII_Value,
 round(nvl(cic1.item_cost,0) * sumwip.quantity,2)  New_Net_WIP_Value,
 round(nvl(cic2.item_cost,0) * sumwip.quantity,2)  Old_Gross_WIP_Value,
 0        Old_PII_Value,
 round(nvl(cic2.item_cost,0) * sumwip.quantity,2)  Old_Net_WIP_Value,
 round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) *
 sumwip.quantity,2)      Gross_WIP_Value_Difference,
 -- Revision for version 1.4, show absolute difference
 abs(round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) * 
  sumwip.quantity,2))     Abs_WIP_Value_Difference,
 -- End revision for version 1.4
-- Revision for version 1.6 for PII
 0        PII_Value_Difference,
 round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) *
 sumwip.quantity,2)      Net_WIP_Value_Difference,
-- End revision for version 1.6 for PII
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
 gdr1.conversion_rate      New_FX_Rate,
 gdr2.conversion_rate      Old_FX_Rate,
 gdr1.conversion_rate - gdr2.conversion_rate   Exchange_Rate_Difference,
-- ===========================================================
-- Select To Currency WIP quantities and values
-- ===========================================================
-- ===========================================================
-- Costs in To Currency by Cost_Element, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
 round(nvl(cic1.material_cost,0) * gdr1.conversion_rate
 * sumwip.quantity,2)      "&p_to_currency_code New Material Value",
 round(nvl(cic2.material_cost,0) * gdr2.conversion_rate
 * sumwip.quantity,2)      "&p_to_currency_code Old Material Value",
 round(nvl(cic1.material_overhead_cost,0) * gdr1.conversion_rate 
 * sumwip.quantity,2)      "&p_to_currency_code New Material Ovhd Value",
 round(nvl(cic2.material_overhead_cost,0) * gdr2.conversion_rate
 * sumwip.quantity,2)      "&p_to_currency_code Old Material Ovhd Value",
 round(nvl(cic1.resource_cost,0) * gdr1.conversion_rate
 * sumwip.quantity,2)      "&p_to_currency_code New Resource Value",
 round(nvl(cic2.resource_cost,0) * gdr2.conversion_rate
 * sumwip.quantity,2)      "&p_to_currency_code Old Resource Value",
 round(nvl(cic1.outside_processing_cost,0) * gdr1.conversion_rate
 * sumwip.quantity,2)      "&p_to_currency_code New OSP Value",
 round(nvl(cic2.outside_processing_cost,0) * gdr2.conversion_rate
 * sumwip.quantity,2)      "&p_to_currency_code Old OSP Value",
 round(nvl(cic1.overhead_cost,0) * gdr1.conversion_rate
 * sumwip.quantity,2)      "&p_to_currency_code New Overhead Value",
 round(nvl(cic2.overhead_cost,0) * gdr2.conversion_rate
 * sumwip.quantity,2)      "&p_to_currency_code Old Overhead Value",
-- ===========================================================
-- WIP_Values expressed in To Currency, new values at
-- new Fx rate and old values at old Fx rate
-- ===========================================================
 round(nvl(cic1.item_cost,0) * gdr1.conversion_rate *
  sumwip.quantity,2)     "&p_to_currency_code New Gross WIP Value",
 round(nvl(cic2.item_cost,0) * gdr2.conversion_rate *
  sumwip.quantity,2)     "&p_to_currency_code Old Gross WIP Value",
 -- USD New WIP Cost - USD Old WIP Cost
 round(( (nvl(cic1.item_cost,0) * gdr1.conversion_rate) -
  (nvl(cic2.item_cost,0) * gdr2.conversion_rate)) *
 -- multiplied by the total WIP quantity 
  sumwip.quantity,2)     "&p_to_currency_code Gross WIP_Value Diff",
 -- Revision for version 1.4, show absolute difference
 -- USD New WIP Cost - USD Old WIP Cost
 abs(round(( (nvl(cic1.item_cost,0) * gdr1.conversion_rate) -
  (nvl(cic2.item_cost,0) * gdr2.conversion_rate)) *
 -- multiplied by the total WIP quantity 
  sumwip.quantity,2))     "&p_to_currency_code Abs WIP_Value Diff",
 -- End revision for version 1.4
-- Revision for version 1.6 for PII
-- ===========================================================
-- PII Values in USD, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
 0        "&p_to_currency_code New PII Value",
 0        "&p_to_currency_code Old PII Value",
 0        "&p_to_currency_code PII Value Difference",
-- ===========================================================
-- Net Values in USD, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
 round(nvl(cic1.item_cost,0) * gdr1.conversion_rate *
  sumwip.quantity,2)     "&p_to_currency_code New Net Value",
 round(nvl(cic2.item_cost,0) * gdr2.conversion_rate *
  sumwip.quantity,2)     "&p_to_currency_code Old Net Value",
 -- USD New WIP Cost - USD Old WIP Cost
 round(( (nvl(cic1.item_cost,0) * gdr1.conversion_rate) -
  (nvl(cic2.item_cost,0) * gdr2.conversion_rate)) *
 -- multiplied by the total WIP quantity 
  sumwip.quantity,2)     "&p_to_currency_code Net Value Difference",
-- End revision for version 1.6 for PI
-- ===========================================================
-- Value Differences in To Currency using the new rate
-- New and Old costs at New Fx Rate
-- ===========================================================
 -- NEW COST at new fx conversion rate minus OLD COST at new fx conversion rate
 round(( (nvl(cic1.item_cost,0) * gdr1.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr1.conversion_rate)) *
 -- multiplied by the total WIP quantity
  sumwip.quantity,2)     "&p_to_currency_code Gross Value Diff-New Rate",
 0        "&p_to_currency_code PII Value Diff-New Rate",
-- Revision for version 1.6 for PII
 -- NEW COST at new fx conversion rate minus OLD COST at new fx conversion rate
 round(( (nvl(cic1.item_cost,0) * gdr1.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr1.conversion_rate)) *
 -- multiplied by the total WIP quantity
  sumwip.quantity,2)     "&p_to_currency_code Net Value Diff-New Rate",
-- End revision for version 1.6 for PII
-- ===========================================================
-- Value Differences in To Currency using the old rate
-- New and Old costs at Old Fx Rate
-- ===========================================================
 -- NEW COST at old fx conversion rate minus OLD COST at old fx conversion rate
 round(( (nvl(cic1.item_cost,0) * gdr2.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr2.conversion_rate)) *
 -- multiplied by the total WIP quantity
  sumwip.quantity,2)     "&p_to_currency_code Gross Value Diff-Old Rate",
 0        "&p_to_currency_code PII Value Diff-Old Rate",
-- Revision for version 1.6 for PII
 -- NEW COST at old fx conversion rate minus OLD COST at old fx conversion rate
 round(( (nvl(cic1.item_cost,0) * gdr2.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr2.conversion_rate)) *
 -- multiplied by the total WIP quantity
  sumwip.quantity,2)     "&p_to_currency_code Net Value Diff-Old Rate",
-- End revision for version 1.6 for PII
-- ===========================================================
-- Value Differences comparing the new less the old rate differences
-- ===========================================================
 -- USD Value Diff-New Rate less USD Value Diff-Old Rate
 -- USD Value Diff-New Rate
 round(( (nvl(cic1.item_cost,0) * gdr1.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr1.conversion_rate)) *
  sumwip.quantity,2) -
 -- USD Value Diff-Old Rate
 round(( (nvl(cic1.item_cost,0) * gdr2.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr2.conversion_rate)) *
  sumwip.quantity,2)     "&p_to_currency_code Gross Value FX Diff",
-- Revision for version 1.6 for PII
 0         "&p_to_currency_code PII Value FX Diff",
 -- USD Value Diff-New Rate less USD Value Diff-Old Rate
 -- USD Value Diff-New Rate
 round(( (nvl(cic1.item_cost,0) * gdr1.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr1.conversion_rate)) *
  sumwip.quantity,2) -
 -- USD Value Diff-Old Rate
 round(( (nvl(cic1.item_cost,0) * gdr2.conversion_rate) - 
  (nvl(cic2.item_cost,0) * gdr2.conversion_rate)) *
  sumwip.quantity,2)     "&p_to_currency_code Net Value FX Diff"
-- End revision for version 1.6 for PII
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
 gl_ledgers gl,
 -- ===========================================================================
 -- Select New Currency Rates based on the new concurrency conversion date
 -- ===========================================================================
 (select gl.currency_code from_currency,
  decode(gl.currency_code, :p_to_currency_code, 1,
  (select gdr1.conversion_rate
       from gl_daily_rates gdr1,
       gl_daily_conversion_types gdct1
       where gdr1.from_currency = gl.currency_code
       and gdr1.conversion_type = gdct1.conversion_type
       and 4=4                        -- p_curr_conv_date1
       and 5=5                        -- p_curr_conv_type1
       and 11=11                      -- p_to_currency_code
      )) conversion_rate
  from (select distinct gl.currency_code from gl_ledgers gl) gl
 ) gdr1, -- NEW Currency Rates, 1 for the same currency, blank when the rate is missing
 -- ===========================================================================
 -- Select Old Currency Rates based on the old concurrency conversion date
 -- ===========================================================================
 (select gl.currency_code from_currency,
  decode(gl.currency_code, :p_to_currency_code, 1,
  (select gdr2.conversion_rate
       from gl_daily_rates gdr2,
       gl_daily_conversion_types gdct2
       where gdr2.from_currency = gl.currency_code
       and gdr2.conversion_type = gdct2.conversion_type
       and 6=6                        -- p_curr_conv_date2
       and 7=7                        -- p_curr_conv_type2
       and gdr2.to_currency = :p_to_currency_code
      )) conversion_rate
  from (select distinct gl.currency_code from gl_ledgers gl) gl
 ) gdr2, -- OLD Currency Rates, 1 for the same currency, blank when the rate is missing
 -- =================================================
 -- Get the resource costs for Cost_Type 1
 -- =================================================
 (select crc1.organization_id    organization_id,
  -999     inventory_item_id,
  crc1.resource_id    resource_id,
  0     material_cost,
  0     material_overhead_cost,
  decode(br.cost_element_id,
   3, nvl(crc1.resource_rate,0),
   0)    resource_cost,
  decode(br.cost_element_id,
   4, nvl(crc1.resource_rate,0),
   0)    outside_processing_cost,
  decode(br.cost_element_id,
   5, nvl(crc1.resource_rate,0),
   0)    overhead_cost,
  nvl(crc1.resource_rate,0)  item_cost  
  from cst_resource_costs crc1,
  bom_resources br,
  cst_cost_types cct1,
  mtl_parameters mp
  where cct1.cost_type_id           = crc1.cost_type_id
  and crc1.organization_id        = mp.organization_id
  -- Do not report the master inventory organization
  and mp.organization_id         <> mp.master_organization_id
  and br.resource_id              = crc1.resource_id
  and 8=8                         -- p_cost_type1
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                         -- p_org_code
  union all
  -- =============================================================
  -- Get the costs from the frozen cost type that is not in cost
  -- type 1 so that all resource costs are reported
  -- =============================================================
  select crc_frozen.organization_id   organization_id,
  -999     inventory_item_id,
  crc_frozen.resource_id    resource_id,
  0     material_cost,
  0     material_overhead_cost,
  decode(br.cost_element_id,
   3, nvl(crc_frozen.resource_rate,0),
   0)    resource_cost,
  decode(br.cost_element_id,
   4, nvl(crc_frozen.resource_rate,0),
   0)    outside_processing_cost,
  decode(br.cost_element_id,
   5, nvl(crc_frozen.resource_rate,0),
   0)    overhead_cost,
  nvl(crc_frozen.resource_rate,0)  item_cost 
  from cst_resource_costs crc_frozen,
  cst_cost_types cct1,
  bom_resources br,
  mtl_parameters mp
  where crc_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
  and crc_frozen.organization_id  = mp.organization_id
  -- Do not report the master inventory organization
  and mp.organization_id         <> mp.master_organization_id
  and br.resource_id              = crc_frozen.resource_id
  and 8=8                         -- p_cost_type1
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                         -- p_org_code
  -- =============================================================
  -- If p_cost_type1 = frozen cost_type_id then we have all the 
  -- costs and don't need this union all statement
  -- =============================================================
  and cct1.cost_type_id    <> 1  -- frozen cost type
  -- =============================================================
  -- Check to see if the costs exist in cost type 1 
  -- =============================================================
  and not exists (
   select 'x'
   from cst_resource_costs crc1
   where crc1.cost_type_id      = cct1.cost_type_id
   and crc1.organization_id   = crc_frozen.organization_id
   and crc1.resource_id       = crc_frozen.resource_id
      )
  ) cic1,
 -- =================================================
 -- Get the resource costs for Cost_Type 2
 -- =================================================
 (select crc2.organization_id    organization_id,
  -999     inventory_item_id,
  crc2.resource_id    resource_id,
  0     material_cost,
  0     material_overhead_cost,
  decode(br.cost_element_id,
   3, nvl(crc2.resource_rate,0),
   0)    resource_cost,
  decode(br.cost_element_id,
   4, nvl(crc2.resource_rate,0),
   0)    outside_processing_cost,
  decode(br.cost_element_id,
   5, nvl(crc2.resource_rate,0),
   0)    overhead_cost,
  nvl(crc2.resource_rate,0)  item_cost  
  from cst_resource_costs crc2,
  bom_resources br,
  cst_cost_types cct2,
  mtl_parameters mp
  where cct2.cost_type_id           = crc2.cost_type_id
  and crc2.organization_id        = mp.organization_id
  -- Do not report the master inventory organization
  and mp.organization_id         <> mp.master_organization_id
  and br.resource_id              = crc2.resource_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                         -- p_org_code
  and 10=10                       -- p_cost_type2
  union all
  -- =============================================================
  -- Get the costs from the frozen cost type that is not in cost
  -- type 2 so that all resource costs are reported
  -- =============================================================
  select crc_frozen.organization_id   organization_id,
  -999     inventory_item_id,
  crc_frozen.resource_id    resource_id,
  0     material_cost,
  0     material_overhead_cost,
  decode(br.cost_element_id,
   3, nvl(crc_frozen.resource_rate,0),
   0)    resource_cost,
  decode(br.cost_element_id,
   4, nvl(crc_frozen.resource_rate,0),
   0)    outside_processing_cost,
  decode(br.cost_element_id,
   5, nvl(crc_frozen.resource_rate,0),
   0)    overhead_cost,
  nvl(crc_frozen.resource_rate,0)  item_cost 
  from cst_resource_costs crc_frozen,
  cst_cost_types cct2,
  bom_resources br,
  mtl_parameters mp
  where crc_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
  and crc_frozen.organization_id  = mp.organization_id
  and br.resource_id              = crc_frozen.resource_id
  and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                         -- p_org_code
  and 10=10                       -- p_cost_type2
  -- =============================================================
  -- If p_cost_type2 = frozen cost_type_id then we have all the 
  -- costs and don't need this union all statement
  -- =============================================================
  and cct2.cost_type_id    <> 1  -- frozen cost type
  -- =============================================================
  -- Check to see if the costs exist in cost type 2
  -- =============================================================
  and not exists (
   select 'x'
   from cst_resource_costs crc2
   where crc2.cost_type_id      = cct2.cost_type_id
   and crc2.organization_id   = crc_frozen.organization_id
   and crc2.resource_id       = crc_frozen.resource_id
      )
  ) cic2,
  -- ===========================
 -- end of getting resource costs 
  -- ===========================
 -- ==================================================================================
 -- Get WIP resource quantities from the WIP job information in wip_discrete_jobs
  -- ==================================================================================
 -- ==============================================
 -- Part III: Get the WIP_Resource Quantities
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
  round(wip.quantity,3) quantity,
  wip.resource_value,
  wip.scrapped_quantity
  from (
   -- ==============================================
   -- Part III: Get the WIP_Resource Quantities
   -- ==============================================   
   select 'Resource' txn_source,
   wor.organization_id,
   wdj.primary_item_id inventory_item_id,
   wor.wip_entity_id,
   wdj.class_code,
   wac.class_type,
   wdj.status_type,
   wdj.date_released,
   wdj.date_completed,
   wdj.last_update_date,
   br.resource_code resource_code,
   br.resource_id,
   ml.meaning transaction_type,
   (select max(wro.wip_supply_type)
    from wip_requirement_operations wro
    where wro.operation_seq_num = wor.operation_seq_num
    and wro.wip_entity_id = wor.wip_entity_id) wip_supply_type,
   wor.operation_seq_num op_seq_num,
   wor.resource_seq_num res_seq_num,
   wor.basis_type,
   wor.applied_resource_units quantity,
   wor.applied_resource_value resource_value,
   nvl(wor.relieved_res_scrap_units,0) scrapped_quantity
    from wip_discrete_jobs wdj,
   wip_accounting_classes wac,
   wip_operation_resources wor,
   bom_resources br,
   -- Notes for version 1.6, for performance reasons use mtl_parameters
   mtl_parameters mp,
   mfg_lookups ml -- Transaction_Type
   where mp.organization_id              = wdj.organization_id
   and wor.wip_entity_id               = wdj.wip_entity_id
   and wor.organization_id             = wdj.organization_id
   and mp.organization_id              = wdj.organization_id
   and wac.class_code                  = wdj.class_code
   and wac.organization_id             = wdj.organization_id
   -- Only want asset jobs
   and wac.class_type not in (4,6,7)
   and br.resource_id                  = wor.resource_id
   and ml.lookup_type                  = 'WIP_TRANSACTION_TYPE'
   and ml.lookup_code                  = 
    decode(br.cost_element_id,
     3,1, -- Resource transaction
     4,3) -- Outside processing
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
   -- Only want open non-zero hours and values
   and wor.applied_resource_units + wor.applied_resource_value <> 0
   -- Notes for version 1.6, for performance reasons use mtl_parameters
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
  and 9=9                             -- p_org_code
  ) wip
  group by
  wip.txn_source,
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
  wip.op_seq_num,
  wip.res_seq_num,
  wip.basis_type,
  round(wip.quantity,3), -- quantity
  wip.resource_value,
  wip.scrapped_quantity
 ) sumwip
 -- ===========================
 -- End of getting WIP quantities
  -- ===========================
-- ===================================================================
-- Joins for the item master, organization, item costs and pii costs
-- ===================================================================
where msiv.inventory_item_id          = sumwip.inventory_item_id
and msiv.organization_id            = sumwip.organization_id
and msiv.primary_uom_code           = muomv.uom_code
and misv.inventory_item_status_code = msiv.inventory_item_status_code
and we.wip_entity_id                = sumwip.wip_entity_id
and sumwip.resource_id              = cic1.resource_id
and sumwip.organization_id          = cic1.organization_id
and msiv.organization_id            = mp.organization_id
-- Outer join as you may have newly costed resources in the new
-- cost type which were never existed in the old cost type
and sumwip.resource_id              = cic2.resource_id (+)
and sumwip.organization_id          = cic2.organization_id (+)
-- ===================================================================
-- joins for the Lookup Codes
-- ===================================================================
and ml1.lookup_type                 = 'WIP_CLASS_TYPE'
and ml1.lookup_code                 = sumwip.class_type
and ml2.lookup_type                 = 'WIP_JOB_STATUS'
and ml2.lookup_code                 = sumwip.status_type
and ml3.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml3.lookup_code                 = msiv.planning_make_buy_code
and ml4.lookup_type (+)             = 'WIP_SUPPLY'
and ml4.lookup_code (+)             = sumwip.wip_supply_type
and ml5.lookup_type                 = 'CST_BASIS'
and ml5.lookup_code                 = sumwip.basis_type
-- Lookup codes for item types
and fcl.lookup_code (+)             = msiv.item_type
and fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- Joins for the currency exchange rates
-- ===================================================================
-- new FX rate
and gl.currency_code                = gdr1.from_currency
-- old FX rate
and gl.currency_code                = gdr2.from_currency
-- ===================================================================
-- Use base tables instead of HR organization views
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id             -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3)  -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1)  -- get the ledger_id
-- avoid selecting disabled inventory organizations
and sysdate           < nvl(haou.date_to, sysdate +1)
and 9=9                             -- p_org_code
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                             -- p_ledger, p_operating_unit
-- ===================================================================
-- Only report non-zero results
-- ===================================================================
-- Revision for version 1.5, make this a parameter
-- Item_Cost_Difference + Exchange_Rate_Difference <> 0
-- and (round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5))  
--   +  (gdr1.conversion_rate - gdr2.conversion_rate) <> 0
and decode(:p_all_wip_jobs,
  -- without a conversion rate compare the ledger currency costs
  'N', nvl(round(nvl(cic1.item_cost,0) * gdr1.conversion_rate,5) - round(nvl(cic2.item_cost,0) * gdr2.conversion_rate,5),
       round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5)),
  'Y', 1)               <> 0
-- End revision for version 1.5
union all
-- ==========================================================
-- Revision for version 1.7
-- Get the Production Overhead (Resource Overhead) Cost and
-- Value Cost Adjustments, for both resource-based overheads
-- (resource units and resource value) and move-based
-- overheads (item and lot)
-- ==========================================================
select  nvl(gl.short_name, gl.name)     Ledger,
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
 sumwip.overhead_code      Overhead_Code,
 sumwip.op_seq_num      Operation_Seq_Number,
 sumwip.res_seq_num      Resource_Seq_Number,
 ml5.meaning       Basis_Type,
 ml6.meaning       Overhead_Basis_Type,
 gl.currency_code      Currency_Code,
 muomv.uom_code       UOM_Code,
-- ==========================================================
-- Select the new and old overhead rates from Cost_Type 1 and 2
-- ==========================================================
 0        New_Material_Cost,
 0        Old_Material_Cost,
 0        New_Material_Overhead_Cost,
 0        Old_Material_Overhead_Cost,
 0        New_Resource_Cost,
 0        Old_Resource_Cost,
 0        New_Outside_Processing_Cost,
 0        Old_Outside_Processing_Cost,
 round(sumwip.new_overhead_cost,5)    New_Overhead_Cost,
 round(sumwip.old_overhead_cost,5)    Old_Overhead_Cost,
 round(sumwip.new_overhead_cost,5)    New_Gross_Item_Cost,
 round(sumwip.old_overhead_cost,5)    Old_Gross_Item_Cost,
-- ========================================================
-- WIP Overheads Do Not Have PII item costs
-- ========================================================
 0        New_PII_Cost,
 0        Old_PII_Cost,
 round(sumwip.new_overhead_cost,5)    New_Net_Item_Cost,
 round(sumwip.old_overhead_cost,5)    Old_Net_Item_Cost,
-- ========================================================
-- Select the overhead rates from Cost_Type 1 and 2 and compare
-- ========================================================
 round(sumwip.new_overhead_cost,5) - round(sumwip.old_overhead_cost,5) Gross_Item_Cost_Difference,
 case
   when round(sumwip.new_overhead_cost - sumwip.old_overhead_cost,5) = 0 then 0
   when round(sumwip.new_overhead_cost - sumwip.old_overhead_cost,5) = round(sumwip.new_overhead_cost,5) then  100
   when round(sumwip.old_overhead_cost - sumwip.new_overhead_cost,5) = round(sumwip.old_overhead_cost,5) then -100
   else round((sumwip.new_overhead_cost - sumwip.old_overhead_cost) / sumwip.old_overhead_cost * 100,2)
 end        Gross_Percent_Difference,
 0        PII_Item_Cost_Difference,
 0        PII_Percent_Difference,
 round(sumwip.new_overhead_cost,5) - round(sumwip.old_overhead_cost,5) Net_Item_Cost_Difference,
-- ===========================================================
-- Select the WIP quantities and values.  For overheads the WIP
-- quantity is the overhead basis quantity:  the operation
-- quantity completed (item), one (lot), the applied resource
-- units (resource units) or the applied resource units at the
-- resource rate (resource value).
-- ===========================================================
 muomv.uom_code       UOM_Code,
 round(decode(sumwip.new_overhead_cost, 0, sumwip.old_quantity, sumwip.new_quantity),3) WIP_Quantity,
 round(sumwip.new_value,2)     New_Gross_WIP_Value,
 0        New_PII_Value,
 round(sumwip.new_value,2)     New_Net_WIP_Value,
 round(sumwip.old_value,2)     Old_Gross_WIP_Value,
 0        Old_PII_Value,
 round(sumwip.old_value,2)     Old_Net_WIP_Value,
 round(sumwip.new_value,2) - round(sumwip.old_value,2)  Gross_WIP_Value_Difference,
 abs(round(sumwip.new_value,2) - round(sumwip.old_value,2)) Abs_WIP_Value_Difference,
 0        PII_Value_Difference,
 round(sumwip.new_value,2) - round(sumwip.old_value,2)  Net_WIP_Value_Difference,
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
 gdr1.conversion_rate      New_FX_Rate,
 gdr2.conversion_rate      Old_FX_Rate,
 gdr1.conversion_rate - gdr2.conversion_rate   Exchange_Rate_Difference,
-- ===========================================================
-- Costs in To Currency by Cost_Element, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
 0        "&p_to_currency_code New Material Value",
 0        "&p_to_currency_code Old Material Value",
 0        "&p_to_currency_code New Material Ovhd Value",
 0        "&p_to_currency_code Old Material Ovhd Value",
 0        "&p_to_currency_code New Resource Value",
 0        "&p_to_currency_code Old Resource Value",
 0        "&p_to_currency_code New OSP Value",
 0        "&p_to_currency_code Old OSP Value",
 round(sumwip.new_value * gdr1.conversion_rate,2)  "&p_to_currency_code New Overhead Value",
 round(sumwip.old_value * gdr2.conversion_rate,2)  "&p_to_currency_code Old Overhead Value",
-- ===========================================================
-- WIP_Values expressed in To Currency, new values at
-- new Fx rate and old values at old Fx rate
-- ===========================================================
 round(sumwip.new_value * gdr1.conversion_rate,2)  "&p_to_currency_code New Gross WIP Value",
 round(sumwip.old_value * gdr2.conversion_rate,2)  "&p_to_currency_code Old Gross WIP Value",
 round(sumwip.new_value * gdr1.conversion_rate -
  sumwip.old_value * gdr2.conversion_rate,2)  "&p_to_currency_code Gross WIP Value Diff",
 abs(round(sumwip.new_value * gdr1.conversion_rate -
  sumwip.old_value * gdr2.conversion_rate,2))  "&p_to_currency_code Abs WIP Value Diff",
 0        "&p_to_currency_code New PII Value",
 0        "&p_to_currency_code Old PII Value",
 0        "&p_to_currency_code PII Value Difference",
 round(sumwip.new_value * gdr1.conversion_rate,2)  "&p_to_currency_code New Net Value",
 round(sumwip.old_value * gdr2.conversion_rate,2)  "&p_to_currency_code Old Net Value",
 round(sumwip.new_value * gdr1.conversion_rate -
  sumwip.old_value * gdr2.conversion_rate,2)  "&p_to_currency_code Net Value Difference",
-- ===========================================================
-- Value Differences in To Currency using the new rate
-- New and Old costs at New Fx Rate
-- ===========================================================
 round((sumwip.new_value - sumwip.old_value) * gdr1.conversion_rate,2) "&p_to_currency_code Gross Value Diff-New Rate",
 0        "&p_to_currency_code PII Value Diff-New Rate",
 round((sumwip.new_value - sumwip.old_value) * gdr1.conversion_rate,2) "&p_to_currency_code Net Value Diff-New Rate",
-- ===========================================================
-- Value Differences in To Currency using the old rate
-- New and Old costs at Old Fx Rate
-- ===========================================================
 round((sumwip.new_value - sumwip.old_value) * gdr2.conversion_rate,2) "&p_to_currency_code Gross Value Diff-Old Rate",
 0        "&p_to_currency_code PII Value Diff-Old Rate",
 round((sumwip.new_value - sumwip.old_value) * gdr2.conversion_rate,2) "&p_to_currency_code Net Value Diff-Old Rate",
-- ===========================================================
-- Value Differences comparing the new less the old rate differences
-- ===========================================================
 round((sumwip.new_value - sumwip.old_value) * gdr1.conversion_rate,2) -
 round((sumwip.new_value - sumwip.old_value) * gdr2.conversion_rate,2) "&p_to_currency_code Gross Value FX Diff",
 0         "&p_to_currency_code PII Value FX Diff",
 round((sumwip.new_value - sumwip.old_value) * gdr1.conversion_rate,2) -
 round((sumwip.new_value - sumwip.old_value) * gdr2.conversion_rate,2) "&p_to_currency_code Net Value FX Diff"
from mtl_system_items_vl msiv,
 mtl_units_of_measure_vl muomv,
 mtl_item_status_vl misv,
 wip_entities we,
 mtl_parameters mp,
 mfg_lookups ml1,  -- WIP_Class_Type
 mfg_lookups ml2,  -- WIP_Job_Status
 mfg_lookups ml3,  -- Planning Make_Buy_Code
 mfg_lookups ml4,  -- WIP_Supply_Type
 mfg_lookups ml5,  -- Resource Basis_Type
 mfg_lookups ml6,  -- Overhead Basis_Type
 fnd_common_lookups fcl,
 hr_organization_information hoi,
 hr_all_organization_units_vl haou,  -- inv_organization_id
 hr_all_organization_units_vl haou2, -- operating unit
 gl_ledgers gl,
 -- ===========================================================================
 -- Select New Currency Rates based on the new concurrency conversion date
 -- ===========================================================================
 (select gl.currency_code from_currency,
  decode(gl.currency_code, :p_to_currency_code, 1,
  (select gdr1.conversion_rate
       from gl_daily_rates gdr1,
       gl_daily_conversion_types gdct1
       where gdr1.from_currency = gl.currency_code
       and gdr1.conversion_type = gdct1.conversion_type
       and 4=4                        -- p_curr_conv_date1
       and 5=5                        -- p_curr_conv_type1
       and 11=11                      -- p_to_currency_code
      )) conversion_rate
  from (select distinct gl.currency_code from gl_ledgers gl) gl
 ) gdr1, -- NEW Currency Rates, 1 for the same currency, blank when the rate is missing
 -- ===========================================================================
 -- Select Old Currency Rates based on the old concurrency conversion date
 -- ===========================================================================
 (select gl.currency_code from_currency,
  decode(gl.currency_code, :p_to_currency_code, 1,
  (select gdr2.conversion_rate
       from gl_daily_rates gdr2,
       gl_daily_conversion_types gdct2
       where gdr2.from_currency = gl.currency_code
       and gdr2.conversion_type = gdct2.conversion_type
       and 6=6                        -- p_curr_conv_date2
       and 7=7                        -- p_curr_conv_type2
       and gdr2.to_currency = :p_to_currency_code
      )) conversion_rate
  from (select distinct gl.currency_code from gl_ledgers gl) gl
 ) gdr2, -- OLD Currency Rates, 1 for the same currency, blank when the rate is missing
 -- ==================================================================================
 -- Part IV: Get the WIP Overhead Quantities, Rates and Values
 -- ==================================================================================
 -- ================================================
 -- Condense down to WIP_Job, Op, Resource and Overhead,
 -- with the new and old rates, basis and values side by side
 -- ================================================
 (with
  -- =================================================
  -- Get the department overhead rates for Cost_Type 1
  -- (New) and Cost_Type 2 (Old), one row per cost type
  -- =================================================
  cdo as
  (select cdo1.organization_id,
   cdo1.department_id,
   cdo1.overhead_id,
   cdo1.cost_type_id,
   cdo1.basis_type,
   nvl(cdo1.rate_or_amount,0) overhead_rate,
   'N' new_old
   from cst_department_overheads cdo1,
   cst_cost_types cct1,
   mtl_parameters mp
   where cct1.cost_type_id           = cdo1.cost_type_id
   and cdo1.organization_id        = mp.organization_id
   -- Do not report the master inventory organization
   and mp.organization_id         <> mp.master_organization_id
   and 8=8                         -- p_cost_type1
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
   and 9=9                         -- p_org_code
   union all
   -- =============================================================
   -- Get the rates from the frozen cost type that are not in cost
   -- type 1 so that all overhead rates are reported
   -- =============================================================
   select cdo_frozen.organization_id,
   cdo_frozen.department_id,
   cdo_frozen.overhead_id,
   cdo_frozen.cost_type_id,
   cdo_frozen.basis_type,
   nvl(cdo_frozen.rate_or_amount,0) overhead_rate,
   'N' new_old
   from cst_department_overheads cdo_frozen,
   cst_cost_types cct1,
   mtl_parameters mp
   where cdo_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
   and cdo_frozen.organization_id  = mp.organization_id
   -- Do not report the master inventory organization
   and mp.organization_id         <> mp.master_organization_id
   and 8=8                         -- p_cost_type1
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
   and 9=9                         -- p_org_code
   -- =============================================================
   -- If p_cost_type1 = frozen cost_type_id then we have all the 
   -- rates and don't need this union all statement
   -- =============================================================
   and cct1.cost_type_id    <> 1  -- frozen cost type
   and not exists (
    select 'x'
    from cst_department_overheads cdo1
    where cdo1.cost_type_id      = cct1.cost_type_id
    and cdo1.organization_id   = cdo_frozen.organization_id
    and cdo1.department_id     = cdo_frozen.department_id
    and cdo1.overhead_id       = cdo_frozen.overhead_id
       )
   union all
   select cdo2.organization_id,
   cdo2.department_id,
   cdo2.overhead_id,
   cdo2.cost_type_id,
   cdo2.basis_type,
   nvl(cdo2.rate_or_amount,0) overhead_rate,
   'O' new_old
   from cst_department_overheads cdo2,
   cst_cost_types cct2,
   mtl_parameters mp
   where cct2.cost_type_id           = cdo2.cost_type_id
   and cdo2.organization_id        = mp.organization_id
   -- Do not report the master inventory organization
   and mp.organization_id         <> mp.master_organization_id
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
   and 9=9                         -- p_org_code
   and 10=10                       -- p_cost_type2
   union all
   -- =============================================================
   -- Get the rates from the frozen cost type that are not in cost
   -- type 2 so that all overhead rates are reported
   -- =============================================================
   select cdo_frozen.organization_id,
   cdo_frozen.department_id,
   cdo_frozen.overhead_id,
   cdo_frozen.cost_type_id,
   cdo_frozen.basis_type,
   nvl(cdo_frozen.rate_or_amount,0) overhead_rate,
   'O' new_old
   from cst_department_overheads cdo_frozen,
   cst_cost_types cct2,
   mtl_parameters mp
   where cdo_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
   and cdo_frozen.organization_id  = mp.organization_id
   -- Do not report the master inventory organization
   and mp.organization_id         <> mp.master_organization_id
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
   and 9=9                         -- p_org_code
   and 10=10                       -- p_cost_type2
   -- =============================================================
   -- If p_cost_type2 = frozen cost_type_id then we have all the 
   -- rates and don't need this union all statement
   -- =============================================================
   and cct2.cost_type_id    <> 1  -- frozen cost type
   and not exists (
    select 'x'
    from cst_department_overheads cdo2
    where cdo2.cost_type_id      = cct2.cost_type_id
    and cdo2.organization_id   = cdo_frozen.organization_id
    and cdo2.department_id     = cdo_frozen.department_id
    and cdo2.overhead_id       = cdo_frozen.overhead_id
       )
  ),
  -- =================================================
  -- Get the resource rates for Cost_Type 1
  -- (New) and Cost_Type 2 (Old), one row per cost type
  -- =================================================
  crc as
  (select crc1.organization_id,
   crc1.resource_id,
   nvl(crc1.resource_rate,0) resource_rate,
   'N' new_old
   from cst_resource_costs crc1,
   cst_cost_types cct1,
   mtl_parameters mp
   where cct1.cost_type_id           = crc1.cost_type_id
   and crc1.organization_id        = mp.organization_id
   -- Do not report the master inventory organization
   and mp.organization_id         <> mp.master_organization_id
   and 8=8                         -- p_cost_type1
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
   and 9=9                         -- p_org_code
   union all
   -- =============================================================
   -- Get the rates from the frozen cost type that are not in cost
   -- type 1 so that all resource rates are reported
   -- =============================================================
   select crc_frozen.organization_id,
   crc_frozen.resource_id,
   nvl(crc_frozen.resource_rate,0) resource_rate,
   'N' new_old
   from cst_resource_costs crc_frozen,
   cst_cost_types cct1,
   mtl_parameters mp
   where crc_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
   and crc_frozen.organization_id  = mp.organization_id
   -- Do not report the master inventory organization
   and mp.organization_id         <> mp.master_organization_id
   and 8=8                         -- p_cost_type1
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
   and 9=9                         -- p_org_code
   -- =============================================================
   -- If p_cost_type1 = frozen cost_type_id then we have all the 
   -- rates and don't need this union all statement
   -- =============================================================
   and cct1.cost_type_id    <> 1  -- frozen cost type
   and not exists (
    select 'x'
    from cst_resource_costs crc1
    where crc1.cost_type_id      = cct1.cost_type_id
    and crc1.organization_id   = crc_frozen.organization_id
    and crc1.resource_id       = crc_frozen.resource_id
       )
   union all
   select crc2.organization_id,
   crc2.resource_id,
   nvl(crc2.resource_rate,0) resource_rate,
   'O' new_old
   from cst_resource_costs crc2,
   cst_cost_types cct2,
   mtl_parameters mp
   where cct2.cost_type_id           = crc2.cost_type_id
   and crc2.organization_id        = mp.organization_id
   -- Do not report the master inventory organization
   and mp.organization_id         <> mp.master_organization_id
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
   and 9=9                         -- p_org_code
   and 10=10                       -- p_cost_type2
   union all
   -- =============================================================
   -- Get the rates from the frozen cost type that are not in cost
   -- type 2 so that all resource rates are reported
   -- =============================================================
   select crc_frozen.organization_id,
   crc_frozen.resource_id,
   nvl(crc_frozen.resource_rate,0) resource_rate,
   'O' new_old
   from cst_resource_costs crc_frozen,
   cst_cost_types cct2,
   mtl_parameters mp
   where crc_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
   and crc_frozen.organization_id  = mp.organization_id
   -- Do not report the master inventory organization
   and mp.organization_id         <> mp.master_organization_id
   and mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
   and 9=9                         -- p_org_code
   and 10=10                       -- p_cost_type2
   -- =============================================================
   -- If p_cost_type2 = frozen cost_type_id then we have all the 
   -- rates and don't need this union all statement
   -- =============================================================
   and cct2.cost_type_id    <> 1  -- frozen cost type
   and not exists (
    select 'x'
    from cst_resource_costs crc2
    where crc2.cost_type_id      = cct2.cost_type_id
    and crc2.organization_id   = crc_frozen.organization_id
    and crc2.resource_id       = crc_frozen.resource_id
       )
  )
  select ovhd.organization_id,
  ovhd.inventory_item_id,
  ovhd.wip_entity_id,
  ovhd.class_code,
  ovhd.class_type,
  ovhd.status_type,
  ovhd.date_released,
  ovhd.date_completed,
  ovhd.last_update_date,
  ovhd.resource_code,
  ovhd.overhead_code,
  ovhd.transaction_type,
  (select max(wro.wip_supply_type)
   from wip_requirement_operations wro
   where wro.operation_seq_num = ovhd.op_seq_num
   and wro.wip_entity_id = ovhd.wip_entity_id) wip_supply_type,
  ovhd.op_seq_num,
  ovhd.res_seq_num,
  ovhd.res_basis_type,
  ovhd.ovhd_basis_type,
  nvl(sum(decode(ovhd.new_old, 'N', ovhd.overhead_rate)),0) new_overhead_cost,
  nvl(sum(decode(ovhd.new_old, 'O', ovhd.overhead_rate)),0) old_overhead_cost,
  nvl(sum(decode(ovhd.new_old, 'N', ovhd.quantity)),0) new_quantity,
  nvl(sum(decode(ovhd.new_old, 'O', ovhd.quantity)),0) old_quantity,
  nvl(sum(decode(ovhd.new_old, 'N', ovhd.quantity * ovhd.overhead_rate)),0) new_value,
  nvl(sum(decode(ovhd.new_old, 'O', ovhd.quantity * ovhd.overhead_rate)),0) old_value
  from (
   -- ==============================================
   -- Part IV.A: Move-based overheads, earned on the
   -- operation completions.  Item basis earns on each
   -- unit completed, Lot basis earns once per operation.
   -- ==============================================
   select wdj.organization_id,
   wdj.primary_item_id inventory_item_id,
   wdj.wip_entity_id,
   wdj.class_code,
   wac.class_type,
   wdj.status_type,
   wdj.date_released,
   wdj.date_completed,
   wdj.last_update_date,
   null resource_code,
   br_ovhd.resource_code overhead_code,
   ml.meaning transaction_type,
   wo.operation_seq_num op_seq_num,
   to_number(null) res_seq_num,
   to_number(null) res_basis_type,
   cdo.basis_type ovhd_basis_type,
   cdo.new_old,
   cdo.overhead_rate,
   decode(cdo.basis_type,
    1, wo.quantity_completed, -- Item
    2, 1)   quantity  -- Lot
   from wip_discrete_jobs wdj,
   wip_accounting_classes wac,
   wip_operations wo,
   bom_resources br_ovhd,
   mfg_lookups ml, -- Transaction_Type
   cdo
   where wo.wip_entity_id                = wdj.wip_entity_id
   and wo.organization_id              = wdj.organization_id
   and wac.class_code                  = wdj.class_code
   and wac.organization_id             = wdj.organization_id
   -- Only want asset jobs
   and wac.class_type not in (4,6,7)
   and cdo.organization_id             = wo.organization_id
   and cdo.department_id               = wo.department_id
   and cdo.basis_type in (1,2)         -- Item or Lot
   and br_ovhd.resource_id             = cdo.overhead_id
   and ml.lookup_type                  = 'WIP_TRANSACTION_TYPE'
   and ml.lookup_code                  = 2 -- Overhead transaction
   -- Avoid assemblies issued from expense subinventories at zero cost
   and nvl(wdj.issue_zero_cost_flag, 'N') = 'N'
   -- Only want open WIP jobs
   and wdj.date_closed is null
   -- Only want operations with completed units
   and wo.quantity_completed <> 0
   union all
   -- ==============================================
   -- Part IV.B: Resource-based overheads, earned on the
   -- applied resource units or on the applied resource
   -- value.  As the resource charges are revalued to the
   -- resource rates of each cost type, the resource value
   -- is the applied resource units at the resource rate.
   -- ==============================================
   select res.organization_id,
   res.inventory_item_id,
   res.wip_entity_id,
   res.class_code,
   res.class_type,
   res.status_type,
   res.date_released,
   res.date_completed,
   res.last_update_date,
   res.resource_code,
   res.overhead_code,
   res.transaction_type,
   res.op_seq_num,
   res.res_seq_num,
   res.res_basis_type,
   res.ovhd_basis_type,
   res.new_old,
   res.overhead_rate,
   decode(res.ovhd_basis_type,
    3, res.applied_resource_units, -- Resource units
    4, res.applied_resource_units * nvl(crc.resource_rate,0)) quantity -- Resource value
   from (select wdj.organization_id,
    wdj.primary_item_id inventory_item_id,
    wdj.wip_entity_id,
    wdj.class_code,
    wac.class_type,
    wdj.status_type,
    wdj.date_released,
    wdj.date_completed,
    wdj.last_update_date,
    br.resource_code,
    br.resource_id,
    br_ovhd.resource_code overhead_code,
    ml.meaning transaction_type,
    wor.operation_seq_num op_seq_num,
    wor.resource_seq_num res_seq_num,
    wor.basis_type res_basis_type,
    wor.applied_resource_units,
    cdo.basis_type ovhd_basis_type,
    cdo.new_old,
    cdo.overhead_rate
    from wip_discrete_jobs wdj,
    wip_accounting_classes wac,
    wip_operations wo,
    wip_operation_resources wor,
    bom_resources br,
    bom_resources br_ovhd,
    cst_resource_overheads cro,
    mfg_lookups ml, -- Transaction_Type
    cdo
    where wo.wip_entity_id                = wdj.wip_entity_id
    and wo.organization_id              = wdj.organization_id
    and wor.wip_entity_id               = wo.wip_entity_id
    and wor.operation_seq_num           = wo.operation_seq_num
    and wor.organization_id             = wo.organization_id
    and wac.class_code                  = wdj.class_code
    and wac.organization_id             = wdj.organization_id
    -- Only want asset jobs
    and wac.class_type not in (4,6,7)
    and br.resource_id                  = wor.resource_id
    and cdo.organization_id             = wo.organization_id
    and cdo.department_id               = wo.department_id
    and cdo.basis_type in (3,4)         -- Resource units or Resource value
    and br_ovhd.resource_id             = cdo.overhead_id
    -- The overhead must be assigned to the resource, in the
    -- same cost type as the department overhead rate
    and cro.cost_type_id                = cdo.cost_type_id
    and cro.organization_id             = cdo.organization_id
    and cro.overhead_id                 = cdo.overhead_id
    and cro.resource_id                 = wor.resource_id
    and ml.lookup_type                  = 'WIP_TRANSACTION_TYPE'
    and ml.lookup_code                  = 2 -- Overhead transaction
    -- Avoid assemblies issued from expense subinventories at zero cost
    and nvl(wdj.issue_zero_cost_flag, 'N') = 'N'
    -- Only want open WIP jobs
    and wdj.date_closed is null
    -- Only want open non-zero hours
    and wor.applied_resource_units <> 0
   ) res,
   crc
   where res.organization_id             = crc.organization_id (+)
   and res.resource_id                 = crc.resource_id (+)
   and res.new_old                     = crc.new_old (+)
  ) ovhd
  group by
  ovhd.organization_id,
  ovhd.inventory_item_id,
  ovhd.wip_entity_id,
  ovhd.class_code,
  ovhd.class_type,
  ovhd.status_type,
  ovhd.date_released,
  ovhd.date_completed,
  ovhd.last_update_date,
  ovhd.resource_code,
  ovhd.overhead_code,
  ovhd.transaction_type,
  ovhd.op_seq_num,
  ovhd.res_seq_num,
  ovhd.res_basis_type,
  ovhd.ovhd_basis_type
 ) sumwip
 -- ===========================
 -- End of getting WIP overhead quantities
 -- ===========================
-- ===================================================================
-- Joins for the item master and organization
-- ===================================================================
where msiv.inventory_item_id          = sumwip.inventory_item_id
and msiv.organization_id            = sumwip.organization_id
and msiv.primary_uom_code           = muomv.uom_code
and misv.inventory_item_status_code = msiv.inventory_item_status_code
and we.wip_entity_id                = sumwip.wip_entity_id
and msiv.organization_id            = mp.organization_id
-- ===================================================================
-- joins for the Lookup Codes
-- ===================================================================
and ml1.lookup_type                 = 'WIP_CLASS_TYPE'
and ml1.lookup_code                 = sumwip.class_type
and ml2.lookup_type                 = 'WIP_JOB_STATUS'
and ml2.lookup_code                 = sumwip.status_type
and ml3.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and ml3.lookup_code                 = msiv.planning_make_buy_code
and ml4.lookup_type (+)             = 'WIP_SUPPLY'
and ml4.lookup_code (+)             = sumwip.wip_supply_type
and ml5.lookup_type (+)             = 'CST_BASIS'
and ml5.lookup_code (+)             = sumwip.res_basis_type
and ml6.lookup_type                 = 'CST_BASIS'
and ml6.lookup_code                 = sumwip.ovhd_basis_type
-- Lookup codes for item types
and fcl.lookup_code (+)             = msiv.item_type
and fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- Joins for the currency exchange rates
-- ===================================================================
-- new FX rate
and gl.currency_code                = gdr1.from_currency
-- old FX rate
and gl.currency_code                = gdr2.from_currency
-- ===================================================================
-- Use base tables instead of HR organization views
-- ===================================================================
and hoi.org_information_context     = 'Accounting Information'
and hoi.organization_id             = mp.organization_id
and hoi.organization_id             = haou.organization_id             -- this gets the organization name
and haou2.organization_id           = to_number(hoi.org_information3)  -- this gets the operating unit id
and gl.ledger_id                    = to_number(hoi.org_information1)  -- get the ledger_id
-- avoid selecting disabled inventory organizations
and sysdate           < nvl(haou.date_to, sysdate +1)
and 9=9                             -- p_org_code
and gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and 1=1                             -- p_ledger, p_operating_unit
-- ===================================================================
-- Only report non-zero results
-- ===================================================================
and decode(:p_all_wip_jobs,
  -- without a conversion rate compare the ledger currency values
  'N', nvl(round(sumwip.new_value * gdr1.conversion_rate,5) - round(sumwip.old_value * gdr2.conversion_rate,5),
       round(sumwip.new_value,5) - round(sumwip.old_value,5)),
  'Y', 1)               <> 0
-- End revision for version 1.7
order by 1,2,3,4,5,6,7,8,9,10,11
