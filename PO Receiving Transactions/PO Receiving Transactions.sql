/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Receiving Transactions
-- Description: Receiving transactions register: one row per receiving transaction (receive, accept, reject, transfer, deliver, return to supplier or receiving, correction) for purchase orders, internal requisitions, RMAs and inter-organization shipments, with the source document, item, quantity and PO price.
-- Quantity In Receiving and Days In Receiving are current values from the receiving supply, populated only on the receive, accept, reject or transfer transaction whose quantity still sits in receiving. Days In Receiving counts from the receipt date.
-- Amount is quantity times PO unit price and is blank for sources without a PO price.
-- Excel Example Output: https://www.enginatics.com/example/po-receiving-transactions/
-- Library Link: https://www.enginatics.com/reports/po-receiving-transactions/
-- Run Report: https://demo.enginatics.com/

select
(select hou.name from hr_operating_units hou where hoi.org_information3=to_char(hou.organization_id)) operating_unit,
mp.organization_code,
rsh.receipt_num receipt_number,
rsl.line_num receipt_line,
xxen_util.client_time(rt.transaction_date) transaction_date,
xxen_util.meaning(rt.transaction_type,'RCV TRANSACTION TYPE',201) transaction_type,
(select xxen_util.meaning(rt_par.transaction_type,'RCV TRANSACTION TYPE',201) from rcv_transactions rt_par where rt.parent_transaction_id=rt_par.transaction_id) parent_transaction_type,
xxen_util.meaning(rt.source_document_code,'SHIPMENT SOURCE DOCUMENT TYPE',201) source_document,
xxen_util.meaning(rsh.receipt_source_code,'SHIPMENT SOURCE TYPE',201) receipt_source,
case rt.source_document_code
when 'PO' then pha.segment1
when 'REQ' then (select prha.segment1 from po_requisition_lines_all prla, po_requisition_headers_all prha where rt.requisition_line_id=prla.requisition_line_id and prla.requisition_header_id=prha.requisition_header_id)
when 'RMA' then (select to_char(ooha.order_number) from oe_order_headers_all ooha where rt.oe_order_header_id=ooha.header_id)
when 'INVENTORY' then rsh.shipment_num
end document_number,
(select pra.release_num from po_releases_all pra where rt.po_release_id=pra.po_release_id) release_number,
case rt.source_document_code
when 'PO' then (select to_char(pla.line_num) from po_lines_all pla where rt.po_line_id=pla.po_line_id)
when 'REQ' then (select to_char(prla.line_num) from po_requisition_lines_all prla where rt.requisition_line_id=prla.requisition_line_id)
when 'RMA' then (select oola.line_number||'.'||oola.shipment_number from oe_order_lines_all oola where rt.oe_order_line_id=oola.line_id)
end document_line,
plla.shipment_num po_shipment_number,
aps.vendor_name supplier,
aps.segment1 supplier_number,
(select assa.vendor_site_code from ap_supplier_sites_all assa where rt.vendor_site_id=assa.vendor_site_id) supplier_site,
(select hp.party_name from hz_cust_accounts hca, hz_parties hp where rt.customer_id=hca.cust_account_id and hca.party_id=hp.party_id) customer,
(select mp_from.organization_code from mtl_parameters mp_from where rsl.from_organization_id=mp_from.organization_id) source_organization,
msiv.concatenated_segments item,
nvl(msiv.description,rsl.item_description) item_description,
rt.unit_of_measure uom,
nvl(rls.quantity,rt.quantity) quantity,
rt.primary_unit_of_measure primary_uom,
nvl(rls.primary_quantity,rt.primary_quantity) primary_quantity,
rt.currency_code currency,
rt.po_unit_price,
nvl(rls.quantity,rt.quantity)*rt.po_unit_price amount,
xxen_util.meaning(rt.destination_type_code,'RCV DESTINATION TYPE',201) destination_type,
rt.subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where rt.locator_id=milk.inventory_location_id and rt.organization_id=milk.organization_id) locator,
(select hla.location_code from hr_locations_all hla where rt.location_id=hla.location_id) receiving_location,
(select hla.location_code from hr_locations_all hla where rt.deliver_to_location_id=hla.location_id) deliver_to_location,
(select max(papf.full_name) keep (dense_rank last order by papf.effective_start_date) from per_all_people_f papf where rt.deliver_to_person_id=papf.person_id) deliver_to_person,
(select max(papf.full_name) keep (dense_rank last order by papf.effective_start_date) from per_all_people_f papf where rt.employee_id=papf.person_id) receiver,
rrh.routing_name routing,
xxen_util.meaning(rt.inspection_status_code,'INSPECTION STATUS',201) inspection_status,
rt.inspection_quality_code inspection_quality,
(select mtr.reason_name from mtl_transaction_reasons mtr where rt.reason_id=mtr.reason_id) reason,
rs.quantity quantity_in_receiving,
case when rs.rcv_transaction_id is not null then trunc(sysdate)-trunc(nvl(rs.receipt_date,rt.transaction_date)) end days_in_receiving,
&lot_serial_columns
rt.vendor_lot_num supplier_lot,
rt.rma_reference,
nvl(rsl.packing_slip,rsh.packing_slip) packing_slip,
decode(rsh.receipt_source_code,'VENDOR',rsh.shipment_num) asn_number,
rsh.bill_of_lading,
rsh.waybill_airbill_num waybill,
rsh.freight_carrier_code freight_carrier,
plla.need_by_date,
plla.promised_date,
rt.comments,
xxen_util.user_name(rt.created_by) created_by,
xxen_util.client_time(rt.creation_date) creation_date,
rt.transaction_id
from
rcv_transactions rt,
mtl_parameters mp,
hr_organization_information hoi,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
po_headers_all pha,
po_line_locations_all plla,
ap_suppliers aps,
mtl_system_items_vl msiv,
rcv_routing_headers rrh,
rcv_supply rs,
(
select
rlt.transaction_id,
rlt.lot_num,
rlt.expiration_date lot_expiration_date,
to_char(null) serial_num,
rlt.quantity,
rlt.primary_quantity
from
rcv_lot_transactions rlt
where
'&show_lot_serial'='Y' and
rlt.lot_transaction_type='TRANSACTION' and
not exists (select null from rcv_serial_transactions rst where rlt.transaction_id=rst.transaction_id and rst.serial_transaction_type='TRANSACTION')
union all
select
rst.transaction_id,
rst.lot_num,
(select max(rlt.expiration_date) from rcv_lot_transactions rlt where rst.transaction_id=rlt.transaction_id and rst.lot_num=rlt.lot_num and rlt.lot_transaction_type='TRANSACTION') lot_expiration_date,
rst.serial_num,
1 quantity,
1 primary_quantity
from
rcv_serial_transactions rst
where
'&show_lot_serial'='Y' and
rst.serial_transaction_type='TRANSACTION'
) rls
where
1=1 and
rt.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
rt.organization_id=mp.organization_id and
rt.organization_id=hoi.organization_id and
hoi.org_information_context='Accounting Information' and
rt.shipment_header_id=rsh.shipment_header_id and
rt.shipment_line_id=rsl.shipment_line_id and
rt.po_header_id=pha.po_header_id(+) and
rt.po_line_location_id=plla.line_location_id(+) and
rt.vendor_id=aps.vendor_id(+) and
rsl.item_id=msiv.inventory_item_id(+) and
rsl.to_organization_id=msiv.organization_id(+) and
rt.routing_header_id=rrh.routing_header_id(+) and
rt.transaction_id=rs.rcv_transaction_id(+) and
rs.supply_type_code(+)='RECEIVING' and
rt.transaction_id=rls.transaction_id(+)
order by
mp.organization_code,
rt.transaction_date,
rt.transaction_id,
rls.lot_num,
rls.serial_num
