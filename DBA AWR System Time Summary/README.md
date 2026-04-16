---
layout: default
title: 'DBA AWR System Time Summary | Oracle EBS SQL Report'
description: 'Historic system time model values from the automated workload repository showing how the database time was spent e.g. on excuting SQL, PL/SQL or Java…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, System, Time, dba_hist_snapshot, dba_hist_sys_time_model'
permalink: /DBA%20AWR%20System%20Time%20Summary/
---

# DBA AWR System Time Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-system-time-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Historic system time model values from the automated workload repository showing how the database time was spent e.g. on excuting SQL, PL/SQL or Java code, parsing statements etc..

To see data in this report based on dba_hist_sys_time_model, set the following:
alter session set container=PDB1;
alter system set awr_pdb_autoflush_enabled=true;

<a href="https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/" rel="nofollow" target="_blank">https://www.enginatics.com/blog/updated-dba-awr-blitz-reports-now-work-with-plugglable-databases/</a>

## Report Parameters
Date From, Date To, Display Mode, Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot), [dba_hist_sys_time_model](https://www.enginatics.com/library/?pg=1&find=dba_hist_sys_time_model)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA AWR System Time Percentages](/DBA%20AWR%20System%20Time%20Percentages/ "DBA AWR System Time Percentages Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR System Time Summary 13-Jul-2018 173230.xlsx](https://www.enginatics.com/example/dba-awr-system-time-summary/) |
| Blitz Report™ XML Import | [DBA_AWR_System_Time_Summary.xml](https://www.enginatics.com/xml/dba-awr-system-time-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-system-time-summary/](https://www.enginatics.com/reports/dba-awr-system-time-summary/) |

## Executive Summary
The **DBA AWR System Time Summary** report quantifies the absolute time spent on various database activities. While percentages are useful for composition, absolute values (seconds or microseconds) are necessary for capacity planning and quantifying the impact of changes. For example, knowing that "SQL Execution" dropped from 50,000 seconds to 20,000 seconds proves the success of a tuning exercise.

## Business Challenge
*   **Quantifying Improvement**: "We added an index. How many CPU seconds did we save per hour?"
*   **Capacity Planning**: "Our workload is growing by 500 CPU-seconds per week. When will we max out the server?"
*   **Billing/Chargeback**: "How much database time is the 'Payroll' module consuming?"

## Solution
This report displays the raw values from the Oracle Time Model.

**Key Features:**
*   **DB CPU**: Total CPU time used by the database.
*   **DB Time**: Total time spent in database calls (CPU + Wait).
*   **Background CPU**: CPU used by background processes (LGWR, DBWR).

## Architecture
The report queries `DBA_HIST_SYS_TIME_MODEL`.

**Key Tables:**
*   `DBA_HIST_SYS_TIME_MODEL`: Stores cumulative time values.
*   `DBA_HIST_SNAPSHOT`: Used to calculate deltas between snapshots.

## Impact
*   **ROI Justification**: Provides hard numbers to justify hardware purchases or consulting fees.
*   **Trend Analysis**: Tracks the growth of specific workload components over months or years.
*   **Performance Baselines**: Establishes a "normal" baseline for comparison during incidents.


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
