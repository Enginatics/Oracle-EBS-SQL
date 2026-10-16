---
layout: default
last_modified_at: 2026-10-16
title: 'AR Credit Memo Application Upload | Oracle EBS SQL Report'
description: 'Applies open on account credit memos to invoices and debit memos, and unapplies existing credit memo applications - the Applications action of the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Credit, Memo, Application, ar_payment_schedules_all, ra_customer_trx_all, ra_batch_sources_all'
permalink: /AR%20Credit%20Memo%20Application%20Upload/
report_name: 'AR Credit Memo Application Upload'
report_web_name: ar-credit-memo-application-upload
---

# AR Credit Memo Application Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-credit-memo-application-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload).

## Overview
Applies open on account credit memos to invoices and debit memos, and unapplies existing credit memo applications - the Applications action of the Transactions workbench (ar_cm_api_pub).

The download lists the operating unit's open credit memos (Apply To Invoice empty) and their existing active applications (one row per application). To apply, enter Apply To Invoice on an open credit memo row. To unapply, set Unapply to Yes on an application row.

An existing application cannot be changed in place: unapply it, then enter the new application on the credit memo's open row.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, Credit Memo Number, Credit Memo Date From, Credit Memo Date To, Bill To Customer

## Oracle EBS Tables Used
[ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload), [ra_batch_sources_all](https://www.enginatics.com/library/?pg=1&find=ra_batch_sources_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload)

## Related Reports
[ONT Order to Cash Tracker](/ONT%20Order%20to%20Cash%20Tracker/ "ONT Order to Cash Tracker Oracle EBS SQL Report"), [AR Refund Upload](/AR%20Refund%20Upload/ "AR Refund Upload Oracle EBS SQL Report"), [AR Unapplied Receipts Register](/AR%20Unapplied%20Receipts%20Register/ "AR Unapplied Receipts Register Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AR Receipt Register](/AR%20Receipt%20Register/ "AR Receipt Register Oracle EBS SQL Report"), [AR Transaction Update Upload](/AR%20Transaction%20Update%20Upload/ "AR Transaction Update Upload Oracle EBS SQL Report"), [IEX Collection Note Upload](/IEX%20Collection%20Note%20Upload/ "IEX Collection Note Upload Oracle EBS SQL Report"), [AR Customer Credit Limits](/AR%20Customer%20Credit%20Limits/ "AR Customer Credit Limits Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Credit%20Memo%20Application%20Upload/AR%20Credit%20Memo%20Application%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ar-credit-memo-application-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload) |
| Blitz Report™ XML Import | [AR_Credit_Memo_Application_Upload.xml](https://www.enginatics.com/xml/ar-credit-memo-application-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload) |
| SQL Source | [AR Credit Memo Application Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Credit%20Memo%20Application%20Upload/AR%20Credit%20Memo%20Application%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-credit-memo-application-upload/](https://www.enginatics.com/reports/ar-credit-memo-application-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload) |

## Case Study & Technical Analysis: AR Credit Memo Application Upload

### Executive Summary
This upload applies open credit memos to invoices and debit memos in Oracle Receivables, and unapplies existing credit memo applications. It mirrors the Applications action of the Transactions workbench, so the same rules govern each change. It is used by accounts receivable clerks and collections analysts who need to clear customer credits against open debt in bulk, usually at month end or after a dispute is settled. The template runs in Excel through Blitz Report.

### Business Challenge
*   **Unapplied customer credits:** Credit memos that sit on account keep customer balances overstated and distort aging reports.
*   **Bulk clearing at close:** Applying credits one at a time in the Transactions window is slow when a customer carries many small credits.
*   **Reversing mistaken applications:** An application posted against the wrong invoice must be unapplied and re-applied without manual reconstruction.
*   **Audit of credit positions:** Finance needs a single list of open credits and their existing applications for each operating unit.

### The Solution
*   **Open credit list:** The download returns the operating unit's open credit memos, identified by a payment schedule with class CM, status OP and a non-zero remaining amount.
*   **Apply by row:** Entering an Apply To Invoice value on an open credit memo row creates an application to that invoice, with an installment, amount, apply date and GL date.
*   **Unapply by row:** Setting Unapply to Yes on an existing application row reverses it.
*   **Re-application rule:** An application cannot be changed in place. The clerk unapplies the old row, then enters the new application on the credit memo's open row.
*   **Both directions in one file:** Open credit memo rows and active application rows are combined in one result set, so a correction can be made in the same workbook.

### Technical Architecture (High Level)
#### Primary Tables
*   `AR_PAYMENT_SCHEDULES_ALL`: the balance of each credit memo and invoice, with status and remaining amount.
*   `RA_CUSTOMER_TRX_ALL`: the credit memo and invoice transaction headers, including transaction number and date.
*   `RA_BATCH_SOURCES_ALL`: the batch source that created each credit memo.
*   `AR_RECEIVABLE_APPLICATIONS_ALL`: the applications, with amount applied, apply date, GL date, comments and application type.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the bill-to customer's account number and name.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit name.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the session can access.

#### Logical Relationships
1. The first query block starts from `AR_PAYMENT_SCHEDULES_ALL` with class CM and status OP, joins `RA_CUSTOMER_TRX_ALL` on the customer transaction id, and then reaches the batch source and customer.
2. The second query block starts from `AR_RECEIVABLE_APPLICATIONS_ALL` with application type CM and status APP, and joins the credit memo's transaction and payment schedule.
3. The applied invoice is reached through the applied customer transaction id and the applied payment schedule id, giving the invoice number and installment.
4. Both blocks restrict the operating unit through the organization list in `MO_GLOB_ORG_ACCESS_TMP` and join it to `HR_ALL_ORGANIZATION_UNITS_VL`.
5. The two blocks are combined with UNION ALL, so open credits and existing applications share one set of columns.

### Parameters & Filtering
*   **Upload Mode:** selects Create, or Create, Update to download credit memos and their applications.
*   **Operating Unit:** limits the credit memos and applications to one operating unit.
*   **Credit Memo Number:** finds one credit memo by its transaction number.
*   **Credit Memo Date From / Credit Memo Date To:** bound the credit memos by transaction date.
*   **Bill To Customer:** limits the rows to one customer.

### Performance & Optimization
*   The driving filter on payment schedule class CM and status OP reduces the first block to open credits before any join is evaluated.
*   Operating unit access is enforced with an IN subquery on `MO_GLOB_ORG_ACCESS_TMP`, so the report never returns rows from units the user cannot access.
*   Batch source is joined as an outer join, so credit memos without a recorded source still appear.

### FAQ
**Q: How do I apply an open credit memo to an invoice in Excel?**
A: Enter the invoice number in Apply To Invoice on the credit memo's row, then enter the installment, amount and dates on that row.

**Q: Why can I not change the amount of an existing application?**
A: Applications cannot be edited in place. Set Unapply to Yes on the existing row, then enter the new application on the open credit memo row.

**Q: Which credit memos are listed in the download?**
A: Credit memos with an open payment schedule and a remaining amount that is not zero, for the operating units the responsibility can access.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-credit-memo-application-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
