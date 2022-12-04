/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA SGA Buffer Cache Object Usage
-- Description: SGA buffer cache space usage by object names (in MB).
'Object Percentage' shows how much of one particular object is currently stored in the buffer cache.
100% means that the object is completely in the buffer cache.

Current SGA memory usage is also listed in views:
select * from v$sga
select * from v$sgainfo
select * from v$sga_dynamic_components

Arup Nanda gives a good explanation on how the buffer cache works:
<a href="http://arup.blogspot.ch/2014/11/cache-buffer-chains-demystified.html" rel="nofollow" target="_blank">http://arup.blogspot.ch/2014/11/cache-buffer-chains-demystified.html</a>
-- Excel Examle Output: https://www.enginatics.com/example/dba-sga-buffer-cache-object-usage/
-- Library Link: https://www.enginatics.com/reports/dba-sga-buffer-cache-object-usage/
-- Run Report: https://demo.enginatics.com/

with gb as
(
select /*+ materialize*/ distinct
gb.inst_id,
gb.objd,
count(*) over (partition by gb.inst_id, gb.objd, gb.status, gb.status_code, gb.dirty, gb.temp) blocks,
count(*) over (partition by gb.inst_id, gb.objd) object_blocks,
count(*) over (partition by gb.inst_id) total_blocks,
gb.status,
gb.status_code,
gb.dirty,
gb.temp
from
(
select
gb.inst_id,
gb.status status_code,
decode(gb.status,
'free','Not currently in use',
'xcur','Exclusive',
'scur','Shared current',
'cr','Consistent read',
'read','Being read from disk',
'mrec','In media recovery mode',
'irec','In instance recovery mode') status,
decode(gb.dirty,'Y','Y') dirty,
decode(gb.temp,'Y','Y') temp,
decode(gb.status,'free',null,gb.objd) objd
from
gv$bh gb
) gb
),
do as
(
select /*+ materialize*/ distinct
do.data_object_id,
min(do.owner) keep (dense_rank first order by do.object_id) over (partition by do.data_object_id) owner,
min(do.object_type) keep (dense_rank first order by do.object_id) over (partition by do.data_object_id) object_type,
listagg(do.object_name,', ') within group (order by do.object_name) over (partition by do.data_object_id) object_name
from
dba_objects do
where
do.data_object_id>0
),
ds as
(
select /*+ materialize*/
ds.owner,
ds.segment_type,
ds.segment_name,
sum(ds.blocks) blocks
from
dba_segments ds
group by
ds.owner,
ds.segment_type,
ds.segment_name
)
select
x.inst_id,
x.blocks/x.total_blocks*100 percentage,
x.owner,
x.object_type,
x.object_name,
x.blocks*vp.value/1000000 buffer_size,
x.blocks/ds.blocks*100 object_percentage
&columns2
from
(
select distinct
gb.inst_id,
do.owner,
do.object_type,
nvl(do.object_name,'------free------') object_name,
sum(gb.blocks) over (partition by gb.inst_id, do.owner, do.object_type, do.object_name &partition_by) blocks,
sum(gb.object_blocks) over (partition by gb.inst_id, do.owner, do.object_type, do.object_name) object_blocks,
gb.total_blocks
&columns1
from
gb,
do
where
gb.objd=do.data_object_id(+)
) x,
ds,
(select vp.value from v$parameter vp where vp.name like 'db_block_size') vp
where
x.owner=ds.owner(+) and
x.object_type=ds.segment_type(+) and
x.object_name=ds.segment_name(+)
order by
x.inst_id,
x.object_blocks desc,
x.blocks desc