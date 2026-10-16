/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Attached Documents (Operating Unit Secured)
-- Description: Attachments of operating unit striped documents: sales orders and lines, purchase orders, lines, shipments and releases, requisitions, AP invoices, AR transactions, projects and delivery details. Each row shows the document the attachment belongs to, its category, title, file name and a clickable download link for file attachments. Short text, long text and URL attachments are shown inline.
-- The report is secured by operating unit: only documents of the operating units accessible to the running responsibility (profile options MO: Security Profile or MO: Operating Unit) are returned, so it can be assigned to business users without exposing other organizations' attachments. Attachments on entities which are not operating unit striped, such as items, work orders, bills of material, journals, employees or payment instructions, are not included; use the report FND Attached Documents for those.
-- The Sales Order Number, PO Number and Requisition Number parameters return the header and line level attachments of a document. Their lists show only documents with attachments the report can return.
-- The download link is created with Oracle's secure file download for the user running the report and expires after the number of minutes set in profile option FND: Security File Download Time Limit. Re-run the report to get fresh links.
-- Excel Example Output: https://www.enginatics.com/example/fnd-attached-documents-operating-unit-secured/
-- Library Link: https://www.enginatics.com/reports/fnd-attached-documents-operating-unit-secured/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
fdev.application_name application,
haouv.name operating_unit,
nvl(fdev.table_name,fad.entity_name) table_name,
nvl(
case
when fad.entity_name in ('PO_RELEASES','PO_REL') then (select pha.segment1||'-'||pra.release_num from po_releases_all pra, po_headers_all pha where fad.pk1_value=pra.po_release_id and pra.po_header_id=pha.po_header_id)
when fad.entity_name in ('PO_HEADERS','PO_HEAD') then (select pha.segment1 from po_headers_all pha where fad.pk1_value=pha.po_header_id)
when fad.entity_name='PO_LINES' then (select pha.segment1||': '||pla.line_num||': '||pla.item_description from po_lines_all pla, po_headers_all pha where fad.pk1_value=pla.po_line_id and pla.po_header_id=pha.po_header_id)
when fad.entity_name='PO_SHIPMENTS' then (
select
pha.segment1||nvl2(pra.release_num,'-'||pra.release_num,null)||': '||pla.line_num||': '||pla.item_description
from
po_line_locations_all plla,
po_headers_all pha,
po_releases_all pra,
po_lines_all pla
where
fad.pk1_value=plla.line_location_id and
plla.po_header_id=pha.po_header_id and
plla.po_release_id=pra.po_release_id(+) and
plla.po_line_id=pla.po_line_id
)
when fad.entity_name='REQ_HEADERS' then (select prha.segment1 from po_requisition_headers_all prha where fad.pk1_value=prha.requisition_header_id)
when fad.entity_name='REQ_LINES' then (select prha.segment1||': '||prla.line_num||': '||prla.item_description from po_requisition_lines_all prla, po_requisition_headers_all prha where fad.pk1_value=prla.requisition_line_id and prla.requisition_header_id=prha.requisition_header_id)
when fad.entity_name='OE_ORDER_HEADERS' then (select to_char(ooha.order_number) from oe_order_headers_all ooha where fad.pk1_value=ooha.header_id)
when fad.entity_name='OE_ORDER_LINES' then (select ooha.order_number||': '||rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') from oe_order_lines_all oola, oe_order_headers_all ooha where fad.pk1_value=oola.line_id and oola.header_id=ooha.header_id)
when fad.entity_name='WSH_DELIVERY_DETAILS' then (select wdd.source_header_number||': '||wdd.source_line_number from wsh_delivery_details wdd where fad.pk1_value=wdd.delivery_detail_id)
when fad.entity_name='AP_INVOICES' then (select aia.invoice_num from ap_invoices_all aia where fad.pk1_value=aia.invoice_id)
when fad.entity_name='RA_CUSTOMER_TRX' then (select rcta.trx_number from ra_customer_trx_all rcta where fad.pk1_value=rcta.customer_trx_id)
when fad.entity_name='RA_CUSTOMER_TRX_LINES' then (select rcta.trx_number||': '||rctla.line_number from ra_customer_trx_lines_all rctla, ra_customer_trx_all rcta where fad.pk1_value=rctla.customer_trx_line_id and rctla.customer_trx_id=rcta.customer_trx_id)
when fad.entity_name='PA_PROJECTS' then (select ppa.segment1 from pa_projects_all ppa where fad.pk1_value=ppa.project_id)
end,
trim('.' from fad.pk1_value||'.'||fad.pk2_value||'.'||fad.pk3_value||'.'||fad.pk4_value||'.'||fad.pk5_value)) reference,
fad.seq_num,
fdcv.user_name category,
fdt.title,
fdt.description,
fddv.user_name data_type,
decode(fd.datatype_id,5,fd.url,nvl(fl.file_name,fd.file_name)) name,
decode(fd.datatype_id,
5,'=HYPERLINK("'||fd.url||'","'||fd.url||'")',
nvl2(fd.media_id,'HYPERLINK("'||fnd_gfm.construct_download_url(fnd_web_config.gfm_agent,fd.media_id)||'","'||nvl(fl.file_name,fd.file_name)||'")',null)
) url,
fdn.short_name location,
decode(fd.datatype_id,1,to_clob(fdst.short_text),2,fdlt.long_text) text,
fl.file_id,
length(fl.file_data) file_size,
fl.file_content_type content_type,
lower(fl.file_format) file_format,
fl.expiration_date,
xxen_util.meaning(fd.usage_type,'ATCHMT_DOCUMENT_TYPE',0) usage,
decode(fd.security_type,1,'Organization',2,'Set of Books',3,'Business Unit',4,'None') security_type,
decode(fd.security_type,1,haouv_sec.name,2,gl.name) security_owner,
decode(fd.publish_flag,'Y','Y') share_,
fd.start_date_active,
fd.end_date_active,
xxen_util.user_name(fd.created_by) created_by,
xxen_util.client_time(fd.creation_date) creation_date,
fl.program_name,
fd.request_id,
fcpv.user_concurrent_program_name concurrent_program,
xxen_util.client_time(fd.program_update_date) program_update_date,
fad.entity_name,
fd.category_id,
fd.datatype_id
from
fnd_documents fd,
fnd_documents_tl fdt,
fnd_document_datatypes_vl fddv,
fnd_document_categories_vl fdcv,
hr_all_organization_units_vl haouv_sec,
gl_ledgers gl,
fnd_lobs fl,
fnd_concurrent_programs_vl fcpv,
fnd_documents_short_text fdst,
fnd_documents_long_text fdlt,
(
select
fad.*,
case
when fad.entity_name in ('PO_RELEASES','PO_REL') then (select pra.org_id from po_releases_all pra where fad.pk1_value=pra.po_release_id)
when fad.entity_name in ('PO_HEADERS','PO_HEAD') then (select pha.org_id from po_headers_all pha where fad.pk1_value=pha.po_header_id)
when fad.entity_name='PO_LINES' then (select pla.org_id from po_lines_all pla where fad.pk1_value=pla.po_line_id)
when fad.entity_name='PO_SHIPMENTS' then (select plla.org_id from po_line_locations_all plla where fad.pk1_value=plla.line_location_id)
when fad.entity_name='REQ_HEADERS' then (select prha.org_id from po_requisition_headers_all prha where fad.pk1_value=prha.requisition_header_id)
when fad.entity_name='REQ_LINES' then (select prla.org_id from po_requisition_lines_all prla where fad.pk1_value=prla.requisition_line_id)
when fad.entity_name='OE_ORDER_HEADERS' then (select ooha.org_id from oe_order_headers_all ooha where fad.pk1_value=ooha.header_id)
when fad.entity_name='OE_ORDER_LINES' then (select oola.org_id from oe_order_lines_all oola where fad.pk1_value=oola.line_id)
when fad.entity_name='WSH_DELIVERY_DETAILS' then (select wdd.org_id from wsh_delivery_details wdd where fad.pk1_value=wdd.delivery_detail_id)
when fad.entity_name='AP_INVOICES' then (select aia.org_id from ap_invoices_all aia where fad.pk1_value=aia.invoice_id)
when fad.entity_name='RA_CUSTOMER_TRX' then (select rcta.org_id from ra_customer_trx_all rcta where fad.pk1_value=rcta.customer_trx_id)
when fad.entity_name='RA_CUSTOMER_TRX_LINES' then (select rctla.org_id from ra_customer_trx_lines_all rctla where fad.pk1_value=rctla.customer_trx_line_id)
when fad.entity_name='PA_PROJECTS' then (select ppa.org_id from pa_projects_all ppa where fad.pk1_value=ppa.project_id)
end org_id
from
fnd_attached_documents fad
where
3=3 and
fad.entity_name in ('PO_RELEASES','PO_REL','PO_HEADERS','PO_HEAD','PO_LINES','PO_SHIPMENTS','REQ_HEADERS','REQ_LINES','OE_ORDER_HEADERS','OE_ORDER_LINES','WSH_DELIVERY_DETAILS','AP_INVOICES','RA_CUSTOMER_TRX','RA_CUSTOMER_TRX_LINES','PA_PROJECTS')
) fad,
hr_all_organization_units_vl haouv,
fnd_document_entities_vl fdev,
fnd_dm_nodes fdn
where
1=1 and
fd.document_id=fdt.document_id and
fdt.language=userenv('lang') and
fd.datatype_id=fddv.datatype_id and
fd.category_id=fdcv.category_id and
decode(fd.security_type,1,fd.security_id)=haouv_sec.organization_id(+) and
decode(fd.security_type,2,fd.security_id)=gl.ledger_id(+) and
case when fd.datatype_id in (3,6) then fd.media_id end=fl.file_id(+) and
fd.program_application_id=fcpv.application_id(+) and
fd.program_id=fcpv.concurrent_program_id(+) and
decode(fd.datatype_id,1,fd.media_id)=fdst.media_id(+) and
decode(fd.datatype_id,2,fd.media_id)=fdlt.media_id(+) and
fd.document_id=fad.document_id and
fad.org_id=haouv.organization_id and
fad.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat) and
fad.entity_name=fdev.data_object_code(+) and
nvl(fd.dm_node,0)=fdn.node_id(+)
) x
where
2=2
order by
x.creation_date desc,
x.seq_num
