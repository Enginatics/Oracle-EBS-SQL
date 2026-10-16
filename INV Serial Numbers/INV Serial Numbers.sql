/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Serial Numbers
-- Description: Serial numbers in any status (defined, in stores, issued out of stores, in transit, in receiving, in WIP), one row per serial number, with current organization, subinventory and locator, the last transaction source, the customer of a serial issued on a sales order and the genealogy parent.
-- Organization is the current organization; for an issued serial it is the organization that issued it. Customer is the sold-to customer of the sales order of the last transaction, blank when the order no longer exists. Last Transaction Type and Date are blank where Oracle did not record the last transaction on the serial.
-- Use INV Transaction Register (Serial Number Detail) for the full transaction history of a serial.
-- Excel Example Output: https://www.enginatics.com/example/inv-serial-numbers/
-- Library Link: https://www.enginatics.com/reports/inv-serial-numbers/
-- Run Report: https://demo.enginatics.com/

select
x.organization_code,
x.item,
x.item_description,
x.serial_number,
xxen_util.meaning(x.current_status,'SERIAL_NUM_STATUS',700) current_status,
mmsv.status_code material_status,
x.revision,
x.lot_number,
x.current_subinventory_code subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where x.current_locator_id=milk.inventory_location_id and x.current_organization_id=milk.organization_id) locator,
wlpn.license_plate_number,
x.initialization_date,
x.completion_date,
x.ship_date,
mtst.transaction_source_type_name last_source_type,
case
when x.last_txn_source_type_id in (2,8,12) then mso.segment1
when x.last_txn_source_type_id=5 then we.wip_entity_name
when x.last_txn_source_type_id=1 then pha.segment1
when x.last_txn_source_type_id=7 then prha.segment1
when x.last_txn_source_type_id=4 then mtrh.request_number
else x.last_txn_source_name
end last_source,
mtt.transaction_type_name last_transaction_type,
mmt.transaction_date last_transaction_date,
hp.party_name customer,
hca.account_number customer_number,
we_o.wip_entity_name original_job,
aps.vendor_name supplier,
x.vendor_serial_number supplier_serial_number,
x.vendor_lot_number supplier_lot_number,
msiv_p.concatenated_segments parent_item,
msn_p.serial_number parent_serial_number,
&dff_columns
xxen_util.user_name(x.created_by) created_by,
x.creation_date,
xxen_util.user_name(x.last_updated_by) last_updated_by,
x.last_update_date
from
(
select
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
msn.rowid row_id,
msn.*,
(select max(mog.parent_object_id) from mtl_object_genealogy mog where msn.gen_object_id=mog.object_id and mog.parent_object_type=2 and mog.end_date_active is null) parent_gen_object_id,
case when msn.last_txn_source_type_id in (2,8) then (
select
max(ooha.header_id)
from
mtl_sales_orders mso,
oe_order_headers_all ooha
where
msn.last_txn_source_id=mso.sales_order_id and
case when mso.segment3=fnd_profile.value('ONT_SOURCE_CODE') then to_number(mso.segment1) end=ooha.order_number and
ooha.order_type_id in (select ottt.transaction_type_id from oe_transaction_types_tl ottt where mso.segment2=ottt.name)
) end order_header_id
from
mtl_parameters mp,
mtl_serial_numbers msn,
mtl_system_items_vl msiv
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=msn.current_organization_id and
msn.current_organization_id=msiv.organization_id and
msn.inventory_item_id=msiv.inventory_item_id
) x,
mtl_material_statuses_vl mmsv,
wms_license_plate_numbers wlpn,
mtl_txn_source_types mtst,
mtl_sales_orders mso,
wip_entities we,
po_headers_all pha,
po_requisition_headers_all prha,
mtl_txn_request_headers mtrh,
mtl_material_transactions mmt,
mtl_transaction_types mtt,
oe_order_headers_all ooha,
hz_cust_accounts hca,
hz_parties hp,
wip_entities we_o,
ap_suppliers aps,
mtl_serial_numbers msn_p,
mtl_system_items_vl msiv_p
where
2=2 and
x.status_id=mmsv.status_id(+) and
x.lpn_id=wlpn.lpn_id(+) and
x.last_txn_source_type_id=mtst.transaction_source_type_id(+) and
case when x.last_txn_source_type_id in (2,8,12) then x.last_txn_source_id end=mso.sales_order_id(+) and
case when x.last_txn_source_type_id=5 then x.last_txn_source_id end=we.wip_entity_id(+) and
case when x.last_txn_source_type_id=1 then x.last_txn_source_id end=pha.po_header_id(+) and
case when x.last_txn_source_type_id=7 then x.last_txn_source_id end=prha.requisition_header_id(+) and
case when x.last_txn_source_type_id=4 then x.last_txn_source_id end=mtrh.header_id(+) and
x.last_transaction_id=mmt.transaction_id(+) and
mmt.transaction_type_id=mtt.transaction_type_id(+) and
x.order_header_id=ooha.header_id(+) and
ooha.sold_to_org_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
x.original_wip_entity_id=we_o.wip_entity_id(+) and
x.original_unit_vendor_id=aps.vendor_id(+) and
x.parent_gen_object_id=msn_p.gen_object_id(+) and
msn_p.inventory_item_id=msiv_p.inventory_item_id(+) and
msn_p.current_organization_id=msiv_p.organization_id(+)
order by
x.organization_code,
x.item,
x.serial_number
