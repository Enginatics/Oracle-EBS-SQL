---
layout: default
last_modified_at: 2026-10-16
title: 'GL Trial Balance - Detail | Oracle EBS SQL Report'
description: 'Imported from Concurrent Program Description: Detail Trial Balance (XML) Application: General Ledger Source: Trial Balance - Detail (XML) Short Name…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, General Ledger, Enginatics, R12 only, Trial, Balance, Detail, gl_ledgers, gl_ledger_set_assignments, gl_ledger_relationships'
permalink: /GL%20Trial%20Balance%20-%20Detail/
report_name: 'GL Trial Balance - Detail'
report_web_name: gl-trial-balance-detail
module: 'General Ledger'
module_url: /modules/general-ledger/
---

# GL Trial Balance - Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-trial-balance-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail).
**Oracle EBS module:** [General Ledger](/modules/general-ledger/ "Oracle EBS General Ledger reports") · [all General Ledger reports](/modules/general-ledger/)  

## Overview
Imported from Concurrent Program
Description: Detail Trial Balance (XML)
Application: General Ledger
Source: Trial Balance - Detail (XML)
Short Name: GLTRBALD
DB package:

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger/Ledger Set, Ledger Currency, Currency Type, Entered Currency, Pivot Segment, Pivot Segment Low, Pivot Segment High, Period, Amount Type, Active Accounts Only, Show Parents, DFF Display, Secondary COA Mapping

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail), [gl_ledger_set_assignments](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail), [gl_ledger_relationships](https://www.enginatics.com/library/?pg=1&find=gl_ledger_relationships&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail), [gl_balances](https://www.enginatics.com/library/?pg=1&find=gl_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Trial%20Balance%20-%20Detail/GL%20Trial%20Balance%20-%20Detail.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Trial Balance - Detail - Trial Balance Pivot 19-Jul-2023 164357.xlsx](https://www.enginatics.com/example/gl-trial-balance-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail) |
| Blitz Report™ XML Import | [GL_Trial_Balance_Detail.xml](https://www.enginatics.com/xml/gl-trial-balance-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail) |
| SQL Source | [GL Trial Balance - Detail.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Trial%20Balance%20-%20Detail/GL%20Trial%20Balance%20-%20Detail.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-trial-balance-detail/](https://www.enginatics.com/reports/gl-trial-balance-detail/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail) |

## GL Trial Balance - Detail - Case Study & Technical Analysis

### Executive Summary
The **GL Trial Balance - Detail** report is a fundamental financial report that lists the balances of all General Ledger accounts, broken down by their individual segments (Company, Department, Account, etc.). Unlike a summary trial balance, this report provides the granular detail necessary for deep-dive analysis, period-end reconciliation, and audit verification. It serves as the primary "proof" that the books are in balance (Debits = Credits).

### Business Use Cases
*   **Period-End Close**: The primary tool used by accountants to verify that all subledger entries have been posted and that the trial balance nets to zero before closing the period.
*   **Account Reconciliation**: Used to compare the GL balance of a specific account (e.g., "Accounts Payable") against the corresponding subledger report (e.g., "AP Trial Balance") to identify discrepancies.
*   **Audit Support**: Provides external auditors with a complete listing of account balances at the end of the fiscal year.
*   **Variance Analysis**: Allows analysts to compare balances across periods (if run for multiple periods) or to drill down into specific cost centers or departments.

### Technical Analysis

#### Core Tables
*   `GL_BALANCES`: The primary source of data, storing the period-to-date and year-to-date balances for every code combination.
*   `GL_CODE_COMBINATIONS`: Resolves the account segments.
*   `GL_LEDGERS`: Defines the currency and chart of accounts context.
*   *(XML Publisher Source)*: This report is often based on the standard Oracle XML Publisher data definition `GLTRBALD`, which uses a package to extract data.

#### Key Joins & Logic
*   **Balance Calculation**: The report aggregates `BEGINNING_BALANCE`, `PERIOD_NET_DR`, and `PERIOD_NET_CR` from `GL_BALANCES` to calculate the `ENDING_BALANCE`.
*   **Currency Handling**: It handles "Entered" vs. "Accounted" currencies. For foreign currency accounts, it can show the balance in the original currency (e.g., EUR) as well as the functional currency (e.g., USD).
*   **Translation**: If run for a translated currency, it uses the translated balances.

#### Key Parameters
*   **Ledger/Ledger Set**: The entity to report on.
*   **Period**: The specific accounting period.
*   **Currency**: The currency to view (Functional, Foreign, or Translated).
*   **Amount Type**: PTD (Period to Date) or YTD (Year to Date).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-trial-balance-detail)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
