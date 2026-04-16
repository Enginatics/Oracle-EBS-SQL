/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Status Summary
-- Description: Project-level financial overview showing actual costs, revenue, labor hours, and commitments for each project with manager and status information.
-- Excel Examle Output: https://www.enginatics.com/example/pa-project-status-summary/
-- Library Link: https://www.enginatics.com/reports/pa-project-status-summary/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
ppa.project_type,
(select pps.project_status_name from pa_project_statuses pps where pps.project_status_code=ppa.project_status_code) project_status,
ppx.full_name project_manager,
(select haouv2.name from hr_all_organization_units_vl haouv2 where haouv2.organization_id=ppa.carrying_out_organization_id) project_organization,
ppa.start_date,
ppa.completion_date,
ppa.description project_description,
actuals.raw_cost actual_raw_cost,
actuals.burdened_cost actual_burdened_cost,
actuals.labor_hours actual_labor_hours,
actuals.revenue actual_revenue,
cmts.cmt_raw_cost commitment_raw_cost,
cmts.cmt_burdened_cost commitment_burdened_cost,
actuals.raw_cost+nvl(cmts.cmt_raw_cost,0) total_raw_cost,
actuals.burdened_cost+nvl(cmts.cmt_burdened_cost,0) total_burdened_cost,
ppa.project_currency_code,
ppa.project_id
from
pa_projects_all ppa,
hr_all_organization_units_vl haouv,
(select ppp.project_id, min(ppp.person_id) keep (dense_rank first order by ppp.start_date_active) person_id from pa_project_players ppp where ppp.project_role_type='PROJECT MANAGER' and sysdate between ppp.start_date_active and nvl(ppp.end_date_active,sysdate) group by ppp.project_id) pm,
per_people_x ppx,
(select ppah.project_id, sum(ppaa.raw_cost_itd) raw_cost, sum(ppaa.burdened_cost_itd) burdened_cost, sum(ppaa.labor_hours_itd) labor_hours, sum(ppaa.revenue_itd) revenue from pa_project_accum_actuals ppaa, pa_project_accum_headers ppah where ppah.project_accum_id=ppaa.project_accum_id and ppah.task_id=0 and ppah.resource_list_member_id=0 group by ppah.project_id) actuals,
(select ppah.project_id, sum(ppac.cmt_raw_cost_itd) cmt_raw_cost, sum(ppac.cmt_burdened_cost_itd) cmt_burdened_cost from pa_project_accum_commitments ppac, pa_project_accum_headers ppah where ppah.project_accum_id=ppac.project_accum_id and ppah.task_id=0 and ppah.resource_list_member_id=0 group by ppah.project_id) cmts
where
1=1 and
ppa.org_id=haouv.organization_id and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
ppa.project_id=pm.project_id(+) and
pm.person_id=ppx.person_id(+) and
ppa.project_id=actuals.project_id(+) and
ppa.project_id=cmts.project_id(+)
order by
haouv.name,
ppa.segment1