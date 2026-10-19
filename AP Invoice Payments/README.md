---
layout: default
last_modified_at: 2026-10-19
title: 'AP Invoice Payments | Oracle EBS SQL Report'
description: 'Supplier invoice payment details. There can be multiple payments per invoice and one document/check can be used to pay different payments and invoices. To…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, Invoice, Payments, iby_payment_profiles, gl_je_batches, ap_invoice_distributions_all'
permalink: /AP%20Invoice%20Payments/
report_name: 'AP Invoice Payments'
report_web_name: ap-invoice-payments
module: 'Payables'
module_url: /modules/payables/
---

# AP Invoice Payments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoice-payments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
Supplier invoice payment details.
There can be multiple payments per invoice and one document/check can be used to pay different payments and invoices. To allow reconciling payment with invoices and checks, invoice and check level amounts are shown on the last payment record only and are blank for multiple/duplicate records.

When India Localization is installed, the following GST columns are also included: GST Registration No, GST PAN No, GST TAN No, CGST Amount, SGST Amount, IGST Amount, CESS Amount, Custom Amount, Unclassified Tax Amount, Taxable Value, HSN SAC Code, CGST Rate, SGST Rate, IGST Rate, CESS Rate, CGST Recoverable, CGST Non-Recoverable, SGST Recoverable, SGST Non-Recoverable, IGST Recoverable, IGST Non-Recoverable, Reverse Charge Flag, Place of Supply, Ship From State.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Operating Unit, Payment Date From, Payment Date To, Accounting Date From, Accounting Date To, Supplier, Supplier Number, Supplier Site, Invoice Number, Check Number, Check State

## Oracle EBS Tables Used
[iby_payment_profiles](https://www.enginatics.com/library/?pg=1&find=iby_payment_profiles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [gl_je_batches](https://www.enginatics.com/library/?pg=1&find=gl_je_batches&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ap_terms_vl](https://www.enginatics.com/library/?pg=1&find=ap_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ce_bank_acct_uses_all](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [iby_payment_methods_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_methods_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ap_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ap_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments), [ap_inv_selection_criteria_all](https://www.enginatics.com/library/?pg=1&find=ap_inv_selection_criteria_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments)

## Related Reports
[AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Procure to Pay Tracker](/PO%20Procure%20to%20Pay%20Tracker/ "PO Procure to Pay Tracker Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [PO Invoice Price Variance](/PO%20Invoice%20Price%20Variance/ "PO Invoice Price Variance Oracle EBS SQL Report"), [GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [CAC Receiving Account Detail](/CAC%20Receiving%20Account%20Detail/ "CAC Receiving Account Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoice%20Payments/AP%20Invoice%20Payments.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Invoice Payments 22-Aug-2020 224831.xlsx](https://www.enginatics.com/example/ap-invoice-payments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments) |
| Blitz Report™ XML Import | [AP_Invoice_Payments.xml](https://www.enginatics.com/xml/ap-invoice-payments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments) |
| SQL Source | [AP Invoice Payments.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoice%20Payments/AP%20Invoice%20Payments.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-invoice-payments/](https://www.enginatics.com/reports/ap-invoice-payments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payments)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
