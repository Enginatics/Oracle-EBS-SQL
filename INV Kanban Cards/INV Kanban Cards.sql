/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Kanban Cards
-- Description: Kanban cards with their pull sequence, one row per card, including card type, card status, supply status and card kanban size. Replenishment Cycles and Last Activity Date are derived from the card activity history. Only production pull sequences are listed, not those of kanban plans.
-- Pull Sequences Only lists one row per pull sequence without the cards. Show Activity adds one row per card activity (supply status change), with the document that replenished the card.
-- Excel Example Output: https://www.enginatics.com/example/inv-kanban-cards/
-- Library Link: https://www.enginatics.com/reports/inv-kanban-cards/
-- Run Report: https://demo.enginatics.com/

select
mp.organization_code,
msiv.concatenated_segments item,
msiv.description item_description,
mkps.subinventory_name subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where mkps.locator_id=milk.inventory_location_id and mkps.organization_id=milk.organization_id) locator,
xxen_util.meaning(mkps.source_type,'MTL_KANBAN_SOURCE_TYPE',700) source_type,
aps.vendor_name supplier,
assa.vendor_site_code supplier_site,
mp_s.organization_code source_organization,
mkps.source_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where mkps.source_locator_id=milk.inventory_location_id and mkps.source_organization_id=milk.organization_id) source_locator,
wl.line_code production_line,
mkps.replenishment_lead_time,
xxen_util.meaning(mkps.calculate_kanban_flag,'MTL_CALCULATE_KANBAN_FLAG',700) calculate,
mkps.kanban_size,
mkps.number_of_cards,
mkps.minimum_order_quantity,
mkps.fixed_lot_multiplier,
mkps.safety_stock_days,
xxen_util.meaning(mkps.aggregation_type,'MTL_KANBAN_AGGREGATION_TYPE',700) aggregation_type,
mkps.allocation_percent,
msiv.primary_uom_code uom,
mkc.kanban_card_number card_number,
xxen_util.meaning(mkc.kanban_card_type,'MTL_KANBAN_CARD_TYPE',700) card_type,
xxen_util.meaning(mkc.card_status,'MTL_KANBAN_CARD_STATUS',700) card_status,
xxen_util.meaning(mkc.supply_status,'MTL_KANBAN_SUPPLY_STATUS',700) supply_status,
mkc.kanban_size card_kanban_size,
xxen_util.meaning(mkc.error_code,'MTL_KANBAN_ERROR_CODE',700) card_error,
(select count(distinct mkca.replenishment_cycle_id) from mtl_kanban_card_activity mkca where mkc.kanban_card_id=mkca.kanban_card_id) replenishment_cycles,
(select max(mkca.creation_date) from mtl_kanban_card_activity mkca where mkc.kanban_card_id=mkca.kanban_card_id) last_activity_date,
mkc.last_print_date,
&activity_columns
xxen_util.user_name(mkc.created_by) card_created_by,
mkc.creation_date card_creation_date
from
mtl_parameters mp,
mtl_kanban_pull_sequences mkps,
mtl_system_items_vl msiv,
ap_suppliers aps,
ap_supplier_sites_all assa,
mtl_parameters mp_s,
wip_lines wl,
(select mkc.* from mtl_kanban_cards mkc where '&pull_sequences_only' is null) mkc,
(select mkca.* from mtl_kanban_card_activity mkca where '&show_activity'='Y' and 2=2) mkca,
po_headers_all pha,
po_releases_all pra,
po_headers_all pha_r,
po_requisition_headers_all prha,
mtl_txn_request_headers mtrh,
wip_entities we
where
1=1 and
mkps.kanban_plan_id=-1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=mkps.organization_id and
mkps.organization_id=msiv.organization_id and
mkps.inventory_item_id=msiv.inventory_item_id and
mkps.supplier_id=aps.vendor_id(+) and
mkps.supplier_site_id=assa.vendor_site_id(+) and
mkps.source_organization_id=mp_s.organization_id(+) and
mkps.wip_line_id=wl.line_id(+) and
mkps.pull_sequence_id=mkc.pull_sequence_id(+) and
mkc.kanban_card_id=mkca.kanban_card_id(+) and
case when mkca.document_type=1 then mkca.document_header_id end=pha.po_header_id(+) and
case when mkca.document_type=2 then mkca.document_header_id end=pra.po_release_id(+) and
pra.po_header_id=pha_r.po_header_id(+) and
case when mkca.document_type=3 then mkca.document_header_id end=prha.requisition_header_id(+) and
case when mkca.document_type=4 then mkca.document_header_id end=mtrh.header_id(+) and
case when mkca.document_type in (5,6,7,8) then mkca.document_header_id end=we.wip_entity_id(+)
order by
mp.organization_code,
msiv.concatenated_segments,
mkps.subinventory_name,
mkc.kanban_card_number,
mkca.creation_date desc,
mkca.kanban_activity_id desc
