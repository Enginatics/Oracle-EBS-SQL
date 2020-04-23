/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA AWR PGA History
-- Description: History of database PGA size and other statistics from v$pgastat in megabytes
-- Excel Examle Output: https://www.enginatics.com/example/dba-awr-pga-history
-- Library Link: https://www.enginatics.com/reports/dba-awr-pga-history
-- Run Report: https://demo.enginatics.com/


select * from (
select
xxen_util.client_time(dhs.end_interval_time) end_interval_time,
dhs.instance_number,
dhp.name,
case when dhp.name in (
'recompute count (total)',
'cache hit percentage',
'max processes count',
'process count'
) then dhp.value else dhp.value/1000000 end value_
from
dba_hist_snapshot dhs,
dba_hist_pgastat dhp
where
1=1 and
dhs.dbid=(select vd.dbid from v$database vd) and
dhs.dbid=dhp.dbid and
dhs.instance_number=dhp.instance_number and
dhs.snap_id=dhp.snap_id
)
pivot (
sum(value_) val
for
name in (
'aggregate PGA target parameter' aggr_pga_target,
'aggregate PGA auto target' aggr_pga_auto_target,
'bytes processed' bytes_processed,
'global memory bound' glob_mem_bound,
'total PGA allocated' total_pga_alloc,
'maximum PGA allocated' max_pga_alloc,
'PGA memory freed back to OS' pga_freed_back,
'total PGA inuse' total_pga_inuse,
'total freeable PGA memory' total_freeable_pga,
'maximum PGA used for auto workareas' max_pga_used_auto_workareas,
'recompute count (total)' recompute_count,
'cache hit percentage' "CACHE_HIT_%",
'max processes count' max_process_count,
'process count' process_count
)
)
order by
end_interval_time desc,
instance_number