---
layout: default
title: 'DBA Blocking Sessions | Oracle EBS SQL Report'
description: 'Chain of currently blocking and blocked database sessions from v$waitchains – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Blocking, Sessions, dba_objects, v$wait_chains, gv$session'
permalink: /DBA%20Blocking%20Sessions/
---

# DBA Blocking Sessions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-blocking-sessions/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Chain of currently blocking and blocked database sessions from v$wait_chains

## Report Parameters


## Oracle EBS Tables Used
[dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects), [v$wait_chains](https://www.enginatics.com/library/?pg=1&find=v$wait_chains), [gv$session](https://www.enginatics.com/library/?pg=1&find=gv$session), [gv$process](https://www.enginatics.com/library/?pg=1&find=gv$process), [gv$sqlarea](https://www.enginatics.com/library/?pg=1&find=gv$sqlarea)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA SGA SQL Performance Summary](/DBA%20SGA%20SQL%20Performance%20Summary/ "DBA SGA SQL Performance Summary Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Blocking Sessions 06-May-2020 103312.xlsx](https://www.enginatics.com/example/dba-blocking-sessions/) |
| Blitz Report™ XML Import | [DBA_Blocking_Sessions.xml](https://www.enginatics.com/xml/dba-blocking-sessions/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-blocking-sessions/](https://www.enginatics.com/reports/dba-blocking-sessions/) |

## DBA Blocking Sessions - Case Study

### Executive Summary
The **DBA Blocking Sessions** report is a critical diagnostic tool for Oracle E-Business Suite Database Administrators (DBAs). It provides real-time visibility into database lock contention, identifying sessions that are blocking others and causing performance degradation. By visualizing the chain of blocking and blocked sessions, DBAs can quickly pinpoint the root cause of system slowness or "hanging" processes and take immediate corrective action.

### Business Challenge
In a high-concurrency environment like Oracle EBS, database locking is a normal mechanism to ensure data integrity. However, when a session holds a lock for an extended period (due to a long-running transaction, uncommitted changes, or a "zombie" process), it can prevent other users from accessing the same data. This leads to:
*   **System Slowness:** Users experience delays or unresponsive screens.
*   **Operational Stalls:** Critical business processes (e.g., order entry, month-end close) may be halted.
*   **User Frustration:** Lack of visibility into *why* the system is slow leads to increased helpdesk tickets.

Identifying the specific session holding the lock—and the SQL statement it is executing—is often like finding a needle in a haystack without the right tools.

### Solution
The **DBA Blocking Sessions** report solves this challenge by querying Oracle's `v$wait_chains` and related dynamic performance views. It presents a hierarchical view of the blocking chain, showing exactly which session is at the top of the chain (the "blocker") and which sessions are waiting (the "blockees").

**Key Features:**
*   **Hierarchical View:** Displays the relationship between blocking and waiting sessions.
*   **Real-Time Analysis:** Provides a snapshot of current lock contention.
*   **Detailed Diagnostics:** Includes session IDs, user names, machine names, SQL text, and wait events.
*   **Actionable Intelligence:** Enables DBAs to decide whether to contact the user, kill the session, or optimize the underlying SQL.

### Technical Architecture
The report leverages Oracle's Active Session History (ASH) and wait interface architecture.

**Primary Tables/Views:**
*   `v$wait_chains`: The core view for identifying blocking relationships in RAC and non-RAC environments.
*   `gv$session`: Provides details about the active sessions (User, Module, Machine, Status).
*   `gv$process`: Links sessions to operating system processes.
*   `gv$sqlarea`: Retrieves the SQL text currently being executed by the sessions.
*   `dba_objects`: Identifies the database object (table, index) involved in the lock.

**Logic:**
The query joins `v$wait_chains` with session and SQL information to construct a readable output. It filters for sessions that are currently in a wait state due to another session.

### Frequently Asked Questions

**Q: What is the difference between a "blocking" session and a "blocked" session?**
A: A **blocking** session holds a lock on a resource (like a row in a table). A **blocked** session is trying to acquire a lock on the same resource but must wait until the blocking session releases it (usually by committing or rolling back).

**Q: Does this report show historical blocking sessions?**
A: No, this report shows *current* blocking sessions. For historical analysis, you would typically use AWR (Automatic Workload Repository) or ASH (Active Session History) reports.

**Q: What should I do if I find a blocking session?**
A: First, analyze the "blocker." Is it a valid long-running job? If so, you may need to wait. Is it a user who left their screen open with uncommitted changes? You might contact them. Is it a "stuck" process? You might need to kill the session.

**Q: Can this report handle RAC (Real Application Clusters) environments?**
A: Yes, the use of `gv$` (Global) views and `v$wait_chains` ensures that blocking chains across different RAC nodes are detected.


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
