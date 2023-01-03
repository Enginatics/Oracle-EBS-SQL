/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Tablespace Usage
-- Description: Tablespace usage including currently active undo and temp tablepace usage in Megabytes
-- Excel Examle Output: https://www.enginatics.com/example/dba-tablespace-usage/
-- Library Link: https://www.enginatics.com/reports/dba-tablespace-usage/
-- Run Report: https://demo.enginatics.com/

select
dt.contents,
dtum.tablespace_name,
vp.value*dtum.used_space/1000000 data_size,
ddf.bytes/1000000 file_size,
(ddf.bytes-vp.value*dtum.used_space)/1000000 unused_file_size,
vp.value*dtum.used_space/ddf.bytes*100 file_used_percent,
vp.value*dtum.tablespace_size/1000000 max_extensible_size,
dtum.used_percent max_used_percent,
nvl(due.active,(select vp.value*vss.used_blocks/1000000 from v$sort_segment vss where dt.tablespace_name=vss.tablespace_name)) active,
due.unexpired_undo,
due.expired_undo
from
dba_tablespaces dt,
(select vp.value from v$parameter vp where vp.name like 'db_block_size') vp,
dba_tablespace_usage_metrics dtum,
(
select distinct ddf.tablespace_name, sum(ddf.bytes) over (partition by ddf.tablespace_name) bytes from dba_data_files ddf union all
select distinct dtf.tablespace_name, sum(dtf.bytes) over (partition by dtf.tablespace_name) bytes from dba_temp_files dtf
) ddf,
(
select
*
from
(select distinct due.tablespace_name, due.status, sum(due.blocks) over (partition by due.tablespace_name,due.status)*8192/1000000 space from dba_undo_extents due) due
pivot (
sum(due.space)
for status in (
'ACTIVE' active,
'UNEXPIRED' unexpired_undo,
'EXPIRED' expired_undo
)
)
) due
where
dt.tablespace_name=dtum.tablespace_name and
dt.tablespace_name=ddf.tablespace_name(+) and
dt.tablespace_name=due.tablespace_name(+)
order by
dt.contents,
dtum.used_space desc