---
layout: default
title: 'FND Concurrent Requests Summary | Oracle EBS SQL Report'
description: 'Concurrent programs sorted by the sum of their historic execution times – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Concurrent, Requests, Summary, fnd_concurrent_requests, fnd_concurrent_programs_vl, fnd_user'
permalink: /FND%20Concurrent%20Requests%20Summary/
---

# FND Concurrent Requests Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-concurrent-requests-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Concurrent programs sorted by the sum of their historic execution times

## Report Parameters
Started within Days, Running from Date, Running to Date, Program Name, System Program Name, Executable Short Name, Execution Method, Show Argument Text, Show Reports only

## Oracle EBS Tables Used
[fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [fnd_executables](https://www.enginatics.com/library/?pg=1&find=fnd_executables), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Concurrent Requests Summary 15-Oct-2023 092431.xlsx](https://www.enginatics.com/example/fnd-concurrent-requests-summary/) |
| Blitz Report™ XML Import | [FND_Concurrent_Requests_Summary.xml](https://www.enginatics.com/xml/fnd-concurrent-requests-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-concurrent-requests-summary/](https://www.enginatics.com/reports/fnd-concurrent-requests-summary/) |

## Executive Summary
The **FND Concurrent Requests Summary** report provides a performance profile of your concurrent processing system. It aggregates historical execution data to highlight the most resource-intensive programs.

## Business Challenge
*   **Performance Tuning:** Identifying the "Top 10" programs that consume the most system time.
*   **Trend Analysis:** Seeing if specific jobs are taking longer to run over time.
*   **Housekeeping:** Finding programs that run frequently but generate no output or are cancelled often.

## The Solution
This Blitz Report aggregates data from `FND_CONCURRENT_REQUESTS`:
*   **Total Runtime:** Sums up the execution time for each program.
*   **Average Runtime:** Calculates the mean duration to establish a baseline.
*   **Execution Count:** Shows how often the program is run.

## Technical Architecture
The report groups data by `PROGRAM_APPLICATION_ID` and `CONCURRENT_PROGRAM_ID`. It calculates metrics like `SUM(ACTUAL_COMPLETION_DATE - ACTUAL_START_DATE)`.

## Parameters & Filtering
*   **Date Range:** "Started within Days" or specific dates to define the analysis period.
*   **Program Name:** Filter for specific jobs.

## Performance & Optimization
*   **Purge Impact:** The report can only analyze data currently in the request history table. If you purge requests weekly, you can only analyze the last week.
*   **Summary Level:** This is an aggregate report, so it runs fast even with large history tables.

## FAQ
*   **Q: Can I drill down to specific requests?**
    *   A: This report gives the summary. Use "FND Concurrent Requests" (Detail) to see the individual runs.
*   **Q: Does "Execution Time" include wait time?**
    *   A: No, it typically measures the time from "Actual Start" to "Actual Completion", excluding time spent in the queue.


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
