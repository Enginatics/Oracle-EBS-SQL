---
layout: default
title: 'GL Trial Balance - Detail | Oracle EBS SQL Report'
description: 'Imported from Concurrent Program Description: Detail Trial Balance (XML) Application: General Ledger Source: Trial Balance - Detail (XML) Short Name…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Trial, Balance, Detail'
permalink: /GL%20Trial%20Balance%20-%20Detail/
---

# GL Trial Balance - Detail – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-trial-balance-detail/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from Concurrent Program
Description: Detail Trial Balance (XML)
Application: General Ledger
Source: Trial Balance - Detail (XML)
Short Name: GLTRBALD
DB package:

## Report Parameters
Ledger/Ledger Set, Ledger Currency, Currency Type, Entered Currency, Pivot Segment, Pivot Segment Low, Pivot Segment High, Period, Amount Type, Active Accounts Only, Show Parents, Show DFF Attributes

## Oracle EBS Tables Used


## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Trial Balance - Detail - Trial Balance Pivot 19-Jul-2023 164357.xlsx](https://www.enginatics.com/example/gl-trial-balance-detail/) |
| Blitz Report™ XML Import | [GL_Trial_Balance_Detail.xml](https://www.enginatics.com/xml/gl-trial-balance-detail/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-trial-balance-detail/](https://www.enginatics.com/reports/gl-trial-balance-detail/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
