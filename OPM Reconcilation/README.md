---
layout: default
last_modified_at: 2026-10-19
title: 'OPM Reconcilation | Oracle EBS SQL Report'
description: 'OPM Reconciliation Report. Blitz Report implementation of the Oracle sql script: OPMRecon.sql Reference MOS Document: OPM Inventory Balance Reconciliation…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Process Manufacturing, Enginatics, R12 only, OPM, Reconcilation, mtl_item_flexfields, mtl_parameters, gmf_period_balances'
permalink: /OPM%20Reconcilation/
report_name: 'OPM Reconcilation'
report_web_name: opm-reconcilation
module: 'Process Manufacturing'
module_url: /modules/process-manufacturing/
---

# OPM Reconcilation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-reconcilation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation).
**Oracle EBS module:** [Process Manufacturing](/modules/process-manufacturing/ "Oracle EBS Process Manufacturing reports") · [all Process Manufacturing reports](/modules/process-manufacturing/)  

## Overview
OPM Reconciliation Report.
Blitz Report implementation of the Oracle sql script: OPMRecon.sql 
Reference MOS Document: OPM Inventory Balance Reconciliation (Doc ID 1510357.1)

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Legal Entity, Period to Reconcile

## Oracle EBS Tables Used
[mtl_item_flexfields](https://www.enginatics.com/library/?pg=1&find=mtl_item_flexfields&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation), [gmf_period_balances](https://www.enginatics.com/library/?pg=1&find=gmf_period_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation), [gmf_xla_extract_lines](https://www.enginatics.com/library/?pg=1&find=gmf_xla_extract_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation), [gmf_xla_extract_headers](https://www.enginatics.com/library/?pg=1&find=gmf_xla_extract_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [CAC OPM WIP Account Value](/CAC%20OPM%20WIP%20Account%20Value/ "CAC OPM WIP Account Value Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Reconcilation/OPM%20Reconcilation.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Reconcilation - Default 14-Jul-2023 034226.xlsx](https://www.enginatics.com/example/opm-reconcilation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation) |
| Blitz Report™ XML Import | [OPM_Reconcilation.xml](https://www.enginatics.com/xml/opm-reconcilation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation) |
| SQL Source | [OPM Reconcilation.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/OPM%20Reconcilation/OPM%20Reconcilation.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/opm-reconcilation/](https://www.enginatics.com/reports/opm-reconcilation/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation) |

## Case Study & Technical Analysis: OPM Inventory to GL Reconciliation Report

### Executive Summary

The OPM Inventory to GL Reconciliation report is a critical financial closing tool for businesses using Oracle Process Manufacturing (OPM). Based on a standard Oracle reconciliation script (MOS Doc ID 1510357.1), this report automates the vital process of reconciling the inventory and work-in-process (WIP) values from the OPM subledger with the corresponding account balances in the General Ledger. It is an essential tool for financial controllers and cost accountants to ensure the accuracy of their financial statements and accelerate the period-end close.

### Business Challenge

Reconciling subledger inventory balances to the General Ledger is a cornerstone of the financial close process, but it is often a major pain point. Key challenges in an OPM environment include:

-   **Reconciliation Discrepancies:** It is a common and serious issue for the detailed inventory and WIP values tracked in the OPM subledger to become out of sync with the balances posted to the General Ledger.
-   **Lack of Standard Reporting:** Oracle EBS often lacks a single, comprehensive report that provides a clear and detailed comparison to help identify the source of these discrepancies.
-   **Intensive Manual Effort:** Without an automated report, accountants are forced to spend days at the end of each month manually exporting trial balances from the GL and inventory valuation reports from OPM, then using complex spreadsheets to painstakingly match the numbers and find variances.
-   **Delayed Period Close:** Investigating and resolving OPM-to-GL discrepancies is a primary reason for delays in closing the books, which impacts the timeliness of financial reporting across the enterprise.

### The Solution

This report provides an automated, detailed, and actionable reconciliation that transforms the OPM period-end process.

-   **Automated Balance Comparison:** The report automatically calculates the total inventory/WIP value from the OPM subledger for a given period and compares it directly against the balances of the inventory accounts in the General Ledger.
-   **Variance Identification:** It clearly highlights the total variance between the two systems and provides a detailed, item-by-item breakdown, allowing accountants to immediately focus their investigation on the specific items causing the discrepancy.
-   **Accelerated Financial Close:** By replacing a multi-day manual task with a report that runs in minutes, this tool dramatically reduces the time and effort required for the OPM financial close.
-   **Improved Financial Integrity:** By making the reconciliation process faster and more transparent, the report helps to ensure the ongoing integrity and accuracy of the company's financial statements.

### Technical Architecture (High Level)

The report's logic is based on the proven methodology provided by Oracle Support for OPM-to-GL reconciliation.

-   **Primary Tables Involved:**
    -   `gmf_period_balances` (This OPM table stores the period-end snapshot of inventory and WIP quantities and values, serving as the subledger-side balance).
    -   `gmf_xla_extract_headers` and `gmf_xla_extract_lines` (These are the OPM Subledger Accounting (SLA) tables that store the detailed accounting entries that were posted to the General Ledger).
    -   `org_acct_periods` (Used to identify the correct accounting period for the reconciliation).
-   **Logical Relationships:** The report's core function is to aggregate the total value from `gmf_period_balances` for the specified period. It simultaneously aggregates the net activity posted to the inventory accounts from the `gmf_xla_extract_lines` tables. It then presents these two totals—the subledger value and the GL value—side-by-side and calculates the variance.

### Parameters & Filtering

The parameters are simple and laser-focused on the period-end reconciliation task:

-   **Legal Entity:** Allows the reconciliation to be run for a specific legal entity.
-   **Period to Reconcile:** The user selects the accounting period they wish to reconcile, ensuring the report compares the correct OPM snapshot to the correct GL period balance.

### Performance & Optimization

The report queries large, transaction-heavy subledger accounting tables and is optimized for this task.

-   **Efficient Aggregation:** The SQL logic is designed to perform efficient, summarized aggregation of the period data, minimizing the amount of row-by-row processing.
-   **Direct Data Access:** As a Blitz Report, it accesses the data directly from the database and avoids the performance overhead of other reporting tools that rely on intermediate data formats.

### FAQ

**1. What is the difference between the 'Subledger Value' and the 'GL Value' shown in the report?**
   The 'Subledger Value' is the total value of inventory and WIP as calculated and stored within the OPM module's own period-end snapshot (`gmf_period_balances`). The 'GL Value' is the balance of the inventory/WIP accounts as recorded in the General Ledger, based on the journal entries that came from the OPM subledger. In a perfectly balanced system, these two numbers should be identical.

**2. What are the most common causes for discrepancies that this report finds?**
   Discrepancies can be caused by several issues, including: un-costed or errored material transactions, manual journal entries made directly to inventory control accounts in the GL (bypassing the subledger), or problems with the Subledger Accounting (SLA) rules that create the journal entries.

**3. Should this report be run before or after the accounting period is closed in OPM and GL?**
   This report should be run *after* all inventory-related transactions for the period have been processed and costed, but *before* the OPM and GL periods are finally closed. This allows accountants to find and correct any discrepancies before finalizing the books for the month.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=opm-reconcilation)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
