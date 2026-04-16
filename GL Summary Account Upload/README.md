---
layout: default
title: 'GL Summary Account Upload | Oracle EBS SQL Report'
description: 'This upload can be used to import Summary Account Templates. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Upload, Summary, Account, gl_summary_templates, gl_summary_bc_options, fnd_lookup_values_vl'
permalink: /GL%20Summary%20Account%20Upload/
---

# GL Summary Account Upload – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/gl-summary-account-upload/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
This upload can be used to import Summary Account Templates.

## Report Parameters
Ledger

## Oracle EBS Tables Used
[gl_summary_templates](https://www.enginatics.com/library/?pg=1&find=gl_summary_templates), [gl_summary_bc_options](https://www.enginatics.com/library/?pg=1&find=gl_summary_bc_options), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl), [gl_budgets_require_journals_v](https://www.enginatics.com/library/?pg=1&find=gl_budgets_require_journals_v), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only), [Upload](https://www.enginatics.com/library/?pg=1&category[]=Upload)

## Related Reports
[GL Budget Amounts Upload](/GL%20Budget%20Amounts%20Upload/ "GL Budget Amounts Upload Oracle EBS SQL Report"), [AP Supplier Upload](/AP%20Supplier%20Upload/ "AP Supplier Upload Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/gl-summary-account-upload/) |
| Blitz Report™ XML Import | [GL_Summary_Account_Upload.xml](https://www.enginatics.com/xml/gl-summary-account-upload/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/gl-summary-account-upload/](https://www.enginatics.com/reports/gl-summary-account-upload/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
