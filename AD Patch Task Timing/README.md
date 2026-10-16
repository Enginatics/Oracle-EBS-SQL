---
layout: default
last_modified_at: 2026-10-16
title: 'AD Patch Task Timing | Oracle EBS SQL Report'
description: 'Run time of each job of an adpatch, adop or upgrade session from ADTASKTIMING, to identify the jobs that took longest. Session Percentage is the job''s…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Applications DBA, Enginatics, Patch, Task, Timing, ad_task_timing, ad_patch_runs, ad_patch_drivers'
permalink: /AD%20Patch%20Task%20Timing/
report_name: 'AD Patch Task Timing'
report_web_name: ad-patch-task-timing
module: 'Applications DBA'
module_url: /modules/applications-dba/
---

# AD Patch Task Timing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ad-patch-task-timing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing).
**Oracle EBS module:** [Applications DBA](/modules/applications-dba/ "Oracle EBS Applications DBA reports") · [all Applications DBA reports](/modules/applications-dba/)  

## Overview
Run time of each job of an adpatch, adop or upgrade session from AD_TASK_TIMING, to identify the jobs that took longest.

Session Percentage is the job's share of the total elapsed time of all jobs in the session. Jobs run in parallel by several workers, so the session's wall clock time is shorter than the sum of the job times.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Session Id, Elapsed Minutes From, Phase Name like

## Oracle EBS Tables Used
[ad_task_timing](https://www.enginatics.com/library/?pg=1&find=ad_task_timing&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing), [ad_patch_runs](https://www.enginatics.com/library/?pg=1&find=ad_patch_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing), [ad_patch_drivers](https://www.enginatics.com/library/?pg=1&find=ad_patch_drivers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing)

## Related Reports
[AD Applied Patches](/AD%20Applied%20Patches/ "AD Applied Patches Oracle EBS SQL Report"), [AD Applied Patches R12.2](/AD%20Applied%20Patches%20R12-2/ "AD Applied Patches R12.2 Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AD%20Patch%20Task%20Timing/AD%20Patch%20Task%20Timing.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AD Patch Task Timing 12-Oct-2026 061631.xlsx](https://www.enginatics.com/example/ad-patch-task-timing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing) |
| Blitz Report™ XML Import | [AD_Patch_Task_Timing.xml](https://www.enginatics.com/xml/ad-patch-task-timing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing) |
| SQL Source | [AD Patch Task Timing.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AD%20Patch%20Task%20Timing/AD%20Patch%20Task%20Timing.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ad-patch-task-timing/](https://www.enginatics.com/reports/ad-patch-task-timing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing) |

## Case Study & Technical Analysis: AD Patch Task Timing

### Executive Summary
This report shows how long each job ran during an Oracle E-Business Suite patching session started with adpatch, adop or an upgrade. It lists every job recorded in the task timing data with its phase, worker, start and end times, elapsed time, restart and deferral counts, the patch driver files applied in the session, and the command that ran. Applications DBA teams use it after a patch cycle to find the jobs that dominated the downtime window, so they can decide which phases to tune, which workers to rebalance and which jobs to investigate before the next maintenance window. Blitz Report™ runs it in Excel, so the sessions can be sorted, filtered and charted.

### Business Challenge
*   **Long patching windows:** Patch cycles can run for hours, and the DBA needs to see which individual jobs consumed the most time.
*   **Parallel execution hides the cause:** Several workers run jobs concurrently, so the sum of job times is larger than the session's wall clock time, and the bottleneck is not visible from the session total alone.
*   **Restarts and deferrals:** Jobs that were restarted or deferred extend the window, and they need to be identified quickly.
*   **Comparing sessions:** Successive sessions for the same patch set need a consistent view of timing to show whether tuning has worked.

### The Solution
*   Reads each job from `AD_TASK_TIMING` and attaches the patch driver file names applied in the same session, taken from `AD_PATCH_RUNS` and `AD_PATCH_DRIVERS`.
*   Calculates each job's Session Percentage with an analytic ratio-to-report over the session, so the largest contributors stand out.
*   Converts start and end times to client time, shows elapsed time as a readable duration and also as elapsed minutes for sorting.
*   Shows restart and deferral counts only when they are non-zero, and orders the output with the newest session first and the slowest job first within each session.

### Technical Architecture (High Level)
#### Primary Tables
*   `AD_TASK_TIMING`: one row per job in a patch session, with its worker, phase, program, arguments, timing, restart and defer counts, and command.
*   `AD_PATCH_RUNS`: links a patch session to the patch driver that it applied.
*   `AD_PATCH_DRIVERS`: the patch driver file names that make up the session's patch list.

#### Logical Relationships
1. An inline view joins `AD_PATCH_RUNS` to `AD_PATCH_DRIVERS` on PATCH_DRIVER_ID and groups by session, concatenating the driver file names with LISTAGG.
2. `AD_TASK_TIMING` is outer joined to that aggregate on SESSION_ID, so jobs without patch run records still appear.
3. An analytic RATIO_TO_REPORT partitioned by session computes the Session Percentage of each job's elapsed time.
4. The outer query applies the parameters and orders by session descending and elapsed time descending, with nulls last.

### Parameters & Filtering
*   **Session Id:** restricts the report to one adpatch, adop or upgrade session.
*   **Elapsed Minutes From:** a lower bound on elapsed minutes, so only the longer-running jobs are listed.
*   **Phase Name like:** filters jobs by phase name using a pattern match.

### Performance & Optimization
*   The patch driver names are aggregated once per session in the inline view, so the concatenation runs over the patch records only once for each session rather than once per job row.
*   The session percentage uses a single analytic function over the timing rows, which avoids a second pass over `AD_TASK_TIMING` to compute the session totals.
*   The outer join to the patch aggregate keeps every timing row, so no job is lost when patch metadata is missing.
*   Sorting on session and elapsed time happens in the final query, so the largest jobs in each session appear first without a separate filtering step.

### FAQ
**Q: How do I find the slowest jobs in an adop patch session?**
A: Enter the Session Id, leave the other parameters blank, and the jobs are listed with the slowest first, together with their Session Percentage.

**Q: Why do the job times add up to more than the patch took?**
A: Jobs run in parallel across several workers, so the session's wall clock time is shorter than the sum of the elapsed times of all its jobs.

**Q: Which patches were applied in a session?**
A: The Patches column lists the driver file names linked to the session through `AD_PATCH_RUNS` and `AD_PATCH_DRIVERS`, separated by commas.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ad-patch-task-timing)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
