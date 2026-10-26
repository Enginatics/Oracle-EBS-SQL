---
layout: default
last_modified_at: 2026-10-26
title: 'DBA Parameters | Oracle EBS SQL Report'
description: 'To validate recommended settings validate following notes: Database Initialization Parameters for Oracle E-Business Suite Release 12 (Doc ID 396009.1) EBS…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Parameters, gv$parameter, v$parameter'
permalink: /DBA%20Parameters/
report_name: 'DBA Parameters'
report_web_name: dba-parameters
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Parameters – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-parameters/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
To validate recommended settings validate following notes:
Database Initialization Parameters for Oracle E-Business Suite Release 12 (Doc ID 396009.1)
EBS Database Performance and Statistics Analyzer (Doc ID 2126712.1)
Get Proactive with Oracle E-Business Suite - Product Support Analyzer Index (Doc ID 1545562.1)

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Parameter Name, Non Default only, Different across Instances only

## Oracle EBS Tables Used
[gv$parameter](https://www.enginatics.com/library/?pg=1&find=gv%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v%24parameter&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters)

## Related Reports
[DBA SGA SQL Performance Summary](/DBA%20SGA%20SQL%20Performance%20Summary/ "DBA SGA SQL Performance Summary Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA SGA Buffer Cache Object Usage](/DBA%20SGA%20Buffer%20Cache%20Object%20Usage/ "DBA SGA Buffer Cache Object Usage Oracle EBS SQL Report"), [DBA SGA SQL Execution Plan History](/DBA%20SGA%20SQL%20Execution%20Plan%20History/ "DBA SGA SQL Execution Plan History Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [DBA Undo Statistics](/DBA%20Undo%20Statistics/ "DBA Undo Statistics Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Parameters/DBA%20Parameters.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Parameters 22-Dec-2025 084307.xlsx](https://www.enginatics.com/example/dba-parameters/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters) |
| Blitz Report™ XML Import | [DBA_Parameters.xml](https://www.enginatics.com/xml/dba-parameters/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters) |
| SQL Source | [DBA Parameters.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Parameters/DBA%20Parameters.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-parameters/](https://www.enginatics.com/reports/dba-parameters/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters) |

## Executive Summary
The **DBA Parameters** report audits the database initialization parameters (`init.ora` / `spfile`). These parameters control every aspect of the database's behavior, from memory allocation (`sga_target`) to optimizer behavior (`optimizer_features_enable`). Incorrect parameters are a leading cause of performance issues and instability.

## Business Challenge
*   **Standardization**: "Does our Production database have the same parameters as our Test database?"
*   **Performance Tuning**: "Is `cursor_sharing` set to `EXACT` or `FORCE`?"
*   **Change Tracking**: "Who changed `open_cursors` from 1000 to 500?"

## Solution
This report lists the current value of all database parameters.

**Key Features:**
*   **Is Default**: Indicates if the parameter is set to its default value or has been overridden.
*   **Is Modified**: Shows if the parameter was changed in the current session.
*   **RAC Consistency**: In a RAC environment, checks if parameters are consistent across all instances.

## Architecture
The report queries `GV$PARAMETER`.

**Key Tables:**
*   `GV$PARAMETER`: The in-memory view of active parameters.

## Impact
*   **Stability**: Prevents "drift" where configuration changes are made in one environment but not others.
*   **Best Practices**: Allows DBAs to validate settings against Oracle Support recommendations (e.g., "bde_chk_cbo.sql").
*   **Troubleshooting**: Quickly rules out misconfiguration as the cause of a new issue.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-parameters)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
