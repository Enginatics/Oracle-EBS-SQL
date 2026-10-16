---
layout: default
last_modified_at: 2026-10-16
title: 'DBA SGA Buffer Cache Object Usage | Oracle EBS SQL Report'
description: 'SGA buffer cache space usage by object names (in MB). ''Object Percentage'' shows how much of one particular object is currently stored in the buffer cache…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, SGA, Buffer, Cache, gv$bh, dba_objects, dba_segments'
permalink: /DBA%20SGA%20Buffer%20Cache%20Object%20Usage/
report_name: 'DBA SGA Buffer Cache Object Usage'
report_web_name: dba-sga-buffer-cache-object-usage
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA SGA Buffer Cache Object Usage – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sga-buffer-cache-object-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

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

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Show Block Status

## Oracle EBS Tables Used
[gv$bh](https://www.enginatics.com/library/?pg=1&find=gv%24bh&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage), [dba_segments](https://www.enginatics.com/library/?pg=1&find=dba_segments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage)

## Related Reports
[DBA SGA SQL Execution Plan History](/DBA%20SGA%20SQL%20Execution%20Plan%20History/ "DBA SGA SQL Execution Plan History Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/DBA%20SGA%20Buffer%20Cache%20Object%20Usage.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SGA Buffer Cache Object Usage 05-Apr-2020 014325.xlsx](https://www.enginatics.com/example/dba-sga-buffer-cache-object-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage) |
| Blitz Report™ XML Import | [DBA_SGA_Buffer_Cache_Object_Usage.xml](https://www.enginatics.com/xml/dba-sga-buffer-cache-object-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage) |
| SQL Source | [DBA SGA Buffer Cache Object Usage.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/DBA%20SGA%20Buffer%20Cache%20Object%20Usage.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-sga-buffer-cache-object-usage/](https://www.enginatics.com/reports/dba-sga-buffer-cache-object-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-buffer-cache-object-usage)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
