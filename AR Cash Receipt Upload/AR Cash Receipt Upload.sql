/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Cash Receipt Upload
-- Description: Upload to create AR cash receipts and optionally apply them to open invoices.
-- Each row creates one receipt (if it does not already exist) and optionally applies it to one invoice.
-- To apply one receipt to multiple invoices, enter multiple rows with the same Receipt Number - the receipt is created only once on the first row, and each subsequent row generates one application against the existing receipt.
-- Receipt Application options:
-- - Leave Invoice Number blank: receipt is created as Unapplied
-- - Enter Invoice Number: receipt is applied to that invoice
-- - Set Apply on Account = Yes: receipt amount is applied On Account (no specific invoice)
-- Remittance Bank Account:
-- - Defaults to the Primary bank account assigned to the Receipt Method (matching the form behaviour).
-- - To use a non-primary bank account, pick it from the Remittance Bank Account LOV. The Override flag is auto-defaulted to Yes when a non-primary account is chosen.
-- - For multi-row uploads against the same Receipt Number, only the bank account on the first row is used; subsequent rows simply apply to the receipt that already exists.
-- Apply-only against an existing receipt:
-- - Enter the Receipt Number of an existing receipt and the application columns (Invoice Number, Amount Applied, etc.). Receipt Method, Receipt Amount, Receipt Date and Currency may be left blank - they are required only when creating a new receipt.
-- Receipt Information (Descriptive Flexfield):
-- - Pick an Attribute Category (your configured DFF context) to expose its segments in the Attribute1..15 columns. Each segment shows only values valid for the chosen context.
-- - Column headers rename dynamically to your configured segment labels (via the "AR Cash Receipt DFF Attributes" translation rule).
-- - DFF values are written to the receipt header on create. They cannot be modified on an existing receipt via this upload - use the form, or reverse-and-recreate, for header DFF maintenance.
-- Receipt Type - Standard vs Miscellaneous:
-- - Receipt Type defaults to Standard (a customer cash receipt applied to invoices, as described above).
-- - Set Receipt Type to Miscellaneous to record non-customer income such as bank interest or refunds. A Miscellaneous receipt requires a Receivables Activity, which supplies the GL accounting automatically - there is no customer and no invoice application.
-- - Misc Payment Source is an optional free-text note for Miscellaneous receipts.
-- - On a Miscellaneous row the customer and application columns (Customer Name/Number/Site, Invoice Number, Amount Applied, Apply on Account, etc.) must be left blank.
-- Customer Bank Account:
-- - The customer's own bank account that funds the receipt - used by automatic receipt methods such as Direct Debit and EFT. Pick from the bank accounts registered for the customer. Leave blank for ordinary manually entered cash receipts.
-- Notes Receivable / Bills of Exchange:
-- - Issuer Name, Issue Date and Issuer Bank Branch capture the details of a note or bill of exchange. Populate them only for Notes Receivable receipts; leave blank for ordinary cash receipts.
-- The upload supports the following modes:
-- - Create: opens an empty template for entering new receipts
-- - Create, Update: downloads existing receipts (with applications) for review or to add further applications
-- Excel Example Output: https://www.enginatics.com/example/ar-cash-receipt-upload/
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
(select cba.bank_account_num from ce_bank_acct_uses_all cbau, ce_bank_accounts cba where cbau.bank_acct_use_id=acra.remit_bank_acct_use_id and cbau.bank_account_id=cba.bank_account_id) remittance_bank_account,
decode(acra.override_remit_account_flag,'Y',xxen_util.meaning('Y','YES_NO',0)) override_remit_account_flag,
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
araa.application_ref_num application_reference,
xxen_util.display_flexfield_context(222,'AR_CASH_RECEIPTS',acra.attribute_category) attribute_category,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE1',acra.rowid,acra.attribute1) attribute1,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE2',acra.rowid,acra.attribute2) attribute2,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE3',acra.rowid,acra.attribute3) attribute3,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE4',acra.rowid,acra.attribute4) attribute4,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE5',acra.rowid,acra.attribute5) attribute5,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE6',acra.rowid,acra.attribute6) attribute6,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE7',acra.rowid,acra.attribute7) attribute7,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE8',acra.rowid,acra.attribute8) attribute8,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE9',acra.rowid,acra.attribute9) attribute9,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE10',acra.rowid,acra.attribute10) attribute10,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE11',acra.rowid,acra.attribute11) attribute11,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE12',acra.rowid,acra.attribute12) attribute12,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE13',acra.rowid,acra.attribute13) attribute13,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE14',acra.rowid,acra.attribute14) attribute14,
xxen_util.display_flexfield_value(222,'AR_CASH_RECEIPTS',acra.attribute_category,'ATTRIBUTE15',acra.rowid,acra.attribute15) attribute15,
decode(acra.type,'MISC','Miscellaneous','Standard') receipt_type,
(select arta.name from ar_receivables_trx_all arta where arta.receivables_trx_id=acra.receivables_trx_id) receivables_activity,
acra.misc_payment_source,
(select ieba.bank_account_num from iby_ext_bank_accounts ieba where ieba.ext_bank_account_id=acra.customer_bank_account_id) customer_bank_account,
acra.issuer_name,
trunc(acra.issue_date) issue_date,
(select cbbv.bank_name||' / '||cbbv.bank_branch_name from ce_bank_branches_v cbbv where cbbv.branch_party_id=acra.issuer_bank_branch_id) issuer_bank_branch,
cast(null as date) maturity_date,
trunc(acra.postmark_date) postmark_date,
trunc(acra.anticipated_clearing_date) anticipated_clearing_date,
acra.doc_sequence_value document_number,
decode(acra.reversal_date,null,null,xxen_util.meaning('Y','YES_NO',0)) reverse_flag,
trunc(acra.reversal_date) reversal_date,
(
select trunc(max(acrha.reversal_gl_date))
from ar_cash_receipt_history_all acrha
where acrha.cash_receipt_id=acra.cash_receipt_id
) reversal_gl_date,
xxen_util.meaning(acra.reversal_category,'REVERSAL_CATEGORY_TYPE',222) reversal_category,
xxen_util.meaning(acra.reversal_reason_code,'CKAJST_REASON',222) reversal_reason,
acra.reversal_comments,
to_number(null) upload_row
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
acra.type in ('CASH','MISC') and
acra.receipt_method_id=arm.receipt_method_id(+) and
acra.pay_from_customer=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
acra.customer_site_use_id=hcsua.site_use_id(+) and
acra.cash_receipt_id=araa.cash_receipt_id(+) and
araa.applied_customer_trx_id=rcta.customer_trx_id(+) and
araa.applied_payment_schedule_id=apsa.payment_schedule_id(+)
) x
