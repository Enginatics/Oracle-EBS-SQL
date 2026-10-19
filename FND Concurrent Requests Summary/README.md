---
layout: default
last_modified_at: 2026-10-19
title: 'FND Concurrent Requests Summary | Oracle EBS SQL Report'
description: 'Concurrent programs sorted by the sum of their historic execution times – Oracle EBS Application Object Library SQL report: free SQL, parameters and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Concurrent, Requests, Summary, fnd_concurrent_requests, fnd_concurrent_programs_vl, fnd_user'
permalink: /FND%20Concurrent%20Requests%20Summary/
report_name: 'FND Concurrent Requests Summary'
report_web_name: fnd-concurrent-requests-summary
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Concurrent Requests Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-concurrent-requests-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Concurrent programs sorted by the sum of their historic execution times

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Started within Days, Running from Date, Running to Date, Program Name, System Program Name, Executable Short Name, Execution Method, Show Argument Text, Show Reports only

## Oracle EBS Tables Used
[fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary), [fnd_executables](https://www.enginatics.com/library/?pg=1&find=fnd_executables&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary)

## Related Reports
[ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [Blitz Report Custom Reports Converter](/Blitz%20Report%20Custom%20Reports%20Converter/ "Blitz Report Custom Reports Converter Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [XDO Publisher Data Definitions](/XDO%20Publisher%20Data%20Definitions/ "XDO Publisher Data Definitions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Concurrent%20Requests%20Summary/FND%20Concurrent%20Requests%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Concurrent Requests Summary 15-Oct-2023 092431.xlsx](https://www.enginatics.com/example/fnd-concurrent-requests-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary) |
| Blitz Report™ XML Import | [FND_Concurrent_Requests_Summary.xml](https://www.enginatics.com/xml/fnd-concurrent-requests-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary) |
| SQL Source | [FND Concurrent Requests Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Concurrent%20Requests%20Summary/FND%20Concurrent%20Requests%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-concurrent-requests-summary/](https://www.enginatics.com/reports/fnd-concurrent-requests-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-concurrent-requests-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
