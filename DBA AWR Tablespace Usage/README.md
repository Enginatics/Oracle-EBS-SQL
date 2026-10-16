---
layout: default
last_modified_at: 2026-10-16
title: 'DBA AWR Tablespace Usage | Oracle EBS SQL Report'
description: 'Tablespace usage over time from the AWR – Oracle EBS Database Administration SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, AWR, Tablespace, Usage, v$parameter, v$database, dba_hist_tbspc_space_usage'
permalink: /DBA%20AWR%20Tablespace%20Usage/
report_name: 'DBA AWR Tablespace Usage'
report_web_name: dba-awr-tablespace-usage
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA AWR Tablespace Usage – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-tablespace-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Tablespace usage over time from the AWR

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Date From, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[v$parameter](https://www.enginatics.com/library/?pg=1&find=v%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage), [v$database](https://www.enginatics.com/library/?pg=1&find=v%24database&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage), [dba_hist_tbspc_space_usage](https://www.enginatics.com/library/?pg=1&find=dba_hist_tbspc_space_usage&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage), [ts$](https://www.enginatics.com/library/?pg=1&find=ts%24&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA Tablespace Usage](/DBA%20Tablespace%20Usage/ "DBA Tablespace Usage Oracle EBS SQL Report"), [DBA Undo Statistics](/DBA%20Undo%20Statistics/ "DBA Undo Statistics Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA Feature Usage Statistics](/DBA%20Feature%20Usage%20Statistics/ "DBA Feature Usage Statistics Oracle EBS SQL Report"), [DBA AWR SQL Execution Plan History](/DBA%20AWR%20SQL%20Execution%20Plan%20History/ "DBA AWR SQL Execution Plan History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20Tablespace%20Usage/DBA%20AWR%20Tablespace%20Usage.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Tablespace Usage 18-Jan-2018 223607.xlsx](https://www.enginatics.com/example/dba-awr-tablespace-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage) |
| Blitz Report™ XML Import | [DBA_AWR_Tablespace_Usage.xml](https://www.enginatics.com/xml/dba-awr-tablespace-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage) |
| SQL Source | [DBA AWR Tablespace Usage.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20Tablespace%20Usage/DBA%20AWR%20Tablespace%20Usage.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-awr-tablespace-usage/](https://www.enginatics.com/reports/dba-awr-tablespace-usage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage) |

## Executive Summary
The **DBA AWR Tablespace Usage** report tracks the historical growth of database storage. Unlike real-time checks that only show current usage, this report uses AWR history to show *trends*. This is essential for capacity planning, allowing DBAs to predict when a tablespace will fill up based on its growth rate over the last month or year.

## Business Challenge
*   **Capacity Planning**: "When will we need to buy more disk storage?"
*   **Budgeting**: "How much storage did the 'Archive' tablespace consume last year?"
*   **Anomaly Detection**: "Why did the UNDO tablespace suddenly grow by 50GB yesterday?"

## Solution
This report displays the used size of tablespaces over time.

**Key Features:**
*   **Used Space**: The amount of space actually occupied by data.
*   **Allocated Space**: The size of the datafiles.
*   **Growth Trend**: By comparing snapshots, you can calculate the daily growth rate.

## Architecture
The report queries `DBA_HIST_TBSPC_SPACE_USAGE`.

**Key Tables:**
*   `DBA_HIST_TBSPC_SPACE_USAGE`: Historical tablespace usage metrics.
*   `TS$`: Tablespace metadata.

## Impact
*   **Uptime**: Prevents outages caused by tablespaces reaching 100% capacity.
*   **Cost Control**: Helps justify storage purchases and identify wasted space.
*   **Proactive Management**: Allows DBAs to add space during maintenance windows rather than in a panic during business hours.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-tablespace-usage)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
