/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Purchasing Document Upload
-- Description: Upload to create and update purchase documents
-- Excel Examle Output: https://www.enginatics.com/example/po-purchasing-document-upload/
-- Library Link: https://www.enginatics.com/reports/po-purchasing-document-upload/
-- Run Report: https://demo.enginatics.com/

with document_types_ as
(
select /*+ inline */
case when pdtav.document_type_code='QUOTATION' then pdtav.document_type_code else pdtav.document_subtype end document_type,
pdtav.type_name document_type_name
from
po_document_types_all_vl pdtav,
hr_all_organization_units_vl haouv
where
2=2 and
3=3 and
pdtav.org_id=haouv.organization_id and
pdtav.document_type_code in ('PO','PA','QUOTATION') and
pdtav.document_subtype in ('BLANKET','CONTRACT','STANDARD')
),
po_lines_ as
(
select /*+ inline */
pla.po_line_id,
pla.note_to_vendor,
pla.line_reference_num,
pla.po_header_id,
pla.line_num,
pltt.line_type,
msiv.concatenated_segments item,
pla.unit_meas_lookup_code unit_of_measure,
pla.unit_price,
xxen_util.meaning(pla.allow_price_override_flag,'YES_NO',0) allow_price_override,
pla.not_to_exceed_price limit_price,
pla.quantity line_quantity,
pla.item_description description,
pla.vendor_product_num supplier_item,
mcv.category_concat_segs category,
xxen_util.display_flexfield_context(201,'PO_LINES',pla.attribute_category) line_dff_context,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE1',pla.rowid,pla.attribute1) line_attribute1,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE2',pla.rowid,pla.attribute2) line_attribute2,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE3',pla.rowid,pla.attribute3) line_attribute3,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE4',pla.rowid,pla.attribute4) line_attribute4,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE5',pla.rowid,pla.attribute5) line_attribute5,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE6',pla.rowid,pla.attribute6) line_attribute6,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE7',pla.rowid,pla.attribute7) line_attribute7,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE8',pla.rowid,pla.attribute8) line_attribute8,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE9',pla.rowid,pla.attribute9) line_attribute9,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE10',pla.rowid,pla.attribute10) line_attribute10,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE11',pla.rowid,pla.attribute11) line_attribute11,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE12',pla.rowid,pla.attribute12) line_attribute12,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE13',pla.rowid,pla.attribute13) line_attribute13,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE14',pla.rowid,pla.attribute14) line_attribute14,
xxen_util.display_flexfield_value(201,'PO_LINES',pla.attribute_category,'ATTRIBUTE15',pla.rowid,pla.attribute15) line_attribute15
from
po_lines_all pla,
po_line_types_tl pltt,
mtl_categories_v mcv,
mtl_system_items_vl msiv
where
nvl(pla.cancel_flag,'N')='N' and
nvl(pla.closed_code,'OPEN')<>'FINALLY CLOSED' and
pltt.language=userenv('lang') and
pltt.line_type_id=pla.line_type_id and
pla.category_id=mcv.category_id(+) and
msiv.inventory_item_id(+) = pla.item_id and
msiv.organization_id(+) = xxen_po_upload.get_inv_org_id(pla.org_id)
),
po_line_locations_ as
(
select /*+ inline */
plla.po_line_id,
plla.line_location_id,
plla.shipment_num,
plla.quantity ship_quantity,
plla.price_override break_price,
plla.unit_meas_lookup_code break_unit_of_measure,
plla.price_discount discount,
mp.organization_code ship_to_organization_code,
hla.location_code ship_to_location_code,
plla.need_by_date,
plla.promised_date,
xxen_util.display_flexfield_context(201,'PO_LINE_LOCATIONS',plla.attribute_category) line_location_dff_context,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE1',plla.rowid,plla.attribute1) line_location_attribute1,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE2',plla.rowid,plla.attribute2) line_location_attribute2,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE3',plla.rowid,plla.attribute3) line_location_attribute3,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE4',plla.rowid,plla.attribute4) line_location_attribute4,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE5',plla.rowid,plla.attribute5) line_location_attribute5,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE6',plla.rowid,plla.attribute6) line_location_attribute6,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE7',plla.rowid,plla.attribute7) line_location_attribute7,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE8',plla.rowid,plla.attribute8) line_location_attribute8,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE9',plla.rowid,plla.attribute9) line_location_attribute9,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE10',plla.rowid,plla.attribute10) line_location_attribute10,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE11',plla.rowid,plla.attribute11) line_location_attribute11,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE12',plla.rowid,plla.attribute12) line_location_attribute12,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE13',plla.rowid,plla.attribute13) line_location_attribute13,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE14',plla.rowid,plla.attribute14) line_location_attribute14,
xxen_util.display_flexfield_value(201,'PO_LINE_LOCATIONS',plla.attribute_category,'ATTRIBUTE15',plla.rowid,plla.attribute15) line_location_attribute15
from
po_line_locations_all plla,
mtl_parameters mp,
hr_locations_all hla
where
plla.ship_to_location_id=hla.location_id(+) and
plla.ship_to_organization_id=mp.organization_id(+) and
plla.po_release_id is null
)
select
null action_,
null status_,
null message_,
null modified_columns_,
pha.org_id,
to_number(null) request_id_,
to_number(null) interface_header_id,
pha.po_header_id,
pha.segment1 po_number,
null group_,
null document_number,
pha.revision_num,
pha.creation_date,
pt.document_type_name document_type,
po_headers_sv3.get_po_status(pha.po_header_id) document_status,
pha.start_date effective_start_date,
pha.end_date effective_end_date,
pha.currency_code,
gdct.user_conversion_type rate_type,
pha.rate_date,
pha.rate,
pha.reference_num header_reference_num,
pha.comments header_description,
papf.full_name buyer,
pv.vendor_name supplier_name,
pvsa.vendor_site_code supplier_site,
pha.blanket_total_amount amount_agreed,
xxen_util.meaning(pha.global_agreement_flag,'YES_NO',0) global_agreement,
pha.quote_warning_delay,
pha.note_to_vendor header_note_to_vendor,
pha.note_to_receiver header_note_to_receiver,
xxen_util.display_flexfield_context(201,'PO_HEADERS',pha.attribute_category) header_dff_context,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE1',pha.rowid,pha.attribute1) header_attribute1,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE2',pha.rowid,pha.attribute2) header_attribute2,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE3',pha.rowid,pha.attribute3) header_attribute3,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE4',pha.rowid,pha.attribute4) header_attribute4,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE5',pha.rowid,pha.attribute5) header_attribute5,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE6',pha.rowid,pha.attribute6) header_attribute6,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE7',pha.rowid,pha.attribute7) header_attribute7,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE8',pha.rowid,pha.attribute8) header_attribute8,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE9',pha.rowid,pha.attribute9) header_attribute9,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE10',pha.rowid,pha.attribute10) header_attribute10,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE11',pha.rowid,pha.attribute11) header_attribute11,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE12',pha.rowid,pha.attribute12) header_attribute12,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE13',pha.rowid,pha.attribute13) header_attribute13,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE14',pha.rowid,pha.attribute14) header_attribute14,
xxen_util.display_flexfield_value(201,'PO_HEADERS',pha.attribute_category,'ATTRIBUTE15',pha.rowid,pha.attribute15) header_attribute15,
hla2.location_code header_ship_to_location,
hla1.location_code header_bill_to_location,
to_number(null) interface_line_id,
pl.po_line_id,
pl.line_num,
pl.line_reference_num,
pl.line_type,
pl.item,
pl.category,
pl.description,
pl.unit_of_measure,
pl.unit_price price,
pl.allow_price_override,
pl.limit_price,
pl.line_quantity,
pl.supplier_item,
pl.note_to_vendor line_note_to_vendor,
pl.line_dff_context,
pl.line_attribute1,
pl.line_attribute2,
pl.line_attribute3,
pl.line_attribute4,
pl.line_attribute5,
pl.line_attribute6,
pl.line_attribute7,
pl.line_attribute8,
pl.line_attribute9,
pl.line_attribute10,
pl.line_attribute11,
pl.line_attribute12,
pl.line_attribute13,
pl.line_attribute14,
pl.line_attribute15,
to_number(null) interface_line_location_id,
pll.line_location_id,
pll.shipment_num,
pll.ship_quantity,
pll.break_price,
pll.break_unit_of_measure,
--pll.discount,
pll.ship_to_organization_code,
pll.ship_to_location_code,
pll.need_by_date,
pll.promised_date,
pll.line_location_dff_context,
pll.line_location_attribute1,
pll.line_location_attribute2,
pll.line_location_attribute3,
pll.line_location_attribute4,
pll.line_location_attribute5,
pll.line_location_attribute6,
pll.line_location_attribute7,
pll.line_location_attribute8,
pll.line_location_attribute9,
pll.line_location_attribute10,
pll.line_location_attribute11,
pll.line_location_attribute12,
pll.line_location_attribute13,
pll.line_location_attribute14,
pll.line_location_attribute15,
to_number(null) interface_distribution_id,
pda.po_distribution_id,
pda.distribution_num,
pda.quantity_ordered,
gcck.concatenated_segments charge_account,
case when pda.deliver_to_person_id is not null then (select papf.full_name from per_all_people_f papf where papf.person_id=pda.deliver_to_person_id and trunc(sysdate) between papf.effective_start_date and papf.effective_end_date) end requestor,
case when pda.project_id is not null then (select ppev.project_number from pa_projects_expend_v ppev where ppev.project_id=pda.project_id) end project_number,
case when pda.task_id is not null then (select ptaev.task_number from pa_tasks_all_expend_v ptaev where ptaev.task_id= pda.task_id and ptaev.expenditure_org_id=pda.org_id) end task_number,
pda.expenditure_type,
pda.expenditure_item_date expenditure_date,
case when pda.expenditure_organization_id is not null then  (select poev.name from pa_organizations_expend_v poev where poev.organization_id= pda.expenditure_organization_id) end expenditure_org,
xxen_util.display_flexfield_context(201,'PO_DISTRIBUTIONS',pda.attribute_category) distribution_dff_context,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE1',pda.rowid,pda.attribute1) distribution_attribute1,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE2',pda.rowid,pda.attribute2) distribution_attribute2,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE3',pda.rowid,pda.attribute3) distribution_attribute3,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE4',pda.rowid,pda.attribute4) distribution_attribute4,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE5',pda.rowid,pda.attribute5) distribution_attribute5,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE6',pda.rowid,pda.attribute6) distribution_attribute6,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE7',pda.rowid,pda.attribute7) distribution_attribute7,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE8',pda.rowid,pda.attribute8) distribution_attribute8,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE9',pda.rowid,pda.attribute9) distribution_attribute9,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE10',pda.rowid,pda.attribute10) distribution_attribute10,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE11',pda.rowid,pda.attribute11) distribution_attribute11,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE12',pda.rowid,pda.attribute12) distribution_attribute12,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE13',pda.rowid,pda.attribute13) distribution_attribute13,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE14',pda.rowid,pda.attribute14) distribution_attribute14,
xxen_util.display_flexfield_value(201,'PO_DISTRIBUTIONS',pda.attribute_category,'ATTRIBUTE15',pda.rowid,pda.attribute15) distribution_attribute15,
null approval_status,
null create_or_update_items,
null group_lines,
null attachment_category_,
null attachment_title_,
null attachment_description_,
null attachment_type_,
null attachment_content_,
null attachment_file_id_
from
po_headers_all pha,
gl_daily_conversion_types gdct,
per_all_people_f papf,
po_vendors pv,
po_vendor_sites_all pvsa,
hr_locations_all hla1,
hr_locations_all hla2,
po_distributions_all pda,
gl_code_combinations_kfv gcck,
hr_all_organization_units_vl haouv,
document_types_ pt,
po_lines_ pl,
po_line_locations_ pll
where
nvl(:p_create_empty_file,'N')<>'Y' and
1=1 and
2=2 and
pha.org_id=haouv.organization_id and
pha.rate_type=gdct.conversion_type(+) and
pha.type_lookup_code=pt.document_type and
papf.person_id=pha.agent_id and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
pha.vendor_id=pv.vendor_id(+) and
pha.vendor_site_id=pvsa.vendor_site_id(+) and
pha.bill_to_location_id=hla1.location_id(+) and
pha.ship_to_location_id=hla2.location_id(+) and
pha.po_header_id=pl.po_header_id(+) and
pl.po_line_id=pll.po_line_id(+) and
pll.line_location_id=pda.line_location_id(+) and
pda.code_combination_id=gcck.code_combination_id(+) and
nvl(pha.cancel_flag,'N')='N' and
nvl(pha.closed_code,'OPEN')='OPEN' and
nvl(pha.frozen_flag,'N')='N' and
nvl(pha.user_hold_flag,'N')='N'