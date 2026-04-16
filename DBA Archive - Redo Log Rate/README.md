---
layout: default
title: 'DBA Archive / Redo Log Rate | Oracle EBS SQL Report'
description: 'If the database is running in ARCHIVELOG mode, the amount of generated archive log is shown. For databases on NOARCHIVELOG, the approximate amount of…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Archive, Redo, Log, v$database, dual, gv$instance'
permalink: /DBA%20Archive%20-%20Redo%20Log%20Rate/
---

# DBA Archive / Redo Log Rate – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-archive-redo-log-rate/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
If the database is running in ARCHIVELOG mode, the amount of generated archive log is shown.
For databases on NOARCHIVELOG, the approximate amount of generated redo is calculated by the number of log switches per hour and log file size. Note that this log rate is just an approximated maximum as switches could also occur without the log files being full.

Redo log files are located here:
select * from sys.v_$logfile

## Report Parameters
Days

## Oracle EBS Tables Used
[v$database](https://www.enginatics.com/library/?pg=1&find=v$database), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [gv$instance](https://www.enginatics.com/library/?pg=1&find=gv$instance), [gv$archived_log](https://www.enginatics.com/library/?pg=1&find=gv$archived_log), [gv$log_history](https://www.enginatics.com/library/?pg=1&find=gv$log_history), [gv$log](https://www.enginatics.com/library/?pg=1&find=gv$log)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [DBA Log Switches](/DBA%20Log%20Switches/ "DBA Log Switches Oracle EBS SQL Report"), [DBA Redo Log Files](/DBA%20Redo%20Log%20Files/ "DBA Redo Log Files Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Archive Redo Log Rate 13-Jul-2018 173740.xlsx](https://www.enginatics.com/example/dba-archive-redo-log-rate/) |
| Blitz Report™ XML Import | [DBA_Archive_Redo_Log_Rate.xml](https://www.enginatics.com/xml/dba-archive-redo-log-rate/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-archive-redo-log-rate/](https://www.enginatics.com/reports/dba-archive-redo-log-rate/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
