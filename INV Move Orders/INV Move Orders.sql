/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Move Orders
-- Description: Move order lines of all move order types (requisition, replenishment, pick wave, manufacturing component pick, put away), one row per line, with requested, allocated (detailed), delivered, unallocated and open quantity.
-- Unallocated and open quantity are shown for open lines only. Source shows the sales order, WIP job, purchase order or internal requisition the line was created for; Reference Source and Kanban Card identify replenishment move orders created by kanban, min-max or replenishment counts.
-- Show Allocations lists the pending allocations (subinventory, locator and lot) of each line, repeating the line quantities on each allocation row.
-- Excel Example Output: https://www.enginatics.com/example/inv-move-orders/
-- Library Link: https://www.enginatics.com/reports/inv-move-orders/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
mtrh.request_number move_order,
mtrh.description move_order_description,
xxen_util.meaning(mtrh.move_order_type,'MOVE_ORDER_TYPE',700) move_order_type,
mtt.transaction_type_name transaction_type,
xxen_util.meaning(mtrh.header_status,'MTL_TXN_REQUEST_STATUS',700) header_status,
mtrl.line_number line,
xxen_util.meaning(mtrl.line_status,'MTL_TXN_REQUEST_STATUS',700) line_status,
mtrl.status_date line_status_date,
msiv.concatenated_segments item,
msiv.description item_description,
mtrl.revision,
mtrl.lot_number,
mtrl.serial_number_start serial_number_from,
mtrl.serial_number_end serial_number_to,
mtrl.uom_code uom,
mtrl.quantity,
mtrl.quantity_detailed allocated_quantity,
mtrl.quantity_delivered delivered_quantity,
case when mtrl.line_status in (1,2,3,7,8) then mtrl.quantity-nvl(mtrl.quantity_detailed,0) end unallocated_quantity,
case when mtrl.line_status in (1,2,3,7,8) then mtrl.quantity-nvl(mtrl.quantity_delivered,0) end open_quantity,
mtrl.from_subinventory_code from_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where mtrl.from_locator_id=milk.inventory_location_id and mtrl.organization_id=milk.organization_id) from_locator,
mtrl.to_subinventory_code to_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where mtrl.to_locator_id=milk.inventory_location_id and nvl(mtrl.to_organization_id,mtrl.organization_id)=milk.organization_id) to_locator,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where mtrl.to_account_id=gcck.code_combination_id) to_account,
mtrl.date_required,
mtst.transaction_source_type_name source_type,
case
when mtrl.transaction_source_type_id in (2,8,12) then coalesce(to_char(ooha.order_number),mso.segment1)
when mtrl.transaction_source_type_id=5 then we.wip_entity_name
when mtrl.transaction_source_type_id=1 then pha.segment1
when mtrl.transaction_source_type_id=7 then prha.segment1
end source,
case
when mtrl.transaction_source_type_id in (2,8,12) then oola.line_number||'.'||oola.shipment_number
when mtrl.transaction_source_type_id=1 then pla.line_num||'.'||plla.shipment_num
when mtrl.transaction_source_type_id=7 then to_char(prla.line_num)
end source_line,
case when mtrh.move_order_type=5 then mtrl.txn_source_line_id end operation_seq,
(select wnd.name from wsh_delivery_assignments wda, wsh_new_deliveries wnd where mtrl.txn_source_line_detail_id=wda.delivery_detail_id and wda.delivery_id=wnd.delivery_id) delivery,
hp.party_name customer,
xxen_util.meaning(mtrl.reference_type_code,'MTL_TXN_REQUEST_SOURCE',700) reference_source,
mkc.kanban_card_number kanban_card,
mtr.reason_name reason,
mtrl.reference,
ppa.segment1 project,
pt.task_number task,
mtrl.pick_slip_number,
&allocation_columns
&dff_columns
xxen_util.user_name(mtrl.created_by) created_by,
xxen_util.client_time(mtrl.creation_date) creation_date,
xxen_util.user_name(mtrl.last_updated_by) last_updated_by,
xxen_util.client_time(mtrl.last_update_date) last_update_date
from
mtl_parameters mp,
mtl_txn_request_headers mtrh,
mtl_txn_request_lines mtrl,
mtl_system_items_vl msiv,
mtl_transaction_types mtt,
mtl_txn_source_types mtst,
mtl_sales_orders mso,
oe_order_lines_all oola,
oe_order_headers_all ooha,
hz_cust_accounts hca,
hz_parties hp,
wip_entities we,
po_line_locations_all plla,
po_lines_all pla,
po_headers_all pha,
rcv_shipment_lines rsl,
po_requisition_lines_all prla,
po_requisition_headers_all prha,
mtl_kanban_cards mkc,
mtl_transaction_reasons mtr,
pa_projects_all ppa,
pa_tasks pt,
(select mmtt.* from mtl_material_transactions_temp mmtt where '&show_allocations'='Y') mmtt
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=mtrl.organization_id and
mtrl.header_id=mtrh.header_id and
mtrl.organization_id=msiv.organization_id and
mtrl.inventory_item_id=msiv.inventory_item_id and
mtrl.transaction_type_id=mtt.transaction_type_id(+) and
mtrl.transaction_source_type_id=mtst.transaction_source_type_id(+) and
case when mtrl.transaction_source_type_id in (2,8) then mtrl.txn_source_id end=mso.sales_order_id(+) and
case when mtrl.transaction_source_type_id in (2,8) then mtrl.txn_source_line_id when mtrl.transaction_source_type_id=12 and mtrl.reference='ORDER_LINE_ID' then mtrl.reference_id end=oola.line_id(+) and
oola.header_id=ooha.header_id(+) and
ooha.sold_to_org_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
case when mtrl.transaction_source_type_id=5 then mtrl.txn_source_id end=we.wip_entity_id(+) and
case when mtrl.reference='PO_LINE_LOCATION_ID' then mtrl.reference_id end=plla.line_location_id(+) and
plla.po_line_id=pla.po_line_id(+) and
plla.po_header_id=pha.po_header_id(+) and
case when mtrl.reference='SHIPMENT_LINE_ID' then mtrl.reference_id end=rsl.shipment_line_id(+) and
rsl.requisition_line_id=prla.requisition_line_id(+) and
prla.requisition_header_id=prha.requisition_header_id(+) and
case when mtrl.reference_type_code=1 then mtrl.reference_id end=mkc.kanban_card_id(+) and
mtrl.reason_id=mtr.reason_id(+) and
mtrl.project_id=ppa.project_id(+) and
mtrl.task_id=pt.task_id(+) and
mtrl.line_id=mmtt.move_order_line_id(+)
order by
mp.organization_code,
mtrh.request_number,
mtrl.line_number
