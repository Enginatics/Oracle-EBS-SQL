---
layout: default
title: 'DBA AWR Blocking Session Summary | Oracle EBS SQL Report'
description: 'Summary of blocked and blocking sessions based on the active session history from the AWR. The link to blocking sessions is deliberately nonunique without…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, Blocking, Session, v$waitstat, dual, dba_objects'
permalink: /DBA%20AWR%20Blocking%20Session%20Summary/
---

# DBA AWR Blocking Session Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-blocking-session-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary of blocked and blocking sessions based on the active session history from the AWR.
The link to blocking sessions is deliberately nonunique without jointing to sample_id to increase the chance to fetch the blocking session's additional information such as module, action and client_id.
In some cases, such as row lock scenarios, the blocking session is idle and does not show up in the ASH.

We recommend doing further analysis with a pivot in Excel rather than by SQL, as Excel's drag- and drop is a lot faster than typing commands manually.

## Report Parameters
User Name, Module Type, Module contains, From Time, To Time, Wait Event, SID - Serial#, SQL Id, UI Sessions only, Session Type, Schema, Action contains, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[v$waitstat](https://www.enginatics.com/library/?pg=1&find=v$waitstat), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects), [gv$sqlarea](https://www.enginatics.com/library/?pg=1&find=gv$sqlarea), [obj$](https://www.enginatics.com/library/?pg=1&find=obj$), [dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_active_sess_history](https://www.enginatics.com/library/?pg=1&find=dba_hist_active_sess_history), [dba_users](https://www.enginatics.com/library/?pg=1&find=dba_users), [y](https://www.enginatics.com/library/?pg=1&find=y)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Blocking Session Summary 21-Jan-2019 095329.xlsx](https://www.enginatics.com/example/dba-awr-blocking-session-summary/) |
| Blitz Report™ XML Import | [DBA_AWR_Blocking_Session_Summary.xml](https://www.enginatics.com/xml/dba-awr-blocking-session-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-blocking-session-summary/](https://www.enginatics.com/reports/dba-awr-blocking-session-summary/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
