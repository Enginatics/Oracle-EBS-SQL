---
layout: default
title: 'AP Invoice Payments | Oracle EBS SQL Report'
description: 'Supplier invoice payment details. There can be multiple payments per invoice and one document/check can be used to pay different payments and invoices. To…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Invoice, Payments, iby_payment_profiles, gl_je_batches'
permalink: /AP%20Invoice%20Payments/
---

# AP Invoice Payments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoice-payments/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Supplier invoice payment details.
There can be multiple payments per invoice and one document/check can be used to pay different payments and invoices. To allow reconciling payment with invoices and checks, invoice and check level amounts are shown on the last payment record only and are blank for multiple/duplicate records.

## Report Parameters
Ledger, Operating Unit, Payment Date From, Payment Date To, Accounting Date From, Accounting Date To, Supplier, Supplier Number, Supplier Site, Invoice Number, Check Number, Check State

## Oracle EBS Tables Used
[iby_payment_profiles](https://www.enginatics.com/library/?pg=1&find=iby_payment_profiles), [gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CE Bank Statement and Reconciliation](/CE%20Bank%20Statement%20and%20Reconciliation/ "CE Bank Statement and Reconciliation Oracle EBS SQL Report"), [CE Cleared Transactions](/CE%20Cleared%20Transactions/ "CE Cleared Transactions Oracle EBS SQL Report"), [AR Miscellaneous Receipts](/AR%20Miscellaneous%20Receipts/ "AR Miscellaneous Receipts Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [AR Transactions and Lines](/AR%20Transactions%20and%20Lines/ "AR Transactions and Lines Oracle EBS SQL Report"), [IBY Payment Process Request Details](/IBY%20Payment%20Process%20Request%20Details/ "IBY Payment Process Request Details Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Invoice Payments 22-Aug-2020 224831.xlsx](https://www.enginatics.com/example/ap-invoice-payments/) |
| Blitz Report™ XML Import | [AP_Invoice_Payments.xml](https://www.enginatics.com/xml/ap-invoice-payments/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-invoice-payments/](https://www.enginatics.com/reports/ap-invoice-payments/) |

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
