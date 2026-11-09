/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Receiving Transaction Upload
-- Description: PO Receiving Transaction Upload
-- ================================
-- Create receiving transactions (receipts) against approved standard purchase orders and blanket and scheduled releases.
-- Upload Modes
-- ============
-- Create
-- ------
-- Opens an empty spreadsheet where the user can manually enter PO receiving details.
-- Create, Update
-- --------------
-- Downloads open PO shipment lines with quantities available to receive for the selected organization.
-- The user fills in the Quantity and Transaction Date columns for each line to receive, then uploads.
-- Prerequisites
-- =============
-- - PO must be approved and not cancelled or closed.
-- - PO shipment must have remaining quantity to receive.
-- - Transaction date must be in an open inventory receiving period.
-- Fields
-- ======
-- - Organization Code: Required. The receiving inventory organization.
-- - Operating Unit: Required. The operating unit of the purchase order, one the responsibility can access. Defaults to the operating unit of the receiving organization.
-- - PO Number: Required. The purchase order number.
-- - Release Num: Optional. The release number of a blanket or scheduled release. Leave it empty for a standard purchase order.
-- - Line Num: Required. The PO line number.
-- - Shipment Num: Required. The PO shipment number.
-- - Item Revision: Optional. Item revision (defaults from PO line, override for revision-controlled items).
-- - Quantity: Required. The quantity to receive (must be greater than zero).
-- - Transaction Date: Required. The date of the receipt.
-- - Destination Type: Optional. Inventory, Expense, or Shop Floor (defaults from PO distribution).
-- - Subinventory: Optional. Destination subinventory (defaults from PO distribution).
-- - Locator: Optional. Stock locator within the subinventory (required for locator-controlled subinventories).
-- - Deliver To Location: Optional. Override the deliver-to location.
-- - Country of Origin: Optional. Country of origin for trade compliance.
-- - Vendor Lot Num: Optional. Supplier lot number for lot tracking.
-- - Comments: Optional. Receipt comments.
-- Excel Example Output: https://www.enginatics.com/example/po-receiving-transaction-upload/
-- Library Link: https://www.enginatics.com/reports/po-receiving-transaction-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) request_id_,
to_char(null) row_id,
mp.organization_code,
(select hou.name from hr_operating_units hou where pha.org_id=hou.organization_id) operating_unit,
aps.vendor_name supplier,
assa.vendor_site_code supplier_site,
pha.segment1 po_number,
pra.release_num,
pla.line_num,
plla.shipment_num,
(select msibk.concatenated_segments from mtl_system_items_b_kfv msibk where pla.item_id=msibk.inventory_item_id and plla.ship_to_organization_id=msibk.organization_id) item,
pla.item_revision,
pla.item_description,
plla.quantity quantity_ordered,
nvl(plla.quantity_received,0) quantity_received,
plla.quantity-nvl(plla.quantity_received,0) quantity_remaining,
pla.unit_meas_lookup_code unit_of_measure,
to_number(null) quantity,
to_date(null) transaction_date,
(select xxen_util.meaning(pda.destination_type_code,'DESTINATION TYPE',201) from po_distributions_all pda where plla.line_location_id=pda.line_location_id and rownum=1) destination_type,
(select pda.destination_subinventory from po_distributions_all pda where plla.line_location_id=pda.line_location_id and rownum=1) subinventory,
to_char(null) locator,
(select hla.location_code from hr_locations_all hla where hla.location_id=(select pda.deliver_to_location_id from po_distributions_all pda where plla.line_location_id=pda.line_location_id and rownum=1)) deliver_to_location,
(select ft.territory_short_name from fnd_territories_vl ft where plla.country_of_origin_code=ft.territory_code) country_of_origin,
cast(null as varchar2(30)) vendor_lot_num,
cast(null as varchar2(240)) comments,
to_number(null) upload_row
from
po_headers_all pha,
ap_suppliers aps,
ap_supplier_sites_all assa,
po_lines_all pla,
po_line_locations_all plla,
po_releases_all pra,
mtl_parameters mp
where
pha.vendor_id=aps.vendor_id and
pha.vendor_site_id=assa.vendor_site_id(+) and
pha.po_header_id=pla.po_header_id and
pla.po_line_id=plla.po_line_id and
plla.po_release_id=pra.po_release_id(+) and
plla.ship_to_organization_id=mp.organization_id and
plla.shipment_type in ('STANDARD','BLANKET','SCHEDULED') and
plla.approved_flag='Y' and
nvl(plla.cancel_flag,'N')='N' and
nvl(plla.closed_code,'OPEN') not in ('FINALLY CLOSED','CLOSED','CLOSED FOR RECEIVING') and
plla.quantity-nvl(plla.quantity_received,0)>0 and
1=1
