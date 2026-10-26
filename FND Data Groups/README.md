---
layout: default
last_modified_at: 2026-10-26
title: 'FND Data Groups | Oracle EBS SQL Report'
description: 'Oracle EBS Application Object Library SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Data, Groups, fnd_data_groups, fnd_data_group_units, fnd_application_vl'
permalink: /FND%20Data%20Groups/
report_name: 'FND Data Groups'
report_web_name: fnd-data-groups
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Data Groups – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-data-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Data Group Name

## Oracle EBS Tables Used
[fnd_data_groups](https://www.enginatics.com/library/?pg=1&find=fnd_data_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups), [fnd_data_group_units](https://www.enginatics.com/library/?pg=1&find=fnd_data_group_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups), [fnd_oracle_userid](https://www.enginatics.com/library/?pg=1&find=fnd_oracle_userid&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups)

## Related Reports
[FND Applications](/FND%20Applications/ "FND Applications Oracle EBS SQL Report"), [FND Responsibility Upload](/FND%20Responsibility%20Upload/ "FND Responsibility Upload Oracle EBS SQL Report"), [FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Data%20Groups/FND%20Data%20Groups.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Data Groups 04-Apr-2026 123137.xlsx](https://www.enginatics.com/example/fnd-data-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups) |
| Blitz Report™ XML Import | [FND_Data_Groups.xml](https://www.enginatics.com/xml/fnd-data-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups) |
| SQL Source | [FND Data Groups.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Data%20Groups/FND%20Data%20Groups.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-data-groups/](https://www.enginatics.com/reports/fnd-data-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups) |

## Executive Summary
The **FND Data Groups** report documents the Data Group configuration in EBS. Data Groups determine which Oracle ID (database schema) a concurrent program connects to when it runs.

## Business Challenge
*   **Multi-Schema Support:** Managing environments where different applications store data in different schemas (common in custom bolt-ons).
*   **Security:** Verifying that programs are connecting with the appropriate privileges.
*   **Troubleshooting:** Solving "Table or View does not exist" errors when a program runs in the wrong context.

## The Solution
This Blitz Report lists the mapping between Applications and Oracle IDs within each Data Group:
*   **Group Definition:** Shows the name of the Data Group (e.g., "Standard").
*   **Application Mapping:** Lists every application (e.g., "Assets") and the Oracle User (e.g., "FA") it maps to in that group.

## Technical Architecture
The report queries `FND_DATA_GROUPS` and `FND_DATA_GROUP_UNITS`. It joins `FND_ORACLE_USERID` to show the actual database schema name.

## Parameters & Filtering
*   **Data Group Name:** Filter for a specific group.

## Performance & Optimization
*   **Configuration Report:** Runs instantly.

## FAQ
*   **Q: What is the "Standard" data group?**
    *   A: It is the default group where each application maps to its own standard schema (e.g., GL maps to GL schema).
*   **Q: Why would I change this?**
    *   A: You might create a custom Data Group to point a standard report to a reporting schema or a custom schema for specific processing needs.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-data-groups)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
