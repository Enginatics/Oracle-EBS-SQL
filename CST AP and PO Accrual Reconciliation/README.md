---
layout: default
title: 'CST AP and PO Accrual Reconciliation | Oracle EBS SQL Report'
description: 'Imported from Concurrent Program Application: Bills of Material Source: AP and PO Accrual Reconciliation Report Short Name: CSTACRAP'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CST, Accrual, Reconciliation, per_all_people_f, mtl_system_items_vl, cst_reconciliation_codes'
permalink: /CST%20AP%20and%20PO%20Accrual%20Reconciliation/
---

# CST AP and PO Accrual Reconciliation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-ap-and-po-accrual-reconciliation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from Concurrent Program
Application: Bills of Material
Source: AP and PO Accrual Reconciliation Report
Short Name: CSTACRAP


## Report Parameters
Operating Unit, Show Transaction Details, Balancing Segment From, Balancing Segment To, Accrual Account, Aging Period Days, Minimum Age in Days, Maximum Age in Days, Minimum Outstanding Balance, Maximum Outstanding Balance, Item, Vendor, PO Number, PO Release, PO Line, PO Shipment, Destination Type, Sort By

## Oracle EBS Tables Used
[per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [cst_reconciliation_codes](https://www.enginatics.com/library/?pg=1&find=cst_reconciliation_codes), [cst_ap_po_reconciliation](https://www.enginatics.com/library/?pg=1&find=cst_ap_po_reconciliation), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [cst_reconciliation_summary](https://www.enginatics.com/library/?pg=1&find=cst_reconciliation_summary), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [po_destination_types_all_v](https://www.enginatics.com/library/?pg=1&find=po_destination_types_all_v), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [cst_accrual_accounts](https://www.enginatics.com/library/?pg=1&find=cst_accrual_accounts), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [capr](https://www.enginatics.com/library/?pg=1&find=capr)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[PO Purchase Price Variance](/PO%20Purchase%20Price%20Variance/ "PO Purchase Price Variance Oracle EBS SQL Report"), [PO Cancelled Purchase Orders](/PO%20Cancelled%20Purchase%20Orders/ "PO Cancelled Purchase Orders Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Vendor Service Performance Analysis](/PO%20Vendor%20Service%20Performance%20Analysis/ "PO Vendor Service Performance Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST AP and PO Accrual Reconciliation 14-Jul-2021 041641.xlsx](https://www.enginatics.com/example/cst-ap-and-po-accrual-reconciliation/) |
| Blitz Report™ XML Import | [CST_AP_and_PO_Accrual_Reconciliation.xml](https://www.enginatics.com/xml/cst-ap-and-po-accrual-reconciliation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-ap-and-po-accrual-reconciliation/](https://www.enginatics.com/reports/cst-ap-and-po-accrual-reconciliation/) |

## Case Study & Technical Analysis: CST AP and PO Accrual Reconciliation

### 1. Executive Summary
The **CST AP and PO Accrual Reconciliation** report is a critical financial tool used to reconcile the **Accrual Accounts** (typically the "Inventory AP Accrual" or "Expense AP Accrual" accounts) between the **General Ledger (GL)**, **Purchasing (PO)**, and **Payables (AP)** subledgers. It identifies discrepancies between the estimated liability recorded upon receipt of goods/services (PO Receipt) and the actual liability recorded upon invoicing (AP Invoice).

This report is essential for the **Period End Accrual Process**, ensuring that the accrual account balance in the GL accurately reflects the "Received but Not Invoiced" liability. It helps organizations identify write-off candidates, fix process gaps (e.g., un-invoiced receipts, price variances), and support audit requirements.

### 2. Business Context & Usage
#### 2.1. Purpose
*   **Reconciliation:** Matches PO receipts (accruals) with AP invoices to ensure the accrual account clears to zero for fully processed transactions.
*   **Liability Tracking:** Provides a detailed breakdown of the outstanding accrual balance (Received Not Invoiced).
*   **Write-Off Identification:** Highlights old or mismatched transactions that will never be invoiced or matched, allowing users to write them off to clear the balance.
*   **Audit Support:** Serves as the subledger detail supporting the GL Accrual Account balance.

#### 2.2. Key Stakeholders
*   **Accounts Payable (AP) Department:** To resolve invoice matching holds and discrepancies.
*   **Purchasing Department:** To close old POs and resolve receipt issues.
*   **Cost Accounting / Inventory Team:** To monitor inventory accruals and write-offs.
*   **General Ledger (GL) Team:** To reconcile the GL balance for period close.

#### 2.3. Process Flow
1.  **PO Receipt:** Goods are received. The system debits Inventory/Expense and credits the Accrual Account (Estimated Liability).
2.  **AP Invoice:** Invoice is entered and matched to the PO/Receipt. The system debits the Accrual Account and credits Liability (AP).
3.  **Accrual Load Run:** The "Accrual Reconciliation Load Run" program populates the reconciliation tables (`CST_RECONCILIATION_SUMMARY`, `CST_AP_PO_RECONCILIATION`).
4.  **Report Generation:** This report is run to view the data populated by the load program.
5.  **Analysis & Action:** Users analyze the report to identify unmatched items, price variances, or "stuck" transactions.
6.  **Write-Off:** Irreconcilable differences are written off using the "Accrual Write-Off" form.

### 3. Technical Analysis
#### 3.1. Data Sources & Tables
The report relies on a set of specialized reconciliation tables populated by the **Accrual Load Run** program, joined with standard PO and AP tables for details.

*   **Core Reconciliation Tables:**
    *   `CST_RECONCILIATION_SUMMARY` (`CRS`): Stores the summarized balance for each PO Distribution. This is the primary driver for the report's logic regarding balances.
    *   `CST_AP_PO_RECONCILIATION` (`CAPR`): Contains the detailed transaction history (Receipts, Invoices, Write-offs) for each PO Distribution.
    *   `CST_RECONCILIATION_CODES` (`CRC`): Lookup table for transaction types (e.g., 'Invoice', 'Receive', 'Match').
    *   `CST_ACCRUAL_ACCOUNTS`: Stores the specific accrual accounts being reconciled.

*   **Standard Subledger Tables:**
    *   **Purchasing:** `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL`, `PO_DISTRIBUTIONS_ALL`, `PO_RELEASES_ALL`, `RCV_TRANSACTIONS`, `RCV_SHIPMENT_HEADERS`.
    *   **Payables:** `AP_INVOICES_ALL`, `AP_INVOICE_DISTRIBUTIONS_ALL`.
    *   **Inventory/Items:** `MTL_SYSTEM_ITEMS_VL`, `MTL_PARAMETERS`.
    *   **GL/Org:** `GL_CODE_COMBINATIONS`, `HR_ALL_ORGANIZATION_UNITS`.

#### 3.2. Key Logic & Calculations
*   **Balances:** The report calculates three key balances from `CST_RECONCILIATION_SUMMARY`:
    *   `PO_BALANCE`: Value of receipts (Quantity Received * PO Price).
    *   `AP_BALANCE`: Value of invoices matched (Quantity Billed * Invoice Price).
    *   `WRITE_OFF_BALANCE`: Value of any write-offs performed.
    *   `TOTAL_BALANCE`: The net outstanding balance (`PO_BALANCE` + `AP_BALANCE` + `WRITE_OFF_BALANCE`). Ideally, this should be zero for closed transactions.

*   **Aging:** The report calculates the age of the accrual entry to help prioritize old items.
    *   Logic: `sysdate - greatest(last_receipt_date, last_invoice_date)`.
    *   Profile Option: `CST_ACCRUAL_AGE_IN_DAYS` determines if aging is based on the last activity date or the initial transaction date.

*   **Transaction Source:**
    *   Determined by the presence of `INVOICE_DISTRIBUTION_ID` (AP) or `WRITE_OFF_ID` (WO). If neither, it is a PO Receipt.

#### 3.3. Parameters
*   **Operating Unit:** Filters by the relevant financial entity.
*   **Balancing Segment (From/To):** Allows filtering by specific GL balancing segments (e.g., Company Code).
*   **Accrual Account:** Filters for a specific GL account being reconciled.
*   **Aging Parameters (Days, Min/Max Balance):** Filters to focus on high-value or old items.
*   **Show Transaction Details:** Toggle to show every receipt/invoice line or just the summary per PO distribution.

### 4. Common Issues & Troubleshooting
*   **Data Not Appearing:** The "Accrual Reconciliation Load Run" program must be run *before* this report. If the load program hasn't run or failed, the report will be empty or stale.
*   **Balances Don't Match GL:**
    *   Manual journal entries to the accrual account in GL are *not* captured by this subledger report.
    *   Transactions occurring after the last "Load Run" will not be reflected.
*   **Performance:** The report can be slow if the `CST_AP_PO_RECONCILIATION` table is very large. Regular purging (via "Accrual Write-Off") and archiving is recommended.
*   **"Stuck" Balances:** Often caused by:
    *   Receipts not invoiced (RNI).
    *   Invoices entered but not matched to the PO.
    *   Currency exchange rate variances.
    *   Rounding differences.

### 5. SQL Query Structure
The query uses a Common Table Expression (CTE) named `capr` to pre-calculate and format the main dataset.
1.  **CTE `capr`:** Joins `CST_RECONCILIATION_SUMMARY` and `CST_AP_PO_RECONCILIATION` with PO, AP, and GL tables.
    *   Derives `ledger`, `operating_unit`, and GL segments.
    *   Calculates `age_in_days` and `aging_period`.
    *   Formats PO and Invoice references.
2.  **Main Select:** Selects from the `capr` CTE.
    *   Applies filtering based on the parameters (Aging, Balances, Account, etc.).
    *   Handles the "Show Transaction Details" logic (though the provided SQL seems to pull details by default, the standard report often groups them).

This structure allows for a flexible, high-performance extract that can be easily pivoted in Excel (via Blitz Report) to analyze the accrual reconciliation status.


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
