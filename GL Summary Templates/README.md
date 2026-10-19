---
layout: default
last_modified_at: 2026-10-19
title: 'GL Summary Templates | Oracle EBS SQL Report'
description: 'Master data report showing GL summary and concatenation templates based on ledger, company, department, account, sub-account, and product segments, and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, General Ledger, Enginatics, Summary, Templates, gl_ledgers, gl_summary_templates'
permalink: /GL%20Summary%20Templates/
report_name: 'GL Summary Templates'
report_web_name: gl-summary-templates
module: 'General Ledger'
module_url: /modules/general-ledger/
---

# GL Summary Templates – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-summary-templates/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates).
**Oracle EBS module:** [General Ledger](/modules/general-ledger/ "Oracle EBS General Ledger reports") · [all General Ledger reports](/modules/general-ledger/)  

## Overview
Master data report showing GL summary and concatenation templates based on ledger, company, department, account, sub-account, and product segments, and including information for the group, ledger set, ledger, ledger category, currency and chart of accounts.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Chart of Accounts, Non Rollup Group Only

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates), [gl_summary_templates](https://www.enginatics.com/library/?pg=1&find=gl_summary_templates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates)

## Related Reports
[GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [GL Code Combinations](/GL%20Code%20Combinations/ "GL Code Combinations Oracle EBS SQL Report"), [GL Summary Account Upload](/GL%20Summary%20Account%20Upload/ "GL Summary Account Upload Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [CST Period Close Subinventory Value Summary](/CST%20Period%20Close%20Subinventory%20Value%20Summary/ "CST Period Close Subinventory Value Summary Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [FA Asset Book Details](/FA%20Asset%20Book%20Details/ "FA Asset Book Details Oracle EBS SQL Report"), [GL Budget Amounts Upload](/GL%20Budget%20Amounts%20Upload/ "GL Budget Amounts Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Summary%20Templates/GL%20Summary%20Templates.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [GL Summary Templates 09-Jul-2019 140636.xlsx](https://www.enginatics.com/example/gl-summary-templates/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates) |
| Blitz Report™ XML Import | [GL_Summary_Templates.xml](https://www.enginatics.com/xml/gl-summary-templates/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates) |
| SQL Source | [GL Summary Templates.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Summary%20Templates/GL%20Summary%20Templates.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-summary-templates/](https://www.enginatics.com/reports/gl-summary-templates/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates) |

## GL Summary Templates - Case Study & Technical Analysis

### Executive Summary
The **GL Summary Templates** report lists the existing Summary Account templates defined in the system. It provides a catalog of the pre-aggregated balance structures currently active. This report is crucial for understanding the performance optimization strategy of the General Ledger and for auditing which summary levels are being maintained.

### Business Use Cases
*   **Performance Tuning**: Helps identify if too many summary templates exist (which can slow down posting) or if key templates are missing (which slows down reporting).
*   **Redundancy Check**: Identifies duplicate or overlapping templates that might be wasting system resources.
*   **Impact Analysis**: Before deleting a rollup group or segment value, this report helps identify which summary templates rely on it.
*   **Documentation**: Provides a clear map of the "Total" accounts available for reporting users (e.g., "Use the 'Total Dept' summary account for faster queries").

### Technical Analysis

#### Core Tables
*   `GL_SUMMARY_TEMPLATES`: Stores the template header and the definition string (e.g., `D-T-D`).
*   `GL_LEDGERS`: Identifies the ledger.
*   `GL_ACCOUNT_HIERARCHIES`: (Implicit) The logic relies on the hierarchies defined in the chart of accounts.

#### Key Joins & Logic
*   **Template Decoding**: The report parses the `TEMPLATE` column to show which segments are "Detail" and which are "Summary".
*   **Status Check**: Checks if the template is `ENABLED` and if the status is `CURRENT` (meaning balances are up to date).
*   **Ledger Association**: Joins to `GL_LEDGERS` to show the scope of the template.

#### Key Parameters
*   **Chart of Accounts**: Filter by structure.
*   **Non Rollup Group Only**: A filter to show templates that might be using "Parent" values directly rather than Rollup Groups (depending on configuration).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-templates)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
