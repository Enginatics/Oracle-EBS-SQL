/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Result Cache Statistics
-- Description: Result cache statistics with size values in MB.

If the 'Maximum Size' is big enough, 'Create Count Failure' should be zero or low, same as 'Delete Count Valid', which depicts the number of valid cache results flushed out.
'Find Count' shows the number of cached results used (instead of executing the underlying sql/plsql) and should hence be as high as possible for maximum performance improvement.

A high number of 'Invalidation Count' or 'Delete Count Invalid' relative to 'Find Count' should get investigated further as it indicates a result_cache specified for code where the underlying data changes too frequently.

alter system set result_cache_max_size=600M scope=both
-- Excel Examle Output: https://www.enginatics.com/example/dba-result-cache-statistics/
-- Library Link: https://www.enginatics.com/reports/dba-result-cache-statistics/
-- Run Report: https://demo.enginatics.com/

select
x.inst_id,
decode(x.name,
'Block Count Maximum','Maximum Size',
'Block Count Current','Current Size',
'Result Size Maximum (Blocks)','Result Size Maximum',
x.name) name,
case when x.name like '%Block%' then round(x.block_size*x.value/1000000,2) else to_number(x.value) end value
from
(
select
max(decode(grcs.name,'Block Size (Bytes)',grcs.value)) over () block_size,
grcs.inst_id,
grcs.id,
grcs.name,
grcs.value
from
gv$result_cache_statistics grcs
where
grcs.name not in ('Hash Chain Length')
union all
select distinct
null block_size,
grcs.inst_id,
8.5 id,
'Invalidation Percentage' name,
to_char(round(100*max(decode(grcs.name,'Invalidation Count',grcs.value)) over (partition by grcs.inst_id)/xxen_util.zero_to_null(max(decode(grcs.name,'Find Count',grcs.value)) over (partition by grcs.inst_id)),2)) value
from
gv$result_cache_statistics grcs
where
grcs.name in ('Find Count','Invalidation Count')
union all
select distinct
null block_size,
grcs.inst_id,
5.5 id,
'Creation Percentage' name,
to_char(round(100*max(decode(grcs.name,'Create Count Success',grcs.value)) over (partition by grcs.inst_id)/xxen_util.zero_to_null(max(decode(grcs.name,'Find Count',grcs.value)) over (partition by grcs.inst_id)),2)) value
from
gv$result_cache_statistics grcs
where
grcs.name in ('Create Count Success','Find Count')
) x
where x.name not in ('Block Size (Bytes)')
order by
x.inst_id,
x.id