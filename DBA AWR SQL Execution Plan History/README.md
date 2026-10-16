---
layout: default
last_modified_at: 2026-10-16
title: 'DBA AWR SQL Execution Plan History | Oracle EBS SQL Report'
description: 'Execution plan history for a particular SQL id from the automatic workload repository'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, AWR, SQL, Execution, dba_hist_sql_plan, v$parameter, dba_segments'
permalink: /DBA%20AWR%20SQL%20Execution%20Plan%20History/
report_name: 'DBA AWR SQL Execution Plan History'
report_web_name: dba-awr-sql-execution-plan-history
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA AWR SQL Execution Plan History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-sql-execution-plan-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Execution plan history for a particular SQL id from the automatic workload repository

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
SQL Id, Plan Hash Value, Using Index, Object Name, Options, Objects larger than x GB, Show Object Size, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_sql_plan](https://www.enginatics.com/library/?pg=1&find=dba_hist_sql_plan&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history), [dba_segments](https://www.enginatics.com/library/?pg=1&find=dba_segments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history)

## Related Reports
[DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA SGA SQL Execution Plan History](/DBA%20SGA%20SQL%20Execution%20Plan%20History/ "DBA SGA SQL Execution Plan History Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Tablespace Usage](/DBA%20AWR%20Tablespace%20Usage/ "DBA AWR Tablespace Usage Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [Blitz Report Security](/Blitz%20Report%20Security/ "Blitz Report Security Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20SQL%20Execution%20Plan%20History/DBA%20AWR%20SQL%20Execution%20Plan%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR SQL Execution Plan History 22-Dec-2025 083522.xlsx](https://www.enginatics.com/example/dba-awr-sql-execution-plan-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history) |
| Blitz Report™ XML Import | [DBA_AWR_SQL_Execution_Plan_History.xml](https://www.enginatics.com/xml/dba-awr-sql-execution-plan-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history) |
| SQL Source | [DBA AWR SQL Execution Plan History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20SQL%20Execution%20Plan%20History/DBA%20AWR%20SQL%20Execution%20Plan%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-awr-sql-execution-plan-history/](https://www.enginatics.com/reports/dba-awr-sql-execution-plan-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history) |

## Executive Summary
The **DBA AWR SQL Execution Plan History** report is a critical tool for diagnosing "Plan Flipping" or "Plan Regression". It tracks how the execution plan for a specific SQL statement has changed over time. In Oracle, the Optimizer decides the best way to execute a query (which index to use, join order, etc.). Sometimes, this plan changes for the worse, causing a query that used to take 1 second to suddenly take 1 hour.

## Business Challenge
*   **Performance Regression**: "This report was fast yesterday. Today it's slow. Nothing changed in the code."
*   **Upgrade Analysis**: "Did the database upgrade cause the Optimizer to pick a bad plan for our critical payroll query?"
*   **Index Impact**: "Did dropping that index cause the query to switch to a full table scan?"

## Solution
This report lists all execution plans captured in AWR for a given SQL ID.

**Key Features:**
*   **Plan Hash Value**: A unique identifier for the plan structure. A change in this value confirms the plan changed.
*   **Cost**: The Optimizer's estimated cost for the plan.
*   **Timestamp**: When the plan was first and last seen.

## Architecture
The report queries `DBA_HIST_SQL_PLAN`.

**Key Tables:**
*   `DBA_HIST_SQL_PLAN`: Stores the steps of the execution plan.
*   `DBA_HIST_SQLSTAT`: Links the plan to performance metrics.

## Impact
*   **Stability**: Allows DBAs to identify unstable queries and lock down their plans (using SQL Profiles or Baselines).
*   **Root Cause Analysis**: Definitively proves whether a performance drop was caused by a plan change.
*   **Recovery**: Provides the "good" plan hash value needed to restore performance.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-sql-execution-plan-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
