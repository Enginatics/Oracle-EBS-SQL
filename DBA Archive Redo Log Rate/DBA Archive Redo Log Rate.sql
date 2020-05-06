/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Archive / Redo Log Rate
-- Description: If the database is running in ARCHIVELOG mode, the amount of generated archive log is shown.
For databases on NOARCHIVELOG, the approximate amount of generated redo is calculated by the number of log switches per hour and log file size. Note that this log rate is just an approximated maximum as switches could also occur without the log files being full.

Redo log files are located here:
select * from sys.v_$logfile
-- Excel Examle Output: https://www.enginatics.com/example/dba-archive-redo-log-rate/
-- Library Link: https://www.enginatics.com/reports/dba-archive-redo-log-rate/
-- Run Report: https://demo.enginatics.com/

select
y.log_mode,
y.inst_id,
trim(to_char(xxen_util.client_time(y.time),'Day')) day_of_week,
xxen_util.client_time(y.time+1/24) time,
nvl(y.switch_count,0) switch_count,
nvl(y.bytes_per_hour/3600/1000000,0) mb_per_second,
nvl(y.bytes_per_hour/1000000,0) mb_per_hour,
nvl(sum(y.bytes_per_hour) over (partition by trunc(y.time))/1000000,0) mb_per_day
from
(
select
vd.log_mode,
x.inst_id,
x.time,
decode(vd.log_mode,'ARCHIVELOG',gal.file_count,glh.switch_count) switch_count,
decode(vd.log_mode,'ARCHIVELOG',gal.bytes_per_hour,gl.bytes*glh.switch_count) bytes_per_hour
from
v$database vd,
(
select
gi.inst_id,
x.time
from
(select trunc(sysdate,'hh24')-(level-1)/24 time from dual connect by level<=ceil(:days*24)) x,
gv$instance gi
) x,
(
select distinct
gal.inst_id,
trunc(gal.first_time,'hh24') time,
count(*) over (partition by gal.inst_id, trunc(gal.first_time,'hh24')) file_count,
sum(gal.blocks*gal.block_size) over (partition by gal.inst_id, trunc(gal.first_time,'hh24')) bytes_per_hour
from
gv$archived_log gal
) gal,
(
select distinct
glh.inst_id,
trunc(glh.first_time,'hh24') time,
count(distinct glh.recid) over (partition by glh.inst_id, trunc(glh.first_time,'hh24')) switch_count
from
gv$log_history glh
) glh,
gv$log gl
where
x.time=gal.time(+) and
x.inst_id=gal.inst_id(+) and
x.time=glh.time(+) and
x.inst_id=glh.inst_id(+) and
x.inst_id=gl.inst_id and
gl.status='CURRENT'
) y
order by
y.inst_id,
y.time desc