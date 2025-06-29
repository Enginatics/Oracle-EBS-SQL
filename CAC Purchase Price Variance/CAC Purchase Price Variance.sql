/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Purchase Price Variance
-- Description: Report for Purchase Price Variance accounting entries for external inventory purchases, external outside processing purchases, (internal) intransit shipments, (internal) direct organization transfers and transfer to regular (consignment) transactions.  The FOB point indicates when title passes to the receiving organization and it also determines which internal transfer transaction gets the PPV.  With FOB Shipment, PPV happens on the Intransit Shipment transaction.  With FOB Receipt, PPV happens on the Intransit Receipt transaction.  And if you enter PO receipts by lot numbers this report splits out the PPV variances by lot number.  The PPV Cost Amount column indicates PPV due to only cost differences; the PPV FX Amount column indicates PPV due to differences between the original PO currency exchange rate and the material transaction's daily exchange rate.

Parameters:
===========
Transaction Date From:  enter the starting transaction date (mandatory).
Transaction Date To:  enter the ending transaction date (mandatory).
Currency Conversion Type:  enter the currency conversion type to use for converting foreign currency purchases into the currency of hhe general ledger (mandatory).
Category Sets 1-3:  any item category you wish, typically the Cost, Product Line or Inventory category sets (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2010-25 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |  ======= =========== ============== =========================================
-- |  1.0     26 Jan 2010 Douglas Volz   Initial Coding
-- |  1.17    01 Jan 2021 Douglas Volz   Added Section 5 PPV for Transfer to Regular transactions.
-- |  1.18    08 Jan 2021 Douglas Volz   Removed redundant joins and tables to improve performance.
-- |  1.19    14 Dec 2021 Douglas Volz   Bug fix, Section I and V were both picking up
-- |                                     Transfer to Regular PPV transactions
-- |  1.20    21 Jun 2022 Douglas Volz   Add PO Line and PO Shipment Line Creation Date.
-- |  1.21    04 Apr 2022 Andy Haack     Added organization security restriction by org_access_view oav.
-- |  1.22    10 May 2023 Douglas Volz   Fix PPV calculations for RTV and Receipt Adjustment transactions.
-- |  1.23    13 Jan 2024 Douglas Volz   Rewrite report code for single material and WIP transaction pass,
-- |                                     add Transaction Exchange Rate, PPV Cost Amount and PPV FX columns,
-- |                                     improve performance and fix PPV amount and percent calculations.
-- |  1.24    24 Jan 2024 Douglas Volz   Rename column Standard Unit Cost to Standard Purchase Unit Cost.
-- |  1.25    30 May 2025 Douglas Volz   Bug fix for PO Unit Price, added in Clearing Accounting Line Type.
-- |  1.26    16 Jun 2025 Douglas Volz   Bug fix for Intransit Shipment and Internal Order Intransit
-- |                                     Shipment transaction types.
+=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-purchase-price-variance/
-- Library Link: https://www.enginatics.com/reports/cac-purchase-price-variance/
-- Run Report: https://demo.enginatics.com/

with mta_id as
(select mta2.transaction_id
 from   mtl_transaction_accounts mta2,
        mtl_parameters mp
 where  mp.organization_id        = mta2.organization_id
 and    mta2.transaction_date    >= :p_trx_date_from    -- p_trx_date_from
 and    mta2.transaction_date    <  :p_trx_date_to + 1  -- p_trx_date_to
 and    3=3                       -- p_org_code
 and    mta2.transaction_source_type_id in (1,7,8,13)
 and    mta2.accounting_line_type = 6
),
wta_id as
(select wta2.transaction_id
 from   wip_transaction_accounts wta2,
        mtl_parameters mp
 where  mp.organization_id        = wta2.organization_id
 and    wta2.transaction_date    >= :p_trx_date_from    -- p_trx_date_from
 and    wta2.transaction_date    <  :p_trx_date_to + 1  -- p_trx_date_to
 and    3=3                       -- p_org_code
 and    wta2.accounting_line_type = 6
),
ppv_txns as
-- Revision for version 1.23
-- ===========================================================================
-- Select inventory/material/wip purchase price transactions in one SQL statement
-- ===========================================================================
(select ppv_txns2.PPV_Type,
        ppv_txns2.Ledger,
        ppv_txns2.Operating_Unit,
        ppv_txns2.Org_Code,
        ppv_txns2.organization_id,
        ppv_txns2.Ship_To_Org,
        ppv_txns2.Ship_From_Org,
        ppv_txns2.Ship_To_Org_id,
        ppv_txns2.Ship_From_Org_id,
        ppv_txns2.Period_Name,
        ppv_txns2.code_combination_id,
        ppv_txns2.inventory_item_id,
        ppv_txns2.Item_Number,
        ppv_txns2.Item_Description,
        ppv_txns2.Item_Type,
        ppv_txns2.Item_Status,
        ppv_txns2.Make_Buy_Code,
        ppv_txns2.WIP_Job,
        ppv_txns2.OSP_Resource,
        ppv_txns2.OSP_Unit_of_Measure,
        ppv_txns2.Transaction_Source_Id, -- PO Header Id
        ppv_txns2.Source_Line_Id, -- PO Release Id
        ppv_txns2.trx_source_line_id, -- iso_line.line_id
        ppv_txns2.transfer_organization_id,
        ppv_txns2.fob_point,
        ppv_txns2.Shipment_Number,
        ppv_txns2.Shipment_Creation_Date,
        ppv_txns2.Created_By,
        ppv_txns2.Accounting_Line_Type,
        ppv_txns2.Transaction_Type,
        ppv_txns2.Transaction_Id,
        ppv_txns2.RCV_Transaction_Id,
        ppv_txns2.Transfer_Transaction_Id,
        ppv_txns2.Move_Transaction_Id,
        ppv_txns2.Transaction_Date,
        ppv_txns2.Lot_Number,
        ppv_txns2.UOM_Code,
        ppv_txns2.Received_Quantity,
        -- Revision for version 1.23
        ppv_txns2.WIP_Received_Quantity,
        ppv_txns2.usage_rate_or_amount,
        ppv_txns2.GL_Currency_Code,
        ppv_txns2.PO_Currency_Code,
        ppv_txns2.PPV_Rate_or_Amount,
        ppv_txns2.PO_Exchange_Rate,
        nvl(round(gdr.conversion_rate,8),1) Daily_Exchange_Rate,
        ppv_txns2.Converted_PO_Unit_Price,
        ppv_txns2.Standard_Unit_Cost,
        ppv_txns2.MOH_Unit_cost
 from
        (select case
                   when (mmt.transaction_action_id = 3 and mmt.transaction_source_type_id = 13) then 'Direct Transfer'
                   when (mmt.transaction_action_id = 6 and mmt.transaction_source_type_id = 1) then 'Transfer to Regular'
                   when (mmt.transaction_source_type_id = 1) then 'Purchase Order'
                   when (mmt.transaction_source_type_id = 7) then 'Internal Requisitions'
                   when (mmt.transaction_source_type_id = 8) then 'Internal Orders'
                   when (mmt.transaction_source_type_id = 13) then 'Intransit'
                   else 'Unknown'
                end PPV_Type,
                nvl(gl.short_name, gl.name) Ledger,
                haou2.name Operating_Unit,
                mp.organization_code Org_Code,
                mp.organization_id,
                decode(mmt.transaction_action_id,
                         3, mp_xfer_org.organization_code, -- Direct Org Transfer, txn_id 3
                         9, mp_xfer_org.organization_code, -- Logical Intercompany Sales Issue, txn_id 11
                        10, mp_mmt_org.organization_code,  -- Logical Intercompany Shipment Receipt, txn_id 10
                        12, mp_mmt_org.organization_code,  -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
                        13, mp_xfer_org.organization_code, -- Logical Intercompany Receipt Return, txn_id 13
                        15, mp_mmt_org.organization_code,  -- Logical Intransit Receipt, txn_id 76
                        17, mp_mmt_org.organization_code,  -- Logical Expense Requisition Receipt, txn_id 27
                        21, mp_xfer_org.organization_code, -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
                        22, mp_xfer_org.organization_code, -- Logical Intransit Shipment, tnx_id 60, 65
                        '') Ship_To_Org,
                decode(mmt.transaction_action_id,
                         3, mp_mmt_org.organization_code,  -- Direct Org Transfer, txn_id 3
                         9, mp_mmt_org.organization_code,  -- Logical Intercompany Sales Issue, txn_id 11
                        10, mp_xfer_org.organization_code, -- Logical Intercompany Shipment Receipt, txn_id 10
                        12, mp_xfer_org.organization_code, -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
                        13, mp_mmt_org.organization_code,  -- Logical Intercompany Receipt Return, txn_id 13
                        15, mp_xfer_org.organization_code, -- Logical Intransit Receipt, txn_id 76
                        17, mp_xfer_org.organization_code, -- Logical Expense Requisition Receipt, txn_id 27
                        21, mp_mmt_org.organization_code,  -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
                        22, mp_mmt_org.organization_code,  -- Logical Intransit Shipment, tnx_id 60, 65
                        '') Ship_From_Org,
                decode(mmt.transaction_action_id,
                         3, mp_xfer_org.organization_id,   -- Direct Org Transfer, txn_id 3
                         9, mp_xfer_org.organization_id,   -- Logical Intercompany Sales Issue, txn_id 11
                        10, mp_mmt_org.organization_id,    -- Logical Intercompany Shipment Receipt, txn_id 10
                        12, mp_mmt_org.organization_id,    -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
                        13, mp_xfer_org.organization_id,   -- Logical Intercompany Receipt Return, txn_id 13
                        15, mp_mmt_org.organization_id,    -- Logical Intransit Receipt, txn_id 76
                        17, mp_mmt_org.organization_id,    -- Logical Expense Requisition Receipt, txn_id 27
                        21, mp_xfer_org.organization_id,   -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
                        22, mp_xfer_org.organization_id,   -- Logical Intransit Shipment, tnx_id 60, 65
                        '') Ship_To_Org_Id,
                decode(mmt.transaction_action_id,
                         3, mp_mmt_org.organization_id,    -- Direct Org Transfer, txn_id 3
                         9, mp_mmt_org.organization_id,    -- Logical Intercompany Sales Issue, txn_id 11
                        10, mp_xfer_org.organization_id,   -- Logical Intercompany Shipment Receipt, txn_id 10
                        12, mp_xfer_org.organization_id,   -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
                        13, mp_mmt_org.organization_id,    -- Logical Intercompany Receipt Return, txn_id 13
                        15, mp_xfer_org.organization_id,   -- Logical Intransit Receipt, txn_id 76
                        17, mp_xfer_org.organization_id,   -- Logical Expense Requisition Receipt, txn_id 27
                        21, mp_mmt_org.organization_id,    -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
                        22, mp_mmt_org.organization_id,    -- Logical Intransit Shipment, tnx_id 60, 65
                        '') Ship_From_Org_id,
                ah.period_name Period_Name,
                sum(decode(mta.accounting_line_type, 6, al.code_combination_id, 0)) code_combination_id,
                msiv.inventory_item_id,
                msiv.concatenated_segments Item_Number,
                msiv.description Item_Description,
                fcl.meaning Item_Type,
                misv.inventory_item_status_code_tl Item_Status,
                ml2.meaning Make_Buy_Code,
                null Class_Code,
                null WIP_Job,
                null OSP_Resource,
                null OSP_Unit_of_Measure,
                mmt.transaction_source_id, -- PO Header Id
                mmt.Source_Line_Id, -- PO Release Id
                mmt.trx_source_line_id, -- iso_line.line_id
                mmt.transfer_organization_id,
                mmt.fob_point,
                mmt.shipment_number Shipment_Number,
                mmt.created_by,
                mmt.creation_date Shipment_Creation_Date,
                ml1.meaning Accounting_Line_Type,
                mtt.transaction_type_name Transaction_Type,
                mmt.transaction_id,
                mmt.rcv_transaction_id,
                mmt.transfer_transaction_id,
                mmt.move_transaction_id,
                trunc(mmt.transaction_date) Transaction_Date,
                mtln.lot_number lot_number,
                muomv.uom_code,
                decode(mmt.fob_point,
                        -- Internal Requisitions and Internal Orders
                        1, decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity), -- Shipment
                        2, decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity), -- Receipt
                        -- ================================================================
                        -- Revision for version 1.16
                        -- Check by fob_point to determine the sign of the quantity
                        -- Revision for version 1.23
                        -- FOB Point may be null for Direct Xfers and Rel 12.2.11 Inter-Org Returns
                        -- ================================================================  
                        decode(mmt.transaction_action_id,
                               -- Purchase Orders, Direct Transfers and Transfer_to_Regular
                               1, decode(mtln.lot_number, null, mmt.primary_quantity, mtln.primary_quantity),                -- Direct Transfers
                               3, decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity),      -- Inter-Org Returns
                               decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity)
                              )
                      ) Received_Quantity,
                -- Revision for version 1.23
                0 WIP_Received_Quantity,
                0 usage_rate_or_amount,
                gl.currency_code GL_Currency_Code,
                nvl(mta.currency_code, gl.currency_code) PO_Currency_Code,
                sum(case
                   when (mta.accounting_line_type = 6)  then nvl(mta.rate_or_amount,0) -- Purchase Price Variance
                   else 0
                end) PPV_Rate_or_Amount,
                round(nvl(mta.currency_conversion_rate,1),8) PO_Exchange_Rate,
                sum(case
                      when (mmt.transaction_action_id = 1  and mmt.transaction_source_type_id = 1  and mta.accounting_line_type = 5)  then nvl(mta.rate_or_amount,0) -- Return to Vendor
                      -- Revision for version 1.25, adding in Clearing accounting_line_type.
                      when (mmt.transaction_action_id = 1  and mmt.transaction_source_type_id = 1  and mta.accounting_line_type = 31) then nvl(mta.rate_or_amount,0) -- Return to Vendor
                      when (mmt.transaction_action_id = 3  and mmt.transaction_source_type_id = 13 and mta.accounting_line_type = 9)  then nvl(mta.rate_or_amount,0) -- Direct Transfer
                      when (mmt.transaction_action_id = 3  and mmt.transaction_source_type_id = 8  and mta.accounting_line_type = 9)  then nvl(mta.rate_or_amount,0) -- Internal Orders
                      when (mmt.transaction_action_id = 6  and mmt.transaction_source_type_id = 1  and mta.accounting_line_type = 16) then nvl(mta.rate_or_amount,0) -- Transfer to Regular
                      when (mmt.transaction_action_id = 12 and mmt.transaction_source_type_id = 7  and mta.accounting_line_type = 9)  then nvl(mta.rate_or_amount,0) -- Internal Reqs
                      when (mmt.transaction_action_id = 12 and mmt.transaction_source_type_id = 13 and mta.accounting_line_type = 9)  then nvl(mta.rate_or_amount,0) -- Intransit Receipt
                      -- Revision for version 1.26
                      when (mmt.transaction_action_id = 21 and mmt.transaction_source_type_id = 8  and mta.accounting_line_type = 2)  then nvl(mta.rate_or_amount,0) -- Internal Orders, Account Accounting_Line_Type
                      when (mmt.transaction_action_id = 21 and mmt.transaction_source_type_id = 8  and mta.accounting_line_type = 9)  then nvl(mta.rate_or_amount,0) -- Internal Orders, Inter-org payables Accounting_Line_Type
                      when (mmt.transaction_action_id = 21 and mmt.transaction_source_type_id = 13 and mta.accounting_line_type = 9)  then nvl(mta.rate_or_amount,0) -- Intransit Shipment, Inter-org payables Accounting_Line_Type
                      -- End revision for version 1.26
                      when (mmt.transaction_action_id = 27 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type = 5)  then nvl(mta.rate_or_amount,0) -- PO Receipt
                      -- Revision for version 1.25, adding in Clearing accounting_line_type.
                      when (mmt.transaction_action_id = 27 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type = 31) then nvl(mta.rate_or_amount,0) -- PO Receipt
                      when (mmt.transaction_action_id = 29 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type = 5)  then nvl(mta.rate_or_amount,0) -- PO Rcpt Adjust
                      -- Revision for version 1.25, adding in Clearing accounting_line_type.
                      when (mmt.transaction_action_id = 29 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type = 31) then nvl(mta.rate_or_amount,0) -- PO Rcpt Adjust
                      -- End revision for version 1.25
                      else 0
                    end
                   ) Converted_PO_Unit_Price,
                sum(case
                      when (mmt.transaction_action_id =  1 and mmt.transaction_source_type_id = 7  and mta.accounting_line_type =  1) then nvl(mta.rate_or_amount,0) -- Internal Order Return
                      when (mmt.transaction_action_id =  1 and mmt.transaction_source_type_id = 7  and mta.accounting_line_type = 14) then nvl(mta.rate_or_amount,0) -- Internal Order Return
                      when (mmt.transaction_action_id =  1 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type =  1) then nvl(mta.rate_or_amount,0) -- Return to Vendor
                      when (mmt.transaction_action_id =  3 and mmt.transaction_source_type_id = 13 and mta.accounting_line_type =  1) then nvl(mta.rate_or_amount,0) -- Direct Transfer
                      when (mmt.transaction_action_id =  3 and mmt.transaction_source_type_id = 8  and mta.accounting_line_type =  1) then nvl(mta.rate_or_amount,0) -- Internal Orders
                      when (mmt.transaction_action_id =  3 and mmt.transaction_source_type_id = 8  and mta.accounting_line_type = 14) then nvl(mta.rate_or_amount,0) -- Internal Orders
                      when (mmt.transaction_action_id =  6 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type =  1) then nvl(mta.rate_or_amount,0) -- Transfer to Regular
                      when (mmt.transaction_action_id = 12 and mmt.transaction_source_type_id = 7  and mta.accounting_line_type =  1) then nvl(mta.rate_or_amount,0) -- Internal Requisitions
                      when (mmt.transaction_action_id = 12 and mmt.transaction_source_type_id = 7  and mta.accounting_line_type = 14) then nvl(mta.rate_or_amount,0) -- Internal Requisitions
                      when (mmt.transaction_action_id = 12 and mmt.transaction_source_type_id = 13 and mta.accounting_line_type =  1) then nvl(mta.rate_or_amount,0) -- Intransit Receipt
                      when (mmt.transaction_action_id = 12 and mmt.transaction_source_type_id = 13 and mta.accounting_line_type = 14) then nvl(mta.rate_or_amount,0) -- Intransit Receipt
                      -- Revision for version 1.26
                      when (mmt.transaction_action_id = 21 and mmt.transaction_source_type_id = 8  and mta.accounting_line_type = 14) then nvl(mta.rate_or_amount,0) -- Intransit Shipment
                      when (mmt.transaction_action_id = 21 and mmt.transaction_source_type_id = 13 and mta.accounting_line_type = 14) then nvl(mta.rate_or_amount,0) -- Intransit Shipment
                      -- End revision for version 1.26
                      when (mmt.transaction_action_id = 27 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type =  1) then nvl(mta.rate_or_amount,0) -- PO Receipt
                      when (mmt.transaction_action_id = 29 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type =  1) then nvl(mta.rate_or_amount,0) -- PO Rcpt Adjust
                      else 0
                    end
                   ) Standard_Unit_Cost,
                sum(case
                      when (mmt.transaction_action_id =  1 and mmt.transaction_source_type_id = 7  and mta.accounting_line_type =  3) then nvl(mta.rate_or_amount,0) -- Internal Order Return
                      when (mmt.transaction_action_id =  1 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type =  3) then nvl(mta.rate_or_amount,0) -- Return to Vendor
                      when (mmt.transaction_action_id =  3 and mmt.transaction_source_type_id = 13 and mta.accounting_line_type =  3) then nvl(mta.rate_or_amount,0) -- Direct Transfer
                      when (mmt.transaction_action_id =  3 and mmt.transaction_source_type_id = 8  and mta.accounting_line_type =  3) then nvl(mta.rate_or_amount,0) -- Internal Orders
                      when (mmt.transaction_action_id =  6 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type =  3) then nvl(mta.rate_or_amount,0) -- Transfer to Regular
                      when (mmt.transaction_action_id = 12 and mmt.transaction_source_type_id = 7  and mta.accounting_line_type =  3) then nvl(mta.rate_or_amount,0) -- Internal Requisitions
                      when (mmt.transaction_action_id = 12 and mmt.transaction_source_type_id = 13 and mta.accounting_line_type =  3) then nvl(mta.rate_or_amount,0) -- Intransit Receipt
                      -- Revision for version 1.26
                      when (mmt.transaction_action_id = 21 and mmt.transaction_source_type_id = 8  and mta.accounting_line_type =  3) then nvl(mta.rate_or_amount,0) -- Intransit Shipment
                      when (mmt.transaction_action_id = 21 and mmt.transaction_source_type_id = 13 and mta.accounting_line_type =  3) then nvl(mta.rate_or_amount,0) -- Intransit Shipment
                      -- End revision for version 1.26
                      when (mmt.transaction_action_id = 27 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type =  3) then nvl(mta.rate_or_amount,0) -- PO Receipt
                      when (mmt.transaction_action_id = 29 and mmt.transaction_source_type_id = 1  and mta.accounting_line_type =  3) then nvl(mta.rate_or_amount,0) -- PO Rcpt Adjust
                      else 0
                    end 
                   ) MOH_Unit_cost      
         from   mta_id,
                mtl_transaction_accounts mta,
                mtl_material_transactions mmt,
                mtl_transaction_lot_numbers mtln,
                mtl_transaction_types mtt,
                mtl_system_items_vl msiv,
                mtl_units_of_measure_vl muomv,
                mtl_item_status_vl misv,
                mtl_parameters mp,            -- Accounted For Org
                mtl_parameters mp_xfer_org,   -- Transfer Org
                mtl_parameters mp_mmt_org,    -- MMT Org
                fnd_common_lookups fcl, -- item type
                mfg_lookups ml1, -- accounting line type
                mfg_lookups ml2, -- planning make/buy code
                hr_organization_information hoi,
                hr_all_organization_units_vl haou, -- inv_organization_id
                hr_all_organization_units_vl haou2, -- operating unit
                gl_ledgers gl,
                xla_distribution_links xdl,
                xla_ae_headers ah,
                xla_ae_lines al
                -- ========================================================
                -- Material Transaction, org and item joins
                -- ========================================================
         where  mta.transaction_id              = mmt.transaction_id
         and    mta.transaction_id              = mta_id.transaction_id
         and    mmt.transaction_id              = mtln.transaction_id (+)
         and    mmt.inventory_item_id           = mtln.inventory_item_id (+)
         and    mmt.organization_id             = mtln.organization_id (+)
         and    mmt.transaction_type_id         = mtt.transaction_type_id
         and    mmt.inventory_item_id           = msiv.inventory_item_id
         and    mmt.organization_id             = msiv.organization_id -- accounted for organization_id
         and    mp.organization_id              = mta.organization_id -- accounted for organization_id
         and    mp_xfer_org.organization_id     = nvl(mmt.transfer_organization_id, mmt.organization_id)
         and    mp_mmt_org.organization_id      = mmt.organization_id
         and    msiv.primary_uom_code           = muomv.uom_code
         and    misv.inventory_item_status_code = msiv.inventory_item_status_code
         and    mmt.transaction_source_type_id in (1,7,8,13)
         -- and    mta.transaction_source_type_id in (1,7,8,13)
         -- and    mmt.transaction_action_id in (1,3,6,12,27,29) 
         -- ========================================================
         -- Version 1.3, 1.14 added lookup values to see more detail
         -- ========================================================
         and    ml1.lookup_type                 = 'CST_ACCOUNTING_LINE_TYPE'
         and    ml1.lookup_code                 = 6 -- Purchase price or rate variance
         and    ml2.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
         and    ml2.lookup_code                 = msiv.planning_make_buy_code
         and    fcl.lookup_type (+)             = 'ITEM_TYPE'
         and    fcl.lookup_code (+)             = msiv.item_type
         -- ========================================================
         -- Material Transaction date, operating unit and ledger joins
         -- ========================================================
         and    1=1                             -- p_item_number, p_operating_unit, p_ledger
         and    2=2                             -- p_trx_date_from, p_trx_date_to
         and    3=3                             -- p_org_code
                -- ========================================================
                -- HR organizations, operating unit and ledger joins
                -- ========================================================
         and    hoi.org_information_context     = 'Accounting Information'
         and    hoi.organization_id             = mta.organization_id
         and    hoi.organization_id             = haou.organization_id   -- this gets the organization name
         and    haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
         and    gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
                -- ========================================================
                -- SLA table joins to get the exact account numbers
                -- ========================================================
         and    ah.ledger_id                    = gl.ledger_id
         and    ah.application_id               = al.application_id
         and    ah.application_id               = 707
         and    ah.ae_header_id                 = al.ae_header_id
         and    al.ledger_id                    = ah.ledger_id
         and    al.ae_header_id                 = xdl.ae_header_id
         and    al.ae_line_num                  = xdl.ae_line_num
         and    xdl.application_id              = 707
         and    xdl.source_distribution_type    = 'MTL_TRANSACTION_ACCOUNTS'
         and    mta.inv_sub_ledger_id           = xdl.source_distribution_id_num_1
         -- ========================================================
         -- Fetch all transactions with PPV entries
         -- ========================================================
         -- and    exists  (select 'x' from mtl_transaction_accounts mta2
         --                where   mta2.accounting_line_type       = 6
         --                and     mta2.transaction_id             = mta.transaction_id
         --                and     mta2.organization_id            = mta.organization_id
         --                and     mta2.transaction_date           = mta.transaction_date
         --                and     mta2.transaction_source_type_id = mta.transaction_source_type_id
         --               )
         group by
                case
                   when (mmt.transaction_action_id = 3 and mmt.transaction_source_type_id = 13) then 'Direct Transfer'
                   when (mmt.transaction_action_id = 6 and mmt.transaction_source_type_id = 1) then 'Transfer to Regular'
                   when (mmt.transaction_source_type_id = 1) then 'Purchase Order'
                   when (mmt.transaction_source_type_id = 7) then 'Internal Requisitions'
                   when (mmt.transaction_source_type_id = 8) then 'Internal Orders'
                   when (mmt.transaction_source_type_id = 13) then 'Intransit'
                   else 'Unknown'
                end, -- PPV_Type
                nvl(gl.short_name, gl.name), -- Ledger
                haou2.name, -- Operating_Unit
                mp.organization_code, -- Org_Code
                mp.organization_id,
                decode(mmt.transaction_action_id,
                         3, mp_xfer_org.organization_code, -- Direct Org Transfer, txn_id 3
                         9, mp_xfer_org.organization_code, -- Logical Intercompany Sales Issue, txn_id 11
                        10, mp_mmt_org.organization_code,  -- Logical Intercompany Shipment Receipt, txn_id 10
                        12, mp_mmt_org.organization_code,  -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
                        13, mp_xfer_org.organization_code, -- Logical Intercompany Receipt Return, txn_id 13
                        15, mp_mmt_org.organization_code,  -- Logical Intransit Receipt, txn_id 76
                        17, mp_mmt_org.organization_code,  -- Logical Expense Requisition Receipt, txn_id 27
                        21, mp_xfer_org.organization_code, -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
                        22, mp_xfer_org.organization_code, -- Logical Intransit Shipment, tnx_id 60, 65
                        ''), -- Ship_To_Org
                decode(mmt.transaction_action_id,
                         3, mp_mmt_org.organization_code,  -- Direct Org Transfer, txn_id 3
                         9, mp_mmt_org.organization_code,  -- Logical Intercompany Sales Issue, txn_id 11
                        10, mp_xfer_org.organization_code, -- Logical Intercompany Shipment Receipt, txn_id 10
                        12, mp_xfer_org.organization_code, -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
                        13, mp_mmt_org.organization_code,  -- Logical Intercompany Receipt Return, txn_id 13
                        15, mp_xfer_org.organization_code, -- Logical Intransit Receipt, txn_id 76
                        17, mp_xfer_org.organization_code, -- Logical Expense Requisition Receipt, txn_id 27
                        21, mp_mmt_org.organization_code,  -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
                        22, mp_mmt_org.organization_code,  -- Logical Intransit Shipment, tnx_id 60, 65
                        ''), -- Ship_From_Org
                decode(mmt.transaction_action_id,
                         3, mp_xfer_org.organization_id,   -- Direct Org Transfer, txn_id 3
                         9, mp_xfer_org.organization_id,   -- Logical Intercompany Sales Issue, txn_id 11
                        10, mp_mmt_org.organization_id,    -- Logical Intercompany Shipment Receipt, txn_id 10
                        12, mp_mmt_org.organization_id,    -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
                        13, mp_xfer_org.organization_id,   -- Logical Intercompany Receipt Return, txn_id 13
                        15, mp_mmt_org.organization_id,    -- Logical Intransit Receipt, txn_id 76
                        17, mp_mmt_org.organization_id,    -- Logical Expense Requisition Receipt, txn_id 27
                        21, mp_xfer_org.organization_id,   -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
                        22, mp_xfer_org.organization_id,   -- Logical Intransit Shipment, tnx_id 60, 65
                        ''), -- Ship_To_Org_Id
                decode(mmt.transaction_action_id,
                         3, mp_mmt_org.organization_id,    -- Direct Org Transfer, txn_id 3
                         9, mp_mmt_org.organization_id,    -- Logical Intercompany Sales Issue, txn_id 11
                        10, mp_xfer_org.organization_id,   -- Logical Intercompany Shipment Receipt, txn_id 10
                        12, mp_xfer_org.organization_id,   -- Receive from intransit, Int Req Intr Rcpt, txn_id 12,61
                        13, mp_mmt_org.organization_id,    -- Logical Intercompany Receipt Return, txn_id 13
                        15, mp_xfer_org.organization_id,   -- Logical Intransit Receipt, txn_id 76
                        17, mp_xfer_org.organization_id,   -- Logical Expense Requisition Receipt, txn_id 27
                        21, mp_mmt_org.organization_id,    -- Intransit Shipment, Int Order Intr Ship,  txn_id 21,62
                        22, mp_mmt_org.organization_id,    -- Logical Intransit Shipment, tnx_id 60, 65
                        ''), -- Ship_From_Org_id
                ah.period_name, -- Period_Name
                msiv.inventory_item_id,
                msiv.concatenated_segments, -- Item_Number
                msiv.description, -- Item_Description
                fcl.meaning, -- Item_Type
                misv.inventory_item_status_code_tl, -- Item_Status
                ml2.meaning, -- Make_Buy_Code
                null, -- Class_Code
                null, -- WIP_Job
                null, -- OSP_Resource
                null, -- OSP_Unit_of_Measure,
                mmt.transaction_source_id, -- PO Header Id
                mmt.Source_Line_Id, -- PO Release Id
                mmt.trx_source_line_id, -- iso_line.line_id
                mmt.transfer_organization_id,
                mmt.fob_point,
                mmt.shipment_number, -- Shipment_Number
                mmt.created_by,
                mmt.creation_date, -- Shipment_Creation_Date
                ml1.meaning, -- Accounting_Line_Type
                mtt.transaction_type_name, -- Transaction_Type
                mmt.transaction_id, -- Transaction_Id
                mmt.rcv_transaction_id, -- RCV_Transaction_Id
                mmt.transfer_transaction_id, -- Transfer_Transaction_id
                mmt.move_transaction_id,
                trunc(mmt.transaction_date), -- Transaction_Date
                mtln.lot_number, -- Lot_Number
                muomv.uom_code, -- UOM_Code
                decode(mmt.fob_point,
                        -- Internal Requisitions and Internal Orders
                        1, decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity), -- Shipment
                        2, decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity), -- Receipt
                        decode(mmt.transaction_action_id,
                                -- Purchase Orders and Transfer_to_Regular
                                1, decode(mtln.lot_number, null, mmt.primary_quantity, mtln.primary_quantity),
                                -- Direct Transfers
                                3, decode(mtln.lot_number, null, -1 * mmt.primary_quantity, -1 * mtln.primary_quantity),
                                -- Inter-Org Returns
                                decode(mtln.lot_number, null,  1 * mmt.primary_quantity,  1 * mtln.primary_quantity)
                              )
                      ), -- Received_Quantity
                -- Revision for version 1.23
                0, -- WIP_Received_Quantity
                0, -- usage_rate_or_amount
                gl.currency_code, -- GL_Currency_Code
                nvl(mta.currency_code, gl.currency_code), -- PO_Currency_Code,
                round(nvl(mta.currency_conversion_rate,1),8), -- PO_Exchange_Rate
                mmt.transaction_action_id,
                mmt.transaction_source_type_id
         union all
         select 'WIP_OSP' PPV_Type,
                nvl(gl.short_name, gl.name) Ledger,
                haou2.name Operating_Unit,
                mp.organization_code Org_Code,
                mp.organization_id,
                mp.organization_code Ship_To_Org,
                '' Ship_From_Org,
                mp.organization_id Ship_To_Org_id,
                -99 Ship_From_Org_id,
                ah.period_name Period_Name,
                sum(decode(wta.accounting_line_type, 6, al.code_combination_id, 0)) code_combination_id,
                msiv.inventory_item_id,
                msiv.concatenated_segments Item_Number,
                msiv.description Item_Description,
                fcl.meaning Item_Type,
                misv.inventory_item_status_code_tl Item_Status,
                ml2.meaning Make_Buy_Code,
                wac.class_code Class_Code,
                we.wip_entity_name WIP_Job,
                br.resource_code OSP_Resource,
                br.unit_of_measure OSP_Unit_of_Measure,
                wt.po_header_id transaction_source_id,
                null Source_Line_Id, -- PO Release Id
                null trx_source_line_id, -- iso_line.line_id
                null transfer_organization_id,
                null fob_point,
                null shipment_number,
                wt.created_by,
                wt.creation_date Shipment_Creation_Date,
                ml1.meaning Accounting_Line_Type,
                ml3.meaning Transaction_Type,
                wt.transaction_id,
                wt.rcv_transaction_id,
                null Transfer_Transaction_id,
                null Move_Transaction_Id,
                trunc(wt.transaction_date) Transaction_Date,
                null lot_number,
                null UOM_Code,
                0 Received_Quantity,
                -- Revision for version 1.23
                wt.primary_quantity WIP_Received_Quantity,
                wt.usage_rate_or_amount,
                gl.currency_code GL_Currency_Code,
                nvl(wta.currency_code, gl.currency_code) PO_Currency_Code,
                sum(case
                       when (wta.accounting_line_type = 6)  then nvl(wta.rate_or_amount,0) -- Purchase Price Variance
                       else 0
                    end
                   ) PPV_Rate_or_Amount,
                round(nvl(wta.currency_conversion_rate,1),8) PO_Exchange_Rate,
                sum(case
                       when (wt.source_code = 'RCV' and wta.accounting_line_type = 4) then nvl(wta.rate_or_amount,0) -- Resource Absorption / Receiving for Return to Vendor, PO Receipt, PO Rcpt Adjust
                       when (wt.source_code = 'RCV' and wta.accounting_line_type = 5) then nvl(wta.rate_or_amount,0) -- Receiving for Return to Vendor, PO Receipt, PO Rcpt Adjust (not in use)
                       else 0
                    end
                   ) Converted_PO_Unit_Price,
                sum(case
                       when (wt.source_code = 'RCV' and wta.accounting_line_type = 7) then nvl(wta.rate_or_amount,0) -- Return to Vendor, PO Receipt, PO Rcpt Adjust
                       else 0
                    end
                   ) Standard_Unit_Cost,
                sum(case
                       when (wt.source_code = 'RCV' and wta.accounting_line_type = 3) then nvl(wta.rate_or_amount,0) -- Overhead Absorption for Return to Vendor, PO Receipt, PO Rcpt Adjust
                       else 0
                    end
                   ) MOH_Unit_cost      
         from   wta_id,
                wip_transaction_accounts wta,
                wip_transactions wt,
                wip_entities we,
                wip_discrete_jobs wdj,
                wip_accounting_classes wac,
                bom_resources br,
                mtl_system_items_vl msiv,
                mtl_units_of_measure_vl muomv,
                mtl_item_status_vl misv,
                mtl_parameters mp, 
                fnd_common_lookups fcl, -- item type
                mfg_lookups ml1, -- accounting line type
                mfg_lookups ml2, -- planning make/buy code
                mfg_lookups ml3, -- WIP short transaction type
                hr_organization_information hoi,
                hr_all_organization_units_vl haou, -- inv_organization_id
                hr_all_organization_units_vl haou2, -- operating unit
                gl_ledgers gl,
                xla_distribution_links xdl,
                xla_ae_headers ah,
                xla_ae_lines al
         -- ========================================================
         -- WIP Job, Transaction, org, osp resource and item joins
         -- ========================================================
         where  wta.transaction_id              = wt.transaction_id
         and    wta.transaction_id              = wta_id.transaction_id
         and    wta.organization_id             = mp.organization_id
         and    mp.organization_id              = msiv.organization_id
         -- Revision for version 1.14
         and    msiv.primary_uom_code           = muomv.uom_code
         and    misv.inventory_item_status_code = msiv.inventory_item_status_code
         -- End revision for version 1.14
         and    wta.resource_id                 = br.resource_id 
         -- Only pick up OSP resources where the standard_rate_flag is checked
         -- When the wt.standard_rate_flag is checked PPV entries are created
         -- 1 = Yes, 2 = No
         and    wt.standard_rate_flag           = 1
         and    br.cost_element_id              = 4 -- OSP cost element
         and    wdj.wip_entity_id               = wt.wip_entity_id
         and    wdj.wip_entity_id               = we.wip_entity_id
         and    msiv.inventory_item_id          = wdj.primary_item_id
         and    wac.class_code                  = wdj.class_code
         and    wdj.organization_id             = wac.organization_id
         -- ========================================================
         -- PO Line and OSP Item information
         -- ========================================================
         -- ========================================================
         -- Version 1.3, 1.14 added lookup values to see more detail
         -- ========================================================
         and    ml1.lookup_type                 = 'CST_ACCOUNTING_LINE_TYPE'
         and    ml1.lookup_code                 = 6 -- Purchase price or rate variance
         and    ml2.lookup_type                 = 'MTL_PLANNING_MAKE_BUY'
         and    ml2.lookup_code                 = msiv.planning_make_buy_code
         and    ml3.lookup_type                 = 'WIP_TRANSACTION_TYPE_SHORT'
         and    ml3.lookup_code                 = wt.transaction_type
         and    fcl.lookup_type (+)             = 'ITEM_TYPE'
         and    fcl.lookup_code (+)             = msiv.item_type
         -- ========================================================
         -- WIP Transaction date, operating unit and ledger joins
         -- ========================================================
         and    hoi.org_information_context     = 'Accounting Information'
         and    hoi.organization_id             = wta.organization_id
         and    hoi.organization_id             = haou.organization_id   -- this gets the organization name
         and    haou2.organization_id           = to_number(hoi.org_information3) -- this gets the operating unit id
         and    gl.ledger_id                    = to_number(hoi.org_information1) -- get the ledger_id
         and    mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
         and    wt.transaction_date            >= :p_trx_date_from    -- p_trx_date_from
         and    wt.transaction_date            <  :p_trx_date_to + 1  -- p_trx_date_to
         and    1=1                             -- p_item_number, p_operating_unit, p_ledger
         and    3=3                             -- p_org_code
         -- ========================================================
         -- SLA table joins to get the exact account numbers
         -- ========================================================
         and    ah.ledger_id                    = gl.ledger_id
         and    ah.application_id               = al.application_id
         and    ah.application_id               = 707
         and    ah.ae_header_id                 = al.ae_header_id
         and    al.ledger_id                    = ah.ledger_id
         and    al.ae_header_id                 = xdl.ae_header_id
         and    al.ae_line_num                  = xdl.ae_line_num
         and    xdl.application_id              = 707
         and    xdl.source_distribution_type    = 'WIP_TRANSACTION_ACCOUNTS'
         and    wta.wip_sub_ledger_id           = xdl.source_distribution_id_num_1
         -- ========================================================
         -- Fetch all transactions with PPV entries
         -- ========================================================
         -- and    exists  (select 'x' from wip_transaction_accounts wta2
         --                 where   wta2.accounting_line_type       = 6
         --                 and     wta2.transaction_id             = wta.transaction_id
         --                 and     wta2.organization_id            = wta.organization_id
         --                 and     wta2.transaction_date           = wta.transaction_date
         --                )
         group by
                'WIP_OSP', -- PPV_Type
                nvl(gl.short_name, gl.name), -- Ledger
                haou2.name, -- Operating_Unit
                mp.organization_code, -- Org_Code
                mp.organization_id,
                mp.organization_code, -- Ship_To_Org
                '', --  Ship_From_Org,
                mp.organization_id, -- Ship_To_Org_id
                '', -- Ship_From_Org_id
                ah.period_name, -- Period_Name
                msiv.inventory_item_id,
                msiv.concatenated_segments, -- Item_Number
                msiv.description, -- Item_Description
                fcl.meaning, -- Item_Type
                misv.inventory_item_status_code_tl, -- Item_Status
                ml2.meaning, -- Make_Buy_Code
                wac.class_code, -- Class_Code
                we.wip_entity_name, -- WIP_Job
                br.resource_code, -- OSP_Resource
                br.unit_of_measure, -- OSP_Unit_of_Measure,
                wt.po_header_id, -- transaction_source_id
                null, -- Source_Line_Id (PO Release Id)
                null, -- trx_source_line_id (iso_line.line_id)
                null, -- transfer_organization_id
                null, -- move_transaction_id
                null, -- fob_point
                null, -- shipment_number
                wt.created_by,
                wt.creation_date, -- Shipment_Creation_Date
                ml1.meaning, -- Accounting_Line_Type
                ml3.meaning, -- Transaction_Type
                wt.transaction_id,
                wt.rcv_transaction_id,
                null, -- Transfer_Transaction_id
                trunc(wt.transaction_date), -- Transaction_Date
                null, -- lot_number
                null, -- UOM_Code,
                0, -- Received_Quantity,
                -- Revision for version 1.23
                wt.primary_quantity, -- WIP_Received_Quantity
                wt.usage_rate_or_amount,
                gl.currency_code, -- GL_Currency_Code
                nvl(wta.currency_code, gl.currency_code), -- PO_Currency_Code
                round(nvl(wta.currency_conversion_rate,1),8) -- PO_Exchange_Rate
        ) ppv_txns2,
        (select gdr.*
         from    gl_daily_rates gdr,
                 gl_daily_conversion_types gdct
         where   gdct.conversion_type            = gdr.conversion_type
         and     gdr.conversion_date            >= :p_trx_date_from    -- p_trx_date_from
         and     gdr.conversion_date            <  :p_trx_date_to + 1  -- p_trx_date_to
         and     4=4                             -- p_user_conversion_type
        ) gdr -- Daily Currency Rates
 where  gdr.conversion_date (+)          = ppv_txns2.Transaction_Date
 and    gdr.from_currency (+)            = ppv_txns2.PO_Currency_Code
 and    gdr.to_currency (+)              = ppv_txns2.GL_Currency_Code
) -- ppv_txns

----------------main query starts here--------------

-- =============================================================
-- Section I
-- Get the Deliveries from Receiving Inspection to Stores
-- inventory for purchase order receipt transactions
-- =============================================================
select  ppv_txns.Ledger,
        ppv_txns.Operating_Unit,
        ppv_txns.org_code Ship_To_Org,
        ppv_txns.Ship_From_Org,
        ppv_txns.period_name Period_Name,
        &segment_columns
        pov.vendor_name Supplier,
        he.full_name Buyer,
        ppv_txns.Item_Number,
        ppv_txns.Item_Description,
        ppv_txns.Item_Type,
        ppv_txns.Item_Status,
        ppv_txns.Make_Buy_Code,
&category_columns
        -- Revision for version 1.9
        '' WIP_Job,
        '' OSP_Resource,
        -- End change for version 1.9
        ph.segment1 PR_or_PO_Number,
        to_char(pl.line_num)  Line_Number,
        -- Revision for version 1.20
        pl.creation_date Line_Creation_Date,
        to_char(pr.release_num) PO_Release,
        rsh.receipt_num Receipt_Number,
        rsh.shipment_num Shipment_Number,
        -- Revision for version 1.20
        pll.creation_date Shipment_Creation_Date,
        ppv_txns.Accounting_Line_Type,
        ppv_txns.Transaction_Type,
        ppv_txns.Transaction_Id,
        ppv_txns.Transaction_Date,
        ppv_txns.Lot_Number,
        -- Revision for version 1.14
        ppv_txns.UOM_Code,
        ppv_txns.Received_Quantity,
        -- Revision for version 1.23
        ppv_txns.WIP_Received_Quantity,
        nvl(ph.currency_code, ppv_txns.PO_Currency_Code) PO_Currency_Code,
        round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) PO_Unit_Price,
        ppv_txns.PO_Exchange_Rate,
        -- Revision for version 1.23
        ppv_txns.Daily_Exchange_Rate,
        ppv_txns.GL_Currency_Code,
        round(ppv_txns.Converted_PO_Unit_Price,5) Converted_PO_Unit_Price,
        -- Revision for version 1.23
        -- Revision for version 1.24, rename Standard_Unit_Cost
        round(ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost,5) Standard_Purchase_Unit_Cost,
        -- Unit cost difference = PO price - Std Unit Cost
        round(ppv_txns.Converted_PO_Unit_Price,5) - round(ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost,5) Unit_Cost_Difference,
        round(ppv_txns.Converted_PO_Unit_Price * ppv_txns.Received_Quantity,2) Total_Purchase_Amount,
        -- Revision for version 1.22, Std Unit Cost X Qty
        round((ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost) * ppv_txns.Received_Quantity,2) Total_Standard_Amount,
        -- PPV_Amount = PO Amount - Std Amount
        round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) * ppv_txns.Received_Quantity,2) PPV_Amount,
        -- Revision for version 1.23, calculate the percentage
        -- case
        --   when difference = 0 then 0
        --   when standard = 0 then 100%
        --   when PO unit price = 0 then -100%
        --   else PO - std / std
        case
           when round(ppv_txns.PPV_Rate_or_Amount,5) = 0 then 0
           when round((ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost),5) = 0 then 100
           when round(ppv_txns.Converted_PO_Unit_Price,5) = 0 then -100
           else round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) / (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost),5) * sign(ppv_txns.Received_Quantity) * 100
        end Percent_Difference,
        -- End revision for version 1.23
        -- Revision for version 1.23, add PPV Cost Amount and PPV FX Amount
        -- PPV Cost Amount = PPV Amount - PPV FX Amount
        -- PPV Amount = PO Amount - Std Amount
        round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) * ppv_txns.Received_Quantity,2) -
        -- PPV FX Amount = (Daily FX Rate - PO FX Rate) X PO Amount in PO Currency
        round((ppv_txns.Daily_Exchange_Rate - ppv_txns.PO_Exchange_Rate) * round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) * ppv_txns.Received_Quantity,2) PPV_Cost_Amount,
        -- PPV FX Amount = (Daily FX Rate - PO FX Rate) X PO Amount in PO Currency
        round((ppv_txns.Daily_Exchange_Rate - ppv_txns.PO_Exchange_Rate) * round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) * ppv_txns.Received_Quantity,2) PPV_FX_Amount
        -- End revision for version 1.23
from    ppv_txns,
        rcv_transactions rt,
        rcv_shipment_headers rsh,
        po_headers_all ph,
        po_lines_all pl,
        po_line_locations_all pll,
        po_releases_all pr,
        po_distributions_all pod,
        po_vendors pov,
        hr_employees he,
        gl_code_combinations gcc
-- ========================================================
-- Purchase Order transaction, receiving and OSP item joins
-- ========================================================
where   ppv_txns.PPV_Type               = 'Purchase Order'
and     rt.transaction_id               = ppv_txns.rcv_transaction_id
-- Revision for version 1.18, performance improvements
-- and     ph.po_header_id                 = pl.po_header_id
and     pod.destination_type_code       = 'INVENTORY'
and     pod.po_distribution_id          = rt.po_distribution_id
and     rsh.shipment_header_id          = rt.shipment_header_id
and     pod.line_location_id            = pll.line_location_id
and     pl.po_line_id                   = pll.po_line_id
and     pll.po_release_id               = pr.po_release_id (+)
and     ph.po_header_id                 = ppv_txns.Transaction_Source_Id
and     pl.po_line_id                   = rt.po_line_id
and     pov.vendor_id                   = ph.vendor_id
and     ph.agent_id                     = he.employee_id
and     gcc.code_combination_id (+)     = ppv_txns.code_combination_id
union all
-- =============================================================
-- Section II - WIP PPV Entries
-- =============================================================
select  ppv_txns.Ledger,
        ppv_txns.Operating_Unit,
        ppv_txns.org_code Ship_To_Org,
        ppv_txns.Ship_From_Org,
        ppv_txns.period_name Period_Name,
        &segment_columns
        pov.vendor_name Supplier,
        he.full_name Buyer,
        ppv_txns.Item_Number,
        ppv_txns.Item_Description,
        ppv_txns.Item_Type,
        ppv_txns.Item_Status,
        ppv_txns.Make_Buy_Code,
&category_columns
        -- End revision for version 1.12
        ppv_txns.WIP_Job,
        ppv_txns.OSP_Resource,
        ph.segment1 PR_or_PO_Number,
        to_char(pl.line_num)  Line_Number,
        -- Revision for version 1.20
        pl.creation_date Line_Creation_Date,
        to_char(pr.release_num) PO_Release,
        rsh.receipt_num Receipt_Number,
        rsh.shipment_num Shipment_Number,
        -- Revision for version 1.20
        pll.creation_date Shipment_Creation_Date,
        ppv_txns.Accounting_Line_Type,
        ppv_txns.Transaction_Type,
        ppv_txns.Transaction_Id,
        ppv_txns.Transaction_Date,
        null Lot_Number,
        decode(msiv_osp.outside_operation_uom_type, 
                        'ASSEMBLY', msiv_osp.primary_uom_code,
                        'RESOURCE', ppv_txns.osp_unit_of_measure) UOM_Code,
        round((sign(ppv_txns.WIP_Received_Quantity) * rt.primary_quantity),3) Received_Quantity,
        -- Revision for version 1.23
        ppv_txns.WIP_Received_Quantity,
        nvl(ph.currency_code, ppv_txns.PO_Currency_Code) PO_Currency_Code,
        round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) PO_Unit_Price,
        ppv_txns.PO_Exchange_Rate,
        ppv_txns.Daily_Exchange_Rate,
        ppv_txns.GL_Currency_Code,
        round(ppv_txns.Converted_PO_Unit_Price,5) Converted_PO_Unit_Price,
        -- Revision for version 1.23
        -- Revision for version 1.24, rename Standard_Unit_Cost
        round(ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost,5) Standard_Purchase_Unit_Cost,
        -- Unit cost difference = PO price - Std Unit Cost
        round(ppv_txns.Converted_PO_Unit_Price,5) - round(ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost,5) Unit_Cost_Difference,
        round(ppv_txns.Converted_PO_Unit_Price * ppv_txns.WIP_Received_Quantity, 2) Total_Purchase_Amount,
        round((ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost) * ppv_txns.WIP_Received_Quantity, 2) Total_Standard_Amount,
        -- PPV_Amount = PO Amount - Std Amount
        round((ppv_txns.Converted_PO_Unit_Price - ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost) * ppv_txns.WIP_Received_Quantity,2) PPV_Amount,
        -- Calculate the percentage
        -- case
        --   when difference = 0 then 0
        --   when standard = 0 then 100%
        --   when PO unit price = 0 then -100%
        --   else PO - std / std
        case
           when round(ppv_txns.PPV_Rate_or_Amount,5) = 0 then 0
           when round(ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost,5) = 0 then 100
           when round(ppv_txns.Converted_PO_Unit_Price,5) = 0 then -100
           else round((ppv_txns.Converted_PO_Unit_Price - ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost) / (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost),5) * sign(ppv_txns.WIP_Received_Quantity) * 100
        end Percent_Difference,
        -- End revision for version 1.23
        -- Revision for version 1.23, add PPV Cost Amount and PPV FX Amount
        -- PPV Cost Amount = PPV Amount - PPV FX Amount
        -- PPV Amount = PO Amount - Std Amount
        round((ppv_txns.Converted_PO_Unit_Price - ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost) * ppv_txns.WIP_Received_Quantity,2) -
        -- PPV FX Amount = (Daily FX Rate - PO FX Rate) X PO Amount in PO Currency
        round((ppv_txns.Daily_Exchange_Rate - ppv_txns.PO_Exchange_Rate) * ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate * ppv_txns.WIP_Received_Quantity,2) PPV_Cost_Amount,
        -- PPV FX Amount = (Daily FX Rate - PO FX Rate) X PO Amount in PO Currency
        round((ppv_txns.Daily_Exchange_Rate - ppv_txns.PO_Exchange_Rate) * ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate * ppv_txns.WIP_Received_Quantity,2) PPV_FX_Amount
        -- End revision for version 1.23
from    ppv_txns,
        rcv_transactions rt,
        rcv_shipment_headers rsh,
        po_headers_all ph,
        po_lines_all pl,
        po_line_locations_all pll,
        po_releases_all pr,
        po_distributions_all pod,
        mtl_system_items_vl msiv_osp,
        po_vendors pov,
        hr_employees he,
        gl_code_combinations gcc
-- ========================================================
-- PPV transaction and receiving joins
-- ========================================================
where   ppv_txns.PPV_Type               = 'WIP_OSP'
and     rt.transaction_id               = ppv_txns.rcv_transaction_id
-- ========================================================
-- Purchase Order and OSP Item Joins
-- ========================================================
and     pod.po_distribution_id          = rt.po_distribution_id
and     rsh.shipment_header_id          = rt.shipment_header_id
and     ph.po_header_id                 = pl.po_header_id
and     pod.destination_type_code       = 'SHOP FLOOR'
and     pod.line_location_id            = pll.line_location_id
and     pl.po_line_id                   = pll.po_line_id
and     pll.po_release_id               = pr.po_release_id (+)
and     pl.item_id                      = msiv_osp.inventory_item_id
and     rt.organization_id              = msiv_osp.organization_id
-- Revision for version 1.18, performance improvements
-- and     wt.po_header_id                 = ph.po_header_id
-- and     wt.po_line_id                   = pl.po_line_id
-- End revision for version 1.18
and     pov.vendor_id                   = ph.vendor_id
and     ph.agent_id                     = he.employee_id
and     gcc.code_combination_id (+)     = ppv_txns.code_combination_id
union all
-- =============================================================
-- Section III
-- Get the PPV from inventory transactions from the intransit
-- shipment transactions and direct shipment transactions using 
-- internal requisitions
-- =============================================================
select  ppv_txns.Ledger,
        ppv_txns.Operating_Unit,
        ppv_txns.org_code Ship_To_Org,
        ppv_txns.Ship_From_Org,
        ppv_txns.period_name Period_Name,
        &segment_columns
        '' Supplier,
        fu.user_name Buyer,
        ppv_txns.Item_Number,
        ppv_txns.Item_Description,
        ppv_txns.Item_Type,
        ppv_txns.Item_Status,
        ppv_txns.Make_Buy_Code,
&category_columns
        -- Revision for version 1.9
        '' WIP_Job,
        '' OSP_Resource,
        -- End change for version 1.9
        (select prh.segment1
         from   po_requisition_headers_all prh
         where  prh.requisition_header_id = ppv_txns.transaction_source_id) PR_or_PO_Number,
        -- Revision for version 1.23
        (select to_char(prl.line_num)
         from   po_requisition_lines_all prl, rcv_transactions rt
         where  rt.transaction_id          = ppv_txns.rcv_transaction_id
         and    rt.requisition_line_id     = prl.requisition_line_id) Line_Number,
        -- Revision for version 1.20 and 1.23
        -- Shipment and line number not always available
        -- rsl.creation_date Line_Creation_Date,
        (select prl.creation_date
         from   po_requisition_lines_all prl, rcv_transactions rt
         where  rt.transaction_id          = ppv_txns.rcv_transaction_id
         and    rt.requisition_line_id     = prl.requisition_line_id
         union
         select rsl.creation_date
         from   rcv_shipment_lines rsl
         where  rsl.shipment_header_id (+) = rsh.shipment_header_id
         and    rsl.mmt_transaction_id (+) = nvl(ppv_txns.transfer_transaction_id, ppv_txns.transaction_id)
         and    rsl.requisition_line_id is null
        ) Line_Creation_Date,
        -- End revision for version 1.23
        '' PO_Release,
        -- Revision for version 1.14
        rsh.receipt_num Receipt_Number,
        -- End revision for version 1.14
        ppv_txns.Shipment_Number,
        -- Revision for version 1.20
        ppv_txns.Shipment_Creation_Date,
        ppv_txns.Accounting_Line_Type,
        ppv_txns.Transaction_Type,
        ppv_txns.Transaction_Id,
        ppv_txns.Transaction_Date,
        ppv_txns.Lot_Number,
        -- Revision for version 1.14
        ppv_txns.UOM_Code,
        ppv_txns.Received_Quantity,
        -- Revision for version 1.23
        ppv_txns.WIP_Received_Quantity,
        ppv_txns.PO_Currency_Code,
        round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) PO_Unit_Price,
        ppv_txns.PO_Exchange_Rate,
        -- Revision for version 1.23
        ppv_txns.Daily_Exchange_Rate,
        ppv_txns.GL_Currency_Code,
        round(ppv_txns.Converted_PO_Unit_Price,5) Converted_PO_Unit_Price,
        -- Revision for version 1.23
        -- Revision for version 1.24, rename Standard_Unit_Cost
        round(ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost,5) Standard_Purchase_Unit_Cost,
        -- Unit cost difference = PO price - Std Unit Cost
        round(ppv_txns.Converted_PO_Unit_Price - ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost,5) Unit_Cost_Difference,
        round(ppv_txns.Converted_PO_Unit_Price * ppv_txns.Received_Quantity,2) Total_Purchase_Amount,
        -- Revision for version 1.22, Std Unit Cost X Qty
        round((ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost) * ppv_txns.Received_Quantity,2) Total_Standard_Amount,
        -- PPV_Amount = PO Amount - Std Amount
        round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) * ppv_txns.Received_Quantity,2) PPV_Amount,
        -- Revision for version 1.23, calculate the percentage
        -- case
        --   when difference = 0 then 0
        --   when standard = 0 then 100%
        --   when PO unit price = 0 then -100%
        --   else PO - std / std
        case
           when round(ppv_txns.PPV_Rate_or_Amount,5) = 0 then 0
           when round((ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost),5) = 0 then 100
           when round(ppv_txns.Converted_PO_Unit_Price,5) = 0 then -100
           else round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) / (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost),5) * sign(ppv_txns.Received_Quantity) * 100
        end Percent_Difference,
        -- End revision for version 1.23
        -- Revision for version 1.23, add PPV Cost Amount and PPV FX Amount
        -- PPV Cost Amount = PPV Amount - PPV FX Amount
        -- PPV Amount = PO Amount - Std Amount
        round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) * ppv_txns.Received_Quantity,2) -
        -- PPV FX Amount = (Daily FX Rate - PO FX Rate) X PO Amount in PO Currency
        round((ppv_txns.Daily_Exchange_Rate - ppv_txns.PO_Exchange_Rate) * round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) * ppv_txns.Received_Quantity,2) PPV_Cost_Amount,
        -- PPV FX Amount = (Daily FX Rate - PO FX Rate) X PO Amount in PO Currency
        round((ppv_txns.Daily_Exchange_Rate - ppv_txns.PO_Exchange_Rate) * round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) * ppv_txns.Received_Quantity,2) PPV_FX_Amount
        -- End revision for version 1.23
from    ppv_txns,
        -- Fix for version 1.4
        -- rcv_transactions rt, -- causing PPV to double up
        rcv_shipment_headers rsh,
        -- Revision for version 1.23
        -- rcv_shipment_Lines rsl
        fnd_user fu,
        gl_code_combinations gcc
-- ========================================================
-- Receiving transaction joins
-- ========================================================
where   ppv_txns.PPV_Type in ('Direct Transfer','Internal Requisitions', 'Intransit')
-- Revision for version 1.14 and 1.23
-- Bad join, should be transfer_transaction_id but even this may be missing on direct xfers and inter-org xfers
-- and     mmt.transaction_id              = rsl.mmt_transaction_id -- commented out ver 1.14
-- Revision for version 1.23, rsl causing cross joining and missed transactions
-- and     rsh.shipment_header_id          = rsl.shipment_header_id
-- and     rsh.shipment_num                = mmt.shipment_number
and    rsh.shipment_num (+)             = ppv_txns.shipment_number
-- End revision for version 1.23
-- Fix for version 1.4, rcv_transactions has the same shipment number
-- for multiple transactions, was causing PPV to double up
-- and     rt.shipment_line_id             = rsl.shipment_line_id   -- commented out ver 1.4
-- and     rt.transaction_type             = 'DELIVER'              -- commented out ver 1.4
-- End revision for version 1.4
and     fu.user_id                      = ppv_txns.created_by
and     gcc.code_combination_id (+)     = ppv_txns.code_combination_id
union all
-- =============================================================
-- Section IV
-- Get the PPV from inventory transactions from the internal
-- order and intransit shipments between organizations
-- =============================================================
select  ppv_txns.Ledger,
        ppv_txns.Operating_Unit,
        ppv_txns.org_code Ship_To_Org,
        ppv_txns.Ship_From_Org,
        ppv_txns.period_name Period_Name,
        &segment_columns
        haou_src.name Supplier,
        he.full_name Buyer,
        ppv_txns.Item_Number,
        ppv_txns.Item_Description,
        ppv_txns.Item_Type,
        ppv_txns.Item_Status,
        ppv_txns.Make_Buy_Code,
&category_columns
        -- Fix for version 1.9
        '' WIP_Job,
        '' OSP_Resource,
        -- End fix for version 1.9
        decode (iso.order_source_id, 10, iso.orig_sys_document_ref, '') PR_or_PO_Number,
        decode (iso.order_source_id, 10, iso_line.orig_sys_line_ref, '')  Line_Number,
        -- Revision for version 1.20
        prl.creation_date Line_Creation_Date,
        '' PO_Release,
        '' Receipt_Number,
        ppv_txns.shipment_number Shipment_Number,
        -- Revision for version 1.20
        ppv_txns.Shipment_Creation_Date,
        ppv_txns.Accounting_Line_Type,
        ppv_txns.Transaction_Type,
        ppv_txns.Transaction_Id,
        ppv_txns.Transaction_Date,
        ppv_txns.Lot_Number,
        -- Revision for version 1.14
        ppv_txns.UOM_Code,
        ppv_txns.Received_Quantity,
        -- Revision for version 1.23
        ppv_txns.WIP_Received_Quantity,
        ppv_txns.PO_Currency_Code,
        round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) PO_Unit_Price,
        ppv_txns.PO_Exchange_Rate,
        -- Revision for version 1.23
        ppv_txns.Daily_Exchange_Rate,
        ppv_txns.GL_Currency_Code,
        round(ppv_txns.Converted_PO_Unit_Price,5) Converted_PO_Unit_Price,
        -- Revision for version 1.23
        -- Revision for version 1.24, rename Standard_Unit_Cost
        round(ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost,5) Standard_Purchase_Unit_Cost,
        -- Unit cost difference = PO price - Std Unit Cost
        round(ppv_txns.Converted_PO_Unit_Price - ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost,5) Unit_Cost_Difference,
        round(ppv_txns.Converted_PO_Unit_Price * ppv_txns.Received_Quantity,2) Total_Purchase_Amount,
        -- Revision for version 1.22, Std Unit Cost X Qty
        round((ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost) * ppv_txns.Received_Quantity,2) Total_Standard_Amount,
        -- PPV_Amount = PO Amount - Std Amount
        round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) * ppv_txns.Received_Quantity,2) PPV_Amount,
        -- Revision for version 1.23, calculate the percentage
        -- case
        --   when difference = 0 then 0
        --   when standard = 0 then 100%
        --   when PO unit price = 0 then -100%
        --   else PO - std / std
        case
           when round(ppv_txns.PPV_Rate_or_Amount,5) = 0 then 0
           when round((ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost),5) = 0 then 100
           when round(ppv_txns.Converted_PO_Unit_Price,5) = 0 then -100
           else round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) / (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost),5) * sign(ppv_txns.Received_Quantity) * 100
        end Percent_Difference,
        -- End revision for version 1.23
        -- Revision for version 1.23, add PPV Cost Amount and PPV FX Amount
        -- PPV Cost Amount = PPV Amount - PPV FX Amount
        -- PPV Amount = PO Amount - Std Amount
        round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) * ppv_txns.Received_Quantity,2) -
        -- PPV FX Amount = (Daily FX Rate - PO FX Rate) X PO Amount in PO Currency
        round((ppv_txns.Daily_Exchange_Rate - ppv_txns.PO_Exchange_Rate) * round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) * ppv_txns.Received_Quantity,2) PPV_Cost_Amount,
        -- PPV FX Amount = (Daily FX Rate - PO FX Rate) X PO Amount in PO Currency
        round((ppv_txns.Daily_Exchange_Rate - ppv_txns.PO_Exchange_Rate) * round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) * ppv_txns.Received_Quantity,2) PPV_FX_Amount
        -- End revision for version 1.23
from    ppv_txns,
        oe_order_headers_all iso, 
        oe_order_lines_all iso_line,  
        po_requisition_headers_all prh,   
        po_requisition_lines_all prl,
        hr_employees he,
        hr_organization_information hoi_src, -- source inv_organization information
        hr_all_organization_units_vl haou_src, -- source inv_organization_id
        gl_code_combinations gcc
-- ========================================================
-- Material Transaction, org and item joins
-- ========================================================
where   ppv_txns.PPV_Type               = 'Internal Orders'
and     prl.destination_organization_id = ppv_txns.ship_to_org_id -- transfer to organization_id
and     prl.item_id                     = ppv_txns.inventory_item_id
-- ========================================================
-- Internal Sales Order Joins
-- ========================================================
and     iso_line.line_category_code in ('ORDER')
and     iso_line.line_id                = ppv_txns.trx_source_line_id
and     iso_line.header_id              = iso.header_id
 -- Use this condition to limit this sql for internal requisitions
and     iso_line.order_source_id        = 10 -- internal requisitions
 -- ==============================================================
 -- Use these conditions to join to purchase reqs
 -- ==============================================================
-- Fix for version 1.8, this condition was preventing four Oct-2010
-- transactions from being reported, txn_ids 36014001 - 36014004
-- and     prh.type_lookup_code         = 'INTERNAL'
-- ===============================================================
-- Revision 1.16, for avoiding full table scan on oe_order_headers_all
--and     iso.source_document_id          = prh.requisition_header_id
and     prl.requisition_header_id       = prh.requisition_header_id
and     prl.requisition_line_id         = iso_line.source_document_line_id
and     prh.preparer_id                 = he.employee_id
-- ========================================================
-- Get the name of the source organization_id
-- ========================================================
and     hoi_src.org_information_context = 'Accounting Information'
and     hoi_src.organization_id         = ppv_txns.ship_from_org_id -- transfer from organization_id
and     hoi_src.organization_id         = haou_src.organization_id  -- this gets the organization name
and     gcc.code_combination_id (+)     = ppv_txns.code_combination_id
union all
-- =============================================================
-- Section V, Revision for version 1.17
-- Get the PPV from inventory transactions for the Transfer to
-- Regular transactions (consignment entries).
-- =============================================================
select  ppv_txns.Ledger,
        ppv_txns.Operating_Unit,
        ppv_txns.org_code Ship_To_Org,
        ppv_txns.Ship_From_Org,
        ppv_txns.period_name Period_Name,
        &segment_columns
        pov.vendor_name Supplier,
        fu.user_name Buyer,
        ppv_txns.Item_Number,
        ppv_txns.Item_Description,
        ppv_txns.Item_Type,
        ppv_txns.Item_Status,
        ppv_txns.Make_Buy_Code,
&category_columns
        -- mmt.move_transaction_id can be null when there is no release id
        (select we.wip_entity_name
         from   wip_entities we,
                wip_move_transactions wmt
         where  wmt.transaction_id      = ppv_txns.move_transaction_id
         and    we.wip_entity_id        = wmt.wip_entity_id) WIP_Job,
        '' OSP_Resource,
        ph.segment1 PR_or_PO_Number,
        to_char(pl.line_num)  Line_Number,
        -- Revision for version 1.20
        pl.creation_date Line_Creation_Date,
        -- Purchase Release can be missing when there is no move transaction
        (select to_char(pr.release_num)
         from    po_releases_all pr
         where  pr.po_header_id         = ph.po_header_id
         and    pr.release_num          = ppv_txns.source_line_id) PO_Release,
        '' Receipt_Number,
        ppv_txns.shipment_number Shipment_Number,
        -- Revision for version 1.20
        ppv_txns.Shipment_Creation_Date,
        ppv_txns.Accounting_Line_Type,
        ppv_txns.Transaction_Type,
        ppv_txns.Transaction_Id,
        ppv_txns.Transaction_Date,
        ppv_txns.Lot_Number,
        -- Revision for version 1.14
        ppv_txns.UOM_Code,
        ppv_txns.Received_Quantity,
        -- Revision for version 1.23
        ppv_txns.WIP_Received_Quantity,
        nvl(ph.currency_code, ppv_txns.PO_Currency_Code) PO_Currency_Code,
        round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) PO_Unit_Price,
        ppv_txns.PO_Exchange_Rate,
        -- Revision for version 1.23
        ppv_txns.Daily_Exchange_Rate,
        ppv_txns.GL_Currency_Code,
        round(ppv_txns.Converted_PO_Unit_Price,5) Converted_PO_Unit_Price,
        -- Revision for version 1.23
        -- Revision for version 1.24, rename Standard_Unit_Cost
        round(ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost,5) Standard_Purchase_Unit_Cost,
        -- Unit cost difference = PO price - Std Unit Cost
        round(ppv_txns.Converted_PO_Unit_Price - ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost,5) Unit_Cost_Difference,
        round(ppv_txns.Converted_PO_Unit_Price * ppv_txns.Received_Quantity,2) Total_Purchase_Amount,
        -- Revision for version 1.22, Std Unit Cost X Qty
        round((ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost) * ppv_txns.Received_Quantity,2) Total_Standard_Amount,
        -- PPV_Amount = PO Amount - Std Amount
        round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) * ppv_txns.Received_Quantity,2) PPV_Amount,
        -- Revision for version 1.23, calculate the percentage
        -- case
        --   when difference = 0 then 0
        --   when standard = 0 then 100%
        --   when PO unit price = 0 then -100%
        --   else PO - std / std
        case
           when round(ppv_txns.PPV_Rate_or_Amount,5) = 0 then 0
           when round((ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost),5) = 0 then 100
           when round(ppv_txns.Converted_PO_Unit_Price,5) = 0 then -100
           else round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) / (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost),5) * sign(ppv_txns.Received_Quantity) * 100
        end Percent_Difference,
        -- End revision for version 1.23
        -- Revision for version 1.23, add PPV Cost Amount and PPV FX Amount
        -- PPV Cost Amount = PPV Amount - PPV FX Amount
        -- PPV Amount = PO Amount - Std Amount
        round((ppv_txns.Converted_PO_Unit_Price - (ppv_txns.Standard_Unit_Cost - ppv_txns.MOH_Unit_cost)) * ppv_txns.Received_Quantity,2) -
        -- PPV FX Amount = (Daily FX Rate - PO FX Rate) X PO Amount in PO Currency
        round((ppv_txns.Daily_Exchange_Rate - ppv_txns.PO_Exchange_Rate) * round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) * ppv_txns.Received_Quantity,2) PPV_Cost_Amount,
        -- PPV FX Amount = (Daily FX Rate - PO FX Rate) X PO Amount in PO Currency
        round((ppv_txns.Daily_Exchange_Rate - ppv_txns.PO_Exchange_Rate) * round(ppv_txns.Converted_PO_Unit_Price / ppv_txns.PO_Exchange_Rate,5) * ppv_txns.Received_Quantity,2) PPV_FX_Amount
        -- End revision for version 1.23
from    ppv_txns,
        mtl_consumption_transactions mct,
        po_vendors pov,
        po_headers_all ph,
        po_lines_all pl,
        hr_employees he,
        fnd_user fu,
        gl_code_combinations gcc
-- ========================================================
-- Material Consumption (consignment) and Purchase Order Joins
-- ========================================================
where   ppv_txns.PPV_Type               = 'Transfer to Regular'
and     fu.user_id                      = ppv_txns.created_by
-- Consumption transaction joins
and     mct.transaction_id              = ppv_txns.transfer_transaction_id
-- Purchase Order joins
and     pl.po_line_id                   = mct.po_line_id
and     ph.po_header_id                 = pl.po_header_id
-- Revision for version 1.18
-- and     pl.item_id                      = msiv.inventory_item_id
and     pov.vendor_id                   = ph.vendor_id
and     ph.agent_id                     = he.employee_id
and     gcc.code_combination_id (+)     = ppv_txns.code_combination_id
-- Ledger, Operating Unit, Ship to Org, Period Name, Item_Number, WIP_Job, Resource, PO_Number, Line_Number, Release, Receipt_Number
order by 1,2,3,4,5,15,22,23,24,25,26,27