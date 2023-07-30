/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Account Analysis
-- Description: Detail GL transaction report with one line per transaction including all segments and subledger data, with amounts in both transaction currency and ledger currency.
-- Excel Examle Output: https://www.enginatics.com/example/gl-account-analysis/
-- Library Link: https://www.enginatics.com/reports/gl-account-analysis/
-- Run Report: https://demo.enginatics.com/

with h as
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
)
--
-- Main Query
--
select
&hierarchy_levels3
y.*
from
(
select
&hierarchy_levels2
x.*,
case when max(x.je_header_id) over (partition by x.ledger,x.concatenated_segments) is not null then 'Y' else 'N' end has_activity,
case when sum(case when x.record_type='Balance' then abs(nvl(x.accounted_amount,0)) else 0 end) over (partition by x.ledger,x.concatenated_segments)=0 then 'Y' else 'N' end zero_balance
from
(
select --GL Data Query
case when count(distinct gp.period_num) over ()>1 then lpad(gp.period_num,2,'0')||' ' end||gjh.period_name period_name,
lpad(gp.period_num,2,'0')||' '||gjh.period_name period_name_label,
gl.name ledger,
gjsv.user_je_source_name source_name, --XXECL
gjh.external_reference reference,
gjcv.user_je_category_name category_name, --XXECL
gjb.name batch_name,
xxen_util.meaning(gjb.status,'MJE_BATCH_STATUS',101) batch_status,
gjh.posted_date,
gjh.name journal_name,
gjh.description journal_description,
xxen_util.meaning(gjh.tax_status_code,'TAX_STATUS',101) tax_status_code,
gjl.je_line_num line_number,
gcck.concatenated_segments,
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcck.chart_of_accounts_id, NULL, gcck.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') concatenated_segments_desc,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then gjl.entered_dr end line_entered_dr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then gjl.entered_cr end line_entered_cr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then nvl(gjl.entered_dr,0)-nvl(gjl.entered_cr,0) end line_entered_amount,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then gjl.accounted_dr end line_accounted_dr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then gjl.accounted_cr end line_accounted_cr,
case when 1=row_number() over (partition by gjl.je_header_id,gjl.je_line_num order by gjl.je_header_id,gjl.je_line_num,xal.gl_sl_link_id) then nvl(gjl.accounted_dr,0)-nvl(gjl.accounted_cr,0) end line_accounted_amount,
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
&revaluation_columns
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
gjh.doc_sequence_id document_seq_id, --XXECL      
(select fds.name from fnd_document_sequences fds where fds.doc_sequence_id = gjh.doc_sequence_id)  document_seq_name, --XXECL       
gjh.doc_sequence_value document_seq_value, --XXECL
nvl(gjl.subledger_doc_sequence_id,xah.doc_sequence_id) sub_doc_seq_id, --XXECL  
(select fds.name from fnd_document_sequences fds where fds.doc_sequence_id = nvl(gjl.subledger_doc_sequence_id,xah.doc_sequence_id))  sub_doc_seq_name, --XXECL
nvl(gjl.subledger_doc_sequence_value,xah.doc_sequence_value)    sub_doc_seq_val, --XXECL
gjh.close_acct_seq_value gl_close_acct_seq_val, -- XXECL
xah.close_acct_seq_value sl_close_acct_seq_val, --XXECL
nvl2(xe.event_id,xah.close_acct_seq_value,gjh.close_acct_seq_value) reporting_seq, --XXECL
--
decode(xal.gl_sl_link_id,
       null,(select gjlr.jgzz_recon_ref from gl_je_lines_recon gjlr where gjlr.je_header_id=gjl.je_header_id and gjlr.je_line_num=gjl.je_line_num),
       xal.jgzz_recon_ref
      ) reconciliation_reference, --XXECL
--
&lp_gjl_dff_cols
--
case
when nvl2(xe.event_id,decode(gjsv.user_je_source_name,'Assets' ,xah.je_category_name,'Payables',xah.je_category_name,'Receivables',xah.je_category_name,'Cost Management',xah.je_category_name,gjcv.user_je_category_name),gjcv.user_je_category_name) in ('Payments','Receipts')
then gjsv.user_je_source_name
when nvl2(xe.event_id,decode(gjsv.user_je_source_name,'Assets' ,xah.je_category_name,'Payables',xah.je_category_name,'Receivables',xah.je_category_name,'Cost Management',xah.je_category_name,gjcv.user_je_category_name),gjcv.user_je_category_name) = 'Receiving'
then
  case
  when xe.event_id is not null and gjsv.user_je_source_name = 'Cost Management' and nvl2(xe.event_id,decode(gjsv.user_je_source_name,'Assets' ,xah.je_category_name,'Payables',xah.je_category_name,'Receivables',xah.je_category_name,'Cost Management',xah.je_category_name,gjcv.user_je_category_name),gjcv.user_je_category_name) = 'Receiving' and xte.entity_code = 'WO_ACCOUNTING_EVENTS'
  then
     (select
       pha.attribute6
      from
       cst_write_offs cwos,
       po_distributions_all poda,
       po_headers_all pha
      where
        pha.po_header_id=poda.po_header_id and
        poda.po_distribution_id = cwos.po_distribution_id and
        cwos.write_off_id = xte.transaction_number
     )
  when xe.event_id is not null and gjsv.user_je_source_name = 'Cost Management' and nvl2(xe.event_id,decode(gjsv.user_je_source_name,'Assets' ,xah.je_category_name,'Payables',xah.je_category_name,'Receivables',xah.je_category_name,'Cost Management',xah.je_category_name,gjcv.user_je_category_name),gjcv.user_je_category_name) = 'Receiving'
  then
     (select
       pha.attribute6
      from
       rcv_transactions rt,
       rcv_shipment_headers rsh,
       po_headers_all pha
      where
        pha.po_header_id=rt.po_header_id and
        rsh.shipment_header_id = rt.shipment_header_id and
        rt.transaction_id = xte.transaction_number
     )
  else
   null
  end
when xe.event_id is not null and gjsv.user_je_source_name = 'Receivables'
then
  coalesce
  (
   (select distinct
     rabs.name
    from
     ra_cust_trx_line_gl_dist_all ractl,
     ra_customer_trx_all ract,
     ra_customer_trx_lines_all ractla,
     ra_batch_sources_all rabs
    where
     rabs.batch_source_id = ract.batch_source_id and
     ract.customer_trx_id = ractla.customer_trx_id and
     ractla.customer_trx_id = ractl.customer_trx_id and
     ractla.customer_trx_line_id = ractl.customer_trx_line_id and
     ractl.event_id = xe.event_id  and
     ractl.code_combination_id = gjl.code_combination_id and
     rownum=1
   ),
   (select distinct
     rabs.name
    from
     ar_receivable_applications_all araa,
     ra_customer_trx_all ract,
     ra_customer_trx_lines_all ractla,
     ra_batch_sources_all rabs
    where
     rabs.batch_source_id = ract.batch_source_id and
     ract.customer_trx_id = ractla.customer_trx_id and
     ractla.customer_trx_id = araa.customer_trx_id and
     araa.event_id = xe.event_id and
     rownum=1
   ),
   gjsv.user_je_source_name
  )
when xe.event_id is not null and gjsv.user_je_source_name = 'Payables'
then
  case
  when nvl2(xe.event_id,decode(gjsv.user_je_source_name,'Assets' ,xah.je_category_name,'Payables',xah.je_category_name,'Receivables',xah.je_category_name,'Cost Management',xah.je_category_name,gjcv.user_je_category_name),gjcv.user_je_category_name) = 'Payments'
  then
    nvl(
    (select distinct
      apia.source
     from
      ap_invoices_all apia,
      ap_invoice_lines_all apila,
      ap_invoice_payments_all aip
     where
     aip.accounting_event_id = xe.event_id and
     aip.payment_num = xe.event_number and
     apia.invoice_id = aip.invoice_id and
     apila.invoice_id = aip.invoice_id and
     rownum=1
    ),gjsv.user_je_source_name)
  else
    nvl(
    (select distinct
      apia.source
     from
      ap_invoices_all apia,
      ap_invoice_lines_all apila,
      ap_invoice_distributions_all apida,
      xla_distribution_links xdl
     where
      xdl.application_id = 200 and
      xdl.ae_header_id = xal.ae_header_id and
      xdl.ae_line_num = xal.ae_line_num and
      xdl.source_distribution_type = 'AP_INV_DIST' and
      xdl.source_distribution_id_num_1 = apida.invoice_distribution_id and
      apia.invoice_id = apida.invoice_id and
      apila.invoice_id = apida.invoice_id and
      apila.line_number = apida.invoice_line_number and
      rownum=1
    ),
    gjsv.user_je_source_name
   )
  end
else
 gjsv.user_je_source_name
end sl_source,
case
when gjsv.user_je_source_name='Assets' and xte.source_id_int_3 is not null
then to_char(xte.source_id_int_3)
when gjsv.user_je_source_name='Payables' and xte.transaction_number is not null
then
 case when decode(gjsv.user_je_source_name,'Assets' ,xah.je_category_name,'Payables',xah.je_category_name,'Receivables',xah.je_category_name,'Cost Management',xah.je_category_name,gjcv.user_je_category_name)='Payments'
 then
   (select distinct aba.batch_name from
     ap_batches_all aba,
     ap_invoices_all aia2,
     ap_invoice_payments_all aipa
    where
     aia2.batch_id = aba.batch_id and
     aia2.invoice_id = aipa.invoice_id and
     aipa.check_id = xte.source_id_int_1 and
     rownum=1
   )
 else
   (select
     aba.batch_name
    from
     ap_batches_all aba
    where
     aba.batch_id = aia.batch_id and
     rownum=1
   )
 end
when gjsv.user_je_source_name='Receivables' and xte.transaction_number is not null
then
 case when decode(gjsv.user_je_source_name,'Assets' ,xah.je_category_name,'Payables',xah.je_category_name,'Receivables',xah.je_category_name,'Cost Management',xah.je_category_name,gjcv.user_je_category_name)='Receipts'
 then
   (select distinct
     nvl(aba.name ,'')
    from
     ar_cash_receipt_history_all acrha,
     ar_batches_all aba
    where
     aba.batch_id = acrha.batch_id and
     acrha.cash_receipt_id = xte.source_id_int_1 and
     rownum=1
   )
 else
   (select
     rba.name
    from
     ra_batches_all rba
    where
     rba.batch_id = rcta.batch_id and
     rownum=1
   )
 end
else
 null
end sl_batch_no,
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
coalesce(aia.invoice_amount,apsa.amount_due_original) invoice_amount,
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
coalesce(aps.segment1,hca.account_number) vendor_or_customer_number, --XXECL
coalesce(aps.vendor_name,hp.party_name) vendor_or_customer_name, --XXECL
coalesce(assa.vendor_site_code,hcsua.location) vendor_or_customer_site, --XXECL
--AP/AR MDM Party/Site Identifier
nvl2(xal.party_type_code,xal.party_type_code||'-'||nvl(to_char(xal.party_id),'UNKNOWN')||'-' ||nvl(to_char(xal.party_site_id),'0'),null) mdm_party_id,
decode(xal.party_type_code,
'C',xal.party_type_code||'-'||nvl(hp.party_name,'UNKNOWN')||'-' ||nvl(hcsua.location,'0'),
'S',xal.party_type_code||'-'||nvl(aps.vendor_name,'UNKNOWN')|| '-'||nvl(assa.vendor_site_code,'0')
) mdm_party_desc,
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
(select haouv.name from hr_all_organization_units_vl haouv where
coalesce(
aca.org_id,
aia.org_id,
assa.org_id,
aaa.org_id,
acra.org_id,
apsa.org_id,
hca.org_id,
hcsua.org_id,
rcta.org_id,
oola.org_id,
paa.org_id,
pdra.org_id,
pea.org_id,
peia.org_id,
ppa.org_id,
pha.org_id,
pra.org_id,
prha.org_id,
prla.org_id,
gjb.org_id
)=haouv.organization_id) operating_unit,
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
&lp_contra_acct_sel
&hierarchy_segment
xte.source_id_int_1,
gp.start_date period_date,
gp.period_name period,
'Journal' record_type,
gcck.chart_of_accounts_id,
(select fifs.flex_value_set_id from fnd_id_flex_segments fifs where gcck.chart_of_accounts_id=fifs.id_flex_num and fifs.application_id=101 and fifs.id_flex_code='GL#' and fifs.application_column_name='&hierarchy_segment_column') flex_value_set_id
from
gl_ledgers gl,
gl_periods gp,
gl_je_batches gjb,
gl_je_headers gjh,
gl_je_lines gjl,
(select gir.* from gl_import_references gir where gir.gl_sl_link_table in ('XLAJEL','APECL') and gir.gl_sl_link_id is not null) gir,
gl_je_sources_vl gjsv, --XXECL
gl_je_categories_vl gjcv, --XXECL
xla_ae_lines xal,
xla_ae_headers xah,
xla_events xe,
xla.xla_transaction_entities xte,
gl_code_combinations_kfv gcck,
(select gdr.* from gl_daily_rates gdr where gdr.to_currency=:revaluation_currency and gdr.conversion_type=(select gdct.conversion_type from gl_daily_conversion_types gdct where gdct.user_conversion_type=:revaluation_conversion_type)) gdr,
zx_rates_b zrb,
fa_transaction_headers fth,
fa_additions_b fab,
(select (select aida.task_id from ap_invoice_distributions_all aida where aia.invoice_id=aida.invoice_id and aida.task_id is not null and rownum=1) aida_task_id, aia.* from ap_invoices_all aia) aia,
(select (select distinct max(aipa.invoice_id) keep (dense_rank last order by aipa.invoice_payment_id) over () invoice_id from ap_invoice_payments_all aipa where aca.check_id=aipa.check_id) max_aipa_invoice_id, aca.* from ap_checks_all aca) aca,
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
(select apsa.customer_trx_id, apsa.org_id, sum(apsa.amount_due_original) amount_due_original from ar_payment_schedules_all apsa group by apsa.customer_trx_id, apsa.org_id) apsa,
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
oe_order_lines_all oola,
oe_order_headers_all ooha
&lp_contra_acct_tbl
where
1=1 and
3=3 and
gl.period_set_name=gp.period_set_name and
gp.period_name=gjh.period_name and
gp.period_name=gjl.period_name and
gl.ledger_id=gjh.ledger_id and
gjb.je_batch_id=gjh.je_batch_id and
gjh.je_header_id=gjl.je_header_id and
gjh.je_source=gjsv.je_source_name and --XXECL
gjh.je_category=gjcv.je_category_name and --XXECL
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
gl_security_pkg.validate_access(null,gjl.code_combination_id)='TRUE' and
gjl.code_combination_id=gcck.code_combination_id and
coalesce(xal.currency_conversion_date,gjh.currency_conversion_date,trunc(xe.transaction_date))=gdr.conversion_date(+) and
decode(nvl2(xal.gl_sl_link_id,xal.currency_code,gjh.currency_code),:revaluation_currency,null,nvl2(xal.gl_sl_link_id,xal.currency_code,gjh.currency_code))=gdr.from_currency(+) and
gjl.tax_code_id=zrb.tax_rate_id(+) and
case when xte.application_id=140 then decode(xte.entity_code,'DEPRECIATION',xte.source_id_int_1,'TRANSACTIONS',fth.asset_id) end=fab.asset_id(+) and
case when xte.application_id=140 and xte.entity_code='TRANSACTIONS' then xte.source_id_int_1 end=fth.transaction_header_id(+) and
case when xte.application_id=200 then decode(xte.entity_code,'AP_INVOICES',xte.source_id_int_1,'AP_PAYMENTS',aca.max_aipa_invoice_id) end=aia.invoice_id(+) and 
case when xte.application_id=200 and xte.entity_code='AP_PAYMENTS' then xte.source_id_int_1 end=aca.check_id(+) and
coalesce(case when xte.application_id=201 and xte.entity_code='PURCHASE_ORDER' then xte.source_id_int_1 end,pra.po_header_id,aia.quick_po_header_id,rt.po_header_id,wt.po_header_id,decode(mmt.transaction_source_type_id,1,mmt.transaction_source_id))=pha.po_header_id(+) and
coalesce(case when xte.application_id=201 and xte.entity_code='RELEASE' then xte.source_id_int_1 end,rt.po_release_id)=pra.po_release_id(+) and
coalesce(case when xte.application_id=201 and xte.entity_code='REQUISITION' then xte.source_id_int_1 end,prla.requisition_header_id,decode(mmt.transaction_source_type_id,7,mmt.transaction_source_id))=prha.requisition_header_id(+) and
rt.requisition_line_id=prla.requisition_line_id(+) and
coalesce(decode(xal.party_type_code,'S',xal.party_id),aia.vendor_id,aca.vendor_id,rt.vendor_id,pha.vendor_id)=aps.vendor_id(+) and
decode(xal.party_type_code,'S',xal.party_site_id)=assa.party_site_id(+) and
coalesce(decode(xal.party_type_code,'C',xal.party_id),rcta.bill_to_customer_id,acra.pay_from_customer,paa.customer_id,oola.sold_to_org_id)=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
decode(xal.party_type_code,'C',xal.party_site_id)=hcsua.site_use_id(+) and
case when xte.application_id=222 then case when xte.entity_code in ('TRANSACTIONS','BILLS_RECEIVABLE') then xte.source_id_int_1 when xte.entity_code='ADJUSTMENTS' then aaa.customer_trx_id end end=rcta.customer_trx_id(+) and
rcta.customer_trx_id=apsa.customer_trx_id(+) and
rcta.primary_salesrep_id=jrs.salesrep_id(+) and
rcta.org_id=jrs.org_id(+) and
jrs.resource_id=jrrev.resource_id(+) and
case when xte.application_id=222 and xte.entity_code='ADJUSTMENTS' then xte.source_id_int_1 end=aaa.adjustment_id(+) and
case when xte.application_id=222 and xte.entity_code='RECEIPTS' then xte.source_id_int_1 end=acra.cash_receipt_id(+) and
coalesce(case when xte.application_id=275 then decode(xte.entity_code,'REVENUE',xte.source_id_int_1,'EXPENDITURES',peia.project_id) end,pdra.project_id,pt.project_id)=ppa.project_id(+) and
case when xte.application_id=275 and xte.entity_code='REVENUE' then xte.source_id_int_1 end=pdra.project_id(+) and
case when xte.application_id=275 and xte.entity_code='REVENUE' then xte.source_id_int_2 end=pdra.draft_revenue_num(+) and
pdra.agreement_id=paa.agreement_id(+) and
case when xte.application_id=275 and xte.entity_code='EXPENDITURES' then xte.source_id_int_1 end=peia.expenditure_item_id(+) and
nvl(aia.aida_task_id,peia.task_id)=pt.task_id(+) and
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
when xte.application_id=555 and gxeh.txn_source='PUR' then gxeh.source_line_id --OPM
end=rt.transaction_id(+) and
rt.shipment_line_id=rsl.shipment_line_id(+) and
case when xte.application_id=707 and xte.entity_code='WIP_ACCOUNTING_EVENTS' then xte.source_id_int_1 end=wt.transaction_id(+) and
coalesce(wt.wip_entity_id,decode(mmt.transaction_source_type_id,5,mmt.transaction_source_id))=we.wip_entity_id(+) and
wt.department_id=bd.department_id(+) and
wt.resource_id=br.resource_id(+) and
case when xah.application_id=555 then xah.event_id end=gxeh.event_id(+) and --OPM
--Inventory
case when xte.application_id=707 and xte.entity_code='MTL_ACCOUNTING_EVENTS' then xte.source_id_int_1
     when xah.application_id=555 then gxeh.transaction_id end=mmt.transaction_id(+) and
coalesce(mmt.organization_id,rsl.to_organization_id,we.organization_id)=msiv.organization_id(+) and
coalesce(mmt.inventory_item_id,rsl.item_id,we.primary_item_id)=msiv.inventory_item_id(+) and
coalesce(mmt.organization_id,rt.organization_id,rsl.to_organization_id,we.organization_id)=mp.organization_id(+) and
mmt.transaction_type_id=mtt.transaction_type_id(+) and
mmt.transaction_source_type_id=mtst.transaction_source_type_id(+) and
coalesce(decode(gxeh.txn_source,'OM',gxeh.source_line_id),case when mmt.transaction_source_type_id in (2,8,12) then mmt.trx_source_line_id end,rsl.oe_order_line_id,rt.oe_order_line_id)=oola.line_id(+) and
coalesce(oola.header_id,rsl.oe_order_header_id,rt.oe_order_header_id)=ooha.header_id(+)
&lp_contra_acct_join
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
null tax_status_code,
null line_number,
gcck.concatenated_segments,
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcck.chart_of_accounts_id, NULL, gcck.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') concatenated_segments_desc,
null line_entered_dr,
null line_entered_cr,
null line_entered_amount,
gb.begin_balance_dr line_accounted_dr,
gb.begin_balance_cr line_accounted_cr,
nvl(gb.begin_balance_dr,0)-nvl(gb.begin_balance_cr,0) line_accounted_amount,
null line_description,
null tax_rate_code,
null tax_line,
null taxable_line,
null amount_includes_tax,
null accounting_class,
xxen_util.meaning(gcck.gl_account_type,'ACCOUNT_TYPE',0) account_type,
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
null event_type,
null currency_conversion_date,
null currency_conversion_type,
null currency_conversion_rate,
xxen_util.description(gb.actual_flag,'BATCH_TYPE',101) balance_type,
(select gbv.budget_name from gl_budget_versions gbv where gb.budget_version_id=gbv.budget_version_id) budget_name,
(select get.encumbrance_type from gl_encumbrance_types get where get.encumbrance_type_id = gb.encumbrance_type_id) encumbrance_type,
null conversion_date,
null conversion_type,
null conversion_rate,
null accounting_event_description,
null accounting_date,
null transaction_date,
null transaction_number,
-- Document Sequences
null document_seq_id, --XXECL      
null document_seq_name, --XXECL       
null document_seq_value, --XXECL
null sub_doc_seq_id, --XXECL 
null sub_doc_seq_name, --XXECL
null sub_doc_seq_val, --XXECL
null gl_close_acct_seq_val, -- XXECL
null sl_close_acct_seq_val, --XXECL
null reporting_seq, --XXECL
null reconciliation_reference, --XXECL
--
&lp_gjl_dff_cols_null
--
null sl_source, --XXECL
null sl_batch_no, -- XXECL
--Assets
null asset_number,
--AP
null invoice_number,
