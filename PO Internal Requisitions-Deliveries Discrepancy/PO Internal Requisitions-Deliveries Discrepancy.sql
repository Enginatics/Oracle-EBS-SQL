/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Internal Requisitions/Deliveries Discrepancy
-- Description: Application: Purchasing
Description: Internal Requisitions/Deliveries Discrepancy Report
Source: Internal Requisitions/Deliveries Discrepancy Report (XML)
Short Name: POXRQSDD_XML
-- Excel Examle Output: https://www.enginatics.com/example/po-internal-requisitions-deliveries-discrepancy/
-- Library Link: https://www.enginatics.com/reports/po-internal-requisitions-deliveries-discrepancy/
-- Run Report: https://demo.enginatics.com/

select
req.operating_unit,
req.req_number,
req.req_type,
req.req_date,
req.destination_oganization,
req.requestor,
req.line_number,
req.item,
req.item_revision,
req.item_description,
req.source_organization,
req.source_subinventory,
req.unit_price,
req.uom,
req.quantity_requested,
shp.quantity_shipped,
shp.amount_shipped,
req.quantity_delivered,
req.amount_delivered,
shp.quantity_shipped-nvl(req.quantity_delivered,0) quantity_variance,
shp.amount_shipped-nvl(req.amount_delivered,0) cost_variance
from
(
select
hou.name operating_unit,
prha.segment1 req_number,
xxen_util.meaning(prha.type_lookup_code,'REQUISITION TYPE',201) req_type,
prla.creation_date req_date,
mp.organization_code destination_oganization,
papf.full_name requestor,
prla.line_num line_number,
pspa.order_source_id,
msiv.concatenated_segments item,
prla.item_revision,
msiv.description item_description,
ood.organization_name source_organization,
prla.source_subinventory,
prla.unit_meas_lookup_code uom,
prla.unit_price,
prla.quantity-nvl(prla.quantity_cancelled,0) quantity_requested,
prla.quantity_delivered,
prla.quantity_delivered*nvl(prla.unit_price,0) amount_delivered,
prla.requisition_header_id,
prla.requisition_line_id
from
po_requisition_headers prha,
po_requisition_lines prla,
mtl_system_items_vl msiv,
per_all_people_f papf,
org_organization_definitions ood,
po_system_parameters pspa,
hr_operating_units hou,
mtl_parameters mp
where
1=1 and
prla.quantity_delivered>0 and
hou.organization_id=prha.org_id and
pspa.org_id=prha.org_id and
prla.requisition_header_id=prha.requisition_header_id and
prla.source_type_code='INVENTORY' and
nvl(prha.transferred_to_oe_flag,'N')='Y' and
prla.source_organization_id=ood.organization_id and
papf.person_id=prla.to_person_id and
msiv.inventory_item_id=prla.item_id and
nvl(msiv.organization_id,prla.source_organization_id)=prla.source_organization_id and
trunc(sysdate) between papf.effective_start_date and papf.effective_end_date and
prla.destination_organization_id=mp.organization_id
) req,
(
select
oola.order_source_id,
oola.orig_sys_document_ref,
oola.orig_sys_line_ref,
oola.source_document_id,
oola.source_document_line_id,
sum(oola.shipped_quantity) quantity_shipped,
sum(nvl(oola.unit_selling_price,0) * nvl(oola.shipped_quantity,0)) amount_shipped
from
oe_order_lines_all oola,
oe_order_headers_all ooha
where
oola.header_id=ooha.header_id and
oola.shipped_quantity is not null
group by
oola.order_source_id,
oola.orig_sys_document_ref,
oola.orig_sys_line_ref,
oola.source_document_id,
oola.source_document_line_id
) shp
where
req.order_source_id=shp.order_source_id(+) and
req.req_number=shp.orig_sys_document_ref(+) and
req.line_number=shp.orig_sys_line_ref(+) and
req.requisition_header_id=shp.source_document_id(+) and
req.requisition_line_id=shp.source_document_line_id(+)
order by
case :p_orderby
when 'REQUESTOR' then req.requestor
when 'SUBINVENTORY' then req.source_subinventory
end,
req.req_date,
req.req_number