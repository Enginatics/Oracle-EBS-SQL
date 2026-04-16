---
layout: default
title: 'FA Cost Adjustments | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Cost Adjustments Report Application: Assets Source: Cost Adjustments Report (XML) Short Name: FAS840XML DB…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Cost, Adjustments, fa_system_controls, gl_ledgers, fnd_currencies'
permalink: /FA%20Cost%20Adjustments/
---

# FA Cost Adjustments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-cost-adjustments/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Cost Adjustments Report
Application: Assets
Source: Cost Adjustments Report (XML)
Short Name: FAS840_XML
DB package: FA_FAS840_XMLP_PKG

## Report Parameters
Book, Set of Books Currency, From Period, To Period, Show Source Invoice Details

## Oracle EBS Tables Used
[fa_system_controls](https://www.enginatics.com/library/?pg=1&find=fa_system_controls), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [fa_asset_history](https://www.enginatics.com/library/?pg=1&find=fa_asset_history), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [fa_categories](https://www.enginatics.com/library/?pg=1&find=fa_categories), [fa_category_books](https://www.enginatics.com/library/?pg=1&find=fa_category_books), [&lp_fa_books](https://www.enginatics.com/library/?pg=1&find=&lp_fa_books), [fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups), [&lp_fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=&lp_fa_deprn_periods), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers), [fa_trx](https://www.enginatics.com/library/?pg=1&find=fa_trx), [fa_asset_invoices](https://www.enginatics.com/library/?pg=1&find=fa_asset_invoices), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [FA Asset Cost](/FA%20Asset%20Cost/ "FA Asset Cost Oracle EBS SQL Report"), [FA Asset Retirements](/FA%20Asset%20Retirements/ "FA Asset Retirements Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Cost Adjustments 30-Aug-2021 053010.xlsx](https://www.enginatics.com/example/fa-cost-adjustments/) |
| Blitz Report™ XML Import | [FA_Cost_Adjustments.xml](https://www.enginatics.com/xml/fa-cost-adjustments/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-cost-adjustments/](https://www.enginatics.com/reports/fa-cost-adjustments/) |

## Executive Summary
The **FA Cost Adjustments** report provides a detailed audit trail of all changes made to asset costs within a specified period. It is essential for verifying that cost adjustments—whether from invoice additions, manual adjustments, or revaluations—are correctly recorded and approved.

## Business Challenge
*   **Audit Trail:** Tracking who changed an asset's cost and why.
*   **Financial Accuracy:** Ensuring that cost adjustments are reflected in the depreciation base.
*   **Invoice Reconciliation:** Matching cost adjustments back to the source AP invoices.

## The Solution
This Blitz Report enhances the standard cost adjustment tracking by:
*   **Source Details:** Optionally showing the specific invoice lines that drove the cost change.
*   **Transaction Context:** Linking the adjustment to the specific transaction type (e.g., ADDITION, ADJUSTMENT).
*   **Supplier Visibility:** Displaying supplier information for invoice-related adjustments.

## Technical Architecture
Based on `FAS840_XML`, the report queries `FA_TRANSACTION_HEADERS` for cost-impacting transactions. It joins `FA_ASSET_INVOICES` and `AP_SUPPLIERS` to provide the upstream source document details when requested.

## Parameters & Filtering
*   **Book:** The asset book.
*   **Period Range:** The time window for the adjustments.
*   **Show Source Invoice Details:** A toggle to include granular invoice data.

## Performance & Optimization
*   **Invoice Details:** Enabling "Show Source Invoice Details" adds significant volume to the report; use only when detailed reconciliation is needed.
*   **Period Range:** Keep the range narrow (e.g., current period) for month-end validation.

## FAQ
*   **Q: Does this show mass additions?**
    *   A: Yes, if the mass addition resulted in a cost adjustment or new asset cost.
*   **Q: Why is the cost adjustment negative?**
    *   A: A negative adjustment typically indicates a credit memo or a manual reduction in asset value.


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
