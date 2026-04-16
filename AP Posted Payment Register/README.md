---
layout: default
title: 'AP Posted Payment Register | Oracle EBS SQL Report'
description: 'Application: Payables Description: Payables Posted Payment Register This report provides equivalent functionality to the Oracle standard Payables Posted…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Posted, Payment, Register, &lp_template_table'
permalink: /AP%20Posted%20Payment%20Register/
---

# AP Posted Payment Register – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-posted-payment-register/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Operating Unit, Ledger/Ledger Set, Period From, Period To, Journal Source, Include Zero Amount Lines, Account Flexfield From, Account Flexfield To, Bank Account, GL Batch Name, Include Manual Entries from GL, Relative Period From, Relative Period To

## Oracle EBS Tables Used
[&lp_template_table](https://www.enginatics.com/library/?pg=1&find=&lp_template_table)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[AP Posted Invoice Register](/AP%20Posted%20Invoice%20Register/ "AP Posted Invoice Register Oracle EBS SQL Report"), [INV Transaction Historical Summary](/INV%20Transaction%20Historical%20Summary/ "INV Transaction Historical Summary Oracle EBS SQL Report"), [AP Trial Balance](/AP%20Trial%20Balance/ "AP Trial Balance Oracle EBS SQL Report"), [PA Revenue, Cost, Budgets by Work Breakdown Structure](/PA%20Revenue-%20Cost-%20Budgets%20by%20Work%20Breakdown%20Structure/ "PA Revenue, Cost, Budgets by Work Breakdown Structure Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ap-posted-payment-register/) |
| Blitz Report™ XML Import | [AP_Posted_Payment_Register.xml](https://www.enginatics.com/xml/ap-posted-payment-register/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-posted-payment-register/](https://www.enginatics.com/reports/ap-posted-payment-register/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
