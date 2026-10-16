---
layout: default
last_modified_at: 2026-10-16
title: 'FND Concurrent Request Conflicts | Oracle EBS SQL Report'
description: 'Lists concurrent requests that were held by the conflict resolution manager and shows their conflicting / blocking requests which were running at the time…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Concurrent, Request, Conflicts, fnd_concurrent_requests, fnd_concurrent_program_serial, fnd_concurrent_programs_vl'
permalink: /FND%20Concurrent%20Request%20Conflicts/
report_name: 'FND Concurrent Request Conflicts'
report_web_name: fnd-concurrent-request-conflicts
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Concurrent Request Conflicts – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-concurrent-request-conflicts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Lists concurrent requests that were held by the conflict resolution manager and shows their conflicting / blocking requests which were running at the time between the requested start date and conflict release date.
This might not work 100% (it doesn't consider request set conflicts yet), but should give a good indication of most conflicting scenarios.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Concurrent Program Name, Started within Days, Requested Start Date From, Requested Start Date To

## Oracle EBS Tables Used
[fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts), [fnd_concurrent_program_serial](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_program_serial&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts)

## Related Reports
[FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [PAY Payroll Process Summary](/PAY%20Payroll%20Process%20Summary/ "PAY Payroll Process Summary Oracle EBS SQL Report"), [FND Gather Statistics History](/FND%20Gather%20Statistics%20History/ "FND Gather Statistics History Oracle EBS SQL Report"), [FND Concurrent Managers](/FND%20Concurrent%20Managers/ "FND Concurrent Managers Oracle EBS SQL Report"), [FND Concurrent Requests Summary](/FND%20Concurrent%20Requests%20Summary/ "FND Concurrent Requests Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Concurrent%20Request%20Conflicts/FND%20Concurrent%20Request%20Conflicts.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Concurrent Request Conflicts 25-Jun-2023 132118.xlsx](https://www.enginatics.com/example/fnd-concurrent-request-conflicts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts) |
| Blitz Report™ XML Import | [FND_Concurrent_Request_Conflicts.xml](https://www.enginatics.com/xml/fnd-concurrent-request-conflicts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts) |
| SQL Source | [FND Concurrent Request Conflicts.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Concurrent%20Request%20Conflicts/FND%20Concurrent%20Request%20Conflicts.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-concurrent-request-conflicts/](https://www.enginatics.com/reports/fnd-concurrent-request-conflicts/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts) |

## Executive Summary
The **FND Concurrent Request Conflicts** report analyzes the "Conflict Resolution Manager" (CRM) activity. It identifies requests that were delayed because they were incompatible with currently running jobs.

## Business Challenge
*   **Wait Time Analysis:** Understanding why a request stayed in "Pending" status for a long time.
*   **Incompatibility Tuning:** Identifying if incompatibility rules are too aggressive and causing unnecessary bottlenecks.
*   **SLA Monitoring:** Explaining delays in critical report delivery to business users.

## The Solution
This Blitz Report reconstructs the conflict scenario:
*   **Blocked Request:** Identifies the request that was held.
*   **Blocking Request:** Identifies the specific request ID that was running and caused the conflict.
*   **Time Impact:** Shows the duration of the delay caused by the conflict.

## Technical Architecture
The report logic looks at requests where the `PHASE_CODE` was 'P' (Pending) and analyzes the CRM logs or infers conflicts based on the `FND_CONCURRENT_PROGRAM_SERIAL` rules and execution timestamps of overlapping requests.

## Parameters & Filtering
*   **Program Name:** Filter for the program that was blocked.
*   **Date Range:** Analyze conflicts within a specific window.

## Performance & Optimization
*   **Complex Logic:** Determining conflicts retrospectively is complex. The report uses heuristic logic to match blocked requests with potential blockers.
*   **History:** Only works for requests that are still in the `FND_CONCURRENT_REQUESTS` table (not purged).

## FAQ
*   **Q: Does it show Request Set conflicts?**
    *   A: As noted in the description, it focuses on individual program conflicts and may not fully capture complex Request Set incompatibilities.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-request-conflicts)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
