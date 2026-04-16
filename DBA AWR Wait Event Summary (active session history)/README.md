---
layout: default
title: 'DBA AWR Wait Event Summary (active session history) | Oracle EBS SQL Report'
description: 'Wait event and CPU usage summary from the AWR active session history. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, AWR, Wait, Event, dba_hist_active_sess_history'
permalink: /DBA%20AWR%20Wait%20Event%20Summary%20%28active%20session%20history%29/
---

# DBA AWR Wait Event Summary (active session history) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-wait-event-summary-active-session-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Wait event and CPU usage summary from the AWR active session history.

## Report Parameters
From Time, To Time, By Instance, By Event, Session Type, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_active_sess_history](https://www.enginatics.com/library/?pg=1&find=dba_hist_active_sess_history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR CPU Load (active session history)](/DBA%20AWR%20CPU%20Load%20%28active%20session%20history%29/ "DBA AWR CPU Load (active session history) Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Wait Event Summary (active session history) 23-Sep-2025 104849.xlsx](https://www.enginatics.com/example/dba-awr-wait-event-summary-active-session-history/) |
| Blitz Report™ XML Import | [DBA_AWR_Wait_Event_Summary_active_session_history.xml](https://www.enginatics.com/xml/dba-awr-wait-event-summary-active-session-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-wait-event-summary-active-session-history/](https://www.enginatics.com/reports/dba-awr-wait-event-summary-active-session-history/) |

## Executive Summary
The **DBA AWR Wait Event Summary (active session history)** report provides a highly granular view of database waits. Unlike the standard "System Wait Event" report which aggregates data globally, this report uses Active Session History (ASH) data. This allows you to filter waits by specific dimensions like User, Module, Action, or SQL ID. It answers "Who?" and "What?" rather than just "How much?".

## Business Challenge
*   **User Isolation**: "Why is the CFO's session slow, even though the system overall is fine?"
*   **Module Analysis**: "Is the 'Payroll' module suffering from lock contention?"
*   **SQL Diagnosis**: "What specific event is this SQL statement waiting on?"

## Solution
This report aggregates ASH samples to estimate wait times for specific criteria.

**Key Features:**
*   **Granular Filtering**: Can filter by `SESSION_TYPE`, `EVENT`, `INSTANCE_NUMBER`, etc.
*   **ASH Sampling**: Uses the 1-second samples from ASH to reconstruct the performance profile.
*   **CPU vs. Wait**: Clearly distinguishes between time spent working (CPU) and time spent waiting.

## Architecture
The report queries `DBA_HIST_ACTIVE_SESS_HISTORY`.

**Key Tables:**
*   `DBA_HIST_ACTIVE_SESS_HISTORY`: The history of active sessions (sampled every 10 seconds).

## Impact
*   **Targeted Tuning**: Solves "needle in a haystack" problems where a single user or job is suffering.
*   **Multi-Tenant Analysis**: In a consolidated environment, identifies which tenant is causing the noise.
*   **Forensic Analysis**: Allows detailed post-mortem analysis of incidents that happened days ago.


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
