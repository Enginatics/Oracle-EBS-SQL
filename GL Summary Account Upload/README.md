---
layout: default
last_modified_at: 2026-10-19
title: 'GL Summary Account Upload | Oracle EBS SQL Report'
description: 'This upload can be used to import Summary Account Templates. – Oracle E-Business Suite SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Summary, Account, gl_summary_templates, gl_summary_bc_options, fnd_lookup_values_vl'
permalink: /GL%20Summary%20Account%20Upload/
report_name: 'GL Summary Account Upload'
report_web_name: gl-summary-account-upload
---

# GL Summary Account Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-summary-account-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload).

## Overview
This upload can be used to import Summary Account Templates.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger

## Oracle EBS Tables Used
[gl_summary_templates](https://www.enginatics.com/library/?pg=1&find=gl_summary_templates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload), [gl_summary_bc_options](https://www.enginatics.com/library/?pg=1&find=gl_summary_bc_options&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload), [gl_budgets_require_journals_v](https://www.enginatics.com/library/?pg=1&find=gl_budgets_require_journals_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload), [Upload](https://www.enginatics.com/library/?pg=1&category%5B%5D=Upload&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload)

## Related Reports
[GL Budget Amounts Upload](/GL%20Budget%20Amounts%20Upload/ "GL Budget Amounts Upload Oracle EBS SQL Report"), [GL Setup Upload](/GL%20Setup%20Upload/ "GL Setup Upload Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [GL Code Combinations](/GL%20Code%20Combinations/ "GL Code Combinations Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Summary%20Account%20Upload/GL%20Summary%20Account%20Upload.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/gl-summary-account-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload) |
| Blitz Report™ XML Import | [GL_Summary_Account_Upload.xml](https://www.enginatics.com/xml/gl-summary-account-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload) |
| SQL Source | [GL Summary Account Upload.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/GL%20Summary%20Account%20Upload/GL%20Summary%20Account%20Upload.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/gl-summary-account-upload/](https://www.enginatics.com/reports/gl-summary-account-upload/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload) |

## GL Summary Account Upload - Case Study & Technical Analysis

### Executive Summary
The **GL Summary Account Upload** is a utility tool designed to facilitate the mass creation or maintenance of Summary Accounts (Summary Templates) in Oracle General Ledger. Summary Accounts are special accounts that maintain pre-aggregated balances for a group of detail accounts, significantly speeding up financial reporting and inquiry. This tool allows users to define these templates in Excel and upload them, avoiding the complex manual setup screens.

### Business Use Cases
*   **Performance Optimization**: Quickly creates summary accounts to improve the performance of FSG reports and online account inquiries.
*   **Mass Creation**: Enables the creation of dozens of summary templates (e.g., "Total Revenue by Region", "Total Expenses by Department") in a single batch operation.
*   **Standardization**: Ensures consistent naming conventions and structure for summary accounts across different ledgers.
*   **Budgetary Control**: Summary accounts are often used for budgetary control (checking funds at a summary level); this tool helps set up those controls efficiently.

### Technical Analysis

#### Core Tables
*   `GL_SUMMARY_TEMPLATES`: The primary table storing the summary account definitions.
*   `GL_SUMMARY_BC_OPTIONS`: Stores budgetary control options associated with the summary template.
*   `GL_LEDGERS`: The ledger context.
*   `GL_CODE_COMBINATIONS`: The resulting summary code combinations created by the template.

#### Key Joins & Logic
*   **Template Logic**: The tool defines a template (e.g., `D-T-D-D-D`) where 'D' stands for Detail and 'T' for Total (Rollup).
*   **Interface/API**: It likely uses the `GL_SUMMARY_TEMPLATES_PKG` or a similar internal API to validate and insert the template definition.
*   **Concurrent Processing**: Upon upload, it typically triggers the "Program - Maintain Summary Templates" concurrent request to build the summary account balances in the background.

#### Key Parameters
*   **Ledger**: The ledger where the summary accounts will be created.
*   **Template Name**: The unique name for the summary definition.
*   **Template Pattern**: The D/T pattern defining the aggregation level.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=gl-summary-account-upload)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
