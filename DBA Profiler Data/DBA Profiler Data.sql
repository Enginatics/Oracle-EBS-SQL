/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Profiler Data
-- Description: Excel version of Oracle's dbms_profiler PLSQL performance analysis, see Oracle note:
Using DBMS_PROFILER (Doc ID 97270.1)
<a href="https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=97270.1" rel="nofollow" target="_blank">https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=97270.1</a>

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
-- Excel Examle Output: https://www.enginatics.com/example/dba-profiler-data/
-- Library Link: https://www.enginatics.com/reports/dba-profiler-data/
-- Run Report: https://demo.enginatics.com/

with
function ds_text(p_unit_type in varchar2, p_unit_owner in varchar2, p_unit_name in varchar2, p_line# pls_integer) return varchar2 is
begin
  for c in (select ds.text from dba_source ds where p_unit_type=ds.type and p_unit_owner=ds.owner and p_unit_name=ds.name and p_line#=ds.line) loop
    return c.text;
  end loop;
  return null;
end ds_text;
select x.* from ( 
select
ppr.runid,
ppr.run_date,
ppr.run_total_time/decode(:time_unit,'Seconds',1000000000,1000000) total_time,
sum(ppd.total_time) over (partition by ppd.runid)/decode(:time_unit,'Seconds',1000000000,1000000) plsql_time,
ppu.unit_type type,
ppu.unit_owner||'.'||ppu.unit_name module,
ppd.total_time*100/sum(ppd.total_time) over (partition by ppd.runid) percentage,
ppd.total_occur calls,
ppd.total_time/decode(:time_unit,'Seconds',1000000000,1000000) time,
ppd.line#,
ds_text(ppu.unit_type,ppu.unit_owner,ppu.unit_name,ppd.line#) line_text
from
plsql_profiler_runs ppr,
plsql_profiler_units ppu,
plsql_profiler_data ppd
where
1=1 and
ppr.runid=ppu.runid and
ppu.runid=ppd.runid and
ppu.unit_number=ppd.unit_number
) x
where
2=2
order by
x.runid desc,
x.time desc