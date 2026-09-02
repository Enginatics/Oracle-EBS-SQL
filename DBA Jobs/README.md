---
layout: default
title: 'DBA Jobs | Oracle EBS SQL Report'
description: ' – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Jobs, dba_jobs'
permalink: /DBA%20Jobs/
---

# DBA Jobs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-jobs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview


## Report Parameters


## Oracle EBS Tables Used
[dba_jobs](https://www.enginatics.com/library/?pg=1&find=dba_jobs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA Scheduler Jobs](/DBA%20Scheduler%20Jobs/ "DBA Scheduler Jobs Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [DBA Object Access Privileges](/DBA%20Object%20Access%20Privileges/ "DBA Object Access Privileges Oracle EBS SQL Report"), [DBA AWR Settings](/DBA%20AWR%20Settings/ "DBA AWR Settings Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA Segments](/DBA%20Segments/ "DBA Segments Oracle EBS SQL Report"), [DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Jobs 22-Dec-2025 084233.xlsx](https://www.enginatics.com/example/dba-jobs/) |
| Blitz Report™ XML Import | [DBA_Jobs.xml](https://www.enginatics.com/xml/dba-jobs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-jobs/](https://www.enginatics.com/reports/dba-jobs/) |

## Executive Summary
The **DBA Jobs** report monitors the legacy Oracle Job Scheduler (`DBMS_JOB`). While newer applications use `DBMS_SCHEDULER`, many older parts of Oracle E-Business Suite and custom legacy code still rely on `DBMS_JOB`. This report is essential for ensuring that these background tasks are running successfully.

## Business Challenge
*   **Silent Failures**: "The nightly interface didn't run, but no one got an email."
*   **Broken Jobs**: "Why is this job marked as 'Broken'?" (It failed 16 times in a row).
*   **Performance**: "Is this job taking longer and longer to run each night?"

## Solution
This report lists all jobs submitted via `DBMS_JOB`.

**Key Features:**
*   **Last Date/Time**: When the job last ran successfully.
*   **Next Date/Time**: When it is scheduled to run again.
*   **Failures**: The number of consecutive failures.
*   **What**: The PL/SQL block that the job executes.

## Architecture
The report queries `DBA_JOBS`.

**Key Tables:**
*   `DBA_JOBS`: The legacy job queue table.

## Impact
*   **Reliability**: Ensures critical background processes (like workflow background engines or materialized view refreshes) are active.
*   **Troubleshooting**: Quickly identifies jobs that have stopped running due to errors.
*   **Migration**: Helps inventory legacy jobs that should be migrated to the modern `DBMS_SCHEDULER`.


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
