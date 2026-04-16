---
layout: default
title: 'JA India GSTR-3B Return | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: GSTR-3B Return Report Application: Asia/Pacific Localizations Source: India GSTR-3B Return Report Short Name…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, India, GSTR-3B, Return, jai_party_reg_lines_v, jai_party_regs_v, jai_tax_det_factors'
permalink: /JA%20India%20GSTR-3B%20Return/
---

# JA India GSTR-3B Return – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ja-india-gstr-3b-return/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: GSTR-3B Return Report
Application: Asia/Pacific Localizations
Source: India GSTR-3B Return Report
Short Name: JAIGSTR3B
DB package:

## Report Parameters
Tax Regime, GST Registration Number, Return Period (MONYYYY)

## Oracle EBS Tables Used
[jai_party_reg_lines_v](https://www.enginatics.com/library/?pg=1&find=jai_party_reg_lines_v), [jai_party_regs_v](https://www.enginatics.com/library/?pg=1&find=jai_party_regs_v), [jai_tax_det_factors](https://www.enginatics.com/library/?pg=1&find=jai_tax_det_factors), [jai_tax_lines_v](https://www.enginatics.com/library/?pg=1&find=jai_tax_lines_v), [jai_reporting_associations_v](https://www.enginatics.com/library/?pg=1&find=jai_reporting_associations_v), [jai_rgm_recovery_lines](https://www.enginatics.com/library/?pg=1&find=jai_rgm_recovery_lines), [jai_party_reg](https://www.enginatics.com/library/?pg=1&find=jai_party_reg), [jai_party_regs](https://www.enginatics.com/library/?pg=1&find=jai_party_regs), [jai_tax_types_v](https://www.enginatics.com/library/?pg=1&find=jai_tax_types_v), [jai_tax_lines](https://www.enginatics.com/library/?pg=1&find=jai_tax_lines)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ja-india-gstr-3b-return/) |
| Blitz Report™ XML Import | [JA_India_GSTR_3B_Return.xml](https://www.enginatics.com/xml/ja-india-gstr-3b-return/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ja-india-gstr-3b-return/](https://www.enginatics.com/reports/ja-india-gstr-3b-return/) |

## JA India GSTR-3B Return - Case Study & Technical Analysis

### Executive Summary
The **JA India GSTR-3B Return** report supports the filing of the monthly summary return. GSTR-3B is a self-declared summary of outward supplies, inward supplies liable to reverse charge, and eligible ITC. It is the return that determines the actual tax payment liability for the month.

### Business Challenge
GSTR-3B is the "Payment Return". Errors here directly result in incorrect tax payments.
-   **Summary View:** Unlike GSTR-1 (detailed), GSTR-3B requires consolidated figures.
-   **Liability Calculation:** "Output Tax - Input Tax Credit = Cash Payment". This calculation must be precise.
-   **Reverse Charge:** Identifying services (like Legal Fees or Transport) where the company must pay tax on behalf of the vendor.

### Solution
The **JA India GSTR-3B Return** report aggregates data from both Sales (GSTR-1 equivalent) and Purchases (GSTR-2 equivalent) to provide the summary figures needed for the 3B filing.

**Key Features:**
-   **Consolidated Outward Supplies:** Total Taxable Value and Tax for sales.
-   **Eligible ITC:** Summary of ITC available from imports, ISDT, and domestic purchases.
-   **Reverse Charge Liability:** Summarizes liability arising from RCM (Reverse Charge Mechanism).

### Technical Architecture
The report aggregates data from the GST transaction repository.

#### Key Tables and Views
-   **`JAI_TAX_DET_FACTORS`**: Tax determination factors.
-   **`JAI_TAX_LINES`**: Tax amounts.
-   **`JAI_RGM_RECOVERY_LINES`**: Repository for tax recovery/payment.

#### Core Logic
1.  **Aggregation:** Sums up taxable values and tax amounts by category (Outward, Inward RCM, ITC).
2.  **Netting:** (In the business process, not necessarily the report) Calculates the net liability.
3.  **Reporting:** Presents the data in the exact table format of the GSTR-3B online form (Table 3.1, Table 4, etc.).

### Business Impact
-   **Tax Payment:** The basis for the monthly GST payment to the government.
-   **Compliance:** Ensures the monthly return is filed accurately and on time.
-   **Financial Planning:** Provides visibility into the net cash outflow required for taxes.


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
