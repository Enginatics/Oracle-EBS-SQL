/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Pending Cost Adjustment
-- Description: Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues, WIP resource (labor) and WIP overhead transactions. However, WIP cost adjustments for Assembly Scrap is not included. The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session. And if you choose Yes for "Include All WIP Jobs" all WIP jobs will be reported even if there are no valuation changes.
-- Parameters:
-- ===========
-- Cost Type (New): enter the Cost Type that has the revised or new item costs (mandatory).
-- Cost Type (Old): enter the Cost Type that has the existing or current item costs, defaults to the Frozen Cost Type (mandatory).
-- Currency Conversion Date (New): enter the currency conversion date to use for the new item costs (mandatory).
-- Currency Conversion Type (New): enter the currency conversion type to use for the new item costs, defaults to Corporate (mandatory).
-- Currency Conversion Date (Old): enter the currency conversion date to use for the existing item costs (mandatory).
-- Currency Conversion Type (Old): enter the currency conversion type to use for the existing item costs, defaults to Corporate (mandatory).
-- To Currency Code: enter the currency code used to translate the item costs and inventory values into.
-- Category Set 1 - 3: up to three item categories to report, typically the Inventory, Cost or Product Line Category Sets (optional).
-- Include All WIP Jobs: enter No to only report WIP jobs with valuation changes, enter Yes to report all WIP jobs. (mandatory).
-- Item Number: specific buy or make item you wish to report (optional).
-- Organization Code: enter the inventory organization(s) you wish to report, defaults to your session's inventory organization (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
-- / +=============================================================================+
-- -- | Copyright 2020 - 2025 Douglas Volz Consulting, Inc.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission. All rights reserved.
-- -- +=============================================================================+
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 04 Dec 2020 Douglas Volz Created initial Report based on the Pending
-- -- | Cost Adjustment Report for Inventory and Intransit.
-- -- | 1.1 11 Dec 2020 Douglas Volz Corrected cost adjustments for assemblies
-- -- | 1.2 16 Dec 2020 Douglas Volz Change SIGN of completion quantities to match
-- -- | the Oracle WIP Standard Cost Adjustment Report.
-- -- | 1.3 10 Feb 2021 Douglas Volz Fixes for WIP completion quantities, needed to
-- -- | change the SIGN of completion quantities.
-- -- | 1.4 17 Feb 2021 Douglas Volz Add absolute difference column.
-- -- | 1.5 13 Dec 2021 Douglas Volz Add parameter to report all WIP jobs, even
-- -- | if there is no valuation change.
-- -- | 1.6 12 Feb 2024 Douglas Volz Remove tabs, simplify G/L conversion rates,
-- -- | added inventory org access security.
-- -- | 1.7 20 Jul 2026 Douglas Volz Added in overhead cost and valuation differences.
-- -- | 1.8 26 Sep 2026 Enginatics Currency rate and overhead corrections.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-wip-pending-cost-adjustment/
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
        -- Revision for version 1.7
        null Overhead_Code,
        sumwip.op_seq_num Operation_Seq_Number,
        sumwip.res_seq_num Resource_Seq_Number,
        -- Revision for version 1.7
        ml5.meaning Matl_or_Resource_Basis_Type,
        null Overhead_Basis_Type,
        -- End for revision 1.7
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
        -- End revision for version 1.1
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
        --  end Percent_Difference,
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
           -- when new cost - old cost = old cost then 100
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
                then 100
            -- Revision for version 1.7, fix for percentages
            -- change from:  when new cost - old cost = old cost then -100
            -- to:  when old cost - new cost = old cost then -100
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
           -- End revision for version 1.7
           -- when old cost = 0 then 100
           when case
                   when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then
                        round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
                   else round(nvl(cic2.item_cost,0),5)
                 end = 0 then 100
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
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        -- Revision for version 1.1
        (round(
         case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then
                round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
           else round(nvl(cic1.item_cost,0),5)
         end * sumwip.quantity
            ,2)
        ) New_Onhand_Value,
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        (round(
         case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then
                round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
           else round(nvl(cic2.item_cost,0),5)
         end * sumwip.quantity
            ,2)
        ) Old_Onhand_Value,
        -- Revision for version 1.2
        -- WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
        decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        -- New Onhand Value - Old Onhand Value = Onhand Value Difference
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
           ,2)
        ) Onhand_Value_Difference,
        -- End revision for version 1.1
        -- Revision for version 1.4, show absolute difference
        -- Revision for version 1.2
        -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
        abs(decode(sumwip.txn_source, 'WIP Completion',-1,1) * (
        -- New Onhand Value - Old Onhand Value = Onhand Value Difference
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
           ,2)
        )) Abs_Onhand_Value_Difference,
        -- End revision for version 1.4
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
        gdr1.conversion_rate New_FX_Rate,
        gdr2.conversion_rate Old_FX_Rate,
        gdr1.conversion_rate - gdr2.conversion_rate Exchange_Rate_Difference,
-- ===========================================================
-- Select To Currency WIP quantities and values
-- ===========================================================
-- ===========================================================
-- Costs in To Currency by Cost_Element, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
              (round(nvl(cic1.material_cost,0) * gdr1.conversion_rate * sumwip.quantity,2))  "&p_to_currency_code New Material Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
              (round(nvl(cic2.material_cost,0) * gdr2.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code Old Material Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        -- Revision for version 1.1
        (round(
         case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then
                round(nvl(cic1.material_overhead_cost,0) - nvl(cic1.tl_material_overhead,0),5)
           else round(nvl(cic1.material_overhead_cost,0),5)
         end * sumwip.quantity * gdr1.conversion_rate
            ,2)
        ) "&p_to_currency_code New Material Ovhd Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        (round(
         case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then
                round(nvl(cic2.material_overhead_cost,0) - nvl(cic2.tl_material_overhead,0),5)
           else round(nvl(cic2.material_overhead_cost,0),5)
         end * sumwip.quantity * gdr2.conversion_rate
            ,2)
        ) "&p_to_currency_code Old Material Ovhd Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        -- End revision for version 1.1
        (round(nvl(cic1.resource_cost,0) * gdr1.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code New Resource Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        (round(nvl(cic2.resource_cost,0) * gdr2.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code Old Resource Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        (round(nvl(cic1.outside_processing_cost,0) * gdr1.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code New OSP Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        (round(nvl(cic2.outside_processing_cost,0) * gdr2.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code Old OSP Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        (round(nvl(cic1.overhead_cost,0) * gdr1.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code New Overhead Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        (round(nvl(cic2.overhead_cost,0) * gdr2.conversion_rate * sumwip.quantity,2)) "&p_to_currency_code Old Overhead Value",
-- ===========================================================
-- WIP Values expressed in the To Currency, new values at
-- the new Fx rate and old values at old Fx rate
-- ===========================================================
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        -- Revision for version 1.1
        (round(
         case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then
                round(nvl(cic1.item_cost,0) - nvl(cic1.tl_material_overhead,0),5)
           else round(nvl(cic1.item_cost,0),5)
         end * sumwip.quantity * gdr1.conversion_rate
           ,2)
        ) "&p_to_currency_code New Onhand Value",
        -- Revision for version 1.3
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        (round(
         case
           when sumwip.txn_source = 'WIP Completion' and sumwip.class_type in (1,5) then
                round(nvl(cic2.item_cost,0) - nvl(cic2.tl_material_overhead,0),5)
           else round(nvl(cic2.item_cost,0),5)
         end * sumwip.quantity * gdr2.conversion_rate
            ,2)
        ) "&p_to_currency_code Old Onhand Value",
        -- Revision for version 1.2
        -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        -- USD New Onhand Cost - USD Old Onhand Cost
        (round(
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
            ,2)
        ) "&p_to_currency_code Onhand Value Difference",
        -- End revision for version 1.1
        -- Revision for version 1.4, show absolute difference
        -- Revision for version 1.2
        -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
        abs(decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        -- USD New Onhand Cost - USD Old Onhand Cost
        (round(
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
           ,2)
        )) "&p_to_currency_code Abs Onhand Value Diff",
        -- End revision for version 1.4
-- ===========================================================
-- Value Differences in To Currency using the new rate
-- New and Old costs at New Fx Rate
-- ===========================================================
        -- Revision for version 1.2
        -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        -- Revision for version 1.1
        -- NEW COST at new fx conversion rate minus OLD COST at new fx conversion rate
        -- New_Item_Cost
        (round(
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
          -- multiplied by the total onhand quantity
          end
         ) * sumwip.quantity
            ,2)
        ) "&p_to_currency_code Value Difference-New Rate",
-- ===========================================================
-- Value Differences in To Currency using the old rate
-- New and Old costs at Old Fx Rate
-- ===========================================================
        -- Revision for version 1.2
        -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        -- NEW COST at old fx conversion rate minus OLD COST at old fx conversion rate
        -- New_Item_Cost
        (round(
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
          end
          -- multiplied by the total onhand quantity
         ) * sumwip.quantity
            ,2)
        ) "&p_to_currency_code Value Difference-Old Rate",
-- ===========================================================
-- Value Differences comparing the new less the old rate differences
-- ===========================================================
        -- Revision for version 1.2
        -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        -- USD Value Diff-New Rate less USD Value Diff-Old Rate
        -- NEW COST at new fx conversion rate minus OLD COST at new fx conversion rate
        -- New_Item_Cost
        (round(
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
          end
          -- multiplied by the total onhand quantity
         ) *sumwip.quantity,2)
        ) -
        -- Revision for version 1.2
        -- Show WIP Completion adjustments as negative to match the Oracle WIP Standard Cost Adjustment Report
        decode(sumwip.txn_source, 'WIP Completion',-1,1) *
        -- NEW COST at old fx conversion rate minus OLD COST at old fx conversion rate
        -- New_Item_Cost
        (round(
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
          end
          -- multiplied by the total onhand quantity
         ) * sumwip.quantity
            ,2)
        ) "&p_to_currency_code Value FX Difference"
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
        gl_ledgers gl,
 -- ===========================================================================
 -- Select New Currency Rates based on the new concurrency conversion date
 -- ===========================================================================
(select gl.currency_code from_currency, decode(gl.currency_code, :p_to_currency_code, 1, (select gdr1.conversion_rate from gl_daily_rates gdr1, gl_daily_conversion_types gdct1 where gdr1.from_currency=gl.currency_code and gdr1.conversion_type=gdct1.conversion_type and 4=4 and 5=5 and 11=11)) conversion_rate from (select distinct gl.currency_code from gl_ledgers gl) gl) gdr1, -- NEW Currency Rates, 1 for the same currency, blank when the rate is missing
 -- ===========================================================================
 -- Select Old Currency Rates based on the old concurrency conversion date
 -- ===========================================================================
(select gl.currency_code from_currency, decode(gl.currency_code, :p_to_currency_code, 1, (select gdr2.conversion_rate from gl_daily_rates gdr2, gl_daily_conversion_types gdct2 where gdr2.from_currency=gl.currency_code and gdr2.conversion_type=gdct2.conversion_type and gdr2.to_currency=:p_to_currency_code and 6=6 and 7=7)) conversion_rate from (select distinct gl.currency_code from gl_ledgers gl) gl) gdr2,  -- OLD Currency Rates, 1 for the same currency, blank when the rate is missing
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
         -- Revision for version 1.6
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    8=8                         -- p_cost_type1
         and    9=9                         -- p_org_code
         -- Revision for version 1.7
         -- Do not report items with Null new item costs, the Standard Cost Update will
         -- ignore these values and keep the Frozen item costs unchanged.  This happens
         -- when you roll up an item which does not have a BOM or routing.  Rolls up to null values.
         and    (cic1.based_on_rollup_flag = 1 and item_cost is not null
                 or
                 cic1.based_on_rollup_flag = 2
                )
         -- End revision for version 1.7
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
         -- Revision for version 1.6
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    8=8                         -- p_cost_type1
         and    9=9                         -- p_org_code
         -- =============================================================
         -- If p_cost_type1 = frozen cost_type_id then we have all the
         -- costs and don't need this union all statement
         -- =============================================================
         and    cct1.cost_type_id           <> 1  -- frozen cost type
         and    cic_frozen.organization_id  = mp.organization_id
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
         -- Revision for version 1.6
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    9=9                         -- p_org_code
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
         -- Revision for version 1.6
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    9=9                         -- p_org_code
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
                        -- Revision for version 1.7
                        ml.meaning transaction_type,
                        null wip_supply_type,
                        null op_seq_num,
                        null res_seq_num,
                        -- WIP completion quantities always has a basis of Item
                        1 basis_type, -- 1 - item
                        -- Revision for version 1.2
                        -- sum(wdj.quantity_completed * -1) quantity,
                        wdj.quantity_completed quantity,
                        0 resource_value,
                        wdj.quantity_scrapped scrapped_quantity
                 from   wip_discrete_jobs wdj,
                        wip_accounting_classes wac,
                        mtl_parameters mp,
                        -- Revision for version 1.7, use lookup type not transaction type
                        mfg_lookups ml
                 where  mp.organization_id              = wdj.organization_id
                 -- Revision for version 1.7, use lookup type not transaction type
                 and    ml.lookup_type                  = 'CST_UPDATE_TXN_TYPE'
                 and    ml.lookup_code                  = 4 -- WIP assembly completion
                 -- End revision for version 1.7
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
                 -- Revision for version 1.6
                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                 and    9=9                             -- p_org_code
                 and    wdj.quantity_completed         <> 0
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
                        -- Revision for version 1.7
                        ml.meaning transaction_type,
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
                        -- Revision for version 1.7, use lookup type not transaction type
                        mfg_lookups ml
                 where  mp.organization_id              = wdj.organization_id
                 and    wro.wip_entity_id               = wdj.wip_entity_id
                 and    wro.organization_id             = wdj.organization_id
                 and    mp.organization_id              = wdj.organization_id
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
                 -- Revision for version 1.7, use lookup type not transaction type
                 and    ml.lookup_type                  = 'CST_UPDATE_TXN_TYPE'
                 and    ml.lookup_code                  = 3 -- WIP component issue
                 -- End revision for version 1.7
                 -- Avoid assemblies issued from expense subinventories at zero cost
                 and    nvl(wdj.issue_zero_cost_flag, 'N') = 'N'
                 -- Only want open WIP jobs
                 and    wdj.date_closed is null
                 -- Only want open non-zero units
                 and    wro.quantity_issued <> 0
                 -- Do not report the master inventory organization
                 and    mp.organization_id             <> mp.master_organization_id
                 -- Revision for version 1.6
                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                 and    9=9                             -- p_org_code
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
and     sumwip.inventory_item_id        = cic2.inventory_item_id (+)
and     sumwip.organization_id          = cic2.organization_id (+)
and     sumwip.resource_id              = cic2.resource_id (+)
and     msiv.organization_id            = mp.organization_id
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
-- Revision for version 1.6
and     gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+))
and     haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
and     1=1                             -- p_ledger, p_operating_unit
-- ===================================================================
-- Only report non-zero results
-- ===================================================================
-- Revision for version 1.5, make this a parameter
-- Item_Cost_Difference + Exchange_Rate_Difference <> 0
-- and  (round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5))
--                +         (nvl(gdr1.conversion_rate,1) - nvl(gdr2.conversion_rate,1)) <> 0
and     decode(:p_all_wip_jobs,
                -- without a conversion rate compare the ledger currency costs
                'N', nvl(round(nvl(cic1.item_cost,0) * gdr1.conversion_rate,5) - round(nvl(cic2.item_cost,0) * gdr2.conversion_rate,5),
                         round(nvl(cic1.item_cost,0),5) - round(nvl(cic2.item_cost,0),5)),
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
        -- Revision for version 1.7
        null Overhead_Code,
        sumwip.op_seq_num Operation_Seq_Number,
        sumwip.res_seq_num Resource_Seq_Number,
        -- Revision for version 1.7
        -- ml5.meaning Basis_Type,
        ml5.meaning Matl_or_Resource_Basis_Type,
        null Overhead_Basis_Type,
        -- End revision for version 1.7
        gl.currency_code Currency_Code,
        muomv.uom_code UOM_Code,
-- ==========================================================
-- Select the new and old item costs from Cost_Type 1 and 2
-- ==========================================================
        round(nvl(crc1.material_cost,0),5) New_Material_Cost,
        round(nvl(crc2.material_cost,0),5) Old_Material_Cost,
        round(nvl(crc1.material_overhead_cost,0),5) New_Material_Overhead_Cost,
        round(nvl(crc2.material_overhead_cost,0),5) Old_Material_Overhead_Cost,
        round(nvl(crc1.resource_cost,0),5) New_Resource_Cost,
        round(nvl(crc2.resource_cost,0),5) Old_Resource_Cost,
        round(nvl(crc1.outside_processing_cost,0),5) New_Outside_Processing_Cost,
        round(nvl(crc2.outside_processing_cost,0),5) Old_Outside_Processing_Cost,
        round(nvl(crc1.overhead_cost,0),5) New_Overhead_Cost,
        round(nvl(crc2.overhead_cost,0),5) Old_Overhead_Cost,
        round(nvl(crc1.item_cost,0),5) New_Item_Cost,
        round(nvl(crc2.item_cost,0),5) Old_Item_Cost,
-- ========================================================
-- Select the item costs from Cost_Type 1 and 2 and compare
-- ========================================================
        round(nvl(crc1.item_cost,0),5) - round(nvl(crc2.item_cost,0),5) Item_Cost_Difference,
        case
          when round((nvl(crc1.item_cost,0) - nvl(crc2.item_cost,0)),5) = 0 then 0
          when round((nvl(crc1.item_cost,0) - nvl(crc2.item_cost,0)),5) = round(nvl(crc1.item_cost,0),5) then  100
          -- Revision for version 1.7
          -- change from:  when new cost - old cost = old cost then -100
          -- to:  when old cost - new cost = old cost then -100
          -- when round((nvl(crc1.item_cost,0) - nvl(crc2.item_cost,0)),5) = round(nvl(crc2.item_cost,0),5) then -100
          when round((nvl(crc2.item_cost,0) - nvl(crc1.item_cost,0)),5) = round(nvl(crc2.item_cost,0),5) then -100
          -- End revision for version 1.7
          -- Revision for version 1.7, avoid dividing by zero
          when nvl(crc2.item_cost,0) = 0 then 100
          -- End revision for version 1.7
          else round((nvl(crc1.item_cost,0) - nvl(crc2.item_cost,0)) / nvl(crc2.item_cost,0) * 100,2)
        end Percent_Difference,
-- ===========================================================
-- Select the WIP onhand quantities and values
-- ===========================================================
        muomv.uom_code UOM_Code,
        -- Show the WIP Completion Quantity as a positive number
        decode(sumwip.txn_source, 'WIP Completion', -1 * sumwip.quantity, sumwip.quantity) WIP_Quantity,
        round(nvl(crc1.item_cost,0) * sumwip.quantity,2) New_Onhand_Value,
        round(nvl(crc2.item_cost,0) * sumwip.quantity,2) Old_Onhand_Value,
        round((nvl(crc1.item_cost,0) - nvl(crc2.item_cost,0)) * sumwip.quantity,2) Onhand_Value_Difference,
        -- Revision for version 1.4, show absolute difference
        abs(round((nvl(crc1.item_cost,0) - nvl(crc2.item_cost,0)) * sumwip.quantity,2)) Abs_Onhand_Value_Difference,
        -- End revision for version 1.4
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
        gdr1.conversion_rate New_FX_Rate,
        gdr2.conversion_rate Old_FX_Rate,
        gdr1.conversion_rate - gdr2.conversion_rate Exchange_Rate_Difference,
-- ===========================================================
-- Select To Currency WIP onhand quantities and values
-- ===========================================================
-- ===========================================================
-- Costs in To Currency by Cost_Element, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        round(nvl(crc1.material_cost,0) * gdr1.conversion_rate
        * sumwip.quantity,2) "&p_to_currency_code New Material Value",
        round(nvl(crc2.material_cost,0) * gdr2.conversion_rate
        * sumwip.quantity,2) "&p_to_currency_code Old Material Value",
        round(nvl(crc1.material_overhead_cost,0) * gdr1.conversion_rate
        * sumwip.quantity,2) "&p_to_currency_code New Material Ovhd Value",
        round(nvl(crc2.material_overhead_cost,0) * gdr2.conversion_rate
        * sumwip.quantity,2) "&p_to_currency_code Old Material Ovhd Value",
        round(nvl(crc1.resource_cost,0) * gdr1.conversion_rate
        * sumwip.quantity,2) "&p_to_currency_code New Resource Value",
        round(nvl(crc2.resource_cost,0) * gdr2.conversion_rate
        * sumwip.quantity,2) "&p_to_currency_code Old Resource Value",
        round(nvl(crc1.outside_processing_cost,0) * gdr1.conversion_rate
        * sumwip.quantity,2) "&p_to_currency_code New OSP Value",
        round(nvl(crc2.outside_processing_cost,0) * gdr2.conversion_rate
        * sumwip.quantity,2) "&p_to_currency_code Old OSP Value",
        round(nvl(crc1.overhead_cost,0) * gdr1.conversion_rate
        * sumwip.quantity,2) "&p_to_currency_code New Overhead Value",
        round(nvl(crc2.overhead_cost,0) * gdr2.conversion_rate
        * sumwip.quantity,2) "&p_to_currency_code Old Overhead Value",
-- ===========================================================
-- Onhand_Values in To Currency, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        round(nvl(crc1.item_cost,0) * gdr1.conversion_rate * sumwip.quantity,2) "&p_to_currency_code New Onhand Value",
        round(nvl(crc2.item_cost,0) * gdr2.conversion_rate * sumwip.quantity,2) "&p_to_currency_code Old Onhand Value",
        -- USD New Onhand Cost - USD Old Onhand Cost
        round(((nvl(crc1.item_cost,0) * gdr1.conversion_rate) -
               (nvl(crc2.item_cost,0) * gdr2.conversion_rate)) *
        -- multiplied by the total onhand quantity
                sumwip.quantity,2) "&p_to_currency_code Onhand Value Difference",
        -- Revision for version 1.4, show absolute difference
        -- USD New Onhand Cost - USD Old Onhand Cost
        abs(round(((nvl(crc1.item_cost,0) * gdr1.conversion_rate) -
                   (nvl(crc2.item_cost,0) * gdr2.conversion_rate)) *
        -- multiplied by the total onhand quantity
                sumwip.quantity,2)
           ) "&p_to_currency_code Abs Onhand Value Diff",
        -- End revision for version 1.4
-- ===========================================================
-- Value Differences in To Currency using the new rate
-- New and Old costs at New Fx Rate
-- ===========================================================
        -- NEW COST at new fx conversion rate minus OLD COST at new fx conversion rate
        round(((nvl(crc1.item_cost,0) * gdr1.conversion_rate) -
               (nvl(crc2.item_cost,0) * gdr1.conversion_rate)) *
        -- multiplied by the total onhand quantity
                sumwip.quantity,2) "&p_to_currency_code Value Difference-New Rate",
-- ===========================================================
-- Value Differences in To Currency using the old rate
-- New and Old costs at Old Fx Rate
-- ===========================================================
        -- NEW COST at old fx conversion rate minus OLD COST at old fx conversion rate
        round(((nvl(crc1.item_cost,0) * gdr2.conversion_rate) -
               (nvl(crc2.item_cost,0) * gdr2.conversion_rate)) *
        -- multiplied by the total onhand quantity
                sumwip.quantity,2) "&p_to_currency_code Value Difference-Old Rate",
-- ===========================================================
-- Value Differences comparing the new less the old rate differences
-- ===========================================================
        -- USD Value Diff-New Rate less USD Value Diff-Old Rate
        -- USD Value Diff-New Rate
        round(((nvl(crc1.item_cost,0) * gdr1.conversion_rate) -
               (nvl(crc2.item_cost,0) * gdr1.conversion_rate)) *
                sumwip.quantity,2) -
        -- USD Value Diff-Old Rate
        round(((nvl(crc1.item_cost,0) * gdr2.conversion_rate) -
               (nvl(crc2.item_cost,0) * gdr2.conversion_rate)) *
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
        gl_ledgers gl,
 -- ===========================================================================
 -- Select New Currency Rates based on the new concurrency conversion date
 -- ===========================================================================
(select gl.currency_code from_currency, decode(gl.currency_code, :p_to_currency_code, 1, (select gdr1.conversion_rate from gl_daily_rates gdr1, gl_daily_conversion_types gdct1 where gdr1.from_currency=gl.currency_code and gdr1.conversion_type=gdct1.conversion_type and 4=4 and 5=5 and 11=11)) conversion_rate from (select distinct gl.currency_code from gl_ledgers gl) gl) gdr1, -- NEW Currency Rates, 1 for the same currency, blank when the rate is missing
 -- ===========================================================================
 -- Select Old Currency Rates based on the old concurrency conversion date
 -- ===========================================================================
(select gl.currency_code from_currency, decode(gl.currency_code, :p_to_currency_code, 1, (select gdr2.conversion_rate from gl_daily_rates gdr2, gl_daily_conversion_types gdct2 where gdr2.from_currency=gl.currency_code and gdr2.conversion_type=gdct2.conversion_type and gdr2.to_currency=:p_to_currency_code and 6=6 and 7=7)) conversion_rate from (select distinct gl.currency_code from gl_ledgers gl) gl) gdr2,  -- OLD Currency Rates, 1 for the same currency, blank when the rate is missing
        -- =================================================
        -- Get the resource costs for Cost_Type 1
        -- =================================================
        (select crc1.organization_id,
                br.purchase_item_id inventory_item_id,
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
         -- Revision for version 1.6
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    8=8                         -- p_cost_type1
         and    9=9                         -- p_org_code
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
         -- Revision for version 1.6
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    8=8                         -- p_cost_type1
         and    9=9                         -- p_org_code
         -- =============================================================
         -- If p_cost_type1 = frozen cost_type_id then we have all the
         -- costs and don't need this union all statement
         -- =============================================================
         and    cct1.cost_type_id           <> 1  -- frozen cost type
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
        ) crc1,
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
         -- Revision for version 1.6
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    9=9                         -- p_org_code
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
         -- Revision for version 1.6
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    9=9                         -- p_org_code
         and    10=10                       -- p_cost_type2
         -- =============================================================
         -- If p_cost_type2 = frozen cost_type_id then we have all the
         -- costs and don't need this union all statement
         -- =============================================================
         and    cct2.cost_type_id           <> 1  -- frozen cost type
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
        ) crc2,
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
                 -- ===========================================
                 -- Expense WIP Accounting Classes
                 -- 4 - Expense Non-standard
                 -- 6 - Maintenance
                 -- 7 - Expense Non-standard Lot Based
                 -- ===========================================
                 and    br.resource_id                  = wor.resource_id
                 and    ml.lookup_type                  = 'WIP_TRANSACTION_TYPE'
                 and    ml.lookup_code                  =
                                decode(br.cost_element_id,
                                        3,1, -- Resource transaction
                                        4,3) -- Outside processing
                 -- Avoid assemblies issued from expense subinventories at zero cost
                 and    nvl(wdj.issue_zero_cost_flag, 'N') = 'N'
                 -- Only want open WIP jobs
                 and    wdj.date_closed is null
                 -- Only want open non-zero hours
                 and    wor.applied_resource_units <> 0
                 -- Do not report the master inventory organization
                 and    mp.organization_id             <> mp.master_organization_id
                 -- Revision for version 1.6
                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                 and    9=9                             -- p_org_code
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
where   msiv.inventory_item_id          = sumwip.inventory_item_id
and     msiv.organization_id            = sumwip.organization_id
and     msiv.primary_uom_code           = muomv.uom_code
and     misv.inventory_item_status_code = msiv.inventory_item_status_code
and     we.wip_entity_id                = sumwip.wip_entity_id
and     sumwip.resource_id              = crc1.resource_id
and     sumwip.organization_id          = crc1.organization_id
and     msiv.organization_id            = mp.organization_id
-- Outer join as you may have newly costed resources in the new
-- cost type which were never existed in the old cost type
and     sumwip.resource_id              = crc2.resource_id (+)
and     sumwip.organization_id          = crc2.organization_id (+)
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
and     9=9                             -- p_org_code
-- Revision for version 1.6
and     mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     1=1                             -- p_ledger, p_operating_unit
-- ===================================================================
-- Only report non-zero results
-- ===================================================================
-- Revision for version 1.5, make this a parameter
-- Item_Cost_Difference + Exchange_Rate_Difference <> 0
-- and     (round(nvl(crc1.item_cost,0),5) - round(nvl(crc2.item_cost,0),5))
--          + (nvl(gdr1.conversion_rate,1) - nvl(gdr2.conversion_rate,1)) <> 0
and     decode(:p_all_wip_jobs,
                -- without a conversion rate compare the ledger currency costs
                'N', nvl(round(nvl(crc1.item_cost,0) * gdr1.conversion_rate,5) - round(nvl(crc2.item_cost,0) * gdr2.conversion_rate,5),
                         round(nvl(crc1.item_cost,0),5) - round(nvl(crc2.item_cost,0),5)),
                'Y', 1)               <> 0
-- End revision for version 1.5
-- ==========================================================
-- Revision for version 1.7.  Add in calculations for
-- resource overheads and move-based overheads
-- ==========================================================
union all
select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        sumwip.organization_code Org_Code,
        haou.name Organization_Name,
        sumwip.class_code WIP_Class,
        ml1.meaning Class_Type,
        sumwip.wip_entity_name WIP_Job,
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
        ml7.meaning Transaction_Type,
        sumwip.resource_code Resource_Code,
        sumwip.overhead_code Overhead_Code,
        sumwip.op_seq_num Operation_Seq_Number,
        sumwip.res_seq_num Resource_Seq_Number,
        ml5.meaning Matl_or_Resource_Basis_Type,
        ml6.meaning Overhead_Basis_Type,
        gl.currency_code Currency_Code,
        muomv.uom_code UOM_Code,
-- ==========================================================
-- Select the new and old item costs from Cost_Type 1 and 2
-- ==========================================================
        round(nvl(sumwip.new_material_cost,0),5) New_Material_Cost,
        round(nvl(sumwip.old_material_cost,0),5) Old_Material_Cost,
        round(nvl(sumwip.new_material_overhead_cost,0),5) New_Material_Overhead_Cost,
        round(nvl(sumwip.old_material_overhead_cost,0),5) Old_Material_Overhead_Cost,
        round(nvl(sumwip.new_resource_cost,0),5) New_Resource_Cost,
        round(nvl(sumwip.old_resource_cost,0),5) Old_Resource_Cost,
        round(nvl(sumwip.new_outside_processing_cost,0),5) New_Outside_Processing_Cost,
        round(nvl(sumwip.old_outside_processing_cost,0),5) Old_Outside_Processing_Cost,
        round(nvl(sumwip.new_overhead_cost,0),5) New_Overhead_Cost,
        round(nvl(sumwip.old_overhead_cost,0),5) Old_Overhead_Cost,
        round(nvl(sumwip.new_overhead_cost,0),5) New_Item_Cost,
        round(nvl(sumwip.old_overhead_cost,0),5) Old_Item_Cost,
-- ========================================================
-- Select the item costs from Cost_Type 1 and 2 and compare
-- ========================================================
        round(nvl(sumwip.new_overhead_cost,0),5) - round(nvl(sumwip.old_overhead_cost,0),5) Item_Cost_Difference,
        case
          when round((nvl(sumwip.new_overhead_cost,0) - nvl(sumwip.old_overhead_cost,0)),5) = 0 then 0
          when round((nvl(sumwip.new_overhead_cost,0) - nvl(sumwip.old_overhead_cost,0)),5) = round(nvl(sumwip.new_overhead_cost,0),5) then  100
          when round((nvl(sumwip.old_overhead_cost,0) - nvl(sumwip.new_overhead_cost,0)),5) = round(nvl(sumwip.old_overhead_cost,0),5) then -100
          -- Avoid dividing by zero
          when nvl(sumwip.old_overhead_cost,0) = 0 then 100
          else round((nvl(sumwip.new_overhead_cost,0) - nvl(sumwip.old_overhead_cost,0)) / nvl(sumwip.old_overhead_cost,0) * 100,2)
        end Percent_Difference,
-- ===========================================================
-- Select the WIP onhand quantities and values
-- ===========================================================
        muomv.uom_code UOM_Code,
        round(decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
                    )
           ,2) WIP_Quantity,
        -- New Onhand Value = WIP Quantity X New Item Cost
          round(decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
                      ) * nvl(sumwip.new_overhead_cost,0),2) New_Onhand_Value,
        -- Old Onhand Value = WIP Quantity X Old Item Cost
          round(decode(sumwip.old_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
                      ) * nvl(sumwip.old_overhead_cost,0),2) Old_Onhand_Value,
        -- Onhand Value Diff = New Onhand Value - Old Onhand value
          round(decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
                      ) * nvl(sumwip.new_overhead_cost,0),2) -
          round(decode(sumwip.old_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
                      ) * nvl(sumwip.old_overhead_cost,0),2) Onhand_Value_Difference,
        -- Absolute Onhand Value Difference
          abs(round(decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
                          ) * nvl(sumwip.new_overhead_cost,0),2) -
          round(decode(sumwip.old_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
                          ) * nvl(sumwip.old_overhead_cost,0),2)) Abs_Onhand_Value_Difference,
-- ========================================================
-- Select the new and old currency rates
-- ========================================================
        gdr1.conversion_rate New_FX_Rate,
        gdr2.conversion_rate Old_FX_Rate,
        gdr1.conversion_rate - gdr2.conversion_rate Exchange_Rate_Difference,
-- ===========================================================
-- Select To Currency WIP onhand quantities and values
-- ===========================================================
-- ===========================================================
-- Costs in To Currency by Cost_Element, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        round(nvl(sumwip.new_material_cost,0) * gdr1.conversion_rate
        * sumwip.quantity_completed,2) "&p_to_currency_code New Material Value",
        round(nvl(sumwip.old_material_cost,0) * gdr2.conversion_rate
        * sumwip.quantity_completed,2) "&p_to_currency_code Old Material Value",
        round(nvl(sumwip.new_material_overhead_cost,0) * gdr1.conversion_rate
        * sumwip.quantity_completed,2) "&p_to_currency_code New Material Ovhd Value",
        round(nvl(sumwip.old_material_overhead_cost,0) * gdr2.conversion_rate
        * sumwip.quantity_completed,2) "&p_to_currency_code Old Material Ovhd Value",
        round(nvl(sumwip.new_resource_cost,0) * gdr1.conversion_rate
        * sumwip.quantity_completed,2) "&p_to_currency_code New Resource Value",
        round(nvl(sumwip.old_resource_cost,0) * gdr2.conversion_rate
        * sumwip.quantity_completed,2) "&p_to_currency_code Old Resource Value",
        round(nvl(sumwip.new_outside_processing_cost,0) * gdr1.conversion_rate
        * sumwip.quantity_completed,2) "&p_to_currency_code New OSP Value",
        round(nvl(sumwip.old_outside_processing_cost,0) * gdr2.conversion_rate
        * sumwip.quantity_completed,2) "&p_to_currency_code Old OSP Value",
        round(nvl(sumwip.new_overhead_cost,0) * gdr1.conversion_rate *
        decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2) "&p_to_currency_code New Overhead Value",
        round(nvl(sumwip.old_overhead_cost,0) * gdr2.conversion_rate *
        decode(sumwip.old_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2) "&p_to_currency_code Old Overhead Value",
-- ===========================================================
-- Onhand_Values in To Currency, new values at new Fx rate
-- old values at old Fx rate
-- ===========================================================
        round(nvl(sumwip.new_overhead_cost,0) * gdr1.conversion_rate *
        decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2) "&p_to_currency_code New Onhand Value",
        round(nvl(sumwip.old_overhead_cost,0) * gdr2.conversion_rate *
        decode(sumwip.old_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2) "&p_to_currency_code Old Onhand Value",
        -- USD New Onhand Value - USD Old Onhand Value
        round(
        round(nvl(sumwip.new_overhead_cost,0) * gdr1.conversion_rate *
         decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2) -
         round(nvl(sumwip.old_overhead_cost,0) * gdr2.conversion_rate *
         decode(sumwip.old_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2),2
             ) "&p_to_currency_code Onhand Value Difference",
        -- abs(USD New Onhand Value - USD Old Onhand Value)
        abs(round(
        round(nvl(sumwip.new_overhead_cost,0) * gdr1.conversion_rate *
         decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2) -
         round(nvl(sumwip.old_overhead_cost,0) * gdr2.conversion_rate *
         decode(sumwip.old_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2),2)
           ) "&p_to_currency_code Abs Onhand Value Diff",
-- ===========================================================
-- Value Differences in To Currency using the new rate
-- New and Old costs at New Fx Rate
-- ===========================================================
        -- NEW COST at new fx conversion rate multiplied by the total onhand quantity
        -- minus OLD COST at new fx conversion rate multiplied by the total onhand quantity
        round(nvl(sumwip.new_overhead_cost,0) * gdr1.conversion_rate *
        decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2) -
        round(nvl(sumwip.old_overhead_cost,0) * gdr1.conversion_rate *
        decode(sumwip.old_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2) "&p_to_currency_code Value Difference-New Rate",
-- ===========================================================
-- Value Differences in To Currency using the old rate
-- New and Old costs at Old Fx Rate
-- ===========================================================
        -- NEW COST at old fx conversion rate multiplied by the total onhand quantity
        -- minus OLD COST at old fx conversion rate multiplied by the total onhand quantity
        round(nvl(sumwip.new_overhead_cost,0) * gdr2.conversion_rate *
        decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2) -
        round(nvl(sumwip.old_overhead_cost,0) * gdr2.conversion_rate *
        decode(sumwip.old_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
              ),2) "&p_to_currency_code Value Difference-Old Rate",
-- ===========================================================
-- Value Differences comparing the new less the old rate differences
-- ===========================================================
        -- USD Value Diff-New Rate less USD Value Diff-Old Rate
        -- USD  Value Diff-New Rate
        (round(nvl(sumwip.new_overhead_cost,0) * gdr1.conversion_rate *
         decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
               ),2) -
         round(nvl(sumwip.old_overhead_cost,0) * gdr1.conversion_rate *
         decode(sumwip.old_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
               ),2)) -
        -- USD  Value Diff-Old Rate
        (round(nvl(sumwip.new_overhead_cost,0) * gdr2.conversion_rate *
         decode(sumwip.new_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
               ),2) -
         round(nvl(sumwip.old_overhead_cost,0) * gdr2.conversion_rate *
         decode(sumwip.old_ovhd_basis_type,
                1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                nvl(round(sumwip.quantity_completed,3),0) -- for null or zero values
               ),2)) "&p_to_currency_code Value FX Difference"
from    mtl_system_items_vl msiv,
        mtl_units_of_measure_vl muomv,
        mtl_item_status_vl misv,
        mfg_lookups ml1,  -- WIP_Class_Type
        mfg_lookups ml2,  -- WIP_Job_Status
        mfg_lookups ml3,  -- Planning Make_Buy_Code
        mfg_lookups ml4,  -- WIP_Supply_Type
        mfg_lookups ml5,  -- WIP Basis_Type for resources
        mfg_lookups ml6,  -- WIP Basis_Type for overheads
        mfg_lookups ml7,  -- WIP Transaction Type for overheads
        fnd_common_lookups fcl,
        hr_organization_information hoi,
        hr_all_organization_units_vl haou,  -- inv_organization_id
        hr_all_organization_units_vl haou2, -- operating unit
        gl_ledgers gl,
        -- ===========================================================================
        -- Select New Currency Rates based on the new concurrency conversion date
        -- ===========================================================================
        (select gl.currency_code from_currency, decode(gl.currency_code, :p_to_currency_code, 1, (select gdr1.conversion_rate from gl_daily_rates gdr1, gl_daily_conversion_types gdct1 where gdr1.from_currency=gl.currency_code and gdr1.conversion_type=gdct1.conversion_type and 4=4 and 5=5 and 11=11)) conversion_rate from (select distinct gl.currency_code from gl_ledgers gl) gl) gdr1, -- NEW Currency Rates, 1 for the same currency, blank when the rate is missing
        -- ===========================================================================
        -- Select Old Currency Rates based on the old concurrency conversion date
        -- ===========================================================================
        (select gl.currency_code from_currency, decode(gl.currency_code, :p_to_currency_code, 1, (select gdr2.conversion_rate from gl_daily_rates gdr2, gl_daily_conversion_types gdct2 where gdr2.from_currency=gl.currency_code and gdr2.conversion_type=gdct2.conversion_type and gdr2.to_currency=:p_to_currency_code and 6=6 and 7=7)) conversion_rate from (select distinct gl.currency_code from gl_ledgers gl) gl) gdr2,  -- OLD Currency Rates, 1 for the same currency, blank when the rate is missing
        -- =================================================
        -- Part I
        -- Condense multiple select statements for WIP jobs,
        -- quantities, overhead rates and resource rates
        -- =================================================
        (select wip_ovhds.organization_code,
                wip_ovhds.organization_id,
                wip_ovhds.inventory_item_id,
                wip_ovhds.wip_entity_id,
                wip_ovhds.wip_entity_name,
                wip_ovhds.class_code,
                wip_ovhds.class_type,
                wip_ovhds.status_type,
                wip_ovhds.date_released,
                wip_ovhds.date_completed,
                wip_ovhds.last_update_date,
                wip_ovhds.resource_code,
                wip_ovhds.resource_id,
                wip_ovhds.department_id,
                wip_ovhds.overhead_id,
                wip_ovhds.overhead_code,
                wip_ovhds.transaction_type,
                (select max(wro.wip_supply_type)
                 from   wip_requirement_operations wro
                 where  wro.operation_seq_num = wip_ovhds.op_seq_num
                 and    wro.wip_entity_id     = wip_ovhds.wip_entity_id
                ) wip_supply_type,
                wip_ovhds.op_seq_num,
                to_number(decode(wip_ovhds.resource_code, null, null, wip_res.res_seq_num)) res_seq_num,
                decode(wip_ovhds.resource_code, null, null, wip_res.res_basis_type) res_basis_type,
                decode(wip_ovhds.resource_code, null, null, wip_res.resource_units) resource_units,
                decode(wip_ovhds.resource_code, null, null, wip_res.resource_value) resource_value,
                decode(wip_ovhds.resource_code, null, null, wip_res.res_scrapped_quantity) res_scrapped_quantity,
                wip_ovhds.quantity_completed,
                wip_ovhds.quantity_scrapped,
                sum(0) new_material_cost,
                sum(0) old_material_cost,
                sum(0) new_material_overhead_cost,
                sum(0) old_material_overhead_cost,
                sum(0) new_resource_cost,
                sum(0) old_resource_cost,
                sum(0) new_outside_processing_cost,
                sum(0) old_outside_processing_cost,
                wip_ovhds.new_overhead_cost,
                wip_ovhds.old_overhead_cost,
                wip_ovhds.new_ovhd_basis_type,
                wip_ovhds.old_ovhd_basis_type,
                decode(wip_ovhds.resource_code, null, wip_ovhds.new_item_cost, wip_res.new_item_cost) new_item_cost,
                decode(wip_ovhds.resource_code, null, wip_ovhds.old_item_cost, wip_res.old_item_cost) old_item_cost
        from    (select 'WIP_Res' txn_source,
                        wor.organization_code,
                        wor.organization_id,
                        wor.inventory_item_id,
                        wor.wip_entity_id,
                        res_costs.department_id,
                        wor.class_code,
                        wor.class_type,
                        wor.status_type,
                        wor.date_released,
                        wor.date_completed,
                        wor.last_update_date,
                        wor.resource_code,
                        wor.resource_id,
                        wor.op_seq_num,
                        wor.res_seq_num,
                        wor.res_basis_type,
                        wor.resource_units,
                        wor.resource_value,
                        wor.res_scrapped_quantity,
                        res_costs.new_resource_cost,
                        res_costs.old_resource_cost,
                        res_costs.new_outside_processing_cost,
                        res_costs.old_outside_processing_cost,
                        res_costs.new_item_cost,
                        res_costs.old_item_cost
                 from   (select mp.organization_code,
                                wor.organization_id,
                                wdj.primary_item_id inventory_item_id,
                                wor.wip_entity_id,
                                wac.class_code,
                                wac.class_type,
                                wdj.status_type,
                                wdj.date_released,
                                wdj.date_completed,
                                wdj.last_update_date,
                                br.resource_code,
                                br.resource_id,
                                wor.operation_seq_num op_seq_num,
                                wor.resource_seq_num res_seq_num,
                                nvl(wor.basis_type, br.default_basis_type) res_basis_type,
                                nvl(wor.applied_resource_units,0) resource_units,
                                nvl(wor.applied_resource_value,0) resource_value,
                                nvl(wor.relieved_res_scrap_units,0) res_scrapped_quantity
                         from   wip_operation_resources wor,
                                wip_discrete_jobs wdj,
                                wip_accounting_classes wac,
                                bom_resources br,
                                mtl_parameters mp
                         where  mp.organization_id          = wdj.organization_id
                         and    wac.class_code              = wdj.class_code
                         and    wac.organization_id         = wdj.organization_id
                         -- Only want asset jobs
                         and    wac.class_type not in (4,6,7)
                         -- ===========================================
                         -- Expense WIP Accounting Classes
                         -- 4 - Expense Non-standard
                         -- 6 - Maintenance
                         -- 7 - Expense Non-standard Lot Based
                         -- ===========================================
                         and    wor.resource_id             = br.resource_id
                         -- Do not report the master inventory organization
                         and    mp.organization_id         <> mp.master_organization_id
                         -- Only want open non-zero hours and values
                         and    wor.applied_resource_units + wor.applied_resource_value <> 0
                         and    wdj.wip_entity_id           = wor.wip_entity_id
                         and    wdj.organization_id         = wor.organization_id
                         -- Avoid assemblies issued from expense subinventories at zero cost
                         and    nvl(wdj.issue_zero_cost_flag, 'N') = 'N'
                         -- Only want open WIP jobs
                         and    wdj.date_closed is null
                         -- You can have "Pending Scheduling" status with completed operation quantities, even if not released.
                         -- Checking for Release Date so this report agrees with the Oracle standard cost update adjustment reports.
                         and    wdj.date_released is not null
                         and    9=9                         -- p_org_code
                        ) wor,
                        (select crc.organization_id,
                                crc.inventory_item_id,
                                crc.resource_id,
                                crc.department_id,
                                sum(crc.new_resource_cost) new_resource_cost,
                                sum(crc.old_resource_cost) old_resource_cost,
                                sum(crc.new_outside_processing_cost) new_outside_processing_cost,
                                sum(crc.old_outside_processing_cost) old_outside_processing_cost,
                                sum(crc.new_item_cost) new_item_cost,
                                sum(crc.old_item_cost) old_item_cost
                         from
                                -- =================================================
                                -- Get resource costs for Cost_Type 1 - New Costs
                                -- =================================================
                                (select crc1.organization_id,
                                        -999 inventory_item_id,
                                        crc1.resource_id,
                                        bdr.department_id,
                                        decode(br.cost_element_id,
                                                3, nvl(crc1.resource_rate,0),
                                                0) new_resource_cost,
                                        0 old_resource_cost,
                                        decode(br.cost_element_id,
                                                4, nvl(crc1.resource_rate,0),
                                                0) new_outside_processing_cost,
                                        0 old_outside_processing_cost,
                                        nvl(crc1.resource_rate,0) new_item_cost,
                                        0 old_item_cost
                                 from   cst_resource_costs crc1,
                                        bom_department_resources bdr,
                                        bom_resources br,
                                        cst_cost_types cct1,
                                        mtl_parameters mp
                                 where  cct1.cost_type_id           = crc1.cost_type_id
                                 and    crc1.organization_id        = mp.organization_id
                                 and    br.resource_id              = crc1.resource_id
                                 and    crc1.resource_id            = bdr.resource_id
                                 -- Do not report the master inventory organization
                                 and    mp.organization_id         <> mp.master_organization_id
                                 -- Revision for version 1.6
                                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                                 and    8=8                         -- p_cost_type1
                                 and    9=9                         -- p_org_code
                                 union all
                                 -- =============================================================
                                 -- Get the costs from the frozen cost type that is not in cost
                                 -- type 1 so that all resource costs are reported
                                 -- =============================================================
                                 select crc_frozen.organization_id,
                                        -999 inventory_item_id,
                                        crc_frozen.resource_id,
                                        bdr.department_id,
                                        decode(br.cost_element_id,
                                                3, nvl(crc_frozen.resource_rate,0),
                                                0) new_resource_cost,
                                        0 old_resource_cost,
                                        decode(br.cost_element_id,
                                                4, nvl(crc_frozen.resource_rate,0),
                                                0) new_outside_processing_cost,
                                        0 old_outside_processing_cost,
                                        nvl(crc_frozen.resource_rate,0) item_cost,
                                        0 old_item_cost
                                 from   cst_resource_costs crc_frozen,
                                        bom_department_resources bdr,
                                        cst_cost_types cct1,
                                        bom_resources br,
                                        mtl_parameters mp
                                 where  crc_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
                                 and    crc_frozen.organization_id  = mp.organization_id
                                 and    br.resource_id              = crc_frozen.resource_id
                                 and    crc_frozen.resource_id      = bdr.resource_id
                                 -- Do not report the master inventory organization
                                 and    mp.organization_id         <> mp.master_organization_id
                                 -- Revision for version 1.6
                                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                                 and    8=8                         -- p_cost_type1
                                 and    9=9                         -- p_org_code
                                 -- =============================================================
                                 -- If p_cost_type1 = frozen cost_type_id then we have all the
                                 -- costs and don't need this union all statement
                                 -- =============================================================
                                 and    cct1.cost_type_id           <> 1  -- frozen cost type
                                 -- =============================================================
                                 -- Check to see if the costs exist in cost type 1
                                 -- =============================================================
                                and not exists (
                                                 select  'x'
                                                 from    cst_resource_costs crc1
                                                 where   crc1.cost_type_id      = cct1.cost_type_id
                                                 and     crc1.organization_id   = crc_frozen.organization_id
                                                 and     crc1.resource_id       = crc_frozen.resource_id
                                                )
                                 union all
                                 -- =================================================
                                 -- Get the Resource Costs for Cost_Type 2
                                 -- =================================================
                                 select crc2.organization_id,
                                        -999 inventory_item_id,
                                        crc2.resource_id,
                                        bdr.department_id,
                                        0 new_resource_cost,
                                        decode(br.cost_element_id,
                                                3, nvl(crc2.resource_rate,0),
                                                0) old_resource_cost,
                                        0 new_outside_processing_cost,
                                        decode(br.cost_element_id,
                                                4, nvl(crc2.resource_rate,0),
                                                0) old_outside_processing_cost,
                                        0 new_item_cost,
                                        nvl(crc2.resource_rate,0) old_item_cost
                                 from   cst_resource_costs crc2,
                                        bom_department_resources bdr,
                                        bom_resources br,
                                        cst_cost_types cct2,
                                        mtl_parameters mp
                                 where  cct2.cost_type_id           = crc2.cost_type_id
                                 and    crc2.organization_id        = mp.organization_id
                                 and    br.resource_id              = crc2.resource_id
                                 and    crc2.resource_id            = bdr.resource_id
                                 -- Do not report the master inventory organization
                                 and    mp.organization_id         <> mp.master_organization_id
                                 -- Revision for version 1.6
                                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                                 and    9=9                         -- p_org_code
                                 and    10=10                       -- p_cost_type2
                                 union all
                                 -- =============================================================
                                 -- Get the costs from the frozen cost type that is not in cost
                                 -- type 2 so that all resource costs are reported
                                 -- =============================================================
                                 select crc_frozen.organization_id,
                                        -999 inventory_item_id,
                                        crc_frozen.resource_id,
                                        bdr.department_id,
                                        0 new_resource_cost,
                                        decode(br.cost_element_id,
                                                3, nvl(crc_frozen.resource_rate,0),
                                                0) old_resource_cost,
                                        0 new_outside_processing_cost,
                                        decode(br.cost_element_id,
                                                4, nvl(crc_frozen.resource_rate,0),
                                                0) old_outside_processing_cost,
                                        0 new_item_cost,
                                        nvl(crc_frozen.resource_rate,0) old_item_cost
                                 from   cst_resource_costs crc_frozen,
                                        bom_department_resources bdr,
                                        cst_cost_types cct2,
                                        bom_resources br,
                                        mtl_parameters mp
                                 where  crc_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
                                 and    crc_frozen.organization_id  = mp.organization_id
                                 and    br.resource_id              = crc_frozen.resource_id
                                 and    crc_frozen.resource_id      = bdr.resource_id
                                 -- Do not report the master inventory organization
                                 and    mp.organization_id         <> mp.master_organization_id
                                 -- Revision for version 1.6
                                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                                 and    9=9                         -- p_org_code
                                 and    10=10                       -- p_cost_type2
                                 -- =============================================================
                                 -- If p_cost_type2 = frozen cost_type_id then we have all the
                                 -- costs and don't need this union all statement
                                 -- =============================================================
                                 and    cct2.cost_type_id           <> 1  -- frozen cost type
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
                                ) crc
                         group by
                                crc.organization_id,
                                crc.inventory_item_id,
                                crc.resource_id,
                                crc.department_id
                        ) res_costs
                 where  res_costs.organization_id   = wor.organization_id
                 and    res_costs.resource_id       = wor.resource_id
                 and    res_costs.organization_id   = wor.organization_id
                ) wip_res,
                (select 'Overhead_WIP' txn_source,
                        cdo2.organization_code,
                        cdo2.organization_id,
                        wdj.primary_item_id inventory_item_id,
                        wo.wip_entity_id,
                        we.wip_entity_name,
                        wdj.class_code,
                        wac.class_type,
                        wdj.status_type,
                        wdj.date_released,
                        wdj.date_completed,
                        wdj.last_update_date,
                        cdo2.resource_code,
                        cdo2.resource_id,
                        cdo2.department_id,
                        cdo2.overhead_id,
                        cdo2.overhead_code,
                        ml.meaning transaction_type,
                        wo.operation_seq_num op_seq_num,
                        wo.quantity_completed,
                        wo.quantity_scrapped,
                        sum(cdo2.new_overhead_cost) new_overhead_cost,
                        sum(cdo2.old_overhead_cost) old_overhead_cost,
                        sum(cdo2.new_ovhd_basis_type) new_ovhd_basis_type,
                        sum(cdo2.old_ovhd_basis_type) old_ovhd_basis_type,
                        sum(cdo2.new_item_cost) new_item_cost,
                        sum(cdo2.old_item_cost) old_item_cost
                 from   wip_discrete_jobs wdj,
                        wip_entities we,
                        wip_accounting_classes wac,
                        wip_operations wo,
                        mfg_lookups ml, -- Transaction_Type
                        -- =================================================
                        -- Revision for version 1.7
                        -- Get the overhead costs for Cost_Type 1 - New
                        -- =================================================
                        -- Overheads Associated with Resources
                        (select cdo1.organization_id,
                                cro1.organization_code,
                                -999 inventory_item_id,
                                cdo1.overhead_id,
                                br_ovhd.resource_code overhead_code,
                                cro1.resource_id,
                                br.resource_code,
                                cdo1.department_id,
                                decode(br_ovhd.cost_element_id,
                                        5, nvl(cdo1.rate_or_amount,0),
                                        0) new_overhead_cost,
                                0 old_overhead_cost,
                                nvl(cdo1.basis_type, br_ovhd.default_basis_type) new_ovhd_basis_type,
                                0 old_ovhd_basis_type,
                                nvl(cdo1.rate_or_amount,0) new_item_cost,
                                0 old_item_cost
                         from   cst_department_overheads cdo1,
                                (select cro.resource_id,
                                        cro.overhead_id,
                                        cro.organization_id,
                                        mp.organization_code,
                                        bdr.department_id,
                                        cro.cost_type_id
                                 from   cst_resource_overheads cro,
                                        bom_department_resources bdr,
                                        cst_cost_types cct1,
                                        mtl_parameters mp
                                 where  cct1.cost_type_id           = cro.cost_type_id
                                 and    cro.organization_id         = mp.organization_id
                                 and    cro.resource_id             = bdr.resource_id
                                 -- Do not report the master inventory organization
                                 and    mp.organization_id         <> mp.master_organization_id
                                 -- Revision for version 1.6
                                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                                 and    8=8                         -- p_cost_type1
                                 and    9=9                         -- p_org_code
                                ) cro1,
                                bom_resources br, -- Resource cost elements
                                bom_resources br_ovhd, -- Overhead cost elements
                                cst_cost_types cct1,
                                mtl_parameters mp
                         -- cst_department_overheads has all of the overheads you are going to earn or charge
                         where  cct1.cost_type_id           = cdo1.cost_type_id
                         and    cdo1.overhead_id            = br_ovhd.resource_id
                         and    cdo1.organization_id        = mp.organization_id
                         and    cdo1.cost_type_id           = cro1.cost_type_id
                         and    cdo1.organization_id        = cro1.organization_id
                         and    cdo1.overhead_id            = cro1.overhead_id
                         and    br.resource_id              = cro1.resource_id
                         and    cdo1.department_id          = cro1.department_id
                         and    nvl(cdo1.basis_type, br_ovhd.default_basis_type) in (3,4) -- Resource units or Resource value
                         -- Do not report the master inventory organization
                         and    mp.organization_id         <> mp.master_organization_id
                         -- Revision for version 1.6
                         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                         and    8=8                         -- p_cost_type1
                         and    9=9                         -- p_org_code
                         union all
                         -- Move-Based Overheads with Basis Type Item or Lot (1,2)
                         -- You can earn Overheads based on Resources and also based on shop floor moves
                         -- This code section was added to ensure getting the Move-Based Overheads
                         select cdo1.organization_id,
                                mp.organization_code,
                                -999 inventory_item_id,
                                cdo1.overhead_id,
                                br_ovhd.resource_code overhead_code,
                                null resource_id,
                                null resource_code,
                                cdo1.department_id,
                                decode(br_ovhd.cost_element_id,
                                        5, nvl(cdo1.rate_or_amount,0),
                                        0) new_overhead_cost,
                                0 old_overhead_cost,
                                nvl(cdo1.basis_type, br_ovhd.default_basis_type) new_ovhd_basis_type,
                                0 old_ovhd_basis_type,
                                nvl(cdo1.rate_or_amount,0) new_item_cost,
                                0 old_item_cost
                         from   cst_department_overheads cdo1,
                                bom_resources br_ovhd, -- Overhead cost elements
                                cst_cost_types cct1,
                                mtl_parameters mp
                         -- cst_department_overheads has all of the overheads you are going to earn or charge
                         where  cct1.cost_type_id           = cdo1.cost_type_id
                         and    cdo1.overhead_id            = br_ovhd.resource_id
                         and    cdo1.organization_id        = mp.organization_id
                         -- You earn move-based overheads based on the number of completions ("moves")
                         -- within the operation, as opposed to the number of resource units or resource value.
                         -- To do this the Basis Type must be Item or Lot (1,2)
                         and    nvl(cdo1.basis_type, br_ovhd.default_basis_type) in (1,2) -- Item or Lot
                         -- Do not report the master inventory organization
                         and    mp.organization_id         <> mp.master_organization_id
                         -- Revision for version 1.6
                         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                         and    8=8                         -- p_cost_type1
                         and    9=9                         -- p_org_code
                         union all
                         -- =============================================================
                         -- Get the costs from the frozen cost type that is not in cost
                         -- type 1 so that all overhead costs are reported
                         -- =============================================================
                        -- Frozen Overheads Associated with Resources
                         select cdo_frozen.organization_id,
                                mp.organization_code,
                                -999 inventory_item_id,
                                cdo_frozen.overhead_id,
                                br_ovhd.resource_code overhead_code,
                                cro_frozen.resource_id,
                                br.resource_code,
                                cdo_frozen.department_id,
                                decode(br_ovhd.cost_element_id,
                                        5, nvl(cdo_frozen.rate_or_amount,0),
                                        0) new_overhead_cost,
                                0 old_overhead_cost,
                                nvl(cdo_frozen.basis_type, br_ovhd.default_basis_type) new_ovhd_basis_type,
                                0 old_ovhd_basis_type,
                                nvl(cdo_frozen.rate_or_amount,0) new_item_cost,
                                0 old_item_cost
                         from   cst_department_overheads cdo_frozen,
                                (select cro.resource_id,
                                        cro.overhead_id,
                                        cro.organization_id,
                                        mp.organization_code,
                                        bdr.department_id,
                                        cro.cost_type_id
                                 from   cst_resource_overheads cro,
                                        bom_department_resources bdr,
                                        mtl_parameters mp
                                 where  cro.cost_type_id            = 1 -- get the frozen costs for the standard cost update
                                 and    cro.organization_id         = mp.organization_id
                                 and    cro.resource_id             = bdr.resource_id
                                 -- Do not report the master inventory organization
                                 and    mp.organization_id         <> mp.master_organization_id
                                 -- Revision for version 1.6
                                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                                 and    9=9                         -- p_org_code
                                ) cro_frozen,
                                bom_resources br, -- Resource cost elements
                                bom_resources br_ovhd, -- Overhead cost elements
                                cst_cost_types cct1,
                                mtl_parameters mp
                         -- cst_department_overheads has all of the overheads you are going to earn or charge
                         where  cdo_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
                         and    cdo_frozen.overhead_id      = br_ovhd.resource_id
                         and    cdo_frozen.organization_id  = mp.organization_id
                         -- You can have move-based overheads which are not associated to resources.
                         -- You earn move-based overheads based on the number of completions ("moves")
                         -- within the operation, as opposed to the number of resource units or resource value.
                         and    cdo_frozen.cost_type_id     = cro_frozen.cost_type_id
                         and    cdo_frozen.organization_id  = cro_frozen.organization_id
                         and    cdo_frozen.overhead_id      = cro_frozen.overhead_id
                         and    br.resource_id              = cro_frozen.resource_id
                         and    cdo_frozen.department_id    = cro_frozen.department_id
                         and    nvl(cdo_frozen.basis_type, br_ovhd.default_basis_type) in (3,4) -- Resource units or Resource value
                         -- Do not report the master inventory organization
                         and    mp.organization_id         <> mp.master_organization_id
                         -- Revision for version 1.6
                         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                         and    8=8                         -- p_cost_type1
                         and    9=9                         -- p_org_code
                         -- =============================================================
                         -- If p_cost_type1 = frozen cost_type_id then we have all the
                         -- costs and don't need this union all statement
                         -- =============================================================
                         and    cct1.cost_type_id           <> 1  -- frozen cost type
                         -- =============================================================
                         -- Check to see if the overhead costs exist in cost type 1
                         -- =============================================================
                         and not exists (
                                         select  'x'
                                         from    cst_department_overheads cdo1
                                         where   cdo1.cost_type_id      = cct1.cost_type_id
                                         and     cdo1.organization_id   = cdo_frozen.organization_id
                                         and     cdo1.overhead_id       = cdo_frozen.overhead_id
                                         and     cdo1.department_id     = cdo_frozen.department_id
                                       )
                         union all
                         -- Frozen Move-Based Overheads with Basis Type Item or Lot (1,2)
                         -- You can earn Overheads based on Resources and also based on shop floor moves
                         -- This code section was added to ensure getting the Move-Based Overheads
                         select cdo_frozen.organization_id,
                                mp.organization_code,
                                -999 inventory_item_id,
                                cdo_frozen.overhead_id,
                                br_ovhd.resource_code overhead_code,
                                null resource_id,
                                null resource_code,
                                cdo_frozen.department_id,
                                decode(br_ovhd.cost_element_id,
                                        5, nvl(cdo_frozen.rate_or_amount,0),
                                        0) new_overhead_cost,
                                0 old_overhead_cost,
                                nvl(cdo_frozen.basis_type, br_ovhd.default_basis_type) new_ovhd_basis_type,
                                0 old_ovhd_basis_type,
                                nvl(cdo_frozen.rate_or_amount,0) new_item_cost,
                                0 old_item_cost
                         from   cst_department_overheads cdo_frozen,
                                bom_resources br_ovhd, -- Overhead cost elements
                                cst_cost_types cct1,
                                mtl_parameters mp
                         -- cst_department_overheads has all of the overheads you are going to earn or charge
                         where  cdo_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
                         and    cdo_frozen.overhead_id      = br_ovhd.resource_id
                         and    cdo_frozen.organization_id  = mp.organization_id
                         -- You earn move-based overheads based on the number of completions ("moves")
                         -- within the operation, as opposed to the number of resource units or resource value.
                         -- To do this the Basis Type must be Item or Lot (1,2)
                         and    nvl(cdo_frozen.basis_type, br_ovhd.default_basis_type) in (1,2) -- Item or Lot
                         -- Do not report the master inventory organization
                         and    mp.organization_id         <> mp.master_organization_id
                         -- Revision for version 1.6
                         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                         and    8=8                         -- p_cost_type1
                         and    9=9                         -- p_org_code
                         -- =============================================================
                         -- If p_cost_type1 = frozen cost_type_id then we have all the
                         -- costs and don't need this union all statement
                         -- =============================================================
                         and    cct1.cost_type_id           <> 1  -- frozen cost type
                         -- =============================================================
                         -- Check to see if the overhead costs exist in cost type 1
                         -- =============================================================
                         and not exists (
                                         select  'x'
                                         from    cst_department_overheads cdo1
                                         where   cdo1.cost_type_id      = cct1.cost_type_id
                                         and     cdo1.organization_id   = cdo_frozen.organization_id
                                         and     cdo1.overhead_id       = cdo_frozen.overhead_id
                                         and     cdo1.department_id     = cdo_frozen.department_id
                                       )
                         union all
                        -- =================================================
                        -- Get the overhead costs for Cost_Type 2
                        -- =================================================
                        -- Overheads Associated with Resources
                         select cdo.organization_id,
                                mp.organization_code,
                                -999 inventory_item_id,
                                cdo.overhead_id,
                                br_ovhd.resource_code overhead_code,
                                cro2.resource_id,
                                br.resource_code,
                                cdo.department_id,
                                0 new_overhead_cost,
                                decode(br_ovhd.cost_element_id,
                                        5, nvl(cdo.rate_or_amount,0),
                                        0) old_overhead_cost,
                                0 new_ovhd_basis_type,
                                nvl(cdo.basis_type, br_ovhd.default_basis_type) old_ovhd_basis_type,
                                0 new_item_cost,
                                nvl(cdo.rate_or_amount,0) old_item_cost
                         from   cst_department_overheads cdo,
                                (select cro.resource_id,
                                        cro.overhead_id,
                                        cro.organization_id,
                                        mp.organization_code,
                                        bdr.department_id,
                                        cro.cost_type_id
                                 from   cst_resource_overheads cro,
                                        bom_department_resources bdr,
                                        cst_cost_types cct2,
                                        mtl_parameters mp
                                 where  cct2.cost_type_id           = cro.cost_type_id
                                 and    cro.organization_id         = mp.organization_id
                                 and    cro.resource_id             = bdr.resource_id
                                 -- Do not report the master inventory organization
                                 and    mp.organization_id         <> mp.master_organization_id
                                 -- Revision for version 1.6
                                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                                 and    9=9                         -- p_org_code
                                 and    10=10                       -- p_cost_type2
                                ) cro2,
                                bom_resources br, -- Resource cost elements
                                bom_resources br_ovhd, -- Overhead cost elements
                                cst_cost_types cct2,
                                mtl_parameters mp
                         -- cst_department_overheads has all of the overheads you are going to earn or charge
                         where  cct2.cost_type_id          = cdo.cost_type_id
                         and    cdo.overhead_id            = br_ovhd.resource_id
                         and    cdo.organization_id        = mp.organization_id
                         and    cdo.cost_type_id           = cro2.cost_type_id
                         and    cdo.organization_id        = cro2.organization_id
                         and    cdo.overhead_id            = cro2.overhead_id
                         and    br.resource_id             = cro2.resource_id
                         and    cdo.department_id          = cro2.department_id
                         and    nvl(cdo.basis_type, br_ovhd.default_basis_type) in (3,4) -- Resource units or Resource value
                         -- Do not report the master inventory organization
                         and    mp.organization_id         <> mp.master_organization_id
                         -- Revision for version 1.6
                         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                         and    9=9                         -- p_org_code
                         and    10=10                       -- p_cost_type2
                         union all
                         -- Move-Based Overheads with Basis Type Item or Lot (1,2)
                         -- You can earn Overheads based on Resources and also based on shop floor moves
                         -- This code section was added to ensure getting the Move-Based Overheads
                         select cdo.organization_id,
                                mp.organization_code,
                                -999 inventory_item_id,
                                cdo.overhead_id,
                                br_ovhd.resource_code overhead_code,
                                null resource_id,
                                null resource_code,
                                cdo.department_id,
                                0 new_overhead_cost,
                                decode(br_ovhd.cost_element_id,
                                        5, nvl(cdo.rate_or_amount,0),
                                        0) old_overhead_cost,
                                0 new_ovhd_basis_type,
                                nvl(cdo.basis_type, br_ovhd.default_basis_type) old_ovhd_basis_type,
                                0 new_item_cost,
                                nvl(cdo.rate_or_amount,0) old_item_cost
                         from   cst_department_overheads cdo,
                                bom_resources br_ovhd, -- Overhead cost elements
                                cst_cost_types cct2,
                                mtl_parameters mp
                         -- cst_department_overheads has all of the overheads you are going to earn or charge
                         where  cct2.cost_type_id           = cdo.cost_type_id
                         and    cdo.overhead_id             = br_ovhd.resource_id
                         and    cdo.organization_id         = mp.organization_id
                         -- You earn move-based overheads based on the number of completions ("moves")
                         -- within the operation, as opposed to the number of resource units or resource value.
                         -- To do this the Basis Type must be Item or Lot (1,2)
                         and    nvl(cdo.basis_type, br_ovhd.default_basis_type) in (1,2) -- Item or Lot
                         -- Do not report the master inventory organization
                         and    mp.organization_id         <> mp.master_organization_id
                         -- Revision for version 1.6
                         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                         and    9=9                         -- p_org_code
                         and    10=10                       -- p_cost_type2
                         union all
                         -- =============================================================
                         -- Get the costs from the frozen cost type that is not in cost
                         -- type 2 so that all overhead costs are reported
                         -- =============================================================
                        -- Frozen Overheads Associated with Resources
                         select cdo_frozen.organization_id,
                                mp.organization_code,
                                -999 inventory_item_id,
                                cdo_frozen.overhead_id,
                                br_ovhd.resource_code overhead_code,
                                cro_frozen.resource_id,
                                br.resource_code,
                                cdo_frozen.department_id,
                                0 new_overhead_cost,
                                decode(br_ovhd.cost_element_id,
                                        5, nvl(cdo_frozen.rate_or_amount,0),
                                        0) old_overhead_cost,
                                0 new_ovhd_basis_type,
                                nvl(cdo_frozen.basis_type, br_ovhd.default_basis_type) old_ovhd_basis_type,
                                0 new_item_cost,
                                nvl(cdo_frozen.rate_or_amount,0) old_item_cost
                         from   cst_department_overheads cdo_frozen,
                                (select cro.resource_id,
                                        cro.overhead_id,
                                        cro.organization_id,
                                        mp.organization_code,
                                        bdr.department_id,
                                        cro.cost_type_id
                                 from   cst_resource_overheads cro,
                                        bom_department_resources bdr,
                                        mtl_parameters mp
                                 where  cro.cost_type_id            = 1 -- get the frozen costs for the standard cost update
                                 and    cro.organization_id         = mp.organization_id
                                 and    cro.resource_id             = bdr.resource_id
                                 -- Do not report the master inventory organization
                                 and    mp.organization_id         <> mp.master_organization_id
                                 -- Revision for version 1.6
                                 and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                                 and    9=9                         -- p_org_code
                                ) cro_frozen,
                                bom_resources br, -- Resource cost elements
                                bom_resources br_ovhd, -- Overhead cost elements
                                cst_cost_types cct2,
                                mtl_parameters mp
                         -- cst_department_overheads has all of the overheads you are going to earn or charge
                         where  cdo_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
                         and    cdo_frozen.overhead_id      = br_ovhd.resource_id
                         and    cdo_frozen.organization_id  = mp.organization_id
                         and    cdo_frozen.cost_type_id     = cro_frozen.cost_type_id
                         and    cdo_frozen.organization_id  = cro_frozen.organization_id
                         and    cdo_frozen.overhead_id      = cro_frozen.overhead_id
                         and    br.resource_id              = cro_frozen.resource_id
                         and    cdo_frozen.department_id    = cro_frozen.department_id
                         and    nvl(cdo_frozen.basis_type, br_ovhd.default_basis_type) in (3,4) -- Resource units or Resource value
                         -- Do not report the master inventory organization
                         and    mp.organization_id         <> mp.master_organization_id
                         -- Revision for version 1.6
                         -- and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                         and    9=9                         -- p_org_code
                         and    10=10                       -- p_cost_type2
                         -- =============================================================
                         -- If p_cost_type2 = frozen cost_type_id then we have all the
                         -- costs and don't need this union all statement
                         -- =============================================================
                         and    cct2.cost_type_id           <> 1  -- frozen cost type
                         -- =============================================================
                         -- Check to see if the overhead costs exist in cost type 2
                         -- =============================================================
                         and not exists (
                                         select  'x'
                                         from    cst_department_overheads cdo
                                         where   cdo.cost_type_id      = cct2.cost_type_id
                                         and     cdo.organization_id   = cdo_frozen.organization_id
                                         and     cdo.overhead_id       = cdo_frozen.overhead_id
                                         and     cdo.department_id     = cdo_frozen.department_id
                                       )
                         union all
                         -- Frozen Move-Based Overheads with Basis Type Item or Lot (1,2)
                         select cdo_frozen.organization_id,
                                mp.organization_code,
                                -999 inventory_item_id,
                                cdo_frozen.overhead_id,
                                br_ovhd.resource_code overhead_code,
                                null resource_id,
                                null resource_code,
                                cdo_frozen.department_id,
                                0 new_overhead_cost,
                                decode(br_ovhd.cost_element_id,
                                        5, nvl(cdo_frozen.rate_or_amount,0),
                                        0) old_overhead_cost,
                                0 new_ovhd_basis_type,
                                nvl(cdo_frozen.basis_type, br_ovhd.default_basis_type) old_ovhd_basis_type,
                                0 new_item_cost,
                                nvl(cdo_frozen.rate_or_amount,0) old_item_cost
                         from   cst_department_overheads cdo_frozen,
                                bom_resources br_ovhd, -- Overhead cost elements
                                cst_cost_types cct2,
                                mtl_parameters mp
                         -- cst_department_overheads has all of the overheads you are going to earn or charge
                         where  cdo_frozen.cost_type_id     = 1  -- get the frozen costs for the standard cost update
                         and    cdo_frozen.overhead_id      = br_ovhd.resource_id
                         and    cdo_frozen.organization_id  = mp.organization_id
                         -- You earn move-based overheads based on the number of completions ("moves")
                         -- within the operation, as opposed to the number of resource units or resource value.
                         -- To do this the Basis Type must be Item or Lot (1,2)
                         and    nvl(cdo_frozen.basis_type, br_ovhd.default_basis_type) in (1,2) -- Item or Lot
                         -- Do not report the master inventory organization
                         and    mp.organization_id         <> mp.master_organization_id
                         -- Revision for version 1.6
                         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                         and    9=9                         -- p_org_code
                         and    10=10                       -- p_cost_type2
                         -- =============================================================
                         -- If p_cost_type2 = frozen cost_type_id then we have all the
                         -- costs and don't need this union all statement
                         -- =============================================================
                         and    cct2.cost_type_id           <> 1  -- frozen cost type
                         -- =============================================================
                         -- Check to see if the overhead costs exist in cost type 2
                         -- =============================================================
                         and not exists (
                                         select  'x'
                                         from    cst_department_overheads cdo
                                         where   cdo.cost_type_id      = cct2.cost_type_id
                                         and     cdo.organization_id   = cdo_frozen.organization_id
                                         and     cdo.overhead_id       = cdo_frozen.overhead_id
                                         and     cdo.department_id     = cdo_frozen.department_id
                                       )
                        ) cdo2
                 where  wdj.organization_id         = cdo2.organization_id
                 and    wo.department_id            = cdo2.department_id
                 and    wo.wip_entity_id            = wdj.wip_entity_id
                 and    wo.organization_id          = wdj.organization_id
                 and    we.wip_entity_id            = wdj.wip_entity_id
                 and    wac.class_code              = wdj.class_code
                 and    wac.organization_id         = wdj.organization_id
                 -- Only want asset jobs
                 and    wac.class_type not in (4,6,7)
                 -- ===========================================
                 -- Expense WIP Accounting Classes
                 -- 4 - Expense Non-standard
                 -- 6 - Maintenance
                 -- 7 - Expense Non-standard Lot Based
                 -- ===========================================
                 and    ml.lookup_type              = 'WIP_TRANSACTION_TYPE'
                 and    ml.lookup_code              = 2 -- Overhead
                 -- Avoid assemblies issued from expense subinventories at zero cost
                 and    nvl(wdj.issue_zero_cost_flag, 'N') = 'N'
                 -- Only want open WIP jobs
                 and    wdj.date_closed is null
                 -- You can have "Pending Scheduling" status with completed operation quantities, even if not released.
                 -- Checking for Release Date so this report agrees with the Oracle standard cost update adjustment reports.
                 and    wdj.date_released is not null
                 group by
                        'Overhead_WIP', -- txn_source
                        cdo2.organization_code,
                        cdo2.organization_id,
                        wdj.primary_item_id, -- inventory_item_id
                        wo.wip_entity_id,
                        we.wip_entity_name,
                        wdj.class_code,
                        wac.class_type,
                        wdj.status_type,
                        wdj.date_released,
                        wdj.date_completed,
                        wdj.last_update_date,
                        cdo2.resource_code,
                        cdo2.resource_id,
                        cdo2.department_id,
                        cdo2.overhead_id,
                        cdo2.overhead_code,
                        ml.meaning, -- transaction_type
                        wo.operation_seq_num,
                        wo.quantity_completed,
                        wo.quantity_scrapped
                 ) wip_ovhds
                 -- A WIP operation does not have to have assigned resources
                 where  wip_ovhds.op_seq_num       = wip_res.op_seq_num (+)
                 -- You can have a WIP job with operations but with no resources
                 and    wip_ovhds.wip_entity_id    = wip_res.wip_entity_id (+)
                 and    wip_ovhds.organization_id  = wip_res.organization_id (+)
                 and    wip_ovhds.department_id    = wip_res.department_id (+)
                 -- Move-based overheads are usually not in wip_operation_resources
                 and    (wip_ovhds.resource_id = wip_res.resource_id or wip_ovhds.resource_id is null)
                 -- Only want open non-zero resource hours, resource values or only operations with completed units
                 and    (wip_res.resource_units <> 0
                         or
                         wip_ovhds.quantity_completed + wip_ovhds.quantity_scrapped <> 0
                        )
         group by
                wip_ovhds.txn_source,
                wip_ovhds.organization_code,
                wip_ovhds.organization_id,
                wip_ovhds.inventory_item_id,
                wip_ovhds.wip_entity_id,
                wip_ovhds.wip_entity_name,
                wip_ovhds.class_code,
                wip_ovhds.class_type,
                wip_ovhds.status_type,
                wip_ovhds.date_released,
                wip_ovhds.date_completed,
                wip_ovhds.last_update_date,
                wip_ovhds.resource_code,
                wip_ovhds.resource_id,
                wip_ovhds.department_id,
                wip_ovhds.overhead_id,
                wip_ovhds.overhead_code,
                wip_ovhds.transaction_type,
                wip_ovhds.op_seq_num,
                decode(wip_ovhds.resource_code, null, null, wip_res.res_seq_num), -- res_seq_num
                decode(wip_ovhds.resource_code, null, null, wip_res.res_basis_type), -- res_basis_type
                decode(wip_ovhds.resource_code, null, null, wip_res.resource_units), -- resource_units
                decode(wip_ovhds.resource_code, null, null, wip_res.resource_value), -- resource_value
                decode(wip_ovhds.resource_code, null, null, wip_res.res_scrapped_quantity), -- res_scrapped_quantity
                wip_ovhds.quantity_completed,
                wip_ovhds.quantity_scrapped,
                wip_ovhds.new_overhead_cost,
                wip_ovhds.old_overhead_cost,
                wip_ovhds.new_ovhd_basis_type,
                wip_ovhds.old_ovhd_basis_type,
                decode(wip_ovhds.resource_code, null, wip_ovhds.new_item_cost, wip_res.new_item_cost), -- new_item_cost
                decode(wip_ovhds.resource_code, null, wip_ovhds.old_item_cost, wip_res.old_item_cost) -- old_item_cost
        ) sumwip
        -- ===================================================================
        -- End of getting WIP overhead quantities, costs and values
        -- ===================================================================
-- ===================================================================
-- Joins for the item master, organization, item costs and pii costs
-- ===================================================================
where   msiv.inventory_item_id          = sumwip.inventory_item_id
and     msiv.organization_id            = sumwip.organization_id
and     msiv.primary_uom_code           = muomv.uom_code
and     misv.inventory_item_status_code = msiv.inventory_item_status_code
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
and     ml5.lookup_type (+)             = 'CST_BASIS'
and     ml5.lookup_code (+)             = sumwip.res_basis_type
and     ml6.lookup_type (+)             = 'CST_BASIS'
and     ml6.lookup_code (+)             = decode(sumwip.new_ovhd_basis_type, 0, sumwip.old_ovhd_basis_type, sumwip.new_ovhd_basis_type)
and     ml7.lookup_type                 = 'WIP_TRANSACTION_TYPE'
and     ml7.lookup_code                 = '2'
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
and     hoi.organization_id             = sumwip.organization_id
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
and     sumwip.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     decode(:p_all_wip_jobs,
                -- To Currency Onhand Value Difference not equal to zero, the ledger currency difference without a conversion rate
                'N', nvl((round(decode(nvl(sumwip.new_ovhd_basis_type, 1),
                                        1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                                        2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                                        3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                                        4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                                        5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                                        6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                                        nvl(round(sumwip.quantity_completed,3),0) -- for other values
                                      ) * nvl(sumwip.new_overhead_cost,0) * gdr1.conversion_rate,2) -
                      round(decode(nvl(sumwip.old_ovhd_basis_type, 1),
                                        1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                                        2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                                        3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                                        4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                                        5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                                        6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                                        nvl(round(sumwip.quantity_completed,3),0) -- for other values
                                      ) * nvl(sumwip.old_overhead_cost,0) * gdr2.conversion_rate,2)
                     ),
                     (round(decode(nvl(sumwip.new_ovhd_basis_type, 1),
                                        1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                                        2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                                        3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                                        4, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Resource value
                                        5, nvl(round(sumwip.resource_units * sumwip.new_item_cost,3),0), -- Total value
                                        6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                                        nvl(round(sumwip.quantity_completed,3),0) -- for other values
                                      ) * nvl(sumwip.new_overhead_cost,0),2) -
                      round(decode(nvl(sumwip.old_ovhd_basis_type, 1),
                                        1, nvl(round(sumwip.quantity_completed,3),0), -- Item
                                        2, decode(nvl(sumwip.quantity_completed,0), 0, 0, 1), -- Lot, once per operation
                                        3, nvl(round(sumwip.resource_units,3),0), -- Resource units
                                        4, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Resource value
                                        5, nvl(round(sumwip.resource_units * sumwip.old_item_cost,3),0), -- Total value
                                        6, nvl(round(sumwip.quantity_completed,3),0), -- Activity units
                                        nvl(round(sumwip.quantity_completed,3),0) -- for other values
                                      ) * nvl(sumwip.old_overhead_cost,0),2)
                     )),
                'Y', 1
              ) <> 0
-- End revision for version 1.7
order by 1,2,3,4,5,6,7,8,9,10,11
