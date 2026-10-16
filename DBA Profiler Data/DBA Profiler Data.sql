/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Profiler Data
-- Description: Excel version of Oracle's dbmsprofiler PLSQL performance analysis, see Oracle note:
-- Using DBMSPROFILER (KB85737)
-- https://support.oracle.com/support/?kmContentId=97270
-- PL/SQL units that have been compiled in NATIVE mode cannot be profiled using the DBMSPROFILER package.
-- To gather information using DBMSPROFILER, you must ensure that the PL/SQL code is INTERPRETED."
-- Before compilation of the profiled code, execute:
-- alter session set plsqlcodetype=interpreted;
-- To start and stop profiling code, use the following commands (see use https://docs.oracle.com/cd/B1930601/appdev.102/b14258/dprofil.htmi1000047):
-- dbmsprofiler.startprofiler(optional runcomment);
-- dbmsprofiler.stopprofiler;
-- To purge and reset the profiler data, execute the following as sys:
-- truncate table sys.plsqlprofilerdata;
-- truncate table sys.plsqlprofilerunits;
-- truncate table sys.plsqlprofilerruns;
-- alter sequence plsqlprofilerrunnumber restart start with 1;
-- Excel Example Output: https://www.enginatics.com/example/dba-profiler-data/
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
