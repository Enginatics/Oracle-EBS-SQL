/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Credit Memo Application Upload
-- Description: Applies open on account credit memos to invoices and debit memos, and unapplies existing credit memo applications - the Applications action of the Transactions workbench (ar_cm_api_pub).

The download lists the operating unit's open credit memos (Apply To Invoice empty) and their existing active applications (one row per application). To apply, enter Apply To Invoice on an open credit memo row. To unapply, set Unapply to Yes on an application row.

An existing application cannot be changed in place: unapply it, then enter the new application on the credit memo's open row.
-- Excel Examle Output: https://www.enginatics.com/example/ar-credit-memo-application-upload/
-- Library Link: https://www.enginatics.com/reports/ar-credit-memo-application-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
haouv.name operating_unit,
rcta.trx_number cm_number,
rcta.trx_date cm_date,
rbsa.name cm_source,
hp.party_name bill_to_customer,
hca.account_number bill_to_account,
apsa.invoice_currency_code currency,
apsa.amount_due_remaining cm_balance,
to_char(null) apply_to_invoice,
to_number(null) installment,
to_number(null) amount_applied,
to_date(null) apply_date,
to_date(null) gl_date,
to_char(null) comments,
to_char(null) unapply,
to_date(null) reversal_gl_date,
rcta.customer_trx_id cm_customer_trx_id,
to_number(null) receivable_application_id,
null upload_row
from
ar_payment_schedules_all apsa,
ra_customer_trx_all rcta,
ra_batch_sources_all rbsa,
hz_cust_accounts hca,
hz_parties hp,
hr_all_organization_units_vl haouv
where
1=1 and
apsa.class='CM' and
apsa.status='OP' and
apsa.amount_due_remaining<>0 and
apsa.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
apsa.customer_trx_id=rcta.customer_trx_id and
rcta.batch_source_id=rbsa.batch_source_id(+) and
rcta.org_id=rbsa.org_id(+) and
apsa.customer_id=hca.cust_account_id and
hca.party_id=hp.party_id and
apsa.org_id=haouv.organization_id
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
haouv.name operating_unit,
rcta.trx_number cm_number,
rcta.trx_date cm_date,
rbsa.name cm_source,
hp.party_name bill_to_customer,
hca.account_number bill_to_account,
apsa.invoice_currency_code currency,
apsa.amount_due_remaining cm_balance,
rcta_i.trx_number apply_to_invoice,
apsa_i.terms_sequence_number installment,
araa.amount_applied,
araa.apply_date,
araa.gl_date,
araa.comments,
to_char(null) unapply,
to_date(null) reversal_gl_date,
rcta.customer_trx_id cm_customer_trx_id,
araa.receivable_application_id,
null upload_row
from
ar_receivable_applications_all araa,
ra_customer_trx_all rcta,
ra_batch_sources_all rbsa,
ar_payment_schedules_all apsa,
ra_customer_trx_all rcta_i,
ar_payment_schedules_all apsa_i,
hz_cust_accounts hca,
hz_parties hp,
hr_all_organization_units_vl haouv
where
2=2 and
araa.application_type='CM' and
araa.status='APP' and
araa.display='Y' and
araa.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
araa.customer_trx_id=rcta.customer_trx_id and
rcta.batch_source_id=rbsa.batch_source_id(+) and
rcta.org_id=rbsa.org_id(+) and
araa.payment_schedule_id=apsa.payment_schedule_id and
araa.applied_customer_trx_id=rcta_i.customer_trx_id and
araa.applied_payment_schedule_id=apsa_i.payment_schedule_id and
apsa.customer_id=hca.cust_account_id and
hca.party_id=hp.party_id and
araa.org_id=haouv.organization_id