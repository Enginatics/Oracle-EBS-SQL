---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Interface Error Summary | Oracle EBS SQL Report'
description: 'Use this report to view your transactions that are pending or have errors in the Oracle interface tables. Across both Financial and Supply Chain…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, R12 only, CAC, Interface, Error, Summary, mtl_parameters, hr_organization_information, hr_all_organization_units_vl'
permalink: /CAC%20Interface%20Error%20Summary/
report_name: 'CAC Interface Error Summary'
report_web_name: cac-interface-error-summary
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Interface Error Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-interface-error-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Use this report to view your transactions that are pending or have errors in the Oracle interface tables.  Across both Financial and Supply Chain Applications.  This includes interfaces that would prevent closing the inventory accounting period, as suggested by the report titles, Resolution Required and Resolution Recommended.  Similar to the Inventory Account Periods Close form (checking open receipts, pending shipments, failed inventory, WIP, etc.).

Notes:
1)  Supply Chain queries check for the period close timezone of the legal entity, just like the Inventory Account Periods Close form and the Blitz INV Period Close Pending Transactions report.  Period count queries sourced from procedure CST_AccountingPeriod_PUB.Get_PendingTcount (CSTPAPEB.pls 120.18.12020000.8)
2)  The Financial interfaces all show a priority of "Resolution Recommended", as having entries in these interface tables do not prevent you from closing your books.  However, just like Supply Chain, best practice would be to process all unprocessed and/or erred out entries in these interfaces, before closing the accounting period.

Specific Functional Areas and Interface Reports include:

Accounts Payables
   AP_Invoices_Interface
   AP_Invoice_Lines_Interface

Accounts Receivables
   RA_Interface_Lines_All
   RA_Interface_Errors_All

Cash Management
   CE_Header_Interface_Errors

Cost Management
   Uncosted Material - MTL_Material_Transactions
   Uncosted - WSM_Split_Merge_Transactions
   Pending WIP Costing - WIP_Cost_Txn_Interface Report

General Ledger
   GL_Interface

Inventory
   Unprocessed Material - MTL_Material_Transactions_Temp
   Unprocessed Locked Material - MTL_Material_Transactions_Temp
   Pending Material - MTL_Transactions_Interface

Oracle Landed Cost Management
   Pending Landed Cost Management (INL) Interface - CST_Lc_Adj_Interface Interface

Project
   PA_Transaction_Interface_All

Purchasing
   PO_Requisitions_Interface_All

Purchasing (showing Receiving as the reported Functional Area)
   Pending Expense Receiving - RCV_Transactions_Interface
   Pending Inventory and OSP Receiving - RCV_Transactions_Interface
   Pending Intransit Receiving - RCV_Transactions_Interface
   Pending RMA Receiving - RCV_Transactions_Interface

Shipping
   Shipping - WSH_Delivery_Details

Warehouse Management System (WSM)
   Pending WSM Interface Transactions - WSM_Split_Merge_Txn_Interface
   Pending WSM Lot Interface Transactions - WSM_Lot_Split_Merges_Interface

Work in Process (Manufacturing)
   Pending Shop Floor Move Transactions - WIP_Move_Txn_Interface

-- |  Version Modified  Modified  by   Description
-- | ======== ========= =============== ================================================
-- |     1.0  1995      Initial Design  Originally based on sql from a project in 1995.
-- |     1.1  31-Jan-08 Douglas Volz    Added Operating Unit column to summary queries.
-- |     1.42 15-Jul-25 Douglas Volz    For Uncosted Transactions, checked for Process MFG
-- |                                    and added Ledger Security Controls for GL_Interface.
-- |     1.43 19-Jul-25 Douglas Volz    Changed LCM query to use the LCM short name 'INL' instead of 'CST'.
-- |     1.44 24-Aug-25 Douglas Volz    Changed Pending Material from Resolution Required to Recommended.
-- |  1.45    24 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Functional Area, Period Year, Period Name, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [financials_system_params_all](https://www.enginatics.com/library/?pg=1&find=financials_system_params_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [ap_invoices_interface](https://www.enginatics.com/library/?pg=1&find=ap_invoices_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [ap_interface_rejections](https://www.enginatics.com/library/?pg=1&find=ap_interface_rejections&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [ap_invoice_lines_interface](https://www.enginatics.com/library/?pg=1&find=ap_invoice_lines_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [ra_interface_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_interface_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [ra_interface_errors_all](https://www.enginatics.com/library/?pg=1&find=ra_interface_errors_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [ce_header_interface_errors](https://www.enginatics.com/library/?pg=1&find=ce_header_interface_errors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [gl_interface](https://www.enginatics.com/library/?pg=1&find=gl_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [mtl_material_transactions_temp](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [mtl_transactions_interface](https://www.enginatics.com/library/?pg=1&find=mtl_transactions_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wsm_split_merge_transactions](https://www.enginatics.com/library/?pg=1&find=wsm_split_merge_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [cst_lc_adj_interface](https://www.enginatics.com/library/?pg=1&find=cst_lc_adj_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [cst_lc_adj_interface_errors](https://www.enginatics.com/library/?pg=1&find=cst_lc_adj_interface_errors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wip_move_txn_interface](https://www.enginatics.com/library/?pg=1&find=wip_move_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wip_txn_interface_errors](https://www.enginatics.com/library/?pg=1&find=wip_txn_interface_errors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wsm_split_merge_txn_interface](https://www.enginatics.com/library/?pg=1&find=wsm_split_merge_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wsm_lot_split_merges_interface](https://www.enginatics.com/library/?pg=1&find=wsm_lot_split_merges_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wip_cost_txn_interface](https://www.enginatics.com/library/?pg=1&find=wip_cost_txn_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [pa_transaction_interface_all](https://www.enginatics.com/library/?pg=1&find=pa_transaction_interface_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [po_requisitions_interface_all](https://www.enginatics.com/library/?pg=1&find=po_requisitions_interface_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [po_interface_errors](https://www.enginatics.com/library/?pg=1&find=po_interface_errors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [rcv_transactions_interface](https://www.enginatics.com/library/?pg=1&find=rcv_transactions_interface&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wsh_delivery_details](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wsh_delivery_assignments](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wsh_new_deliveries](https://www.enginatics.com/library/?pg=1&find=wsh_new_deliveries&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wsh_delivery_legs](https://www.enginatics.com/library/?pg=1&find=wsh_delivery_legs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wsh_trip_stops](https://www.enginatics.com/library/?pg=1&find=wsh_trip_stops&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [wsh_exceptions_v](https://www.enginatics.com/library/?pg=1&find=wsh_exceptions_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [fnd_application](https://www.enginatics.com/library/?pg=1&find=fnd_application&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [fnd_product_installations](https://www.enginatics.com/library/?pg=1&find=fnd_product_installations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary)

## Related Reports
[CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [INV Intercompany Invoice Reconciliation](/INV%20Intercompany%20Invoice%20Reconciliation/ "INV Intercompany Invoice Reconciliation Oracle EBS SQL Report"), [INL Pending Actual Charges](/INL%20Pending%20Actual%20Charges/ "INL Pending Actual Charges Oracle EBS SQL Report"), [PO Invoice Price Variance](/PO%20Invoice%20Price%20Variance/ "PO Invoice Price Variance Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Interface%20Error%20Summary/CAC%20Interface%20Error%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Interface Error Summary 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/cac-interface-error-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary) |
| Blitz Report™ XML Import | [CAC_Interface_Error_Summary.xml](https://www.enginatics.com/xml/cac-interface-error-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary) |
| SQL Source | [CAC Interface Error Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Interface%20Error%20Summary/CAC%20Interface%20Error%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-interface-error-summary/](https://www.enginatics.com/reports/cac-interface-error-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary) |

## Case Study & Technical Analysis: CAC Interface Error Summary

### Executive Summary
The **CAC Interface Error Summary** is a comprehensive dashboard for monitoring the health of Oracle EBS data interfaces. It aggregates pending transactions and error records across critical Financial and Supply Chain modules (AP, AR, GL, Inventory, WIP, Purchasing, etc.). This report is an indispensable tool for the "Period Close" process, helping support teams quickly identify and resolve stuck transactions that could prevent the closing of accounting periods.

### Business Challenge
Closing the books at month-end requires that all transactions are processed.
*   **Fragmented Visibility**: Checking for errors usually requires logging into multiple different responsibilities (Inventory, Payables, Receivables) and running separate reports.
*   **Hidden Blockers**: Some interface errors (e.g., stuck material transactions) can silently prevent period close without obvious warnings until the close program is run.
*   **Efficiency**: Support teams waste time running individual diagnostic queries for each module.

### Solution
This report provides a "Single Pane of Glass" view of the interface landscape.
*   **Cross-Functional**: Covers over 10 different functional areas including AP, AR, Cost Management, GL, Inventory, and Purchasing.
*   **Prioritization**: Categorizes issues as "Resolution Required" (must fix to close period) or "Resolution Recommended" (good hygiene).
*   **Actionable**: Identifies the specific interface table and error count, directing support staff exactly where to look.

### Technical Architecture
The report is a union of multiple diagnostic queries:
*   **Inventory/WIP**: Checks `mtl_transactions_interface`, `mtl_material_transactions_temp`, and `wip_cost_txn_interface`.
*   **Finance**: Checks `ap_invoices_interface`, `ra_interface_lines_all`, and `gl_interface`.
*   **Logic**: It counts records that are either in an 'Error' state or have been pending processing for an unusual amount of time.
*   **Timezone Awareness**: For Supply Chain queries, it respects the legal entity's time zone to align with the Period Close form logic.

### Parameters
*   **None**: The report is designed to run as a full system health check. It automatically scans all relevant interface tables.

### Performance
*   **Fast Scan**: Despite covering many tables, the queries are designed to be lightweight "counts" or checks on status columns, which are typically indexed.
*   **Snapshot**: Provides a near real-time snapshot of the system's interface queues.

### FAQ
**Q: Does this fix the errors?**
A: No, it identifies *where* the errors are. You must use the standard Oracle interface exception forms or correction capabilities to fix the data.

**Q: Why are some items "Resolution Recommended"?**
A: Some interfaces (like GL Interface) do not technically block the closing of a subledger period, but leaving data in them is bad practice and leads to reconciliation issues later.

**Q: Can I run this daily?**
A: Yes, it is recommended to run this daily or weekly, not just at month-end, to prevent a backlog of errors.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-interface-error-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
