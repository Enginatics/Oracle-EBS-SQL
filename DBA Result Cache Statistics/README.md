---
layout: default
title: 'DBA Result Cache Statistics | Oracle EBS SQL Report'
description: 'Result cache statistics with size values in MB. If the ''Maximum Size'' is big enough, ''Create Count Failure'' should be zero or low, same as ''Delete Count…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Result, Cache, Statistics, gv$result_cache_statistics'
permalink: /DBA%20Result%20Cache%20Statistics/
---

# DBA Result Cache Statistics – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-result-cache-statistics/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Result cache statistics with size values in MB.

If the 'Maximum Size' is big enough, 'Create Count Failure' should be zero or low, same as 'Delete Count Valid', which depicts the number of valid cache results flushed out.
'Find Count' shows the number of cached results used (instead of executing the underlying sql/plsql) and should hence be as high as possible for maximum performance improvement.

A high number of 'Invalidation Count' or 'Delete Count Invalid' relative to 'Find Count' should get investigated further as it indicates a result_cache specified for code where the underlying data changes too frequently.

alter system set result_cache_max_size=600M scope=both

## Report Parameters


## Oracle EBS Tables Used
[gv$result_cache_statistics](https://www.enginatics.com/library/?pg=1&find=gv$result_cache_statistics)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA Result Cache Objects and Dependencies](/DBA%20Result%20Cache%20Objects%20and%20Dependencies/ "DBA Result Cache Objects and Dependencies Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report"), [DBA Feature Usage Statistics](/DBA%20Feature%20Usage%20Statistics/ "DBA Feature Usage Statistics Oracle EBS SQL Report"), [FND Concurrent Managers](/FND%20Concurrent%20Managers/ "FND Concurrent Managers Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Result Cache Statistics 18-Jan-2018 225229.xlsx](https://www.enginatics.com/example/dba-result-cache-statistics/) |
| Blitz Report™ XML Import | [DBA_Result_Cache_Statistics.xml](https://www.enginatics.com/xml/dba-result-cache-statistics/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-result-cache-statistics/](https://www.enginatics.com/reports/dba-result-cache-statistics/) |

## Case Study & Technical Analysis

### Abstract
The **DBA Result Cache Statistics** report offers a high-level overview of the health and efficiency of the Oracle Server Result Cache. Unlike the object-level detail report, this analysis focuses on global statistics such as total memory usage, hit/miss ratios, and invalidation counts. It is the primary tool for sizing the result cache and determining if the feature is providing a net benefit to the database workload.

### Technical Analysis

#### Key Metrics
*   **Create Count Failure**: Indicates if the cache is too small to accommodate new results. A non-zero value suggests `RESULT_CACHE_MAX_SIZE` may need to be increased.
*   **Find Count**: Represents cache hits. A high value indicates the cache is effectively serving data from memory, bypassing SQL execution.
*   **Invalidation Count**: The number of times cached results were purged due to data changes. High invalidation rates relative to find counts suggest that the result cache is being used on volatile data, which is an anti-pattern.
*   **Delete Count Valid**: Results flushed due to LRU (Least Recently Used) pressure, further indicating potential sizing issues.

#### Configuration Context
The report helps validate the setting of the initialization parameter:
```sql
alter system set result_cache_max_size=600M scope=both;
```
If the allocated memory is consistently full and valid results are being evicted, increasing this parameter may yield performance gains.

#### Key View
*   `GV$RESULT_CACHE_STATISTICS`: Provides the global counters for the result cache subsystem across all RAC instances.

#### Operational Use Cases
*   **Capacity Planning**: determining the optimal memory allocation for the result cache.
*   **Efficiency Monitoring**: Calculating the "Hit Ratio" of the result cache.
*   **Workload Characterization**: Understanding if the workload is read-mostly (good for caching) or write-intensive (bad for caching).


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
