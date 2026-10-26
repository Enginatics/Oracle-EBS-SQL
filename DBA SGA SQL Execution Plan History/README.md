---
layout: default
last_modified_at: 2026-10-26
title: 'DBA SGA SQL Execution Plan History | Oracle EBS SQL Report'
description: 'Execution plan history for a particular SQL id from the SGA – Oracle EBS Database Administration SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, SGA, SQL, Execution, gv$sql_plan, v$parameter, dba_segments'
permalink: /DBA%20SGA%20SQL%20Execution%20Plan%20History/
report_name: 'DBA SGA SQL Execution Plan History'
report_web_name: dba-sga-sql-execution-plan-history
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA SGA SQL Execution Plan History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sga-sql-execution-plan-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Execution plan history for a particular SQL id from the SGA

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
SQL Id, Plan Hash Value, SQL Text contains, Module contains, Using Index, Object Name, Options, Objects larger than x GB, Show Object Size

## Oracle EBS Tables Used
[gv$sql_plan](https://www.enginatics.com/library/?pg=1&find=gv%24sql_plan&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history), [dba_segments](https://www.enginatics.com/library/?pg=1&find=dba_segments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history)

## Related Reports
[DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR SQL Execution Plan History](/DBA%20AWR%20SQL%20Execution%20Plan%20History/ "DBA AWR SQL Execution Plan History Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA Blocking Sessions](/DBA%20Blocking%20Sessions/ "DBA Blocking Sessions Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20SQL%20Execution%20Plan%20History/DBA%20SGA%20SQL%20Execution%20Plan%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SGA SQL Execution Plan History 20-Sep-2021 140214.xlsx](https://www.enginatics.com/example/dba-sga-sql-execution-plan-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history) |
| Blitz Report™ XML Import | [DBA_SGA_SQL_Execution_Plan_History.xml](https://www.enginatics.com/xml/dba-sga-sql-execution-plan-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history) |
| SQL Source | [DBA SGA SQL Execution Plan History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20SGA%20SQL%20Execution%20Plan%20History/DBA%20SGA%20SQL%20Execution%20Plan%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-sga-sql-execution-plan-history/](https://www.enginatics.com/reports/dba-sga-sql-execution-plan-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history) |

## Case Study & Technical Analysis

### Abstract
The **DBA SGA SQL Execution Plan History** report retrieves the actual execution plans for SQL statements currently residing in the library cache (SGA). Unlike the theoretical plan generated by `EXPLAIN PLAN`, this report shows the plan that the optimizer *actually* chose and compiled. It enriches this data by joining with segment statistics to display the size of the tables and indexes involved in the query, providing immediate context on the cost of full table scans.

### Technical Analysis

#### Core Features
*   **Actual vs. Theoretical**: Displays the plan from `GV$SQL_PLAN`, which represents the compiled bytecode in memory.
*   **Object Sizing**: Integrates with `DBA_SEGMENTS` to show the physical size (in GB) of every object accessed in the plan. This is crucial for distinguishing between a harmless full scan on a lookup table vs. a disastrous full scan on a 500GB transaction table.
*   **Predicate Information**: Shows access and filter predicates, helping to diagnose why an index was or wasn't used.

#### Key View
*   `GV$SQL_PLAN`: The row-source generation plan stored in the Shared Pool.

#### Operational Use Cases
*   **Plan Flipping**: Diagnosing why a query suddenly changed performance by comparing its current plan hash value against historical knowledge.
*   **Index Validation**: Verifying if a newly created index is actually being picked up by the application code without needing to bounce the application.
*   **Cost Analysis**: Understanding the optimizer's estimated cardinality and cost for each step.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-sga-sql-execution-plan-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
