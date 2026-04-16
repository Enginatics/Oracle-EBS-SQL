/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Cash Receipt Upload
-- Description: Upload to create AR cash receipts and optionally apply them to open invoices.

Each row creates one receipt (if it does not already exist) and optionally applies it to one invoice.
To apply one receipt to multiple invoices, enter multiple rows with the same Receipt Number - the receipt is created only once and each row generates one application.

Receipt Application options:
- Leave Invoice Number blank: receipt is created as Unapplied
- Enter Invoice Number: receipt is applied to that invoice
- Set Apply on Account = Yes: receipt amount is applied On Account (no specific invoice)

The upload supports the following modes:
- Create: opens an empty template for entering new receipts
- Create, Update: downloads existing receipts (with applications) for review or to add further applications
-- Excel Examle Output: https://www.enginatics.com/example/ar-cash-receipt-upload/
-- Library Link: https://www.enginatics.com/reports/ar-cash-receipt-upload/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
null action_,
null status_,
null message_,
null modified_columns_,
haouv.name operating_unit,
arm.name receipt_method,
acra.receipt_number,
acra.amount receipt_amount,
acra.currency_code receipt_currency,
trunc(acra.receipt_date) receipt_date,
(
select trunc(max(acrha.gl_date))
from ar_cash_receipt_history_all acrha
where acrha.cash_receipt_id=acra.cash_receipt_id
and acrha.current_record_flag='Y'
) gl_date,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where gdct.conversion_type=acra.exchange_rate_type) exchange_rate_type,
trunc(acra.exchange_date) exchange_date,
acra.exchange_rate,
hp.party_name customer_name,
hca.account_number customer_number,
hcsua.location customer_site,
acra.customer_receipt_reference,
acra.comments,
trunc(acra.deposit_date) deposit_date,
rcta.trx_number invoice_number,
apsa.terms_sequence_number installment,
trunc(araa.apply_date) apply_date,
trunc(araa.gl_date) apply_gl_date,
araa.amount_applied,
araa.earned_discount_taken discount_amount,
case when araa.status='ACC' then xxen_util.meaning('Y','YES_NO',0) end apply_on_account,
araa.application_ref_num application_reference
from
ar_cash_receipts_all acra,
hr_all_organization_units_vl haouv,
ar_receipt_methods arm,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
(select araa.* from ar_receivable_applications_all araa where araa.status in ('APP','ACC') and araa.display='Y') araa,
ra_customer_trx_all rcta,
ar_payment_schedules_all apsa
where
1=1 and
haouv.organization_id=acra.org_id and
acra.type='CASH' and
acra.receipt_method_id=arm.receipt_method_id(+) and
acra.pay_from_customer=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
acra.customer_site_use_id=hcsua.site_use_id(+) and
acra.cash_receipt_id=araa.cash_receipt_id(+) and
araa.applied_customer_trx_id=rcta.customer_trx_id(+) and
araa.applied_payment_schedule_id=apsa.payment_schedule_id(+)
) x