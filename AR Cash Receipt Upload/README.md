---
layout: default
last_modified_at: 2026-10-26
title: 'AR Cash Receipt Upload | Oracle EBS SQL Report'
description: 'Upload to create AR cash receipts and optionally apply them to open invoices. Each row creates one receipt (if it does not already exist) and optionally…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Cash, Receipt, ce_bank_acct_uses_all, ce_bank_accounts, ar_cash_receipt_history_all'
permalink: /AR%20Cash%20Receipt%20Upload/
report_name: 'AR Cash Receipt Upload'
report_web_name: ar-cash-receipt-upload
---

# AR Cash Receipt Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-cash-receipt-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload).

## Overview
Upload to create AR cash receipts and optionally apply them to open invoices.

Each row creates one receipt (if it does not already exist) and optionally applies it to one invoice.
To apply one receipt to multiple invoices, enter multiple rows with the same Receipt Number - the receipt is created only once on the first row, and each subsequent row generates one application against the existing receipt.

Receipt Application options:
- Leave Invoice Number blank: receipt is created as Unapplied
- Enter Invoice Number: receipt is applied to that invoice
- Set Apply on Account = Yes: receipt amount is applied On Account (no specific invoice)

Remittance Bank Account:
- Defaults to the Primary bank account assigned to the Receipt Method (matching the form behaviour).
- To use a non-primary bank account, pick it from the Remittance Bank Account LOV. The Override flag is auto-defaulted to Yes when a non-primary account is chosen.
- For multi-row uploads against the same Receipt Number, only the bank account on the first row is used; subsequent rows simply apply to the receipt that already exists.

Apply-only against an existing receipt:
- Enter the Receipt Number of an existing receipt and the application columns (Invoice Number, Amount Applied, etc.). Receipt Method, Receipt Amount, Receipt Date and Currency may be left blank - they are required only when creating a new receipt.

Receipt Information (Descriptive Flexfield):
- Pick an Attribute Category (your configured DFF context) to expose its segments in the Attribute1..15 columns. Each segment shows only values valid for the chosen context.
- Column headers rename dynamically to your configured segment labels (via the "AR Cash Receipt DFF Attributes" translation rule).
- DFF values are written to the receipt header on create. They cannot be modified on an existing receipt via this upload - use the form, or reverse-and-recreate, for header DFF maintenance.

Receipt Type - Standard vs Miscellaneous:
- Receipt Type defaults to Standard (a customer cash receipt applied to invoices, as described above).
- Set Receipt Type to Miscellaneous to record non-customer income such as bank interest or refunds. A Miscellaneous receipt requires a Receivables Activity, which supplies the GL accounting automatically - there is no customer and no invoice application.
- Misc Payment Source is an optional free-text note for Miscellaneous receipts.
- On a Miscellaneous row the customer and application columns (Customer Name/Number/Site, Invoice Number, Amount Applied, Apply on Account, etc.) must be left blank.

Customer Bank Account:
- The customer's own bank account that funds the receipt - used by automatic receipt methods such as Direct Debit and EFT. Pick from the bank accounts registered for the customer. Leave blank for ordinary manually entered cash receipts.

Notes Receivable / Bills of Exchange:
- Issuer Name, Issue Date and Issuer Bank Branch capture the details of a note or bill of exchange. Populate them only for Notes Receivable receipts; leave blank for ordinary cash receipts.

The upload supports the following modes:
- Create: opens an empty template for entering new receipts
- Create, Update: downloads existing receipts (with applications) for review or to add further applications

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Receipt Date From, Receipt Date To, Customer Name, Customer Number, Bill To Site, Receipt Method

## Oracle EBS Tables Used
[ce_bank_acct_uses_all](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [ar_receivables_trx_all](https://www.enginatics.com/library/?pg=1&find=ar_receivables_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Cash%20Receipt%20Upload/AR%20Cash%20Receipt%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ar-cash-receipt-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload) |
| Blitz Report™ XML Import | [AR_Cash_Receipt_Upload.xml](https://www.enginatics.com/xml/ar-cash-receipt-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload) |
| SQL Source | [AR Cash Receipt Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Cash%20Receipt%20Upload/AR%20Cash%20Receipt%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-cash-receipt-upload/](https://www.enginatics.com/reports/ar-cash-receipt-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload) |

## Case Study & Technical Analysis: AR Cash Receipt Upload

### Executive Summary
This upload creates Oracle Receivables cash receipts in bulk and optionally applies them to open customer invoices, to a specific invoice number, or on account. It serves cash application teams that receive lockbox files, bank remittance advices or manual payments and need them recorded in the AR subledger without keying each receipt into the Receipts window. Each spreadsheet row creates or applies one receipt, and the same workbook can apply existing receipts to further invoices. The template runs in Excel through Blitz Report.

### Business Challenge
*   **Manual receipt entry:** Keying every customer payment into the Receipts form is slow and error-prone when a period produces hundreds of remittances.
*   **Multi-invoice remittances:** One payment often settles several invoices, and each application has to be recorded against the same receipt.
*   **Unmatched cash:** Receipts that cannot yet be tied to an invoice must still be recorded as Unapplied or On Account before period close.
*   **Bank and flexfield consistency:** The remittance bank account and the receipt descriptive flexfield values must follow the receipt method setup.
*   **Non-customer income:** Bank interest and refunds need recording as Miscellaneous receipts that post through a Receivables Activity rather than against a customer.

### The Solution
*   **Receipt creation by number:** A row creates the receipt when its Receipt Number is new. Later rows that repeat the number add one application each against the receipt that already exists.
*   **Application options:** A blank Invoice Number leaves the receipt Unapplied. An Invoice Number applies it to that invoice. Apply on Account = Yes applies it to the customer without a specific invoice.
*   **Bank account defaulting:** The remittance bank account defaults to the primary bank account of the receipt method. A non-primary account can be picked from the list of values, and the Override flag is then set to Yes.
*   **Apply-only mode:** An existing Receipt Number with application columns only adds applications. Receipt Method, Receipt Amount, Receipt Date and Currency are needed only when a new receipt is created.
*   **Receipt type and notes:** Receipt Type switches between Standard and Miscellaneous. Issuer Name, Issue Date and Issuer Bank Branch are populated only for Notes Receivable and bills of exchange.

### Technical Architecture (High Level)
#### Primary Tables
*   `AR_CASH_RECEIPTS_ALL`: the receipt header, with amount, currency, receipt date, method, remittance account, descriptive flexfield values and reversal data.
*   `AR_RECEIVABLE_APPLICATIONS_ALL`: one row per application, holding the amount applied, discount taken, apply date, GL date and on-account status.
*   `AR_PAYMENT_SCHEDULES_ALL`: the invoice installment that an application settles, identified by its terms sequence number.
*   `RA_CUSTOMER_TRX_ALL`: the invoice header that supplies the invoice number.
*   `AR_RECEIPT_METHODS` and `AR_RECEIVABLES_TRX_ALL`: the receipt method and the Receivables Activity used by Miscellaneous receipts.
*   `AR_CASH_RECEIPT_HISTORY_ALL`: the current history record, from which the GL date and reversal GL date are taken.
*   `HZ_CUST_ACCOUNTS`, `HZ_PARTIES` and `HZ_CUST_SITE_USES_ALL`: the customer, its party name and the bill-to site.
*   `CE_BANK_ACCT_USES_ALL`, `CE_BANK_ACCOUNTS`, `CE_BANK_BRANCHES_V` and `IBY_EXT_BANK_ACCOUNTS`: remittance, issuer and customer bank accounts.

#### Logical Relationships
1. `HR_ALL_ORGANIZATION_UNITS_VL` supplies the operating unit, which is matched to `AR_CASH_RECEIPTS_ALL.org_id`.
2. `AR_CASH_RECEIPTS_ALL` joins to `AR_RECEIPT_METHODS` on the receipt method and to `HZ_CUST_ACCOUNTS` on the paying customer, then to `HZ_PARTIES` and `HZ_CUST_SITE_USES_ALL`.
3. `AR_CASH_RECEIPTS_ALL` joins to `AR_RECEIVABLE_APPLICATIONS_ALL` on the cash receipt id, as an outer join so unapplied receipts still appear.
4. Each application joins to `RA_CUSTOMER_TRX_ALL` on the applied customer transaction and to `AR_PAYMENT_SCHEDULES_ALL` on the applied payment schedule.
5. The remittance bank account is resolved from the remittance bank account use id through `CE_BANK_ACCT_USES_ALL` to `CE_BANK_ACCOUNTS`.

### Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download existing receipts with their applications.
*   **Operating Unit:** restricts the receipts to one operating unit.
*   **Receipt Date From / Receipt Date To:** bound the receipts returned when the workbook is downloaded.
*   **Customer Name, Customer Number and Bill To Site:** narrow the downloaded receipts to one customer and site.
*   **Receipt Method:** restricts the downloaded receipts to one receipt method.

### Performance & Optimization
*   The receipt history lookups for GL date and reversal GL date are scalar subqueries keyed on the cash receipt id, so they run only for the receipts that the outer filters return.
*   Applications are joined with outer joins and a status filter of APP or ACC with display set to Y, which keeps unapplied receipts in the result without a second pass.

### FAQ
**Q: How do I apply one receipt to several invoices in a single upload?**
A: Enter one row per invoice with the same Receipt Number. The receipt is created on the first row, and each following row adds an application.

**Q: Can I apply a receipt to an existing receipt that was created earlier?**
A: Yes. Enter the existing Receipt Number with the Invoice Number and Amount Applied. Receipt Method, Amount, Date and Currency can be left blank.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-cash-receipt-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
