---
layout: default
title: 'FA Tax Reserve Ledger | Oracle EBS SQL Report'
description: 'Imported Oracle standard tax reserve ledger report Source: Tax Reserve Ledger Report (XML) Short Name: FAS480XML DB package: FAFAS480XMLPPKG Custom…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Tax, Reserve, Ledger, fa_system_controls, gl_ledgers, fnd_currencies'
permalink: /FA%20Tax%20Reserve%20Ledger/
---

# FA Tax Reserve Ledger – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-tax-reserve-ledger/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard tax reserve ledger report
Source: Tax Reserve Ledger Report (XML)
Short Name: FAS480_XML
DB package: FA_FAS480_XMLP_PKG
Custom Package: XXEN_FA_FAS_XMLP

## Report Parameters
Book, Set of Books Currency, Period

## Oracle EBS Tables Used
[fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls), [fa_reserve_ledger_gt](https://www.enginatics.com/library/?pg=1&find=fa_reserve_ledger_gt), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fa_fiscal_year](https://www.enginatics.com/library/?pg=1&find=fa_fiscal_year)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FA Asset Cost](/FA%20Asset%20Cost/ "FA Asset Cost Oracle EBS SQL Report"), [FA Revaluation Reserve](/FA%20Revaluation%20Reserve/ "FA Revaluation Reserve Oracle EBS SQL Report"), [FA Depreciation Reserve](/FA%20Depreciation%20Reserve/ "FA Depreciation Reserve Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA CIP Cost](/FA%20CIP%20Cost/ "FA CIP Cost Oracle EBS SQL Report"), [FA Journal Entry Reserve Ledger](/FA%20Journal%20Entry%20Reserve%20Ledger/ "FA Journal Entry Reserve Ledger Oracle EBS SQL Report"), [FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Tax Reserve Ledger 30-Aug-2021 053238.xlsx](https://www.enginatics.com/example/fa-tax-reserve-ledger/) |
| Blitz Report™ XML Import | [FA_Tax_Reserve_Ledger.xml](https://www.enginatics.com/xml/fa-tax-reserve-ledger/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-tax-reserve-ledger/](https://www.enginatics.com/reports/fa-tax-reserve-ledger/) |

## Executive Summary
The **FA Tax Reserve Ledger** is a critical report for tax reporting, specifically designed to reconcile the tax book's depreciation reserve. It ensures that the accumulated depreciation for tax purposes is accurately recorded and matches the tax ledger.

## Business Challenge
*   **Tax Compliance:** Meeting the strict reporting requirements of tax authorities.
*   **Deferred Tax Calculation:** Providing the data needed to calculate deferred tax assets or liabilities (the difference between book and tax depreciation).
*   **Audit Readiness:** Having a clear, detailed ledger of tax depreciation for auditors.

## The Solution
This Blitz Report mirrors the standard `FAS480_XML` report but delivers it in Excel for easier analysis:
*   **Tax Book Focus:** Specifically targets tax books, which often have different depreciation rules than corporate books.
*   **Fiscal Year Alignment:** Respects the fiscal year definitions associated with the tax book.
*   **Detailed Listing:** Shows the reserve movement for each asset within the tax book.

## Technical Architecture
The report uses `FA_RESERVE_LEDGER_GT` to capture the depreciation run details. It joins with `FA_FISCAL_YEAR` to ensure the reporting period aligns with the tax year, which may differ from the corporate fiscal year.

## Parameters & Filtering
*   **Book:** The tax depreciation book.
*   **Period:** The period to report on.

## Performance & Optimization
*   **Run Timing:** Should be run after the tax book depreciation is closed for the period.
*   **Data Volume:** Tax books often contain the same assets as corporate books, so data volume is similar.

## FAQ
*   **Q: Can I run this for a corporate book?**
    *   A: Yes, technically, but the "Journal Entry Reserve Ledger" is usually preferred for corporate books. This report is labeled "Tax" to indicate its typical use case.
*   **Q: Why are the amounts different from the Corporate book?**
    *   A: Tax books usually use accelerated depreciation methods (like MACRS) compared to straight-line in corporate books, leading to different reserve balances.


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
