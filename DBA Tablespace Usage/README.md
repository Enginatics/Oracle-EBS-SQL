---
layout: default
title: 'DBA Tablespace Usage | Oracle EBS SQL Report'
description: 'Tablespace usage including currently active undo and temp tablepace usage in Megabytes'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Tablespace, Usage, v$sort_segment, dba_tablespaces, v$parameter'
permalink: /DBA%20Tablespace%20Usage/
---

# DBA Tablespace Usage – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-tablespace-usage/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Tablespace usage including currently active undo and temp tablepace usage in Megabytes

## Report Parameters


## Oracle EBS Tables Used
[v$sort_segment](https://www.enginatics.com/library/?pg=1&find=v$sort_segment), [dba_tablespaces](https://www.enginatics.com/library/?pg=1&find=dba_tablespaces), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v$parameter), [dba_tablespace_usage_metrics](https://www.enginatics.com/library/?pg=1&find=dba_tablespace_usage_metrics), [dba_data_files](https://www.enginatics.com/library/?pg=1&find=dba_data_files), [dba_temp_files](https://www.enginatics.com/library/?pg=1&find=dba_temp_files), [dba_undo_extents](https://www.enginatics.com/library/?pg=1&find=dba_undo_extents)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Tablespace Usage](/DBA%20AWR%20Tablespace%20Usage/ "DBA AWR Tablespace Usage Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA SGA Buffer Cache Object Usage](/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/ "DBA SGA Buffer Cache Object Usage Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Tablespace Usage 09-Mar-2021 101632.xlsx](https://www.enginatics.com/example/dba-tablespace-usage/) |
| Blitz Report™ XML Import | [DBA_Tablespace_Usage.xml](https://www.enginatics.com/xml/dba-tablespace-usage/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-tablespace-usage/](https://www.enginatics.com/reports/dba-tablespace-usage/) |

## Case Study & Technical Analysis

### Abstract
The **DBA Tablespace Usage** report is the primary instrument for storage capacity planning and monitoring. It provides a unified view of space utilization across all types of tablespaces: Permanent (Data/Index), Temporary (Sort/Hash), and Undo (Rollback). By calculating the "Used" vs. "Allocated" vs. "Max Size" (autoextend), it gives a true picture of remaining capacity.

### Technical Analysis

#### Core Logic
*   **Permanent Tablespaces**: usage is calculated based on extent allocation in `DBA_DATA_FILES`.
*   **Temp Tablespaces**: Usage is dynamic, based on `V$SORT_SEGMENT` or `DBA_TEMP_FILES`.
*   **Undo Tablespaces**: Usage is based on active vs. expired extents in `DBA_UNDO_EXTENTS`.

#### Key Views
*   `DBA_TABLESPACE_USAGE_METRICS`: A convenient view that pre-calculates usage percentages, accounting for auto-extensibility.
*   `DBA_DATA_FILES` / `DBA_TEMP_FILES`: Physical file definitions.

#### Operational Use Cases
*   **Alerting**: "Alert me when the `APPS_TS_TX_DATA` tablespace is 90% full."
*   **Cleanup**: Identifying tablespaces that are unexpectedly filling up due to unpurged interface tables.
*   **Undo Sizing**: Monitoring if the Undo tablespace is large enough to support the `UNDO_RETENTION` period without "Snapshot too old" errors.


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
