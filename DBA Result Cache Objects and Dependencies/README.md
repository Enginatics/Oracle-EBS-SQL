---
layout: default
title: 'DBA Result Cache Objects and Dependencies | Oracle EBS SQL Report'
description: 'Shows result cache objects with the current number cached results and their dependency on objects causing the most frequent invalidations. Warning !!!…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Result, Cache, Objects, gv$result_cache_objects, gv$result_cache_dependency, dba_objects'
permalink: /DBA%20Result%20Cache%20Objects%20and%20Dependencies/
---

# DBA Result Cache Objects and Dependencies – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-result-cache-objects-and-dependencies/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Shows result cache objects with the current number cached results and their dependency on objects causing the most frequent invalidations.

Warning !!!
Don't run this on a prod system during business hours as prior to DB version 12.2, selecting from v$result_cache_objects apparently blocks all result cache objects (see note 2143739.1, section 4.).
You may end up with all server sessions waiting on 'latch free' for 'Result Cache: RC Latch' while the report is running.

## Report Parameters
Show Dependencies, I have read the warning

## Oracle EBS Tables Used
[gv$result_cache_objects](https://www.enginatics.com/library/?pg=1&find=gv$result_cache_objects), [gv$result_cache_dependency](https://www.enginatics.com/library/?pg=1&find=gv$result_cache_dependency), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA Result Cache Statistics](/DBA%20Result%20Cache%20Statistics/ "DBA Result Cache Statistics Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Buffer Cache Object Usage](/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/ "DBA SGA Buffer Cache Object Usage Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Result Cache Objects and Dependencies 23-Dec-2024 112646.xlsx](https://www.enginatics.com/example/dba-result-cache-objects-and-dependencies/) |
| Blitz Report™ XML Import | [DBA_Result_Cache_Objects_and_Dependencies.xml](https://www.enginatics.com/xml/dba-result-cache-objects-and-dependencies/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-result-cache-objects-and-dependencies/](https://www.enginatics.com/reports/dba-result-cache-objects-and-dependencies/) |

## Case Study & Technical Analysis

### Abstract
The **DBA Result Cache Objects and Dependencies** report provides a deep dive into the contents of the Oracle Server Result Cache. It maps cached result sets to their underlying database objects and tracks dependencies. This visibility is crucial for diagnosing cache invalidation storms, where frequent updates to a dependency table cause the result cache to constantly flush and reload, potentially degrading performance instead of improving it.

### Technical Analysis

#### Core Components
*   **Cache Inventory**: Lists individual result sets currently stored in the result cache memory.
*   **Dependency Mapping**: Links cached results to the specific database objects (tables, views) they rely on.
*   **Invalidation Metrics**: Highlights objects that trigger frequent cache invalidations.

#### Critical Warning
**Performance Impact**: On Oracle Database versions prior to 12.2, querying `v$result_cache_objects` can acquire a latch that blocks other sessions from accessing the result cache. This can lead to a system-wide hang or severe contention on the 'Result Cache: RC Latch' wait event.
*   **Recommendation**: Avoid running this report on production systems during peak business hours unless on a modern database version where this latching behavior is optimized.

#### Key Views
*   `GV$RESULT_CACHE_OBJECTS`: The primary view for listing cached artifacts.
*   `GV$RESULT_CACHE_DEPENDENCY`: Resolves the many-to-many relationships between cached results and database objects.
*   `DBA_OBJECTS`: Provides metadata (owner, object name, type) for the dependencies.

#### Operational Use Cases
*   **Cache Tuning**: Identifying which queries are consuming the most cache space.
*   **Invalidation Analysis**: Determining if a specific table is too volatile to be part of a result cached query.
*   **Application Debugging**: Verifying that expected results are actually being cached by the application logic.


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
