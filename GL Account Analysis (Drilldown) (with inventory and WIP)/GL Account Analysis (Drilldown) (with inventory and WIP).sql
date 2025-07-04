/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Account Analysis (Drilldown) (with inventory and WIP)
-- Description: ** This report is used by the GL Financial Statement and Drilldown report, to show Subledger details. **

Detail GL transaction report with one line per transaction including all segments and subledger data, with amounts in both transaction currency and ledger currency. This also has inventory and WIP details.
-- Excel Examle Output: https://www.enginatics.com/example/gl-account-analysis-drilldown-with-inventory-and-wip/
-- Library Link: https://www.enginatics.com/reports/gl-account-analysis-drilldown-with-inventory-and-wip/
-- Run Report: https://demo.enginatics.com/

with gcck as (select &materialize_hint gcck.* from gl_code_combinations_kfv gcck where 2=2)
select /*+ &leading_hint push_pred(msiv) */
case when count(distinct gp.period_num) over ()>1 then lpad(gp.period_num,2,'0')||' ' end||gjh.period_name period_name,
lpad(gp.period_num,2,'0')||' '||gjh.period_name period_name_label,
gl.name ledger,
gjsv.user_je_source_name source_name,
gjh.external_reference reference,
gjcv.user_je_category_name category_name,
gjb.name batch_name,
xxen_util.meaning(gjb.status,'MJE_BATCH_STATUS',101) batch_status,
gjh.posted_date,
gjh.name journal_name,
gjh.description journal_description,
xxen_util.meaning(gjh.tax_status_code,'TAX_STATUS',101) tax_status_code,
gjl.je_line_num line_number,
gcck.concatenated_segments,
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcck.chart_of_accounts_id, null, gcck.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') concatenated_segments_desc,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then gjl.entered_dr end line_entered_dr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then gjl.entered_cr end line_entered_cr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then nvl(gjl.entered_dr,0)-nvl(gjl.entered_cr,0) end line_entered_amount,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then gjl.accounted_dr end line_accounted_dr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then gjl.accounted_cr end line_accounted_cr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) end line_accounted_amount,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then gjl.stat_amount end line_stat_amount,
gjl.description line_description,
zrb.tax_rate_code,
xxen_util.meaning(gjl.tax_line_flag,'YES_NO',0) tax_line,
xxen_util.meaning(gjl.taxable_line_flag,'YES_NO',0) taxable_line,
xxen_util.meaning(gjl.amount_includes_tax_flag,'YES_NO',0) amount_includes_tax,
xxen_util.meaning(xal.accounting_class_code,'XLA_ACCOUNTING_CLASS',602,'Y') accounting_class,
xxen_util.meaning(gcck.gl_account_type,'ACCOUNT_TYPE',0) account_type,
&segment_columns
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num) then nvl2(xal.gl_sl_link_id,xal.entered_dr,gjl.entered_dr) end entered_dr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num) then nvl2(xal.gl_sl_link_id,xal.entered_cr,gjl.entered_cr) end entered_cr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num) then nvl(nvl2(xal.gl_sl_link_id,xal.entered_dr,gjl.entered_dr),0)-nvl(nvl2(xal.gl_sl_link_id,xal.entered_cr,gjl.entered_cr),0) end entered_amount,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num) then nvl2(xal.gl_sl_link_id,xal.currency_code,gjh.currency_code) end transaction_currency,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num) then nvl2(xal.gl_sl_link_id,xal.accounted_dr,gjl.accounted_dr) end accounted_dr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num) then nvl2(xal.gl_sl_link_id,xal.accounted_cr,gjl.accounted_cr) end accounted_cr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id,xal.ae_header_id,xal.ae_line_num) then nvl(nvl2(xal.gl_sl_link_id,xal.accounted_dr,gjl.accounted_dr),0)-nvl(nvl2(xal.gl_sl_link_id,xal.accounted_cr,gjl.accounted_cr),0) end accounted_amount,
gl.currency_code ledger_currency,
(select xett.name from xla_event_types_tl xett where xte.application_id=xett.application_id and xte.entity_code=xett.entity_code and xe.event_type_code=xett.event_type_code and xett.language=userenv('lang')) event_type,
xal.currency_conversion_date,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where xal.currency_conversion_type=gdct.conversion_type) currency_conversion_type,
xal.currency_conversion_rate,
xxen_util.description(gjh.actual_flag,'BATCH_TYPE',101) balance_type,
(select gbv.budget_name from gl_budget_versions gbv where gjh.budget_version_id=gbv.budget_version_id) budget_name,
(select get.encumbrance_type from gl_encumbrance_types get where gjh.encumbrance_type_id=get.encumbrance_type_id) encumbrance_type,
gjh.currency_conversion_date conversion_date,
gjh.currency_conversion_type conversion_type,
gjh.currency_conversion_rate conversion_rate,
xah.description accounting_event_description,
nvl(xah.accounting_date,gjh.default_effective_date) accounting_date,
xe.transaction_date,
xte.transaction_number,
-- Document Sequences
gjh.doc_sequence_id document_seq_id,      
(select fds.name from fnd_document_sequences fds where gjh.doc_sequence_id=fds.doc_sequence_id)  document_seq_name,       
gjh.doc_sequence_value document_seq_value,
nvl(gjl.subledger_doc_sequence_id,xah.doc_sequence_id) sub_doc_seq_id,
(select fds.name from fnd_document_sequences fds where nvl(gjl.subledger_doc_sequence_id,xah.doc_sequence_id)=fds.doc_sequence_id) sub_doc_seq_name,
nvl(gjl.subledger_doc_sequence_value,xah.doc_sequence_value) sub_doc_seq_val,
gjh.close_acct_seq_value gl_close_acct_seq_val,
xah.close_acct_seq_value sl_close_acct_seq_val,
nvl2(xe.event_id,xah.close_acct_seq_value,gjh.close_acct_seq_value) reporting_seq,
nvl2(xal.gl_sl_link_id,xal.jgzz_recon_ref,(select gjlr.jgzz_recon_ref from gl_je_lines_recon gjlr where gjl.je_header_id=gjlr.je_header_id and gjl.je_line_num=gjlr.je_line_num)) reconciliation_reference,
&lp_gjl_dff_cols
coalesce(aia.source,rbsa.name,gjsv.user_je_source_name) sl_source,
decode(gjsv.user_je_source_name,'Assets',to_char(xte.source_id_int_3),'Payables',aba.batch_name,'Receivables',decode(xah.je_category_name,'Receipts',arba.name,rba.name)) sl_batch_no,
--Assets
fab.asset_number,
--AP
nvl(aia.invoice_num,rcta.trx_number) invoice_number,
nvl(aia.description,rcta.comments) description,
nvl(aia.invoice_date,rcta.trx_date) invoice_date,
aia.gl_date,
nvl(aia.invoice_currency_code,rcta.invoice_currency_code) invoice_currency,
aia.payment_currency_code payment_currency,
nvl(xxen_util.meaning(aia.payment_method_code,'PAYMENT METHOD',200),aia.payment_method_code) payment_method,
pha.segment1 purchase_order,
pra.release_num release,
rt.quantity po_quantity,
prha.segment1 requisition,
prla.line_num requisition_line,
--AR
coalesce(
ooha.order_number,
case
when xte.entity_code='TRANSACTIONS' and rcta.interface_header_context in ('ORDER ENTRY','INTERCOMPANY') then to_number(rcta.interface_header_attribute1)
when mmt.transaction_source_type_id in (2,8,12) then (select to_number(mso.segment1) from mtl_sales_orders mso where mmt.transaction_source_id=mso.sales_order_id)
end
) sales_order,
jrrev.resource_name salesperson,
(select name from ra_rules rr where rcta.invoicing_rule_id=rule_id) invoice_rule,
(select rr.name from ra_customer_trx_lines_all rctla, ra_rules rr where rcta.customer_trx_id=rctla.customer_trx_id and rctla.line_type='LINE' and rctla.accounting_rule_id=rr.rule_id and rownum=1) accounting_rule,
coalesce(aps.segment1,hca.account_number) vendor_or_customer_number,
coalesce(aps.vendor_name,hp.party_name) vendor_or_customer_name,
coalesce(assa.vendor_site_code,hcsua.location) vendor_or_customer_site,
--Projects
coalesce(ppa.segment1,case when xte.application_id=222 and xte.entity_code='TRANSACTIONS' and rcta.interface_header_context='PROJECTS INVOICES' then rcta.interface_header_attribute1 end) project,
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
papf.full_name employee_name,
nvl(papf.employee_number,papf.npw_number) employee_number,
--Payroll
(select pjv.name from per_jobs_vl pjv where paaf.job_id=pjv.job_id) job,
(select hapft.name from hr_all_positions_f_tl hapft where paaf.position_id=hapft.position_id and hapft.language=userenv('lang')) position,
(select haouv.name from hr_all_organization_units_vl haouv where paaf.organization_id=haouv.organization_id) assignment_organization,
--WIP
bd.department_code,
br.resource_code,
we.wip_entity_name wip_job,
wt.operation_seq_num,
nvl(wt.transaction_quantity,mmt.transaction_quantity) transaction_quantity,
nvl(wt.transaction_uom,mmt.transaction_uom) transaction_uom,
nvl(wt.primary_quantity,mmt.primary_quantity) primary_quantity,
--Inventory
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
when mmt.transaction_source_type_id=1 then pha.segment1 --PO
when mmt.transaction_source_type_id=16 then (select okhab.contract_number from okc_k_headers_all_b okhab where mmt.transaction_source_id=okhab.id) --Project Contracts
when mmt.transaction_source_type_id=7 then prha.segment1 --Requisition
when mmt.transaction_source_type_id=5 then we.wip_entity_name --WIP Job or Schedule
when mmt.transaction_source_type_id=4 then (select mtrh.request_number from mtl_txn_request_headers mtrh where mtrh.header_id=mmt.transaction_source_id) --Move Order
end inv_transaction_source,
mmt.transaction_id inv_transaction_id,
cwo.comments write_off_comments,
--AP/AR MDM Party/Site Identifier
nvl2(xal.party_type_code,xal.party_type_code||'-'||nvl(to_char(xal.party_id),'UNKNOWN')||'-' ||nvl(to_char(xal.party_site_id),'0'),null) mdm_party_id,
decode(xal.party_type_code,
'C',xal.party_type_code||'-'||nvl(hp.party_name,'UNKNOWN')||'-' ||nvl(hcsua.location,'0'),
'S',xal.party_type_code||'-'||nvl(aps.vendor_name,'UNKNOWN')|| '-'||nvl(assa.vendor_site_code,'0')
) mdm_party_desc,
--Record history and ID columns
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
xal.accounting_class_code,
xte.entity_code,
&segments_with_desc
xte.source_id_int_1,
gp.start_date period_date,
gp.period_name period,
gcck.chart_of_accounts_id,
case when gjsv.user_je_source_name not in ('Property Manager','Global Intercompany','Payroll','Inflation Accting','Projects','Spreadsheet') then
case when nvl(fnd_profile.value('XXEN_FSG_DRILLDOWN_TO_SAME_WORKBOOK'), 'N')='N' then '=dd' else '=dds' end
||'("VT","'||gl.ledger_id||','||gjsv.user_je_source_name||','||xah.event_id||','||gjl.je_line_num||'")' end view_transaction
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
gcck,
zx_rates_b zrb,
fa_transaction_headers fth,
fa_additions_b fab,
ap_invoices_all aia,
(select (select distinct max(aipa.invoice_id) keep (dense_rank last order by aipa.invoice_payment_id) over () invoice_id from ap_invoice_payments_all aipa where aca.check_id=aipa.check_id) max_aipa_invoice_id, aca.* from ap_checks_all aca) aca,
ap_batches_all aba,
po_headers_all pha,
po_releases_all pra,
po_requisition_headers_all prha,
po_requisition_lines_all prla,
ap_suppliers aps,
ap_supplier_sites_all assa,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
ra_customer_trx_all rcta,
ra_batch_sources_all rbsa,
ra_batches_all rba,
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_vl jrrev,
ar_adjustments_all aaa,
(select (select araa.customer_trx_id from ar_receivable_applications_all araa where acra.cash_receipt_id=araa.cash_receipt_id and araa.display='Y' and araa.status='APP' and rownum=1) customer_trx_id, acra.* from ar_cash_receipts_all acra) acra,
(select acrha.* from ar_cash_receipt_history_all acrha where acrha.current_record_flag='Y') acrha,
ar_batches_all arba,
pa_projects_all ppa,
pa_tasks pt,
pa_budget_versions pbv,
pa_draft_revenues_all pdra,
pa_agreements_all paa,
pa_expenditure_items_all peia,
pa_expenditures_all pea,
pa_expenditure_types pet,
per_all_people_f papf,
pay_assignment_actions paa,
per_all_assignments_f paaf,
rcv_transactions rt,
rcv_shipment_lines rsl,
wip_transactions wt,
wip_entities we,
bom_departments bd,
bom_resources br,
gmf_xla_extract_headers gxeh, --OPM
--Inventory
mtl_material_transactions mmt,
mtl_system_items_vl msiv,
mtl_parameters mp,
mtl_transaction_types mtt,
mtl_txn_source_types mtst,
(select (select fspa.inventory_organization_id from financials_system_params_all fspa where cwo.operating_unit_id=fspa.org_id) organization_id, cwo.* from cst_write_offs cwo) cwo,
po_distributions_all pda,
ap_invoice_distributions_all aida,
oe_order_lines_all oola,
oe_order_headers_all ooha
where
1=1 and
gl.period_set_name=gp.period_set_name and
gp.period_name=gjh.period_name and
gp.period_name=gjl.period_name and
gl.ledger_id=gjh.ledger_id and
gjb.je_batch_id=gjh.je_batch_id and
gjh.je_header_id=gjl.je_header_id and
gjh.je_source=gjsv.je_source_name and
gjh.je_category=gjcv.je_category_name and
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
gjl.tax_code_id=zrb.tax_rate_id(+) and
case when xte.application_id=140 then case when xte.entity_code in ('DEPRECIATION','DEFERRED_DEPRECIATION') then xte.source_id_int_1 when xte.entity_code='TRANSACTIONS' then fth.asset_id end end=fab.asset_id(+) and
case when xte.application_id=140 and xte.entity_code='TRANSACTIONS' then xte.source_id_int_1 end=fth.transaction_header_id(+) and
coalesce(case when xte.application_id=200 then decode(xte.entity_code,'AP_INVOICES',xte.source_id_int_1,'AP_PAYMENTS',aca.max_aipa_invoice_id) end,aida.invoice_id)=aia.invoice_id(+) and 
case when xte.application_id=200 and xte.entity_code='AP_PAYMENTS' then xte.source_id_int_1 end=aca.check_id(+) and
aia.batch_id=aba.batch_id(+) and
coalesce(case when xte.application_id=201 and xte.entity_code='PURCHASE_ORDER' then xte.source_id_int_1 end,pra.po_header_id,aia.quick_po_header_id,rt.po_header_id,wt.po_header_id,decode(mmt.transaction_source_type_id,1,mmt.transaction_source_id),pda.po_header_id)=pha.po_header_id(+) and
coalesce(case when xte.application_id=201 and xte.entity_code='RELEASE' then xte.source_id_int_1 end,rt.po_release_id)=pra.po_release_id(+) and
coalesce(case when xte.application_id=201 and xte.entity_code='REQUISITION' then xte.source_id_int_1 end,prla.requisition_header_id,decode(mmt.transaction_source_type_id,7,mmt.transaction_source_id))=prha.requisition_header_id(+) and
rt.requisition_line_id=prla.requisition_line_id(+) and
coalesce(decode(xal.party_type_code,'S',xal.party_id),aia.vendor_id,aca.vendor_id,rt.vendor_id,pha.vendor_id,cwo.vendor_id)=aps.vendor_id(+) and
decode(xal.party_type_code,'S',xal.party_site_id)=assa.party_site_id(+) and
coalesce(decode(xal.party_type_code,'C',xal.party_id),rcta.bill_to_customer_id,acra.pay_from_customer,paa.customer_id,oola.sold_to_org_id)=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
decode(xal.party_type_code,'C',xal.party_site_id)=hcsua.site_use_id(+) and
case when xte.application_id=222 then case when xte.entity_code in ('TRANSACTIONS','BILLS_RECEIVABLE') then xte.source_id_int_1 when xte.entity_code='ADJUSTMENTS' then aaa.customer_trx_id end end=rcta.customer_trx_id(+) and
rcta.batch_source_id=rbsa.batch_source_id(+) and
rcta.org_id=rbsa.org_id(+) and
rcta.batch_id=rba.batch_id(+) and
rcta.primary_salesrep_id=jrs.salesrep_id(+) and
rcta.org_id=jrs.org_id(+) and
jrs.resource_id=jrrev.resource_id(+) and
case when xte.application_id=222 and xte.entity_code='ADJUSTMENTS' then xte.source_id_int_1 end=aaa.adjustment_id(+) and
case when xte.application_id=222 and xte.entity_code='RECEIPTS' then xte.source_id_int_1 end=acra.cash_receipt_id(+) and
acra.cash_receipt_id=acrha.cash_receipt_id(+) and
acrha.batch_id=arba.batch_id(+) and
coalesce(case when xte.application_id=275 then decode(xte.entity_code,'REVENUE',xte.source_id_int_1,'EXPENDITURES',peia.project_id) end,pbv.project_id,pdra.project_id,pt.project_id)=ppa.project_id(+) and
case when xte.application_id=275 and xte.entity_code='BUDGETS' then xte.source_id_int_1 end=pbv.budget_version_id(+) and
case when xte.application_id=275 and xte.entity_code='REVENUE' then xte.source_id_int_1 end=pdra.project_id(+) and
case when xte.application_id=275 and xte.entity_code='REVENUE' then xte.source_id_int_2 end=pdra.draft_revenue_num(+) and
pdra.agreement_id=paa.agreement_id(+) and
case when xte.application_id=275 and xte.entity_code='EXPENDITURES' then xte.source_id_int_1 end=peia.expenditure_item_id(+) and
peia.task_id=pt.task_id(+) and
peia.expenditure_id=pea.expenditure_id(+) and
peia.expenditure_type=pet.expenditure_type(+) and
coalesce(pea.incurred_by_person_id,paaf.person_id)=papf.person_id(+) and
nvl(peia.expenditure_item_date,case when xte.application_id=801 and xte.entity_code='ASSIGNMENTS' then fnd_date.canonical_to_date(xte.source_id_char_1) end)>=papf.effective_start_date(+) and
nvl(peia.expenditure_item_date,case when xte.application_id=801 and xte.entity_code='ASSIGNMENTS' then fnd_date.canonical_to_date(xte.source_id_char_1) end)-1<papf.effective_end_date(+) and
case when xte.application_id=801 and xte.entity_code='ASSIGNMENTS' then xte.source_id_int_1 end=paa.assignment_action_id(+) and
paa.assignment_id=paaf.assignment_id(+) and
case when xte.application_id=801 and xte.entity_code='ASSIGNMENTS' then fnd_date.canonical_to_date(xte.source_id_char_1) end between paaf.effective_start_date(+) and paaf.effective_end_date(+) and
case
when xte.application_id=707 and xte.entity_code='RCV_ACCOUNTING_EVENTS' then xte.source_id_int_1
when xte.application_id=555 and gxeh.txn_source='PUR' then gxeh.source_line_id
end=rt.transaction_id(+) and
rt.shipment_line_id=rsl.shipment_line_id(+) and
case when xte.application_id=707 and xte.entity_code='WIP_ACCOUNTING_EVENTS' then xte.source_id_int_1 end=wt.transaction_id(+) and
coalesce(wt.wip_entity_id,decode(mmt.transaction_source_type_id,5,mmt.transaction_source_id))=we.wip_entity_id(+) and
wt.department_id=bd.department_id(+) and
wt.resource_id=br.resource_id(+) and
case when xah.application_id=555 then xah.event_id end=gxeh.event_id(+) and
--Inventory
coalesce(case when xte.application_id=707 and xte.entity_code='MTL_ACCOUNTING_EVENTS' then xte.source_id_int_1
when xah.application_id=555 then gxeh.transaction_id end,cwo.inventory_transaction_id)=mmt.transaction_id(+) and
coalesce(mmt.organization_id,rsl.to_organization_id,we.organization_id,cwo.organization_id)=msiv.organization_id(+) and
coalesce(mmt.inventory_item_id,rsl.item_id,we.primary_item_id,cwo.inventory_item_id)=msiv.inventory_item_id(+) and
coalesce(mmt.organization_id,rt.organization_id,rsl.to_organization_id,we.organization_id)=mp.organization_id(+) and
mmt.transaction_type_id=mtt.transaction_type_id(+) and
mmt.transaction_source_type_id=mtst.transaction_source_type_id(+) and
case when xte.application_id=707 and xte.entity_code='WO_ACCOUNTING_EVENTS' then xte.source_id_int_1 end=cwo.write_off_id(+) and
cwo.po_distribution_id=pda.po_distribution_id(+) and
cwo.invoice_distribution_id=aida.invoice_distribution_id(+) and
coalesce(decode(gxeh.txn_source,'OM',gxeh.source_line_id),case when mmt.transaction_source_type_id in (2,8,12) then mmt.trx_source_line_id end,rsl.oe_order_line_id,rt.oe_order_line_id)=oola.line_id(+) and
coalesce(oola.header_id,rsl.oe_order_header_id,rt.oe_order_header_id)=ooha.header_id(+)
order by
gl.name,
gcck.concatenated_segments,
gp.start_date,
gp.period_name,
gjb.je_batch_id,
gjl.je_header_id,
gjl.je_line_num ,
xe.transaction_date,
xte.transaction_number