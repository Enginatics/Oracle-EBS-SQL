---
layout: default
title: 'DBA AWR CPU vs Wait Time Summary | Oracle EBS SQL Report'
description: 'Summary of database CPU vs. wait times and average active sessions for a specified time frame To see data in this report based on dbahistsystimemodel, set…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, AWR, CPU, Wait, dba_hist_snapshot, dba_hist_sys_time_model'
permalink: /DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/
---

# DBA AWR CPU vs Wait Time Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-cpu-vs-wait-time-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary of database CPU vs. wait times and average active sessions for a specified time frame

To see data in this report based on dba_hist_sys_time_model, set the following:
alter session set container=PDB1;
alter system set awr_pdb_autoflush_enabled=true;

<a href="https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/" rel="nofollow" target="_blank">https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/</a>

## Report Parameters
Date From, Date To, Level of Detail, Request Id (Time Restriction), Time Restriction, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_sys_time_model](https://www.enginatics.com/library/?pg=1&find=dba_hist_sys_time_model)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA AWR System Time Summary](/DBA%20AWR%20System%20Time%20Summary/ "DBA AWR System Time Summary Oracle EBS SQL Report"), [DBA AWR System Time Percentages](/DBA%20AWR%20System%20Time%20Percentages/ "DBA AWR System Time Percentages Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR CPU vs Wait Time Summary 22-Dec-2025 083306.xlsx](https://www.enginatics.com/example/dba-awr-cpu-vs-wait-time-summary/) |
| Blitz Report™ XML Import | [DBA_AWR_CPU_vs_Wait_Time_Summary.xml](https://www.enginatics.com/xml/dba-awr-cpu-vs-wait-time-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-cpu-vs-wait-time-summary/](https://www.enginatics.com/reports/dba-awr-cpu-vs-wait-time-summary/) |

## Executive Summary
The **DBA AWR CPU vs Wait Time Summary** report provides a high-level "health check" of the database workload. It compares the time spent on CPU (doing work) versus the time spent waiting (for I/O, locks, network, etc.). This ratio is the fundamental starting point for any performance tuning exercise: "Is the problem that we are doing too much work (CPU), or that we are waiting too long for resources (Wait)?"

## Business Challenge
*   **Problem Classification**: "Is the database slow because of slow disks (Wait) or inefficient code (CPU)?"
*   **Workload Profiling**: Understanding if the system is "CPU Bound" or "I/O Bound".
*   **Trend Analysis**: Seeing how the workload profile changes over time (e.g., after a storage migration).

## Solution
This report summarizes the "System Time Model" statistics from AWR.

**Key Features:**
*   **DB Time Breakdown**: Shows the total "DB Time" split into CPU Time and Wait Time.
*   **Average Active Sessions (AAS)**: Calculates the AAS metric, a key indicator of system load relative to capacity.
*   **PDB Support**: Can report on Pluggable Databases (PDBs) if configured.

## Architecture
The report queries `DBA_HIST_SYS_TIME_MODEL`.

**Key Tables:**
*   `DBA_HIST_SYS_TIME_MODEL`: Stores system-wide time statistics.
*   `DBA_HIST_SNAPSHOT`: Snapshot timing details.

## Impact
*   **Strategic Tuning**: Directs tuning efforts to the right area (e.g., don't buy faster disks if the problem is 90% CPU).
*   **Performance Baselines**: Establishes a baseline for "normal" behavior to compare against during incidents.
*   **Executive Reporting**: Provides a simple, high-level metric (CPU vs. Wait) that is easy to explain to management.


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
