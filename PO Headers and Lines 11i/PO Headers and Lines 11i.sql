/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Headers and Lines 11i
-- Description: PO headers, lines, receiving transactions and corresponding AP invoices
-- Excel Examle Output: https://www.enginatics.com/example/po-headers-and-lines-11i/
-- Library Link: https://www.enginatics.com/reports/po-headers-and-lines-11i/
-- Run Report: https://demo.enginatics.com/

select
x.po_number,
x.revision,
x.release,
x.type,
x.supplier_name,
x.supplier_site,
x.buyer,
x.status,
x.description,
x.line_num,
x.line_type,
x.project,
x.task,
x.item,
x.item_description,
x.item_type,
x.uom,
x.frozen_cost,
x.pending_cost,
x.shipment_num,
x.quantity,
x.price,
x.amount,
x.currency,
x.wip_job,
xxen_util.client_time(x.need_by_date) need_by,
xxen_util.client_time(x.last_accept_date) last_accept_date,
xxen_util.client_time(x.promised_date) promised,
xxen_util.client_time(x.original_promise) original_promise,
x.supplier_item,
x.contact_name,
x.contact_phone,
x.contact_email,
x.ship_to,
xxen_util.client_time(x.approved_date) approved_date,
xxen_util.client_time(x.request_date) request_date,
x.match_approval_level,
x.match_option,
xxen_util.client_time(x.receipt_date) receipt_date,
round(x.receipt_date-x.approved_date) delivery_time,
x.delivery_delay,
x.invoice,
x.invoice_line,
x.invoice_date,
x.invoice_status,
x.invoice_line_amount,
x.invoice_amount,
x.amount_paid,
x.receiver,
x.location_code,
x.receiving_organization,
x.packing_slip,
x.receipt,
x.receipt_line_number,
x.receipt_quantity,
x.quantity_ordered,
x.quantity_cancelled,
x.quantity_received,
x.quantity_due,
x.quantity_billed,
x.primary_quantity,
x.primary_unit_of_measure,
x.po_unit_price,
x.receiving_shipment_num,
x.quantity_shipped,
x.item_category,
x.vendor_item_num,
x.shipment_line_status,
x.supplier_number,
x.supplier_address1,
x.supplier_address2,
x.supplier_address3,
x.supplier_zip,
x.supplier_city,
x.supplier_country,
x.po_created_by,
xxen_util.client_time(x.po_creation_date) po_creation_date,
x.operating_unit,
x.po_header_id,
x.po_line_id
from
(
select
pha.segment1 po_number,
pha.revision_num revision,
pra.release_num release,
pdtav.type_name type,
aps.vendor_name supplier_name,
assa.vendor_site_code supplier_site,
ppx.full_name buyer,
po_headers_sv3.get_po_status(pha.po_header_id) status,
pha.comments description,
pla.line_num,
pltv.line_type,
u.project,
v.task,
msiv.concatenated_segments item,
coalesce(rsl.item_description,msiv.description,pla.item_description) item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
muot.unit_of_measure_tl uom,
cic1.item_cost frozen_cost,
cic3.item_cost pending_cost,
plla.shipment_num,
plla.quantity,
nvl(plla.price_override,pla.unit_price) price,
plla.quantity*nvl(plla.price_override,pla.unit_price) amount,
pha.currency_code currency,
(
select distinct
listagg(y.wip_entity_name,', ') within group (order by y.wip_entity_name) over (partition by y.line_id) wip_entity_name
from
(
select distinct
mipo.line_id,
we.wip_entity_name
from
mrp_item_purchase_orders mipo,
mrp_recommendations mr,
mrp_full_pegging mfp,
mrp_gross_requirements mgr,
wip_entities we
where
mipo.transaction_id=mr.disposition_id and
mr.order_type in (1,8) and
mr.organization_id=mfp.organization_id and
mr.compile_designator=mfp.compile_designator and
mr.transaction_id=mfp.transaction_id and
mfp.demand_id=mgr.demand_id and
mgr.origination_type in (2,3,17,25,26) and
mgr.disposition_id=we.wip_entity_id
) y
where
pla.po_line_id=y.line_id
) wip_job,
plla.need_by_date,
plla.last_accept_date,
plla.promised_date,
(select distinct min(pllaa.promised_date) keep (dense_rank first order by pllaa.revision_num) promised_date from po_line_locations_archive_all pllaa where plla.line_location_id=pllaa.line_location_id and pllaa.promised_date is not null) original_promise,
pla.vendor_product_num supplier_item,
nvl2(pvc.first_name,pvc.first_name||' ',null)||nvl2(pvc.middle_name,pvc.middle_name||' ',null)||pvc.first_name contact_name,
pvc.area_code||pvc.phone contact_phone,
pvc.email_address contact_email,
hlat.location_code ship_to,
rsh.receipt_num receipt,
(
select distinct
min(pah.action_date) keep (dense_rank first order by pah.sequence_num) over (partition by pah.object_type_code,pah.object_sub_type_code,pah.object_id) action_date
from
po_action_history pah
where
nvl(plla.po_release_id,pha.po_header_id)=pah.object_id and
nvl2(plla.po_release_id,'RELEASE','PO')=pah.object_type_code and
nvl2(plla.po_release_id,'BLANKET','STANDARD')=pah.object_sub_type_code and
pah.action_code='APPROVE'
) approved_date,
coalesce(plla.promised_date,plla.need_by_date,plla.last_accept_date) request_date,
decode(pha.type_lookup_code,'STANDARD',
case
when plla.inspection_required_flag='N' and plla.receipt_required_flag='N' then '2-Way'
when plla.inspection_required_flag='N' and plla.receipt_required_flag='Y' then '3-Way'
when plla.inspection_required_flag='Y' and plla.receipt_required_flag='Y' then '4-Way'
end) match_approval_level,
xxen_util.meaning(plla.match_option,'POS_INVOICE_MATCH_OPTION',0) match_option,
rt.transaction_date receipt_date,
trunc(rt.transaction_date-coalesce(plla.promised_date,plla.need_by_date,plla.last_accept_date)) delivery_delay,
aia.invoice_num invoice,
aila.line_number invoice_line,
aia.invoice_date,
xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id) invoice_status,
aila.amount invoice_line_amount,
aia.invoice_amount,
aia.amount_paid,
ppx2.full_name receiver,
hla.location_code,
mp.organization_code receiving_organization,
rsh.packing_slip,
rsl.line_num receipt_line_number,
rt.quantity receipt_quantity,
nvl(plla.quantity, pla.quantity) quantity_ordered,
plla.quantity_cancelled,
plla.quantity_received,
nvl(plla.quantity, pla.quantity)-nvl(plla.quantity_cancelled,0)-nvl(plla.quantity_received,0) quantity_due,
plla.quantity_billed,
rt.primary_quantity,
rt.primary_unit_of_measure,
rt.po_unit_price,
rsh.shipment_num receiving_shipment_num,
rsl.quantity_shipped,
mck.concatenated_segments item_category,
rsl.vendor_item_num,
xxen_util.meaning(rsl.shipment_line_status_code,'SHIPMENT LINE STATUS',201) shipment_line_status,
aps.segment1 supplier_number,
assa.address_line1 supplier_address1,
assa.address_line2 supplier_address2,
assa.address_line3 supplier_address3,
assa.zip supplier_zip,
assa.city supplier_city,
nvl(ftv.territory_short_name,assa.country) supplier_country,
xxen_util.user_name(pha.created_by) po_created_by,
pha.creation_date po_creation_date,
pla.operating_unit,
pla.po_header_id,
pla.po_line_id
from
po_headers_all pha,
po_vendors aps,
po_vendor_sites_all assa,
fnd_territories_vl ftv,
po_vendor_contacts pvc,
po_document_types_all_vl pdtav,
(
select
pla.*,
(select fspa.inventory_organization_id from financials_system_params_all fspa where hou.set_of_books_id=fspa.set_of_books_id and pla.org_id=fspa.org_id) inventory_organization_id,
hou.name operating_unit
from
&xrrpv_table
po_lines_all pla,
hr_operating_units hou
where
2=2 and
pla.org_id=hou.organization_id
) pla,
(
select distinct
pda.line_location_id,
listagg(ppa.segment1,', ') within group (order by ppa.segment1) over (partition by pda.line_location_id) project
from
(select distinct pda.line_location_id, pda.project_id from po_distributions_all pda where pda.project_id is not null) pda,
pa_projects_all ppa
where
pda.project_id=ppa.project_id
) u,
(
select distinct
pda.line_location_id,
listagg(pda.task_number,', ') within group (order by pda.task_number) over (partition by pda.line_location_id) task
from
(
select distinct
pda.line_location_id,
pt.task_number
from
po_distributions_all pda,
pa_tasks pt
where
pda.task_id=pt.task_id
) pda
) v,
po_line_types_v pltv,
po_line_locations_all plla,
hr_locations_all_tl hlat,
per_people_x ppx,
po_releases_all pra,
rcv_transactions rt,
rcv_shipment_headers rsh,
rcv_shipment_lines rsl,
per_people_x ppx2,
hr_locations_all hla,
mtl_parameters mp,
mtl_system_items_vl msiv,
mtl_units_of_measure_tl muot,
cst_item_costs cic1,
cst_item_costs cic3,
mtl_categories_kfv mck,
(
select
pda.line_location_id po_line_location_id,
aida.invoice_id,
aida.distribution_line_number line_number,
aida.amount
from
ap_invoice_distributions_all aida,
po_distributions_all pda
where
aida.po_distribution_id=pda.po_distribution_id and
aida.line_type_lookup_code='ITEM'
) aila,
ap_invoices_all aia
where
1=1 and
pha.vendor_id=aps.vendor_id and
pha.vendor_site_id=assa.vendor_site_id and
assa.country=ftv.territory_code(+) and
pha.vendor_contact_id=pvc.vendor_contact_id(+) and
pha.vendor_site_id=pvc.vendor_site_id(+) and
pdtav.document_type_code(+) in ('PO','PA') and
pha.type_lookup_code=pdtav.document_subtype(+) and
pha.org_id=pdtav.org_id(+) and
pha.po_header_id=pla.po_header_id and
pla.line_type_id=pltv.line_type_id(+) and
pla.po_line_id=plla.po_line_id and
plla.line_location_id=u.line_location_id(+) and
plla.line_location_id=v.line_location_id(+) and
plla.shipment_type in ('STANDARD','PLANNED','PRICE BREAK','RFQ','QUOTATION','BLANKET') and
plla.ship_to_location_id=hlat.location_id(+) and
hlat.language(+)=userenv('lang') and
pla.inventory_organization_id=msiv.organization_id(+) and
pla.item_id=msiv.inventory_item_id(+) and
pla.unit_meas_lookup_code=muot.unit_of_measure(+) and
muot.language(+)=userenv('lang') and
pla.inventory_organization_id=cic1.organization_id(+) and
pla.inventory_organization_id=cic3.organization_id(+) and
pla.item_id=cic1.inventory_item_id(+) and
pla.item_id=cic3.inventory_item_id(+) and
cic1.cost_type_id(+)=1 and
cic3.cost_type_id(+)=3 and
pha.agent_id=ppx.person_id(+) and
plla.po_release_id=pra.po_release_id(+) and
plla.line_location_id=rt.po_line_location_id(+) and
rt.transaction_type(+)='RECEIVE' and
rt.shipment_header_id=rsh.shipment_header_id(+) and
rt.shipment_line_id=rsl.shipment_line_id(+) and
rt.employee_id=ppx2.person_id(+) and
rt.location_id=hla.location_id(+) and
rt.organization_id=mp.organization_id(+) and
rsl.category_id=mck.category_id(+) and
plla.line_location_id=aila.po_line_location_id(+) and
aila.invoice_id=aia.invoice_id(+)
) x
order by
x.operating_unit,
x.item,
xxen_util.client_time(x.po_creation_date) desc,
x.po_number,
x.line_num,
x.release desc nulls last,
x.shipment_num desc