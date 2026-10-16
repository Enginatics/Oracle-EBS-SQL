---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Jobs | Oracle EBS SQL Report'
description: 'Oracle EBS Database Administration SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, DBA, Jobs, dba_jobs'
permalink: /DBA%20Jobs/
report_name: 'DBA Jobs'
report_web_name: dba-jobs
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Jobs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-jobs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[dba_jobs](https://www.enginatics.com/library/?pg=1&find=dba_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs)

## Related Reports
[DBA Scheduler Jobs](/DBA%20Scheduler%20Jobs/ "DBA Scheduler Jobs Oracle EBS SQL Report"), [DBA Undo Statistics](/DBA%20Undo%20Statistics/ "DBA Undo Statistics Oracle EBS SQL Report"), [DBA Text Search](/DBA%20Text%20Search/ "DBA Text Search Oracle EBS SQL Report"), [FND Document Sequence Assignments](/FND%20Document%20Sequence%20Assignments/ "FND Document Sequence Assignments Oracle EBS SQL Report"), [FND Lookup Search](/FND%20Lookup%20Search/ "FND Lookup Search Oracle EBS SQL Report"), [DBA Registry SQL Patch](/DBA%20Registry%20SQL%20Patch/ "DBA Registry SQL Patch Oracle EBS SQL Report"), [DBA Index Columns](/DBA%20Index%20Columns/ "DBA Index Columns Oracle EBS SQL Report"), [XLA Distribution Links Summary](/XLA%20Distribution%20Links%20Summary/ "XLA Distribution Links Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Jobs/DBA%20Jobs.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Jobs 22-Dec-2025 084233.xlsx](https://www.enginatics.com/example/dba-jobs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs) |
| Blitz Report™ XML Import | [DBA_Jobs.xml](https://www.enginatics.com/xml/dba-jobs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs) |
| SQL Source | [DBA Jobs.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Jobs/DBA%20Jobs.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-jobs/](https://www.enginatics.com/reports/dba-jobs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-jobs)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
