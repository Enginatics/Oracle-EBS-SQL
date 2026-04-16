---
layout: default
title: 'FA Depreciation Projection | Oracle EBS SQL Report'
description: 'Based on Oracle''s ''Depreciation Projection Report'' FASPRJ Uses custom DB package call XXENFAFASXMLP to launch Oracle standard Depreciation Projection…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Depreciation, Projection, gl_ledgers, fa_book_controls, fa_proj_interim_v'
permalink: /FA%20Depreciation%20Projection/
---

# FA Depreciation Projection – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-depreciation-projection/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Based on Oracle's 'Depreciation Projection Report' FASPRJ

Uses custom DB package call XXEN_FA_FAS_XMLP to launch Oracle standard Depreciation Projection concurrent FAPROJ. The data generation is explained in note:
How Does FA Depreciation Projections Handle Table FA_PROJ_INTERIM_XXX or FA_PROJ_INTERIM_REP ? (KB730395)
<a href="https://support.oracle.com/support/?kmContentId=1607626" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=1607626</a>

## Report Parameters
Ledger, Calendar, Number of Periods, Starting Period, Currency, Book1, Book2, Book3, Book4, Show Asset Number, Show Cost Center, Run Depreciation Projection, Previous Request Id

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls), [fa_proj_interim_v](https://www.enginatics.com/library/?pg=1&find=fa_proj_interim_v), [fa_additions_vl](https://www.enginatics.com/library/?pg=1&find=fa_additions_vl), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv), [fa_asset_keywords_kfv](https://www.enginatics.com/library/?pg=1&find=fa_asset_keywords_kfv), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [FA CIP Assets and Invoices](/FA%20CIP%20Assets%20and%20Invoices/ "FA CIP Assets and Invoices Oracle EBS SQL Report"), [FA Asset Book Details 11i](/FA%20Asset%20Book%20Details%2011i/ "FA Asset Book Details 11i Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Depreciation Projection 06-Nov-2024 005550.xlsx](https://www.enginatics.com/example/fa-depreciation-projection/) |
| Blitz Report™ XML Import | [FA_Depreciation_Projection.xml](https://www.enginatics.com/xml/fa-depreciation-projection/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-depreciation-projection/](https://www.enginatics.com/reports/fa-depreciation-projection/) |

## Executive Summary
The **FA Depreciation Projection** report forecasts future depreciation expenses for a specified number of periods. It is a strategic tool for budgeting and financial planning, allowing organizations to anticipate future capital consumption costs.

## Business Challenge
*   **Budgeting:** Accurately estimating future depreciation expense for the annual budget.
*   **Scenario Planning:** Understanding the impact of new asset acquisitions on future P&L.
*   **Cash Flow Management:** While depreciation is non-cash, it impacts tax liabilities and net income projections.

## The Solution
This Blitz Report leverages Oracle's standard projection logic but presents it in a usable format:
*   **Multi-Book Support:** Can project for up to 4 books simultaneously for comparative analysis (e.g., Corporate vs. Tax).
*   **Flexible Horizon:** Allows projection for any number of future periods.
*   **Granularity:** Can show projections at the asset level or summarized by cost center.

## Technical Architecture
The report uses a wrapper (`XXEN_FA_FAS_XMLP`) to launch the standard Oracle concurrent program `FAPROJ`. This program populates temporary tables (`FA_PROJ_INTERIM_V`) which the Blitz Report then queries to present the results.

## Parameters & Filtering
*   **Ledger/Calendar:** Defines the accounting context.
*   **Number of Periods:** How far into the future to project.
*   **Run Depreciation Projection:** Set to 'Yes' to trigger the calculation engine; 'No' to view previously generated results.

## Performance & Optimization
*   **Calculation Time:** The projection calculation can be resource-intensive. Run it during off-peak hours for large asset books.
*   **Previous Request ID:** If you have already run the projection, you can simply query the results by passing the Request ID, avoiding re-calculation.

## FAQ
*   **Q: Does this include CIP assets?**
    *   A: Generally, no. It projects depreciation for assets currently in service.
*   **Q: Why do I need to run the projection first?**
    *   A: Depreciation is a complex calculation based on methods and lives; the system must simulate the depreciation run to generate the data.


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
