/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Approved Supplier List Upload
-- Description: This upload supports the creation and update of Approved Supplier Lists (ASL) in Oracle Purchasing.

The upload supports creation/update/deletion of the following Approved Supplier List entities:
- Approved Supplier Lists (Global and Local)
- Approved Supplier List Attributes. Including Local (Using Organization specific) attributes against a global ASL.
- Source Documents
- Authorizations
- Supplier Capacities
- Supplier Tolerances

Notes:
- You cannot delete Manufacturer ASLs using this upload. There is a restriction in the standard Oracle API used by this upload that prevents this.

- When the ASL attributes for the same Item/Commodity, Supplier, Supplier Site, and Using Organization are repeated in the upload excel, then first row flagged for upload will be used to apply the attribute updates. The attributes on subsequent rows are ignored. 

- The following points are only significant if you define Local Attributes for a Using Organization against a Global ASL:
  Source Documents are associated with the Using Organization of the ASL Attributes 
  Authorizations, Supplier Capacities and Supplier Tolerances are always associated with the Using Organization of the ASL
  
  If you delete a Local ASL defined for a specific using organization against a Global ASL, only the local using organization attributes will be deleted.
  The Global ASL will not be deleted. 

- When downloading existing ASL data into the upload excel, Source Documents, Authorizations, Capacities, and Tolerances are downloaded into separate rows in the excel.
This is to minimize the duplication of data in the excel. However, when entering data for upload Source Documents, Authorizations, Capacities, and Tolerances can be added in the same excel row.
i.e. You can upload an excel row containing a Source Document, Authorization, Capacity, and Tolerance.

- Capacity Entries with a capacity from/to date in the past cannot be updated by this upload due to validations applied in the standard Oracle API used by the upload. It is possible to delete a capacity entry with a capacity from date in the past, but only if the capacity to date is either null or later than the current date.

- By default, Authorizations, Supplier Capacities, and Supplier Tolerances are not included in the downloaded data. The following report parameters may be Yes in order to include these in the download:
  Download Authorizations
  Download Capacities
  Download Tolerances
-- Excel Examle Output: https://www.enginatics.com/example/po-approved-supplier-list-upload/
-- Library Link: https://www.enginatics.com/reports/po-approved-supplier-list-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
:p_upload_mode upload_mode_,
null asl_id,
null att_row_id,
null doc_row_id,
null ath_row_id,
null cap_row_id,
null tol_row_id,
asl.*
from
(
--
-- Q1 ASL Supplier Attributes and Documents
--
select
-- Owning Organization
mp_o.organization_code owning_organization_code,
haout_o.name owning_organization,
-- ASL item/commodity
nvl2(pasl.item_id,'Item','Commodity') type,
mck.concatenated_segments commodity,
msiv.concatenated_segments item,
case when pasl.item_id is not null
then msiv.description
else (select mct.description from mtl_categories_tl mct where mct.category_id = pasl.category_id and mct.language = userenv('lang'))
end description,
--
-- ASL Suppliers
xxen_util.meaning(pasl.vendor_business_type,'ASL_VENDOR_BUSINESS_TYPE',201) supplier_business_type,
aps.vendor_name supplier,
aps.segment1 supplier_number,
ass.vendor_site_code supplier_site,
po_moac_utils_pvt.get_ou_name(ass.org_id) operating_unit,
mm.manufacturer_name manufacturer,
(select mm2.manufacturer_name from po_approved_supplier_list pasl2, mtl_manufacturers mm2 where pasl2.manufacturer_id = mm2.manufacturer_id and pasl2.asl_id = pasl.manufacturer_asl_id) distributor_manufacturer,
xxen_util.meaning(decode(pasl.using_organization_id,-1,'Y','N'),'YES_NO',0) global_asl,
(select pas.status from po_asl_statuses pas where pas.status_id = pasl.asl_status_id) status,
xxen_util.meaning(decode(pasl.disable_flag,'Y','Y',null),'YES_NO',0) disabled,
pasl.primary_vendor_item supplier_item,
pasl.review_by_date review_by_date,
pasl.comments,
pasl.creation_date created,
--
-- ASL Supplier Attributes
mp_u.organization_code using_organization_code,
haout_u.name using_organization,
xxen_util.meaning(decode(paa.using_organization_id,-1,'Y',nvl2(paa.using_organization_id,'N',null)),'YES_NO',0) global_attributes,
null delete_this_asl,
paa.purchasing_unit_of_measure purchasing_uom,
xxen_util.meaning(paa.release_generation_method,'DOC GENERATION METHOD',201) release_method,
paa.price_update_tolerance,
paa.country_of_origin_code country_of_origin,
-- Supplier Scheduling Attributes
xxen_util.meaning(decode(paa.enable_plan_schedule_flag,'Y','Y',null),'YES_NO',0) enable_planning_schedules,
xxen_util.meaning(decode(paa.enable_ship_schedule_flag,'Y','Y',null),'YES_NO',0) enable_shipping_schedules,
(select ppx.full_name from per_people_x ppx where paa.scheduler_id=ppx.person_id) scheduler,
(select ppx.employee_number from per_people_x ppx where paa.scheduler_id=ppx.person_id) scheduler_emp_num,
xxen_util.meaning(decode(paa.enable_autoschedule_flag,'Y','Y',null),'YES_NO',0) enable_autoschedule,
(select cbp.bucket_pattern_name from chv_bucket_patterns cbp where cbp.bucket_pattern_id=paa.plan_bucket_pattern_id) plan_bucket_pattern,
(select cbp.bucket_pattern_name from chv_bucket_patterns cbp where cbp.bucket_pattern_id=paa.ship_bucket_pattern_id) ship_bucket_pattern,
xxen_util.meaning(paa.plan_schedule_type,'PLAN_SCHEDULE_SUBTYPE',201) plan_schedule_type,
xxen_util.meaning(paa.ship_schedule_type,'SHIP_SCHEDULE_SUBTYPE',201) ship_schedule_type,
xxen_util.meaning(decode(paa.enable_authorizations_flag,'Y','Y',null),'YES_NO',0) enable_authorizations,
-- Planning Constraints Attributes
paa.delivery_calendar supplier_capacity_calendar,
paa.processing_lead_time,
-- Inventory Attributes
paa.min_order_qty inv_minimum_order_quantity,
paa.fixed_lot_multiple inv_fixed_lot_multiple,
paa.fixed_order_quantity inv_fixed_order_quantity,
-- VMI Attributes
xxen_util.meaning(decode(paa.enable_vmi_flag,'Y','Y',null),'YES_NO',0) vmi_enabled,
xxen_util.meaning(decode(paa.enable_vmi_auto_replenish_flag,'Y','Y',null),'YES_NO',0) vmi_allow_auto_replenishment,
decode(paa.vmi_replenishment_approval,'SUPPLIER_OR_BUYER','Supplier or Buyer',initcap(paa.vmi_replenishment_approval)) vmi_replenishment_approval,
decode(paa.replenishment_method,1,'Min - Max Quantities',2,'Min - Max Days',3,'Min Qty and Fixed Order Qty',4,'Min Days and Fixed Order Qty',paa.replenishment_method) vmi_replenishment_method,
paa.forecast_horizon vmi_forecast_horizon_days,
paa.vmi_min_qty vmi_minimum_quantity,
paa.vmi_max_qty vmi_maximum_quantity,
paa.vmi_min_days vmi_minimum_days,
paa.vmi_max_days vmi_maximum_days,
-- Consigned Attributes
xxen_util.meaning(decode(paa.consigned_from_supplier_flag,'Y','Y',null),'YES_NO',0) consigned_from_supplier,
paa.consigned_billing_cycle consigned_billing_cycle_days,
paa.last_billing_date consigned_last_billing_date,
xxen_util.meaning(decode(paa.consume_on_aging_flag,'Y','Y',null),'YES_NO',0) consigned_consume_on_aging,
paa.aging_period consigned_aging_period_days,
--
-- ASL Supplier Documents
pad.sequence_num source_document_seq,
xxen_util.meaning(pad.document_type_code,'SOURCE DOCUMENT TYPE',201) source_document_type,
pha.segment1 source_document_number,
pla.line_num source_document_line,
null delete_this_document,
xxen_util.meaning(decode(pha.global_agreement_flag,'Y','Y',null),'YES_NO',0) document_global_agreement,
decode(pha.global_agreement_flag,'Y',po_moac_utils_pvt.get_ou_name(pha.org_id)) document_owning_org,
xxen_util.meaning(decode(pha.type_lookup_code,'QUOTATION',pha.status_lookup_code,'BLANKET',pha.authorization_status,'CONTRACT',pha.authorization_status),
                  decode(pha.type_lookup_code, 'QUOTATION','RFQ/QUOTE STATUS','BLANKET','AUTHORIZATION STATUS','CONTRACT','AUTHORIZATION STATUS'),
                  201
) document_status,
pha.start_date document_effective_from,
pha.end_date document_effective_to,
--
-- Authorizations
to_number(null) authorization_seq,
null authorization,
to_number(null) authorization_cutoff_days,
null delete_this_authorization,
--
-- Capacity
to_date(null) capacity_from_date,
to_date(null) capacity_to_date,
to_number(null) capacity_per_day,
null delete_this_capacity,
--
-- Tolerances
to_number(null) tolerance_days_in_advance,
to_number(null) tolerance_percentage,
null delete_this_tolerance,
--
-- ASL DFFs
xxen_util.display_flexfield_context(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category) po_asl_dff_category,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE1',pasl.rowid,pasl.attribute1) po_asl_attribute1,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE2',pasl.rowid,pasl.attribute2) po_asl_attribute2,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE3',pasl.rowid,pasl.attribute3) po_asl_attribute3,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE4',pasl.rowid,pasl.attribute4) po_asl_attribute4,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE5',pasl.rowid,pasl.attribute5) po_asl_attribute5,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE6',pasl.rowid,pasl.attribute6) po_asl_attribute6,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE7',pasl.rowid,pasl.attribute7) po_asl_attribute7,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE8',pasl.rowid,pasl.attribute8) po_asl_attribute8,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE9',pasl.rowid,pasl.attribute9) po_asl_attribute9,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE10',pasl.rowid,pasl.attribute10) po_asl_attribute10,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE11',pasl.rowid,pasl.attribute11) po_asl_attribute11,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE12',pasl.rowid,pasl.attribute12) po_asl_attribute12,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE13',pasl.rowid,pasl.attribute13) po_asl_attribute13,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE14',pasl.rowid,pasl.attribute14) po_asl_attribute14,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE15',pasl.rowid,pasl.attribute15) po_asl_attribute15,
-- Attribute DFFs
xxen_util.display_flexfield_context(201,'PO_ASL_ATTRIBUTES',paa.attribute_category) po_asl_att_dff_category,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE1',paa.rowid,paa.attribute1) po_asl_att_attribute1,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE2',paa.rowid,paa.attribute2) po_asl_att_attribute2,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE3',paa.rowid,paa.attribute3) po_asl_att_attribute3,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE4',paa.rowid,paa.attribute4) po_asl_att_attribute4,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE5',paa.rowid,paa.attribute5) po_asl_att_attribute5,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE6',paa.rowid,paa.attribute6) po_asl_att_attribute6,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE7',paa.rowid,paa.attribute7) po_asl_att_attribute7,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE8',paa.rowid,paa.attribute8) po_asl_att_attribute8,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE9',paa.rowid,paa.attribute9) po_asl_att_attribute9,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE10',paa.rowid,paa.attribute10) po_asl_att_attribute10,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE11',paa.rowid,paa.attribute11) po_asl_att_attribute11,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE12',paa.rowid,paa.attribute12) po_asl_att_attribute12,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE13',paa.rowid,paa.attribute13) po_asl_att_attribute13,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE14',paa.rowid,paa.attribute14) po_asl_att_attribute14,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE15',paa.rowid,paa.attribute15) po_asl_att_attribute15,
-- Document DFFs
xxen_util.display_flexfield_context(201,'PO_ASL_DOCUMENTS',pad.attribute_category) po_asl_doc_dff_category,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE1',pad.rowid,pad.attribute1) po_asl_doc_attribute1,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE2',pad.rowid,pad.attribute2) po_asl_doc_attribute2,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE3',pad.rowid,pad.attribute3) po_asl_doc_attribute3,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE4',pad.rowid,pad.attribute4) po_asl_doc_attribute4,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE5',pad.rowid,pad.attribute5) po_asl_doc_attribute5,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE6',pad.rowid,pad.attribute6) po_asl_doc_attribute6,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE7',pad.rowid,pad.attribute7) po_asl_doc_attribute7,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE8',pad.rowid,pad.attribute8) po_asl_doc_attribute8,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE9',pad.rowid,pad.attribute9) po_asl_doc_attribute9,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE10',pad.rowid,pad.attribute10) po_asl_doc_attribute10,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE11',pad.rowid,pad.attribute11) po_asl_doc_attribute11,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE12',pad.rowid,pad.attribute12) po_asl_doc_attribute12,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE13',pad.rowid,pad.attribute13) po_asl_doc_attribute13,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE14',pad.rowid,pad.attribute14) po_asl_doc_attribute14,
xxen_util.display_flexfield_value(201,'PO_ASL_DOCUMENTS',pad.attribute_category,'ATTRIBUTE15',pad.rowid,pad.attribute15) po_asl_doc_attribute15,
--
-- IDs
pasl.asl_id old_asl_id,
rowidtochar(paa.rowid) old_att_row_id,
rowidtochar(pad.rowid) old_doc_row_id,
null old_ath_row_id,
null old_cap_row_id,
null old_tol_row_id,
to_number(null) upload_row
from
po_approved_supplier_list pasl,
mtl_system_items_vl msiv,
mtl_categories_b_kfv mck,
ap_suppliers aps,
ap_supplier_sites ass,
mtl_manufacturers mm,
mtl_parameters mp_o,
hr_all_organization_units_tl haout_o,
--
po_asl_attributes paa,
mtl_parameters mp_u,
hr_all_organization_units_tl haout_u,
--
po_asl_documents pad,
po_headers_all pha,
po_lines_all pla
where
1=1 and
2=2 and
pasl.owning_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
pasl.owning_organization_id=msiv.organization_id(+) and
pasl.item_id=msiv.inventory_item_id(+) and
pasl.category_id=mck.category_id(+) and
pasl.vendor_id=aps.vendor_id(+) and
pasl.vendor_site_id=ass.vendor_site_id(+) and
((pasl.vendor_site_id is not null and ass.vendor_site_code is not null) or
 (pasl.vendor_site_id is null and ass.vendor_site_code is null)
) and
pasl.manufacturer_id=mm.manufacturer_id(+) and
pasl.owning_organization_id=mp_o.organization_id and
pasl.owning_organization_id=haout_o.organization_id and
haout_o.language = userenv('lang') and
--
decode(pasl.vendor_business_type,'MANUFACTURER',-1,pasl.asl_id)=paa.asl_id(+) and
paa.using_organization_id=mp_u.organization_id(+) and
paa.using_organization_id=haout_u.organization_id(+) and
haout_u.language(+) = userenv('lang') and
--
paa.asl_id=pad.asl_id(+) and
paa.using_organization_id=pad.using_organization_id(+) and
pad.document_header_id=pha.po_header_id(+) and
pad.document_line_id=pla.po_line_id(+)
--
union all
--
-- Q2 ASL Authorizations
--
select
-- Owning Organization
mp_o.organization_code owning_organization_code,
haout_o.name owning_organization,
-- ASL item/commodity
nvl2(pasl.item_id,'Item','Commodity') type,
mck.concatenated_segments commodity,
msiv.concatenated_segments item,
case when pasl.item_id is not null
then msiv.description
else (select mct.description from mtl_categories_tl mct where mct.category_id = pasl.category_id and mct.language = userenv('lang'))
end description,
--
-- ASL Suppliers
xxen_util.meaning(pasl.vendor_business_type,'ASL_VENDOR_BUSINESS_TYPE',201) supplier_business_type,
aps.vendor_name supplier,
aps.segment1 supplier_number,
ass.vendor_site_code supplier_site,
po_moac_utils_pvt.get_ou_name(ass.org_id) operating_unit,
mm.manufacturer_name manufacturer,
(select mm2.manufacturer_name from po_approved_supplier_list pasl2, mtl_manufacturers mm2 where pasl2.manufacturer_id = mm2.manufacturer_id and pasl2.asl_id = pasl.manufacturer_asl_id) distributor_manufacturer,
xxen_util.meaning(decode(pasl.using_organization_id,-1,'Y','N'),'YES_NO',0) global_asl,
(select pas.status from po_asl_statuses pas where pas.status_id = pasl.asl_status_id) status,
xxen_util.meaning(decode(pasl.disable_flag,'Y','Y',null),'YES_NO',0) disabled,
pasl.primary_vendor_item supplier_item,
pasl.review_by_date review_by_date,
pasl.comments,
pasl.creation_date created,
--
-- ASL Supplier Attributes
mp_u.organization_code using_organization_code,
haout_u.name using_organization,
xxen_util.meaning(decode(paa.using_organization_id,-1,'Y',nvl2(paa.using_organization_id,'N',null)),'YES_NO',0) global_attributes,
null delete_this_asl,
paa.purchasing_unit_of_measure purchasing_uom,
xxen_util.meaning(paa.release_generation_method,'DOC GENERATION METHOD',201) release_method,
paa.price_update_tolerance,
paa.country_of_origin_code country_of_origin,
-- Supplier Scheduling Attributes
xxen_util.meaning(decode(paa.enable_plan_schedule_flag,'Y','Y',null),'YES_NO',0) enable_planning_schedules,
xxen_util.meaning(decode(paa.enable_ship_schedule_flag,'Y','Y',null),'YES_NO',0) enable_shipping_schedules,
(select ppx.full_name from per_people_x ppx where paa.scheduler_id=ppx.person_id) scheduler,
(select ppx.employee_number from per_people_x ppx where paa.scheduler_id=ppx.person_id) scheduler_emp_num,
xxen_util.meaning(decode(paa.enable_autoschedule_flag,'Y','Y',null),'YES_NO',0) enable_autoschedule,
(select cbp.bucket_pattern_name from chv_bucket_patterns cbp where cbp.bucket_pattern_id=paa.plan_bucket_pattern_id) plan_bucket_pattern,
(select cbp.bucket_pattern_name from chv_bucket_patterns cbp where cbp.bucket_pattern_id=paa.ship_bucket_pattern_id) ship_bucket_pattern,
xxen_util.meaning(paa.plan_schedule_type,'PLAN_SCHEDULE_SUBTYPE',201) plan_schedule_type,
xxen_util.meaning(paa.ship_schedule_type,'SHIP_SCHEDULE_SUBTYPE',201) ship_schedule_type,
xxen_util.meaning(decode(paa.enable_authorizations_flag,'Y','Y',null),'YES_NO',0) enable_authorizations,
-- Planning Constraints Attributes
paa.delivery_calendar supplier_capacity_calendar,
paa.processing_lead_time,
-- Inventory Attributes
paa.min_order_qty inv_minimum_order_quantity,
paa.fixed_lot_multiple inv_fixed_lot_multiple,
paa.fixed_order_quantity inv_fixed_order_quantity,
-- VMI Attributes
xxen_util.meaning(decode(paa.enable_vmi_flag,'Y','Y',null),'YES_NO',0) vmi_enabled,
xxen_util.meaning(decode(paa.enable_vmi_auto_replenish_flag,'Y','Y',null),'YES_NO',0) vmi_allow_auto_replenishment,
decode(paa.vmi_replenishment_approval,'SUPPLIER_OR_BUYER','Supplier or Buyer',initcap(paa.vmi_replenishment_approval)) vmi_replenishment_approval,
decode(paa.replenishment_method,1,'Min - Max Quantities',2,'Min - Max Days',3,'Min Qty and Fixed Order Qty',4,'Min Days and Fixed Order Qty',paa.replenishment_method) vmi_replenishment_method,
paa.forecast_horizon vmi_forecast_horizon_days,
paa.vmi_min_qty vmi_minimum_quantity,
paa.vmi_max_qty vmi_maximum_quantity,
paa.vmi_min_days vmi_minimum_days,
paa.vmi_max_days vmi_maximum_days,
-- Consigned Attributes
xxen_util.meaning(decode(paa.consigned_from_supplier_flag,'Y','Y',null),'YES_NO',0) consigned_from_supplier,
paa.consigned_billing_cycle consigned_billing_cycle_days,
paa.last_billing_date consigned_last_billing_date,
xxen_util.meaning(decode(paa.consume_on_aging_flag,'Y','Y',null),'YES_NO',0) consigned_consume_on_aging,
paa.aging_period consigned_aging_period_days,
--
-- ASL Supplier Documents
to_number(null) source_document_seq,
null source_document_type,
null source_document_number,
null source_document_line,
null delete_this_document,
null document_global_agreement,
null document_owning_org,
null document_status,
to_date(null) document_effective_from,
to_date(null) document_effective_to,
--
-- Supplier Authorizations
ca.authorization_sequence authorization_seq,
xxen_util.meaning(ca.authorization_code,'AUTHORIZATION_TYPE',201) authorization,
ca.timefence_days authorization_cutoff_days,
null delete_this_authorization,
--
-- Capacity
to_date(null) capacity_from_date,
to_date(null) capacity_to_date,
to_number(null) capacity_per_day,
null delete_this_capacity,
--
-- Tolerances
to_number(null) tolerance_days_in_advance,
to_number(null) tolerance_percentage,
null delete_this_tolerance,
--
-- ASL DFFs
xxen_util.display_flexfield_context(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category) po_asl_dff_category,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE1',pasl.rowid,pasl.attribute1) po_asl_attribute1,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE2',pasl.rowid,pasl.attribute2) po_asl_attribute2,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE3',pasl.rowid,pasl.attribute3) po_asl_attribute3,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE4',pasl.rowid,pasl.attribute4) po_asl_attribute4,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE5',pasl.rowid,pasl.attribute5) po_asl_attribute5,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE6',pasl.rowid,pasl.attribute6) po_asl_attribute6,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE7',pasl.rowid,pasl.attribute7) po_asl_attribute7,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE8',pasl.rowid,pasl.attribute8) po_asl_attribute8,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE9',pasl.rowid,pasl.attribute9) po_asl_attribute9,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE10',pasl.rowid,pasl.attribute10) po_asl_attribute10,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE11',pasl.rowid,pasl.attribute11) po_asl_attribute11,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE12',pasl.rowid,pasl.attribute12) po_asl_attribute12,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE13',pasl.rowid,pasl.attribute13) po_asl_attribute13,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE14',pasl.rowid,pasl.attribute14) po_asl_attribute14,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE15',pasl.rowid,pasl.attribute15) po_asl_attribute15,
-- Attribute DFFs
xxen_util.display_flexfield_context(201,'PO_ASL_ATTRIBUTES',paa.attribute_category) po_asl_att_dff_category,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE1',paa.rowid,paa.attribute1) po_asl_att_attribute1,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE2',paa.rowid,paa.attribute2) po_asl_att_attribute2,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE3',paa.rowid,paa.attribute3) po_asl_att_attribute3,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE4',paa.rowid,paa.attribute4) po_asl_att_attribute4,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE5',paa.rowid,paa.attribute5) po_asl_att_attribute5,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE6',paa.rowid,paa.attribute6) po_asl_att_attribute6,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE7',paa.rowid,paa.attribute7) po_asl_att_attribute7,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE8',paa.rowid,paa.attribute8) po_asl_att_attribute8,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE9',paa.rowid,paa.attribute9) po_asl_att_attribute9,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE10',paa.rowid,paa.attribute10) po_asl_att_attribute10,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE11',paa.rowid,paa.attribute11) po_asl_att_attribute11,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE12',paa.rowid,paa.attribute12) po_asl_att_attribute12,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE13',paa.rowid,paa.attribute13) po_asl_att_attribute13,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE14',paa.rowid,paa.attribute14) po_asl_att_attribute14,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE15',paa.rowid,paa.attribute15) po_asl_att_attribute15,
-- Document DFFs
null po_asl_doc_dff_category,
null po_asl_doc_attribute1,
null po_asl_doc_attribute2,
null po_asl_doc_attribute3,
null po_asl_doc_attribute4,
null po_asl_doc_attribute5,
null po_asl_doc_attribute6,
null po_asl_doc_attribute7,
null po_asl_doc_attribute8,
null po_asl_doc_attribute9,
null po_asl_doc_attribute10,
null po_asl_doc_attribute11,
null po_asl_doc_attribute12,
null po_asl_doc_attribute13,
null po_asl_doc_attribute14,
null po_asl_doc_attribute15,
--
-- IDs
pasl.asl_id old_asl_id,
null old_att_row_id,
null old_doc_row_id,
rowidtochar(ca.rowid) old_ath_row_id,
null old_cap_row_id,
null old_tol_row_id,
to_number(null) upload_row
from
po_approved_supplier_list pasl,
mtl_system_items_vl msiv,
mtl_categories_b_kfv mck,
ap_suppliers aps,
ap_supplier_sites ass,
mtl_manufacturers mm,
mtl_parameters mp_o,
hr_all_organization_units_tl haout_o,
--
po_asl_attributes paa,
mtl_parameters mp_u,
hr_all_organization_units_tl haout_u,
--
chv_authorizations ca
--
where
:p_download_authorizations = 'Y' and
1=1 and
3=3 and
pasl.vendor_business_type != 'MANUFACTURER' and
pasl.owning_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
pasl.owning_organization_id=msiv.organization_id(+) and
pasl.item_id=msiv.inventory_item_id(+) and
pasl.category_id=mck.category_id(+) and
pasl.vendor_id=aps.vendor_id(+) and
pasl.vendor_site_id=ass.vendor_site_id(+) and
((pasl.vendor_site_id is not null and ass.vendor_site_code is not null) or
 (pasl.vendor_site_id is null and ass.vendor_site_code is null)
) and
pasl.manufacturer_id=mm.manufacturer_id(+) and
pasl.owning_organization_id=mp_o.organization_id and
pasl.owning_organization_id=haout_o.organization_id and
haout_o.language = userenv('lang') and
--
pasl.asl_id=paa.asl_id and
pasl.using_organization_id = paa.using_organization_id and
paa.using_organization_id=mp_u.organization_id(+) and
paa.using_organization_id=haout_u.organization_id(+) and
haout_u.language(+) = userenv('lang') and
--
pasl.asl_id=ca.reference_id and
pasl.using_organization_id=ca.using_organization_id and
ca.reference_type='ASL'
--
union all
--
-- Q3 ASL Supplier Capacities
--
select
-- Owning Organization
mp_o.organization_code owning_organization_code,
haout_o.name owning_organization,
-- ASL item/commodity
nvl2(pasl.item_id,'Item','Commodity') type,
mck.concatenated_segments commodity,
msiv.concatenated_segments item,
case when pasl.item_id is not null
then msiv.description
else (select mct.description from mtl_categories_tl mct where mct.category_id = pasl.category_id and mct.language = userenv('lang'))
end description,
--
-- ASL Suppliers
xxen_util.meaning(pasl.vendor_business_type,'ASL_VENDOR_BUSINESS_TYPE',201) supplier_business_type,
aps.vendor_name supplier,
aps.segment1 supplier_number,
ass.vendor_site_code supplier_site,
po_moac_utils_pvt.get_ou_name(ass.org_id) operating_unit,
mm.manufacturer_name manufacturer,
(select mm2.manufacturer_name from po_approved_supplier_list pasl2, mtl_manufacturers mm2 where pasl2.manufacturer_id = mm2.manufacturer_id and pasl2.asl_id = pasl.manufacturer_asl_id) distributor_manufacturer,
xxen_util.meaning(decode(pasl.using_organization_id,-1,'Y','N'),'YES_NO',0) global_asl,
(select pas.status from po_asl_statuses pas where pas.status_id = pasl.asl_status_id) status,
xxen_util.meaning(decode(pasl.disable_flag,'Y','Y',null),'YES_NO',0) disabled,
pasl.primary_vendor_item supplier_item,
pasl.review_by_date review_by_date,
pasl.comments,
pasl.creation_date created,
--
-- ASL Supplier Attributes
mp_u.organization_code using_organization_code,
haout_u.name using_organization,
xxen_util.meaning(decode(paa.using_organization_id,-1,'Y',nvl2(paa.using_organization_id,'N',null)),'YES_NO',0) global_attributes,
null delete_this_asl,
paa.purchasing_unit_of_measure purchasing_uom,
xxen_util.meaning(paa.release_generation_method,'DOC GENERATION METHOD',201) release_method,
paa.price_update_tolerance,
paa.country_of_origin_code country_of_origin,
-- Supplier Scheduling Attributes
xxen_util.meaning(decode(paa.enable_plan_schedule_flag,'Y','Y',null),'YES_NO',0) enable_planning_schedules,
xxen_util.meaning(decode(paa.enable_ship_schedule_flag,'Y','Y',null),'YES_NO',0) enable_shipping_schedules,
(select ppx.full_name from per_people_x ppx where paa.scheduler_id=ppx.person_id) scheduler,
(select ppx.employee_number from per_people_x ppx where paa.scheduler_id=ppx.person_id) scheduler_emp_num,
xxen_util.meaning(decode(paa.enable_autoschedule_flag,'Y','Y',null),'YES_NO',0) enable_autoschedule,
(select cbp.bucket_pattern_name from chv_bucket_patterns cbp where cbp.bucket_pattern_id=paa.plan_bucket_pattern_id) plan_bucket_pattern,
(select cbp.bucket_pattern_name from chv_bucket_patterns cbp where cbp.bucket_pattern_id=paa.ship_bucket_pattern_id) ship_bucket_pattern,
xxen_util.meaning(paa.plan_schedule_type,'PLAN_SCHEDULE_SUBTYPE',201) plan_schedule_type,
xxen_util.meaning(paa.ship_schedule_type,'SHIP_SCHEDULE_SUBTYPE',201) ship_schedule_type,
xxen_util.meaning(decode(paa.enable_authorizations_flag,'Y','Y',null),'YES_NO',0) enable_authorizations,
-- Planning Constraints Attributes
paa.delivery_calendar supplier_capacity_calendar,
paa.processing_lead_time,
-- Inventory Attributes
paa.min_order_qty inv_minimum_order_quantity,
paa.fixed_lot_multiple inv_fixed_lot_multiple,
paa.fixed_order_quantity inv_fixed_order_quantity,
-- VMI Attributes
xxen_util.meaning(decode(paa.enable_vmi_flag,'Y','Y',null),'YES_NO',0) vmi_enabled,
xxen_util.meaning(decode(paa.enable_vmi_auto_replenish_flag,'Y','Y',null),'YES_NO',0) vmi_allow_auto_replenishment,
decode(paa.vmi_replenishment_approval,'SUPPLIER_OR_BUYER','Supplier or Buyer',initcap(paa.vmi_replenishment_approval)) vmi_replenishment_approval,
decode(paa.replenishment_method,1,'Min - Max Quantities',2,'Min - Max Days',3,'Min Qty and Fixed Order Qty',4,'Min Days and Fixed Order Qty',paa.replenishment_method) vmi_replenishment_method,
paa.forecast_horizon vmi_forecast_horizon_days,
paa.vmi_min_qty vmi_minimum_quantity,
paa.vmi_max_qty vmi_maximum_quantity,
paa.vmi_min_days vmi_minimum_days,
paa.vmi_max_days vmi_maximum_days,
-- Consigned Attributes
xxen_util.meaning(decode(paa.consigned_from_supplier_flag,'Y','Y',null),'YES_NO',0) consigned_from_supplier,
paa.consigned_billing_cycle consigned_billing_cycle_days,
paa.last_billing_date consigned_last_billing_date,
xxen_util.meaning(decode(paa.consume_on_aging_flag,'Y','Y',null),'YES_NO',0) consigned_consume_on_aging,
paa.aging_period consigned_aging_period_days,
--
-- ASL Supplier Documents
to_number(null) source_document_seq,
null source_document_type,
null source_document_number,
null source_document_line,
null delete_this_document,
null document_global_agreement,
null document_owning_org,
null document_status,
to_date(null) document_effective_from,
to_date(null) document_effective_to,
--
-- Authorizations
to_number(null) authorization_seq,
null authorization,
to_number(null) authorization_cutoff_days,
null delete_this_authorization,
--
-- Capacity
psic.from_date capacity_from_date,
psic.to_date capacity_to_date,
psic.capacity_per_day,
null delete_this_capacity,
--
-- Tolerances
to_number(null) tolerance_days_in_advance,
to_number(null) tolerance_percentage,
null delete_this_tolerance,
--
-- ASL DFFs
xxen_util.display_flexfield_context(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category) po_asl_dff_category,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE1',pasl.rowid,pasl.attribute1) po_asl_attribute1,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE2',pasl.rowid,pasl.attribute2) po_asl_attribute2,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE3',pasl.rowid,pasl.attribute3) po_asl_attribute3,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE4',pasl.rowid,pasl.attribute4) po_asl_attribute4,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE5',pasl.rowid,pasl.attribute5) po_asl_attribute5,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE6',pasl.rowid,pasl.attribute6) po_asl_attribute6,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE7',pasl.rowid,pasl.attribute7) po_asl_attribute7,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE8',pasl.rowid,pasl.attribute8) po_asl_attribute8,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE9',pasl.rowid,pasl.attribute9) po_asl_attribute9,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE10',pasl.rowid,pasl.attribute10) po_asl_attribute10,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE11',pasl.rowid,pasl.attribute11) po_asl_attribute11,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE12',pasl.rowid,pasl.attribute12) po_asl_attribute12,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE13',pasl.rowid,pasl.attribute13) po_asl_attribute13,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE14',pasl.rowid,pasl.attribute14) po_asl_attribute14,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE15',pasl.rowid,pasl.attribute15) po_asl_attribute15,
-- Attribute DFFs
xxen_util.display_flexfield_context(201,'PO_ASL_ATTRIBUTES',paa.attribute_category) po_asl_att_dff_category,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE1',paa.rowid,paa.attribute1) po_asl_att_attribute1,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE2',paa.rowid,paa.attribute2) po_asl_att_attribute2,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE3',paa.rowid,paa.attribute3) po_asl_att_attribute3,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE4',paa.rowid,paa.attribute4) po_asl_att_attribute4,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE5',paa.rowid,paa.attribute5) po_asl_att_attribute5,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE6',paa.rowid,paa.attribute6) po_asl_att_attribute6,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE7',paa.rowid,paa.attribute7) po_asl_att_attribute7,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE8',paa.rowid,paa.attribute8) po_asl_att_attribute8,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE9',paa.rowid,paa.attribute9) po_asl_att_attribute9,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE10',paa.rowid,paa.attribute10) po_asl_att_attribute10,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE11',paa.rowid,paa.attribute11) po_asl_att_attribute11,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE12',paa.rowid,paa.attribute12) po_asl_att_attribute12,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE13',paa.rowid,paa.attribute13) po_asl_att_attribute13,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE14',paa.rowid,paa.attribute14) po_asl_att_attribute14,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE15',paa.rowid,paa.attribute15) po_asl_att_attribute15,
-- Document DFFs
null po_asl_doc_dff_category,
null po_asl_doc_attribute1,
null po_asl_doc_attribute2,
null po_asl_doc_attribute3,
null po_asl_doc_attribute4,
null po_asl_doc_attribute5,
null po_asl_doc_attribute6,
null po_asl_doc_attribute7,
null po_asl_doc_attribute8,
null po_asl_doc_attribute9,
null po_asl_doc_attribute10,
null po_asl_doc_attribute11,
null po_asl_doc_attribute12,
null po_asl_doc_attribute13,
null po_asl_doc_attribute14,
null po_asl_doc_attribute15,
--
-- IDs
pasl.asl_id old_asl_id,
null old_att_row_id,
null old_doc_row_id,
null old_ath_row_id,
rowidtochar(psic.rowid) old_cap_row_id,
null old_tol_row_id,
to_number(null) upload_row
from
po_approved_supplier_list pasl,
mtl_system_items_vl msiv,
mtl_categories_b_kfv mck,
ap_suppliers aps,
ap_supplier_sites ass,
mtl_manufacturers mm,
mtl_parameters mp_o,
hr_all_organization_units_tl haout_o,
--
po_asl_attributes paa,
mtl_parameters mp_u,
hr_all_organization_units_tl haout_u,
--
po_supplier_item_capacity psic
where
:p_download_capacities = 'Y' and
1=1 and
3=3 and
pasl.vendor_business_type != 'MANUFACTURER' and
pasl.owning_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
pasl.owning_organization_id=msiv.organization_id(+) and
pasl.item_id=msiv.inventory_item_id(+) and
pasl.category_id=mck.category_id(+) and
pasl.vendor_id=aps.vendor_id(+) and
pasl.vendor_site_id=ass.vendor_site_id(+) and
((pasl.vendor_site_id is not null and ass.vendor_site_code is not null) or
 (pasl.vendor_site_id is null and ass.vendor_site_code is null)
) and
pasl.manufacturer_id=mm.manufacturer_id(+) and
pasl.owning_organization_id=mp_o.organization_id and
pasl.owning_organization_id=haout_o.organization_id and
haout_o.language = userenv('lang') and
--
pasl.asl_id=paa.asl_id and
pasl.using_organization_id = paa.using_organization_id and
paa.using_organization_id=mp_u.organization_id(+) and
paa.using_organization_id=haout_u.organization_id(+) and
haout_u.language(+) = userenv('lang') and
--
pasl.asl_id=psic.asl_id and
pasl.using_organization_id=psic.using_organization_id
--
union all
--
--
-- Q4 ASL Supplier Tolerances
--
select
-- Owning Organization
mp_o.organization_code owning_organization_code,
haout_o.name owning_organization,
-- ASL item/commodity
nvl2(pasl.item_id,'Item','Commodity') type,
mck.concatenated_segments commodity,
msiv.concatenated_segments item,
case when pasl.item_id is not null
then msiv.description
else (select mct.description from mtl_categories_tl mct where mct.category_id = pasl.category_id and mct.language = userenv('lang'))
end description,
--
-- ASL Suppliers
xxen_util.meaning(pasl.vendor_business_type,'ASL_VENDOR_BUSINESS_TYPE',201) supplier_business_type,
aps.vendor_name supplier,
aps.segment1 supplier_number,
ass.vendor_site_code supplier_site,
po_moac_utils_pvt.get_ou_name(ass.org_id) operating_unit,
mm.manufacturer_name manufacturer,
(select mm2.manufacturer_name from po_approved_supplier_list pasl2, mtl_manufacturers mm2 where pasl2.manufacturer_id = mm2.manufacturer_id and pasl2.asl_id = pasl.manufacturer_asl_id) distributor_manufacturer,
xxen_util.meaning(decode(pasl.using_organization_id,-1,'Y','N'),'YES_NO',0) global_asl,
(select pas.status from po_asl_statuses pas where pas.status_id = pasl.asl_status_id) status,
xxen_util.meaning(decode(pasl.disable_flag,'Y','Y',null),'YES_NO',0) disabled,
pasl.primary_vendor_item supplier_item,
pasl.review_by_date review_by_date,
pasl.comments,
pasl.creation_date created,
--
-- ASL Supplier Attributes
mp_u.organization_code using_organization_code,
haout_u.name using_organization,
xxen_util.meaning(decode(paa.using_organization_id,-1,'Y',nvl2(paa.using_organization_id,'N',null)),'YES_NO',0) global_attributes,
null delete_this_asl,
paa.purchasing_unit_of_measure purchasing_uom,
xxen_util.meaning(paa.release_generation_method,'DOC GENERATION METHOD',201) release_method,
paa.price_update_tolerance,
paa.country_of_origin_code country_of_origin,
-- Supplier Scheduling Attributes
xxen_util.meaning(decode(paa.enable_plan_schedule_flag,'Y','Y',null),'YES_NO',0) enable_planning_schedules,
xxen_util.meaning(decode(paa.enable_ship_schedule_flag,'Y','Y',null),'YES_NO',0) enable_shipping_schedules,
(select ppx.full_name from per_people_x ppx where paa.scheduler_id=ppx.person_id) scheduler,
(select ppx.employee_number from per_people_x ppx where paa.scheduler_id=ppx.person_id) scheduler_emp_num,
xxen_util.meaning(decode(paa.enable_autoschedule_flag,'Y','Y',null),'YES_NO',0) enable_autoschedule,
(select cbp.bucket_pattern_name from chv_bucket_patterns cbp where cbp.bucket_pattern_id=paa.plan_bucket_pattern_id) plan_bucket_pattern,
(select cbp.bucket_pattern_name from chv_bucket_patterns cbp where cbp.bucket_pattern_id=paa.ship_bucket_pattern_id) ship_bucket_pattern,
xxen_util.meaning(paa.plan_schedule_type,'PLAN_SCHEDULE_SUBTYPE',201) plan_schedule_type,
xxen_util.meaning(paa.ship_schedule_type,'SHIP_SCHEDULE_SUBTYPE',201) ship_schedule_type,
xxen_util.meaning(decode(paa.enable_authorizations_flag,'Y','Y',null),'YES_NO',0) enable_authorizations,
-- Planning Constraints Attributes
paa.delivery_calendar supplier_capacity_calendar,
paa.processing_lead_time,
-- Inventory Attributes
paa.min_order_qty inv_minimum_order_quantity,
paa.fixed_lot_multiple inv_fixed_lot_multiple,
paa.fixed_order_quantity inv_fixed_order_quantity,
-- VMI Attributes
xxen_util.meaning(decode(paa.enable_vmi_flag,'Y','Y',null),'YES_NO',0) vmi_enabled,
xxen_util.meaning(decode(paa.enable_vmi_auto_replenish_flag,'Y','Y',null),'YES_NO',0) vmi_allow_auto_replenishment,
decode(paa.vmi_replenishment_approval,'SUPPLIER_OR_BUYER','Supplier or Buyer',initcap(paa.vmi_replenishment_approval)) vmi_replenishment_approval,
decode(paa.replenishment_method,1,'Min - Max Quantities',2,'Min - Max Days',3,'Min Qty and Fixed Order Qty',4,'Min Days and Fixed Order Qty',paa.replenishment_method) vmi_replenishment_method,
paa.forecast_horizon vmi_forecast_horizon_days,
paa.vmi_min_qty vmi_minimum_quantity,
paa.vmi_max_qty vmi_maximum_quantity,
paa.vmi_min_days vmi_minimum_days,
paa.vmi_max_days vmi_maximum_days,
-- Consigned Attributes
xxen_util.meaning(decode(paa.consigned_from_supplier_flag,'Y','Y',null),'YES_NO',0) consigned_from_supplier,
paa.consigned_billing_cycle consigned_billing_cycle_days,
paa.last_billing_date consigned_last_billing_date,
xxen_util.meaning(decode(paa.consume_on_aging_flag,'Y','Y',null),'YES_NO',0) consigned_consume_on_aging,
paa.aging_period consigned_aging_period_days,
--
-- ASL Supplier Documents
to_number(null) source_document_seq,
null source_document_type,
null source_document_number,
null source_document_line,
null delete_this_document,
null document_global_agreement,
null document_owning_org,
null document_status,
to_date(null) document_effective_from,
to_date(null) document_effective_to,
--
-- Authorizations
to_number(null) authorization_seq,
null authorization,
to_number(null) authorization_cutoff_days,
null delete_this_authorization,
--
-- Capacity
to_date(null) capacity_from_date,
to_date(null) capacity_to_date,
to_number(null) capacity_per_day,
null delete_this_capacity,
--
-- Tolerances
psit.number_of_days tolerance_days_in_advance,
psit.tolerance tolerance_percentage,
null delete_this_tolerance,
--
-- ASL DFFs
xxen_util.display_flexfield_context(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category) po_asl_dff_category,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE1',pasl.rowid,pasl.attribute1) po_asl_attribute1,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE2',pasl.rowid,pasl.attribute2) po_asl_attribute2,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE3',pasl.rowid,pasl.attribute3) po_asl_attribute3,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE4',pasl.rowid,pasl.attribute4) po_asl_attribute4,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE5',pasl.rowid,pasl.attribute5) po_asl_attribute5,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE6',pasl.rowid,pasl.attribute6) po_asl_attribute6,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE7',pasl.rowid,pasl.attribute7) po_asl_attribute7,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE8',pasl.rowid,pasl.attribute8) po_asl_attribute8,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE9',pasl.rowid,pasl.attribute9) po_asl_attribute9,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE10',pasl.rowid,pasl.attribute10) po_asl_attribute10,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE11',pasl.rowid,pasl.attribute11) po_asl_attribute11,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE12',pasl.rowid,pasl.attribute12) po_asl_attribute12,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE13',pasl.rowid,pasl.attribute13) po_asl_attribute13,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE14',pasl.rowid,pasl.attribute14) po_asl_attribute14,
xxen_util.display_flexfield_value(201,'PO_APPROVED_SUPPLIER_LIST',pasl.attribute_category,'ATTRIBUTE15',pasl.rowid,pasl.attribute15) po_asl_attribute15,
-- Attribute DFFs
xxen_util.display_flexfield_context(201,'PO_ASL_ATTRIBUTES',paa.attribute_category) po_asl_att_dff_category,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE1',paa.rowid,paa.attribute1) po_asl_att_attribute1,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE2',paa.rowid,paa.attribute2) po_asl_att_attribute2,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE3',paa.rowid,paa.attribute3) po_asl_att_attribute3,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE4',paa.rowid,paa.attribute4) po_asl_att_attribute4,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE5',paa.rowid,paa.attribute5) po_asl_att_attribute5,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE6',paa.rowid,paa.attribute6) po_asl_att_attribute6,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE7',paa.rowid,paa.attribute7) po_asl_att_attribute7,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE8',paa.rowid,paa.attribute8) po_asl_att_attribute8,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE9',paa.rowid,paa.attribute9) po_asl_att_attribute9,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE10',paa.rowid,paa.attribute10) po_asl_att_attribute10,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE11',paa.rowid,paa.attribute11) po_asl_att_attribute11,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE12',paa.rowid,paa.attribute12) po_asl_att_attribute12,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE13',paa.rowid,paa.attribute13) po_asl_att_attribute13,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE14',paa.rowid,paa.attribute14) po_asl_att_attribute14,
xxen_util.display_flexfield_value(201,'PO_ASL_ATTRIBUTES',paa.attribute_category,'ATTRIBUTE15',paa.rowid,paa.attribute15) po_asl_att_attribute15,
-- Document DFFs
null po_asl_doc_dff_category,
null po_asl_doc_attribute1,
null po_asl_doc_attribute2,
null po_asl_doc_attribute3,
null po_asl_doc_attribute4,
null po_asl_doc_attribute5,
null po_asl_doc_attribute6,
null po_asl_doc_attribute7,
null po_asl_doc_attribute8,
null po_asl_doc_attribute9,
null po_asl_doc_attribute10,
null po_asl_doc_attribute11,
null po_asl_doc_attribute12,
null po_asl_doc_attribute13,
null po_asl_doc_attribute14,
null po_asl_doc_attribute15,
--
-- IDs
pasl.asl_id old_asl_id,
null old_att_row_id,
null old_doc_row_id,
null old_ath_row_id,
null old_cap_row_id,
rowidtochar(psit.rowid) old_tol_row_id,
to_number(null) upload_row
from
po_approved_supplier_list pasl,
mtl_system_items_vl msiv,
mtl_categories_b_kfv mck,
ap_suppliers aps,
ap_supplier_sites ass,
mtl_manufacturers mm,
mtl_parameters mp_o,
--
po_asl_attributes paa,
mtl_parameters mp_u,
hr_all_organization_units_tl haout_u,
--
hr_all_organization_units_tl haout_o,
po_supplier_item_tolerance psit
--
where
:p_download_tolerances = 'Y' and
1=1 and
3=3 and
pasl.vendor_business_type != 'MANUFACTURER' and
pasl.owning_organization_id in (select oav.organization_id from org_access_view oav where oav.resp_application_id=fnd_global.resp_appl_id and oav.responsibility_id=fnd_global.resp_id) and
pasl.owning_organization_id=msiv.organization_id(+) and
pasl.item_id=msiv.inventory_item_id(+) and
pasl.category_id=mck.category_id(+) and
pasl.vendor_id=aps.vendor_id(+) and
pasl.vendor_site_id=ass.vendor_site_id(+) and
((pasl.vendor_site_id is not null and ass.vendor_site_code is not null) or
 (pasl.vendor_site_id is null and ass.vendor_site_code is null)
) and
pasl.manufacturer_id=mm.manufacturer_id(+) and
pasl.owning_organization_id=mp_o.organization_id and
pasl.owning_organization_id=haout_o.organization_id and
haout_o.language = userenv('lang') and
--
pasl.asl_id=paa.asl_id and
pasl.using_organization_id = paa.using_organization_id and
paa.using_organization_id=mp_u.organization_id(+) and
paa.using_organization_id=haout_u.organization_id(+) and
haout_u.language(+) = userenv('lang') and
--
pasl.asl_id=psit.asl_id and
pasl.using_organization_id=psit.using_organization_id
) asl
where
:p_upload_mode like '%' || xxen_upload.action_update