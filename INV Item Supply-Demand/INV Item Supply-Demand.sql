/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Supply/Demand
-- Description: Inventory Item Supply/Demand data as per the standard Inventory Item Supply/Demand form
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-supply-demand/
-- Library Link: https://www.enginatics.com/reports/inv-item-supply-demand/
-- Run Report: https://demo.enginatics.com/

select
sd.item,
sd.item_description,
sd.user_item_type,
sd.organization_code,
sd.organization_name,
&category_set_columns
sd.requirement_date,
sd.supply_demand_type,
sd.identifier,
sd.quantity,
(sum(sd.qty_) over (partition by sd.item, sd.organization_code order by sd.seq)) +  sd.avail_qty_ available_quantity,
sd.onhand_qty_ current_onhand,
sd.avail_qty_ current_available,
sd.reservable_onhand_qty_ current_reservable_onhand,
sd.reservable_avail_qty_ current_reservable_available,
sd.reserved_qty_ current_reserved
from
( select
   rownum seq,
   sd2.*
  from
   (select
     msiv.concatenated_segments item,
     msiv.description item_description,
     xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
     ood.organization_code,
     ood.organization_name,
     msdt.requirement_date,
     xxen_util.meaning(msdt.supply_demand_source_type,'MRP_SUPPLY_DEMAND_SOURCE_TYPE',700) supply_demand_type,
     case msdt.disposition_type
     when 1 then
      (select nvl(clm_document_number,segment1)
       from po_headers_all
       where po_header_id = msdt.disposition_id
      )
     when 2 then
      (select segment1
       from mtl_sales_orders_kfv
       where sales_order_id = msdt.disposition_id
      )
     when 3 then
      (select concatenated_segments
       from gl_code_combinations_kfv
       where code_combination_id = msdt.disposition_id
      )
     when 4 then
      (select wip_entity_name
       from wip_entities
       where wip_entity_id = msdt.disposition_id
      )
     when 5 then
      (select wip_entity_name
       from wip_entities
       where wip_entity_id = msdt.disposition_id
      )
     when 6 then
      (select concatenated_segments
       from mtl_generic_dispositions_kfv
       where organization_id = msdt.organization_id
       and disposition_id = msdt.disposition_id
      )
     when 8 then
      (select shipment_num
       from rcv_shipment_headers
       where shipment_header_id = msdt.disposition_id
      )
     when 10 then
      (select segment1
       from po_requisition_headers_all
       where requisition_header_id = msdt.disposition_id
      )
     when 30 then
      (select schedule_designator
       from mrp_schedule_dates
       where mps_transaction_id = msdt.disposition_id
       and schedule_level = 2
       and supply_demand_type = 2
      )
     when 31 then
      (select request_number
       from mtl_txn_request_headers
       where header_id = msdt.disposition_id
      )
     else
       nvl2(msdt.disposition_type,msdt.c_column1,null)
     end identifier,
     msdt.quantity,
     msdt.on_hand_quantity,
     nvl2(msdt.on_hand_quantity,msdt.quantity,0) qty_,
     nvl(xxen_inv_sd.get_item_start_qty(msdt.inventory_item_id,msdt.organization_id,'ONHAND'),0) onhand_qty_,
     nvl(xxen_inv_sd.get_item_start_qty(msdt.inventory_item_id,msdt.organization_id,'AVAILABLE'),0) avail_qty_,
     nvl(xxen_inv_sd.get_item_start_qty(msdt.inventory_item_id,msdt.organization_id,'RESERVABLE_ONHAND'),0) reservable_onhand_qty_,
     nvl(xxen_inv_sd.get_item_start_qty(msdt.inventory_item_id,msdt.organization_id,'RESERVABLE_AVAILABLE'),0) reservable_avail_qty_,
     nvl(xxen_inv_sd.get_item_start_qty(msdt.inventory_item_id,msdt.organization_id,'RESERVED'),0) reserved_qty_,
     msdt.inventory_item_id,
     msdt.organization_id
    from
     mtl_supply_demand_temp msdt,
     mtl_system_items_vl msiv,
     org_organization_definitions ood
    where
     msiv.organization_id = msdt.organization_id and
     msiv.inventory_item_id = msdt.inventory_item_id and
     ood.organization_id = msdt.organization_id and
     msdt.record_type = 'SD' and
     nvl(msdt.quantity, -1) <> 0 and
     msdt.seq_num in (select to_number(column_value) from table(cast(xxen_inv_sd.get_seq_nums_table() as fnd_table_of_varchar2_30))) and
     1=1
    order by
     msiv.concatenated_segments,
     ood.organization_code,
     msdt.requirement_date,
     msdt.supply_demand_type desc,
     msdt.supply_demand_source_type,
     msdt.quantity,
     decode(sign(msdt.quantity),-1,-1*msdt.on_hand_quantity,msdt.on_hand_quantity)
   ) sd2
) sd