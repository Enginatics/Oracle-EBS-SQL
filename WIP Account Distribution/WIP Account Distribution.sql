/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WIP Account Distribution
-- Description: Detail WIP report that lists resource transaction account distributions.
-- Excel Examle Output: https://www.enginatics.com/example/wip-account-distribution/
-- Library Link: https://www.enginatics.com/reports/wip-account-distribution/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
haouv.name operating_unit,
ood.organization_code,
wta.transaction_date,
(select gp.period_name from gl_periods gp where wta.transaction_date>=gp.start_date and wta.transaction_date<gp.end_date+1 and gl.period_set_name=gp.period_set_name and gl.accounted_period_type=gp.period_type and gp.adjustment_period_flag='N') period,
to_number(to_char(wta.transaction_date,'yyyy')) year,
to_number(to_char(wta.transaction_date,'ww')) week,
we.wip_entity_name job_schedule,
msiv.concatenated_segments assembly,
msiv.description assembly_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
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
xxen_util.segments_description(wta.reference_account,gl.chart_of_accounts_id) account_description,
&gl_account_segments
nvl(wri.class_code,wdj.class_code) accounting_class,
xxen_util.meaning(we.entity_type,'WIP_ENTITY',700) type,
xxen_util.meaning(wdj.job_type,'WIP_DISCRETE_JOB',700) job_type,
xxen_util.meaning(wdj.wip_supply_type,'WIP_SUPPLY',700) wip_supply_type,
mck.concatenated_segments item_category,
nvl(ppx.npw_number,ppx.employee_number) employee_num,
ppx.full_name employee,
poh.segment1 po_number,
wta.gl_batch_id gl_batch,
ogb.gl_batch_date,
ogb.description gl_batch_description,
wta.wip_entity_id
from
gl_ledgers gl,
hr_all_organization_units_vl haouv,
org_organization_definitions ood,
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
org_gl_batches ogb,
per_people_x ppx,
po_headers_all poh
where
1=1 and
&account_where_clause
wta.organization_id=ood.organization_id and
ood.set_of_books_id=gl.ledger_id and
ood.operating_unit=haouv.organization_id and
gl.ledger_id in (select nvl(glsnav.ledger_id,gasna.ledger_id) from gl_access_set_norm_assign gasna, gl_ledger_set_norm_assign_v glsnav where gasna.access_set_id=fnd_profile.value('GL_ACCESS_SET_ID') and gasna.ledger_id=glsnav.ledger_set_id(+)) and
haouv.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
wta.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
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
wta.organization_id=ogb.organization_id(+) and
wta.gl_batch_id=ogb.gl_batch_id(+) and
wt.employee_id=ppx.person_id(+) and
wt.po_header_id=poh.po_header_id(+)
order by
ood.organization_code,
ood.organization_name,
wta.transaction_date desc,
wta.transaction_id desc,
cost_type,
accounting_line_type