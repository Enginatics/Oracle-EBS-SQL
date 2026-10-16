/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: WSH Pick Confirm Upload
-- Description: WSH Pick Confirm Upload
-- =======================
-- Confirms released sales order pick tasks in bulk from Excel: the picked quantity, the subinventory, locator and lot actually picked, the staging location and, in WMS enabled organizations, the LPN the material was packed into.
-- Download the released to warehouse lines of an organization, optionally restricted to an order, delivery, trip, move order (pick slip), customer or item. One row is created per pick allocation, and per allocated lot for lot controlled items.
-- Overwrite the pre-filled allocation where the pick differs, enter the LPN and upload. Each pick task is confirmed through the standard pick confirm API, which moves the material to the staging subinventory and sets the delivery line to Staged/Pick Confirmed. Unknown LPN names are created as new LPNs in the organization.
-- Parameter Confirm All Downloaded Lines pre-flags every downloaded row, so an unchanged pick list can be uploaded as it is.
-- Parameter Ship Confirm additionally ship confirms a delivery as soon as its last released line has been confirmed by the upload. Unpicked quantities of the delivery are backordered.
-- Serial controlled items are not supported.
-- Excel Example Output: https://www.enginatics.com/example/wsh-pick-confirm-upload/
-- Library Link: https://www.enginatics.com/reports/wsh-pick-confirm-upload/
-- Run Report: https://demo.enginatics.com/

select
case when :confirm_all is not null then xxen_upload.action_meaning(xxen_upload.action_update) end action_,
case when :confirm_all is not null then xxen_upload.status_meaning(xxen_upload.status_new) end status_,
case when :confirm_all is not null then xxen_util.description('U_EXCEL_MSG_VALIDATION_PENDING','XXEN_REPORT_TRANSLATIONS',0) end message_,
null modified_columns_,
:ship_confirm ship_confirm,
x.*,
0 upload_row
from
(
select
mp.organization_code,
ooha.order_number,
rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') line_number,
hp.party_name customer,
hcsua.location ship_to,
wnd.name delivery,
(select listagg(y.name,', ') within group (order by y.name) from (select distinct wt.name, wdl.delivery_id from wsh_delivery_legs wdl, wsh_trip_stops wts, wsh_trips wt where wdl.pick_up_stop_id=wts.stop_id and wts.trip_id=wt.trip_id) y where wnd.delivery_id=y.delivery_id) trip,
mmtt.pick_slip_number pick_slip,
mtrh.request_number move_order,
xxen_util.meaning(wdt.status,'WMS_TASK_STATUS',700) task_status,
msiv.concatenated_segments item,
msiv.description item_description,
wdd.requested_quantity,
mmtt.transaction_uom uom,
mmtt.subinventory_code subinventory,
milk.concatenated_segments locator,
mtlt.lot_number,
nvl(mtlt.transaction_quantity,mmtt.transaction_quantity) picked_quantity,
wlpn.license_plate_number lpn,
mmtt.transfer_subinventory staging_subinventory,
milk_st.concatenated_segments staging_locator,
mmtt.transaction_temp_id,
mmtt.move_order_line_id,
wdd.delivery_detail_id,
mp.organization_id,
mtlt.lot_number allocated_lot
from
mtl_parameters mp,
mtl_material_transactions_temp mmtt,
wsh_delivery_details wdd,
wsh_delivery_assignments wda,
wsh_new_deliveries wnd,
oe_order_lines_all oola,
oe_order_headers_all ooha,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
mtl_transaction_lots_temp mtlt,
mtl_txn_request_lines mtrl,
mtl_txn_request_headers mtrh,
wms_dispatched_tasks wdt,
mtl_system_items_vl msiv,
mtl_item_locations_kfv milk,
mtl_item_locations_kfv milk_st,
wms_license_plate_numbers wlpn
where
1=1 and
mp.organization_id=mmtt.organization_id and
mmtt.transaction_source_type_id=2 and
mmtt.move_order_line_id=wdd.move_order_line_id and
wdd.released_status='S' and
wdd.delivery_detail_id=wda.delivery_detail_id(+) and
wda.delivery_id=wnd.delivery_id(+) and
wdd.source_line_id=oola.line_id and
oola.header_id=ooha.header_id and
ooha.sold_to_org_id=hca.cust_account_id and
hca.party_id=hp.party_id and
oola.ship_to_org_id=hcsua.site_use_id(+) and
mmtt.transaction_temp_id=mtlt.transaction_temp_id(+) and
mmtt.move_order_line_id=mtrl.line_id and
mtrl.header_id=mtrh.header_id and
mmtt.transaction_temp_id=wdt.transaction_temp_id(+) and
mmtt.organization_id=msiv.organization_id and
mmtt.inventory_item_id=msiv.inventory_item_id and
mmtt.locator_id=milk.inventory_location_id(+) and
mmtt.transfer_to_location=milk_st.inventory_location_id(+) and
mmtt.transfer_lpn_id=wlpn.lpn_id(+)
) x
