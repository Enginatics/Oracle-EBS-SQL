/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Account Detail
-- Description: Report to get the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update. With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes. And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster. With parameters to limit the number of report columns, Show Project to display or not display the project number and name, Show WIP Job to display or not display the WIP job (WIP job, description and resource codes), Show WIP Outside Processing to display or not display the outside processing information (WIP OSP item number, supplier, purchase order, purchase order line and release) and Show Overheads to display or not display the overhead codes. For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules). Note that both Flow and Workorderless show up as the WIP Type "Flow schedule". And WIP Standard Cost Update descriptions show up in the Transaction Reference column.
-- / +=============================================================================+
-- -- | Copyright 2009- 2024 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this permission.
-- -- +=============================================================================+
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 06 Nov 2009 Douglas Volz Initial Coding
-- -- | 1.21 25 Jan 2024 Douglas Volz Added Std Cost Update Description to Transaction Reference column.
-- -- | Andy Haack Added organization security restriction by orgaccessview oav.
-- -- | 1.22 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-wip-account-detail/
-- Library Link: https://www.enginatics.com/reports/cac-wip-account-detail/
-- Run Report: https://demo.enginatics.com/

select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
x.organization_code org_code,
oap.period_name,
&segment_columns
msiv.concatenated_segments assembly_number,
msiv.description assembly_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
&category_columns
xxen_util.meaning(x.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_line_type,
xxen_util.meaning(x.transaction_type,'WIP_TRANSACTION_TYPE_SHORT',700) transaction_type,
x.transaction_id,
&p_show_wip_osp
x.move_transaction_id,
x.completion_transaction_id,
x.transaction_date,
x.creation_date,
xxen_util.user_name(x.created_by) created_by,
x.transaction_reference,
wac.class_code wip_class,
xxen_util.meaning(wac.class_type,'WIP_CLASS_TYPE',700) class_type,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) wip_type,
&p_show_project
we.wip_entity_name wip_job,
we.description,
xxen_util.meaning(x.status_type,decode(we.entity_type,4,'WIP_FLOW_SCHEDULE_STATUS','WIP_JOB_STATUS'),700) wip_status,
x.operation_seq_num operation_seq_number,
x.resource_seq_num resource_operation_seq,
bd.department_code wip_department,
regexp_replace(bd.description,'[^[:alnum:]'' '']',null) department_description,
br.resource_code wip_resource,
xxen_util.meaning(x.autocharge_type,'BOM_AUTOCHARGE_TYPE',700) autocharge_type,
xxen_util.yes(decode(x.standard_rate_flag,1,'Y')) standard_rate,
&p_show_wip_osp2
x.actual_resource_rate,
x.standard_resource_rate,
x.rate_or_amount resource_cost,
xxen_util.meaning(x.basis_type,'CST_BASIS',700) basis_type,
&p_show_wip_ovhds
ca.activity,
br.unit_of_measure uom_code,
round(nvl(x.primary_quantity,0),3) primary_quantity,
cce.cost_element,
gl.currency_code,
x.base_transaction_value amount
from
(
select /*+ leading(wt) use_nl(wta)*/
mp.organization_code,
wta.organization_id,
wt.acct_period_id,
wta.reference_account,
nvl(wdj.primary_item_id,wfs.primary_item_id) primary_item_id,
wta.accounting_line_type,
wt.transaction_type,
wt.transaction_id,
wt.rcv_transaction_id,
wt.move_transaction_id,
wt.completion_transaction_id,
wt.transaction_date,
wt.creation_date,
wt.created_by,
decode(wt.transaction_type,4,(select ccu.description from cst_cost_updates ccu where wt.cost_update_id=ccu.cost_update_id),regexp_replace(wt.reference,'[^[:alnum:]'' '']',null)) transaction_reference,
nvl(wdj.class_code,wfs.class_code) class_code,
wta.wip_entity_id,
nvl(wdj.status_type,wfs.status) status_type,
wta.resource_id,
wt.po_header_id,
wt.po_line_id,
wt.department_id,
wt.project_id,
wt.task_id,
wt.pm_cost_collected,
wt.operation_seq_num,
wt.resource_seq_num,
wt.autocharge_type,
wt.standard_rate_flag,
wt.actual_resource_rate,
wt.standard_resource_rate,
wta.rate_or_amount,
wta.basis_type,
wta.currency_code,
wta.currency_conversion_date,
wta.currency_conversion_rate,
wta.overhead_basis_factor,
wta.basis_resource_id,
wt.activity_id,
wta.primary_quantity,
wta.cost_element_id,
wta.base_transaction_value,
wta.wip_sub_ledger_id
from
mtl_parameters mp,
wip_transaction_accounts wta,
wip_transactions wt,
wip_discrete_jobs wdj,
wip_flow_schedules wfs
where
2=2 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=wta.organization_id and
wta.transaction_id=wt.transaction_id and
wta.wip_entity_id=wdj.wip_entity_id(+) and
wta.wip_entity_id=wfs.wip_entity_id(+)
) x,
wip_entities we,
wip_accounting_classes wac,
mtl_system_items_vl msiv,
bom_departments bd,
bom_resources br,
cst_activities ca,
cst_cost_elements cce,
org_acct_periods oap,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
&project_tables
&wip_osp_tables
&wip_ovhd_tables
&wip_sla_tables
gl_code_combinations gcc
where
1=1 and
x.wip_entity_id=we.wip_entity_id and
x.organization_id=msiv.organization_id(+) and
x.primary_item_id=msiv.inventory_item_id(+) and
x.class_code=wac.class_code(+) and
x.organization_id=wac.organization_id(+) and
x.department_id=bd.department_id(+) and
x.resource_id=br.resource_id(+) and
x.activity_id=ca.activity_id(+) and
x.cost_element_id=cce.cost_element_id(+) and
x.acct_period_id=oap.acct_period_id and
x.organization_id=oap.organization_id and
x.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id
&project_table_joins
&osp_wip_table_joins
&wip_ovhd_table_joins
&wip_sla_table_joins
&wip_non_sla_table_joins
order by
ledger,
operating_unit,
org_code,
oap.period_name,
&segment_columns_grp
assembly_number,
accounting_line_type,
transaction_type,
wip_class,
wip_type
&order_by_project
,wip_job
,wip_resource
&order_by_wip_osp
&order_by_wip_ovhds
