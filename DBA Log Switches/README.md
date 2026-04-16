---
layout: default
title: 'DBA Log Switches | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Log, Switches, gv$log_history'
permalink: /DBA%20Log%20Switches/
---

# DBA Log Switches – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-log-switches/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
None

## Report Parameters


## Oracle EBS Tables Used
[gv$log_history](https://www.enginatics.com/library/?pg=1&find=gv$log_history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA Archive / Redo Log Rate](/DBA%20Archive%20-%20Redo%20Log%20Rate/ "DBA Archive / Redo Log Rate Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [DBA Redo Log Files](/DBA%20Redo%20Log%20Files/ "DBA Redo Log Files Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA SGA Wait Event Summary (active session history)](/DBA%20SGA%20Wait%20Event%20Summary%20%28active%20session%20history%29/ "DBA SGA Wait Event Summary (active session history) Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA CPU Load (active session history)](/DBA%20SGA%20CPU%20Load%20%28active%20session%20history%29/ "DBA SGA CPU Load (active session history) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Log Switches 27-Apr-2024 202922.xlsx](https://www.enginatics.com/example/dba-log-switches/) |
| Blitz Report™ XML Import | [DBA_Log_Switches.xml](https://www.enginatics.com/xml/dba-log-switches/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-log-switches/](https://www.enginatics.com/reports/dba-log-switches/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
