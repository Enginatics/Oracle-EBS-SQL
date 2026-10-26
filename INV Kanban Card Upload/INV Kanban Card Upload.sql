/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: INV Kanban Card Upload
-- Description: Creates kanban cards for existing pull sequences and updates the size, card status, supply status and descriptive flexfield of kanban cards, as the Kanban Cards window (Inventory > Kanban > Kanban Cards).
-- A new card takes its source from the pull sequence of its item, subinventory and locator; leave Card Number blank to have it generated. Card and supply status changes follow the status transitions the form allows, and a supply status of Empty triggers the replenishment of the card.
-- Cards can be deleted with Delete Card.
-- Excel Example Output: https://www.enginatics.com/example/inv-kanban-card-upload/
-- Library Link: https://www.enginatics.com/reports/inv-kanban-card-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
mkc.kanban_card_id,
mp.organization_code,
mkc.kanban_card_number card_number,
msiv.concatenated_segments item,
msiv.description item_description,
mkc.subinventory_name subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where mkc.locator_id=milk.inventory_location_id and mkc.organization_id=milk.organization_id) locator,
xxen_util.yes(decode(mkc.kanban_card_type,1,'Y')) replenishable,
mkc.kanban_size,
xxen_util.meaning(mkc.card_status,'MTL_KANBAN_CARD_STATUS',700) card_status,
xxen_util.meaning(mkc.supply_status,'MTL_KANBAN_SUPPLY_STATUS',700) supply_status,
mkc.last_print_date printed_on,
xxen_util.meaning(mkc.error_code,'MTL_KANBAN_ERROR_CODE',700) error,
xxen_util.meaning(mkc.source_type,'MTL_KANBAN_SOURCE_TYPE',700) source_type,
(select aps.vendor_name from ap_suppliers aps where mkc.supplier_id=aps.vendor_id) supplier,
(select assa.vendor_site_code from ap_supplier_sites_all assa where mkc.supplier_site_id=assa.vendor_site_id) supplier_site,
(select mp_s.organization_code from mtl_parameters mp_s where mkc.source_organization_id=mp_s.organization_id) source_organization,
mkc.source_subinventory,
(select milk.concatenated_segments from mtl_item_locations_kfv milk where mkc.source_locator_id=milk.inventory_location_id and mkc.source_organization_id=milk.organization_id) source_locator,
(select wl.line_code from wip_lines wl where mkc.wip_line_id=wl.line_id) line_code,
xxen_util.display_flexfield_context(401,'MTL_KANBAN_CARDS',mkc.attribute_category) flexfield_context,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE1',mkc.rowid,mkc.attribute1) kb_attribute1,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE2',mkc.rowid,mkc.attribute2) kb_attribute2,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE3',mkc.rowid,mkc.attribute3) kb_attribute3,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE4',mkc.rowid,mkc.attribute4) kb_attribute4,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE5',mkc.rowid,mkc.attribute5) kb_attribute5,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE6',mkc.rowid,mkc.attribute6) kb_attribute6,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE7',mkc.rowid,mkc.attribute7) kb_attribute7,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE8',mkc.rowid,mkc.attribute8) kb_attribute8,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE9',mkc.rowid,mkc.attribute9) kb_attribute9,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE10',mkc.rowid,mkc.attribute10) kb_attribute10,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE11',mkc.rowid,mkc.attribute11) kb_attribute11,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE12',mkc.rowid,mkc.attribute12) kb_attribute12,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE13',mkc.rowid,mkc.attribute13) kb_attribute13,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE14',mkc.rowid,mkc.attribute14) kb_attribute14,
xxen_util.display_flexfield_value(401,'MTL_KANBAN_CARDS',mkc.attribute_category,'ATTRIBUTE15',mkc.rowid,mkc.attribute15) kb_attribute15,
null delete_card,
to_number(null) upload_row
from
mtl_parameters mp,
mtl_kanban_cards mkc,
mtl_system_items_vl msiv
where
1=1 and
mp.organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
mp.organization_id=mkc.organization_id and
mkc.inventory_item_id=msiv.inventory_item_id and
mkc.organization_id=msiv.organization_id
