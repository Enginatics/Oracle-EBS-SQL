---
layout: default
title: 'ECC Admin - Data Load Tracking | Oracle EBS SQL Report'
description: 'Enterprise Command Center data load run history, including status, the load SQL and possible error messages in case of failures. For description of the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, ECC, Admin, Data, Load, ecc_application_tl, ecc_dataset_b, ecc_audit_request'
permalink: /ECC%20Admin%20-%20Data%20Load%20Tracking/
---

# ECC Admin - Data Load Tracking – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ecc-admin-data-load-tracking/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Enterprise Command Center data load run history, including status, the load SQL and possible error messages in case of failures.
For description of the load process, see ECC Concurrent Programs <a href="https://www.enginatics.com/reports/ecc-concurrent-programs/" rel="nofollow" target="_blank">https://www.enginatics.com/reports/ecc-concurrent-programs/</a>

## Report Parameters
Run Id, Application, Data Set, Load Type, Status, Running within past x Days, Start Date From, Start Date To, Show Load Rules, Show SQLs

## Oracle EBS Tables Used
[ecc_application_tl](https://www.enginatics.com/library/?pg=1&find=ecc_application_tl), [ecc_dataset_b](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_b), [ecc_audit_request](https://www.enginatics.com/library/?pg=1&find=ecc_audit_request), [ecc_audit_dataset](https://www.enginatics.com/library/?pg=1&find=ecc_audit_dataset), [ecc_dataset_tl](https://www.enginatics.com/library/?pg=1&find=ecc_dataset_tl), [ecc_audit_load_rule](https://www.enginatics.com/library/?pg=1&find=ecc_audit_load_rule), [ecc_audit_load_details](https://www.enginatics.com/library/?pg=1&find=ecc_audit_load_details)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[ECC Admin - Data Sets](/ECC%20Admin%20-%20Data%20Sets/ "ECC Admin - Data Sets Oracle EBS SQL Report"), [ECC Admin - Metadata Attributes](/ECC%20Admin%20-%20Metadata%20Attributes/ "ECC Admin - Metadata Attributes Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [ECC Admin - Data Load Tracking 15-Jun-2020 193916.xlsx](https://www.enginatics.com/example/ecc-admin-data-load-tracking/) |
| Blitz Report™ XML Import | [ECC_Admin_Data_Load_Tracking.xml](https://www.enginatics.com/xml/ecc-admin-data-load-tracking/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ecc-admin-data-load-tracking/](https://www.enginatics.com/reports/ecc-admin-data-load-tracking/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
