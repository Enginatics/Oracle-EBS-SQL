---
layout: default
title: 'FA Revaluation Reserve | Oracle EBS SQL Report'
description: 'Revaluation Reserve Summary/Detail Report Equivalent to Oracle Standard Reports: Revaluation Reserve Summary Report Revaluation Reserve Detail Report DB…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Revaluation, Reserve, fa_system_controls, gl_ledgers, fnd_currencies'
permalink: /FA%20Revaluation%20Reserve/
---

# FA Revaluation Reserve – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-revaluation-reserve/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Revaluation Reserve Summary/Detail Report

Equivalent to Oracle Standard Reports:
Revaluation Reserve Summary Report
Revaluation Reserve Detail Report

DB package: XXEN_FA_FAS_XMLP

## Report Parameters
Book, Set of Books Currency, From Period, To Period

## Oracle EBS Tables Used
[fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [fa_balances_report_gt](https://www.enginatics.com/library/?pg=1&find=fa_balances_report_gt), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Revaluation Reserve 30-Aug-2021 080055.xlsx](https://www.enginatics.com/example/fa-revaluation-reserve/) |
| Blitz Report™ XML Import | [FA_Revaluation_Reserve.xml](https://www.enginatics.com/xml/fa-revaluation-reserve/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-revaluation-reserve/](https://www.enginatics.com/reports/fa-revaluation-reserve/) |

## Executive Summary
The **FA Revaluation Reserve** report tracks the revaluation reserve account, which holds the unrealized gains or losses from asset revaluations. This is critical for companies that use the revaluation model for fixed assets (common in IFRS and public sector).

## Business Challenge
*   **Revaluation Tracking:** Monitoring the surplus created when an asset is revalued upwards.
*   **Equity Reporting:** The revaluation reserve is often part of Shareholder's Equity; accuracy is paramount.
*   **Amortization:** Tracking the amortization of the revaluation reserve over the asset's life.

## The Solution
This Blitz Report provides a clear view of the revaluation reserve activity:
*   **Movement Analysis:** Shows the beginning balance, revaluation impact, amortization, and ending balance.
*   **Asset Detail:** Links the reserve balance to specific assets.
*   **Compliance:** Supports reporting requirements for jurisdictions allowing asset revaluation.

## Technical Architecture
Equivalent to the standard Revaluation Reserve reports, it uses `FA_BALANCES_REPORT_GT` to calculate the buckets for the revaluation reserve. It tracks the `REVAL_RESERVE` column in the FA books.

## Parameters & Filtering
*   **Book:** The asset book (must be a book where revaluation is enabled).
*   **Period:** The reporting period.

## Performance & Optimization
*   **Revaluation Only:** This report is only relevant for books where revaluation has occurred. If you don't revalue assets, this report will be empty.
*   **Summary Mode:** Use summary mode for high-level equity reporting.

## FAQ
*   **Q: What triggers a change in this reserve?**
    *   A: Running the "Mass Revaluation" program or manually revaluing an asset.
*   **Q: Can the reserve be negative?**
    *   A: Typically, a revaluation reserve represents a gain (credit balance). A loss usually goes to the P&L unless it reverses a previous gain.


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
