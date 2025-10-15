/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR SQL Execution Plan History
-- Description: Execution plan history for a particular SQL id from the automatic workload repository
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-sql-execution-plan-history/
-- Library Link: https://www.enginatics.com/reports/dba-awr-sql-execution-plan-history/
-- Run Report: https://demo.enginatics.com/

select
dhsp.sql_id,
dhsp.plan_hash_value,
xxen_util.client_time(dhsp.timestamp) timestamp,
lpad(' ',dhsp.depth*2)||dhsp.operation||
case when dhsp.options is not null then ' '||dhsp.options end||
case when dhsp.object_name is not null then ' '||dhsp.object_type||' '||dhsp.object_owner||'.'||dhsp.object_name end operation,
dhsp.qblock_name query_block,
lpad(' ',dhsp.depth)||dhsp.depth depth,
dhsp.cardinality,
dhsp.bytes/1000000 mb,
dhsp.time,
dhsp.cost,
dhsp.cpu_cost,
dhsp.io_cost,
dhsp.id,
dhsp.parent_id,
ds.object_size
from
dba_hist_sql_plan dhsp,
(
select
ds.owner,
ds.segment_type,
ds.segment_name,
sum(ds.blocks)*(select vp.value from v$parameter vp where vp.name like 'db_block_size')/1000000 object_size
from
dba_segments ds
where
'&show_object_size'='Y'
group by
ds.owner,
ds.segment_type,
ds.segment_name
) ds
where
1=1 and
dhsp.object_owner=ds.owner(+) and
case when dhsp.object_type like '% %' then substr(dhsp.object_type,1,instr(dhsp.object_type,' ')) else dhsp.object_type end=ds.segment_type(+) and
dhsp.object_name=ds.segment_name(+)
order by
dhsp.sql_id,
dhsp.sql_id,
dhsp.timestamp desc,
dhsp.plan_hash_value,
dhsp.id,
dhsp.position