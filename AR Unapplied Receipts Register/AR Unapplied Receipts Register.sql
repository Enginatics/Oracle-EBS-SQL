/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Unapplied Receipts Register
-- Description: Detail unapplied receipts report with receipt number, date and amount
-- Excel Examle Output: https://www.enginatics.com/example/ar-unapplied-receipts-register/
-- Library Link: https://www.enginatics.com/reports/ar-unapplied-receipts-register/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.balancing_segment,
x.balancing_segment_desc,
x.account_segment,
x.account_segment_desc,
x.customer_name,
x.customer_number,
x.batch_source_name,
x.batch_name,
x.receipt_method,
x.receipt_number,
x.issue_date,
x.receipt_date,
x.receipt_gl_date,
x.receipt_creation_date,
x.receipt_created_by,
x.receipt_last_updated_date,
x.receipt_last_updated_by,
&apply_date_cols
x.receipt_currency,
x.currency,
x.on_account_amt,
x.unapplied_amt,
x.claim_amt,
&reval_cols
x.application_notes,
x.operating_unit,
x.bank_name,
x.bank_name_alt,
x.bank_number,
x.bank_branch_name,
x.bank_branch_name_alt,
x.branch_number,
x.bank_branch_country,
x.bank_account_name,
x.bank_account_name_alt,
x.bank_account_number,
x.bank_account_currency,
x.bank_account_description
&receipt_dff_cols
from
(
select
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') balancing_segment,
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') balancing_segment_desc,
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') account_segment,
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') account_segment_desc,
hp.party_name customer_name,
hca.account_number customer_number,
acra.receipt_number,
acra.issue_date,
acra.receipt_date,
apsa.gl_date receipt_gl_date,
nvl2(:p_as_of_date,to_date(null),araa.apply_date) applied_date,
nvl2(:p_as_of_date,to_date(null),araa.gl_date) applied_gl_date,
acra.creation_date  receipt_creation_date,
xxen_util.user_name(acra.created_by) receipt_created_by,
acra.last_update_date receipt_last_updated_date,
xxen_util.user_name(acra.last_updated_by) receipt_last_updated_by,
max(araa.apply_date) latest_applied_date,
max(araa.gl_date) latest_applied_gl_date,
absa.name batch_source_name,
aba.name batch_name,
arm.name receipt_method,
apsa.invoice_currency_code receipt_currency,
nvl(upper(:p_in_curr_code),gl.currency_code) currency,
sum(decode (araa.status,'ACC', decode (upper (:p_in_curr_code),null, araa.acctd_amount_applied_from,araa.amount_applied),'OTHER ACC',
decode(araa.applied_payment_schedule_id,-7, decode(upper (:p_in_curr_code),null, araa.acctd_amount_applied_from,araa.amount_applied),0),0)) on_account_amt,
sum(decode (araa.status,'UNAPP', decode (upper (:p_in_curr_code),null, araa.acctd_amount_applied_from,araa.amount_applied),'UNID',
decode (upper(:p_in_curr_code),null, araa.acctd_amount_applied_from,araa.amount_applied),0)) unapplied_amt,
sum(decode(araa.status,'OTHER ACC', decode(araa.applied_payment_schedule_id,-4, decode(upper(:p_in_curr_code),null, araa.acctd_amount_applied_from,araa.amount_applied),0),0)) claim_amt,
acra.application_notes,
gl.name ledger,
hou.name operating_unit,
max(decode(nvl(upper(:p_in_curr_code),gl.currency_code),:p_reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where nvl(upper(:p_in_curr_code),gl.currency_code)=gdr.from_currency and gdr.to_currency=:p_reval_currency and :p_reval_conv_date=gdr.conversion_date and gdct.user_conversion_type=:p_reval_conv_type and gdct.conversion_type=gdr.conversion_type))) reval_conv_rate,
acra.rowid row_id,
acra.attribute_category,
--
cbbv.bank_name,
cbbv.bank_name_alt,
cbbv.bank_number,
cbbv.bank_branch_name,
cbbv.bank_branch_name_alt,
cbbv.branch_number,
ftv.territory_short_name bank_branch_country,
cba.bank_account_name,
cba.bank_account_name_alt,
cba.bank_account_num bank_account_number,
cba.currency_code bank_account_currency,
cba.description bank_account_description
from
gl_ledgers gl,
hr_operating_units hou,
ar_payment_schedules_all apsa,
hz_cust_accounts hca,
hz_parties hp,
ar_receipt_methods arm,
gl_code_combinations gcc,
ar_receivable_applications_all araa,
ar_cash_receipts_all acra,
ar_cash_receipt_history_all acrha,
ar_batches_all aba,
ar_batch_sources_all absa,
ce_bank_accounts cba,
ce_bank_acct_uses_all cbaua,
ce_bank_branches_v cbbv,
fnd_territories_vl ftv
where
1=1 and
gl.ledger_id=hou.set_of_books_id and
hou.organization_id=araa.org_id and
hou.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where not exists (select null from mo_glob_org_access_tmp mgoat)) and
apsa.class='PMT' and
apsa.invoice_currency_code=nvl(upper(:p_in_curr_code),apsa.invoice_currency_code) and
apsa.gl_date_closed >= nvl(:p_as_of_date+1,to_date ('31-12-4712','DD-MM-YYYY')) and -- to_date ('31-12-4712','DD-MM-YYYY') and
apsa.cash_receipt_id=araa.cash_receipt_id and
apsa.payment_schedule_id=araa.payment_schedule_id and
araa.status in ('ACC','UNAPP','UNID','OTHER ACC') and
nvl(araa.confirmed_flag,'Y')='Y' and
araa.gl_date < nvl(:p_as_of_date+1,to_date ('31-12-4712','DD-MM-YYYY')) and
araa.cash_receipt_id=acra.cash_receipt_id and
nvl(acra.confirmed_flag,'Y')='Y' and
acra.pay_from_customer=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
acra.receipt_method_id=arm.receipt_method_id and
araa.code_combination_id=gcc.code_combination_id and
acra.cash_receipt_id=acrha.cash_receipt_id and
acrha.first_posted_record_flag='Y' and
acrha.batch_id=aba.batch_id(+) and
aba.batch_source_id=absa.batch_source_id(+) and
acra.remit_bank_acct_use_id = cbaua.bank_acct_use_id and
acra.org_id = cbaua.org_id and
cba.bank_branch_id = cbbv.branch_party_id and
cbaua.bank_account_id = cba.bank_account_id and
ftv.territory_code (+) = cbbv.country
group by
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION'),
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE'),
fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION'),
hp.party_name,
hca.account_number,
absa.name,
aba.name,
arm.name,
acra.receipt_number,
acra.issue_date,
acra.receipt_date,
apsa.gl_date,
acra.creation_date,
acra.created_by,
acra.last_update_date,
acra.last_updated_by,
nvl2(:p_as_of_date,to_date(null),araa.apply_date),
nvl2(:p_as_of_date,to_date(null),araa.gl_date),
apsa.invoice_currency_code,
acra.application_notes,
acra.rowid,
acra.attribute_category,
nvl(upper(:p_in_curr_code),gl.currency_code),
nvl(hca.cust_account_id,0),
decode (hca.cust_account_id,null,'*',null),
gl.name,
hou.name,
cbbv.bank_name,
cbbv.bank_name_alt,
cbbv.bank_number,
cbbv.bank_branch_name,
cbbv.bank_branch_name_alt,
cbbv.branch_number,
ftv.territory_short_name,
cba.bank_account_name,
cba.bank_account_name_alt,
cba.bank_account_num,
cba.currency_code,
cba.description
having
sum(decode(araa.status,'ACC',araa.acctd_amount_applied_from,0))!=0 or
sum(decode(araa.status,'UNAPP',araa.acctd_amount_applied_from,'UNID',araa.acctd_amount_applied_from,0))!=0 or
sum(decode(araa.status,'OTHER ACC',araa.acctd_amount_applied_from,0))!=0
) x
order by
x.operating_unit,
x.balancing_segment asc,
x.customer_number asc,
x.applied_gl_date,
x.receipt_gl_date,
x.receipt_number,
x.batch_source_name,
x.batch_name,
x.receipt_method,
x.receipt_date