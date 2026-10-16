/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoice Payment Upload
-- Description: Records Manual and Quick payments of open Payables invoices and voids payments - the Excel equivalent of entering a payment and its invoices in the Payments window.
-- Each row is one invoice installment paid, with the payment columns repeated on every row. Rows with identical payment columns are paid by one payment. Amount Paid and Discount Taken default to the full amount remaining less the discount available at the Payment Date, and can be reduced to pay an installment partially.
-- Each payment is processed as a whole: when any of its rows fails validation, none of its rows are saved. A Manual payment records a document already issued and needs its Document Num. A Quick payment takes the next number of a printed Payment Document, and is submitted to Oracle Payments as a single payment, as from the Payments window.
-- Set the Open Invoices parameter to download the open installments of the selected supplier and operating unit as new rows to pay. In Create, Update mode existing Manual and Quick payments are downloaded; enter a Void Date to void one. Voiding reverses all invoice payments of the payment and leaves the invoices unpaid, unless Invoice Action puts them on hold or cancels them. Cancelling invoices is committed by Oracle Payables as it happens, as in the Payments window.
-- Invoices that would get withholding tax or an interest invoice at payment time cannot be paid by a Quick payment through the upload.
-- Excel Example Output: https://www.enginatics.com/example/ap-invoice-payment-upload/
-- Library Link: https://www.enginatics.com/reports/ap-invoice-payment-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
x.operating_unit,
x.payment_type,
x.payment_date,
x.trading_partner,
x.supplier_num,
x.supplier_site,
x.bank_account,
x.payment_method,
x.payment_process_profile,
x.payment_document,
x.document_num,
x.currency,
x.exchange_rate_type,
x.exchange_date,
x.exchange_rate,
x.payment_amount,
x.payment_status,
x.void_date,
x.invoice_action,
x.hold_name,
x.hold_reason,
x.invoice_num,
x.invoice_date,
x.payment_num,
x.due_date,
x.amount_remaining,
x.discount_available,
x.amount_paid,
x.discount_taken,
x.check_id,
x.invoice_payment_id,
null upload_row
from
(
select
haouv.name operating_unit,
xxen_util.meaning(aca.payment_type_flag,'PAYMENT TYPE',200) payment_type,
aca.check_date payment_date,
aps.vendor_name trading_partner,
aps.segment1 supplier_num,
assa.vendor_site_code supplier_site,
xxen_ap_upload.bank_account_name(aca.ce_bank_acct_use_id) bank_account,
xxen_ap_upload.payment_method_name(aca.payment_method_code) payment_method,
xxen_ap_upload.payment_profile_name(aca.payment_profile_id) payment_process_profile,
cpd.payment_document_name payment_document,
aca.check_number document_num,
aca.currency_code currency,
gdct.user_conversion_type exchange_rate_type,
aca.exchange_date,
aca.exchange_rate,
aca.amount payment_amount,
xxen_util.meaning(aca.status_lookup_code,'CHECK STATE',200) payment_status,
aca.void_date,
null invoice_action,
null hold_name,
null hold_reason,
aia.invoice_num,
aia.invoice_date,
aipa.payment_num,
apsa.due_date,
apsa.amount_remaining,
to_number(null) discount_available,
aipa.amount amount_paid,
aipa.discount_taken,
aca.check_id,
aipa.invoice_payment_id
from
ap_checks_all aca,
hr_all_organization_units_vl haouv,
ap_suppliers aps,
ap_supplier_sites_all assa,
ce_payment_documents cpd,
gl_daily_conversion_types gdct,
ap_invoice_payments_all aipa,
ap_invoices_all aia,
ap_payment_schedules_all apsa
where
1=1 and
aca.payment_type_flag in ('M','Q') and
aca.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
aca.org_id=haouv.organization_id and
aca.vendor_id=aps.vendor_id and
aca.vendor_site_id=assa.vendor_site_id and
aca.payment_document_id=cpd.payment_document_id(+) and
aca.exchange_rate_type=gdct.conversion_type(+) and
aca.check_id=aipa.check_id and
aipa.reversal_inv_pmt_id is null and
aipa.invoice_id=aia.invoice_id and
aipa.invoice_id=apsa.invoice_id and
aipa.payment_num=apsa.payment_num
union all
select
haouv.name operating_unit,
null payment_type,
to_date(null) payment_date,
aps.vendor_name trading_partner,
aps.segment1 supplier_num,
assa.vendor_site_code supplier_site,
null bank_account,
xxen_ap_upload.payment_method_name(apsa.payment_method_code) payment_method,
null payment_process_profile,
null payment_document,
to_number(null) document_num,
aia.payment_currency_code currency,
null exchange_rate_type,
to_date(null) exchange_date,
to_number(null) exchange_rate,
to_number(null) payment_amount,
null payment_status,
to_date(null) void_date,
null invoice_action,
null hold_name,
null hold_reason,
aia.invoice_num,
aia.invoice_date,
apsa.payment_num,
apsa.due_date,
apsa.amount_remaining,
to_number(null) discount_available,
to_number(null) amount_paid,
to_number(null) discount_taken,
to_number(null) check_id,
to_number(null) invoice_payment_id
from
ap_invoices_all aia,
hr_all_organization_units_vl haouv,
ap_suppliers aps,
ap_supplier_sites_all assa,
ap_payment_schedules_all apsa
where
2=2 and
:open_invoices='Y' and
aia.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
aia.org_id=haouv.organization_id and
aia.vendor_id=aps.vendor_id and
aia.vendor_site_id=assa.vendor_site_id and
aia.invoice_id=apsa.invoice_id and
aia.cancelled_date is null and
nvl(aia.payment_status_flag,'N')<>'Y' and
aia.wfapproval_status in ('WFAPPROVED','NOT REQUIRED','MANUALLY APPROVED') and
nvl(apsa.payment_status_flag,'N')<>'Y' and
nvl(apsa.hold_flag,'N')='N' and
apsa.checkrun_id is null and
aia.invoice_id not in (select aha.invoice_id from ap_holds_all aha where aha.release_lookup_code is null) and
aia.invoice_id not in (select asia.invoice_id from ap_selected_invoices_all asia) and
ap_invoices_pkg.get_approval_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code) not in ('NEVER APPROVED','NEEDS REAPPROVAL','UNAPPROVED')
) x
