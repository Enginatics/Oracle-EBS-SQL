---
layout: default
title: 'CE General Ledger Cash Account Usage | Oracle EBS SQL Report'
description: 'Application: Cash Management Description: Cash Account Usage This report details the General Ledger Cash Accounts assigned to Bank Accounts, and their…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, General, Ledger, Cash, Account, ce_bank_accounts, xle_entity_profiles, gl_ledgers'
permalink: /CE%20General%20Ledger%20Cash%20Account%20Usage/
---

# CE General Ledger Cash Account Usage – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-general-ledger-cash-account-usage/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Cash Management
Description: Cash Account Usage

This report details the General Ledger Cash Accounts assigned to Bank Accounts, and their usage.

The following templates are available:
Pivot: Bank Accounts, Assigned Cash Accounts - Pivot by Bank Account, Cash Account showing cash account usage within each bank account.
Pivot: Cash Account, Assigned Bank Accounts - Pivot by Cash Account, Bank Account, showing cash account usage within each bank account. 


## Report Parameters
Legal Entity, Bank Name, Bank Branch, Bank Account Name, Bank Account Number, Bank Account Currency, Cash Account

## Oracle EBS Tables Used
[ce_bank_accounts](https://www.enginatics.com/library/?pg=1&find=ce_bank_accounts), [xle_entity_profiles](https://www.enginatics.com/library/?pg=1&find=xle_entity_profiles), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [ce_bank_acct_uses_all](https://www.enginatics.com/library/?pg=1&find=ce_bank_acct_uses_all), [ce_security_profiles_v](https://www.enginatics.com/library/?pg=1&find=ce_security_profiles_v), [ce_gl_accounts_ccid](https://www.enginatics.com/library/?pg=1&find=ce_gl_accounts_ccid), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CE General Ledger Reconciliation](/CE%20General%20Ledger%20Reconciliation/ "CE General Ledger Reconciliation Oracle EBS SQL Report"), [CE Cleared Transactions](/CE%20Cleared%20Transactions/ "CE Cleared Transactions Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [CE Bank Account Balances](/CE%20Bank%20Account%20Balances/ "CE Bank Account Balances Oracle EBS SQL Report"), [IBY Payment Process Request Details](/IBY%20Payment%20Process%20Request%20Details/ "IBY Payment Process Request Details Oracle EBS SQL Report"), [AR Miscellaneous Receipts](/AR%20Miscellaneous%20Receipts/ "AR Miscellaneous Receipts Oracle EBS SQL Report"), [AR Unapplied Receipts Register](/AR%20Unapplied%20Receipts%20Register/ "AR Unapplied Receipts Register Oracle EBS SQL Report"), [AR Transactions and Payments](/AR%20Transactions%20and%20Payments/ "AR Transactions and Payments Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CE General Ledger Cash Account Usage 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/ce-general-ledger-cash-account-usage/) |
| Blitz Report™ XML Import | [CE_General_Ledger_Cash_Account_Usage.xml](https://www.enginatics.com/xml/ce-general-ledger-cash-account-usage/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ce-general-ledger-cash-account-usage/](https://www.enginatics.com/reports/ce-general-ledger-cash-account-usage/) |

## Executive Summary
The **CE General Ledger Cash Account Usage** report is a configuration audit tool that maps Bank Accounts to their corresponding General Ledger (GL) Cash Accounts. In Oracle, a single bank account can be linked to multiple GL accounts (e.g., for different currencies or operating units), and conversely, a GL account might be shared. This report visualizes these relationships to ensure that cash activity is being booked to the correct ledger accounts.

## Business Challenge
The link between the Bank Account (Treasury) and the GL Account (Accounting) is defined in the Bank Account Setup.
*   **Mispostings**: If a bank account is mapped to the wrong GL account, cash transactions will be recorded in the wrong place, causing reconciliation nightmares.
*   **Segregation of Duties**: Ensuring that specific bank accounts map to specific GL accounts is often a compliance requirement.
*   **Complexity**: In multi-org environments, the mapping rules can become complex and hard to visualize one screen at a time.

## Solution
This report provides a matrix view of Bank Accounts and their assigned GL Cash Accounts.

**Key Features:**
*   **Bi-Directional Pivot**: Can be viewed by Bank Account (showing all GL accounts used) or by GL Account (showing all Bank Accounts linked).
*   **Currency Visibility**: Shows the currency of both the bank account and the GL account to ensure alignment.
*   **Legal Entity Context**: Groups accounts by Legal Entity to validate ownership.

## Architecture
The report queries `CE_BANK_ACCOUNTS` and joins to `CE_GL_ACCOUNTS_CCID` (or `CE_BANK_ACCT_USES_ALL`) to retrieve the accounting flexfield segments.

**Key Tables:**
*   `CE_BANK_ACCOUNTS`: Bank account definitions.
*   `CE_BANK_ACCT_USES_ALL`: The usage assignment (which links the bank account to a specific Org and GL Account).
*   `GL_CODE_COMBINATIONS`: The GL account details.

## Impact
*   **Configuration Accuracy**: Validates that the Treasury-to-GL mapping is correct.
*   **Reconciliation Readiness**: Ensures that the "GL Balance" used in reconciliation reports is pulling from the correct combination of accounts.
*   **System Cleanup**: Helps identify unused or incorrectly mapped GL accounts.


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
