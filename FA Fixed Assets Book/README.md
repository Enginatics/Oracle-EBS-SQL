---
layout: default
last_modified_at: 2026-10-26
title: 'FA Fixed Assets Book | Oracle EBS SQL Report'
description: 'Assets held in a depreciation book with their cost, depreciation and net book value as at the end of the selected period. Replaces the Oracle standard…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Assets, Enginatics, R12 only, Fixed, Book, fa_asset_keywords_kfv, fa_locations_kfv, fa_lookups_vl'
permalink: /FA%20Fixed%20Assets%20Book/
report_name: 'FA Fixed Assets Book'
report_web_name: fa-fixed-assets-book
module: 'Assets'
module_url: /modules/assets/
---

# FA Fixed Assets Book – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-fixed-assets-book/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book).
**Oracle EBS module:** [Assets](/modules/assets/ "Oracle EBS Assets reports") · [all Assets reports](/modules/assets/)  

## Overview
Assets held in a depreciation book with their cost, depreciation and net book value as at the end of the selected period.

Replaces the Oracle standard RXi: Fixed Assets Book report. The rows are extracted by the same routine its RX-only: Fixed Assets Book data program uses, so cost and depreciation figures are identical. The two seeded RXi attribute sets, Default and Book Details, are shipped as the templates of the same names; each puts the asset detail on the report sheet and the RXi group subtotals on a pivot sheet beside it.

One row per asset distribution, so an asset split over several cost centers or employees appears once per distribution. Units and Percent give the share of the asset in that distribution; Cost and the depreciation amounts are the distribution's share, not the asset total.

Cost, YTD Depreciation and LTD Depreciation are the balances of the last depreciation run on or before the selected period. Depreciation Amount is filled only where that run is the selected period itself, and is zero for an asset whose last run is earlier.

NBV at Period End is Cost less LTD Depreciation less impairment reserve, so it is lower than Cost less LTD Depreciation for an impaired asset. NBV at Beginning of Fiscal Year adds YTD Depreciation back.

Assets placed in service after the end of the selected period are excluded, as are assets fully retired before the start of the fiscal year that period falls in.

Drill Down into Group Assets adds the member assets of group assets, which are otherwise represented by their group asset alone.

The segment description columns are read in full from the flexfield value sets. The Oracle report prints the bare code for every value after the first one it looks up per value set, and cuts the descriptions it does print to the segment's display width.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Book, Period, Drill Down into Group Assets, Balancing Segment From, Balancing Segment To, Expense Account From, Expense Account To, Cost Center From, Cost Center To, Major Category From, Major Category To, Minor Category From, Minor Category To, Category Segment, Category Segment Value From, Category Segment Value To, Property Type, Asset Number From, Asset Number To

## Oracle EBS Tables Used
[fa_asset_keywords_kfv](https://www.enginatics.com/library/?pg=1&find=fa_asset_keywords_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_lookups_vl](https://www.enginatics.com/library/?pg=1&find=fa_lookups_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_reserve_ledger_gt](https://www.enginatics.com/library/?pg=1&find=fa_reserve_ledger_gt&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_asset_history](https://www.enginatics.com/library/?pg=1&find=fa_asset_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_fiscal_year](https://www.enginatics.com/library/?pg=1&find=fa_fiscal_year&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_category_books](https://www.enginatics.com/library/?pg=1&find=fa_category_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fnd_id_flex_segments](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_segments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fnd_segment_attribute_values](https://www.enginatics.com/library/?pg=1&find=fnd_segment_attribute_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_categories_vl](https://www.enginatics.com/library/?pg=1&find=fa_categories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_books](https://www.enginatics.com/library/?pg=1&find=fa_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_category_book_defaults](https://www.enginatics.com/library/?pg=1&find=fa_category_book_defaults&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book)

## Related Reports
[FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report"), [FA Asset Transfers](/FA%20Asset%20Transfers/ "FA Asset Transfers Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [FA Additions By Source](/FA%20Additions%20By%20Source/ "FA Additions By Source Oracle EBS SQL Report"), [FA Asset Retirements](/FA%20Asset%20Retirements/ "FA Asset Retirements Oracle EBS SQL Report"), [FA CIP Assets and Invoices](/FA%20CIP%20Assets%20and%20Invoices/ "FA CIP Assets and Invoices Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Fixed%20Assets%20Book/FA%20Fixed%20Assets%20Book.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fa-fixed-assets-book/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book) |
| Blitz Report™ XML Import | [FA_Fixed_Assets_Book.xml](https://www.enginatics.com/xml/fa-fixed-assets-book/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book) |
| SQL Source | [FA Fixed Assets Book.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Fixed%20Assets%20Book/FA%20Fixed%20Assets%20Book.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fa-fixed-assets-book/](https://www.enginatics.com/reports/fa-fixed-assets-book/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book) |

## Case Study & Technical Analysis: FA Fixed Assets Book

### Executive Summary
The FA Fixed Assets Book report lists the assets held in one depreciation book, with their cost, depreciation and net book value as at the end of the selected period. Each row is one asset distribution, showing the balancing segment, expense account, cost center, asset category, employee and location. Fixed asset accountants and controllers use it for period-end reconciliation of the asset register to the general ledger, and for the depreciation review that precedes a close. The report is an Enginatics replacement for the standard Oracle RXi: Fixed Assets Book report, and it uses the same extraction routine as the RX-only data program, so cost and depreciation figures are identical. It runs in Excel via Blitz Report.

### Business Challenge
*   **Period-end reconciliation:** Asset cost and accumulated depreciation must agree with the balances used for the period close, and the book must be reviewed before the close is finalized.
*   **Split assets:** An asset spread across several cost centers or employees must be reported by distribution, with its share of units and percent clearly shown.
*   **Impaired assets:** Net book value must reflect impairment reserves, which the standard view may not separate from depreciation.

### The Solution
*   **Distribution-level detail:** Units and percent show each distribution's share, and the cost and depreciation amounts are the distribution's share rather than the asset total.
*   **Period balances:** Cost, year-to-date and life-to-date depreciation are taken from the last depreciation run on or before the selected period.
*   **Full segment descriptions:** Balancing segment, expense account, cost center and category segments are returned with their descriptions read from the flexfield value sets.

### Technical Architecture (High Level)
#### Primary Tables
*   `FA_RESERVE_LEDGER_GT`: the global temporary table of depreciation reserve balances for the selected period, which drives the extraction.
*   `FA_DISTRIBUTION_HISTORY`: asset distributions by cost center, location and assigned employee, with effective dates.
*   `FA_ADDITIONS`: the asset master, including asset number, description, tag, serial number and asset type.
*   `FA_ASSET_HISTORY`: the category assignment and units of each asset, with effective dates.
*   `FA_BOOKS`: the book assignment, salvage value and group asset link.
*   `FA_BOOK_CONTROLS`, `FA_DEPRN_PERIODS`, `FA_FISCAL_YEAR`: the book, period and fiscal year definitions.
*   `FA_CATEGORY_BOOKS`, `FA_CATEGORY_BOOK_DEFAULTS`, `FA_CATEGORIES_VL`, `FA_CATEGORIES_B_KFV`: category and book default information.
*   `GL_LEDGERS`, `GL_CODE_COMBINATIONS`: the ledger and the account combinations of the distributions.
*   `FND_ID_FLEX_SEGMENTS`, `FND_SEGMENT_ATTRIBUTE_VALUES`: the segment roles used to identify the balancing, account and cost center columns.
*   `FA_LOCATIONS_KFV`, `FA_ASSET_KEYWORDS_KFV`, `PER_ALL_PEOPLE_F`: location, asset key and employee details.

#### Logical Relationships
1. `FA_BOOK_CONTROLS` is joined to `GL_LEDGERS` on the set of books, and `FA_DEPRN_PERIODS` supplies the period close date.
2. `FA_RESERVE_LEDGER_GT` is joined to `FA_ADDITIONS` on asset, to `FA_DISTRIBUTION_HISTORY` on asset, distribution and code combination, and to `FA_ASSET_HISTORY` on asset.
3. `FA_CATEGORY_BOOKS` and `FA_BOOKS` are joined on the book and asset, with date-effective conditions on each history row.
4. The fiscal year joins `FA_BOOK_CONTROLS` and tests the placed-in-service date against the fiscal year start and end.
5. Segment descriptions are resolved by inline views over `GL_CODE_COMBINATIONS` and the category flexfield, using the segment role columns.

### Parameters & Filtering
*   **Book and Period:** The book is required and the period sets the depreciation period close used for the balances.
*   **Drill Down into Group Assets:** When set, the member assets of group assets are included; otherwise a group asset is represented by its group alone.
*   **Balancing Segment, Expense Account and Cost Center From/To:** Restrict the output to the account ranges entered.
*   **Major Category, Minor Category and Category Segment Value From/To:** Restrict the output to the category ranges, with Category Segment naming the flexfield segment to filter on.
*   **Property Type, Asset Number From/To:** Restrict the output by property type and asset number range.

### Performance & Optimization
*   The segment description and category subqueries are wrapped in `no_merge` inline views, which prevents them from being merged into the main extraction.
*   The reserve ledger is read from a global temporary table filled for the selected period, so the depreciation balances are not recalculated.
*   Date-effective conditions on distribution, asset and book history keep each asset to the row valid at the period.

### FAQ
**Q: Why does an asset appear more than once in the FA Fixed Assets Book report?**
A: The report returns one row per asset distribution, so an asset split across several cost centers or employees appears once for each distribution, with its share of units and percent.

**Q: Why is depreciation amount zero for some assets?**
A: The depreciation amount is filled only where the last depreciation run is the selected period itself, so an asset whose last run is earlier shows zero.

**Q: How is net book value at period end calculated?**
A: It is cost less life-to-date depreciation less the impairment reserve, so an impaired asset has a lower value than cost less depreciation alone.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-fixed-assets-book)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
