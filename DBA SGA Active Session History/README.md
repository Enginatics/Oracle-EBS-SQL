---
layout: default
last_modified_at: 2026-10-16
title: 'DBA SGA Active Session History | Oracle EBS SQL Report'
description: 'Active session history from the SGA. Parameter ''Blocked Sessions only'' allows a blocking scenario root cause analysis, e.g. by doing a pivot in Excel (see…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, SGA, Active, Session, v$waitstat, dual, dba_objects'
permalink: /DBA%20SGA%20Active%20Session%20History/
report_name: 'DBA SGA Active Session History'
report_web_name: dba-sga-active-session-history
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA SGA Active Session History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sga-active-session-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Active session history from the SGA.

Parameter 'Blocked Sessions only' allows a blocking scenario root cause analysis, e.g. by doing a pivot in Excel (see example in the online library).
The link to blocking sessions is deliberately nonunique without jointing to sample_id to increase the chance to fetch the blocking session's additional information such as module, action and client_id.
In some cases, such as row lock scenarios, the blocking session is idle and does not show up in the ASH then.
For scenarios where the blocking sessions are active and part of the ASH, Tanel Poder has a treewalk ash_wait_chains.sql, showing the whole chain of ASH records linked by a unique join, including the sample_id:
<a href="https://blog.tanelpoder.com/2013/11/06/diagnosing-buffer-busy-waits-with-the-ash_wait_chains-sql-script-v0-2/" rel="nofollow" target="_blank">https://blog.tanelpoder.com/2013/11/06/diagnosing-buffer-busy-waits-with-the-ash_wait_chains-sql-script-v0-2/</a>

We recommend doing ASH performance analysis with a pivot in Excel rather than by SQL, as Excel's drag- and drop is a lot faster than typing commands manually.
A typical use case is to analyze which EBS application user waited for how many seconds in which forms UI and to drill down further into the SQL or wait event root causes.

Column 'Module Name' shows either the translated EBS module display name or, e.g. for background sessions, the process name (from the program column) to enable pivoting by this column only.
Oracle's background process names are listed here:
<a href="https://docs.oracle.com/database/121/REFRN/GUID-86184690-5531-405F-AA05-BB935F57B76D.htm#REFRN104" rel="nofollow" target="_blank">https://docs.oracle.com/database/121/REFRN/GUID-86184690-5531-405F-AA05-BB935F57B76D.htm#REFRN104</a>

To identify an object or segment of a hot block, for example causing wait events, Oracle's dba_extents view is unusable due to performance bugs in 19c+, and Franck Pachot published a workaround here:
<a href="https://www.dbi-services.com/blog/efficiently-query-dba_extents-for-file_id-block_id/" rel="nofollow" target="_blank">https://www.dbi-services.com/blog/efficiently-query-dba_extents-for-file_id-block_id/</a>

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Name, Module Type, Module contains, Show Blocking Session Info, Blocked Sessions only, Request Id, Request Id (multi session), Restrict User Name to Client_ID, From Time, To Time, Code Name starts with, Entry Procedure contains, Wait Event, Exclude Wait Event, SID - Serial#, SQL Id, Max Temp Space larger than GB, Show SQL Text, UI Sessions only, Session Type, Instance Id, Machine, Schema, Action contains, Program contains, Diagnostic Pack enabled

## Oracle EBS Tables Used
[v$waitstat](https://www.enginatics.com/library/?pg=1&find=v%24waitstat&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history), [dba_objects](https://www.enginatics.com/library/?pg=1&find=dba_objects&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history), [gv$sqlarea](https://www.enginatics.com/library/?pg=1&find=gv%24sqlarea&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history), [obj$](https://www.enginatics.com/library/?pg=1&find=obj%24&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history), [gv$active_session_history](https://www.enginatics.com/library/?pg=1&find=gv%24active_session_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history), [dba_procedures](https://www.enginatics.com/library/?pg=1&find=dba_procedures&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history), [dba_users](https://www.enginatics.com/library/?pg=1&find=dba_users&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history)

## Related Reports
[DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20Active%20Session%20History/DBA%20SGA%20Active%20Session%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SGA Active Session History 24-Sep-2018 011658.xlsx](https://www.enginatics.com/example/dba-sga-active-session-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history) |
| Blitz Report™ XML Import | [DBA_SGA_Active_Session_History.xml](https://www.enginatics.com/xml/dba-sga-active-session-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history) |
| SQL Source | [DBA SGA Active Session History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20Active%20Session%20History/DBA%20SGA%20Active%20Session%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-sga-active-session-history/](https://www.enginatics.com/reports/dba-sga-active-session-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history) |

## Case Study & Technical Analysis

### Abstract
The **DBA SGA Active Session History** report is the primary tool for real-time and near-real-time performance diagnostics in Oracle Database. Unlike AWR reports which provide hourly snapshots persisted to disk, this report queries `GV$ACTIVE_SESSION_HISTORY` directly from the System Global Area (SGA). This allows for second-by-second analysis of database activity, wait events, and resource consumption for the immediate past (typically the last few hours, depending on buffer size and activity levels).

### Technical Analysis

#### Core Methodology
*   **Sampling**: The database samples the state of all active sessions once per second.
*   **In-Memory**: Data is read from the circular ASH buffer in the SGA. Once the buffer is full, older data is overwritten (and 1 in 10 samples are flushed to AWR on disk).
*   **Pivot Analysis**: The report is designed to be exported to Excel, where users can pivot by `SAMPLE_TIME`, `WAIT_CLASS`, `EVENT`, `SQL_ID`, or `MODULE` to isolate performance bottlenecks.

#### Blocking Session Analysis
The report includes logic to link blocked sessions to their blockers.
*   **Limitation**: If a blocking session is "Idle" (e.g., a user updated a row but hasn't committed and went to lunch), it will *not* appear in the ASH data as an active session, even though it is holding a lock.
*   **Resolution**: The report attempts to provide context, but for complex lock chains, specialized scripts (like Tanel Poder's `ash_wait_chains`) or the `DBA Blocking Sessions` report (which queries `V$SESSION` directly) might be needed.

#### Key Views
*   `GV$ACTIVE_SESSION_HISTORY`: The source of truth for recent activity.
*   `GV$SQLAREA`: Joins to provide SQL text and execution stats.
*   `DBA_USERS` / `DBA_PROCEDURES`: Resolves IDs to human-readable names.

#### Operational Use Cases
*   **"It's slow right now"**: Diagnosing current performance spikes.
*   **Root Cause Analysis**: Determining who was holding the lock that caused a pile-up 10 minutes ago.
*   **Application Profiling**: Filtering by `MODULE` (e.g., 'eBusiness Suite') to see where the application spends its time.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-active-session-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
