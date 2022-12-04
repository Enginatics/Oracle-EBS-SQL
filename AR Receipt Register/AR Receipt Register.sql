/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Receipt Register
-- Description: Application: Receivables
Description: Receivables Receipt Register

Provided Templates:
Default: Detail - Detail Listing with no Pivot Summarization
Pivot: Summary by Receipt Date - Summary by Balancing Segment, Receipt Currency, Receipt Date
Pivot: Summary by Receipt Status - Summary by Balancing Segment, Receipt Status
Pivot: Summary by Batch - Summary by Balancing Segment, Receipt Currency, Batch
Pivot: Summary by Customer Name - Summary by Balancing Segment, Receipt Currency, Customer
Pivot: Summary by Debit Account - Summary by Balancing Segment, Account Segment, Debit Account, Receipt Currency
Pivot: Summary by GL Date - Summary by Balancing Segment, Receipt Currency, GL Date

Source: Receipt Register
Short Name: ARRXRCRG/RXARRCRG

-- Excel Examle Output: https://www.enginatics.com/example/ar-receipt-register/
-- Library Link: https://www.enginatics.com/reports/ar-receipt-register/
-- Run Report: https://demo.enginatics.com/

select
 x.*
from
(
select 
 gl.name  ledger,
 gl.currency_code ledger_currency,
 haou.name  operating_unit,
 substrb(hp.party_name,1,240) customer_name,
 hca.account_number customer_number,
 decode(hp.party_type, 'ORGANIZATION',hp.organization_name_phonetic, null) customer_name_alt,
  -- Receipt Main Details
 decode(acrha.status, 'REVERSED', aba2.name, aba2.name) batch_name,
 acra.receipt_number,
 acra.receipt_date,
 acrha.gl_date,
 xxen_util.meaning(acra.type,'PAYMENT_CATEGORY_TYPE',222) receipt_type,
 arm.name receipt_method,
 case when acra.status in ('REV', 'NSF', 'STOP') and acrha.status <> 'REVERSED'
 then case :p_mrc_flag
      when 'R'
      then (select
             case
             when sum(decode(araa2.status,'UNID',araa2.amount_applied,0)) != 0
             then xxen_util.meaning('UNID','CHECK_STATUS',222)
             when sum(decode(araa2.status,'UNAPP',araa2.amount_applied,0)) != 0
             then xxen_util.meaning('UNAPP','CHECK_STATUS',222)
             else xxen_util.meaning('APP','CHECK_STATUS',222)
             end
            from
              ar_receivable_apps_all_mrc_v araa2
            where
              araa2.cash_receipt_id = acra.cash_receipt_id
           )
      else (select
             case
             when sum(decode(araa2.status,'UNID',araa2.amount_applied,0)) != 0
             then xxen_util.meaning('UNID','CHECK_STATUS',222)
             when sum(decode(araa2.status,'UNAPP',araa2.amount_applied,0)) != 0
             then xxen_util.meaning('UNAPP','CHECK_STATUS',222)
             else xxen_util.meaning('APP','CHECK_STATUS',222)
             end
            from
              ar_receivable_applications_all araa2
            where
              araa2.cash_receipt_id = acra.cash_receipt_id
           )
      end
 else xxen_util.meaning(acra.status,'CHECK_STATUS',222)
 end  receipt_status,
 xxen_util.meaning(acrha.status,'RECEIPT_CREATION_STATUS',222) receipt_history_status, 
 acra.currency_code receipt_currency,
 decode(acrha.status,'REVERSED',
        decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, 0 , (nvl(acrha3.amount,0))* -1),
		decode(acrha3.cash_receipt_history_id, acrha.cash_receipt_history_id, (acrha.amount), (acrha.amount -(nvl(acrha3.amount,0))))
	   ) + 
 decode(acrha.status,'REVERSED',
        decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, 0, (nvl(acrha3.factor_discount_amount,0))* -1),
		decode(acrha3.cash_receipt_history_id ,acrha.cash_receipt_history_id, nvl(acrha.factor_discount_amount,0), (nvl(acrha.factor_discount_amount,0) -(nvl(acrha3.factor_discount_amount,0))))
	   ) receipt_amount,
 decode(acrha.status,'REVERSED', 
        decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, 0, (nvl(acrha3.factor_discount_amount,0))* -1),
		decode(acrha3.cash_receipt_history_id ,acrha.cash_receipt_history_id, nvl(acrha.factor_discount_amount,0), (nvl(acrha.factor_discount_amount,0) -(nvl(acrha3.factor_discount_amount,0))))
	   ) factor_discount_amount,
 decode(acrha.status,'REVERSED',
        decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, 0, (nvl(acrha3.acctd_amount,0))* -1),
		decode(acrha3.cash_receipt_history_id, acrha.cash_receipt_history_id, (acrha.acctd_amount) , (acrha.acctd_amount -(nvl(acrha3.acctd_amount,0))))
	   ) + 
 decode(acrha.status,'REVERSED',
        decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id,0, (nvl(acrha3.acctd_factor_discount_amount,0))* -1),
		decode(acrha3.cash_receipt_history_id ,acrha.cash_receipt_history_id, nvl(acrha.acctd_factor_discount_amount,0), (nvl(acrha.acctd_factor_discount_amount,0) -(nvl(acrha3.acctd_factor_discount_amount,0))))
	   ) acctd_receipt_amount,

 decode(acrha.status,'REVERSED', 
        decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id,0, (nvl(acrha3.acctd_factor_discount_amount,0))* -1),
		decode(acrha3.cash_receipt_history_id ,acrha.cash_receipt_history_id, nvl(acrha.acctd_factor_discount_amount,0), (nvl(acrha.acctd_factor_discount_amount,0) -(nvl(acrha3.acctd_factor_discount_amount,0))))
	   ) acctd_factor_discount_amount,
 -- Additional Receipt Infor
 fds.name doc_sequence_name,
 acra.doc_sequence_value doc_sequence_value, 
 acra.creation_date  receipt_creation_date,
 xxen_util.user_name(acra.created_by) receipt_created_by,
 acra.last_update_date receipt_last_updated_date,
 xxen_util.user_name(acra.last_updated_by) receipt_last_updated_by,
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
 cba.description bank_account_description, 
 -- Debit GL Account Info
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE') debit_account,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') debit_account_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') balancing_segment,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') balancing_segment_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') account_segment,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') account_segment_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE') || ' - ' ||
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') debit_account_pivot_label,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') || ' - ' ||
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') bal_seg_pivot_label,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') || ' - ' ||
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') account_pivot_label,
 hp.party_name || ' - ' || hca.account_number cust_name_pivot_label,
 hca.account_number || ' - ' || hp.party_name cust_number_pivot_label,
 decode(:reporting_level,1000,gl.name,3000,haou.name,null) reporting_entity,
 acra.cash_receipt_id 
from 
 &lp_table_list
where
 acra.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where not exists (select null from mo_glob_org_access_tmp mgoat)) and
 acra.org_id = haou.organization_id and
 acra.set_of_books_id = gl.ledger_id and
 acra.cash_receipt_id = acrha2.cash_receipt_id and
 acrha2.first_posted_record_flag = 'Y' and
 acrha2.batch_id = aba2.batch_id(+) and
 acrha.batch_id = aba1.batch_id(+) and
 acra.doc_sequence_id = fds.doc_sequence_id(+) and
 acra.vat_tax_id = avta.vat_tax_id(+) and
 acra.remit_bank_acct_use_id = cbaua.bank_acct_use_id and
 cba.bank_branch_id = cbbv.branch_party_id and
 cbaua.bank_account_id = cba.bank_account_id and
 acra.receipt_method_id = arm.receipt_method_id and
 acra.cash_receipt_id = acrha.cash_receipt_id and
 gcc.code_combination_id = acrha.account_code_combination_id and
 acra.pay_from_customer = hca.cust_account_id(+) and
 hca.party_id = hp.party_id(+) and
 acrha.cash_receipt_id = acrha3.cash_receipt_id and
 (decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, acrha.acctd_amount +1 , acrha3.acctd_amount) <> acrha.acctd_amount or 
  decode(acrha3.cash_receipt_history_id , acrha.cash_receipt_history_id, nvl( acrha.acctd_factor_discount_amount,0) + 1 ,nvl(acrha3.acctd_factor_discount_amount,0)) <> nvl( acrha.acctd_factor_discount_amount,0) or 
  acrha.status='REVERSED'
 ) and
 nvl(acra.confirmed_flag,'Y') = 'Y' and
 --
 :reporting_level in (1000,3000) and
 nvl(:p_coa,-1) = nvl(:p_coa,-1) and
 :p_mrc_flag = :p_mrc_flag and
 nvl(:p_gl_date_low_h,sysdate) = nvl(:p_gl_date_low_h,sysdate) and
 nvl(:p_gl_date_high_h,sysdate) = nvl(:p_gl_date_high_h,sysdate) and 
 1=1
 ) x
where
 2=2
order by
 x.ledger,
 x.balancing_segment,
 x.operating_unit,
 x.receipt_currency,
 x.receipt_number