---
layout: default
last_modified_at: 2026-10-16
title: 'DBA SGA SQL Performance Summary | Oracle EBS SQL Report'
description: 'Database SQL performance summary from the SGA to give an overview of top SQL load and performance issues. The purpose of this report, compared to ''DBA AWR…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, SGA, SQL, Performance, obj$, v$parameter, gv$sqlarea'
permalink: /DBA%20SGA%20SQL%20Performance%20Summary/
report_name: 'DBA SGA SQL Performance Summary'
report_web_name: dba-sga-sql-performance-summary
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA SGA SQL Performance Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sga-sql-performance-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Database SQL performance summary from the SGA to give an overview of top SQL load and performance issues.
The purpose of this report, compared to 'DBA AWR SQL Performance Summary' is to retrieve SQLs which are not in the AWR, either becasue they ran after the most recent snapshot or because their performance impact is too small to be written to the AWR (see topnsql <a href="https://docs.oracle.com/database/121/ARPLS/d_workload_repos.htm#ARPLS69140" rel="nofollow" target="_blank">https://docs.oracle.com/database/121/ARPLS/d_workload_repos.htm#ARPLS69140</a>).
This is useful for example to:
-Identify SQLs executed by a particular program or UI function without running a trace. Navigate to the UI functionality first, then directly after, execute this report and restrict to the module name in question. Sort by column 'Last Active Time'
-Identify SQLs and example bind variables to reproduce a SQL execution in a DB access tool. Switch parameter 'Show Bind Values' to 'Yes'
-Identify SQLs incorrectly using literals instead of binds. Set parameter 'Literals Duplication Count' to a value bigger than zero to show all SQLs which are at least duplicated this numer of times.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
SQL Text contains, Module Type, Module contains, SQL Id, Plan Hash Value, Show Bind Values, Schema, Package Name starts with, First Load Time From, Last Active from, Last Active to, Time Basis Days, Minimum Days Active in SGA, Minimum Executions in SGA, Literals Duplication Count, Examples per Duplicate, Command Type, Exclude Command Type, Using Index, Order By, Exclude PLSQL Code, Exclude SYS User

## Oracle EBS Tables Used
[obj$](https://www.enginatics.com/library/?pg=1&find=obj%24&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary), [gv$sqlarea](https://www.enginatics.com/library/?pg=1&find=gv%24sqlarea&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary), [gv$sql_bind_capture](https://www.enginatics.com/library/?pg=1&find=gv%24sql_bind_capture&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary)

## Related Reports
[DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA SGA SQL Execution Plan History](/DBA%20SGA%20SQL%20Execution%20Plan%20History/ "DBA SGA SQL Execution Plan History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20SQL%20Performance%20Summary/DBA%20SGA%20SQL%20Performance%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SGA SQL Performance Summary 11-May-2017 124450.xlsx](https://www.enginatics.com/example/dba-sga-sql-performance-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary) |
| Blitz Report™ XML Import | [DBA_SGA_SQL_Performance_Summary.xml](https://www.enginatics.com/xml/dba-sga-sql-performance-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary) |
| SQL Source | [DBA SGA SQL Performance Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20SQL%20Performance%20Summary/DBA%20SGA%20SQL%20Performance%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-sga-sql-performance-summary/](https://www.enginatics.com/reports/dba-sga-sql-performance-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary) |

## Case Study & Technical Analysis

### Abstract
The **DBA SGA SQL Performance Summary** report provides a snapshot of the most resource-intensive SQL statements currently in the database memory. It fills the gap left by AWR reports, which only capture the "Top N" SQLs at hourly intervals. This report is essential for identifying "flash" performance issues—queries that run frequently or poorly for a short period but don't sustain enough load to be persisted to AWR.

### Technical Analysis

#### Core Features
*   **Bind Variable Capture**: Retrieves values from `GV$SQL_BIND_CAPTURE`, allowing developers to reproduce the issue in a separate session with actual data.
*   **Literal Analysis**: Includes a "Literals Duplication Count" to identify applications that are failing to use bind variables (hard parse storms), which can devastate CPU and Shared Pool performance.
*   **Granular Filtering**: Allows filtering by module, user, or specific time windows (e.g., "Last Active Time").

#### Key Views
*   `GV$SQLAREA`: Aggregated statistics for SQL statements (execution count, elapsed time, CPU time).
*   `GV$SQL_BIND_CAPTURE`: Sampled bind values for the queries.

#### Operational Use Cases
*   **Code Review**: Identifying SQLs with high `DISK_READS` or `BUFFER_GETS` per execution.
*   **Ad-hoc Tuning**: Quickly finding the SQL_ID for a query that a user complains is "slow right now."
*   **Security Audit**: Checking for SQL injection patterns or unexpected queries from specific modules.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-performance-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
