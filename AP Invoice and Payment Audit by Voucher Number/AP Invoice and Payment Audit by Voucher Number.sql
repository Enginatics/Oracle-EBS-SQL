/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoice and Payment Audit by Voucher Number
-- Description: Lists every voucher number of the Payables invoice and payment document sequences with its status: Entered, Deleted (the number was issued, but the invoice or payment no longer exists) or Not Entered (the number is missing from the sequence audit trail).
-- Replaces Oracle's Invoice Audit by Voucher Number (APXINVAD) and Payment Audit by Voucher Number (APXPAYAD). Unlike Oracle's payment report, a voided payment is listed as Entered with its void date, and a payment number without a payment as Deleted instead of Not Entered.
-- Missing numbers are the gaps between the numbers recorded in the sequence audit table, counted from the sequence's initial value, and belong to the ledger of the next recorded number. Numbers after the last recorded voucher are not reported.
-- The GL date of a payment is the earliest accounting date of its invoice payments.
-- Excel Example Output: https://www.enginatics.com/example/ap-invoice-and-payment-audit-by-voucher-number/
-- Library Link: https://www.enginatics.com/reports/ap-invoice-and-payment-audit-by-voucher-number/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
z.sequence_name,
z.category,
z.voucher_number,
xxen_util.meaning(z.status_code,'SEQ_DOCUMENT_STATUS',0) status,
haouv.name operating_unit,
nvl(z.payee,aps.vendor_name) supplier,
aps.segment1 supplier_number,
z.document_number,
z.document_date,
z.gl_date,
z.currency_code,
z.amount,
z.payment_status,
z.void_date,
z.description,
xxen_util.user_name(z.created_by) created_by,
xxen_util.client_time(z.creation_date) creation_date
from
(
select
y.sequence_name,
y.doc_sequence_id,
y.set_of_books_id,
y.min_voucher,
y.max_voucher,
y.doc_sequence_value-y.numbers+rowgen.column_value voucher_number,
decode(rowgen.column_value,y.numbers,y.status_code,'N') status_code,
decode(rowgen.column_value,y.numbers,y.category) category,
decode(rowgen.column_value,y.numbers,y.org_id) org_id,
decode(rowgen.column_value,y.numbers,y.vendor_id) vendor_id,
decode(rowgen.column_value,y.numbers,y.payee) payee,
decode(rowgen.column_value,y.numbers,y.document_number) document_number,
decode(rowgen.column_value,y.numbers,y.document_date) document_date,
decode(rowgen.column_value,y.numbers,y.gl_date) gl_date,
decode(rowgen.column_value,y.numbers,y.currency_code) currency_code,
decode(rowgen.column_value,y.numbers,y.amount) amount,
decode(rowgen.column_value,y.numbers,y.payment_status) payment_status,
decode(rowgen.column_value,y.numbers,y.void_date) void_date,
decode(rowgen.column_value,y.numbers,y.description) description,
decode(rowgen.column_value,y.numbers,y.created_by) created_by,
decode(rowgen.column_value,y.numbers,y.creation_date) creation_date
from
(
select
x.*,
greatest(x.doc_sequence_value-coalesce(lag(x.doc_sequence_value) over (partition by x.doc_sequence_id order by x.doc_sequence_value),x.initial_value-1,x.doc_sequence_value-1),1) numbers,
min(case when x.gl_date is not null &gl_date_from &gl_date_to then x.doc_sequence_value end) over (partition by x.doc_sequence_id) min_voucher,
max(case when x.gl_date is not null &gl_date_from &gl_date_to then x.doc_sequence_value end) over (partition by x.doc_sequence_id) max_voucher
from
(
select
fds.name sequence_name,
fds.initial_value,
adsa.doc_sequence_id,
adsa.doc_sequence_value,
adsa.creation_date,
adsa.created_by,
fdsa.set_of_books_id,
fdsc.name category,
nvl2(coalesce(aia.invoice_id,aca.check_id),'E','D') status_code,
nvl(aia.org_id,aca.org_id) org_id,
nvl(aia.vendor_id,aca.vendor_id) vendor_id,
aca.vendor_name payee,
nvl(aia.invoice_num,to_char(aca.check_number)) document_number,
nvl(aia.invoice_date,aca.check_date) document_date,
coalesce(aia.gl_date,(select min(aipa.accounting_date) from ap_invoice_payments_all aipa where aca.check_id=aipa.check_id)) gl_date,
nvl(aia.invoice_currency_code,aca.currency_code) currency_code,
nvl(aia.invoice_amount,aca.amount) amount,
coalesce(xxen_util.meaning(aia.payment_status_flag,'INVOICE PAYMENT STATUS',200),xxen_util.meaning(aca.status_lookup_code,'CHECK STATE',200)) payment_status,
aca.void_date,
nvl(aia.description,aca.description) description
from
fnd_document_sequences fds,
ap_doc_sequence_audit adsa,
fnd_doc_sequence_assignments fdsa,
fnd_doc_sequence_categories fdsc,
ap_invoices_all aia,
ap_checks_all aca
where
1=1 and
fds.doc_sequence_id in (select fdsa2.doc_sequence_id from fnd_doc_sequence_assignments fdsa2 where fdsa2.set_of_books_id in (select hou.set_of_books_id from hr_operating_units hou where hou.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11))) and
fds.doc_sequence_id=adsa.doc_sequence_id and
adsa.doc_sequence_assignment_id=fdsa.doc_sequence_assignment_id and
fdsa.application_id=fdsc.application_id and
fdsa.category_code=fdsc.code and
adsa.doc_sequence_id=aia.doc_sequence_id(+) and
adsa.doc_sequence_value=aia.doc_sequence_value(+) and
adsa.doc_sequence_id=aca.doc_sequence_id(+) and
adsa.doc_sequence_value=aca.doc_sequence_value(+)
) x
) y,
table(xxen_util.rowgen(y.numbers)) rowgen
) z,
gl_ledgers gl,
hr_all_organization_units_vl haouv,
ap_suppliers aps
where
2=2 and
z.set_of_books_id in (select hou.set_of_books_id from hr_operating_units hou where hou.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)) and
z.set_of_books_id=gl.ledger_id and
z.org_id=haouv.organization_id(+) and
z.vendor_id=aps.vendor_id(+)
order by
z.sequence_name,
z.voucher_number
