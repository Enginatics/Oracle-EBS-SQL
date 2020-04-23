/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR Tablespace Usage
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-tablespace-usage
-- Library Link: https://www.enginatics.com/reports/dba-awr-tablespace-usage
-- Run Report: https://demo.enginatics.com/


select
x.*
from
(
select
to_char(xxen_util.client_time(to_date(dhtsu.rtime,'MM/DD/YYYY HH24:MI:SS')),'Day') day_of_week,
xxen_util.client_time(to_date(dhtsu.rtime,'MM/DD/YYYY HH24:MI:SS')) end_interval_time,
decode(ts.contents$,0,(decode(bitand (ts.flags, 16),16,'UNDO','PERMANENT')),1,'TEMPORARY') contents,
ts.name tablespace,
dhtsu.tablespace_usedsize*vp.value/1000000 used_size,
dhtsu.tablespace_size*vp.value/1000000 size_,
dhtsu.tablespace_maxsize*vp.value/1000000 max_size
from
(select vp.value from v$parameter vp where vp.name like 'db_block_size') vp,
v$database vd,
dba_hist_tbspc_space_usage dhtsu,
sys.ts$ ts
where
vd.dbid=dhtsu.dbid and
dhtsu.tablespace_id=ts.ts#
) x
where
1=1
order by
x.contents desc,
x.tablespace,
x.end_interval_time desc