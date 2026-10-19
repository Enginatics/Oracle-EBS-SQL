---
layout: default
last_modified_at: 2026-10-19
title: 'FA Asset Impairments | Oracle EBS SQL Report'
description: 'Source: Asset Impairment Report Short Name: FAXRASIM DB package: – Oracle EBS Assets SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Assets, Enginatics, R12 only, Asset, Impairments, fa_lookups_tl, gl_code_combinations_kfv, fa_impairments'
permalink: /FA%20Asset%20Impairments/
report_name: 'FA Asset Impairments'
report_web_name: fa-asset-impairments
module: 'Assets'
module_url: /modules/assets/
---

# FA Asset Impairments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-asset-impairments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments).
**Oracle EBS module:** [Assets](/modules/assets/ "Oracle EBS Assets reports") · [all Assets reports](/modules/assets/)  

## Overview
Source: Asset Impairment Report
Short Name: FAXRASIM
DB package:

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Book, Set of Books Currency, Start Period, End Period, Impairment, Cash Generating Unit

## Oracle EBS Tables Used
[fa_lookups_tl](https://www.enginatics.com/library/?pg=1&find=fa_lookups_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments), [fa_impairments](https://www.enginatics.com/library/?pg=1&find=fa_impairments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments), [fa_cash_gen_units](https://www.enginatics.com/library/?pg=1&find=fa_cash_gen_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments), [fa_additions_vl](https://www.enginatics.com/library/?pg=1&find=fa_additions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments), [fa_mc_impairments](https://www.enginatics.com/library/?pg=1&find=fa_mc_impairments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments), [fa_itf_impairments](https://www.enginatics.com/library/?pg=1&find=fa_itf_impairments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments), [fa_mc_itf_impairments](https://www.enginatics.com/library/?pg=1&find=fa_mc_itf_impairments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments), [fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments)

## Related Reports
[FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Depreciation Reserve](/FA%20Depreciation%20Reserve/ "FA Depreciation Reserve Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Fixed Assets Book](/FA%20Fixed%20Assets%20Book/ "FA Fixed Assets Book Oracle EBS SQL Report"), [PA Capital Project Summary with Asset Detail](/PA%20Capital%20Project%20Summary%20with%20Asset%20Detail/ "PA Capital Project Summary with Asset Detail Oracle EBS SQL Report"), [FA Asset Transfers](/FA%20Asset%20Transfers/ "FA Asset Transfers Oracle EBS SQL Report"), [FA Additions By Source](/FA%20Additions%20By%20Source/ "FA Additions By Source Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Asset%20Impairments/FA%20Asset%20Impairments.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fa-asset-impairments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments) |
| Blitz Report™ XML Import | [FA_Asset_Impairments.xml](https://www.enginatics.com/xml/fa-asset-impairments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments) |
| SQL Source | [FA Asset Impairments.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20Asset%20Impairments/FA%20Asset%20Impairments.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fa-asset-impairments/](https://www.enginatics.com/reports/fa-asset-impairments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-asset-impairments)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
