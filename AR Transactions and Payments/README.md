---
layout: default
title: 'AR Transactions and Payments | Oracle EBS SQL Report'
description: 'Detail AR customer billing history including payments / cash receipts, excluding any entered or incomplete transactions.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Transactions, Payments, ar_receivable_applications_all, ra_customer_trx_all, ar_cons_inv_trx_all'
permalink: /AR%20Transactions%20and%20Payments/
---

# AR Transactions and Payments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-transactions-and-payments/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail AR customer billing history including payments / cash receipts, excluding any entered or incomplete transactions.

## Report Parameters
Ledger, Operating Unit, Transaction Class, Transaction Type, Category, Period, Inv. Date From, Inv. Date To, State, Status, Overdue for more than x Days, Customer Name, Account Number, Invoice Number, Transaction Number, Print Date from, Print Date to, Revaluation Currency, Revaluation Rate Type, Revaluation Date

## Oracle EBS Tables Used
[ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ar_cons_inv_trx_all](https://www.enginatics.com/library/?pg=1&find=ar_cons_inv_trx_all), [ar_cons_inv_all](https://www.enginatics.com/library/?pg=1&find=ar_cons_inv_all), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [oe_sys_parameters_all](https://www.enginatics.com/library/?pg=1&find=oe_sys_parameters_all), [ra_batch_sources_all](https://www.enginatics.com/library/?pg=1&find=ra_batch_sources_all), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all), [ra_terms_tl](https://www.enginatics.com/library/?pg=1&find=ra_terms_tl), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps), [jtf_rs_resource_extns_tl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_tl), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all), [ce_bank_acct_uses_all](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_all), [ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts), [hz_relationships](https://www.enginatics.com/library/?pg=1&find=hz_relationships), [hz_organization_profiles](https://www.enginatics.com/library/?pg=1&find=hz_organization_profiles), [&gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=&gl_period_statuses), [xle_entity_profiles](https://www.enginatics.com/library/?pg=1&find=xle_entity_profiles), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods), [iby_fndcpt_pmt_chnnls_tl](https://www.enginatics.com/library/?pg=1&find=iby_fndcpt_pmt_chnnls_tl), [iby_fndcpt_tx_extensions](https://www.enginatics.com/library/?pg=1&find=iby_fndcpt_tx_extensions), [fnd_application](https://www.enginatics.com/library/?pg=1&find=fnd_application), [iby_pmt_instr_uses_all](https://www.enginatics.com/library/?pg=1&find=iby_pmt_instr_uses_all), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts), [iby_creditcard](https://www.enginatics.com/library/?pg=1&find=iby_creditcard)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Transactions and Payments 04-Oct-2021 211221.xlsx](https://www.enginatics.com/example/ar-transactions-and-payments/) |
| Blitz Report™ XML Import | [AR_Transactions_and_Payments.xml](https://www.enginatics.com/xml/ar-transactions-and-payments/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-transactions-and-payments/](https://www.enginatics.com/reports/ar-transactions-and-payments/) |

## Case Study & Technical Analysis: AR Transactions and Payments

### 1. Executive Summary

#### Business Problem
Managing the full lifecycle of customer billing and collections requires a unified view of both invoices (debits) and payments (credits). Standard Oracle reports often separate these into "Transaction Registers" and "Receipt Registers," forcing analysts to manually merge data to see the complete picture of a customer's account. This fragmentation leads to:
*   **Inefficient Collections:** Difficulty in seeing which specific invoices were paid by a receipt.
*   **Reconciliation Gaps:** Challenges in matching the "Due Original" amounts with "Payment Applied" to verify outstanding balances.
*   **Customer Service Delays:** Inability to quickly answer "Did you receive my payment for Invoice X?" without navigating multiple screens.
*   **Forecasting Errors:** Lack of visibility into actual payment dates versus due dates.

#### Solution Overview
The **AR Transactions and Payments** report provides a consolidated, transactional view of the customer sub-ledger. It combines Invoices, Credit Memos, Debit Memos, and Cash Receipts into a single dataset. Crucially, it includes logic to show which invoices were paid by which receipts (and vice versa), providing a clear audit trail of the "Application" process. This report is the definitive source for analyzing customer account history and open balances.

#### Key Benefits
*   **Unified History:** See Invoices and Payments side-by-side in one report.
*   **Application Visibility:** For payments, the report lists the specific invoices they were applied to (via the `credited_or_paid_invoice` column).
*   **Aging & Status:** Real-time calculation of "Due Remaining" and "Overdue Days" for accurate aging analysis.
*   **Legal Entity View:** Includes Legal Entity and Ledger context for multi-org reporting.
*   **Payment Details:** Displays the Payment Method (Check, Wire, Credit Card) and Bank details associated with the transaction.

### 2. Technical Analysis

#### Core Tables and Views
The report queries the central AR payment schedule and transaction tables:
*   **`AR_PAYMENT_SCHEDULES_ALL`**: The backbone of the report. It tracks every transaction that affects the customer balance (Invoices, Receipts, Adjustments).
*   **`RA_CUSTOMER_TRX_ALL`**: Details for Invoices, Credit Memos, and Debit Memos.
*   **`AR_CASH_RECEIPTS_ALL`**: Details for Cash Receipts.
*   **`AR_RECEIVABLE_APPLICATIONS_ALL`**: The link between Receipts and Invoices. Used to derive the "Applied To" information.
*   **`HZ_CUST_ACCOUNTS` / `HZ_PARTIES`**: Customer master data.
*   **`XLE_ENTITY_PROFILES`**: Legal Entity information.

#### SQL Logic and Data Flow
The SQL is built around the `AR_PAYMENT_SCHEDULES_ALL` table, which acts as the unifying entity for all AR activity.
*   **Union/Polymorphic Logic:** The query handles both "TRX" (Invoices) and "PMT" (Payments) classes. It conditionally joins to `RA_CUSTOMER_TRX_ALL` or `AR_CASH_RECEIPTS_ALL` based on the class.
*   **Application Aggregation:** For payments, a subquery uses `LISTAGG` to concatenate the list of invoices paid by that receipt. This provides a comma-separated list of paid invoices directly on the receipt row.
*   **Revaluation Logic:** Includes optional columns (`&reval_cols`) to calculate revalued amounts based on a user-specified currency and rate type, useful for multi-currency reporting.
*   **Consolidated Billing:** Handles "Consolidated Invoices" (`AR_CONS_INV_ALL`) to show the customer-facing bill number instead of the internal transaction number where applicable.

#### Integration Points
*   **Cash Management:** Fetches Remittance Bank details.
*   **Payments (IBY):** Fetches Credit Card and Payment Channel information.
*   **General Ledger:** Provides Ledger and GL Date context.
*   **Legal Entity:** Links transactions to the legal entity for statutory reporting.

### 3. Functional Capabilities

#### Reporting Dimensions
*   **Transaction Class:** Filter by Invoice, Credit Memo, Debit Memo, Chargeback, or Payment.
*   **Customer:** Analyze history by Customer Name or Account Number.
*   **Time:** Filter by Transaction Date, GL Date, or Due Date.
*   **Status:** Focus on "Open" transactions for collections or "Closed" for history.

#### Key Parameters
*   **Revaluation:** Parameters for `Revaluation Currency`, `Rate Type`, and `Date` allow for "what-if" currency analysis.
*   **Overdue Days:** Filter for transactions overdue by more than X days.
*   **State:** Filter by 'Current' or 'Past Due'.

### 4. Implementation Considerations

#### Performance
*   **List Aggregation:** The `LISTAGG` function used to show applied invoices can be performance-intensive if a single receipt pays thousands of invoices. The query includes logic to limit the length of this string to prevent buffer overflow errors.
*   **Indexing:** Ensure `AR_PAYMENT_SCHEDULES_ALL` is indexed on `CLASS`, `STATUS`, and `DUE_DATE`.

#### Best Practices
*   **Statement Generation:** This report can serve as a detailed "Customer Statement" for internal use.
*   **Unapplied Cash:** Filter for Class = 'PMT' and Status = 'OP' (Open) to find unapplied cash receipts that need to be matched to invoices.
*   **Dispute Management:** Use the `dispute_amount` column to identify invoices that are partially paid or held due to customer disputes.


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
