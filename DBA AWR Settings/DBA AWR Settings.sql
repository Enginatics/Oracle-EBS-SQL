/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR Settings
-- Description: Automatic workload repository settings such as retention period, snapshot interval and number of top SQLs to capture.
topnsql=DEFAULT means the database captures the top 30 SQLs from 5 different categories (Elapsed Time, CPU Time, Parse Calls, Shareable Memory, Version Count) for each snapshot interval.
So the default setting would capture a maximum of 150 different SQLs per snapshot, depending on system load.

Settings are modified by package dbms_workload_repository where interval parameters passed are specified in minutes.
Example: A 35 days retention with snapshot intervals of 30 minutes and 50 top SQLs captured is set as follows:

exec dbms_workload_repository.modify_snapshot_settings (retention=>35*1440, interval=>30, topnsql=>50);

A common problem is that AWR records are not getting purged, see Oracle note 1292724.1.
If column 'Orphan Sess History Count' is bigger than zero, then orphan records not belonging to the current DB's snapshots should get purged either 'manually' table by table:

delete /*+ parallel(x 4) */ from wrh$_active_session_history wash where (wash.dbid, wash.instance_number, wash.snap_id) not in (select ws.dbid, ws.instance_number, ws.snap_id from wrm$_snapshot ws)
alter table wrh$_active_session_history shrink space cascade;

or by a generic script:

begin
for c in (
select x.* from (
select distinct
dt.num_rows,
dt.row_movement,
dtc.table_name,
listagg(dtc.column_name,', ') within group (order by dtc.column_name) over (partition by dtc.table_name) table_columns,
count(*) over (partition by dtc.table_name) column_count
from
dba_tables dt,
dba_tab_columns dtc
where
dt.owner=dtc.owner and
dt.table_name=dtc.table_name and
dtc.owner='SYS' and
dtc.table_name like 'WRH$\_%' escape '\' and
dtc.column_name in ('DBID','INSTANCE_NUMBER','SNAP_ID')
) x
where
x.table_columns in ('DBID, INSTANCE_NUMBER, SNAP_ID','DBID, SNAP_ID')
order by
x.num_rows desc
) loop
  if c.table_columns='DBID, INSTANCE_NUMBER, SNAP_ID' then
    execute immediate '
    delete /*+ parallel(x 4) */
    '||c.table_name||' x
    where
    x.dbid is not null and
    x.instance_number is not null and
    x.snap_id is not null and
    (x.dbid, x.instance_number, x.snap_id) not in (select ws.dbid, ws.instance_number, ws.snap_id from wrm$_snapshot ws)';
    dbms_output.put_line(sql%rowcount||' records deleted from '||c.table_name);
  elsif c.table_columns='DBID, SNAP_ID' then
    execute immediate '
    delete /*+ parallel(x 4) */
    '||c.table_name||' x
    where
    x.dbid is not null and
    x.snap_id is not null and
    (x.dbid, x.snap_id) not in (select ws.dbid, ws.snap_id from wrm$_snapshot ws)';
    dbms_output.put_line(sql%rowcount||' records deleted from '||c.table_name);
  end if;
  if c.row_movement='ENABLED' then
    execute immediate 'alter table '||c.table_name||' shrink space cascade';
    dbms_output.put_line(c.table_name||' shrinked');
  end if;
  commit;
end loop;
end;

To purge obsolete data from old DBIDs:
http://www.strategicdbs.com/p/removing-old-dbid-data.html

begin
for c in (select distinct dfus.dbid from dba_feature_usage_statistics dfus where dfus.dbid not in (select vd.dbid from v$database vd)) loop
 dbms_swrf_internal.unregister_database(c.dbid);
end loop;
delete wri$_dbu_usage_sample wdus where wdus.dbid not in (select vd.dbid from v$database vd);
delete wri$_dbu_feature_usage wdfu where wdfu.dbid not in (select vd.dbid from v$database vd);
delete wri$_dbu_high_water_mark wdhwm where wdhwm.dbid not in (select vd.dbid from v$database vd);
delete wri$_dbu_cpu_usage wdcu where wdcu.dbid not in (select vd.dbid from v$database vd);
delete wri$_dbu_cpu_usage_sample wdcus where wdcus.dbid not in (select vd.dbid from v$database vd);
commit;
end;
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-settings/
-- Library Link: https://www.enginatics.com/reports/dba-awr-settings/
-- Run Report: https://demo.enginatics.com/

select
vd.name database,
dhdi.host_name,
dhdi.instance_name,
case when extract(day from wwc.retention)>0 then extract(day from wwc.retention)||'d ' end||
case when extract(hour from wwc.retention)>0 then extract(hour from wwc.retention)||'h ' end||
case when extract(minute from wwc.retention)>0 then extract(minute from wwc.retention)||'m ' end||
case when extract(second from wwc.retention)>0 then extract(second from wwc.retention)||'s' end retention,
case when extract(day from wwc.snap_interval)>0 then extract(day from wwc.snap_interval)||'d ' end||
case when extract(hour from wwc.snap_interval)>0 then extract(hour from wwc.snap_interval)||'h ' end||
case when extract(minute from wwc.snap_interval)>0 then extract(minute from wwc.snap_interval)||'m ' end||
case when extract(second from wwc.snap_interval)>0 then extract(second from wwc.snap_interval)||'s' end snap_interval,
decode (wwc.topnsql,2000000000,'DEFAULT',2000000001,'MAXIMUM',to_char(wwc.topnsql,'999999999')) topnsql,
(select count(*) from dba_hist_snapshot dhs where dhdi.dbid=dhs.dbid and dhdi.instance_number=dhs.instance_number) snapshot_count,
(select count(*) from dba_hist_sqlstat dhss where dhdi.dbid=dhss.dbid and dhdi.instance_number=dhss.instance_number) sqlstat_count,
(select count(*) from sys.wrh$_active_session_history wash where (wash.dbid, wash.instance_number, wash.snap_id) in (select ws.dbid, ws.instance_number, ws.snap_id from sys.wrm$_snapshot ws where dhdi.dbid=ws.dbid and dhdi.instance_number=ws.instance_number)) active_sess_history_count,
(select count(*) from sys.wrh$_active_session_history wash where (wash.dbid, wash.instance_number, wash.snap_id) not in (select ws.dbid, ws.instance_number, ws.snap_id from sys.wrm$_snapshot ws where dhdi.dbid=ws.dbid)) orphan_sess_history_count,
(select count(*) from sys.wrh$_sysmetric_history wsh where (wsh.dbid, wsh.instance_number, wsh.snap_id) not in (select ws.dbid, ws.instance_number, ws.snap_id from sys.wrm$_snapshot ws where dhdi.dbid=ws.dbid)) orphan_sysmetric_history_count,
xxen_util.client_time(dhdi.startup_time) startup_time,
xxen_util.client_time(wwc.most_recent_snap_time) most_recent_snap_time,
xxen_util.client_time(wwc.most_recent_purge_time) most_recent_purge_time
from
v$database vd,
sys.wrm$_wr_control wwc,
(select x.* from (select max(dhdi.startup_time) over (partition by dhdi.dbid, dhdi.instance_number) max_startup_time, dhdi.* from dba_hist_database_instance dhdi) x where x.startup_time=x.max_startup_time) dhdi
where
vd.dbid=wwc.dbid and
wwc.dbid=dhdi.dbid(+)
order by
dhdi.startup_time desc