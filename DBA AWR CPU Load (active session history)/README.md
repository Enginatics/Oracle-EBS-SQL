---
layout: default
title: 'DBA AWR CPU Load (active session history) | Oracle EBS SQL Report'
description: 'Aggregates active sessions by snapshot time to identify times with high CPU load over a specific ''CPU Sessions From'' threshold value.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, AWR, CPU, Load, dba_hist_active_sess_history'
permalink: /DBA%20AWR%20CPU%20Load%20%28active%20session%20history%29/
---

# DBA AWR CPU Load (active session history) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-cpu-load-active-session-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Aggregates active sessions by snapshot time to identify times with high CPU load over a specific 'CPU Sessions From' threshold value.

## Report Parameters
From Time, To Time, CPU Sessions From, Session Type, Instance Id, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_active_sess_history](https://www.enginatics.com/library/?pg=1&find=dba_hist_active_sess_history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA AWR Wait Event Summary (active session history)](/DBA%20AWR%20Wait%20Event%20Summary%20%28active%20session%20history%29/ "DBA AWR Wait Event Summary (active session history) Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR CPU Load (active session history) 22-Dec-2025 083150.xlsx](https://www.enginatics.com/example/dba-awr-cpu-load-active-session-history/) |
| Blitz Report™ XML Import | [DBA_AWR_CPU_Load_active_session_history.xml](https://www.enginatics.com/xml/dba-awr-cpu-load-active-session-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-cpu-load-active-session-history/](https://www.enginatics.com/reports/dba-awr-cpu-load-active-session-history/) |

## Executive Summary
The **DBA AWR CPU Load (active session history)** report is a targeted analysis tool for identifying CPU bottlenecks. By aggregating Active Session History (ASH) data, it highlights specific time intervals where the number of sessions actively using CPU exceeded a defined threshold. This helps DBAs pinpoint "CPU spikes" and drill down into the sessions responsible.

## Business Challenge
*   **Server Sizing**: "Do we need more CPU cores, or is the current usage just inefficient SQL?"
*   **Performance Degradation**: "The system slows down every day at 10 AM. Is it CPU saturation?"
*   **Resource Hog Identification**: Finding the specific user or background process consuming the most CPU cycles.

## Solution
This report aggregates ASH samples where the session state is 'ON CPU'.

**Key Features:**
*   **Threshold Filtering**: The "CPU Sessions From" parameter allows filtering for intervals where CPU demand was high (e.g., > 8 active sessions on an 8-core machine).
*   **Time-Based Aggregation**: Groups data by AWR snapshot time to show the load profile over time.
*   **Drill-Down Capable**: Can be used in conjunction with other ASH reports to find the specific SQL IDs.

## Architecture
The report queries `DBA_HIST_ACTIVE_SESS_HISTORY`.

**Key Tables:**
*   `DBA_HIST_ACTIVE_SESS_HISTORY`: The source of session state data.

## Impact
*   **Cost Savings**: Optimizing high-CPU queries can delay or eliminate the need for expensive hardware upgrades.
*   **Stability**: Prevents CPU starvation for critical processes by identifying and tuning aggressive workloads.
*   **Capacity Planning**: Provides empirical data on peak CPU utilization trends.


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
