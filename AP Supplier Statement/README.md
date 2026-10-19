---
layout: default
last_modified_at: 2026-10-19
title: 'AP Supplier Statement | Oracle EBS SQL Report'
description: 'Application: Payables Source: Supplier Statement Short Name: APTPSTMT DB package: APTPSTMTPKG When India Localization is installed, the following GST…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, R12 only, Supplier, Statement, gl_code_combinations_kfv, ap_invoices, ap_suppliers'
permalink: /AP%20Supplier%20Statement/
report_name: 'AP Supplier Statement'
report_web_name: ap-supplier-statement
module: 'Payables'
module_url: /modules/payables/
---

# AP Supplier Statement – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-supplier-statement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
Application: Payables
Source: Supplier Statement
Short Name: APTPSTMT
DB package: AP_TP_STMT_PKG

When India Localization is installed, the following GST columns are also included: GST Registration No, GST PAN No, GST TAN No, CESS Amount, CESS Rate, CGST Amount, CGST Non-Recoverable, CGST Recoverable, CGST Rate, Custom Amount, IGST Amount, IGST Non-Recoverable, IGST Recoverable, IGST Rate, Reverse Charge Flag, SGST Amount, SGST Non-Recoverable, SGST Recoverable, SGST Rate, Unclassified Tax Amount, Taxable Value, HSN SAC Code.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Reporting Level, Reporting Context, GL Date From, GL Date To, Document Date From, Document Date To, Supplier Name From, Supplier Name To, Currency, Pay Group, Vendor Type, Include Zero Balance Suppliers, Include Unvalidated Transactions, Include Unapproved Transaction, Accounted Transactions, Report Level, Summarization Level

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement), [ap_invoices](https://www.enginatics.com/library/?pg=1&find=ap_invoices&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement), [ap_lookup_codes](https://www.enginatics.com/library/?pg=1&find=ap_lookup_codes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement), [ap_prepay_history](https://www.enginatics.com/library/?pg=1&find=ap_prepay_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement), [ap_invoice_payments](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement), [ap_checks](https://www.enginatics.com/library/?pg=1&find=ap_checks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [AP Accounted Invoice Aging](/AP%20Accounted%20Invoice%20Aging/ "AP Accounted Invoice Aging Oracle EBS SQL Report"), [AP Suppliers](/AP%20Suppliers/ "AP Suppliers Oracle EBS SQL Report"), [AP Invoice Payments 11g](/AP%20Invoice%20Payments%2011g/ "AP Invoice Payments 11g Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Supplier%20Statement/AP%20Supplier%20Statement.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Supplier Statement 28-Apr-2021 200101.xlsx](https://www.enginatics.com/example/ap-supplier-statement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement) |
| Blitz Report™ XML Import | [AP_Supplier_Statement.xml](https://www.enginatics.com/xml/ap-supplier-statement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement) |
| SQL Source | [AP Supplier Statement.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Supplier%20Statement/AP%20Supplier%20Statement.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-supplier-statement/](https://www.enginatics.com/reports/ap-supplier-statement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement) |

## Case Study & Technical Analysis: AP Supplier Statement

### 1. Executive Summary

#### Business Problem
Supplier relationships are often strained by communication gaps regarding payment status. Vendors frequently contact Accounts Payable asking, "Have you received Invoice X?", "When will you pay Invoice Y?", or "Why was my payment short?". Answering these queries manually is time-consuming and inefficient.

#### Solution Overview
The **AP Supplier Statement** is a comprehensive, external-facing document designed to be sent directly to vendors. It provides a complete history of the account, including:
*   **Invoices:** Received, Validated, and Approved status.
*   **Payments:** Check numbers, dates, and amounts.
*   **Credits:** Applied Credit Memos and Prepayments.
*   **Balance:** The net outstanding amount owed to the supplier.

#### Key Benefits
*   **Self-Service:** Can be scheduled and emailed to suppliers automatically (using Blitz Report's email distribution), reducing helpdesk calls.
*   **Reconciliation:** Helps vendors reconcile their books with yours, identifying missing invoices or misapplied payments early.
*   **Professionalism:** Provides a polished, accurate statement of account, improving vendor relations.

### 2. Technical Analysis

#### Core Tables and Views
*   **`AP_INVOICES_ALL`**: The primary source for invoice details.
*   **`AP_CHECKS_ALL`**: Payment details.
*   **`AP_INVOICE_PAYMENTS_ALL`**: The link between Invoices and Payments (showing which invoice was paid by which check).
*   **`AP_SUPPLIERS` / `AP_SUPPLIER_SITES_ALL`**: Vendor master data.
*   **`HR_OPERATING_UNITS`**: Organization context.

#### SQL Logic and Data Flow
The report typically uses a `UNION` approach to combine different transaction types into a single chronological list:
1.  **Invoices:** Selects standard invoices, debit memos.
2.  **Payments:** Selects payments, linking them to the invoices they paid.
3.  **Prepayments:** Identifies available prepayments.
4.  **Balance Calculation:** Uses analytic functions (e.g., `SUM() OVER (PARTITION BY Vendor ORDER BY Date)`) to calculate a running balance.

#### Integration Points
*   **Purchasing:** Often displays the PO Number associated with the invoice.
*   **General Ledger:** Can filter by GL Date to show the statement "As Of" a financial close.

### 3. Functional Capabilities

#### Parameters & Filtering
*   **Supplier Name:** Run for a single vendor or a range.
*   **Date Range:** "Document Date" (Invoice Date) or "GL Date".
*   **Include Unvalidated/Unapproved:** Allows showing invoices that are in the system but not yet ready for payment (crucial for "Received but not approved" visibility).
*   **Currency:** Filter by transaction currency.

#### Performance & Optimization
*   **Bursting Capable:** The report structure is optimized for "Bursting," meaning it can be run once for all suppliers and automatically split into separate PDF/Excel files for each email recipient.

### 4. FAQ

**Q: Can this report show "In Process" invoices?**
A: Yes, by checking "Include Unvalidated Transactions," you can show vendors that you have received their invoice even if it's on hold or pending approval.

**Q: Does it handle "Cross Currency" payments?**
A: Yes, the report logic typically handles cases where the invoice is in EUR but paid in USD, showing the relevant amounts.

**Q: How is the "Running Balance" calculated?**
A: It takes the opening balance (sum of all transactions prior to the "From Date") and adds/subtracts subsequent invoices and payments chronologically.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-supplier-statement)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
