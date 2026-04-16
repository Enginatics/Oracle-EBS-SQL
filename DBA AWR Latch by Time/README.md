---
layout: default
title: 'DBA AWR Latch by Time | Oracle EBS SQL Report'
description: 'Latch contention wait time history. Each row shows the system-wide latch contention wait time per latch name of one AWR snapshot interval to identify high…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, Latch, Time, dba_hist_snapshot, dba_hist_latch'
permalink: /DBA%20AWR%20Latch%20by%20Time/
---

# DBA AWR Latch by Time – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-latch-by-time/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Latch contention wait time history.
Each row shows the system-wide latch contention wait time per latch name of one AWR snapshot interval to identify high latch contention at specific times.

## Report Parameters
Date From, Date To, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_latch](https://www.enginatics.com/library/?pg=1&find=dba_hist_latch)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA AWR Latch Summary](/DBA%20AWR%20Latch%20Summary/ "DBA AWR Latch Summary Oracle EBS SQL Report"), [DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA AWR PGA History](/DBA%20AWR%20PGA%20History/ "DBA AWR PGA History Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Wait Class by Time](/DBA%20AWR%20Wait%20Class%20by%20Time/ "DBA AWR Wait Class by Time Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Latch by Time 26-Nov-2018 201456.xlsx](https://www.enginatics.com/example/dba-awr-latch-by-time/) |
| Blitz Report™ XML Import | [DBA_AWR_Latch_by_Time.xml](https://www.enginatics.com/xml/dba-awr-latch-by-time/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-latch-by-time/](https://www.enginatics.com/reports/dba-awr-latch-by-time/) |

## Executive Summary
The **DBA AWR Latch by Time** report analyzes low-level serialization mechanisms called "Latches". Unlike locks (which protect data), latches protect memory structures in the SGA (System Global Area). High latch contention indicates that too many processes are trying to access the same memory structure simultaneously, leading to CPU spikes and "spinning". This report tracks latch wait times over time.

## Business Challenge
*   **CPU Spikes**: Latch contention often manifests as high CPU usage because processes "spin" (burn CPU) while waiting for a latch.
*   **Concurrency Bottlenecks**: Identifying specific times when memory access becomes a bottleneck (e.g., "Cache Buffers Chains" latch during a batch run).
*   **Scalability Limits**: Latch contention is often the limiting factor in how many concurrent users a system can support.

## Solution
This report shows the wait time for each latch type per AWR snapshot.

**Key Features:**
*   **Time-Series View**: Shows how latch contention evolves over the day.
*   **Latch Identification**: Identifies the specific latch name (e.g., "shared pool", "library cache").

## Architecture
The report queries `DBA_HIST_LATCH`.

**Key Tables:**
*   `DBA_HIST_LATCH`: Historical latch statistics.
*   `DBA_HIST_SNAPSHOT`: Snapshot timing.

## Impact
*   **Deep Tuning**: Helps DBAs diagnose complex internal contention issues that standard SQL tuning cannot fix.
*   **Application Design**: Can point to design flaws (e.g., lack of bind variables causing "library cache" latch contention).
*   **System Health**: Ensures the internal memory management mechanisms are functioning smoothly.


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
