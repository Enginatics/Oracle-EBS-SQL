---
layout: default
last_modified_at: 2026-10-19
title: 'AP Invoice and Payment Audit by Voucher Number | Oracle EBS SQL Report'
description: 'Lists every voucher number of the Payables invoice and payment document sequences with its status: Entered, Deleted (the number was issued, but the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, Invoice, Payment, Audit, Voucher, ap_invoice_payments_all, fnd_document_sequences, ap_doc_sequence_audit'
permalink: /AP%20Invoice%20and%20Payment%20Audit%20by%20Voucher%20Number/
report_name: 'AP Invoice and Payment Audit by Voucher Number'
report_web_name: ap-invoice-and-payment-audit-by-voucher-number
module: 'Payables'
module_url: /modules/payables/
---

# AP Invoice and Payment Audit by Voucher Number – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-invoice-and-payment-audit-by-voucher-number/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
Lists every voucher number of the Payables invoice and payment document sequences with its status: Entered, Deleted (the number was issued, but the invoice or payment no longer exists) or Not Entered (the number is missing from the sequence audit trail).

Replaces Oracle's Invoice Audit by Voucher Number (APXINVAD) and Payment Audit by Voucher Number (APXPAYAD). Unlike Oracle's payment report, a voided payment is listed as Entered with its void date, and a payment number without a payment as Deleted instead of Not Entered.

Missing numbers are the gaps between the numbers recorded in the sequence audit table, counted from the sequence's initial value, and belong to the ledger of the next recorded number. Numbers after the last recorded voucher are not reported.

The GL date of a payment is the earliest accounting date of its invoice payments.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Operating Unit, Sequence Name, Voucher Number From, Voucher Number To, GL Date From, GL Date To, Status

## Oracle EBS Tables Used
[ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [fnd_document_sequences](https://www.enginatics.com/library/?pg=1&find=fnd_document_sequences&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [ap_doc_sequence_audit](https://www.enginatics.com/library/?pg=1&find=ap_doc_sequence_audit&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [fnd_doc_sequence_assignments](https://www.enginatics.com/library/?pg=1&find=fnd_doc_sequence_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [fnd_doc_sequence_categories](https://www.enginatics.com/library/?pg=1&find=fnd_doc_sequence_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number)

## Related Reports
[AP Accounted Invoice Aging](/AP%20Accounted%20Invoice%20Aging/ "AP Accounted Invoice Aging Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [IBY Payment Process Request Details](/IBY%20Payment%20Process%20Request%20Details/ "IBY Payment Process Request Details Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [AP Prepayments Status](/AP%20Prepayments%20Status/ "AP Prepayments Status Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Receipt Register](/AR%20Receipt%20Register/ "AR Receipt Register Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoice%20and%20Payment%20Audit%20by%20Voucher%20Number/AP%20Invoice%20and%20Payment%20Audit%20by%20Voucher%20Number.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Invoice and Payment Audit by Voucher Number 26-Sep-2026 115756.xlsx](https://www.enginatics.com/example/ap-invoice-and-payment-audit-by-voucher-number/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number) |
| Blitz Report™ XML Import | [AP_Invoice_and_Payment_Audit_by_Voucher_Number.xml](https://www.enginatics.com/xml/ap-invoice-and-payment-audit-by-voucher-number/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number) |
| SQL Source | [AP Invoice and Payment Audit by Voucher Number.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Invoice%20and%20Payment%20Audit%20by%20Voucher%20Number/AP%20Invoice%20and%20Payment%20Audit%20by%20Voucher%20Number.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-invoice-and-payment-audit-by-voucher-number/](https://www.enginatics.com/reports/ap-invoice-and-payment-audit-by-voucher-number/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number) |

## Case Study & Technical Analysis: AP Invoice and Payment Audit by Voucher Number

### Executive Summary
This report lists every voucher number issued from the Oracle Payables invoice and payment document sequences, with the status of each number: Entered, Deleted or Not Entered. Accounts payable supervisors, internal auditors and period-close teams use it to show that every sequentially numbered invoice and payment document is accounted for. The report replaces Oracle's Invoice Audit by Voucher Number and Payment Audit by Voucher Number reports and runs in Excel through Blitz Report™.

### Business Challenge
*   **Sequence gaps:** A missing voucher number in a document sequence can hide a lost, voided or unrecorded invoice or payment, and auditors require each gap to be explained.
*   **Voided versus deleted documents:** A voided payment must be distinguishable from a number that was issued but no longer has a payment behind it.
*   **Multi-ledger control:** Document sequences are assigned per ledger and operating unit, so numbering has to be checked against the correct set of books.
*   **Period-close evidence:** Payments need to be attributed to the accounting period of their GL date when completeness of vouchers is reviewed.

### The Solution
*   Builds the full range of voucher numbers from the sequence audit trail, so a number that was never recorded appears as Not Entered instead of silently disappearing.
*   Matches each recorded number to an invoice in `AP_INVOICES_ALL` or a check in `AP_CHECKS_ALL` and labels it Entered or Deleted, with the void date where a payment was voided.
*   Derives the GL date of a payment from the earliest accounting date of its invoice payments, and shows the supplier, currency, amount and payment status beside each number.
*   Restricts the output by Ledger, Operating Unit, Sequence Name, a voucher number range, a GL date range and Status.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_DOCUMENT_SEQUENCES`: the document sequence definitions, including the initial value used to start gap counting.
*   `AP_DOC_SEQUENCE_AUDIT`: one row per recorded sequence value, which is the basis of the gap analysis.
*   `FND_DOC_SEQUENCE_ASSIGNMENTS` and `FND_DOC_SEQUENCE_CATEGORIES`: link each sequence to its set of books and to the Payables category.
*   `AP_INVOICES_ALL`: the invoice behind an audit row, supplying invoice number, GL date, amount and payment status.
*   `AP_CHECKS_ALL` and `AP_INVOICE_PAYMENTS_ALL`: the payment behind an audit row, its void date and the earliest accounting date of its payments.
*   `AP_SUPPLIERS`: supplier name and supplier number.
*   `HR_OPERATING_UNITS`, `HR_ALL_ORGANIZATION_UNITS_VL` and `GL_LEDGERS`: operating unit, set of books and ledger names.
*   `MO_GLOB_ORG_ACCESS_TMP` and `DUAL`: the organizations the user can access, with a release check for Release 11.

#### Logical Relationships
1.  Sequence assignments are limited to the sets of books of the operating units the user can access.
2.  Each audit row is outer-joined to `AP_INVOICES_ALL` and `AP_CHECKS_ALL` on sequence identifier and sequence value, so unmatched numbers are kept.
3.  An analytic LAG over each sequence returns the previously recorded value, which defines the start of each gap.
4.  A row generator (`XXEN_UTIL.ROWGEN`) expands every gap into individual voucher numbers.
5.  Generated gap numbers receive status N (Not Entered); recorded numbers keep the status derived from the invoice or check.
6.  The result joins to `GL_LEDGERS`, the operating unit, and `AP_SUPPLIERS`, and is sorted by sequence name and voucher number.

### Parameters & Filtering
*   **Ledger** and **Operating Unit:** restrict the document sequences to those assigned to the selected sets of books.
*   **Sequence Name:** limits the report to one Payables document sequence.
*   **Voucher Number From** and **Voucher Number To:** define the window of sequence values listed.
*   **GL Date From** and **GL Date To:** define the accounting window used to bound each sequence's numbering range.
*   **Status:** filters the rows by Entered, Deleted or Not Entered.

### Performance & Optimization
*   The LAG and MIN/MAX analytic functions partitioned by sequence identifier find every gap in a single pass over the audit table instead of a self-join.
*   Numbers are generated only between recorded values, and numbers after the last recorded voucher are not generated, so the row count follows the actual gaps.
*   The organization security subquery against `MO_GLOB_ORG_ACCESS_TMP` restricts sequences before the joins to invoices and checks.
*   The GL date and payment status derivations are correlated subqueries evaluated per row, so narrowing the ledger, sequence and date parameters is the main lever on run time.

### FAQ
**Q: What does Not Entered mean in the Payables voucher audit?**
A: Not Entered means the voucher number is missing from the sequence audit trail, so no invoice or payment was recorded against that number.

**Q: How is a voided payment shown in this report?**
A: A voided payment is listed as Entered with its void date, while a payment number with no payment behind it is listed as Deleted.

**Q: How is the GL date of a payment determined?**
A: The GL date of a payment is the earliest accounting date of its invoice payments, taken from `AP_INVOICE_PAYMENTS_ALL`.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-invoice-and-payment-audit-by-voucher-number)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
