---
layout: default
title: 'DBA AWR Latch Summary | Oracle EBS SQL Report'
description: 'Summary of latch statistics such as misses and wait times for a specified snapshot time interval'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, Latch, Summary, dba_hist_snapshot, dba_hist_latch'
permalink: /DBA%20AWR%20Latch%20Summary/
---

# DBA AWR Latch Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-latch-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary of latch statistics such as misses and wait times for a specified snapshot time interval

## Report Parameters
Date From, Date To, Level of Detail, Request Id (Time Restriction), Time Restriction, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_latch](https://www.enginatics.com/library/?pg=1&find=dba_hist_latch)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA AWR Latch by Time](/DBA%20AWR%20Latch%20by%20Time/ "DBA AWR Latch by Time Oracle EBS SQL Report"), [DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA AWR PGA History](/DBA%20AWR%20PGA%20History/ "DBA AWR PGA History Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Wait Class by Time](/DBA%20AWR%20Wait%20Class%20by%20Time/ "DBA AWR Wait Class by Time Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Latch Summary 26-Nov-2018 223201.xlsx](https://www.enginatics.com/example/dba-awr-latch-summary/) |
| Blitz Report™ XML Import | [DBA_AWR_Latch_Summary.xml](https://www.enginatics.com/xml/dba-awr-latch-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-latch-summary/](https://www.enginatics.com/reports/dba-awr-latch-summary/) |

## Executive Summary
The **DBA AWR Latch Summary** report provides an aggregated view of latch statistics over a specified period. While the "Latch by Time" report shows trends, this report is useful for identifying the "Top N" latches causing the most pain overall. It summarizes misses, sleeps, and wait times to highlight the most contended memory structures.

## Business Challenge
*   **Top Contributors**: "Which latch is responsible for 80% of our concurrency wait time?"
*   **Tuning Prioritization**: Deciding which area to focus on (e.g., Shared Pool vs. Buffer Cache) based on latch statistics.
*   **Efficiency Analysis**: High "Misses" but low "Sleeps" might indicate efficient spinning, whereas high "Sleeps" indicates severe contention.

## Solution
This report aggregates latch statistics for the selected timeframe.

**Key Features:**
*   **Gets**: Number of times the latch was requested.
*   **Misses**: Number of times the latch was not obtained on the first try.
*   **Sleeps**: Number of times the process had to yield the CPU while waiting.
*   **Wait Time**: Total time spent waiting.

## Architecture
The report queries `DBA_HIST_LATCH`.

**Key Tables:**
*   `DBA_HIST_LATCH`: Historical latch statistics.

## Impact
*   **Targeted Optimization**: Focuses tuning efforts on the specific memory structures causing bottlenecks.
*   **Configuration Tuning**: Can suggest changes to initialization parameters (e.g., increasing `SHARED_POOL_SIZE` or `DB_CACHE_SIZE`) to relieve latch pressure.
*   **Code Optimization**: Helps identify application patterns (like hard parsing) that stress specific latches.


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
