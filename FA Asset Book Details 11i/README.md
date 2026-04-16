---
layout: default
title: 'FA Asset Book Details 11i | Oracle EBS SQL Report'
description: 'FA asset books with asset depreciation summary and financial transaction values. Using parameters ''Show Calendar'', ''Show Alternative Ledgers'', ''Show…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Asset, Book, Details, 11i, fa_additions_tl, fa_asset_keywords_kfv, fa_additions_b'
permalink: /FA%20Asset%20Book%20Details%2011i/
---

# FA Asset Book Details 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-book-details-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
FA asset books with asset depreciation summary and financial transaction values.
Using parameters 'Show Calendar', 'Show Alternative Ledgers', 'Show Accounting Rules', 'Show Natural Accounts' shows the setup details of book controls.

## Report Parameters
Ledger, Asset Book, Show Calendar, Show Accounting Rules, Show Natural Accounts, Show Asset Details, Show Depreciation Summary, Show Fin Transactions, Organization

## Oracle EBS Tables Used
[fa_additions_tl](https://www.enginatics.com/library/?pg=1&find=fa_additions_tl), [fa_asset_keywords_kfv](https://www.enginatics.com/library/?pg=1&find=fa_asset_keywords_kfv), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors), [fa_books](https://www.enginatics.com/library/?pg=1&find=fa_books), [fa_leases](https://www.enginatics.com/library/?pg=1&find=fa_leases), [fa_deprn_summary](https://www.enginatics.com/library/?pg=1&find=fa_deprn_summary), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods), [fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers), [fa_trx_references](https://www.enginatics.com/library/?pg=1&find=fa_trx_references), [fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls), [fa_calendar_periods](https://www.enginatics.com/library/?pg=1&find=fa_calendar_periods), [fnd_id_flex_structures_tl](https://www.enginatics.com/library/?pg=1&find=fnd_id_flex_structures_tl), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [c_additions](https://www.enginatics.com/library/?pg=1&find=c_additions), [c_dprn](https://www.enginatics.com/library/?pg=1&find=c_dprn), [c_fin_trx](https://www.enginatics.com/library/?pg=1&find=c_fin_trx), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fa-asset-book-details-11i/) |
| Blitz Report™ XML Import | [FA_Asset_Book_Details_11i.xml](https://www.enginatics.com/xml/fa-asset-book-details-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-asset-book-details-11i/](https://www.enginatics.com/reports/fa-asset-book-details-11i/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
