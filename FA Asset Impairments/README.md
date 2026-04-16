---
layout: default
title: 'FA Asset Impairments | Oracle EBS SQL Report'
description: 'Source: Asset Impairment Report Short Name: FAXRASIM DB package: – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Asset, Impairments, fa_lookups_tl, gl_code_combinations_kfv, fa_impairments'
permalink: /FA%20Asset%20Impairments/
---

# FA Asset Impairments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-impairments/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Source: Asset Impairment Report
Short Name: FAXRASIM
DB package:

## Report Parameters
Book, Set of Books Currency, Start Period, End Period, Impairment, Cash Generating Unit

## Oracle EBS Tables Used
[fa_lookups_tl](https://www.enginatics.com/library/?pg=1&find=fa_lookups_tl), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [fa_impairments](https://www.enginatics.com/library/?pg=1&find=fa_impairments), [fa_cash_gen_units](https://www.enginatics.com/library/?pg=1&find=fa_cash_gen_units), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods), [fa_additions_vl](https://www.enginatics.com/library/?pg=1&find=fa_additions_vl), [fa_mc_impairments](https://www.enginatics.com/library/?pg=1&find=fa_mc_impairments), [fa_itf_impairments](https://www.enginatics.com/library/?pg=1&find=fa_itf_impairments), [fa_mc_itf_impairments](https://www.enginatics.com/library/?pg=1&find=fa_mc_itf_impairments), [fa_impairment_q](https://www.enginatics.com/library/?pg=1&find=fa_impairment_q), [fa_itf_impairment_q](https://www.enginatics.com/library/?pg=1&find=fa_itf_impairment_q), [fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fa-asset-impairments/) |
| Blitz Report™ XML Import | [FA_Asset_Impairments.xml](https://www.enginatics.com/xml/fa-asset-impairments/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-asset-impairments/](https://www.enginatics.com/reports/fa-asset-impairments/) |

## Executive Summary
The **FA Asset Impairments** report provides a detailed listing of asset impairments, supporting financial compliance and accurate asset valuation. It is critical for Finance teams to track reductions in the recoverable amount of fixed assets and ensure the General Ledger reflects true asset values.

## Business Challenge
*   **Regulatory Compliance:** Meeting accounting standards (like IAS 36 or FAS 144) regarding asset impairment.
*   **Financial Accuracy:** Ensuring that the book value of assets does not exceed their recoverable amount.
*   **Audit Trail:** Maintaining a clear record of impairment losses and reversals for audit purposes.

## The Solution
This Blitz Report facilitates impairment management by:
*   **Detailed Reporting:** Listing impairment amounts, net book values, and impairment reasons for each asset.
*   **Cash Generating Units (CGU):** Supporting analysis at the CGU level, which is essential for impairment testing.
*   **Reconciliation:** Helping reconcile impairment postings to the General Ledger.

## Technical Architecture
The report extracts data from `FA_IMPAIRMENTS`, `FA_ADDITIONS_VL`, and `FA_BOOK_CONTROLS`. It links assets to their respective Cash Generating Units via `FA_CASH_GEN_UNITS`. The SQL logic handles both standard and reporting currency (MRC) impairments if applicable.

## Parameters & Filtering
*   **Book:** The depreciation book to analyze.
*   **Start/End Period:** The range of accounting periods for the report.
*   **Impairment:** Filter by specific impairment ID or status.
*   **Cash Generating Unit:** Filter for assets belonging to a specific CGU.

## Performance & Optimization
*   **Period Range:** Run for specific open periods to minimize data volume during month-end close.
*   **Book:** Always specify the corporate or tax book to avoid duplicate data from multiple books.

## FAQ
*   **Q: What is a Cash Generating Unit (CGU)?**
    *   A: A CGU is the smallest identifiable group of assets that generates cash inflows that are largely independent of the cash inflows from other assets or groups of assets.
*   **Q: Does this report show reversed impairments?**
    *   A: Yes, depending on the status and period selected, it can show impairment reversals.


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
