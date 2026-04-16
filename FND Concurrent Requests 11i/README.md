---
layout: default
title: 'FND Concurrent Requests 11i | Oracle EBS SQL Report'
description: 'Running, scheduled and historic concurrent requests including phase, status, parameters, schedule, timing, delivery and output option information. For…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Concurrent, Requests, 11i, fnd_profile_option_values'
permalink: /FND%20Concurrent%20Requests%2011i/
---

# FND Concurrent Requests 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-concurrent-requests-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Running, scheduled and historic concurrent requests including phase, status, parameters, schedule, timing, delivery and output option information.
For performance analysis of running requests, the report contains sid, currently executed sql_id and sql_text and distribution of wait time on different wait classes.

Use parameter 'Scheduled or Running' to get a list of all currently scheduled or running requests.

## Report Parameters
Concurrent Program Name, Concurrent Progr. (all languages), Concurrent Program Short Name, Request Id, Requested By, Started within Days, Scheduled or Running, Waiting for x Minutes, Running longer than x Minutes, Phase, Status, Show Parameters Display Values, Show BI Pub & Delivery Options, Show active session SQL Text, Parameter Text contains, Request Set Name, Execution Method, Executable Short Name, Running from Timestamp, Running to Timestamp, Requested Start Date From, Requested Start Date To, Node, Manager Name, Operating Unit, Exclude Conc Program Name, Incremental Alert Mode

## Oracle EBS Tables Used
[fnd_profile_option_values](https://www.enginatics.com/library/?pg=1&find=fnd_profile_option_values)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Concurrent Requests 11i 22-Jul-2020 121122.xlsx](https://www.enginatics.com/example/fnd-concurrent-requests-11i/) |
| Blitz Report™ XML Import | [FND_Concurrent_Requests_11i.xml](https://www.enginatics.com/xml/fnd-concurrent-requests-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-concurrent-requests-11i/](https://www.enginatics.com/reports/fnd-concurrent-requests-11i/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
