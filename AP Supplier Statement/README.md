---
layout: default
title: 'AP Supplier Statement | Oracle EBS SQL Report'
description: 'Application: Payables Source: Supplier Statement Short Name: APTPSTMT DB package: APTPSTMTPKG'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Supplier, Statement, gl_code_combinations_kfv, ap_invoices, ap_suppliers'
permalink: /AP%20Supplier%20Statement/
---

# AP Supplier Statement – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-supplier-statement/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Payables
Source: Supplier Statement
Short Name: APTPSTMT
DB package: AP_TP_STMT_PKG

## Report Parameters
Reporting Level, Reporting Context, GL Date From, GL Date To, Document Date From, Document Date To, Supplier Name From, Supplier Name To, Currency, Pay Group, Vendor Type, Include Zero Balance Suppliers, Include Unvalidated Transactions, Include Unapproved Transaction, Accounted Transactions, Report Level, Summarization Level

## Oracle EBS Tables Used
[gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [ap_invoices](https://www.enginatics.com/library/?pg=1&find=ap_invoices), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [ap_lookup_codes](https://www.enginatics.com/library/?pg=1&find=ap_lookup_codes), [ap_invoice_payments](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments), [ap_checks](https://www.enginatics.com/library/?pg=1&find=ap_checks)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Supplier Statement 28-Apr-2021 200101.xlsx](https://www.enginatics.com/example/ap-supplier-statement/) |
| Blitz Report™ XML Import | [AP_Supplier_Statement.xml](https://www.enginatics.com/xml/ap-supplier-statement/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-supplier-statement/](https://www.enginatics.com/reports/ap-supplier-statement/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
