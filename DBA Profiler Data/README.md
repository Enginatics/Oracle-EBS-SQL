---
layout: default
title: 'DBA Profiler Data | Oracle EBS SQL Report'
description: 'Excel version of Oracle''s dbmsprofiler PLSQL performance analysis, see Oracle note: Using DBMSPROFILER (KB85737)…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Profiler, Data, plsql_profiler_runs, plsql_profiler_units, plsql_profiler_data'
permalink: /DBA%20Profiler%20Data/
---

# DBA Profiler Data – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-profiler-data/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Run Id, Module, Time From, Percentage From, Line Text Contains, Line Number From, Line Number To, Time Unit

## Oracle EBS Tables Used
[plsql_profiler_runs](https://www.enginatics.com/library/?pg=1&find=plsql_profiler_runs), [plsql_profiler_units](https://www.enginatics.com/library/?pg=1&find=plsql_profiler_units), [plsql_profiler_data](https://www.enginatics.com/library/?pg=1&find=plsql_profiler_data)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA SGA Blocking Session Summary](/DBA%20SGA%20Blocking%20Session%20Summary/ "DBA SGA Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR Active Session History](/DBA%20AWR%20Active%20Session%20History/ "DBA AWR Active Session History Oracle EBS SQL Report"), [DBA SGA Active Session History](/DBA%20SGA%20Active%20Session%20History/ "DBA SGA Active Session History Oracle EBS SQL Report"), [FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Profiler Data 14-Dec-2025 081549.xlsx](https://www.enginatics.com/example/dba-profiler-data/) |
| Blitz Report™ XML Import | [DBA_Profiler_Data.xml](https://www.enginatics.com/xml/dba-profiler-data/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-profiler-data/](https://www.enginatics.com/reports/dba-profiler-data/) |



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
