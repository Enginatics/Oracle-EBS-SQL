---
layout: default
title: 'FA CIP Assets and Invoices | Oracle EBS SQL Report'
description: 'CIP (Construction in Progress) assets with invoice details. Shows asset master information (category, location, tag, cost) alongside AP invoice lines that…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CIP, Assets, Invoices, fa_book_controls, gl_ledgers, fa_additions_b'
permalink: /FA%20CIP%20Assets%20and%20Invoices/
---

# FA CIP Assets and Invoices – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fa-cip-assets-and-invoices/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
CIP (Construction in Progress) assets with invoice details.
Shows asset master information (category, location, tag, cost) alongside AP invoice lines that feed into CIP.
Run as-is for invoice-level detail, or pivot/group in Excel for an asset-level summary.

Covers the use cases of:
- Monthly CIP Report - Asset Details (CapEx)
- Monthly CIP Report - CIP Invoice Activity

## Report Parameters
Book, Asset Number, Asset Category, Invoice Date From, Invoice Date To, Show DFF Attributes

## Oracle EBS Tables Used
[fa_book_controls](https://www.enginatics.com/library/?pg=1&find=fa_book_controls), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fa_additions_b](https://www.enginatics.com/library/?pg=1&find=fa_additions_b), [fa_additions_tl](https://www.enginatics.com/library/?pg=1&find=fa_additions_tl), [fa_books](https://www.enginatics.com/library/?pg=1&find=fa_books), [fa_distribution_history](https://www.enginatics.com/library/?pg=1&find=fa_distribution_history), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fa_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=fa_categories_b_kfv), [fa_locations_kfv](https://www.enginatics.com/library/?pg=1&find=fa_locations_kfv), [fa_asset_invoices](https://www.enginatics.com/library/?pg=1&find=fa_asset_invoices), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FA Asset Upload](/FA%20Asset%20Upload/ "FA Asset Upload Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [FA Asset Register](/FA%20Asset%20Register/ "FA Asset Register Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [FA Asset Additions](/FA%20Asset%20Additions/ "FA Asset Additions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/fa-cip-assets-and-invoices/) |
| Blitz Report™ XML Import | [FA_CIP_Assets_and_Invoices.xml](https://www.enginatics.com/xml/fa-cip-assets-and-invoices/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fa-cip-assets-and-invoices/](https://www.enginatics.com/reports/fa-cip-assets-and-invoices/) |



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
