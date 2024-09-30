/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Preliminary Payment Register 11i
-- Description: Imported from Concurrent Program
Application: Payables
Source: Preliminary Payment Register
Short Name: APXPBPPR
-- Excel Examle Output: https://www.enginatics.com/example/ap-preliminary-payment-register-11i/
-- Library Link: https://www.enginatics.com/reports/ap-preliminary-payment-register-11i/
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
 nvl(q_check_totals.payment_batch_total,0) -- original_invoice_total = payment batch total - withheld amount total - discounts taken total
 - nvl(sum(-decode(asi.ok_to_pay_flag,'N',0 ,decode(asic.ok_to_pay_flag,'N',0 ,asi.withholding_amount))) over (partition by aisc.checkrun_name),0)
 - nvl(sum(decode(asi.ok_to_pay_flag, 'Y',decode(asic.ok_to_pay_flag,'Y', -asi.discount_amount,0), 'F', decode(asic.ok_to_pay_flag,'N',0,-asi.discount_amount),0)) over (partition by aisc.checkrun_name),0) total_original_invoice_amount,
 nvl(sum(-decode(asi.ok_to_pay_flag,'N',0 ,decode(asic.ok_to_pay_flag,'N',0 ,asi.withholding_amount))) over (partition by aisc.checkrun_name),0) total_withheld_amount,
 nvl(sum(decode(asi.ok_to_pay_flag, 'Y',decode(asic.ok_to_pay_flag,'Y', -asi.discount_amount,0), 'F', decode(asic.ok_to_pay_flag,'N',0,-asi.discount_amount),0)) over (partition by aisc.checkrun_name),0) total_discount_taken_amount,
 q_check_totals.payment_batch_total total_payment_batch_amount,
 q_check_totals.setup_document_count,
 q_check_totals.non_payment_document_count,
 q_check_totals.overflow_documnent_count,
 q_check_totals.negotiable_document_count,
 -- checks
 decode(asic.check_number,'0','***************', to_char(asic.check_number)) document_number,
 decode(asic.check_voucher_num,'0','***************', to_char(asic.check_voucher_num)) voucher_number,
 xxen_util.meaning(asic.dont_pay_reason_code,'DONT PAY REASON',200) status,
 asic.vendor_name supplier_name,
 asic.vendor_site_code supplier_site,
 nvl(asic.bank_account_num, aba2.bank_account_num) supplier_bank_account,
 (select
  aba2.last_update_date
  from
  ap_bank_accounts aba2
  where
  aba2.bank_account_id = asic.external_bank_account_id and
  aba2.last_update_date >
  (select
   max(aisc2.check_date)
   from
   ap_invoice_selection_criteria aisc2,
   ap_checks ac2
   where
   aisc2.status = 'CONFIRMED' and
   aisc2.checkrun_name = ac2.checkrun_name and
   ac2.external_bank_account_id = asic.external_bank_account_id
  )
 ) supplier_bank_account_updated,
 asic.check_amount document_payment_amount,
 nvl2(asic.checkrun_name,xxen_util.meaning(decode(asic.ok_to_pay_flag,'N','N', decode(asic.void_flag,'Y','N','Y')),'PAYMENT OPTIONS',200),null) document_ok_to_pay,
 -- invoices
 asi.dont_pay_description dont_pay_description,
 --
 asi.sequence_num invoice_sequence_number,
 asi.invoice_num  invoice_number,
 asi.payment_num  invoice_payment_num,
 trunc(asi.invoice_date) invoice_date,
 asi.invoice_description invoice_description,
 asi.amount_remaining invoice_gross_amount,
 -decode(asi.ok_to_pay_flag,'N',0 ,decode(asic.ok_to_pay_flag,'N',0 ,asi.withholding_amount)) invoice_withholding_amount,
 asi.discount_amount invoice_discount_amount,
 asi.proposed_payment_amount invoice_payment_amount,
 decode(asi.ok_to_pay_flag,'Y','','F','',xxen_util.meaning(asi.ok_to_pay_flag,'PAYMENT OPTIONS',200)) invoice_ok_to_pay,
 fds.name invoice_doc_sequence_name,
 nvl(to_char(ai.doc_sequence_value),ai.voucher_num) invoice_voucher_num,
 asi.due_date invoice_due_date,
 case when ai.invoice_id is not null
 then
  nvl((select
       xxen_util.meaning('Y','YES_NO',0)
       from
       ap_holds_all aha
       where
       aha.invoice_id = ai.invoice_id and
       aha.held_by = 5 and -- held by system
       aha.release_lookup_code is not null and -- released
       aha.last_updated_by != 5 and -- not released by system
       rownum <= 1
      ),
      xxen_util.meaning('N','YES_NO',0)
  )
 else
  null
 end invoice_manual_hold_releases,
 case when ai.invoice_id is not null
 then
  nvl((select
       xxen_util.meaning('Y','YES_NO',0)
       from
       fnd_attached_documents fad,
       fnd_documents_vl fdv
       where
       fad.document_id = fdv.document_id and
       fad.entity_name = 'AP_INVOICES' and
       fad.pk1_value = ai.invoice_id and
       rownum <= 1
      ),
      xxen_util.meaning('N','YES_NO',0)
  )
 else
  null
 end invoice_has_attachment
from
 ap_invoice_selection_criteria aisc,
 ap_check_stocks acs,
 ap_bank_accounts aba,
 ap_system_parameters asp,
 gl_sets_of_books gsob,
 gl_daily_conversion_types gdct,
 --
 (select
  asic.checkrun_name,
  sum(decode(asic.ok_to_pay_flag,'Y',asic.check_amount,'F',asic.check_amount,0)) payment_batch_total,
  sum(decode(asic.status_lookup_code, 'UNCONFIRMED SET UP',1,0)) setup_document_count,
  sum(decode(asic.dont_pay_reason_code,'OVERFLOW',0,'',0,1)) non_payment_document_count,
  sum(decode(asic.dont_pay_reason_code,'OVERFLOW',1,0)) overflow_documnent_count,
  sum(decode(asic.status_lookup_code, '',decode(asic.dont_pay_reason_code,'',1,0), 0)) negotiable_document_count
  from
  ap_selected_invoice_checks asic
  group by
  asic.checkrun_name
 ) q_check_totals,
 --
 ap_selected_invoice_checks asic,
 ap_bank_accounts aba2,
 --
 ap_selected_invoices asi,
 ap_invoices ai,
 fnd_document_sequences fds
where
 1=1 and
 aisc.status not in ('QUICKCHECK','CONFIRMED','CANCELED') and
 acs.check_stock_id = aisc.check_stock_id and
 aba.bank_account_id = acs.bank_account_id and
 asp.set_of_books_id = gsob.set_of_books_id and
 gdct.conversion_type(+) = aisc.exchange_rate_type and
 --
 aisc.checkrun_name = q_check_totals.checkrun_name (+) and
 --
 aisc.checkrun_name = asic.checkrun_name (+) and
 nvl(asic.status_lookup_code (+),'dummy') != 'UNCONFIRMED SET UP' and
 asic.external_bank_account_id = aba2.bank_account_id (+) and
 --
 asic.selected_check_id = asi.pay_selected_check_id (+) and
 asi.invoice_id = ai.invoice_id(+) and
 ai.doc_sequence_id = fds.doc_sequence_id(+)
 order by
 gsob.name,
 aisc.check_date,
 aisc.checkrun_name,
 asic.selected_check_id,
 asi.dont_pay_description,
 asi.sequence_num,
 asi.invoice_num,
 asi.payment_num,
 asi.invoice_date