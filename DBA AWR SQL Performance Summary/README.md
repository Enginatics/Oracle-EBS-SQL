---
layout: default
title: 'DBA AWR SQL Performance Summary | Oracle EBS SQL Report'
description: 'Database SQL performance summary from the Automatic Workload Repository (AWR) tables to give an overview of top SQL load and performance issues. The…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, SQL, Performance, obj$, dba_hist_snapshot, dba_hist_sqlstat'
permalink: /DBA%20AWR%20SQL%20Performance%20Summary/
---

# DBA AWR SQL Performance Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-sql-performance-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Database SQL performance summary from the Automatic Workload Repository (AWR) tables to give an overview of top SQL load and performance issues.
The report shows the summarized execution stats such as elapsed time and IO figures for a certain timeframe for individual SQL_ID and plan hash value combinations.
All IO figures are shown in MB.

Parameter 'Level' can be switched to aggregate data either by Module or by individual SQL and to show summarised figures or to split them by day.

The default sorting shows the most CPU intensive SQLs on top, as the tuning goal is usually server load optimization.
Other performance bottlenecks, such as wait times caused by Network e.g. 'SQL*Net message from dblink', can be spotted when sorting by 'elapsed time' instead of CPU.

Columns:

- Responsibility: Derived from the SGA's action column for initialized EBS sessions.
- Module Name: Derived from the SGA's module column for initialized EBS sessions.
- Module: SGA's module. Please note that if the same SQL is executed by different modules, it appears only once in this report. Thus, the module name column could be misleading as it shows the name of the first module parsing the SQL only.
-Code and Code Line#: Code package and line number of the SQL, in case it is still in the cursor cache
-Sql Id: Hash identifier for an individual SQL.
-Plan Hash Value: Hash identifier for one particular execution plan. Please note that similar but different SQLs might share exactly the same plan hash value if their execution path is identical.
-Sql Text
-Executions: Total number of executions
-Elapsed Time: Total elapsed time in seconds
-Time: Total elapsed time in a readable format split into days, hours, minutes and seconds
-User Io Wait Time: Total elapsed time in seconds from wait event class 'User I/O'
-Cpu Time: Total elapsed time in seconds that the SQL spent on CPU. High figures here usually indicate that massive amounts of data are read from the buffer cache
-IO Factor: Indicates how much faster the query would execute without wait IO times or unlimited memory
-Plsql Exec Time: Total elapsed time in seconds for PLSQL execution
-Concurrency Wait Time: Total elapsed time in seconds from wait event class 'Concurrency' e.g. 'buffer busy waits' or 'enq: TX - index contention'
-Application Wait Time: Total elapsed time in seconds from wait event class 'Application' e.g. 'enq: TX - row lock contention', an uncommitted session's update blocking another session.
-Time Exec: Average elapsed time per execution
-Buffer IO: Total buffer IO in megabtes. This is the most important figure to look at from a server load perspective.
-Disk IO: Total physical IO
-IO Exec: Total IO per execution.
-Rows Exec: Average number of rows per execution
-IO Row: Average IO per individual row retrieved. For data extraction SQLs without any sort of data aggregation, the average IO per row is a good indication if the IO spent is reasonable or if the SQL executes efficiently or not.
-IO Sec: Average IO in MB per second during SQL execution time.
-IO Sec Avg: Average IO in MB per second per overall server time (to indicate the average IO server load of the individual SQL).
-Execs Per Hour: Number of SQL executions per hour
-Time Percentage: Average percentage of the overall server time that the SQL is running. 50% indicates a SQL is running half of the server time, 400% means the same SQL is running constantly 4 times in parallel
-Is Bind Sensitive: Indicates the DB's 'adaptive cursor sharing' feature. A value of 'Y' means, the DB might consider a different explainplan for different bind values. Note that for transactional SQLs such as the ones used by Oracle EBS, the execution path should usually not change. Thus, a value of 'Y' often indicates 'instable' SQLs or SQLs where the optimizer struggles to find the best execution path.
-Is Bind Aware: 'adaptive cursor sharing' feature. A value of 'Y' means, the DB considers a differ

## Report Parameters
SQL Text contains, Module Type, Module contains, SQL Id, Plan Hash Value, Show Bind Values, Schema, Package Name starts with, Date From, Date To, Request Id (Time Restriction), Daytime or Night hours, Day of Week, Level, Order By, Exclude PLSQL Code, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[obj$](https://www.enginatics.com/library/?pg=1&find=obj$), [dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_sqlstat](https://www.enginatics.com/library/?pg=1&find=dba_hist_sqlstat), [dba_hist_sqltext](https://www.enginatics.com/library/?pg=1&find=dba_hist_sqltext), [wrh$_sqlstat](https://www.enginatics.com/library/?pg=1&find=wrh$_sqlstat), [wrh$_sql_bind_metadata](https://www.enginatics.com/library/?pg=1&find=wrh$_sql_bind_metadata), [gv$sqlarea](https://www.enginatics.com/library/?pg=1&find=gv$sqlarea), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v$parameter)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR SQL Performance Summary 25-Jan-2019 160632.xlsx](https://www.enginatics.com/example/dba-awr-sql-performance-summary/) |
| Blitz Report™ XML Import | [DBA_AWR_SQL_Performance_Summary.xml](https://www.enginatics.com/xml/dba-awr-sql-performance-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-sql-performance-summary/](https://www.enginatics.com/reports/dba-awr-sql-performance-summary/) |

## Executive Summary
The **DBA AWR SQL Performance Summary** report is the "Top SQL" report for the database. It aggregates performance metrics from AWR to identify the SQL statements that are consuming the most resources (CPU, I/O, Time) over a specific period. This is the primary tool for identifying candidates for SQL tuning.

## Business Challenge
*   **Resource Hogs**: "Which 5 queries are consuming 80% of our CPU?"
*   **I/O Bottlenecks**: "Which reports are doing the most physical reads and slowing down the storage array?"
*   **Inefficiency**: "Which queries are executed millions of times a day (e.g., inside a loop)?"

## Solution
This report summarizes execution statistics for SQL statements.

**Key Features:**
*   **Multi-Dimensional Sorting**: Can sort by Elapsed Time, CPU Time, Buffer Gets (Logical I/O), or Disk Reads (Physical I/O).
*   **Per-Execution Metrics**: Calculates "Time per Exec" and "I/O per Exec" to identify inefficient code regardless of execution count.
*   **Module Identification**: Shows which EBS module (e.g., "GL", "OE") executed the SQL.

## Architecture
The report queries `DBA_HIST_SQLSTAT` and `DBA_HIST_SQLTEXT`.

**Key Tables:**
*   `DBA_HIST_SQLSTAT`: Performance statistics per snapshot.
*   `DBA_HIST_SQLTEXT`: The actual SQL code.
*   `DBA_HIST_SNAPSHOT`: Snapshot timing.

## Impact
*   **Performance ROI**: Tuning the top 5 SQLs often yields a greater system-wide benefit than upgrading hardware.
*   **Code Quality**: Highlights poorly written custom code (e.g., missing indexes, Cartesian products).
*   **Capacity Management**: Reducing the load from top SQLs frees up headroom for growth.


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
