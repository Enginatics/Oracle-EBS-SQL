---
layout: default
title: 'DBA SGA CPU Load (active session history) | Oracle EBS SQL Report'
description: 'Aggregates active sessions by snapshot time to identify times with high CPU load over a specific ''CPU Sessions From'' threshold value.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, SGA, CPU, Load, gv$active_session_history'
permalink: /DBA%20SGA%20CPU%20Load%20%28active%20session%20history%29/
---

# DBA SGA CPU Load (active session history) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-sga-cpu-load-active-session-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Aggregates active sessions by snapshot time to identify times with high CPU load over a specific 'CPU Sessions From' threshold value.

## Report Parameters
From Time, To Time, CPU Sessions From, Session Type, Instance Id, Diagnostic Pack enabled

## Oracle EBS Tables Used
[gv$active_session_history](https://www.enginatics.com/library/?pg=1&find=gv$active_session_history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA Wait Event Summary (active session history)](/DBA%20SGA%20Wait%20Event%20Summary%20%28active%20session%20history%29/ "DBA SGA Wait Event Summary (active session history) Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [DBA SGA SQL Performance Summary](/DBA%20SGA%20SQL%20Performance%20Summary/ "DBA SGA SQL Performance Summary Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA SGA CPU Load (active session history) 22-Dec-2025 084512.xlsx](https://www.enginatics.com/example/dba-sga-cpu-load-active-session-history/) |
| Blitz Report™ XML Import | [DBA_SGA_CPU_Load_active_session_history.xml](https://www.enginatics.com/xml/dba-sga-cpu-load-active-session-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-sga-cpu-load-active-session-history/](https://www.enginatics.com/reports/dba-sga-cpu-load-active-session-history/) |

## Case Study & Technical Analysis

### Abstract
The **DBA SGA CPU Load (active session history)** report is a specialized view of ASH data designed to visualize CPU consumption over time. By aggregating the count of active sessions that are `ON CPU` per sample time, it reconstructs a load profile that can be compared against the server's physical CPU core count. This helps identify specific intervals where the database was CPU-bound.

### Technical Analysis

#### Core Logic
*   **Filter**: Selects records from `GV$ACTIVE_SESSION_HISTORY` where `SESSION_STATE = 'ON CPU'`.
*   **Aggregation**: Counts distinct session IDs per `SAMPLE_TIME`.
*   **Threshold**: The `CPU Sessions From` parameter allows filtering for spikes where the load exceeded a certain number of concurrent active sessions (e.g., greater than the number of CPU cores).

#### Interpretation
*   **Load < Cores**: The system is generally healthy; CPU is not the bottleneck.
*   **Load > Cores**: The system is CPU-bound. Sessions are runnable but waiting for CPU time (run queue). Latency increases.

#### Key View
*   `GV$ACTIVE_SESSION_HISTORY`: The source of the CPU usage samples.

#### Operational Use Cases
*   **Capacity Planning**: Determining if the server needs more CPUs to handle peak loads.
*   **Spike Analysis**: Correlating a CPU spike at 10:00 AM with a specific SQL_ID or Module.
*   **Resource Manager**: Validating if Resource Manager plans are effectively throttling CPU-hungry consumer groups.


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
