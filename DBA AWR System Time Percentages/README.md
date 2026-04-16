---
layout: default
title: 'DBA AWR System Time Percentages | Oracle EBS SQL Report'
description: 'Historic system time model values from the automated workload repository showing a breakdown of how much percent of the database time was spent e.g. on…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, System, Time, dba_hist_snapshot, dba_hist_sys_time_model'
permalink: /DBA%20AWR%20System%20Time%20Percentages/
---

# DBA AWR System Time Percentages – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-system-time-percentages/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Historic system time model values from the automated workload repository showing a breakdown of how much percent of the database time was spent e.g. on excuting SQL, PL/SQL or Java code, parsing statements etc..

To see data in this report based on dba_hist_sys_time_model, set the following:
alter session set container=PDB1;
alter system set awr_pdb_autoflush_enabled=true;

<a href="https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/" rel="nofollow" target="_blank">https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/</a>

## Report Parameters
Date From, Date To, Time Split, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_sys_time_model](https://www.enginatics.com/library/?pg=1&find=dba_hist_sys_time_model)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA AWR System Time Summary](/DBA%20AWR%20System%20Time%20Summary/ "DBA AWR System Time Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR System Time Percentages 22-Dec-2025 083614.xlsx](https://www.enginatics.com/example/dba-awr-system-time-percentages/) |
| Blitz Report™ XML Import | [DBA_AWR_System_Time_Percentages.xml](https://www.enginatics.com/xml/dba-awr-system-time-percentages/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-system-time-percentages/](https://www.enginatics.com/reports/dba-awr-system-time-percentages/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
