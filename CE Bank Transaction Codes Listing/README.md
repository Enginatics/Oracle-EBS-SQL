---
layout: default
last_modified_at: 2026-10-19
title: 'CE Bank Transaction Codes Listing | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Bank Transaction Codes Application: Cash Management Source: Bank Transaction Codes Listing Short Name: CEXTRXCD DB…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cash Management, Enginatics, R12 only, Bank, Transaction, Codes, Listing, ce_internal_bank_accounts_v, ce_transaction_codes_v, ce_lookups'
permalink: /CE%20Bank%20Transaction%20Codes%20Listing/
report_name: 'CE Bank Transaction Codes Listing'
report_web_name: ce-bank-transaction-codes-listing
module: 'Cash Management'
module_url: /modules/cash-management/
---

# CE Bank Transaction Codes Listing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ce-bank-transaction-codes-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing).
**Oracle EBS module:** [Cash Management](/modules/cash-management/ "Oracle EBS Cash Management reports") · [all Cash Management reports](/modules/cash-management/)  

## Overview
Imported from BI Publisher
Description: Bank Transaction Codes
Application: Cash Management
Source: Bank Transaction Codes Listing 
Short Name: CEXTRXCD
DB package: CE_CEXTRXCD_XMLP_PKG

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Bank Name, Bank Branch Name, Bank Account Name, Bank Account Number

## Oracle EBS Tables Used
[ce_internal_bank_accounts_v](https://www.enginatics.com/library/?pg=1&find=ce_internal_bank_accounts_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing), [ce_transaction_codes_v](https://www.enginatics.com/library/?pg=1&find=ce_transaction_codes_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing), [ce_lookups](https://www.enginatics.com/library/?pg=1&find=ce_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing)

## Related Reports
[CE General Ledger Reconciliation](/CE%20General%20Ledger%20Reconciliation/ "CE General Ledger Reconciliation Oracle EBS SQL Report"), [CE Cleared Transactions](/CE%20Cleared%20Transactions/ "CE Cleared Transactions Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report"), [IBY Payment Process Request Details](/IBY%20Payment%20Process%20Request%20Details/ "IBY Payment Process Request Details Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CE%20Bank%20Transaction%20Codes%20Listing/CE%20Bank%20Transaction%20Codes%20Listing.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CE Bank Transaction Codes Listing 22-Feb-2022 233052.xlsx](https://www.enginatics.com/example/ce-bank-transaction-codes-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing) |
| Blitz Report™ XML Import | [CE_Bank_Transaction_Codes_Listing.xml](https://www.enginatics.com/xml/ce-bank-transaction-codes-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing) |
| SQL Source | [CE Bank Transaction Codes Listing.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CE%20Bank%20Transaction%20Codes%20Listing/CE%20Bank%20Transaction%20Codes%20Listing.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ce-bank-transaction-codes-listing/](https://www.enginatics.com/reports/ce-bank-transaction-codes-listing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing) |

## Executive Summary
The **CE Bank Transaction Codes Listing** report provides a reference list of all transaction codes configured in the system for bank statement processing. These codes (e.g., "115" for Lockbox Deposit, "495" for Outgoing Wire) are the language the bank uses to describe transactions. Mapping these codes correctly to Oracle Transaction Types is the foundation of the Auto-Reconciliation process. This report helps verify that the system is configured to understand the electronic bank statements it receives.

## Business Challenge
Banks use standard (BAI2, SWIFT) or proprietary codes to identify transaction types. If Oracle doesn't know what "Code 501" means, it cannot automatically match that line to a payment or receipt.
*   **Auto-Reconcilition Failure**: Missing or incorrect code mappings force users to manually reconcile transactions.
*   **Configuration Drift**: Over time, as new accounts are added, transaction code mappings might not be copied or updated consistently.
*   **Bank Changes**: Banks occasionally update their code sets, requiring a system audit to ensure alignment.

## Solution
This report lists the defined transaction codes for each bank account, showing the code, description, and the Oracle Transaction Type it maps to.

**Key Features:**
*   **Account-Level Detail**: Shows mappings specific to each bank account (since different banks use different codes).
*   **Type Mapping**: Displays how the bank code translates to an Oracle type (e.g., "Code 475" = "Payment").
*   **Verification**: Used to audit the setup before going live with a new bank interface.

## Architecture
The report queries `CE_TRANSACTION_CODES_V` which holds the mapping rules.

**Key Tables:**
*   `CE_TRANSACTION_CODES_V`: The definition of bank codes and their mapping.
*   `CE_BANK_ACCOUNTS`: The bank account the codes belong to.
*   `CE_LOOKUPS`: For descriptions of the Oracle transaction types.

## Impact
*   **Automation Rates**: Accurate code mapping is the primary driver of high auto-reconciliation rates.
*   **Setup Validation**: Essential for testing and validating new bank implementations.
*   **Maintenance**: Simplifies the process of updating mappings when a bank changes its file format specifications.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ce-bank-transaction-codes-listing)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
