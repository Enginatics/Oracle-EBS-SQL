/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Receiving Expense Value (Period-End)
-- Description: Report to show receiving value for expense locations and expense destination types.  You may run this report for open or closed accounting periods.  If run for a prior period the report automatically rolls back the quantities and values to the prior period's period end date.  If run for a current period, the report shows the real-time quantities and values.  This report displays both the receiving valuation account as well as the offset (expense or CapEx) account.

Parameters:
Period Name:  the accounting period you wish to report (mandatory).
Category Sets 1 - 3:  any item category you wish (optional).
Organization Code:  specific inventory organization to report (optional)
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

/* +=============================================================================+
-- |  Copyright 2010-25 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com) 
-- | 
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0  5 Jul 2010 Douglas Volz   Created initial Report for Celgene
-- |                                     based on XXX_IPV_RCV_VALUE_REPT.sql
-- |      1.1  5 Jul 2010 Douglas Volz   Added requisition, requestor and requestor
-- |                                     email address
-- |      1.2 15 Sep 2010 Douglas Volz   Added unit of measure, supplier, buyer columns.
-- |                                     Fix for parameter changes for BO Freehand SQL requirements,
-- |                                     changing the code to accept null or % or value GL Ledger names.
-- |      1.3 27 Sep 2010 Douglas Volz   Changed the report sort to include the offset accounts
-- |      1.4 04 Jan 2012 Douglas Volz   Fixed quantities to sum up rcv_receiving_sub_ledger,
-- |                                     as the view rcv_receiving_value_view and
-- |                                         rcv_transactions does not split out quantities by
-- |                                     po distributions.  For expenses you can have multiple expense
-- |                                     accounts or distributions for each scheduled receipt
-- |                                     in po_line_locations
-- |      1.5 08 Feb 2012 Douglas Volz   Rewrite code to fix quantity and amounts, mtl_supply does
-- |                                     not handle split rcv_transations, split by multiple 
-- |                                     po_distribution_ids.  It only stores one of the PODs for
-- |                                     expenses.
-- |      1.6 06 Jan 2020 Douglas Volz   Added item categories, Org Code and Operating Unit parameters.
-- |      1.7 29 May 2025 Douglas Volz   Removed tabs, added Blitz G/L and OU security.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-receiving-expense-value-period-end/
-- Library Link: https://www.enginatics.com/reports/cac-receiving-expense-value-period-end/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
-- ==================================================================
-- This statement works using inline table queries with a union all
-- on the inside inline queries wrapped by an "outside" inline query
-- in order to produce a single row per item.
-- ==================================================================
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        haou.name Organization_Name,
        oap.period_name Period_Name,
        gcc1.concatenated_segments Receiving_Account,
        gcc2.concatenated_segments Offset_Account,
        &segment_columns
        pov.vendor_name Supplier,
        he.full_name Buyer,
        msiv.concatenated_segments Item_Number,
        nvl(msiv.description,net_rcv.item_description) Item_Description,
&category_columns
        pl.displayed_field Destination_Type,
        net_rcv.po_number PO_Number,
        net_rcv.po_line_num PO_Line,
        net_rcv.release_num PO_Release,
        pp.name Project_Number,
        (select max(prh.segment1)
         from   po_requisition_headers_all prh,
                po_requisition_lines_all prl
         where  prh.requisition_header_id = prl.requisition_header_id
         and    prl.line_location_id      = net_rcv.po_line_location_id) Requisition_Number,
        (select max(he.full_name)
         from   po_requisition_headers_all prh,
                po_requisition_lines_all prl,
                hr_employees he
         where  prh.requisition_header_id = prl.requisition_header_id
         and    prl.line_location_id      = net_rcv.po_line_location_id
         and    prh.preparer_id           = he.employee_id) Requestor,
        (select max(he.email_address)
         from   po_requisition_headers_all prh,
                po_requisition_lines_all prl,
                hr_employees he
         where  prh.requisition_header_id = prl.requisition_header_id
         and    prl.line_location_id      = net_rcv.po_line_location_id
         and    prh.preparer_id           = he.employee_id) Requestor_Email,
        net_rcv.receipt_num Receipt_Number,
        net_rcv.transaction_date Receipt_Date,
        case 
         when (sysdate - net_rcv.transaction_date) < 31  then '30 days'
         when (sysdate - net_rcv.transaction_date) < 61  then '60 days'
         when (sysdate - net_rcv.transaction_date) < 91  then '90 days'
         when (sysdate - net_rcv.transaction_date) < 121 then '120 days'
         when (sysdate - net_rcv.transaction_date) < 151 then '150 days'
         when (sysdate - net_rcv.transaction_date) < 181 then '180 days'
         else 'Over 180 days'
        end Aging_Date,
-- ==========================================================
-- Select the onhand quantities and values
-- from the Part 3 condensing to one row per item and org
-- ==========================================================
        net_rcv.unit_of_measure Transaction_UOM,
        sum(net_rcv.quantity) Onhand_Quantity,
        gl.currency_code Currency_Code,
        sum(net_rcv.amount) Onhand_Value
from    mtl_parameters mp,
        mtl_system_items_vl msiv,
        rcv_parameters rp,
        po_vendors pov,
        hr_employees he,
        pa_projects_all pp,
        org_acct_periods oap,
        po_lookup_codes pl,
        hr_organization_information hoi,
        hr_all_organization_units haou,  -- inv_organization_id
        hr_all_organization_units haou2, -- operating unit
        gl_code_combinations_kfv gcc1,
        gl_code_combinations_kfv gcc2,
        gl_ledgers gl,
        -- ==================================
        -- Get receiving quantities and value
        -- ==================================
        -- ================================================
        -- part 3 
        -- Condense the Union down to individual Org/Items
        -- ================================================
        (select all_rcv.organization_id         organization_id,
                all_rcv.inventory_item_id       inventory_item_id,
                all_rcv.destination_type_code   destination_type_code,
                all_rcv.item_description        item_description,
                all_rcv.po_number               po_number,
                all_rcv.po_line_num             po_line_num,
                all_rcv.vendor_id               vendor_id,
                all_rcv.agent_id                agent_id,
                all_rcv.po_header_id            po_header_id,
                all_rcv.po_line_id              po_line_id,
                all_rcv.po_line_location_id     po_line_location_id,
                all_rcv.release_num             release_num,
                all_rcv.project_id              project_id,
                all_rcv.receipt_num             receipt_num,
                all_rcv.charge_account_id       charge_account_id,
                min(trunc(all_rcv.transaction_date)) transaction_date,
                all_rcv.unit_of_measure         unit_of_measure,
                sum(nvl(all_rcv.quantity,0))    quantity,
                sum(nvl(all_rcv.amount,0))      amount
         from   (
                 -- ===================================
                     -- =============================================================
                     -- part 2
                     -- get the onhand receiving quantities for Expense destinations
                     -- =============================================================
                 select 'Onhand Section', -- section
                        rrvv.organization_id organization_id,
                        rrvv.inventory_item_id inventory_item_id,
                        rrvv.item_description item_description,
                        rrvv.destination_type_code destination_type_code,
                        rrvv.po_number po_number,
                        rrvv.po_line_num po_line_num,
                        rrvv.vendor_id vendor_id,
                        rrvv.agent_id agent_id,
                        rrvv.po_header_id po_header_id,
                        rrvv.po_line_id po_line_id,
                        rrvv.po_line_location_id po_line_location_id,
                        rrvv.release_num release_num,
                        rrvv.project_id project_id,
                        rrvv.po_distribution_id,
                        rrvv.receipt_num receipt_num,
                        rrvv.transaction_date transaction_date,
                        rrvv.charge_account_id charge_account_id,
                        rrvv.unit_of_measure,
                        rrvv.source_document_code,
                        rrvv.deliver_to_location_id,
                        rrvv.source_document,
                        rrvv.document_line_num,
                        rrvv.actual_price,
                        sum(rrvv.primary_quantity) quantity,
                        sum(round(rrvv.amount,2)) amount,
                        rrvv.shipment_num shipment_num,
                        rrvv.rcv_transaction_id rcv_transaction_id
                 from   (select rs.to_organization_id organization_id,
                                rs.item_id inventory_item_id,
                                pl.item_description item_description, 
                                rs.destination_type_code destination_type_code,
                                ph.segment1 po_number,
                                pl.line_num po_line_num,
                                ph.vendor_id vendor_id, 
                                ph.agent_id agent_id,
                                rs.po_header_id po_header_id,
                                rs.po_line_id po_line_id,
                                rs.po_line_location_id po_line_location_id,
                                pr.release_num release_num,
                                pd.project_id project_id,
                                pd.po_distribution_id po_distribution_id,
                                 rsh.receipt_num receipt_num, 
                                rt_receive.transaction_date transaction_date,
                                pd.code_combination_id charge_account_id,
                                rs.unit_of_measure unit_of_measure, 
                                rsl.source_document_code source_document_code, 
                                decode(rsl.source_document_code, 'INV', rsl.deliver_to_location_id, 
                                                                 'PO', pd.deliver_to_location_id,
                                                                 'REQ', prl.deliver_to_location_id) deliver_to_location_id, 
                                decode(rsl.source_document_code, 'INV', rsh.shipment_num, 
                                                                 'PO', ph.segment1, 
                                                                 'REQ', prh.segment1) source_document, 
                                decode(rsl.source_document_code, 'INV', rsl.line_num, 
                                                                 'PO', pl.line_num,
                                                                 'REQ', prl.line_num) document_line_num, 
                                decode(rsl.source_document_code, 'INV', 
                                                (rsl.shipment_unit_price * nvl(ph.rate,1)) * (rt_receive.source_doc_quantity/rt_receive.primary_quantity), 
                                                                 'PO', 
                                                (pll.price_override *nvl(ph.rate,1)) * (rt_receive.source_doc_quantity/rt_receive.primary_quantity),
                                                                 'REQ', prl.unit_price * (rt_receive.source_doc_quantity / rt_receive.primary_quantity)) actual_price, 
                                sum(rs.to_org_primary_quantity) primary_quantity,
                                -- Revision for version 1.7, need to get the pll.price_override amount
                                -- as the Oracle Receiving Value Report uses the latest PO price for current amounts.
                                -- decode(rsl.source_document_code, 'INV', 
                                --                 (rsl.shipment_unit_price * nvl(ph.rate,1)) * (rt.source_doc_quantity/rt.primary_quantity), 
                                --                                  'PO', 
                                --                 (pll.price_override *nvl(ph.rate,1)) * (rt.source_doc_quantity/rt.primary_quantity),
                                --                                  'REQ', prl.unit_price * (rt.source_doc_quantity / rt.primary_quantity)) *
                                --        sum(rs.to_org_primary_quantity) amount,
                                -- Quantity X Price
                                round(sum(rs.to_org_primary_quantity) *
                                    round(sum(decode(rae.currency_conversion_rate,
                                                         null, case when nvl2(rt_correct.po_unit_price,rt_correct.po_unit_price,nvl(rt_deliver.po_unit_price,0))<>nvl(rae.unit_price,0) then nvl(pll.price_override,nvl(rae.unit_price,0)) else nvl(rae.unit_price,0) end,
                                                         case when nvl2(rt_correct.po_unit_price,rt_correct.po_unit_price,nvl(rt_deliver.po_unit_price,0))<>nvl(rae.unit_price,0) then nvl(pll.price_override,nvl(rae.unit_price,0)) else nvl(rae.unit_price,0) end * rae.currency_conversion_rate
                                                    ) * (rae.source_doc_quantity/rae.primary_quantity) * rae.primary_quantity
                                             )        / sum(rae.primary_quantity)
                                       ,8)
                                   ,2) amount,
                                -- End revision for version 1.7
                                rsh.shipment_num shipment_num, 
                                rs.rcv_transaction_id rcv_transaction_id
                         from   mtl_supply rs,
                                rcv_shipment_headers rsh, 
                                rcv_shipment_lines rsl, 
                                po_headers_all ph, 
                                po_lines_all pl, 
                                po_line_locations_all pll, 
                                po_distributions_all pd, 
                                po_requisition_headers_all prh, 
                                po_requisition_lines_all prl, 
                                --Revision for version 1.40
                                rcv_transactions rt_receive,
                                (select x.*
                                 from   (select rt.transaction_id parent_transaction_id,
                                                rt.organization_id,
                                         connect_by_root rt.transaction_id child_transaction_id,
                                         connect_by_isleaf
                                         from   rcv_transactions rt
                                         connect by prior rt.parent_transaction_id=rt.transaction_id
                                         start with rt.transaction_id in
                                                (select ms.rcv_transaction_id
                                                 from   mtl_supply ms
                                                 where  ms.supply_type_code       = 'RECEIVING'
                                                 -- Only expense receipts
                                                 and    ms.destination_type_code  = 'EXPENSE'
                                                 and    5=5                       -- p_org_code
                                                )
                                         -- Transfer of ownership consigned entries do not hit receiving accounts
                                         and    nvl(rt.consigned_flag,'N')        = 'N'
                                         and    4=4                               -- p_org_code
                                        ) x
                                 where  x.connect_by_isleaf=1
                                ) rt,
                                po_system_parameters_all psp,
                                rcv_accounting_events rae,
                                rcv_transactions rt_deliver,
                                rcv_transactions rt_correct,
                                --End Revision for version 1.40
                                po_releases_all pr 
                         where  rsh.shipment_header_id        = rs.shipment_header_id
                         and    rsl.shipment_line_id          = rs.shipment_line_id
                         and    ph.po_header_id (+)           = rs.po_header_id
                         and    pl.po_line_id (+)             = rs.po_line_id
                         and    pll.line_location_id (+)      = rs.po_line_location_id
                         and    pd.po_distribution_id (+)     = rs.po_distribution_id
                         and    prh.requisition_header_id (+) = rs.req_header_id
                         and    prl.requisition_line_id (+)   = rs.req_line_id
                         and    pr.po_release_id (+)          = rs.po_release_id
                         and    rs.rcv_transaction_id         = rt_receive.transaction_id
                         and    rs.destination_type_code      = 'EXPENSE'
                         and    pd.destination_type_code      = 'EXPENSE'
                         and    rs.supply_type_code           = 'RECEIVING'
                         --Revision for version 1.7
                         and    rs.rcv_transaction_id         = rt.child_transaction_id
                         and    rt.parent_transaction_id      = rae.rcv_transaction_id
                         and    rt_deliver.parent_transaction_id(+) = rs.rcv_transaction_id 
                         and    rt_deliver.transaction_type(+) = 'DELIVER'
                         and    rt_correct.parent_transaction_id(+) = rt_deliver.transaction_id
                         and    rt_correct.transaction_type(+) = 'CORRECT'
                         and    rae.organization_id            = rt.organization_id
                         and    rs.to_organization_id          = rt.organization_id
                         and    psp.org_id                     = ph.org_id
                         -- Only have expense receipts if accrual expenses at time of receipt
                         and    psp.expense_accrual_code       = 'RECEIPT'
                         -- End revision for version 1.7
                         group by
                                rs.to_organization_id,
                                rs.item_id, 
                                pl.item_description,
                                rs.destination_type_code,
                                ph.segment1,
                                pl.line_num,
                                ph.vendor_id,
                                ph.agent_id,
                                rs.po_header_id,
                                rs.po_line_id,
                                rs.po_line_location_id,
                                pr.release_num,
                                pd.project_id,
                                pd.po_distribution_id,
                                  rsh.receipt_num, 
                                rt_receive.transaction_date,
                                pd.code_combination_id,
                                rs.unit_of_measure, 
                                rsh.shipment_num, 
                                rsl.source_document_code, 
                                decode(rsl.source_document_code, 'INV', rsl.deliver_to_location_id, 
                                                                 'PO', pd.deliver_to_location_id,
                                                                 'REQ', prl.deliver_to_location_id), 
                                decode(rsl.source_document_code, 'INV', rsh.shipment_num, 
                                                                 'PO', ph.segment1, 
                                                                 'REQ', prh.segment1), 
                                decode(rsl.source_document_code, 'INV', rsl.line_num, 
                                                                 'PO', pl.line_num,
                                                                 'REQ', prl.line_num), 
                                decode(rsl.source_document_code, 'INV', 
                                                (rsl.shipment_unit_price * nvl(ph.rate,1)) * (rt_receive.source_doc_quantity/rt_receive.primary_quantity), 
                                                                 'PO', 
                                                (pll.price_override *nvl(ph.rate,1)) * (rt_receive.source_doc_quantity/rt_receive.primary_quantity),
                                                                 'REQ', prl.unit_price * (rt_receive.source_doc_quantity / rt_receive.primary_quantity)), 
                                rsh.shipment_num,  
                                rs.rcv_transaction_id) rrvv
                 group by
                        'Onhand Section', -- section
                        rrvv.organization_id,
                        rrvv.inventory_item_id,
                        rrvv.item_description,
                        rrvv.destination_type_code,
                        rrvv.po_number,
                        rrvv.po_line_num,
                        rrvv.vendor_id,
                        rrvv.agent_id,
                        rrvv.po_header_id,
                        rrvv.po_line_id,
                        rrvv.po_line_location_id,
                        rrvv.release_num,
                        rrvv.project_id,
                        rrvv.po_distribution_id,
                        rrvv.receipt_num,
                        rrvv.transaction_date,
                        rrvv.charge_account_id,
                        rrvv.unit_of_measure,
                        rrvv.source_document_code,
                        rrvv.deliver_to_location_id,
                        rrvv.source_document,
                        rrvv.document_line_num,
                        rrvv.actual_price,
                        rrvv.shipment_num, 
                        rrvv.rcv_transaction_id
                 union all
                      -- =============================================================            
                     -- Part 1 
                     -- Sum up all the post close rcv'g transactions by item and org
                     -- The SIGN of the quantities and amounts have been reversed
                     -- =============================================================            
                 select 'Section 1.1 Post Close' section,
                        rt.organization_id,
                        rsl.item_id inventory_item_id, 
                        pl.item_description item_description,
                        pd.destination_type_code destination_type_code,
                        ph.segment1 po_number,
                        pl.line_num po_line_num,
                        ph.vendor_id vendor_id,               
                        ph.agent_id agent_id,
                        rt.po_header_id po_header_id,
                        rt.po_line_id po_line_id,
                        rt.po_line_location_id po_line_location_id,
                        pr.release_num release_num,
                        pd.project_id project_id,
                        pd.po_distribution_id po_distribution_id,        
                        rsh.receipt_num receipt_num,
                        rt.transaction_date transaction_date,
                        pd.code_combination_id charge_account_id,
                        rt.unit_of_measure,
                        rsl.source_document_code source_document_code, 
                        decode(rsl.source_document_code, 'INV', rsl.deliver_to_location_id, 
                                                         'PO', pd.deliver_to_location_id) deliver_to_location_id, 
                        decode(rsl.source_document_code, 'INV', rsh.shipment_num, 
                                                         'PO', ph.segment1) source_document, 
                        decode(rsl.source_document_code, 'INV', rsl.line_num, 
                                                          'PO', pl.line_num) document_line_num, 
                        decode(rsl.source_document_code, 'INV', 
                                (rsl.shipment_unit_price * nvl(ph.rate,1)) * (rt.source_doc_quantity/rt.primary_quantity), 
                                                         'PO', 
                                (pll.price_override *nvl(ph.rate,1)) * (rt.source_doc_quantity/rt.primary_quantity)) actual_price,
                        -- Revert back to version 1.3, rrsl.source_doc_quantity not accurate on CORRECT transaction types
                        -- invert the SIGN as we will subtract away these quantities, based
                        -- upon the SIGN of the net amount of the accounting entry
                        --sum(abs(nvl(rt.primary_quantity,0)) * decode(sign(nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0)), -1, 1, -1)) quantity,
                        --sum(round(-1*(nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0)),2)) amount,
                        abs(nvl(rt.primary_quantity,0)) * decode(sign(rrsl.amount), -1, 1, -1) quantity,
                        rrsl.amount * -1 amount,
                        rsh.shipment_num shipment_num, 
                        rt.transaction_id rcv_transaction_id
                 from   rcv_transactions rt,
                        po_headers_all ph,
                        po_lines_all pl,
                        po_line_locations_all pll,
                        rcv_shipment_headers rsh,
                        rcv_shipment_lines rsl,
                        po_releases_all pr,
                        po_distributions_all pd,
                        rcv_parameters rp,
                        po_system_parameters_all psp,
                        org_acct_periods oap,
                        -- ==========================================================================
                        -- mtl_supply does not store split expense receipts by multiple PO_DISTRIBUTION_IDs
                        -- and will only store one of the PO distributions for a given receipt or receiving txn id.
                        -- You can only see the split PO distributions in rcv_receiving_sub_ledger since
                        -- rcv_transactions, rcv_shipment_lines has a null po_distribution_id, but rcv_receiving_sub_ledger
                        -- may have multiple lines for each rcv_transaction_id.  And since we are trying to 
                        -- recreate a prior state in mtl_supply, we have to emulate this, and subtract  
                        -- the rcv_transaction amounts and quantities by the same po_distribution_id.  The
                        -- assumption is that mtl_supply will have the max(po_distribution_id) from rrsl.
                        -- ==========================================================================
                        (select max(to_number(rrsl.reference3)) po_distribution_id,
                                rrsl.rcv_transaction_id rcv_transaction_id,
                                rrsl.code_combination_id code_combination_id,
                                sum(round((nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0)),2)) amount
                         from   rcv_receiving_sub_ledger rrsl,
                                rcv_transactions rt,
                                org_acct_periods oap
                         where  rrsl.rcv_transaction_id       = rt.transaction_id
                         and    trunc(rt.transaction_date)    > oap.schedule_close_date
                         and    rt.organization_id            = oap.organization_id
                         and    3=3                           -- p_period_name
                         and    4=4                           -- p_org_code
                         and    rrsl.accounting_line_type     = 'Receiving Inspection'
                         group by 
                                rrsl.rcv_transaction_id,
                                rrsl.code_combination_id) rrsl        
                 where  rt.shipment_header_id        = rsh.shipment_header_id
                 and    rt.shipment_line_id          = rsl.shipment_line_id
                 and    rt.po_header_id              = ph.po_header_id
                 and    rt.po_line_id                = pl.po_line_id
                 and    rt.po_line_location_id       = pll.line_location_id
                 and    pd.line_location_id          = pll.line_location_id
                 and    pr.po_release_id (+)         = rsl.po_release_id  
                 and    rt.transaction_id            = rrsl.rcv_transaction_id
                 and    pd.po_distribution_id        = rrsl.po_distribution_id
                 and    rt.po_line_location_id       = pd.line_location_id 
                 and    oap.organization_id          = rt.organization_id
                 and    3=3                          -- p_period_name
                 -- The oap.schedule_close_date does not have a timestamp so we have to trunc to make the comparison
                 -- Don't use rrsl.accounting date, really slow, use rt.transaction_date instead
                 and    trunc(rt.transaction_date)   > oap.schedule_close_date
                 and    rp.receiving_account_id      = rrsl.code_combination_id
                 and    rp.organization_id           = rt.organization_id
                 and    pd.destination_type_code     = 'EXPENSE'
                 and    psp.org_id                   = ph.org_id
                 -- Only have expense receipts if accrual expenses at time of receipt
                 and    psp.expense_accrual_code     = 'RECEIPT'
                 group by
                        'Section 1.1 Post Close', -- section
                        rt.organization_id,
                        rsl.item_id,
                        pl.item_description,
                        pd.destination_type_code,
                        ph.segment1,
                        pl.line_num,
                        ph.vendor_id,               
                        ph.agent_id,
                        rt.po_header_id,
                        rt.po_line_id,
                        rt.po_line_location_id,
                        rsh.receipt_num,
                        pr.release_num,
                        pd.project_id,
                        pd.po_distribution_id,
                        rt.transaction_date,
                        pd.code_combination_id,
                        rt.unit_of_measure,
                        rsl.source_document_code, 
                        decode(rsl.source_document_code, 'INV', rsl.deliver_to_location_id, 
                                                         'PO', pd.deliver_to_location_id), 
                        decode(rsl.source_document_code, 'INV', rsh.shipment_num, 
                                                         'PO', ph.segment1), 
                        decode(rsl.source_document_code, 'INV', rsl.line_num, 
                                                         'PO', pl.line_num), 
                        decode(rsl.source_document_code, 'INV', 
                               (rsl.shipment_unit_price * nvl(ph.rate,1)) * (rt.source_doc_quantity/rt.primary_quantity), 
                                                         'PO', 
                               (pll.price_override *nvl(ph.rate,1)) * (rt.source_doc_quantity/rt.primary_quantity)), 
                        abs(nvl(rt.primary_quantity,0)) * decode(sign(rrsl.amount), -1, 1, -1),
                        rrsl.amount * -1,
                        rsh.shipment_num, 
                        rt.transaction_id
                 union all
                 -- ==========================================================
                 -- 1.7 Get the change in unit prices between the RECEIVE and
                 -- DELIVER transaction types.  When Retroactive Price adjust-
                 -- ments are not in use, the Oracle Receiving accounting 
                 -- entries in rrsl are not recording these differences
                 -- and as a result, the sum of the receiving accounting
                 -- entries do not agree with the perpetual receiving values
                 -- on the Oracle Receiving Value Report.  The Oracle report
                 -- is in effect, revaluing the onhand receiving quantities
                 -- without a rrsl revaluation entry, leading to a cumulative
                 -- accounting vs. perpetual receiving value out-of-balance.
                 -- Especially as the Oracle Receiving Value Report assumes
                 -- both the RECEIVE and DELIVER were at the latest unit price
                 -- per the DELIVER transaction.  
                 -- ==========================================================
                 select 'Section 1.2 Post Close' section,
                        rae.organization_id,
                        rae.inventory_item_id inventory_item_id,
                        pl.item_description item_description,
                        pd.destination_type_code destination_type_code,
                        ph.segment1 po_number,
                        pl.line_num po_line_num,
                        ph.vendor_id vendor_id,               
                        ph.agent_id agent_id,
                        rae.po_header_id po_header_id,
                        rae.po_line_id po_line_id,
                        rae.po_line_location_id po_line_location_id,
                        pr.release_num release_num,
                        pd.project_id project_id,
                        pd.po_distribution_id po_distribution_id,
                        rsh.receipt_num receipt_num,
                        rt.transaction_date transaction_date,
                        pd.code_combination_id charge_account_id,
                        rt.unit_of_measure,
                        rsl.source_document_code source_document_code, 
                        decode(rsl.source_document_code, 'INV', rsl.deliver_to_location_id, 
                                                         'PO', pd.deliver_to_location_id) deliver_to_location_id, 
                        decode(rsl.source_document_code, 'INV', rsh.shipment_num, 
                                                         'PO', ph.segment1) source_document, 
                        decode(rsl.source_document_code, 'INV', rsl.line_num, 
                                                          'PO', pl.line_num) document_line_num, 
                        decode(rsl.source_document_code, 'INV', 
                                (rsl.shipment_unit_price * nvl(ph.rate,1)) * (rt.source_doc_quantity/rt.primary_quantity), 
                                                         'PO', 
                                (pll.price_override *nvl(ph.rate,1)) * (rt.source_doc_quantity/rt.primary_quantity)) actual_price,
                        to_number(null) quantity,
                        -- =====================================================================
                        -- Calculate the adjustment amount by subtracting the DELIVER unit price
                        -- by the RECEIVE unit price times RECEIVE quantity.  Invert the SIGN
                        -- of the quantity as we will subtract away these amounts and convert
                        -- the price into the primary UOM -- (rae.source_doc_quantity/rae.primary_quantity)
                        -- Use rcv_accounting_events to get the quantity received by PO Distribution.
                        -- =====================================================================
                        -- Quantity X Price Difference = Adjustment Amount
                        -- Quantity
                        round(decode(rt.transaction_type,
                                        'RECEIVE', -1 * rt.primary_quantity,
                                        'RETURN TO VENDOR', 1 * rt.primary_quantity,
                                        'MATCH', -1 * rt.primary_quantity,
                                        'CORRECT',
                                                decode(parent_rt.transaction_type,
                                                        'UNORDERED', 0,
                                                        'RECEIVE', -1 * rt.primary_quantity,
                                                        'RETURN TO VENDOR', 1 * rt.primary_quantity,
                                                        0
                                                      ),
                                        0
                                    ) *
                                -- Unit Price Difference
                                ((decode(deliver_rt.currency_conversion_rate,
                                        null, nvl(deliver_rt.po_unit_price,0),
                                        nvl(deliver_rt.po_unit_price,0) * deliver_rt.currency_conversion_rate
                                       ) *
                                        -- Convert into the primary UOM
                                       (deliver_rt.source_doc_quantity/deliver_rt.primary_quantity)
                                ) -
                                (decode(rt.currency_conversion_rate,
                                        null, nvl(rt.po_unit_price,0),
                                        nvl(rt.po_unit_price,0) * rt.currency_conversion_rate
                                       ) *
                                        -- Convert into the primary UOM
                                        (rt.source_doc_quantity/rt.primary_quantity)
                                ))
                           ,2) amount,
                        rsh.shipment_num shipment_num,
                        rae.rcv_transaction_id
                 from   -- =====================================================================
                        -- Client has multiple PO distributions per Receipt Number for the same
                        -- PO Header, Line, Line Location and item number.
                        -- Need to use rcv_accounting_events to get the split quantities
                        -- =====================================================================
                        rcv_transactions rt,
                        rcv_transactions parent_rt,
                        rcv_transactions deliver_rt, -- get the child DELIVER entries
                        rcv_shipment_headers rsh,
                        rcv_shipment_lines rsl,
                        rcv_accounting_events rae,
                        rcv_receiving_sub_ledger rrsl,
                        rcv_parameters rp,
                        po_system_parameters_all psp,
                        po_headers_all ph,
                        po_lines_all pl,
                        po_line_locations_all pll,
                        po_releases_all pr,
                        po_distributions_all pd,
                        org_acct_periods oap
                 where  rt.transaction_id            = rae.rcv_transaction_id
                 and    rt.parent_transaction_id     = parent_rt.transaction_id (+)
                 and    rt.organization_id           = parent_rt.organization_id (+)
                 and    rt.transaction_id            = rrsl.rcv_transaction_id
                 and    rrsl.accounting_line_type in ('Clearing', 'Receiving Inspection')
                 and    rt.transaction_date         >= oap.schedule_close_date + 1
                 and    rrsl.transaction_date       >= oap.schedule_close_date + 1
                 and    pd.po_distribution_id        = rrsl.reference3
                 and    ph.po_header_id              = rae.po_header_id         
                 and    pr.po_release_id (+)         = rsl.po_release_id
                 and    pl.po_line_id                = rae.po_line_id
                 and    pll.line_location_id         = rae.po_line_location_id
                 and    pd.destination_type_code     = 'EXPENSE'
                 and    oap.organization_id          = rt.organization_id
                 and    rae.accounting_event_id      = rrsl.accounting_event_id
                 and    rt.shipment_header_id        = rsh.shipment_header_id
                 and    rt.shipment_line_id          = rsl.shipment_line_id
                 and    rt.shipment_header_id        = rsh.shipment_header_id
                 and    rt.shipment_line_id          = rsl.shipment_line_id
                 and    rt.transaction_type         <> 'DELIVER'  -- only want receipts, return to vendor and corrections
                 and    deliver_rt.transaction_type  = 'DELIVER'  -- get the deliver transaction for the price difference
                 and    deliver_rt.parent_transaction_id = rt.transaction_id
                 and    deliver_rt.po_unit_price    <> rt.po_unit_price
                 and    deliver_rt.transaction_date >= oap.schedule_close_date + 1
                 and    rp.organization_id           = rt.organization_id
                 -- Assume if Retroactive Price Adjustments in use, then Section 1.5 picks up these entries.
                 and    rp.retroprice_adj_account_id is null
                 and    psp.org_id                   = ph.org_id
                 -- Only have expense receipts if accrual expenses at time of receipt
                 and    psp.expense_accrual_code     = 'RECEIPT'
                 and    3=3                          -- p_period_name
                 and    4=4                          -- p_org_code
                 group by
                        'Section 1.2 Post Close', -- section
                        rae.rcv_transaction_id,
                        rae.organization_id,
                        rae.inventory_item_id,
                        pl.item_description,
                        pd.destination_type_code,
                        ph.segment1, -- po_number
                        pl.line_num,
                        ph.vendor_id,               
                        ph.agent_id,
                        rae.po_header_id,
                        rae.po_line_id,
                        rae.po_line_location_id,
                        pr.release_num,
                        pd.project_id,
                        pd.po_distribution_id,
                        rsh.receipt_num,
                        rt.transaction_date,
                        pd.code_combination_id, -- charge_account_id
                        rt.unit_of_measure,
                        rsl.source_document_code, 
                        decode(rsl.source_document_code, 'INV', rsl.deliver_to_location_id, 
                                                         'PO', pd.deliver_to_location_id), -- deliver_to_location_id
                        decode(rsl.source_document_code, 'INV', rsh.shipment_num, 
                                                         'PO', ph.segment1), -- source_document 
                        decode(rsl.source_document_code, 'INV', rsl.line_num, 
                                                          'PO', pl.line_num), -- document_line_num
                        decode(rsl.source_document_code, 'INV', 
                                (rsl.shipment_unit_price * nvl(ph.rate,1)) * (rt.source_doc_quantity/rt.primary_quantity), 
                                                         'PO', 
                                (pll.price_override *nvl(ph.rate,1)) * (rt.source_doc_quantity/rt.primary_quantity)), -- actual_price
                       to_number(null), -- quantity
                        -- =====================================================================
                        -- Calculate the adjustment amount by subtracting the DELIVER unit price
                        -- by the RECEIVE unit price times RECEIVE quantity.  Invert the SIGN
                        -- of the quantity as we will subtract away these amounts and convert
                        -- the price into the primary UOM -- (rae.source_doc_quantity/rae.primary_quantity)
                        -- Use rcv_accounting_events to get the quantity received by PO Distribution.
                        -- =====================================================================
                        -- Quantity X Price Difference = Adjustment Amount
                        -- Quantity
                        round(decode(rt.transaction_type,
                                        'RECEIVE', -1 * rt.primary_quantity,
                                        'RETURN TO VENDOR', 1 * rt.primary_quantity,
                                        'MATCH', -1 * rt.primary_quantity,
                                        'CORRECT',
                                                decode(parent_rt.transaction_type,
                                                        'UNORDERED', 0,
                                                        'RECEIVE', -1 * rt.primary_quantity,
                                                        'RETURN TO VENDOR', 1 * rt.primary_quantity,
                                                        0
                                                      ),
                                        0
                                    ) *
                                -- Unit Price Difference
                                ((decode(deliver_rt.currency_conversion_rate,
                                        null, nvl(deliver_rt.po_unit_price,0),
                                        nvl(deliver_rt.po_unit_price,0) * deliver_rt.currency_conversion_rate
                                       ) *
                                        -- Convert into the primary UOM
                                       (deliver_rt.source_doc_quantity/deliver_rt.primary_quantity)
                                ) -
                                (decode(rt.currency_conversion_rate,
                                        null, nvl(rt.po_unit_price,0),
                                        nvl(rt.po_unit_price,0) * rt.currency_conversion_rate
                                       ) *
                                        -- Convert into the primary UOM
                                        (rt.source_doc_quantity/rt.primary_quantity)
                                ))
                           ,2), -- amount
                        rsh.shipment_num, 
                        rt.transaction_id
                ) all_rcv
        group by all_rcv.organization_id,
                 all_rcv.inventory_item_id,
                 all_rcv.destination_type_code,
                 -- Fix for version 1.5
                 all_rcv.item_description,
                 all_rcv.po_number,
                 all_rcv.po_line_num,
                 all_rcv.vendor_id,
                 all_rcv.agent_id,
                 -- End fix for version 1.5
                 all_rcv.po_header_id,
                 all_rcv.po_line_id,
                 all_rcv.po_line_location_id,
                 all_rcv.release_num,
                 all_rcv.project_id,
                 all_rcv.receipt_num,
                 all_rcv.charge_account_id,
                 all_rcv.unit_of_measure
        ) net_rcv
        -- ===========================
        -- End of getting quantities
        -- ===========================
-- ===================================================================
-- Item master to quantity and item master to cost joins
-- ===================================================================
where  msiv.inventory_item_id  (+) = net_rcv.inventory_item_id  -- outer join as the items may be missing
and    msiv.organization_id    (+) = net_rcv.organization_id    -- outer join as the items may be missing
and    net_rcv.project_id          = pp.project_id (+)
and    mp.organization_id          = net_rcv.organization_id
and    mp.organization_id          = oap.organization_id
and    3=3                         -- p_period_name
-- ===================================================================
-- PO Header joins
-- ===================================================================
-- Fix for version 1.5
-- and    ph.po_header_id               = net_rcv.po_header_id
-- and    pl.po_line_id                 = net_rcv.po_line_id
-- and    pov.vendor_id                 = ph.vendor_id
-- and    ph.agent_id                   = he.employee_id
and    pov.vendor_id               = net_rcv.vendor_id
and    he.employee_id              = net_rcv.agent_id
-- End fix for version 1.5
-- ===================================================================
-- Receiving accrual account to account number join and org joins
-- ===================================================================
and    rp.receiving_account_id     = gcc1.code_combination_id (+) -- receiving value account
and    rp.organization_id          = mp.organization_id
and    net_rcv.charge_account_id   = gcc2.code_combination_id (+) -- offset charge account for expenses
-- ===================================================================
-- -- joins for the lookup codes
-- ===================================================================
and    pl.lookup_type              = 'DESTINATION TYPE'
and    pl.lookup_code              = net_rcv.destination_type_code
-- ===================================================================
-- using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and    hoi.org_information_context = 'Accounting Information'
and    hoi.organization_id         = mp.organization_id
and    hoi.organization_id         = haou.organization_id             -- this gets the organization name
-- avoid selecting disabled inventory organizations
and    sysdate                    <  nvl(haou.date_to, sysdate +1)
and    haou2.organization_id       = to_number(hoi.org_information3)  -- this gets the operating unit id
and    gl.ledger_id                = to_number(hoi.org_information1)  -- get the ledger_id
and    mp.organization_code in (select oav.organization_code from org_access_view oav where  oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) 
and    1=1                         -- p_operating_unit, p_ledger
and    2=2                         -- p_org_code
-- Revision for Operating Unit and Ledger Controls and Parameters
and    (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
and    (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
group by
        nvl(gl.short_name, gl.name),
        haou2.name,
        mp.organization_code,
        haou.name,
        oap.period_name,
        gcc1.concatenated_segments, -- Receiving_Account
        gcc2.concatenated_segments, -- Offset_Account
        &segment_columns_grp
        pov.vendor_name,
        he.full_name,
        msiv.concatenated_segments,
        nvl(msiv.description,net_rcv.item_description),
        -- For category_columns
        -- Added for inline selects
        msiv.inventory_item_id,
        msiv.organization_id,
        -- End revision for version 1.6
        pl.displayed_field,
        net_rcv.po_number,
        net_rcv.po_line_num,
        net_rcv.release_num,
        pp.name,
        net_rcv.receipt_num,
        net_rcv.transaction_date,
        msiv.primary_uom_code,
        gl.currency_code,
        net_rcv.unit_of_measure,
        -- added for inline column select
        net_rcv.po_line_location_id
having sum(nvl(net_rcv.amount,0)) <> 0
-- Order by Ledger, Operating Unit, Org Code, Valuation Accounts, Offset Accounts, PO Number, PO Line, PO Release, Receipt Number 
order by
        nvl(gl.short_name, gl.name), -- Ledger
        haou2.name, --  Operating_Unit
        mp.organization_code,
        oap.period_name,
        gcc1.concatenated_segments, -- Receiving_Account
        gcc2.concatenated_segments, -- Offset_Account
        pov.vendor_name, --   Supplier,
        he.full_name, --   Buyer,
        msiv.concatenated_segments, --   Item_Number,
        net_rcv.po_number,
        net_rcv.po_line_num,
        net_rcv.release_num,
        pp.name,
        net_rcv.receipt_num