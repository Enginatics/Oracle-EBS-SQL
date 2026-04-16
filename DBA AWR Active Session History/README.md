---
layout: default
title: 'DBA AWR Active Session History | Oracle EBS SQL Report'
description: 'Active session history from the automatic workload repository – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, Active, Session, gv$sqlarea, obj$, dba_hist_active_sess_history'
permalink: /DBA%20AWR%20Active%20Session%20History/
---

# DBA AWR Active Session History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-active-session-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Active session history from the automatic workload repository

## Report Parameters
User Name, Module Type, Module contains, Show Blocking Session Info, Blocked Sessions only, Request Id, From Time, To Time, Code Name starts with, Entry Procedure contains, Wait Event, Exclude Wait Event, SID - Serial#, SQL Id, Plan Hash Value, Show SQL Text, UI Sessions only, Machine, Session Type, Schema, Action contains, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[gv$sqlarea](https://www.enginatics.com/library/?pg=1&find=gv$sqlarea), [obj$](https://www.enginatics.com/library/?pg=1&find=obj$), [dba_hist_active_sess_history](https://www.enginatics.com/library/?pg=1&find=dba_hist_active_sess_history), [dba_hist_sqltext](https://www.enginatics.com/library/?pg=1&find=dba_hist_sqltext), [dba_procedures](https://www.enginatics.com/library/?pg=1&find=dba_procedures), [dba_users](https://www.enginatics.com/library/?pg=1&find=dba_users)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR Wait Event Summary (active session history)](/DBA%20AWR%20Wait%20Event%20Summary%20%28active%20session%20history%29/ "DBA AWR Wait Event Summary (active session history) Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA AWR CPU Load (active session history)](/DBA%20AWR%20CPU%20Load%20%28active%20session%20history%29/ "DBA AWR CPU Load (active session history) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Active Session History 11-May-2017 125507.xlsx](https://www.enginatics.com/example/dba-awr-active-session-history/) |
| Blitz Report™ XML Import | [DBA_AWR_Active_Session_History.xml](https://www.enginatics.com/xml/dba-awr-active-session-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-active-session-history/](https://www.enginatics.com/reports/dba-awr-active-session-history/) |

## Executive Summary
The **DBA AWR Active Session History** report is a forensic performance analysis tool. It mines the Automatic Workload Repository (AWR) to reconstruct the "Active Session History" (ASH) for a past time period. While real-time ASH shows what is happening *now*, this report allows DBAs to answer "What happened *then*?" with second-by-second granularity.

## Business Challenge
*   **Post-Mortem Analysis**: "Users reported the system froze yesterday between 2:00 and 2:15 PM. What caused it?"
*   **Wait Analysis**: Identifying the specific bottleneck (CPU, I/O, Locks) that dominated the workload during the incident.
*   **SQL Identification**: Pinpointing the exact SQL ID and execution plan that was consuming resources at that time.

## Solution
This report dumps the historical ASH data, allowing for detailed filtering and pivoting.

**Key Features:**
*   **Granularity**: ASH samples active sessions every second (in memory) and persists a sample (1 in 10) to AWR.
*   **Dimensions**: Can analyze by User, Module, SQL ID, Wait Event, Machine, etc.
*   **Blocking Info**: Shows which session was blocking which other session.

## Architecture
The report queries `DBA_HIST_ACTIVE_SESS_HISTORY`, the persistent storage for ASH data.

**Key Tables:**
*   `DBA_HIST_ACTIVE_SESS_HISTORY`: The core history table.
*   `DBA_USERS`: Usernames.
*   `DBA_HIST_SQLTEXT`: SQL text for the captured SQL IDs.

## Impact
*   **Root Cause Analysis**: Moves performance tuning from guessing to evidence-based diagnosis.
*   **SLA Management**: Helps explain service interruptions to stakeholders with concrete data.
*   **Trend Identification**: Can be used to spot recurring patterns of contention (e.g., "Every day at 9 AM, we hit this lock").


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
