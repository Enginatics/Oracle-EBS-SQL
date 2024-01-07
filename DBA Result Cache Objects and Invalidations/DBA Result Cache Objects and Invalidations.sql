/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: DBA Result Cache Objects and Invalidations
-- Description: Shows result cache objects with the current number cached results and their dependency on objects causing the most frequent invalidations.

Warning !!!
Don't run this on a prod system during business hours as prior to DB version 12.2, selecting from v$result_cache_objects apparently blocks all result cache objects (see note 2143739.1, section 4.).
You may end up with all server sessions waiting on 'latch free' for 'Result Cache: RC Latch' while the report is running.
-- Excel Examle Output: https://www.enginatics.com/example/dba-result-cache-objects-and-invalidations/
-- Library Link: https://www.enginatics.com/reports/dba-result-cache-objects-and-invalidations/
-- Run Report: https://demo.enginatics.com/

select
y.result_name,
y.results_count,
y.cache_id
&object_columns
from
(
select distinct
count(*) over (partition by grco.cache_id) results_count,
grco.name result_name,
x.object_type,
x.owner,
x.object_name,
x.invalidations,
max(x.invalidations) over (partition by grco.cache_id) max_invalidations,
grco.cache_id
from
gv$result_cache_objects grco,
(
select
grcd.result_id,
do.object_type,
do.owner,
do.object_name,
grco0.invalidations
from
gv$result_cache_dependency grcd,
gv$result_cache_objects grco0,
dba_objects do
where
1=1 and
'&show_invalidation_dependencies'='Y' and
grcd.depend_id=grco0.id and
grco0.invalidations>0 and
grco0.type='Dependency' and
grcd.object_no=do.object_id
) x
where
grco.status='Published' and
grco.type='Result' and
grco.id=x.result_id(+)
) y
order by
y.max_invalidations desc nulls last,
y.results_count desc nulls last,
y.result_name,
y.invalidations desc nulls last,
y.object_type,
y.owner,
y.object_name