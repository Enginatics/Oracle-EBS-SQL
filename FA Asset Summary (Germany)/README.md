---
layout: default
title: 'FA Asset Summary (Germany) | Oracle EBS SQL Report'
description: 'Description: Asset Summary Report (Germany) Application: Assets This Blitz Report has been extended to allow it to be run across multiple Ledgers and/or…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Asset, Summary, (Germany), fa_deprn_periods, fa_asset_history, gl_code_combinations'
permalink: /FA%20Asset%20Summary%20%28Germany%29/
---

# FA Asset Summary (Germany) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-summary-germany/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Description: Asset Summary Report (Germany)
Application: Assets

This Blitz Report has been extended to allow it to be run across multiple Ledgers and/or Asset Books.

Source: Asset Summary Report (Germany)
Short Name: FASSUMRPT
DB package: XXEN_FA_FAS_XMLP

## Report Parameters
Ledger, Book Class, Book, From Period, To Period, From Category, To Category, From Balancing Segment, To Balancing Segment, From Account Segment, To Account Segment, Asset Type, Descriptive Flexfield Attributes

## Oracle EBS Tables Used
[fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods), [fa_asset_history](https://www.enginatics.com/library/?pg=1&find=fa_asset_history), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fa_categories_b](https://www.enginatics.com/library/?pg=1&find=fa_categories_b), [fa_category_books](https://www.enginatics.com/library/?pg=1&find=fa_category_books), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [fa_asset_keywords_kfv](https://www.enginatics.com/library/?pg=1&find=fa_asset_keywords_kfv), [fa_book_controls_sec](https://www.enginatics.com/library/?pg=1&find=fa_book_controls_sec), [fa_books](https://www.enginatics.com/library/?pg=1&find=fa_books), [fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups), [fa_summary](https://www.enginatics.com/library/?pg=1&find=fa_summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Asset Summary (Germany) - Pivot - Detailed (with Asset Details) 03-Jul-2024 114249.xlsx](https://www.enginatics.com/example/fa-asset-summary-germany/) |
| Blitz Report™ XML Import | [FA_Asset_Summary_Germany.xml](https://www.enginatics.com/xml/fa-asset-summary-germany/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-asset-summary-germany/](https://www.enginatics.com/reports/fa-asset-summary-germany/) |

## Executive Summary
The **FA Asset Summary (Germany)** report is a specialized asset schedule designed to meet German reporting requirements (Anlagenspiegel). It provides a matrix view of asset movements: Opening Balance, Additions, Retirements, Transfers, Revaluations, and Closing Balance.

## Business Challenge
*   **Local Compliance:** Meeting the specific format requirements of German accounting standards (HGB).
*   **Movement Analysis:** Understanding the "roll-forward" of asset balances from the beginning to the end of the fiscal year.
*   **Multi-Book Reporting:** Consolidating data across multiple books or ledgers for corporate reporting.

## The Solution
This Blitz Report extends the standard functionality by:
*   **Multi-Ledger Support:** Allowing execution across multiple ledgers/books in a single run.
*   **Pivot-Friendly:** Structuring data to easily create the standard asset roll-forward grid in Excel.
*   **Granular Filtering:** Options to filter by Account, Category, and Balancing Segment.

## Technical Architecture
The report uses the `XXEN_FA_FAS_XMLP` package, which is a custom wrapper around standard logic to enhance performance and flexibility. It aggregates data from `FA_BALANCES_REPORT_GT` (or similar temporary structures populated by the logic) to calculate the movement buckets.

## Parameters & Filtering
*   **Ledger/Book:** Defines the scope.
*   **Period Range:** Usually a full fiscal year (Opening to Closing period).
*   **Account/Category Segments:** For filtering specific asset classes.

## Performance & Optimization
*   **Temporary Tables:** This report often uses temporary tables to calculate balances. Ensure sufficient temporary tablespace is available.
*   **Wide Ranges:** Running for "All Categories" is standard for the full schedule but can be time-consuming.

## FAQ
*   **Q: Can this be used for non-German entities?**
    *   A: Yes, the "Asset Schedule" or "Roll-forward" concept is universal. The "Germany" label implies it meets specific column requirements common in that region.
*   **Q: Why don't my numbers roll forward?**
    *   A: Check for manual journal entries to asset accounts in GL that are not reflected in the FA subledger.


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
