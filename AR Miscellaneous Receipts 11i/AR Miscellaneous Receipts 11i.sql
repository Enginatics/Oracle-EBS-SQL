/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Miscellaneous Receipts 11i
-- Description: Receivables miscellaneous receipts
-- Excel Examle Output: https://www.enginatics.com/example/ar-miscellaneous-receipts-11i/
-- Library Link: https://www.enginatics.com/reports/ar-miscellaneous-receipts-11i/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
arm.name receipt_method,
acra.receipt_number,
acra.receipt_date,
acrha1.gl_date,
acra.currency_code currency,
acra.amount,
acrha2.acctd_amount functional_amount,
xxen_util.meaning(acrha2.status,'RECEIPT_CREATION_STATUS',222) state,
xxen_util.meaning(acra.reference_type,'CB_REFERENCE_TYPE',222) reference_type,
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
replace(initcap(arm.payment_type_code),'_',' ') payment_method,
abac.bank_account_num                           instrument_number,
acra.payment_server_order_num                   pson,
abbc.bank_name                                  bank_name,
abbc.bank_branch_name                           bank_branch,
abbr.bank_name                                  remit_bank_name,
abbr.bank_branch_name                           remit_bank_branch,
abar.bank_account_num                           remit_bank_account
from
ar_cash_receipts_all acra,
hr_all_organization_units_vl haouv,
ar_cash_receipt_history_all acrha1,
ar_cash_receipt_history_all acrha2,
ar_receipt_methods arm,
ap_bank_accounts_all  abac,
ap_bank_branches      abbc,
ar_receivables_trx_all arta,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
ap_bank_accounts_all  abar,
ap_bank_branches      abbr,
ar_distribution_sets_all adsa
where
1=1 and
acra.type='MISC' and
acra.org_id=haouv.organization_id and
acra.receipt_method_id=arm.receipt_method_id(+) and
acra.customer_bank_account_id = abac.bank_account_id (+) and
abac.bank_branch_id = abbc.bank_branch_id (+) and
acra.cash_receipt_id=acrha1.cash_receipt_id(+) and
acra.cash_receipt_id=acrha2.cash_receipt_id(+) and
acrha1.first_posted_record_flag(+)='Y' and
acrha2.current_record_flag(+)='Y' and
acra.receivables_trx_id=arta.receivables_trx_id(+) and
acra.org_id=arta.org_id(+) and
acra.pay_from_customer=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
acra.customer_site_use_id=hcsua.site_use_id(+) and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id(+) and
hcasa.party_site_id=hps.party_site_id(+) and
acra.remittance_bank_account_id = abar.bank_account_id (+) and
abar.bank_branch_id = abbr.bank_branch_id (+) and
acra.distribution_set_id=adsa.distribution_set_id(+)
order by
haouv.name,
acra.receipt_date desc,
acra.receipt_number desc