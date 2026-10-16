---
layout: default
last_modified_at: 2026-10-16
title: 'DBA Hierarchical Profiler Data | Oracle EBS SQL Report'
description: 'Excel version of Oracle''s hierarchical profiler dbmshprof PLSQL performance analysis. PL/SQL units that have been compiled in NATIVE mode cannot be…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Database Administration, Enginatics, R12 only, DBA, Hierarchical, Profiler, Data, dba_source, dbmshp_runs, dbmshp_parent_child_info'
permalink: /DBA%20Hierarchical%20Profiler%20Data/
report_name: 'DBA Hierarchical Profiler Data'
report_web_name: dba-hierarchical-profiler-data
module: 'Database Administration'
module_url: /modules/database-administration/
---

# DBA Hierarchical Profiler Data – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-hierarchical-profiler-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data).
**Oracle EBS module:** [Database Administration](/modules/database-administration/ "Oracle EBS Database Administration reports") · [all Database Administration reports](/modules/database-administration/)  

## Overview
Excel version of Oracle's hierarchical profiler dbms_hprof PLSQL performance analysis.

PL/SQL units that have been compiled in NATIVE mode cannot be profiled.
To gather information, you must ensure that the PL/SQL code is INTERPRETED."
Before compilation of the profiled code, execute:
alter session set plsql_code_type=interpreted;


Create and setup access to profiler tables as sys:

exec dbms_hprof.create_tables(force_it=>true);
create public synonym dbmshp_trace_data for sys.dbmshp_trace_data;
create public synonym dbmshp_runs for sys.dbmshp_runs;
create public synonym dbmshp_function_info for sys.dbmshp_function_info;
create public synonym dbmshp_parent_child_info for sys.dbmshp_parent_child_info;
create public synonym dbmshp_runnumber for sys.dbmshp_runnumber;
create public synonym dbmshp_tracenumber for sys.dbmshp_tracenumber;
grant select, insert, update, delete on dbmshp_trace_data to public;
grant select, insert, update, delete on dbmshp_runs to public;
grant select, insert, update, delete on dbmshp_function_info to public;
grant select, insert, update, delete on dbmshp_parent_child_info to public;
grant select on dbmshp_runnumber to public;
grant select on dbmshp_tracenumber to public;


To start and stop profiling code, use the following commands:

declare
l_trace_id pls_integer;
l_sqlmonitor_clob clob;
l_runid pls_integer;
begin
  l_trace_id:=dbms_hprof.start_profiling;
  xxen_api.clear; --code to profile
  l_sqlmonitor_clob:=dbms_hprof.stop_profiling;
  l_runid:=dbms_hprof.analyze(l_trace_id);
end;


To purge and reset the profiler data, execute the following as sys:

truncate table dbmshp_parent_child_info;
truncate table dbmshp_function_info;
truncate table dbmshp_runs;
truncate table dbmshp_trace_data;
alter sequence dbmshp_runnumber restart start with 1;
alter sequence dbmshp_tracenumber restart start with 1;

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Run Id, Module, Time From, Percentage From, Line Text Contains, Line Number From, Line Number To, Time Unit

## Oracle EBS Tables Used
[dba_source](https://www.enginatics.com/library/?pg=1&find=dba_source&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data), [dbmshp_runs](https://www.enginatics.com/library/?pg=1&find=dbmshp_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data), [dbmshp_parent_child_info](https://www.enginatics.com/library/?pg=1&find=dbmshp_parent_child_info&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data)

## Related Reports
[DBA Profiler Data](/DBA%20Profiler%20Data/ "DBA Profiler Data Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Hierarchical%20Profiler%20Data/DBA%20Hierarchical%20Profiler%20Data.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Hierarchical Profiler Data 14-Dec-2025 080657.xlsx](https://www.enginatics.com/example/dba-hierarchical-profiler-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data) |
| Blitz Report™ XML Import | [DBA_Hierarchical_Profiler_Data.xml](https://www.enginatics.com/xml/dba-hierarchical-profiler-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data) |
| SQL Source | [DBA Hierarchical Profiler Data.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DBA%20Hierarchical%20Profiler%20Data/DBA%20Hierarchical%20Profiler%20Data.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dba-hierarchical-profiler-data/](https://www.enginatics.com/reports/dba-hierarchical-profiler-data/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data) |

## Case Study & Technical Analysis: DBA Hierarchical Profiler Data

### Executive Summary
The DBA Hierarchical Profiler Data report is an Excel view of the output of Oracle's hierarchical profiler, the `DBMS_HPROF` PL/SQL performance analysis package. It is written for database administrators and Oracle EBS technical teams who must find where PL/SQL code spends its time, for example a slow custom concurrent program, a form customisation or an API call. For each function in a profiled run, it shows the elapsed time, the share of total run time, the number of calls, the owning module, the line number and the source text.
### Business Challenge
*   **Locating PL/SQL hotspots:** When a customised process is slow, the DBA needs to know which function or line consumes the elapsed time, not only that the process is slow.
*   **Separating self time from subtree time:** Total time for a function includes the functions it calls, so the report must show both the function time and the subtree time to find the real cost.
*   **Tracing back to source:** The profiler records line numbers, and the team needs the source text at that line to act on the finding.

### The Solution
*   **Function-level breakdown:** Each function in a run is listed with its elapsed time, percentage of the run total, call count and owning module.
*   **Time units:** Elapsed times are converted from microseconds into seconds or milliseconds, as selected by the Time Unit parameter.
*   **Source text lookup:** A helper function reads the line of source from `DBA_SOURCE` for each profiled line, so the code appears next to its timing.
*   **Excel analysis:** Running the report through Blitz Report puts the profile into a sortable sheet for filtering by module, line or percentage.

### Technical Architecture (High Level)
#### Primary Tables
*   `DBA_SOURCE`: the PL/SQL source text, queried through a helper function to return the line that corresponds to each profiled line.
*   `DBMSHP_RUNS`: one row per profiling run, holding the run timestamp and total elapsed time.
*   `DBMSHP_FUNCTION_INFO`: one row per function per run, holding the function, module, SQL identifier, elapsed time, calls and line number.
*   `DBMSHP_PARENT_CHILD_INFO`: the parent and child relationships between profiled functions in each run.

#### Logical Relationships
1. `DBMSHP_RUNS` joins to `DBMSHP_FUNCTION_INFO` on the run identifier, giving each function the run date and total time.
2. The parent-child data is reduced to distinct run and parent symbol identifiers, then joined to the function rows as an outer join, so only functions with children show a subtree time.
3. The helper function looks up `DBA_SOURCE` by unit type, owner, name and line number, and returns the text of that line, or null if none is found.
4. The outer query sorts by run identifier descending and then by time descending, so the most expensive functions of the latest run appear first.

### Parameters & Filtering
*   **Run Id:** Restricts the output to one profiling run.
*   **Module:** Limits the functions to one PL/SQL unit, identified by its module name.
*   **Time From:** Filters the functions by elapsed time above a threshold.
*   **Percentage From:** Filters to functions whose share of the run total is at or above a given percentage.
*   **Line Text Contains:** Restricts the rows to those whose source line contains the given text.
*   **Line Number From and Line Number To:** Bound the source lines of the functions returned.
*   **Time Unit:** Selects whether elapsed time is shown in seconds or milliseconds, and the SQL divides the stored microsecond values accordingly.

### Performance & Optimization
*   **Run-scoped reading:** The profiler tables are read per run, and the run identifier is the natural filter for keeping the query to a single profile.
*   **Distinct parent-child reduction:** The parent-child table is collapsed to distinct run and parent identifiers before the join, which prevents the join from multiplying function rows.
*   **Analytic percentage:** The percentage of each function is computed with a window sum over the run identifier, so no second pass over the data is needed.

### FAQ
**Q: Why does my PL/SQL profile not show any functions?**
A: The description states that units compiled in NATIVE mode cannot be profiled. The code must be compiled with `plsqlcodetype=interpreted` before profiling starts.

**Q: What is the difference between the time and subtree time columns?**
A: Time is the elapsed time spent in the function itself, and subtree time is the inclusive time including the functions it calls, shown only where the function has children.

**Q: How do I stop the profiler data from accumulating?**
A: The description gives the purge steps: truncate the four profiler tables and restart the run and trace number sequences, as the SYS user.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dba-hierarchical-profiler-data)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
