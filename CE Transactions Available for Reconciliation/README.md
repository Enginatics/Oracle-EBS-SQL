---
layout: default
title: 'CE Transactions Available for Reconciliation | Oracle EBS SQL Report'
description: 'Application: Cash Management Description: Transactions - Transactions Available for Reconciliation Provides equivalent functionality to the following…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Transactions, Available, Reconciliation, ce_101_transactions_v, ce_185_transactions_v, ce_200_transactions_v'
permalink: /CE%20Transactions%20Available%20for%20Reconciliation/
---

# CE Transactions Available for Reconciliation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-transactions-available-for-reconciliation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Cash Management
Description: Transactions - Transactions Available for Reconciliation

Provides equivalent functionality to the following standard Oracle Forms/Reports
- Transactions Available for Reconciliation Report
  Applicable Templates:
  Pivot: Transactions Available by Bank Account, Source and Type

Source: Transactions Available for Reconciliation Report (CEXAVTRX)
DB package: CE_CEXSTMRR_XMLP_PKG (required to initialize security)

## Report Parameters
Bank Name, Bank Branch, Bank Account Name, Bank Account Number, Transaction Type, Treasury Legal Entity, Payroll Business Group, AR/AP Operating Unit, Effective Date From, Effective Date To

## Oracle EBS Tables Used
[ce_101_transactions_v](https://www.enginatics.com/library/?pg=1&find=ce_101_transactions_v), [ce_185_transactions_v](https://www.enginatics.com/library/?pg=1&find=ce_185_transactions_v), [ce_200_transactions_v](https://www.enginatics.com/library/?pg=1&find=ce_200_transactions_v), [ce_222_transactions_v](https://www.enginatics.com/library/?pg=1&find=ce_222_transactions_v), [ce_801_transactions_v](https://www.enginatics.com/library/?pg=1&find=ce_801_transactions_v), [ce_801_eft_transactions_v](https://www.enginatics.com/library/?pg=1&find=ce_801_eft_transactions_v), [ce_999_transactions_v](https://www.enginatics.com/library/?pg=1&find=ce_999_transactions_v), [ce_avail_trx_v](https://www.enginatics.com/library/?pg=1&find=ce_avail_trx_v), [ce_bank_accts_gt_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_accts_gt_v), [ce_system_parameters](https://www.enginatics.com/library/?pg=1&find=ce_system_parameters), [xle_entity_profiles](https://www.enginatics.com/library/?pg=1&find=xle_entity_profiles), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ce-transactions-available-for-reconciliation/) |
| Blitz Report™ XML Import | [CE_Transactions_Available_for_Reconciliation.xml](https://www.enginatics.com/xml/ce-transactions-available-for-reconciliation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ce-transactions-available-for-reconciliation/](https://www.enginatics.com/reports/ce-transactions-available-for-reconciliation/) |

## Executive Summary
The **CE Transactions Available for Reconciliation** report lists all system transactions (payments, receipts, journal entries) that are eligible to be reconciled against a bank statement but have not yet been matched. This is effectively the "To-Do List" for the reconciliation team. It helps identify transactions that are missing from the bank statement or that need to be manually reconciled due to data mismatches.

## Business Challenge
If a transaction exists in Oracle but hasn't been reconciled, it means either:
1.  It hasn't cleared the bank yet (In Transit).
2.  It has cleared, but the system couldn't auto-match it (e.g., different amount or reference number).
3.  It is a duplicate or erroneous entry.

Distinguishing between "In Transit" and "Problem" items is crucial for keeping the reconciliation current.

## Solution
This report provides a comprehensive list of all unreconciled transactions available in the system.

**Key Features:**
*   **Source Filtering**: Can filter by Source (AP, AR, GL, Payroll) to route issues to the correct department.
*   **Date Range**: Allows users to focus on older items that should have cleared by now.
*   **Detail View**: Shows the Transaction Number, Date, Amount, and Currency for easy comparison with the bank statement.

## Architecture
The report queries the `CE_AVAILABLE_TRANSACTIONS_V` view, which unions all eligible unreconciled items from the subledgers.

**Key Tables:**
*   `CE_AVAILABLE_TRANSACTIONS_V`: The master view for unreconciled items.
*   `AP_CHECKS_ALL`: Unreconciled payments.
*   `AR_CASH_RECEIPTS`: Unreconciled receipts.
*   `GL_JE_LINES`: Unreconciled manual journal entries.

## Impact
*   **Reconciliation Efficiency**: Helps users quickly identify transactions that need manual attention.
*   **Data Cleanup**: Highlights old, stale transactions that may need to be voided or reversed.
*   **Cash Control**: Ensures that every system transaction is eventually accounted for against the bank.


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
