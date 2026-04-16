/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PA Project Expenditure Items with WIP and INV Detail
-- Description: Project expenditure items showing WIP and inventory transaction details including transaction types, quantities, WIP job, assembly, department, resource, and inventory item information.
-- Excel Examle Output: https://www.enginatics.com/example/pa-project-expenditure-items-with-wip-and-inv-detail/
-- Library Link: https://www.enginatics.com/reports/pa-project-expenditure-items-with-wip-and-inv-detail/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
ppa.segment1 project_number,
ppa.name project_name,
(select pps.project_status_name from pa_project_statuses pps where pps.project_status_code=ppa.project_status_code) project_status,
ppa.project_type,
pt.task_number,
pt.task_name,
peia.expenditure_type,
pet.expenditure_category,
(select psl.meaning from pa_system_linkages psl where psl.function=peia.system_linkage_function) expenditure_type_class,
(select pts.user_transaction_source from pa_transaction_sources pts where pts.transaction_source=peia.transaction_source) transaction_source,
peia.expenditure_item_date,
pea.expenditure_group,
nvl(ppx.npw_number,ppx.employee_number) employee_number,
ppx.full_name employee,
we.wip_entity_name job,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) wip_entity_type,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
nvl(wri.class_code,wdj.class_code) accounting_class,
xxen_util.meaning(wt.transaction_type,'WIP_TRANSACTION_TYPE',700) wip_transaction_type,
wt.transaction_date wip_transaction_date,
wt.operation_seq_num wip_operation_seq,
bd.department_code wip_department,
wt.resource_seq_num wip_resource_seq,
br.resource_code wip_resource,
br.description wip_resource_description,
mtt.transaction_type_name inv_transaction_type,
mmt.transaction_date inv_transaction_date,
msiv2.concatenated_segments inv_item,
msiv2.description inv_item_description,
mmt.transaction_quantity inv_quantity,
mmt.transaction_uom inv_uom,
peia.quantity,
peia.denom_currency_code currency,
peia.denom_raw_cost raw_cost,
peia.denom_burdened_cost burdened_cost,
peia.acct_raw_cost,
peia.acct_burdened_cost,
peia.orig_transaction_reference,
peia.expenditure_item_id
from
pa_expenditure_items_all peia,
pa_expenditures_all pea,
pa_expenditure_types pet,
pa_projects_all ppa,
pa_tasks pt,
hr_all_organization_units_vl haouv,
per_people_x ppx,
wip_transactions wt,
wip_entities we,
wip_discrete_jobs wdj,
wip_repetitive_items wri,
mtl_system_items_vl msiv,
bom_departments bd,
bom_resources br,
mtl_material_transactions mmt,
mtl_transaction_types mtt,
mtl_system_items_vl msiv2
where
1=1 and
peia.project_id=ppa.project_id and
peia.task_id=pt.task_id(+) and
peia.expenditure_id=pea.expenditure_id and
peia.expenditure_type=pet.expenditure_type and
peia.org_id=haouv.organization_id and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
pea.incurred_by_person_id=ppx.person_id(+) and
case when peia.system_linkage_function='WIP' and peia.transaction_source='Work In Process' then to_number(peia.orig_transaction_reference default null on conversion error) end=wt.transaction_id(+) and
coalesce(wt.wip_entity_id,decode(mmt.transaction_source_type_id,5,mmt.transaction_source_id))=we.wip_entity_id(+) and
coalesce(wt.wip_entity_id,decode(mmt.transaction_source_type_id,5,mmt.transaction_source_id))=wdj.wip_entity_id(+) and
coalesce(wt.organization_id,mmt.organization_id)=wdj.organization_id(+) and
wt.wip_entity_id=wri.wip_entity_id(+) and
wt.organization_id=wri.organization_id(+) and
wt.line_id=wri.line_id(+) and
we.primary_item_id=msiv.inventory_item_id(+) and
we.organization_id=msiv.organization_id(+) and
wt.department_id=bd.department_id(+) and
peia.wip_resource_id=br.resource_id(+) and
case when peia.system_linkage_function in ('WIP','INV') and peia.transaction_source<>'Work In Process' then to_number(peia.orig_transaction_reference default null on conversion error) end=mmt.transaction_id(+) and
mmt.transaction_type_id=mtt.transaction_type_id(+) and
mmt.inventory_item_id=msiv2.inventory_item_id(+) and
mmt.organization_id=msiv2.organization_id(+)
order by
haouv.name,
ppa.segment1,
pt.task_number,
peia.expenditure_item_date