---
layout: default
title: 'AR Miscellaneous Receipts 11i | Oracle EBS SQL Report'
description: 'Receivables miscellaneous receipts – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Miscellaneous, Receipts, 11i, ar_batches, ar_cash_receipts_all, ap_inv_selection_criteria_all'
permalink: /AR%20Miscellaneous%20Receipts%2011i/
---

# AR Miscellaneous Receipts 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-miscellaneous-receipts-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Receivables miscellaneous receipts

## Report Parameters
Operating Unit, Receipt Method, Period, Receipt Date From, Receipt Date To, State, Customer Name, Account Number, Receipt Number

## Oracle EBS Tables Used
[ar_batches](https://www.enginatics.com/library/?pg=1&find=ar_batches), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all), [ap_inv_selection_criteria_all](https://www.enginatics.com/library/?pg=1&find=ap_inv_selection_criteria_all), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods), [ap_bank_accounts_all](https://www.enginatics.com/library/?pg=1&find=ap_bank_accounts_all), [ap_bank_branches](https://www.enginatics.com/library/?pg=1&find=ap_bank_branches), [ar_receivables_trx_all](https://www.enginatics.com/library/?pg=1&find=ar_receivables_trx_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [ar_distribution_sets_all](https://www.enginatics.com/library/?pg=1&find=ar_distribution_sets_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AR Miscellaneous Receipts](/AR%20Miscellaneous%20Receipts/ "AR Miscellaneous Receipts Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [CE Cleared Transactions](/CE%20Cleared%20Transactions/ "CE Cleared Transactions Oracle EBS SQL Report"), [AR Receipt Register](/AR%20Receipt%20Register/ "AR Receipt Register Oracle EBS SQL Report"), [AR Transactions and Payments 11i](/AR%20Transactions%20and%20Payments%2011i/ "AR Transactions and Payments 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ar-miscellaneous-receipts-11i/) |
| Blitz Report™ XML Import | [AR_Miscellaneous_Receipts_11i.xml](https://www.enginatics.com/xml/ar-miscellaneous-receipts-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-miscellaneous-receipts-11i/](https://www.enginatics.com/reports/ar-miscellaneous-receipts-11i/) |

## Case Study & Technical Analysis: AR Miscellaneous Receipts

### 1. Executive Summary

#### Business Problem
Miscellaneous receipts in Oracle Receivables represent cash inflows that are not directly related to customer invoices. These include interest income, investment returns, tax refunds, or stock sales. Because these transactions do not follow the standard "Invoice -> Receipt" matching process, they are often difficult to track, reconcile, and audit. Finance teams struggle with:
*   **Visibility:** Lack of a centralized view for non-trade cash receipts.
*   **Reconciliation:** Difficulty in tracing miscellaneous cash to the General Ledger, especially when complex distribution sets are used.
*   **Audit Compliance:** Ensuring that all non-standard cash inflows are properly authorized, categorized, and accounted for.
*   **Tax Reporting:** Identifying VAT or other taxes collected on miscellaneous income.

#### Solution Overview
The **AR Miscellaneous Receipts** report provides a detailed register of all non-invoice related cash receipts. It captures the entire lifecycle of the receipt, from creation to remittance and clearance. By exposing the underlying accounting distributions, tax codes, and reference information, it allows the Treasury and Accounting teams to fully validate and reconcile miscellaneous cash entries against bank statements and GL balances.

#### Key Benefits
*   **Complete Audit Trail:** Tracks the status history of receipts (Approved, Remitted, Cleared, Reversed).
*   **Accounting Detail:** Shows the specific GL accounts credited (e.g., Interest Income, Gain/Loss) for each receipt line.
*   **Tax Compliance:** Identifies tax codes and amounts associated with taxable miscellaneous receipts.
*   **Reference Tracking:** Links receipts to external reference numbers (e.g., Legacy System IDs, Check Numbers) for easier cross-referencing.
*   **Bank Reconciliation:** Provides deposit dates and clearing dates to assist in month-end bank reconciliation.

### 2. Technical Analysis

#### Core Tables and Views
The report queries the core AR receipt tables:
*   **`AR_CASH_RECEIPTS_ALL`**: The primary header table for all receipts, including miscellaneous ones (identified by `type = 'MISC'`).
*   **`AR_MISC_CASH_DISTRIBUTIONS_ALL`**: Stores the accounting distributions (GL accounts) for the miscellaneous receipt.
*   **`AR_CASH_RECEIPT_HISTORY_ALL`**: Tracks the status changes (Creation -> Remittance -> Clearance) and the accounting date for each event.
*   **`AR_RECEIVABLES_TRX_ALL`**: Defines the "Receivables Activity" (e.g., "Interest Income") which drives the default accounting.
*   **`AR_BATCHES_ALL`**: Links receipts to their batch if entered via a batch.
*   **`GL_CODE_COMBINATIONS_KFV`**: Decodes the GL account segments.

#### SQL Logic and Data Flow
The SQL is designed to handle the one-to-many relationship between receipts and their distributions/history.
*   **Row Number Partitioning:** Uses `row_number() over (partition by ...)` to handle the display of amounts. This technique ensures that the header-level Receipt Amount is only displayed on the first distribution line to prevent double-counting in summations.
*   **Status Decoding:** Complex `DECODE` logic is used to interpret the `STATUS` columns from both the receipt header and history tables, providing user-friendly statuses like 'Reversed', 'Cleared', etc.
*   **Reference Resolution:** A `CASE` statement resolves the `reference_type` and `reference_id` to fetch human-readable values (e.g., if type is 'PAYMENT', it fetches the Check Number from `AP_CHECKS_ALL`).
*   **Bank Account Security:** Joins to `IBY` (Payments) tables (`IBY_EXT_BANK_ACCOUNTS`, `IBY_CREDITCARD`) to securely fetch masked bank account or credit card numbers.

#### Integration Points
*   **General Ledger:** Validates the credited accounts via `AR_MISC_CASH_DISTRIBUTIONS_ALL`.
*   **Cash Management:** Provides data for bank reconciliation (Bank Account, Deposit Date).
*   **Tax (E-Business Tax):** Links to `AR_VAT_TAX_ALL` (or the E-Business Tax repository in R12) for tax codes.

### 3. Functional Capabilities

#### Reporting Dimensions
*   **Receipt Source:** Analyze receipts by "Activity" (e.g., Interest vs. Refund).
*   **Status:** Filter by Receipt Status (e.g., Remitted, Cleared, Reversed).
*   **Time:** Analyze cash inflows by GL Date, Receipt Date, or Deposit Date.
*   **Bank Account:** Group receipts by the depositing Bank Account.

#### Key Parameters
*   **Date Ranges:** GL Date, Receipt Date, Deposit Date.
*   **Receipt Method:** Filter by Check, Wire, Cash, etc.
*   **Batch Name:** Filter for specific receipt batches.
*   **Currency:** Filter by Entered Currency.

### 4. Implementation Considerations

#### Best Practices
*   **Distribution Sets:** Encourage the use of "Distribution Sets" in AR to standardize the accounting for common miscellaneous receipt types. This report can then be used to audit adherence to these standards.
*   **Reversal Tracking:** Use the report to monitor reversed receipts, which can be an indicator of entry errors or potential fraud.
*   **Month-End:** Run this report as part of the month-end close to ensure all miscellaneous cash is posted to the correct period and accounts.


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
