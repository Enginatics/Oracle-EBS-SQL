/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Unapplied Receipts Register
-- Description: Application: Receivables
Source: Unapplied Receipts Register (Obsolete)
Short Name: ARXCOA2
-- Excel Examle Output: https://www.enginatics.com/example/ar-unapplied-receipts-register/
-- Library Link: https://www.enginatics.com/reports/ar-unapplied-receipts-register/
-- Run Report: https://demo.enginatics.com/

select
gcc.segment1 balancing_segment,
substrb(hp.party_name,1,50) customer_name,
hca.account_number customer_number,
max(decode(upper(:p_in_format_option),'DETAIL', araa.gl_date,null)) gl_date,
absa.name batch_source_name,
aba.name batch_name,
arm.name receipt_method,
acra.receipt_number,
acra.receipt_date,
sum(decode (araa.status,'ACC', decode (upper (:p_in_curr_code),null, araa.acctd_amount_applied_from,araa.amount_applied),'OTHER ACC',
decode(araa.applied_payment_schedule_id,-7, decode(upper (:p_in_curr_code),null, araa.acctd_amount_applied_from,araa.amount_applied),0),0)) on_account_amt,
sum(decode (araa.status,'UNAPP', decode (upper (:p_in_curr_code),null, araa.acctd_amount_applied_from,araa.amount_applied),'UNID',
decode (upper (:p_in_curr_code),null, araa.acctd_amount_applied_from,araa.amount_applied),0)) unapplied_amt,
sum(decode(araa.status,'OTHER ACC', decode(araa.applied_payment_schedule_id,-4, decode(upper(:p_in_curr_code),null, araa.acctd_amount_applied_from,araa.amount_applied),0),0)) claim_amt,
hou.name operating_unit
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
ar_batch_sources_all absa
where
1=1 and
gl.ledger_id=:p_ca_set_of_books_id and
gl.ledger_id=hou.set_of_books_id and
hou.organization_id=araa.org_id and
apsa.class='PMT' and
apsa.gl_date_closed=to_date ('31-12-4712', 'DD-MM-YYYY') and
apsa.cash_receipt_id=araa.cash_receipt_id and
araa.status in ('ACC', 'UNAPP', 'UNID', 'OTHER ACC') and
nvl(araa.confirmed_flag,'Y')='Y' and
araa.cash_receipt_id=acra.cash_receipt_id and
nvl(acra.confirmed_flag, 'Y')='Y' and
acra.pay_from_customer=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
acra.receipt_method_id=arm.receipt_method_id and
araa.code_combination_id=gcc.code_combination_id and
acra.cash_receipt_id=acrha.cash_receipt_id and
acrha.first_posted_record_flag='Y' and
acrha.batch_id=aba.batch_id(+) and
aba.batch_source_id=absa.batch_source_id(+)
group by
gcc.segment1,
hp.party_name,
hca.account_number,
absa.name,
aba.name,
arm.name,
acra.receipt_number,
acra.receipt_date,
nvl (hca.cust_account_id, 0),
decode (hca.cust_account_id, null, '*', null),
hou.name
having sum (decode (araa.status, 'ACC', araa.acctd_amount_applied_from, 0))!=0
or sum (decode (araa.status,
'UNAPP', araa.acctd_amount_applied_from,
'UNID', araa.acctd_amount_applied_from,
0
)
) != 0
or sum (decode (araa.status,
'OTHER ACC', araa.acctd_amount_applied_from,
0
)
) != 0
order by
hou.name,
1 asc,
3 asc,
4 asc,
gcc.segment1,
hp.party_name,
hca.account_number,
acra.receipt_number,
max (decode (upper (:p_in_format_option),
'SUMMARY', null,
araa.gl_date
)
),
absa.name,
aba.name,
arm.name,
acra.receipt_date,
nvl (hca.cust_account_id, 0),
decode (hca.cust_account_id, null, '*', null)