---
layout: default
last_modified_at: 2026-10-16
title: 'DBA AWR Latch by Time | Oracle EBS SQL Report'
description: 'Latch contention wait time history. Each row shows the system-wide latch contention wait time per latch name of one AWR snapshot interval to identify high…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, R12 only, DBA, AWR, Latch, Time, dba_hist_snapshot, dba_hist_latch'
permalink: /DBA%20AWR%20Latch%20by%20Time/
report_name: 'DBA AWR Latch by Time'
report_web_name: dba-awr-latch-by-time
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA AWR Latch by Time – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-latch-by-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Latch contention wait time history.
Each row shows the system-wide latch contention wait time per latch name of one AWR snapshot interval to identify high latch contention at specific times.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Date From, Date To, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time), [dba_hist_latch](https://www.enginatics.com/library/?pg=1&find=dba_hist_latch&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time)

## Related Reports
[DBA AWR Latch Summary](/DBA%20AWR%20Latch%20Summary/ "DBA AWR Latch Summary Oracle EBS SQL Report"), [DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA AWR PGA History](/DBA%20AWR%20PGA%20History/ "DBA AWR PGA History Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Wait Class by Time](/DBA%20AWR%20Wait%20Class%20by%20Time/ "DBA AWR Wait Class by Time Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20Latch%20by%20Time/DBA%20AWR%20Latch%20by%20Time.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Latch by Time 26-Nov-2018 201456.xlsx](https://www.enginatics.com/example/dba-awr-latch-by-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time) |
| Blitz Report™ XML Import | [DBA_AWR_Latch_by_Time.xml](https://www.enginatics.com/xml/dba-awr-latch-by-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time) |
| SQL Source | [DBA AWR Latch by Time.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20AWR%20Latch%20by%20Time/DBA%20AWR%20Latch%20by%20Time.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-awr-latch-by-time/](https://www.enginatics.com/reports/dba-awr-latch-by-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-awr-latch-by-time)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
