---
layout: default
title: 'CE General Ledger Reconciliation | Oracle EBS SQL Report'
description: 'Application: Cash Management Description: Bank Statements - General Ledger Reconciliation Provides equivalent functionality to the following standard…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, General, Ledger, Reconciliation, gl_balances, gl_code_combinations, ce_bank_accounts'
permalink: /CE%20General%20Ledger%20Reconciliation/
---

# CE General Ledger Reconciliation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-general-ledger-reconciliation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Cash Management
Description: Bank Statements - General Ledger Reconciliation

Provides equivalent functionality to the following standard Oracle Forms/Reports
- General Ledger Reconciliation Report
  Applicable Templates:
  Pivot: Reconciliation Summary

Source: General Ledger Reconciliation Report
Short Name: CEXRECRE
DB package: CE_CEXRECRE_XMLP_PKG

## Report Parameters
Legal Entity, Bank Account Name, Bank Account Number, Period Name, Closing Balance

## Oracle EBS Tables Used
[gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts), [ce_bank_acct_uses_all](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_all), [ce_gl_accounts_ccid](https://www.enginatics.com/library/?pg=1&find=ce_gl_accounts_ccid), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [ar_cash_receipts](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts), [ar_cash_receipt_history](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods), [ce_bank_acct_uses_ou_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_ou_v), [ce_system_parameters](https://www.enginatics.com/library/?pg=1&find=ce_system_parameters), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all), [ce_statement_recon_gt_v](https://www.enginatics.com/library/?pg=1&find=ce_statement_recon_gt_v), [ce_statement_lines](https://www.enginatics.com/library/?pg=1&find=ce_statement_lines), [ce_statement_headers](https://www.enginatics.com/library/?pg=1&find=ce_statement_headers), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [ce_security_profiles_gt](https://www.enginatics.com/library/?pg=1&find=ce_security_profiles_gt), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities), [xla_events](https://www.enginatics.com/library/?pg=1&find=xla_events), [ap_payment_history_all](https://www.enginatics.com/library/?pg=1&find=ap_payment_history_all), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines), [ce_statement_reconcils_all](https://www.enginatics.com/library/?pg=1&find=ce_statement_reconcils_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CE General Ledger Reconciliation 06-Sep-2021 012753.xlsx](https://www.enginatics.com/example/ce-general-ledger-reconciliation/) |
| Blitz Report™ XML Import | [CE_General_Ledger_Reconciliation.xml](https://www.enginatics.com/xml/ce-general-ledger-reconciliation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ce-general-ledger-reconciliation/](https://www.enginatics.com/reports/ce-general-ledger-reconciliation/) |

## Executive Summary
The **CE General Ledger Reconciliation** report is the primary month-end report for reconciling the General Ledger cash balance to the Bank Statement balance. It highlights the differences caused by unposted journals, unreconciled transactions, and transactions in the subledger that haven't been transferred to GL. This report is the "bridge" that proves the financial statements accurately reflect the cash position.

## Business Challenge
Reconciling the GL to the Bank is a multi-step process involving three balances:
1.  **Bank Balance**: What the bank says we have.
2.  **Subledger Balance**: What AP/AR says we have.
3.  **GL Balance**: What the Trial Balance says we have.

Discrepancies can arise from manual journals, unposted batches, or timing differences. Identifying the root cause of a variance is often the most stressful part of the month-end close.

## Solution
This report compares the GL Account Balance (for the designated cash account) against the Bank Statement Balance and itemizes the reconciling items.

**Key Features:**
*   **Three-Way Match**: Conceptually links Bank, Subledger, and GL.
*   **Variance Identification**: Explicitly lists "Transactions in GL but not in Bank" and "Transactions in Bank but not in GL".
*   **Period-End Focus**: Designed to be run for a specific accounting period to support the close process.

## Architecture
The report aggregates `GL_BALANCES` for the cash account and compares it to the `CE_STATEMENT_HEADERS` closing balance, adjusting for unreconciled items in `CE_STATEMENT_LINES` and `CE_AVAILABLE_TRANSACTIONS`.

**Key Tables:**
*   `GL_BALANCES`: The official GL balance.
*   `CE_STATEMENT_HEADERS`: The official bank balance.
*   `CE_RECONCILIATION_ERRORS`: Any system errors preventing reconciliation.
*   `XLA_AE_LINES`: Subledger accounting entries (to check for posting status).

## Impact
*   **Financial Integrity**: Validates the accuracy of the Cash line item on the Balance Sheet.
*   **Audit Compliance**: Serves as the primary evidence of cash control for external auditors.
*   **Process Improvement**: Highlights recurring reconciling items (e.g., manual journals) that should be automated.


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
