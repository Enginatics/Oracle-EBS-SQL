/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Budget Upload
-- Description: The PA Project Budget Upload supports the creation/update of standard project budgets. 

At this stage it does not support the creation/update of Financial Plan Budgets.

The PA Project Budget Upload allows users to:

- Create new working budgets.

When creating a new working budget, any existing working budget for the specified Project and Budget Type will be overwritten.

The upload allows the user to create a working budget either by entering the data directly into an empty upload excel file, or by copying a prior version of the budget and modifying this in the upload excel file.

- Update existing working budgets.

This option allows for the update of an existing working budget. In this mode the existing budget is retained, and the update mode allows for individual budget lines to be added, updated, and/or deleted from the existing working budget.

- Additionally, the upload allows users to Baseline a Working Budget.

Working Budgets can be uploaded against the Projects belonging to the Operating Units accessible to the responsibility in which the PA Project Budget Upload process is run.

-- Excel Examle Output: https://www.enginatics.com/example/pa-project-budget-upload/
-- Library Link: https://www.enginatics.com/reports/pa-project-budget-upload/
-- Run Report: https://demo.enginatics.com/

/*
&report_table_name
*/
select
x.*
from
(
select
decode(:p_upload_mode,xxen_upload.action_create,xxen_upload.action_meaning(xxen_upload.action_create),null) action_,
decode(:p_upload_mode,xxen_upload.action_create,xxen_upload.status_meaning(xxen_upload.status_new),null)status_,
null message_,
null baseline_message_,
null request_id_,
null modified_columns_,
:p_upload_mode upload_mode_,
decode(:p_upload_mode,xxen_upload.action_create,to_number(null),pbl.budget_line_id) budget_line_id,
--
-- Budget
--
:p_pm_product_code product_source,
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
pbt.budget_type,
pbv.version_name,
--pbv.version_number,
--pbv.budget_status_m status,
pbv.description,
pbem.budget_entry_method entry_method,
prl.name resource_list,
null baseline_budget,
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
--xxen_util.meaning(pbl.change_reason_code,'BUDGET CHANGE REASON',275) line_change_reason,
--xxen_util.meaning(pra.track_as_labor_flag,'YES_NO',0) track_as_labor,
null delete_this_line,
--
-- DFF Columns
pbv.attribute_category budget_attribute_category,
pbv.attribute1 budget_attribute1,
pbv.attribute2 budget_attribute2,
pbv.attribute3 budget_attribute3,
pbv.attribute4 budget_attribute4,
pbv.attribute5 budget_attribute5,
pbv.attribute6 budget_attribute6,
pbv.attribute7 budget_attribute7,
pbv.attribute8 budget_attribute8,
pbv.attribute9 budget_attribute9,
pbv.attribute10 budget_attribute10,
pbv.attribute11 budget_attribute11,
pbv.attribute12 budget_attribute12,
pbv.attribute13 budget_attribute13,
pbv.attribute14 budget_attribute14,
pbv.attribute15 budget_attribute15,
pbl.attribute_category line_attribute_category,
pbl.attribute1 line_attribute1,
pbl.attribute2 line_attribute2,
pbl.attribute3 line_attribute3,
pbl.attribute4 line_attribute4,
pbl.attribute5 line_attribute5,
pbl.attribute6 line_attribute6,
pbl.attribute7 line_attribute7,
pbl.attribute8 line_attribute8,
pbl.attribute9 line_attribute9,
pbl.attribute10 line_attribute10,
pbl.attribute11 line_attribute11,
pbl.attribute12 line_attribute12,
pbl.attribute13 line_attribute13,
pbl.attribute14 line_attribute14,
pbl.attribute15 line_attribute15,
--
null mark_as_original
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
( (:p_upload_mode = xxen_upload.action_update and pbv.budget_status_code IN ('W','S')) or -- draft
  (:p_upload_mode = xxen_upload.action_create and :p_create_copy = xxen_util.meaning('Y','YES_NO',0))
) and
haouv.name = nvl(:p_operating_unit,haouv.name) and
nvl(:p_pm_product_code,'?') = nvl(:p_pm_product_code,'?') and
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
&not_use_first_block
&processed_errors_query
&processed_success_query
&processed_run
) x
order by
x.operating_unit,
x.project_number,
x.project_name,
x.budget_type,
x.version_name,
&lp_sort_col1
&lp_sort_col2
&lp_sort_col3
x.budget_line_id