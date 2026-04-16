---
layout: default
title: 'JA India GSTR-1 Return | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: India GSTR-1 Return Report in XML format Application: Asia/Pacific Localizations Source: India GSTR-1 Return…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, India, GSTR-1, Return, jai_party_reg_lines_v, jai_party_regs_v, jai_party_reg'
permalink: /JA%20India%20GSTR-1%20Return/
---

# JA India GSTR-1 Return – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ja-india-gstr-1-return/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: India GSTR-1 Return Report in XML format
Application: Asia/Pacific Localizations
Source: India GSTR-1 Return Report(XML)
Short Name: JAIGSTR1_XML
DB package: JAI_GST_EXTRACT_PKG

## Report Parameters
Tax Regime, Registration Number, Return Period(MONYYYY), Aggregate Turnover in Preceding year, Aggregate Turnover April to June

## Oracle EBS Tables Used
[jai_party_reg_lines_v](https://www.enginatics.com/library/?pg=1&find=jai_party_reg_lines_v), [jai_party_regs_v](https://www.enginatics.com/library/?pg=1&find=jai_party_regs_v), [jai_party_reg](https://www.enginatics.com/library/?pg=1&find=jai_party_reg), [jai_gst_rep_trx_detail_t](https://www.enginatics.com/library/?pg=1&find=jai_gst_rep_trx_detail_t)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[JA India GSTR-2 Return](/JA%20India%20GSTR-2%20Return/ "JA India GSTR-2 Return Oracle EBS SQL Report"), [JA India GSTR-3B Return](/JA%20India%20GSTR-3B%20Return/ "JA India GSTR-3B Return Oracle EBS SQL Report"), [JA India Third Party Registration Upload](/JA%20India%20Third%20Party%20Registration%20Upload/ "JA India Third Party Registration Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ja-india-gstr-1-return/) |
| Blitz Report™ XML Import | [JA_India_GSTR_1_Return.xml](https://www.enginatics.com/xml/ja-india-gstr-1-return/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ja-india-gstr-1-return/](https://www.enginatics.com/reports/ja-india-gstr-1-return/) |

## JA India GSTR-1 Return - Case Study & Technical Analysis

### Executive Summary
The **JA India GSTR-1 Return** report is a critical tax filing document under the Goods and Services Tax (GST) regime in India. It details all outward supplies (sales) of goods and services. Every registered business must file this return monthly or quarterly.

### Business Challenge
GST compliance in India is data-intensive and strictly regulated.
-   **Granularity:** The government requires invoice-level details for B2B sales, including HSN codes, tax rates, and customer GSTINs.
-   **Timeliness:** Late filing results in penalties and blocks the customer's ability to claim Input Tax Credit (ITC).
-   **Accuracy:** Mismatches between the GSTR-1 filed by the supplier and the GSTR-2A of the buyer lead to disputes.

### Solution
The **JA India GSTR-1 Return** report extracts the required data from the Oracle Receivables and Order Management modules, enriched with India Localization tax details.

**Key Features:**
-   **Section-wise Breakdown:** Categorizes data into B2B, B2C Large, B2C Small, Exports, and Credit/Debit Notes.
-   **HSN Summary:** Provides the mandatory HSN-wise summary of outward supplies.
-   **Document Series:** Lists the document number ranges issued during the period.

### Technical Architecture
The report uses the GST repository tables introduced in the R12.2 GST patch.

#### Key Tables and Views
-   **`JAI_GST_REP_TRX_DETAIL_T`**: A temporary or staging table often used by the extract package.
-   **`JAI_PARTY_REGS_V`**: Customer GST registration details.
-   **`JAI_TAX_LINES`**: Detailed tax calculation lines.

#### Core Logic
1.  **Extraction:** The `JAI_GST_EXTRACT_PKG` gathers data from AR Invoices and OM Orders.
2.  **Classification:** Logic determines if a transaction is B2B (Customer has GSTIN) or B2C.
3.  **XML Generation:** Produces the specific XML schema required by the GST Network (GSTN) or for upload to a GSP (GST Suvidha Provider).

### Business Impact
-   **Statutory Compliance:** Enables the timely filing of the GSTR-1 return.
-   **Cash Flow:** Ensures customers receive their tax credits, preventing payment withholding.
-   **Data Quality:** Highlights missing GSTINs or HSN codes before the filing deadline.


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
