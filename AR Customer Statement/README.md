---
layout: default
title: 'AR Customer Statement | Oracle EBS SQL Report'
description: 'Application: Receivables Source: Customer Statement Short Name: ARSTMTRPT DB package: ARTPSTMTPKG'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Customer, Statement, hz_cust_accounts, hz_parties, hz_cust_site_uses_all'
permalink: /AR%20Customer%20Statement/
---

# AR Customer Statement – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-customer-statement/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Receivables
Source: Customer Statement
Short Name: ARSTMTRPT
DB package: AR_TP_STMT_PKG

## Report Parameters
Reporting Level, Reporting Context, GL Date From, GL Date To, Document Date From, Document Date To, Customer Name From, Customer Name To, Currency, Customer Category, Customer Class, Include Incomplete Transactions, Accounted Transactions, Summarization Level, Show Summary Only

## Oracle EBS Tables Used
[hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [zx_party_tax_profile](https://www.enginatics.com/library/?pg=1&find=zx_party_tax_profile), [ra_customer_trx](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all), [ra_cust_trx_line_gl_dist_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist_all), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [ar_cash_receipts](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all), [ar_adjustments](https://www.enginatics.com/library/?pg=1&find=ar_adjustments), [ar_lookups](https://www.enginatics.com/library/?pg=1&find=ar_lookups), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all), [ar_receivables_trx_all](https://www.enginatics.com/library/?pg=1&find=ar_receivables_trx_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ar-customer-statement/) |
| Blitz Report™ XML Import | [AR_Customer_Statement.xml](https://www.enginatics.com/xml/ar-customer-statement/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-customer-statement/](https://www.enginatics.com/reports/ar-customer-statement/) |

## Case Study & Technical Analysis: AR Customer Statement

### Executive Summary
The **AR Customer Statement** report is a vital financial document that provides a detailed account of customer activity within Oracle Receivables. It serves as the primary communication tool between the Collections department and customers, detailing outstanding balances, recent payments, and credits. Its strategic value lies in accelerating cash collection and reducing Days Sales Outstanding (DSO).

### Business Challenge
Managing accounts receivable effectively requires clear and timely communication with customers.
*   **Manual Processes:** Generating statements for thousands of customers using standard print jobs can be slow and inflexible.
*   **Disputes & Delays:** Customers often delay payment if they cannot reconcile their records with the vendor's statement. Vague or summary-level statements contribute to these disputes.
*   **Format Limitations:** Standard Oracle statements may not easily export to Excel for customers who want to perform their own reconciliation.

### The Solution
This report offers a flexible, data-centric solution for statement generation.
*   **Detailed Visibility:** It provides a granular view of every transaction (Invoice, Credit Memo, Debit Memo, Receipt) affecting the customer's balance.
*   **Reconciliation Ready:** By outputting to Excel (via tools like Blitz Report), it allows both the internal collections team and the customer to sort, filter, and reconcile open items quickly.
*   **Flexible Scope:** Users can run it for a single high-priority customer or a whole batch based on Customer Class or Category.

### Technical Architecture (High Level)
The report aggregates data from the Receivables transaction and payment tables to calculate the running balance.

*   **Primary Tables:**
    *   `HZ_CUST_ACCOUNTS` / `HZ_PARTIES`: Customer master data.
    *   `RA_CUSTOMER_TRX_ALL`: Headers for Invoices, Credit Memos, etc.
    *   `AR_PAYMENT_SCHEDULES_ALL`: The central table for tracking what is due and what remains unpaid on each transaction.
    *   `AR_CASH_RECEIPTS_ALL`: Details of payments received.
    *   `AR_ADJUSTMENTS_ALL`: Any manual or automatic adjustments made to balances.
*   **Logical Relationships:**
    *   The report centers around `AR_PAYMENT_SCHEDULES_ALL`, which links transactions (`CUSTOMER_TRX_ID`) to their current payment status.
    *   It joins to `HZ_PARTIES` to retrieve the Customer Name and Address.
    *   It calculates the "Open Balance" by looking at the `AMOUNT_DUE_REMAINING` column.

### Parameters & Filtering
*   **Customer Name / Account:** Allows for generating a statement for a specific client or a range of clients.
*   **GL Date / Document Date:** Defines the "As Of" date or the activity period for the statement.
*   **Include Incomplete Transactions:** A toggle to decide whether to show drafted invoices that haven't been posted to GL yet.
*   **Summarization Level:** Users can choose between a high-level balance summary or a detailed line-by-line transaction history.
*   **Currency:** Essential for multi-currency environments to produce statements in the transaction currency.

### Performance & Optimization
*   **Indexed Retrieval:** The query leverages indexes on `CUSTOMER_ID` and `TRX_DATE` to quickly locate relevant records among millions of transactions.
*   **Efficient Aggregation:** Instead of recalculating balances from the beginning of time for every run, it utilizes the `AMOUNT_DUE_REMAINING` fields in `AR_PAYMENT_SCHEDULES` for current balance reporting, which is significantly faster than summing all historical debits and credits.

### FAQ
**Q: Does this report show unapplied receipts?**
A: Yes, unapplied receipts (payments received but not yet matched to a specific invoice) are critical for an accurate total balance. They are typically listed as credits on the statement.

**Q: Why doesn't the statement balance match the GL balance?**
A: Timing differences are the most common cause. This report is often run by "Document Date" or "GL Date". If there are unposted items or if the "As Of" date differs from the GL period close date, variances can occur. Also, ensure "Include Incomplete Transactions" is set correctly for reconciliation.

**Q: Can I send this to customers electronically?**
A: While the SQL generates the data, the delivery depends on the tool used (e.g., Blitz Report, BI Publisher). The data structure is designed to support "Bursting," where the output is split by Customer Email and sent automatically.


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
