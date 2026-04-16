---
layout: default
title: 'AP Invoice Payments 11i | Oracle EBS SQL Report'
description: 'Supplier invoice payment details. There can be multiple payments per invoice and one document/check can be used to pay different payments and invoices. To…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Invoice, Payments, 11i, gl_je_batches, gl_sets_of_books, hr_operating_units'
permalink: /AP%20Invoice%20Payments%2011i/
---

# AP Invoice Payments 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoice-payments-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Supplier invoice payment details.
There can be multiple payments per invoice and one document/check can be used to pay different payments and invoices. To allow reconciling payment with invoices and checks, invoice and check level amounts are shown on the last payment record only and are blank for multiple/duplicate records.

## Report Parameters
Ledger, Operating Unit, Payment Date From, Payment Date To, GL Date From, GL Date To, Supplier, Supplier Number, Invoice Number, Check Number

## Oracle EBS Tables Used
[gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [ap_terms_vl](https://www.enginatics.com/library/?pg=1&find=ap_terms_vl), [ap_bank_accounts_all](https://www.enginatics.com/library/?pg=1&find=ap_bank_accounts_all), [ap_bank_branches](https://www.enginatics.com/library/?pg=1&find=ap_bank_branches), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [ap_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ap_payment_schedules_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AP Invoice Payments](/AP%20Invoice%20Payments/ "AP Invoice Payments Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [AP Invoices and Lines 11i](/AP%20Invoices%20and%20Lines%2011i/ "AP Invoices and Lines 11i Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ap-invoice-payments-11i/) |
| Blitz Report™ XML Import | [AP_Invoice_Payments_11i.xml](https://www.enginatics.com/xml/ap-invoice-payments-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-invoice-payments-11i/](https://www.enginatics.com/reports/ap-invoice-payments-11i/) |

## Case Study & Technical Analysis: AP Invoice Payments Report

### Executive Summary
The **AP Invoice Payments Report** provides a detailed operational view of supplier payments within Oracle Payables. It is designed to facilitate the reconciliation of invoices against payments and checks, ensuring financial accuracy and transparency. By listing multiple payments per invoice and handling complex scenarios where a single check pays multiple invoices, this report is an essential tool for Accounts Payable and Treasury departments.

### Business Challenge
Managing supplier payments involves several challenges:
*   **Reconciliation Complexity:** Matching individual invoices to consolidated payments (one check paying multiple invoices) can be tedious and error-prone.
*   **Payment Visibility:** Determining the exact status of a payment (e.g., issued, cleared, voided) often requires navigating multiple screens.
*   **Duplicate Data:** Standard reports may duplicate check amounts when listing multiple invoices per check, leading to incorrect totals if not carefully handled.
*   **Audit Requirements:** Auditors frequently request detailed listings of payments to verify authorization and accuracy.

### The Solution
The **AP Invoice Payments Report** addresses these challenges by providing a structured, flat-file view of the payment process.

*   **Consolidated View:** It links invoices to their respective payments, showing the relationship clearly.
*   **Smart Totals:** To prevent double-counting, invoice and check level amounts are displayed only on the last payment record for a given group, leaving duplicate records blank. This feature simplifies pivot table analysis and summation.
*   **Status Tracking:** The report includes the check state, allowing users to filter for cleared, voided, or issued payments.
*   **Flexible Filtering:** Users can search by date ranges, supplier, or specific document numbers to quickly locate transactions.

### Technical Architecture (High Level)
The report is built on the core Payables payment tables, ensuring data integrity and performance.

#### Primary Tables
*   `AP_INVOICES_ALL`: Contains the invoice header information.
*   `AP_INVOICE_PAYMENTS_ALL`: The intersection table linking invoices to payments.
*   `AP_CHECKS_ALL`: Stores the physical payment document (check/EFT) details.
*   `IBY_PAYMENT_PROFILES`: (R12) Provides details on the payment method and profile used.
*   `AP_SUPPLIERS` & `AP_SUPPLIER_SITES_ALL`: Supplier master data.
*   `GL_JE_BATCHES`: Links payments to General Ledger journal entries for accounting reconciliation.

#### Logical Relationships
1.  **Invoice to Payment:** `AP_INVOICES_ALL` joins to `AP_INVOICE_PAYMENTS_ALL` on `INVOICE_ID`.
2.  **Payment to Check:** `AP_INVOICE_PAYMENTS_ALL` joins to `AP_CHECKS_ALL` on `CHECK_ID`.
3.  **Payment Method:** `AP_CHECKS_ALL` links to `IBY_PAYMENT_PROFILES` to identify the payment instrument.
4.  **Accounting:** The payment accounting events are linked to GL via `GL_JE_BATCHES` (likely through XLA tables in R12, though the high-level view simplifies this).

### Parameters & Filtering
The report supports a wide range of parameters for targeted analysis:
*   **Ledger & Operating Unit:** Essential for multi-org reporting.
*   **Date Ranges:** "Payment Date" and "Accounting Date" filters allow for period-based reporting.
*   **Supplier Filters:** "Supplier", "Supplier Number", and "Site" allow for vendor-specific analysis.
*   **Document Filters:** "Invoice Number" and "Check Number" enable quick lookups of specific transactions.
*   **Check State:** Filters by the status of the payment (e.g., Negotiable, Voided, Cleared).

### Performance & Optimization
*   **Smart Aggregation:** The logic to show amounts only on the last record is likely handled within the SQL query (using analytic functions like `ROW_NUMBER()` or `LAST_VALUE()`), avoiding post-processing overhead.
*   **Indexed Access:** Filtering by `CHECK_DATE`, `CHECK_ID`, or `VENDOR_ID` utilizes standard Oracle indexes for efficient retrieval.
*   **Direct SQL:** Bypasses XML parsing for rapid generation of large datasets.

### FAQ
**Q: Why are some amount fields blank?**
A: To avoid double-counting totals when a single check pays multiple invoices, the report logic displays the check amount only on the last record of the group.

**Q: Can I see voided payments?**
A: Yes, use the "Check State" parameter to filter for 'Voided' payments.

**Q: Does this report show electronic payments?**
A: Yes, it includes all payment methods (Check, EFT, Wire, etc.) recorded in Oracle Payables.


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
