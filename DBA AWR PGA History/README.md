---
layout: default
title: 'DBA AWR PGA History | Oracle EBS SQL Report'
description: 'History of database PGA size and other statistics from v$pgastat in megabytes – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, PGA, History, dba_hist_snapshot, dba_hist_pgastat'
permalink: /DBA%20AWR%20PGA%20History/
---

# DBA AWR PGA History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-pga-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
History of database PGA size and other statistics from v$pgastat in megabytes

## Report Parameters
Date From, Date To, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_pgastat](https://www.enginatics.com/library/?pg=1&find=dba_hist_pgastat)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA AWR System Time Percentages](/DBA%20AWR%20System%20Time%20Percentages/ "DBA AWR System Time Percentages Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Latch Summary](/DBA%20AWR%20Latch%20Summary/ "DBA AWR Latch Summary Oracle EBS SQL Report"), [DBA AWR Wait Class by Time](/DBA%20AWR%20Wait%20Class%20by%20Time/ "DBA AWR Wait Class by Time Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR PGA History 29-Jul-2018 094718.xlsx](https://www.enginatics.com/example/dba-awr-pga-history/) |
| Blitz Report™ XML Import | [DBA_AWR_PGA_History.xml](https://www.enginatics.com/xml/dba-awr-pga-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-pga-history/](https://www.enginatics.com/reports/dba-awr-pga-history/) |

## Executive Summary
The **DBA AWR PGA History** report tracks the usage of the Program Global Area (PGA) over time. The PGA is the memory region reserved for each server process to perform non-shared operations, primarily sorting and hashing. Unlike the SGA (which is fixed), the PGA grows and shrinks dynamically. This report helps DBAs understand if the `PGA_AGGREGATE_TARGET` is sized correctly.

## Business Challenge
*   **Memory Leaks**: "Why does the database server run out of RAM every Friday?"
*   **Performance Tuning**: "Are we doing too many disk sorts because the PGA is too small?"
*   **Sizing**: "How much memory do we need to allocate to PGA to support 500 concurrent users?"

## Solution
This report displays historical PGA statistics from AWR.

**Key Features:**
*   **Total PGA Allocated**: The total amount of memory currently used by all processes.
*   **Cache Hit %**: The percentage of work areas (sorts/hashes) that ran entirely in memory (Optimal) vs. spilling to disk (One-pass/Multipass).
*   **Over-allocation Count**: Number of times the system failed to honor the target limit.

## Architecture
The report queries `DBA_HIST_PGASTAT`.

**Key Tables:**
*   `DBA_HIST_PGASTAT`: Historical PGA statistics.
*   `DBA_HIST_SNAPSHOT`: Snapshot timing.

## Impact
*   **Stability**: Prevents ORA-4030 (out of process memory) errors.
*   **Performance**: Maximizes in-memory sorting, which is orders of magnitude faster than disk sorting.
*   **Cost Efficiency**: Ensures RAM is allocated where it's needed most (SGA vs. PGA).


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
