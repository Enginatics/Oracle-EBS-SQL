---
layout: default
last_modified_at: 2026-10-16
title: 'FND Request Groups | Oracle EBS SQL Report'
description: 'FND request groups and their assigned units, such as concurrent programs, request sets or applications'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Request, Groups, fnd_request_groups, fnd_application_vl, fnd_request_group_units'
permalink: /FND%20Request%20Groups/
report_name: 'FND Request Groups'
report_web_name: fnd-request-groups
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Request Groups – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-request-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
FND request groups and their assigned units, such as concurrent programs, request sets or applications

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Request Group, Group Application, Concurrent Program Name

## Oracle EBS Tables Used
[fnd_request_groups](https://www.enginatics.com/library/?pg=1&find=fnd_request_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups), [fnd_request_group_units](https://www.enginatics.com/library/?pg=1&find=fnd_request_group_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups), [fnd_request_sets_vl](https://www.enginatics.com/library/?pg=1&find=fnd_request_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups)

## Related Reports
[FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [PAY Payroll Process Summary](/PAY%20Payroll%20Process%20Summary/ "PAY Payroll Process Summary Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Attached Documents](/FND%20Attached%20Documents/ "FND Attached Documents Oracle EBS SQL Report"), [FND Concurrent Programs and Executables](/FND%20Concurrent%20Programs%20and%20Executables/ "FND Concurrent Programs and Executables Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Request%20Groups/FND%20Request%20Groups.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Request Groups 27-Jun-2024 161133.xlsx](https://www.enginatics.com/example/fnd-request-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups) |
| Blitz Report™ XML Import | [FND_Request_Groups.xml](https://www.enginatics.com/xml/fnd-request-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups) |
| SQL Source | [FND Request Groups.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Request%20Groups/FND%20Request%20Groups.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-request-groups/](https://www.enginatics.com/reports/fnd-request-groups/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups) |

## Executive Summary
The **FND Request Groups** report documents which concurrent programs are assigned to which Request Groups. This is the mechanism that controls which reports a user can run.

## Business Challenge
*   **Security Audit:** Verifying that sensitive reports (e.g., "Employee Salary Report") are not in standard request groups.
*   **Troubleshooting:** Explaining why a user cannot find a specific report in the "Submit Request" window.
*   **Configuration:** Documenting the contents of custom request groups.

## The Solution
This Blitz Report lists the assignments:
*   **Request Group:** The name of the group (e.g., "GL Concurrent Program Group").
*   **Unit Type:** Program, Set, or Application.
*   **Unit Name:** The specific report or set assigned.

## Technical Architecture
The report queries `FND_REQUEST_GROUPS` and `FND_REQUEST_GROUP_UNITS`.

## Parameters & Filtering
*   **Request Group:** Filter by the group name.
*   **Concurrent Program Name:** Find all groups that contain a specific report (Reverse Search).

## Performance & Optimization
*   **Fast Execution:** Runs quickly against the configuration tables.

## FAQ
*   **Q: What does "Application" unit type mean?**
    *   A: It means *all* reports belonging to that application are automatically included in the group.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-request-groups)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
