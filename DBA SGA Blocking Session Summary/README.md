---
layout: default
title: 'DBA SGA Blocking Session Summary | Oracle EBS SQL Report'
description: 'Summary of blocked and blocking sessions based on the active session history from the SGA. The link to blocking sessions is deliberately nonunique without…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, SGA, Blocking, Session, v$waitstat, dual, dba_objects'
permalink: /DBA%20SGA%20Blocking%20Session%20Summary/
---

# DBA SGA Blocking Session Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sga-blocking-session-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary of blocked and blocking sessions based on the active session history from the SGA.
The link to blocking sessions is deliberately nonunique without jointing to sample_id to increase the chance to fetch the blocking session's additional information such as module, action and client_id.
In some cases, such as row lock scenarios, the blocking session is idle and does not show up in the ASH.

We recommend doing further analysis with a pivot in Excel rather than by SQL, as Excel's drag- and drop is a lot faster than typing commands manually.

## Report Parameters
User Name, Module Type, Module contains, From Time, To Time, Wait Event, SID - Serial#, SQL Id, UI Sessions only, Session Type, Instance Id, Schema, Action contains, Program contains, Diagnostic Pack enabled

## Oracle EBS Tables Used
[v$waitstat](https://www.enginatics.com/library/?pg=1&find=v$waitstat), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects), [gv$sqlarea](https://www.enginatics.com/library/?pg=1&find=gv$sqlarea), [obj$](https://www.enginatics.com/library/?pg=1&find=obj$), [gv$active_session_history](https://www.enginatics.com/library/?pg=1&find=gv$active_session_history), [dba_users](https://www.enginatics.com/library/?pg=1&find=dba_users), [y](https://www.enginatics.com/library/?pg=1&find=y)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [CAC Inventory Accounts Setup](/CAC%20Inventory%20Accounts%20Setup/ "CAC Inventory Accounts Setup Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SGA Blocking Session Summary 21-Jan-2019 083708.xlsx](https://www.enginatics.com/example/dba-sga-blocking-session-summary/) |
| Blitz Report™ XML Import | [DBA_SGA_Blocking_Session_Summary.xml](https://www.enginatics.com/xml/dba-sga-blocking-session-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-sga-blocking-session-summary/](https://www.enginatics.com/reports/dba-sga-blocking-session-summary/) |

## Case Study & Technical Analysis

### Abstract
The **DBA SGA Blocking Session Summary** report aggregates data from the Active Session History (ASH) in the SGA to provide a retrospective view of locking and contention. While the standard ASH report shows all activity, this report filters and summarizes specifically for blocking scenarios, helping DBAs understand the impact and duration of lock chains that occurred recently.

### Technical Analysis

#### Core Logic
*   **Source**: Queries `GV$ACTIVE_SESSION_HISTORY` where `BLOCKING_SESSION` is not null.
*   **Aggregation**: Groups by the blocking session's attributes to show which session/user was the "root blocker" and how much time other sessions spent waiting behind them.
*   **Wait Events**: Typically focuses on `enq: TX - row lock contention`, `library cache lock`, or `buffer busy waits`.

#### Limitations of ASH for Locking
*   **Sampling Bias**: Short locks (< 1 second) might be missed by the 1-second sampler.
*   **Idle Blockers**: As noted in the ASH analysis, if the blocker is idle, it won't be in ASH. This report is best for finding "active" blockers—e.g., a batch job that is running slow SQL and holding locks that block online users.

#### Key View
*   `GV$ACTIVE_SESSION_HISTORY`: The in-memory circular buffer of active session samples.

#### Operational Use Cases
*   **Post-Mortem**: Analyzing a "system hang" that cleared up before a DBA could look at it.
*   **Pattern Recognition**: Identifying if a specific scheduled job consistently blocks users at 2:00 PM every day.
*   **Concurrency Tuning**: Identifying "hot" records or tables that are subject to frequent contention.


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
