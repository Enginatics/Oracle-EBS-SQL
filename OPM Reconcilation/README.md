---
layout: default
title: 'OPM Reconcilation | Oracle EBS SQL Report'
description: 'OPM Reconciliation Report. Blitz Report implementation of the Oracle sql script: OPMRecon.sql Reference MOS Document: OPM Inventory Balance Reconciliation…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, OPM, Reconcilation, mtl_item_flexfields, mtl_parameters, gmf_period_balances'
permalink: /OPM%20Reconcilation/
---

# OPM Reconcilation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/opm-reconcilation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
OPM Reconciliation Report.
Blitz Report implementation of the Oracle sql script: OPMRecon.sql 
Reference MOS Document: OPM Inventory Balance Reconciliation (Doc ID 1510357.1)

## Report Parameters
Legal Entity, Period to Reconcile

## Oracle EBS Tables Used
[mtl_item_flexfields](https://www.enginatics.com/library/?pg=1&find=mtl_item_flexfields), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [gmf_period_balances](https://www.enginatics.com/library/?pg=1&find=gmf_period_balances), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [gmf_xla_extract_lines](https://www.enginatics.com/library/?pg=1&find=gmf_xla_extract_lines), [gmf_xla_extract_headers](https://www.enginatics.com/library/?pg=1&find=gmf_xla_extract_headers), [q_inv_val_cur](https://www.enginatics.com/library/?pg=1&find=q_inv_val_cur), [q_inv_val_pri](https://www.enginatics.com/library/?pg=1&find=q_inv_val_pri), [q_sl_val_cur](https://www.enginatics.com/library/?pg=1&find=q_sl_val_cur), [q_item_diff_val](https://www.enginatics.com/library/?pg=1&find=q_item_diff_val)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [OPM Reconcilation - Default 14-Jul-2023 034226.xlsx](https://www.enginatics.com/example/opm-reconcilation/) |
| Blitz Report™ XML Import | [OPM_Reconcilation.xml](https://www.enginatics.com/xml/opm-reconcilation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/opm-reconcilation/](https://www.enginatics.com/reports/opm-reconcilation/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
