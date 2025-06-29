/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Purchase Requisitions with PO Details
-- Description: Purchase Requisitions Status with PO Details Report
-- Excel Examle Output: https://www.enginatics.com/example/po-purchase-requisitions-with-po-details/
-- Library Link: https://www.enginatics.com/reports/po-purchase-requisitions-with-po-details/
-- Run Report: https://demo.enginatics.com/

with req as (
select /*+ push_pred(x) */
haouv.name operating_unit,
xxen_util.meaning(prha.type_lookup_code,'REQUISITION TYPE',201) requisition_type,
prha.segment1 requisition_number,
trunc(prha.creation_date) creation_date,
xxen_util.user_name(prha.created_by) created_by_user,
ppx.full_name preparer_name,
prha.description description,
nvl(xxen_util.meaning(prha.authorization_status,'AUTHORIZATION STATUS',201) ,prha.authorization_status) status,
prha.note_to_authorizer,
prha.agent_return_flag agent_return_flag,
xxen_util.meaning(prha.closed_code,'DOCUMENT STATE',201) closed_status,
prla.line_num line_number,
trunc(prla.creation_date) line_creation_date,
xxen_util.meaning(prla.source_type_code,'REQUISITION SOURCE TYPE',201) line_source_type,
xxen_util.meaning(prla.purchase_basis,'PURCHASE BASIS',201) line_type,
xxen_util.meaning(prla.order_type_lookup_code,'ORDER TYPE',201) line_order_type,
msiv.concatenated_segments item,
prla.item_revision item_revision,
(select mck.concatenated_segments from mtl_categories_kfv mck where prla.category_id=mck.category_id) category,
nvl(prla.item_description ,msiv.description) line_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) user_item_type,
(select misv.inventory_item_status_code_tl from mtl_item_status_vl misv where msiv.inventory_item_status_code=misv.inventory_item_status_code) item_status,
xxen_util.meaning(msiv.inventory_item_flag,'YES_NO',0) inventory_item_flag,
xxen_util.meaning(msiv.stock_enabled_flag,'YES_NO',0) stock_enabled_flag,
xxen_util.meaning(msiv.inventory_asset_flag,'YES_NO',0) inventory_asset_flag,
prla.unit_meas_lookup_code uom,
prla.quantity,
prla.quantity_cancelled,
prla.quantity_received,
prla.quantity_delivered,
prla.unit_price unit_price,
nvl(decode(prla.order_type_lookup_code,'RATE', prla.amount,'FIXED PRICE', prla.amount, prla.quantity * prla.unit_price),0) amount,
prla.need_by_date need_by_date,
ppx2.full_name requestor_name,
(select mp.organization_code from mtl_parameters mp where prla.destination_organization_id=mp.organization_id) destination_organization,
nvl(hrl.location_code,(substrb(rtrim(hzl.address1)||'-'||rtrim(hzl.city),1,60))) deliver_to_location,
(select mp.organization_code from mtl_parameters mp where prla.source_organization_id=mp.organization_id) source_organization,
prla.source_subinventory,    
prla.suggested_vendor_name suggested_supplier,
prla.suggested_vendor_location suggested_supplier_site,
prla.suggested_vendor_contact suggested_supplier_contact,
prla.suggested_vendor_product_code supplier_item,
prla.note_to_agent note_to_agent,
xxen_util.meaning(nvl(prla.on_rfq_flag,'N'),'YES/NO',201) on_rfq,
prla2.line_num parent_req_line_number,
xxen_util.yes(prla.cancel_flag) cancelled_flag,
trunc(nvl(prla.cancel_date ,pah.cancelled_date)) cancelled_date,
nvl(prla.cancel_reason,pah.cancelled_note) cancelled_reason,
pah.cancelled_by,
&req_dist_columns
&req_dff_cols
&item_dff_cols
prla.requisition_header_id,
prla.requisition_line_id,
prla.line_location_id,
prha.attribute_category req_hdr_dff_cat,
prha.rowid req_hdr_rowid,
prla.attribute_category req_line_dff_cat,
prla.rowid req_line_rowid,
msiv.attribute_category item_dff_category,
msiv.inventory_item_id,
nvl(prla.destination_organization_id,msiv.organization_id) organization_id,
msiv.rowid item_rowid
from 
po_requisition_headers_all prha,
po_requisition_lines_all prla,
po_requisition_lines_all prla2, 
&req_dist_tables
financials_system_params_all fspa,
gl_ledgers gl,
hr_all_organization_units_vl haouv,
per_people_x ppx,
per_people_x ppx2,
hr_locations hrl,
hz_locations hzl,
mtl_system_items_vl msiv,
(
select
ppx.full_name cancelled_by,
pah.action_date cancelled_date,
pah.note cancelled_note,
pah.object_id requisition_header_id
from 
po_action_history pah,
per_people_x ppx
where
pah.employee_ID=ppx.person_id(+) and 
pah.object_type_code='REQUISITION' and
pah.action_code='CANCEL'
) pah
where
1=1 and
prha.type_lookup_code='PURCHASE' and
nvl(prha.contractor_requisition_flag,'N')<>'Y' and
prha.authorization_status<>'INCOMPLETE' and
prha.requisition_header_id=prla.requisition_header_id and 
&req_dist_joins
fspa.org_id=prha.org_id and
gl.ledger_id=fspa.set_of_books_id and
prha.org_id=haouv.organization_id and
prha.preparer_id=ppx.person_id and
prla.to_person_id=ppx2.person_id and
prla.deliver_to_location_id=hrl.location_id(+) and
prla.deliver_to_location_id=hzl.location_id(+) and
prla.parent_req_line_id=prla2.requisition_line_id(+) and
prla.item_id=msiv.inventory_item_id(+) and
nvl(prla.destination_organization_id,fspa.inventory_organization_id)=nvl(msiv.organization_id,fspa.inventory_organization_id) and
prha.requisition_header_id=pah.requisition_header_id(+)
),
po as (
select /*+ push_pred(x) */
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
(select mck.concatenated_segments from mtl_categories_kfv mck where pla.category_id=mck.category_id) po_line_category,
msiv.item po_line_item,
nvl(pla.item_description,msiv.description) po_line_description,
plla.shipment_num po_shipment_number,
plla.need_by_date po_shipment_need_by_date,
plla.promised_date po_shipment_promised_date,
plla.firm_date po_shipment_firm_date,
plla.unit_meas_lookup_code po_uom,
plla.quantity - nvl(plla.quantity_cancelled,0) po_quantity_ordered,
plla.quantity_accepted po_quantity_accepted,
plla.quantity_rejected po_quantity_rejected,
plla.quantity_received po_quantity_received,
plla.quantity_billed po_quantity_billed,
nvl(plla.price_override,pla.unit_price) po_unit_price,
decode(plla.quantity, null, (plla.amount - nvl(plla.amount_cancelled,0)),(plla.quantity - nvl(plla.quantity_cancelled,0))*nvl2(plla.price_override,plla.price_override,nvl(pla.unit_price,0)))po_amount_ordered,
decode(plla.quantity_accepted,null,plla.amount_accepted,plla.quantity_accepted*nvl(plla.price_override,pla.unit_price))po_amount_accepted,
decode(plla.quantity_rejected,null,plla.amount_rejected,plla.quantity_rejected*nvl(plla.price_override,pla.unit_price))po_amount_rejected,
decode(plla.quantity_received,null,plla.amount_received,plla.quantity_received*nvl(plla.price_override,pla.unit_price))po_amount_received,
plla.amount_billed po_amount_billed,
trunc(plla.creation_date) po_shipment_creation_date,
decode(plla.cancel_flag,'Y','Y',null) po_shipment_cancelled_flag,
trunc(plla.cancel_date) po_shipment_cancelled_date,
plla.cancel_reason po_shipment_cancelled_reason,
xxen_util.user_name(plla.cancelled_by) po_shipment_cancelled_by,
mp1.organization_code po_ship_to_organization,
hl1.location_code po_ship_to_location,
&po_dist_columns
&po_dff_cols
plla.po_header_id,
plla.po_line_id,
plla.line_location_id,
pha.attribute_category po_hdr_dff_cat,
pha.rowid po_hdr_rowid,
pla.attribute_category po_line_dff_cat,
pla.rowid po_line_rowid
from
po_headers_all pha,
po_lines_all pla,
po_line_locations_all plla,
&po_dist_tables
po_releases_all pra,
po_line_types_v pltv,
ap_suppliers asu,
ap_supplier_sites_all assa,
financials_system_params_all fspa,
gl_ledgers gl,
hr_all_organization_units_vl haouv,
hr_locations hl1,
mtl_parameters mp1,
(
select 
fspa.org_id,
msiv.inventory_item_id,
msiv.concatenated_segments item,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
msiv.description
from 
financials_system_params_all fspa,
mtl_system_items_vl msiv
where
msiv.organization_id=fspa.inventory_organization_id
) msiv
where
2=2 and
pha.po_header_id=pla.po_header_id and
pla.po_header_id=plla.po_header_id and
pla.po_line_id=plla.po_line_id and
&po_dist_joins
plla.po_release_id=pra.po_release_id(+) and
pha.vendor_id=asu.vendor_id and
pha.vendor_site_id=assa.vendor_site_id and
pha.org_id=fspa.org_id and
gl.ledger_id=fspa.set_of_books_id and
haouv.organization_id=pha.org_id and
pla.line_type_id=pltv.line_type_id and
pla.item_id=msiv.inventory_item_id(+) and
pla.org_id=msiv.org_id(+) and
plla.ship_to_organization_id=mp1.organization_id(+) and
plla.ship_to_location_id=hl1.location_id(+)
)
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
req.note_to_authorizer,
req.agent_return_flag,
req.line_number,
req.line_source_type,
req.line_type,
req.line_order_type,
req.line_creation_date,
req.item,
req.item_revision,
req.user_item_type,
req.item_status,
req.inventory_item_flag,
req.stock_enabled_flag,
req.inventory_asset_flag,
&category_columns
req.category,
req.line_description,
req.need_by_date,
req.unit_price, 
req.requestor_name,
req.destination_organization,
req.deliver_to_location,
req.source_organization,
req.source_subinventory,
req.suggested_supplier,
req.suggested_supplier_site,
req.suggested_supplier_contact,
req.supplier_item,
&req_line_columns_disp 
&req_dist_columns_disp
req.note_to_agent,
req.on_rfq,
req.parent_req_line_number,
&req_dff_cols_disp
&item_dff_cols_disp
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
po.po_shipment_need_by_date,
po.po_shipment_promised_date,
po.po_shipment_firm_date,
po.po_ship_to_organization,
po.po_ship_to_location,
po.po_unit_price,
po.po_uom, 
&po_line_columns_disp 
&po_dist_columns_disp
&po_dff_cols_disp
po.po_shipment_creation_date,
po.po_shipment_cancelled_flag,
po.po_shipment_cancelled_date,
po.po_shipment_cancelled_reason,
po.po_shipment_cancelled_by
from 
req,
po
where
3=3 and
&req_to_po_dist_joins
req.line_location_id=po.line_location_id(+)
order by 
req.operating_unit,
req.creation_date,
req.requisition_number,
req.line_number