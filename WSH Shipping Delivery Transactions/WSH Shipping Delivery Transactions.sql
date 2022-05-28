/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: WSH Shipping/Delivery Transactions
-- Description: This report provides details of Warehouse Shipping Transactions and Deliveries.

To review details of deliveries only, set the Assigned to Delivery Parameter = 'Yes'
To review details of shipping transaction not yet assigned to a delivery, set the Assigned to Delivery Parameter = 'No'
Set the parameter to null to review all shipping transations regardless of delivery assignment status.

-- Excel Examle Output: https://www.enginatics.com/example/wsh-shipping-delivery-transactions/
-- Library Link: https://www.enginatics.com/reports/wsh-shipping-delivery-transactions/
-- Run Report: https://demo.enginatics.com/

select
 haou2.name selling_operating_unit,
 haou1.name shipping_operating_unit,
 ood.organization_code,
 -- delivery level info
 wnd.delivery_id delivery_note_id,
 wnd.name delivery_note_number,
 trunc(nvl(mmt.transaction_date,wnd.initial_pickup_date)) delivery_note_date,
 xxen_util.meaning(wnd.status_code,'DELIVERY_STATUS',665) delivery_status,
 trunc(mmt.transaction_date) actual_shipment_date,
 trunc(wnd.confirm_date) confirmed_date,
 wnd.confirmed_by,
 -- delivery detail info
 wdd.delivery_detail_id,
 xxen_util.meaning(wdd.released_status,'PICK_STATUS',665) release_status,
 trunc(wpb.creation_date) released_date,
 -- customer details
 hca.account_number customer_number,
 nvl(hca.account_name,hp.party_name) customer_name,
 hcsua.location customer_ship_to_site,
 hz_format_pub.format_address(hl.location_id,null,null,',') customer_ship_to_address,
 wdd.cust_po_number customer_po_number,
 wnd.delivery_id customer_delivery_code,
 wnd.name customer_delivery_name,
 -- delivery item details
 msiv.concatenated_segments item,
 wdd.item_description item_description,
 wdd.requested_quantity,
 decode(wdd.released_status,'Y',nvl(wdd.picked_quantity,wdd.requested_quantity),NULL) picked_qty,
 wdd.shipped_quantity,
 wdd.delivered_quantity,
 wdd.cancelled_quantity,
 wdd.requested_quantity_uom uom,
 -- packing metrics
 wdd.net_weight,
 wdd.gross_weight,
 wdd.weight_uom_code weight_uom,
 wdd.volume,
 wdd.volume_uom_code volume_uom,
 wdd.unit_price,
 wdd.currency_code,
 -- shipment details
 wnd.waybill,
 wsh_util_core.derive_shipment_priority(wnd.delivery_id) shipment_priority,
 wc.freight_code,
 xxen_util.meaning(wnd.ship_method_code,'SHIP_METHOD',3) shipping_method,
 xxen_util.meaning(wnd.freight_terms_code,'FREIGHT_TERMS',660) freight_terms,
 nvl(xxen_util.meaning(wnd.fob_code,'FOB',222),wnd.fob_code) fob,
 wdd.tracking_number,
 wdd.customer_dock_code,
 -- container/lot details
 wdd.container_flag,
 xxen_util.meaning(wdd.container_type_code,'CONTAINER_TYPE',401) container_type,
 wdd.container_name,
 coalesce((select listagg(mtln.lot_number,',') within group (order by mtln.lot_number) -- shipped
           from   mtl_material_transactions mmt,
                  mtl_transaction_lot_numbers mtln
           where  mmt.picking_line_id = wdd.delivery_detail_id
           and    mtln.transaction_id = mmt.transaction_id
          ),
          (select listagg(mtln.lot_number,',') within group (order by mtln.lot_number) -- picked
           from   mtl_material_transactions mmt,
                  mtl_transaction_lot_numbers mtln
           where  mmt.move_order_line_id = wdd.move_order_line_id
           and    nvl(mmt.transaction_quantity,0) < 0 --> to prevent duplicates, just take the -qty trx leg sub to staging.
           and    mtln.transaction_id = mmt.transaction_id
          ),
          wdd.lot_number
         ) lot_numbers,
 -- exceptions
 (select dbms_lob.substr(rtrim(xmlagg(xmlelement(name excptn,wev.description,',').extract('//text()') order by wev.description).GetClobVal(),','),4000,1)
  from   (select distinct
                 wev.delivery_detail_id,
                 wev.description
          from   wsh_exceptions_v wev
          where  wev.status = 'OPEN'
          and    wev.severity = 'ERROR'
         ) wev
  where  wev.delivery_detail_id = wdd.delivery_detail_id
 ) error_exceptions,
 -- source references/invoice details
 wpb.name release_batch,
 coalesce((select mmt.pick_slip_number -- released to warehouse
           from   mtl_material_transactions mmt
           where  mmt.move_order_line_id = wdd.move_order_line_id
           and    mmt.transaction_id = decode(nvl(wdd.transaction_id ,-99),-99,mmt.transaction_id,wdd.transaction_id)
           and    nvl(mmt.transaction_quantity,0) < 0 --> to prevent duplicates, just take the -qty trx leg sub to staging.
           and    mmt.pick_slip_number is not null
           and    wdd.source_code = 'OE'
           and    wdd.released_status != 'S' -- released to warehouse
           and    rownum <= 1
          ),
          (select mtrl.pick_slip_number
           from   mtl_txn_request_lines mtrl
           where  mtrl.line_id = wdd.move_order_line_id
           and    mtrl.pick_slip_number is not null
           and    wdd.source_code = 'OE'
           and    wdd.released_status != 'S' -- released to warehouse
           and    wdd.transaction_id is null
           and    rownum <= 1
          ),
          (select mmtt.pick_slip_number
           from   mtl_material_transactions_temp mmtt
           where  mmtt.move_order_line_id = wdd.move_order_line_id
           and    nvl(mmtt.parent_line_id,0) = 0
           and    mmtt.pick_slip_number is not null
           and    wdd.source_code = 'OE'
           and    wdd.released_status = 'S' -- released to warehouse
           and    rownum <= 1
          ),
          (select mmttp.pick_slip_number
           from   mtl_material_transactions_temp mmtt,
                  mtl_material_transactions_temp mmttp
           where
                  mmttp.transaction_temp_id = mmtt.parent_line_id
           and    mmtt.parent_line_id != mmtt.transaction_temp_id
           and    mmtt.move_order_line_id = wdd.move_order_line_id
           and    nvl(mmtt.parent_line_id,0) = 0
           and    mmttp.pick_slip_number is not null
           and    wdd.source_code = 'OE'
           and    wdd.released_status = 'S' -- released to warehouse
           and    rownum <= 1
          ),
          (select mmtt.pick_slip_number
           from   mtl_material_transactions_temp mmtt
           where
                  mmtt.move_order_line_id = wdd.move_order_line_id
           and    mmtt.parent_line_id = mmtt.transaction_temp_id
           and    mmtt.pick_slip_number is not null
           and    wdd.source_code = 'OE'
           and    wdd.released_status = 'S' -- released to warehouse
           and    rownum <= 1
          )
         ) pick_slip_number,
 (select mtrh.request_number
  from   mtl_txn_request_lines mtrl,
         mtl_txn_request_headers mtrh
  where  mtrl.header_id = mtrh.header_id
  and    mtrl.line_id = wdd.move_order_line_id
 ) move_order_number,
 wdi.sequence_number pack_slip_number,
 xxen_util.meaning(wdd.source_code,'SOURCE_SYSTEM',665) source,
 wdd.source_header_type_name source_document_type,
 wdd.source_header_number source_document_number,
 wdd.source_line_number source_document_line,
 ooha.ordered_date source_document_date,
 rcta.trx_number invoice_number,
 rctla.line_number invoice_line_number,
 rcta.trx_date invoice_date,
 -- date info
 trunc(wdd.date_requested) requested_date,
 trunc(wdd.date_scheduled) scheduled_date,
 trunc(wdd.earliest_pickup_date) earliest_pickup_date,
 trunc(wdd.latest_pickup_date) latest_pickup_date,
 trunc(wdd.earliest_dropoff_date) earliest_dropoff_date,
 trunc(wdd.latest_dropoff_date) latest_dropoff_date,
 trunc(wnd.initial_pickup_date) delivery_initial_pickup_date,
 trunc(wnd.ultimate_dropoff_date) delivery_ultimate_dropoff_date,
 -- ship from/to locations
 wsh_util_core.get_location_description(nvl(wnd.initial_pickup_location_id,wdd.ship_from_location_id), 'NEW UI CODE') ship_from_location,
 wsh_util_core.get_location_description(nvl(wnd.ultimate_dropoff_location_id,wdd.ship_to_location_id), 'NEW UI CODE') ship_to_location,
 wsh_util_core.get_location_description(wdd.deliver_to_location_id, 'NEW UI CODE') deliver_to_location,
 wsh_util_core.get_location_description(nvl(wnd.intmed_ship_to_location_id,wdd.intmed_ship_to_location_id), 'NEW UI CODE') int_med_ship_to_location,
 wsh_util_core.get_location_description(wnd.fob_location_id, 'NEW UI CODE') fob_location,
 -- packing/shipping instructions
 wdd.packing_instructions,
 wdd.shipping_instructions
from
 wsh_delivery_details wdd,
 wsh_delivery_assignments wda,
 wsh_new_deliveries wnd,
 wsh_picking_batches wpb,
 wsh_document_instances wdi,
 wsh_carriers wc,
 mtl_system_items_vl msiv,
 mtl_material_transactions mmt,
 oe_order_headers_all ooha,
 oe_order_lines_all oola,
 ra_customer_trx_lines_all rctla,
 ra_customer_trx_all rcta,
 org_organization_definitions ood,
 hr_all_organization_units haou1,
 hz_cust_accounts hca,
 hz_parties hp,
 hz_cust_site_uses_all hcsua,
 hz_cust_acct_sites_all hcasa,
 hz_party_sites hps,
 hz_locations hl,
 hr_all_organization_units haou2
where
    1=1
and nvl(wdd.line_direction,'O') in ('O','IO')
and wdd.delivery_detail_id = wda.delivery_detail_id (+)
and wda.delivery_id = wnd.delivery_id (+)
and nvl(wnd.shipment_direction, 'O') in ('O','IO')
and wnd.delivery_type (+) = 'STANDARD'
and wdd.batch_id = wpb.batch_id(+)
and wnd.delivery_id = wdi.entity_id(+)
and wdi.entity_name(+) = 'WSH_NEW_DELIVERIES'
and wdi.document_type(+) = 'PACK_TYPE'
and wdd.carrier_id = wc.carrier_id(+)
and wdd.organization_id = msiv.organization_id(+)
and wdd.inventory_item_id = msiv.inventory_item_id(+)
and wdd.delivery_detail_id = mmt.picking_line_id(+)
--
and decode(wdd.source_code,'OE',wdd.source_header_id) = ooha.header_id(+)
and decode(wdd.source_code,'OE',wdd.source_line_id)  = oola.line_id(+)
and rctla.interface_line_context(+) = 'ORDER ENTRY'
and decode(wdd.source_code,'OE',wdd.source_header_number) = rctla.interface_line_attribute1(+)
and decode(wdd.source_code,'OE',wdd.source_header_type_name) = rctla.interface_line_attribute2(+)
and decode(wdd.source_code,'OE',to_char(wdd.source_line_id)) = rctla.interface_line_attribute6(+)
and nvl(rctla.interface_line_attribute3,nvl(wnd.name,'??')) = nvl(wnd.name,'??')
and rctla.customer_trx_id = rcta.customer_trx_id(+)
--
and wdd.organization_id = ood.organization_id(+)
and ood.operating_unit = haou1.organization_id(+)
and wdd.customer_id = hca.cust_account_id(+)
and hca.party_id = hp.party_id(+)
and wdd.ship_to_site_use_id = hcsua.site_use_id(+)
and hcsua.cust_acct_site_id = hcasa.cust_acct_site_id(+)
and hcasa.party_site_id = hps.party_site_id(+)
and hps.location_id = hl.location_id(+)
and hcasa.org_id = haou2.organization_id(+)
--
and (wdd.organization_id is null or exists (select null from org_access_view oav where oav.organization_id = wdd.organization_id and oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id))
and (   haou1.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual)
     or haou2.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual)
     or (haou1.organization_id is null and haou2.organization_id is null)
    )
order by
 selling_operating_unit,
 shipping_operating_unit,
 organization_code,
 delivery_note_date,
 delivery_note_id,
 delivery_detail_id