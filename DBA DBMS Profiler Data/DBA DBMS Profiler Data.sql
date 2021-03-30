/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA DBMS Profiler Data
-- Description: Excel version of Oracle's dbms_profiler PLSQL performance analysis, see Oracle note:
Using DBMS_PROFILER (Doc ID 97270.1)
https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=97270.1

PL/SQL units that have been compiled in NATIVE mode cannot be profiled using the DBMS_PROFILER package.
To gather information using DBMS_PROFILER, you must ensure that the PL/SQL code is INTERPRETED."
Before compilation of the profiled code, execute:
alter session set plsql_code_type=interpreted;

To start and stop profiling code, use the following commands (see use https://docs.oracle.com/cd/B19306_01/appdev.102/b14258/d_profil.htm#i1000047):
dbms_profiler.start_profiler(optional run_comment);
dbms_profiler.stop_profiler;
-- Excel Examle Output: https://www.enginatics.com/example/dba-dbms-profiler-data/
-- Library Link: https://www.enginatics.com/reports/dba-dbms-profiler-data/
-- Run Report: https://demo.enginatics.com/

select
ppr.runid,
ppr.run_date,
ppr.run_total_time/decode(:time_unit,'Seconds',1000000000,1000000) total_time,
sum(ppd.total_time) over (partition by ppd.runid)/decode(:time_unit,'Seconds',1000000000,1000000) plsql_time,
ppu.unit_type type,
ppu.unit_owner||'.'||ppu.unit_name name,
ppd.total_time*100/sum(ppd.total_time) over (partition by ppd.runid) percentage,
ppd.line#,
ppd.total_occur executions,
ppd.total_time/decode(:time_unit,'Seconds',1000000000,1000000) time,
(select ds.text from dba_source ds where ppu.unit_type=ds.type and ppu.unit_owner=ds.owner and ppu.unit_name=ds.name and ppd.line#=ds.line) line_text
from
plsql_profiler_runs ppr,
plsql_profiler_units ppu,
plsql_profiler_data ppd
where
1=1 and
ppr.runid=ppu.runid and
ppu.runid=ppd.runid and
ppu.unit_number=ppd.unit_number
order by
ppr.runid desc,
ppd.total_time desc