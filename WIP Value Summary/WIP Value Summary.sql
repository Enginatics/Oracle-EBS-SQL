/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Value Summary
-- Description: Report to get the WIP and Material  accounting distributions,  by WIP job,period, Org .
It displays detailed information from both sources WIP and Material Transactions
Parameters:
===========
Period:  To pull the transactions based on specific inventory period ( transaction_date).(mandatory)
Source:  enter the source "WIP","Material" or "Both" you wish to report (mandatory).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Category Set 3:  any item category you wish, typically the Inventory category set (optional).
Replace Colon with Dot:  This is to give flexibility to replace concatenated segments '-' with '.' . If Yes, it wil always replace (optional).
WIP Job or Flow Schedule:  enter the WIP Job or the Flow Schedule to report (optional).
Organization Code:  enter the inventory organization(s) you wish to report (mandatory).
Operating Unit:  enter the operating unit(s) you wish to report (optional).
Ledger:  enter the ledger(s) you wish to report (optional).

-- Excel Examle Output: https://www.enginatics.com/example/wip-value-summary/
-- Library Link: https://www.enginatics.com/reports/wip-value-summary/
-- Run Report: https://demo.enginatics.com/

---------------------------
--WIP Transaction Accounts---
---------------------------
select
'WIP' source,
nvl(gl.short_name, gl.name) ledger,
hou.name operating_unit,
ood.organization_code,
trunc(wta.transaction_date) transaction_date,
to_char(xah.period_name) period,
we.wip_entity_name wip_job_number,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) job_status,
wdj.net_quantity wo_quantity,
msiv.concatenated_segments assembly_item_number,
msiv.concatenated_segments item_number,
case when :p_replace_colon_dot = 'Y' then replace( xxen_util.concatenated_segments(msiv.expense_account),'-','.') else xxen_util.concatenated_segments(msiv.expense_account) end item_expense_account,
case when :p_replace_colon_dot = 'Y' then replace( xxen_util.concatenated_segments(msiv.cost_of_sales_account),'-','.') else xxen_util.concatenated_segments(msiv.cost_of_sales_account) end item_cogs_account,
case when :p_replace_colon_dot = 'Y' then replace( xxen_util.concatenated_segments(msiv.sales_Account),'-','.') else xxen_util.concatenated_segments(msiv.sales_Account) end item_sales_account,
msiv.description item_description,
&category_columns
decode(msiv.planning_make_buy_code, 2, 'Buy', 1, 'Make')"Make/Buy",
msiv.item_type,
null subinventory,
null locator,
wt.operation_seq_num operation_sequence,
bd.department_code department,
wt.resource_seq_num resource_seq,
br.resource_code,
br.description resource_description,
xxen_util.meaning(br.cost_code_type,'CST_COST_CODE_TYPE',700) cost_element,
&cst_segment_columns
&sla_segment_columns
br.unit_of_measure transaction_uom,
xxen_util.meaning(wta.basis_type,'CST_BASIS',700) basis_type,
wta.primary_quantity transaction_qty,
wta.rate_or_amount unit_cost,
wta.base_transaction_value transaction_value,
gl.currency_code currency,
xxen_util.meaning(wt.transaction_type,'WIP_TRANSACTION_TYPE',700) transaction_type_name,
xal.accounting_class_code accounting_class,
xxen_util.meaning(wta.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_line_type,
xal.accounted_dr,
xal.accounted_cr,
nvl(xal.accounted_dr, 0)-nvl(xal.accounted_cr, 0)account_net,
wta.activity_id,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) wip_entity_type,
xxen_util.meaning(wdj.job_type,'WIP_DISCRETE_JOB',700) job_type,
xxen_util.meaning(wdj.wip_supply_type,'WIP_SUPPLY',700) supply_type,
null po_number,
wta.wip_entity_id,
wta.transaction_id,
xte.entity_code,
xah.ae_header_id xla_header_id,
xal.ae_line_num xla_line_number
from
gl_ledgers gl,
org_organization_definitions ood,
wip_transaction_accounts wta,
wip_transactions wt,
wip_entities we,
wip_discrete_jobs wdj,
gl_code_combinations_kfv gcc1,
gl_code_combinations_kfv gcc2,
xla_transaction_entities_upg xte,
org_acct_periods oap,
xla_events xe,
xla_ae_headers xah,
xla_ae_lines xal,
xla_distribution_links xdl,
hr_operating_units hou,
mtl_system_items_vl msiv,
wip_repetitive_items wri,
bom_departments bd,
bom_resources br
where 1=1 and
3=3 and
wta.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
ood.operating_unit=hou.organization_id and
xte.source_id_int_1=wta.transaction_id and
xte.security_id_int_1=wta.organization_id and
xe.entity_id=xte.entity_id and
xe.event_id=xah.event_id and
xah.ae_header_id=xal.ae_header_id and
xdl.event_id=xe.event_id and
xdl.ae_header_id=xah.ae_header_id and
xdl.ae_line_num=xal.ae_line_num and
wta.wip_sub_ledger_id=xdl.source_distribution_id_num_1 and
xal.code_combination_id=gcc2.code_combination_id and
xte.ledger_id=xah.ledger_id and
wta.base_transaction_value<>0 and
hou.set_of_books_id=xte.ledger_id and
hou.organization_id=xte.security_id_int_2 and
wta.organization_id=ood.organization_id and
wta.accounting_line_type<>15 and
wta.transaction_id=wt.transaction_id and
wta.wip_entity_id=we.wip_entity_id and
wta.wip_entity_id=wdj.wip_entity_id and
wta.organization_id(+)=wdj.organization_id and
wta.transaction_date >= oap.period_start_date and wta.transaction_date < oap.schedule_close_date + 1 and
oap.organization_id= ood.organization_id and
wta.reference_account=gcc1.code_combination_id and
we.organization_id(+)=msiv.organization_id and
we.primary_item_id(+)=msiv.inventory_item_id and
wt.organization_id=wri.organization_id(+) and
wt.wip_entity_id=wri.wip_entity_id(+) and
wt.line_id=wri.line_id(+) and
wt.department_id=bd.department_id(+) and
br.resource_id(+)=wta.resource_id and 
:p_source in ('Both','WIP')
union
---------------------------
--Material Distirbutions---
---------------------------
select
'Material' source,
nvl(gl.short_name, gl.name) ledger,
hou.name operating_unit,
ood.organization_code,
trunc(mta.transaction_date) transaction_date,
to_char(xah.period_name) period,
we.wip_entity_name wip_job_number,
xxen_util.meaning(wdj.status_type,'WIP_JOB_STATUS',700) job_status,
wdj.net_quantity wo_quantity,
(select msiv_assembly.concatenated_segments from mtl_system_items_vl msiv_assembly where wdj.primary_item_id=msiv_assembly.inventory_item_id and wdj.organization_id=msiv_assembly.organization_id) assembly_item_number,
msiv.concatenated_segments item_number,
case when :p_replace_colon_dot = 'Y' then replace( xxen_util.concatenated_segments(msiv.expense_account),'-','.') else xxen_util.concatenated_segments(msiv.expense_account) end item_expense_account,
case when :p_replace_colon_dot = 'Y' then replace( xxen_util.concatenated_segments(msiv.cost_of_sales_account),'-','.') else xxen_util.concatenated_segments(msiv.cost_of_sales_account) end item_cogs_account,
case when :p_replace_colon_dot = 'Y' then replace( xxen_util.concatenated_segments(msiv.sales_Account),'-','.') else xxen_util.concatenated_segments(msiv.sales_Account) end item_sales_account,
msiv.description item_description,
&category_columns
decode(msiv.planning_make_buy_code, 2, 'Buy', 1, 'Make')"Make/Buy",
msiv.item_type,
mmt.subinventory_code subinventory,
mil.concatenated_segments locator,
mmt.operation_seq_num operation_sequence,
null department,
null resource_seq,
null resource_code,
null resource_description,
cce.cost_element,
&cst_segment_columns
&sla_segment_columns
mmt.transaction_uom,
xxen_util.meaning(mta.basis_type,'CST_BASIS',700) basis_type,
mmt.transaction_quantity transaction_qty,
case when mta.primary_quantity <> 0 then (mta.base_transaction_value / mta.primary_quantity) else 0 end unit_cost,
mta.base_transaction_value transaction_value,
mmt.currency_code currency,
mtt.transaction_type_name,
xal.accounting_class_code accounting_class,
xxen_util.meaning(mta.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_line_type,
xal.accounted_dr,
xal.accounted_cr,
nvl(xal.accounted_dr, 0)-nvl(xal.accounted_cr, 0)account_net,
null activity_id,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) wip_entity_type,
null job_type,
null supply_type,
null po_number,
wdj.wip_entity_id,
mmt.transaction_id,
xte.entity_code,
xah.ae_header_id xla_header_id,
xal.ae_line_num xla_line_number
from
mtl_material_transactions mmt,
mtl_transaction_accounts mta,
mtl_system_items_vl msiv,
gl_ledgers gl,
org_organization_definitions ood,
mtl_item_locations_kfv mil,
mtl_transaction_types mtt,
wip_discrete_jobs wdj,
wip_entities we,
cst_cost_elements cce,
gl_code_combinations_kfv gcc1,
gl_code_combinations_kfv gcc2,
org_acct_periods oap,
xla_transaction_entities_upg xte,
xla_events xe,
xla_ae_headers xah,
xla_ae_lines xal,
xla_distribution_links xdl,
hr_operating_units hou
where 2=2 and
3=3 and
mmt.transaction_id=mta.transaction_id and
mmt.inventory_item_id=mta.inventory_item_id and
mta.inventory_item_id=msiv.inventory_item_id and
mmt.inventory_item_id=msiv.inventory_item_id and
mmt.organization_id=ood.organization_id and
msiv.organization_id=mmt.organization_id and
msiv.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
ood.operating_unit=hou.organization_id and
mmt.transaction_source_id=wdj.wip_entity_id(+) and
wdj.wip_entity_id=we.wip_entity_id and
mmt.organization_id=wdj.organization_id(+) and
mil.inventory_location_id(+)=mmt.locator_id and
mil.organization_id(+)=mmt.organization_id and
mil.subinventory_code(+)=mmt.subinventory_code and
mmt.transaction_type_id=mtt.transaction_type_id and
mta.cost_element_id=cce.cost_element_id(+) and
mta.reference_account=gcc1.code_combination_id(+) and
mmt.organization_id=nvl(mmt.owning_organization_id, mmt.organization_id) and
xte.source_id_int_1=mta.transaction_id and
xte.security_id_int_1=mta.organization_id and
xe.entity_id=xte.entity_id and
xe.event_id=xah.event_id and
xah.ae_header_id=xal.ae_header_id and
xdl.event_id=xe.event_id and
xdl.ae_header_id=xah.ae_header_id and
xdl.ae_line_num=xal.ae_line_num and
mta.inv_sub_ledger_id=xdl.source_distribution_id_num_1 and
xal.code_combination_id=gcc2.code_combination_id and
xte.ledger_id=xah.ledger_id and
mta.base_transaction_value<> 0 and
hou.set_of_books_id=xte.ledger_id and
hou.organization_id=xte.security_id_int_2 and
mta.transaction_source_type_id=5 and --'Purchase order' =1, Internal Requistion = 7
mmt.transaction_date >= oap.period_start_date and mmt.transaction_date < oap.schedule_close_date + 1 and
oap.organization_id= ood.organization_id and 
:p_source in ('Both','Material')