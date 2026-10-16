/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Refund Upload
-- Description: Bulk-refund customer credit balances in AR. Each row refunds either an open credit memo or the unapplied/on-account portion of a customer cash receipt by applying it against the operating unit's Credit Memo Refund Receivables Activity, via ARCMAPPLICATIONPUB.Activityapplication or ARRECEIPTAPIPUB.Activityapplication.
-- WHEN TO USE EACH REFUND SOURCE
-- - Credit Memo - the customer has an open credit memo (e.g. overpayment recorded as a CM) and wants the money back.
-- - Unapplied Receipt - the customer paid more than they owed, or paid against the account with no specific invoice. The receipt has an unapplied/on-account balance to return.
-- WORKFLOW (review and select)
-- The template downloads (Create, Update mode) pre-populated with every eligible credit memo and unapplied receipt for the parameters, showing Customer Name and Open Balance. Review the list, then:
-- 1. Set Refund = Yes on the rows to refund; leave blank to skip. Blank rows are not processed.
-- 2. Refund Amount defaults to the source open balance - override with a smaller positive amount for a partial refund (validated > 0 and <= balance, in Excel and at upload).
-- 3. Apply Date / Apply GL Date default to today; the GL Date must be in an open AR period.
-- 4. Optionally set Payment Method, Pay Group, Payment Reason Comments, Comments - these flow to the AP Payment Request invoice.
-- To add a row manually: pick Refund Source, then the Credit Memo Number or Receipt Number (the LOV adapts to the source).
-- APPROVAL LIMITS
-- The AR API runs with pchkapprovallimitflag='Y' - the user's AR approval limit applies. Rows over the limit error with the API's own message. Limits are never bypassed.
-- END-TO-END FLOW
-- 1. AR (this upload): a new arreceivableapplicationsall row is created (applicationtype='CM' or 'CASH', status='ACTIVITY').
-- 2. AR -> AP business event (automatic): AP creates a Payment Request invoice (source='Receivables', invoicetypelookupcode='PAYMENT REQUEST') payable to the customer's TCA party.
-- 3. AP Invoice Validation (standard AP concurrent).
-- 4. AP Payment Process Request issues the disbursement.
-- This upload performs step 1 only. Steps 2-4 are standard Oracle AP processing - a second human control point before any money leaves.
-- PER-OU SETUP
-- Each OU that processes refunds needs a Credit Memo Refund-type Receivables Activity (AR Setup -> Receipts -> Receivable Activities). The same activity is used for both CM and receipt refunds. If none, the upload errors: "No Credit Memo Refund activity is defined for this operating unit."
-- CANDIDATE IDENTIFICATION
-- - Credit Memo Number LOV: open credit memos in the OU whose customer account has no open invoices (standard refund-candidate rule). Set "Include accounts with open invoices" = Yes to override the safety filter (e.g. when open invoices are disputed).
-- - Receipt Number LOV: unapplied/on-account customer receipts in the OU with positive unapplied amount.
-- - Download in Create, Update mode to see existing candidates as rows.
-- FILTER PARAMETERS
-- - Operating Unit - filters both branches.
-- - Customer Name - LOV of customers that have an eligible refund in the OU (respects the open-invoice rules below).
-- - GL Date From / To, Credit Memo Number (multi-value), Batch Name (multi-value LOV on AR transaction batches) - Credit Memo branch only. The Receipt branch always shows all unapplied/on-account receipts in the chosen OU.
-- - Include accounts with open invoices - default blank (= safety filter on for CMs). Does not apply to receipts.
-- - Open Invoice Due Within Days - applies only when Include accounts with open invoices = Yes (otherwise ignored). Enter any number N: a credit memo is hidden only when the customer has an open invoice due within N days; invoices due later are ignored so the CM can still be refunded. Blank = due dates not considered.
-- MODE
-- Create, Update by default so the eligible candidates pre-populate. Only rows with Refund = Yes are processed; the result XLSM lists the refunded rows.
-- Excel Example Output: https://www.enginatics.com/example/ar-refund-upload/
-- Library Link: https://www.enginatics.com/reports/ar-refund-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
haouv.name operating_unit,
cast(null as varchar2(30)) refund,
'Credit Memo' refund_source,
rcta.trx_number credit_memo_number,
cast(null as varchar2(30)) receipt_number,
hp.party_name customer_name,
abs(apsa.amount_due_remaining) open_balance,
abs(apsa.amount_due_remaining) refund_amount,
cast(null as date) apply_date,
cast(null as date) apply_gl_date,
cast(null as varchar2(100)) payment_method,
cast(null as varchar2(80)) pay_group,
cast(null as varchar2(240)) payment_reason_comments,
cast(null as varchar2(240)) comments,
rownum upload_row
from
ar_payment_schedules_all apsa,
ra_customer_trx_all rcta,
hr_all_organization_units_vl haouv,
hz_cust_accounts hca,
hz_parties hp
where
1=1 and
apsa.class='CM' and
apsa.status='OP' and
apsa.amount_due_remaining<>0 and
apsa.customer_trx_id=rcta.customer_trx_id and
apsa.org_id=haouv.organization_id and
apsa.customer_id=hca.cust_account_id and
hca.party_id=hp.party_id and
apsa.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
not exists (
select
null
from
ar_payment_schedules_all inv
where
inv.customer_id=apsa.customer_id and
inv.org_id=apsa.org_id and
inv.class='INV' and
inv.status='OP' and
inv.amount_due_remaining<>0 and
(nvl(:include_with_open_invoices,'N')<>'Y' or :open_invoice_due_within_days is not null and inv.due_date<trunc(sysdate)+:open_invoice_due_within_days)
)
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
haouv.name operating_unit,
cast(null as varchar2(30)) refund,
'Unapplied Receipt' refund_source,
cast(null as varchar2(20)) credit_memo_number,
acra.receipt_number,
hp.party_name customer_name,
(select sum(ara.amount_applied) from ar_receivable_applications_all ara where ara.cash_receipt_id=acra.cash_receipt_id and ara.status in ('UNAPP','ACC') and ara.amount_applied>0) open_balance,
(select sum(ara.amount_applied) from ar_receivable_applications_all ara where ara.cash_receipt_id=acra.cash_receipt_id and ara.status in ('UNAPP','ACC') and ara.amount_applied>0) refund_amount,
cast(null as date) apply_date,
cast(null as date) apply_gl_date,
cast(null as varchar2(100)) payment_method,
cast(null as varchar2(80)) pay_group,
cast(null as varchar2(240)) payment_reason_comments,
cast(null as varchar2(240)) comments,
rownum upload_row
from
ar_cash_receipts_all acra,
hr_all_organization_units_vl haouv,
hz_cust_accounts hca,
hz_parties hp
where
1=1 and
acra.status='UNAPP' and
acra.org_id=haouv.organization_id and
acra.pay_from_customer=hca.cust_account_id and
hca.party_id=hp.party_id and
acra.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
exists (
select
null
from
ar_receivable_applications_all ara
where
ara.cash_receipt_id=acra.cash_receipt_id and
ara.status in ('UNAPP','ACC') and
ara.amount_applied>0
)
