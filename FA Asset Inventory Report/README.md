---
layout: default
title: 'FA Asset Inventory Report | Oracle EBS SQL Report'
description: 'Application: Assets Source: Asset Inventory Report (Enginatics) – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Asset, Inventory, Report, fa_books, fa_additions_b, fa_additions_tl'
permalink: /FA%20Asset%20Inventory%20Report/
---

# FA Asset Inventory Report – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-inventory-report/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Assets
Source: Asset Inventory Report (Enginatics)

## Report Parameters
Book, From Cost Center, To Cost Center, From Date Placed in Service, To Date Placed in Service

## Oracle EBS Tables Used
[fa_books](https://www.enginatics.com/library/?pg=1&find=fa_books), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b), [fa_additions_tl](https://www.enginatics.com/library/?pg=1&find=fa_additions_tl), [fa_deprn_detail](https://www.enginatics.com/library/?pg=1&find=fa_deprn_detail), [fa_adjustments](https://www.enginatics.com/library/?pg=1&find=fa_adjustments), [fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [fa_locations](https://www.enginatics.com/library/?pg=1&find=fa_locations), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FA Asset Inventory](/FA%20Asset%20Inventory/ "FA Asset Inventory Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fa-asset-inventory-report/) |
| Blitz Report™ XML Import | [FA_Asset_Inventory_Report.xml](https://www.enginatics.com/xml/fa-asset-inventory-report/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-asset-inventory-report/](https://www.enginatics.com/reports/fa-asset-inventory-report/) |

## Executive Summary
The **FA Asset Inventory Report** (Enginatics version) is an enhanced alternative to the standard Oracle inventory report. It is designed to provide a more user-friendly and detailed view of fixed assets, specifically tailored for efficient physical audits and reconciliation tasks.

## Business Challenge
*   **Data Usability:** Standard reports often lack specific columns or are hard to manipulate in Excel.
*   **Detailed Tracking:** Need for more granular details on asset assignments and locations.
*   **Efficiency:** Reducing the time spent formatting data for physical inventory counts.

## The Solution
This Enginatics-developed Blitz Report offers:
*   **Enhanced Columns:** Includes additional fields that may not be in the standard report, such as detailed location segments and employee details.
*   **Excel Optimization:** Formatted specifically for immediate use in spreadsheet analysis.
*   **Flexibility:** Broader filtering options to target specific asset groups.

## Technical Architecture
The SQL logic directly queries `FA_ADDITIONS_B`, `FA_BOOKS`, `FA_LOCATIONS`, and `PER_ALL_PEOPLE_F`. It joins distribution history to show the current assignment of each asset. It is optimized for performance by avoiding some of the overhead of the generic XML Publisher packages.

## Parameters & Filtering
*   **Book:** The asset book to query.
*   **Cost Center:** Filter by the expense account's cost center segment.
*   **Date Placed in Service:** Filter by the asset's start date.

## Performance & Optimization
*   **Direct SQL:** This report runs directly against the database tables, often resulting in faster execution than the standard XML wrapper.
*   **Column Selection:** In Blitz Report, you can hide unnecessary columns to make the output file smaller and more readable.

## FAQ
*   **Q: Why use this over the "FA Asset Inventory" (Standard) report?**
    *   A: This version is often faster and provides a flatter, more Excel-friendly structure without the need for complex XML parsing.
*   **Q: Does it show split assignments?**
    *   A: Yes, assets split across multiple cost centers or locations will appear as multiple rows (distributions).


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
