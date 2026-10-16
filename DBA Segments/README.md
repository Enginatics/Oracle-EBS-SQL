---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Segments | Oracle EBS SQL Report'
description: 'Database segments such as tables, indexes, lob segments by size and total database size summary'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Segments, dba_segments, dba_indexes, dba_lobs'
permalink: /DBA%20Segments/
report_name: 'DBA Segments'
report_web_name: dba-segments
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Segments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-segments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Database segments such as tables, indexes, lob segments by size and total database size summary

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Segment Name like, Segment Type, Table Name, Tablespace Name, Owner, Size bigger than x MB, Group by

## Oracle EBS Tables Used
[dba_segments](https://www.enginatics.com/library/?pg=1&find=dba_segments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments), [dba_indexes](https://www.enginatics.com/library/?pg=1&find=dba_indexes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments), [dba_lobs](https://www.enginatics.com/library/?pg=1&find=dba_lobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments), [dba_secondary_objects](https://www.enginatics.com/library/?pg=1&find=dba_secondary_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments)

## Related Reports
[DBA Index Columns](/DBA%20Index%20Columns/ "DBA Index Columns Oracle EBS SQL Report"), [DBA Objects](/DBA%20Objects/ "DBA Objects Oracle EBS SQL Report"), [DBA SGA Buffer Cache Object Usage](/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/ "DBA SGA Buffer Cache Object Usage Oracle EBS SQL Report"), [DBA Dependencies (uses)](/DBA%20Dependencies%20%28uses%29/ "DBA Dependencies (uses) Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Segments/DBA%20Segments.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Segments 22-Dec-2025 084642.xlsx](https://www.enginatics.com/example/dba-segments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments) |
| Blitz Report™ XML Import | [DBA_Segments.xml](https://www.enginatics.com/xml/dba-segments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments) |
| SQL Source | [DBA Segments.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Segments/DBA%20Segments.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-segments/](https://www.enginatics.com/reports/dba-segments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments) |

## Case Study & Technical Analysis

### Abstract
The **DBA Segments** report is a fundamental storage analysis tool used to visualize space consumption within the Oracle database. It aggregates data at the segment level—covering tables, indexes, LOBs, and partitions—to identify the largest objects and their growth patterns. This analysis is critical for capacity planning, reclaiming wasted space, and managing tablespace quotas.

### Technical Analysis

#### Core Components
*   **Segment Classification**: Categorizes storage by type (TABLE, INDEX, LOBSEGMENT, TABLE PARTITION, etc.).
*   **Size Metrics**: Reports physical space allocated (bytes/blocks) versus actual space used, helping to identify fragmentation or "high water mark" issues.
*   **Ownership & Location**: Maps segments to their owners (schemas) and tablespaces.

#### Key Views
*   `DBA_SEGMENTS`: The primary source for storage allocation data.
*   `DBA_INDEXES`: Used to correlate index segments with their parent tables.
*   `DBA_LOBS`: Links LOB segments (which often have system-generated names) back to their parent table and column.
*   `DBA_SECONDARY_OBJECTS`: Handles secondary objects like domain indexes.

#### Operational Use Cases
*   **Top N Analysis**: Identifying the top 10 or 20 largest objects in the database to focus tuning or archiving efforts.
*   **Growth Monitoring**: Tracking segment size changes over time to forecast storage requirements.
*   **Cleanup**: Finding temporary or "backup" tables (e.g., `EMP_BKP_2023`) that are consuming space unnecessarily.
*   **LOB Management**: Specifically analyzing Large Object storage, which can often grow uncontrollably if not monitored.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-segments)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
