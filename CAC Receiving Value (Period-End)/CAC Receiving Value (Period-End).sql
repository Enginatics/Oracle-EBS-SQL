/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC Receiving Value (Period-End)
-- Description: Report to show receiving value for all locations, as of the end of an accounting period.  You may run this report for open or closed accounting periods.  With parameters to display or not display WIP outside processing information (WIP job, status, close date and OSP resource code).  If run for a prior period the report automatically rolls back the quantities and values to the prior period's period end date.  In addition, for any receipt with an item number, this report displays Inventory, Shop Floor (Outside Processing) and Expense destination types.

Note:  The Adjustment Amount column show differences between the PO unit price for the Receipt and Deliver transactions, which currently is not included in the receiving accounting entries. 

Reconciliation Notes to Oracle Reports:
The Oracle All Inventory Values Report does not display Shop Floor (Outside Processing) or Expense destination types.  
If the PO line is closed, the Oracle Receiving Value Report does not display Expense destination types, even if the receipt is still in receiving and has not been delivered.

Parameters:
Period Name:  the accounting period you wish to report (mandatory).
Show WIP Outside Processing:  display WIP job details for outside processing, enter Yes or No (mandatory).
Category Set 1:  any item category you wish (optional).
Category Set 2:  any item category you wish (optional).
Item Number:  specific item you wish to report (optional)
Organization Code:  specific inventory organization to report (optional)
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)
Product Line Accounting:  use this parameter to tell the report if you have set up product line accounting information in your item master accounts.  Enter Yes or No.
Product Line Segment:  use this parameter to tell the report which segment to use to find the product line information.  If the Product Line Accounting parameter is set to No this parameter is grayed out and not required.
Item Master Account Type:  use this parameter to determine if you store your product line information in your item master Expense, Cost of Sales or Sales Accounts.  If the Product Line Accounting parameter is set to No this parameter is grayed out and not required.

/* +=============================================================================+
-- |  Copyright 2009 - 2025 Douglas Volz Consulting, Inc. and Enginatics GmbH
-- |  All rights reserved. 
-- |  Version Modified on Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |     1.0  25 Nov 2009 Douglas Volz   Created initial Report for client
-- |                                     based on xxx_inv_value.sql
-- |     1.36 10 Aug 2022 Douglas Volz   Performance improvements for main query.  Allow expense
-- |                                     receipts with items, add PO line status column.
-- |     1.37 12 Aug 2022 Douglas Volz   Add parameter to Show WIP OSP columns and remove extra
-- |                                     join to the item master table.
-- |     1.38 16 Aug 2022 Douglas Volz   Fixes for quantities for Correction transactions and
-- |                                     for when the PO unit price is zero.
-- |     1.39 02 Jun 2025 Douglas Volz   Removed tabs.
-- |     1.40 05 Jun 2025 Douglas Volz   Added section 1.6 for PO unit price differences between
-- |                 Piyush Khandelwal   the PO Receipt and the PO Deliver transactions.  Put
-- |                                     this into an "Adjustment Amount" column, as this is
-- |                                     included in the Oracle Receiving Value Report but is
-- |                                     not recorded on any Receiving Accounting entry.
-- |                                     Also added in inventory org access, XXEN G/L and OU security profiles.
-- +=============================================================================+*/
-- Excel Examle Output: https://www.enginatics.com/example/cac-receiving-value-period-end/
-- Library Link: https://www.enginatics.com/reports/cac-receiving-value-period-end/
-- Run Report: https://demo.enginatics.com/

select  nvl(gl.short_name, gl.name) Ledger,
        haou2.name Operating_Unit,
        mp.organization_code Org_Code,
        oap.period_name Period_Name,
        &column_segments
        -- Revision for version 1.29
        pov.vendor_name Supplier,
         hr.full_name Buyer,
        -- End revision for version 1.29
        rp_items.concatenated_segments Item_Number,
        rp_items.description Item_Description,
        fcl.meaning Item_Type,
        -- Revision for version 1.33
        misv.inventory_item_status_code_tl Item_Status,
        ml.meaning Make_Buy_Code,
        -- revision for version 1.27
        -- Not all items have category values
        -- mc.segment1 Prod_Line,
&category_columns
        pl1.displayed_field Destination_Type,
        -- Revision for version 1.13
        poh.segment1 PO_Number,
        -- Revision for version 1.29
        pol.line_num PO_Line,
        -- Revision for version 1.36
        nvl(pl4.displayed_field,nvl(pl3.displayed_field, pl2.displayed_field))  PO_Line_Status,
        pr.release_num PO_Release,
        pp.segment1 Project_Number,
        pp.name Project_Name,
        (select max(prh.segment1)
         from   po_requisition_headers_all prh,
                po_requisition_lines_all prl
         where  prh.requisition_header_id = prl.requisition_header_id
         and    prl.line_location_id      = net_rcv.po_line_location_id) Requisition_Number,
        (select max(hr.full_name)
         from   po_requisition_headers_all prh,
                po_requisition_lines_all prl,
                hr_employees hr
         where  prh.requisition_header_id = prl.requisition_header_id
         and    prl.line_location_id      = net_rcv.po_line_location_id
         and    prh.preparer_id           = hr.employee_id) Requestor,
        (select max(hr.email_address)
         from   po_requisition_headers_all prh,
                po_requisition_lines_all prl,
                hr_employees hr
         where  prh.requisition_header_id = prl.requisition_header_id
         and    prl.line_location_id      = net_rcv.po_line_location_id
         and    prh.preparer_id           = hr.employee_id) Requestor_Email,
        -- End revision for version 1.29
        net_rcv.receipt_num Receipt_Number,
        -- Revision for version 1.13
        net_rcv.transaction_date Earliest_Receipt_Date,
        case
         when (sysdate - net_rcv.transaction_date) < 31  then '30 days'
         when (sysdate - net_rcv.transaction_date) < 61  then '60 days'
         when (sysdate - net_rcv.transaction_date) < 91  then '90 days'
         when (sysdate - net_rcv.transaction_date) < 121 then '120 days'
         when (sysdate - net_rcv.transaction_date) < 151 then '150 days'
         when (sysdate - net_rcv.transaction_date) < 181 then '180 days'
         else 'Over 180 days'
        end Aging_Date,
        -- Revision for version 1.13 and 1.36
        &p_show_wip_osp
                -- nvl((select we.wip_entity_name
                --      from   wip_entities we
                --      where  we.wip_entity_id = net_rcv.wip_entity_id),'') WIP_Job,
                -- -- Revision for version 1.30
                -- nvl((select ml.meaning
                --      from   wip_discrete_jobs wdj,
                --             mfg_lookups ml
                --      where  wdj.wip_entity_id = net_rcv.wip_entity_id
                --      and    ml.lookup_type    = 'WIP_JOB_STATUS'
                 --     and    ml.lookup_code    = wdj.status_type),'') Job_Status,
                -- nvl((select wdj.date_closed
                --      from   wip_discrete_jobs wdj
                --      where  wdj.wip_entity_id = net_rcv.wip_entity_id),'') Job_Close_Date,
                -- -- End revision for version 1.30
                -- nvl((select br.resource_code
                --     from    bom_resources br
                 --     where  br.resource_id    = net_rcv.bom_resource_id),'') OSP_Resource,
                -- -- End revision for version 1.13 and 1.36
        -- Revision for version 1.33
        muomv.uom_code UOM_Code,
        sum(net_rcv.quantity) Onhand_Quantity,
        gl.currency_code Currency_Code,
        sum(net_rcv.amount) Onhand_Value,
        -- Revision for version 1.40
        sum(net_rcv.adjustment_amount) Adjustment_Amount,
        sum(net_rcv.total_onhand_amount) Total_Onhand_Value
        -- End revision for version 1.40
-- ==========================================================
-- Select the receiving quantities and values from Part 4,
-- condensing to one row per org, item, po, po line and req.
-- ==========================================================
from    -- Revision for version 1.37
        -- mtl_system_items_vl msiv,
        -- Revision for version 1.33
        mtl_item_status_vl misv,
        mtl_units_of_measure_vl muomv,
        -- End revision for version 1.33
        mtl_parameters mp,
        -- Revision for version 1.35
        -- rcv_parameters rp,
        -- Get the receiving valuation accounts by organization and item master account
        (-- No Product Line Accounting
         select 'No Product Line Accounting' valuation_type,
                rp.organization_id,
                msiv.inventory_item_id,
                rp.receiving_account_id,
                -- Revision for version 1.37
                msiv.concatenated_segments,
                msiv.description,
                msiv.item_type,
                msiv.inventory_item_status_code,
                msiv.planning_make_buy_code,
                msiv.primary_uom_code
                -- End revision for version 1.37
         from   rcv_parameters rp,
                mtl_system_items_vl msiv
         where  msiv.organization_id            = rp.organization_id
         -- Avoid organizations with category accounts
         and    :p_product_line_accounting      = 'N'
         and    4=4                             -- p_org_code
         union all
         -- Category Accounting
         -- Revision for version 1.19
         select 'Product Line Accounting' valuation_type,
                item.organization_id,
                item.inventory_item_id,
                nvl(item.code_combination_id,rp.receiving_account_id) receiving_account_id,
                -- Revision for version 1.37
                item.concatenated_segments,
                item.description,
                item.item_type,
                item.inventory_item_status_code,
                item.planning_make_buy_code,
                item.primary_uom_code
                -- End revision for version 1.37
         from   rcv_parameters rp,
                (select rp.organization_id,
                        msiv.inventory_item_id,
                        (select gcc2.code_combination_id
                         from   gl_code_combinations gcc2
                         where  &gcc_product_line_where_clause 
                                gcc.chart_of_accounts_id = gcc2.chart_of_accounts_id) code_combination_id,
                        -- Revision for version 1.37
                        msiv.concatenated_segments,
                        msiv.description,
                        msiv.item_type,
                        msiv.inventory_item_status_code,
                        msiv.planning_make_buy_code,
                        msiv.primary_uom_code
                        -- End revision for version 1.37
                 from   gl_code_combinations gcc_item,
                        gl_code_combinations gcc,
                        mtl_system_items_vl msiv,
                        rcv_parameters rp,
                        fnd_lookups fl
                 where  gcc_item.code_combination_id =
                                decode( fl.lookup_code,
                                        'SALES_ACCOUNT', msiv.sales_account,
                                        'COST_OF_SALES_ACCOUNT', msiv.cost_of_sales_account,
                                        'EXPENSE_ACCOUNT', msiv.expense_account)
                 and    gcc.code_combination_id (+)  = rp.receiving_account_id
                 and    msiv.organization_id         = rp.organization_id
                 and    fl.lookup_type               = 'INV_ITEM_ATTRIBUTES'
                 and    fl.meaning                   = :p_item_master_account_type
                 and    4=4                          -- p_org_code
                ) item
         where  item.organization_id(+)            = rp.organization_id
         and    :p_product_line_accounting         = 'Y'
        ) rp_items,
        -- End revision for version 1.35
        po_headers_all poh,
        org_acct_periods oap,
        mfg_lookups ml, -- Planning Make Buy Code
        fnd_common_lookups fcl, -- Item Type
        po_lookup_codes pl1, -- Destination Type Code
        -- Revision for version 1.36
        po_lookup_codes pl2,  -- Header
        po_lookup_codes pl3,  -- Line
        po_lookup_codes pl4,  -- Line location
        -- End revision for version 1.36
        -- Revision for version 1.29
        po_lines_all pol,
        -- Revision for version 1.36
        po_line_locations_all pll,
        po_releases_all pr,
        po_vendors pov,
        hr_employees hr,
        pa_projects_all pp,
        -- End revision for version 1.29
        hr_organization_information hoi,
        hr_all_organization_units haou,  -- inv_organization_id
        hr_all_organization_units haou2, -- operating unit
        gl_code_combinations gcc,
        gl_ledgers gl,
        -- ==================================
        -- Get receiving quantities and value
        -- ==================================
        -- ================================================
        -- Part 4
        -- Condense the Union down to individual Org/Items
        -- ================================================
        (select all_rcv.organization_id         organization_id,
                all_rcv.inventory_item_id       inventory_item_id,
                all_rcv.destination_type_code   destination_type_code,
                all_rcv.po_header_id            po_header_id,
                all_rcv.po_line_id              po_line_id,
                all_rcv.po_line_location_id     po_line_location_id,
                -- Revision for version 1.29
                all_rcv.po_release_id           po_release_id,
                all_rcv.project_id project_id,
                -- End revision for version 1.29
                all_rcv.receipt_num             receipt_num,
                -- ==========================================================
                -- Revision for version 1.36
                -- Move the earliest transaction logic to the upper query.
                -- For consistent reporting so the qtys and amounts sum together,
                -- use the earliest receipt date for the transaction date
                -- ==========================================================
                (select min(rt2.transaction_date)
                 from   rcv_transactions rt2,
                        rcv_shipment_headers rsh2
                 where  rt2.organization_id     = all_rcv.organization_id
                 and    rt2.shipment_header_id  = all_rcv.shipment_header_id
                 and    rsh2.shipment_header_id = rt2.shipment_header_id
                 and    rsh2.receipt_num        = all_rcv.receipt_num
                ) transaction_date,
                -- End revision for version 1.36
                all_rcv.wip_entity_id           wip_entity_id,
                all_rcv.bom_resource_id         bom_resource_id,
                -- Revision for version 1.36, comment this out
                -- get the earliest date so that the Aging Date is correct,
                -- even if you run this report for a prior period
                -- Fix for version 1.16, changed to MIN instead of MAX
                -- min(trunc(all_rcv.transaction_date)) transaction_date,
                -- End revision for version 1.36
                sum(nvl(all_rcv.quantity,0))    quantity,
                sum(nvl(all_rcv.amount,0))      amount,
                -- Revision for version 1.40
                sum(nvl(all_rcv.adjustment_amount,0)) adjustment_amount,
                sum(nvl(all_rcv.amount,0) + nvl(all_rcv.adjustment_amount,0)) total_onhand_amount
                -- End revision for version 1.40
         from   (
                 -- =============================================================
                 -- Part 3
                 -- Get the onhand receiving quantities
                 -- =============================================================
                 -- Revision for version 1.28, rewrite this section to not use
                 -- rcv_receiving_value_view, unit prices in Release 12 from
                 -- purchase orders or from transfer prices based on advanced pricing.
                 -- =============================================================
                 select 'rcv_onhand' section,
                        rs.to_organization_id organization_id,
                        rs.item_id  inventory_item_id,
                        rs.destination_type_code,
                        rs.po_header_id,
                        rs.po_line_id,
                        rs.po_line_location_id,
                        -- Revision for version 1.29
                        rs.po_release_id,
                        -- Revision for version 1.36
                        -- Move Txn Date Logic to all_rcv Query
                        rs.shipment_header_id,
                        rs.shipment_line_id,
                        -- End revision for version 1.36
                        pod.project_id,
                        -- End revision for version 1.29
                        rsh.receipt_num,
                        pod.wip_entity_id,
                        pod.bom_resource_id,
                        round(rs.to_org_primary_quantity,3) quantity,
                        -- Revision for version 1.32
                        -- round(decode(rt.currency_conversion_rate,
                        --                         null, nvl(rt.po_unit_price,0),
                        --                         nvl(rt.po_unit_price,0) * rt.currency_conversion_rate
                        --             ) * (rt.source_doc_quantity/rt.primary_quantity)
                        --               * round(rs.to_org_primary_quantity,3),2) amount
                        -- End revision for version 1.32
                        -- Revision for version 1.40
                        rs.amount,
                        to_number(null) adjustment_amount
                        -- End revision for version 1.40
                 from   (select ms.to_organization_id,
                                ms.item_id,
                                ms.destination_type_code,
                                ms.po_header_id,
                                ms.po_line_id,
                                ms.po_line_location_id,
                                ms.po_distribution_id,
                                ms.po_release_id,
                                ms.req_header_id,
                                ms.shipment_header_id,
                                ms.shipment_line_id,
                                ms.rcv_transaction_id,
                                ms.to_org_primary_quantity,
                                -- Revision for version 1.32
                                -- Need a consistent price based on rae qtys as the transaction quantity in rcv_accounting_events may be
                                -- different from the ms.to_org_primary_quantity in mtl_supply, due to returns to vendor transactions.
                                -- Average Unit Price
                                round(sum(decode(rae.currency_conversion_rate,
                                                 null, nvl(rae.unit_price,0),
                                                 nvl(rae.unit_price,0) * rae.currency_conversion_rate
                                                )
                                          * (rae.source_doc_quantity/rae.primary_quantity) * rae.primary_quantity
                                         )
                                -- Divided by the Quantity
                                         / sum(rae.primary_quantity)
                                   ,8) avg_unit_price,
                                -- Average Unit Price X Quantity = Amount
                                        -- Price X Quantity
                                        -- Revision for version 1.40, need to get the pll.price_override amount
                                        -- as the Oracle Receiving Value Report uses the latest PO price for current amounts.
                                        -- round(sum(decode(rae.currency_conversion_rate,
                                        --                  null, nvl(rae.unit_price,0),
                                        --                  nvl(rae.unit_price,0) * rae.currency_conversion_rate
                                        --          ) * (rae.source_doc_quantity/rae.primary_quantity) * rae.primary_quantity
                                        --       )        / sum(rae.primary_quantity)
                                        --    ,8)
                                round(ms.to_org_primary_quantity *
                                        -- Price X Quantity
                                         round(sum(decode(rae.currency_conversion_rate,
                                                          null, case when nvl2(rt_correct.po_unit_price,rt_correct.po_unit_price,nvl(rt_deliver.po_unit_price,0))<>nvl(rae.unit_price,0) then nvl(pll.price_override,nvl(rae.unit_price,0)) else nvl(rae.unit_price,0) end,
                                                          case when nvl2(rt_correct.po_unit_price,rt_correct.po_unit_price,nvl(rt_deliver.po_unit_price,0))<>nvl(rae.unit_price,0) then nvl(pll.price_override,nvl(rae.unit_price,0)) else nvl(rae.unit_price,0) end * rae.currency_conversion_rate
                                                  ) * (rae.source_doc_quantity/rae.primary_quantity) * rae.primary_quantity
                                               )        / sum(rae.primary_quantity)
                                            ,8)
                                   ,2) amount
                                -- End revision for version 1.40
                         from   mtl_supply ms,
                                po_line_locations_all pll, -- Added Revision for version 1.40
                                -- Revision for version 1.35
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
                                                 where  ms.supply_type_code       ='RECEIVING'
                                                 -- Revision for version 1.36, client has expense receipts with items
                                                 -- and ms.destination_type_code <>'EXPENSE'
                                                 and    5=5                       -- p_org_code
                                                 -- End revision for version 1.36
                                                )
                                         -- Transfer of ownership consigned entries do not hit receiving accounts
                                         and    nvl(rt.consigned_flag,'N')        = 'N'
                                         and    2=2                               -- p_org_code
                                        ) x
                                 where  x.connect_by_isleaf=1
                                ) rt,
                                -- End revision for version 1.35
                                rcv_accounting_events rae,
                                --Revision for version 1.40
                                rcv_transactions rt_deliver,
                                rcv_transactions rt_correct
                                --End Revision for version 1.40
                         where  ms.rcv_transaction_id         = rt.child_transaction_id
                         and    rt.parent_transaction_id      = rae.rcv_transaction_id
                         --Revision for version 1.40
                         and    rt_deliver.parent_transaction_id(+) = ms.rcv_transaction_id 
                         and    rt_deliver.transaction_type(+) = 'DELIVER'
                         and    rt_correct.parent_transaction_id(+) = rt_deliver.transaction_id
                         and    rt_correct.transaction_type(+) = 'CORRECT'
                         and    pll.line_location_id (+)      = ms.po_line_location_id
                         -- End revision for version 1.40
                         -- Revision for version 1.35
                         -- and    rae.transaction_date         >= ms.receipt_date
                         and    rae.organization_id           = rt.organization_id
                         -- Revision for version 1.36
                         and    ms.to_organization_id         = rt.organization_id
                         group by
                                ms.to_organization_id,
                                ms.item_id,
                                ms.destination_type_code,
                                ms.po_header_id,
                                ms.po_line_id,
                                ms.po_line_location_id,
                                ms.po_distribution_id,
                                ms.po_release_id,
                                ms.req_header_id,
                                ms.shipment_header_id,
                                ms.shipment_line_id,
                                ms.rcv_transaction_id,
                                ms.to_org_primary_quantity
                        ) rs,
                        -- End revision for version 1.35
                        rcv_shipment_headers rsh,
                        rcv_shipment_lines rsl,
                        po_headers_all ph,
                        po_line_locations_all pll,
                        po_distributions_all pod,
                        po_requisition_headers_all prh
                        -- Revision for version 1.29
                        -- po_lines_all pl,
                        -- po_requisition_lines_all prl,
                        -- rcv_transactions rt
                where   rsh.shipment_header_id        = rs.shipment_header_id
                and     rsl.shipment_line_id          = rs.shipment_line_id
                -- Revision for version 1.36
                and     rsl.shipment_header_id        = rs.shipment_header_id
                and     ph.po_header_id (+)           = rs.po_header_id
                -- Revision for version 1.29
                -- and     pl.po_line_id (+)             = rs.po_line_id
                and     pll.line_location_id (+)      = rs.po_line_location_id
                and     pod.po_distribution_id (+)    = rs.po_distribution_id
                and     prh.requisition_header_id (+) = rs.req_header_id
                -- Revision for version 1.29
                -- and     prl.requisition_line_id (+)   = rs.req_line_id
                -- and     rs.rcv_transaction_id         = rt.transaction_id
                -- and     rs.supply_type_code           = 'RECEIVING'
                -- use the Expense Receiving Value Report instead
                -- Revision for version 1.36, client has expense receipts with items
                -- and     rs.destination_type_code <> 'EXPENSE'
                -- Internal requisitions are not part of receiving inventory value
                and     rsl.source_document_code <> 'REQ'
                union all
                      -- =============================================================
                     -- Part 2
                     -- Sum up all the post close rcv'g transactions by item and org
                     -- The SIGN of the quantities and amounts have been reversed
                     -- =============================================================
                 select post_close_rcv_txns.section section,
                        post_close_rcv_txns.organization_id organization_id,
                        post_close_rcv_txns.inventory_item_id inventory_item_id,
                        post_close_rcv_txns.destination_type_code destination_type_code,
                        post_close_rcv_txns.po_header_id po_header_id,
                        post_close_rcv_txns.po_line_id po_line_id,
                        post_close_rcv_txns.po_line_location_id  po_line_location_id,
                        -- Revision for version 1.29
                        post_close_rcv_txns.po_release_id po_release_id,
                        -- Revision for version 1.36
                        -- Move Txn Date Logic to all_rcv Query
                        post_close_rcv_txns.shipment_header_id,
                        post_close_rcv_txns.shipment_line_id,
                        -- End revision for version 1.36
                        post_close_rcv_txns.project_id project_id,
                        -- End revision for version 1.29
                        post_close_rcv_txns.receipt_num receipt_num,
                        post_close_rcv_txns.wip_entity_id wip_entity_id,
                        post_close_rcv_txns.bom_resource_id bom_resource_id,
                        -- Revision for version 1.36
                        -- post_close_rcv_txns.transaction_date transaction_date,
                        sum(nvl(post_close_rcv_txns.quantity,0)) quantity,
                        sum(nvl(post_close_rcv_txns.amount,0)) amount,
                        -- Revision for version 1.40
                        sum(nvl(post_close_rcv_txns.adjustment_amount,0)) adjustment_amount
                 from   (
                     -- ==========================================================
                     -- Part 1
                     -- Get the post close transactions for all receiving activity
                     -- ==========================================================
                         -- ==========================================================
                         -- 1.1 Get the PO receipts into receiving inspection
                         -- ==========================================================
                         select 'Section 1.1' section,
                                -- Revision for version 1.28, added to avoid missing
                                -- transactions having same organization_id, item_id, etc.
                                rae.rcv_transaction_id,
                                rae.organization_id,
                                rae.inventory_item_id inventory_item_id,
                                pod.destination_type_code destination_type_code,
                                rae.po_header_id po_header_id,
                                rae.po_line_id po_line_id,
                                rae.po_line_location_id po_line_location_id,
                                -- Revision for version 1.29
                                rsl.po_release_id po_release_id,
                                -- Revision for version 1.36
                                -- Move Txn Date Logic to all_rcv Query
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                -- End revision for version 1.36
                                pod.project_id project_id,
                                -- End revision for version 1.29
                                rsh.receipt_num receipt_num,
                                pod.wip_entity_id wip_entity_id,
                                pod.bom_resource_id bom_resource_id,
                                -- Amount = Quantity X Price
                                -- Rewrite quantity logic for version 1.38, decode on received accounted amounts does not work if it is zero
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
                                            )
                                   ,3) quantity,
                                -- =====================================================================
                                -- Revision for version 1.28
                                -- 1)  Round amounts to 2 decimals
                                -- 2)  No longer use rrsl, inconsistent amounts with mmt when try to
                                --     subtract away non-recoverable tax and recoverable tax amounts
                                -- 3)  Invert the SIGN as we will subtract away these amounts
                                -- 4)  Convert the price into the primary UOM -- (rae.source_doc_quantity/rae.primary_quantity)
                                -- 5)  Use rcv_accounting_events to get the quantity received by PO Distribution
                                -- 6)  Don't sum up the quantities or amounts as there are multiple po
                                --     distributions per PO Header, Line and Line Location, which creates
                                --     split PO receipts by a percentage of the PO Distributions.
                                -- =====================================================================
                                -- Comment out the below code
                                -- -1 * round(sum((nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0)
                                --        - nvl(rrsl.accounted_rec_tax,0) - nvl(rrsl.accounted_nr_tax0))),2) amount
                                -- =====================================================================
                                round(
                                        -- Quantity
                                        round(decode(sign(nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0)),
                                                          1,  -1 * abs(rae.primary_quantity),
                                                         -1, +1 * abs(rae.primary_quantity),
                                                         rae.primary_quantity
                                                     )
                                           ,3) *
                                        -- Price
                                        decode(rt.currency_conversion_rate,
                                                null, nvl(rt.po_unit_price,0),
                                                nvl(rt.po_unit_price,0) * rt.currency_conversion_rate
                                              ) *
                                        -- Convert into the primary UOM
                                        (rt.source_doc_quantity/rt.primary_quantity)
                                   ,2) amount,
                                -- End fix for version 1.28
                                -- Revision for version 1.40
                                to_number(null) adjustment_amount
                                -- End revision for version 1.40 
                         from   -- =====================================================================
                                -- Revision for version 1.28
                                -- Client has multiple WIP Entity Ids and multiple PO distributions per
                                -- Receipt Number for the same PO Header, Line, Line Location and item number.
                                -- Need to use rcv_accounting_events to get the split quantities
                                -- =====================================================================
                                rcv_transactions rt,
                                -- Revision for version 1.38
                                rcv_transactions parent_rt,
                                rcv_shipment_headers rsh,
                                rcv_shipment_lines rsl,
                                rcv_accounting_events rae,
                                rcv_receiving_sub_ledger rrsl,
                                po_distributions_all pod,
                                org_acct_periods oap
                         where  rt.transaction_id            = rae.rcv_transaction_id
                         -- Revision for version 1.38
                         and    rt.parent_transaction_id     = parent_rt.transaction_id (+)
                         and    rt.organization_id           = parent_rt.organization_id (+)
                         and    rt.transaction_id            = rrsl.rcv_transaction_id
                         -- Oracle difference =>  the RRSL table is using the meaning as the value for the CST_ACCOUNTING_LINE_TYPE
                         --                       lookup code, as opposed to the lookup code values 1 - 99
                         -- Revision for version 1.34, receiving transactions also use 'Clearing'
                         -- and    rrsl.accounting_line_type    = 'Receiving Inspection'
                         and    rrsl.accounting_line_type in ('Clearing', 'Receiving Inspection')
                         -- End revision for version 1.34
                         -- Revision for version 1.32
                         -- Fix for version 1.16
                         -- and    trunc(rae.transaction_date) > oap.schedule_close_date
                         and    rt.transaction_date         >= oap.schedule_close_date + 1
                         -- Revision for version 1.36
                         and    rrsl.transaction_date       >= oap.schedule_close_date + 1
                         and    pod.po_distribution_id       = rrsl.reference3
                         -- and    rae.organization_id          = rt.organization_id
                         -- and    oap.organization_id          = rae.organization_id
                         -- and    rae.transaction_date        >= oap.schedule_close_date + 1
                         -- and    pod.po_distribution_id       = rae.po_distribution_id
                         -- End revision for version 1.36
                         and    oap.organization_id          = rt.organization_id
                         and    rae.accounting_event_id      = rrsl.accounting_event_id
                         -- End revision for version 1.32
                         -- Revision for version 1.32
                         and    2=2                          -- p_org_code
                         and    3=3                          -- p_period_name
                         -- Revision for version 1.36
                         -- and    pod.destination_type_code   <> 'EXPENSE'
                         and    rt.shipment_header_id        = rsh.shipment_header_id
                         and    rt.shipment_line_id          = rsl.shipment_line_id
                         -- Fix for version 1.19
                         and    rt.transaction_type         <> 'DELIVER'  -- only want receipts, return to vendor and corrections
                         -- End revision for version 1.32
                         group by
                                'Section 1.1', -- section
                                -- Revision for version 1.28
                                rae.rcv_transaction_id,
                                rae.organization_id,
                                rae.inventory_item_id,
                                pod.destination_type_code,
                                rae.po_header_id,
                                rae.po_line_id,
                                rae.po_line_location_id,
                                -- Revision for version 1.29
                                rsl.po_release_id,
                                -- Revision for version 1.36
                                -- Move Txn Date Logic to all_rcv Query
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                -- End revision for version 1.36
                                pod.project_id,
                                -- End revision for version 1.29
                                rsh.receipt_num,
                                pod.wip_entity_id,
                                pod.bom_resource_id,
                                -- Revision for version 1.38, decode on accounted amounts does not work if it is zero
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
                                            )
                                   ,3), --quantity
                                -- Amount = Quantity X Price
                                round(
                                        -- Quantity
                                        round(decode(sign(nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0)),
                                                          1,  -1 * abs(rae.primary_quantity),
                                                         -1, +1 * abs(rae.primary_quantity),
                                                         rae.primary_quantity
                                                     )
                                           ,3) *
                                -- Price
                                        decode(rt.currency_conversion_rate,
                                                null, nvl(rt.po_unit_price,0),
                                                nvl(rt.po_unit_price,0) * rt.currency_conversion_rate
                                              ) *
                                        -- Convert into the primary UOM
                                        (rt.source_doc_quantity/rt.primary_quantity)
                                   ,2) -- Amount = Quantity X Price
                                -- End revision for version 1.26
                         -- ==========================================================
                         -- 1.2 Get the PO deliveries from receiving inspt into inventory
                         -- for both costed and uncosted material transactions
                         -- Uncosted entries are not in mtl_transaction_accounts
                         -- ==========================================================
                         union all
                         select 'Section 1.2' section,
                                -- Revision for version 1.28, added because Section 1.1
                                -- needed the rae.rcv_transaction_id for uniqueness
                                rt.transaction_id,
                                mmt.organization_id organization_id,
                                rsl.item_id inventory_item_id,
                                pod.destination_type_code destination_type_code,
                                rt.po_header_id po_header_id,
                                rt.po_line_id po_line_id,
                                rt.po_line_location_id po_line_location_id,
                                -- Revision for version 1.29
                                rsl.po_release_id po_release_id,
                                -- Revision for version 1.36
                                -- Move Txn Date Logic to all_rcv Query
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                -- End revision for version 1.36
                                pod.project_id project_id,
                                -- End revision for version 1.29
                                rsh.receipt_num receipt_num,
                                pod.wip_entity_id wip_entity_id,
                                pod.bom_resource_id bom_resource_id,
                                -- Fix for version 1.17, get the SIGN of the quantity correct
                                -- no need to invert the SIGN, is it positive going into inventory
                                --sum(-1*(nvl(mmt.primary_quantity,0))) quantity,
                                -- Revision for version 1.28, round qtys to 3 decimals
                                round(sum((nvl(mmt.primary_quantity,0))),3) quantity,
                                -- Fix for version 1.18
                                round(sum((nvl(mmt.primary_quantity,0) *
                                    -- Fix for version 1.28, the PO Unit Price on RT may be in a different UOM
                                    -- Convert into the primary UOM
                                    (rt.source_doc_quantity/rt.primary_quantity) *
                                    -- End revision for version 1.28
                                    decode(rt.currency_conversion_rate, null, nvl(rt.po_unit_price,0),
                                      nvl(rt.po_unit_price,0) * rt.currency_conversion_rate))),2) amount,
                                -- Revision for version 1.40
                                to_number(null) adjustment_amount
                                -- End revision for version 1.40 
                         from   mtl_material_transactions mmt,
                                rcv_transactions rt,
                                rcv_parameters rp,
                                -- Revision for version 1.29
                                -- po_lines_all pol,
                                po_line_locations_all pll,
                                po_distributions_all pod,
                                rcv_shipment_headers rsh,
                                rcv_shipment_lines rsl,
                                org_acct_periods oap
                         where  mmt.rcv_transaction_id       = rt.transaction_id
                         and    mmt.transaction_source_type_id = 1 -- purchasing receipts
                         -- Revision for version 1.29
                         -- and    rt.po_line_id                = pol.po_line_id
                         and    rt.po_line_location_id       = pll.line_location_id
                         and    pll.line_location_id         = pod.line_location_id
                         and    rt.shipment_line_id          = rsl.shipment_line_id
                         -- Revision for version 1.36
                         and    rt.shipment_header_id        = rsh.shipment_header_id
                         and    rsl.shipment_header_id       = rsh.shipment_header_id
                         -- Revision for version 1.34, to prevent cross-joining with pod
                         and    pod.po_distribution_id       = nvl(rsl.po_distribution_id, pod.po_distribution_id)
                         and    oap.organization_id          = mmt.organization_id
                         and    3=3                          -- p_period_name
                         -- Revision for version 1.32
                         -- Fix for version 1.16
                         -- The oap.schedule_close_date does not have a timestamp so we have to trunc to make the comparison
                         -- and    mmt.transaction_date        >= oap.schedule_close_date
                         -- and    trunc(mmt.transaction_date) > oap.schedule_close_date
                         and    mmt.transaction_date        >= oap.schedule_close_date + 1
                         -- End revision for version 1.32
                         -- Revision for version 1.36
                         and    rt.transaction_date         >= oap.schedule_close_date + 1
                         and    rp.receiving_account_id      = mmt.distribution_account_id
                         and    rp.organization_id           = mmt.organization_id
                         -- Revision for version 1.36
                         -- and    pod.destination_type_code <> 'EXPENSE'
                         -- Revision for version 1.32
                         and    2=2                          -- p_org_code
                         group by
                                'Section 1.2', -- section
                                -- Revision for version 1.28
                                rt.transaction_id,
                                mmt.organization_id,
                                rsl.item_id,
                                pod.destination_type_code,
                                rt.po_header_id,
                                rt.po_line_id,
                                rt.po_line_location_id,
                                -- Revision for version 1.29
                                rsl.po_release_id,
                                -- Revision for version 1.36
                                -- Move Txn Date Logic to all_rcv Query
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                -- End revision for version 1.36
                                pod.project_id,
                                -- End revision for version 1.29
                                rsh.receipt_num,
                                pod.wip_entity_id,
                                pod.bom_resource_id,
                                -- Revision for version 1.26
                                -- for receipt date inline select
                                rsh.organization_id
                                -- End revision for version 1.26
                         -- ==========================================================
                         -- 1.3 Get the PO deliveries from receiving inspection into WIP
                         -- ==========================================================
                         union all
                         select 'Section 1.3' section,
                                -- Revision for version 1.28, added because Section 1.1
                                -- needed the rae.rcv_transaction_id for uniqueness
                                rt.transaction_id,
                                wta.organization_id organization_id,
                                rsl.item_id inventory_item_id,
                                pod.destination_type_code destination_type_code,
                                rt.po_header_id po_header_id,
                                rt.po_line_id po_line_id,
                                rt.po_line_location_id po_line_location_id,
                                -- Revision for version 1.29
                                rsl.po_release_id po_release_id,
                                -- Revision for version 1.36
                                -- Move Txn Date Logic to all_rcv Query
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                -- End revision for version 1.36
                                pod.project_id project_id,
                                -- End revision for version 1.29
                                rsh.receipt_num receipt_num,
                                pod.wip_entity_id wip_entity_id,
                                pod.bom_resource_id bom_resource_id,
                                -- Revision for version 1.38, decode on accounted amounts does not work if it is zero
                                round(decode(rt.transaction_type,
                                        'DELIVER', 1 * rt.primary_quantity,
                                        'RETURN TO RECEIVING', -1 * rt.primary_quantity,
                                        'CORRECT',
                                                decode(parent_rt.transaction_type,
                                                        'UNORDERED', 0,
                                                        'DELIVER', 1 * rt.primary_quantity,
                                                        'RETURN TO RECEIVING', -1 * rt.primary_quantity,
                                                        'MATCH', -1 * rt.primary_quantity,
                                                        0),
                                        0)
                                   ,3) quantity,
                                -- invert the SIGN as we will subtract away these amounts
                                --Fix for version 1.18
                                round(sum(-1*wta.base_transaction_value),2) amount,
                                -- Revision for version 1.40
                                to_number(null) adjustment_amount
                                -- End revision for version 1.40 
                         from   wip_transaction_accounts wta,
                                wip_transactions wt,
                                rcv_transactions rt,
                                -- Revision for version 1.38
                                rcv_transactions parent_rt,
                                rcv_parameters rp,
                                -- Revision for version 1.29
                                -- po_lines_all pol,
                                po_line_locations_all pll,
                                rcv_shipment_headers rsh,
                                rcv_shipment_lines rsl,
                                po_distributions_all pod,
                                org_acct_periods oap
                         where  wt.transaction_id            = wta.transaction_id
                         -- Oracle bug => the accounting line type used is 4 (res absorption) and should be 5 (receiving)
                         and    wta.accounting_line_type in (4,5)
                         and    wt.rcv_transaction_id        = rt.transaction_id
                         -- Revision for version 1.38
                         and    rt.parent_transaction_id     = parent_rt.transaction_id (+)
                         and    rt.organization_id           = parent_rt.organization_id (+)
                         -- Revision for version 1.36
                         and    wt.organization_id           = rt.organization_id
                         -- Revision for version 1.29
                         -- and    rt.po_line_id                = pol.po_line_id
                         and    rt.po_line_location_id       = pll.line_location_id
                         and    pll.line_location_id         = pod.line_location_id
                         and    rt.shipment_line_id          = rsl.shipment_line_id
                         -- Revision for version 1.36
                         and    rt.shipment_header_id        = rsh.shipment_header_id
                         and    rsl.shipment_header_id       = rsh.shipment_header_id
                         -- Revision for version 1.34, to prevent cross-joining with pod
                         and    pod.po_distribution_id       = nvl(rsl.po_distribution_id, pod.po_distribution_id)
                         and    oap.organization_id          = wta.organization_id
                         and    3=3                          -- p_period_name
                         -- Revision for version 1.32
                         -- Fix for version 1.16
                         -- The oap.schedule_close_date does not have a timestamp so we have to trunc to make the comparison
                         -- and    wta.transaction_date        >= oap.schedule_close_date
                         -- and    trunc(wta.transaction_date) > oap.schedule_close_date
                         and    wta.transaction_date        >= oap.schedule_close_date + 1
                         -- End revision for version 1.32
                         -- Revision for version 1.36
                         and    wt.transaction_date         >= oap.schedule_close_date + 1
                         and    rt.transaction_date         >= oap.schedule_close_date + 1
                         -- End revision for version 1.36
                         and    rp.receiving_account_id      = wta.reference_account
                         and    rp.organization_id           = wta.organization_id
                         and    pod.destination_type_code <> 'EXPENSE'
                        -- Fix for version 1.2, to avoid doubling up results
                         and    pod.wip_entity_id            = wta.wip_entity_id
                         -- Revision for version 1.32
                         and    2=2                          -- p_org_code
                         group by
                                'Section 1.3', -- section
                                -- Revision for version 1.28
                                rt.transaction_id,
                                wta.organization_id,
                                rsl.item_id,
                                pod.destination_type_code,
                                rt.po_header_id,
                                rt.po_line_id,
                                rt.po_line_location_id,
                                -- Revision for version 1.29
                                rsl.po_release_id,
                                -- Revision for version 1.36
                                -- Move Txn Date Logic to all_rcv Query
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                -- End revision for version 1.36
                                pod.project_id,
                                -- End revision for version 1.29
                                rsh.receipt_num,
                                pod.wip_entity_id,
                                pod.bom_resource_id,
                                -- Revision for version 1.38, decode on accounted amounts does not work if it is zero
                                round(decode(rt.transaction_type,
                                        'DELIVER', 1 * rt.primary_quantity,
                                        'RETURN TO RECEIVING', -1 * rt.primary_quantity,
                                        'CORRECT',
                                                decode(parent_rt.transaction_type,
                                                        'UNORDERED', 0,
                                                        'DELIVER', 1 * rt.primary_quantity,
                                                        'RETURN TO RECEIVING', -1 * rt.primary_quantity,
                                                        'MATCH', -1 * rt.primary_quantity,
                                                     0),
                                           0)
                                   ,3), -- quantity
                                -- Revision for version 1.26
                                -- for receipt date inline select
                                rsh.organization_id
                                -- End revision for version 1.26
                         -- ==========================================================
                         -- 1.4 Get the unprocessed PO deliveries (wip_cost_txn_interface)
                         -- from WIP receiving inspection into WIP, as the receiving
                         -- quantities in MTL_SUPPLY have already been updated, but the
                         -- WIP transactions and WIP accounting entries do not exist.
                         -- ==========================================================
                         union all
                         select 'Section 1.4' section,
                                -- Revision for version 1.28, added because Section 1.1
                                -- needed the rae.rcv_transaction_id for uniqueness
                                rt.transaction_id,
                                wcti.organization_id organization_id,
                                rsl.item_id inventory_item_id,
                                pod.destination_type_code destination_type_code,
                                rt.po_header_id po_header_id,
                                rt.po_line_id po_line_id,
                                rt.po_line_location_id po_line_location_id,
                                -- Revision for version 1.29
                                rsl.po_release_id po_release_id,
                                -- Revision for version 1.36
                                -- Move Txn Date Logic to all_rcv Query
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                -- End revision for version 1.36
                                pod.project_id project_id,
                                -- End revision for version 1.29
                                rsh.receipt_num receipt_num,
                                pod.wip_entity_id wip_entity_id,
                                pod.bom_resource_id bom_resource_id,
                                -- Revision for version 1.28, round qtys to 3 decimals
                                -- no need to invert the SIGN of the quantity, already a positive QTY
                                round(sum((nvl(wcti.primary_quantity,0))),3) quantity,
                                -- no need to invert the SIGN of the quantity, already a positive QTY
                                -- Fix for version 1.18
                                round(sum(nvl(wcti.primary_quantity,0) *
                                   -- Fix for version 1.28
                                   -- Make sure the price is in the primary UOM
                                   (rt.source_doc_quantity/rt.primary_quantity) *
                                   decode(rt.currency_conversion_rate, null, nvl(rt.po_unit_price,0),
                                      nvl(rt.po_unit_price,0) * rt.currency_conversion_rate)),2) amount,
                                -- Revision for version 1.40
                                to_number(null) adjustment_amount
                                -- End revision for version 1.40 
                         from   wip_cost_txn_interface wcti,
                                rcv_transactions rt,
                                rcv_parameters rp,
                                -- Revision for version 1.29
                                -- po_lines_all pol,
                                po_line_locations_all pll,
                                rcv_shipment_headers rsh,
                                rcv_shipment_lines rsl,
                                po_distributions_all pod,
                                org_acct_periods oap
                         where  wcti.rcv_transaction_id      = rt.transaction_id
                         and    wcti.transaction_type        = 3 -- outside processing
                         -- Revision for version 1.29
                         -- and    rt.po_line_id                = pol.po_line_id
                         and    rt.po_line_location_id       = pll.line_location_id
                         and    pll.line_location_id         = pod.line_location_id
                         and    rt.shipment_line_id          = rsl.shipment_line_id
                         and    rsl.shipment_header_id       = rsh.shipment_header_id
                         and    rt.shipment_line_id          = rsl.shipment_line_id
                         -- Revision for version 1.36
                         and    rt.shipment_header_id        = rsh.shipment_header_id
                         -- Revision for version 1.34, to prevent cross-joining with pod
                         and    pod.po_distribution_id       = nvl(rsl.po_distribution_id, pod.po_distribution_id)
                         and    oap.organization_id          = wcti.organization_id
                         and    3=3                          -- p_period_name
                         -- Revision for version 1.32
                         -- Fix for version 1.16
                         -- The oap.schedule_close_date does not have a timestamp so we have to trunc to make the comparison
                         -- and    wcti.transaction_date       >= oap.schedule_close_date
                         -- and    trunc(wcti.transaction_date) > oap.schedule_close_date
                         and    wcti.transaction_date       >= oap.schedule_close_date + 1
                         -- Revision for version 1.36
                         and    rt.transaction_date         >= oap.schedule_close_date + 1
                         and    wcti.organization_id         = rt.organization_id
                         -- End revision for version 1.32
                         and    rp.receiving_account_id      = wcti.receiving_account_id
                         and    rp.organization_id           = wcti.organization_id
                         -- revision for version 1.28
                         -- To avoid cross-joining with multiple PO distributions, multiple WIP jobs per receipt
                         and    pod.wip_entity_id            = wcti.wip_entity_id
                         and    pod.destination_type_code <> 'EXPENSE'
                         -- Revision for version 1.32
                         and    2=2                          -- p_org_code
                         group by
                                'Section 1.4', -- section
                                -- Revision for version 1.28
                                rt.transaction_id,
                                wcti.organization_id,
                                rsl.item_id,
                                pod.destination_type_code,
                                rt.po_header_id,
                                rt.po_line_id,
                                rt.po_line_location_id,
                                -- Revision for version 1.29
                                rsl.po_release_id,
                                -- Revision for version 1.36
                                -- Move Txn Date Logic to all_rcv Query
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                -- End revision for version 1.36
                                pod.project_id,
                                -- End revision for version 1.29
                                rsh.receipt_num,
                                pod.wip_entity_id,
                                pod.bom_resource_id,
                                -- Revision for version 1.26
                                -- for receipt date inline select
                                rsh.organization_id
                                -- End revision for version 1.26
                         -- ==========================================================
                         -- 1.5 Get the retroactive price adjustments on the DELIVER
                         -- transaction type from rrsl.  Retroactive price adjust-
                         -- ments have entries in rrsl on DELIVER rt.transaction_type.
                         -- Normally there are no accounting entries in rrsl for
                         -- DELIVER rt.transaction types.
                         -- This logic applies to material and WIP DELIVER txns.
                         -- Fix for version 1.19
                         -- ==========================================================
                         union all
                         select 'Section 1.5' section,
                                -- Revision for version 1.28, added because Section 1.1
                                -- needed the rae.rcv_transaction_id for uniqueness
                                rt.transaction_id,
                                rt.organization_id organization_id,
                                rsl.item_id inventory_item_id,
                                pod.destination_type_code destination_type_code,
                                rt.po_header_id po_header_id,
                                rt.po_line_id po_line_id,
                                rt.po_line_location_id po_line_location_id,
                                -- Revision for version 1.29
                                rsl.po_release_id po_release_id,
                                -- Revision for version 1.36
                                -- Move Txn Date Logic to all_rcv Query
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                -- End revision for version 1.36
                                pod.project_id project_id,
                                -- End revision for version 1.29
                                rsh.receipt_num receipt_num,
                                pod.wip_entity_id wip_entity_id,
                                pod.bom_resource_id bom_resource_id,
                                -- the quantities have already been included in sections
                                -- 1.1 to 1.4, no "real" qty for retroactive price adjustments
                                -- as this works like a valuation adjustment
                                sum(0) quantity,
                                -- invert the SIGN as we will subtract away these amounts
                                round(sum(-1*(nvl(rrsl.accounted_dr,0) - nvl(rrsl.accounted_cr,0))),2) amount,
                                -- Revision for version 1.40
                                to_number(null) adjustment_amount
                                -- End revision for version 1.40 
                         from   rcv_transactions rt,
                                rcv_receiving_sub_ledger rrsl,
                                rcv_parameters rp,
                                -- Revision for version 1.29
                                -- po_lines_all pol,
                                po_line_locations_all pll,
                                po_distributions_all pod,
                                rcv_shipment_headers rsh,
                                rcv_shipment_lines rsl,
                                org_acct_periods oap
                         -- Revision for version 1.29
                         -- where  rt.po_line_id               = pol.po_line_id
                         where  rt.po_line_location_id       = pll.line_location_id
                         and    pll.line_location_id         = pod.line_location_id
                         and    rt.shipment_line_id          = rsl.shipment_line_id
                         -- Revision for version 1.36
                         and    rt.shipment_header_id        = rsh.shipment_header_id
                         -- Revision for version 1.34, to prevent cross-joining with pod
                         -- and    pod.po_distribution_id       = nvl(rsl.po_distribution_id, pod.po_distribution_id)
                         and    pod.po_distribution_id       = rrsl.reference3
                         -- End revision for version 1.36
                         and    rsl.shipment_header_id       = rsh.shipment_header_id
                         and    oap.organization_id          = rt.organization_id
                         and    3=3                          -- p_period_name
                         -- Revision for version 1.32
                         -- Fix for version 1.16
                         -- The oap.schedule_close_date does not have a timestamp so we have to trunc to make the comparison
                         -- Use rt.transaction_date as this correctly references the quantity movement, even
                         -- though the rrsl.accounting_date is when the retroactive adjustment happened
                         -- and    trunc(rt.transaction_date)  > oap.schedule_close_date
                         and    rt.transaction_date         >= oap.schedule_close_date + 1
                         and    rp.organization_id           = rt.organization_id
                         -- Revision for version 1.36
                         and    rrsl.transaction_date       >= oap.schedule_close_date + 1
                         -- ==============================================
                         -- These joins will get the retroactive price
                         -- adjustments for both inventory and WIP, that
                         -- hit the receiving inspection account
                         -- ==============================================
                         and    rp.receiving_account_id      = rrsl.code_combination_id
                         and    rt.transaction_type          = 'DELIVER'
                         and    pod.destination_type_code   <> 'EXPENSE'
                         and    rt.transaction_id            = rrsl.rcv_transaction_id
                         -- Oracle difference =>  the RRSL table is using the meaning as the value for the CST_ACCOUNTING_LINE_TYPE
                         --                       lookup code, as opposed to the lookup code values 1 - 99
                         -- Revision for version 1.34, receiving transactions also use 'Clearing'
                         -- and    rrsl.accounting_line_type    = 'Receiving Inspection'
                         and     rrsl.accounting_line_type in ('Clearing', 'Receiving Inspection')
                         -- End revision for version 1.34
                         -- Revision for version 1.32
                         and    2=2                          -- p_org_code
                         group by
                                'Section 1.5', -- section
                                -- Revision for version 1.28
                                rt.transaction_id,
                                rt.organization_id,
                                rsl.item_id,
                                pod.destination_type_code,
                                rt.po_header_id,
                                rt.po_line_id,
                                rt.po_line_location_id,
                                -- Revision for version 1.29
                                rsl.po_release_id,
                                -- Revision for version 1.36
                                -- Move Txn Date Logic to all_rcv Query
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                -- End revision for version 1.36
                                pod.project_id,
                                -- End revision for version 1.29
                                rsh.receipt_num,
                                pod.wip_entity_id,
                                pod.bom_resource_id,
                                -- Revision for version 1.26
                                -- for receipt date inline select
                                rsh.organization_id
                                -- End revision for version 1.26
                         -- ==========================================================
                         -- Revision for version 1.40
                         -- 1.6 Get the change in unit prices between the RECEIVE and
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
                         -- per the DELIVER transaction.  So the CAC report now has two
                         -- new columns, "Adjustment Amount" and "Total Onhand Value",
                         -- thereby balancing the CAC Receiving Value Report to the
                         -- Oracle Receiving Value Report.  For both material and
                         -- WIP RECEIVE transactions.
                         -- ==========================================================
                         union all
                         select 'Section 1.6' section,
                                rae.rcv_transaction_id,
                                rae.organization_id,
                                rae.inventory_item_id inventory_item_id,
                                pod.destination_type_code destination_type_code,
                                rae.po_header_id po_header_id,
                                rae.po_line_id po_line_id,
                                rae.po_line_location_id po_line_location_id,
                                rsl.po_release_id po_release_id,
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                pod.project_id project_id,
                                rsh.receipt_num receipt_num,
                                pod.wip_entity_id wip_entity_id,
                                pod.bom_resource_id bom_resource_id,
                                to_number(null) quantity,
                                to_number(null) amount,
                                -- =====================================================================
                                -- Revision for version 1.40
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
                                   ,2) adjustment_amount
                         from   -- =====================================================================
                                -- Client has multiple WIP Entity Ids and multiple PO distributions per
                                -- Receipt Number for the same PO Header, Line, Line Location and item number.
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
                                po_distributions_all pod,
                                org_acct_periods oap
                         where  rt.transaction_id            = rae.rcv_transaction_id
                         and    rt.parent_transaction_id     = parent_rt.transaction_id (+)
                         and    rt.organization_id           = parent_rt.organization_id (+)
                         and    rt.transaction_id            = rrsl.rcv_transaction_id
                         and    rrsl.accounting_line_type in ('Clearing', 'Receiving Inspection')
                         and    rt.transaction_date         >= oap.schedule_close_date + 1
                         and    rrsl.transaction_date       >= oap.schedule_close_date + 1
                         and    pod.po_distribution_id       = rrsl.reference3
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
                         and    2=2                          -- p_org_code
                         and    3=3                          -- p_period_name
                         group by
                                'Section 1.6', -- section
                                -- Revision for version 1.28
                                rae.rcv_transaction_id,
                                rae.organization_id,
                                rae.inventory_item_id,
                                pod.destination_type_code,
                                rae.po_header_id,
                                rae.po_line_id,
                                rae.po_line_location_id,
                                -- Revision for version 1.29
                                rsl.po_release_id,
                                -- Revision for version 1.36
                                -- Move Txn Date Logic to all_rcv Query
                                rsh.shipment_header_id,
                                rsl.shipment_line_id,
                                -- End revision for version 1.36
                                pod.project_id,
                                -- End revision for version 1.29
                                rsh.receipt_num,
                                pod.wip_entity_id,
                                pod.bom_resource_id,
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
                                   ,2)
                         -- End revision for version 1.40 
                        ) post_close_rcv_txns
                 group by
                        post_close_rcv_txns.section,
                        post_close_rcv_txns.organization_id,
                        post_close_rcv_txns.inventory_item_id,
                        post_close_rcv_txns.destination_type_code,
                        post_close_rcv_txns.po_header_id,
                        post_close_rcv_txns.po_line_id,
                        post_close_rcv_txns.po_line_location_id,
                        -- Revision for version 1.29
                        post_close_rcv_txns.po_release_id,
                        -- Revision for version 1.36
                        -- Move Txn Date Logic to all_rcv Query
                        post_close_rcv_txns.shipment_header_id,
                        post_close_rcv_txns.shipment_line_id,
                        -- End revision for version 1.36
                        post_close_rcv_txns.project_id,
                        -- End revision for version 1.29
                        post_close_rcv_txns.receipt_num,
                        post_close_rcv_txns.wip_entity_id,
                        post_close_rcv_txns.bom_resource_id
                        -- Revision for version 1.36
                        -- post_close_rcv_txns.transaction_date
                ) all_rcv
        group by
                all_rcv.section,
                all_rcv.organization_id,
                all_rcv.inventory_item_id,
                all_rcv.destination_type_code,
                all_rcv.po_header_id,
                all_rcv.po_line_id,
                all_rcv.po_line_location_id,
                -- Revision for version 1.29
                all_rcv.po_release_id,
                -- Revision for version 1.36
                all_rcv.shipment_header_id,
                all_rcv.project_id,
                -- End revision for version 1.29
                all_rcv.receipt_num,
                all_rcv.wip_entity_id,
                all_rcv.bom_resource_id
                -- Revision for version 1.36
                -- trunc(all_rcv.transaction_date)
        -- Fix for version 1.26
        -- Caused corrections to be missed with incorrect results
        -- Fix for version 1.18
        -- having abs(sum(nvl(all_rcv.quantity,0))) > .01
        ) net_rcv
        -- ===========================
        -- End of getting quantities
        -- ===========================
-- ===================================================================
-- Item master to quantity and item master to cost joins
-- ===================================================================
where   rp_items.inventory_item_id      = net_rcv.inventory_item_id
and     rp_items.organization_id        = net_rcv.organization_id
-- Revision for version 1.33
and     muomv.uom_code                  = rp_items.primary_uom_code
and     misv.inventory_item_status_code = rp_items.inventory_item_status_code
-- End revision for version 1.33
and     mp.organization_id              = oap.organization_id
and     3=3                             -- p_period_name
-- ===================================================================
-- PO Header joins
-- ===================================================================
and     poh.po_header_id                = net_rcv.po_header_id
-- Revision for version 1.29
and     pol.po_line_id                  = net_rcv.po_line_id
-- Revision for version 1.36
and     pll.line_location_id            = net_rcv.po_line_location_id
and     pov.vendor_id                   = poh.vendor_id
and     hr.employee_id                  = poh.agent_id
and     pp.project_id (+)               = net_rcv.project_id
and     pr.po_release_id (+)            = net_rcv.po_release_id
-- End revision for version 1.29
-- ===================================================================
-- Receiving accrual account to account number join and org joins
-- ===================================================================
and     rp_items.receiving_account_id   = gcc.code_combination_id (+)
and     rp_items.organization_id        = mp.organization_id
-- ===================================================================
-- Joins for the lookup codes
-- ===================================================================
and     ml.lookup_type                  = 'MTL_PLANNING_MAKE_BUY'
and     ml.lookup_code                  = rp_items.planning_make_buy_code
-- revision for version 1.11
and     fcl.lookup_type (+)             = 'ITEM_TYPE'
and     fcl.lookup_code (+)             = rp_items.item_type
and     pl1.lookup_type                 = 'DESTINATION TYPE'
and     pl1.lookup_code                 = net_rcv.destination_type_code
and     pl2.lookup_type (+)             = 'DOCUMENT STATE'
and     pl2.lookup_code (+)             = poh.closed_code
and     pl3.lookup_type (+)             = 'DOCUMENT STATE'
and     pl3.lookup_code (+)             = pol.closed_code
and     pl4.lookup_type (+)             = 'DOCUMENT STATE'
and     pl4.lookup_code (+)             = pll.closed_code
-- ===================================================================
-- Using the base tables to avoid the performance issues
-- with org_organization_definitions and hr_operating_units
-- ===================================================================
and     hoi.org_information_context     = 'Accounting Information'
and     hoi.organization_id             = mp.organization_id
and     hoi.organization_id             = haou.organization_id             -- this gets the organization name
-- avoid selecting disabled inventory organizations
and     sysdate                         < nvl(haou.date_to, sysdate +1)
and     haou2.organization_id           = to_number(hoi.org_information3)  -- this gets the operating unit id
and     gl.ledger_id                    = to_number(hoi.org_information1)  -- get the ledger_id
-- Revision for version 1.40
-- Revision for Inventory Organization, Operating Unit and Ledger Controls and Parameters, replacing prior method.
and     mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id)
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_LEDGER_SECURITY'),'N')='N' or gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)))
and     (nvl(fnd_profile.value('XXEN_REPORT_USE_OPERATING_UNIT_SECURITY'),'N')='N' or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))
-- End revision for version 1.40
and     1=1                             -- p_item_number, p_operating_unit, p_ledger
group by
        nvl(gl.short_name, gl.name),
        haou2.name,
        mp.organization_code,
        haou.name,
        oap.period_name,
        &column_segments_grp
        -- Revision for version 1.29
        pov.vendor_name,
         hr.full_name,
        -- End revision for version 1.29
        rp_items.concatenated_segments,
        rp_items.description,
        fcl.meaning, -- Item Type
        -- Revision for version 1.33
        misv.inventory_item_status_code_tl,
        ml.meaning, -- Planning Make Buy Code
        -- Revision for version 1.27
        -- mc.segment1,
        pl1.displayed_field, -- Destination_Type
        -- Revision for version 1.36
        nvl(pl4.displayed_field,nvl(pl3.displayed_field, pl2.displayed_field)), --  PO_Line_Status
        poh.segment1,
        -- Revision for version 1.29
        pol.line_num,
        pr.release_num,
        pp.segment1, -- Project Number
        pp.name, -- Project Name
        -- For inline column category select
        net_rcv.po_line_location_id,
        -- End revision for version 1.29
        net_rcv.receipt_num,
        net_rcv.transaction_date,
        &p_show_wip_osp_grp
        -- net_rcv.wip_entity_id,
        -- net_rcv.bom_resource_id,
        gl.currency_code,
        -- Revision for version 1.33
        muomv.uom_code,
        -- For inline column category select
        rp_items.inventory_item_id,
        rp_items.organization_id
-- Revision for version 1.28, screen out zero quantities and amounts at the very end
having abs(sum(nvl(net_rcv.quantity,0) + nvl(net_rcv.amount,0))) > .01
-- Order by Ledger, Operating Unit, Org Code, Account Segments, Item Number, PO Number and Receipt Number
order by
        nvl(gl.short_name, gl.name), -- Ledger
        haou2.name, -- Operating Unit
        mp.organization_code, -- Org Code
        &column_segments_grp
        pov.vendor_name, -- Supplier
        rp_items.concatenated_segments, -- Item Number
        poh.segment1, -- PO Number
        pol.line_num, -- PO Line
        pr.release_num, -- PO Rel
        net_rcv.transaction_date