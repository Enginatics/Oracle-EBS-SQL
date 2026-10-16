---
layout: default
last_modified_at: 2026-10-16
title: 'AP Posted Payment Register | Oracle EBS SQL Report'
description: 'Application: Payables Description: Payables Posted Payment Register This report provides equivalent functionality to the Oracle standard Payables Posted…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, R12 only, Posted, Payment, Register'
permalink: /AP%20Posted%20Payment%20Register/
report_name: 'AP Posted Payment Register'
report_web_name: ap-posted-payment-register
module: 'Payables'
module_url: /modules/payables/
---

# AP Posted Payment Register – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-posted-payment-register/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
Application: Payables
Description: Payables Posted Payment Register

This report provides equivalent functionality to the Oracle standard Payables Posted Payment Register report.

For scheduling the report to run periodically, use the relative period from/to offset parameters. These are the relative period offsets to the current period, so when the current period changes, the included periods will also automatically be updated when the report is re-run.

Templates
- Pivot: Summary by Account
  Equivalent to standard report in Summarize Report = Yes Mode 
- Pivot: Summary by Account, Bank Account, Batch, Payment Currency, Payment Document
  Equivalent to standard report in Summarize=No Order By=Bank Account
- Pivot: Summary by Account, Batch, Bank Account, Payment Currency, Payment Document
  Equivalent to standard report in Summarize=No Order By=Journal Entry Batch
- Detail
  Provides detail listing of the posted payments

Additional data fields are available. Run the report without a template to see full list available fields


Source: Payables Posted Payment Register
Short Name: APXPOPMT
DB package: XLA_JELINES_RPT_PKG

Also requires custom package XXEN_XLA package to be installed to initialize the hidden parameters removed from the report to simplify scheduling of the report.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Ledger/Ledger Set, Period From, Period To, Journal Source, Include Zero Amount Lines, Account Flexfield From, Account Flexfield To, Bank Account, GL Batch Name, Include Manual Entries from GL, Relative Period From, Relative Period To

## Oracle EBS Tables Used
–

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Posted%20Payment%20Register/AP%20Posted%20Payment%20Register.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ap-posted-payment-register/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register) |
| Blitz Report™ XML Import | [AP_Posted_Payment_Register.xml](https://www.enginatics.com/xml/ap-posted-payment-register/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register) |
| SQL Source | [AP Posted Payment Register.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Posted%20Payment%20Register/AP%20Posted%20Payment%20Register.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-posted-payment-register/](https://www.enginatics.com/reports/ap-posted-payment-register/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register) |

## Case Study & Technical Analysis: AP Posted Payment Register

### 1. Executive Summary

#### Business Problem
Cash reconciliation is a critical control function. Treasury and Accounting teams need to verify that the payments recorded in the bank statement match the payments posted to the General Ledger "Cash" and "Cash Clearing" accounts. Discrepancies here can indicate fraud, data corruption, or configuration errors in the posting program.

#### Solution Overview
The **AP Posted Payment Register** provides a detailed audit trail of all Payables payments (Checks, Wires, EFTs) that have been transferred to the General Ledger. It serves as the counterpart to the Posted Invoice Register, focusing on the "Credit" side of the liability and the "Debit/Credit" to Cash. It allows users to group payments by Bank Account, Payment Document (Check Stock), or GL Batch.

#### Key Benefits
*   **Bank Reconciliation:** Validates that the total credits to the GL Cash Account match the total payments issued from the Bank Account.
*   **Audit Proof:** Provides a list of every payment included in a specific GL Journal Entry.
*   **Cash Flow Analysis:** Helps analyze cash outflows by currency and payment method.

### 2. Technical Analysis

#### Core Tables and Views
*   **`XLA_AE_HEADERS` / `XLA_AE_LINES`**: The accounting repository.
*   **`AP_CHECKS_ALL`**: The payment header table (despite the name, it covers all payment methods).
*   **`AP_CHECK_STOCKS_ALL`**: Provides details on the payment document (e.g., "Check Stock A").
*   **`CE_BANK_ACCOUNTS`**: Bank account details.

#### SQL Logic and Data Flow
*   **Entity Type:** The query filters `XLA_TRANSACTION_ENTITIES` for Entity Code `AP_PAYMENTS`.
*   **Linkage:** `XLA_AE_HEADERS` -> `XLA_TRANSACTION_ENTITIES` -> `AP_CHECKS_ALL`.
*   **Account Derivation:** The report pulls the Code Combination ID from `XLA_AE_LINES` to show the actual account hit (Cash, Cash Clearing, or Liability), which is crucial since SLA rules can override the default bank accounts.

#### Integration Points
*   **Cash Management (CE):** The Bank Account details link this report to the Cash Management module.
*   **General Ledger:** Ties directly to GL Journals sourced from Payables Payments.

### 3. Functional Capabilities

#### Parameters & Filtering
*   **Bank Account:** Filter payments by the source bank account.
*   **Payment Currency:** Isolate payments made in specific currencies.
*   **GL Batch Name:** Trace a specific GL batch back to its payments.
*   **Include Manual Entries:** Option to include manual GL adjustments (though rare for subledger feeds).

#### Performance & Optimization
*   **SLA Architecture:** By querying SLA tables directly, the report avoids the complex and slow logic of reconstructing accounting from raw AP distribution tables (`AP_PAYMENT_HISTORY_ALL`), which was the method in older Oracle versions (11i).

### 4. FAQ

**Q: Why do I see two lines for one payment?**
A: You are likely seeing the Debit to the Liability Account and the Credit to the Cash/Cash Clearing Account. This is the double-entry accounting representation of the payment.

**Q: Does this include voided payments?**
A: Yes, if the void has been posted. A voided payment will typically show reversing entries (Debiting Cash, Crediting Liability).

**Q: How does this help with "Cash Clearing"?**
A: By filtering for the "Cash Clearing" account, you can see exactly which payments are currently in transit (issued but not yet cleared at the bank, if using Cash Clearing accounting).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-posted-payment-register)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
