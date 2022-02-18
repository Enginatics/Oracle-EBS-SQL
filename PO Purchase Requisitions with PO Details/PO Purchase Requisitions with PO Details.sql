/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Purchase Requisitions with PO Details
-- Description: Purchase Requisitions Status with PO Details Report
-- Excel Examle Output: https://www.enginatics.com/example/po-purchase-requisitions-with-po-details/
-- Library Link: https://www.enginatics.com/reports/po-purchase-requisitions-with-po-details/
-- Run Report: https://demo.enginatics.com/

with req as (select 
   haouv.name operating_unit,
   xxen_util.meaning(prha.type_lookup_code,'REQUISITION TYPE',201) requisition_type,
   prha.segment1 requisition_number,
   trunc(prha.creation_date) creation_date,
   xxen_util.user_name(prha.created_by) created_by_user,
   ppx.full_name preparer_name,
   prha.description description,
   nvl(xxen_util.meaning(prha.authorization_status,'AUTHORIZATION STATUS',201) ,prha.authorization_status) status,
   prha.note_to_authorizer note_to_authorizor,
   prha.agent_return_flag agent_return_flag,
   xxen_util.meaning(prha.closed_code,'DOCUMENT STATE',201) closed_status,
   prla.line_num line_number,
   prla.item_revision line_revision,
   trunc(prla.creation_date) line_creation_date,
   xxen_util.meaning(prla.purchase_basis,'PURCHASE BASIS',201) line_type,
   xxen_util.meaning(prla.order_type_lookup_code,'ORDER TYPE',201) line_order_type,
   prla.need_by_date need_by_date,
   ppx2.full_name requestor_name,
   hl.location_code deliver_to_location,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_cat_disp', 'INV', 'MCAT', mc.structure_id, NULL, mc.category_id, 'ALL', 'Y', 'VALUE') category,
   nvl2(prla.item_id ,fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_item_disp', 'INV', 'MSTK', 101, msiv.organization_id, msiv.inventory_item_id, 'ALL', 'Y', 'VALUE') ,null) item,
   nvl(prla.item_description ,msiv.description) line_description,
   prla.unit_meas_lookup_code uom,
   prla.quantity,
   prla.quantity_cancelled,
   prla.quantity_received,
   prla.quantity_delivered,
   prla.unit_price unit_price,
   prla.amount amount,
   prla.note_to_agent note_to_agent,
   xxen_util.meaning(nvl(prla.on_rfq_flag,'N'),'YES/NO',201) on_rfq,
   prla2.line_num parent_req_line_number,
   decode(prla.cancel_flag,'Y','Y',null) cancelled_flag,
   trunc(nvl(prla.cancel_date ,pah.cancelled_date)) cancelled_date,
   nvl(prla.cancel_reason ,pah.cancelled_note) cancelled_reason,
   pah.cancelled_by,
   prla.requisition_header_id,
   prla.requisition_line_id,
   prla.line_location_id
   &lp_req_dist_columns
  from 
   po_requisition_headers_all prha,
   po_requisition_lines_all prla,
   po_requisition_lines_all prla2, 
   &lp_req_dist_tables
   financials_system_params_all fspa,
   gl_ledgers gl,
   hr_all_organization_units_vl haouv,
   per_people_x ppx,
   per_people_x ppx2,
   hr_locations hl,
   mtl_categories mc,
   mtl_system_items_vl msiv,
   (select 
     ppx.full_name cancelled_by,
     pah.action_date cancelled_date,
     pah.note cancelled_note,
     object_id requisition_header_id
    from 
     po_action_history pah,
     per_people_x ppx
    where
     ppx.person_id (+) = pah.employee_ID
     and pah.object_type_code = 'REQUISITION'
     and pah.action_code = 'CANCEL' ) pah
  where
   prla.requisition_header_id = prha.requisition_header_id 
   &lp_req_dist_joins
   and fspa.org_id = prha.org_id
   and gl.ledger_id = fspa.set_of_books_id
   and haouv.organization_id = prha.org_id
   and ppx.person_id = prha.preparer_id
   and ppx2.person_id = prla.to_person_id
   and hl.location_id = prla.deliver_to_location_id
   and mc.category_id = prla.category_id
   and prla2.requisition_line_id (+) = prla.parent_req_line_id
   and msiv.inventory_item_id (+) = prla.item_id
   and nvl(msiv.organization_id ,fspa.inventory_organization_id) = fspa.inventory_organization_id
   and pah.requisition_header_id (+) = prha.requisition_header_id
   and prha.type_lookup_code = 'PURCHASE'
   and nvl(prha.contractor_requisition_flag , 'N') <> 'Y'
   and nvl(prha.authorization_status,'INCOMPLETE') != 'INCOMPLETE'
   and prla.source_type_code = 'VENDOR'
   and 1=1 ),
po as (select 
   haouv.name po_operating_unit,
   asu.vendor_name po_vendor_name,
   asu.segment1 po_vendor_number,
   assa.vendor_site_code po_vendor_site,
   pha.segment1 po_number,
   pra.release_num po_release_num,
   xxen_util.meaning(pha.authorization_status , 'DOCUMENT STATE', 201) po_status,
   xxen_util.meaning(pra.authorization_status , 'DOCUMENT STATE', 201) po_release_status,
   trunc(pha.creation_date) po_creation_date,
   trunc(pra.release_date) po_release_date,
   pha.currency_code po_currency,
   pla.line_num po_line_number,
   pltv.line_type po_line_type,
   nvl2(pla.category_id ,fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_cat_disp', 'INV', 'MCAT', mc.structure_id, NULL, mc.category_id, 'ALL', 'Y', 'VALUE') ,null) po_line_category,
   msiv.item po_line_item,
   nvl(pla.item_description,msiv.description) po_line_description,
   plla.shipment_num po_shipment_number,
   plla.unit_meas_lookup_code po_uom,
   plla.quantity - nvl(plla.quantity_cancelled,0) po_quantity_ordered,
   plla.quantity_accepted po_quantity_accepted,
   plla.quantity_rejected po_quantity_rejected,
   plla.quantity_received po_quantity_received,
   plla.quantity_billed po_quantity_billed,
   nvl(plla.price_override,pla.unit_price) po_unit_price,
   plla.amount - nvl(plla.amount_cancelled,0) po_amount_ordered,
   plla.amount_accepted po_amount_accepted,
   plla.amount_rejected po_amount_rejected,
   plla.amount_received po_amount_received,
   plla.amount_billed po_amount_billed,
   trunc(plla.creation_date) po_shipment_creation_date,
   decode(plla.cancel_flag,'Y','Y',null) po_shipment_cancelled_flag,
   trunc(plla.cancel_date) po_shipment_cancelled_date,
   plla.cancel_reason po_shipment_cancelled_reason,
   xxen_util.user_name(plla.cancelled_by) po_shipment_cancelled_by,
   mp1.organization_code po_ship_to_organization,
   hl1.location_code po_ship_to_location,
   plla.po_header_id,
   plla.po_line_id,
   plla.line_location_id 
   &lp_po_dist_columns
  from 
   po_line_locations_all plla,
   po_lines_all pla,
   po_headers_all pha,
   po_releases_all pra,
   po_line_types_v pltv,
   ap_suppliers asu,
   ap_supplier_sites_all assa,
   financials_system_params_all fspa,
   gl_ledgers gl,
   hr_all_organization_units_vl haouv,
   hr_locations hl1,
   mtl_parameters mp1,
   mtl_categories mc,
   (select 
     fspa.org_id,
     msiv.inventory_item_id,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('c_flex_item_disp', 'INV', 'MSTK', 101, msiv.organization_id, msiv.inventory_item_id, 'ALL', 'Y', 'VALUE') item,
     xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
     msiv.description
    from 
     financials_system_params_all fspa,
     mtl_system_items_vl msiv
    where
     msiv.organization_id = fspa.inventory_organization_id ) msiv
   &lp_po_dist_tables
  where
   pla.po_header_id = pha.po_header_id
   and plla.po_header_id = pla.po_header_id
   and plla.po_line_id = pla.po_line_id
   and pra.po_release_id (+) = plla.po_release_id
   and asu.vendor_id = pha.vendor_id
   and assa.vendor_site_id = pha.vendor_site_id
   and fspa.org_id = pha.org_id
   and gl.ledger_id = fspa.set_of_books_id
   and haouv.organization_id = pha.org_id
   and pltv.line_type_id = pla.line_type_id
   and mc.category_id (+) = pla.category_id
   and msiv.inventory_item_id (+) = pla.item_id
   and msiv.org_id (+) = pla.org_id
   and mp1.organization_id (+) = plla.ship_to_organization_id
   and hl1.location_id (+) = plla.ship_to_location_id
   and trunc(plla.creation_date) >= nvl(:plla_creation_date_from,trunc(plla.creation_date))
   and trunc(plla.creation_date) < nvl(:plla_creation_date_to,trunc(plla.creation_date)) + 1 
   &lp_po_dist_joins
   and 2=2 )
select 
 req.operating_unit,
 req.requisition_type,
 req.requisition_number,
 req.creation_date,
 req.created_by_user,
 req.preparer_name,
 req.description,
 req.status,
 req.closed_status,
 req.cancelled_flag,
 req.cancelled_date,
 req.cancelled_reason,
 req.cancelled_by,
 req.note_to_authorizor,
 req.agent_return_flag,
 req.line_number,
 req.line_revision,
 req.line_type,
 req.line_order_type,
 req.line_creation_date,
 req.need_by_date,
 req.requestor_name,
 req.deliver_to_location,
 req.category,
 req.item,
 req.line_description,
 req.unit_price, 
 &lp_req_line_columns_disp 
 &lp_req_dist_columns_disp
 req.note_to_agent,
 req.on_rfq,
 req.parent_req_line_number,
 po.po_vendor_name,
 po.po_vendor_number,
 po.po_vendor_site,
 po.po_number,
 po.po_release_num,
 po.po_status,
 po.po_release_status,
 po.po_creation_date,
 po.po_release_date,
 po.po_currency,
 po.po_line_number,
 po.po_line_type,
 po.po_line_category,
 po.po_line_item,
 po.po_line_description,
 po.po_shipment_number,
 po.po_ship_to_organization,
 po.po_ship_to_location,
 po.po_unit_price,
 po.po_uom, 
 &lp_po_line_columns_disp 
 &lp_po_dist_columns_disp
 po.po_shipment_creation_date,
 po.po_shipment_cancelled_flag,
 po.po_shipment_cancelled_date,
 po.po_shipment_cancelled_reason,
 po.po_shipment_cancelled_by
from 
 req,
 po
where
 req.line_location_id = po.line_location_id (+) 
 &lp_req_to_po_dist_joins
 and 3=3 
order by 
 req.operating_unit,
 req.creation_date,
 req.requisition_number,
 req.line_number