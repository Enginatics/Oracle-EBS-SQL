/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Cost Audit
-- Description: Project cost distribution lines transferred to GL showing DR/CR accounts, amounts, transfer status, and GL dates for audit and reconciliation purposes.
-- Excel Examle Output: https://www.enginatics.com/example/pa-cost-audit/
-- Library Link: https://www.enginatics.com/reports/pa-cost-audit/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
pt.task_number,
pt.task_name,
peia.expenditure_type,
peia.expenditure_item_date,
ppx.full_name employee_name,
ppx.employee_number,
pcdla.pa_period_name period_name,
pcdla.gl_date,
gcck.concatenated_segments dr_account,
gcck2.concatenated_segments cr_account,
pcdla.amount,
pcdla.dr_code_combination_id,
pcdla.cr_code_combination_id,
pcdla.transfer_status_code,
xxen_util.meaning(pcdla.transfer_status_code,'TRANSFER STATUS',275) transfer_status,
pcdla.transferred_date,
peia.quantity,
peia.expenditure_item_id,
peia.system_linkage_function,
xxen_util.meaning(peia.system_linkage_function,'SYSTEM_LINKAGE',275) expenditure_category,
pcdla.line_num distribution_line_num,
xxen_util.user_name(pcdla.created_by) created_by,
pcdla.creation_date
from
pa_cost_distribution_lines_all pcdla,
pa_expenditure_items_all peia,
pa_expenditures_all pea,
pa_projects_all ppa,
pa_tasks pt,
gl_code_combinations_kfv gcck,
gl_code_combinations_kfv gcck2,
hr_all_organization_units_vl haouv,
per_people_x ppx
where
1=1 and
pcdla.line_type='R' and
pcdla.expenditure_item_id=peia.expenditure_item_id and
peia.expenditure_id=pea.expenditure_id and
peia.project_id=ppa.project_id and
peia.task_id=pt.task_id and
pcdla.dr_code_combination_id=gcck.code_combination_id(+) and
pcdla.cr_code_combination_id=gcck2.code_combination_id(+) and
ppa.org_id=haouv.organization_id and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
pea.incurred_by_person_id=ppx.person_id(+)
order by
haouv.name,
ppa.segment1,
pt.task_number,
peia.expenditure_item_date,
pcdla.line_num