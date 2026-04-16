---
layout: default
title: 'FA Depreciation Reserve | Oracle EBS SQL Report'
description: 'Depreciation Reserve Summary/Detail Report Equivalent to Oracle Standard Reports: Reserve Summary Report Reserve Detail Report DB package: XXENFAFASXMLP'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Depreciation, Reserve, msc_form_query, fa_system_controls, gl_ledgers'
permalink: /FA%20Depreciation%20Reserve/
---

# FA Depreciation Reserve – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-depreciation-reserve/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Depreciation Reserve Summary/Detail Report

Equivalent to Oracle Standard Reports:
Reserve Summary Report
Reserve Detail Report

DB package: XXEN_FA_FAS_XMLP

## Report Parameters
Set of Books, Book, From Period, To Period, Show Impairments

## Oracle EBS Tables Used
[msc_form_query](https://www.enginatics.com/library/?pg=1&find=msc_form_query), [fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [fa_balances_report_q](https://www.enginatics.com/library/?pg=1&find=fa_balances_report_q), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[MSC Horizontal Plan](/MSC%20Horizontal%20Plan/ "MSC Horizontal Plan Oracle EBS SQL Report"), [FA Asset Cost](/FA%20Asset%20Cost/ "FA Asset Cost Oracle EBS SQL Report"), [CAC Shipping Network (Inter-Org) Accounts Setup](/CAC%20Shipping%20Network%20%28Inter-Org%29%20Accounts%20Setup/ "CAC Shipping Network (Inter-Org) Accounts Setup Oracle EBS SQL Report"), [CAC Shipping Networks Missing Interco OU Relationships](/CAC%20Shipping%20Networks%20Missing%20Interco%20OU%20Relationships/ "CAC Shipping Networks Missing Interco OU Relationships Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Depreciation Reserve 30-Aug-2021 073636.xlsx](https://www.enginatics.com/example/fa-depreciation-reserve/) |
| Blitz Report™ XML Import | [FA_Depreciation_Reserve.xml](https://www.enginatics.com/xml/fa-depreciation-reserve/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-depreciation-reserve/](https://www.enginatics.com/reports/fa-depreciation-reserve/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
