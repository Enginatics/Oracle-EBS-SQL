---
layout: default
last_modified_at: 2026-10-26
title: 'DBA Tablespace Usage | Oracle EBS SQL Report'
description: 'Tablespace usage including currently active undo and temp tablepace usage in Megabytes'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Tablespace, Usage, v$sort_segment, dba_tablespaces, v$parameter'
permalink: /DBA%20Tablespace%20Usage/
report_name: 'DBA Tablespace Usage'
report_web_name: dba-tablespace-usage
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Tablespace Usage – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-tablespace-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Tablespace usage including currently active undo and temp tablepace usage in Megabytes

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[v$sort_segment](https://www.enginatics.com/library/?pg=1&find=v%24sort_segment&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage), [dba_tablespaces](https://www.enginatics.com/library/?pg=1&find=dba_tablespaces&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage), [dba_tablespace_usage_metrics](https://www.enginatics.com/library/?pg=1&find=dba_tablespace_usage_metrics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage), [dba_data_files](https://www.enginatics.com/library/?pg=1&find=dba_data_files&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage), [dba_temp_files](https://www.enginatics.com/library/?pg=1&find=dba_temp_files&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage), [dba_undo_extents](https://www.enginatics.com/library/?pg=1&find=dba_undo_extents&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage)

## Related Reports
[DBA Data Files](/DBA%20Data%20Files/ "DBA Data Files Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Tablespace Usage](/DBA%20AWR%20Tablespace%20Usage/ "DBA AWR Tablespace Usage Oracle EBS SQL Report"), [Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA Undo Statistics](/DBA%20Undo%20Statistics/ "DBA Undo Statistics Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Tablespace%20Usage/DBA%20Tablespace%20Usage.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Tablespace Usage 09-Mar-2021 101632.xlsx](https://www.enginatics.com/example/dba-tablespace-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage) |
| Blitz Report™ XML Import | [DBA_Tablespace_Usage.xml](https://www.enginatics.com/xml/dba-tablespace-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage) |
| SQL Source | [DBA Tablespace Usage.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Tablespace%20Usage/DBA%20Tablespace%20Usage.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-tablespace-usage/](https://www.enginatics.com/reports/dba-tablespace-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-tablespace-usage)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
