/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FND Attached Documents
-- Description: FND attachments stored in the fnd_lobs table and their corresponding application entity e.g. sales orders that they are attached to.
-- Excel Examle Output: https://www.enginatics.com/example/fnd-attached-documents/
-- Library Link: https://www.enginatics.com/reports/fnd-attached-documents/
-- Run Report: https://demo.enginatics.com/

select
x.*
from
(
select
fdev.application_name appliction,
nvl(fdev.table_name,fad.entity_name) table_name,
nvl(
case
when fad.entity_name in ('PO_RELEASES','PO_REL') then (select haouv.name||': '||pha.segment1||'-'||pra.release_num from hr_all_organization_units_vl haouv, po_headers_all pha, po_releases_all pra where fad.pk1_value=pra.po_release_id and pra.org_id=haouv.organization_id and pra.po_header_id=pha.po_header_id)
when fad.entity_name in ('PO_HEADERS','PO_HEAD') then (select haouv.name||': '||pha.segment1 from hr_all_organization_units_vl haouv, po_headers_all pha where fad.pk1_value=pha.po_header_id and pha.org_id=haouv.organization_id(+))
when fad.entity_name='REQ_HEADERS' then (select haouv.name||': '||prha.segment1 from po_requisition_headers_all prha, hr_all_organization_units_vl haouv where fad.pk1_value=prha.requisition_header_id and prha.org_id=haouv.organization_id(+))
when fad.entity_name='PO_LINES' then (select haouv.name||': '||pha.segment1||': '||pla.line_num||': '||pla.item_description from po_lines_all pla, po_headers_all pha, hr_all_organization_units_vl haouv where fad.pk1_value=pla.po_line_id and pla.po_header_id=pha.po_header_id and pla.org_id=haouv.organization_id(+))
when fad.entity_name='REQ_LINES' then (select haouv.name||': '||prha.segment1||': '||prla.line_num||': '||prla.item_description from po_requisition_lines_all prla, po_requisition_headers_all prha, hr_all_organization_units_vl haouv where fad.pk1_value=prla.requisition_line_id and prla.requisition_header_id=prha.requisition_header_id and prla.org_id=haouv.organization_id(+))
when fad.entity_name='PO_SHIPMENTS' then (
select
haouv.name||': '||pha.segment1||nvl2(pra.release_num,'-'||pra.release_num,null)||': '||pla.line_num||'-'||pla.item_description
from
po_line_locations_all plla,
po_headers_all pha,
po_releases_all pra,
po_lines_all pla,
hr_all_organization_units_vl haouv
where
fad.pk1_value=plla.line_location_id and
plla.po_header_id=pha.po_header_id and
plla.po_release_id=pra.po_release_id(+) and
plla.po_line_id=pla.po_line_id and
pha.org_id=haouv.organization_id(+) and
pha.po_header_id=plla.po_header_id
)
when fad.entity_name='AP_INVOICES' then (select haouv.name||': '||aia.invoice_num from ap_invoices_all aia, hr_all_organization_units_vl haouv where fad.pk1_value=aia.invoice_id and aia.org_id=haouv.organization_id)
when fad.entity_name='MTL_SYSTEM_ITEMS' then (select mp.organization_code||': '||msibk.concatenated_segments from mtl_parameters mp, mtl_system_items_b_kfv msibk where fad.pk1_value=msibk.organization_id and fad.pk2_value=msibk.inventory_item_id and msibk.organization_id=mp.organization_id)
when fad.entity_name='OE_ORDER_HEADERS' then (select haouv.name||': '||ooha.order_number from hr_all_organization_units_vl haouv, oe_order_headers_all ooha where fad.pk1_value=ooha.header_id and haouv.organization_id=ooha.org_id)
when fad.entity_name='OE_ORDER_LINES' then (select haouv.name||': '||ooha.order_number||': '||rtrim(oola.line_number||'.'||oola.shipment_number||'.'||oola.option_number||'.'||oola.component_number||'.'||oola.service_number,'.') from hr_all_organization_units_vl haouv, oe_order_headers_all ooha, oe_order_lines_all oola where fad.pk1_value=oola.line_id and ooha.header_id=oola.header_id and oola.org_id=haouv.organization_id)
when fad.entity_name='BOM_OPERATION_SEQUENCES' then (
select
mp.organization_code||': '||msibk.concatenated_segments||': '||bor.alternate_routing_designator||': '||bos.operation_seq_num
from
mtl_parameters mp,
bom_operational_routings bor,
mtl_system_items_b_kfv msibk,
bom_operation_sequences bos
where
fad.pk1_value=bos.operation_sequence_id and
mp.organization_id=bor.organization_id and
bor.assembly_item_id=msibk.inventory_item_id and
bor.organization_id=msibk.organization_id and
bor.routing_sequence_id=bos.routing_sequence_id
)
when fad.entity_name='BOM_BILL_OF_MATERIALS' then (select mp.organization_code||': '||msibk.concatenated_segments from bom_structures_b bsb, mtl_parameters mp, mtl_system_items_b_kfv msibk where fad.pk1_value=bsb.bill_sequence_id and bsb.assembly_item_id=msibk.inventory_item_id and bsb.organization_id=msibk.organization_id and bsb.organization_id=mp.organization_id)
&iby_pay_instr_entity_ref
when fad.entity_name='WIP_DISCRETE_JOBS' then (select mp.organization_code||': '||we.wip_entity_name from wip_entities we, wip_discrete_jobs wdj, mtl_parameters mp where fad.pk1_value=wdj.wip_entity_id and fad.pk2_value=wdj.organization_id and we.wip_entity_id=wdj.wip_entity_id and wdj.organization_id=mp.organization_id)
when fad.entity_name='WIP_DISCRETE_OPERATIONS' then (select mp.organization_code from mtl_parameters mp where fad.pk3_value=mp.organization_id)||': '||(select we.wip_entity_name from wip_entities we where fad.pk1_value=we.wip_entity_id)||': '||fad.pk2_value
when fad.entity_name='WSH_DELIVERY_DETAILS' then (select haouv.name||': '||wdd.source_header_number||': '||wdd.source_line_number from wsh_delivery_details wdd, hr_all_organization_units_vl haouv where fad.pk1_value=wdd.delivery_detail_id and wdd.org_id=haouv.organization_id(+))
when fad.entity_name='WSH_NEW_DELIVERIES' then (select mp.organization_code||': '||wnd.name from wsh_new_deliveries wnd, mtl_parameters mp where fad.pk1_value=wnd.delivery_id and wnd.organization_id=mp.organization_id)
when fad.entity_name='RA_CUSTOMER_TRX' then (select haouv.name||': '||rcta.trx_number from ra_customer_trx_all rcta, hr_all_organization_units_vl haouv where fad.pk1_value=rcta.customer_trx_id and rcta.org_id=haouv.organization_id(+))
when fad.entity_name='RA_CUSTOMER_TRX_LINES' then (select haouv.name||': '||rcta.trx_number||': '||rctla.line_number from ra_customer_trx_lines_all rctla, ra_customer_trx_all rcta, hr_all_organization_units_vl haouv where fad.pk1_value=rctla.customer_trx_line_id and rctla.customer_trx_id=rcta.customer_trx_id and rctla.org_id=haouv.organization_id)
when fad.entity_name='AR_CUSTOMERS' then (select hca.account_number||': '||hca.account_name from hz_cust_accounts hca where fad.pk1_value=hca.cust_account_id)
when fad.entity_name='QA_RESULTS' then (select mp.organization_code||': '||(select qp.name from qa_plans qp where fad.pk3_value=qp.plan_id)||': '||fad.pk2_value from qa_results qr, mtl_parameters mp where fad.pk3_value=qr.plan_id and fad.pk2_value=qr.collection_id and fad.pk1_value=qr.occurrence and qr.organization_id=mp.organization_id)
when fad.entity_name='PER_PEOPLE_F' then (select haouv.name||': '||ppx.full_name from per_people_x ppx, hr_all_organization_units_vl haouv where fad.pk1_value=ppx.person_id and ppx.business_group_id=haouv.organization_id and rownum=1)
when fad.entity_name='PA_PROJECTS' then (select haouv.name||': '||ppa.segment1 from pa_projects_all ppa, hr_all_organization_units_vl haouv where fad.pk1_value=ppa.project_id and ppa.org_id=haouv.organization_id)
when fad.entity_name='PER_ASSIGNMENTS_F' then (
select
haouv.name||': '||ppx.full_name||': '||paaf.assignment_number||': '||pjv.name
from
(select paaf.* from per_all_assignments_f paaf where sysdate between paaf.effective_start_date and paaf.effective_end_date) paaf,
per_people_x ppx,
per_jobs_vl pjv,
hr_all_organization_units_vl haouv
where
fad.pk1_value=paaf.assignment_id and
paaf.person_id=ppx.person_id and
paaf.job_id=pjv.job_id(+) and
paaf.business_group_id=haouv.organization_id and
rownum=1
)
when fad.entity_name='EAM_DISCRETE_OPERATIONS' then (select mp.organization_code||': '||we.wip_entity_name||': '||wdj.description||': '||fad.pk2_value from wip_entities we, wip_discrete_jobs wdj, mtl_parameters mp where fad.pk1_value=we.wip_entity_id and fad.pk1_value=wdj.wip_entity_id and fad.pk3_value=wdj.organization_id and fad.pk3_value=mp.organization_id)
when fad.entity_name='BOM_STANDARD_OPERATIONS' then (select mp.organization_code||': '||bso.operation_code||': '||bso.operation_description from bom_standard_operations bso, mtl_parameters mp where fad.pk1_value=bso.standard_operation_id and bso.organization_id=mp.organization_id)
when fad.entity_name='GL_JE_BATCHES' then (select gjb.name from gl_je_batches gjb where fad.pk1_value=gjb.je_batch_id)
when fad.entity_name='GL_JE_HEADERS' then (select gjh.name from gl_je_headers gjh where fad.pk2_value=gjh.je_header_id)
end,
trim('.' from fad.pk1_value||'.'||fad.pk2_value||'.'||fad.pk3_value||'.'||fad.pk4_value||'.'||fad.pk5_value)) reference,
fad.seq_num,
fdcv.user_name category,
&title_column
fdt.description,
fdd.user_name data_type,
decode(fd.datatype_id,5,&url_column,nvl(fl.file_name,fd.file_name)) name,
&url_text
fdn.short_name location,
decode(fd.datatype_id,1,to_clob(fdst.short_text),2,xxen_util.long_to_clob('FND_DOCUMENTS_LONG_TEXT','LONG_TEXT',fdlt.rowid)) text,
length(fl.file_data) file_size,
fl.file_content_type content_type,
lower(fl.file_format) file_format,
fl.expiration_date,
xxen_util.meaning(fd.usage_type,'ATCHMT_DOCUMENT_TYPE',0) usage,
decode(fd.security_type,1,'Organization',2,'Set of Books',3,'Business Unit',4,'None') security_type,
decode(fd.security_type,1,haouv.name,2,gl.name) security_owner,
decode(fd.publish_flag,'Y','Y') share_,
fd.start_date_active,
fd.end_date_active,
xxen_util.user_name(fd.created_by) created_by,
xxen_util.client_time(fd.creation_date) creation_date,
fl.program_name,
fd.request_id,
fcpv.user_concurrent_program_name concurrent_program,
xxen_util.client_time(fd.program_update_date) program_update_date,
fad.entity_name
from
fnd_documents fd,
fnd_documents_tl fdt,
fnd_document_datatypes fdd,
fnd_document_categories_vl fdcv,
hr_all_organization_units_vl haouv,
gl_ledgers gl,
fnd_lobs fl,
fnd_concurrent_programs_vl fcpv,
fnd_documents_short_text fdst,
fnd_documents_long_text fdlt,
(select fad.* from fnd_attached_documents fad where '&show_attachment_objects'='Y') fad,
fnd_document_entities_vl fdev,
fnd_dm_nodes fdn
where
1=1 and
fd.document_id=fdt.document_id and
fdt.language=userenv('lang') and
fd.datatype_id=fdd.datatype_id and
fdd.language=userenv('lang') and
fd.category_id=fdcv.category_id and
decode(fd.security_type,1,fd.security_id)=haouv.organization_id(+) and
decode(fd.security_type,2,fd.security_id)=gl.ledger_id(+) and
fd.media_id=fl.file_id(+) and
fd.program_application_id=fcpv.application_id(+) and
fd.program_id=fcpv.concurrent_program_id(+) and
decode(fd.datatype_id,1,fd.media_id)=fdst.media_id(+) and
decode(fd.datatype_id,2,fd.media_id)=fdlt.media_id(+) and
fd.document_id=fad.document_id(+) and
fad.entity_name=fdev.data_object_code(+) and
nvl(fd.dm_node,0)=fdn.node_id(+)
) x
where
2=2
order by
x.creation_date desc,
x.seq_num