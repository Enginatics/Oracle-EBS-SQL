/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Period Close Exceptions
-- Description: Based on Oracle standard Period Close Exceptions Report
Source: Period Close Exceptions Report (XML)
Short Name: APXPCER
DB package: ap_period_close_pkg
-- Excel Examle Output: https://www.enginatics.com/example/ap-period-close-exceptions/
-- Library Link: https://www.enginatics.com/reports/ap-period-close-exceptions/
-- Run Report: https://demo.enginatics.com/

select
:period_name period_name,
x.*
from
(
-- Unaccounted Invoice Distributions
select
'Unaccounted Invoice Distributions' exception_type,
gl.name ledger,
haou.name operating_unit,
nvl(aps.vendor_name,hp.party_name) supplier_name,
aps.segment1 supplier_number,
aia.invoice_num invoice_number,
aia.invoice_date,
aid.accounting_date,
aia.invoice_currency_code currency,
aia.invoice_amount,
to_char(null) check_number,
to_char(null) bank_account_name,
to_char(null) transaction_type,
to_char(null) payment_batch_name,
to_char(null) payment_batch_status,
to_char(null) event_type,
fc.precision
from
ap_invoices_all aia,
ap_invoice_distributions_all aid,
ap_suppliers aps,
hz_parties hp,
hr_all_organization_units haou,
gl_ledgers gl,
fnd_currencies fc
where
aia.invoice_id=aid.invoice_id and
aia.vendor_id=aps.vendor_id(+) and
aia.party_id=hp.party_id and
aia.org_id=haou.organization_id and
aia.set_of_books_id=gl.ledger_id and
aia.invoice_currency_code=fc.currency_code and
aid.posted_flag<>'Y' and
nvl(aid.reversal_flag,'N')<>'Y' and
2=2
union all
-- Invoices Without Distributions
select
'Invoices Without Distributions' exception_type,
gl.name ledger,
haou.name operating_unit,
nvl(aps.vendor_name,hp.party_name) supplier_name,
aps.segment1 supplier_number,
aia.invoice_num invoice_number,
aia.invoice_date,
to_date(null) accounting_date,
aia.invoice_currency_code currency,
aia.invoice_amount,
to_char(null) check_number,
to_char(null) bank_account_name,
to_char(null) transaction_type,
to_char(null) payment_batch_name,
to_char(null) payment_batch_status,
to_char(null) event_type,
fc.precision
from
ap_invoices_all aia,
ap_invoice_lines_all aila,
ap_suppliers aps,
hz_parties hp,
hr_all_organization_units haou,
gl_ledgers gl,
fnd_currencies fc
where
aia.invoice_id=aila.invoice_id and
aia.vendor_id=aps.vendor_id(+) and
aia.party_id=hp.party_id and
aia.org_id=haou.organization_id and
aia.set_of_books_id=gl.ledger_id and
aia.invoice_currency_code=fc.currency_code and
not exists (select null from ap_invoice_distributions_all aid2 where aid2.invoice_id=aia.invoice_id and aid2.invoice_line_number=aila.line_number) and
10=10
union all
-- Unaccounted Payment History
select
'Unaccounted Payments' exception_type,
gl.name ledger,
haou.name operating_unit,
nvl(aps.vendor_name,hp.party_name) supplier_name,
aps.segment1 supplier_number,
to_char(null) invoice_number,
to_date(null) invoice_date,
aph.accounting_date,
aca.currency_code currency,
aca.amount invoice_amount,
to_char(aca.check_number) check_number,
cba.bank_account_name,
initcap(substr(aph.transaction_type,9)) transaction_type,
to_char(null) payment_batch_name,
to_char(null) payment_batch_status,
to_char(null) event_type,
fc.precision
from
ap_checks_all aca,
ap_payment_history_all aph,
ap_suppliers aps,
hz_parties hp,
hr_all_organization_units haou,
gl_ledgers gl,
fnd_currencies fc,
ce_bank_accounts cba,
ce_bank_acct_uses_all cbau,
ap_system_parameters_all asp
where
aca.check_id=aph.check_id and
aca.vendor_id=aps.vendor_id(+) and
aca.party_id=hp.party_id and
aca.org_id=haou.organization_id and
aca.org_id=asp.org_id and
asp.set_of_books_id=gl.ledger_id and
aca.currency_code=fc.currency_code and
aca.ce_bank_acct_use_id=cbau.bank_acct_use_id(+) and
cbau.bank_account_id=cba.bank_account_id(+) and
aph.posted_flag<>'Y' and
aph.transaction_type in ('PAYMENT CREATED','PAYMENT MATURITY','PAYMENT CLEARING','PAYMENT UNCLEARING') and
3=3
union all
-- Future Dated Payments
select
'Future Dated Payments' exception_type,
gl.name ledger,
haou.name operating_unit,
nvl(aps.vendor_name,hp.party_name) supplier_name,
aps.segment1 supplier_number,
to_char(null) invoice_number,
to_date(null) invoice_date,
aca.future_pay_due_date accounting_date,
aca.currency_code currency,
aca.amount invoice_amount,
to_char(aca.check_number) check_number,
cba.bank_account_name,
'Future Dated' transaction_type,
to_char(null) payment_batch_name,
to_char(null) payment_batch_status,
to_char(null) event_type,
fc.precision
from
ap_checks_all aca,
ap_suppliers aps,
hz_parties hp,
hr_all_organization_units haou,
gl_ledgers gl,
fnd_currencies fc,
ce_bank_accounts cba,
ce_bank_acct_uses_all cbau,
ap_system_parameters_all asp
where
aca.vendor_id=aps.vendor_id(+) and
aca.party_id=hp.party_id and
aca.org_id=haou.organization_id and
aca.org_id=asp.org_id and
asp.set_of_books_id=gl.ledger_id and
aca.currency_code=fc.currency_code and
aca.ce_bank_acct_use_id=cbau.bank_acct_use_id(+) and
cbau.bank_account_id=cba.bank_account_id(+) and
aca.future_pay_due_date is not null and
aca.status_lookup_code='ISSUED' and
nvl(asp.when_to_account_pmt,'ALWAYS')='ALWAYS' and
4=4
union all
-- Unconfirmed Payment Batches
select distinct
'Unconfirmed Payment Batches' exception_type,
gl.name ledger,
haou.name operating_unit,
to_char(null) supplier_name,
to_char(null) supplier_number,
to_char(null) invoice_number,
to_date(null) invoice_date,
aisc.check_date accounting_date,
to_char(null) currency,
to_number(null) invoice_amount,
to_char(null) check_number,
to_char(null) bank_account_name,
to_char(null) transaction_type,
aisc.checkrun_name payment_batch_name,
decode(iby.meaning,null,alc.displayed_field,iby.meaning) payment_batch_status,
to_char(null) event_type,
to_number(null) precision
from
ap_inv_selection_criteria_all aisc,
ap_selected_invoices_all asi,
ap_lookup_codes alc,
fnd_lookups iby,
iby_pay_service_requests ipsr,
hr_all_organization_units haou,
gl_ledgers gl,
ap_system_parameters_all asp
where
aisc.checkrun_id=asi.checkrun_id and
ipsr.call_app_pay_service_req_code(+)=aisc.checkrun_name and
iby.lookup_type(+)='IBY_REQUEST_STATUSES' and
iby.lookup_code(+)=ipsr.payment_service_request_status and
alc.lookup_type(+)='CHECK BATCH STATUS' and
alc.lookup_code(+)=aisc.status and
decode(ipsr.payment_service_request_id,null,aisc.status,
ap_payment_util_pkg.get_psr_status(ipsr.payment_service_request_id,ipsr.payment_service_request_status))
not in ('CONFIRMED','CANCELED','QUICKCHECK','CANCELLED NO PAYMENTS','TERMINATED') and
asi.org_id=haou.organization_id and
asi.org_id=asp.org_id and
asp.set_of_books_id=gl.ledger_id and
5=5
union all
-- Untransferred XLA Events - Invoices
select distinct
'Untransferred XLA Events' exception_type,
gl.name ledger,
haou.name operating_unit,
nvl(aps.vendor_name,hp.party_name) supplier_name,
aps.segment1 supplier_number,
aia.invoice_num invoice_number,
aia.invoice_date,
xah.accounting_date,
aia.invoice_currency_code currency,
aia.invoice_amount,
to_char(null) check_number,
to_char(null) bank_account_name,
to_char(null) transaction_type,
to_char(null) payment_batch_name,
to_char(null) payment_batch_status,
xet.event_type_code event_type,
fc.precision
from
xla_ae_headers xah,
xla_events xe,
xla_event_types_tl xet,
xla_transaction_entities xte,
ap_invoices_all aia,
ap_suppliers aps,
hz_parties hp,
hr_all_organization_units haou,
gl_ledgers gl,
fnd_currencies fc
where
xah.event_id=xe.event_id and
xah.application_id=xe.application_id and
xe.event_type_code=xet.event_type_code and
xe.application_id=xet.application_id and
xet.language=userenv('LANG') and
xe.entity_id=xte.entity_id and
xe.application_id=xte.application_id and
xte.entity_code='AP_INVOICES' and
xte.source_id_int_1=aia.invoice_id and
aia.vendor_id=aps.vendor_id(+) and
aia.party_id=hp.party_id and
aia.org_id=haou.organization_id and
xah.ledger_id=gl.ledger_id and
aia.invoice_currency_code=fc.currency_code and
xah.gl_transfer_status_code<>'Y' and
xah.accounting_entry_status_code='F' and
xe.application_id=200 and
6=6
union all
-- Untransferred XLA Events - Payments
select distinct
'Untransferred XLA Events' exception_type,
gl.name ledger,
haou.name operating_unit,
nvl(aps.vendor_name,hp.party_name) supplier_name,
aps.segment1 supplier_number,
to_char(null) invoice_number,
to_date(null) invoice_date,
xah.accounting_date,
aca.currency_code currency,
aca.amount invoice_amount,
to_char(aca.check_number) check_number,
cba.bank_account_name,
to_char(null) transaction_type,
to_char(null) payment_batch_name,
to_char(null) payment_batch_status,
xet.event_type_code event_type,
fc.precision
from
xla_ae_headers xah,
xla_events xe,
xla_event_types_tl xet,
xla_transaction_entities xte,
ap_checks_all aca,
ap_suppliers aps,
hz_parties hp,
hr_all_organization_units haou,
gl_ledgers gl,
fnd_currencies fc,
ce_bank_accounts cba,
ce_bank_acct_uses_all cbau
where
xah.event_id=xe.event_id and
xah.application_id=xe.application_id and
xe.event_type_code=xet.event_type_code and
xe.application_id=xet.application_id and
xet.language=userenv('LANG') and
xe.entity_id=xte.entity_id and
xe.application_id=xte.application_id and
xte.entity_code='AP_PAYMENTS' and
xte.source_id_int_1=aca.check_id and
aca.vendor_id=aps.vendor_id(+) and
aca.party_id=hp.party_id and
aca.org_id=haou.organization_id and
xah.ledger_id=gl.ledger_id and
aca.currency_code=fc.currency_code and
aca.ce_bank_acct_use_id=cbau.bank_acct_use_id(+) and
cbau.bank_account_id=cba.bank_account_id(+) and
xah.gl_transfer_status_code<>'Y' and
xah.accounting_entry_status_code='F' and
xe.application_id=200 and
6=6
union all
-- Other XLA Exceptions - Unprocessed Events for Invoices
select distinct
'Unprocessed Events' exception_type,
gl.name ledger,
haou.name operating_unit,
nvl(aps.vendor_name,hp.party_name) supplier_name,
aps.segment1 supplier_number,
aia.invoice_num invoice_number,
aia.invoice_date,
xe.event_date accounting_date,
aia.invoice_currency_code currency,
aia.invoice_amount,
to_char(null) check_number,
to_char(null) bank_account_name,
to_char(null) transaction_type,
to_char(null) payment_batch_name,
to_char(null) payment_batch_status,
xet.event_type_code event_type,
fc.precision
from
xla_events xe,
xla_event_types_tl xet,
xla_transaction_entities xte,
ap_invoices_all aia,
ap_suppliers aps,
hz_parties hp,
hr_all_organization_units haou,
gl_ledgers gl,
fnd_currencies fc
where
xe.event_type_code=xet.event_type_code and
xe.application_id=xet.application_id and
xet.language=userenv('LANG') and
xe.entity_id=xte.entity_id and
xe.application_id=xte.application_id and
xte.entity_code='AP_INVOICES' and
xte.source_id_int_1=aia.invoice_id and
aia.vendor_id=aps.vendor_id(+) and
aia.party_id=hp.party_id and
aia.org_id=haou.organization_id and
xte.ledger_id=gl.ledger_id and
aia.invoice_currency_code=fc.currency_code and
xe.event_status_code='U' and
xe.process_status_code='U' and
xe.application_id=200 and
8=8
union all
-- Other XLA Exceptions - Unprocessed Events for Payments
select distinct
'Unprocessed Events' exception_type,
gl.name ledger,
haou.name operating_unit,
nvl(aps.vendor_name,hp.party_name) supplier_name,
aps.segment1 supplier_number,
to_char(null) invoice_number,
to_date(null) invoice_date,
xe.event_date accounting_date,
aca.currency_code currency,
aca.amount invoice_amount,
to_char(aca.check_number) check_number,
cba.bank_account_name,
to_char(null) transaction_type,
to_char(null) payment_batch_name,
to_char(null) payment_batch_status,
xet.event_type_code event_type,
fc.precision
from
xla_events xe,
xla_event_types_tl xet,
xla_transaction_entities xte,
ap_checks_all aca,
ap_suppliers aps,
hz_parties hp,
hr_all_organization_units haou,
gl_ledgers gl,
fnd_currencies fc,
ce_bank_accounts cba,
ce_bank_acct_uses_all cbau
where
xe.event_type_code=xet.event_type_code and
xe.application_id=xet.application_id and
xet.language=userenv('LANG') and
xe.entity_id=xte.entity_id and
xe.application_id=xte.application_id and
xte.entity_code='AP_PAYMENTS' and
xte.source_id_int_1=aca.check_id and
aca.vendor_id=aps.vendor_id(+) and
aca.party_id=hp.party_id and
aca.org_id=haou.organization_id and
xte.ledger_id=gl.ledger_id and
aca.currency_code=fc.currency_code and
aca.ce_bank_acct_use_id=cbau.bank_acct_use_id(+) and
cbau.bank_account_id=cba.bank_account_id(+) and
xe.event_status_code='U' and
xe.process_status_code='U' and
xe.application_id=200 and
9=9
) x
where
1=1
order by
x.exception_type,
x.ledger,
x.operating_unit,
x.supplier_name,
x.invoice_number,
x.check_number