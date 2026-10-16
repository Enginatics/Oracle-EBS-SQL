---
layout: default
last_modified_at: 2026-10-16
title: 'AP Invoice Payment Upload | Oracle EBS SQL Report'
description: 'Records Manual and Quick payments of open Payables invoices and voids payments - the Excel equivalent of entering a payment and its invoices in the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Invoice, Payment, ap_checks_all, hr_all_organization_units_vl, ap_suppliers'
permalink: /AP%20Invoice%20Payment%20Upload/
report_name: 'AP Invoice Payment Upload'
report_web_name: ap-invoice-payment-upload
---

# AP Invoice Payment Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoice-payment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload).

## Overview
Records Manual and Quick payments of open Payables invoices and voids payments - the Excel equivalent of entering a payment and its invoices in the Payments window.

Each row is one invoice installment paid, with the payment columns repeated on every row. Rows with identical payment columns are paid by one payment. Amount Paid and Discount Taken default to the full amount remaining less the discount available at the Payment Date, and can be reduced to pay an installment partially.

Each payment is processed as a whole: when any of its rows fails validation, none of its rows are saved. A Manual payment records a document already issued and needs its Document Num. A Quick payment takes the next number of a printed Payment Document, and is submitted to Oracle Payments as a single payment, as from the Payments window.

Set the Open Invoices parameter to download the open installments of the selected supplier and operating unit as new rows to pay. In Create, Update mode existing Manual and Quick payments are downloaded; enter a Void Date to void one. Voiding reverses all invoice payments of the payment and leaves the invoices unpaid, unless Invoice Action puts them on hold or cancels them. Cancelling invoices is committed by Oracle Payables as it happens, as in the Payments window.

Invoices that would get withholding tax or an interest invoice at payment time cannot be paid by a Quick payment through the upload.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Trading Partner, Payment Date From, Payment Date To, Document Num, Open Invoices

## Oracle EBS Tables Used
[ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [ce_payment_documents](https://www.enginatics.com/library/?pg=1&find=ce_payment_documents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [ap_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ap_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [ap_holds_all](https://www.enginatics.com/library/?pg=1&find=ap_holds_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [ap_selected_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_selected_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload)

## Related Reports
[AP Accounted Invoice Aging](/AP%20Accounted%20Invoice%20Aging/ "AP Accounted Invoice Aging Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [IBY Payment Process Request Details](/IBY%20Payment%20Process%20Request%20Details/ "IBY Payment Process Request Details Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Procure to Pay Tracker](/PO%20Procure%20to%20Pay%20Tracker/ "PO Procure to Pay Tracker Oracle EBS SQL Report"), [AP Invoices and Lines 11i](/AP%20Invoices%20and%20Lines%2011i/ "AP Invoices and Lines 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoice%20Payment%20Upload/AP%20Invoice%20Payment%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ap-invoice-payment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload) |
| Blitz Report™ XML Import | [AP_Invoice_Payment_Upload.xml](https://www.enginatics.com/xml/ap-invoice-payment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload) |
| SQL Source | [AP Invoice Payment Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoice%20Payment%20Upload/AP%20Invoice%20Payment%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-invoice-payment-upload/](https://www.enginatics.com/reports/ap-invoice-payment-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload) |

## Case Study & Technical Analysis: AP Invoice Payment Upload

### Executive Summary
The AP Invoice Payment Upload is an Excel upload that records Manual and Quick payments of open Oracle Payables invoices and voids payments, in the same way as the Payments window. Each row is one invoice installment paid, and rows with identical payment columns form one payment. Accounts Payable teams use it to pay large numbers of invoices, to void payments in bulk and to correct payment details before they are finalized. Blitz Report downloads the open installments and existing payments, and the upload writes the changes back through the Payables invoice and payment tables.

### Business Challenge
*   **Volume payment processing:** Paying hundreds of installments one at a time in the Payments window is slow, while each payment must remain complete and balanced.
*   **Partial payments and discounts:** Amount Paid and Discount Taken must reflect the discount still available on the Payment Date, and an installment sometimes has to be paid only in part.
*   **Document control:** A Manual payment records a document already issued, while a Quick payment draws on the next number of a printed Payment Document, so each type needs its own data.
*   **Reversal:** Voiding a payment reverses all its invoice payments, and the team must control what happens to the invoices afterwards.

### The Solution
*   Downloads open installments of a supplier and operating unit as new rows to pay when the Open Invoices parameter is set, with the amount remaining and discount available filled in.
*   Groups rows with identical payment columns into one payment, and processes each payment as a whole: when any row fails validation, none of its rows are saved.
*   Downloads existing Manual and Quick payments in Create, Update mode, so a Void Date can be entered to void a payment.
*   Carries the Invoice Action, Hold Name and Hold Reason columns, which decide whether the invoices of a voided payment are left unpaid, put on hold or cancelled.

### Technical Architecture (High Level)
#### Primary Tables
*   `AP_CHECKS_ALL`: the payment header, with type, date, amount, currency, exchange rate and status.
*   `AP_INVOICE_PAYMENTS_ALL`: one row per invoice installment paid by a payment.
*   `AP_INVOICES_ALL`: the invoice header, supplying the invoice number, date, currency and approval status.
*   `AP_PAYMENT_SCHEDULES_ALL`: the installments of each invoice, with due date, amount remaining and hold flag.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: the trading partner and supplier site.
*   `CE_PAYMENT_DOCUMENTS`, `HR_ALL_ORGANIZATION_UNITS_VL`, `GL_DAILY_CONVERSION_TYPES`, `AP_HOLDS_ALL`, `AP_SELECTED_INVOICES_ALL` and `MO_GLOB_ORG_ACCESS_TMP`: the payment document, operating unit, rate type, hold, selection and access controls.

#### Logical Relationships
1.  Existing payments: `AP_CHECKS_ALL` is joined to `AP_INVOICE_PAYMENTS_ALL` on check id, and that row to its invoice and to the matching payment schedule. Reversal rows are excluded by the null reversal invoice payment id condition.
2.  Open installments: `AP_INVOICES_ALL` is joined to `AP_PAYMENT_SCHEDULES_ALL` and filtered to uncancelled, approved invoices whose installment is unpaid, not on hold and not in a check run.
3.  Exclusions: invoices with an unreleased hold in `AP_HOLDS_ALL`, or a row in `AP_SELECTED_INVOICES_ALL`, are left out of the open list.
4.  The two branches are combined with UNION ALL, so both have the same columns, with payment columns empty for open invoice rows.

### Parameters & Filtering
*   **Upload Mode:** selects whether rows are downloaded for creation, update or both.
*   **Operating Unit** and **Trading Partner:** restrict the rows to one operating unit and one supplier.
*   **Payment Date From** and **Payment Date To:** bound the payment dates of the existing payments downloaded.
*   **Document Num:** selects a payment by its document number.
*   **Open Invoices:** when set to Y, adds the open installments of the selected supplier and operating unit as new rows to pay.

### Performance & Optimization
*   Open invoices are selected by NOT IN and NOT EXISTS conditions on holds and selected invoices, so no open installment is joined more than once.
*   The approval status is checked through the `AP_INVOICES_PKG.GET_APPROVAL_STATUS` function in the final filter, so it runs only for invoices that pass the earlier conditions.
*   The operating unit access list is a subquery on `MO_GLOB_ORG_ACCESS_TMP`, which keeps the report within the responsibility's organizations.
*   Setting Trading Partner and Payment Date filters before the download keeps the rows of a large upload file to a manageable number.

### FAQ
**Q: How do I pay open invoices from Excel in Oracle Payables?**
A: Set the Open Invoices parameter to Y with the supplier and operating unit. The open installments are downloaded as new rows, with Amount Paid filled in as the full amount remaining less the discount available at the Payment Date.

**Q: How do I void an AP payment through the upload?**
A: Download the payment in Create, Update mode and enter a Void Date. Voiding reverses all the invoice payments of that payment, and the invoices become unpaid unless Invoice Action puts them on hold or cancels them.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-payment-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
