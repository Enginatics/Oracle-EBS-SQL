/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Account Distribution
-- Description: Detail WIP report that lists resource transaction account distributions.
-- Excel Examle Output: https://www.enginatics.com/example/wip-account-distribution/
-- Library Link: https://www.enginatics.com/reports/wip-account-distribution/
-- Run Report: https://demo.enginatics.com/

select
wta.transaction_date,
we.wip_entity_name job_schedule,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
wl.line_code line,
wta.transaction_id,
wt.operation_seq_num operation_seq,
bd.department_code department,
wt.resource_seq_num resource_seq,
br.resource_code,
br.description resource_description,
muot.unit_of_measure_tl uom,
xxen_util.meaning(wta.basis_type,'CST_BASIS',700) basis,
wta.primary_quantity quantity,
wta.rate_or_amount unit_cost,
xxen_util.meaning(br.cost_code_type,'CST_COST_CODE_TYPE',700) cost_type,
xxen_util.meaning(wta.accounting_line_type,'CST_ACCOUNTING_LINE_TYPE',700) accounting_line_type,
gcck.concatenated_segments account,
wta.base_transaction_value value,
gl.currency_code,
wta.transaction_value orig_value,
decode(wta.currency_code,gl.currency_code,null,wta.currency_code) orig_currency,
decode(wta.currency_code,gl.currency_code,null,wta.currency_conversion_rate) conversion_rate,
decode(wta.currency_code,gl.currency_code,null,wta.currency_conversion_date) conversion_date,
xxen_util.meaning(wt.transaction_type,'WIP_TRANSACTION_TYPE',700) transaction_type,
ca.activity,
xxen_util.meaning(wt.standard_rate_flag,'SYS_YES_NO',700) standard_rate,
xxen_util.segments_description(wta.reference_account) account_description,
gcck.segment3,
xxen_util.segment_description(gcck.segment5,'SEGMENT5',gcck.chart_of_accounts_id) segment5_description,
nvl(wri.class_code,wdj.class_code) accounting_class,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) type,
xxen_util.meaning(wdj.job_type,'WIP_DISCRETE_JOB',700) job_type,
xxen_util.meaning(wdj.wip_supply_type,'WIP_SUPPLY',700) wip_supply_type,
mck.concatenated_segments item_category,
ood.organization_code,
ood.organization_name,
nvl(ppx.npw_number,ppx.employee_number) employee_num,
ppx.full_name employee,
poh.segment1 po_number,
gl.name ledger,
wta.gl_batch_id gl_batch,
ogb.gl_batch_date,
ogb.description gl_batch_description,
wta.wip_entity_id
from
wip_transaction_accounts wta,
wip_transactions wt,
wip_entities we,
wip_discrete_jobs wdj,
gl_code_combinations_kfv gcck,
wip_lines wl,
mtl_item_categories mic,
mtl_categories_kfv mck,
mtl_system_items_vl msiv,
wip_repetitive_items wri,
bom_departments bd,
bom_resources br,
mtl_units_of_measure_tl muot,
cst_activities ca,
org_organization_definitions ood,
gl_ledgers gl,
org_gl_batches ogb,
per_people_x ppx,
po_headers_all poh
where
1=1 and
wta.accounting_line_type<>15 and
wta.transaction_id=wt.transaction_id and
wta.wip_entity_id=we.wip_entity_id and
wta.wip_entity_id=wdj.wip_entity_id(+) and
wta.organization_id=wdj.organization_id(+) and
wta.reference_account=gcck.code_combination_id and
wt.line_id=wl.line_id(+) and
wt.organization_id=wl.organization_id(+) and
we.organization_id=mic.organization_id(+) and
we.primary_item_id=mic.inventory_item_id(+) and
mic.category_set_id(+)=:category_set_id and
mic.category_id=mck.category_id(+) and
we.organization_id=msiv.organization_id(+) and
we.primary_item_id=msiv.inventory_item_id(+) and
wt.organization_id=wri.organization_id(+) and
wt.wip_entity_id=wri.wip_entity_id(+) and
wt.line_id=wri.line_id(+) and
wt.department_id=bd.department_id(+) and
wta.resource_id=br.resource_id(+) and
br.unit_of_measure=muot.uom_code(+) and
muot.language(+)=userenv('lang') and
wta.activity_id=ca.activity_id(+) and
wta.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
wta.organization_id=ogb.organization_id(+) and
wta.gl_batch_id=ogb.gl_batch_id(+) and
ppx.person_id(+)=wt.employee_id and
poh.po_header_id(+)=wt.po_header_id
order by
wta.transaction_date desc,
wta.transaction_id desc,
cost_type,
accounting_line_type