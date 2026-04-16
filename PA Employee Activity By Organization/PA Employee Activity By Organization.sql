/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Employee Activity By Organization
-- Description: Labor hours summary by employee, project, and task showing total, billable, and non-billable hours with cost amounts for the expenditure organization.
-- Excel Examle Output: https://www.enginatics.com/example/pa-employee-activity-by-organization/
-- Library Link: https://www.enginatics.com/reports/pa-employee-activity-by-organization/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
haouv2.name expenditure_organization,
ppx.employee_number,
ppx.full_name employee_name,
ppa.segment1 project_number,
ppa.name project_name,
pt.task_number,
pt.task_name,
peia.expenditure_type,
sum(peia.quantity) total_hours,
sum(decode(peia.billable_flag,'Y',peia.quantity)) billable_hours,
sum(decode(peia.billable_flag,'N',peia.quantity)) non_billable_hours,
sum(nvl(peia.raw_cost,0)) raw_cost,
sum(nvl(peia.burden_cost,0)) burdened_cost,
ppa.project_currency_code currency
from
pa_expenditure_items_all peia,
pa_expenditures_all pea,
pa_projects_all ppa,
pa_tasks pt,
per_people_x ppx,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv2
where
1=1 and
peia.system_linkage_function in ('ST','OT') and
peia.expenditure_id=pea.expenditure_id and
peia.project_id=ppa.project_id and
peia.task_id=pt.task_id and
pea.incurred_by_person_id=ppx.person_id and
ppa.org_id=haouv.organization_id and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
peia.organization_id=haouv2.organization_id
group by
haouv.name,
haouv2.name,
ppx.employee_number,
ppx.full_name,
ppa.segment1,
ppa.name,
pt.task_number,
pt.task_name,
peia.expenditure_type,
ppa.project_currency_code
order by
haouv.name,
haouv2.name,
ppx.full_name,
ppa.segment1,
pt.task_number