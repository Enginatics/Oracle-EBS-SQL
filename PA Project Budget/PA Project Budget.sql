/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Budget
-- Description: Report of Standard Project Budgets. This report does not include Financial Plan Budgets.
In addition to the budget details, the report will also display the actuals matching the budget line datapoints.
Note: Inclusion of actuals data requires Blitz Report Build Data later than 04-APR-2025 03:21:50

-- Excel Examle Output: https://www.enginatics.com/example/pa-project-budget/
-- Library Link: https://www.enginatics.com/reports/pa-project-budget/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
--
-- Budget
--
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
pbt.budget_type,
pbv.version_name,
pbv.version_number,
xxen_util.meaning(pbv.budget_status_code,'BUDGET STATUS',275) status,
pbv.description,
pbem.budget_entry_method entry_method,
prl.name resource_list,
xxen_util.meaning(pbv.change_reason_code,'BUDGET CHANGE REASON',275) change_reason,
--
-- Budget line
--
pt.task_number,
pt.task_name,
pbl.period_name,
pbl.start_date,
pbl.end_date,
prlm.alias_path resource_alias,
pbl.raw_cost,
pbl.burdened_cost,
pbl.revenue,
pbl.quantity,
xxen_util.meaning(pra.unit_of_measure,'UNIT',275) unit_of_measure,
pbl.description line_description,
xxen_util.meaning(pbl.change_reason_code,'BUDGET CHANGE REASON',275) line_change_reason,
xxen_util.meaning(pra.track_as_labor_flag,'YES_NO',0) track_as_labor,
--
-- Actuals
&actuals_columns
--
-- DFF Columns
&dff_columns
--
pbv.project_id,
pbv.budget_version_id,
pbl.budget_line_id,
pbv.resource_list_id,
pra.task_id,
pra.resource_assignment_id,
pra.resource_list_member_id
from
hr_all_organization_units_vl haouv,
pa_projects_all ppa,
pa_budget_versions pbv,
pa_budget_types pbt,
pa_budget_entry_methods pbem,
pa_resource_lists prl,
pa_resource_assignments pra,
pa_budget_lines pbl,
pa_tasks pt,
--pa_resource_list_members prlm
(select
  prlm.resource_list_id,
  prlm.resource_list_member_id,
  prlm.alias alias,
  substr(sys_connect_by_path (prlm.alias,'|'),2) alias_path
 from
  pa_resource_list_members prlm
 where
  nvl(prlm.migration_code, '-99') <> 'N'
 connect by
  prior prlm.resource_list_member_id = prlm.parent_member_id and
  prior prlm.resource_list_id = prlm.resource_list_id
 start with
  prlm.parent_member_id is null
) prlm
where
1=1 and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
haouv.organization_id = ppa.org_id and
ppa.project_id = pbv.project_id and
pbv.budget_type_code = pbt.budget_type_code and
pbv.budget_entry_method_code = pbem.budget_entry_method_code and
pbv.resource_list_id = prl.resource_list_id and
pbv.budget_version_id  = pra.budget_version_id (+) and
pbv.project_id = pra.project_id (+) and
pra.resource_assignment_id = pbl.resource_assignment_id (+) and
pra.task_id = pt.task_id (+) and
pra.resource_list_member_id = prlm.resource_list_member_id (+)
) x
order by
x.operating_unit,
x.project_number,
x.project_name,
x.budget_type,
x.version_name,
x.version_number desc,
&lp_sort_col1
&lp_sort_col2
&lp_sort_col3
x.budget_line_id