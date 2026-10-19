---
layout: default
last_modified_at: 2026-10-19
title: 'AR Refund Upload | Oracle EBS SQL Report'
description: 'Bulk-refund customer credit balances in AR. Each row refunds either an open credit memo or the unapplied/on-account portion of a customer cash receipt by…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Refund, ar_payment_schedules_all, ra_customer_trx_all, hr_all_organization_units_vl'
permalink: /AR%20Refund%20Upload/
report_name: 'AR Refund Upload'
report_web_name: ar-refund-upload
---

# AR Refund Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-refund-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload).

## Overview
Bulk-refund customer credit balances in AR. Each row refunds either an open credit memo or the unapplied/on-account portion of a customer cash receipt by applying it against the operating unit's Credit Memo Refund Receivables Activity, via AR_CM_APPLICATION_PUB.Activity_application or AR_RECEIPT_API_PUB.Activity_application.

WHEN TO USE EACH REFUND SOURCE
- Credit Memo - the customer has an open credit memo (e.g. overpayment recorded as a CM) and wants the money back.
- Unapplied Receipt - the customer paid more than they owed, or paid against the account with no specific invoice. The receipt has an unapplied/on-account balance to return.

WORKFLOW (review and select)
The template downloads (Create, Update mode) pre-populated with every eligible credit memo and unapplied receipt for the parameters, showing Customer Name and Open Balance. Review the list, then:
1. Set Refund = Yes on the rows to refund; leave blank to skip. Blank rows are not processed.
2. Refund Amount defaults to the source open balance - override with a smaller positive amount for a partial refund (validated > 0 and <= balance, in Excel and at upload).
3. Apply Date / Apply GL Date default to today; the GL Date must be in an open AR period.
4. Optionally set Payment Method, Pay Group, Payment Reason Comments, Comments - these flow to the AP Payment Request invoice.
To add a row manually: pick Refund Source, then the Credit Memo Number or Receipt Number (the LOV adapts to the source).

APPROVAL LIMITS
The AR API runs with p_chk_approval_limit_flag='Y' - the user's AR approval limit applies. Rows over the limit error with the API's own message. Limits are never bypassed.

END-TO-END FLOW
1. AR (this upload): a new ar_receivable_applications_all row is created (application_type='CM' or 'CASH', status='ACTIVITY').
2. AR -> AP business event (automatic): AP creates a Payment Request invoice (source='Receivables', invoice_type_lookup_code='PAYMENT REQUEST') payable to the customer's TCA party.
3. AP Invoice Validation (standard AP concurrent).
4. AP Payment Process Request issues the disbursement.

This upload performs step 1 only. Steps 2-4 are standard Oracle AP processing - a second human control point before any money leaves.

PER-OU SETUP
Each OU that processes refunds needs a Credit Memo Refund-type Receivables Activity (AR Setup -> Receipts -> Receivable Activities). The same activity is used for both CM and receipt refunds. If none, the upload errors: "No Credit Memo Refund activity is defined for this operating unit."

CANDIDATE IDENTIFICATION
- Credit Memo Number LOV: open credit memos in the OU whose customer account has no open invoices (standard refund-candidate rule). Set "Include accounts with open invoices" = Yes to override the safety filter (e.g. when open invoices are disputed).
- Receipt Number LOV: unapplied/on-account customer receipts in the OU with positive unapplied amount.
- Download in Create, Update mode to see existing candidates as rows.

FILTER PARAMETERS
- Operating Unit - filters both branches.
- Customer Name - LOV of customers that have an eligible refund in the OU (respects the open-invoice rules below).
- GL Date From / To, Credit Memo Number (multi-value), Batch Name (multi-value LOV on AR transaction batches) - Credit Memo branch only. The Receipt branch always shows all unapplied/on-account receipts in the chosen OU.
- Include accounts with open invoices - default blank (= safety filter on for CMs). Does not apply to receipts.
- Open Invoice Due Within Days - applies only when Include accounts with open invoices = Yes (otherwise ignored). Enter any number N: a credit memo is hidden only when the customer has an open invoice due within N days; invoices due later are ignored so the CM can still be refunded. Blank = due dates not considered.

MODE
Create, Update by default so the eligible candidates pre-populate. Only rows with Refund = Yes are processed; the result XLSM lists the refunded rows.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Operating Unit, GL Date From, GL Date To, Credit Memo Number, Customer Name, Batch Name, Include accounts with open invoices, Open Invoice Due Within Days

## Oracle EBS Tables Used
[ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload)

## Related Reports
[ONT Order to Cash Tracker](/ONT%20Order%20to%20Cash%20Tracker/ "ONT Order to Cash Tracker Oracle EBS SQL Report"), [AR Unapplied Receipts Register](/AR%20Unapplied%20Receipts%20Register/ "AR Unapplied Receipts Register Oracle EBS SQL Report"), [AR Receipt Register](/AR%20Receipt%20Register/ "AR Receipt Register Oracle EBS SQL Report"), [AR Credit Memo Application Upload](/AR%20Credit%20Memo%20Application%20Upload/ "AR Credit Memo Application Upload Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report"), [IEX Collection Note Upload](/IEX%20Collection%20Note%20Upload/ "IEX Collection Note Upload Oracle EBS SQL Report"), [AR Customer Credit Limits](/AR%20Customer%20Credit%20Limits/ "AR Customer Credit Limits Oracle EBS SQL Report"), [AR Customer Statement](/AR%20Customer%20Statement/ "AR Customer Statement Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Refund%20Upload/AR%20Refund%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ar-refund-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload) |
| Blitz Report™ XML Import | [AR_Refund_Upload.xml](https://www.enginatics.com/xml/ar-refund-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload) |
| SQL Source | [AR Refund Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Refund%20Upload/AR%20Refund%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-refund-upload/](https://www.enginatics.com/reports/ar-refund-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload) |

## Case Study & Technical Analysis: AR Refund Upload

### Executive Summary
This upload refunds customer credit balances in Oracle Receivables. Each row refunds either an open credit memo or the unapplied, on-account portion of a customer cash receipt, by applying it against the operating unit's Credit Memo Refund Receivables Activity. Collections and cash-application teams use it to clear customer credits in bulk, with a review step before any money leaves. It runs in Excel through Blitz Report™ in Create, Update mode.

### Business Challenge
*   **Idle customer credits:** Overpayments held as credit memos or unapplied receipts sit on accounts until someone arranges a refund.
*   **Candidate selection:** Refunding a credit while the customer still has open invoices can distort collections, so the rule that excludes such accounts has to be applied consistently.
*   **Two refund sources:** Credit memos and unapplied receipts follow different candidate rules and must be handled on one worksheet.
*   **Payment control:** A refund is a disbursement, so selection is separated from the Payables steps that follow.

### The Solution
*   Pre-populates the download with every eligible credit memo and every unapplied receipt for the chosen parameters, showing customer name and open balance.
*   Processes only the rows where Refund is set to Yes, and defaults the refund amount to the source open balance, which can be overridden with a smaller positive amount for a partial refund.
*   Applies each refund through the Oracle Receivables public APIs.
*   Hands over to Accounts Payable, where a Payment Request invoice is created for the customer's party, followed by standard Invoice Validation and the Payment Process Request.

### Technical Architecture (High Level)
#### Primary Tables
*   `AR_PAYMENT_SCHEDULES_ALL`: the open CM installments with their amount due remaining, and the open INV installments used by the safety filter.
*   `RA_CUSTOMER_TRX_ALL`: the credit memo transaction number.
*   `AR_CASH_RECEIPTS_ALL`: the unapplied and on-account customer receipts, identified by receipt number and status UNAPP.
*   `AR_RECEIVABLE_APPLICATIONS_ALL`: the applications whose UNAPP or ACC amounts give the open balance of a receipt.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customer account and the customer name.
*   `HR_ALL_ORGANIZATION_UNITS_VL` and `MO_GLOB_ORG_ACCESS_TMP`: the operating unit and the organizations the user can access.

#### Logical Relationships
1.  The credit memo branch joins open CM installments to transactions, operating unit, customer and party.
2.  A NOT EXISTS test removes a credit memo when the same customer has an open invoice, unless Include accounts with open invoices is Yes.
3.  When that override is set, the open invoice due-date test excludes only customers with an open invoice due within the number of days entered.
4.  The receipt branch joins unapplied receipts (status UNAPP) to their customer, and keeps those with a positive amount in an UNAPP or ACC application.
5.  The two branches are combined with UNION ALL, and each row carries a refund source of Credit Memo or Unapplied Receipt.
6.  Each row is numbered with ROWNUM as its upload row.

### Parameters & Filtering
*   **Upload Mode:** Create, Update is the default, so the eligible candidates pre-populate the template.
*   **Operating Unit:** filters both the credit memo and the receipt branch.
*   **Customer Name:** limits the candidates to customers with an eligible refund in the operating unit.
*   **GL Date From** and **GL Date To**, **Credit Memo Number** and **Batch Name:** filter the credit memo branch only, because the receipt branch always lists all unapplied receipts in the chosen operating unit.
*   **Include accounts with open invoices:** turns off the safety filter for credit memos; it does not apply to receipts.
*   **Open Invoice Due Within Days:** applies only when Include accounts with open invoices is Yes, and hides a credit memo only when an open invoice is due within that many days.

### Performance & Optimization
*   The open invoice test is a NOT EXISTS subquery on `AR_PAYMENT_SCHEDULES_ALL`.
*   The receipt open balance is a scalar subquery, evaluated only for receipts that passed the EXISTS filter.
*   Both branches are restricted through `MO_GLOB_ORG_ACCESS_TMP` before the customer and party joins.
*   Candidates come from the database, so the spreadsheet carries only rows the refund rules allow.

### FAQ
**Q: When should a refund come from a credit memo rather than an unapplied receipt?**
A: Use a credit memo refund when the customer holds an open credit memo from an overpayment, and an unapplied receipt refund when the customer paid more than owed or paid against the account with no specific invoice.

**Q: Why might a credit memo not appear in the download?**
A: By default a credit memo is hidden when its customer has any open invoice, so the customer must have no open invoices unless Include accounts with open invoices is set to Yes.

**Q: What happens after the refund row is uploaded with Refund set to Yes?**
A: The upload creates the refund application in Receivables and a Payment Request invoice in Accounts Payable, which still needs Invoice Validation and the Payment Process Request before any payment is issued.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-refund-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
