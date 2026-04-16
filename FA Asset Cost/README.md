---
layout: default
title: 'FA Asset Cost | Oracle EBS SQL Report'
description: 'Asset Costs Summary/Detail Report Equivalent to Oracle Standard Reports: Cost Summary Report Cost Detail Report DB package: XXENFAFASXMLP'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Asset, Cost, msc_form_query, fa_system_controls, gl_ledgers'
permalink: /FA%20Asset%20Cost/
---

# FA Asset Cost – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-cost/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Asset Costs Summary/Detail Report

Equivalent to Oracle Standard Reports:
Cost Summary Report
Cost Detail Report

DB package: XXEN_FA_FAS_XMLP

## Report Parameters
Set of Books, Book, From Period, To Period, Show Depreciation Reserve

## Oracle EBS Tables Used
[msc_form_query](https://www.enginatics.com/library/?pg=1&find=msc_form_query), [fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [fa_balances_report_q](https://www.enginatics.com/library/?pg=1&find=fa_balances_report_q), [fa_asset_history](https://www.enginatics.com/library/?pg=1&find=fa_asset_history), [fa_category_books](https://www.enginatics.com/library/?pg=1&find=fa_category_books), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[MSC Horizontal Plan](/MSC%20Horizontal%20Plan/ "MSC Horizontal Plan Oracle EBS SQL Report"), [FA Depreciation Reserve](/FA%20Depreciation%20Reserve/ "FA Depreciation Reserve Oracle EBS SQL Report"), [CAC Shipping Network (Inter-Org) Accounts Setup](/CAC%20Shipping%20Network%20%28Inter-Org%29%20Accounts%20Setup/ "CAC Shipping Network (Inter-Org) Accounts Setup Oracle EBS SQL Report"), [CAC Shipping Networks Missing Interco OU Relationships](/CAC%20Shipping%20Networks%20Missing%20Interco%20OU%20Relationships/ "CAC Shipping Networks Missing Interco OU Relationships Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Asset Cost - Asset Cost Detail 20-Jul-2023 032253.xlsx](https://www.enginatics.com/example/fa-asset-cost/) |
| Blitz Report™ XML Import | [FA_Asset_Cost.xml](https://www.enginatics.com/xml/fa-asset-cost/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-asset-cost/](https://www.enginatics.com/reports/fa-asset-cost/) |

## Case Study & Technical Analysis: FA Asset Cost Report

### Executive Summary
The **FA Asset Cost** report is the definitive tool for reconciling Fixed Asset subledger balances. It provides a detailed "Roll Forward" analysis of asset costs, tracking movements from the beginning balance through additions, adjustments, retirements, revaluations, and transfers to the ending balance. This report is indispensable for Period Close activities and external audits, ensuring that the Fixed Assets register aligns perfectly with the General Ledger.

### Business Challenge
Reconciling Fixed Assets is often a manual and error-prone process:
*   **Static Reporting:** Standard Oracle "Cost Summary" and "Cost Detail" reports are PDF-based or text-based, making it difficult to perform variance analysis in Excel.
*   **Data Integrity:** Identifying specific assets that cause out-of-balance conditions between the subledger and GL requires tedious line-by-line comparison.
*   **Fragmented View:** Users often have to run separate reports for Cost and Depreciation Reserve, making it hard to see the net book value impact in one place.

### The Solution
This report modernizes the standard asset reconciliation process by extracting the core data into a flat, pivot-ready format.
*   **Automated Roll-Forward:** Clearly displays the formula: `Beginning Balance + Additions + Adjustments - Retirements +/- Transfers = Ending Balance`.
*   **Exception Handling:** Automatically calculates and highlights "Out of Balance" amounts, allowing accountants to instantly focus on problem assets.
*   **Unified Detail:** Combines the high-level summary with asset-level details (Asset Number, Description, Cost Center), eliminating the need to cross-reference multiple reports.

### Technical Architecture (High Level)
The report leverages Oracle's standard reconciliation logic to ensure 100% accuracy while enhancing the data presentation.

#### Primary Tables
*   `FA_BALANCES_REPORT_GT`: A Global Temporary Table that acts as the primary data source. It is populated by the standard Oracle logic (similar to the standard Cost Summary Report) before the query runs.
*   `FA_ADDITIONS`: Provides master data like Asset Number and Description.
*   `FA_ASSET_HISTORY`: Used to track historical changes to asset distributions (Cost Centers).
*   `GL_CODE_COMBINATIONS`: Decodes the accounting flexfields for Balancing Segments and Asset Accounts.

#### Logical Relationships
*   **Standard Logic Wrapper:** The report calls a PL/SQL package (`XXEN_FA_FAS_XMLP` or standard `FA_FASCOSTS_XMLP_PKG`) to populate the temporary table. This ensures that the numbers reported match the standard Oracle reports exactly.
*   **Pivot Logic:** The SQL uses `SUM(DECODE(source_type_code, ...))` to transform the transactional rows in the temporary table (which stores movements as separate rows) into a single row per asset with columns for each movement type (Beginning, Addition, Retirement, etc.).
*   **Dynamic Flexfields:** It uses `fnd_flex_xml_publisher_apis.process_kff_combination_1` to dynamically retrieve segment values (like Cost Center) based on the client's specific Chart of Accounts setup.

### Parameters & Filtering
*   **Book:** Selects the Depreciation Book (Corporate, Tax, etc.).
*   **From Period / To Period:** Defines the reconciliation range.
*   **Show Depreciation Reserve:** A powerful option that, when enabled, adds columns for Depreciation Reserve movements, effectively turning the report into a full "Net Book Value" roll forward.

### Performance & Optimization
*   **Leveraging Standard Code:** By using the standard Oracle temporary table population, the report guarantees consistency with official records.
*   **Aggregation:** The query aggregates data at the Asset and Cost Center level, reducing the volume of data transferred to Excel while maintaining sufficient detail for reconciliation.

### FAQ
**Q: Why does this report match the standard Oracle Cost Summary Report?**
A: It uses the exact same underlying PL/SQL logic to calculate the balances. The difference is only in how the data is presented (Excel vs. PDF).

**Q: What does the "Out of Balance Amount" column mean?**
A: This column checks the mathematical integrity of the asset's history. If `Begin + Activity != End`, it shows the difference. This usually indicates a data corruption issue or a bug in a previous transaction that needs IT investigation.

**Q: Can I use this for Tax Books?**
A: Yes, simply select the desired Tax Book in the "Book" parameter.


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
