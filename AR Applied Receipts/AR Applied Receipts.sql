/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Applied Receipts
-- Description: Application: Receivables
Description: Receivables Applied Receipts Register

Provided Templates:
Default: Detail - Detail Listing with no Pivot Summarization
Pivot: Summary by Apply Date - Summary by Balancing Segment, Receipt Currency, Apply Date
Pivot: Summary by Batch - Summary by Balancing Segment, Receipt Currency, Batch
Pivot: Summary by Customer Name - Summary by Balancing Segment, Receipt Currency, Customer with drilldown to details
Pivot: Summary by Debit Account - Summary by Balancing Segment, Account Segment, Debit Account, Receipt Currency
Pivot: Summary by GL Date - Summary by Balancing Segment, Receipt Currency, GL Date

Source: Applied Receipts Register
Short Name: RXARARRG
-- Excel Examle Output: https://www.enginatics.com/example/ar-applied-receipts/
-- Library Link: https://www.enginatics.com/reports/ar-applied-receipts/
-- Run Report: https://demo.enginatics.com/

select
 gl.name  ledger,
 gl.currency_code ledger_currency,
 haou.name  operating_unit,
 hp.party_name customer_name,
 hca.account_number customer_number,
 decode(hp.party_type, 'ORGANIZATION',hp.organization_name_phonetic, null) customer_name_alt,
 -- Receipt Main Details
 decode(acrha.status, 'REVERSED', aba1.name, aba1.name) batch_name,
 absa.name batch_source,
 acra.receipt_number,
 acra.receipt_date, 
 xxen_util.meaning(acra.type,'PAYMENT_CATEGORY_TYPE',222) receipt_type,
 arm.name receipt_method,
 case when acra.status in ('REV', 'NSF', 'STOP') and acrha.status <> 'REVERSED'
 then case :p_mrc_flag
      when 'R'
      then (select
             case
             when sum(decode(araa2.status,'UNID',araa2.amount_applied,0)) != 0
             then xxen_util.meaning('UNID','CHECK_STATUS',222)
             when sum(decode(status,'UNAPP',amount_applied,0)) != 0
             then xxen_util.meaning('UNAPP','CHECK_STATUS',222)
             else xxen_util.meaning('APP','CHECK_STATUS',222)
             end
            from
              ar_receivable_apps_all_mrc_v araa2
            where
              cash_receipt_id = acra.cash_receipt_id
           )
      else (select
             case
             when sum(decode(araa2.status,'UNID',araa2.amount_applied,0)) != 0
             then xxen_util.meaning('UNID','CHECK_STATUS',222)
             when sum(decode(status,'UNAPP',amount_applied,0)) != 0
             then xxen_util.meaning('UNAPP','CHECK_STATUS',222)
             else xxen_util.meaning('APP','CHECK_STATUS',222)
             end
            from
              ar_receivable_applications_all araa2
            where
              cash_receipt_id = acra.cash_receipt_id
           )
      end
 else xxen_util.meaning(acra.status,'CHECK_STATUS',222)
 end  receipt_status,
 xxen_util.meaning(acrha.status,'RECEIPT_CREATION_STATUS',222) receipt_history_status, 
 acra.currency_code receipt_currency,
 decode(acrha.status,'REVERSED',acrha.amount*-1,acrha.amount) + decode(acrha.status,'REVERSED',acrha.factor_discount_amount*-1,acrha.factor_discount_amount) receipt_amount,
 decode(acrha.status,'REVERSED',acrha.factor_discount_amount*-1,acrha.factor_discount_amount) factor_discount_amount,
 decode(acrha.status,'REVERSED',acrha.acctd_amount*-1,acrha.acctd_amount) + decode(acrha.status,'REVERSED',acrha.acctd_factor_discount_amount*-1,acrha.acctd_factor_discount_amount) acctd_receipt_amount,
 decode(acrha.status,'REVERSED',acrha.acctd_factor_discount_amount*-1,acrha.acctd_factor_discount_amount) acctd_factor_discount_amount,
 -- Applied To Trx Details
 case when aspa.show_billing_number_flag = 'Y'
 then decode(araa.status, 'ACC', xxen_util.meaning('ACC','PAYMENT_TYPE',222) , decode(acia.cons_billing_number, null, apsa.trx_number , substrb(rtrim(acia.cons_billing_number)||'/'||rtrim(to_char(rcta.trx_number)),1,30)))
 else decode(araa.status, 'ACC', xxen_util.meaning('ACC','PAYMENT_TYPE',222) , apsa.trx_number)
 end applied_to_trx_number,
 rcta.trx_date,
 rcta.invoice_currency_code trx_currency,
 nvl(rctlgda.amount,0) trx_amount,
 nvl(rctlgda.acctd_amount,0) acctd_trx_amount,
 hca2.account_number related_customer_number,  
 -- Application Details
 araa.apply_date,
 araa.gl_date apply_gl_date,
 nvl(araa.amount_applied_from,araa.amount_applied) amount_applied_from_receipt,
 nvl(araa.amount_applied,0) amount_applied_to_trx,
 nvl(araa.earned_discount_taken,0) earned_discount_taken,
 nvl(araa.unearned_discount_taken,0) unearned_discount_taken,
 nvl(araa.acctd_amount_applied_from,0) acctd_amt_applied_from_receipt,
 nvl(araa.acctd_amount_applied_to + araa.acctd_earned_discount_taken + araa.acctd_unearned_discount_taken,0) acctd_amt_applied_to_trx, 
 nvl(araa.acctd_earned_discount_taken,0) acctd_earned_discount_taken,
 nvl(araa.acctd_unearned_discount_taken,0) acctd_unearned_discount_taken,
 nvl(araa.acctd_amount_applied_from - araa.acctd_amount_applied_to,0) receipt_gain_loss, 
 -- Additional Receipt Infor
 fds.name  doc_sequence_name,
 acra.doc_sequence_value,
 acra.deposit_date,
 acra.anticipated_clearing_date,
 acra.misc_payment_source,
 xxen_util.meaning(acra.reference_type,'CB_REFERENCE_TYPE',222) reference_type,
 avta.tax_code,
 acra.exchange_rate,
 acra.exchange_date,
 acra.exchange_rate_type,
 cbbv.bank_name,
 cbbv.bank_name_alt,
 cbbv.bank_number,
 cbbv.bank_branch_name,
 cbbv.bank_branch_name_alt,
 cbbv.branch_number,
 cba.bank_account_name,
 cba.bank_account_name_alt,
 cba.bank_account_num bank_account_number,
 cba.currency_code bank_account_currency,
 -- Debit GL Account Info
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'ALL', 'Y', 'VALUE') debit_account,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') debit_account_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') balancing_segment,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') balancing_segment_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') account_segment,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') account_segment_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'ALL', 'Y', 'VALUE') || ' - ' ||
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') debit_account_pivot_label,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') || ' - ' ||
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') bal_seg_pivot_label,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') || ' - ' ||
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') account_pivot_label,
 hp.party_name || ' - ' || hca.account_number cust_name_pivot_label,
 hca.account_number || ' - ' || hp.party_name cust_number_pivot_label
from
&lp_table_list
where
 acra.org_id = haou.organization_id and
 acra.set_of_books_id = gl.ledger_id and
 acra.cash_receipt_id = acrha1.cash_receipt_id and
 acra.org_id = acrha1.org_id and
 acrha1.first_posted_record_flag = 'Y' and
 acrha1.batch_id = aba1.batch_id(+) and
 acrha1.org_id = aba1.org_id(+) and
 acrha.batch_id = aba.batch_id(+) and
 acrha.org_id = aba.org_id(+) and
 acra.doc_sequence_id = fds.doc_sequence_id(+) and
 acra.vat_tax_id = avta.vat_tax_id(+) and
 acra.org_id = avta.org_id(+) and
 acra.remit_bank_acct_use_id = cbaua.bank_acct_use_id and
 acra.org_id = cbaua.org_id and
 cba.bank_branch_id = cbbv.branch_party_id and
 cbaua.bank_account_id = cba.bank_account_id and
 acra.receipt_method_id = arm.receipt_method_id and
 acra.cash_receipt_id = acrha.cash_receipt_id and
 acra.org_id = acrha.org_id and
 gcc.code_combination_id = acrha.account_code_combination_id and
 acra.pay_from_customer = hca.cust_account_id(+) and
 hca.party_id = hp.party_id(+) and
 araa.cash_receipt_id = acra.cash_receipt_id and
 araa.org_id = acra.org_id and
 ( araa.status = 'APP' or (araa.status = 'ACTIVITY' and araa.receivables_trx_id = -16)) and
 araa.applied_customer_trx_id = rcta.customer_trx_id(+) and
 araa.org_id = rcta.org_id(+) and
 araa.applied_customer_trx_id = rctlgda.customer_trx_id(+) and
 araa.org_id = rctlgda.org_id(+) and
 nvl(aba.batch_source_id,-1) = absa.batch_source_id(+) and
 nvl(aba.org_id,-1) = absa.org_id(+) and
 araa.applied_payment_schedule_id = apsa.payment_schedule_id(+) and
 araa.org_id = apsa.org_id(+) and
 apsa.customer_id = hca2.cust_account_id(+) and
 rctlgda.latest_rec_flag(+) = 'Y' and
 araa.code_combination_id = gcc2.code_combination_id and
 acrha.first_posted_record_flag = 'Y' and
 apsa.cons_inv_id = acia.cons_inv_id(+) and
 apsa.org_id = acia.org_id(+) and
 aspa.org_id = araa.org_id and
 :reporting_level in (1000,3000) and
 :reporting_context is not null and
 :p_coa is not null and
 :p_mrc_flag = :p_mrc_flag and
 1=1
order by
 gl.name,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', :p_coa, NULL, gcc2.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
 haou.name,
 acra.currency_code,
 araa.apply_date,
 acra.receipt_number,
 case when aspa.show_billing_number_flag = 'Y'
 then decode(araa.status, 'ACC', xxen_util.meaning('ACC','PAYMENT_TYPE',222) , decode(acia.cons_billing_number, null, apsa.trx_number , substrb(rtrim(acia.cons_billing_number)||'/'||rtrim(to_char(rcta.trx_number)),1,30)))
 else decode(araa.status, 'ACC', xxen_util.meaning('ACC','PAYMENT_TYPE',222) , apsa.trx_number)
 end