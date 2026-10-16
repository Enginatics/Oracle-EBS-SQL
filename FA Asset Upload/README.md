---
layout: default
last_modified_at: 2026-10-16
title: 'FA Asset Upload | Oracle EBS SQL Report'
description: 'Upload to create, update, and retire fixed assets using FA Public APIs. New assets are created via faadditionpub.doaddition. Existing assets are updated…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Upload, Asset, fa_lookups, fa_deprn_periods, fa_additions_vl'
permalink: /FA%20Asset%20Upload/
report_name: 'FA Asset Upload'
report_web_name: fa-asset-upload
---

# FA Asset Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload).

## Overview
Upload to create, update, and retire fixed assets using FA Public APIs.
New assets are created via fa_addition_pub.do_addition. Existing assets are updated via fa_asset_desc_pub.update_desc, fa_reclass_pub.do_reclass, and fa_adjustment_pub.do_adjustment.
Asset retirements are processed via fa_retirement_pub.do_retirement; after uploading retirements, run the Calculate Gains and Losses program to finalize them and post the gain/loss.
Use the Record Type column to select Addition or Retirement processing. Fully retired assets are excluded from the list unless Include Retired Assets is set to Yes.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Upload Mode, Book, Asset Number, Category, From Category, To Category, Asset Type, Net Book Value Greater Than, Net Book Value Less Than, Include Retired Assets

## Oracle EBS Tables Used
[fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_additions_vl](https://www.enginatics.com/library/?pg=1&find=fa_additions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_books](https://www.enginatics.com/library/?pg=1&find=fa_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_category_books](https://www.enginatics.com/library/?pg=1&find=fa_category_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_deprn_summary](https://www.enginatics.com/library/?pg=1&find=fa_deprn_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_asset_keywords_kfv](https://www.enginatics.com/library/?pg=1&find=fa_asset_keywords_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_add_warranties](https://www.enginatics.com/library/?pg=1&find=fa_add_warranties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_warranties](https://www.enginatics.com/library/?pg=1&find=fa_warranties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_leases](https://www.enginatics.com/library/?pg=1&find=fa_leases&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [fa_retirements](https://www.enginatics.com/library/?pg=1&find=fa_retirements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload)

## Related Reports
[FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Fixed Assets Book](/FA%20Fixed%20Assets%20Book/ "FA Fixed Assets Book Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report"), [FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [FA Asset Transfers](/FA%20Asset%20Transfers/ "FA Asset Transfers Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [FA Cost Adjustments](/FA%20Cost%20Adjustments/ "FA Cost Adjustments Oracle EBS SQL Report"), [FA Additions By Source](/FA%20Additions%20By%20Source/ "FA Additions By Source Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Asset%20Upload/FA%20Asset%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fa-asset-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload) |
| Blitz Report™ XML Import | [FA_Asset_Upload.xml](https://www.enginatics.com/xml/fa-asset-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload) |
| SQL Source | [FA Asset Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Asset%20Upload/FA%20Asset%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fa-asset-upload/](https://www.enginatics.com/reports/fa-asset-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload) |

## Case Study & Technical Analysis: FA Asset Upload

### Executive Summary
This upload maintains fixed assets in Oracle Fixed Assets. It downloads the assets of one book with their categories, locations, distribution, cost, depreciation reserve, depreciation method and life, and lets an asset accountant create new asset additions, update descriptions, categories and adjustments, and record asset retirements in a spreadsheet. The changes are applied through Oracle's public Fixed Assets APIs, so the rules of the Fixed Assets forms still apply. It is used by asset accountants and by finance teams that load acquisitions from procurement, reclassify assets after a reorganization or retire assets at the end of their life. Blitz Report™ provides the spreadsheet layout.

### Business Challenge
*   **Bulk asset creation:** Large acquisitions, such as a batch of equipment from one project, are slow to enter one asset at a time through the forms.
*   **Reclassification and transfers:** Moving assets between categories, locations or employees must be consistent across all assets of a book.
*   **Retirement and gain or loss:** Retirements must be recorded and then finalized, with the gain or loss posted, so the process needs a clear sequence.

### The Solution
*   Downloads the assets of one book with their description, category, asset key, location, expense account, assigned employee, depreciation method, life, salvage and limit settings, and the current year depreciation.
*   Shows the depreciation reserve, net book value and the year-to-date depreciation from the latest depreciation summary period of each asset.
*   Builds an addition row and a retirement row for each asset in one result, so both can be processed from the same layout.
*   Shows fully retired assets only when Include Retired Assets is set to Yes, and it excludes them from the list otherwise.

### Technical Architecture (High Level)
#### Primary Tables
*   `FA_ADDITIONS_VL` and `FA_ADDITIONS_B`: the asset master, with asset number, description, tag, serial number, parent asset and group asset.
*   `FA_BOOKS`: the asset's book record, with cost, original cost, salvage, depreciation method, life, prorate convention and limits.
*   `FA_BOOK_CONTROLS`: the book controls, including the current fiscal year and the ledger.
*   `FA_DEPRN_SUMMARY`: the depreciation reserve and year-to-date depreciation per period.
*   `FA_DISTRIBUTION_HISTORY`: the location, expense account and assigned employee of the asset.
*   `FA_CATEGORIES_B_KFV` and `FA_CATEGORY_BOOKS`: the category and its book assignment.
*   `FA_LOCATIONS_KFV` and `GL_CODE_COMBINATIONS_KFV`: the location and expense account segments.
*   `FA_ASSET_KEYWORDS_KFV`: the asset key.
*   `FA_ADD_WARRANTIES`, `FA_WARRANTIES` and `FA_LEASES`: the warranty and lease of the asset.
*   `FA_RETIREMENTS`: the retirement record, with date, cost retired, proceeds of sale, cost of removal and retirement type.
*   `FA_TRANSACTION_HEADERS`, `FA_DEPRN_PERIODS` and `FA_LOOKUPS`: the transaction dates, the periods and the lookup meanings.
*   `FA_ADDITIONS_B`: a second reference to the asset master, used for the parent asset and the group asset.
*   `GL_LEDGERS` and `PER_ALL_PEOPLE_F`: the ledger of the book and the employee assigned to the asset, with the employee taken as current on the run date.

#### Logical Relationships
1. `FA_ADDITIONS_VL` is joined to `FA_BOOKS` on asset identifier, and to `FA_BOOK_CONTROLS` and `GL_LEDGERS` on book.
2. The depreciation summary is restricted to the latest period counter of each asset and book.
3. The distribution history is restricted to the currently effective record, or to the record effective at retirement for a retired asset.
4. Category, location, expense account and asset key are joined on their identifiers.
5. The Addition branch and the Retirement branch are combined with UNION ALL, and the retirement branch adds the retirement columns.

### Parameters & Filtering
*   **Upload Mode:** selects create only, or create and update.
*   **Book:** selects the asset book to download.
*   **Asset Number**, **Category**, **From Category** and **To Category:** limit the assets to one asset or to a category or range of categories.
*   **Asset Type:** limits the assets to one asset type, using the asset type lookup.
*   **Net Book Value Greater Than** and **Net Book Value Less Than:** bound the net book value.
*   **Include Retired Assets:** when Yes, fully retired assets are included.

### Performance & Optimization
*   The depreciation summary is limited to the latest period of each asset through a correlated maximum, so only one summary row is read per asset and book.
*   The distribution history uses the date-ineffective test, or the retirement date for a retired asset, to select the distribution that applies to the row.
*   Lookups of asset type, property type, ownership and other codes are scalar subqueries on the lookup table, so each code is translated once per row.

### FAQ
**Q: How do I retire assets in bulk?**
A: Download the assets, set the Record Type to Retirement for the rows to retire and upload. Then run the Calculate Gains and Losses program to finalize the retirements and post the gain or loss.

**Q: Why are fully retired assets missing from my download?**
A: They are excluded unless Include Retired Assets is set to Yes.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
