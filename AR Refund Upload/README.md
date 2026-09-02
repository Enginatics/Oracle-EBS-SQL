---
layout: default
title: 'AR Refund Upload | Oracle EBS SQL Report'
description: 'Bulk-refund customer credit balances in AR. Each row refunds either an open credit memo or the unapplied/on-account portion of a customer cash receipt by…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Refund, ar_payment_schedules_all, ra_customer_trx_all, hr_all_organization_units_vl'
permalink: /AR%20Refund%20Upload/
---

# AR Refund Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-refund-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Upload Mode, Operating Unit, GL Date From, GL Date To, Credit Memo Number, Customer Name, Batch Name, Include accounts with open invoices, Open Invoice Due Within Days

## Oracle EBS Tables Used
[ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[AR Unapplied Receipts Register](/AR%20Unapplied%20Receipts%20Register/ "AR Unapplied Receipts Register Oracle EBS SQL Report"), [AR Receipt Register](/AR%20Receipt%20Register/ "AR Receipt Register Oracle EBS SQL Report"), [AR Credit Memo Application Upload](/AR%20Credit%20Memo%20Application%20Upload/ "AR Credit Memo Application Upload Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [](https://www.enginatics.com/example/ar-refund-upload/) |
| Blitz Report™ XML Import | [AR_Refund_Upload.xml](https://www.enginatics.com/xml/ar-refund-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-refund-upload/](https://www.enginatics.com/reports/ar-refund-upload/) |



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
