---
layout: default
title: 'DBA AWR System Metrics Summary | Oracle EBS SQL Report'
description: 'Historic system statistics from the automated workload repository showing CPU load, wait time percentage, logical (buffer/RAM) and physical read and write…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, System, Metrics, gv$system_parameter, v$parameter, &sysmetric_view'
permalink: /DBA%20AWR%20System%20Metrics%20Summary/
---

# DBA AWR System Metrics Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-system-metrics-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Historic system statistics from the automated workload repository showing CPU load, wait time percentage, logical (buffer/RAM) and physical read and write IO figures, summarized in snapshot time intervals. All IO figures are measured in MB/s.

-CPU%: Total CPU usage percentage. If this is low, the hardware is underused and performance could potentially get improved by using it better e.g. by resolving IO bottlenecks (bigger RAM, faster storage) or parallelization of SQLs and user processes.
-WAIT%: Percentage of time that the DB process spends waiting rather than processing. If the wait% is high and most of the wait time is spend e.g. waiting for IO, then the storage is too slow compared to CPU speed.
-BUFF_READ: Logical IO read from the buffer cache (RAM) in MB/s
-PHYS_READ: Physical IO read from the storage in MB/s
-PHYS_WRITE:  Physical IO written to the storage in MB/s

Note: The UOM calculation from LIOs to MB uses the database default block size and doesn't support different block sizes for different tablespaces.

## Report Parameters
Date From, Date To, Show Daily Averages, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[gv$system_parameter](https://www.enginatics.com/library/?pg=1&find=gv$system_parameter), [v$parameter](https://www.enginatics.com/library/?pg=1&find=v$parameter), [&sysmetric_view](https://www.enginatics.com/library/?pg=1&find=&sysmetric_view), [dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [&sysmetric_symmary_view](https://www.enginatics.com/library/?pg=1&find=&sysmetric_symmary_view)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory to G/L Reconciliation (Restricted by Org Access)](/CAC%20Inventory%20to%20G-L%20Reconciliation%20%28Restricted%20by%20Org%20Access%29/ "CAC Inventory to G/L Reconciliation (Restricted by Org Access) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR System Metrics Summary 13-Jul-2018 173115.xlsx](https://www.enginatics.com/example/dba-awr-system-metrics-summary/) |
| Blitz Report™ XML Import | [DBA_AWR_System_Metrics_Summary.xml](https://www.enginatics.com/xml/dba-awr-system-metrics-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-system-metrics-summary/](https://www.enginatics.com/reports/dba-awr-system-metrics-summary/) |

## Executive Summary
The **DBA AWR System Metrics Summary** report provides a high-level dashboard of the database's vital signs over time. It summarizes key system-wide metrics like CPU Load, Wait Percentage, and I/O Throughput (MB/s). This report is ideal for spotting trends, identifying peak load windows, and correlating system behavior with user complaints.

## Business Challenge
*   **Health Check**: "Is the database healthy right now? How does it compare to last week?"
*   **Bottleneck Identification**: "Are we CPU bound (high CPU%) or I/O bound (high Wait% and Phys Read)?"
*   **Throughput Analysis**: "What is our peak I/O throughput? Do we need a faster SAN?"

## Solution
This report aggregates system metrics from AWR snapshots.

**Key Features:**
*   **CPU %**: Total CPU utilization.
*   **Wait %**: Percentage of time sessions spent waiting.
*   **I/O Metrics**: Buffer Read (Logical), Physical Read, and Physical Write in MB/s.
*   **Snapshot Granularity**: Shows how these metrics evolve hour by hour.

## Architecture
The report queries `DBA_HIST_SYSMETRIC_SUMMARY` (or similar views depending on version).

**Key Tables:**
*   `DBA_HIST_SYSMETRIC_SUMMARY`: Summarized system metrics.
*   `DBA_HIST_SNAPSHOT`: Snapshot timing.

## Impact
*   **Executive Reporting**: Provides simple, understandable charts for management (e.g., "CPU usage is up 20% year-over-year").
*   **Proactive Sizing**: Helps predict when the system will hit hardware limits.
*   **Incident Correlation**: Helps correlate "slow system" tickets with actual server load metrics.


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
