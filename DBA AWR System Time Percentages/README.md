---
layout: default
last_modified_at: 2026-10-16
title: 'DBA AWR System Time Percentages | Oracle EBS SQL Report'
description: 'Historic system time model values from the automated workload repository showing a breakdown of how much percent of the database time was spent e.g. on…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, AWR, System, Time, dba_hist_snapshot'
permalink: /DBA%20AWR%20System%20Time%20Percentages/
report_name: 'DBA AWR System Time Percentages'
report_web_name: dba-awr-system-time-percentages
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA AWR System Time Percentages – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-system-time-percentages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Historic system time model values from the automated workload repository showing a breakdown of how much percent of the database time was spent e.g. on excuting SQL, PL/SQL or Java code, parsing statements etc..

To see data in this report based on dba_hist_sys_time_model, set the following:
alter session set container=PDB1;
alter system set awr_pdb_autoflush_enabled=true;

<a href="https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages" rel="nofollow" target="_blank">https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Date From, Date To, Time Split, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Latch by Time](/DBA%20AWR%20Latch%20by%20Time/ "DBA AWR Latch by Time Oracle EBS SQL Report"), [DBA AWR Latch Summary](/DBA%20AWR%20Latch%20Summary/ "DBA AWR Latch Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report"), [DBA AWR Wait Class by Time](/DBA%20AWR%20Wait%20Class%20by%20Time/ "DBA AWR Wait Class by Time Oracle EBS SQL Report"), [DBA AWR System Time Summary](/DBA%20AWR%20System%20Time%20Summary/ "DBA AWR System Time Summary Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20System%20Time%20Percentages/DBA%20AWR%20System%20Time%20Percentages.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR System Time Percentages 22-Dec-2025 083614.xlsx](https://www.enginatics.com/example/dba-awr-system-time-percentages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages) |
| Blitz Report™ XML Import | [DBA_AWR_System_Time_Percentages.xml](https://www.enginatics.com/xml/dba-awr-system-time-percentages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages) |
| SQL Source | [DBA AWR System Time Percentages.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20System%20Time%20Percentages/DBA%20AWR%20System%20Time%20Percentages.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-awr-system-time-percentages/](https://www.enginatics.com/reports/dba-awr-system-time-percentages/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages) |

## Executive Summary
The **DBA AWR System Time Percentages** report provides a proportional breakdown of how the database spends its time. Instead of raw seconds, it shows percentages (e.g., "80% SQL Execution, 10% Parsing, 5% PL/SQL"). This is crucial for understanding the *nature* of the workload. For example, a system spending 40% of its time on "Hard Parse" indicates a code quality issue (lack of bind variables), whereas 90% "SQL Execution" suggests a need for SQL tuning or more hardware.

## Business Challenge
*   **Workload Characterization**: "Is our system mostly doing calculation (CPU) or waiting for data (I/O)?"
*   **Code Quality Audit**: "Are we wasting resources on overhead tasks like parsing and connection management?"
*   **Tuning Focus**: "Should we focus on optimizing PL/SQL loops or SQL queries?"

## Solution
This report calculates the percentage contribution of each time model statistic to the total DB Time.

**Key Features:**
*   **SQL Execution Time %**: Time spent actually running queries.
*   **Parse Time %**: Time spent compiling SQL (Hard vs. Soft).
*   **PL/SQL Execution Time %**: Time spent in procedural logic.
*   **Connection Management %**: Time spent logging on/off.

## Architecture
The report queries `DBA_HIST_SYS_TIME_MODEL`.

**Key Tables:**
*   `DBA_HIST_SYS_TIME_MODEL`: Historical time model statistics.

## Impact
*   **Strategic Tuning**: Directs tuning efforts to the area with the biggest potential ROI (e.g., fixing parsing issues can double throughput).
*   **Application Profiling**: Helps developers understand the behavior of their application code.
*   **Anomaly Detection**: A sudden spike in "Sequence Load" or "Failed Parse" indicates a specific application bug.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-system-time-percentages)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
