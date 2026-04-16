---
layout: default
title: 'DBA SGA Buffer Cache Object Usage | Oracle EBS SQL Report'
description: 'SGA buffer cache space usage by object names (in MB). ''Object Percentage'' shows how much of one particular object is currently stored in the buffer cache…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, SGA, Buffer, Cache, gv$bh'
permalink: /DBA%20SGA%20Buffer%20Cache%20Object%20Usage/
---

# DBA SGA Buffer Cache Object Usage – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sga-buffer-cache-object-usage/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
SGA buffer cache space usage by object names (in MB).
'Object Percentage' shows how much of one particular object is currently stored in the buffer cache.
100% means that the object is completely in the buffer cache.

Current SGA memory usage is also listed in views:
select * from v$sga
select * from v$sgainfo
select * from v$sga_dynamic_components

Arup Nanda gives a good explanation on how the buffer cache works:
<a href="http://arup.blogspot.ch/2014/11/cache-buffer-chains-demystified.html" rel="nofollow" target="_blank">http://arup.blogspot.ch/2014/11/cache-buffer-chains-demystified.html</a>

## Report Parameters
Show Block Status

## Oracle EBS Tables Used
[gv$bh](https://www.enginatics.com/library/?pg=1&find=gv$bh)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [DBA Result Cache Statistics](/DBA%20Result%20Cache%20Statistics/ "DBA Result Cache Statistics Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SGA Buffer Cache Object Usage 05-Apr-2020 014325.xlsx](https://www.enginatics.com/example/dba-sga-buffer-cache-object-usage/) |
| Blitz Report™ XML Import | [DBA_SGA_Buffer_Cache_Object_Usage.xml](https://www.enginatics.com/xml/dba-sga-buffer-cache-object-usage/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-sga-buffer-cache-object-usage/](https://www.enginatics.com/reports/dba-sga-buffer-cache-object-usage/) |

## Case Study & Technical Analysis

### Abstract
The **DBA SGA Buffer Cache Object Usage** report provides a detailed breakdown of how the Database Buffer Cache memory is being utilized. It identifies which database objects (tables, indexes, clusters) are currently resident in RAM. This insight is critical for verifying that the most frequently accessed data is being cached effectively and for identifying "cache pollution" where large, infrequently used segments are washing out critical data.

### Technical Analysis

#### Core Metrics
*   **Size (MB)**: The amount of buffer cache memory occupied by a specific object.
*   **Object Percentage**: The percentage of the object's total size that is currently cached. A value of 100% means the entire table/index is in memory.
*   **Block Status**: (Optional) Can differentiate between `xcur` (exclusive current), `scur` (shared current), and `cr` (consistent read) blocks, which is useful for RAC cache fusion analysis.

#### Key View
*   `GV$BH`: The Buffer Header view. This is a high-volume view that lists every single block currently in the buffer cache. Querying this on a busy, large-SGA system can be expensive, so use with caution.

#### Operational Use Cases
*   **Sizing Verification**: Determining if `DB_CACHE_SIZE` is adequate for the working set.
*   **Pinning Candidates**: Identifying small, hot tables that are frequently re-read and might benefit from being pinned (though less common in modern Oracle versions).
*   **Performance Tuning**: Detecting if a full table scan on a massive log table has flushed useful indexes out of the cache.
*   **RAC Analysis**: Understanding block distribution across instances in a cluster.


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
