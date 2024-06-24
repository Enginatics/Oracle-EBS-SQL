/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Result Cache Object Dependencies
-- Description: Shows result cache objects with the current number cached results and their dependency on objects causing the most frequent invalidations.

Warning !!!
Don't run this on a prod system during business hours as prior to DB version 12.2, selecting from v$result_cache_objects apparently blocks all result cache objects (see note 2143739.1, section 4.).
You may end up with all server sessions waiting on 'latch free' for 'Result Cache: RC Latch' while the report is running.
-- Excel Examle Output: https://www.enginatics.com/example/dba-result-cache-object-dependencies/
-- Library Link: https://www.enginatics.com/reports/dba-result-cache-object-dependencies/
-- Run Report: https://demo.enginatics.com/

select distinct
count(*) over (partition by grco.cache_id) results_count,
grco.name result_name,
&object_columns
grco.cache_id
from
gv$result_cache_objects grco,
(
select
grcd.inst_id,
grcd.result_id,
grcd.depend_id,
do.object_type,
nvl(do.owner||nvl2(do.object_id,'.',null)||do.object_name,grco2.name) object,
grco2.invalidations
from
gv$result_cache_dependency grcd,
dba_objects do,
(select grco2.* from gv$result_cache_objects grco2) grco2
where
1=1 and
'&show_dependencies'='Y' and
grcd.object_no=do.object_id(+) and
grcd.inst_id=grco2.inst_id(+) and
grcd.depend_id=grco2.id(+)
) x
where
grco.status='Published' and
grco.type='Result' and
grco.inst_id=x.inst_id(+) and
grco.id=x.result_id(+)
order by
&order_by1
results_count desc,
grco.name
&order_by2