---
layout: default
title: 'AR Unapplied Receipts Register | Oracle EBS SQL Report'
description: 'Detail unapplied receipts report with receipt number, date and amount – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Unapplied, Receipts, Register, ar_receivable_applications_all, gl_daily_conversion_types, gl_daily_rates'
permalink: /AR%20Unapplied%20Receipts%20Register/
---

# AR Unapplied Receipts Register – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-unapplied-receipts-register/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail unapplied receipts report with receipt number, date and amount

## Report Parameters
Ledger, Operating Unit, As of GL Date, Receipt GL Date Low, Receipt GL Date High, Application GL Date Low, Application GL Date High, Receipt Last Updated From, Receipt Last Updated To, Entered Currency, Customer Name, Customer Number, Batch Name, Batch Source Name, Receipt Number Low, Receipt Number High, Revaluation Currency, Revaluation Rate Type, Revaluation Date, Show Receipt DFF Segments

## Oracle EBS Tables Used
[ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl), [hz_customer_profiles](https://www.enginatics.com/library/?pg=1&find=hz_customer_profiles), [ar_collectors](https://www.enginatics.com/library/?pg=1&find=ar_collectors), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all), [ar_batches_all](https://www.enginatics.com/library/?pg=1&find=ar_batches_all), [ar_batch_sources_all](https://www.enginatics.com/library/?pg=1&find=ar_batch_sources_all), [ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts), [ce_bank_acct_uses_all](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_all), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[AR Open Balances Revaluation](/AR%20Open%20Balances%20Revaluation/ "AR Open Balances Revaluation Oracle EBS SQL Report"), [AR Receipt Register](/AR%20Receipt%20Register/ "AR Receipt Register Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Unapplied Receipts Register 18-Jul-2023 085905.xlsx](https://www.enginatics.com/example/ar-unapplied-receipts-register/) |
| Blitz Report™ XML Import | [AR_Unapplied_Receipts_Register.xml](https://www.enginatics.com/xml/ar-unapplied-receipts-register/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-unapplied-receipts-register/](https://www.enginatics.com/reports/ar-unapplied-receipts-register/) |

## AR Unapplied Receipts Register - Case Study & Technical Analysis

### Executive Summary

The **AR Unapplied Receipts Register** is a primary operational report for the Cash Application team. It identifies all customer payments that have been recorded in the system but not yet fully applied to specific invoices. Reducing the volume and value of unapplied receipts is a critical Key Performance Indicator (KPI) for the Accounts Receivable department, as it directly impacts the accuracy of customer aging and the efficiency of the collections process.

### Business Challenge

"Unapplied Cash" represents a disconnect in the Order-to-Cash cycle.
*   **Distorted Aging:** A customer may have $1M in open invoices and $1M in unapplied cash. Their net balance is zero, but the aging report shows them as $1M past due, triggering unnecessary dunning actions.
*   **Customer Satisfaction:** Calling a customer to demand payment when they have already paid (but the cash is sitting unapplied) damages the relationship.
*   **Accounting Risk:** Unapplied cash sits in a suspense or liability account. If not cleared promptly, it can hide revenue recognition issues or duplicate payments.

### Solution

The **AR Unapplied Receipts Register** serves as a worklist for resolving these items:
*   **Identification:** Lists every receipt with a non-zero "Unapplied" balance.
*   **Aging:** Shows how long the cash has been sitting unapplied (via Receipt Date), allowing managers to target old items first.
*   **Ownership:** Includes the "Collector" assigned to the customer, enabling the distribution of the workload.

### Technical Architecture

The report focuses on the "Open" portion of the payment schedules associated with receipts.

#### Key Tables & Joins

*   **Open Balance:** `AR_PAYMENT_SCHEDULES_ALL` is the driver. The query looks for records where `CLASS = 'PMT'` and `STATUS = 'OP'` (Open). The `AMOUNT_DUE_REMAINING` on a payment schedule represents the unapplied amount.
*   **Receipt Header:** `AR_CASH_RECEIPTS_ALL` provides the Receipt Number, Date, and Currency.
*   **Customer:** `HZ_PARTIES` and `HZ_CUST_ACCOUNTS` identify the payer.
*   **Bank:** `CE_BANK_ACCOUNTS` identifies where the money was deposited.

#### Logic

1.  **Selection:** Finds receipts where the unapplied amount is not zero.
2.  **As-Of Logic:** If an "As of Date" is provided, the report must reconstruct the balance. It takes the current balance and "rolls back" any applications that happened *after* the As-Of Date to show what the balance was at that point in time.
3.  **Exclusion:** Typically excludes "Reversed" receipts, as they are no longer valid assets.

### Parameters

*   **As of GL Date:** The most critical parameter for month-end reconciliation. It ensures the report matches the General Ledger balance for the "Unapplied Cash" account.
*   **Customer Name:** Filters for a specific client.
*   **Receipt Number:** Locates a specific payment.
*   **Collector:** Segments the report by the responsible agent.

### FAQ

**Q: What is the difference between "Unapplied" and "On Account"?**
*   **Unapplied:** The cash is in the system, but no decision has been made on how to use it.
*   **On Account:** The cash has been deliberately placed "On Account" (e.g., a prepayment or deposit) to be used later.
*   *Note:* Both result in a negative balance on the customer account, and this report typically includes both unless filtered.

**Q: Why does the report show a receipt that I applied yesterday?**
A: If you run the report with an "As of Date" from *last week*, it will show the receipt as unapplied because it *was* unapplied at that time.

**Q: How do I clear items from this report?**
A: You must "Apply" the receipt to an invoice, a debit memo, or refund it to the customer. Once the `AMOUNT_DUE_REMAINING` on the receipt becomes zero, it drops off the list.


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
