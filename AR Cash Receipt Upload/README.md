---
layout: default
title: 'AR Cash Receipt Upload | Oracle EBS SQL Report'
description: 'Upload to create AR cash receipts and optionally apply them to open invoices. Each row creates one receipt (if it does not already exist) and optionally…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Cash, Receipt, ar_cash_receipt_history_all, gl_daily_conversion_types, ar_cash_receipts_all'
permalink: /AR%20Cash%20Receipt%20Upload/
---

# AR Cash Receipt Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-cash-receipt-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Upload to create AR cash receipts and optionally apply them to open invoices.

Each row creates one receipt (if it does not already exist) and optionally applies it to one invoice.
To apply one receipt to multiple invoices, enter multiple rows with the same Receipt Number - the receipt is created only once and each row generates one application.

Receipt Application options:
- Leave Invoice Number blank: receipt is created as Unapplied
- Enter Invoice Number: receipt is applied to that invoice
- Set Apply on Account = Yes: receipt amount is applied On Account (no specific invoice)

The upload supports the following modes:
- Create: opens an empty template for entering new receipts
- Create, Update: downloads existing receipts (with applications) for review or to add further applications

## Report Parameters
Upload Mode, Operating Unit, Receipt Date From, Receipt Date To, Customer, Receipt Method

## Oracle EBS Tables Used
[ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[AR Transactions and Payments](/AR%20Transactions%20and%20Payments/ "AR Transactions and Payments Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ar-cash-receipt-upload/) |
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
