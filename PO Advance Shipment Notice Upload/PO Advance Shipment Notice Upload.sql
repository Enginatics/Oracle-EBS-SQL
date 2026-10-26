/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Advance Shipment Notice Upload
-- Description: Creates advance shipment notices (ASN) and advance shipment and billing notices (ASBN) against approved purchase order shipments, as a supplier does in iSupplier Portal or by EDI, and cancels them.
-- Each row is one shipment line. Rows with the same Ship-To Organization, supplier and Shipment Number form one shipment, whose header values are taken from its first row. The supplier and supplier site are those of the purchase order.
-- The rows are loaded into the receiving open interface and processed by the Receiving Transaction Processor; its errors are shown in the Message column.
-- Create, Update downloads the open lines of existing shipments. Cancel Shipment cancels a shipment that has not been received yet, with all of its lines. Shipments shipped more than 12 months ago cannot be cancelled.
-- An ASBN needs Invoice Number, Invoice Date and Invoice Amount; the Receiving Transaction Processor passes its invoice on to Payables Open Interface Import.
-- Excel Example Output: https://www.enginatics.com/example/po-advance-shipment-notice-upload/
-- Library Link: https://www.enginatics.com/reports/po-advance-shipment-notice-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) request_id_,
to_number(null) header_row_id,
to_number(null) line_row_id,
rsh.shipment_header_id,
rsl.shipment_line_id,
mp.organization_code ship_to_organization,
aps.vendor_name supplier,
assa.vendor_site_code supplier_site,
rsh.shipment_num shipment_number,
xxen_util.meaning(rsh.asn_type,'ASN_TYPE',201) asn_type,
rsh.shipped_date shipment_date,
rsh.expected_receipt_date,
rsh.freight_carrier_code freight_carrier,
xxen_util.meaning(rsh.freight_terms,'FREIGHT TERMS',201) freight_terms,
rsh.bill_of_lading,
rsh.packing_slip,
rsh.waybill_airbill_num,
rsh.num_of_containers number_of_containers,
rsh.freight_bill_number,
rsh.gross_weight,
rsh.gross_weight_uom_code gross_weight_uom,
rsh.net_weight,
rsh.net_weight_uom_code net_weight_uom,
rsh.tar_weight tare_weight,
rsh.tar_weight_uom_code tare_weight_uom,
rsh.packaging_code,
rsh.special_handling_code,
rsh.comments,
rsh.invoice_num invoice_number,
rsh.invoice_date,
rsh.invoice_amount,
rsh.tax_amount,
rsh.freight_amount,
(select atv.name from ap_terms_vl atv where rsh.payment_terms_id=atv.term_id) payment_terms,
pha.segment1 po_number,
pra.release_num release_number,
pla.line_num,
plla.shipment_num po_shipment_num,
msiv.concatenated_segments item,
pla.item_description,
rsl.unit_of_measure,
plla.quantity quantity_ordered,
plla.quantity_received,
plla.quantity_shipped,
rsl.quantity_shipped ship_quantity,
rsl.packing_slip line_packing_slip,
rsl.vendor_lot_num,
rsl.container_num,
rsl.truck_num,
(select ftv.territory_short_name from fnd_territories_vl ftv where rsl.country_of_origin_code=ftv.territory_code) country_of_origin,
rsl.comments line_comments,
nvl(xxen_util.meaning(rsl.shipment_line_status_code,'SHIPMENT LINE STATUS',201),rsl.shipment_line_status_code) line_status,
null cancel_shipment,
to_number(null) upload_row
from
mtl_parameters mp,
rcv_shipment_headers rsh,
ap_suppliers aps,
ap_supplier_sites_all assa,
rcv_shipment_lines rsl,
po_line_locations_all plla,
po_lines_all pla,
po_headers_all pha,
po_releases_all pra,
mtl_system_items_vl msiv
where
mp.organization_id=rsh.ship_to_org_id and
rsh.asn_type in ('ASN','ASBN') and
rsh.vendor_id=aps.vendor_id and
rsh.vendor_site_id=assa.vendor_site_id(+) and
rsh.shipment_header_id=rsl.shipment_header_id and
rsl.shipment_line_status_code in ('EXPECTED','PARTIALLY RECEIVED') and
rsl.po_line_location_id=plla.line_location_id and
plla.po_line_id=pla.po_line_id and
pla.po_header_id=pha.po_header_id and
plla.po_release_id=pra.po_release_id(+) and
rsl.item_id=msiv.inventory_item_id(+) and
rsl.to_organization_id=msiv.organization_id(+) and
1=1
