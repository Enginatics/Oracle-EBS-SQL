/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Resource Transactions
-- Description: WIP resource, overhead and outside processing transactions, one row per transaction, as shown in the View Resource Transactions form.
-- Quantity is in the unit of measure the transaction was entered in, Primary Quantity in the resource's unit of measure.
-- Transactions still pending in the resource transaction interface are not included.
-- Excel Example Output: https://www.enginatics.com/example/wip-resource-transactions/
-- Library Link: https://www.enginatics.com/reports/wip-resource-transactions/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
wt.transaction_date,
xxen_util.meaning(wt.transaction_type,'WIP_TRANSACTION_TYPE',700) transaction_type,
we.wip_entity_name job,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) job_type,
wl.line_code line,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
wt.operation_seq_num operation_seq,
bd.department_code department,
wt.resource_seq_num resource_seq,
br.resource_code,
br.description resource_description,
xxen_util.meaning(br.resource_type,'BOM_RESOURCE_TYPE',700) resource_type,
xxen_util.meaning(wt.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) charge_type,
xxen_util.meaning(wt.basis_type,'CST_BASIS',700) basis,
wt.usage_rate_or_amount usage_rate,
wt.transaction_quantity quantity,
wt.transaction_uom uom,
wt.primary_quantity,
wt.primary_uom,
xxen_util.yes(case when wt.transaction_type<>2 and nvl(wt.standard_rate_flag,1)=1 then 'Y' end) standard_rate,
wt.actual_resource_rate,
wt.standard_resource_rate,
ca.activity,
nvl(papf.npw_number,papf.employee_number) employee_number,
papf.full_name employee,
mtr.reason_name reason,
wt.reference,
pha.segment1 po_number,
ppa.segment1 project_number,
pt.task_number,
xxen_util.meaning(decode(wt.pm_cost_collected,null,nvl2(wt.pm_cost_collector_group_id,'1','4'),'N','2','E','3'),'INV_YES_NO_ERROR_NA',700) transferred_to_projects,
wt.source_code,
xxen_util.user_name(wt.created_by) created_by,
wt.creation_date,
wt.transaction_id
from
mtl_parameters mp,
wip_transactions wt,
wip_entities we,
wip_lines wl,
mtl_system_items_vl msiv,
bom_departments bd,
bom_resources br,
cst_activities ca,
per_all_people_f papf,
mtl_transaction_reasons mtr,
po_headers_all pha,
pa_projects_all ppa,
pa_tasks pt
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=wt.organization_id and
wt.transaction_type in (1,2,3,4,5,6,7,17) and
wt.wip_entity_id=we.wip_entity_id and
wt.line_id=wl.line_id(+) and
wt.organization_id=wl.organization_id(+) and
wt.organization_id=msiv.organization_id(+) and
wt.primary_item_id=msiv.inventory_item_id(+) and
nvl(wt.charge_department_id,wt.department_id)=bd.department_id(+) and
wt.resource_id=br.resource_id(+) and
wt.activity_id=ca.activity_id(+) and
wt.employee_id=papf.person_id(+) and
wt.transaction_date>=papf.effective_start_date(+) and
wt.transaction_date<papf.effective_end_date(+)+1 and
wt.reason_id=mtr.reason_id(+) and
wt.po_header_id=pha.po_header_id(+) and
wt.project_id=ppa.project_id(+) and
wt.task_id=pt.task_id(+)
order by
mp.organization_code,
wt.transaction_date,
wt.transaction_id
