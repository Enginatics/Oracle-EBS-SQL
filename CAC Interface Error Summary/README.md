---
layout: default
title: 'CAC Interface Error Summary | Oracle EBS SQL Report'
description: 'Use this report to view your transactions that are pending or have errors in the Oracle interface tables. Across both Financial and Supply Chain…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting - Other, Enginatics, CAC, Interface, Error, Summary, gl_ledgers, hr_organization_information, hr_all_organization_units_vl'
permalink: /CAC%20Interface%20Error%20Summary/
---

# CAC Interface Error Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-interface-error-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

Parameters
==========
Functional Area:  Cash Management, Cost Management, General Ledger, Inventory, Payables, Work in Process (Manufacturing), Oracle Landed Cost Management, Projects, Purchasing, Receivables, Shipping, Warehouse Management System (WSM) (optional).
Period Name:  Enter the desired period(s) to report (optional)
Organization Code:  specific inventory organization to report (optional)
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

Note:  To avoid excessive run times., one of the above parameters must be entered in order to run this report.

-- |  Version Modified  Modified  by   Description
-- | ======== ========= =============== ================================================
-- |     1.0  1995      Initial Design  Originally based on sql from a project in 1995.
-- |     1.1  31-Jan-08 Douglas Volz    Added Operating Unit column to summary queries.
-- |     1.42 15-Jul-25 Douglas Volz    For Uncosted Transactions, checked for Process MFG
-- |                                    and added Ledger Security Controls for GL_Interface.
-- |     1.43 19-Jul-25 Douglas Volz    Changed LCM query to use the LCM short name 'INL' instead of 'CST'.
-- |     1.44 24-Aug-25 Douglas Volz    Changed Pending Material from Resolution Required to Recommended.
-- +=============================================================================+*/

## Report Parameters
Functional Area, Period Year, Period Name, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [financials_system_params_all](https://www.enginatics.com/library/?pg=1&find=financials_system_params_all), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [ap_invoices_interface](https://www.enginatics.com/library/?pg=1&find=ap_invoices_interface), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_product_installations](https://www.enginatics.com/library/?pg=1&find=fnd_product_installations), [gl_ou](https://www.enginatics.com/library/?pg=1&find=gl_ou), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [ap_interface_rejections](https://www.enginatics.com/library/?pg=1&find=ap_interface_rejections), [ap_invoice_lines_interface](https://www.enginatics.com/library/?pg=1&find=ap_invoice_lines_interface), [ra_interface_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_interface_lines_all), [ra_interface_errors_all](https://www.enginatics.com/library/?pg=1&find=ra_interface_errors_all), [hz_cust_accounts_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts_all), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties)

## Report Categories
[Cost Accounting - Other](https://www.enginatics.com/library/?pg=1&category[]=Cost%20Accounting%20-%20Other), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Interface Error Summary 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/cac-interface-error-summary/) |
| Blitz Report™ XML Import | [CAC_Interface_Error_Summary.xml](https://www.enginatics.com/xml/cac-interface-error-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-interface-error-summary/](https://www.enginatics.com/reports/cac-interface-error-summary/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
