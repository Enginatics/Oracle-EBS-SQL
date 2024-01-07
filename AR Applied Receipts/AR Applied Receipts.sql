/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
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
 x.*
from
(
select
 gl.name  ledger,
 gl.currency_code ledger_currency,
 haou.name  operating_unit,
 hp.party_name customer_name,
 hca.account_number customer_number,
 decode(hp.party_type, 'ORGANIZATION',hp.organization_name_phonetic, null) customer_name_alt,
 hcsua.location customer_location,
 hz_format_pub.format_address(hps.location_id,null,null,' , ') customer_address,
 ftv2.territory_short_name customer_country,
 hp.jgzz_fiscal_code customer_tax_number,
 nvl(ac2.name,ac.name) collector,
 ac.name collector_account,
 ac2.name collector_site,
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
 decode(acrha.status,'REVERSED',0,acrha.amount) + decode(acrha.status,'REVERSED',0,nvl(acrha.factor_discount_amount,0)) receipt_amount,
 decode(acrha.status,'REVERSED',0,acrha.factor_discount_amount) factor_discount_amount,
 decode(acrha.status,'REVERSED',0,acrha.acctd_amount) + decode(acrha.status,'REVERSED',0,nvl(acrha.acctd_factor_discount_amount,0)) acctd_receipt_amount,
 decode(acrha.status,'REVERSED',0,acrha.acctd_factor_discount_amount) acctd_factor_discount_amount,
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
 acra.application_notes,
 cbbv.bank_name,
 cbbv.bank_name_alt,
 cbbv.bank_number,
 cbbv.bank_branch_name,
 cbbv.bank_branch_name_alt,
 cbbv.branch_number,
 cba.bank_account_name,
 cba.bank_account_name_alt,
 cba.masked_account_num bank_account_number,
 cba.currency_code bank_account_currency,
 cba.description bank_account_description,
 -- Debit GL Account Info
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'ALL', 'Y', 'VALUE') debit_account,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') debit_account_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') balancing_segment,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') balancing_segment_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') account_segment,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') account_segment_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'ALL', 'Y', 'VALUE') || ' - ' ||
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') debit_account_pivot_label,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') || ' - ' ||
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') bal_seg_pivot_label,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') || ' - ' ||
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_seg', 'SQLGL', 'GL#', gcc2.chart_of_accounts_id, NULL, gcc2.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') account_pivot_label,
 hp.party_name || ' - ' || hca.account_number cust_name_pivot_label,
 hca.account_number || ' - ' || hp.party_name cust_number_pivot_label,
 decode(:reporting_level,1000,gl.name,3000,haou.name,null) reporting_entity
from
&lp_table_list
where
 acra.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
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
 acra.customer_site_use_id=hcsua.site_use_id(+) and
 hcsua.cust_acct_site_id=hcasa.cust_acct_site_id(+) and
 hcasa.party_site_id=hps.party_site_id(+) and
 hps.location_id=hl.location_id(+) and
 hl.country=ftv2.territory_code(+) and
 acra.pay_from_customer=hcp.cust_account_id(+) and
 nvl(hcp.site_use_id(+),-999)=-999 and
 hcp.collector_id=ac.collector_id(+) and
 acra.pay_from_customer=hcp2.cust_account_id(+) and
 acra.customer_site_use_id=hcp2.site_use_id(+) and
 hcp2.collector_id=ac2.collector_id(+) and
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
 apsa.cons_inv_id = acia.cons_inv_id(+) and
 apsa.org_id = acia.org_id(+) and
 aspa.org_id = araa.org_id and
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
 x.apply_date,
 x.receipt_number,
 x.applied_to_trx_number