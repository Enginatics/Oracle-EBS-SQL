---
layout: default
title: 'DBA SGA Wait Event Summary (active session history) | Oracle EBS SQL Report'
description: 'Wait event and CPU usage summary from the SGA active session history. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, SGA, Wait, Event, gv$active_session_history'
permalink: /DBA%20SGA%20Wait%20Event%20Summary%20%28active%20session%20history%29/
---

# DBA SGA Wait Event Summary (active session history) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sga-wait-event-summary-active-session-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Wait event and CPU usage summary from the SGA active session history.

## Report Parameters
From Time, To Time, By Instance, By Event, Session Type

## Oracle EBS Tables Used
[gv$active_session_history](https://www.enginatics.com/library/?pg=1&find=gv$active_session_history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA CPU Load (active session history)](/DBA%20SGA%20CPU%20Load%20%28active%20session%20history%29/ "DBA SGA CPU Load (active session history) Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [DBA SGA SQL Performance Summary](/DBA%20SGA%20SQL%20Performance%20Summary/ "DBA SGA SQL Performance Summary Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SGA Wait Event Summary (active session history) 23-Sep-2025 105219.xlsx](https://www.enginatics.com/example/dba-sga-wait-event-summary-active-session-history/) |
| Blitz Report™ XML Import | [DBA_SGA_Wait_Event_Summary_active_session_history.xml](https://www.enginatics.com/xml/dba-sga-wait-event-summary-active-session-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-sga-wait-event-summary-active-session-history/](https://www.enginatics.com/reports/dba-sga-wait-event-summary-active-session-history/) |

## Case Study & Technical Analysis

### Abstract
The **DBA SGA Wait Event Summary (active session history)** report aggregates wait event data from the in-memory ASH buffer to provide a "Top Wait Events" profile for the immediate past. Unlike the standard AWR "Top 5 Timed Events," which covers a full hour, this report can be scoped to the last 5, 10, or 30 minutes, providing high-resolution visibility into transient performance spikes.

### Technical Analysis

#### Core Logic
*   **Aggregation**: Sums the number of active session samples for each `EVENT` (or `WAIT_CLASS`).
*   **Time Basis**: Since ASH samples once per second, the count of samples roughly equates to "seconds spent waiting" (DB Time).
*   **CPU vs. Wait**: Clearly distinguishes between time spent on CPU (working) versus time spent waiting for resources (I/O, locks, latches).

#### Key View
*   `GV$ACTIVE_SESSION_HISTORY`: The source of the wait event samples.

#### Operational Use Cases
*   **Incident Response**: During a slowdown, running this report for the "Last 10 Minutes" immediately reveals if the bottleneck is I/O (`db file sequential read`), Concurrency (`enq: TX`), or CPU.
*   **Load Profiling**: Understanding the "personality" of the workload (e.g., is it read-intensive or commit-intensive?).


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
