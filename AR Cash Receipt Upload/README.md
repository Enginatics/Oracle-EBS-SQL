---
layout: default
title: 'AR Cash Receipt Upload | Oracle EBS SQL Report'
description: 'Upload to create AR cash receipts and optionally apply them to open invoices. Each row creates one receipt (if it does not already exist) and optionally…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Cash, Receipt, ce_bank_acct_uses_all, ce_bank_accounts, ar_cash_receipt_history_all'
permalink: /AR%20Cash%20Receipt%20Upload/
---

# AR Cash Receipt Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-cash-receipt-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Upload Mode, Operating Unit, Receipt Date From, Receipt Date To, Customer, Receipt Method

## Oracle EBS Tables Used
[ce_bank_acct_uses_all](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_all), [ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [ar_receivables_trx_all](https://www.enginatics.com/library/?pg=1&find=ar_receivables_trx_all), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Miscellaneous Receipts](/AR%20Miscellaneous%20Receipts/ "AR Miscellaneous Receipts Oracle EBS SQL Report"), [AR Transactions and Payments](/AR%20Transactions%20and%20Payments/ "AR Transactions and Payments Oracle EBS SQL Report"), [AR Unapplied Receipts Register](/AR%20Unapplied%20Receipts%20Register/ "AR Unapplied Receipts Register Oracle EBS SQL Report"), [CE Cleared Transactions](/CE%20Cleared%20Transactions/ "CE Cleared Transactions Oracle EBS SQL Report"), [CE Cash in Transit](/CE%20Cash%20in%20Transit/ "CE Cash in Transit Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/ar-cash-receipt-upload/) |
| Blitz Report™ XML Import | [AR_Cash_Receipt_Upload.xml](https://www.enginatics.com/xml/ar-cash-receipt-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-cash-receipt-upload/](https://www.enginatics.com/reports/ar-cash-receipt-upload/) |



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
