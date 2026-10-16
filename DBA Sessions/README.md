---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Sessions | Oracle EBS SQL Report'
description: 'Current database sessions with their Oracle EBS user, responsibility, form or concurrent request, the SQL being executed, wait event, blocking session…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Sessions, fnd_responsibility_vl, dba_procedures, gv$session'
permalink: /DBA%20Sessions/
report_name: 'DBA Sessions'
report_web_name: dba-sessions
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Sessions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Current database sessions with their Oracle EBS user, responsibility, form or concurrent request, the SQL being executed, wait event, blocking session, and PGA, temp and undo usage. All sizes are shown in MB.

Status Duration is the time since the session last changed between active and inactive, so for an active session it is the run time of the current call. Temp Used and Undo Used are the space the session holds at the time of the report.

For a Blitz Report run inside a web service call, from the Excel add-in or a Blitz FSG drilldown, the user and responsibility are those of the run. Blitz Report Webservice Runs only lists the runs still executing. The Excel clients stop waiting after 15 minutes, so such a run active for longer has no client reading its result. Schedule the report with Active only, Blitz Report Webservice Runs only and Status Duration Minutes From 15 to be notified of them.

The Kill DB Session, Disconnect DB Session and Kill Server Process columns contain the commands to end a session.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Active only, Status Duration Minutes From, Blitz Report Webservice Runs only, Blocked Sessions only, Session Type, User Name, Module Type, Module contains, Request Id, SQL Id, Schema, Machine, Instance Id, Show SQL Text

## Oracle EBS Tables Used
[fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions), [dba_procedures](https://www.enginatics.com/library/?pg=1&find=dba_procedures&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions), [gv$session](https://www.enginatics.com/library/?pg=1&find=gv%24session&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions), [gv$process](https://www.enginatics.com/library/?pg=1&find=gv%24process&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions), [fnd_concurrent_programs_vl](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_programs_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions), [dba_tablespaces](https://www.enginatics.com/library/?pg=1&find=dba_tablespaces&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions), [gv$tempseg_usage](https://www.enginatics.com/library/?pg=1&find=gv%24tempseg_usage&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions), [gv$transaction](https://www.enginatics.com/library/?pg=1&find=gv%24transaction&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions), [gv$sess_io](https://www.enginatics.com/library/?pg=1&find=gv%24sess_io&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions)

## Related Reports
[Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA Undo Statistics](/DBA%20Undo%20Statistics/ "DBA Undo Statistics Oracle EBS SQL Report"), [Blitz Report Custom Reports Converter](/Blitz%20Report%20Custom%20Reports%20Converter/ "Blitz Report Custom Reports Converter Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Sessions/DBA%20Sessions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Sessions 12-Oct-2026 063015.xlsx](https://www.enginatics.com/example/dba-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions) |
| Blitz Report™ XML Import | [DBA_Sessions.xml](https://www.enginatics.com/xml/dba-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions) |
| SQL Source | [DBA Sessions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Sessions/DBA%20Sessions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-sessions/](https://www.enginatics.com/reports/dba-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions) |

## Case Study & Technical Analysis: DBA Sessions

### Executive Summary
This report is a live view of the database sessions connected to the Oracle E-Business Suite instance. For each session it shows the EBS user and responsibility, the form or concurrent request that owns it, the SQL being executed, the wait event, any blocking session, and the PGA, temporary and undo space it holds. It is used by DBAs during performance incidents, by support teams who must find the session behind a stuck form or request, and by administrators who need to end a runaway session safely.

### Business Challenge
*   **Finding who is blocking whom:** When users report that a form or a request hangs, the blocking session and its wait event must be identified quickly.
*   **Linking database sessions to EBS users:** The database user is usually a shared application account, so the EBS user, responsibility and program must be recovered from the session context.
*   **Runaway resource use:** Sessions can hold large amounts of temporary space, undo or PGA memory, and these need to be found and assessed.

### The Solution
*   Lists each session in the instance with its status, status duration, logon time, wait class, event and wait time.
*   Recovers the EBS user and responsibility from the Blitz Report run record when the session belongs to a report, and from the module and action information otherwise.
*   Shows the concurrent request and program for sessions that run a concurrent request, identified by the Oracle session identifier of the request.
*   Reports PGA memory allocated and used, temporary segment usage, undo blocks and records, the transaction start, and logical and physical reads per session.
*   Provides ready-made commands to kill the session, disconnect it, or kill the server process, for every session that is not a background process.

### Technical Architecture (High Level)
#### Primary Tables
*   `GV$SESSION`: the active and inactive sessions of each instance, with status, module, action, wait and SQL information.
*   `GV$PROCESS`: the operating system process behind each session, used for the PGA memory and the server process identifier.
*   `GV$TEMPSEG_USAGE`: the temporary segments held by each session, with `DBA_TABLESPACES` for the block size.
*   `GV$TRANSACTION`: the active transactions, with undo blocks, undo records and the transaction start.
*   `GV$SESS_IO`: the logical and physical I/O of each session.
*   `V$PARAMETER`: the database block size used to convert undo blocks to MB.
*   `XXEN_REPORT_RUNS`: the Blitz Report run records of sessions started by Blitz Report.
*   `FND_CONCURRENT_REQUESTS` and `FND_CONCURRENT_PROGRAMS_VL`: the running concurrent requests and their program names.
*   `FND_RESPONSIBILITY_VL`: the responsibility name.
*   `DBA_PROCEDURES`: the PL/SQL entry point of the session.

#### Logical Relationships
1. `GV$SESSION` is joined to `GV$PROCESS` on instance and process address, which provides the operating system process.
2. `GV$SESSION` is joined to `XXEN_REPORT_RUNS` through the run identifier that the module and action carry, and to the running concurrent request through the Oracle session identifier.
3. Temporary usage, transaction and I/O data are each aggregated per session in separate inline views, then joined on instance and session address.
4. The entry procedure is found by joining the session's PL/SQL object and subprogram identifiers to `DBA_PROCEDURES`.

### Parameters & Filtering
*   **Active only:** restricts the output to sessions that are active.
*   **Status Duration Minutes From:** lower bound on how long the session has been in its current status.
*   **Blitz Report Webservice Runs only:** restricts the output to sessions that are Blitz Report runs still executing.
*   **Blocked Sessions only:** shows the sessions that are blocked by another session.
*   **Session Type**, **User Name**, **Module Type**, **Module contains**, **Machine**, **Schema** and **Instance Id:** filter the sessions by their type, database or EBS user, module, machine, schema and instance.
*   **Request Id** and **SQL Id:** find the session of a concurrent request or of a SQL statement.
*   **Show SQL Text:** includes the text of the SQL being executed.

### Performance & Optimization
*   The temporary and undo figures are aggregated per session before the join, so the report does not repeat those scans for each session row.
*   The database block size is read from `V$PARAMETER` inside the undo subquery, which converts undo blocks to MB.
*   The run and concurrent request lookups are outer joins on identifiers, so sessions that are not reports or requests still appear.

### FAQ
**Q: How do I find the session that is blocking a form?**
A: Run the report with Blocked Sessions only set to Yes. The Blocking Inst Id and Blocking SID columns identify the blocking session.


**Q: How do I end a session safely?**
A: Use the Kill DB Session or Disconnect DB Session command for a non-background session. The Kill Server Process command ends the operating system process and should be used with care.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sessions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
