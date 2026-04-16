---
layout: default
title: 'DBA AWR Settings | Oracle EBS SQL Report'
description: 'Automatic workload repository settings such as retention period, snapshot interval and number of top SQLs to capture (from table underlying the view…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Diagnostic Pack, Enginatics, DBA, AWR, Settings, dba_hist_wr_control, v$database, dba_hist_database_instance'
permalink: /DBA%20AWR%20Settings/
---

# DBA AWR Settings – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dba-awr-settings/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Automatic workload repository settings such as retention period, snapshot interval and number of top SQLs to capture (from table underlying the view dba_hist_wr_control).
Note that for executing Blitz Report queries on AWR data, you require a Diagnostic pack license as explained in Oracle's note KB136730:
<a href="https://support.oracle.com/support/?kmContentId=1490798" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=1490798</a>

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
<a href="http://www.strategicdbs.com/p/removing-old-dbid-data.html" rel="nofollow" target="_blank">http://www.strategicdbs.com/p/removing-old-dbid-data.html</a>

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

## Report Parameters
Diagnostic Pack enabled, Container Data

## Oracle EBS Tables Used
[dba_hist_wr_control](https://www.enginatics.com/library/?pg=1&find=dba_hist_wr_control), [v$database](https://www.enginatics.com/library/?pg=1&find=v$database), [dba_hist_database_instance](https://www.enginatics.com/library/?pg=1&find=dba_hist_database_instance), [dba_hist_snapshot](https://www.enginatics.com/library/?pg=1&find=dba_hist_snapshot)

## Report Categories
[Diagnostic Pack](https://www.enginatics.com/library/?pg=1&category[]=Diagnostic%20Pack), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DBA SGA+PGA Memory Configuration](/DBA%20SGA-PGA%20Memory%20Configuration/ "DBA SGA+PGA Memory Configuration Oracle EBS SQL Report"), [DBA AWR System Metrics Summary](/DBA%20AWR%20System%20Metrics%20Summary/ "DBA AWR System Metrics Summary Oracle EBS SQL Report"), [DBA AWR Interconnect Traffic](/DBA%20AWR%20Interconnect%20Traffic/ "DBA AWR Interconnect Traffic Oracle EBS SQL Report"), [DBA AWR Tablespace Usage](/DBA%20AWR%20Tablespace%20Usage/ "DBA AWR Tablespace Usage Oracle EBS SQL Report"), [DBA AWR SQL Performance Summary](/DBA%20AWR%20SQL%20Performance%20Summary/ "DBA AWR SQL Performance Summary Oracle EBS SQL Report"), [DBA AWR Blocking Session Summary](/DBA%20AWR%20Blocking%20Session%20Summary/ "DBA AWR Blocking Session Summary Oracle EBS SQL Report"), [DBA AWR CPU vs Wait Time Summary](/DBA%20AWR%20CPU%20vs%20Wait%20Time%20Summary/ "DBA AWR CPU vs Wait Time Summary Oracle EBS SQL Report"), [DBA AWR Wait Class by Time](/DBA%20AWR%20Wait%20Class%20by%20Time/ "DBA AWR Wait Class by Time Oracle EBS SQL Report"), [DBA AWR Wait Event Summary](/DBA%20AWR%20Wait%20Event%20Summary/ "DBA AWR Wait Event Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DBA AWR Settings 11-May-2017 125144.xlsx](https://www.enginatics.com/example/dba-awr-settings/) |
| Blitz Report™ XML Import | [DBA_AWR_Settings.xml](https://www.enginatics.com/xml/dba-awr-settings/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dba-awr-settings/](https://www.enginatics.com/reports/dba-awr-settings/) |

## Executive Summary
The **DBA AWR Settings** report audits the configuration of the Automatic Workload Repository itself. AWR is the "black box flight recorder" of the Oracle database. Its effectiveness depends on how it is configured: how often it takes snapshots, how long it keeps them, and how many "Top SQL" statements it captures.

## Business Challenge
*   **Data Retention**: "We had a performance issue last month, but the AWR data is gone because retention is set to 8 days."
*   **Granularity**: "We missed a short spike because the snapshot interval is set to 1 hour instead of 15 minutes."
*   **Storage Growth**: "The SYSAUX tablespace is full because AWR is keeping too much data."

## Solution
This report displays the current AWR configuration parameters.

**Key Features:**
*   **Retention**: How long history is kept (e.g., 30 days).
*   **Interval**: Frequency of snapshots (e.g., 60 minutes).
*   **Top N SQL**: How many SQL statements are captured per snapshot (e.g., Top 30 by CPU).

## Architecture
The report queries the internal workload repository control tables.

**Key Tables:**
*   `DBA_HIST_WR_CONTROL`: Stores the AWR settings.

## Impact
*   **Observability**: Ensures that when a problem occurs, the necessary diagnostic data will be available.
*   **Space Management**: Helps balance the need for history against the storage cost of the SYSAUX tablespace.
*   **Compliance**: Verifies that retention policies meet internal audit requirements.


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
