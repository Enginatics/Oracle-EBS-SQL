/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoices and Lines
-- Description: Detail Invoice Aging report with line item details and amounts

Parameter explanation:
- Invoice on Hold (LOV: Yes/No)
  Default Value = Null (Hold Status not considered as per current behaviour)
  Yes - Only Invoices that currently have an unreleased hold will be retrieved
  No - Only Invoices that do not currently have an unreleased hold will be retrieved

- Hold Name (LOV: AP Hold Names)
  Default Value Null
  If specified - only Invoices that currently have an unreleased hold of the specified name will be retrieved

Hold column explanation:
- Holds  - a list of the current unreleased holds against the invoice
- Hold Dates - the Hold Date
- Holds Held By - the name of user who applied the holds
- Hold PO References - Identifies the matching POs for PO Matching Holds in the format: PO Number(Release number)(Line Number)(Shipment Number)
- Hold Receipt References  - Identifies the matching Receipts for Receipt Matching Holds in the format: Receipt Number(Line Number)
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoices-and-lines/
-- Library Link: https://www.enginatics.com/reports/ap-invoices-and-lines/
-- Run Report: https://demo.enginatics.com/

select
ap_inv.ledger,
ap_inv.operating_unit,
ap_inv.supplier,
ap_inv.supplier_number,
ap_inv.supplier_site,
ap_inv.invoice_num,
ap_inv.doc_sequence_value document_number,
ap_inv.invoice_status,
ap_inv.batch_name,
ap_inv.invoice_creation_date,
ap_inv.invoice_received_date,
ap_inv.invoice_date,
ap_inv.invoice_gl_date,
ap_inv.due_date,
ap_inv.days_due,
ap_inv.invoice_type,
ap_inv.invoice_source,
ap_inv.invoice_description,
ap_inv.has_attachment,
ap_inv.invoice_currency_code,
ap_inv.payment_currency_code,
decode(ap_inv.first_invoice,'Y',ap_inv.invoice_amount) invoice_amount,
decode(ap_inv.first_invoice,'Y',ap_invoices_utility_pkg.get_item_total(ap_inv.invoice_id, ap_inv.org_id)) items_total,
decode(ap_inv.first_invoice,'Y',ap_invoices_utility_pkg.get_retained_total(ap_inv.invoice_id, ap_inv.org_id)) retainage_total,
decode(ap_inv.first_invoice,'Y',ap_invoices_utility_pkg.get_prepaid_amount(ap_inv.invoice_id)) prepayments_applied_total,
decode(ap_inv.first_invoice,'Y',ap_invoices_utility_pkg.get_amount_withheld(ap_inv.invoice_id)) witholding_total,
decode(ap_inv.first_invoice,'Y',ap_inv.total_tax_amount) tax_total,
decode(ap_inv.first_invoice,'Y',ap_inv.self_assessed_tax_amount) self_assessed_tax_amount,
decode(ap_inv.first_invoice,'Y',ap_invoices_utility_pkg.get_freight_total(ap_inv.invoice_id, ap_inv.org_id)) freight_total,
decode(ap_inv.first_invoice,'Y',ap_invoices_utility_pkg.get_misc_total(ap_inv.invoice_id, ap_inv.org_id)) miscellaneous_total,
decode(ap_inv.first_invoice,'Y',
nvl(ap_invoices_utility_pkg.get_item_total(ap_inv.invoice_id, ap_inv.org_id),0)
+ nvl(ap_invoices_utility_pkg.get_retained_total(ap_inv.invoice_id, ap_inv.org_id),0)
- nvl(abs(ap_invoices_utility_pkg.get_prepaid_amount(ap_inv.invoice_id)),0)
- nvl(ap_invoices_utility_pkg.get_amount_withheld(ap_inv.invoice_id),0)
+ nvl(ap_inv.total_tax_amount,0)
+ nvl(ap_invoices_utility_pkg.get_freight_total(ap_inv.invoice_id, ap_inv.org_id),0)
+ nvl(ap_invoices_utility_pkg.get_misc_total(ap_inv.invoice_id, ap_inv.org_id),0)
) invoice_total,
decode(ap_inv.first_invoice,'Y',ap_inv.amount_applicable_to_discount) amount_applicable_to_discount,
decode(ap_inv.first_invoice,'Y',ap_inv.discount_amount_taken) discount_amount_taken,
decode(ap_inv.first_invoice,'Y',ap_inv.approved_amount) approved_amount,
decode(ap_inv.first_invoice,'Y',ap_inv.pay_curr_invoice_amount) payment_curr_invoice_amount,
decode(ap_inv.first_invoice,'Y',ap_inv.amount_paid) amount_paid,
ap_inv.base_currency,
decode(ap_inv.first_invoice,'Y',ap_inv.invoice_amount_base) invoice_amount_base,
decode(ap_inv.first_invoice,'Y',ap_inv.tax_amount_base) tax_amount_base,
decode(ap_inv.first_invoice,'Y',ap_inv.amt_applicable_to_disc_base) amt_applicable_to_disc_base,
decode(ap_inv.first_invoice,'Y',ap_inv.discount_amount_taken_base) discount_amount_taken_base,
decode(ap_inv.first_invoice,'Y',ap_inv.approved_amount_base) approved_amount_base,
decode(ap_inv.first_invoice,'Y',ap_inv.amount_paid_base) amount_paid_base,
ap_inv.payment_num,
ap_inv.payment_date,
decode(ap_inv.first_psched,'Y',ap_inv.gross_amount) payment_num_gross_amount,
decode(ap_inv.first_psched,'Y',ap_inv.amount_remaining) payment_num_amount_remaining,
&aging_bucket_cols2
ap_inv.payment_cross_rate,
ap_inv.payment_cross_rate_date,
ap_inv.discount_date,
ap_inv.future_pay_due_date,
ap_inv.payment_method,
ap_inv.payment_priority,
ap_inv.invoice_payment_status,
ap_inv.schedule_payment_status,
ap_inv.second_discount_date,
ap_inv.third_discount_date,
decode(ap_inv.first_psched,'Y',ap_inv.discount_amount_available) discount_amount_available,
decode(ap_inv.first_psched,'Y',ap_inv.second_disc_amt_available) second_disc_amt_available,
decode(ap_inv.first_psched,'Y',ap_inv.third_disc_amt_available) third_disc_amt_available,
decode(ap_inv.first_psched,'Y',ap_inv.discount_amount_remaining) discount_amount_remaining,
decode(ap_inv.first_psched,'Y',ap_inv.inv_curr_gross_amount) inv_curr_gross_amount,
ap_inv.bank_name,
ap_inv.iban,
ap_inv.invoice_terms,
ap_inv.terms_date,
ap_inv.invoice_cancelled_date,
ap_inv.invoice_cancelled_by,
decode(ap_inv.first_invoice,'Y',ap_inv.invoice_cancelled_amount) invoice_cancelled_amount,
decode(ap_inv.first_invoice,'Y',ap_inv.invoice_temp_cancelled_amount) invoice_temp_cancelled_amount,
ap_inv.auto_tax_calculation_method,
ap_inv.invoice_pay_group,
ap_inv.invoice_exclusive_payment_flag,
ap_inv.dispute_reason,
ap_inv.supplier_site_payment_hold,
ap_inv.scheduled_payment_hold,
ap_inv.scheduled_payment_hold_reason,
ap_holds.holds invoice_holds,
ap_holds.hold_dates invoice_hold_dates,
ap_holds.holds_held_by invoice_holds_held_by,
ap_holds.hold_po_references invoice_hold_purchase_orders,
ap_holds.hold_receipt_references invoice_hold_receipts,
&invoice_detail_columns
&dff_columns2
ap_inv.accts_pay_account,
ap_inv.accts_pay_account_descripton,
ap_inv.recurring_pmt_number,
ap_inv.recurring_pmt_period_type,
ap_inv.recurring_number_of_periods,
ap_inv.recurring_pmt_description,
ap_inv.supplier_taxpayer_id,
ap_inv.supplier_tax_registration,
ap_inv.supplier_inactive_on,
ap_inv.customer_num,
ap_inv.one_time_supplier,
ap_inv.supplier_credit_status,
ap_inv.credit_limit,
ap_inv.supplier_withholding_status,
ap_inv.withholding_start_date,
ap_inv.supplier_vat_code,
ap_inv.supplier_site_alt,
ap_inv.purchasing_site,
ap_inv.rfq_site,
ap_inv.pay_site,
ap_inv.tax_reporting_site,
ap_inv.p_card_site,
ap_inv.attention_ar,
ap_inv.address_line1,
ap_inv.address_line2,
ap_inv.address_line3,
ap_inv.address_line4,
ap_inv.city,
ap_inv.state,
ap_inv.zip,
ap_inv.county,
ap_inv.province,
ap_inv.country,
ap_inv.area_code,
ap_inv.phone,
ap_inv.fax_area_code,
ap_inv.fax,
ap_inv.supplier_notif_method,
ap_inv.email_address,
ap_inv.remittance_email,
&gcc_dist_segment_columns
&attachment_columns
ap_inv.created_by,
ap_inv.creation_date,
ap_inv.last_updated_by,
ap_inv.last_update_date,
ap_inv.line_created_by,
ap_inv.line_creation_date,
ap_inv.line_last_updated_by,
ap_inv.line_last_update_date,
ap_inv.dist_created_by,
ap_inv.dist_creation_date,
ap_inv.dist_last_updated_by,
ap_inv.dist_last_update_date,
ap_inv.invoice_id
from
(
select
gl.name ledger,
haouv.name operating_unit,
nvl(aps.vendor_name,hp.party_name) supplier,
nvl(aps.segment1,hp.party_number) supplier_number,
nvl(assa.vendor_site_code,hps.party_site_number) supplier_site,
aia.invoice_num,
xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id) invoice_status,
aba.batch_name,
xxen_util.client_time(aia.creation_date) invoice_creation_date,
xxen_util.client_time(aia.invoice_received_date) invoice_received_date,
aia.invoice_date,
aia.gl_date invoice_gl_date,
apsa.due_date,
ceil(sysdate-apsa.due_date) days_due,
xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200) invoice_type,
aia.source invoice_source,
aia.description invoice_description,
(select xxen_util.meaning('Y','YES_NO',0) from fnd_attached_documents fad where to_char(aia.invoice_id)=fad.pk1_value and fad.entity_name='AP_INVOICES' and rownum=1) has_attachment,
aia.invoice_currency_code,
aia.payment_currency_code,
aia.invoice_amount,
aia.total_tax_amount,
aia.self_assessed_tax_amount,
aia.amount_applicable_to_discount,
aia.discount_amount_taken,
aia.approved_amount,
aia.pay_curr_invoice_amount,
aia.amount_paid,
gl.currency_code base_currency,
decode(aia.invoice_currency_code,gl.currency_code,aia.invoice_amount,aia.base_amount) invoice_amount_base,
aia.total_tax_amount*nvl(aia.exchange_rate,1) tax_amount_base,
aia.amount_applicable_to_discount*nvl(aia.exchange_rate,1) amt_applicable_to_disc_base,
aia.discount_amount_taken/aia.payment_cross_rate*nvl(aia.exchange_rate,1) discount_amount_taken_base,
aia.approved_amount*nvl(aia.exchange_rate,1) approved_amount_base,
aia.amount_paid/aia.payment_cross_rate*nvl(aia.exchange_rate,1) amount_paid_base,
aia.dispute_reason,
aia.doc_sequence_value,
apsa.payment_priority,
apsa.payment_num,
(
select
max(aca.check_date)
from
ap_invoice_payments_all aipa,
ap_checks_all aca
where
apsa.invoice_id=aipa.invoice_id and
apsa.payment_num=aipa.payment_num and
aipa.check_id=aca.check_id and
aca.void_date is null and
aca.stopped_date is null
) payment_date,
apsa.gross_amount,
apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) amount_remaining,
&aging_bucket_cols1
aia.payment_cross_rate,
aia.payment_cross_rate_date,
apsa.discount_date,
apsa.future_pay_due_date,
case when assa.hold_all_payments_flag='Y' and aia.cancelled_date is null and aia.payment_status_flag<>'Y' then xxen_util.meaning('Y','YES_NO',0) end supplier_site_payment_hold,
decode(apsa.hold_flag,'Y',xxen_util.meaning(apsa.hold_flag,'YES_NO',0)) scheduled_payment_hold,
decode(apsa.hold_flag,'Y',apsa.iby_hold_reason) scheduled_payment_hold_reason,
nvl(xxen_util.meaning(apsa.payment_method_code,'PAYMENT METHOD',200),apsa.payment_method_code) payment_method,
xxen_util.meaning(aia.payment_status_flag,'INVOICE PAYMENT STATUS',200) invoice_payment_status,
xxen_util.meaning(apsa.payment_status_flag,'INVOICE PAYMENT STATUS',200) schedule_payment_status,
apsa.second_discount_date,
apsa.third_discount_date,
apsa.discount_amount_available,
apsa.second_disc_amt_available,
apsa.third_disc_amt_available,
apsa.discount_amount_remaining,
apsa.inv_curr_gross_amount,
cbv.bank_name,
ieba.masked_iban iban,
at.name invoice_terms,
aia.terms_date,
aia.cancelled_date invoice_cancelled_date,
aia.cancelled_amount invoice_cancelled_amount,
xxen_util.user_name(aia.cancelled_by) invoice_cancelled_by,
aia.temp_cancelled_amount invoice_temp_cancelled_amount,
xxen_util.meaning(aia.auto_tax_calc_flag,'AP_TAX_CALCULATION_METHOD',200) auto_tax_calculation_method,
aia.pay_group_lookup_code invoice_pay_group,
xxen_util.meaning(aia.exclusive_payment_flag,'YES_NO',0) invoice_exclusive_payment_flag,
xxen_util.concatenated_segments(aia.accts_pay_code_combination_id) accts_pay_account,
xxen_util.segments_description(aia.accts_pay_code_combination_id) accts_pay_account_descripton,
aila.line_number,
xxen_util.meaning(aila.line_type_lookup_code,'INVOICE LINE TYPE',200) line_type,
xxen_util.meaning(aila.line_source,'LINE SOURCE',200) line_source,
decode(aila.discarded_flag,'Y','Y') line_discarded,
replace(aila.description,'~','-') line_description,
aila.amount line_amount,
nvl(aila.base_amount,aila.amount) line_base_amount,
aila.accounting_date line_accounting_date,
decode(aila.deferred_acctg_flag,'Y',xxen_util.meaning(aila.deferred_acctg_flag,'YES_NO',0)) deferred_option,
aila.def_acctg_start_date deferred_start_date,
aila.def_acctg_end_date deferred_end_date,
aila.tax_regime_code,
aila.tax,
aila.tax_jurisdiction_code,
aila.tax_rate_code,
aila.tax_rate,
aida.distribution_line_number dist_line_number,
xxen_util.meaning(aida.line_type_lookup_code,'INVOICE DISTRIBUTION TYPE',200) distribution_type,
aida.period_name,
aida.accounting_date dist_accounting_date,
case when '&show_aida'='Y' then aida.quantity_invoiced else aila.quantity_invoiced end quantity_invoiced,
case when '&show_aida'='Y' then aida.unit_price else aila.unit_price end unit_price,
aida.amount dist_amount,
nvl(aida.base_amount,aida.amount) dist_base_amount,
aida.invoice_price_variance dist_invoice_price_variance,
aida.base_invoice_price_variance dist_base_inv_price_variance,
aida.dist_code_combination_id,
xxen_util.concatenated_segments(aida.dist_code_combination_id) expense_account,
xxen_util.concatenated_segments(aida.price_var_code_combination_id) price_variance_account,
xxen_util.segments_description(aida.dist_code_combination_id) expense_account_descripton,
xxen_util.segments_description(aida.price_var_code_combination_id) price_variance_account_desc,
xxen_util.meaning(aida.dist_match_type,'MATCH_STATUS',200) dist_match_type,
decode(aida.match_status_flag,'A','Validated','T','Tested','S','Stopped','Never Validated') dist_match_status,
(select pha.segment1 from po_headers_all pha where nvl((select pda.po_header_id from po_distributions_all pda where nvl(aida.po_distribution_id,aila.po_distribution_id)=pda.po_distribution_id),aia.quick_po_header_id)=pha.po_header_id) po_number,
nvl((select max(rt.transaction_date) from rcv_transactions rt where rt.transaction_id = nvl(aida.rcv_transaction_id,aila.rcv_transaction_id) and rt.transaction_type in ('RECEIVE','DELIVER')),
    (select max(rt.transaction_date) from rcv_transactions rt where rt.po_line_id = aila.po_line_id and rt.po_line_location_id = aila.po_line_location_id and rt.transaction_type in ('RECEIVE','DELIVER'))
) receipt_date,
xxen_util.meaning(aida.assets_tracking_flag,'YES_NO',0) dist_asset_tracking_flag,
aida.assets_addition_flag dist_assets_addition_flag,
replace(aida.description,'~','-') dist_description,
aida.expenditure_item_date pa_expenditure_item_date,
aida.expenditure_type pa_expenditure_type,
coalesce(haouv1.name,haouv3.name,haouv2.name) expenditure_organization,
nvl(xxen_util.meaning(aida.pa_addition_flag,'PA_ADDITION_FLAG',275),aida.pa_addition_flag) pa_addition_flag,
aida.project_accounting_context,
ppa.segment1 project_number,
ppa.name project_name,
ppa.description project_description,
ppa.project_type,
ppa.project_status_code,
ppa.start_date project_start_date,
ppa.completion_date project_completion_date,
pt.task_number,
pt.task_name,
pt.description task_description,
pt.service_type_code,
pt.start_date task_start_date,
pt.completion_date task_completion_date,
arpa.recurring_pay_num    recurring_pmt_number,
arpa.rec_pay_period_type  recurring_pmt_period_type,
arpa.num_of_periods       recurring_number_of_periods,
arpa.description          recurring_pmt_description,
aps.num_1099             supplier_taxpayer_id,
aps.vat_registration_num supplier_tax_registration,
aps.end_date_active      supplier_inactive_on,
aps.customer_num,
xxen_util.meaning(aps.one_time_flag,'YES_NO',0) one_time_supplier,
aps.credit_status_lookup_code supplier_credit_status,
aps.credit_limit,
aps.withholding_status_lookup_code supplier_withholding_status,
aps.withholding_start_date,
aps.vat_code supplier_vat_code,
assa.vendor_site_code_alt   supplier_site_alt,
xxen_util.meaning(assa.purchasing_site_flag,'YES_NO',0)    purchasing_site,
xxen_util.meaning(assa.rfq_only_site_flag,'YES_NO',0)      rfq_site,
xxen_util.meaning(assa.pay_site_flag,'YES_NO',0)           pay_site,
xxen_util.meaning(assa.tax_reporting_site_flag,'YES_NO',0) tax_reporting_site,
xxen_util.meaning(assa.pcard_site_flag,'YES_NO',0)         p_card_site,
xxen_util.meaning(assa.attention_ar_flag,'YES_NO',0)       attention_ar,
nvl(assa.address_line1,hl.address1) address_line1,
nvl(assa.address_line2,hl.address2) address_line2,
nvl(assa.address_line3,hl.address3) address_line3,
nvl(assa.address_line4,hl.address4) address_line4,
nvl(assa.city,hl.city) city,
nvl(assa.state,hl.state) state,
nvl(assa.zip,hl.postal_code)  zip,
nvl(assa.county,hl.county) county,
nvl(assa.province,hl.province) province,
nvl(assa.country,hl.country) country,
assa.area_code,
assa.phone,
assa.fax_area_code,
assa.fax,
assa.supplier_notif_method,
assa.email_address,
assa.remittance_email,
&dff_columns
xxen_util.user_name(aia.created_by) created_by,
xxen_util.client_time(aia.creation_date) creation_date,
xxen_util.user_name(aia.last_updated_by) last_updated_by,
xxen_util.client_time(aia.last_update_date) last_update_date,
xxen_util.user_name(aila.created_by) line_created_by,
xxen_util.client_time(aila.creation_date) line_creation_date,
xxen_util.user_name(aila.last_updated_by) line_last_updated_by,
xxen_util.client_time(aila.last_update_date) line_last_update_date,
xxen_util.user_name(aida.created_by) dist_created_by,
xxen_util.client_time(aida.creation_date) dist_creation_date,
xxen_util.user_name(aida.last_updated_by) dist_last_updated_by,
xxen_util.client_time(aida.last_update_date) dist_last_update_date,
aia.invoice_id,
aia.org_id,
decode(row_number() over (partition by apsa.invoice_id order by nvl(apsa.payment_num,1),aila.line_number,aida.accounting_date,aida.distribution_line_number),1,'Y') first_invoice,
decode(row_number() over (partition by apsa.invoice_id,apsa.payment_num order by aila.line_number,aida.accounting_date,aida.distribution_line_number),1,'Y') first_psched,
decode(row_number() over (partition by apsa.invoice_id,aila.line_number order by aida.accounting_date,aida.distribution_line_number),1,'Y') first_line
from
gl_ledgers gl,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv1,
hr_all_organization_units_vl haouv2,
hr_all_organization_units_vl haouv3,
ap_invoices_all aia,
ap_batches_all aba,
ap_payment_schedules_all apsa,
iby_ext_bank_accounts ieba,
ce_banks_v cbv,
ap_suppliers aps,
ap_supplier_sites_all assa,
hz_parties hp,
hz_party_sites hps,
hz_locations hl,
(select aila.* from ap_invoice_lines_all aila where '&show_aila'='Y') aila,
(select aida2.* from ap_invoice_distributions_all aida2, gl_code_combinations gcc where '&show_aida'='Y' and 2=2 and aida2.dist_code_combination_id=gcc.code_combination_id) aida,
ap_recurring_payments_all arpa,
ap_terms at,
pa_projects_all ppa,
pa_tasks pt
where
1=1 and
aia.set_of_books_id=gl.ledger_id and
aia.org_id=haouv.organization_id(+) and
aia.expenditure_organization_id=haouv1.organization_id(+) and
aila.expenditure_organization_id=haouv2.organization_id(+) and
aida.expenditure_organization_id=haouv3.organization_id(+) and
aia.batch_id=aba.batch_id(+) and
aia.invoice_id=apsa.invoice_id and
apsa.external_bank_account_id=ieba.ext_bank_account_id(+) and
ieba.bank_id=cbv.bank_party_id(+) and
aia.vendor_id=aps.vendor_id(+) and
aia.vendor_site_id=assa.vendor_site_id(+) and
aia.party_id=hp.party_id(+) and
aia.party_site_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+) and
decode(apsa.payment_num,1,apsa.invoice_id)=aila.invoice_id(+) and
aila.invoice_id=aida.invoice_id(+)and
aila.line_number=aida.invoice_line_number(+) and
aida.project_id=ppa.project_id(+)and
aida.task_id=pt.task_id(+)and
aia.recurring_payment_id=arpa.recurring_payment_id(+) and
aia.terms_id=at.term_id(+) and
(
:p_has_dist_criteria is null or aia.invoice_id in --need this to apply dist level restrictions in case report is run at header or line level
(
select
aida2.invoice_id
from
ap_invoice_distributions_all aida2,
gl_code_combinations gcc
where
2=2 and
nvl(aila.line_number,aida2.invoice_line_number)=aida2.invoice_line_number and
nvl(aida.distribution_line_number,aida2.distribution_line_number)=aida2.distribution_line_number and
aida2.dist_code_combination_id=gcc.code_combination_id
)
)
) ap_inv,
(
select distinct
x.invoice_id,
listagg(x.hold_name,', ') within group (order by x.hold_name) over (partition by x.invoice_id) holds,
case count(distinct fnd_date.date_to_displaydate(x.hold_date)) over (partition by x.invoice_id)
 when 1 then to_char(fnd_date.date_to_displaydate(x.hold_date))
 else listagg(to_char(fnd_date.date_to_displaydate(x.hold_date)),', ') within group (order by x.hold_name) over (partition by x.invoice_id)
 end hold_dates,
case count(distinct x.held_by_user_name) over (partition by x.invoice_id)
 when 1 then x.held_by_user_name
 else listagg(x.held_by_user_name,', ') within group (order by x.hold_name) over (partition by x.invoice_id)
 end holds_held_by,
x.po_ref hold_po_references,
x.receipt_ref hold_receipt_references
from
(
select distinct
  aha.invoice_id,
  alc.displayed_field hold_name,
  first_value(aha.hold_date) over (partition by aha.invoice_id,aha.hold_lookup_code order by aha.hold_date) hold_date,
  first_value(decode(aha.held_by,5,xxen_util.meaning('SYSTEM','NLS TRANSLATION',200),xxen_util.user_name(aha.held_by))) over (partition by aha.invoice_id,aha.hold_lookup_code order by aha.hold_date) held_by_user_name,
  po.po_ref,
  rcv.receipt_ref
 from
  ap_holds_all aha,
  ap_lookup_codes alc,
  (select distinct
    x.invoice_id,
    listagg(x.po_ref,',') within group (order by x.po_ref) over (partition by x.invoice_id) po_ref
   from
    (select distinct
      aha.invoice_id,
      nvl(pha.clm_document_number,pha.segment1)||'('||nvl(to_char(pra.release_num),' ')||')('||nvl(pla.line_num_display, to_char(pla.line_num))||')('||plla.shipment_num||')' po_ref
     from
      ap_holds_all aha,
      po_line_locations_all plla,
      po_lines_all pla,
      po_headers_all pha,
      po_releases_all pra
     where
      aha.release_lookup_code is null and
      plla.line_location_id=aha.line_location_id and
      pla.po_line_id=plla.po_line_id and
      pha.po_header_id=plla.po_header_id and
      pra.po_release_id (+)=plla.po_release_id
    ) x
  ) po,
  (select distinct
    x.invoice_id,
    listagg(x.receipt_ref,',') within group (order by x.receipt_ref) over (partition by x.invoice_id) receipt_ref
   from
    (select distinct
      aha.invoice_id,
      rsh.receipt_num||'('||rsl.line_num||')' receipt_ref
     from
      ap_holds_all aha,
      rcv_transactions rt,
      rcv_shipment_lines rsl,
      rcv_shipment_headers rsh
     where
      aha.release_lookup_code is null and
      rt.transaction_id=aha.rcv_transaction_id and
      rsl.shipment_line_id=rt.shipment_line_id and
      rsh.shipment_header_id=rt.shipment_header_id
    ) x
  ) rcv
 where
  aha.release_lookup_code is null and
  aha.hold_lookup_code=alc.lookup_code and
  alc.lookup_type='HOLD CODE' and
  aha.invoice_id=po.invoice_id(+) and
  aha.invoice_id=rcv.invoice_id(+)
) x
) ap_holds,
(select
 fad.attached_document_id attachment_id,
 fad.entity_name,
 fad.pk1_value entity_id,
 fad.seq_num,
 fdd.user_name type,
 fdct.user_name category,
 fdt.title,
 fdt.description,
 case fd.datatype_id
 when 1 then (select fdst.short_text from fnd_documents_short_text fdst where fdst.media_id = fd.media_id)
 when 5 then fd.url
 when 6 then (select fl.file_name from fnd_lobs fl where fl.file_id = fd.media_id)
 else null
 end content,
 case when fd.datatype_id = 6 then fd.media_id else null end file_id
 from
 fnd_attached_documents fad,
 fnd_documents fd,
 fnd_documents_tl fdt,
 fnd_document_datatypes fdd,
 fnd_document_categories_tl fdct
 where
 fad.document_id = fd.document_id and
 fd.document_id = fdt.document_id and
 fdt.language = userenv('lang') and
 fd.datatype_id = fdd.datatype_id and
 fdd.language = userenv('lang') and
 fd.category_id = fdct.category_id and
 fdct.language = userenv('lang') and
 fd.datatype_id in (1,5,6)
) attchmt,
gl_code_combinations_kfv gcck
where
ap_inv.invoice_id=ap_holds.invoice_id(+) and
decode(:p_show_attachments,'Y','AP_INVOICES',null)=attchmt.entity_name(+) and
decode(:p_show_attachments,'Y',to_char(ap_inv.invoice_id),null)=attchmt.entity_id(+) and
ap_inv.dist_code_combination_id=gcck.code_combination_id(+)
order by
ap_inv.operating_unit,
ap_inv.supplier,
ap_inv.supplier_number,
ap_inv.invoice_date,
ap_inv.invoice_gl_date,
ap_inv.invoice_num,
ap_inv.payment_num,
ap_inv.line_number,
ap_inv.dist_accounting_date,
ap_inv.dist_line_number,
attchmt.seq_num