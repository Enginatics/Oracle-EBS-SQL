/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Transaction Upload
-- Description: INV Transaction Upload
======================
This upload can be used to create Inventory Material Transactions.

The following upload modes are supported:

Create – Generates an empty upload file. Transaction details must be entered manually. The Create mode always opens a blank Excel template, regardless of any parameter settings.

Create, Update – Based on the selected parameters, this mode can generate a pre-populated file with details such as item, primary unit of measure, and transaction date (defaulted to today’s date). It also displays the current on-hand quantity for each item, allowing users to transact against existing stock. Additionally, users can create new transactions by entering details manually

Note :
-- For "Account alias issue" transaction Type - Transaction Source needs to be selected for this Transaction Type, Don't select Account Alias.
-- For "Account alias receipt" transaction Type - Transaction Source needs to be selected for this Transaction Type, Don't select Account Alias.
-- For "Account issue" transaction Type - Account Alias needs to be selected for this Transaction Type, Don't select Transaction Source.
-- For "Account receipt" transaction Type - Account Alias needs to be selected for this Transaction Type, Don't select Transaction Source.
-- Excel Examle Output: https://www.enginatics.com/example/inv-transaction-upload/
-- Library Link: https://www.enginatics.com/reports/inv-transaction-upload/
-- Run Report: https://demo.enginatics.com/

select 
null action_,
null status_,
null message_,
null modified_columns_,
to_number(null) source_line_id,
to_number(null) source_header_id,
ood.organization_code organization,
msiv.concatenated_segments item,
msiv.description,
moqd.revision,
moqd.subinventory_code subinventory,
moqd.locator_code locator,
moqd.on_hand_quantity onhand_quantity,
msiv.primary_uom_code uom,
sysdate transaction_date,
to_char(null) transaction_type,
to_char(null) transaction_source,
to_number(null) quantity,
to_char(null) account_alias,
to_char(null) distribution_account,
to_char(null) gl_segment1,
to_char(null) gl_segment2,
to_char(null) gl_segment3,
to_char(null) gl_segment4,
to_char(null) gl_segment5,
to_char(null) gl_segment6,
to_char(null) gl_segment7,
to_char(null) gl_segment8,
to_char(null) gl_segment9,
to_char(null) gl_segment10,
to_char(null) gl_segment11,
to_char(null) gl_segment12,
to_char(null) gl_segment13,
to_char(null) gl_segment14,
to_char(null) gl_segment15,
to_char(null) lpn,
to_char(null) from_serial_number,
to_char(null) to_serial_number, 
to_char(null) transaction_reference,
to_char(null) reason,
to_number(null) transaction_cost,
to_char(null) lot_number,
to_date(null) lot_expiration_date,
to_number(null) lot_quantity,
to_char(null) to_subinv,
to_char(null) to_locator,
to_char(null) location,
to_char(null) source_project,
to_char(null) source_task,
to_char(null) expenditure_type,
to_char(null) expenditure_org,
to_char(null) attribute_category,
to_char(null) inv_trx_attribute1,
to_char(null) inv_trx_attribute2,
to_char(null) inv_trx_attribute3,
to_char(null) inv_trx_attribute4,
to_char(null) inv_trx_attribute5,
to_char(null) inv_trx_attribute6,
to_char(null) inv_trx_attribute7,
to_char(null) inv_trx_attribute8,
to_char(null) inv_trx_attribute9,
to_char(null) inv_trx_attribute10,
to_char(null) inv_trx_attribute11,
to_char(null) inv_trx_attribute12,
to_char(null) inv_trx_attribute13,
to_char(null) inv_trx_attribute14,
to_char(null) inv_trx_attribute15,
0 upload_row
from 
org_organization_definitions ood,
mtl_system_items_vl msiv,
(
select 
moqd1.organization_id,
moqd1.inventory_item_id,
moqd1.subinventory_code,
moqd1.revision,
milk.concatenated_segments locator_code,
sum(primary_transaction_quantity) on_hand_quantity
from 
mtl_onhand_quantities_detail moqd1,
mtl_item_locations_kfv milk,
wms_license_plate_numbers wlpn
where 
moqd1.locator_id=milk.inventory_location_id(+) and
moqd1.lpn_id=wlpn.lpn_id(+)
group by 
moqd1.organization_id,
moqd1.inventory_item_id,
moqd1.subinventory_code,
moqd1.revision,
milk.concatenated_segments
) moqd
where
1=1 and
msiv.organization_id=ood.organization_id and
msiv.mtl_transactions_enabled_flag = 'Y' and 
msiv.organization_id=moqd.organization_id(+) and
msiv.inventory_item_id=moqd.inventory_item_id(+)