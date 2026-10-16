---
layout: default
last_modified_at: 2026-10-16
title: 'FND Concurrent Requests | Oracle EBS SQL Report'
description: 'Running, scheduled and historic concurrent requests including phase, status, parameters, schedule, timing, delivery and output option information. For…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Concurrent, Requests, fnd_profile_option_values, fnd_concurrent_requests, fnd_concurrent_processes'
permalink: /FND%20Concurrent%20Requests/
report_name: 'FND Concurrent Requests'
report_web_name: fnd-concurrent-requests
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Concurrent Requests – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-concurrent-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Running, scheduled and historic concurrent requests including phase, status, parameters, schedule, timing, delivery and output option information.
For performance analysis of running requests, the report contains sid, currently executed sql_id and sql_text and distribution of wait time on different wait classes.

Use parameter 'Scheduled or Running' to get a list of all currently scheduled or running requests.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Concurrent Program Name, Concurrent Progr. (all languages), Concurrent Program Short Name, Request Id, Requested By, Started within Days, Scheduled or Running, Waiting for x Minutes, Running longer than x Minutes, Output file larger than x MB, Log file larger than x MB, Phase, Status, Show Parameters Display Values, Show BI Pub & Delivery Options, Show Reports only, Show active session SQL Text, Parameter Text contains, Request Set Name, Execution Method, Executable Short Name, Running from Timestamp, Running to Timestamp, Requested Start Date From, Requested Start Date To, Node, Manager Name, Operating Unit, Exclude Conc Program Name, Incremental Alert Mode

## Oracle EBS Tables Used
[fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_concurrent_processes](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_processes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_concurrent_queues_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_queues_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_run_requests](https://www.enginatics.com/library/?pg=1&find=fnd_run_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_request_set_programs](https://www.enginatics.com/library/?pg=1&find=fnd_request_set_programs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_request_set_stages](https://www.enginatics.com/library/?pg=1&find=fnd_request_set_stages&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_conc_prog_onsite_info](https://www.enginatics.com/library/?pg=1&find=fnd_conc_prog_onsite_info&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_executables_vl](https://www.enginatics.com/library/?pg=1&find=fnd_executables_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_conc_release_classes](https://www.enginatics.com/library/?pg=1&find=fnd_conc_release_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_conflicts_domain](https://www.enginatics.com/library/?pg=1&find=fnd_conflicts_domain&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_conc_pp_actions](https://www.enginatics.com/library/?pg=1&find=fnd_conc_pp_actions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_cp_delivery_options](https://www.enginatics.com/library/?pg=1&find=fnd_cp_delivery_options&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_conc_req_outputs](https://www.enginatics.com/library/?pg=1&find=fnd_conc_req_outputs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [fnd_lookup_values_vl](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [gv$session](https://www.enginatics.com/library/?pg=1&find=gv%24session&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [gv$session_event](https://www.enginatics.com/library/?pg=1&find=gv%24session_event&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests), [gv$sql](https://www.enginatics.com/library/?pg=1&find=gv%24sql&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests)

## Related Reports
[FND Concurrent Programs and Executables](/FND%20Concurrent%20Programs%20and%20Executables/ "FND Concurrent Programs and Executables Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [FND Concurrent Managers](/FND%20Concurrent%20Managers/ "FND Concurrent Managers Oracle EBS SQL Report"), [PAY Payroll Process Summary](/PAY%20Payroll%20Process%20Summary/ "PAY Payroll Process Summary Oracle EBS SQL Report"), [FND Concurrent Requests Summary](/FND%20Concurrent%20Requests%20Summary/ "FND Concurrent Requests Summary Oracle EBS SQL Report"), [Blitz Report Custom Reports Converter](/Blitz%20Report%20Custom%20Reports%20Converter/ "Blitz Report Custom Reports Converter Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Concurrent%20Requests/FND%20Concurrent%20Requests.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Concurrent Requests 27-Jan-2019 140201.xlsx](https://www.enginatics.com/example/fnd-concurrent-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests) |
| Blitz Report™ XML Import | [FND_Concurrent_Requests.xml](https://www.enginatics.com/xml/fnd-concurrent-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests) |
| SQL Source | [FND Concurrent Requests.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Concurrent%20Requests/FND%20Concurrent%20Requests.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-concurrent-requests/](https://www.enginatics.com/reports/fnd-concurrent-requests/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests) |

## Case Study & Technical Analysis: FND Concurrent Requests

### Executive Summary
The FND Concurrent Requests report is the definitive operational dashboard for Oracle E-Business Suite System Administrators and Support Analysts. It provides real-time and historical visibility into the Concurrent Processing system, enabling teams to monitor system health, troubleshoot performance bottlenecks, and ensure the timely execution of critical business processes.

### Business Challenge
- **Operational Blind Spots:** Standard Oracle forms are often slow and lack the advanced filtering needed to manage high-volume environments with millions of requests.
- **Performance Troubleshooting:** Identifying the root cause of a "long-running" request usually requires separate DBA tools to check database sessions and wait events.
- **Resource Management:** Unchecked requests generating massive log or output files can silently consume disk space and degrade system performance.

### The Solution
This report bridges the gap between functional administration and technical performance monitoring.
- **Unified Monitoring:** It consolidates request status, scheduling parameters, and delivery options into a single, filterable view.
- **Real-Time Diagnostics:** For currently running requests, it exposes critical database metrics—including the active `SQL_ID`, execution text, and wait classes—allowing immediate diagnosis of "stuck" jobs.
- **Proactive Alerting:** Parameters like "Running longer than x Minutes" or "Log file larger than x MB" enable proactive identification of anomalies before they impact users.

### Technical Architecture (High Level)
- **Primary Tables:** `FND_CONCURRENT_REQUESTS`, `FND_CONCURRENT_PROGRAMS_VL`, `FND_USER`, `FND_RESPONSIBILITY_VL`.
- **Performance Views:** `GV$SESSION`, `GV$PROCESS`, `GV$SQL` (accessed dynamically for running requests).
- **Logical Relationships:**
    - The report joins the core Request table to Program, User, and Responsibility definitions to provide human-readable context.
    - For requests with `Phase = 'Running'`, it performs a left join to the database session views (`GV$SESSION`) using the `ORACLE_PROCESS_ID` (SPID) to retrieve real-time execution details.
    - It parses and decodes the raw argument string to display meaningful parameter values.

### Parameters & Filtering
- **Scheduled or Running:** A binary flag to instantly filter the list to only active or pending workloads, removing historical clutter.
- **Running longer than x Minutes:** A critical threshold filter for identifying performance outliers and potential runaways.
- **Show active session SQL Text:** When enabled, retrieves the actual SQL statement currently executing in the database for running requests.
- **Output/Log file larger than x MB:** Identifies requests that are consuming excessive file system storage.
- **Wait for x Minutes:** Highlights requests that have been in a 'Pending' state for an extended period, indicating potential manager issues.

### Performance & Optimization
- **Conditional Logic:** The report is optimized to only query heavy performance views (`GV$`) when relevant (i.e., for running requests), ensuring the report itself runs instantly.
- **Indexed Access:** Filters on `REQUEST_ID`, `REQUEST_DATE`, and `PROGRAM_ID` leverage standard EBS indexes to ensure fast retrieval of historical data.
- **Direct Output:** Bypasses the XML Publisher layer to stream data directly to Excel, capable of handling tens of thousands of rows without timeout.

### FAQ
**Q: Can I see the SQL statement for a request that has already completed?**
A: No, the "Active Session SQL Text" is retrieved from the live database session cache (`GV$SQL`). Once a request finishes and the session closes, this runtime information is no longer available in memory.

**Q: Why do some requests show a status of 'Inactive' but 'No Manager'?**
A: This usually indicates that the Concurrent Manager defined to run this specific program is not running or is busy. The report helps identify these bottlenecks by showing the 'Manager Name' and 'Node'.

**Q: Does this report show requests from all RAC nodes?**
A: Yes, it queries global views (`GV$`) to capture session information across all nodes in a Real Application Clusters (RAC) environment.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
