---
layout: default
last_modified_at: 2026-10-16
title: 'CE Bank Statement and Reconciliation | Oracle EBS SQL Report'
description: 'Application: Cash Management Description: Bank Statements - Bank Statement Details and Reconciliation Provides equivalent functionality to the following…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cash Management, Enginatics, R12 only, Bank, Statement, Reconciliation, gl_daily_conversion_types, gl_je_lines, ap_checks_all'
permalink: /CE%20Bank%20Statement%20and%20Reconciliation/
report_name: 'CE Bank Statement and Reconciliation'
report_web_name: ce-bank-statement-and-reconciliation
module: 'Cash Management'
module_url: /modules/cash-management/
---

# CE Bank Statement and Reconciliation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-bank-statement-and-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation).
**Oracle EBS module:** [Cash Management](/modules/cash-management/ "Oracle EBS Cash Management reports") · [all Cash Management reports](/modules/cash-management/)  

## Overview
Application: Cash Management
Description: Bank Statements - Bank Statement Details and Reconciliation

Provides equivalent functionality to the following standard Oracle Forms/Reports
- Bank Statements and Reconciliation Form
  Applicable Templates:
  Pivot: Bank Statement by Transaction Type
  Bank Statement Detail
  Bank Statement Detail with Reconciled Trxs
- Bank Statement Summary Report
   Applicable Templates:
   Pivot: Bank Statement by Transaction Type
   Bank Statement Summary
- Bank Statement Detail Report
   Applicable Templates:
  Pivot: Bank Statement by Transaction Type
  Bank Statement Detail
  Bank Statement Detail with Reconciled Trxs

This Blitz Report offers an extended set of parameters over and above the standard form/reports to search for specific reconciled transactions.

Sources: 
Bank Statement Detail Report (CEXSTMRR)
Bank Statement Summary Report (CEXSTMSR)
DB package:  CE_CEXSTMRR_XMLP_PKG (required to initialize security)

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Bank Name, Bank Branch, Bank Account Name, Bank Account Number, Check Digits, Statement Date From, Statement Date To, Statement GL Date From, Statement GL Date To, Statement Number From, Statement Number To, Document Number From, Document Number To, Statement Currency, Statement Line Status, Statement Complete, Trx Date From, Trx Date To, Payer/Payee Name Like, Trx Type, Trx Number, Invoice Number, Trx Amount, Trx Currency, Display Reconciled Transactions, Transaction Cleared Date From, Transaction Cleared Date To

## Oracle EBS Tables Used
[gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [gl_je_lines](https://www.enginatics.com/library/?pg=1&find=gl_je_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ce_cashflows](https://www.enginatics.com/library/?pg=1&find=ce_cashflows&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ce_statement_lines](https://www.enginatics.com/library/?pg=1&find=ce_statement_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [pay_assignment_actions](https://www.enginatics.com/library/?pg=1&find=pay_assignment_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [pay_pre_payments](https://www.enginatics.com/library/?pg=1&find=pay_pre_payments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [pay_action_interlocks](https://www.enginatics.com/library/?pg=1&find=pay_action_interlocks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ce_999_interface_v](https://www.enginatics.com/library/?pg=1&find=ce_999_interface_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [xtr_settlement_summary](https://www.enginatics.com/library/?pg=1&find=xtr_settlement_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ce_reconciled_transactions_v](https://www.enginatics.com/library/?pg=1&find=ce_reconciled_transactions_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ce_reconciliation_errors_v](https://www.enginatics.com/library/?pg=1&find=ce_reconciliation_errors_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ce_bank_accts_gt_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_accts_gt_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ce_statement_headers](https://www.enginatics.com/library/?pg=1&find=ce_statement_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [xle_entity_profiles](https://www.enginatics.com/library/?pg=1&find=xle_entity_profiles&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ce_statement_reconcils_all](https://www.enginatics.com/library/?pg=1&find=ce_statement_reconcils_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [iby_fndcpt_tx_extensions](https://www.enginatics.com/library/?pg=1&find=iby_fndcpt_tx_extensions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [ar_batches_all](https://www.enginatics.com/library/?pg=1&find=ar_batches_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation)

## Related Reports
[CE Cash in Transit](/CE%20Cash%20in%20Transit/ "CE Cash in Transit Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CE Cleared Transactions](/CE%20Cleared%20Transactions/ "CE Cleared Transactions Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CE%20Bank%20Statement%20and%20Reconciliation/CE%20Bank%20Statement%20and%20Reconciliation.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CE Bank Statement and Reconciliation 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/ce-bank-statement-and-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation) |
| Blitz Report™ XML Import | [CE_Bank_Statement_and_Reconciliation.xml](https://www.enginatics.com/xml/ce-bank-statement-and-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation) |
| SQL Source | [CE Bank Statement and Reconciliation.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CE%20Bank%20Statement%20and%20Reconciliation/CE%20Bank%20Statement%20and%20Reconciliation.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ce-bank-statement-and-reconciliation/](https://www.enginatics.com/reports/ce-bank-statement-and-reconciliation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation) |

## Case Study: Streamlining Cash Reconciliation with Oracle Cash Management

### Executive Summary
The **CE Bank Statement and Reconciliation** report is the cornerstone of cash visibility within Oracle E-Business Suite. It provides a unified view of bank statement activity and the corresponding system transactions (Payments and Receipts), enabling treasury and accounting teams to rapidly identify unreconciled items, monitor cash positions, and close the books with confidence.

### Business Challenge
Cash reconciliation is often one of the most labor-intensive processes in finance. Discrepancies between the bank statement and the general ledger can arise from numerous sources:
*   **Timing Differences:** Checks issued but not yet cleared, or deposits in transit.
*   **Bank Fees & Interest:** Miscellaneous charges on the bank statement that have not yet been recorded in the system.
*   **Data Volume:** High volumes of transactions making manual matching prone to error.
*   **Visibility Gaps:** Lack of a single view that combines data from Accounts Payable, Accounts Receivable, and the Bank Statement interface.

### The Solution
This report acts as a "Reconciliation Hub," pulling data from the Bank Statement Interface tables and joining it with the reconciled system transactions. It effectively replicates and enhances the visibility provided by the standard Bank Statement Detail and Summary reports.

#### Key Features
*   **Reconciliation Status:** Clearly flags transactions as Reconciled, Unreconciled, or Error.
*   **Cross-Module Visibility:** Links bank lines to AP Payments (`AP_CHECKS_ALL`), AR Receipts (`AR_CASH_RECEIPTS_ALL`), and GL Journal Lines (`GL_JE_LINES`).
*   **Transaction Matching:** Displays the specific system transaction number (Check Number, Receipt Number) matched to the bank line.
*   **Variance Analysis:** Highlights differences between the bank amount and the system amount to identify partial matches or exchange rate variances.

### Technical Architecture
The solution leverages the robust Oracle Cash Management schema, specifically the tables that handle the storage of bank statement files (MT940, BAI2) and their mapping to system transactions.

#### Critical Tables
*   `CE_STATEMENT_HEADERS`: Represents the bank statement file header (Bank Account, Statement Date).
*   `CE_STATEMENT_LINES`: Contains the individual line items from the bank statement (Deposits, Withdrawals, Fees).
*   `CE_RECONCILED_TRANSACTIONS_V`: A key view that links statement lines to their matched system transactions.
*   `CE_CASHFLOWS`: Handles miscellaneous transfers and manual cash entries.
*   `AP_CHECKS_ALL` / `AR_CASH_RECEIPT_HISTORY_ALL`: The source tables for the subledger transactions being reconciled.

#### Key Parameters
*   **Bank Account:** The specific internal bank account being analyzed.
*   **Statement Date Range:** The period of banking activity to review.
*   **Status:** Filter for `Unreconciled` to focus purely on open items, or `Reconciled` for audit purposes.
*   **Transaction Type:** Filter by specific activity types (e.g., PAYMENT, RECEIPT, MISC).

### Functional Analysis
#### Use Cases
1.  **Daily Reconciliation:** Treasury analysts run this report daily to match the previous day's bank feed against system activity.
2.  **Period-End Close:** The report serves as the supporting schedule for the Cash GL account balance, proving the "Adjusted Bank Balance" equals the "Book Balance."
3.  **Audit Defense:** Provides a historical record of exactly which system transaction cleared a specific bank line item.

#### FAQ
**Q: Does this report show transactions that are in the system but not on the bank statement?**
A: Primarily, this report focuses on the *Bank Statement* perspective (what is on the statement). However, by filtering for unreconciled system transactions (available in related reports), users can find the inverse.

**Q: How are foreign currency transactions handled?**
A: The report includes columns for both the Transaction Currency (e.g., invoice currency) and the Bank Currency, allowing for validation of exchange rates used during clearing.

**Q: Can this report handle manual reconciliation?**
A: Yes, whether the reconciliation was performed automatically by the AutoReconciliation program or manually by a user, the link is preserved in the `CE_RECONCILED_TRANSACTIONS_V` view.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-statement-and-reconciliation)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
