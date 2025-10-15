/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Item Reservations
-- Description: Imported from BI Publisher
Description: Item reservations report
Application: Inventory
Source: Item reservations report (XML)
Short Name: INVDRRSV_XML
DB package: INV_INVDRRSV_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/inv-item-reservations/
-- Library Link: https://www.enginatics.com/reports/inv-item-reservations/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code organization,
msiv.concatenated_segments item,
md.revision revision,
mic.category_set_name category_set,
mic.category_concat_segs category,
md.lot_number lot_number,
md.subinventory subinventory,
loc.concatenated_segments locator,
mtst.transaction_source_type_name  source_type,
decode(md.demand_source_type,
  2,mkts.concatenated_segments,
  3,gl1.concatenated_segments,
  5,wip1.wip_entity_name,
  6,mdsp.concatenated_segments,
  8,mkts.concatenated_segments,
    md.demand_source_name
)  source,
trunc(md.requirement_date) requirement_date,
md.primary_uom_quantity reserved_qty,
msiv.primary_uom_code uom,
nvl(md.primary_uom_quantity,0) - md.completed_quantity    remaining_qty
from
mtl_parameters mp,
mtl_demand md,
mtl_system_items_vl msiv,
mtl_item_categories_v mic,
mtl_txn_source_types mtst,
mtl_item_locations_kfv loc,
wip_entities wip1,
mtl_sales_orders_kfv mkts,
mtl_generic_dispositions_kfv mdsp,
gl_code_combinations_kfv gl1
where
1=1 and
md.reservation_type = 2 and
md.row_status_flag = 1 and
md.completed_quantity < md.primary_uom_quantity and
--
md.organization_id = mp.organization_id and
md.inventory_item_id = msiv.inventory_item_id and
md.organization_id = msiv.organization_id and
msiv.inventory_item_id = mic.inventory_item_id and
msiv.organization_id = mic.organization_id and
mic.category_set_name = :p_cat_set_name and
md.demand_source_type = mtst.transaction_source_type_id and
md.locator_id = loc.inventory_location_id(+) and
md.organization_id = loc.organization_id (+) and
decode(md.demand_source_type,5,md.demand_source_header_id) = wip1.wip_entity_id (+) and
decode(md.demand_source_type,5,md.organization_id) = wip1.organization_id (+) and
decode(md.demand_source_type,2,md.demand_source_header_id,8,md.demand_source_header_id) = mkts.sales_order_id(+) and
decode(md.demand_source_type,6,md.demand_source_header_id) = mdsp.disposition_id(+) and
decode(md.demand_source_type,3,md.demand_source_header_id) = gl1.code_combination_id(+)
order by
decode(:P_sort_id,1,to_char(md.requirement_date,'J'),2,msiv.concatenated_segments,3,mtst.transaction_source_type_name,null),
md.requirement_date,
decode(md.demand_source_type,
  2,mkts.concatenated_segments,
  3,gl1.concatenated_segments,
  5,wip1.wip_entity_name,
  6,mdsp.concatenated_segments,
  8,mkts.concatenated_segments,
    md.demand_source_name
),
msiv.concatenated_segments,
md.revision