---
layout: default
title: 'FA Additions By Source | Oracle EBS SQL Report'
description: 'Application: Assets Source: Additions By Source Report Short Name: FASASSBS – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Additions, Source, fa_lookups_vl, fa_distribution_history, fa_asset_history'
permalink: /FA%20Additions%20By%20Source/
---

# FA Additions By Source – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-additions-by-source/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Assets
Source: Additions By Source Report
Short Name: FASASSBS


## Report Parameters
Book, From Period, To Period

## Oracle EBS Tables Used
[fa_lookups_vl](https://www.enginatics.com/library/?pg=1&find=fa_lookups_vl), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [fa_asset_history](https://www.enginatics.com/library/?pg=1&find=fa_asset_history), [fa_category_books](https://www.enginatics.com/library/?pg=1&find=fa_category_books), [fa_lookups](https://www.enginatics.com/library/?pg=1&find=fa_lookups), [fa_additions](https://www.enginatics.com/library/?pg=1&find=fa_additions), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fa_transaction_headers](https://www.enginatics.com/library/?pg=1&find=fa_transaction_headers), [fa_deprn_detail](https://www.enginatics.com/library/?pg=1&find=fa_deprn_detail), [fa_deprn_periods](https://www.enginatics.com/library/?pg=1&find=fa_deprn_periods), [fa_adjustments](https://www.enginatics.com/library/?pg=1&find=fa_adjustments), [fa_asset_invoices](https://www.enginatics.com/library/?pg=1&find=fa_asset_invoices), [fa_invoice_transactions](https://www.enginatics.com/library/?pg=1&find=fa_invoice_transactions), [po_vendors](https://www.enginatics.com/library/?pg=1&find=po_vendors)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FA Additions By Source - Pivot Default Template 18-Jul-2023 150338.xlsx](https://www.enginatics.com/example/fa-additions-by-source/) |
| Blitz Report™ XML Import | [FA_Additions_By_Source.xml](https://www.enginatics.com/xml/fa-additions-by-source/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-additions-by-source/](https://www.enginatics.com/reports/fa-additions-by-source/) |

## FA Additions By Source

### Description
This report provides a detailed analysis of asset additions, categorized by their source. It is based on the standard Oracle "Additions By Source Report" and helps financial analysts track where new assets are originating from (e.g., Accounts Payable invoices, manual entries, or project capitalization).

Key features:
- **Source Tracking**: Identifies the origin of each asset addition.
- **Financial Details**: Includes cost, depreciation, and transaction details.
- **Audit Trail**: Links assets back to their source transactions, such as AP invoices (`fa_asset_invoices`, `po_vendors`).

This report is essential for reconciling asset subledgers with general ledger accounts and verifying the accuracy of capital expenditures.

### Parameters
- **Book**: The depreciation book to report on.
- **From Period**: Start period for the report.
- **To Period**: End period for the report.

### Used Tables
- `fa_lookups_vl`, `fa_lookups`: Lookup values for codes.
- `fa_distribution_history`: Asset distribution history.
- `fa_asset_history`: Asset history changes.
- `fa_category_books`: Asset category configurations.
- `fa_additions`: Asset master information.
- `gl_code_combinations`: General Ledger account codes.
- `fa_transaction_headers`: Transaction history.
- `fa_deprn_detail`, `fa_deprn_periods`: Depreciation details.
- `fa_adjustments`: Financial adjustments.
- `fa_asset_invoices`: Links to AP invoices.
- `fa_invoice_transactions`: Invoice transaction details.
- `po_vendors`: Supplier information.

### Categories
- **Enginatics**: Fixed Assets reporting and reconciliation.


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
