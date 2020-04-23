/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Miscellaneous Receipts
-- Description: Receivables miscellaneous receipts
-- Excel Examle Output: https://www.enginatics.com/example/ar-miscellaneous-receipts
-- Library Link: https://www.enginatics.com/reports/ar-miscellaneous-receipts
-- Run Report: https://demo.enginatics.com/


select
haou.name ou,
arm.name receipt_method,
acra.receipt_number,
acra.receipt_date,
acrha1.gl_date,
acra.currency_code currency,
acra.amount,
acrha2.acctd_amount functional_amount,
flv2.meaning state,
flv1.meaning reference_type,
case
when acra.reference_type='REMITTANCE' then (select ab.name from ar_batches ab where acra.reference_id=ab.batch_id)
when acra.reference_type='RECEIPT' then (select acra.receipt_number from ar_cash_receipts_all acra0 where acra.reference_id=acra0.cash_receipt_id)
when acra.reference_type='PAYMENT_BATCH' then (select aisca.checkrun_name from ap_inv_selection_criteria_all aisca where acra.reference_id=aisca.checkrun_id)
when acra.reference_type='PAYMENT' then (select to_char(aca.check_number) from ap_checks_all aca where acra.reference_id=aca.check_id)
when acra.reference_type='CREDIT_MEMO' then (select rcta.trx_number from ra_customer_trx_all rcta where acra.reference_id=rcta.customer_trx_id)
end reference_number,
hca.account_number,
hp.party_name,
hcsua.location location,
hz_format_pub.format_address (hps.location_id,null,null,' , ') address,
hp.jgzz_fiscal_code taxpayer_id,
acra.misc_payment_source paid_by,
arta.name activity,
adsa.distribution_set_name distribution_set,
acra.customer_receipt_reference reference,
acra.comments,
ifpct.payment_channel_name payment_method,
decode(ipiua.instrument_type,'BANKACCOUNT',ieba.masked_bank_account_num,'CREDITCARD',ic.masked_cc_number) instrument_number,
nvl(ifte.payment_system_order_number,nvl2(ifte.trxn_extension_id,substr(iby_fndcpt_trxn_pub.get_tangible_id(fa.application_short_name,ifte.order_id,ifte.trxn_ref_number1,ifte.trxn_ref_number2),1,80),null)) pson,
hp2.party_name bank_name,
hp3.party_name bank_branch,
hop.organization_name remit_bank_name,
hp4.party_name remit_bank_branch,
case when cba.bank_account_id is not null then ce_bank_and_account_util.get_masked_bank_acct_num(cba.bank_account_id) end remit_bank_account
from
ar_cash_receipts_all acra,
hr_all_organization_units haou,
ar_cash_receipt_history_all acrha1,
ar_cash_receipt_history_all acrha2,
fnd_lookup_values flv1,
fnd_lookup_values flv2,
ar_receipt_methods arm,
iby_fndcpt_pmt_chnnls_tl ifpct,
iby_fndcpt_tx_extensions ifte,
fnd_application fa,
iby_pmt_instr_uses_all ipiua,
iby_ext_bank_accounts ieba,
hz_parties hp2,
hz_parties hp3,
iby_creditcard ic,
ar_receivables_trx_all arta,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
ce_bank_acct_uses_all cbaua,
ce_bank_accounts cba,
hz_parties hp4,
hz_relationships hr,
(select hop.* from hz_organization_profiles hop where sysdate between hop.effective_start_date and nvl(hop.effective_end_date,sysdate)) hop,
ar_distribution_sets_all adsa
where
1=1 and
acra.type='MISC' and
acra.org_id=haou.organization_id and
acra.receipt_method_id=arm.receipt_method_id(+) and
arm.payment_channel_code=ifpct.payment_channel_code(+) and
ifpct.language(+)=userenv('lang') and
acra.payment_trxn_extension_id=ifte.trxn_extension_id(+) and
ifte.origin_application_id=fa.application_id(+) and
ifte.instr_assignment_id=ipiua.instrument_payment_use_id(+) and
decode(ipiua.instrument_type,'BANKACCOUNT',ipiua.instrument_id)=ieba.ext_bank_account_id(+) and
ieba.bank_id=hp2.party_id(+) and
ieba.branch_id=hp3.party_id(+) and
decode(ipiua.instrument_type,'CREDITCARD',ipiua.instrument_id)=ic.instrid(+) and
acra.cash_receipt_id=acrha1.cash_receipt_id(+) and
acra.cash_receipt_id=acrha2.cash_receipt_id(+) and
acrha1.first_posted_record_flag(+)='Y' and
acrha2.current_record_flag(+)='Y' and
acra.reference_type=flv1.lookup_code(+) and
acrha2.status=flv2.lookup_code(+) and
flv1.lookup_type(+)='CB_REFERENCE_TYPE' and
flv2.lookup_type(+)='RECEIPT_CREATION_STATUS' and
flv1.view_application_id(+)=222 and
flv2.view_application_id(+)=222 and
flv1.language(+)=userenv('lang') and
flv2.language(+)=userenv('lang') and
flv1.security_group_id(+)=0 and
flv2.security_group_id(+)=0 and
acra.receivables_trx_id=arta.receivables_trx_id(+) and
acra.org_id=arta.org_id(+) and
acra.pay_from_customer=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
acra.customer_site_use_id=hcsua.site_use_id(+) and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id(+) and
hcasa.party_site_id=hps.party_site_id(+) and
acra.remit_bank_acct_use_id=cbaua.bank_acct_use_id(+) and
cbaua.bank_account_id=cba.bank_account_id(+) and
cba.bank_branch_id=hp4.party_id(+) and
hp4.party_id=hr.subject_id(+) and
hr.relationship_type(+)='BANK_AND_BRANCH' and
hr.relationship_code(+)='BRANCH_OF' and
hr.status(+)='A' and
hr.subject_table_name(+)='HZ_PARTIES' and
hr.subject_type(+)='ORGANIZATION' and
hr.object_table_name(+)='HZ_PARTIES' and
hr.object_type(+)='ORGANIZATION' and
hr.object_id=hop.party_id(+) and
acra.distribution_set_id=adsa.distribution_set_id(+)
order by
haou.name,
acra.receipt_date desc,
acra.receipt_number desc