/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Supplier Scheduling On-Time Delivery
-- Description: Supplier on-time delivery (OTD) based on the Oracle Supplier Scheduling (CHV) module instead of the purchase order form. For each firm scheduled release the report compares the scheduling-module requested delivery date against the actual goods receipt date and reports the delivery delay, ordered vs received quantity, and a partial-delivery flag. Designed for environments where the blanket PO holds only a skeleton (with placeholder dates) and the real call-off dates arrive via EDI into Supplier Scheduling. First-pass draft - see version comments for open scoping items.
-- Excel Examle Output: https://www.enginatics.com/example/po-supplier-scheduling-on-time-delivery/
-- Library Link: https://www.enginatics.com/reports/po-supplier-scheduling-on-time-delivery/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.supplier,
x.supplier_number,
x.supplier_site,
x.po_number,
x.po_type,
x.schedule_numbers,
x.schedule_type,
x.item,
x.item_description,
x.ship_to_org,
x.ship_to_location,
x.buyer,
x.requested_delivery_date,
x.latest_scheduled_date,
x.po_promised_date,
x.po_need_by_date,
x.last_edi_date,
x.first_goods_receipt_date,
x.last_goods_receipt_date,
trunc(x.first_goods_receipt_date)-trunc(x.requested_delivery_date) delivery_delay_days,
xxen_util.yes(case when x.first_goods_receipt_date is not null and trunc(x.first_goods_receipt_date)-trunc(x.requested_delivery_date)<=nvl(:on_time_tolerance_days,0) then 'Y' end) on_time,
x.quantity_ordered,
x.quantity_received,
x.quantity_open,
x.uom,
x.partial_delivery,
x.fob,
x.freight_terms,
x.ship_method,
x.asn_date
from
(
select
haouv.name operating_unit,
pv.vendor_name supplier,
pv.segment1 supplier_number,
pvsa.vendor_site_code supplier_site,
poh.segment1 po_number,
xxen_util.meaning(poh.type_lookup_code,'PO TYPE',201) po_type,
chv.schedule_numbers,
decode(chv.schedule_type,'PLAN_SCHEDULE','Planning','SHIP_SCHEDULE','Shipping',chv.schedule_type) schedule_type,
msibk.concatenated_segments item,
msibk.description item_description,
mp.organization_code ship_to_org,
hla.location_code ship_to_location,
(select papf.full_name from per_all_people_f papf where papf.person_id=poh.agent_id and trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and rownum=1) buyer,
chv.first_scheduled_date requested_delivery_date,
chv.last_scheduled_date latest_scheduled_date,
pll.promised_date po_promised_date,
pll.need_by_date po_need_by_date,
chv.last_edi_date last_edi_date,
(select min(rt.transaction_date) from rcv_transactions rt where rt.po_line_location_id=pll.line_location_id and rt.transaction_type='RECEIVE') first_goods_receipt_date,
(select max(rt.transaction_date) from rcv_transactions rt where rt.po_line_location_id=pll.line_location_id and rt.transaction_type='RECEIVE') last_goods_receipt_date,
pll.quantity quantity_ordered,
pll.quantity_received quantity_received,
pll.quantity-nvl(pll.quantity_received,0) quantity_open,
pll.unit_meas_lookup_code uom,
xxen_util.yes(case when nvl(pll.quantity_received,0)>0 and nvl(pll.quantity_received,0)<pll.quantity then 'Y' end) partial_delivery,
xxen_util.meaning(pll.fob_lookup_code,'FOB',201) fob,
xxen_util.meaning(pll.freight_terms_lookup_code,'FREIGHT TERMS',201) freight_terms,
pll.ship_via_lookup_code ship_method,
(select max(rsh.shipped_date) from rcv_shipment_headers rsh,rcv_shipment_lines rsl where rsl.shipment_header_id=rsh.shipment_header_id and rsl.po_line_location_id=pll.line_location_id and rsh.asn_type in ('ASN','ASBN')) asn_date
from
(
select
cio.document_shipment_id line_location_id,
min(cio.due_date) first_scheduled_date,
max(cio.due_date) last_scheduled_date,
listagg(distinct csh.schedule_num,', ') within group (order by csh.schedule_num) schedule_numbers,
max(csh.schedule_type) schedule_type,
max(csh.last_edi_date) last_edi_date
from
chv_item_orders cio,
chv_schedule_headers csh
where
cio.supply_document_type='RELEASE' and
cio.document_shipment_id is not null and
cio.schedule_id=csh.schedule_id
group by
cio.document_shipment_id
) chv,
po_line_locations_all pll,
po_lines_all pol,
po_headers_all poh,
po_vendors pv,
po_vendor_sites_all pvsa,
mtl_system_items_b_kfv msibk,
mtl_parameters mp,
hr_locations_all hla,
hr_all_organization_units_vl haouv
where
chv.line_location_id=pll.line_location_id and
pll.po_line_id=pol.po_line_id and
pll.po_header_id=poh.po_header_id and
poh.vendor_id=pv.vendor_id and
poh.vendor_site_id=pvsa.vendor_site_id(+) and
pol.item_id=msibk.inventory_item_id(+) and
pll.ship_to_organization_id=msibk.organization_id(+) and
pll.ship_to_organization_id=mp.organization_id(+) and
pll.ship_to_location_id=hla.location_id(+) and
pll.org_id=haouv.organization_id(+) and
pll.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)
) x
where
1=1
order by
x.operating_unit,
x.supplier,
x.po_number,
x.requested_delivery_date