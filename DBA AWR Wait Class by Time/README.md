---
layout: default
title: 'DBA AWR Wait Class by Time | Oracle EBS SQL Report'
description: 'Non idle session wait times by wait class over time. Each row shows the system-wide wait time per wait class of one AWR snapshot interval to identify…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, Wait, Class, dba_hist_snapshot, dba_hist_system_event'
permalink: /DBA%20AWR%20Wait%20Class%20by%20Time/
---

# DBA AWR Wait Class by Time – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-wait-class-by-time/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Non idle session wait times by wait class over time.
Each row shows the system-wide wait time per wait class of one AWR snapshot interval to identify unusual wait events that occured at specific times.
Use the Session Type parameter to restrict either to foreground, background or all server processes.

To see data in this report based on dba_hist_system_event, set the following:
alter session set container=PDB1;
alter system set awr_pdb_autoflush_enabled=true;

<a href="https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/" rel="nofollow" target="_blank">https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/</a>

## Report Parameters
Date From, Date To, Session Type, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_system_event](https://www.enginatics.com/library/?pg=1&find=dba_hist_system_event)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA AWR System Time Percentages](/DBA%20AWR%20System%20Time%20Percentages/ "DBA AWR System Time Percentages Oracle EBS SQL Report"), [DBA AWR PGA History](/DBA%20AWR%20PGA%20History/ "DBA AWR PGA History Oracle EBS SQL Report"), [DBA AWR Latch Summary](/DBA%20AWR%20Latch%20Summary/ "DBA AWR Latch Summary Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Wait Class by Time 22-Dec-2025 083647.xlsx](https://www.enginatics.com/example/dba-awr-wait-class-by-time/) |
| Blitz Report™ XML Import | [DBA_AWR_Wait_Class_by_Time.xml](https://www.enginatics.com/xml/dba-awr-wait-class-by-time/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-wait-class-by-time/](https://www.enginatics.com/reports/dba-awr-wait-class-by-time/) |

## Executive Summary
This report provides a comprehensive analysis of non-idle session wait times categorized by wait class over a specified time range. It is a critical tool for Database Administrators (DBAs) to identify system-wide performance bottlenecks and understand the distribution of database time across different activity types such as I/O, Concurrency, or Application logic.

## Business Challenge
*   **Performance Degradation:** Difficulty in pinpointing the exact time periods when database performance suffers.
*   **Root Cause Analysis:** Challenges in distinguishing between I/O-bound, CPU-bound, or contention-related issues.
*   **Capacity Planning:** Lack of historical data trends to forecast future resource requirements.

## The Solution
The **DBA AWR Wait Class by Time** Blitz Report addresses these challenges by:
*   **Time-Series Visualization:** Presenting wait class data per AWR snapshot interval, allowing for precise correlation with reported slow periods.
*   **Drill-Down Capabilities:** Enabling users to isolate specific wait classes (e.g., "User I/O") to see their impact over time.
*   **Pluggable Database Support:** Fully compatible with Oracle Multitenant architecture, allowing analysis at the PDB level.

## Technical Architecture
The report queries the Oracle Automatic Workload Repository (AWR) tables, specifically `DBA_HIST_SNAPSHOT` and `DBA_HIST_SYSTEM_EVENT`. It aggregates the `TIME_WAITED_MICRO` metric by `WAIT_CLASS` for each snapshot interval. The logic handles the delta calculation between snapshots to show the wait time incurred during each specific interval rather than cumulative totals.

## Parameters & Filtering
*   **Date From / Date To:** Defines the time window for the analysis.
*   **Session Type:** Filters data for 'Foreground', 'Background', or 'All' sessions. Foreground is typically most relevant for user experience.
*   **Container Data:** For multitenant environments, allows selection of specific containers.

## Performance & Optimization
*   **Date Range:** Keep the date range focused (e.g., 1-2 days) for high-resolution analysis, as AWR data can be voluminous.
*   **Snapshot Interval:** Ensure AWR snapshot intervals are appropriate (typically 15-60 minutes) for the level of granularity required.

## FAQ
*   **Q: Why do I see no data for my PDB?**
    *   A: Ensure that `awr_pdb_autoflush_enabled` is set to `true` and you are connected to the correct container.
*   **Q: What is "DB CPU"?**
    *   A: While not a "wait class" in the traditional sense, this report often includes CPU time to provide a complete picture of DB time.


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
