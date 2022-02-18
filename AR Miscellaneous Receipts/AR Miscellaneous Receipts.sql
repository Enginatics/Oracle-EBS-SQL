/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Miscellaneous Receipts
-- Description: Receivables Miscellaneous Receipts
Imported from Concurrent Program
Application: Receivables
Source: Miscellaneous Receipts Register
Short Name: ARRXMTRG
-- Excel Examle Output: https://www.enginatics.com/example/ar-miscellaneous-receipts/
-- Library Link: https://www.enginatics.com/reports/ar-miscellaneous-receipts/
-- Run Report: https://demo.enginatics.com/

select misc_receipts.*
from
(
select
 gl.name                               ledger,
 haou.name                             operating_unit,
 decode(nvl(aba1.batch_source_id,-1)
       ,-1, null
          ,absa.name
       )                               batch_source,
 decode(acrha2.status
       , 'REVERSED', aba1.name
                   , aba1.name)
                                       batch_name,
 acra.receipt_number,
 acrha1.gl_date,
 acra.receipt_date,
 acra.deposit_date,
 acra.anticipated_clearing_date,
 acra.currency_code                    currency,
 case amcda.misc_cash_distribution_id
 when min(amcda.misc_cash_distribution_id) over (partition by acra.cash_receipt_id)
 then decode(acrha2.status,'REVERSED',acrha2.amount*-1,acrha2.amount)
 end                                   amount,
 case amcda.misc_cash_distribution_id
 when min(amcda.misc_cash_distribution_id) over (partition by acra.cash_receipt_id)
 then decode(acrha2.status,'REVERSED',acrha2.acctd_amount*-1,acrha2.acctd_amount)
 end                                   accounted_amount,
 case amcda.misc_cash_distribution_id
 when min(amcda.misc_cash_distribution_id) over (partition by acra.cash_receipt_id)
 then decode(acrha2.status,'REVERSED',acrha2.factor_discount_amount*-1,acrha2.factor_discount_amount)
 end                                   discount_amount,
 case amcda.misc_cash_distribution_id
 when min(amcda.misc_cash_distribution_id) over (partition by acra.cash_receipt_id)
 then decode(acrha2.status,'REVERSED',acrha2.acctd_factor_discount_amount*-1,acrha2.acctd_factor_discount_amount)
 end                                   accounted_discount_amount,
 --gcck1.concatenated_segments           accounting_flexfield,
 &l_dist_select
 acra.exchange_rate,
 acra.exchange_date,
 acra.exchange_rate_type               exchange_type,
 xxen_util.meaning('CASH','PAYMENT_CATEGORY_TYPE',222)
                                       receipt_type,
 arm.name                              receipt_method,
 acra.misc_payment_source              payment_source,
 arta.name                             activity,
 adsa.distribution_set_name            distribution_set,
 xxen_util.meaning('APP','CHECK_STATUS',222)
                                       state,
 xxen_util.meaning(acrha2.status,'RECEIPT_CREATION_STATUS',222)
                                       status,
 decode(ada.source_type
       ,'TAX', avta.tax_code
             , NULL)                   tax_code,
 fds.name                              document_sequence_name,
 acra.doc_sequence_value               document_sequence,
 xxen_util.meaning(acra.reference_type,'CB_REFERENCE_TYPE',222)
                                       reference_type,
 case
  when acra.reference_type='REMITTANCE' then (select ab.name from ar_batches_all ab where acra.reference_id=ab.batch_id)
  when acra.reference_type='RECEIPT' then (select acra.receipt_number from ar_cash_receipts_all acra0 where acra.reference_id=acra0.cash_receipt_id)
  when acra.reference_type='PAYMENT_BATCH' then (select aisca.checkrun_name from ap_inv_selection_criteria_all aisca where acra.reference_id=aisca.checkrun_id)
  when acra.reference_type='PAYMENT' then (select to_char(aca.check_number) from ap_checks_all aca where acra.reference_id=aca.check_id)
  when acra.reference_type='CREDIT_MEMO' then (select rcta.trx_number from ra_customer_trx_all rcta where acra.reference_id=rcta.customer_trx_id)
 end                                   reference_number,
 acra.customer_receipt_reference       customer_receipt_reference,
 substrb(hp.party_name,1,240)          customer_name,
 decode(hp.party_type
       ,'ORGANIZATION',hp.organization_name_phonetic
                       , null
       )                               customer_name_alt,
 hca.account_number                    customer_number,
 hcsua.location                        customer_location,
 hz_format_pub.format_address (hps.location_id,null,null,' , ')
                                       customer_address,
 hp.jgzz_fiscal_code                   customer_tax_number,
 ifpct.payment_channel_name            payment_method,
 hp2.party_name                        bank_name,
 hp3.party_name                        bank_branch,
 decode(ipiua.instrument_type
       ,'BANKACCOUNT',ieba.masked_bank_account_num
       ,'CREDITCARD',ic.masked_cc_number
       )                               instrument_number,
 nvl(ifte.payment_system_order_number
    ,nvl2(ifte.trxn_extension_id
         ,substr(iby_fndcpt_trxn_pub.get_tangible_id(fa.application_short_name,ifte.order_id,ifte.trxn_ref_number1,ifte.trxn_ref_number2),1,80)
         ,null))                       pson,
 cbbv.bank_name                        remit_bank_name,
 cbbv.bank_branch_name                 remit_bank_branch_name,
 cbbv.bank_name_alt                    remit_bank_name_alt,
 cbbv.bank_branch_name_alt             remit_bank_branch_name_alt,
 cbbv.bank_number                      remit_bank_number,
 cbbv.branch_number                    remit_bank_branch_number,
 cba.bank_account_name                 remit_bank_account_name,
 cba.bank_account_name_alt             remit_bank_account_name_alt,
 case
  when cba.bank_account_id is not null
  then ce_bank_and_account_util.get_masked_bank_acct_num(cba.bank_account_id)
  end                                  remit_bank_account_number,
 cba.currency_code                     remit_bank_account_currency,
 acra.comments                         receipt_comments
 &l_gcck2_segments
from
 hr_all_organization_units      haou,
 gl_ledgers                     gl,
 ar_cash_receipts_all           acra,
 ar_cash_receipt_history_all    acrha1,
 ar_cash_receipt_history_all    acrha2,
 ar_batches_all                 aba1,
 ar_batches_all                 aba2,
 ar_batch_sources_all           absa,
 ar_receipt_methods             arm,
 ar_distribution_sets_all	      adsa,
 ar_receivables_trx_all	        arta,
 -- distribution info
 ar_misc_cash_distributions_all amcda,
 ar_distributions_all           ada,
 gl_code_combinations_kfv       gcck1,
 gl_code_combinations_kfv       gcck2,
 -- customer info
 hz_cust_accounts               hca,
 hz_parties                     hp,
 hz_cust_site_uses_all          hcsua,
 hz_cust_acct_sites_all         hcasa,
 hz_party_sites                 hps,
 -- remit bank info
 ce_bank_accounts               cba,
 ce_bank_acct_uses_all          cbaua,
 ce_bank_branches_v             cbbv,
 ar_vat_tax_all                 avta,
 fnd_document_sequences         fds,
 -- payment info
 iby_fndcpt_pmt_chnnls_tl       ifpct,
 iby_fndcpt_tx_extensions       ifte,
 fnd_application                fa,
 iby_pmt_instr_uses_all         ipiua,
 iby_ext_bank_accounts          ieba,
 iby_creditcard                 ic,
 hz_parties                     hp2,
 hz_parties                     hp3
where
     acra.type                           = 'MISC'
 and acra.org_id                         = haou.organization_id
 and acra.set_of_books_id                = gl.ledger_id
 and acra.cash_receipt_id                = acrha1.cash_receipt_id
 and acrha1.first_posted_record_flag     = 'Y'
 and acrha1.batch_id                     = aba1.batch_id(+)
 and nvl(aba1.batch_source_id,-1)        = absa.batch_source_id(+)
 and nvl(aba1.org_id, -1)                = absa.org_id(+)
 and acra.cash_receipt_id                = acrha2.cash_receipt_id
 and acrha2.batch_id                     = aba2.batch_id(+)
 and (   (    acrha2.current_record_flag = 'Y'
          and acrha2.status              = 'REVERSED'
         )
      or (acrha2.cash_receipt_history_id in
           (select
             nvl(acrha4.cash_receipt_history_id, acrha3.cash_receipt_history_id)
            from
             ar_cash_receipt_history_all acrha3,
             ar_cash_receipt_history_all acrha4
            where
                 acrha3.cash_receipt_id = acrha2.cash_receipt_id
             and acrha3.first_posted_record_flag = 'Y'
             and acrha4.cash_receipt_id(+) = acrha3.cash_receipt_id
             and acrha4.current_record_flag(+) = 'Y'
             and acrha4.status(+) <> 'REVERSED'
             and acrha3.status <> 'REVERSED'
             and 2=2
           )
         )
    )
 and acrha2.account_code_combination_id  = gcck1.code_combination_id (+)
 and acra.receipt_method_id              = arm.receipt_method_id
 and acra.receivables_trx_id             = arta.receivables_trx_id (+)
 and acra.org_id                         = arta.org_id (+)
 and acra.distribution_set_id            = adsa.distribution_set_id (+)
 and acra.doc_sequence_id                = fds.doc_sequence_id(+)
 and acra.vat_tax_id                     = avta.vat_tax_id(+)
 -- distribution info
 and amcda.cash_receipt_id               = acra.cash_receipt_id
 and amcda.misc_cash_distribution_id     = ada.source_id(+)
 and ada.source_table(+)                 = 'MCD'
 and ada.code_combination_id             = gcck2.code_combination_id
 -- remit bank info
 and acra.remit_bank_acct_use_id         = cbaua.bank_acct_use_id
 and cbaua.bank_account_id               = cba.bank_account_id
 and cba.bank_branch_id                  = cbbv.branch_party_id
 -- customer info
 and acra.pay_from_customer              = hca.cust_account_id(+)
 and hca.party_id                        = hp.party_id(+)
 and acra.customer_site_use_id           = hcsua.site_use_id (+)
 and hcsua.cust_acct_site_id             = hcasa.cust_acct_site_id (+)
 and hcasa.party_site_id                 = hps.party_site_id (+)
 --  customer payment info
 and acra.payment_trxn_extension_id      = ifte.trxn_extension_id (+)
 and ifte.origin_application_id          = fa.application_id(+)
 and ifte.instr_assignment_id            = ipiua.instrument_payment_use_id(+)
 and decode(ipiua.instrument_type
           ,'BANKACCOUNT',ipiua.instrument_id)
                                         = ieba.ext_bank_account_id(+)
 and decode(ipiua.instrument_type
           ,'CREDITCARD',ipiua.instrument_id)
                                         = ic.instrid(+)
 and ieba.bank_id                        = hp2.party_id(+)
 and ieba.branch_id                      = hp3.party_id(+)
 and arm.payment_channel_code            = ifpct.payment_channel_code(+)
 and ifpct.language (+)                  = userenv('lang')
 --
 and :reporting_level in (1000,3000)
 and :reporting_context is not null
 and :p_coa is not null
 and 1=1
order by
 acrha1.gl_date
,acra.receipt_date
,acra.receipt_number
,acra.cash_receipt_id
,amcda.misc_cash_distribution_id
) misc_receipts
where
  3=3