---
layout: default
last_modified_at: 2026-10-26
title: 'DBA SGA Wait Event Summary (active session history) | Oracle EBS SQL Report'
description: 'Wait event and CPU usage summary from the SGA active session history. – Oracle EBS Database Administration SQL report: free SQL, parameters and tables…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, SGA, Wait, Event, gv$active_session_history'
permalink: /DBA%20SGA%20Wait%20Event%20Summary%20%28active%20session%20history%29/
report_name: 'DBA SGA Wait Event Summary (active session history)'
report_web_name: dba-sga-wait-event-summary-active-session-history
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA SGA Wait Event Summary (active session history) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sga-wait-event-summary-active-session-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Wait event and CPU usage summary from the SGA active session history.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
From Time, To Time, By Instance, By Event, Session Type

## Oracle EBS Tables Used
[gv$active_session_history](https://www.enginatics.com/library/?pg=1&find=gv%24active_session_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history)

## Related Reports
[DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA CPU Load (active session history)](/DBA%20SGA%20CPU%20Load%20%28active%20session%20history%29/ "DBA SGA CPU Load (active session history) Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [DBA SGA SQL Performance Summary](/DBA%20SGA%20SQL%20Performance%20Summary/ "DBA SGA SQL Performance Summary Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20Wait%20Event%20Summary%20%28active%20session%20history%29/DBA%20SGA%20Wait%20Event%20Summary%20%28active%20session%20history%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SGA Wait Event Summary (active session history) 23-Sep-2025 105219.xlsx](https://www.enginatics.com/example/dba-sga-wait-event-summary-active-session-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history) |
| Blitz Report™ XML Import | [DBA_SGA_Wait_Event_Summary_active_session_history.xml](https://www.enginatics.com/xml/dba-sga-wait-event-summary-active-session-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history) |
| SQL Source | [DBA SGA Wait Event Summary (active session history).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20Wait%20Event%20Summary%20%28active%20session%20history%29/DBA%20SGA%20Wait%20Event%20Summary%20%28active%20session%20history%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-sga-wait-event-summary-active-session-history/](https://www.enginatics.com/reports/dba-sga-wait-event-summary-active-session-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-wait-event-summary-active-session-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
