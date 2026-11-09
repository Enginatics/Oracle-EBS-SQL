/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Expenditure Item Transfer Upload
-- Description: Transfers expenditure items to another project or task, as the Transfer action of the Expenditure Items window (Expenditure Inquiry) does, through paadjustments.
-- Enter a To Task, and a To Project for a transfer to another project, on the rows to transfer. Each transferred item is reversed on its current task and recreated on the destination task, which takes its billable or capitalizable flag and transaction controls from there. The result shows the new item, with the original item in Transferred From Item Id. Rows without a To Task are not transferred.
-- The download lists the items that are not reversed, reversing or related items. An item is rejected with Oracle's message where the window refuses the transfer, such as an unapproved item, an item already transferred or a date outside the destination project or task dates.
-- Excel Example Output: https://www.enginatics.com/example/pa-expenditure-item-transfer-upload/
-- Library Link: https://www.enginatics.com/reports/pa-expenditure-item-transfer-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
pt.task_number,
pt.task_name,
peia.expenditure_item_date,
peia.expenditure_type,
pet.expenditure_category,
(select psl.meaning from pa_system_linkages psl where peia.system_linkage_function=psl.function) expenditure_type_class,
(select max(papf.full_name) keep (dense_rank last order by papf.effective_start_date) from per_all_people_f papf where pea.incurred_by_person_id=papf.person_id) employee_name,
(select max(nvl(papf.employee_number,papf.npw_number)) keep (dense_rank last order by papf.effective_start_date) from per_all_people_f papf where pea.incurred_by_person_id=papf.person_id) employee_number,
(select haouv2.name from hr_all_organization_units_vl haouv2 where nvl(peia.override_to_organization_id,pea.incurred_by_organization_id)=haouv2.organization_id) expenditure_organization,
peia.non_labor_resource,
peia.quantity,
xxen_util.meaning(peia.unit_of_measure,'UNIT',275) unit_of_measure,
peia.projfunc_currency_code project_functional_currency,
peia.raw_cost,
peia.burden_cost burdened_cost,
xxen_util.yes(peia.billable_flag) billable,
(select pts.user_transaction_source from pa_transaction_sources pts where peia.transaction_source=pts.transaction_source) transaction_source,
peia.orig_transaction_reference original_transaction_reference,
pea.expenditure_group expenditure_batch,
(select pec.expenditure_comment from pa_expenditure_comments pec where peia.expenditure_item_id=pec.expenditure_item_id) expenditure_comment,
null to_project_number,
null to_project_name,
null to_task_number,
null to_task_name,
peia.expenditure_item_id,
peia.transferred_from_exp_item_id transferred_from_item_id,
to_number(null) upload_row
from
hr_all_organization_units_vl haouv,
pa_expenditure_items_all peia,
pa_expenditures_all pea,
pa_projects_all ppa,
pa_tasks pt,
pa_expenditure_types pet
where
1=1 and
:p_upload_mode like '%'||xxen_upload.action_update and
haouv.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU') and
haouv.organization_id=peia.org_id and
nvl(peia.net_zero_adjustment_flag,'N')='N' and
peia.adjusted_expenditure_item_id is null and
peia.source_expenditure_item_id is null and
peia.expenditure_id=pea.expenditure_id and
peia.project_id=ppa.project_id and
peia.task_id=pt.task_id and
peia.expenditure_type=pet.expenditure_type
