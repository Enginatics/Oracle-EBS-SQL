/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC WIP Account Summary
-- Description: Report to get the WIP accounting distributions, in summary, by WIP job, resource, overhead and WIP cost update. With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes. And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster. With parameters to limit the report size, Show Project to display or not display the project number and name, Show WIP Job to display or not display the WIP job (WIP job, description and resource codes) and Show WIP Outside Processing to display or not display the outside processing information (WIP OSP item number, supplier, purchase order, purchase order line and release). For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules). Note that both Flow and Workorderless show up as the WIP Type "Flow schedule".
-- Parameters:
-- ===========
-- Transaction Date From: enter the starting transaction date (mandatory).
-- Transaction Date To: enter the ending transaction date (mandatory).
-- Show SLA Accounting: enter Yes to use the Subledger Accounting rules for your accounting information (mandatory). If you choose No the report uses the pre-Create Accounting entries.
-- Show Projects: display the project number and name. Enter Yes or No, use to limit the report size. (mandatory).
-- Show WIP Jobs: display the WIP job, description, department and resource. Enter Yes or No, use to limit the report size (mandatory).
-- Show WIP Outside Processing: display the WIP OSP item number, supplier, purchase order, purchase order line and release. Enter Yes or No, use to limit the report size (mandatory).
-- Category Set 1: any item category you wish, typically the Cost or Product Line category set (optional).
-- Category Set 2: any item category you wish, typically the Inventory category set (optional).
-- Assembly Number: enter the specific assembly number(s) you wish to report (optional).
-- Organization Code: enter the specific inventory organization(s) you wish to report (optional).
-- Operating Unit: enter the specific operating unit(s) you wish to report (optional).
-- Ledger: enter the specific ledger(s) you wish to report (optional).
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
-- -- | 1.13 11 Mar 2021 Douglas Volz Added Flow Schedules and Workorderless WIP
-- -- | and removed redundant joins and tables to
-- -- | improve performance.
-- -- | 1.14 22 Mar 2021 Douglas Volz Add WIP Job parameter.
-- -- | 1.15 20 Dec 2021 Douglas Volz Add WIP Department.
-- -- | 1.16 12 Aug 2022 Douglas Volz Combine with WIP Account Summary No SLA report
-- -- | and add Show WIP Job and Show WIP OSP parameters.
-- -- | 1.17 14 Aug 2022 Douglas Volz Screen out zero job close variances for Flow Schedules.
-- -- | 1.18 22 Aug 2022 Douglas Volz Improve performance with outer joins and streamline dynamic SQL.
-- -- | 1.19 26 Feb 2023 Douglas Volz Fix to show job close variances.
-- -- | 1.20 20 Jun 2024 Douglas Volz Remove tabs, reinstall missing parameters and org access controls.
-- -- | 1.21 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-wip-account-summary/
-- Library Link: https://www.enginatics.com/reports/cac-wip-account-summary/
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
wac.class_code wip_class,
xxen_util.meaning(wac.class_type,'WIP_CLASS_TYPE',700) class_type,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) wip_type,
&p_show_project
&p_show_wip_job
&p_show_wip_osp
&p_show_wip_job_uom
round(sum(decode(x.transaction_type,4,0,nvl(x.primary_quantity,0))),3) primary_quantity,
gl.currency_code,
sum(decode(x.cost_element_id,1,x.base_transaction_value,0)) material_amount,
sum(decode(x.cost_element_id,2,x.base_transaction_value,0)) material_overhead_amount,
sum(decode(x.cost_element_id,3,x.base_transaction_value,0)) resource_amount,
sum(decode(x.cost_element_id,4,x.base_transaction_value,0)) outside_processing_amount,
sum(decode(x.cost_element_id,5,x.base_transaction_value,0)) overhead_amount,
sum(x.base_transaction_value) amount
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
nvl(wdj.class_code,wfs.class_code) class_code,
wta.wip_entity_id,
nvl(wdj.status_type,wfs.status) status_type,
wta.resource_id,
wt.po_header_id,
wt.po_line_id,
wt.department_id,
nvl(wdj.project_id,wfs.project_id) project_id,
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
wta.wip_entity_id=wfs.wip_entity_id(+) and
(wt.transaction_type not in (5,6,7) or wta.base_transaction_value<>0)
) x,
wip_entities we,
wip_accounting_classes wac,
mtl_system_items_vl msiv,
bom_departments bd,
bom_resources br,
org_acct_periods oap,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
&project_tables
&wip_osp_tables
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
x.acct_period_id=oap.acct_period_id and
x.organization_id=oap.organization_id and
x.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id
&project_table_joins
&osp_wip_table_joins
&wip_sla_table_joins
&wip_non_sla_table_joins
group by
nvl(gl.short_name,gl.name),
haouv_ou.name,
x.organization_code,
oap.period_name,
&segment_columns_grp
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
x.accounting_line_type,
x.transaction_type,
wac.class_code,
wac.class_type,
we.entity_type,
&group_by_project
&group_by_wip_job
&group_by_wip_osp
msiv.organization_id,
msiv.inventory_item_id,
gl.currency_code
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
&order_by_wip_job
&order_by_wip_osp
