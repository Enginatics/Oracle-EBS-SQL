---
layout: default
last_modified_at: 2026-10-16
title: 'AP Invoices and Lines 11i | Oracle EBS SQL Report'
description: 'Detail Invoice Aging report with line item details and amounts. The Approval Status column and parameter show and filter the status of the invoice in the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, Invoices, Lines, 11i, gl_period_statuses, gl_daily_conversion_types, ap_holds_all'
permalink: /AP%20Invoices%20and%20Lines%2011i/
report_name: 'AP Invoices and Lines 11i'
report_web_name: ap-invoices-and-lines-11i
module: 'Payables'
module_url: /modules/payables/
---

# AP Invoices and Lines 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoices-and-lines-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
Detail Invoice Aging report with line item details and amounts.

The Approval Status column and parameter show and filter the status of the invoice in the Invoice Approval Workflow.

On withholding tax distributions, the withholding columns show the withholding tax and rate, the tax authority supplier and site of the tax, the gross amount subject to withholding, the payment that created the withholding when it was calculated at payment, and the invoice raised to the tax authority.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Operating Unit, Aging Bucket Name, Display Level, Supplier, Supplier Site, Invoice Number, Invoice Date Period, Invoice Date From, Invoice Date To, Invoice Creation Period, Invoice Creation Date From, Invoice Creation Date To, Accounting Period, Accounting Date From, Accounting Date To, Payment Period, Payment Date From, Payment Date To, Open only, Days Overdue, Invoice Type, Invoice Status, Approval Status, Payment Status, Distribution Type, Exclude Cancelled, Invoice PO Matched, Invoice on Hold, Hold Name, Has Attachment, Expense Account From, Expense Account To, Show DFF Attributes

## Oracle EBS Tables Used
[gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_holds_all](https://www.enginatics.com/library/?pg=1&find=ap_holds_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [fnd_attached_documents](https://www.enginatics.com/library/?pg=1&find=fnd_attached_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [fnd_documents_vl](https://www.enginatics.com/library/?pg=1&find=fnd_documents_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_accounting_events_all](https://www.enginatics.com/library/?pg=1&find=ap_accounting_events_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_tax_codes_all](https://www.enginatics.com/library/?pg=1&find=ap_tax_codes_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_awt_tax_rates_all](https://www.enginatics.com/library/?pg=1&find=ap_awt_tax_rates_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [po_vendor_sites_all](https://www.enginatics.com/library/?pg=1&find=po_vendor_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ap_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_bank_accounts_all](https://www.enginatics.com/library/?pg=1&find=ap_bank_accounts_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_bank_branches](https://www.enginatics.com/library/?pg=1&find=ap_bank_branches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_recurring_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_recurring_payments_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [ap_terms](https://www.enginatics.com/library/?pg=1&find=ap_terms&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i)

## Related Reports
[AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoices%20and%20Lines%2011i/AP%20Invoices%20and%20Lines%2011i.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Invoices and Lines 11i 03-Sep-2024 053525.xlsx](https://www.enginatics.com/example/ap-invoices-and-lines-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i) |
| Blitz Report™ XML Import | [AP_Invoices_and_Lines_11i.xml](https://www.enginatics.com/xml/ap-invoices-and-lines-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i) |
| SQL Source | [AP Invoices and Lines 11i.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoices%20and%20Lines%2011i/AP%20Invoices%20and%20Lines%2011i.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-invoices-and-lines-11i/](https://www.enginatics.com/reports/ap-invoices-and-lines-11i/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i) |

## Case Study & Technical Analysis: AP Invoices and Lines

### 1. Executive Summary

#### Business Problem
Managing Accounts Payable requires deep visibility into invoice details to ensure timely payments, accurate accounting, and effective cash flow management. Standard Oracle reports often provide either a high-level summary (Aging) or specific transactional details (Register), but rarely combine both effectively. Finance teams struggle with:
*   **Hold Resolution:** Identifying why invoices are blocked from payment (e.g., Price Variance, Qty Received).
*   **Reconciliation:** Verifying that invoice header totals match the sum of lines, taxes, and freight.
*   **Aging Analysis:** Understanding the detailed composition of overdue balances.
*   **Audit Compliance:** Tracing invoices back to their source (PO, Receipt) and verifying approval status.

#### Solution Overview
The **AP Invoices and Lines** report is a comprehensive operational tool that bridges the gap between high-level aging and detailed transaction analysis. It provides a flattened view of AP data, combining Invoice Headers, Lines, Payment Schedules, and Hold details into a single, pivot-friendly dataset. This allows AP Managers and Accountants to drill down from a supplier's total outstanding balance to the specific line items and hold reasons causing delays.

#### Key Benefits
*   **Holistic View:** Combines Header, Line, and Payment Schedule data in one report.
*   **Hold Management:** Detailed visibility into active holds, including the user who placed them and the date.
*   **Financial Accuracy:** distinct columns for Item, Tax, Freight, and Miscellaneous amounts to ensure accurate sub-ledger reporting.
*   **Aging Insight:** Dynamic calculation of "Days Due" and aging buckets for precise cash flow forecasting.
*   **Process Efficiency:** Reduces the time spent navigating multiple Oracle screens to gather invoice status information.

### 2. Technical Analysis

#### Core Tables and Views
The report queries the core AP transactional tables:
*   **`AP_INVOICES_ALL`**: Primary header table containing invoice number, supplier, dates, and status.
*   **`AP_INVOICE_LINES_ALL`**: Detailed line items (Item, Tax, Freight).
*   **`AP_PAYMENT_SCHEDULES_ALL`**: Tracks due dates, remaining balances, and payment status.
*   **`AP_HOLDS_ALL`**: Stores details on invoice holds.
*   **`PO_HEADERS_ALL` / `PO_LINES_ALL`**: Linked for PO-matched invoices.
*   **`XLA_EVENTS` / `XLA_TRANSACTION_ENTITIES`**: Used to derive the accounting status.

#### SQL Logic and Data Flow
The SQL is designed to handle the one-to-many relationships inherent in AP data (One Invoice -> Many Lines -> Many Holds).
*   **Denormalization:** The query flattens the hierarchy, repeating header information for each line item. This is optimized for Excel pivot tables.
*   **Calculated Fields:**
    *   **`invoice_total`**: Dynamically calculated as (Item + Tax + Freight + Misc - Prepayments - Withholding).
    *   **`days_due`**: Calculated based on the system date versus the due date.
    *   **`invoice_status`**: Derived logic to determine if an invoice is 'Validated', 'Needs Revalidation', or 'Cancelled'.
*   **Utility Functions:** Uses `ap_invoices_utility_pkg` to fetch summarized totals (e.g., `get_item_total`, `get_tax_total`) ensuring consistency with Oracle forms.
*   **Conditional Decoding:** Uses `decode(ap_inv.first_invoice,'Y', ...)` to ensure that header-level amounts (like Invoice Amount) are only summed once per invoice when aggregating lines, preventing double-counting in pivot tables.

#### Integration Points
*   **Purchasing:** Links to POs for matching details.
*   **General Ledger:** Provides GL Dates and Account Code Combinations.
*   **Payments:** Links to `AP_CHECKS_ALL` (via payment schedules) to show payment history.
*   **SLA (Subledger Accounting):** Links to XLA tables for accounting status.

### 3. Functional Capabilities

#### Reporting Dimensions
*   **Supplier Analysis:** Group by Supplier and Site to see total liability.
*   **Aging:** Analyze open balances by Due Date buckets (Current, 1-30, 31-60, etc.).
*   **Status Tracking:** Filter by 'Invoice on Hold' to target problem invoices.
*   **Expense Analysis:** Analyze spend by GL Account or Cost Center (derived from distribution lines).

#### Key Parameters
*   **Date Ranges:** Invoice Date, GL Date, Creation Date.
*   **Status Filters:** Invoice Status (Validated, Cancelled), Payment Status (Paid, Unpaid, Partial).
*   **Hold Filters:** Filter by specific Hold Names (e.g., "Qty Recv", "Max Ship Amount").
*   **Supplier/Invoice:** Filter for specific vendors or transaction numbers.

### 4. Implementation Considerations

#### Performance
*   **Data Volume:** For high-volume environments, it is recommended to run this report for specific date ranges or Supplier groups to avoid performance issues.
*   **Indexing:** Ensure standard Oracle indexes on `AP_INVOICES_ALL` (Invoice Date, Vendor ID) are active.

#### Best Practices
*   **Pivot Tables:** The output is designed for Excel Pivot Tables. Users should be trained to use the "First Invoice" flag or specific Line Amount columns to avoid double-counting header totals.
*   **Month-End Close:** Use this report during month-end to identify unvalidated invoices or those on hold that need resolution before the period closes.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoices-and-lines-11i)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
