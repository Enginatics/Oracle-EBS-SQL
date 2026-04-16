---
layout: default
title: 'DBA Hierarchical Profiler Data | Oracle EBS SQL Report'
description: 'Excel version of Oracle''s hierarchical profiler dbmshprof PLSQL performance analysis. PL/SQL units that have been compiled in NATIVE mode cannot be…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DBA, Hierarchical, Profiler, Data, dbmshp_runs, dbmshp_function_info, dbmshp_parent_child_info'
permalink: /DBA%20Hierarchical%20Profiler%20Data/
---

# DBA Hierarchical Profiler Data – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-hierarchical-profiler-data/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

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

## Report Parameters
Run Id, Module, Time From, Percentage From, Line Text Contains, Line Number From, Line Number To, Time Unit

## Oracle EBS Tables Used
[dbmshp_runs](https://www.enginatics.com/library/?pg=1&find=dbmshp_runs), [dbmshp_function_info](https://www.enginatics.com/library/?pg=1&find=dbmshp_function_info), [dbmshp_parent_child_info](https://www.enginatics.com/library/?pg=1&find=dbmshp_parent_child_info)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Concurrent Requests 11i](/FND%20Concurrent%20Requests%2011i/ "FND Concurrent Requests 11i Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Blitz Report ORDS Configuration](/DBA%20Blitz%20Report%20ORDS%20Configuration/ "DBA Blitz Report ORDS Configuration Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA Hierarchical Profiler Data 14-Dec-2025 080657.xlsx](https://www.enginatics.com/example/dba-hierarchical-profiler-data/) |
| Blitz Report™ XML Import | [DBA_Hierarchical_Profiler_Data.xml](https://www.enginatics.com/xml/dba-hierarchical-profiler-data/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-hierarchical-profiler-data/](https://www.enginatics.com/reports/dba-hierarchical-profiler-data/) |



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
