# [DBA AWR Settings](https://www.enginatics.com/reports/dba-awr-settings/)
## Description: 
Automatic workload repository settings such as retention period, snapshot interval and number of top SQLs to capture.
Note that for executing Blitz Report queries on AWR data, you require a Diagnostic pack license as explained in Oracle's note 1490798.1:
https://support.oracle.com/CSP/main/article?cmd=show&type=NOT&id=1490798.1

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
## Categories: 
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic+Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [Toolkit - DBA](https://www.enginatics.com/library/?pg=1&category[]=Toolkit+-+DBA)
## Dependencies
If you would like to try one of these Oracle EBS SQLs without having Blitz Report installed, note that some of the reports require functions from utility package [xxen_util](https://www.enginatics.com/xxen_util/true).
# Report Example
[DBA_AWR_Settings 11-May-2017 125144.xlsx](https://www.enginatics.com/example/dba-awr-settings/)
# [Blitz Report™](https://www.enginatics.com/blitz-report/) import options
[DBA_AWR_Settings.xml](https://www.enginatics.com/xml/dba-awr-settings/)
# Oracle E-Business Suite [Reporting Library](https://www.enginatics.com/library/)
    
We provide an open source Oracle EBS SQLs as a part of operational and project implementation support [toolkits](https://www.enginatics.com/blitz-report-toolkits/) for rapid Excel reports generation. 

[Blitz Report™](https://www.enginatics.com/blitz-report/) is based on Oracle EBS forms technology, and hence requires minimal training. There are no data or performance limitations since the output files are created directly from the database without going through intermediate file formats such as XML. 

Blitz Report can be used as BI Publisher and [Oracle Discoverer replacement tool](https://www.enginatics.com/blog/discoverer-replacement/). Standard Oracle [BI Publisher](https://www.enginatics.com/user-guide/#BI_Publisher) and [Discoverer](https://www.enginatics.com/blog/importing-discoverer-worksheets-into-blitz-report/) reports can also be imported into Blitz Report for immediate output to Excel. Typically, reports can be created and version tracked within hours instead of days. The concurrent request output automatically opens upon completion without the need for re-formatting.

![Running Blitz Report](https://www.enginatics.com/wp-content/uploads/2018/01/Running-blitz-report.png) 

You can [download](https://www.enginatics.com/download/) and use Blitz Report [free](https://www.enginatics.com/pricing/) of charge for your first 30 reports.

The installation and implementation process usually takes less than 1 hour; you can refer to our [installation](https://www.enginatics.com/installation-guide/) and [user](https://www.enginatics.com/user-guide/) guides for specific details.

If you would like to optimize your Oracle EBS implementation and or operational reporting you can visit [www.enginatics.com](https://www.enginatics.com/) to review great ideas and example usage in [blog](https://www.enginatics.com/blog/). Or why not try for yourself in our [demo environment](http://demo.enginatics.com/).

© 2020 Enginatics