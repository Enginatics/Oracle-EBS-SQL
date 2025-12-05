/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Requisition Upload
-- Description: Upload to create and update requisitions.

In the generated Excel, the user can amend the following columns for an existing requisition.
-	Header Description
-	Quantity
-	Unit Price
-	Need By Date
-	Reference Number
-	Supplier Item
-	Buyer
-	Note To Buyer
-	Currency
-	Conversion Type
-	Conversion Rate
-	Conversion Date

Additionally, the user can create a requisition by entering the below required fields.
-	Line Type
-        Source Type
-        Item
-	Item Description
-	Category
-	Unit of Measure
-	Quantity
-	Need By Date
-	Destination Type
-	Deliver To Requestor
-	Destination Organization
-	Deliver To Location
-- Excel Examle Output: https://www.enginatics.com/example/po-requisition-upload/
-- Library Link: https://www.enginatics.com/reports/po-requisition-upload/
-- Run Report: https://demo.enginatics.com/

select
--process--
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
to_char(null) row_id,
--header--
null group_code,
prha.creation_date,
prha.requisition_header_id,
prha.segment1 requisition_number,
papf3.full_name preparer,
prha.note_to_authorizer,
--prh.type_lookup_disp requisition_type,
prha.description header_description,
xxen_util.display_flexfield_context(201,'PO_REQUISITION_HEADERS',prha.attribute_category) header_attribute_category,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE1',prha.rowid,prha.attribute1) header_attribute1,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE2',prha.rowid,prha.attribute2) header_attribute2,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE3',prha.rowid,prha.attribute3) header_attribute3,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE4',prha.rowid,prha.attribute4) header_attribute4,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE5',prha.rowid,prha.attribute5) header_attribute5,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE6',prha.rowid,prha.attribute6) header_attribute6,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE7',prha.rowid,prha.attribute7) header_attribute7,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE8',prha.rowid,prha.attribute8) header_attribute8,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE9',prha.rowid,prha.attribute9) header_attribute9,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE10',prha.rowid,prha.attribute10) header_attribute10,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE11',prha.rowid,prha.attribute11) header_attribute11,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE12',prha.rowid,prha.attribute12) header_attribute12,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE13',prha.rowid,prha.attribute13) header_attribute13,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE14',prha.rowid,prha.attribute14) header_attribute14,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_HEADERS',prha.attribute_category,'ATTRIBUTE15',prha.rowid,prha.attribute15) header_attribute15,
prla.requisition_line_id,
prla.line_num,
pltt.line_type,
plc2.displayed_field destination_type,
mpd.organization_code destination_organization,
prla.destination_subinventory,
hlat.location_code deliver_to_location,
papf2.full_name deliver_to_requestor,
plc1.displayed_field source_type,
mps.organization_code source_organization,
prla.source_subinventory,
msiv.concatenated_segments item,
prla.item_description,
prla.item_revision,
mcv.category_concat_segs category,
prla.unit_meas_lookup_code unit_of_measure,
prla.quantity,
prla.unit_price,
prla.need_by_date,
prla.reference_num reference_number,
--source--
prla.suggested_vendor_name supplier,
prla.suggested_vendor_location supplier_site,
prla.suggested_vendor_contact supplier_contact,
prla.suggested_vendor_product_code supplier_item,
--source details--
papf1.full_name buyer,
prla.note_to_agent note_to_buyer,
--currency--
prla.currency_code currency,
prla.rate_type conversion_type,
prla.rate_date conversion_date,
prla.rate conversion_rate,
prla.currency_unit_price,
--
xxen_util.display_flexfield_context(201,'PO_REQUISITION_LINES',prla.attribute_category) line_attribute_category,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE1',prla.rowid,prla.attribute1) line_attribute1,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE2',prla.rowid,prla.attribute2) line_attribute2,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE3',prla.rowid,prla.attribute3) line_attribute3,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE4',prla.rowid,prla.attribute4) line_attribute4,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE5',prla.rowid,prla.attribute5) line_attribute5,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE6',prla.rowid,prla.attribute6) line_attribute6,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE7',prla.rowid,prla.attribute7) line_attribute7,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE8',prla.rowid,prla.attribute8) line_attribute8,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE9',prla.rowid,prla.attribute9) line_attribute9,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE10',prla.rowid,prla.attribute10) line_attribute10,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE11',prla.rowid,prla.attribute11) line_attribute11,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE12',prla.rowid,prla.attribute12) line_attribute12,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE13',prla.rowid,prla.attribute13) line_attribute13,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE14',prla.rowid,prla.attribute14) line_attribute14,
xxen_util.display_flexfield_value(201,'PO_REQUISITION_LINES',prla.attribute_category,'ATTRIBUTE15',prla.rowid,prla.attribute15) line_attribute15,
--distribution accounts--
prda.distribution_id,
prda.distribution_num,
gcc.segment1 charge_account_segment1,
gcc.segment2 charge_account_segment2,
gcc.segment3 charge_account_segment3,
gcc.segment4 charge_account_segment4,
gcc.segment5 charge_account_segment5,
gcc.segment6 charge_account_segment6,
gcc.segment7 charge_account_segment7,
gcc.segment8 charge_account_segment8,
gcc.segment9 charge_account_segment9,
gcc.segment10 charge_account_segment10,
--distribution projects--
prda.project_accounting_context project_accounting,
ppv.segment1 project_number,
ptv.task_number,
prda.expenditure_type,
haouve.name expenditure_organization,
prda.expenditure_item_date,
xxen_util.display_flexfield_context(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category) dist_attribute_category,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE1',prda.rowid,prda.attribute1) dist_attribute1,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE2',prda.rowid,prda.attribute2) dist_attribute2,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE3',prda.rowid,prda.attribute3) dist_attribute3,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE4',prda.rowid,prda.attribute4) dist_attribute4,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE5',prda.rowid,prda.attribute5) dist_attribute5,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE6',prda.rowid,prda.attribute6) dist_attribute6,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE7',prda.rowid,prda.attribute7) dist_attribute7,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE8',prda.rowid,prda.attribute8) dist_attribute8,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE9',prda.rowid,prda.attribute9) dist_attribute9,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE10',prda.rowid,prda.attribute10) dist_attribute10,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE11',prda.rowid,prda.attribute11) dist_attribute11,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE12',prda.rowid,prda.attribute12) dist_attribute12,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE13',prda.rowid,prda.attribute13) dist_attribute13,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE14',prda.rowid,prda.attribute14) dist_attribute14,
xxen_util.display_flexfield_value(201,'PO_REQ_DISTRIBUTIONS',prda.attribute_category,'ATTRIBUTE15',prda.rowid,prda.attribute15) dist_attribute15,

-- defaults
to_char(null) group_by,
to_char(null) initiate_reqappr_after_imp,
to_char(null) interface_source_code,
to_char(null) multi_distributions,
to_char(null) allow_dynamic_ccid,
to_char(null) authorization_status,
to_char(null) attachment_type,
to_char(null) attachment_category,
to_char(null) attachment_title,
to_char(null) attachment_description,
to_char(null) preparer_id,
prha.type_lookup_code requisition_type
from
po_requisition_headers_all prha,
po_requisition_lines_all prla,
po_req_distributions_all prda,
mtl_categories_v mcv,
gl_code_combinations gcc,
pa_projects_all ppv,
pa_tasks_v ptv,
hr_all_organization_units_vl haouve,
mtl_parameters mps,
mtl_parameters mpd,
mtl_system_items_vl msiv,
hr_all_organization_units_vl haouv,
per_all_people_f papf1,
per_all_people_f papf2,
per_all_people_f papf3,
po_lookup_codes plc1,
po_lookup_codes plc2,
hr_locations_all_tl hlat,
po_line_types_tl pltt,
po_document_types_all_tl podt,
po_document_types_all_b podb
where
1=1 and
:p_group_by=:p_group_by and
prha.org_id=haouv.organization_id and
prha.requisition_header_id=prla.requisition_header_id and
prla.requisition_line_id=prda.requisition_line_id and
papf1.person_id(+) = prla.suggested_buyer_id and
trunc (sysdate) between papf1.effective_start_date (+) and papf1.effective_end_date (+) and
plc1.lookup_code = prla.source_type_code and
plc1.lookup_type = 'REQUISITION SOURCE TYPE' and
plc2.lookup_code = prla.destination_type_code and
plc2.lookup_type = 'DESTINATION TYPE' and
podb.document_type_code = 'REQUISITION' and
podb.document_subtype = prha.type_lookup_code and
podb.document_type_code = podt.document_type_code and
podb.document_subtype = podt.document_subtype and
podt.language = userenv ('LANG') and
podt.org_id = podb.org_id and
podb.org_id = prha.org_id and
papf2.person_id = prla.to_person_id and
trunc (sysdate) between papf2.effective_start_date and papf2.effective_end_date and
papf3.person_id = prha.preparer_id and
trunc (sysdate) between papf3.effective_start_date and papf3.effective_end_date and
pltt.line_type_id=prla.line_type_id and
pltt.language=userenv ('LANG') and
hlat.location_id(+) = prla.deliver_to_location_id and
hlat.language(+) = userenv ('LANG') and
nvl(prla.transferred_to_oe_flag,'N')<>'Y' and
nvl(prha.closed_code,'!')<>'FINALLY CLOSED' and
prha.authorization_status not in ('CANCELLED','PRE-APPROVED','IN PROCESS','SYSTEM_SAVED')  and
not exists (
select
1
from
po_distributions_all pda,
po_req_distributions_all prda
where pda.req_distribution_id = prda.distribution_id and
prda.requisition_line_id = prla.requisition_line_id
) and
prla.item_id=msiv.inventory_item_id(+) and
xxen_po_upload.get_inv_org_id(prla.org_id)=msiv.organization_id(+) and
prla.destination_organization_id=mpd.organization_id(+) and
prla.source_organization_id=mps.organization_id(+) and
prla.category_id=mcv.category_id(+) and
prda.code_combination_id=gcc.code_combination_id(+) and
prda.project_id=ppv.project_id(+) and
prda.task_id=ptv.task_id(+) and
prda.expenditure_organization_id=haouve.organization_id(+)