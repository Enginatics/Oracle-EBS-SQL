/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Procure to Pay Tracker
-- Description: One row per purchase order shipment, and per requisition line not yet on a purchase order, with the date of each step from requisition to payment and the accounting and GL posting of the invoice.
-- Requisition columns are those of the first requisition line placed on the shipment. Invoice columns are those of the first invoice matched to the shipment; Invoiced Amount sums its matched item lines. Validation Status reads as in the invoice workbench, Hold Name lists the invoice's unreleased holds, and Amount Remaining is shown on the invoice's first row only, so it can be summed. Paid Date is the latest payment date once the invoice is fully paid.
-- Accounted Date is when final accounting was created for the invoice, GL Posted Date when its journal was posted. Cancelled shipments and requisition lines are left out.
-- Excel Example Output: https://www.enginatics.com/example/po-procure-to-pay-tracker/
-- Library Link: https://www.enginatics.com/reports/po-procure-to-pay-tracker/
-- Run Report: https://demo.enginatics.com/

select
y.operating_unit,
y.supplier,
y.supplier_site,
y.requisition_number,
y.requisition_line,
y.requisition_date,
y.requisition_approved_date,
y.requisition_status,
y.requester,
y.po_number,
y.po_type,
y.po_date,
y.po_approved_date "PO Approved Date",
y.po_status "PO Status",
y.buyer,
y.line_number,
y.item,
y.item_description,
y.category,
y.quantity,
y.uom,
y.unit_price,
y.line_amount,
y.currency,
y.need_by_date,
y.promised_date,
y.receipt_number,
y.received_date,
y.quantity_received,
y.quantity_billed,
y.closure_status,
y.invoice_number,
y.invoice_date,
y.invoice_entered_date,
y.invoiced_amount,
xxen_util.meaning(case when y.distribution_status='APPROVED' and (y.force_revalidation_flag='Y' or y.hold_name is not null) then 'NEEDS REAPPROVAL' else y.distribution_status end,'NLS TRANSLATION',200) validation_status,
y.hold_name,
y.hold_date,
y.due_date,
case when row_number() over (partition by y.invoice_id order by y.po_header_id, y.line_location_id)=1 then y.invoice_remaining end amount_remaining,
y.accounted_date,
y.gl_posted_date "GL Posted Date",
y.payment_number,
y.paid_date
from
(
select
x.*,
prha.segment1 requisition_number,
prla.line_num requisition_line,
prha.creation_date requisition_date,
prha.approved_date requisition_approved_date,
xxen_util.meaning(case when prha.requisition_header_id is not null then nvl(prha.authorization_status,'INCOMPLETE') end,'AUTHORIZATION STATUS',201) requisition_status,
ppx_r.full_name requester,
aia.invoice_num invoice_number,
aia.invoice_date,
aia.creation_date invoice_entered_date,
aia.force_revalidation_flag,
(
select
case
when count(decode(aida.match_status_flag,'A',1))=count(*) then 'APPROVED'
when count(decode(aida.match_status_flag,null,1,'N',1))=count(*) then 'NEVER APPROVED'
else 'NEEDS REAPPROVAL'
end
from
ap_invoice_distributions_all aida
where
aia.invoice_id=aida.invoice_id
having
count(*)>0
) distribution_status,
(
select
regexp_replace(listagg(xxen_util.meaning(aha.hold_lookup_code,'HOLD CODE',200),', ') within group (order by aha.hold_lookup_code),'([^,]+)(, \1)+(,|$)','\1\3')
from
ap_holds_all aha
where
aia.invoice_id=aha.invoice_id and
aha.release_lookup_code is null
) hold_name,
(select min(aha.hold_date) from ap_holds_all aha where aia.invoice_id=aha.invoice_id and aha.release_lookup_code is null) hold_date,
(select min(apsa.due_date) from ap_payment_schedules_all apsa where aia.invoice_id=apsa.invoice_id) due_date,
(select sum(apsa.amount_remaining) from ap_payment_schedules_all apsa where aia.invoice_id=apsa.invoice_id) invoice_remaining,
(
select
max(xah.creation_date)
from
xla.xla_transaction_entities xte,
xla_ae_headers xah
where
aia.set_of_books_id=xte.ledger_id and
xte.application_id=200 and
xte.entity_code='AP_INVOICES' and
nvl(xte.source_id_int_1,-99)=aia.invoice_id and
xte.entity_id=xah.entity_id and
xte.application_id=xah.application_id and
xah.accounting_entry_status_code='F'
) accounted_date,
(
select
max(gjh.posted_date)
from
xla.xla_transaction_entities xte,
xla_ae_headers xah,
xla_ae_lines xal,
gl_import_references gir,
gl_je_headers gjh
where
aia.set_of_books_id=xte.ledger_id and
xte.application_id=200 and
xte.entity_code='AP_INVOICES' and
nvl(xte.source_id_int_1,-99)=aia.invoice_id and
xte.entity_id=xah.entity_id and
xte.application_id=xah.application_id and
xah.accounting_entry_status_code='F' and
xah.gl_transfer_status_code='Y' and
xah.ae_header_id=xal.ae_header_id and
xah.application_id=xal.application_id and
xal.gl_sl_link_id=gir.gl_sl_link_id and
xal.gl_sl_link_table=gir.gl_sl_link_table and
gir.je_header_id=gjh.je_header_id and
gjh.status='P'
) gl_posted_date,
(
select
max(aca.check_number) keep (dense_rank last order by aca.check_date, aca.check_id)
from
ap_invoice_payments_all aipa,
ap_checks_all aca
where
aia.invoice_id=aipa.invoice_id and
aipa.check_id=aca.check_id and
aca.void_date is null
) payment_number,
(
select
max(aca.check_date)
from
ap_invoice_payments_all aipa,
ap_checks_all aca
where
aia.invoice_id=aipa.invoice_id and
aia.payment_status_flag='Y' and
aipa.check_id=aca.check_id and
aca.void_date is null
) paid_date
from
(
select
haouv.name operating_unit,
aps.vendor_name supplier,
assa.vendor_site_code supplier_site,
(select min(prla.requisition_line_id) from po_requisition_lines_all prla where plla.line_location_id=prla.line_location_id) requisition_line_id,
pha.segment1||case when pra.release_num is not null then '-'||pra.release_num end po_number,
xxen_util.meaning(pha.type_lookup_code,'PO TYPE',201) po_type,
nvl2(pra.po_release_id,pra.creation_date,pha.creation_date) po_date,
nvl2(pra.po_release_id,pra.approved_date,pha.approved_date) po_approved_date,
xxen_util.meaning(nvl(nvl2(pra.po_release_id,pra.authorization_status,pha.authorization_status),'INCOMPLETE'),'AUTHORIZATION STATUS',201) po_status,
ppx.full_name buyer,
pla.line_num||'.'||plla.shipment_num line_number,
msiv.concatenated_segments item,
pla.item_description,
mck.concatenated_segments category,
plla.quantity-nvl(plla.quantity_cancelled,0) quantity,
pla.unit_meas_lookup_code uom,
plla.price_override unit_price,
nvl(plla.amount-nvl(plla.amount_cancelled,0),(plla.quantity-nvl(plla.quantity_cancelled,0))*plla.price_override) line_amount,
pha.currency_code currency,
plla.need_by_date,
plla.promised_date,
(
select
max(rsh.receipt_num) keep (dense_rank first order by rt.transaction_date, rt.transaction_id)
from
rcv_transactions rt,
rcv_shipment_headers rsh
where
plla.line_location_id=rt.po_line_location_id and
rt.transaction_type='RECEIVE' and
rt.shipment_header_id=rsh.shipment_header_id
) receipt_number,
(select min(rt.transaction_date) from rcv_transactions rt where plla.line_location_id=rt.po_line_location_id and rt.transaction_type='RECEIVE') received_date,
plla.quantity_received,
plla.quantity_billed,
xxen_util.meaning(nvl(plla.closed_code,'OPEN'),'DOCUMENT STATE',201) closure_status,
(
select
min(aila.invoice_id)
from
ap_invoice_lines_all aila,
ap_invoices_all aia
where
plla.line_location_id=aila.po_line_location_id and
aila.line_type_lookup_code='ITEM' and
nvl(aila.discarded_flag,'N')='N' and
aila.invoice_id=aia.invoice_id and
aia.cancelled_date is null
) invoice_id,
(
select
sum(aila.amount)
from
ap_invoice_lines_all aila,
ap_invoices_all aia
where
plla.line_location_id=aila.po_line_location_id and
aila.line_type_lookup_code='ITEM' and
nvl(aila.discarded_flag,'N')='N' and
aila.invoice_id=aia.invoice_id and
aia.cancelled_date is null
) invoiced_amount,
pha.po_header_id,
plla.line_location_id
from
hr_all_organization_units_vl haouv,
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
po_releases_all pra,
ap_suppliers aps,
ap_supplier_sites_all assa,
per_people_x ppx,
mtl_system_items_vl msiv,
mtl_categories_kfv mck
where
1=1 and
pha.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
haouv.organization_id=pha.org_id and
pha.type_lookup_code in ('STANDARD','BLANKET','PLANNED') and
pha.po_header_id=pla.po_header_id and
pla.po_line_id=plla.po_line_id and
plla.shipment_type in ('STANDARD','BLANKET','SCHEDULED') and
nvl(plla.cancel_flag,'N')='N' and
plla.po_release_id=pra.po_release_id(+) and
pha.vendor_id=aps.vendor_id and
pha.vendor_site_id=assa.vendor_site_id and
nvl2(pra.po_release_id,pra.agent_id,pha.agent_id)=ppx.person_id(+) and
pla.item_id=msiv.inventory_item_id(+) and
plla.ship_to_organization_id=msiv.organization_id(+) and
pla.category_id=mck.category_id(+)
union all
select
haouv.name operating_unit,
aps.vendor_name supplier,
assa.vendor_site_code supplier_site,
prla.requisition_line_id,
null po_number,
null po_type,
to_date(null) po_date,
to_date(null) po_approved_date,
null po_status,
ppx.full_name buyer,
null line_number,
msiv.concatenated_segments item,
prla.item_description,
mck.concatenated_segments category,
prla.quantity-nvl(prla.quantity_cancelled,0) quantity,
prla.unit_meas_lookup_code uom,
prla.unit_price,
nvl(prla.amount,(prla.quantity-nvl(prla.quantity_cancelled,0))*prla.unit_price) line_amount,
gl.currency_code currency,
prla.need_by_date,
to_date(null) promised_date,
null receipt_number,
to_date(null) received_date,
to_number(null) quantity_received,
to_number(null) quantity_billed,
null closure_status,
to_number(null) invoice_id,
to_number(null) invoiced_amount,
to_number(null) po_header_id,
to_number(null) line_location_id
from
hr_all_organization_units_vl haouv,
po_requisition_headers_all prha,
po_requisition_lines_all prla,
financials_system_params_all fspa,
gl_ledgers gl,
ap_suppliers aps,
ap_supplier_sites_all assa,
per_people_x ppx,
mtl_system_items_vl msiv,
mtl_categories_kfv mck
where
2=2 and
prha.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
haouv.organization_id=prha.org_id and
prha.type_lookup_code='PURCHASE' and
nvl(prha.authorization_status,'INCOMPLETE') not in ('SYSTEM_SAVED','CANCELLED','REJECTED','RETURNED') and
prha.requisition_header_id=prla.requisition_header_id and
prla.line_location_id is null and
prla.source_type_code='VENDOR' and
nvl(prla.cancel_flag,'N')='N' and
nvl(prla.closed_code,'OPEN')<>'FINALLY CLOSED' and
prha.org_id=fspa.org_id and
fspa.set_of_books_id=gl.ledger_id and
prla.vendor_id=aps.vendor_id(+) and
prla.vendor_site_id=assa.vendor_site_id(+) and
prla.suggested_buyer_id=ppx.person_id(+) and
prla.item_id=msiv.inventory_item_id(+) and
prla.destination_organization_id=msiv.organization_id(+) and
prla.category_id=mck.category_id(+)
) x,
po_requisition_lines_all prla,
po_requisition_headers_all prha,
per_people_x ppx_r,
ap_invoices_all aia
where
x.requisition_line_id=prla.requisition_line_id(+) and
prla.requisition_header_id=prha.requisition_header_id(+) and
prla.to_person_id=ppx_r.person_id(+) and
x.invoice_id=aia.invoice_id(+)
) y
order by
y.operating_unit,
y.po_header_id,
y.line_location_id,
y.requisition_line_id
