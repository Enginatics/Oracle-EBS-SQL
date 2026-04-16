---
layout: default
title: 'JA India GSTR-2 Return | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: India GSTR-2 Return Report with XML Format Application: Asia/Pacific Localizations Source: India GSTR-2 Return…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, India, GSTR-2, Return, jai_party_reg_lines_v, jai_party_regs_v, jai_party_reg'
permalink: /JA%20India%20GSTR-2%20Return/
---

# JA India GSTR-2 Return – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ja-india-gstr-2-return/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: India GSTR-2 Return Report with XML Format
Application: Asia/Pacific Localizations
Source: India GSTR-2 Return Report(XML)
Short Name: JAIGSTR2_XML
DB package: JAI_GSTR2_EXTRACT_PKG

## Report Parameters
Tax Regime, Registration Number, Return Period (MONYYYY)

## Oracle EBS Tables Used
[jai_party_reg_lines_v](https://www.enginatics.com/library/?pg=1&find=jai_party_reg_lines_v), [jai_party_regs_v](https://www.enginatics.com/library/?pg=1&find=jai_party_regs_v), [jai_party_reg](https://www.enginatics.com/library/?pg=1&find=jai_party_reg), [jai_gst_rep_trx_detail_t](https://www.enginatics.com/library/?pg=1&find=jai_gst_rep_trx_detail_t)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[JA India GSTR-1 Return](/JA%20India%20GSTR-1%20Return/ "JA India GSTR-1 Return Oracle EBS SQL Report"), [JA India GSTR-3B Return](/JA%20India%20GSTR-3B%20Return/ "JA India GSTR-3B Return Oracle EBS SQL Report"), [JA India Third Party Registration Upload](/JA%20India%20Third%20Party%20Registration%20Upload/ "JA India Third Party Registration Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ja-india-gstr-2-return/) |
| Blitz Report™ XML Import | [JA_India_GSTR_2_Return.xml](https://www.enginatics.com/xml/ja-india-gstr-2-return/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ja-india-gstr-2-return/](https://www.enginatics.com/reports/ja-india-gstr-2-return/) |

## JA India GSTR-2 Return - Case Study & Technical Analysis

### Executive Summary
The **JA India GSTR-2 Return** report is designed to facilitate the reconciliation of inward supplies (purchases). While the GSTR-2 filing itself has been largely suspended/replaced by auto-populated statements (GSTR-2A/2B), this report remains essential for internal reconciliation to claim Input Tax Credit (ITC).

### Business Challenge
To claim ITC, a business must prove that it paid tax to its vendors.
-   **Reconciliation:** "The vendor says they filed their return, but it's not showing in our GSTR-2A."
-   **ITC Claim:** "How much tax credit are we eligible for this month?"
-   **Vendor Compliance:** Identifying vendors who consistently fail to file their returns.

### Solution
The **JA India GSTR-2 Return** report extracts purchase data from Oracle Payables and Receiving, showing the tax paid on procurements.

**Key Features:**
-   **Purchase Register:** Lists all GST-bearing invoices received from vendors.
-   **ITC Eligibility:** Flags whether the tax paid is eligible for credit (e.g., ineligible for personal use items).
-   **Import Details:** Includes details of imports (Bill of Entry) which are also part of inward supplies.

### Technical Architecture
The report queries the Payables and India Localization tax tables.

#### Key Tables and Views
-   **`JAI_GST_REP_TRX_DETAIL_T`**: Staging table for report data.
-   **`JAI_PARTY_REGS_V`**: Vendor GST registration details.
-   **`AP_INVOICES_ALL`**: Base AP invoice data.

#### Core Logic
1.  **Extraction:** The `JAI_GSTR2_EXTRACT_PKG` pulls data from AP Invoices and RCV Transactions.
2.  **Tax Analysis:** Breaks down the tax into CGST, SGST, and IGST components.
3.  **Reconciliation:** Designed to be compared against the government-generated GSTR-2A/2B.

### Business Impact
-   **Financial Savings:** Maximizes the claim of Input Tax Credit, directly reducing cash tax liability.
-   **Compliance:** Ensures that only eligible credits are taken, avoiding interest and penalties.
-   **Vendor Management:** Provides data to hold vendors accountable for their tax compliance.


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
