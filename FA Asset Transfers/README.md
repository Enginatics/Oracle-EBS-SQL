---
layout: default
last_modified_at: 2026-10-16
title: 'FA Asset Transfers | Oracle EBS SQL Report'
description: 'Asset transfers between distributions (employee, expense account and location), one row per transfer and distribution side. A transfer closes the From…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Assets, Enginatics, Asset, Transfers, fa_lookups, fa_book_controls_sec, gl_sets_of_books'
permalink: /FA%20Asset%20Transfers/
report_name: 'FA Asset Transfers'
report_web_name: fa-asset-transfers
module: 'Assets'
module_url: /modules/assets/
---

# FA Asset Transfers – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-transfers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers).
**Oracle EBS module:** [Assets](/modules/assets/ "Oracle EBS Assets reports") · [all Assets reports](/modules/assets/)  

## Overview
Asset transfers between distributions (employee, expense account and location), one row per transfer and distribution side.

A transfer closes the From distributions and creates the To distributions. Units, cost and reserve are signed, negative on the From side and positive on the To side, so a transfer nets to zero and a sum by cost center, account or location shows what moved in and out.

Cost, reserve, depreciation expense and revaluation reserve are the amounts the transfer moved between the distributions in the selected book, taken from its accounting adjustments. A back-dated transfer also moves the depreciation expense of the periods it reaches back to.

A partial unit transfer closes the From distribution and recreates it with the remaining units, so the remainder is listed on the To side as well and nets against the closed distribution.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Book, Period From, Period To, Transfer Date From, Transfer Date To, Asset Number, Category

## Oracle EBS Tables Used
[fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers), [fa_book_controls_sec](https://www.enginatics.com/library/?pg=1&find=fa_book_controls_sec&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers), [fa_adjustments](https://www.enginatics.com/library/?pg=1&find=fa_adjustments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers)

## Related Reports
[FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Fixed Assets Book](/FA%20Fixed%20Assets%20Book/ "FA Fixed Assets Book Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Asset Inventory 11i](/FA%20Asset%20Inventory%2011i/ "FA Asset Inventory 11i Oracle EBS SQL Report"), [FA Asset Reclassification](/FA%20Asset%20Reclassification/ "FA Asset Reclassification Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Asset%20Transfers/FA%20Asset%20Transfers.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Asset Transfers 15-Oct-2026 022650.xlsx](https://www.enginatics.com/example/fa-asset-transfers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers) |
| Blitz Report™ XML Import | [FA_Asset_Transfers.xml](https://www.enginatics.com/xml/fa-asset-transfers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers) |
| SQL Source | [FA Asset Transfers.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Asset%20Transfers/FA%20Asset%20Transfers.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fa-asset-transfers/](https://www.enginatics.com/reports/fa-asset-transfers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers) |

## Case Study & Technical Analysis: FA Asset Transfers

### Executive Summary
The FA Asset Transfers report lists the transfers of Oracle Assets fixed assets between distributions, where a distribution is the combination of employee, expense account and location that holds an asset. Each transfer closes the From distributions and creates the To distributions, and the report shows one row per transfer and distribution side. Fixed asset accountants use it to explain how cost, reserve and depreciation moved between cost centers, accounts and locations in a period, and to reconcile the transfers with the General Ledger. It follows the data of the asset transfer records and runs in Excel through Blitz Report.

### Business Challenge
*   **Cost center reporting:** Management reports by cost center or location must show the cost moved in and out during the period, which the asset register alone does not show.
*   **Net zero control:** A transfer should net to zero, and the team needs to verify this for each transfer before close.
*   **Back-dated transfers:** A transfer dated in an earlier period also moves depreciation expense for the periods it reaches back to, which affects prior-period reporting.
*   **Partial unit transfers:** A partial transfer closes the From distribution and recreates it with the remaining units, and the accountant must recognize the remainder to avoid double counting.

### The Solution
*   Lists each transfer with its ledger, book, currency, period, asset number, description, tag and serial number, asset type and category.
*   Shows the side of each distribution, FROM or TO, with units signed negative on the From side and positive on the To side.
*   Shows the cost, reserve, net book value, depreciation expense and revaluation reserve that the transfer moved in the selected book, taken from its accounting adjustments.
*   Shows the expense account, the cost center value from the account's flexfield, the location, the employee and the user who entered the transfer.

### Technical Architecture (High Level)
#### Primary Tables
*   `FA_TRANSACTION_HEADERS`: the transfer transaction, with its date, transaction name and the book it applies to.
*   `FA_DISTRIBUTION_HISTORY`: the From and To distributions of each transfer, with units, employee, code combination and location.
*   `FA_ADDITIONS`, `FA_CATEGORIES_B_KFV`: the asset master and its category.
*   `FA_ADJUSTMENTS`: the accounting adjustments that the transfer created, by adjustment type.
*   `FA_BOOK_CONTROLS_SEC`, `GL_SETS_OF_BOOKS` and `FA_DEPRN_PERIODS`: the book, its ledger and the period of the transfer.
*   `PER_ALL_PEOPLE_F`, `GL_CODE_COMBINATIONS_KFV` and `FA_LOCATIONS_KFV`: the employee, the expense account and the location.
*   `FA_LOOKUPS`: the asset type and side labels.

#### Logical Relationships
1.  The transfer header is joined to the book controls on the distribution source book, and to the deprecation period whose open and close dates contain the transfer date.
2.  `FA_DISTRIBUTION_HISTORY` is read twice in a UNION ALL, once on the out transaction for the FROM side and once on the in transaction for the TO side.
3.  The transfer is joined to `FA_ADJUSTMENTS` on transaction header, distribution and book, where the source type is TRANSFER. Costs and reserves are summed by adjustment type with their debit or credit sign.
4.  The employee is an outer join to `PER_ALL_PEOPLE_F` valid on the entry date, and the account and location are joined on their code combination and location ids.

### Parameters & Filtering
*   **Ledger** and **Book:** select the ledger and the asset book whose transfers are listed.
*   **Period From** and **Period To:** bound the deprecation periods of the transfers.
*   **Transfer Date From** and **Transfer Date To:** bound the transfer dates.
*   **Asset Number** and **Category:** limit the list to one asset or one category.

### Performance & Optimization
*   The period join is a range match on the transfer date against the period open and close dates, so each transfer reads one period row.
*   The adjustment amounts are aggregated once in an inline view grouped by transaction, distribution and book, and then joined to the transfers.
*   The employee lookup is limited to the effective dates that contain the entry date, which keeps the join to a single row per person.
*   Narrowing the Book and the period range before the run limits the distribution history rows that the UNION ALL has to read.

### FAQ
**Q: How do I check that an asset transfer nets to zero?**
A: Sum the Units, Cost and Reserve columns for the transfer number. The From side is negative and the To side is positive, so the total is zero for a complete transfer.

**Q: Why does the To side show units for a partial transfer?**
A: A partial unit transfer closes the From distribution and recreates it with the remaining units. The remainder appears on the To side and nets against the closed distribution.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-transfers)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
