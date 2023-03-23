/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Headers and Lines
-- Description: PO headers, lines, receiving transactions and corresponding AP invoices
-- Excel Examle Output: https://www.enginatics.com/example/po-headers-and-lines/
-- Library Link: https://www.enginatics.com/reports/po-headers-and-lines/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.po_number,
x.closed_date,
x.revision,
x.supplier_name,
x.supplier_site,
x.buyer,
x.status,
x.description,
x.release,
x.release_revision,
x.release_status,
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
x.shipment_number,
x.distribution_num,
x.price,
x.price_break_quantity,
x.break_price,
x.break_price_discount,
x.quantity,
x.amount,
x.currency,
x.exchange_rate_type,
x.exchange_rate_date,
x.exchange_rate,
x.wip_job,
x.wip_job_batch,
xxen_util.client_time(x.need_by_date) need_by,
xxen_util.client_time(x.last_accept_date) last_accept_date,
xxen_util.client_time(x.promised_date) promised,
xxen_util.client_time(x.original_promise) original_promise,
x.supplier_item,
x.contact_name,
x.contact_phone,
x.contact_email,
x.destination_type,
x.ship_to_organization,
x.ship_to,
xxen_util.client_time(x.approved_date) approved_date,
xxen_util.client_time(x.request_date) request_date,
x.match_approval_level,
x.match_option,
trunc(xxen_util.client_time(x.receipt_date)) receipt_date,
to_char(xxen_util.client_time(x.receipt_date),'HH24:MI:SS') receipt_time,
round(x.receipt_date-x.approved_date) delivery_time,
x.delivery_delay,
aia.invoice_num invoice,
aila.line_number invoice_line,
aia.invoice_date,
aila.accounting_date,
aila.period_name,
xxen_util.ap_invoice_status(aia.invoice_id,aia.invoice_amount,aia.payment_status_flag,aia.invoice_type_lookup_code,aia.validation_request_id) invoice_status,
aila.amount invoice_line_amount,
aia.invoice_amount,
aia.amount_paid,
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
(x.receipt_quantity - x.quantity_billed) grni_quantity,
(x.price * (x.receipt_quantity - x.quantity_billed)) grni_amount,
x.primary_quantity,
x.primary_unit_of_measure,
x.po_unit_price,
x.receiving_shipment_number,
x.shipped_date,
x.quantity_shipped,
x.item_category,
x.vendor_item_num,
x.shipment_line_status,
x.asn_line_flag,
x.supplier_number,
x.supplier_address1,
x.supplier_address2,
x.supplier_address3,
x.supplier_zip,
x.supplier_city,
x.supplier_country,
x.document_type,
x.document_number,
x.document_revision,
x.document_closed_status,
xxen_util.client_time(x.document_creation_date) document_creation_date,
x.document_created_by,
xxen_util.client_time(x.document_revised_date) document_revised_date,
x.document_total_amount,
x.document_amount_limit,
x.document_min_release_amount,
nvl2(x.po_release_id,x.release_amount,x.po_amount) document_amount,
nvl2(x.po_release_id,x.release_matched_amount,x.po_matched_amount) document_matched_amount,
x.charge_account,
x.accrual_account,
x.po_created_by,
xxen_util.client_time(x.po_creation_date) po_creation_date,
x.release_created_by,
xxen_util.client_time(x.release_creation_date) release_creation_date,
x.po_header_id,
x.po_line_id,
x.line_location_id,
x.po_release_id,
x.rcv_transaction_id
from
(
--Q1 Standard POs and Releases. i.e. Actual and Planned Shipments/Releases
select
hou.name operating_unit,
pha.segment1 po_number,
pha.revision_num revision,
pha.closed_date,
aps.vendor_name supplier_name,
assa.vendor_site_code supplier_site,
ppx.full_name buyer,
po_headers_sv3.get_po_status(pha.po_header_id) status,
pha.comments description,
po_inq_sv.get_po_total(pha.type_lookup_code,pha.po_header_id,null) po_amount,
(
select
sum(decode(polla.matching_basis,'AMOUNT',
          (nvl(polla.amount_financed,0)+nvl(polla.amount_billed,0)-nvl(polla.amount_recouped,0)),
          (nvl(polla.quantity_financed,0)+nvl(polla.quantity_billed,0)-nvl(polla.quantity_recouped,0))*nvl(polla.price_override,0)
   ))
from
po_line_locations_all polla
where
polla.po_header_id = pha.po_header_id and
polla.shipment_type != 'SCHEDULED'
) po_matched_amount,
pra.release_num release,
pra.revision_num release_revision,
po_releases_sv2.get_release_status(pra.po_release_id) release_status,
nvl2(pra.po_release_id,po_inq_sv.get_po_total(null,null,pra.po_release_id),null) release_amount,
nvl2(pra.po_release_id,decode(:p_show_distributions,'Y',nvl(pda.amount_billed,0),(select nvl(sum(nvl(pda.amount_billed,0)),0) from po_distributions_all pda where pra.po_release_id=pda.po_release_id)),null) release_matched_amount,
pla.line_num,
pltv.line_type,
u.project,
v.task,
msiv.concatenated_segments item,
coalesce(rsl.item_description,msiv.description,pla.item_description) item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
muomt.unit_of_measure_tl uom,
cic1.item_cost frozen_cost,
cic3.item_cost pending_cost,
plla.shipment_num shipment_number,
pda.distribution_num,
nvl(plla.price_override,pla.unit_price) price,
to_number(null) price_break_quantity,
to_number(null) break_price,
to_number(null) break_price_discount,
decode(:p_show_distributions,'Y',pda.quantity_ordered,plla.quantity) quantity,
decode(:p_show_distributions,'Y',pda.quantity_ordered,plla.quantity)*nvl(plla.price_override,pla.unit_price) amount,
pha.currency_code currency,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where gdct.conversion_type = pha.rate_type) exchange_rate_type,
pha.rate_date exchange_rate_date,
pha.rate exchange_rate,
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
decode(:p_show_distributions,'Y',
 (select we.wip_entity_name from wip_entities we where pda.wip_entity_id=we.wip_entity_id),
 (select distinct
  listagg(y.wip_entity_name,', ') within group (order by y.wip_entity_name) over (partition by y.line_location_id) wip_entity_name
  from
  (select distinct
   pda.line_location_id,
   we.wip_entity_name
   from
   po_distributions_all pda,
   wip_entities we
   where
   pda.wip_entity_id=we.wip_entity_id
  ) y
  where
  plla.line_location_id=y.line_location_id
 )
) wip_job_batch,
plla.need_by_date,
plla.last_accept_date,
plla.promised_date,
(select distinct min(pllaa.promised_date) keep (dense_rank first order by pllaa.revision_num) promised_date from po_line_locations_archive_all pllaa where plla.line_location_id=pllaa.line_location_id and pllaa.promised_date is not null) original_promise,
pla.vendor_product_num supplier_item,
nvl2(pvc.first_name,pvc.first_name||' ',null)||nvl2(pvc.middle_name,pvc.middle_name||' ',null)||pvc.first_name contact_name,
pvc.area_code||pvc.phone contact_phone,
pvc.email_address contact_email,
xxen_util.meaning(decode(:p_show_distributions,'Y',pda.destination_type_code,(select pda.destination_type_code from po_distributions_all pda where plla.line_location_id=pda.line_location_id and rownum=1)),'DESTINATION TYPE',201) destination_type,
mp.organization_code ship_to_organization,
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
ppx2.full_name receiver,
hla.location_code,
mp2.organization_code receiving_organization,
rsh.packing_slip,
rsl.line_num receipt_line_number,
rt.quantity receipt_quantity,
decode(:p_show_distributions,'Y',pda.quantity_ordered,nvl(plla.quantity, pla.quantity)) quantity_ordered,
decode(:p_show_distributions,'Y',pda.quantity_cancelled,plla.quantity_cancelled) quantity_cancelled,
decode(:p_show_distributions,'Y',
plla.quantity_received*(pda.quantity_ordered-nvl(pda.quantity_cancelled,0))/xxen_util.zero_to_null(plla.quantity-nvl(plla.quantity_cancelled,0)),
plla.quantity_received 
) quantity_received,
decode(:p_show_distributions,'Y',
pda.quantity_ordered-nvl(pda.quantity_cancelled,0)-(plla.quantity_received*(pda.quantity_ordered-nvl(pda.quantity_cancelled,0))/xxen_util.zero_to_null(plla.quantity-nvl(plla.quantity_cancelled,0))),
nvl(plla.quantity, pla.quantity)-nvl(plla.quantity_cancelled,0)-nvl(plla.quantity_received,0) 
) quantity_due,
decode(:p_show_distributions,'Y',pda.quantity_billed,plla.quantity_billed) quantity_billed,
rt.primary_quantity,
rt.primary_unit_of_measure,
rt.po_unit_price,
rsh.shipment_num receiving_shipment_number,
rsh.shipped_date,
rsl.quantity_shipped,
mck.concatenated_segments item_category,
rsl.vendor_item_num,
xxen_util.meaning(rsl.shipment_line_status_code,'SHIPMENT LINE STATUS',201) shipment_line_status,
xxen_util.meaning(rsl.asn_line_flag,'YES_NO',0) asn_line_flag,
aps.segment1 supplier_number,
assa.address_line1 supplier_address1,
assa.address_line2 supplier_address2,
assa.address_line3 supplier_address3,
assa.zip supplier_zip,
assa.city supplier_city,
nvl(ftv.territory_short_name,assa.country) supplier_country,
pdtav.type_name document_type,
pha.segment1 || nvl2(pra.po_release_id,' (' || pra.release_num || ')',null) document_number,
nvl2(pra.po_release_id,pra.revision_num,pha.revision_num) document_revision,
case when nvl2(pra.po_release_id,nvl(pra.closed_code,'x') ,nvl(pha.closed_code,'x')) in ('CLOSED','FINALLY CLOSED')
then xxen_util.meaning('CLOSED','DOCUMENT STATE',201)
else xxen_util.meaning('OPEN','DOCUMENT STATE',201)
end document_closed_status,
nvl2(pra.po_release_id,pra.creation_date,pha.creation_date) document_creation_date,
xxen_util.user_name(nvl2(pra.po_release_id,pra.created_by,pha.created_by)) document_created_by,
nvl2(pra.po_release_id,pra.revised_date,pha.revised_date) document_revised_date,
to_number(null) document_total_amount,
to_number(null) document_amount_limit,
to_number(null) document_min_release_amount,
case when pda.code_combination_id is not null then fnd_flex_xml_publisher_apis.process_kff_combination_1('seg','SQLGL','GL#',pda.chart_of_accounts_id,NULL,pda.code_combination_id,'ALL','Y','VALUE') end charge_account,
case when pda.accrual_account_id is not null then fnd_flex_xml_publisher_apis.process_kff_combination_1('seg','SQLGL','GL#',pda.chart_of_accounts_id,NULL,pda.accrual_account_id,'ALL','Y','VALUE') else null
end accrual_account,
xxen_util.user_name(pha.created_by) po_created_by,
pha.creation_date po_creation_date,
xxen_util.user_name(pra.created_by) release_created_by,
pra.creation_date release_creation_date,
pha.po_header_id,
pla.po_line_id,
plla.line_location_id,
pra.po_release_id,
rt.transaction_id rcv_transaction_id
from
po_headers_all pha,
(
select
pla.*,
(select fspa.inventory_organization_id from financials_system_params_all fspa where hou.set_of_books_id=fspa.set_of_books_id and pla.org_id=fspa.org_id) inventory_organization_id,
hou.name operating_unit
from
po_lines_all pla,
hr_operating_units hou
where
2=2 and
pla.org_id=hou.organization_id
) pla,
po_line_locations_all plla,
( 
select
pda.*,
(select gsob.chart_of_accounts_id from gl_sets_of_books gsob where gsob.set_of_books_id = pda.set_of_books_id) chart_of_accounts_id
from
po_distributions_all pda
where
:p_show_distributions='Y'
) pda,
po_releases_all pra,
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
hr_operating_units hou,
ap_suppliers aps,
ap_supplier_sites_all assa,
fnd_territories_vl ftv,
po_vendor_contacts pvc,
po_document_types_all_vl pdtav,
po_line_types_v pltv,
hr_locations_all_tl hlat,
per_people_x ppx,
rcv_shipment_lines rsl,
rcv_shipment_headers rsh,
rcv_transactions rt,
per_people_x ppx2,
hr_locations_all hla,
mtl_parameters mp,
mtl_parameters mp2,
mtl_system_items_vl msiv,
mtl_units_of_measure_tl muomt,
cst_item_costs cic1,
cst_item_costs cic3,
mtl_categories_kfv mck
where
1=1 and
3=3 and
pha.type_lookup_code in ('STANDARD','BLANKET','PLANNED') and
pha.po_header_id=pla.po_header_id and
pla.po_line_id=plla.po_line_id and
plla.shipment_type in ('STANDARD','BLANKET','PLANNED','SCHEDULED') and
plla.line_location_id=pda.line_location_id(+) and
plla.po_release_id=pra.po_release_id(+) and
plla.line_location_id=u.line_location_id(+) and
plla.line_location_id=v.line_location_id(+) and
pha.vendor_id=aps.vendor_id and
pha.vendor_site_id=assa.vendor_site_id and
pha.org_id=hou.organization_id and
assa.country=ftv.territory_code(+) and
pha.vendor_contact_id=pvc.vendor_contact_id(+) and
pha.vendor_site_id=pvc.vendor_site_id(+) and
nvl2(pra.po_release_id,pra.release_type,pha.type_lookup_code)=pdtav.document_subtype and
nvl2(pra.po_release_id,pra.org_id,pha.org_id)=pdtav.org_id and
(pra.po_release_id is null and pdtav.document_type_code in ('PO','PA') or pra.po_release_id is not null and pdtav.document_type_code='RELEASE') and
pla.line_type_id=pltv.line_type_id(+) and
plla.ship_to_organization_id=mp.organization_id(+) and
plla.ship_to_location_id=hlat.location_id(+) and
hlat.language(+)=userenv('lang') and
pla.inventory_organization_id=msiv.organization_id(+) and
pla.item_id=msiv.inventory_item_id(+) and
pla.unit_meas_lookup_code=muomt.unit_of_measure(+) and
muomt.language(+)=userenv('lang') and
pla.inventory_organization_id=cic1.organization_id(+) and
pla.inventory_organization_id=cic3.organization_id(+) and
pla.item_id=cic1.inventory_item_id(+) and
pla.item_id=cic3.inventory_item_id(+) and
cic1.cost_type_id(+)=1 and
cic3.cost_type_id(+)=3 and
pha.agent_id=ppx.person_id(+) and
&lp_shipment_line_join
rsl.shipment_header_id=rsh.shipment_header_id(+) and
rsl.shipment_line_id=rt.shipment_line_id(+) and
rt.transaction_type(+)='RECEIVE' and
rt.employee_id=ppx2.person_id(+) and
rt.location_id=hla.location_id(+) and
rt.organization_id=mp2.organization_id(+) and
rsl.category_id=mck.category_id(+)
union all
--Q2 Blanket and Contract Purchase Agreements
select
hou.name operating_unit,
pha.segment1 po_number,
pha.revision_num revision,
pha.closed_date,
aps.vendor_name supplier_name,
assa.vendor_site_code supplier_site,
ppx.full_name buyer,
po_headers_sv3.get_po_status(pha.po_header_id) status,
pha.comments description,
po_inq_sv.get_po_total(pha.type_lookup_code,pha.po_header_id,null) po_amount,
(
select
sum(decode(polla.matching_basis,'AMOUNT',
          (nvl(polla.amount_financed,0)+nvl(polla.amount_billed,0)-nvl(polla.amount_recouped,0)),
          (nvl(polla.quantity_financed,0)+nvl(polla.quantity_billed,0)-nvl(polla.quantity_recouped,0))*nvl(polla.price_override,0)
   ))
from
po_line_locations_all polla
where
polla.po_header_id = pha.po_header_id and
polla.shipment_type != 'SCHEDULED'
) po_matched_amount,
null release,
null release_status,
null release_revision,
null release_amount,
null release_matched_amount,
pla.line_num,
pltv.line_type,
null project,
null task,
msiv.concatenated_segments item,
coalesce(msiv.description,pla.item_description) item_description,
xxen_util.meaning(msiv.item_type,'ITEM_TYPE',3) item_type,
muomt.unit_of_measure_tl uom,
cic1.item_cost frozen_cost,
cic3.item_cost pending_cost,
plla.shipment_num shipment_number,
null distribution_num,
pla.unit_price price,
plla.quantity price_break_quantity,
nvl(plla.price_override,pla.unit_price) break_price,
plla.price_discount break_price_discount,
null quantity,
null amount,
pha.currency_code currency,
(select gdct.user_conversion_type from gl_daily_conversion_types gdct where gdct.conversion_type = pha.rate_type) exchange_rate_type,
pha.rate_date exchange_rate_date,
pha.rate exchange_rate,
null wip_job,
null wip_job_batch,
null need_by_date,
null last_accept_date,
null promised_date,
null original_promise,
pla.vendor_product_num supplier_item,
nvl2(pvc.first_name,pvc.first_name||' ',null)||nvl2(pvc.middle_name,pvc.middle_name||' ',null)||pvc.first_name contact_name,
pvc.area_code||pvc.phone contact_phone,
pvc.email_address contact_email,
null destination_type,
mp.organization_code ship_to_organization,
hlat.location_code ship_to,
null receipt,
(
select distinct
min(pah.action_date) keep (dense_rank first order by pah.sequence_num) over (partition by pah.object_type_code,pah.object_sub_type_code,pah.object_id) action_date
from
po_action_history pah
where
pha.po_header_id=pah.object_id and
pah.object_type_code = 'PA' and
pah.object_sub_type_code=pha.type_lookup_code and
pah.action_code='APPROVE'
) approved_date,
null request_date,
null match_approval_level,
null match_option,
null receipt_date,
null delivery_delay,
null receiver,
null location_code,
null receiving_organization,
null packing_slip,
null receipt_line_number,
null receipt_quantity,
nvl(plla.quantity, pla.quantity) quantity_ordered,
null quantity_cancelled,
null quantity_received,
null quantity_due,
null quantity_billed,
null primary_quantity,
null primary_unit_of_measure,
null po_unit_price,
null receiving_shipment_number,
null shipped_date,
null quantity_shipped,
null item_category,
null vendor_item_num,
null shipment_line_status,
null asn_line_flag,
aps.segment1 supplier_number,
assa.address_line1 supplier_address1,
assa.address_line2 supplier_address2,
assa.address_line3 supplier_address3,
assa.zip supplier_zip,
assa.city supplier_city,
nvl(ftv.territory_short_name,assa.country) supplier_country,
pdtav.type_name document_type,
pha.segment1 document_number,
pha.revision_num document_revision,
case when nvl(pha.closed_code,'x') in ('CLOSED','FINALLY CLOSED')
then xxen_util.meaning('CLOSED','DOCUMENT STATE',201)
else xxen_util.meaning('OPEN','DOCUMENT STATE',201)
end document_closed_status,
pha.creation_date document_creation_date,
xxen_util.user_name(pha.created_by) document_created_by,
pha.revised_date document_revised_date,
pha.blanket_total_amount document_total_amount,
pha.amount_limit document_amount_limit,
pha.min_release_amount document_min_release_amount,
null charge_account,
null accrual_account,
xxen_util.user_name(pha.created_by) po_created_by,
pha.creation_date po_creation_date,
null release_created_by,
null release_creation_date,
pha.po_header_id,
pla.po_line_id,
plla.line_location_id,
null po_release_id,
null rcv_transaction_id
from
po_headers_all pha,
(
select
pla.*,
(select fspa.inventory_organization_id from financials_system_params_all fspa where hou.set_of_books_id=fspa.set_of_books_id and pla.org_id=fspa.org_id) inventory_organization_id,
hou.name operating_unit
from
po_lines_all pla,
hr_operating_units hou
where
2=2 and
pla.org_id=hou.organization_id
) pla,
po_line_locations_all plla,
po_releases_all pra,
hr_operating_units hou,
ap_suppliers aps,
ap_supplier_sites_all assa,
fnd_territories_vl ftv,
po_vendor_contacts pvc,
po_document_types_all_vl pdtav,
po_line_types_v pltv,
mtl_parameters mp,
hr_locations_all_tl hlat,
per_people_x ppx,
mtl_system_items_vl msiv,
mtl_units_of_measure_tl muomt,
cst_item_costs cic1,
cst_item_costs cic3
where
1=1 and
4=4 and
pha.type_lookup_code in ('BLANKET','CONTRACT') and
pha.po_header_id=pla.po_header_id(+) and
pla.po_line_id=plla.po_line_id(+) and
plla.shipment_type(+) not in ('BLANKET') and
--po_releases added for the common dynamic parameter where clauses
--but does not return anything in this query 
pra.po_release_id(+)= -plla.po_release_id and 
pha.vendor_id=aps.vendor_id and
pha.vendor_site_id=assa.vendor_site_id and
pha.org_id=hou.organization_id and
assa.country=ftv.territory_code(+) and
pha.vendor_contact_id=pvc.vendor_contact_id(+) and
pha.vendor_site_id=pvc.vendor_site_id(+) and
pha.type_lookup_code=pdtav.document_subtype and
pha.org_id=pdtav.org_id and
pdtav.document_type_code in ('PA') and
pla.line_type_id=pltv.line_type_id(+) and
plla.ship_to_organization_id=mp.organization_id(+) and
plla.ship_to_location_id=hlat.location_id(+) and
hlat.language(+)=userenv('lang') and
pla.inventory_organization_id=msiv.organization_id(+) and
pla.item_id=msiv.inventory_item_id(+) and
pla.unit_meas_lookup_code=muomt.unit_of_measure(+) and
muomt.language(+)=userenv('lang') and
pla.inventory_organization_id=cic1.organization_id(+) and
pla.inventory_organization_id=cic3.organization_id(+) and
pla.item_id=cic1.inventory_item_id(+) and
pla.item_id=cic3.inventory_item_id(+) and
cic1.cost_type_id(+)=1 and
cic3.cost_type_id(+)=3 and
pha.agent_id=ppx.person_id(+)
) x,
ap_invoice_lines_all aila,
ap_invoices_all aia
where
x.line_location_id=aila.po_line_location_id(+) and
nvl(aila.discarded_flag(+),'N') = 'N' and
aila.invoice_id=aia.invoice_id(+)
order by
x.operating_unit,
x.po_number,
x.release desc,
x.line_num,
x.release desc nulls last,
x.shipment_number desc,
x.distribution_num,
x.item,
xxen_util.client_time(x.po_creation_date) desc