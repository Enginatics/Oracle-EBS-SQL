---
layout: default
last_modified_at: 2026-10-16
title: 'Blitz Report Web Service Sessions | Oracle EBS SQL Report'
description: 'Blitz Report runs that execute inside a web service call, from the Excel add-in or a Blitz FSG drilldown, and are still active, with the Oracle EBS user…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Web, Service, fnd_responsibility_vl, gv$session, gv$process'
permalink: /Blitz%20Report%20Web%20Service%20Sessions/
report_name: 'Blitz Report Web Service Sessions'
report_web_name: blitz-report-web-service-sessions
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report Web Service Sessions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-web-service-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
Blitz Report runs that execute inside a web service call, from the Excel add-in or a Blitz FSG drilldown, and are still active, with the Oracle EBS user and responsibility that started them.

Running Minutes is the run time of the current database call. The Excel clients stop waiting after 15 minutes. A run that is still active after that has no client reading its result, but its database session and the middle-tier thread serving it stay busy until the query ends.

Kill Session holds the command that ends the session. Temp Used is in MB.

Schedule the report with Running Minutes From to be notified of such sessions.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Running Minutes From

## Oracle EBS Tables Used
[fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions), [gv$session](https://www.enginatics.com/library/?pg=1&find=gv%24session&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions), [gv$process](https://www.enginatics.com/library/?pg=1&find=gv%24process&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions), [dba_tablespaces](https://www.enginatics.com/library/?pg=1&find=dba_tablespaces&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions), [gv$tempseg_usage](https://www.enginatics.com/library/?pg=1&find=gv%24tempseg_usage&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions)

## Related Reports
[DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [Blitz Upload History](/Blitz%20Upload%20History/ "Blitz Upload History Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Web%20Service%20Sessions/Blitz%20Report%20Web%20Service%20Sessions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/blitz-report-web-service-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions) |
| Blitz Report™ XML Import | [Blitz_Report_Web_Service_Sessions.xml](https://www.enginatics.com/xml/blitz-report-web-service-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions) |
| SQL Source | [Blitz Report Web Service Sessions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Web%20Service%20Sessions/Blitz%20Report%20Web%20Service%20Sessions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-web-service-sessions/](https://www.enginatics.com/reports/blitz-report-web-service-sessions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions) |

## Case Study & Technical Analysis: Blitz Report Web Service Sessions

### Executive Summary
The Blitz Report Web Service Sessions report lists the Blitz Report runs that are executing inside a web service call and are still active. These runs come from the Excel add-in or from a Blitz FSG drilldown, and each row shows the Oracle E-Business Suite user and responsibility that started it. System administrators use it to see which reports are running, how long they have been running and how much temporary tablespace they consume, and to end a session that has become unproductive. The report is a monitoring tool for the Blitz Report server side of an installation.

### Business Challenge
*   **Stuck report runs:** The Excel clients stop waiting after 15 minutes, but the database session of a run keeps going until its query ends, so a long run holds resources that no user is waiting for.
*   **Resource contention:** Long sorts and joins consume temporary tablespace and middle-tier threads, which slows down other users.
*   **Accountability:** The administrator needs to know which user and responsibility started a run before ending it.
*   **Proactive alerts:** Operations teams want to be told about long runs before users report a slow system.

### The Solution
*   Finds the Blitz Report runs that are active in a web service call, by matching the module of the database session and the run id in the session's action attribute.
*   Shows the user name, responsibility, report name and run id of each run, taken from the Blitz Report run and report tables.
*   Calculates Running Minutes from the time of the current database call, and shows the wait event or CPU state of the session.
*   Gives the temporary space used by the session in megabytes, and a ready-made ALTER SYSTEM KILL SESSION command for each row.

### Technical Architecture (High Level)
#### Primary Tables
*   `GV$SESSION`: the active database sessions, with module, action, status, last call elapsed time and client identifier.
*   `GV$PROCESS`: the operating system process of each session, used to show the process id of the database server.
*   `XXEN_REPORT_RUNS`: one row per report run, with the run id, the user who created it, the responsibility and the completion fields.
*   `XXEN_REPORTS_V`: the report name for each run.
*   `GV$TEMPSEG_USAGE` and `DBA_TABLESPACES`: the temporary segments of each session and the block size of their tablespaces.
*   `FND_RESPONSIBILITY_VL` and `FND_CONCURRENT_REQUESTS`: the responsibility name, and the concurrent requests that exclude sessions already running as concurrent programs.

#### Logical Relationships
1.  `GV$SESSION` is joined to `GV$PROCESS` on instance and process address, so each session carries its operating system process id.
2.  The run id in the first part of the session's action attribute is matched to `XXEN_REPORT_RUNS`, and the run is kept only while its request id, completion date and completion message are empty.
3.  `XXEN_REPORTS_V` supplies the report name for the run, and `FND_RESPONSIBILITY_VL` supplies the responsibility name from the run's responsibility id.
4.  Temporary usage is summed per instance and session address in an inline view, then joined back to the session on the session address.
5.  Sessions that belong to an active concurrent request in `FND_CONCURRENT_REQUESTS` are excluded.

### Parameters & Filtering
*   **Running Minutes From:** shows only the runs whose elapsed time in the current database call is at least the number of minutes entered. It is the parameter to schedule when an alert on long runs is wanted.

The report has no other parameters; the list is always the current set of active web service sessions.

### Performance & Optimization
*   The session scan is limited by the module filter, which matches only Blitz Report sessions, so the report does not read the full session list of the database.
*   Temporary space usage is aggregated once per session in an inline view, rather than being computed for every row of the session list.
*   The result is ordered by the last call elapsed time, so the longest running sessions appear first.
*   The DBA_TABLESPACES lookup is a correlated subquery on the tablespace name, which returns only the block size needed for the usage calculation.

### FAQ
**Q: How do I find long-running Blitz Report web service calls?**
A: Run the report with Running Minutes From set to the threshold, for example 15. Each row is an active run, with its user, responsibility, report name and running minutes.

**Q: How do I stop a Blitz Report session that is still running?**
A: Copy the Kill Session command of the row and run it with a user who has the ALTER SYSTEM privilege. The command ends the session immediately.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-web-service-sessions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
