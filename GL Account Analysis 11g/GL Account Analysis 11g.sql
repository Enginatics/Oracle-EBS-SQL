/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Account Analysis 11g
-- Description: Backwards compatible version (for 11g databases) of the detail GL transaction report with one line per transaction including all segments and subledger data, with amounts in both transaction currency and ledger currency.
-- Excel Examle Output: https://www.enginatics.com/example/gl-account-analysis-11g/
-- Library Link: https://www.enginatics.com/reports/gl-account-analysis-11g/
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
select
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
&hierarchy_levels3
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
(select get.encumbrance_type from gl_encumbrance_types get where get.encumbrance_type_id = gjh.encumbrance_type_id) encumbrance_type,
gjh.currency_conversion_date conversion_date,
gjh.currency_conversion_type conversion_type,
gjh.currency_conversion_rate conversion_rate,
xe.transaction_date,
xte.transaction_number,
-- Assets
case
when xte.application_id = 140 and xte.entity_code = 'TRANSACTIONS'
then (select fab.asset_number from fa_additions_b fab,fa_transaction_headers fth where fth.asset_id=fab.asset_id and fth.transaction_header_id=xte.source_id_int_1 and fth.event_id = xe.event_id)
when xte.application_id = 140 and xte.entity_code = 'DEPRECIATION'
then (select fab.asset_number from fa_additions_b fab, fa_deprn_detail fdd where fab.asset_id=fdd.asset_id and fdd.asset_id=xte.source_id_int_1 and fdd.period_counter=xte.source_id_int_2 and fdd.event_id=xe.event_id and rownum=1)
end asset_number,
--subledger columns
aia.description description,
(select pha.segment1 from po_headers_all pha where nvl(aia.quick_po_header_id,rt.po_header_id)=pha.po_header_id) purchase_order,
--AR
rt.quantity po_quantity,
coalesce(
(select aps.vendor_name from ap_suppliers aps where coalesce(decode(xal.party_type_code,'S',xal.party_id,null),aia.vendor_id,aca.vendor_id,rt.vendor_id)=aps.vendor_id),
(select hp.party_name from hz_cust_accounts hca, hz_parties hp where decode(xal.party_type_code,'C',xal.party_id,null)=hca.cust_account_id and hca.party_id=hp.party_id)
) vendor_or_customer,
-- AP/AR MDM Party/Site Identifier
case when xal.party_type_code is not null
then xal.party_type_code || '-' || nvl(to_char(xal.party_id),'UNKNOWN') || '-' || nvl(to_char(xal.party_site_id),'0')
else null
end mdm_party_id,
case xal.party_type_code
when 'C'
then xal.party_type_code || '-' ||
     nvl((select hp.party_name from hz_parties hp, hz_cust_accounts hca where hp.party_id=hca.party_id and hca.cust_account_id=xal.party_id),'UNKNOWN') || '-' ||
     nvl((select hcsua.location from hz_cust_site_uses_all hcsua where hcsua.site_use_id = xal.party_site_id),'0')
when 'S'
then xal.party_type_code || '-' ||
     nvl((select aps.vendor_name from ap_suppliers aps where aps.vendor_id=xal.party_id),'UNKNOWN') || '-' ||
     nvl((select apssa.vendor_site_code from ap_supplier_sites_all apssa where apssa.vendor_site_id = xal.party_site_id),'0')
else null
end mdm_party_desc,
--Projects
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
acra.pay_from_customer acra_pay_from_customer
from
gl_ledgers gl,
gl_periods gp,
gl_je_batches gjb,
gl_je_headers gjh,
gl_je_lines gjl,
(select gir.je_header_id, gir.je_line_num, xal.* from gl_import_references gir, xla_ae_lines xal where gir.gl_sl_link_id=xal.gl_sl_link_id and gir.gl_sl_link_table=xal.gl_sl_link_table
) xal,
xla_ae_headers xah,
xla_events xe,
xla.xla_transaction_entities xte,
(
select
&hierarchy_levels2
gcck.*
from
(
select
(
select
fifs.flex_value_set_id
from
fnd_id_flex_segments fifs,
fnd_flex_values ffv
where
gcck.chart_of_accounts_id=fifs.id_flex_num and
fifs.application_id=101 and
fifs.id_flex_code='GL#' and
fifs.application_column_name='&hierarchy_segment_column' and
fifs.flex_value_set_id=ffv.flex_value_set_id and
ffv.parent_flex_value_low is null and
ffv.summary_flag='N' and
5=5
) flex_value_set_id,
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
) gcck,
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
rcv_transactions rt
where
1=1 and
gl.period_set_name=gp.period_set_name and
gp.period_name=gjh.period_name and
gp.period_name=gjl.period_name and
gl.ledger_id=gjh.ledger_id and
gjb.je_batch_id=gjh.je_batch_id and
gjh.je_header_id=gjl.je_header_id and
gjl.je_header_id=xal.je_header_id(+) and
gjl.je_line_num=xal.je_line_num(+) and
xal.ae_header_id=xah.ae_header_id(+) and
xal.application_id=xah.application_id(+) and
xah.gl_transfer_status_code(+)='Y' and
xah.accounting_entry_status_code(+)='F' and
xah.event_id=xe.event_id(+) and
xah.application_id=xe.application_id(+) and
xah.entity_id=xte.entity_id(+) and
xah.application_id=xte.application_id(+) and
gl_security_pkg.validate_access(null,gjl.code_combination_id)='TRUE' and
gjl.code_combination_id=gcck.code_combination_id and
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
case when xte.application_id=707 and xte.entity_code='RCV_ACCOUNTING_EVENTS' then xte.source_id_int_1 end=rt.transaction_id(+)
) x,
ra_customer_trx_all rcta
where
x.customer_trx_id=rcta.customer_trx_id(+)