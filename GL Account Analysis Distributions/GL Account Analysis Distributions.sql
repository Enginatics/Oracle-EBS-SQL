/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Account Analysis (Distributions)
-- Description: Detailed GL transaction report with one line per distribution including all segments and subledger data, with amounts in both transaction currency and ledger currency.
The report includes VAT tax codes and rates for AR and AP transactions.
-- Excel Examle Output: https://www.enginatics.com/example/gl-account-analysis-distributions/
-- Library Link: https://www.enginatics.com/reports/gl-account-analysis-distributions/
-- Run Report: https://demo.enginatics.com/

with gcck as
(
select
&hierarchy_levels2
gcck.*
from
(
select
(select fifs.flex_value_set_id from fnd_id_flex_segments fifs where gcck.chart_of_accounts_id=fifs.id_flex_num and fifs.application_id=101 and fifs.id_flex_code='GL#' and fifs.application_column_name='&hierarchy_segment_column') flex_value_set_id,
gcck.*
from
gl_code_combinations_kfv gcck
) gcck,
(
select
&hierarchy_levels
x.flex_value_set_id,
x.child_flex_value_low,
x.child_flex_value_high
from
(
select
substr(sys_connect_by_path(ffvnh.parent_flex_value,'|'),2) path,
ffvnh.child_flex_value_low,
ffvnh.child_flex_value_high,
ffvnh.flex_value_set_id
from
(select ffvnh.* from fnd_flex_value_norm_hierarchy ffvnh where ffvnh.flex_value_set_id=:flex_value_set_id) ffvnh
where
connect_by_isleaf=1 and
ffvnh.range_attribute='C'
connect by nocycle
ffvnh.parent_flex_value between prior ffvnh.child_flex_value_low and prior ffvnh.child_flex_value_high and
ffvnh.flex_value_set_id=prior ffvnh.flex_value_set_id and
prior ffvnh.range_attribute='P'
start with
ffvnh.parent_flex_value=:parent_flex_value
) x
) h
where
2=2 and
gcck.flex_value_set_id=h.flex_value_set_id(+)
)
--
-- Main Query
--
select y.*
from
(
select 
x.*,
case when max(x.je_header_id) over (partition by x.ledger,x.concatenated_segments) is not null then 'Y' else 'N' end has_activity,
case when sum(case when x.record_type = 'Balance' then abs(nvl(x.accounted_amount,0)) else 0 end) over (partition by x.ledger,x.concatenated_segments) = 0 then 'Y' else 'N' end zero_balance 
from 
(
select
case when count(distinct gp.period_num) over ()>1 then lpad(gp.period_num,2,'0')||' ' end||gjh.period_name period_name,
lpad(gp.period_num,2,'0')||' '||gjh.period_name period_name_label,
gl.name ledger,
(select gjsv.user_je_source_name from gl_je_sources_vl gjsv where gjh.je_source=gjsv.je_source_name) source_name,
gjh.external_reference reference,
(select gjcv.user_je_category_name from gl_je_categories_vl gjcv where gjh.je_category=gjcv.je_category_name) category_name,
gjb.name batch_name,
xxen_util.meaning(gjb.status,'MJE_BATCH_STATUS',101) batch_status,
gjh.posted_date,
gjh.name journal_name,
gjh.description journal_description,
gjh.doc_sequence_value document_number,
xxen_util.meaning(gjh.tax_status_code,'TAX_STATUS',101) tax_status_code,
gjl.je_line_num line_number,
gcck.concatenated_segments,
decode(gir.gl_sl_link_id,min(gir.gl_sl_link_id) over (partition by gjl.je_header_id, gjl.je_line_num),gjl.entered_dr) line_entered_dr,
decode(gir.gl_sl_link_id,min(gir.gl_sl_link_id) over (partition by gjl.je_header_id, gjl.je_line_num),gjl.entered_cr) line_entered_cr,
decode(gir.gl_sl_link_id,min(gir.gl_sl_link_id) over (partition by gjl.je_header_id, gjl.je_line_num),nvl(gjl.entered_dr,0)-nvl(gjl.entered_cr,0)) line_entered_amount,
decode(gir.gl_sl_link_id,min(gir.gl_sl_link_id) over (partition by gjl.je_header_id, gjl.je_line_num),gjl.accounted_dr) line_accounted_dr,
decode(gir.gl_sl_link_id,min(gir.gl_sl_link_id) over (partition by gjl.je_header_id, gjl.je_line_num),gjl.accounted_cr) line_accounted_cr,
decode(gir.gl_sl_link_id,min(gir.gl_sl_link_id) over (partition by gjl.je_header_id, gjl.je_line_num),nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0)) line_accounted_amount,
gjl.description line_description,
coalesce(
zrb.tax_rate_code,
listagg(zl.tax_rate_code,', ') within group (order by zl.tax_rate_code) over (partition by nvl(rctla.link_to_cust_trx_line_id,rctla.customer_trx_line_id)),
aila.tax_rate_code,
aila.tax_classification_code
) tax_rate_code,
coalesce(
zrb.percentage_rate,
max(zl.tax_rate) over (partition by nvl(rctla.link_to_cust_trx_line_id,rctla.customer_trx_line_id)),
aila.tax_rate,
(
select
zl.tax_rate
from
zx.zx_lines zl
where
zl.application_id=200 and
zl.entity_code='AP_INVOICES' and
zl.event_class_code in ('STANDARD INVOICES','EXPENSE REPORTS','PREPAYMENT INVOICES') and
aila.invoice_id=zl.trx_id and
zl.trx_level_type='LINE' and
aila.line_number=zl.trx_line_id and
rownum=1
)
) tax_rate,
xxen_util.meaning(gjl.tax_line_flag,'YES_NO',0) tax_line,
xxen_util.meaning(gjl.taxable_line_flag,'YES_NO',0) taxable_line,
xxen_util.meaning(gjl.amount_includes_tax_flag,'YES_NO',0) amount_includes_tax,
xxen_util.meaning(xal.accounting_class_code,'XLA_ACCOUNTING_CLASS',602,'Y') accounting_class,
xxen_util.meaning(gcck.gl_account_type,'ACCOUNT_TYPE',0) account_type,
&hierarchy_levels3
&segment_columns
nvl2(xal.gl_sl_link_id,xdl.unrounded_entered_dr,gjl.entered_dr) entered_dr,
nvl2(xal.gl_sl_link_id,xdl.unrounded_entered_cr,gjl.entered_cr) entered_cr,
nvl(nvl2(xal.gl_sl_link_id,xdl.unrounded_entered_dr,gjl.entered_dr),0)-nvl(nvl2(xal.gl_sl_link_id,xdl.unrounded_entered_cr,gjl.entered_cr),0) entered_amount,
nvl2(xal.gl_sl_link_id,xal.currency_code,gjh.currency_code) transaction_currency,
nvl2(xal.gl_sl_link_id,xdl.unrounded_accounted_dr,gjl.accounted_dr) accounted_dr,
nvl2(xal.gl_sl_link_id,xdl.unrounded_accounted_cr,gjl.accounted_cr) accounted_cr,
nvl(nvl2(xal.gl_sl_link_id,xdl.unrounded_accounted_dr,gjl.accounted_dr),0)-nvl(nvl2(xal.gl_sl_link_id,xdl.unrounded_accounted_cr,gjl.accounted_cr),0) accounted_amount,
gl.currency_code ledger_currency,
&revaluation_columns
nvl(gjh.doc_sequence_value,xah.doc_sequence_value) doc_sequence_value,
(select xett.name from xla_event_types_tl xett where xte.application_id=xett.application_id and xte.entity_code=xett.entity_code and xe.event_type_code=xett.event_type_code and xett.language=userenv('lang')) event_type,
xal.currency_conversion_date,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where xal.currency_conversion_type=gdct.conversion_type) currency_conversion_type,
xal.currency_conversion_rate,
xxen_util.description(gjh.actual_flag,'BATCH_TYPE',101) balance_type,
(select gbv.budget_name from gl_budget_versions gbv where gjh.budget_version_id=gbv.budget_version_id) budget_name,
gjh.currency_conversion_date conversion_date,
gjh.currency_conversion_type conversion_type,
gjh.currency_conversion_rate conversion_rate,
xah.description accounting_event_description,
xah.accounting_date,
xe.transaction_date,
xte.transaction_number,
-- Source Line Description
coalesce(aida.description,aila.description,aila.item_description,rctla.description,pla.item_description) source_line_description,
-- Assets
case
when xte.application_id = 140 and xte.entity_code = 'TRANSACTIONS'
then (select fab.asset_number from fa_additions_b fab,fa_transaction_headers fth where fth.asset_id=fab.asset_id and fth.transaction_header_id=xte.source_id_int_1 and fth.event_id = xe.event_id)
when xte.application_id = 140 and xte.entity_code = 'DEPRECIATION'
then (select fab.asset_number from fa_additions_b fab, fa_deprn_detail fdd where fab.asset_id=fdd.asset_id and fdd.asset_id=xte.source_id_int_1 and fdd.period_counter=xte.source_id_int_2 and fdd.event_id=xe.event_id and rownum=1)
end asset_number,
--AP
coalesce(aia.invoice_num,rcta.trx_number,(select distinct last_value(aia.invoice_num) over (order by aipa.invoice_payment_id range between unbounded preceding and unbounded following)from ap_invoice_payments_all aipa,ap_invoices_all aia where aipa.invoice_id=aia.invoice_id and aipa.check_id=aca.check_id)) invoice_number,
coalesce(aia.description,rcta.comments,(select distinct last_value(aia.description) over (order by aipa.invoice_payment_id range between unbounded preceding and unbounded following) from ap_invoice_payments_all aipa,ap_invoices_all aia where aipa.invoice_id=aia.invoice_id and aipa.check_id=aca.check_id)) invoice_description,
coalesce(aila.line_number,rctla.line_number) invoice_line_number,
coalesce(aia.invoice_date,rcta.trx_date,(select distinct last_value(aia.invoice_date) over (order by aipa.invoice_payment_id range between unbounded preceding and unbounded following) from ap_invoice_payments_all aipa,ap_invoices_all aia where aipa.invoice_id=aia.invoice_id and aipa.check_id=aca.check_id)) invoice_date,
aia.gl_date,
nvl(aia.invoice_currency_code,rcta.invoice_currency_code) invoice_currency_code,
aia.payment_currency_code,
aia.payment_method_code,
nvl(aia.invoice_amount,(select sum(apsa.amount_due_original) from ar_payment_schedules_all apsa where apsa.customer_trx_id=rcta.customer_trx_id)) invoice_amount,
(select pha.segment1 from po_headers_all pha where coalesce(aia.quick_po_header_id,rt.po_header_id,plla.po_header_id,wt.po_header_id,decode(mmt.transaction_source_type_id,1,mmt.transaction_source_id,null))=pha.po_header_id) purchase_order,
pla.line_num purchase_order_line,
--AR
case
when xte.entity_code='TRANSACTIONS' and rcta.interface_header_context in ('ORDER ENTRY','INTERCOMPANY') then rcta.interface_header_attribute1
when gxeh.txn_source='OM' then (select to_char(ooha.order_number) from oe_order_headers_all ooha,oe_order_lines_all oola where ooha.header_id=oola.header_id and oola.line_id=gxeh.source_line_id) --OPM
when mmt.transaction_source_type_id in (2,8,12) then (select mso.segment1 from mtl_sales_orders mso where mso.sales_order_id=mmt.transaction_source_id)
end sales_order,
jrrev.resource_name salesperson,
(select name from ra_rules rr where rcta.invoicing_rule_id=rule_id) invoice_rule,
(select rr.name from ra_customer_trx_lines_all rctla, ra_rules rr where rcta.customer_trx_id=rctla.customer_trx_id and rctla.line_type='LINE' and rctla.accounting_rule_id=rr.rule_id and rownum=1) accounting_rule,
nvl(rt.quantity,(plla.quantity - nvl(plla.quantity_cancelled,0))) po_quantity,
coalesce(
(select aps.vendor_name from ap_suppliers aps where coalesce(aia.vendor_id,aca.vendor_id,rt.vendor_id)=aps.vendor_id),
(select aps.vendor_name from po_headers_all pha,ap_suppliers aps where aps.vendor_id=pha.vendor_id and coalesce(rt.po_header_id,wt.po_header_id,decode(mmt.transaction_source_type_id,1,mmt.transaction_source_id,null))=pha.po_header_id),
(select hp.party_name from hz_cust_accounts hca, hz_parties hp where coalesce(rcta.bill_to_customer_id,acra.pay_from_customer,paa.customer_id)=hca.cust_account_id and hca.party_id=hp.party_id),
(select hp.party_name from hz_parties hp,hz_cust_accounts hca,oe_order_lines_all oola where hca.party_id=hp.party_id and hca.cust_account_id=oola.sold_to_org_id and oola.line_id=coalesce(gxeh.source_line_id,case when mmt.transaction_source_type_id in (2,8,12) then mmt.trx_source_line_id end))
) vendor_or_customer,
--Projects
coalesce(
(select ppa.segment1 from pa_projects_all ppa where aida.project_id=ppa.project_id),
case when xte.entity_code='TRANSACTIONS' and rcta.interface_header_context='PROJECTS INVOICES' then rcta.interface_header_attribute1 end,
ppa.segment1
) project,
pt.task_number task,
pea.expenditure_group,
xxen_util.meaning(pea.expenditure_class_code,'EXPENDITURE CLASS CODE',275) expenditure_class_code,
xxen_util.meaning(pea.expenditure_status_code,'EXPENDITURE STATUS',275) expenditure_status_code,
pet.expenditure_category,
peia.expenditure_type,
pet.description expenditure_type_description,
peia.expenditure_item_date,
peia.quantity expenditure_item_quantity,
xxen_util.meaning(pet.unit_of_measure,'UNIT',275) expenditure_unit_of_measure,
papf.full_name incurred_by_person,
nvl(papf.employee_number,papf.npw_number) incurred_by_employee_number,
--WIP
bd.department_code,
br.resource_code,
we.wip_entity_name wip_job,
wt.operation_seq_num,
nvl(wt.transaction_quantity,mmt.transaction_quantity) transaction_quantity,
nvl(wt.transaction_uom,mmt.transaction_uom) transaction_uom,
nvl(wt.primary_quantity,mmt.primary_quantity) primary_quantity,
-- inventory
xxen_util.client_time(mmt.transaction_date) inv_transaction_date,
mp.organization_code inv_organization,
coalesce(mmt.subinventory_code,rt.subinventory,rsl.to_subinventory) inv_subinventory,
msiv.concatenated_segments inv_item,
msiv.description inv_item_description,
mmt.transaction_cost inv_transaction_unit_cost,
mmt.actual_cost inv_actual_unit_cost,
mmt.transaction_reference inv_transaction_reference,
mtst.transaction_source_type_name inv_transaction_source_type,
mtt.transaction_type_name inv_transaction_type,
case
when mmt.transaction_source_type_id=6 then (select mgd.segment1 from mtl_generic_dispositions mgd where mgd.disposition_id=mmt.transaction_source_id and mgd.organization_id=mmt.organization_id) --Account Alias
when mmt.transaction_source_type_id in (2,8,12) then (select mso.segment1||'.'||mso.segment2||'.'||mso.segment3 from mtl_sales_orders mso where mso.sales_order_id=mmt.transaction_source_id)--Sales Order, Internal Order, RMA
when mmt.transaction_source_type_id=11 then (select ccu.description from cst_cost_updates ccu where ccu.cost_update_id=mmt.transaction_source_id) --Cost Update
when mmt.transaction_source_type_id=9 then (select mcch.cycle_count_header_name from mtl_cycle_count_headers mcch where mcch.cycle_count_header_id=mmt.transaction_source_id) --Cycle Count
when mmt.transaction_source_type_id=3 then (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id=mmt.transaction_source_id) --Account
when mmt.transaction_source_type_id=13 or mmt.transaction_source_type_id>100 then mmt.transaction_source_name --Inventory
when mmt.transaction_source_type_id=10 then (select mpi.physical_inventory_name from mtl_physical_inventories mpi where mpi.physical_inventory_id=mmt.transaction_source_id and mpi.organization_id=mmt.organization_id) --Physical Inventory
when mmt.transaction_source_type_id=1 then (select pha.segment1 from po_headers_all pha where pha.po_header_id=mmt.transaction_source_id) --PO
when mmt.transaction_source_type_id=16 then (select okhab.contract_number from okc_k_headers_all_b okhab where okhab.id=mmt.transaction_source_id) --Project Contracts
when mmt.transaction_source_type_id=7 then (select prha.segment1 from po_requisition_headers_all prha where prha.requisition_header_id=mmt.transaction_source_id) --Requisition
when mmt.transaction_source_type_id=5 then (select we.wip_entity_name from wip_entities we where we.wip_entity_id=mmt.transaction_source_id) --WIP Job or Schedule
when mmt.transaction_source_type_id=4 then (select mtrh.request_number from mtl_txn_request_headers mtrh where mtrh.header_id=mmt.transaction_source_id) --Move Order
else null
end inv_transaction_source,
mmt.transaction_id inv_transaction_id,
--
xxen_util.user_name(gjh.created_by) journal_created_by,
gjh.creation_date journal_creation_date,
(select fav.application_name from fnd_application_vl fav where xal.application_id=fav.application_id) application,
gjb.je_batch_id,
gjl.je_header_id,
gjl.context dff_context,
xal.application_id,
xal.ae_header_id,
xal.ae_line_num,
xah.event_id,
xe.event_type_code,
xe.event_date,
&segments_with_desc
xal.accounting_class_code,
xte.entity_code,
xte.source_id_int_1,
xdl.source_distribution_type,
xdl.accounting_line_code,
xdl.applied_to_distribution_type,
gp.start_date period_date,
gp.period_name period,
'Journal' record_type
from
gl_ledgers gl,
gl_periods gp,
gl_je_batches gjb,
gl_je_headers gjh,
gl_je_lines gjl,
(select gir.* from gl_import_references gir where gir.gl_sl_link_table='XLAJEL' and gir.gl_sl_link_id is not null) gir,
xla_ae_lines xal,
xla_ae_headers xah,
xla_events xe,
xla.xla_transaction_entities xte,
xla_distribution_links xdl,
gcck gcck,
(select gdr.* from gl_daily_rates gdr where gdr.to_currency=:revaluation_currency and gdr.conversion_type=(select gdct.conversion_type from gl_daily_conversion_types gdct where gdct.user_conversion_type=:revaluation_conversion_type)) gdr,
zx_rates_b zrb,
ap_invoices_all aia,
ap_checks_all aca,
ap_invoice_distributions_all aida,
ap_payment_hist_dists aphd,
ap_invoice_lines_all aila,
po_distributions_all pda,
po_line_locations_all plla,
po_lines_all pla,
ra_customer_trx_all rcta,
ra_cust_trx_line_gl_dist_all rctlgda,
ra_customer_trx_lines_all rctla,
zx_lines zl,
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_vl jrrev,
ar_adjustments_all aaa,
ar_cash_receipts_all acra,
pa_projects_all ppa,
pa_tasks pt,
pa_draft_revenues_all pdra,
pa_agreements_all paa,
pa_expenditure_items_all peia,
pa_expenditures_all pea,
pa_expenditure_types pet,
(select papf.* from per_all_people_f papf where sysdate>=papf.effective_start_date and sysdate<papf.effective_end_date+1) papf,
rcv_transactions rt,
rcv_shipment_lines rsl,
wip_transactions wt,
wip_entities we,
bom_departments bd,
bom_resources br,
gmf_xla_extract_headers gxeh, --OPM
-- inventory
mtl_material_transactions mmt,
mtl_system_items_vl msiv,
mtl_parameters mp,
mtl_transaction_types mtt,
mtl_txn_source_types mtst
where
1=1 and
3=3 and
gl.period_set_name=gp.period_set_name and
gp.period_name=gjh.period_name and
gp.period_name=gjl.period_name and
gl.ledger_id=gjh.ledger_id and
gjb.je_batch_id=gjh.je_batch_id and
gjh.je_header_id=gjl.je_header_id and
gjl.je_header_id=gir.je_header_id(+) and
gjl.je_line_num=gir.je_line_num(+) and
gir.gl_sl_link_id=xal.gl_sl_link_id(+) and
gir.gl_sl_link_table=xal.gl_sl_link_table(+) and
xal.ae_header_id=xah.ae_header_id(+) and
xal.application_id=xah.application_id(+) and
xah.gl_transfer_status_code(+)='Y' and
xah.accounting_entry_status_code(+)='F' and
xah.event_id=xe.event_id(+) and
xah.application_id=xe.application_id(+) and
xah.entity_id=xte.entity_id(+) and
xah.application_id=xte.application_id(+) and
xal.application_id=xdl.application_id(+) and
xal.ae_header_id=xdl.ae_header_id(+) and
xal.ae_line_num=xdl.ae_line_num(+) and
gjl.code_combination_id=gcck.code_combination_id and
coalesce(
xal.currency_conversion_date,
gjh.currency_conversion_date,
trunc(xe.transaction_date)
)=gdr.conversion_date(+) and
decode(nvl2(xal.gl_sl_link_id,xal.currency_code,gjh.currency_code),:revaluation_currency,null,nvl2(xal.gl_sl_link_id,xal.currency_code,gjh.currency_code))=gdr.from_currency(+) and
gjl.tax_code_id=zrb.tax_rate_id(+) and
case when xte.application_id=200 and xte.entity_code='AP_PAYMENTS' then xte.source_id_int_1 end=aca.check_id(+) and
case
when xdl.application_id=200 and xdl.source_distribution_type='AP_INV_DIST' then xdl.source_distribution_id_num_1
when xdl.application_id=200 and xdl.applied_to_distribution_type='AP_INV_DIST' then xdl.applied_to_dist_id_num_1
end=aida.invoice_distribution_id(+) and
case when xdl.application_id=200 and xdl.source_distribution_type='AP_PMT_DIST' then xdl.source_distribution_id_num_1 end=aphd.payment_hist_dist_id(+) and
aida.invoice_id=aia.invoice_id(+) and
aida.invoice_id=aila.invoice_id(+) and
aida.invoice_line_number=aila.line_number(+) and
nvl(aida.po_distribution_id,aila.po_distribution_id)=pda.po_distribution_id(+) and
nvl(pda.line_location_id,aila.po_line_location_id)=plla.line_location_id(+) and
nvl(plla.po_line_id,rt.po_line_id)=pla.po_line_id(+) and
case when xte.application_id=222 then case when xte.entity_code in ('TRANSACTIONS','BILLS_RECEIVABLE') then xte.source_id_int_1 when xte.entity_code='ADJUSTMENTS' then aaa.customer_trx_id end end=rcta.customer_trx_id(+) and
rcta.primary_salesrep_id=jrs.salesrep_id(+) and
rcta.org_id=jrs.org_id(+) and
jrs.resource_id=jrrev.resource_id(+) and
case when xte.application_id=222 and xte.entity_code='ADJUSTMENTS' then xte.source_id_int_1 end=aaa.adjustment_id(+) and
case when xte.application_id=222 and xte.entity_code='RECEIPTS' then xte.source_id_int_1 end=acra.cash_receipt_id(+) and
case when xdl.application_id=222 and xdl.source_distribution_type='RA_CUST_TRX_LINE_GL_DIST_ALL' then xdl.source_distribution_id_num_1 end=rctlgda.cust_trx_line_gl_dist_id(+) and
rctlgda.customer_trx_line_id=rctla.customer_trx_line_id(+) and
rctla.tax_line_id=zl.tax_line_id(+) and
case when xte.application_id=275 then decode(xte.entity_code,'REVENUE',xte.source_id_int_1,'EXPENDITURES',peia.project_id) end=ppa.project_id(+) and
case when xte.application_id=275 and xte.entity_code='REVENUE' then xte.source_id_int_1 end=pdra.project_id(+) and
case when xte.application_id=275 and xte.entity_code='REVENUE' then xte.source_id_int_2 end=pdra.draft_revenue_num(+) and
pdra.agreement_id=paa.agreement_id(+) and
case when xte.application_id=275 and xte.entity_code='EXPENDITURES' then xte.source_id_int_1 end=peia.expenditure_item_id(+) and
nvl(aida.task_id,peia.task_id)=pt.task_id(+) and
peia.expenditure_id=pea.expenditure_id(+) and
peia.expenditure_type=pet.expenditure_type(+) and
pea.incurred_by_person_id=papf.person_id(+) and
case when xah.application_id=555 then xah.event_id end=gxeh.event_id(+) and --OPM
case
when xte.application_id=707 and xte.entity_code='RCV_ACCOUNTING_EVENTS' then xte.source_id_int_1
when xte.application_id=555 and gxeh.txn_source='PUR' then gxeh.source_line_id --OPM
when xdl.application_id=200 and xdl.source_distribution_type='AP_INV_DIST' then nvl(aida.rcv_transaction_id,aila.rcv_transaction_id)
when xdl.application_id=200 and xdl.applied_to_distribution_type='AP_INV_DIST' then nvl(aida.rcv_transaction_id,aila.rcv_transaction_id)
end=rt.transaction_id(+) and
rt.shipment_line_id=rsl.shipment_line_id(+) and
case when xte.application_id=707 and xte.entity_code='WIP_ACCOUNTING_EVENTS' then xte.source_id_int_1 end=wt.transaction_id(+) and
wt.wip_entity_id=we.wip_entity_id(+) and
wt.department_id=bd.department_id(+) and
wt.resource_id=br.resource_id(+) and
--inventory
case when xte.application_id=707 and xte.entity_code='MTL_ACCOUNTING_EVENTS' then xte.source_id_int_1
     when xah.application_id=555 then gxeh.transaction_id end=mmt.transaction_id(+) and
coalesce(mmt.organization_id,rsl.to_organization_id,plla.ship_to_organization_id,we.organization_id,rctla.warehouse_id)=msiv.organization_id(+) and
coalesce(mmt.inventory_item_id,rsl.item_id,pla.item_id,we.primary_item_id,rctla.inventory_item_id)=msiv.inventory_item_id(+) and
coalesce(mmt.organization_id,rt.organization_id,rsl.to_organization_id,plla.ship_to_organization_id,we.organization_id,nvl2(rctla.inventory_item_id,rctla.warehouse_id,null))=mp.organization_id(+) and
mmt.transaction_type_id=mtt.transaction_type_id(+) and
mmt.transaction_source_type_id=mtst.transaction_source_type_id(+)
union all
select -- GL Opening Balance
' ' || gp.period_name || ' Open Bal' period_name,
'00 ' || gp.period_name || ' Open Bal' period_name_label,
gl.name ledger,
null source_name,
null reference,
null category_name,
null batch_name,
null batch_status,
null posted_date,
null journal_name,
null journal_description,
null document_number,
null tax_status_code,
null line_number,
gcck.concatenated_segments,
null line_entered_dr,
null line_entered_cr,
null line_entered_amount,
gb.begin_balance_dr line_accounted_dr,
gb.begin_balance_cr line_accounted_cr,
nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0) line_accounted_amount,
null line_description,
null tax_rate_code,
null tax_rate,
null tax_line,
null taxable_line,
null amount_includes_tax,
null accounting_class,
xxen_util.meaning(gcck.gl_account_type,'ACCOUNT_TYPE',0) account_type,
&hierarchy_levels3
&segment_columns
null entered_dr,
null entered_cr,
null entered_amount,
null transaction_currency,
gb.begin_balance_dr accounted_dr,
gb.begin_balance_cr accounted_cr,
nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0) accounted_amount,
gl.currency_code ledger_currency,
&revaluation_columns_balo
null doc_sequence_value,
null event_type,
null currency_conversion_date,
null currency_conversion_type,
null currency_conversion_rate,
xxen_util.description(gb.actual_flag,'BATCH_TYPE',101) balance_type,
(select gbv.budget_name from gl_budget_versions gbv where gb.budget_version_id=gbv.budget_version_id) budget_name,
null conversion_date,
null conversion_type,
null conversion_rate,
null accounting_event_description,
null accounting_date,
null transaction_date,
null transaction_number,
-- Source Line Description
null source_line_description,
-- Assets
null asset_number,
--AP
null invoice_number,
null invoice_description,
null invoice_line_number,
null invoice_date,
null gl_date,
null invoice_currency_code,
null payment_currency_code,
null payment_method_code,
null invoice_amount,
null purchase_order,
null purchase_order_line,
--AR
null sales_order,
null salesperson,
null invoice_rule,
null accounting_rule,
null po_quantity,
null vendor_or_customer,
--Projects
null project,
null task,
null expenditure_group,
null expenditure_class_code,
null expenditure_status_code,
null expenditure_category,
null expenditure_type,
null expenditure_type_description,
null expenditure_item_date,
null expenditure_item_quantity,
null expenditure_unit_of_measure,
null incurred_by_person,
null incurred_by_employee_number,
--WIP
null department_code,
null resource_code,
null wip_job,
null operation_seq_num,
null transaction_quantity,
null transaction_uom,
null primary_quantity,
-- inventory
null inv_transaction_date,
null inv_organization,
null inv_subinventory,
null inv_item,
null inv_item_description,
null inv_transaction_unit_cost,
null inv_actual_unit_cost,
null inv_transaction_reference,
null inv_transaction_source_type,
null inv_transaction_type,
null inv_transaction_source,
null inv_transaction_id,
--
null journal_created_by,
null journal_creation_date,
null application,
null je_batch_id,
null je_header_id,
null dff_context,
null application_id,
null ae_header_id,
null ae_line_num,
null event_id,
null event_type_code,
null event_date,
&segments_with_desc
null accounting_class_code,
null entity_code,
null source_id_int_1,
null source_distribution_type,
null accounting_line_code,
null applied_to_distribution_type,
gp.start_date-1 period_date,
gp.period_name period,
'Balance' record_type
from
gl_ledgers gl,
gl_periods gp,
gl_balances gb,
gcck gcck,
(select gdr.* from gl_daily_rates gdr where gdr.to_currency=:revaluation_currency and gdr.conversion_type=(select gdct.conversion_type from gl_daily_conversion_types gdct where gdct.user_conversion_type=:revaluation_conversion_type)) gdr
where
-- opening balance is outer joined in case account became active after period from
-- and restrict to accounts which have a balance as at period to
-- in case report is run historically, exclude accounts made active after the period to
1=1 and
4=4 and
:p_show_balances is not null and
gp.period_name=nvl(:period_name,:period_name_from) and
gl.period_set_name=gp.period_set_name and
gl.accounted_period_type=gp.period_type and
gcck.chart_of_accounts_id=gl.chart_of_accounts_id and
gb.period_name(+)=gp.period_name and
gb.ledger_id(+)=gl.ledger_id and
gb.currency_code(+)=gl.currency_code and
gb.template_id(+) is null and
gb.code_combination_id(+)=gcck.code_combination_id and
gp.start_date=gdr.conversion_date(+) and
exists
(select null
 from
 gl_balances gb2
 where
 gb2.period_name=nvl(:period_name,:period_name_to) and
 gb2.ledger_id=gl.ledger_id and
 gb2.currency_code=gl.currency_code and
 gb2.template_id is null and
 gb2.code_combination_id=gcck.code_combination_id and
 (:balance_type is null or gb2.actual_flag=(select flvv.lookup_code from fnd_lookup_values_vl flvv where flvv.description=:balance_type and flvv.lookup_type='BATCH_TYPE' and flvv.view_application_id=101 and flvv.security_group_id=0))
) and
decode(gb.currency_code,:revaluation_currency,null,gb.currency_code)=gdr.from_currency(+)
union all
select -- GL Closing Balance
'?' || gp.period_name || ' Close Bal' period_name,
'99 ' || gp.period_name || ' Close Bal' period_name_label,
gl.name ledger,
null source_name,
null reference,
null category_name,
null batch_name,
null batch_status,
null posted_date,
null journal_name,
null journal_description,
null document_number,
null tax_status_code,
null line_number,
gcck.concatenated_segments,
null line_entered_dr,
null line_entered_cr,
null line_entered_amount,
nvl(gb.begin_balance_dr,0)+nvl(gb.period_net_dr,0) line_accounted_dr,
nvl(gb.begin_balance_cr,0)+nvl(gb.period_net_cr,0) line_accounted_cr,
nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)+nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0) line_accounted_amount,
null line_description,
null tax_rate_code,
null tax_rate,
null tax_line,
null taxable_line,
null amount_includes_tax,
null accounting_class,
xxen_util.meaning(gcck.gl_account_type,'ACCOUNT_TYPE',0) account_type,
&hierarchy_levels3
&segment_columns
null entered_dr,
null entered_cr,
null entered_amount,
null transaction_currency,
nvl(gb.begin_balance_dr,0)+nvl(gb.period_net_dr,0) accounted_dr,
nvl(gb.begin_balance_cr,0)+nvl(gb.period_net_cr,0) accounted_cr,
nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0)+nvl(gb.period_net_dr,0)-nvl(gb.period_net_cr,0) accounted_amount,
gl.currency_code ledger_currency,
&revaluation_columns_balc
null doc_sequence_value,
null event_type,
null currency_conversion_date,
null currency_conversion_type,
null currency_conversion_rate,
xxen_util.description(gb.actual_flag,'BATCH_TYPE',101) balance_type,
(select gbv.budget_name from gl_budget_versions gbv where gb.budget_version_id=gbv.budget_version_id) budget_name,
null conversion_date,
null conversion_type,
null conversion_rate,
null accounting_event_description,
null accounting_date,
null transaction_date,
null transaction_number,
-- Source Line Description
null source_line_description,
-- Assets
null asset_number,
--AP
null invoice_number,
null invoice_description,
null invoice_line_number,
null invoice_date,
null gl_date,
null invoice_currency_code,
null payment_currency_code,
null payment_method_code,
null invoice_amount,
null purchase_order,
null purchase_order_line,
--AR
null sales_order,
null salesperson,
null invoice_rule,
null accounting_rule,
null po_quantity,
null vendor_or_customer,
--Projects
null project,
null task,
null expenditure_group,
null expenditure_class_code,
null expenditure_status_code,
null expenditure_category,
null expenditure_type,
null expenditure_type_description,
null expenditure_item_date,
null expenditure_item_quantity,
null expenditure_unit_of_measure,
null incurred_by_person,
null incurred_by_employee_number,
--WIP
null department_code,
null resource_code,
null wip_job,
null operation_seq_num,
null transaction_quantity,
null transaction_uom,
null primary_quantity,
-- inventory
null inv_transaction_date,
null inv_organization,
null inv_subinventory,
null inv_item,
null inv_item_description,
null inv_transaction_unit_cost,
null inv_actual_unit_cost,
null inv_transaction_reference,
null inv_transaction_source_type,
null inv_transaction_type,
null inv_transaction_source,
null inv_transaction_id,
--
null journal_created_by,
null journal_creation_date,
null application,
null je_batch_id,
null je_header_id,
null dff_context,
null application_id,
null ae_header_id,
null ae_line_num,
null event_id,
null event_type_code,
null event_date,
&segments_with_desc
null accounting_class_code,
null entity_code,
null source_id_int_1,
null source_distribution_type,
null accounting_line_code,
null applied_to_distribution_type,
gp.end_date period_date,
gp.period_name period,
'Balance' record_type
from
gl_ledgers gl,
gl_periods gp,
gl_balances gb,
gcck gcck,
(select gdr.* from gl_daily_rates gdr where gdr.to_currency=:revaluation_currency and gdr.conversion_type=(select gdct.conversion_type from gl_daily_conversion_types gdct where gdct.user_conversion_type=:revaluation_conversion_type)) gdr
where
1=1 and
4=4 and
:p_show_balances is not null and
gp.period_name=nvl(:period_name,:period_name_to) and
gl.period_set_name=gp.period_set_name and
gl.accounted_period_type=gp.period_type and
gcck.chart_of_accounts_id=gl.chart_of_accounts_id and
gb.period_name=gp.period_name and
gb.ledger_id=gl.ledger_id and
gb.currency_code=gl.currency_code and
gb.template_id is null and
gb.code_combination_id=gcck.code_combination_id and
gp.end_date=gdr.conversion_date(+) and
decode(gb.currency_code,:revaluation_currency,null,gb.currency_code)=gdr.from_currency(+)
) x
) y
where
5=5
order by
y.ledger,
y.concatenated_segments,
y.period_date,
y.period_name,
y.batch_name,
y.journal_name,
y.line_number,
y.transaction_date,
y.transaction_number