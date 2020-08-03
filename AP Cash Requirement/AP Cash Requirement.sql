/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Cash Requirement
-- Description: Detail cash requirement report showing all unpaid or partially paid amounts, where the invoice is neither on hold nor cancelled, including invoice currency amount, exchange rate, and currency code
-- Excel Examle Output: https://www.enginatics.com/example/ap-cash-requirement/
-- Library Link: https://www.enginatics.com/reports/ap-cash-requirement/
-- Run Report: https://demo.enginatics.com/

select
apsa.due_date,
hp.party_name trading_partner,
aia.invoice_num,
aia.invoice_date,
ap_apxcrrcr_xmlp_pkg.c_amountformula(assa.always_take_disc_flag, apsa.discount_amount_available, apsa.discount_date, apsa.second_discount_date, apsa.second_disc_amt_available, apsa.third_discount_date, apsa.third_disc_amt_available, apsa.gross_amount, apsa.amount_remaining) amount,
aia.payment_currency_code payment_currency,
aia.pay_group_lookup_code pay_group,
xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id) invoice_status,
xxen_util.meaning(case when aia.wfapproval_status in('MANUALLY APPROVED','NOT REQUIRED','WFAPPROVED') then 'Y' else 'N' end,'YES_NO',0) approved,
xxen_util.meaning(ap_invoices_utility_pkg.get_payment_status(aia.invoice_id),'INVOICE PAYMENT STATUS',200) payment_status,
aia.description,
decode(aia.holds_count,0,null,aia.holds_count) holds_count,
trunc(apsa.due_date-sysdate) days_to_due,
apsa.future_pay_due_date,
apsa.gross_amount,
apsa.hold_flag,
xxen_util.meaning(apsa.payment_method_lookup_code,'PAYMENT METHOD',200) payment_method_lookup_code,
apsa.payment_priority,
apsa.discount_date,
apsa.second_discount_date,
apsa.third_discount_date,
apsa.discount_amount_available,
apsa.second_disc_amt_available,
apsa.third_disc_amt_available,
apsa.discount_amount_remaining,
apsa.inv_curr_gross_amount,
aia.exchange_rate,
aia.payment_cross_rate,
ap_apxcrrcr_xmlp_pkg.c_base_currency_amountformula(
assa.always_take_disc_flag,
apsa.discount_amount_available,
apsa.discount_date,
apsa.second_discount_date,
apsa.second_disc_amt_available,
apsa.third_discount_date,
apsa.third_disc_amt_available,
apsa.gross_amount,
apsa.amount_remaining,
fc.minimum_accountable_unit,
aia.exchange_rate,
aia.payment_cross_rate,
fc.precision) base_currency_amount,
aspa.base_currency_code,
fc.minimum_accountable_unit base_min_unit,
fc.precision base_precision,
sum(case when aia.invoice_currency_code=aspa.base_currency_code or fc.derive_type in ('EURO','EMU') or aia.exchange_rate is not null then 0 else 1 end) over (partition by aia.invoice_currency_code) num_invoices_no_rate,
aia.invoice_currency_code,
gl.name ledger,
hou.name operating_unit,
aia.invoice_id
from
gl_ledgers gl,
hr_operating_units hou,
ap_system_parameters_all aspa,
ap_payment_schedules_all apsa,
(
select
(select count(*) from ap_holds_all aha where aia.invoice_id=aha.invoice_id and aha.release_lookup_code is null) holds_count,
aia.*
from
ap_invoices_all aia
) aia,
fnd_currencies fc,
hz_parties hp,
ap_suppliers asu,
ap_supplier_sites_all assa
&apt_table
where
1=1 and
apsa.payment_status_flag in ('N','P') and
aia.payment_status_flag in ('N','P') and
aia.cancelled_date is null and
nvl(apsa.hold_flag,'N')='N' and
nvl(assa.hold_all_payments_flag,'N')='N' and
gl.ledger_id=hou.set_of_books_id and
hou.set_of_books_id=aspa.set_of_books_id and
hou.organization_id=aspa.org_id and
hou.organization_id=apsa.org_id and
apsa.invoice_id=aia.invoice_id and
aia.invoice_currency_code=fc.currency_code and
aia.party_id=hp.party_id and
aia.vendor_id=asu.vendor_id(+) and
aia.vendor_id=assa.vendor_id(+) and
aia.vendor_site_id=assa.vendor_site_id(+)
order by
hou.name,
aia.invoice_currency_code,
apsa.due_date,
hp.party_name,
aia.invoice_num