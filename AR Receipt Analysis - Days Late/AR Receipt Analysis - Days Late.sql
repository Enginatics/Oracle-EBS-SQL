/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Receipt Analysis - Days Late
-- Description: Receipt applications against all transactions except credit memos, with the days between the installment due date and the application date. Converted from the Oracle report Receipt Analysis - Days Late.
-- One row per receipt application. Days Late is the apply date minus the due date and is negative for an early payment. Weighted Days Late is Days Late multiplied by the amount applied, in the transaction currency.
-- Invoice Amount shows the installment's original amount on its first application row only, so the column sums to the Oracle report's currency totals.
-- Average Days Late and Weighted Average Days Late are calculated per operating unit, customer account and currency and repeated on every row of that group. The Oracle report prints 0 for a negative Average Days Late, and splits a customer's currency group when receipts in another currency are applied.
-- Excel Example Output: https://www.enginatics.com/example/ar-receipt-analysis-days-late/
-- Library Link: https://www.enginatics.com/reports/ar-receipt-analysis-days-late/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
hp.party_name customer_name,
hca.account_number customer_number,
hl.city,
hl.state,
ac.name collector,
apsa.trx_number invoice_number,
rctta.name transaction_type,
rtv.name payment_term,
apsa.terms_sequence_number installment,
apsa.due_date,
apsa.invoice_currency_code currency,
case when row_number() over (partition by apsa.payment_schedule_id order by araa.apply_date,acra.receipt_number,araa.receivable_application_id)=1 then apsa.amount_due_original end invoice_amount,
acra.receipt_number,
araa.apply_date,
araa.amount_applied,
xxen_util.yes(case when araa.amount_applied_from is not null then 'Y' end) cross_currency,
araa.apply_date-apsa.due_date days_late,
(araa.apply_date-apsa.due_date)*araa.amount_applied weighted_days_late,
round(avg(araa.apply_date-apsa.due_date) over (partition by apsa.org_id,apsa.customer_id,apsa.invoice_currency_code),2) average_days_late,
round(sum((araa.apply_date-apsa.due_date)*araa.amount_applied) over (partition by apsa.org_id,apsa.customer_id,apsa.invoice_currency_code)/nullif(sum(araa.amount_applied) over (partition by apsa.org_id,apsa.customer_id,apsa.invoice_currency_code),0),2) weighted_average_days_late
from
hr_all_organization_units_vl haouv,
ar_payment_schedules_all apsa,
ar_receivable_applications_all araa,
ar_cash_receipts_all acra,
ra_customer_trx_all rcta,
ra_cust_trx_types_all rctta,
ra_terms_vl rtv,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
hz_locations hl,
hz_customer_profiles hcp_acct,
hz_customer_profiles hcp_site,
ar_collectors ac
where
1=1 and
apsa.org_id in (select xroa.id from xxen_report_org_access xroa where xroa.access_type='OU') and
apsa.class<>'CM' and
haouv.organization_id=apsa.org_id and
apsa.payment_schedule_id=araa.applied_payment_schedule_id and
araa.status='APP' and
araa.display='Y' and
nvl(araa.confirmed_flag,'Y')='Y' and
araa.cash_receipt_id=acra.cash_receipt_id and
apsa.customer_trx_id=rcta.customer_trx_id(+) and
rcta.cust_trx_type_id=rctta.cust_trx_type_id(+) and
rcta.org_id=rctta.org_id(+) and
apsa.term_id=rtv.term_id(+) and
apsa.customer_id=hca.cust_account_id and
hca.party_id=hp.party_id and
apsa.customer_site_use_id=hcsua.site_use_id and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id and
hcasa.party_site_id=hps.party_site_id and
hps.location_id=hl.location_id and
hca.cust_account_id=hcp_acct.cust_account_id and
hcp_acct.site_use_id is null and
apsa.customer_site_use_id=hcp_site.site_use_id(+) and
nvl(hcp_site.collector_id,hcp_acct.collector_id)=ac.collector_id
order by
hp.party_name,
hca.account_number,
apsa.invoice_currency_code,
apsa.trx_number,
apsa.terms_sequence_number,
araa.apply_date,
acra.receipt_number
