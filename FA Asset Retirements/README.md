---
layout: default
title: 'FA Asset Retirements | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Asset Retirements Report Application: Assets Source: Asset Retirements Report (XML) Short Name: FAS440XML DB…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Asset, Retirements, fa_deprn_periods, fa_lookups_vl, fa_system_controls'
permalink: /FA%20Asset%20Retirements/
---

# FA Asset Retirements – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-retirements/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Asset Retirements Report
Application: Assets
Source: Asset Retirements Report (XML)
Short Name: FAS440_XML
DB package: FA_FAS440_XMLP_PKG


## Report Parameters
Book, Set of Books Currency, From Period, To Period

## Oracle EBS Tables Used
[fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods), [fa_lookups_vl](https://www.enginatics.com/library/?pg=1&find=fa_lookups_vl), [fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [&lp_fa_books](https://www.enginatics.com/library/?pg=1&find=&lp_fa_books), [&lp_fa_retirements](https://www.enginatics.com/library/?pg=1&find=&lp_fa_retirements), [&lp_fa_adjustments](https://www.enginatics.com/library/?pg=1&find=&lp_fa_adjustments), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fa_asset_history](https://www.enginatics.com/library/?pg=1&find=fa_asset_history), [fa_category_books](https://www.enginatics.com/library/?pg=1&find=fa_category_books), [fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups), [fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Asset Impairments](/FA%20Asset%20Impairments/ "FA Asset Impairments Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Asset Book Details 11i](/FA%20Asset%20Book%20Details%2011i/ "FA Asset Book Details 11i Oracle EBS SQL Report"), [FA Additions By Source](/FA%20Additions%20By%20Source/ "FA Additions By Source Oracle EBS SQL Report"), [FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [FA Cost Adjustments](/FA%20Cost%20Adjustments/ "FA Cost Adjustments Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Asset Retirements 30-Aug-2021 052300.xlsx](https://www.enginatics.com/example/fa-asset-retirements/) |
| Blitz Report™ XML Import | [FA_Asset_Retirements.xml](https://www.enginatics.com/xml/fa-asset-retirements/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-asset-retirements/](https://www.enginatics.com/reports/fa-asset-retirements/) |

## Executive Summary
The **FA Asset Retirements** report details assets that have been retired or sold during a specific period. It is essential for calculating gains and losses on disposal and ensuring that retired assets are removed from the active depreciation schedule.

## Business Challenge
*   **Gain/Loss Calculation:** Accurately determining the financial impact of asset disposals.
*   **Tax Reporting:** Reporting asset disposals correctly for tax purposes.
*   **Clean Register:** Preventing "zombie assets" (retired but still on books) from inflating insurance premiums or tax liabilities.

## The Solution
This Blitz Report streamlines retirement analysis by:
*   **Gain/Loss Visibility:** Clearly showing the Proceeds of Sale, Cost of Removal, and resulting Gain/Loss.
*   **Retirement Types:** Distinguishing between sales, thefts, or casual retirements.
*   **Period-End Processing:** assisting in the month-end close process by validating all retirement transactions.

## Technical Architecture
Based on `FAS440_XML`, the report queries `FA_RETIREMENTS` and joins with `FA_BOOKS` to get the Net Book Value at the time of retirement. It calculates the gain/loss based on the formula: `Proceeds - Cost of Removal - Net Book Value`.

## Parameters & Filtering
*   **Book:** The depreciation book.
*   **From/To Period:** The period range when the retirement occurred.

## Performance & Optimization
*   **Period Range:** Keep the range consistent with your financial reporting cycle (e.g., monthly or quarterly).
*   **Currency:** Ensure the correct currency is selected if working in a multi-currency environment.

## FAQ
*   **Q: What happens if I reinstate a retirement?**
    *   A: Reinstatements are typically handled as a separate transaction type or by reversing the retirement entry, depending on how the report filters status.
*   **Q: Does this include partial retirements?**
    *   A: Yes, it shows both full and partial retirements, with the retired cost portion displayed.


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
