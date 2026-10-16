/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Data Files
-- Description: Data and temp files per tablespace with their size, free space, autoextend settings and the space still available up to the maximum size.
-- All sizes are shown in MB.
-- Available Size and Max Used Percent take autoextend into account, so they show how close a file is to its real limit. Used and free space of temp files are shown by DBA Tablespace Usage.
-- In Backup Mode flags data files left in hot backup mode (alter tablespace ... begin backup).
-- Schedule the report with Max Used Percent From, for example 90, to get an email only when a data file is close to full.
-- Excel Example Output: https://www.enginatics.com/example/dba-data-files/
-- Library Link: https://www.enginatics.com/reports/dba-data-files/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
ddf.tablespace_name,
ddf.contents,
ddf.file_name,
ddf.file_id,
ddf.bytes/1000000 file_size,
(ddf.bytes-nvl(dfs.bytes,0))/1000000 used_size,
dfs.bytes/1000000 free_size,
(ddf.bytes-nvl(dfs.bytes,0))/xxen_util.zero_to_null(ddf.bytes)*100 used_percent,
xxen_util.yes(decode(ddf.autoextensible,'YES','Y')) autoextensible,
decode(ddf.autoextensible,'YES',ddf.maxbytes/1000000) max_size,
decode(ddf.autoextensible,'YES',ddf.increment_by*ddf.block_size/1000000) increment_size,
(decode(ddf.autoextensible,'YES',greatest(ddf.maxbytes,ddf.bytes),ddf.bytes)-ddf.bytes+nvl(dfs.bytes,0))/1000000 available_size,
(ddf.bytes-nvl(dfs.bytes,0))/xxen_util.zero_to_null(decode(ddf.autoextensible,'YES',greatest(ddf.maxbytes,ddf.bytes),ddf.bytes))*100 max_used_percent,
ddf.status,
ddf.online_status,
xxen_util.yes(decode(ddf.backup_status,'ACTIVE','Y')) in_backup_mode,
decode(ddf.backup_status,'ACTIVE',xxen_util.client_time(ddf.backup_time)) backup_mode_since
from
(
select /*+ no_merge*/
ddf.*,
dt.contents,
dt.block_size,
vb.status backup_status,
vb.time backup_time
from
(select /*+ no_merge*/ ddf.* from dba_data_files ddf) ddf,
dba_tablespaces dt,
v$backup vb
where
1=1 and
ddf.tablespace_name=dt.tablespace_name and
ddf.file_id=vb.file#(+)
) ddf,
(select /*+ no_merge*/ dfs.file_id, sum(dfs.bytes) bytes from dba_free_space dfs group by dfs.file_id) dfs
where
ddf.file_id=dfs.file_id(+)
union all
select
dtf.tablespace_name,
dt.contents,
dtf.file_name,
dtf.file_id,
dtf.bytes/1000000 file_size,
null used_size,
null free_size,
null used_percent,
xxen_util.yes(decode(dtf.autoextensible,'YES','Y')) autoextensible,
decode(dtf.autoextensible,'YES',dtf.maxbytes/1000000) max_size,
decode(dtf.autoextensible,'YES',dtf.increment_by*dt.block_size/1000000) increment_size,
(decode(dtf.autoextensible,'YES',greatest(dtf.maxbytes,dtf.bytes),dtf.bytes)-dtf.bytes)/1000000 available_size,
null max_used_percent,
dtf.status,
null online_status,
null in_backup_mode,
null backup_mode_since
from
dba_temp_files dtf,
dba_tablespaces dt
where
2=2 and
dtf.tablespace_name=dt.tablespace_name
) x
where
3=3
order by
x.tablespace_name,
x.file_name
