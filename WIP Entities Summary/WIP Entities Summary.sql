/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Entities Summary
-- Description: Overview of WIP entities of different types and their various statuses.
-- Excel Examle Output: https://www.enginatics.com/example/wip-entities-summary/
-- Library Link: https://www.enginatics.com/reports/wip-entities-summary/
-- Run Report: https://demo.enginatics.com/

select /*+ parallel*/
count(*) count,
x.wo_exists,
x.wro_exists,
x.type,
x.job_type,
x.status,
x.wip_supply_type,
x.we_entity_type,
x.wdj_job_type,
x.wdj_status_type,
x.wdj_wip_supply_type
from
(
select
(select 'Y' from wip_operations wo where we.wip_entity_id=wo.wip_entity_id and we.organization_id=wo.organization_id and rownum=1) wo_exists,
(select 'Y' from wip_requirement_operations wro where we.wip_entity_id=wro.wip_entity_id and we.organization_id=wro.organization_id and rownum=1) wro_exists,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) type,
xxen_util.meaning(wdj.job_type,'WIP_DISCRETE_JOB',700) job_type,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) status,
xxen_util.meaning(wdj.wip_supply_type,'WIP_SUPPLY',700) wip_supply_type,
we.entity_type we_entity_type,
wdj.job_type wdj_job_type,
wdj.status_type wdj_status_type,
wdj.wip_supply_type wdj_wip_supply_type
from
wip_entities we,
wip_discrete_jobs wdj
where
1=1 and
we.wip_entity_id=wdj.wip_entity_id(+) and
we.organization_id=wdj.organization_id(+)
) x
group by
x.wo_exists,
x.wro_exists,
x.type,
x.job_type,
x.status,
x.wip_supply_type,
x.we_entity_type,
x.wdj_job_type,
x.wdj_status_type,
x.wdj_wip_supply_type
order by
count(*) desc