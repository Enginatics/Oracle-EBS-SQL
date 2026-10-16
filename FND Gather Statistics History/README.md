---
layout: default
last_modified_at: 2026-10-16
title: 'FND Gather Statistics History | Oracle EBS SQL Report'
description: 'History of Oracle EBS statistics gathering (FNDSTATS) per schema, table, index or column, with start time, end time and duration. Gather Schema Statistics…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Gather, Statistics, History, fnd_concurrent_requests, fnd_concurrent_programs_vl, fnd_stats_hist'
permalink: /FND%20Gather%20Statistics%20History/
report_name: 'FND Gather Statistics History'
report_web_name: fnd-gather-statistics-history
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Gather Statistics History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-gather-statistics-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
History of Oracle EBS statistics gathering (FND_STATS) per schema, table, index or column, with start time, end time and duration.

Gather Schema Statistics and Gather Table Statistics record their runs here. With the default history mode Last Run, each object keeps only its latest gathering.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Start Date From, Start Date To, Schema, Object Type, Object Name like, Request Id, Duration Minutes From

## Oracle EBS Tables Used
[fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history), [fnd_stats_hist](https://www.enginatics.com/library/?pg=1&find=fnd_stats_hist&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history)

## Related Reports
[Blitz Report Custom Reports Converter](/Blitz%20Report%20Custom%20Reports%20Converter/ "Blitz Report Custom Reports Converter Oracle EBS SQL Report"), [ECC Admin - Concurrent Programs](/ECC%20Admin%20-%20Concurrent%20Programs/ "ECC Admin - Concurrent Programs Oracle EBS SQL Report"), [FND Concurrent Managers](/FND%20Concurrent%20Managers/ "FND Concurrent Managers Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [FND Concurrent Requests Summary](/FND%20Concurrent%20Requests%20Summary/ "FND Concurrent Requests Summary Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [FND Concurrent Request Conflicts](/FND%20Concurrent%20Request%20Conflicts/ "FND Concurrent Request Conflicts Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Gather%20Statistics%20History/FND%20Gather%20Statistics%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Gather Statistics History 12-Oct-2026 061641.xlsx](https://www.enginatics.com/example/fnd-gather-statistics-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history) |
| Blitz Report™ XML Import | [FND_Gather_Statistics_History.xml](https://www.enginatics.com/xml/fnd-gather-statistics-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history) |
| SQL Source | [FND Gather Statistics History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Gather%20Statistics%20History/FND%20Gather%20Statistics%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-gather-statistics-history/](https://www.enginatics.com/reports/fnd-gather-statistics-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history) |

## Case Study & Technical Analysis: FND Gather Statistics History

### Executive Summary
The FND Gather Statistics History report shows the history of Oracle E-Business Suite statistics gathering (FNDSTATS) for each schema, table, index or column. For every gathering it gives the start time, end time, duration, estimate percentage, degree of parallelism and the concurrent request that performed it. DBAs and application support teams use it to confirm that statistics jobs completed, to spot gatherings that have become slow, and to decide when a schema or table needs fresh statistics before a performance investigation or a period-end run. The report runs in Excel via Blitz Report.

### Business Challenge
*   **Verifying statistics jobs:** Gather Schema Statistics and Gather Table Statistics runs must be confirmed as completed for the objects that matter to close and reporting processes.
*   **Diagnosing slow gatherings:** A gathering that takes longer than usual can point to growth in a schema or to a parallelism setting that has changed, and the history is needed to see the trend.
*   **Tracing to the request:** When a gathering needs investigation, the owning concurrent request and program must be identified quickly.
*   **Keeping history manageable:** Histories of frequently gathered objects grow large, and users need to see the latest gathering per object without losing the ability to review all runs.

### The Solution
*   **Per-object timing:** Start time, end time, duration in readable form and duration in seconds are shown for every gathering record.
*   **Run identification:** The concurrent request identifier is returned, together with the name of the concurrent program that made the request.
*   **Object and run filters:** The report can be restricted by schema, object type, object name pattern, request identifier, start date range and minimum duration.
*   **Recent first:** Records are ordered by start time, descending, so the latest gatherings appear first.

### Technical Architecture (High Level)
#### Primary Tables
*   `FND_STATS_HIST`: one row per gathered object, with schema, object type, object name, partition, column table, last gather start and end times, estimate percentage, parallel setting and request identifier.
*   `FND_CONCURRENT_REQUESTS`: the concurrent request that performed the gathering.
*   `FND_CONCURRENT_PROGRAMS_VL`: the translated name of the concurrent program for that request.

#### Logical Relationships
1. Each `FND_STATS_HIST` row is one gathering of one object, identified by schema, object type and object name.
2. The concurrent program name is found by a correlated subquery that matches `FND_STATS_HIST.REQUEST_ID` to `FND_CONCURRENT_REQUESTS`.
3. The request's program application and concurrent program identifiers are matched to `FND_CONCURRENT_PROGRAMS_VL` to return the user concurrent program name.
4. Records are returned at the level of the statistics history table, with no further joins to the data dictionary.

### Parameters & Filtering
*   **Start Date From and Start Date To:** Bound the gathering start time to a date range, using the client time zone.
*   **Schema:** Limits the output to one schema owner.
*   **Object Type:** Limits the output to one type of object, such as a table or an index.
*   **Object Name like:** Filters object names by a pattern.
*   **Request Id:** Returns the gatherings performed by one concurrent request.
*   **Duration Minutes From:** Returns only gatherings whose duration is at least the entered number of minutes.

The description notes that the history mode Last Run keeps only the latest gathering per object. Gather Schema Statistics and Gather Table Statistics record their runs in this table.

### Performance & Optimization
*   The query reads only `FND_STATS_HIST`, and the concurrent program name is resolved by a correlated subquery that runs once per returned row, so the number of returned rows drives the cost.
*   Filters on schema, object name and start date narrow the history before the ordering step.
*   The ordering by start time, schema and object name uses the sort step of the query, so large histories should be restricted with the start date and request identifier filters.
*   Durations are computed as date differences multiplied by 86400, a simple arithmetic conversion with no additional lookups.

### FAQ
**Q: How do I check when a schema's statistics were last gathered?**
A: Filter by the Schema parameter and read the start and end times on each row; the most recent gathering appears first.

**Q: Which concurrent program gathered statistics for a given object?**
A: The Concurrent Program column shows the program name for the request identifier recorded against each gathering.

**Q: How do I find statistics gatherings that took longer than an hour?**
A: Set Duration Minutes From to 60 and review the Duration column for the matching gatherings.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-gather-statistics-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
