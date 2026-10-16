/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Prepayments Status
-- Description: Prepayments with an unapplied amount and the open, that is unpaid or partially paid, invoices, credit and debit memos of the suppliers holding such a prepayment, one row per invoice.
-- Equivalent to the Oracle standard Prepayments Status Report (APXINPSR). Amount Remaining is in the invoice currency: for a prepayment the amount not yet applied, for other invoices the unpaid payment schedule amount converted at the payment cross rate. Net Amount Remaining nets paid temporary prepayments (negative) against open invoices and permanent prepayments; an unpaid prepayment counts as zero.
-- Show Prepayment Lines adds one row per item line of a paid prepayment that still has an amount available to apply, with its purchase order and receipt.
-- Excel Example Output: https://www.enginatics.com/example/ap-prepayments-status/
-- Library Link: https://www.enginatics.com/reports/ap-prepayments-status/
-- Run Report: https://demo.enginatics.com/

select
z.ledger,
z.operating_unit,
z.supplier,
z.supplier_number,
z.supplier_type,
z.supplier_site,
z.invoice_type,
z.prepayment_type,
z.prepayment_status,
z.invoice_number,
z.voucher_number,
z.invoice_date,
z.invoice_gl_date,
z.earliest_settlement_date,
z.invoice_description,
z.payment_status,
z.invoice_currency,
z.payment_currency,
z.payment_cross_rate,
z.invoice_amount,
z.withheld_amount,
z.amount_remaining,
z.net_amount_remaining,
z.line_number,
z.line_type,
z.line_description,
z.line_amount,
z.line_amount_remaining,
z.po_number,
z.receipt_number,
z.created_by,
z.creation_date,
z.last_updated_by,
z.last_update_date
from
(
select
y.*,
(
select sum(nvl(aida.prepay_amount_remaining,aida.total_dist_amount))
from ap_invoice_distributions_all aida
where y.invoice_id=aida.invoice_id and y.line_number=aida.invoice_line_number and aida.line_type_lookup_code in ('ITEM','ACCRUAL','REC_TAX','NONREC_TAX') and nvl(aida.reversal_flag,'N')<>'Y'
) line_amount_remaining
from
(
select
x.*,
case
when x.invoice_type_lookup_code<>'PREPAYMENT' then x.amount_remaining
when x.payment_status_flag<>'Y' then 0
when x.earliest_settlement_date is null then x.amount_remaining
else -x.amount_remaining
end net_amount_remaining,
max(case when x.invoice_type_lookup_code='PREPAYMENT' then 1 end) over (partition by x.vendor_id, x.org_id) has_prepayment,
ail.line_number,
xxen_util.meaning(ail.line_type_lookup_code,'INVOICE LINE TYPE',200) line_type,
ail.description line_description,
ail.amount line_amount,
pha.segment1 po_number,
rsh.receipt_num receipt_number
from
(
select
gl.name ledger,
haouv.name operating_unit,
aps.vendor_name supplier,
aps.segment1 supplier_number,
xxen_util.meaning(aps.vendor_type_lookup_code,'VENDOR TYPE',201) supplier_type,
assa.vendor_site_code supplier_site,
xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200) invoice_type,
case when aia.invoice_type_lookup_code='PREPAYMENT' then xxen_util.meaning(nvl2(aia.earliest_settlement_date,'TEMPORARY','PERMANENT'),'PREPAY TYPES',200) end prepayment_type,
case when aia.invoice_type_lookup_code='PREPAYMENT' then
xxen_util.meaning(
case
when aia.payment_status_flag<>'Y' then 'UNPAID'
when aia.earliest_settlement_date is null then 'PERMANENT'
else 'AVAILABLE'
end,'PREPAY STATUS',200)
end prepayment_status,
aia.invoice_num invoice_number,
nvl(to_char(aia.doc_sequence_value),aia.voucher_num) voucher_number,
aia.invoice_date,
aia.gl_date invoice_gl_date,
aia.earliest_settlement_date,
aia.description invoice_description,
xxen_util.meaning(aia.payment_status_flag,'INVOICE PAYMENT STATUS',200) payment_status,
aia.invoice_currency_code invoice_currency,
aia.payment_currency_code payment_currency,
aia.payment_cross_rate,
aia.invoice_amount,
(select -sum(aida.amount) from ap_invoice_distributions_all aida where aia.invoice_id=aida.invoice_id and aida.line_type_lookup_code='AWT') withheld_amount,
case when aia.invoice_type_lookup_code='PREPAYMENT' then
(
select sum(nvl(aida.prepay_amount_remaining,aida.total_dist_amount))
from ap_invoice_lines_all ail, ap_invoice_distributions_all aida
where aia.invoice_id=ail.invoice_id and ail.line_type_lookup_code<>'TAX' and nvl(ail.line_selected_for_appl_flag,'N')<>'Y' and ail.invoice_id=aida.invoice_id and ail.line_number=aida.invoice_line_number and aida.line_type_lookup_code in ('ITEM','ACCRUAL','REC_TAX','NONREC_TAX') and nvl(aida.reversal_flag,'N')<>'Y'
)
else ap_utilities_pkg.ap_round_currency((select sum(apsa.amount_remaining) from ap_payment_schedules_all apsa where aia.invoice_id=apsa.invoice_id)/aia.payment_cross_rate,aia.invoice_currency_code)
end amount_remaining,
xxen_util.user_name(aia.created_by) created_by,
xxen_util.client_time(aia.creation_date) creation_date,
xxen_util.user_name(aia.last_updated_by) last_updated_by,
xxen_util.client_time(aia.last_update_date) last_update_date,
aia.invoice_id,
aia.invoice_type_lookup_code,
aia.payment_status_flag,
aia.vendor_id,
aia.org_id
from
ap_invoices_all aia,
ap_suppliers aps,
ap_supplier_sites_all assa,
gl_ledgers gl,
hr_all_organization_units_vl haouv
where
1=1 and
aia.cancelled_date is null and
(aia.invoice_type_lookup_code='PREPAYMENT' and 2=2 or aia.invoice_type_lookup_code<>'PREPAYMENT' and aia.payment_status_flag in ('N','P') and 3=3) and
aia.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
aia.vendor_id=aps.vendor_id and
aia.vendor_site_id=assa.vendor_site_id(+) and
aia.set_of_books_id=gl.ledger_id and
aia.org_id=haouv.organization_id
) x,
ap_invoice_lines_all ail,
po_headers_all pha,
rcv_transactions rt,
rcv_shipment_headers rsh
where
(x.invoice_type_lookup_code<>'PREPAYMENT' or x.amount_remaining>0) and
x.invoice_id=ail.invoice_id(+) and
ail.line_type_lookup_code(+)=case when :show_prepayment_lines='Y' and x.invoice_type_lookup_code='PREPAYMENT' and x.payment_status_flag='Y' then 'ITEM' end and
ail.po_header_id=pha.po_header_id(+) and
ail.rcv_transaction_id=rt.transaction_id(+) and
rt.shipment_header_id=rsh.shipment_header_id(+)
) y
) z
where
z.has_prepayment=1 and
(z.line_number is null or z.line_amount_remaining>0)
order by
z.supplier,
z.invoice_date,
z.invoice_number,
z.line_number
