---
layout: default
last_modified_at: 2026-10-16
title: 'DBA AWR Blocking Session Summary | Oracle EBS SQL Report'
description: 'Summary of blocked and blocking sessions based on the active session history from the AWR. The link to blocking sessions is deliberately nonunique without…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, AWR, Blocking, Session, v$waitstat, dual, dba_objects'
permalink: /DBA%20AWR%20Blocking%20Session%20Summary/
report_name: 'DBA AWR Blocking Session Summary'
report_web_name: dba-awr-blocking-session-summary
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA AWR Blocking Session Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-blocking-session-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Summary of blocked and blocking sessions based on the active session history from the AWR.
The link to blocking sessions is deliberately nonunique without jointing to sample_id to increase the chance to fetch the blocking session's additional information such as module, action and client_id.
In some cases, such as row lock scenarios, the blocking session is idle and does not show up in the ASH.

We recommend doing further analysis with a pivot in Excel rather than by SQL, as Excel's drag- and drop is a lot faster than typing commands manually.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Name, Module Type, Module contains, From Time, To Time, Wait Event, SID - Serial#, SQL Id, UI Sessions only, Session Type, Schema, Action contains, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[v$waitstat](https://www.enginatics.com/library/?pg=1&find=v%24waitstat&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary), [gv$sqlarea](https://www.enginatics.com/library/?pg=1&find=gv%24sqlarea&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary), [obj$](https://www.enginatics.com/library/?pg=1&find=obj%24&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary), [dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary), [dba_hist_active_sess_history](https://www.enginatics.com/library/?pg=1&find=dba_hist_active_sess_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary), [dba_users](https://www.enginatics.com/library/?pg=1&find=dba_users&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary)

## Related Reports
[DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Wait Event Summary (active session history)](/DBA%20AWR%20Wait%20Event%20Summary%20%28active%20session%20history%29/ "DBA AWR Wait Event Summary (active session history) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20Blocking%20Session%20Summary/DBA%20AWR%20Blocking%20Session%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Blocking Session Summary 21-Jan-2019 095329.xlsx](https://www.enginatics.com/example/dba-awr-blocking-session-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary) |
| Blitz Report™ XML Import | [DBA_AWR_Blocking_Session_Summary.xml](https://www.enginatics.com/xml/dba-awr-blocking-session-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary) |
| SQL Source | [DBA AWR Blocking Session Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20Blocking%20Session%20Summary/DBA%20AWR%20Blocking%20Session%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-awr-blocking-session-summary/](https://www.enginatics.com/reports/dba-awr-blocking-session-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary) |

## Executive Summary
The **DBA AWR Blocking Session Summary** report focuses specifically on database locking and concurrency issues. It aggregates data from the AWR Active Session History to identify "Blocking Chains"—situations where one session holds a resource (like a row lock) that prevents other sessions from proceeding. This is often the cause of "application hangs."

## Business Challenge
*   **Lock Storms**: A single user leaving a record open on their screen can block a batch job, which then blocks other users, creating a cascade of hung sessions.
*   **Code Defects**: Identifying application code that holds locks longer than necessary or commits infrequently.
*   **Idle Blockers**: Detecting sessions that are "Idle" (not consuming CPU) but are still holding locks (e.g., "SQL*Net message from client").

## Solution
This report summarizes the blocking relationships found in the history.

**Key Features:**
*   **Blocker Identification**: Identifies the "Root Blocker"—the session at the top of the chain.
*   **Wait Event Analysis**: Shows what the blocked sessions were waiting for (e.g., "enq: TX - row lock contention").
*   **Impact Assessment**: Shows how many sessions were blocked and for how long.

## Architecture
The report analyzes `DBA_HIST_ACTIVE_SESS_HISTORY` to find rows where `BLOCKING_SESSION` is populated.

**Key Tables:**
*   `DBA_HIST_ACTIVE_SESS_HISTORY`: Source of blocking info.
*   `DBA_OBJECTS`: Identifies the object being locked (if available).
*   `DBA_USERS`: Identifies the users involved.

## Impact
*   **Application Stability**: Helps developers fix code that causes concurrency bottlenecks.
*   **Operational Efficiency**: Reduces the time required to diagnose "system hang" incidents.
*   **User Education**: Can be used to show users the impact of leaving transactions uncommitted.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-blocking-session-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
