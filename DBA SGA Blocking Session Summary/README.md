---
layout: default
last_modified_at: 2026-10-16
title: 'DBA SGA Blocking Session Summary | Oracle EBS SQL Report'
description: 'Summary of blocked and blocking sessions based on the active session history from the SGA. The link to blocking sessions is deliberately nonunique without…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, SGA, Blocking, Session, v$waitstat, dual, dba_objects'
permalink: /DBA%20SGA%20Blocking%20Session%20Summary/
report_name: 'DBA SGA Blocking Session Summary'
report_web_name: dba-sga-blocking-session-summary
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA SGA Blocking Session Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sga-blocking-session-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Summary of blocked and blocking sessions based on the active session history from the SGA.
The link to blocking sessions is deliberately nonunique without jointing to sample_id to increase the chance to fetch the blocking session's additional information such as module, action and client_id.
In some cases, such as row lock scenarios, the blocking session is idle and does not show up in the ASH.

We recommend doing further analysis with a pivot in Excel rather than by SQL, as Excel's drag- and drop is a lot faster than typing commands manually.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Name, Module Type, Module contains, From Time, To Time, Wait Event, SID - Serial#, SQL Id, UI Sessions only, Session Type, Instance Id, Schema, Action contains, Program contains, Diagnostic Pack enabled

## Oracle EBS Tables Used
[v$waitstat](https://www.enginatics.com/library/?pg=1&find=v%24waitstat&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary), [gv$sqlarea](https://www.enginatics.com/library/?pg=1&find=gv%24sqlarea&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary), [obj$](https://www.enginatics.com/library/?pg=1&find=obj%24&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary), [gv$active_session_history](https://www.enginatics.com/library/?pg=1&find=gv%24active_session_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary), [dba_users](https://www.enginatics.com/library/?pg=1&find=dba_users&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary)

## Related Reports
[DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA SGA SQL Performance Summary](/DBA%20SGA%20SQL%20Performance%20Summary/ "DBA SGA SQL Performance Summary Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20Blocking%20Session%20Summary/DBA%20SGA%20Blocking%20Session%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SGA Blocking Session Summary 21-Jan-2019 083708.xlsx](https://www.enginatics.com/example/dba-sga-blocking-session-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary) |
| Blitz Report™ XML Import | [DBA_SGA_Blocking_Session_Summary.xml](https://www.enginatics.com/xml/dba-sga-blocking-session-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary) |
| SQL Source | [DBA SGA Blocking Session Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20Blocking%20Session%20Summary/DBA%20SGA%20Blocking%20Session%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-sga-blocking-session-summary/](https://www.enginatics.com/reports/dba-sga-blocking-session-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-blocking-session-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
