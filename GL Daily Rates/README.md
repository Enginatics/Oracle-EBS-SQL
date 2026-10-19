---
layout: default
last_modified_at: 2026-10-19
title: 'GL Daily Rates | Oracle EBS SQL Report'
description: 'Daily currency conversion rates – Oracle EBS General Ledger SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, General Ledger, Enginatics, Daily, Rates, gl_daily_conversion_types, gl_daily_rates'
permalink: /GL%20Daily%20Rates/
report_name: 'GL Daily Rates'
report_web_name: gl-daily-rates
module: 'General Ledger'
module_url: /modules/general-ledger/
---

# GL Daily Rates – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-daily-rates/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates).
**Oracle EBS module:** [General Ledger](/modules/general-ledger/ "Oracle EBS General Ledger reports") · [all General Ledger reports](/modules/general-ledger/)  

## Overview
Daily currency conversion rates

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
From Currency, To Currency, Conversion Type, Conversion Date From, Conversion Date To

## Oracle EBS Tables Used
[gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates)

## Related Reports
[CAC Item List Price vs. Item Cost](/CAC%20Item%20List%20Price%20vs-%20Item%20Cost/ "CAC Item List Price vs. Item Cost Oracle EBS SQL Report"), [AR Unapplied Receipts Register](/AR%20Unapplied%20Receipts%20Register/ "AR Unapplied Receipts Register Oracle EBS SQL Report"), [AP Trial Balance](/AP%20Trial%20Balance/ "AP Trial Balance Oracle EBS SQL Report"), [CAC PO Price vs. Costing Method Comparison](/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison/ "CAC PO Price vs. Costing Method Comparison Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Daily%20Rates/GL%20Daily%20Rates.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Daily Rates 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/gl-daily-rates/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates) |
| Blitz Report™ XML Import | [GL_Daily_Rates.xml](https://www.enginatics.com/xml/gl-daily-rates/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates) |
| SQL Source | [GL Daily Rates.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Daily%20Rates/GL%20Daily%20Rates.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-daily-rates/](https://www.enginatics.com/reports/gl-daily-rates/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates) |

## GL Daily Rates - Case Study & Technical Analysis

### Executive Summary
The **GL Daily Rates** report provides a comprehensive listing of daily currency exchange rates defined in the Oracle EBS system. It is an essential tool for multi-currency environments, ensuring that conversion rates for foreign currency transactions are accurate, complete, and compliant with corporate treasury policies. This report serves as a primary control for verifying the rates used in currency translation and revaluation processes.

### Business Use Cases
*   **Treasury Management**: Monitors exchange rate trends and ensures that corporate rates (e.g., daily spot rates, monthly average rates) are loaded correctly into the ERP.
*   **Transaction Audit**: Verifies the specific exchange rate applied to a transaction on a given date, which is crucial when investigating currency variances in subledgers (AP/AR).
*   **Missing Rate Identification**: Proactively checks for missing rates between currency pairs before period-end processes (like Revaluation or Translation) fail due to undefined rates.
*   **Intercompany Reconciliation**: Ensures consistent exchange rates are being used across different legal entities for intercompany transactions.
*   **Audit Trail**: Provides a historical record of exchange rates for tax and statutory reporting purposes.

### Technical Analysis

#### Core Tables
*   `GL_DAILY_RATES`: The primary table storing the actual exchange rates. It contains the `FROM_CURRENCY`, `TO_CURRENCY`, `CONVERSION_DATE`, and `CONVERSION_RATE`.
*   `GL_DAILY_CONVERSION_TYPES`: Stores the definitions of rate types (e.g., 'Corporate', 'Spot', 'User').
*   `FND_CURRENCIES`: Used to validate currency codes and retrieve precision information.

#### Key Joins & Logic
*   **Rate Retrieval**: The query selects from `GL_DAILY_RATES` based on the requested date range and currency pairs.
*   **Type Resolution**: Joins to `GL_DAILY_CONVERSION_TYPES` to display the user-friendly conversion type name instead of the internal code.
*   **Inverse Rates**: Depending on the configuration, the system may store rates in one direction (e.g., USD to EUR) and calculate the inverse (EUR to USD) dynamically. The report typically shows the stored rate but may need to handle inverse logic if requested.
*   **Date Filtering**: Strictly filters by `CONVERSION_DATE` to show the rates active for the specific period of interest.

#### Key Parameters
*   **From Currency**: The source currency code (e.g., USD).
*   **To Currency**: The target currency code (e.g., EUR).
*   **Conversion Type**: The specific rate type to report on (e.g., Corporate, Spot).
*   **Conversion Date From/To**: The date range for the report.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-daily-rates)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
