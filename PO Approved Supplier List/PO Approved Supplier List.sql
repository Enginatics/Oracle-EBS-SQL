/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Approved Supplier List
-- Description: Approved supplier list and attribute details such as source documents, supplier scheduling, planning constraints and inventory attributes.
-- Excel Examle Output: https://www.enginatics.com/example/po-approved-supplier-list/
-- Library Link: https://www.enginatics.com/reports/po-approved-supplier-list/
-- Run Report: https://demo.enginatics.com/

select
nvl2(pasl.item_id,'Item','Commodity') type,
mck.concatenated_segments commodity,
msiv.concatenated_segments item,
msiv.description item_description,
xxen_util.meaning(pasl.vendor_business_type,'ASL_VENDOR_BUSINESS_TYPE',201) business,
decode(pasl.vendor_business_type,'MANUFACTURER',null,aps.segment1) supplier_number,
decode(pasl.vendor_business_type,'MANUFACTURER',mm.manufacturer_name,aps.vendor_name) supplier,
assa.vendor_site_code supplier_site,
haout3.name operating_unit,
pas.status,
xxen_util.meaning(pasl.disable_flag,'YES_NO',0) disabled,
pasl.primary_vendor_item supplier_item,
mm1.manufacturer_name manufacturer,
pasl.review_by_date review_by,
mp1.organization_code owning_organization_code,
haout1.name owning_organization,
xxen_util.meaning(decode(pasl.using_organization_id,-1,'Y','N'),'YES_NO',0) global,
mp2.organization_code using_organization_code,
haout2.name using_organization,
xxen_util.user_name(pasl.created_by) created_by,
xxen_util.client_time(pasl.creation_date) creation_date,
xxen_util.user_name(pasl.last_updated_by) last_updated_by,
xxen_util.client_time(pasl.last_update_date) last_update_date,
pasl.comments,
paa.purchasing_unit_of_measure purchasing_uom,
xxen_util.meaning(paa.release_generation_method,'DOC GENERATION METHOD',201) release_method,
paa.price_update_tolerance,
paa.country_of_origin_code country_of_origin,
--source documents
&document_cols
--supplier scheduling
xxen_util.meaning(paa.enable_plan_schedule_flag,'YES_NO',0) enable_planning_schedules,
xxen_util.meaning(paa.enable_ship_schedule_flag,'YES_NO',0) enable_shipping_schedules,
ppx.full_name scheduler,
xxen_util.meaning(paa.enable_autoschedule_flag,'YES_NO',0) enable_autoschedule,
cbp1.bucket_pattern_name plan_bucket_pattern,
cbp2.bucket_pattern_name ship_bucket_pattern,
xxen_util.meaning(paa.plan_schedule_type,'PLAN_SCHEDULE_SUBTYPE',201) plan_schedule_type,
xxen_util.meaning(paa.ship_schedule_type,'SHIP_SCHEDULE_SUBTYPE',201) ship_schedule_type,
xxen_util.meaning(paa.enable_authorizations_flag,'YES_NO',0) enable_authorizations,
&authorization_cols
--planning constraints
paa.delivery_calendar supplier_capacity_calendar,
paa.processing_lead_time,
&supplier_capacity_cols
&supplier_tolerance_cols
--inventory
paa.min_order_qty minimum_order_quantity,
paa.fixed_lot_multiple,
xxen_util.meaning(paa.enable_vmi_flag,'YES_NO',0) vmi_enabled,
xxen_util.meaning(paa.enable_vmi_auto_replenish_flag,'YES_NO',0) vmi_auto_replenish,
decode(paa.vmi_replenishment_approval,'SUPPLIER_OR_BUYER','Supplier or Buyer',initcap(paa.vmi_replenishment_approval)) vmi_replenishment_approval,
decode(paa.replenishment_method,1,'Min - Max Quantities',2,'Min - Max Days',3,'Min Qty and Fixed Order Qty',4,'Min Days and Fixed Order Qty',paa.replenishment_method) vmi_replenishment_method,
paa.vmi_min_days vmi_minimum_days,
paa.vmi_max_days vmi_maximum_days,
paa.vmi_min_qty,
paa.vmi_max_qty,
paa.forecast_horizon vmi_forecast_horizon_days,
paa.fixed_order_quantity,
xxen_util.meaning(paa.consigned_from_supplier_flag,'YES_NO',0) consigned_from_supplier,
paa.consigned_billing_cycle,
paa.last_billing_date,
xxen_util.meaning(paa.consume_on_aging_flag,'YES_NO',0) consume_on_aging,
paa.aging_period
from
po_approved_supplier_list pasl,
mtl_parameters mp1,
mtl_parameters mp2,
hr_all_organization_units_tl haout1,
hr_all_organization_units_tl haout2,
hr_all_organization_units_tl haout3,
mtl_system_items_vl msiv,
mtl_categories_kfv mck,
ap_suppliers aps,
ap_supplier_sites_all assa,
mtl_manufacturers mm,
po_asl_statuses pas,
po_approved_supplier_list pasl1 ,
mtl_manufacturers mm1,
(select padv.* from po_asl_documents_v padv where '&document_enable'='Y') padv,
po_headers_all pha,
po_asl_attributes paa,
per_people_x ppx,
chv_bucket_patterns cbp1,
chv_bucket_patterns cbp2,
(select ca.* from chv_authorizations ca where '&authorization_enable'='Y') ca,
(select psic.* from po_supplier_item_capacity psic where '&supplier_capacity_enable'='Y') psic,
(select psit.* from po_supplier_item_tolerance psit where '&supplier_tolerance_enable'='Y') psit
where
1=1 and
pasl.owning_organization_id=mp1.organization_id and
pasl.owning_organization_id=haout1.organization_id and
pasl.using_organization_id=mp2.organization_id(+) and
pasl.using_organization_id=haout2.organization_id(+) and
haout1.language(+)=userenv('lang') and
haout2.language(+)=userenv('lang') and
haout3.language(+)=userenv('lang') and
pasl.owning_organization_id=msiv.organization_id(+) and
pasl.item_id=msiv.inventory_item_id(+) and
pasl.category_id=mck.category_id(+) and
pasl.vendor_id=aps.vendor_id(+) and
pasl.vendor_site_id=assa.vendor_site_id(+) and
assa.org_id=haout3.organization_id(+) and
pasl.manufacturer_id=mm.manufacturer_id(+) and
pasl.asl_status_id=pas.status_id and
pasl.manufacturer_asl_id=pasl1.asl_id(+) and
pasl1.manufacturer_id=mm1.manufacturer_id(+) and
pasl.asl_id=padv.asl_id(+) and
pasl.using_organization_id=padv.using_organization_id(+) and
pasl.asl_id=paa.asl_id(+) and
padv.document_header_id=pha.po_header_id(+) and
pasl.using_organization_id=paa.using_organization_id(+) and
paa.scheduler_id=ppx.person_id(+) and
paa.plan_bucket_pattern_id=cbp1.bucket_pattern_id(+) and
paa.ship_bucket_pattern_id=cbp2.bucket_pattern_id(+) and
pasl.asl_id=ca.reference_id(+) and
pasl.using_organization_id=ca.using_organization_id(+) and
ca.reference_type(+)='ASL' and
pasl.asl_id=psic.asl_id(+) and
pasl.using_organization_id=psic.using_organization_id(+) and
pasl.asl_id=psit.asl_id(+) and
pasl.using_organization_id=psit.using_organization_id(+)
order by
mp1.organization_code,
mck.concatenated_segments,
msiv.concatenated_segments,
decode(pasl.vendor_business_type,'MANUFACTURER',mm.manufacturer_name,aps.vendor_name),
assa.vendor_site_code,
mp2.organization_code