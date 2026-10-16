---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Profiler Data | Oracle EBS SQL Report'
description: 'Excel version of Oracle''s dbmsprofiler PLSQL performance analysis, see Oracle note: Using DBMSPROFILER (KB85737)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, R12 only, DBA, Profiler, Data, dba_source, plsql_profiler_runs'
permalink: /DBA%20Profiler%20Data/
report_name: 'DBA Profiler Data'
report_web_name: dba-profiler-data
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Profiler Data – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-profiler-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Excel version of Oracle's dbms_profiler PLSQL performance analysis, see Oracle note:
Using DBMS_PROFILER (KB85737)
<a href="https://support.oracle.com/support/?kmContentId=97270" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=97270</a>

PL/SQL units that have been compiled in NATIVE mode cannot be profiled using the DBMS_PROFILER package.
To gather information using DBMS_PROFILER, you must ensure that the PL/SQL code is INTERPRETED."
Before compilation of the profiled code, execute:
alter session set plsql_code_type=interpreted;

To start and stop profiling code, use the following commands (see use <a href="https://docs.oracle.com/cd/B19306_01/appdev.102/b14258/d_profil.htm#i1000047" rel="nofollow" target="_blank">https://docs.oracle.com/cd/B19306_01/appdev.102/b14258/d_profil.htm#i1000047</a>):
dbms_profiler.start_profiler(optional run_comment);
dbms_profiler.stop_profiler;

To purge and reset the profiler data, execute the following as sys:
truncate table sys.plsql_profiler_data;
truncate table sys.plsql_profiler_units;
truncate table sys.plsql_profiler_runs;
alter sequence plsql_profiler_runnumber restart start with 1;

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Run Id, Module, Time From, Percentage From, Line Text Contains, Line Number From, Line Number To, Time Unit

## Oracle EBS Tables Used
[dba_source](https://www.enginatics.com/library/?pg=1&find=dba_source&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data), [plsql_profiler_runs](https://www.enginatics.com/library/?pg=1&find=plsql_profiler_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data)

## Related Reports
[DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Hierarchical Profiler Data](/DBA%20Hierarchical%20Profiler%20Data/ "DBA Hierarchical Profiler Data Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Profiler%20Data/DBA%20Profiler%20Data.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Profiler Data 14-Dec-2025 081549.xlsx](https://www.enginatics.com/example/dba-profiler-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data) |
| Blitz Report™ XML Import | [DBA_Profiler_Data.xml](https://www.enginatics.com/xml/dba-profiler-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data) |
| SQL Source | [DBA Profiler Data.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Profiler%20Data/DBA%20Profiler%20Data.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-profiler-data/](https://www.enginatics.com/reports/dba-profiler-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data) |

## Case Study & Technical Analysis: DBA Profiler Data

### Executive Summary
This report presents the output of Oracle's DBMS_PROFILER PL/SQL performance profiler in Excel. It shows each profiled run with its total elapsed time, the PL/SQL time, and for every program unit and source line the number of calls, the time spent and the share of the run. The source text of each line is retrieved from the data dictionary, so the performance analyst sees the code next to its cost. Database administrators and Oracle EBS technical consultants use it to find the custom or seeded PL/SQL that dominates a slow process. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Slow custom code:** Long-running EBS concurrent programs and custom packages often hide their cost in a few lines of PL/SQL.
*   **Raw profiler tables:** The profiler tables store run, unit and line data in separate tables that are hard to read without joins.
*   **Missing source context:** A line number means little without the code it refers to, and the source must be fetched from the dictionary.
*   **Repeat analysis:** Comparing runs before and after a change requires consistent figures for each run.

### The Solution
*   **Run summary:** Each run carries its run date, total elapsed time and PL/SQL time, so runs can be compared directly.
*   **Unit and line detail:** Each line shows its unit, number of calls, total time and percentage of the run's PL/SQL time.
*   **Source text:** A function retrieves the text of each profiled line from the dictionary source view.
*   **Time units:** The Time Unit parameter presents times in seconds or microseconds.
*   **Ranking:** Rows are ordered by run, then by time descending, so the most expensive lines appear first.

### Technical Architecture (High Level)
#### Primary Tables
*   `PLSQL_PROFILER_RUNS`: one row per profiling run, with run date, run comment and total elapsed time.
*   `PLSQL_PROFILER_UNITS`: one row per profiled program unit within a run, with unit type, owner and name.
*   `PLSQL_PROFILER_DATA`: one row per source line within a unit, with calls, total time and line number.
*   `DBA_SOURCE`: the source text of each program unit, read through the line-text function.

#### Logical Relationships
1. `PLSQL_PROFILER_RUNS` joins to `PLSQL_PROFILER_UNITS` on run id.
2. `PLSQL_PROFILER_UNITS` joins to `PLSQL_PROFILER_DATA` on run id and unit number.
3. Each line's text is returned by a function that matches the unit type, owner, name and line number in `DBA_SOURCE`.
4. Percentage and PL/SQL time are computed as analytic windows partitioned by run id over the line rows.

### Parameters & Filtering
*   **Run Id:** restricts the output to one profiling run.
*   **Module:** restricts the output to one program unit, given as owner and name.
*   **Time From:** keeps only lines whose time is at or above the value entered.
*   **Percentage From:** keeps only lines whose share of the run is at or above the value entered.
*   **Line Text Contains:** keeps only lines whose source text includes the search text.
*   **Line Number From / Line Number To:** bound the lines by their position in the program unit.
*   **Time Unit:** selects seconds or microseconds for all time values.

### Performance & Optimization
*   The time and percentage filters are applied after the analytic totals, so each percentage reflects the full run rather than the filtered rows.
*   The source lookup is a function on the dictionary source view that runs for each returned line, so the Module and Line Number filters should be used to limit the rows.
*   Results are ordered by run and time descending, so the most expensive lines of the latest run are at the top of the sheet.

### FAQ
**Q: Why is my PL/SQL profile empty?**
A: DBMS_PROFILER cannot profile units compiled in native mode. The code must be compiled as interpreted before profiling starts.

**Q: How do I start and stop profiling?**
A: Call the start and stop procedures of the DBMS_PROFILER package around the code under test, as described in Oracle note KB85737.

**Q: How do I clear old profiler data?**
A: The profiler tables are truncated and the run number sequence is restarted by a SYS user, as the report's description states.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-profiler-data)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
