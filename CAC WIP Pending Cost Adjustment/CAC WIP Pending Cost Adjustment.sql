/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Pending Cost Adjustment
-- Description: Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues and WIP resource (labor) transactions.  (Note that resource overheads / production overheads are not included in this report version.)  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session.   And if you choose Yes for "Include All WIP Jobs" all WIP jobs will be reported even if there are no valuation changes.

Parameters:
===========
Cost Type (New):  enter the Cost Type that has the revised or new item costs (mandatory).
Cost Type (Old):  enter the Cost Type that has the existing or current item costs, defaults to the Frozen Cost Type (mandatory).
Currency Conversion Date (New):  enter the currency conversion date to use for the new item costs (mandatory).
Currency Conversion Type (New):  enter the currency conversion type to use for the new item costs, defaults to Corporate (mandatory).
Currency Conversion Date (Old):  enter the currency conversion date to use for the existing item costs (mandatory).
Currency Conversion Type (Old):  enter the currency conversion type to use for the existing item costs, defaults to Corporate (mandatory).
To Currency Code:  enter the currency code used to translate the item costs and inventory values into.
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  The second item category set to report, typically the Inventory Category Set (optional).
Include All WIP Jobs:  enter No to only report WIP jobs with valuation changes, enter Yes to report all WIP jobs. (mandatory).
Item Number:  specific buy or make item you wish to report (optional).
Organization Code:  enter the inventory organization(s) you wish to report, defaults to your session's inventory organization (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2020 - 2024 Douglas Volz Consulting, Inc.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission. All rights reserved.
-- +=============================================================================+

-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 04 Dec 2020 Douglas Volz   Created initial Report based on the Pending
-- |                                     Cost Adjustment Report for Inventory and Intransit.
-- |      1.1 11 Dec 2020 Douglas Volz   Corrected cost adjustments for assemblies
-- |      1.2 16 Dec 2020 Douglas Volz   Change SIGN of completion quantities to match
-- |                                     the Oracle WIP Standard Cost Adjustment Report.
-- |      1.3 10 Feb 2021 Douglas Volz   Fixes for WIP completion quantities, needed to
-- |                                     change the SIGN of completion quantities.
-- |      1.4 17 Feb 2021 Douglas Volz   Add absolute difference column.
-- |      1.5 13 Dec 2021 Douglas Volz   Add parameter to report all WIP jobs, even
-- |                                     if there is no valuation change.
-- |      1.6 12 Feb 2024 Douglas Volz   Remove tabs, simplify G/L conversion rates,
-- |                                     added inventory org access security.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-wip-pending-cost-adjustment/
-- Library Link: https://www.enginatics.com/reports/cac-wip-pending-cost-adjustment/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
-- ==========================================================
-- Get the Material_Cost and Value Cost Adjustments
-- ==========================================================
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        haou.name Organization_Name,
        sumwip.class_code WIP_Class,
        ml1.meaning Class_Type,
        we.wip_entity_name WIP_Job,
        ml2.meaning Job_Status,
        sumwip.date_released Date_Released,
        sumwip.date_completed Date_Completed,
        sumwip.last_update_date Last_Update_Date,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
&category_columns
        fcl.meaning Item_Type,
        misv.inventory_item_status_code_tl Item_Status,
        ml3.meaning Make_Buy_Code,
        ml4.meaning Supply_Type,
        sumwip.transaction_type Transaction_Type,
        sumwip.resource_code Resource_Code,
        sumwip.op_seq_num Operation_Seq_Number,
        sumwip.res_seq_num Resource_Seq_Number,
        ml5.meaning Basis_Type,
        gl.currency_code Currency_Code,
        muomv.uom_code UOM_Code,
-- ==========================================================
-- Select the new and old item costs from Cost_Type 1 and 2
-- ==========================================================
        round(nvl(cic1.material_cost,0),5) New_Material_Cost,
        round(nvl(cic2.material_cost,0),5) Old_Material_Cost,
        -- Revision for version 1.1, remove tl_material_overhead for
        -- assembly completions and only for WIP Standard Discrete Jobs
        case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
                round(nvl(cic1.material_overhead_cost,0) - nvl(cic1.tl_material_overhead,0),5)
           else round(nvl(cic1.material_overhead_cost,0),5)
        end New_Material_Overhead_Cost,
        case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
                round(nvl(cic2.material_overhead_cost,0) - nvl(cic2.tl_material_overhead,0),5)
           else round(nvl(cic2.material_overhead_cost,0),5)
        end Old_Material_Overhead_Cost,
        -- End revision for version 1.1
        round(nvl(cic1.resource_cost,0),5) New_Resource_Cost,
        round(nvl(cic2.resource_cost,0),5) Old_Resource_Cost,
        round(nvl(cic1.outside_processing_cost,0),5) New_Outside_Processing_Cost,
        round(nvl(cic2.outside_processing_cost,0),5) Old_Outside_Processing_Cost,
        round(nvl(cic1.overhead_cost,0),5) New_Overhead_Cost,
        round(nvl(cic2.overhead_cost,0),5) Old_Overhead_Cost,
        -- Revision for version 1.1, remove tl_material_overhead for
        -- assembly completions and only for WIP Standard Discrete Jobs
        case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
                round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
           else round(nvl(cic1.item_cost,0),5)
        end New_Item_Cost,
        case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
                round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
           else round(nvl(cic2.item_cost,0),5)
        end Old_Item_Cost,
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
        end Item_Cost_Difference,
        --case
        --  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = 0 then 0
        --  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic1.item_cost,0),5) then  100
        --  when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic2.item_cost,0),5) then -100
        --  else round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) / nvl(cic2.item_cost,0) * 100,1)
        --end Percent_Difference,
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
        end,2) Percent_Difference,
        -- End of revision for version 1.1
-- ===========================================================
-- Select the WIP quantities and values
-- ===========================================================
        muomv.uom_code UOM_Code,
        -- Revision for version 1.2
        -- Show the WIP Completion Quantity as a positive number
        -- to match the Oracle WIP Std Cost Adjustment Report
        -- decode(sumwip.txn_source, 'WIP Completion', -1 * sumwip.quantity, sumwip.quantity) WIP_Quantity,
        sumwip.quantity WIP_Quantity,
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
           ,2)) New_Onhand_Value,
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        round(
        case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
                round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
           else round(nvl(cic2.item_cost,0),5)
        end * sumwip.quantity
           ,2)) Old_Onhand_Value,
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
           ,2)) Onhand_Value_Difference,
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
           ,2))) Abs_Onhand_Value_Difference,
        -- End revision for version 1.4
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
        nvl(nvl(gdr1.conversion_rate,1),1) New_FX_Rate,
        nvl(gdr2.conversion_rate,1) Old_FX_Rate,
        nvl(nvl(gdr1.conversion_rate,1),1) - nvl(gdr2.conversion_rate,1) Exchange_Rate_Difference,
-- ===========================================================
-- Select To Currency WIP quantities and values
-- ===========================================================
-- ===========================================================
-- Costs in To Currency by Cost_Element, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        round(nvl(cic1.material_cost,0) * nvl(nvl(gdr1.conversion_rate,1),1)
        * sumwip.quantity,2)) "&p_to_currency_code New Material Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        round(nvl(cic2.material_cost,0) * nvl(gdr2.conversion_rate,1)
        * sumwip.quantity,2)) "&p_to_currency_code Old Material Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        -- Revision for version 1.1
        round(
        case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
                round(nvl(cic1.material_overhead_cost,0) - nvl(cic1.tl_material_overhead,0),5)
           else round(nvl(cic1.material_overhead_cost,0),5)
        end * sumwip.quantity * nvl(nvl(gdr1.conversion_rate,1),1)
           ,2)) "&p_to_currency_code New Material Ovhd Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        round(
        case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
                round(nvl(cic2.material_overhead_cost,0) - nvl(cic2.tl_material_overhead,0),5)
           else round(nvl(cic2.material_overhead_cost,0),5)
        end * sumwip.quantity * nvl(gdr2.conversion_rate,1)
           ,2)) "&p_to_currency_code Old Material Ovhd Value",
        -- End revision for version 1.1
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        round(nvl(cic1.resource_cost,0) * nvl(nvl(gdr1.conversion_rate,1),1)
        * sumwip.quantity,2)) "&p_to_currency_code New Resource Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        round(nvl(cic2.resource_cost,0) * nvl(gdr2.conversion_rate,1)
        * sumwip.quantity,2)) "&p_to_currency_code Old Resource Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        round(nvl(cic1.outside_processing_cost,0) * nvl(nvl(gdr1.conversion_rate,1),1)
        * sumwip.quantity,2)) "&p_to_currency_code New OSP Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        round(nvl(cic2.outside_processing_cost,0) * nvl(gdr2.conversion_rate,1)
        * sumwip.quantity,2)) "&p_to_currency_code Old OSP Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        round(nvl(cic1.overhead_cost,0) * nvl(gdr1.conversion_rate,1)
        * sumwip.quantity,2)) "&p_to_currency_code New Overhead Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        round(nvl(cic2.overhead_cost,0) * nvl(gdr2.conversion_rate,1)
        * sumwip.quantity,2)) "&p_to_currency_code Old Overhead Value",
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
           ,2)) "&p_to_currency_code New Onhand Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        round(
        case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then 
                round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
           else round(nvl(cic2.item_cost,0),5)
        end * sumwip.quantity * nvl(gdr2.conversion_rate,1)
           ,2)) "&p_to_currency_code Old Onhand Value",
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
           ,2)) "&p_to_currency_code Onhand Value Difference",
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
           ,2))) "&p_to_currency_code Abs Onhand Value Diff",
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
        sumwip.quantity,2)) "&p_to_currency_code Value Difference-New Rate",
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
        sumwip.quantity,2)) "&p_to_currency_code Value Difference-Old Rate",
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
        sumwip.quantity,2)) "&p_to_currency_code Value FX Difference"
from    mtl_system_items_vl msiv,
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
(select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:p_conversion_date1 and gdct.user_conversion_type=:p_user_conversion_type1 and gdr.to_currency=:p_to_currency and gdct.conversion_type=gdr.conversion_type) gdr1, -- NEW Currency Rates
 -- ===========================================================================
 -- Select Old Currency Rates based on the old concurrency conversion date
 -- ===========================================================================
(select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:p_conversion_date2 and gdct.user_conversion_type=:p_user_conversion_type2 and gdr.to_currency=:p_to_currency and gdct.conversion_type=gdr.conversion_type) gdr2,  -- OLD Currency Rates
        -- =================================================
        -- Get the item costs for Cost_Type 1 - New Costs
        -- =================================================
        (select cic1.organization_id,
                cic1.inventory_item_id,
                -999 resource_id,
                nvl(cic1.material_cost,0) material_cost,
                nvl(cic1.material_overhead_cost,0) material_overhead_cost,
                nvl(cic1.resource_cost,0) resource_cost,
                nvl(cic1.outside_processing_cost,0) outside_processing_cost,
                nvl(cic1.overhead_cost,0) overhead_cost,
                nvl(cic1.item_cost,0) item_cost,
                -- Revision for version 1.1
                nvl(cic1.tl_material_overhead,0) tl_material_overhead
         from   cst_item_costs cic1,
                cst_cost_types cct1,
                mtl_parameters mp
         where  cct1.cost_type_id           = cic1.cost_type_id
         and    cic1.organization_id        = mp.organization_id
         -- Do not report the master inventory organization
         and    mp.organization_id         <> mp.master_organization_id
         and    8=8                         -- p_cost_type1
         and    9=9                         -- p_org_code
         -- Revision for version 1.6
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         union all
         -- =============================================================
         -- Get the costs from the frozen cost type that is not in cost
         -- type 1 so that all of the inventory value is reported
         -- =============================================================
         select cic_frozen.organization_id,
                cic_frozen.inventory_item_id,
                -999 resource_id,
                nvl(cic_frozen.material_cost,0) material_cost,
                nvl(cic_frozen.material_overhead_cost,0) material_overhead_cost,
                nvl(cic_frozen.resource_cost,0) resource_cost,
                nvl(cic_frozen.outside_processing_cost,0) outside_processing_cost,
                nvl(cic_frozen.overhead_cost,0) overhead_cost,
                nvl(cic_frozen.item_cost,0) item_cost,
                -- Revision for version 1.1
                nvl(cic_frozen.tl_material_overhead,0) tl_material_overhead
         from   cst_item_costs cic_frozen,
                cst_cost_types cct1,
                mtl_parameters mp
         where  cic_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
         -- Do not report the master inventory organization
         and    mp.organization_id         <> mp.master_organization_id
         and    8=8                         -- p_cost_type1
         and    9=9                         -- p_org_code
         -- Revision for version 1.6
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         -- =============================================================
         -- If p_cost_type1 = frozen cost_type_id then we have all the 
         -- costs and don't need this union all statement
         -- =============================================================
         and    cct1.cost_type_id           <> 1  -- frozen cost type
         and    cic_frozen.organization_id  = mp.organization_id
         -- Revision for version 1.2, parameter to only_items_in_cost_type
         and    13=13
         -- =============================================================
         -- Check to see if the costs exist in cost type 1 
         -- =============================================================
         and not exists (
                         select 'x'
                         from   cst_item_costs cic1
                         where  cic1.cost_type_id      = cct1.cost_type_id
                         and    cic1.organization_id   = cic_frozen.organization_id
                         and    cic1.inventory_item_id = cic_frozen.inventory_item_id
                        )
         ) cic1,
        -- =================================================
        -- Get the item costs for Cost_Type 2 - Old Costs
        -- =================================================
        (select cic2.organization_id,
                cic2.inventory_item_id,
                -999 resource_id,
                nvl(cic2.material_cost,0) material_cost,
                nvl(cic2.material_overhead_cost,0) material_overhead_cost,
                nvl(cic2.resource_cost,0) resource_cost,
                nvl(cic2.outside_processing_cost,0) outside_processing_cost,
                nvl(cic2.overhead_cost,0) overhead_cost,
                nvl(cic2.item_cost,0) item_cost,
                -- Revision for version 1.1
                nvl(cic2.tl_material_overhead,0) tl_material_overhead
         from   cst_item_costs cic2,
                cst_cost_types cct2,
                mtl_parameters mp
         where  cct2.cost_type_id           = cic2.cost_type_id
         and    cic2.organization_id        = mp.organization_id
         -- Do not report the master inventory organization
         and    mp.organization_id         <> mp.master_organization_id
         and    9=9                         -- p_org_code
         -- Revision for version 1.6
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    10=10                       -- p_cost_type2
         union all
         -- =============================================================
         -- Get the costs from the frozen cost type that is not in cost
         -- type 2 so that all of the inventory value is reported
         -- =============================================================
         select cic_frozen.organization_id,
                cic_frozen.inventory_item_id,
                -999 resource_id,
                nvl(cic_frozen.material_cost,0) material_cost,
                nvl(cic_frozen.material_overhead_cost,0) material_overhead_cost,
                nvl(cic_frozen.resource_cost,0) resource_cost,
                nvl(cic_frozen.outside_processing_cost,0) outside_processing_cost,
                nvl(cic_frozen.overhead_cost,0) overhead_cost,
                nvl(cic_frozen.item_cost,0) item_cost,
                -- Revision for version 1.1
                nvl(cic_frozen.tl_material_overhead,0) tl_material_overhead
         from   cst_item_costs cic_frozen,
                cst_cost_types cct2,
                mtl_parameters mp
         where  cic_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
         -- Do not report the master inventory organization
         and    mp.organization_id         <> mp.master_organization_id
         -- =============================================================
         -- If p_cost_type2 = frozen cost_type_id then we have all the 
         -- costs and don't need this union all statement
         -- =============================================================
         and    cct2.cost_type_id          <> 1 -- frozen cost type
         and    cic_frozen.organization_id  = mp.organization_id
         and    9=9                         -- p_org_code
         -- Revision for version 1.6
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    10=10                       -- p_cost_type2
         -- =============================================================
         -- Check to see if the costs exist in cost type 1 
         -- =============================================================
         and not exists (
                         select 'x'
                         from   cst_item_costs cic2
                         where  cic2.cost_type_id      = cct2.cost_type_id
                         and    cic2.organization_id   = cic_frozen.organization_id
                         and    cic2.inventory_item_id = cic_frozen.inventory_item_id
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
         from   (
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
                 from   wip_discrete_jobs wdj,
                        wip_accounting_classes wac,
                        mtl_parameters mp,
                        mtl_transaction_types mtt
                 where  mp.organization_id              = wdj.organization_id
                 and    mtt.transaction_type_id         = 44 -- WIP Completion
                 and    wac.class_code                  = wdj.class_code
                 and    wac.organization_id             = wdj.organization_id
                 -- Only want asset jobs
                 and    wac.class_type not in (4,6,7)
                 -- ===========================================
                 -- Expense WIP Accounting Classes
                 -- 4 - Expense Non-standard
                 -- 6 - Maintenance
                 -- 7 - Expense Non-standard Lot Based
                 -- ===========================================
                 -- Avoid assemblies issued from expense subinventories at zero cost
                 and    nvl(wdj.issue_zero_cost_flag, 'N') = 'N'
                 -- Only want open WIP jobs
                 and    wdj.date_closed is null
                 -- Do not report the master inventory organization
                 and    mp.organization_id             <> mp.master_organization_id
                 and    9=9                             -- p_org_code
                 -- Revision for version 1.6
                 and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
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
                 from   wip_discrete_jobs wdj,
                        wip_accounting_classes wac,
                        wip_requirement_operations wro,
                        mtl_parameters mp,
                        mtl_transaction_types mtt
                 where  mp.organization_id              = wdj.organization_id
                 and    wro.wip_entity_id               = wdj.wip_entity_id
                 and    wro.organization_id             = wdj.organization_id
                 and    mp.organization_id              = wdj.organization_id
                 and    wac.class_code                  = wdj.class_code
                 and    wac.organization_id             = wdj.organization_id
                 -- Only want asset jobs
                 and    wac.class_type not in (4,6,7)
                 and    mtt.transaction_type_id         =
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
                 and    nvl(wdj.issue_zero_cost_flag, 'N') = 'N'
                 -- Only want open WIP jobs
                 and    wdj.date_closed is null
                 -- Only want open non-zero units
                 and    wro.quantity_issued <> 0
                 -- Do not report the master inventory organization
                 and    mp.organization_id             <> mp.master_organization_id
                 and    9=9                             -- p_org_code
                 -- Revision for version 1.6
                 and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
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
where   msiv.inventory_item_id          = sumwip.inventory_item_id
and     msiv.organization_id            = sumwip.organization_id
and     msiv.primary_uom_code           = muomv.uom_code
and     misv.inventory_item_status_code = msiv.inventory_item_status_code
and     we.wip_entity_id                = sumwip.wip_entity_id
and     msiv.inventory_item_id          = cic1.inventory_item_id
and     msiv.organization_id            = cic1.organization_id
and     sumwip.resource_id              = cic1.resource_id
and     sumwip.organization_id          = cic1.organization_id
-- Outer join as you may have newly costed items in the new cost
-- type which were never existed in the old cost type
and     msiv.inventory_item_id          = cic2.inventory_item_id (+)
and     msiv.organization_id            = cic2.organization_id   (+)
and     msiv.organization_id            = mp.organization_id
and     sumwip.resource_id              = cic2.resource_id
and     sumwip.organization_id          = cic2.organization_id
-- ===================================================================
-- joins for the Lookup Codes
-- ===================================================================
and     ml1.lookup_type                 = 'WIP_CLASS_TYPE'
and     ml1.lookup_code                 = sumwip.class_type
and     ml2.lookup_type                 = 'WIP_JOB_STATUS'
and     ml2.lookup_code                 = sumwip.status_type
and     ml3.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml3.lookup_code                 = msiv.planning_make_buy_code
and     ml4.lookup_type (+)             = 'WIP_SUPPLY'
and     ml4.lookup_code (+)             = sumwip.wip_supply_type
and     ml5.lookup_type                 = 'CST_BASIS'
and     ml5.lookup_code                 = sumwip.basis_type
-- Lookup codes for item types
and     fcl.lookup_code (+)             = msiv.item_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- Joins for the currency exchange rates
-- ===================================================================
-- new FX rate
and     gl.currency_code                = gdr1.from_currency (+)
-- old FX rate
and     gl.currency_code                = gdr2.from_currency (+)
-- ===================================================================
-- Use base tables instead of HR organization views
-- ===================================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp.organization_id
and     hoi.organization_id             = haou.organization_id             -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3)  -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1)  -- get the ledger_id
-- avoid selecting disabled inventory organizations
and     sysdate                                < nvl(haou.date_to, sysdate +1)
-- ===================================================================
-- More efficient to limit the G/L name at the end of the SQL code, as opposed
-- to trying to join on the HR tables for the inner quantity and cost queries
-- ===================================================================
and     1=1                             -- p_ledger, p_operating_unit
-- Revision for version 1.6
and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
-- ===================================================================
-- Only report non-zero results
-- ===================================================================
-- Revision for version 1.5, make this a parameter
-- Item_Cost_Difference + Exchange_Rate_Difference <> 0
-- and  (round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5))         
--       + (nvl(gdr1.conversion_rate,1) - nvl(gdr2.conversion_rate,1)) <> 0
and     decode(:p_all_wip_jobs,
                'N', round(nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1),5) - round(nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1),5),
                'Y', 1)               <> 0
-- End revision for version 1.5
union all
-- ==========================================================
-- Get the Resource_Cost and Value Cost Adjustments
-- ==========================================================
select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        haou.name Organization_Name,
        sumwip.class_code WIP_Class,
        ml1.meaning Class_Type,
        we.wip_entity_name WIP_Job,
        ml2.meaning Job_Status,
        sumwip.date_released Date_Released,
        sumwip.date_completed Date_Completed,
        sumwip.last_update_date Last_Update_Date,
        msiv.concatenated_segments Item_Number,
        msiv.description Item_Description,
&category_columns
        fcl.meaning Item_Type,
        misv.inventory_item_status_code_tl Item_Status,
        ml3.meaning Make_Buy_Code,
        ml4.meaning Supply_Type,
        sumwip.transaction_type Transaction_Type,
        sumwip.resource_code Resource_Code,
        sumwip.op_seq_num Operation_Seq_Number,
        sumwip.res_seq_num Resource_Seq_Number,
        ml5.meaning Basis_Type,
        gl.currency_code Currency_Code,
        muomv.uom_code UOM_Code,
-- ==========================================================
-- Select the new and old item costs from Cost_Type 1 and 2
-- ==========================================================
        round(nvl(cic1.material_cost,0),5) New_Material_Cost,
        round(nvl(cic2.material_cost,0),5) Old_Material_Cost,
        round(nvl(cic1.material_overhead_cost,0),5) New_Material_Overhead_Cost,
        round(nvl(cic2.material_overhead_cost,0),5) Old_Material_Overhead_Cost,
        round(nvl(cic1.resource_cost,0),5) New_Resource_Cost,
        round(nvl(cic2.resource_cost,0),5) Old_Resource_Cost,
        round(nvl(cic1.outside_processing_cost,0),5) New_Outside_Processing_Cost,
        round(nvl(cic2.outside_processing_cost,0),5) Old_Outside_Processing_Cost,
        round(nvl(cic1.overhead_cost,0),5) New_Overhead_Cost,
        round(nvl(cic2.overhead_cost,0),5) Old_Overhead_Cost,
        round(nvl(cic1.item_cost,0),5) New_Item_Cost,
        round(nvl(cic2.item_cost,0),5) Old_Item_Cost,
-- ========================================================
-- Select the item costs from Cost_Type 1 and 2 and compare
-- ========================================================
        round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5) Item_Cost_Difference,
        case
          when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = 0 then 0
          when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic1.item_cost,0),5) then  100
          when round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)),5) = round(nvl(cic2.item_cost,0),5) then -100
          else round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) / nvl(cic2.item_cost,0) * 100,2)
        end Percent_Difference,
-- ===========================================================
-- Select the onhand and intransit quantities and values
-- ===========================================================
        muomv.uom_code UOM_Code,
        -- Show the WIP Completion Quantity as a positive number
        decode(sumwip.txn_source,
                        'WIP Completion', -1 * sumwip.quantity,
                        sumwip.quantity) WIP_Quantity,
        round(nvl(cic1.item_cost,0) * sumwip.quantity,2) New_Onhand_Value,
        round(nvl(cic2.item_cost,0) * sumwip.quantity,2) Old_Onhand_Value,
        round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) * 
                sumwip.quantity,2) Onhand_Value_Difference,
        -- Revision for version 1.4, show absolute difference
        abs(round((nvl(cic1.item_cost,0) - nvl(cic2.item_cost,0)) * 
                sumwip.quantity,2)) Abs_Onhand_Value_Difference,
        -- End revision for version 1.4
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
        nvl(gdr1.conversion_rate,1) New_FX_Rate,
        nvl(gdr2.conversion_rate,1) Old_FX_Rate,
        nvl(gdr1.conversion_rate,1) - nvl(gdr2.conversion_rate,1) Exchange_Rate_Difference,
-- ===========================================================
-- Select To Currency onhand and intransit quantities and values
-- ===========================================================
-- ===========================================================
-- Costs in To Currency by Cost_Element, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        round(nvl(cic1.material_cost,0) * nvl(gdr1.conversion_rate,1)
        * sumwip.quantity,2) "&p_to_currency_code New Material Value",
        round(nvl(cic2.material_cost,0) * nvl(gdr2.conversion_rate,1)
        * sumwip.quantity,2) "&p_to_currency_code Old Material Value",
        round(nvl(cic1.material_overhead_cost,0) * nvl(gdr1.conversion_rate,1)
        * sumwip.quantity,2) "&p_to_currency_code New Material Ovhd Value",
        round(nvl(cic2.material_overhead_cost,0) * nvl(gdr2.conversion_rate,1)
        * sumwip.quantity,2) "&p_to_currency_code Old Material Ovhd Value",
        round(nvl(cic1.resource_cost,0) * nvl(gdr1.conversion_rate,1)
        * sumwip.quantity,2) "&p_to_currency_code New Resource Value",
        round(nvl(cic2.resource_cost,0) * nvl(gdr2.conversion_rate,1)
        * sumwip.quantity,2) "&p_to_currency_code Old Resource Value",
        round(nvl(cic1.outside_processing_cost,0) * nvl(gdr1.conversion_rate,1)
        * sumwip.quantity,2) "&p_to_currency_code New OSP Value",
        round(nvl(cic2.outside_processing_cost,0) * nvl(gdr2.conversion_rate,1)
        * sumwip.quantity,2) "&p_to_currency_code Old OSP Value",
        round(nvl(cic1.overhead_cost,0) * nvl(gdr1.conversion_rate,1)
        * sumwip.quantity,2) "&p_to_currency_code New Overhead Value",
        round(nvl(cic2.overhead_cost,0) * nvl(gdr2.conversion_rate,1)
        * sumwip.quantity,2) "&p_to_currency_code Old Overhead Value",
-- ===========================================================
-- Onhand_Values in To Currency, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        round(nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1) *
                sumwip.quantity,2) "&p_to_currency_code New Onhand Value",
        round(nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1) *
                sumwip.quantity,2) "&p_to_currency_code Old Onhand Value",
        -- USD New Onhand Cost - USD Old Onhand Cost
        round(( (nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1)) -
                (nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
        -- multiplied by the total onhand quantity 
                sumwip.quantity,2) "&p_to_currency_code Onhand Value Difference",
        -- Revision for version 1.4, show absolute difference
        -- USD New Onhand Cost - USD Old Onhand Cost
        abs(round(( (nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1)) -
                (nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
        -- multiplied by the total onhand quantity 
                sumwip.quantity,2)) "&p_to_currency_code Abs Onhand Value Diff",
        -- End revision for version 1.4
-- ===========================================================
-- Value Differences in To Currency using the new rate
-- New and Old costs at New Fx Rate
-- ===========================================================
        -- NEW COST at new fx conversion rate minus OLD COST at new fx conversion rate
        round(( (nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1)) - 
                (nvl(cic2.item_cost,0) * nvl(gdr1.conversion_rate,1))) *
        -- multiplied by the total onhand quantity
                sumwip.quantity,2) "&p_to_currency_code Value Difference-New Rate",
-- ===========================================================
-- Value Differences in To Currency using the old rate
-- New and Old costs at Old Fx Rate
-- ===========================================================
        -- NEW COST at old fx conversion rate minus OLD COST at old fx conversion rate
        round(( (nvl(cic1.item_cost,0) * nvl(gdr2.conversion_rate,1)) - 
                (nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
        -- multiplied by the total onhand quantity
                sumwip.quantity,2) "&p_to_currency_code Value Difference-Old Rate",
-- ===========================================================
-- Value Differences comparing the new less the old rate differences
-- ===========================================================
        -- USD Value Diff-New Rate less USD Value Diff-Old Rate
        -- USD Value Diff-New Rate
        round(( (nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1)) - 
               (nvl(cic2.item_cost,0) * nvl(gdr1.conversion_rate,1))) *
                sumwip.quantity,2) -
        -- USD Value Diff-Old Rate
        round(( (nvl(cic1.item_cost,0) * nvl(gdr2.conversion_rate,1)) - 
                (nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1))) *
                sumwip.quantity,2) "&p_to_currency_code Value FX Difference"
from    mtl_system_items_vl msiv,
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
(select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:p_conversion_date1 and gdct.user_conversion_type=:p_user_conversion_type1 and gdr.to_currency=:p_to_currency and gdct.conversion_type=gdr.conversion_type) gdr1, -- NEW Currency Rates
 -- ===========================================================================
 -- Select Old Currency Rates based on the old concurrency conversion date
 -- ===========================================================================
(select gdr.* from gl_daily_rates gdr, gl_daily_conversion_types gdct where gdr.conversion_date=:p_conversion_date2 and gdct.user_conversion_type=:p_user_conversion_type2 and gdr.to_currency=:p_to_currency and gdct.conversion_type=gdr.conversion_type) gdr2,  -- OLD Currency Rates
        -- =================================================
        -- Get the resource costs for Cost_Type 1
        -- =================================================
        (select crc1.organization_id,
                -999 inventory_item_id,
                crc1.resource_id,
                0 material_cost,
                0 material_overhead_cost,
                decode(br.cost_element_id,
                        3, nvl(crc1.resource_rate,0),
                        0) resource_cost,
                decode(br.cost_element_id,
                        4, nvl(crc1.resource_rate,0),
                        0) outside_processing_cost,
                decode(br.cost_element_id,
                        5, nvl(crc1.resource_rate,0),
                        0) overhead_cost,
                nvl(crc1.resource_rate,0) item_cost                
         from   cst_resource_costs crc1,
                bom_resources br,
                cst_cost_types cct1,
                mtl_parameters mp
         where  cct1.cost_type_id           = crc1.cost_type_id
         and    crc1.organization_id        = mp.organization_id
         and    br.resource_id              = crc1.resource_id
         -- Do not report the master inventory organization
         and    mp.organization_id         <> mp.master_organization_id
         and    8=8                         -- p_cost_type1
         and    9=9                         -- p_org_code
         -- Revision for version 1.6
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         union all
         -- =============================================================
         -- Get the costs from the frozen cost type that is not in cost
         -- type 1 so that all resource costs are reported
         -- =============================================================
         select crc_frozen.organization_id,
                -999 inventory_item_id,
                crc_frozen.resource_id,
                0 material_cost,
                0 material_overhead_cost,
                decode(br.cost_element_id,
                        3, nvl(crc_frozen.resource_rate,0),
                        0) resource_cost,
                decode(br.cost_element_id,
                        4, nvl(crc_frozen.resource_rate,0),
                        0) outside_processing_cost,
                decode(br.cost_element_id,
                        5, nvl(crc_frozen.resource_rate,0),
                        0) overhead_cost,
                nvl(crc_frozen.resource_rate,0) item_cost        
         from   cst_resource_costs crc_frozen,
                cst_cost_types cct1,
                bom_resources br,
                mtl_parameters mp
         where  crc_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
         and    crc_frozen.organization_id  = mp.organization_id
         and    br.resource_id              = crc_frozen.resource_id
         -- Do not report the master inventory organization
         and    mp.organization_id         <> mp.master_organization_id
         and    8=8                         -- p_cost_type1
         and    9=9                         -- p_org_code
         -- Revision for version 1.6
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         -- =============================================================
         -- If p_cost_type1 = frozen cost_type_id then we have all the 
         -- costs and don't need this union all statement
         -- =============================================================
         and    cct1.cost_type_id           <> 1  -- frozen cost type
         and    crc_frozen.organization_id  = mp.organization_id
         -- Revision for version 1.2, parameter to only_items_in_cost_type
         and    13=13
         -- =============================================================
         -- Check to see if the costs exist in cost type 1 
         -- =============================================================
         and not exists (
                        select 'x'
                        from   cst_resource_costs crc1
                        where  crc1.cost_type_id      = cct1.cost_type_id
                        and    crc1.organization_id   = crc_frozen.organization_id
                        and    crc1.resource_id       = crc_frozen.resource_id
                    )
         ) cic1,
        -- =================================================
        -- Get the resource costs for Cost_Type 2
        -- =================================================
        (select crc2.organization_id,
                -999 inventory_item_id,
                crc2.resource_id,
                0 material_cost,
                0 material_overhead_cost,
                decode(br.cost_element_id,
                        3, nvl(crc2.resource_rate,0),
                        0) resource_cost,
                decode(br.cost_element_id,
                        4, nvl(crc2.resource_rate,0),
                        0) outside_processing_cost,
                decode(br.cost_element_id,
                        5, nvl(crc2.resource_rate,0),
                        0) overhead_cost,
                nvl(crc2.resource_rate,0) item_cost                
         from   cst_resource_costs crc2,
                bom_resources br,
                cst_cost_types cct2,
                mtl_parameters mp
         where  cct2.cost_type_id           = crc2.cost_type_id
         and    crc2.organization_id        = mp.organization_id
         and    br.resource_id              = crc2.resource_id
         -- Do not report the master inventory organization
         and    mp.organization_id         <> mp.master_organization_id
         and    9=9                         -- p_org_code
         -- Revision for version 1.6
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    10=10                       -- p_cost_type2
         union all
         -- =============================================================
         -- Get the costs from the frozen cost type that is not in cost
         -- type 2 so that all resource costs are reported
         -- =============================================================
         select crc_frozen.organization_id,
                -999 inventory_item_id,
                crc_frozen.resource_id,
                0 material_cost,
                0 material_overhead_cost,
                decode(br.cost_element_id,
                        3, nvl(crc_frozen.resource_rate,0),
                        0) resource_cost,
                decode(br.cost_element_id,
                        4, nvl(crc_frozen.resource_rate,0),
                        0) outside_processing_cost,
                decode(br.cost_element_id,
                        5, nvl(crc_frozen.resource_rate,0),
                        0) overhead_cost,
                nvl(crc_frozen.resource_rate,0) item_cost        
         from   cst_resource_costs crc_frozen,
                cst_cost_types cct2,
                bom_resources br,
                mtl_parameters mp
         where  crc_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
         and    crc_frozen.organization_id  = mp.organization_id
         and    br.resource_id              = crc_frozen.resource_id
         -- Do not report the master inventory organization
         and    mp.organization_id         <> mp.master_organization_id
         and    9=9                         -- p_org_code
         -- Revision for version 1.6
         and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    10=10                       -- p_cost_type2
         -- =============================================================
         -- If p_cost_type2 = frozen cost_type_id then we have all the 
         -- costs and don't need this union all statement
         -- =============================================================
         and    cct2.cost_type_id           <> 1  -- frozen cost type
         and    crc_frozen.organization_id  = mp.organization_id
         -- =============================================================
         -- Check to see if the costs exist in cost type 2
         -- =============================================================
         and not exists (
                         select  'x'
                         from    cst_resource_costs crc2
                         where   crc2.cost_type_id      = cct2.cost_type_id
                         and     crc2.organization_id   = crc_frozen.organization_id
                         and     crc2.resource_id       = crc_frozen.resource_id
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
         from   (
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
                         from   wip_requirement_operations wro
                         where  wro.operation_seq_num = wor.operation_seq_num
                         and    wro.wip_entity_id = wor.wip_entity_id) wip_supply_type,
                        wor.operation_seq_num op_seq_num,
                        wor.resource_seq_num res_seq_num,
                        wor.basis_type,
                        wor.applied_resource_units quantity,
                        wor.applied_resource_value resource_value,
                        nvl(wor.relieved_res_scrap_units,0) scrapped_quantity
                  from  wip_discrete_jobs wdj,
                        wip_accounting_classes wac,
                        wip_operation_resources wor,
                        bom_resources br,
                        mtl_parameters mp,
                        mfg_lookups ml -- Transaction_Type
                 where  mp.organization_id              = wdj.organization_id
                 and    wor.wip_entity_id               = wdj.wip_entity_id
                 and    wor.organization_id             = wdj.organization_id
                 and    mp.organization_id              = wdj.organization_id
                 and    wac.class_code                  = wdj.class_code
                 and    wac.organization_id             = wdj.organization_id
                 -- Only want asset jobs
                 and    wac.class_type not in (4,6,7)
                 and    br.resource_id                  = wor.resource_id
                 and    ml.lookup_type                  = 'WIP_TRANSACTION_TYPE'
                 and    ml.lookup_code                  = 
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
                 and    nvl(wdj.issue_zero_cost_flag, 'N') = 'N'
                 -- Only want open WIP jobs
                 and    wdj.date_closed is null
                 -- Only want open non-zero hours and values
                 and    wor.applied_resource_units + wor.applied_resource_value <> 0
                 -- Do not report the master inventory organization
                 and    mp.organization_id             <> mp.master_organization_id
                 and    9=9                             -- p_org_code
                 -- Revision for version 1.6
                 and    mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
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
where   msiv.inventory_item_id          = sumwip.inventory_item_id (+)
and     msiv.organization_id            = sumwip.organization_id (+)
and     msiv.primary_uom_code           = muomv.uom_code
and     misv.inventory_item_status_code = msiv.inventory_item_status_code
and     we.wip_entity_id                = sumwip.wip_entity_id
and     sumwip.resource_id              = cic1.resource_id
and     sumwip.organization_id          = cic1.organization_id
and     msiv.organization_id            = mp.organization_id
-- Outer join as you may have newly costed resources in the new
-- cost type which were never existed in the old cost type
and     sumwip.resource_id              = cic2.resource_id (+)
and     sumwip.organization_id          = cic2.organization_id (+)
-- ===================================================================
-- joins for the Lookup Codes
-- ===================================================================
and     ml1.lookup_type                 = 'WIP_CLASS_TYPE'
and     ml1.lookup_code                 = sumwip.class_type
and     ml2.lookup_type                 = 'WIP_JOB_STATUS'
and     ml2.lookup_code                 = sumwip.status_type
and     ml3.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
and     ml3.lookup_code                 = msiv.planning_make_buy_code
and     ml4.lookup_type (+)             = 'WIP_SUPPLY'
and     ml4.lookup_code (+)             = sumwip.wip_supply_type
and     ml5.lookup_type                 = 'CST_BASIS'
and     ml5.lookup_code                 = sumwip.basis_type
-- Lookup codes for item types
and     fcl.lookup_code (+)             = msiv.item_type
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
-- ===================================================================
-- Joins for the currency exchange rates
-- ===================================================================
-- new FX rate
and     gl.currency_code                = gdr1.from_currency (+)
-- old FX rate
and     gl.currency_code                = gdr2.from_currency (+)
-- ===================================================================
-- Using base tables instead of HR organization views
-- ===================================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp.organization_id
and     hoi.organization_id             = haou.organization_id             -- this gets the organization name
and     haou2.organization_id           = to_number(hoi.org_information3)  -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1)  -- get the ledger_id
-- avoid selecting disabled inventory organizations
and     sysdate                         < nvl(haou.date_to, sysdate +1)
-- ===================================================================
-- More efficient to limit the G/L name at the end of the SQL code, as opposed
-- to trying to join on the HR tables for the inner quantity and cost queries
-- ===================================================================
and     1=1                             -- p_ledger, p_operating_unit
-- Revision for version 1.6
and     mp.organization_code in (select oav.organization_code from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
-- ===================================================================
-- Only report non-zero results
-- ===================================================================
-- Revision for version 1.5, make this a parameter
-- Item_Cost_Difference + Exchange_Rate_Difference <> 0
-- and     (round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5))         
--         + (nvl(gdr1.conversion_rate,1) - nvl(gdr2.conversion_rate,1)) <> 0
and     decode(:p_all_wip_jobs,
                'N', round(nvl(cic1.item_cost,0) * nvl(gdr1.conversion_rate,1),5) - round(nvl(cic2.item_cost,0) * nvl(gdr2.conversion_rate,1),5),
                'Y', 1)               <> 0
-- End revision for version 1.5
order by 1,2,3,4,5,6,7,8,9,10,11