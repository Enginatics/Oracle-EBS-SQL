/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR Settings
-- Description: Automatic workload repository settings such as retention period, snapshot interval and number of top SQLs to capture (from table underlying the view dbahistwrcontrol).
-- Note that for executing Blitz Report queries on AWR data, you require a Diagnostic pack license as explained in Oracle's note KB136730:
-- https://support.oracle.com/support/?kmContentId=1490798
-- topnsql=DEFAULT means the database captures the top 30 SQLs from 5 different categories (Elapsed Time, CPU Time, Parse Calls, Shareable Memory, Version Count) for each snapshot interval.
-- So the default setting would capture a maximum of 150 different SQLs per snapshot, depending on system load.
-- Settings are modified by package dbmsworkloadrepository where interval parameters passed are specified in minutes.
-- Example: A 35 days retention with snapshot intervals of 30 minutes and 50 top SQLs captured is set as follows:
-- exec dbmsworkloadrepository.modifysnapshotsettings (retention=>351440, interval=>30, topnsql=>50);
-- A common problem is that AWR records are not getting purged, see Oracle note 1292724.1.
-- If column 'Orphan Sess History Count' is bigger than zero, then orphan records not belonging to the current DB's snapshots should get purged either 'manually' table by table:
-- delete /+ parallel(x 4) / from wrh$activesessionhistory wash where (wash.dbid, wash.instancenumber, wash.snapid) not in (select ws.dbid, ws.instancenumber, ws.snapid from wrm$snapshot ws)
-- alter table wrh$activesessionhistory shrink space cascade;
-- or by a generic script:
-- begin
-- for c in (
-- select x. from (
-- select distinct
-- dt.numrows,
-- dt.rowmovement,
-- dtc.tablename,
-- listagg(dtc.columnname,', ') within group (order by dtc.columnname) over (partition by dtc.tablename) tablecolumns,
-- count() over (partition by dtc.tablename) columncount
-- from
-- dbatables dt,
-- dbatabcolumns dtc
-- where
-- dt.owner=dtc.owner and
-- dt.tablename=dtc.tablename and
-- dtc.owner='SYS' and
-- dtc.tablename like 'WRH$\%' escape '\' and
-- dtc.columnname in ('DBID','INSTANCENUMBER','SNAPID')
-- ) x
-- where
-- x.tablecolumns in ('DBID, INSTANCENUMBER, SNAPID','DBID, SNAPID')
-- order by
-- x.numrows desc
-- ) loop
-- if c.tablecolumns='DBID, INSTANCENUMBER, SNAPID' then
-- execute immediate '
-- delete /+ parallel(x 4) /
-- '||c.tablename||' x
-- where
-- x.dbid is not null and
-- x.instancenumber is not null and
-- x.snapid is not null and
-- (x.dbid, x.instancenumber, x.snapid) not in (select ws.dbid, ws.instancenumber, ws.snapid from wrm$snapshot ws)';
-- dbmsoutput.putline(sql%rowcount||' records deleted from '||c.tablename);
-- elsif c.tablecolumns='DBID, SNAPID' then
-- execute immediate '
-- delete /+ parallel(x 4) /
-- '||c.tablename||' x
-- where
-- x.dbid is not null and
-- x.snapid is not null and
-- (x.dbid, x.snapid) not in (select ws.dbid, ws.snapid from wrm$snapshot ws)';
-- dbmsoutput.putline(sql%rowcount||' records deleted from '||c.tablename);
-- end if;
-- if c.rowmovement='ENABLED' then
-- execute immediate 'alter table '||c.tablename||' shrink space cascade';
-- dbmsoutput.putline(c.tablename||' shrinked');
-- end if;
-- commit;
-- end loop;
-- end;
-- To purge obsolete data from old DBIDs:
-- http://www.strategicdbs.com/p/removing-old-dbid-data.html
-- begin
-- for c in (select distinct dfus.dbid from dbafeatureusagestatistics dfus where dfus.dbid not in (select vd.dbid from v$database vd)) loop
-- dbmsswrfinternal.unregisterdatabase(c.dbid);
-- end loop;
-- delete wri$dbuusagesample wdus where wdus.dbid not in (select vd.dbid from v$database vd);
-- delete wri$dbufeatureusage wdfu where wdfu.dbid not in (select vd.dbid from v$database vd);
-- delete wri$dbuhighwatermark wdhwm where wdhwm.dbid not in (select vd.dbid from v$database vd);
-- delete wri$dbucpuusage wdcu where wdcu.dbid not in (select vd.dbid from v$database vd);
-- delete wri$dbucpuusagesample wdcus where wdcus.dbid not in (select vd.dbid from v$database vd);
-- commit;
-- end;
-- Excel Example Output: https://www.enginatics.com/example/dba-awr-settings/
-- Library Link: https://www.enginatics.com/reports/dba-awr-settings/
-- Run Report: https://demo.enginatics.com/

select
sys_context('userenv','db_name') database,
dhdi.host_name,
dhdi.instance_name,
case when extract(day from dhwc.retention)>0 then extract(day from dhwc.retention)||'d ' end||
case when extract(hour from dhwc.retention)>0 then extract(hour from dhwc.retention)||'h ' end||
case when extract(minute from dhwc.retention)>0 then extract(minute from dhwc.retention)||'m ' end||
case when extract(second from dhwc.retention)>0 then extract(second from dhwc.retention)||'s' end retention,
case when extract(day from dhwc.snap_interval)>0 then extract(day from dhwc.snap_interval)||'d ' end||
case when extract(hour from dhwc.snap_interval)>0 then extract(hour from dhwc.snap_interval)||'h ' end||
case when extract(minute from dhwc.snap_interval)>0 then extract(minute from dhwc.snap_interval)||'m ' end||
case when extract(second from dhwc.snap_interval)>0 then extract(second from dhwc.snap_interval)||'s' end snap_interval,
dhwc.topnsql,
dhs.count snapshot_count,
(select count(*) from dba_hist_sqlstat dhss where dhdi.dbid=dhss.dbid and dhdi.instance_number=dhss.instance_number) sqlstat_count,
(select count(*) from dba_hist_active_sess_history dhash where (dhash.dbid, dhash.instance_number, dhash.snap_id) in (select dhs.dbid, dhs.instance_number, dhs.snap_id from dba_hist_snapshot dhs where dhdi.dbid=dhs.dbid and dhdi.instance_number=dhs.instance_number)) active_sess_history_count,
(select count(*) from sys.wrh$_active_session_history wash where (wash.dbid, wash.instance_number, wash.snap_id) not in (select ws.dbid, ws.instance_number, ws.snap_id from sys.wrm$_snapshot ws where dhdi.dbid=ws.dbid)) orphan_sess_history_count,
(select count(*) from sys.wrh$_sysmetric_history wsh where (wsh.dbid, wsh.instance_number, wsh.snap_id) not in (select ws.dbid, ws.instance_number, ws.snap_id from sys.wrm$_snapshot ws where dhdi.dbid=ws.dbid)) orphan_sysmetric_history_count,
xxen_util.client_time(dhs.startup_time) startup_time,
xxen_util.client_time(dhs.most_recent_snap_time) most_recent_snap_time,
dhdi.dbid
from
dba_hist_wr_control dhwc,
v$database vd,
(select x.* from (select max(dhdi.startup_time) over (partition by dhdi.dbid, dhdi.instance_number) max_startup_time, dhdi.* from dba_hist_database_instance dhdi) x where x.startup_time=x.max_startup_time) dhdi,
(
select distinct
dhs.dbid,
dhs.instance_number,
count(*) over (partition by dhs.dbid, dhs.instance_number) count,
max(dhs.startup_time) over (partition by dhs.dbid, dhs.instance_number) startup_time,
max(dhs.end_interval_time) over (partition by dhs.dbid, dhs.instance_number) most_recent_snap_time
from
dba_hist_snapshot dhs
) dhs
where
1=1 and
dhwc.dbid=dhdi.dbid(+) and
dhdi.dbid=dhs.dbid(+) and
dhdi.instance_number=dhs.instance_number(+)
order by
dhdi.startup_time desc
