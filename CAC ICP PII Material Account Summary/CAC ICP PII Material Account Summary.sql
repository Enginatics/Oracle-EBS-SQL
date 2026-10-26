/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: CAC ICP PII Material Account Summary
-- Description: Use this report to eliminate your internal profit in inventory (PII) at month-end. This report to sums up the material accounting entries for each item, organization, subinventory with the original amount, profit in inventory and net amounts. With the Show SLA Accounting parameter you can choose to use the Release 12 Subledger Accounting (Create Accounting) account setups by selecting Yes. And if you have not modified your SLA accounting rules, select No to allow this report to run a bit faster. Use Show Subinventories to display or not display the subinventory information. Use Show Projects to display or not display the project number and name and use Show WIP Job to display or not display the WIP job information (WIP class, class type, WIP job, description, assembly number and assembly description). For Discrete, Flow and Workorderless WIP (but not Repetitive Schedules). Both Flow and Workorderless show up as the WIP Type "Flow schedule". And for WIP Completions and WIP Completion Returns, this report also has a column "PII Zero Component Quantity" indicating if the underlying components, which have PII, were not issued to the job. If not, the PII amount for WIP completions, for WIP jobs that were open, may be overstated as the PII is actually still sitting in the onhand inventory.
-- Note: there is a hidden parameter, Numeric Sign for PII, which allows you to set the sign of the profit in inventory amounts. You can specify positive or negative values based on how you enter PII amounts into your PII Cost Type. Defaulted as positive (+1).
-- Note: The SQL logic and code for this report is identical to the CAC Material Account Summary report.
-- / +=============================================================================+
-- -- | Copyright 2009- 2022 Douglas Volz Consulting, Inc.
-- -- | All rights reserved.
-- -- | Permission to use this code is granted provided the original author is
-- -- | acknowledged. No warranties, express or otherwise is included in this
-- -- | permission.
-- -- +=============================================================================+
-- -- |
-- -- | Version Modified on Modified by Description
-- -- | ======= =========== ============== =========================================
-- -- | 1.0 06 Nov 2009 Douglas Volz Initial Coding
-- -- | 1.27 07 Oct 2022 Douglas Volz Correction for period name joins for interorg transactions.
-- -- | 1.28 16 Oct 2022 Douglas Volz Correction for quantity calculations and PII logic.
-- -- | 1.29 24 Oct 2026 Andy Haack Rebuilt to the Blitz Report SQL standards.
-- -- +=============================================================================+/
-- Excel Example Output: https://www.enginatics.com/example/cac-icp-pii-material-account-summary/
-- Library Link: https://www.enginatics.com/reports/cac-icp-pii-material-account-summary/
-- Run Report: https://demo.enginatics.com/

with
pii as (
select /*+ materialize*/
cicd.organization_id,
cicd.inventory_item_id,
cct.cost_type pii_cost_type,
sum(cicd.item_cost) pii_item_cost,
sum(cicd.item_cost)*decode(sign(:p_sign_pii),-1,-1,1) corrected_pii_item_cost
from
mtl_parameters mp,
cst_item_cost_details cicd,
cst_cost_types cct,
bom_resources br
where
3=3 and
5=5 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=cicd.organization_id and
cicd.cost_type_id=cct.cost_type_id and
cicd.resource_id=br.resource_id
&only_no_pii
group by
cicd.organization_id,
cicd.inventory_item_id,
cct.cost_type
),
wpii as (
select distinct
y.organization_id,
y.wip_entity_id,
y.primary_item_id
from
(
select
x.organization_id,
x.wip_entity_id,
x.primary_item_id,
x.inventory_item_id
from
(
select
wdj.organization_id,
wdj.wip_entity_id,
wdj.primary_item_id,
wro.inventory_item_id,
wro.quantity_issued
from
wip_discrete_jobs wdj,
wip_requirement_operations wro,
pii
where
(wdj.date_closed is null and wdj.creation_date<:p_trx_date_to+1 or wdj.date_closed>=:p_trx_date_to+1) and
wdj.wip_entity_id=wro.wip_entity_id and
wdj.organization_id=wro.organization_id and
wro.wip_supply_type not in (4,6) and
wro.organization_id=pii.organization_id and
wro.inventory_item_id=pii.inventory_item_id and
pii.pii_item_cost<>0
union all
select
wdj.organization_id,
wdj.wip_entity_id,
wdj.primary_item_id,
mmt.inventory_item_id,
mmt.primary_quantity
from
wip_discrete_jobs wdj,
wip_requirement_operations wro,
mtl_material_transactions mmt,
pii
where
(wdj.date_closed is null and wdj.creation_date<:p_trx_date_to+1 or wdj.date_closed>=:p_trx_date_to+1) and
wdj.wip_entity_id=wro.wip_entity_id and
wdj.organization_id=wro.organization_id and
wro.wip_supply_type not in (4,6) and
wdj.wip_entity_id=mmt.transaction_source_id and
wdj.organization_id=mmt.organization_id and
mmt.transaction_source_type_id=5 and
mmt.transaction_type_id in (35,43) and
wro.operation_seq_num=mmt.operation_seq_num and
wro.inventory_item_id=mmt.inventory_item_id and
mmt.transaction_date>=:p_trx_date_to+1 and
mmt.organization_id=pii.organization_id and
mmt.inventory_item_id=pii.inventory_item_id and
pii.pii_item_cost<>0
) x
group by
x.organization_id,
x.wip_entity_id,
x.primary_item_id,
x.inventory_item_id
having
nvl(sum(x.quantity_issued),0)=0
) y
)
select
nvl(gl.short_name,gl.name) ledger,
haouv_ou.name operating_unit,
x.organization_code org_code,
haouv_ou_from.name from_ou,
haouv_ou_to.name to_ou,
xxen_util.meaning(x.fob_point,'MTL_FOB_POINT',700) fob_point,
mp_from.organization_code ship_from_org,
mp_to.organization_code ship_to_org,
oap.period_name,
&segment_columns
msiv.concatenated_segments item_number,
msiv.description item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
(select misv.inventory_item_status_code_tl from mtl_item_status_vl misv where msiv.inventory_item_status_code=misv.inventory_item_status_code) item_status,
xxen_util.meaning(msiv.planning_make_buy_code,'MTL_PLANNING_MAKE_BUY',700) make_buy_code,
&category_columns
xxen_util.meaning(x.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_line_type,
mtt.transaction_type_name transaction_type,
mtst.transaction_source_type_name transaction_source,
&p_show_subinventory
&p_show_project
&p_show_wip_job
msiv.primary_uom_code uom_code,
sum(x.primary_quantity) quantity,
gl.currency_code,
sum(x.matl_amount) material_amount,
sum(x.matl_ovhd_amount) material_overhead_amount,
sum(x.resource_amount) resource_amount,
sum(x.osp_amount) outside_processing_amount,
sum(x.overhead_amount) overhead_amount,
sum(x.mta_amount) amount
&p_show_pii
from
&mtl_sla_tables
&subinventory_table
&project_tables
(
select
mta.organization_id,
mp.organization_code,
case
when mmt.transaction_action_id in (3,9,13,21,22) then mmt.organization_id
when mmt.transaction_action_id in (10,12,15,17) then nvl(mmt.transfer_organization_id,mmt.organization_id)
end xfer_from_org_id,
case
when mmt.transaction_action_id in (3,9,13,21,22) then nvl(mmt.transfer_organization_id,mmt.organization_id)
when mmt.transaction_action_id in (10,12,15,17) then mmt.organization_id
end xfer_to_org_id,
mmt.fob_point,
mmt.acct_period_id,
mta.reference_account,
mta.inv_sub_ledger_id,
mta.inventory_item_id,
mmt.transaction_source_type_id,
mmt.transaction_action_id,
mmt.transaction_type_id,
mta.accounting_line_type,
mmt.transaction_id,
mmt.transfer_transaction_id,
mmt.parent_transaction_id,
mmt.trx_source_line_id,
mmt.cost_update_id,
mta.transaction_date,
mta.creation_date,
mmt.created_by,
mmt.reason_id,
regexp_replace(mmt.transaction_reference,'[^[:alnum:]'' '']',null) transaction_reference,
decode(mta.accounting_line_type,1,
decode(mmt.transaction_action_id,
2,decode(sign(mta.primary_quantity),1,mmt.transfer_subinventory,mmt.subinventory_code),
3,decode(mmt.organization_id,mta.organization_id,mmt.subinventory_code,mmt.transfer_subinventory),
21,decode(sign(mta.primary_quantity),1,mmt.transfer_subinventory,mmt.subinventory_code),
22,decode(sign(mta.primary_quantity),1,mmt.transfer_subinventory,mmt.subinventory_code),
28,decode(sign(mta.primary_quantity),1,mmt.transfer_subinventory,mmt.subinventory_code),
mmt.subinventory_code)
) subinventory_code,
mmt.transfer_subinventory,
mmt.cost_group_id,
mmt.transfer_cost_group_id,
mmt.transaction_source_id,
mmt.project_id,
mmt.task_id,
mmt.pm_cost_collected,
we.wip_entity_name job,
wac.class_code wip_class,
xxen_util.meaning(wac.class_type,'WIP_CLASS_TYPE',700) class_type,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) wip_type,
msiv_fg.concatenated_segments fg_item,
msiv_fg.description fg_description,
decode(mmt.transaction_action_id,24,mmt.quantity_adjusted,mta.primary_quantity) primary_quantity,
mta.cost_element_id,
mta.resource_id,
decode(mta.cost_element_id,1,mta.base_transaction_value,0) matl_amount,
decode(mta.cost_element_id,2,mta.base_transaction_value,0) matl_ovhd_amount,
decode(mta.cost_element_id,3,mta.base_transaction_value,0) resource_amount,
decode(mta.cost_element_id,4,mta.base_transaction_value,0) osp_amount,
decode(mta.cost_element_id,5,mta.base_transaction_value,0) overhead_amount,
mta.base_transaction_value mta_amount,
case
when mmt.transaction_action_id=24 then 0
when mta.accounting_line_type in (1,2,21,22,23,24,35,36) then decode(mta.cost_element_id,2,0,3,0,4,0,5,0,1)
when mta.accounting_line_type=7 then decode(mta.cost_element_id,1,1,0)
when mta.accounting_line_type in (5,9,10,14,16,20,29,30,31,34) then 1
else 0
end pii_function
from
mtl_parameters mp,
mtl_transaction_accounts mta,
mtl_material_transactions mmt,
(
select
we.wip_entity_id,
we.organization_id,
we.wip_entity_name,
we.entity_type,
we.primary_item_id,
nvl(wdj.class_code,wfs.class_code) class_code
from
wip_entities we,
wip_discrete_jobs wdj,
wip_flow_schedules wfs
where
we.wip_entity_id=wdj.wip_entity_id(+) and
we.wip_entity_id=wfs.wip_entity_id(+)
) we,
wip_accounting_classes wac,
mtl_system_items_vl msiv_fg
where
2=2 and
3=3 and
4=4 and
6=6 and
7=7 and
mp.organization_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='INV') and
mp.organization_id=mta.organization_id and
mta.transaction_id=mmt.transaction_id and
mta.inventory_item_id=mmt.inventory_item_id and
decode(mta.transaction_source_type_id,5,mta.transaction_source_id)=we.wip_entity_id(+) and
we.class_code=wac.class_code(+) and
we.organization_id=wac.organization_id(+) and
we.primary_item_id=msiv_fg.inventory_item_id(+) and
we.organization_id=msiv_fg.organization_id(+)
) x,
mtl_system_items_vl msiv,
org_acct_periods oap,
mtl_transaction_types mtt,
mtl_txn_source_types mtst,
hr_organization_information hoi,
hr_all_organization_units_vl haouv_ou,
gl_ledgers gl,
mtl_parameters mp_from,
mtl_parameters mp_to,
hr_organization_information hoi_from,
hr_all_organization_units_vl haouv_ou_from,
hr_organization_information hoi_to,
hr_all_organization_units_vl haouv_ou_to,
pii,
wpii,
gl_code_combinations gcc
where
1=1 and
x.organization_id=msiv.organization_id and
x.inventory_item_id=msiv.inventory_item_id and
x.acct_period_id=oap.acct_period_id and
x.transaction_type_id=mtt.transaction_type_id and
x.transaction_source_type_id=mtst.transaction_source_type_id and
x.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
to_number(hoi.org_information3)=haouv_ou.organization_id and
to_number(hoi.org_information1)=gl.ledger_id and
x.xfer_from_org_id=mp_from.organization_id(+) and
x.xfer_to_org_id=mp_to.organization_id(+) and
nvl(x.xfer_from_org_id,x.organization_id)=hoi_from.organization_id and
hoi_from.org_information_context='Accounting Information' and
to_number(hoi_from.org_information3)=haouv_ou_from.organization_id and
nvl(x.xfer_to_org_id,x.organization_id)=hoi_to.organization_id and
hoi_to.org_information_context='Accounting Information' and
to_number(hoi_to.org_information3)=haouv_ou_to.organization_id and
x.organization_id=pii.organization_id(+) and
x.inventory_item_id=pii.inventory_item_id(+) and
x.organization_id=wpii.organization_id(+) and
decode(x.transaction_source_type_id,5,x.transaction_source_id)=wpii.wip_entity_id(+) and
x.inventory_item_id=wpii.primary_item_id(+)
&subinv_table_joins
&project_table_joins
&mtl_sla_table_joins
&p_show_non_sla
group by
nvl(gl.short_name,gl.name),
haouv_ou.name,
x.organization_code,
haouv_ou_from.name,
haouv_ou_to.name,
x.fob_point,
mp_from.organization_code,
mp_to.organization_code,
oap.period_name,
&segment_columns_grp
msiv.concatenated_segments,
msiv.description,
msiv.item_type,
msiv.inventory_item_status_code,
msiv.planning_make_buy_code,
msiv.primary_uom_code,
x.organization_id,
x.inventory_item_id,
x.accounting_line_type,
mtt.transaction_type_name,
mtst.transaction_source_type_name,
&group_by_subinventory
&group_by_project
&group_by_wip_job
&group_by_pii
gl.currency_code
order by
nvl(gl.short_name,gl.name),
haouv_ou.name,
x.organization_code,
oap.period_name,
&segment_columns_grp
msiv.concatenated_segments,
x.accounting_line_type,
mtt.transaction_type_name
&order_by_subinventory
&order_by_project
&order_by_wip_job
,x.organization_id
