---
layout: default
title: 'FA Asset Register | Oracle EBS SQL Report'
description: 'Application: Assets Source: Asset Register Report (XML) Short Name: FAS600XML DB package: FAFAS600XMLPPKG'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Asset, Register, fa_asset_history, fa_books, fa_categories'
permalink: /FA%20Asset%20Register/
---

# FA Asset Register – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-register/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Assets
Source: Asset Register Report (XML)
Short Name: FAS600_XML
DB package: FA_FAS600_XMLP_PKG

## Report Parameters
Book, From Asset Number, To Asset Number, Show Deprn Book Details, Show Distribution Details, Show Invoice Details

## Oracle EBS Tables Used
[fa_asset_history](https://www.enginatics.com/library/?pg=1&find=fa_asset_history), [fa_books](https://www.enginatics.com/library/?pg=1&find=fa_books), [fa_categories](https://www.enginatics.com/library/?pg=1&find=fa_categories), [fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups), [fa_additions_tl](https://www.enginatics.com/library/?pg=1&find=fa_additions_tl), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b), [fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods), [fa_ceiling_types](https://www.enginatics.com/library/?pg=1&find=fa_ceiling_types), [fa_deprn_summary](https://www.enginatics.com/library/?pg=1&find=fa_deprn_summary), [fa_methods](https://www.enginatics.com/library/?pg=1&find=fa_methods), [fa_itc_rates](https://www.enginatics.com/library/?pg=1&find=fa_itc_rates), [fa_convention_types](https://www.enginatics.com/library/?pg=1&find=fa_convention_types), [fa_calendar_periods](https://www.enginatics.com/library/?pg=1&find=fa_calendar_periods), [fa_calendar_types](https://www.enginatics.com/library/?pg=1&find=fa_calendar_types), [fa_locations](https://www.enginatics.com/library/?pg=1&find=fa_locations), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [fa_employees](https://www.enginatics.com/library/?pg=1&find=fa_employees), [fa_asset_invoices](https://www.enginatics.com/library/?pg=1&find=fa_asset_invoices), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [q_assets](https://www.enginatics.com/library/?pg=1&find=q_assets), [q_books](https://www.enginatics.com/library/?pg=1&find=q_books), [d_distributions](https://www.enginatics.com/library/?pg=1&find=d_distributions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Asset Register 06-Sep-2023 081714.xlsx](https://www.enginatics.com/example/fa-asset-register/) |
| Blitz Report™ XML Import | [FA_Asset_Register.xml](https://www.enginatics.com/xml/fa-asset-register/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-asset-register/](https://www.enginatics.com/reports/fa-asset-register/) |

## Executive Summary
The **FA Asset Register** is a fundamental report for fixed asset management, providing a comprehensive listing of all assets in a book. It serves as the primary source of truth for asset details, including cost, depreciation, location, and invoice information.

## Business Challenge
*   **Asset Visibility:** Difficulty in getting a complete picture of an asset's financial and physical attributes in one place.
*   **Reconciliation:** Needing a detailed subledger report to reconcile with General Ledger balances.
*   **Data Integrity:** Verifying that all capitalized assets have the correct depreciation method and life assigned.

## The Solution
This Blitz Report enhances the standard Asset Register by:
*   **Comprehensive Data:** Combining asset header, book, distribution, and invoice data into a single view.
*   **Flexible Detail Levels:** Allowing users to toggle details for depreciation, distributions, and invoices.
*   **Excel Analysis:** Enabling pivot tables to summarize cost by category, location, or cost center.

## Technical Architecture
The report mimics the `FAS600_XML` standard report. It joins `FA_ADDITIONS` (header), `FA_BOOKS` (financials), `FA_DISTRIBUTION_HISTORY` (assignments), and `FA_ASSET_INVOICES` (source). It handles the complexity of showing current vs. historical data based on the selected period.

## Parameters & Filtering
*   **Book:** The depreciation book (Required).
*   **Asset Number Range:** To run for specific assets.
*   **Show Details:** Flags to include/exclude Depreciation, Distribution, and Invoice details.

## Performance & Optimization
*   **Detail Flags:** Turn off "Show Invoice Details" or "Show Distribution Details" if you only need high-level financial data to speed up execution.
*   **Asset Range:** Use for targeted analysis of specific assets rather than running the full book.

## FAQ
*   **Q: Why is the report output so wide?**
    *   A: It includes detailed sections for distributions and invoices, which adds many columns. You can hide unused columns in Blitz Report.
*   **Q: Does this show fully retired assets?**
    *   A: It typically shows assets active during the requested period or fiscal year.


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
