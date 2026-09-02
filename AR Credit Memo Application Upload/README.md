---
layout: default
title: 'AR Credit Memo Application Upload | Oracle EBS SQL Report'
description: 'Applies open on account credit memos to invoices and debit memos, and unapplies existing credit memo applications - the Applications action of the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Credit, Memo, Application, ar_payment_schedules_all, ra_customer_trx_all, ra_batch_sources_all'
permalink: /AR%20Credit%20Memo%20Application%20Upload/
---

# AR Credit Memo Application Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-credit-memo-application-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Applies open on account credit memos to invoices and debit memos, and unapplies existing credit memo applications - the Applications action of the Transactions workbench (ar_cm_api_pub).

The download lists the operating unit's open credit memos (Apply To Invoice empty) and their existing active applications (one row per application). To apply, enter Apply To Invoice on an open credit memo row. To unapply, set Unapply to Yes on an application row.

An existing application cannot be changed in place: unapply it, then enter the new application on the credit memo's open row.

## Report Parameters
Upload Mode, Operating Unit, Credit Memo Number, Credit Memo Date From, Credit Memo Date To, Bill To Customer

## Oracle EBS Tables Used
[ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ra_batch_sources_all](https://www.enginatics.com/library/?pg=1&find=ra_batch_sources_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[AR Refund Upload](/AR%20Refund%20Upload/ "AR Refund Upload Oracle EBS SQL Report"), [AR Unapplied Receipts Register](/AR%20Unapplied%20Receipts%20Register/ "AR Unapplied Receipts Register Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AR Receipt Register](/AR%20Receipt%20Register/ "AR Receipt Register Oracle EBS SQL Report"), [AR Transaction Update Upload](/AR%20Transaction%20Update%20Upload/ "AR Transaction Update Upload Oracle EBS SQL Report"), [IEX Collection Note Upload](/IEX%20Collection%20Note%20Upload/ "IEX Collection Note Upload Oracle EBS SQL Report"), [AR Customer Credit Limits](/AR%20Customer%20Credit%20Limits/ "AR Customer Credit Limits Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/ar-credit-memo-application-upload/) |
| Blitz Report™ XML Import | [AR_Credit_Memo_Application_Upload.xml](https://www.enginatics.com/xml/ar-credit-memo-application-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-credit-memo-application-upload/](https://www.enginatics.com/reports/ar-credit-memo-application-upload/) |



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
