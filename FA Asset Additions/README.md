---
layout: default
title: 'FA Asset Additions | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Asset Additions Report Application: Assets Source: Asset Additions Report (XML) Short Name: FAS420XML DB package…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Asset, Additions, fa_calendar_periods, fa_deprn_periods, fa_system_controls'
permalink: /FA%20Asset%20Additions/
---

# FA Asset Additions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-additions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Asset Additions Report
Application: Assets
Source: Asset Additions Report (XML)
Short Name: FAS420_XML
DB package: FA_FAS420_XMLP_PKG

## Report Parameters
Ledger, Book, From Period Entered, To Period Entered, From Period Effective, To Period Effective, Category From, Category To

## Oracle EBS Tables Used
[fa_calendar_periods](https://www.enginatics.com/library/?pg=1&find=fa_calendar_periods), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods), [fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [fa_asset_history](https://www.enginatics.com/library/?pg=1&find=fa_asset_history), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers), [fa_category_books](https://www.enginatics.com/library/?pg=1&find=fa_category_books), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [&lp_fa_adjustments](https://www.enginatics.com/library/?pg=1&find=&lp_fa_adjustments), [&lp_fa_books](https://www.enginatics.com/library/?pg=1&find=&lp_fa_books), [&lp_fa_deprn_summary](https://www.enginatics.com/library/?pg=1&find=&lp_fa_deprn_summary), [&lp_fa_deprn_detail](https://www.enginatics.com/library/?pg=1&find=&lp_fa_deprn_detail), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [&lp_fa_book_controls](https://www.enginatics.com/library/?pg=1&find=&lp_fa_book_controls), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [fa_book_controls_sec](https://www.enginatics.com/library/?pg=1&find=fa_book_controls_sec), [&lp_fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=&lp_fa_deprn_periods)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Asset Reclassification](/FA%20Asset%20Reclassification/ "FA Asset Reclassification Oracle EBS SQL Report"), [FA Asset Retirements](/FA%20Asset%20Retirements/ "FA Asset Retirements Oracle EBS SQL Report"), [FA Cost Adjustments](/FA%20Cost%20Adjustments/ "FA Cost Adjustments Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Asset Additions 30-Aug-2021 051352.xlsx](https://www.enginatics.com/example/fa-asset-additions/) |
| Blitz Report™ XML Import | [FA_Asset_Additions.xml](https://www.enginatics.com/xml/fa-asset-additions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-asset-additions/](https://www.enginatics.com/reports/fa-asset-additions/) |

## Case Study: Automating Fixed Asset Capitalization Reporting in Oracle EBS

### Executive Summary
The **FA Asset Additions** report is a critical financial control tool designed to validate the capitalization of new assets within Oracle Fixed Assets. By providing a detailed audit trail of asset additions—including source details from Payables and Projects—this report ensures that organizations maintain an accurate asset register, comply with depreciation policies, and support rigorous tax reporting requirements.

### Business Challenge
For asset-intensive organizations, the process of capitalizing assets ("Additions") is a high-risk area for financial reporting. Inaccurate data during this phase can lead to incorrect depreciation calculations for years to come. Common challenges include:
*   **Source Traceability:** Difficulty in tracing an asset back to its originating invoice or project cost, making audits time-consuming.
*   **Categorization Errors:** Incorrect assignment of asset categories or depreciation methods at the time of addition.
*   **Period-End Bottlenecks:** The need to manually verify hundreds of additions during the tight financial close window.
*   **Regulatory Compliance:** Ensuring that all capitalized costs meet the specific criteria for asset recognition under GAAP or IFRS.

### The Solution
The **FA Asset Additions** report provides a comprehensive view of all assets added within a specific period or range. It bridges the gap between the subsidiary ledgers (AP/PA) and the Fixed Assets module, offering immediate visibility into the "who, what, and when" of asset creation.

#### Key Features
*   **Source Line Detail:** Links asset additions back to specific invoice lines or project tasks, providing a complete audit trail.
*   **Depreciation Validation:** Displays the assigned depreciation method, life, and prorate conventions to ensure policy compliance.
*   **Multi-Book Support:** Capable of reporting on different depreciation books (Corporate, Tax, etc.) to verify statutory reporting requirements.
*   **Cost Breakdown:** Separates original cost, salvage value, and recoverable cost to validate the depreciable basis.

### Technical Architecture
The report is built upon the core Oracle Fixed Assets transaction tables, ensuring data integrity and alignment with the standard `FAS420` XML Publisher report but with enhanced accessibility.

#### Critical Tables
*   `FA_ADDITIONS_B`: Stores the descriptive information and asset category for each asset.
*   `FA_ASSET_HISTORY`: Tracks changes to asset assignments and category information over time.
*   `FA_TRANSACTION_HEADERS`: Records the specific transaction event (ADDITION) that created the asset.
*   `FA_BOOKS`: Contains the financial rules (Cost, Method, Life) associated with the asset in a specific book.
*   `FA_DISTRIBUTION_HISTORY`: Maps the asset to specific GL accounts and physical locations.

#### Key Parameters
*   **Book:** The specific depreciation book to analyze (e.g., CORP, TAX, FED).
*   **From/To Period:** The range of accounting periods to include in the report.
*   **Asset Category:** Filter by specific asset types (e.g., COMPUTER-HARDWARE, VEHICLES).
*   **Asset Number:** Capability to search for a specific asset for detailed auditing.

### Functional Analysis
#### Use Cases
1.  **Month-End Close:** Accountants run this report to verify that all assets cleared from the CIP (Construction in Process) accounts have been correctly capitalized.
2.  **Tax Reporting:** Tax teams use the report to identify new additions for the year to calculate tax depreciation schedules.
3.  **Internal Audit:** Auditors use the source line details to sample asset additions and verify the existence of supporting documentation (invoices).

#### FAQ
**Q: Does this report show assets added via Mass Additions?**
A: Yes, it includes assets added manually as well as those processed through the Mass Additions interface from Payables or Projects.

**Q: Can I see the GL accounts associated with the addition?**
A: Yes, the report joins to `FA_DISTRIBUTION_HISTORY` and `GL_CODE_COMBINATIONS` to show the expense and asset cost accounts.

**Q: How does this compare to the standard FAS420 report?**
A: This SQL-based approach allows for easier export to Excel for pivot table analysis, whereas the standard XML/PDF output is static and harder to manipulate for large datasets.


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
