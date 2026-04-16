---
layout: default
title: 'FA Asset Reclassification | Oracle EBS SQL Report'
description: 'Application: Assets Source: Asset Reclassification Report (XML) - Not Supported: Reserved For Future Use Short Name: FAS740XML DB package: FAFAS740XMLPPKG'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Asset, Reclassification, fa_system_controls, fa_book_controls_sec, fa_deprn_periods'
permalink: /FA%20Asset%20Reclassification/
---

# FA Asset Reclassification – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-reclassification/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Assets
Source: Asset Reclassification Report (XML) - Not Supported: Reserved For Future Use
Short Name: FAS740_XML
DB package: FA_FAS740_XMLP_PKG

## Report Parameters
Ledger, Book, From Period, To Period

## Oracle EBS Tables Used
[fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [fa_book_controls_sec](https://www.enginatics.com/library/?pg=1&find=fa_book_controls_sec), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fa_categories](https://www.enginatics.com/library/?pg=1&find=fa_categories), [fa_category_books](https://www.enginatics.com/library/?pg=1&find=fa_category_books), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers), [fa_adjustments](https://www.enginatics.com/library/?pg=1&find=fa_adjustments), [fa_asset_history](https://www.enginatics.com/library/?pg=1&find=fa_asset_history), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [fa_calendar_periods](https://www.enginatics.com/library/?pg=1&find=fa_calendar_periods)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [FA Asset Retirements](/FA%20Asset%20Retirements/ "FA Asset Retirements Oracle EBS SQL Report"), [FA Cost Adjustments](/FA%20Cost%20Adjustments/ "FA Cost Adjustments Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Asset Reclassification - Default 08-Oct-2023 234832.xlsx](https://www.enginatics.com/example/fa-asset-reclassification/) |
| Blitz Report™ XML Import | [FA_Asset_Reclassification.xml](https://www.enginatics.com/xml/fa-asset-reclassification/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-asset-reclassification/](https://www.enginatics.com/reports/fa-asset-reclassification/) |

## Executive Summary
The **FA Asset Reclassification** report tracks changes in asset categorization, which is vital for maintaining accurate financial reporting and depreciation schedules. It details assets that have been moved from one category to another within a specified period, ensuring transparency in asset lifecycle management.

## Business Challenge
*   **Depreciation Errors:** Incorrect asset categorization can lead to wrong depreciation rates and financial misstatements.
*   **Audit Compliance:** Auditors require a clear trail of why and when assets were reclassified.
*   **Policy Enforcement:** Ensuring that assets are grouped correctly according to corporate accounting policies.

## The Solution
This Blitz Report provides a clear view of reclassification events by:
*   **Transaction Visibility:** Listing the old and new category for each reclassified asset.
*   **Period-Based Reporting:** allowing users to focus on changes within a specific financial period.
*   **Drill-Down Details:** Including transaction headers and adjustment details to explain the change.

## Technical Architecture
The report is based on the Oracle standard `FAS740_XML` logic. It queries `FA_TRANSACTION_HEADERS` to identify reclassification transactions (`RECLASS`). It joins with `FA_ADDITIONS` and `FA_CATEGORIES` to retrieve asset and category descriptions.

## Parameters & Filtering
*   **Ledger/Book:** Specifies the accounting context.
*   **From/To Period:** Defines the range of time to search for reclassification transactions.

## Performance & Optimization
*   **Period Selection:** Restricting the report to a single period or a small range improves performance, as transaction tables can be large.
*   **Book:** Always specify the book to avoid scanning unrelated data.

## FAQ
*   **Q: Does this change the asset's cost?**
    *   A: Reclassification itself doesn't change the cost, but it might trigger a recalculation of depreciation if the new category has different rules.
*   **Q: Can I see who performed the reclassification?**
    *   A: Yes, the report typically includes the `WHO` columns (Created By) from the transaction header.


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
