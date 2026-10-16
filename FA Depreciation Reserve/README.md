---
layout: default
last_modified_at: 2026-10-16
title: 'FA Depreciation Reserve | Oracle EBS SQL Report'
description: 'Depreciation Reserve Summary/Detail Report Equivalent to Oracle Standard Reports: Reserve Summary Report Reserve Detail Report DB package: XXENFAFASXMLP'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Assets, Enginatics, R12 only, Depreciation, Reserve, msc_form_query, fa_system_controls, gl_ledgers'
permalink: /FA%20Depreciation%20Reserve/
report_name: 'FA Depreciation Reserve'
report_web_name: fa-depreciation-reserve
module: 'Assets'
module_url: /modules/assets/
---

# FA Depreciation Reserve – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-depreciation-reserve/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve).
**Oracle EBS module:** [Assets](/modules/assets/ "Oracle EBS Assets reports") · [all Assets reports](/modules/assets/)  

## Overview
Depreciation Reserve Summary/Detail Report

Equivalent to Oracle Standard Reports:
Reserve Summary Report
Reserve Detail Report

DB package: XXEN_FA_FAS_XMLP

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Set of Books, Book, From Period, To Period, Show Impairments

## Oracle EBS Tables Used
[msc_form_query](https://www.enginatics.com/library/?pg=1&find=msc_form_query&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve), [fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve)

## Related Reports
[FA CIP Cost](/FA%20CIP%20Cost/ "FA CIP Cost Oracle EBS SQL Report"), [FA Asset Cost](/FA%20Asset%20Cost/ "FA Asset Cost Oracle EBS SQL Report"), [FA Revaluation Reserve](/FA%20Revaluation%20Reserve/ "FA Revaluation Reserve Oracle EBS SQL Report"), [FA Tax Reserve Ledger](/FA%20Tax%20Reserve%20Ledger/ "FA Tax Reserve Ledger Oracle EBS SQL Report"), [FA Cost Adjustments](/FA%20Cost%20Adjustments/ "FA Cost Adjustments Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Depreciation%20Reserve/FA%20Depreciation%20Reserve.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Depreciation Reserve 30-Aug-2021 073636.xlsx](https://www.enginatics.com/example/fa-depreciation-reserve/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve) |
| Blitz Report™ XML Import | [FA_Depreciation_Reserve.xml](https://www.enginatics.com/xml/fa-depreciation-reserve/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve) |
| SQL Source | [FA Depreciation Reserve.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Depreciation%20Reserve/FA%20Depreciation%20Reserve.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fa-depreciation-reserve/](https://www.enginatics.com/reports/fa-depreciation-reserve/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve) |

## Executive Summary
The **FA Depreciation Reserve** report provides a snapshot of the accumulated depreciation for assets as of a specific period. It is a key report for reconciling the Accumulated Depreciation account in the General Ledger.

## Business Challenge
*   **GL Reconciliation:** Verifying that the subledger's accumulated depreciation matches the GL balance.
*   **Net Book Value Analysis:** Understanding the remaining life and value of the asset portfolio.
*   **Impairment Tracking:** Seeing the impact of impairments on the reserve.

## The Solution
This Blitz Report offers a robust view of the reserve account:
*   **Roll-Forward Logic:** Shows the beginning balance, additions (depreciation expense), adjustments, and ending balance.
*   **Impairment Visibility:** Optionally includes impairment amounts which reduce the Net Book Value.
*   **Drill-Down:** Can be run at a summary level for reconciliation or detail level for asset analysis.

## Technical Architecture
Equivalent to the standard Reserve Summary/Detail reports, it uses `FA_BALANCES_REPORT_GT` to calculate the movement of the reserve account. It aggregates depreciation expense, retirements, and adjustments to derive the ending reserve.

## Parameters & Filtering
*   **Book:** The depreciation book.
*   **Period:** The "as-of" period for the report.
*   **Show Impairments:** Toggle to display impairment columns.

## Performance & Optimization
*   **Summary vs. Detail:** Use the Summary version for high-level GL checks. Use Detail only when investigating discrepancies.
*   **Currency:** Ensure the correct currency is selected for multi-currency books.

## FAQ
*   **Q: How does this differ from the Account Analysis?**
    *   A: This report focuses specifically on the *Reserve* (Accumulated Depreciation) account and its roll-forward, whereas Account Analysis covers all asset accounts.
*   **Q: Does it show YTD depreciation?**
    *   A: Yes, it typically shows the depreciation expense for the period and the Year-To-Date accumulation.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-depreciation-reserve)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
