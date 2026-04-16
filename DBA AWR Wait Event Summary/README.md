---
layout: default
title: 'DBA AWR Wait Event Summary | Oracle EBS SQL Report'
description: 'Summary of wait times by wait event and event class for a specified snapshot time interval. Use the Session Type parameter to restrict either to…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, Wait, Event, dba_hist_snapshot, dba_hist_system_event'
permalink: /DBA%20AWR%20Wait%20Event%20Summary/
---

# DBA AWR Wait Event Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-wait-event-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary of wait times by wait event and event class for a specified snapshot time interval.
Use the Session Type parameter to restrict either to foreground, background or all server processes.

To see data in this report based on dba_hist_system_event, set the following:
alter session set container=PDB1;
alter system set awr_pdb_autoflush_enabled=true;

<a href="https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/" rel="nofollow" target="_blank">https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/</a>

## Report Parameters
Date From, Date To, Session Type, Level of Detail, Request Id (Time Restriction), Time Restriction, Include Idle Events, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_system_event](https://www.enginatics.com/library/?pg=1&find=dba_hist_system_event)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA AWR Wait Class by Time](/DBA%20AWR%20Wait%20Class%20by%20Time/ "DBA AWR Wait Class by Time Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA AWR System Time Percentages](/DBA%20AWR%20System%20Time%20Percentages/ "DBA AWR System Time Percentages Oracle EBS SQL Report"), [DBA AWR PGA History](/DBA%20AWR%20PGA%20History/ "DBA AWR PGA History Oracle EBS SQL Report"), [DBA AWR Latch Summary](/DBA%20AWR%20Latch%20Summary/ "DBA AWR Latch Summary Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Wait Event Summary 22-Dec-2025 083752.xlsx](https://www.enginatics.com/example/dba-awr-wait-event-summary/) |
| Blitz Report™ XML Import | [DBA_AWR_Wait_Event_Summary.xml](https://www.enginatics.com/xml/dba-awr-wait-event-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-wait-event-summary/](https://www.enginatics.com/reports/dba-awr-wait-event-summary/) |

## Executive Summary
The **DBA AWR Wait Event Summary** report aggregates wait times by specific wait events and event classes for a defined snapshot interval. It is essential for DBAs to quickly identify the top contributors to database latency, enabling targeted tuning and resource optimization.

## Business Challenge
*   **Identifying Top Waiters:** Struggling to determine which specific events (e.g., `db file scattered read`, `log file sync`) are consuming the most database time.
*   **Resource Contention:** Inability to see if performance issues are due to disk I/O, network latency, or locking mechanisms.
*   **Prioritization:** Difficulty in deciding which performance issues to tackle first for maximum impact.

## The Solution
This Blitz Report solves these problems by:
*   **Aggregated View:** Summarizing wait times to highlight the most significant events over the selected period.
*   **Categorization:** Grouping events by class (e.g., System I/O, Network) for better context.
*   **Flexibility:** Allowing filtering by session type (Foreground/Background) to focus on user-impacting events.

## Technical Architecture
The report joins `DBA_HIST_SNAPSHOT` with `DBA_HIST_SYSTEM_EVENT`. It calculates the sum of `TIME_WAITED_MICRO` and `TOTAL_WAITS` for each event within the selected snapshot range. It filters out idle events (unless requested) to focus on active performance constraints.

## Parameters & Filtering
*   **Date From / Date To:** Specifies the analysis period.
*   **Session Type:** Restricts analysis to Foreground, Background, or All processes.
*   **Include Idle Events:** Option to include or exclude non-critical wait events (e.g., `SQL*Net message from client`).

## Performance & Optimization
*   **Exclude Idle Events:** Always keep "Include Idle Events" to 'No' (default) to avoid cluttering the report with irrelevant data.
*   **Time Restriction:** Use the time parameters to narrow down the analysis to peak business hours.

## FAQ
*   **Q: How does this differ from the "Wait Class by Time" report?**
    *   A: This report provides a summary of *specific events* over the entire period, whereas "Wait Class by Time" shows *classes* of waits broken down by snapshot interval.
*   **Q: Can I use this for a specific SQL ID?**
    *   A: No, this report is at the system/instance level. For SQL-level analysis, use "DBA AWR SQL Performance Summary".


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
