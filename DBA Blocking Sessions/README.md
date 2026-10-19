---
layout: default
last_modified_at: 2026-10-19
title: 'DBA Blocking Sessions | Oracle EBS SQL Report'
description: 'Chain of currently blocking and blocked database sessions from v$waitchains – Oracle EBS Database Administration SQL report: free SQL, parameters and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Blocking, Sessions, dba_objects, dba_data_files, v$wait_chains'
permalink: /DBA%20Blocking%20Sessions/
report_name: 'DBA Blocking Sessions'
report_web_name: dba-blocking-sessions
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Blocking Sessions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-blocking-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Chain of currently blocking and blocked database sessions from v$wait_chains

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions), [dba_data_files](https://www.enginatics.com/library/?pg=1&find=dba_data_files&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions), [v$wait_chains](https://www.enginatics.com/library/?pg=1&find=v%24wait_chains&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions), [gv$session](https://www.enginatics.com/library/?pg=1&find=gv%24session&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions), [gv$process](https://www.enginatics.com/library/?pg=1&find=gv%24process&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions), [gv$sqlarea](https://www.enginatics.com/library/?pg=1&find=gv%24sqlarea&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions)

## Related Reports
[DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA SGA Buffer Cache Object Usage](/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/ "DBA SGA Buffer Cache Object Usage Oracle EBS SQL Report"), [Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Blocking%20Sessions/DBA%20Blocking%20Sessions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Blocking Sessions 06-May-2020 103312.xlsx](https://www.enginatics.com/example/dba-blocking-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions) |
| Blitz Report™ XML Import | [DBA_Blocking_Sessions.xml](https://www.enginatics.com/xml/dba-blocking-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions) |
| SQL Source | [DBA Blocking Sessions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Blocking%20Sessions/DBA%20Blocking%20Sessions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-blocking-sessions/](https://www.enginatics.com/reports/dba-blocking-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-blocking-sessions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
