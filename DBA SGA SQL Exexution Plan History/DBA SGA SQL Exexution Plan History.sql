/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA SGA SQL Exexution Plan History
-- Description: Execution plan history for a particular SQL id from the SGA
-- Excel Examle Output: https://www.enginatics.com/example/dba-sga-sql-exexution-plan-history/
-- Library Link: https://www.enginatics.com/reports/dba-sga-sql-exexution-plan-history/
-- Run Report: https://demo.enginatics.com/

select
gsp.sql_id,
gsp.plan_hash_value,
gsp.timestamp,
lpad(' ',gsp.depth*2)||gsp.operation||
case when gsp.options is not null then ' '||gsp.options end||
case when gsp.object_name is not null then ' '||gsp.object_type||' '||gsp.object_owner||'.'||gsp.object_name end operation,
gsp.qblock_name query_block,
lpad(' ',gsp.depth)||gsp.depth depth,
gsp.cardinality,
gsp.bytes/1000000 mb,
gsp.time,
gsp.cost,
gsp.cpu_cost,
gsp.io_cost,
gsp.id,
gsp.parent_id,
ds.object_size
from
gv$sql_plan gsp,
(
select
ds.owner,
ds.segment_type,
ds.segment_name,
sum(ds.blocks)*(select vp.value from v$parameter vp where vp.name like 'db_block_size')/1000000 object_size
from
dba_segments ds
group by
ds.owner,
ds.segment_type,
ds.segment_name
) ds
where
1=1 and
gsp.object_owner=ds.owner(+) and
case when gsp.object_type like '% %' then substr(gsp.object_type,1,instr(gsp.object_type,' ')) else gsp.object_type end=ds.segment_type(+) and
gsp.object_name=ds.segment_name(+)
order by
gsp.sql_id,
gsp.timestamp desc,
gsp.plan_hash_value,
gsp.id,
gsp.position