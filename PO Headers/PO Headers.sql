/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Headers
-- Description: PO headers or releases with corresponding invoices and their payment status.
Example: To show all POs or releases which have an invoice but no receiving TRX yet, set following parameters:
Invoice exists=Yes
Receiving TRX exists=No
-- Excel Examle Output: https://www.enginatics.com/example/po-headers/
-- Library Link: https://www.enginatics.com/reports/po-headers/
-- Run Report: https://demo.enginatics.com/

select distinct
haouv.name operating_unit,
pha.segment1 po_number,
pha.revision_num revision,
pha.release_num release,
pdtav.type_name type,
aps.vendor_name supplier_name,
ppx.full_name buyer,
po_headers_sv3.get_po_status(pha.po_header_id) status,
pha.comments description,
&invoice_columns
xxen_util.client_time(pha.creation_date) po_creation_date,
xxen_util.user_name(pha.created_by) created_by,
xxen_util.client_time(pha.approved_date_) approved_date,
xxen_util.meaning(nvl(pha.authorization_status_,'INCOMPLETE'),'AUTHORIZATION STATUS',201) authorization_status,
pha.amount_limit,
pha.blanket_total_amount,
pha.currency_code,
nvl(pha.closed_code_,'OPEN') closed_code,
xxen_util.client_time(pha.closed_date) closed_date,
(select sum(rt.quantity) from rcv_transactions rt where pha.po_header_id=rt.po_header_id and nvl(pha.po_release_id,-99)=nvl(rt.po_release_id,-99)) quantity_received,
aps.type_1099,
assa.vendor_site_code,
assa.address_line1,
assa.address_line2,
assa.address_line3,
assa.city,
assa.state,
assa.zip,
assa.country,
decode(assa.phone,null,null,'('||assa.area_code||') '||assa.phone) phone,
decode(assa.fax,null,null,'('||assa.fax_area_code||') '||assa.fax) fax,
decode(pvc.last_name,null,null,pvc.last_name||', '||pvc.first_name) vendor_contact,
at.name term_name,
hlav1.location_code,
hlav2.location_code,
pha.note_to_authorizer,
pha.note_to_receiver,
pha.note_to_vendor_,
pha.print_count,
xxen_util.client_time(pha.printed_date) printed_date,
pha.quote_vendor_quote_number,
pha.end_date,
pha.end_date_active,
pha.start_date,
pha.start_date_active,
pha.po_header_id
from
hr_all_organization_units_vl haouv,
(
select
pha.*,
nvl(pra.approved_date,pha.approved_date) approved_date_,
nvl(pra.authorization_status,pha.authorization_status) authorization_status_,
nvl(pra.note_to_vendor,pha.note_to_vendor) note_to_vendor_,
nvl(pra.closed_code,pha.closed_code) closed_code_,
pra.release_num,
pra.po_release_id
from
po_headers_all pha,
po_releases_all pra
where
pha.po_header_id=pra.po_header_id(+)
) pha,
per_people_x ppx,
ap_suppliers aps,
ap_supplier_sites_all assa,
po_vendor_contacts pvc,
po_document_types_all_vl pdtav,
ap_terms at,
hr_locations_all_vl hlav1,
hr_locations_all_vl hlav2,
(select distinct aila.invoice_id, aila.po_header_id, aila.po_release_id from ap_invoice_lines_all aila) aila,
ap_invoices_all aia
where
1=1 and
haouv.organization_id=pha.org_id and
pha.type_lookup_code in ('PLANNED','CONTRACT','BLANKET','STANDARD') and
pha.agent_id=ppx.person_id(+) and
pha.vendor_id=aps.vendor_id(+) and
pha.vendor_site_id=assa.vendor_site_id(+) and
pha.vendor_contact_id=pvc.vendor_contact_id(+) and
pdtav.document_type_code(+) in ('PO','PA') and
pha.type_lookup_code=pdtav.document_subtype(+) and
pha.org_id=pdtav.org_id(+) and
pha.terms_id=at.term_id(+) and
pha.ship_to_location_id=hlav1.location_id(+) and
pha.bill_to_location_id=hlav2.location_id(+) and
(pha.vendor_contact_id is null or pha.vendor_site_id=pvc.vendor_site_id) and
pha.po_header_id=aila.po_header_id(+) and
nvl(pha.po_release_id,-99)=nvl(aila.po_release_id(+),-99) and
aila.invoice_id=aia.invoice_id(+)
order by
po_creation_date desc,
pha.release_num desc