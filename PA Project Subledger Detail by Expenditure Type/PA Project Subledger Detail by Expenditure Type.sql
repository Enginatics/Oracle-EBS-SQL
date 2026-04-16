/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Subledger Detail by Expenditure Type
-- Description: Cost distribution lines summarized by project, task, expenditure type, and GL account showing raw cost, burden cost, and total cost for transferred and accepted lines.
-- Excel Examle Output: https://www.enginatics.com/example/pa-project-subledger-detail-by-expenditure-type(1)/
-- Library Link: https://www.enginatics.com/reports/pa-project-subledger-detail-by-expenditure-type(1)/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
pt.task_number,
pt.task_name,
peia.expenditure_type,
pet.expenditure_category,
xxen_util.meaning(peia.system_linkage_function,'SYSTEM_LINKAGE',275) system_linkage,
gcck.concatenated_segments gl_account,
gcck.description account_description,
sum(pcdla.amount) raw_cost,
sum(pcdla.burdened_cost) burden_cost,
sum(pcdla.amount)+sum(nvl(pcdla.burdened_cost,0)-nvl(pcdla.amount,0)) total_cost,
count(*) line_count
from
pa_cost_distribution_lines_all pcdla,
pa_expenditure_items_all peia,
pa_projects_all ppa,
pa_tasks pt,
pa_expenditure_types pet,
gl_code_combinations_kfv gcck,
hr_all_organization_units_vl haouv
where
1=1 and
pcdla.line_type='R' and
pcdla.transfer_status_code in ('A','V') and
pcdla.expenditure_item_id=peia.expenditure_item_id and
peia.project_id=ppa.project_id and
peia.task_id=pt.task_id and
peia.expenditure_type=pet.expenditure_type and
pcdla.dr_code_combination_id=gcck.code_combination_id(+) and
ppa.org_id=haouv.organization_id and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
group by
haouv.name,
ppa.segment1,
ppa.name,
pt.task_number,
pt.task_name,
peia.expenditure_type,
pet.expenditure_category,
peia.system_linkage_function,
gcck.concatenated_segments,
gcck.description
order by
haouv.name,
ppa.segment1,
pt.task_number,
peia.expenditure_type,
gcck.concatenated_segments