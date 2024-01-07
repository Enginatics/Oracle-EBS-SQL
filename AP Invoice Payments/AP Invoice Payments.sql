/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoice Payments
-- Description: Supplier invoice payment details.
There can be multiple payments per invoice and one document/check can be used to pay different payments and invoices. To allow reconciling payment with invoices and checks, invoice and check level amounts are shown on the last payment record only and are blank for multiple/duplicate records.
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoice-payments/
-- Library Link: https://www.enginatics.com/reports/ap-invoice-payments/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
gl.currency_code ledger_currency,
hou.name operating_unit,
aps.vendor_name supplier,
aps.segment1 supplier_number,
xxen_util.meaning(aps.vendor_type_lookup_code,'VENDOR TYPE',201) supplier_type,
assa.vendor_site_code site_code,
assa.address_line1,
assa.address_line2,
assa.city,
assa.state,
assa.zip,
assa.county,
nvl(ftv.territory_short_name,assa.country) country,
aia.invoice_num invoice_number,
xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200) invoice_type,
aia.description invoice_description,
aia.invoice_date,
aia.gl_date invoice_gl_date,
apsa.due_date invoice_due_date,
decode(aipa.invoice_payment_id,max(aipa.invoice_payment_id) over (partition by aipa.invoice_id),aia.invoice_amount) invoice_amount,
decode(aipa.invoice_payment_id,max(aipa.invoice_payment_id) over (partition by aipa.invoice_id),decode(aia.invoice_currency_code,gl.currency_code,aia.invoice_amount,aia.base_amount)) invoice_amount_functional,
decode(aipa.invoice_payment_id,max(aipa.invoice_payment_id) over (partition by aipa.invoice_id),aia.invoice_amount)*decode(aca.currency_code,'USD',1,gdr.conversion_rate) invoice_amount_usd,
decode(aipa.invoice_payment_id,max(aipa.invoice_payment_id) over (partition by aipa.invoice_id),aia.amount_paid) invoice_amount_paid,
decode(aipa.invoice_payment_id,max(aipa.invoice_payment_id) over (partition by aipa.invoice_id),sum(apsa.amount_remaining) over (partition by apsa.invoice_id)) invoice_amount_remaining,
aia.invoice_currency_code invoice_currency,
atv.name payment_term,
trunc(max(aca.check_date) over (partition by aipa.invoice_id)-aia.invoice_date) days_to_pay,
(select ipp.payment_profile_name from iby_payment_profiles ipp where aca.payment_profile_id=ipp.payment_profile_id) ppr_profile,
aisca.checkrun_name ppr_description,
aisca.creation_date ppr_date,
ipmv.payment_method_name payment_method,
aca.currency_code payment_currency,
aca.check_number document_number,
trunc(aca.check_date) payment_date,
aipa.accounting_date accounting_date,
xxen_util.meaning(aca.status_lookup_code,'CHECK STATE',200) check_state,
decode(aipa.invoice_payment_id,max(aipa.invoice_payment_id) over (partition by aipa.check_id),aca.amount) check_amount,
decode(aipa.invoice_payment_id,max(aipa.invoice_payment_id) over (partition by aipa.check_id),decode(aca.currency_code,gl.currency_code,aca.amount,aca.base_amount)) check_amount_functional,
decode(aipa.invoice_payment_id,max(aipa.invoice_payment_id) over (partition by aipa.check_id),aca.amount*decode(aca.currency_code,'USD',1,gdr.conversion_rate)) check_amount_usd,
decode(aipa.invoice_payment_id,max(aipa.invoice_payment_id) over (partition by aipa.check_id),aca.cleared_amount) check_cleared_amount,
decode(aipa.invoice_payment_id,max(aipa.invoice_payment_id) over (partition by aipa.check_id),aca.cleared_amount*nvl(aca.exchange_rate,1))  check_cleared_amount_funct,
decode(aipa.invoice_payment_id,max(aipa.invoice_payment_id) over (partition by aipa.check_id),aca.cleared_amount*decode(aca.currency_code,'USD',1,gdr.conversion_rate)) check_cleared_amount_usd,
aipa.amount payment_amount,
decode(aca.currency_code,gl.currency_code,aipa.amount,aipa.payment_base_amount) payment_amount_functional,
aipa.amount*decode(aca.currency_code,'USD',1,gdr.conversion_rate) payment_amount_usd,
aipa.discount_taken,
aipa.discount_lost,
cbbv.bank_name,
cbbv.eft_swift_code swift_code,
cba.bank_account_name,
cba.masked_account_num bank_account_num,
cba.masked_iban iban,
aipa.exchange_date,
nvl(aca.exchange_rate,1) exchange_rate,
aipa.exchange_rate_type,
decode(aipa.reversal_flag,'Y',xxen_util.meaning(aipa.reversal_flag,'YES_NO',0)) reversal_flag,
decode(aipa.assets_addition_flag,'Y',xxen_util.meaning(aipa.reversal_flag,'YES_NO',0)) assets_addition_flag,
gcck.concatenated_segments asset_account,
(select gjb.name from gl_je_batches gjb where aipa.je_batch_id=gjb.je_batch_id) je_batch_name,
count(*) over (partition by aipa.invoice_id) payments_per_invoice,
count(*) over (partition by aipa.check_id) payments_per_check,
xxen_util.user_name(aipa.created_by) created_by,
xxen_util.client_time(aipa.creation_date) creation_date,
xxen_util.user_name(aipa.last_updated_by) last_updated_by,
xxen_util.client_time(aipa.last_update_date) last_update_date,
aipa.payment_num payment_number,
aipa.invoice_payment_id,
aipa.check_id,
aipa.invoice_id
from
gl_ledgers gl,
hr_operating_units hou,
ap_invoice_payments_all aipa,
ap_checks_all aca,
gl_daily_rates gdr,
ap_invoices_all aia,
ap_suppliers aps,
ap_supplier_sites_all assa,
fnd_territories_vl ftv,
ap_terms_vl atv,
ce_bank_acct_uses_all cbaua,
ce_bank_accounts cba,
ce_bank_branches_v cbbv,
iby_payment_methods_vl ipmv,
gl_code_combinations_kfv gcck,
ap_payment_schedules_all apsa,
ap_inv_selection_criteria_all aisca
where
1=1 and
gl.ledger_id=aipa.set_of_books_id and
hou.organization_id=aipa.org_id and
aipa.check_id=aca.check_id and
aca.currency_code=gdr.from_currency(+) and
gdr.to_currency(+)='USD' and
aca.check_date=gdr.conversion_date(+) and
gdr.conversion_type(+)='Corporate' and
aipa.invoice_id=aia.invoice_id and
aia.vendor_id=aps.vendor_id and
aia.vendor_site_id=assa.vendor_site_id and
assa.country=ftv.territory_code(+) and
aps.terms_id=atv.term_id(+) and
aca.ce_bank_acct_use_id=cbaua.bank_acct_use_id(+) and
cbaua.bank_account_id=cba.bank_account_id(+) and
cba.bank_branch_id=cbbv.branch_party_id(+) and
aca.payment_method_code=ipmv.payment_method_code(+) and
aipa.asset_code_combination_id=gcck.code_combination_id(+) and
aipa.invoice_id=apsa.invoice_id and
aipa.payment_num=apsa.payment_num and
aca.checkrun_id=aisca.checkrun_id (+)
order by
aipa.invoice_id desc,
aipa.invoice_payment_id desc