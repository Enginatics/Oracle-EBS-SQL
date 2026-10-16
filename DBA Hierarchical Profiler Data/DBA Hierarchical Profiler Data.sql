/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Hierarchical Profiler Data
-- Description: Excel version of Oracle's hierarchical profiler dbmshprof PLSQL performance analysis.
-- PL/SQL units that have been compiled in NATIVE mode cannot be profiled.
-- To gather information, you must ensure that the PL/SQL code is INTERPRETED."
-- Before compilation of the profiled code, execute:
-- alter session set plsqlcodetype=interpreted;
-- Create and setup access to profiler tables as sys:
-- exec dbmshprof.createtables(forceit=>true);
-- create public synonym dbmshptracedata for sys.dbmshptracedata;
-- create public synonym dbmshpruns for sys.dbmshpruns;
-- create public synonym dbmshpfunctioninfo for sys.dbmshpfunctioninfo;
-- create public synonym dbmshpparentchildinfo for sys.dbmshpparentchildinfo;
-- create public synonym dbmshprunnumber for sys.dbmshprunnumber;
-- create public synonym dbmshptracenumber for sys.dbmshptracenumber;
-- grant select, insert, update, delete on dbmshptracedata to public;
-- grant select, insert, update, delete on dbmshpruns to public;
-- grant select, insert, update, delete on dbmshpfunctioninfo to public;
-- grant select, insert, update, delete on dbmshpparentchildinfo to public;
-- grant select on dbmshprunnumber to public;
-- grant select on dbmshptracenumber to public;
-- To start and stop profiling code, use the following commands:
-- declare
-- ltraceid plsinteger;
-- lsqlmonitorclob clob;
-- lrunid plsinteger;
-- begin
-- ltraceid:=dbmshprof.startprofiling;
-- xxenapi.clear; --code to profile
-- lsqlmonitorclob:=dbmshprof.stopprofiling;
-- lrunid:=dbmshprof.analyze(ltraceid);
-- end;
-- To purge and reset the profiler data, execute the following as sys:
-- truncate table dbmshpparentchildinfo;
-- truncate table dbmshpfunctioninfo;
-- truncate table dbmshpruns;
-- truncate table dbmshptracedata;
-- alter sequence dbmshprunnumber restart start with 1;
-- alter sequence dbmshptracenumber restart start with 1;
-- Excel Example Output: https://www.enginatics.com/example/dba-hierarchical-profiler-data/
-- Library Link: https://www.enginatics.com/reports/dba-hierarchical-profiler-data/
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
dfi.runid,
cast(dr.run_timestamp as date) run_date,
dr.total_elapsed_time/decode(:time_unit,'Seconds',1000000,1000) total_time,
dfi.type,
dfi.owner||nvl2(dfi.module,'.'||dfi.module,null) module,
dfi.function,
dfi.sql_id,
dfi.function_elapsed_time*100/sum(dfi.function_elapsed_time) over (partition by dfi.runid) percentage,
dfi.calls,
nvl2(dpci.parentsymid,dfi.subtree_elapsed_time/decode(:time_unit,'Seconds',1000000,1000),null) subtree_time,
dfi.function_elapsed_time/decode(:time_unit,'Seconds',1000000,1000) time,
dfi.line#,
ds_text(dfi.type,dfi.owner,dfi.module,dfi.line#) line_text,
dfi.sql_text,
dfi.namespace,
dfi.symbolid,
dfi.hash
from
dbmshp_runs dr,
dbmshp_function_info dfi,
(select distinct dpci.runid, dpci.parentsymid from dbmshp_parent_child_info dpci) dpci
where
1=1 and
dr.runid=dfi.runid and
dr.runid=dpci.runid(+) and
dfi.symbolid=dpci.parentsymid(+)
) x
where
2=2
order by
x.runid desc,
x.time desc
