---
layout: default
last_modified_at: 2026-10-16
title: 'CST Uninvoiced Receipts | Oracle EBS SQL Report'
description: 'Application: Bills of Material Description: Uninvoiced Receipts Report Templates: Select a template to show Accruals summarized by - PO/Release…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Management, Enginatics, R12 only, CST, Uninvoiced, Receipts, po_vendor_sites_all, mtl_parameters, rcv_transactions'
permalink: /CST%20Uninvoiced%20Receipts/
report_name: 'CST Uninvoiced Receipts'
report_web_name: cst-uninvoiced-receipts
module: 'Cost Management'
module_url: /modules/cost-management/
---

# CST Uninvoiced Receipts – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-uninvoiced-receipts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts).
**Oracle EBS module:** [Cost Management](/modules/cost-management/ "Oracle EBS Cost Management reports") · [all Cost Management reports](/modules/cost-management/)  

## Overview
Application: Bills of Material
Description: Uninvoiced Receipts Report
Templates: Select a template to show Accruals summarized by 
- PO/Release Distributions (Default)
- PO/Release Shipments
- PO/Release Lines

Each template includes a Pivot summarizing the accruals by Accrual Account and the Pivot/Sort Parameter Value (Vendor, Category, PO/Release Number)

Source: Uninvoiced Receipts Report
Short Name: CSTACREP
DB Package: XXEN_CST

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Accrued Receipts, Include Online Accruals, Include Closed POs, Categories From, Categories To, Minimum Accrual Amount, Period Name, Vendors From, Vendors To, Sort/Pivot By, Dynamic Precision Option, DFF Display

## Oracle EBS Tables Used
[po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [cst_per_end_accruals_temp](https://www.enginatics.com/library/?pg=1&find=cst_per_end_accruals_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [po_line_types](https://www.enginatics.com/library/?pg=1&find=po_line_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts)

## Related Reports
[CST AP and PO Accrual Reconciliation](/CST%20AP%20and%20PO%20Accrual%20Reconciliation/ "CST AP and PO Accrual Reconciliation Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Uninvoiced%20Receipts/CST%20Uninvoiced%20Receipts.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Uninvoiced Receipts - Accruals by PO Release Distributions 27-Dec-2024 100620.xlsx](https://www.enginatics.com/example/cst-uninvoiced-receipts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts) |
| Blitz Report™ XML Import | [CST_Uninvoiced_Receipts.xml](https://www.enginatics.com/xml/cst-uninvoiced-receipts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts) |
| SQL Source | [CST Uninvoiced Receipts.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CST%20Uninvoiced%20Receipts/CST%20Uninvoiced%20Receipts.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cst-uninvoiced-receipts/](https://www.enginatics.com/reports/cst-uninvoiced-receipts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts) |

## Case Study & Technical Analysis: CST Uninvoiced Receipts

### 1. Executive Summary
The **CST Uninvoiced Receipts** report is a standard Oracle Cost Management report used to support the **Period End Accrual** process. It provides a detailed listing of all Purchase Order receipts that have been accrued (received) but not yet fully invoiced as of a specific period end.

Unlike the "Accrual Reconciliation" reports which are based on a snapshot table (`CST_RECONCILIATION_SUMMARY`) populated by a load program, this report is often run directly against the transactional tables (or a temporary table `CST_PER_END_ACCRUALS_TEMP` depending on the version/mode) to validate the General Ledger accrual balance. It is the primary audit report for the "Received Not Invoiced" liability.

### 2. Business Context & Usage
#### 2.1. Purpose
*   **Period End Validation:** To substantiate the balance in the Accrual Account at the end of a financial period.
*   **Liability Estimation:** To determine the company's outstanding liability to suppliers for goods received.
*   **Audit Compliance:** Auditors use this report to verify that the liability recorded in the GL matches the detailed subledger transactions.
*   **Aging Analysis:** Helps identify old receipts that haven't been invoiced, which might indicate process failures or lost invoices.

#### 2.2. Key Stakeholders
*   **General Ledger (GL) Team:** To book period-end accrual entries (if using On-Receipt Accrual) or to reverse/book entries (if using Period-End Accrual).
*   **Accounts Payable (AP):** To investigate why receipts haven't been invoiced.
*   **Purchasing:** To close out old POs that will never be invoiced.

#### 2.3. Process Flow
1.  **Receipt:** Goods are received.
    *   *On-Receipt Accrual (Inventory):* Liability is booked immediately.
    *   *Period-End Accrual (Expense):* Liability is not booked until period end.
2.  **Period Close:** The "Uninvoiced Receipts Report" is run.
3.  **GL Posting:**
    *   For Expense items, the report output is used to create a manual or automated reversing journal entry for the liability.
    *   For Inventory items, the report serves as the subledger detail for the existing GL balance.
4.  **Reconciliation:** The report total is compared to the GL Accrual Account balance.

### 3. Technical Analysis
#### 3.1. Data Sources & Tables
The report logic depends on whether it's running for "On-Receipt" or "Period-End" accruals, but generally involves:

*   **Core Transaction Tables:**
    *   `RCV_TRANSACTIONS` (`RT`): The source of truth for receipts.
    *   `RCV_SHIPMENT_HEADERS` (`RSH`): Receipt header details (Receipt Number, Date).
    *   `CST_PER_END_ACCRUALS_TEMP` (`CPEA`): A temporary table often populated by the "Accrual Load" or "Period End Accrual" concurrent program to store the calculated accrual values for the report.

*   **Purchasing Tables:**
    *   `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL`, `PO_DISTRIBUTIONS_ALL`, `PO_RELEASES_ALL`.
    *   `PO_VENDORS`.

*   **GL/Org:**
    *   `GL_CODE_COMBINATIONS`, `GL_SETS_OF_BOOKS`.

#### 3.2. Key Logic & Calculations
*   **Accrual Amount:**
    *   Calculated as `(Quantity Received - Quantity Billed) * PO Price`.
    *   If `Quantity Billed` > `Quantity Received`, the accrual is zero (or negative depending on specific logic/bugs, but typically this report focuses on positive liability).
*   **Currency Conversion:**
    *   The report handles both PO currency and Functional currency.
    *   `Accrual Amount` (PO Currency) vs `Functional Accrual Amount` (Ledger Currency).
*   **Aging:**
    *   `Age in Days` = `Report Date` - `Receipt Date`.
*   **Precision:**
    *   The SQL includes logic for `Dynamic Precision Option` to handle rounding differences between the PO definition and the currency definition.

#### 3.3. Parameters
*   **Accrued Receipts:** Choose to report on "On Receipt" (Inventory) or "Period End" (Expense) accruals.
*   **Include Online Accruals:** Whether to include receipts that accrue immediately.
*   **Include Closed POs:** Critical for finding "stuck" accruals on closed orders.
*   **Period Name:** The target financial period for the snapshot.
*   **Minimum Accrual Amount:** Filters out negligible balances.
*   **Category/Vendor:** For targeted analysis.

### 4. Common Issues & Troubleshooting
*   **Report vs. GL Mismatch:**
    *   Manual journal entries in GL.
    *   Transactions occurring after the report snapshot was taken.
    *   Exchange rate variances.
*   **Negative Balances:** Can occur if an invoice was matched to a receipt that was later returned (RTV) without a credit memo, or over-invoicing.
*   **Performance:** The report can be slow if `CST_PER_END_ACCRUALS_TEMP` is large or if the query runs directly against `RCV_TRANSACTIONS` without proper indexing.
*   **"Ghost" Receipts:** Receipts on cancelled lines or closed POs that still show up.

### 5. SQL Query Structure
The provided SQL is a direct extraction query, likely designed to replace the standard Oracle RDF report with a Blitz Report Excel extract.
1.  **Inner Query (Aggregation):**
    *   Selects from `CST_PER_END_ACCRUALS_TEMP` (aliased as `x` or implied in the source).
    *   Joins to PO and RCV tables.
    *   Calculates `line_qty_accrued`, `ship_qty_accrued` using window functions (`SUM OVER PARTITION`) to allow drilling down from Summary to Detail.
2.  **Outer Query (Formatting):**
    *   Formats the unit prices and amounts based on the precision parameters.
    *   Handles the `Pivot Sort Value` logic to allow dynamic grouping in the Excel output.
    *   Constructs user-friendly columns like `PO (Release) Number`.

This structure allows the report to serve multiple purposes: a high-level summary for the Controller and a detailed transaction list for the AP Clerk.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cst-uninvoiced-receipts)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
