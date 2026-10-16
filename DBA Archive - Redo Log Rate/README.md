---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Archive / Redo Log Rate | Oracle EBS SQL Report'
description: 'If the database is running in ARCHIVELOG mode, the amount of generated archive log is shown. For databases on NOARCHIVELOG, the approximate amount of…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Archive, Redo, Log, v$database, dual, gv$instance'
permalink: /DBA%20Archive%20-%20Redo%20Log%20Rate/
report_name: 'DBA Archive / Redo Log Rate'
report_web_name: dba-archive-redo-log-rate
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Archive / Redo Log Rate – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-archive-redo-log-rate/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
If the database is running in ARCHIVELOG mode, the amount of generated archive log is shown.
For databases on NOARCHIVELOG, the approximate amount of generated redo is calculated by the number of log switches per hour and log file size. Note that this log rate is just an approximated maximum as switches could also occur without the log files being full.

Redo log files are located here:
select * from sys.v_$logfile

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Days

## Oracle EBS Tables Used
[v$database](https://www.enginatics.com/library/?pg=1&find=v%24database&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate), [gv$instance](https://www.enginatics.com/library/?pg=1&find=gv%24instance&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate), [gv$archived_log](https://www.enginatics.com/library/?pg=1&find=gv%24archived_log&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate), [gv$log_history](https://www.enginatics.com/library/?pg=1&find=gv%24log_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate), [gv$log](https://www.enginatics.com/library/?pg=1&find=gv%24log&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate)

## Related Reports
[DBA Log Switches](/DBA%20Log%20Switches/ "DBA Log Switches Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [DBA Redo Log Files](/DBA%20Redo%20Log%20Files/ "DBA Redo Log Files Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA Database Parameter Validation](/DBA%20Database%20Parameter%20Validation/ "DBA Database Parameter Validation Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Archive%20-%20Redo%20Log%20Rate/DBA%20Archive%20-%20Redo%20Log%20Rate.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Archive Redo Log Rate 13-Jul-2018 173740.xlsx](https://www.enginatics.com/example/dba-archive-redo-log-rate/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate) |
| Blitz Report™ XML Import | [DBA_Archive_Redo_Log_Rate.xml](https://www.enginatics.com/xml/dba-archive-redo-log-rate/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate) |
| SQL Source | [DBA Archive - Redo Log Rate.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Archive%20-%20Redo%20Log%20Rate/DBA%20Archive%20-%20Redo%20Log%20Rate.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-archive-redo-log-rate/](https://www.enginatics.com/reports/dba-archive-redo-log-rate/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate) |

## Executive Summary
The **DBA Archive / Redo Log Rate** report analyzes the volume of Redo Log generation over time. This metric is a fundamental indicator of database activity and write intensity. It is essential for sizing backup storage, planning network bandwidth for Data Guard (Disaster Recovery), and identifying abnormal spikes in database workload.

## Business Challenge
*   **Capacity Planning**: "How much disk space do we need for our archive log destination?"
*   **DR Bandwidth**: "Do we have enough network throughput to replicate changes to the standby site in real-time?"
*   **Performance Spikes**: "Why was the system slow at 10 AM? Was there a massive data load?"

## Solution
The report calculates the log generation rate based on historical log switches.

**Key Features:**
*   **Archivelog Mode**: Uses `GV$ARCHIVED_LOG` for precise volume measurement.
*   **NoArchivelog Mode**: Estimates volume based on `GV$LOG_HISTORY` (switch frequency) and log file size.
*   **Trend Analysis**: Shows the daily or hourly generation rate.

## Architecture
The report queries the instance history views.

**Key Tables:**
*   `GV$ARCHIVED_LOG`: History of archived logs.
*   `GV$LOG_HISTORY`: History of log switches.
*   `GV$LOG`: Current log configuration.

## Impact
*   **Infrastructure Sizing**: Prevents "disk full" outages by accurately forecasting storage needs.
*   **Disaster Recovery**: Ensures the DR strategy is viable by validating network requirements.
*   **Workload Characterization**: Helps DBAs understand the "personality" of the database (write-heavy vs. read-heavy).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-archive-redo-log-rate)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
