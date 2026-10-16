---
layout: default
last_modified_at: 2026-10-16
title: 'FA CIP Assets and Invoices | Oracle EBS SQL Report'
description: 'CIP (Construction in Progress) assets with invoice details. Shows asset master information (category, location, tag, cost) alongside AP invoice lines that…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Assets, Enginatics, CIP, Invoices, fa_book_controls, gl_ledgers, fa_additions_b'
permalink: /FA%20CIP%20Assets%20and%20Invoices/
report_name: 'FA CIP Assets and Invoices'
report_web_name: fa-cip-assets-and-invoices
module: 'Assets'
module_url: /modules/assets/
---

# FA CIP Assets and Invoices – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-cip-assets-and-invoices/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices).
**Oracle EBS module:** [Assets](/modules/assets/ "Oracle EBS Assets reports") · [all Assets reports](/modules/assets/)  

## Overview
CIP (Construction in Progress) assets with invoice details.
Shows asset master information (category, location, tag, cost) alongside AP invoice lines that feed into CIP.
Run as-is for invoice-level detail, 
or pivot/group in Excel for an asset-level summary - Use template Asset Summary
Covers the use cases of:
- Monthly CIP Report - Asset Details (CapEx)
- Monthly CIP Report - CIP Invoice Activity

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Book, Asset Number, Asset Category, Invoice Date From, Invoice Date To, DFF Display

## Oracle EBS Tables Used
[fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices), [fa_asset_keywords_kfv](https://www.enginatics.com/library/?pg=1&find=fa_asset_keywords_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices), [fa_additions_tl](https://www.enginatics.com/library/?pg=1&find=fa_additions_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices), [fa_books](https://www.enginatics.com/library/?pg=1&find=fa_books&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices), [fa_asset_invoices](https://www.enginatics.com/library/?pg=1&find=fa_asset_invoices&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices)

## Related Reports
[FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report"), [FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [FA Fixed Assets Book](/FA%20Fixed%20Assets%20Book/ "FA Fixed Assets Book Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report"), [FA Asset Transfers](/FA%20Asset%20Transfers/ "FA Asset Transfers Oracle EBS SQL Report"), [FA Asset Summary (Germany)](/FA%20Asset%20Summary%20%28Germany%29/ "FA Asset Summary (Germany) Oracle EBS SQL Report"), [FA Depreciation Projection](/FA%20Depreciation%20Projection/ "FA Depreciation Projection Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20CIP%20Assets%20and%20Invoices/FA%20CIP%20Assets%20and%20Invoices.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/fa-cip-assets-and-invoices/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices) |
| Blitz Report™ XML Import | [FA_CIP_Assets_and_Invoices.xml](https://www.enginatics.com/xml/fa-cip-assets-and-invoices/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices) |
| SQL Source | [FA CIP Assets and Invoices.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FA%20CIP%20Assets%20and%20Invoices/FA%20CIP%20Assets%20and%20Invoices.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fa-cip-assets-and-invoices/](https://www.enginatics.com/reports/fa-cip-assets-and-invoices/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices) |

## Case Study & Technical Analysis: FA CIP Assets and Invoices

### Executive Summary
The FA CIP Assets and Invoices report lists Construction in Progress (CIP) assets from Oracle Fixed Assets together with the Accounts Payable invoice lines that feed each asset. For each asset it shows the master details, including category, location, tag number and cost, beside the invoice number, date, cost, supplier and purchase order that built up the cost. Fixed asset accountants use it for the monthly CIP review, to support capital expenditure reporting, and to trace how each CIP balance was formed. The report runs at invoice-line level, and it can be pivoted in Excel to give an asset-level summary.

### Business Challenge
*   **Monthly CIP close:** Each month, CIP balances must be explained by the invoices that were capitalised into them, and this trace is hard to build from the forms.
*   **Capital expenditure support:** Capital projects need a list of costs by asset, with the supplier and purchase order behind each cost.
*   **Invoice-to-asset traceability:** Auditors ask how a CIP asset was built, and the answer needs the invoice numbers, dates and batch details in one place.
*   **Location and category reporting:** CIP balances are often reviewed by category and location, so these attributes must sit next to the cost.

### The Solution
*   **Asset master with invoice detail:** Each CIP asset is shown with its cost, placed-in-service date and tag number, and with every invoice line linked to it.
*   **Supplier and PO trace:** The supplier name, invoice number, invoice date and purchase order number are returned for each line.
*   **Feeder and batch information:** The feeder system name and the Payables batch name show where each invoice came from.
*   **Book and period selection:** The report is run for a chosen asset book and a range of invoice dates, and it includes the ledger and currency of the book.

### Technical Architecture (High Level)
#### Primary Tables
*   `FA_BOOK_CONTROLS`: the book, which is linked to its ledger.
*   `GL_LEDGERS`: the ledger name and currency for the book.
*   `FA_ADDITIONS_B` and `FA_ADDITIONS_TL`: the asset master and its description, restricted to assets of type CIP.
*   `FA_ASSET_KEYWORDS_KFV`: the asset key.
*   `FA_BOOKS`: the book-level cost and the placed-in-service date for each asset.
*   `FA_DISTRIBUTION_HISTORY`: the current distribution, which supplies the code combination and location.
*   `GL_CODE_COMBINATIONS`: the accounting combination of the distribution.
*   `FA_CATEGORIES_B_KFV` and `FA_LOCATIONS_KFV`: the category and location descriptions.
*   `FA_ASSET_INVOICES`: the invoice lines that feed each asset.
*   `AP_SUPPLIERS`: the supplier on each invoice.

#### Logical Relationships
1.  `FA_BOOK_CONTROLS` is joined to `GL_LEDGERS` on the set of books ID, and filtered to the selected book type code.
2.  `FA_ADDITIONS_B` is restricted to CIP assets and joined to its description in `FA_ADDITIONS_TL` in the user's language.
3.  `FA_BOOKS` is joined to the asset and book, and only the open book record, with no transaction header out, is kept.
4.  `FA_DISTRIBUTION_HISTORY` is joined to the asset and book, using only current distributions, which supply the code combination and location.
5.  `FA_ASSET_INVOICES` is outer joined to the asset, so CIP assets without invoices still appear, and `AP_SUPPLIERS` is outer joined on the PO vendor ID.
6.  The result is ordered by asset number and invoice number.

### Parameters & Filtering
*   **Book:** Selects the corporate book whose CIP assets are reported. Ledger and currency come from this book.
*   **Asset Number and Asset Category:** Restrict the assets to one asset or one category.
*   **Invoice Date From and Invoice Date To:** Restrict the invoice lines to a date range, which supports a monthly review.
*   **DFF Display:** Controls how the descriptive flexfield columns are displayed.

### Performance & Optimization
*   **Book-first filter:** The book control join is the first restriction, so the asset and book rows are limited to one book before the invoice join.
*   **Current-record filters:** Only the open book record and current distribution are kept, which avoids returning retired cost and location history.
*   **Outer join for invoices:** Invoice lines are outer joined, so assets with no invoice lines still appear and are not dropped.
*   **Flexfield display:** The DFF Display parameter controls whether the descriptive flexfield columns are shown, so the default output stays narrower.

### FAQ
**Q: How do I see every invoice that built up a CIP asset?**
A: Run the report with the book and the asset number. Each invoice line for the asset appears on its own row, with the invoice number, date, cost and supplier.
**Q: How do I reproduce the monthly CIP figures?**
A: Set Invoice Date From and Invoice Date To to the month, then pivot the output in Excel by asset and sum the invoice cost. The description notes that the Asset Summary template covers the monthly CIP use cases.
**Q: Can I limit the report to one asset category?**
A: Yes. Use the Asset Category parameter, which restricts the assets to that category.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fa-cip-assets-and-invoices)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
