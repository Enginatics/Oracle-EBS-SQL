/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Account Analysis (Drilldown)
-- Description: ** This report is used by the GL Financial Statement and Drilldown report, to show Subledger details. **

Detail GL transaction report with one line per transaction including all segments and subledger data, with amounts in both transaction currency and ledger currency.
For drilldown to the transaction screen please ensure the column View Transaction is present in the Displayed Columns
View Transaction
-- Excel Examle Output: https://www.enginatics.com/example/gl-account-analysis-drilldown/
-- Library Link: https://www.enginatics.com/reports/gl-account-analysis-drilldown/
-- Run Report: https://demo.enginatics.com/

select
x.*,
case when x.entity_code='TRANSACTIONS' and rcta.interface_header_context in ('ORDER ENTRY','INTERCOMPANY') then rcta.interface_header_attribute1 end sales_order,
(select name from ra_rules rr where rcta.invoicing_rule_id=rule_id) invoice_rule,
(select rr.name from ra_customer_trx_lines_all rctla, ra_rules rr where rcta.customer_trx_id=rctla.customer_trx_id and rctla.line_type='LINE' and rctla.accounting_rule_id=rr.rule_id and rownum=1) accounting_rule,
coalesce(x.project_,nvl(x.project_,case when x.entity_code='TRANSACTIONS' and rcta.interface_header_context='PROJECTS INVOICES' then rcta.interface_header_attribute1 end)) project_,
coalesce(x.vendor_or_customer,(select hp.party_name from hz_cust_accounts hca, hz_parties hp where coalesce(rcta.bill_to_customer_id,x.acra_pay_from_customer,x.paa_customer_id)=hca.cust_account_id and hca.party_id=hp.party_id)) vendor_or_customer_
from
(
select /*+ push_pred(aida)*/
case when count(distinct gp.period_num) over ()>1 then lpad(gp.period_num,2,'0')||' ' end||gjh.period_name period_name,
gl.name ledger,
(select gjsv.user_je_source_name from gl_je_sources_vl gjsv where gjh.je_source=gjsv.je_source_name) source_name,
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
gjl.description line_description,
xxen_util.meaning(xal.accounting_class_code,'XLA_ACCOUNTING_CLASS',602) accounting_class_code,
xxen_util.meaning(gcck.gl_account_type,'ACCOUNT_TYPE',0) account_type,
&segment_columns
nvl2(xal.gl_sl_link_id,xal.entered_dr,gjl.entered_dr) entered_dr,
nvl2(xal.gl_sl_link_id,xal.entered_cr,gjl.entered_cr) entered_cr,
nvl(nvl2(xal.gl_sl_link_id,xal.entered_dr,gjl.entered_dr),0)-nvl(nvl2(xal.gl_sl_link_id,xal.entered_cr,gjl.entered_cr),0) entered_amount,
nvl2(xal.gl_sl_link_id,xal.currency_code,gjh.currency_code) transaction_currency,
nvl2(xal.gl_sl_link_id,xal.accounted_dr,gjl.accounted_dr) accounted_dr,
nvl2(xal.gl_sl_link_id,xal.accounted_cr,gjl.accounted_cr) accounted_cr,
nvl(nvl2(xal.gl_sl_link_id,xal.accounted_dr,gjl.accounted_dr),0)-nvl(nvl2(xal.gl_sl_link_id,xal.accounted_cr,gjl.accounted_cr),0) accounted_amount,
gl.currency_code ledger_currency,
nvl(gjh.doc_sequence_value,xah.doc_sequence_value) doc_sequence_value,
(select xett.name from xla_event_types_tl xett where xte.application_id=xett.application_id and xte.entity_code=xett.entity_code and xe.event_type_code=xett.event_type_code and xett.language=userenv('lang')) event_type,
xal.currency_conversion_date,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where xal.currency_conversion_type=gdct.conversion_type) currency_conversion_type,
xal.currency_conversion_rate,
xxen_util.description(gjh.actual_flag,'BATCH_TYPE',101) balance_type,
(select gbv.budget_name from gl_budget_versions gbv where gjh.budget_version_id=gbv.budget_version_id) budget_name,
(select get.encumbrance_type from gl_encumbrance_types get where get.encumbrance_type_id=gjh.encumbrance_type_id) encumbrance_type,
gjh.currency_conversion_date conversion_date,
gjh.currency_conversion_type conversion_type,
gjh.currency_conversion_rate conversion_rate,
xe.transaction_date,
xte.transaction_number,
fab.asset_number,
(
select distinct
listagg(fdh.concatenated_segments,chr(10)) within group (order by fdh.concatenated_segments) over (partition by fdh.asset_id) expense_account
from
(
select
fdh.asset_id,
gcck.concatenated_segments,
sum(lengthb(gcck.concatenated_segments)+1) over (partition by fdh.asset_id order by gcck.concatenated_segments rows between unbounded preceding and current row) total_length
from
(select distinct fdh.asset_id, fdh.code_combination_id from fa_distribution_history fdh where fab.asset_id=fdh.asset_id and fdh.date_ineffective is null) fdh,
gl_code_combinations_kfv gcck
where
fdh.code_combination_id=gcck.code_combination_id
) fdh
where
fdh.total_length<=4000
) expense_account,
aia.description description,
(select pha.segment1 from po_headers_all pha where nvl(aia.quick_po_header_id,rt.po_header_id)=pha.po_header_id) purchase_order,
(select pha.comments from po_headers_all pha where nvl(aia.quick_po_header_id,rt.po_header_id)=pha.po_header_id) po_description,
rsh.receipt_num goods_receipt_number,
rt.quantity po_quantity,
acra.receipt_number cash_receipt_number,
coalesce(
(select aps.vendor_name from ap_suppliers aps where coalesce(decode(xal.party_type_code,'S',xal.party_id,null),aia.vendor_id,aca.vendor_id,rt.vendor_id)=aps.vendor_id),
(select hp.party_name from hz_cust_accounts hca, hz_parties hp where decode(xal.party_type_code,'C',xal.party_id,null)=hca.cust_account_id and hca.party_id=hp.party_id)
) vendor_or_customer,
coalesce(
(select ppa.segment1 from pa_projects_all ppa where aida.project_id=ppa.project_id),
(select ppa.segment1 from pa_projects_all ppa where case when xte.application_id=275 then decode(xte.entity_code,'REVENUE',xte.source_id_int_1,'EXPENDITURES',peia.project_id) end=ppa.project_id)
) project_,
(select pt.task_number from pa_tasks pt where nvl(aida.task_id,peia.task_id)=pt.task_id) task,
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
xxen_util.user_name(gjh.created_by) journal_created_by,
gjh.creation_date journal_creation_date,
gjb.je_batch_id,
gjl.je_header_id,
gjl.je_line_num,
gjl.context dff_context,
xal.application_id,
xal.ae_header_id,
xal.ae_line_num,
xah.event_id,
xe.event_date,
xte.entity_code,
&segments_with_desc
xte.source_id_int_1,
case when xte.application_id=222 then case when xte.entity_code in ('TRANSACTIONS','BILLS_RECEIVABLE') then xte.source_id_int_1 when xte.entity_code='ADJUSTMENTS' then aaa.customer_trx_id end end customer_trx_id,
paa.customer_id paa_customer_id,
acra.pay_from_customer acra_pay_from_customer,
case when nvl(fnd_profile.value('XXEN_FSG_DRILLDOWN_TO_SAME_WORKBOOK'), 'Y')='N' then '=dd' else '=dds' end
||'("VT","'||gl.ledger_id||','||gjsv.user_je_source_name||','||xah.event_id||','||gjl.je_line_num||'")' view_transaction
from
gl_ledgers gl,
gl_periods gp,
gl_je_batches gjb,
gl_je_headers gjh,
gl_je_lines gjl,
gl_je_sources_vl gjsv,
gl_je_categories_vl gjcv,
(select gir.* from gl_import_references gir where gir.gl_sl_link_table in ('XLAJEL','APECL') and gir.gl_sl_link_id is not null) gir,
xla_ae_lines xal,
xla_ae_headers xah,
xla_events xe,
xla.xla_transaction_entities xte, 
gl_code_combinations_kfv gcck,
fa_transaction_headers fth,
fa_additions_b fab,
ap_invoices_all aia,
(select distinct aida.invoice_id, min(aida.project_id) keep (dense_rank first order by aida.invoice_distribution_id) over (partition by aida.invoice_id) project_id, min(aida.task_id) keep (dense_rank first order by aida.invoice_distribution_id) over (partition by aida.invoice_id) task_id from ap_invoice_distributions_all aida where aida.task_id is not null) aida,
ap_checks_all aca,
ar_adjustments_all aaa,
ar_cash_receipts_all acra,
pa_draft_revenues_all pdra,
pa_agreements_all paa,
pa_expenditure_items_all peia,
pa_expenditures_all pea,
pa_expenditure_types pet,
(select papf.* from per_all_people_f papf where sysdate>=papf.effective_start_date and sysdate<papf.effective_end_date+1) papf,
rcv_transactions rt,
rcv_shipment_headers rsh
where
1=1 and
gl.period_set_name=gp.period_set_name and
gp.period_name=gjh.period_name and
gp.period_name=gjl.period_name and
gl.ledger_id=gjh.ledger_id and
gjb.je_batch_id=gjh.je_batch_id and
gjh.je_header_id=gjl.je_header_id and
gjh.je_category=gjcv.je_category_name and
gjh.je_source=gjsv.je_source_name and
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
&gl_flex_value_security
gjl.code_combination_id=gcck.code_combination_id and
case when xte.application_id=140 and xte.entity_code='TRANSACTIONS' then xte.source_id_int_1 end=fth.transaction_header_id(+) and
case when xte.application_id=140 then case when xte.entity_code in ('DEPRECIATION','DEFERRED_DEPRECIATION') then xte.source_id_int_1 when xte.entity_code='TRANSACTIONS' then fth.asset_id end end=fab.asset_id(+) and
case when xte.application_id=200 and xte.entity_code='AP_INVOICES' then xte.source_id_int_1 end=aia.invoice_id(+) and
aia.invoice_id=aida.invoice_id(+) and
case when xte.application_id=200 and xte.entity_code='AP_PAYMENTS' then xte.source_id_int_1 end=aca.check_id(+) and
case when xte.application_id=222 and xte.entity_code='ADJUSTMENTS' then xte.source_id_int_1 end=aaa.adjustment_id(+) and
case when xte.application_id=222 and xte.entity_code='RECEIPTS' then xte.source_id_int_1 end=acra.cash_receipt_id(+) and
case when xte.application_id=275 and xte.entity_code='REVENUE' then xte.source_id_int_1 end=pdra.project_id(+) and
case when xte.application_id=275 and xte.entity_code='REVENUE' then xte.source_id_int_2 end=pdra.draft_revenue_num(+) and
pdra.agreement_id=paa.agreement_id(+) and
case when xte.application_id=275 and xte.entity_code='EXPENDITURES' then xte.source_id_int_1 end=peia.expenditure_item_id(+) and
peia.expenditure_id=pea.expenditure_id(+) and
peia.expenditure_type=pet.expenditure_type(+) and
pea.incurred_by_person_id=papf.person_id(+) and
case when xte.application_id=707 and xte.entity_code='RCV_ACCOUNTING_EVENTS' then xte.source_id_int_1 end=rt.transaction_id(+) and
rt.shipment_header_id=rsh.shipment_header_id(+)
) x,
ra_customer_trx_all rcta
where
x.customer_trx_id=rcta.customer_trx_id(+)