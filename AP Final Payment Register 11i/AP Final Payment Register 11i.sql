/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Final Payment Register 11i
-- Description: Imported from Concurrent Program
Application: Payables
Source: Final Payment Register
Short Name: APXPBFPR
-- Excel Examle Output: https://www.enginatics.com/example/ap-final-payment-register-11i/
-- Library Link: https://www.enginatics.com/reports/ap-final-payment-register-11i/
-- Run Report: https://demo.enginatics.com/

select
 -- payment batch
 gsob.name set_of_books,
 aisc.checkrun_name payment_batch_name,
 aisc.bank_account_name bank_account,
 acs.name payment_document,
 trunc(aisc.check_date) payment_date,
 xxen_util.meaning(aisc.status,'CHECK BATCH STATUS',200) payment_batch_status,
 xxen_util.meaning(aisc.document_order_lookup_code,'DOCUMENT ORDER',200) document_order,
 aisc.max_outlay maximum_outlay,
 aisc.max_payment_amount maximum_payment,
 aisc.min_check_amount minimum_payment,
 xxen_util.meaning(aisc.payment_method_lookup_code,'PAYMENT METHOD',200) payment_method,
 xxen_util.meaning(aisc.pay_only_when_due_flag,'YES_NO',0) pay_only_when_due,
 aisc.pay_thru_date pay_through_date,
 xxen_util.meaning(aisc.zero_amounts_allowed,'YES_NO',0) zero_payments_allowed,
 xxen_util.meaning(aisc.zero_invoices_allowed,'YES_NO',0) zero_invoices_allowed,
 aba.currency_code bank_account_currency,
 aisc.currency_code payment_batch_currency,
 aisc.vendor_pay_group pay_group,
 aisc.low_payment_priority priority_range_low,
 aisc.hi_payment_priority priority_range_high,
 gdct.user_conversion_type exchange_rate_type,
 aisc.exchange_rate exchange_rate,
 -- payment batch totals
 sum(ac.amount) over (partition by aisc.checkrun_name) payment_batch_total,
 sum(decode(ac.status_lookup_code,'SET UP',1,0)) over (partition by aisc.checkrun_name) setup_document_count,
 sum(decode(ac.status_lookup_code,'OVERFLOW',1,0)) over (partition by aisc.checkrun_name) overflow_documnent_count,
 sum(decode(ac.status_lookup_code,'SPOILED',0, 'SET UP', 0, 'OVERFLOW',0,1)) over (partition by aisc.checkrun_name) negotiable_document_count,
 -- checks
 ac.check_number document_number,
 nvl(ac.doc_sequence_value,ac.check_voucher_num) voucher_number,
 xxen_util.meaning(ac.status_lookup_code,'CHECK STATE',200) document_status,
 decode(ac.status_lookup_code, 'SET UP',xxen_util.meaning(ac.status_lookup_code,'CHECK STATE',200), ac.vendor_name) supplier_name,
 decode(ac.status_lookup_code, 'SET UP',xxen_util.meaning(ac.status_lookup_code,'CHECK STATE',200), ac.vendor_site_code) supplier_site,
 decode(ac.status_lookup_code, 'SET UP',xxen_util.meaning(ac.status_lookup_code,'CHECK STATE',200), ac.address_line1) address1,
 decode(ac.status_lookup_code,'SET UP','',ac.address_line2) address2,
 decode(ac.status_lookup_code,'SET UP','',ac.address_line3) address3,
 decode(ac.status_lookup_code,'SET UP','',ac.city) city,
 decode(ac.status_lookup_code,'SET UP','',ac.state) state,
 decode(ac.status_lookup_code,'SET UP','', ac.zip) zip,
 decode(ac.status_lookup_code,'SET UP','',ac.province) province,
 decode(ac.status_lookup_code,'SET UP','',ft.territory_short_name) territory,
 nvl(ac.bank_account_num, aba2.bank_account_num) supplier_bank_account,
 ac.amount document_amount
from
 ap_invoice_selection_criteria aisc,
 ap_check_stocks acs,
 ap_bank_accounts aba,
 ap_system_parameters asp,
 gl_sets_of_books gsob,
 gl_daily_conversion_types gdct,
 --
 ap_checks ac,
 fnd_territories_vl ft,
 ap_bank_accounts aba2
where
 1=1 and
 aisc.status = 'CONFIRMED' and
 acs.check_stock_id = aisc.check_stock_id and
 aba.bank_account_id = acs.bank_account_id and
 asp.set_of_books_id = gsob.set_of_books_id and
 gdct.conversion_type(+) = aisc.exchange_rate_type and
 --
 aisc.checkrun_name = ac.checkrun_name (+) and
 ac.country = ft.territory_code(+) and
 ac.external_bank_account_id = aba2.bank_account_id(+)
 order by
 gsob.name,
 aisc.check_date,
 aisc.checkrun_name,
 ac.check_number