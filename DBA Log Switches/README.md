---
layout: default
last_modified_at: 2026-10-26
title: 'DBA Log Switches | Oracle EBS SQL Report'
description: 'Oracle EBS Database Administration SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Log, Switches, gv$log_history'
permalink: /DBA%20Log%20Switches/
report_name: 'DBA Log Switches'
report_web_name: dba-log-switches
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Log Switches – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-log-switches/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[gv$log_history](https://www.enginatics.com/library/?pg=1&find=gv%24log_history&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches)

## Related Reports
[DBA Archive / Redo Log Rate](/DBA%20Archive%20-%20Redo%20Log%20Rate/ "DBA Archive / Redo Log Rate Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [DBA Redo Log Files](/DBA%20Redo%20Log%20Files/ "DBA Redo Log Files Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA SGA Wait Event Summary (active session history)](/DBA%20SGA%20Wait%20Event%20Summary%20%28active%20session%20history%29/ "DBA SGA Wait Event Summary (active session history) Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA CPU Load (active session history)](/DBA%20SGA%20CPU%20Load%20%28active%20session%20history%29/ "DBA SGA CPU Load (active session history) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Log%20Switches/DBA%20Log%20Switches.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Log Switches 27-Apr-2024 202922.xlsx](https://www.enginatics.com/example/dba-log-switches/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches) |
| Blitz Report™ XML Import | [DBA_Log_Switches.xml](https://www.enginatics.com/xml/dba-log-switches/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches) |
| SQL Source | [DBA Log Switches.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Log%20Switches/DBA%20Log%20Switches.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-log-switches/](https://www.enginatics.com/reports/dba-log-switches/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches) |

## Executive Summary
The **DBA Log Switches** report tracks the frequency of Redo Log switches. In an Oracle database, every change is written to the Redo Log. When a log file fills up, a "Log Switch" occurs, and the database moves to the next file. Frequent switching (e.g., every 2 minutes) causes "Checkpoint" storms, where the database freezes while flushing dirty blocks to disk.

## Business Challenge
*   **Performance Stalls**: "Why does the system freeze for 10 seconds every few minutes?"
*   **Sizing**: "Are our 1GB redo logs too small for the current transaction volume?"
*   **Peak Load Analysis**: "At what time of day do we generate the most redo (i.e., do the most inserts/updates)?"

## Solution
This report lists the time of each log switch.

**Key Features:**
*   **Switch Time**: The exact timestamp of the switch.
*   **Frequency**: Allows calculation of the interval between switches.
*   **Thread**: In RAC environments, shows which instance performed the switch.

## Architecture
The report queries `GV$LOG_HISTORY`.

**Key Tables:**
*   `GV$LOG_HISTORY`: Historical log switch data.

## Impact
*   **Tuning**: Helps DBAs size redo logs correctly (Oracle recommends switching no more than once every 15-20 minutes).
*   **IO Stability**: Reducing switch frequency smooths out the I/O load on the storage subsystem.
*   **Archiver Health**: Ensures the Archiver process (ARCn) can keep up with the generation of redo logs.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-log-switches)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
