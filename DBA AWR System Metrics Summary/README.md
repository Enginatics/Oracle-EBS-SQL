---
layout: default
last_modified_at: 2026-10-16
title: 'DBA AWR System Metrics Summary | Oracle EBS SQL Report'
description: 'Historic system statistics from the automated workload repository showing CPU load, wait time percentage, logical (buffer/RAM) and physical read and write…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, AWR, System, Metrics, gv$system_parameter, v$parameter, dba_hist_snapshot'
permalink: /DBA%20AWR%20System%20Metrics%20Summary/
report_name: 'DBA AWR System Metrics Summary'
report_web_name: dba-awr-system-metrics-summary
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA AWR System Metrics Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-system-metrics-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Historic system statistics from the automated workload repository showing CPU load, wait time percentage, logical (buffer/RAM) and physical read and write IO figures, summarized in snapshot time intervals. All IO figures are measured in MB/s.

-CPU%: Total CPU usage percentage. If this is low, the hardware is underused and performance could potentially get improved by using it better e.g. by resolving IO bottlenecks (bigger RAM, faster storage) or parallelization of SQLs and user processes.
-WAIT%: Percentage of time that the DB process spends waiting rather than processing. If the wait% is high and most of the wait time is spend e.g. waiting for IO, then the storage is too slow compared to CPU speed.
-BUFF_READ: Logical IO read from the buffer cache (RAM) in MB/s
-PHYS_READ: Physical IO read from the storage in MB/s
-PHYS_WRITE:  Physical IO written to the storage in MB/s

Note: The UOM calculation from LIOs to MB uses the database default block size and doesn't support different block sizes for different tablespaces.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Date From, Date To, Show Daily Averages, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[gv$system_parameter](https://www.enginatics.com/library/?pg=1&find=gv%24system_parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary), [dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [DBA AWR PGA History](/DBA%20AWR%20PGA%20History/ "DBA AWR PGA History Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA SGA SQL Execution Plan History](/DBA%20SGA%20SQL%20Execution%20Plan%20History/ "DBA SGA SQL Execution Plan History Oracle EBS SQL Report"), [DBA SGA Buffer Cache Object Usage](/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/ "DBA SGA Buffer Cache Object Usage Oracle EBS SQL Report"), [DBA AWR SQL Execution Plan History](/DBA%20AWR%20SQL%20Execution%20Plan%20History/ "DBA AWR SQL Execution Plan History Oracle EBS SQL Report"), [DBA AWR Tablespace Usage](/DBA%20AWR%20Tablespace%20Usage/ "DBA AWR Tablespace Usage Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20System%20Metrics%20Summary/DBA%20AWR%20System%20Metrics%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR System Metrics Summary 13-Jul-2018 173115.xlsx](https://www.enginatics.com/example/dba-awr-system-metrics-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary) |
| Blitz Report™ XML Import | [DBA_AWR_System_Metrics_Summary.xml](https://www.enginatics.com/xml/dba-awr-system-metrics-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary) |
| SQL Source | [DBA AWR System Metrics Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20System%20Metrics%20Summary/DBA%20AWR%20System%20Metrics%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-awr-system-metrics-summary/](https://www.enginatics.com/reports/dba-awr-system-metrics-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary) |

## Executive Summary
The **DBA AWR System Metrics Summary** report provides a high-level dashboard of the database's vital signs over time. It summarizes key system-wide metrics like CPU Load, Wait Percentage, and I/O Throughput (MB/s). This report is ideal for spotting trends, identifying peak load windows, and correlating system behavior with user complaints.

## Business Challenge
*   **Health Check**: "Is the database healthy right now? How does it compare to last week?"
*   **Bottleneck Identification**: "Are we CPU bound (high CPU%) or I/O bound (high Wait% and Phys Read)?"
*   **Throughput Analysis**: "What is our peak I/O throughput? Do we need a faster SAN?"

## Solution
This report aggregates system metrics from AWR snapshots.

**Key Features:**
*   **CPU %**: Total CPU utilization.
*   **Wait %**: Percentage of time sessions spent waiting.
*   **I/O Metrics**: Buffer Read (Logical), Physical Read, and Physical Write in MB/s.
*   **Snapshot Granularity**: Shows how these metrics evolve hour by hour.

## Architecture
The report queries `DBA_HIST_SYSMETRIC_SUMMARY` (or similar views depending on version).

**Key Tables:**
*   `DBA_HIST_SYSMETRIC_SUMMARY`: Summarized system metrics.
*   `DBA_HIST_SNAPSHOT`: Snapshot timing.

## Impact
*   **Executive Reporting**: Provides simple, understandable charts for management (e.g., "CPU usage is up 20% year-over-year").
*   **Proactive Sizing**: Helps predict when the system will hit hardware limits.
*   **Incident Correlation**: Helps correlate "slow system" tickets with actual server load metrics.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-metrics-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
