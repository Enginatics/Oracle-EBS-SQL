---
layout: default
last_modified_at: 2026-10-16
title: 'FA Asset Book Details | Oracle EBS SQL Report'
description: 'FA asset books with asset depreciation summary and financial transaction values. Using parameters ''Show Calendar'', ''Show Alternative Ledgers'', ''Show…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Assets, Enginatics, Asset, Book, Details, fa_mc_book_controls, gl_ledgers, fnd_id_flex_structures_vl'
permalink: /FA%20Asset%20Book%20Details/
report_name: 'FA Asset Book Details'
report_web_name: fa-asset-book-details
module: 'Assets'
module_url: /modules/assets/
---

# FA Asset Book Details – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-book-details/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details).
**Oracle EBS module:** [Assets](/modules/assets/ "Oracle EBS Assets reports") · [all Assets reports](/modules/assets/)  

## Overview
FA asset books with asset depreciation summary and financial transaction values.
Using parameters 'Show Calendar', 'Show Alternative Ledgers', 'Show Accounting Rules', 'Show Natural Accounts' shows the setup details of book controls.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Book, As of Period, Show Calendar, Show Alternative Ledgers, Show Accounting Rules, Show Natural Accounts, Show Asset Details, Show Depreciation Summary, Show Assignments, Show Fin Transactions, Show Source Invoices, Exclude Retired Assets, Organization

## Oracle EBS Tables Used
[fa_mc_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_mc_book_controls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fnd_id_flex_structures_vl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_additions_tl](https://www.enginatics.com/library/?pg=1&find=fa_additions_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_asset_keywords_kfv](https://www.enginatics.com/library/?pg=1&find=fa_asset_keywords_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_books](https://www.enginatics.com/library/?pg=1&find=fa_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_leases](https://www.enginatics.com/library/?pg=1&find=fa_leases&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_category_books](https://www.enginatics.com/library/?pg=1&find=fa_category_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_deprn_summary](https://www.enginatics.com/library/?pg=1&find=fa_deprn_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_calendar_types](https://www.enginatics.com/library/?pg=1&find=fa_calendar_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_trx_references](https://www.enginatics.com/library/?pg=1&find=fa_trx_references&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_calendar_periods](https://www.enginatics.com/library/?pg=1&find=fa_calendar_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fa_invoice_details_v](https://www.enginatics.com/library/?pg=1&find=fa_invoice_details_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [fnd_id_flex_structures_tl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details)

## Related Reports
[FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Fixed Assets Book](/FA%20Fixed%20Assets%20Book/ "FA Fixed Assets Book Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [FA Additions By Source](/FA%20Additions%20By%20Source/ "FA Additions By Source Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [FA CIP Assets and Invoices](/FA%20CIP%20Assets%20and%20Invoices/ "FA CIP Assets and Invoices Oracle EBS SQL Report"), [FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Asset%20Book%20Details/FA%20Asset%20Book%20Details.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Asset Book Details 19-Jan-2018 003659.xlsx](https://www.enginatics.com/example/fa-asset-book-details/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details) |
| Blitz Report™ XML Import | [FA_Asset_Book_Details.xml](https://www.enginatics.com/xml/fa-asset-book-details/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details) |
| SQL Source | [FA Asset Book Details.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Asset%20Book%20Details/FA%20Asset%20Book%20Details.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fa-asset-book-details/](https://www.enginatics.com/reports/fa-asset-book-details/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details) |

## Case Study & Technical Analysis: FA Asset Book Details

### Executive Summary
The **FA Asset Book Details** report is a fundamental tool for Fixed Asset Accountants and System Administrators. It provides a deep dive into the configuration and status of Asset Books within Oracle Assets. From verifying depreciation rules to reconciling financial transaction values, this report ensures that the asset register is aligned with corporate accounting policies and the General Ledger.

### Business Challenge
Fixed Asset management involves complex calculations and strict regulatory compliance. Organizations often struggle with:
*   **Configuration Drift:** Unintended changes to depreciation methods or prorate conventions that can skew financial results.
*   **Reconciliation Issues:** Difficulty in matching the Asset Subledger balance to the General Ledger due to opaque book setups.
*   **Audit Complexity:** Proving to auditors that the system is calculating depreciation correctly according to the defined rules (e.g., Straight Line vs. Double Declining Balance).
*   **Multi-Book Management:** Managing Tax books alongside Corporate books requires constant validation to ensure they remain in sync where necessary.

### The Solution
This report solves these challenges by providing a transparent "Operational View" of the Asset Book controls and contents.
*   **Configuration Audit:** The "Show Accounting Rules" parameter exposes the exact depreciation method, prorate calendar, and retirement conventions assigned to the book.
*   **Financial Integrity:** By enabling "Show Fin Transactions" and "Show Depreciation Summary," users can trace the financial impact of assets within the book, facilitating period-end reconciliation.
*   **Multi-Ledger Support:** The report supports reporting on Alternative Ledgers (Reporting Currencies), ensuring global compliance.

### Technical Architecture (High Level)
The report queries the core Oracle Assets configuration and transaction tables.
*   **Primary Tables:**
    *   `FA_BOOK_CONTROLS`: The header table defining the book itself (Class, Associated Ledger, Current Open Period).
    *   `FA_BOOKS`: Contains the financial rules for each asset within the book (Cost, Depreciation Method, Life).
    *   `FA_DEPRN_SUMMARY`: Stores the calculated depreciation amounts per period.
    *   `FA_ADDITIONS_B`: The master table for asset descriptive details.
    *   `FA_SYSTEM_CONTROLS` & `FA_CALENDAR_TYPES`: Defines the enterprise-level asset system and calendar setups.

*   **Logical Relationships:**
    The report centers on the Book Control (`FA_BOOK_CONTROLS`) and expands to show the rules governing that book. It then optionally joins to the asset-level data (`FA_BOOKS`) and financial summary (`FA_DEPRN_SUMMARY`) to provide a complete picture of both the *rules* and the *results*.

### Parameters & Filtering
*   **Show Accounting Rules:** A key parameter for auditors. When 'Yes', it displays the Depreciation Method, Prorate Convention, and Calendar details.
*   **Show Depreciation Summary:** Toggles the display of accumulated depreciation and YTD depreciation figures.
*   **Show Alternative Ledgers:** Essential for multi-national implementations using Reporting Currencies (MRC).
*   **As of Period:** Allows "Time Travel" reporting to see the state of the book at a past period close.

### Performance & Optimization
*   **Selective Detail:** The report uses parameters to control the depth of the join. If "Show Asset Details" is 'No', the report runs extremely fast as it only queries the high-level Book Control tables.
*   **Indexed Access:** Joins to `FA_DEPRN_SUMMARY` and `FA_BOOKS` are driven by the indexed `BOOK_TYPE_CODE` and `ASSET_ID`, ensuring efficient retrieval even for large asset registers.

### FAQ
**Q: How can I verify if my Tax Book is set up to copy changes from the Corporate Book?**
A: Run the report for the Tax Book and check the "Mass Copy" flags in the output (often part of the detailed book controls).

**Q: Why do I see different costs for the same asset in different books?**
A: This is normal. Run the report for both the Corporate and Tax books. The `FA_BOOKS` table stores cost and depreciation rules separately for each book, allowing for different valuations (e.g., GAAP vs. Tax).

**Q: Can this report show me the GL accounts mapped to the book?**
A: Yes, if you enable "Show Natural Accounts" or look at the distribution details, you can see the account code combinations associated with the asset categories in this book.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-book-details)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
