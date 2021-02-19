/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoices and Lines
-- Description: Detail Invoice Aging report with line item details and amounts

-- Excel Examle Output: https://www.enginatics.com/example/ap-invoices-and-lines/
-- Library Link: https://www.enginatics.com/reports/ap-invoices-and-lines/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
haouv.name operating_unit,
aps.vendor_name supplier,
aia.invoice_num,
xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id) invoice_status,
xxen_util.client_time(aia.creation_date) invoice_creation_date,
aia.invoice_date,
aia.gl_date,
apsa.due_date,
ceil(sysdate-apsa.due_date) days_due,
xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200) invoice_type,
aia.source invoice_source,
aia.description invoice_description,
decode(apsa.payment_num,1,aia.invoice_amount) invoice_amount,
decode(apsa.payment_num,1,aia.total_tax_amount) tax_amount,
decode(apsa.payment_num,1,aia.amount_applicable_to_discount) amount_applicable_to_discount,
decode(apsa.payment_num,1,aia.discount_amount_taken) discount_amount_taken,
decode(apsa.payment_num,1,aia.approved_amount) approved_amount,
aia.invoice_currency_code,
decode(apsa.payment_num,1,aia.amount_paid) amount_paid,
decode(apsa.payment_num,1,aia.pay_curr_invoice_amount) pay_curr_invoice_amount,
aia.payment_currency_code,
decode(apsa.payment_num,1,decode(aia.invoice_currency_code,gl.currency_code,aia.invoice_amount,aia.base_amount)) invoice_amount_base,
decode(apsa.payment_num,1,aia.total_tax_amount)*aia.exchange_rate tax_amount_base,
decode(apsa.payment_num,1,aia.amount_applicable_to_discount)*aia.exchange_rate amt_applicable_to_disc_base,
decode(apsa.payment_num,1,aia.discount_amount_taken)/aia.payment_cross_rate*aia.exchange_rate discount_amount_taken_base,
decode(apsa.payment_num,1,aia.approved_amount)*aia.exchange_rate approved_amount_base,
decode(apsa.payment_num,1,aia.amount_paid)/aia.payment_cross_rate*aia.exchange_rate amount_paid_base,
gl.currency_code base_currency,
aia.doc_sequence_value,
apsa.payment_priority,
--(nvl(C_SUM_INV_DUE_AMT_3,0) * 100)/nvl(C_SUM_AMT_REMAINING,1) percent_open,
apsa.payment_num,
apsa.gross_amount,
case when ceil(sysdate-apsa.due_date)=0 then apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) end current1,
case when ceil(sysdate-apsa.due_date) between 0 and 30 then apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) end between_0_30,
case when ceil(sysdate-apsa.due_date) between 1 and 30 then apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) end between_1_30,
case when ceil(sysdate-apsa.due_date) between 31 and 60 then apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) end between_31_60,
case when ceil(sysdate-apsa.due_date) between 61 and 90 then apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) end between_61_90,
case when ceil(sysdate-apsa.due_date) between 91 and 120 then apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) end between_91_120,
case when ceil(sysdate-apsa.due_date) between 121 and 150 then apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) end between_121_150,
case when ceil(sysdate-apsa.due_date) between 151 and 180 then apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) end between_151_180,
case when ceil(sysdate-apsa.due_date) >=181 then apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) end greater_than_180,
aps.segment1 supplier_number,
aps.num_1099 taxpayer_id,
aps.vat_registration_num tax_registration_number,
aps.end_date_active inactive_on,
aps.customer_num,
xxen_util.meaning(aps.one_time_flag,'YES_NO',0) one_time,
aps.credit_status_lookup_code,
aps.credit_limit,
aps.withholding_status_lookup_code,
aps.withholding_start_date,
aps.vat_code,
assa.vendor_site_id,
assa.vendor_site_code,
assa.vendor_site_code supplier_site,
assa.vendor_site_code_alt,
xxen_util.meaning(assa.purchasing_site_flag,'YES_NO',0) purchasing_site,
xxen_util.meaning(assa.rfq_only_site_flag,'YES_NO',0) rfq_site,
xxen_util.meaning(assa.pay_site_flag,'YES_NO',0) pay_site,
xxen_util.meaning(assa.tax_reporting_site_flag,'YES_NO',0) tax_reporting_site,
xxen_util.meaning(assa.pcard_site_flag,'YES_NO',0) p_card_site,
xxen_util.meaning(assa.attention_ar_flag,'YES_NO',0) attention_ar,
assa.address_line1,
assa.address_line2,
assa.address_line3,
assa.address_line4,
assa.city,
assa.state,
assa.zip,
assa.county,
assa.province,
assa.country,
assa.area_code,
assa.phone,
assa.fax_area_code,
assa.fax,
assa.supplier_notif_method,
assa.email_address,
assa.remittance_email,
aia.payment_cross_rate,
aia.payment_cross_rate_date,
apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) amount_remaining,
apsa.discount_date,
apsa.future_pay_due_date,
apsa.hold_flag,
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
ieba.iban,
at.name invoice_terms,
aia.terms_date,
aia.cancelled_date invoice_cancelled_date,
decode(apsa.payment_num,1,aia.cancelled_amount) invoice_cancelled_amount,
xxen_util.user_name(aia.cancelled_by) invoice_cancelled_by,
decode(apsa.payment_num,1,aia.temp_cancelled_amount) invoice_temp_cancelled_amount,
aia.auto_tax_calc_flag,
--   decode (aia.po_number,'unmatched',null,'any multiple',null,aia.po_number ) po_number,
case when ceil(sysdate-apsa.due_date)=0 then apsa.amount_remaining/aia.payment_cross_rate*nvl(aia.exchange_rate,1) end current_bucket,
&invoice_detail_columns
aia.pay_group_lookup_code invoice_pay_group,
xxen_util.concatenated_segments(aia.accts_pay_code_combination_id) accts_pay_account,
xxen_util.segments_description(aia.accts_pay_code_combination_id) accts_pay_account_descripton,
xxen_util.meaning(aia.exclusive_payment_flag,'YES_NO',0) invoice_exclusive_payment,
arpa.recurring_pay_num,
arpa.rec_pay_period_type,
arpa.num_of_periods,
arpa.description recurring_pmt_description,
aia.invoice_id
from
gl_ledgers gl,
hr_all_organization_units_vl haouv,
hr_all_organization_units_vl haouv1,
hr_all_organization_units_vl haouv2,
hr_all_organization_units_vl haouv3,
ap_invoices_all aia,
ap_payment_schedules_all apsa,
iby_ext_bank_accounts ieba,
ce_banks_v cbv,
ap_suppliers aps,
ap_supplier_sites_all assa,
(select aila.* from ap_invoice_lines_all aila where '&enable_aila'='Y') aila,
(select aida.* from ap_invoice_distributions_all aida where '&enable_aida'='Y') aida,
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
aia.invoice_id=apsa.invoice_id and
apsa.external_bank_account_id=ieba.ext_bank_account_id(+) and
ieba.bank_id=cbv.bank_party_id(+) and
aia.vendor_id=aps.vendor_id and
aia.vendor_site_id=assa.vendor_site_id and
aia.invoice_id=aila.invoice_id(+) and
aila.invoice_id=aida.invoice_id(+)and
aila.line_number=aida.invoice_line_number(+) and
aida.project_id=ppa.project_id(+)and
aida.task_id=pt.task_id(+)and
aia.recurring_payment_id=arpa.recurring_payment_id(+) and
aia.terms_id=at.term_id(+)
order by
haouv.name,
aps.vendor_name,
aia.invoice_date,
aia.gl_date,
aia.invoice_num,
apsa.payment_num
&p_order_by