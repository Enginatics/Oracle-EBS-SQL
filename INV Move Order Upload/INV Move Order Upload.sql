/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Move Order Upload
-- Description: Creates and updates move order requisitions with their lines, approves them, and cancels or closes move order lines, as the Move Orders window (Inventory > Move Orders > Move Orders).
-- Each row carries the move order header and one line. Rows with the same Move Order belong to one move order; leave Move Order blank on new rows to have the number generated, rows with a blank number and the same header values then form one move order.
-- Approve submits the move order for approval as the Approve button of the form: it is approved immediately unless the organization's move order approval timeout requires the approval workflow. Allocating and transacting the approved lines is done in the Transact Move Orders window.
-- Excel Example Output: https://www.enginatics.com/example/inv-move-order-upload/
-- Library Link: https://www.enginatics.com/reports/inv-move-order-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
mtrh.header_id,
mtrl.line_id,
mp.organization_code,
mtrh.request_number move_order,
mtrh.description,
xxen_util.meaning(mtrh.header_status,'MTL_TXN_REQUEST_STATUS',700) header_status,
null approve,
mtrl.line_number,
msiv.concatenated_segments item,
msiv.description item_description,
mtrl.revision,
(select mtt.transaction_type_name from mtl_transaction_types mtt where mtrl.transaction_type_id=mtt.transaction_type_id) transaction_type,
mtrl.date_required,
mtrl.uom_code uom,
mtrl.quantity,
mtrl.quantity_delivered,
mtrl.from_subinventory_code source_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where mtrl.from_locator_id=milk.inventory_location_id and mtrl.organization_id=milk.organization_id) source_locator,
mtrl.lot_number,
mtrl.serial_number_start serial_from,
mtrl.serial_number_end serial_to,
mtrl.to_subinventory_code destination_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where mtrl.to_locator_id=milk.inventory_location_id and mtrl.organization_id=milk.organization_id) destination_locator,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where mtrl.to_account_id=gcck.code_combination_id) destination_account,
(select hla.location_code from hr_locations_all hla where mtrl.ship_to_location_id=hla.location_id) ship_to_location,
(select mtr.reason_name from mtl_transaction_reasons mtr where mtrl.reason_id=mtr.reason_id) reason,
mtrl.reference,
xxen_util.meaning(mtrl.line_status,'MTL_TXN_REQUEST_STATUS',700) line_status,
null line_action,
xxen_util.display_flexfield_context(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category) header_context,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE1',mtrh.rowid,mtrh.attribute1) hdr_attribute1,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE2',mtrh.rowid,mtrh.attribute2) hdr_attribute2,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE3',mtrh.rowid,mtrh.attribute3) hdr_attribute3,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE4',mtrh.rowid,mtrh.attribute4) hdr_attribute4,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE5',mtrh.rowid,mtrh.attribute5) hdr_attribute5,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE6',mtrh.rowid,mtrh.attribute6) hdr_attribute6,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE7',mtrh.rowid,mtrh.attribute7) hdr_attribute7,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE8',mtrh.rowid,mtrh.attribute8) hdr_attribute8,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE9',mtrh.rowid,mtrh.attribute9) hdr_attribute9,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE10',mtrh.rowid,mtrh.attribute10) hdr_attribute10,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE11',mtrh.rowid,mtrh.attribute11) hdr_attribute11,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE12',mtrh.rowid,mtrh.attribute12) hdr_attribute12,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE13',mtrh.rowid,mtrh.attribute13) hdr_attribute13,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE14',mtrh.rowid,mtrh.attribute14) hdr_attribute14,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_HEADERS',mtrh.attribute_category,'ATTRIBUTE15',mtrh.rowid,mtrh.attribute15) hdr_attribute15,
xxen_util.display_flexfield_context(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category) line_context,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE1',mtrl.rowid,mtrl.attribute1) line_attribute1,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE2',mtrl.rowid,mtrl.attribute2) line_attribute2,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE3',mtrl.rowid,mtrl.attribute3) line_attribute3,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE4',mtrl.rowid,mtrl.attribute4) line_attribute4,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE5',mtrl.rowid,mtrl.attribute5) line_attribute5,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE6',mtrl.rowid,mtrl.attribute6) line_attribute6,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE7',mtrl.rowid,mtrl.attribute7) line_attribute7,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE8',mtrl.rowid,mtrl.attribute8) line_attribute8,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE9',mtrl.rowid,mtrl.attribute9) line_attribute9,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE10',mtrl.rowid,mtrl.attribute10) line_attribute10,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE11',mtrl.rowid,mtrl.attribute11) line_attribute11,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE12',mtrl.rowid,mtrl.attribute12) line_attribute12,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE13',mtrl.rowid,mtrl.attribute13) line_attribute13,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE14',mtrl.rowid,mtrl.attribute14) line_attribute14,
xxen_util.display_flexfield_value(401,'MTL_TXN_REQUEST_LINES',mtrl.attribute_category,'ATTRIBUTE15',mtrl.rowid,mtrl.attribute15) line_attribute15,
to_number(null) upload_row
from
mtl_parameters mp,
mtl_txn_request_headers mtrh,
mtl_txn_request_lines mtrl,
mtl_system_items_vl msiv
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=mtrh.organization_id and
mtrh.move_order_type=1 and
mtrh.header_id=mtrl.header_id and
mtrl.inventory_item_id=msiv.inventory_item_id and
mtrl.organization_id=msiv.organization_id
