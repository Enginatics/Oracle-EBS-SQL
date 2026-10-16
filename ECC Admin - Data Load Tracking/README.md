---
layout: default
last_modified_at: 2026-10-16
title: 'ECC Admin - Data Load Tracking | Oracle EBS SQL Report'
description: 'Enterprise Command Center data load run history, including status, the load SQL and possible error messages in case of failures. For description of the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enterprise Command Center, Enginatics, R12 only, ECC, Admin, Data, Load, ecc_application_tl, ecc_dataset_b, ecc_audit_request'
permalink: /ECC%20Admin%20-%20Data%20Load%20Tracking/
report_name: 'ECC Admin - Data Load Tracking'
report_web_name: ecc-admin-data-load-tracking
module: 'Enterprise Command Center'
module_url: /modules/enterprise-command-center/
---

# ECC Admin - Data Load Tracking – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ecc-admin-data-load-tracking/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking).
**Oracle EBS module:** [Enterprise Command Center](/modules/enterprise-command-center/ "Oracle EBS Enterprise Command Center reports") · [all Enterprise Command Center reports](/modules/enterprise-command-center/)  

## Overview
Enterprise Command Center data load run history, including status, the load SQL and possible error messages in case of failures.
For description of the load process, see ECC Concurrent Programs <a href="https://www.enginatics.com/reports/ecc-concurrent-programs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking" rel="nofollow" target="_blank">https://www.enginatics.com/reports/ecc-concurrent-programs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Run Id, Application, Data Set, Load Type, Status, Running within past x Days, Start Date From, Start Date To, Show Load Rules, Show SQLs

## Oracle EBS Tables Used
[ecc_application_tl](https://www.enginatics.com/library/?pg=1&find=ecc_application_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking), [ecc_dataset_b](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking), [ecc_audit_request](https://www.enginatics.com/library/?pg=1&find=ecc_audit_request&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking), [ecc_audit_dataset](https://www.enginatics.com/library/?pg=1&find=ecc_audit_dataset&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking), [ecc_dataset_tl](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking), [ecc_audit_load_rule](https://www.enginatics.com/library/?pg=1&find=ecc_audit_load_rule&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking), [ecc_audit_load_details](https://www.enginatics.com/library/?pg=1&find=ecc_audit_load_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking)

## Related Reports
[ECC Admin - Data Sets](/ECC%20Admin%20-%20Data%20Sets/ "ECC Admin - Data Sets Oracle EBS SQL Report"), [ECC Admin - Metadata Attributes](/ECC%20Admin%20-%20Metadata%20Attributes/ "ECC Admin - Metadata Attributes Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ECC%20Admin%20-%20Data%20Load%20Tracking/ECC%20Admin%20-%20Data%20Load%20Tracking.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ECC Admin - Data Load Tracking 15-Jun-2020 193916.xlsx](https://www.enginatics.com/example/ecc-admin-data-load-tracking/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking) |
| Blitz Report™ XML Import | [ECC_Admin_Data_Load_Tracking.xml](https://www.enginatics.com/xml/ecc-admin-data-load-tracking/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking) |
| SQL Source | [ECC Admin - Data Load Tracking.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ECC%20Admin%20-%20Data%20Load%20Tracking/ECC%20Admin%20-%20Data%20Load%20Tracking.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ecc-admin-data-load-tracking/](https://www.enginatics.com/reports/ecc-admin-data-load-tracking/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking) |

## ECC Admin - Data Load Tracking

### Description
This report provides a detailed history of Enterprise Command Center (ECC) data load runs. It is a crucial tool for administrators to monitor the health and status of data synchronization processes.

Key features include:
- **Execution Status**: Tracks the success, failure, or progress of data loads.
- **Error Analysis**: Captures error messages and SQL queries associated with failed loads, facilitating rapid troubleshooting.
- **Load Details**: Displays the specific dataset, application, and load type (Full vs. Incremental).

By using this report, administrators can ensure that the ECC dashboards are displaying the most current and accurate data.

### Parameters
- **Run Id**: Filter by specific load run ID.
- **Application**: Filter by ECC application.
- **Data Set**: Filter by specific dataset.
- **Load Type**: Filter by load type (e.g., FULL_LOAD, INCREMENTAL_LOAD).
- **Status**: Filter by execution status (e.g., SUCCESS, ERROR).
- **Running within past x Days**: Filter for recent activity.
- **Start Date From/To**: Define a custom date range.
- **Show Load Rules**: Toggle display of load rules.
- **Show SQLs**: Toggle display of the underlying SQL executed during the load.

### Used Tables
- `ecc_application_tl`: ECC application translations.
- `ecc_dataset_b`: ECC dataset base definitions.
- `ecc_audit_request`: Audit log for load requests.
- `ecc_audit_dataset`: Audit log for dataset loads.
- `ecc_dataset_tl`: ECC dataset translations.
- `ecc_audit_load_rule`: Audit log for load rules.
- `ecc_audit_load_details`: Detailed audit logs.

### Categories
- **Enginatics**: ECC administration and monitoring.

### Related Reports
- [ECC Admin - Data Sets](/ECC%20Admin%20-%20Data%20Sets/)
- [ECC Admin - Metadata Attributes](/ECC%20Admin%20-%20Metadata%20Attributes/)

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ecc-admin-data-load-tracking)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
