---
layout: default
title: 'CST Miscellaneous Accrual Reconciliation | Oracle EBS SQL Report'
description: 'Imported from Concurrent Program Application: Bills of Material Source: Miscellaneous Accrual Reconciliation Report Short Name: CSTACRMI DB package:'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CST, Miscellaneous, Accrual, Reconciliation, mtl_transaction_types, cst_reconciliation_codes, rcv_shipment_headers'
permalink: /CST%20Miscellaneous%20Accrual%20Reconciliation/
---

# CST Miscellaneous Accrual Reconciliation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-miscellaneous-accrual-reconciliation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from Concurrent Program
Application: Bills of Material
Source: Miscellaneous Accrual Reconciliation Report
Short Name: CSTACRMI
DB package:

## Report Parameters
Operating Unit, Balancing Segment From, Balancing Segment To, Accrual Account, Date From, Date To, Minimum Amount, Maximum Amount, Item From, Item To, Invoice Number, Invoice Line, PO Number, PO Release, PO Line, PO Shipment, Transaction Type, Inventory Transaction Id, Sort By

## Oracle EBS Tables Used
[mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [cst_reconciliation_codes](https://www.enginatics.com/library/?pg=1&find=cst_reconciliation_codes), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [cst_misc_reconciliation](https://www.enginatics.com/library/?pg=1&find=cst_misc_reconciliation), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [cst_accrual_accounts](https://www.enginatics.com/library/?pg=1&find=cst_accrual_accounts), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [cmr](https://www.enginatics.com/library/?pg=1&find=cmr)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CST AP and PO Accrual Reconciliation](/CST%20AP%20and%20PO%20Accrual%20Reconciliation/ "CST AP and PO Accrual Reconciliation Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [PO Headers and Lines 11i](/PO%20Headers%20and%20Lines%2011i/ "PO Headers and Lines 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Miscellaneous Accrual Reconciliation 14-Jul-2021 041456.xlsx](https://www.enginatics.com/example/cst-miscellaneous-accrual-reconciliation/) |
| Blitz Report™ XML Import | [CST_Miscellaneous_Accrual_Reconciliation.xml](https://www.enginatics.com/xml/cst-miscellaneous-accrual-reconciliation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-miscellaneous-accrual-reconciliation/](https://www.enginatics.com/reports/cst-miscellaneous-accrual-reconciliation/) |

## Case Study & Technical Analysis: CST Miscellaneous Accrual Reconciliation

### 1. Executive Summary
The **CST Miscellaneous Accrual Reconciliation** report is a specialized financial tool designed to reconcile **Inventory Accrual Accounts** for transactions that are *not* standard Purchase Order receipts. While the primary "AP and PO Accrual Reconciliation" report handles standard procurement, this report focuses on **Inventory** and **Payables** transactions that hit the accrual account but originate from other sources, such as:
*   **Consignment Inventory** transactions.
*   **Internal Sales Orders (ISO)** and **Internal Requisitions (IR)**.
*   **Miscellaneous Receipts** or Issues that impact the accrual account.
*   **AP Invoices** matched to consignment or other non-standard PO lines.

This report is crucial for identifying "noise" in the accrual account that cannot be cleared by the standard PO matching process, ensuring the General Ledger (GL) balance is accurate at period end.

### 2. Business Context & Usage
#### 2.1. Purpose
*   **Reconciliation:** Matches inventory transactions (e.g., Consignment usage) with their corresponding AP invoices.
*   **Exception Handling:** Identifies transactions that are stuck in the accrual account because they don't fit the standard "PO Receipt -> AP Match" flow.
*   **Internal Orders:** Helps reconcile the inter-org transfer accruals (though often handled by separate processes, they can appear here).
*   **Audit Trail:** Provides a detailed listing of miscellaneous debits and credits to the accrual account.

#### 2.2. Key Stakeholders
*   **Cost Accounting:** To monitor consignment usage and inventory adjustments.
*   **Accounts Payable:** To resolve invoice matching issues related to consignment or special procurement.
*   **Inventory Management:** To track miscellaneous transactions affecting financial balances.

#### 2.3. Process Flow
1.  **Inventory Transaction:** A user performs a transaction (e.g., "Transfer to Regular" for consignment stock). This credits the Consignment Liability (Accrual) account.
2.  **AP Invoice:** An invoice is created for the consumed consignment stock. This debits the Accrual account.
3.  **Accrual Load Run:** The "Accrual Reconciliation Load Run" program populates the `CST_MISC_RECONCILIATION` table.
4.  **Report Generation:** This report is run to view the unmatched or partially matched miscellaneous transactions.
5.  **Analysis:** Users identify items that should have cleared or need manual write-off.

### 3. Technical Analysis
#### 3.1. Data Sources & Tables
The report relies on the `CST_MISC_RECONCILIATION` table, which is populated by the Accrual Load program. It joins this data with standard inventory and AP tables.

*   **Core Reconciliation Table:**
    *   `CST_MISC_RECONCILIATION` (`CMR`): The primary table storing the reconciled and unreconciled miscellaneous transactions. It holds both the Inventory side and the AP side of the entries.

*   **Standard Subledger Tables:**
    *   **Inventory:** `MTL_MATERIAL_TRANSACTIONS` (`MMT`), `MTL_SYSTEM_ITEMS_VL`, `MTL_PARAMETERS`, `MTL_TRANSACTION_TYPES`.
    *   **Payables:** `AP_INVOICES_ALL`, `AP_INVOICE_DISTRIBUTIONS_ALL`.
    *   **Purchasing:** `PO_VENDORS`, `PO_HEADERS_ALL`, `PO_LINES_ALL` (linked via distributions if applicable).
    *   **GL:** `GL_CODE_COMBINATIONS`.

#### 3.2. Key Logic & Calculations
*   **Transaction Source:**
    *   The query determines the source based on `INVOICE_DISTRIBUTION_ID`.
    *   If `NULL`, it is an **Inventory** transaction (`INV`).
    *   If populated, it is an **Accounts Payable** transaction (`AP`).
*   **Transaction Type:**
    *   For Inventory: Derived from `MTL_TRANSACTION_TYPES` (e.g., "Consignment Logical Receive").
    *   For AP: Derived from `CST_RECONCILIATION_CODES` (e.g., "Invoice Price Variance").
*   **Balances:** Unlike the PO Accrual report which summarizes by PO distribution, this report is often more transactional, listing individual debits and credits to help users manually reconcile complex scenarios.

#### 3.3. Parameters
*   **Operating Unit:** Filters by the relevant financial entity.
*   **Balancing Segment / Accrual Account:** Targets specific GL accounts.
*   **Date Range:** Filters transactions by date (crucial for period-end analysis).
*   **Amount Min/Max:** Helps filter for material discrepancies.
*   **Transaction Type:** Allows focusing specifically on "Inventory" or "AP" side entries.
*   **Inventory Transaction Id:** For investigating a specific material movement.

### 4. Common Issues & Troubleshooting
*   **Consignment Issues:** The most common use case. If the "Transfer to Regular" transaction doesn't match the AP invoice (due to price or quantity differences), it remains on this report.
*   **Timing Differences:** Inventory transactions might happen in one period, while the invoice arrives in the next.
*   **Wrong Account:** If a miscellaneous receipt was manually coded to the Accrual Account by mistake, it will appear here and likely never clear automatically.
*   **Load Program:** Like the PO Accrual report, this depends entirely on the "Accrual Reconciliation Load Run" being up to date.

### 5. SQL Query Structure
The query uses a Common Table Expression (CTE) named `cmr` to prepare the data.
1.  **CTE `cmr`:** Joins `CST_MISC_RECONCILIATION` with the necessary master data tables.
    *   **Logic:** It uses `DECODE` statements to switch between Inventory and AP logic for fields like `Transaction Type` and `UOM`.
    *   **Joins:** It links to `MTL_MATERIAL_TRANSACTIONS` to get the underlying inventory details (like `rcv_transaction_id` for receipt numbers).
2.  **Main Select:** Selects from the `cmr` CTE.
    *   Applies the user parameters (Date, Amount, Account).
    *   Formats the output for the report (Excel/PDF).

This structure provides a unified view of disparate transaction types that share the common characteristic of hitting the Accrual Account outside the standard PO flow.


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
