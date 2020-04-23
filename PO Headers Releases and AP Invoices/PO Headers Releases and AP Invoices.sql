/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PO Headers, Releases and AP Invoices
-- Description: PO headers or releases with corresponding invoices and their payment status.
Example: To show all POs or Releases which have an invoice but no receiving TRX yet, set following parameters:
Invoice exists=Yes
Receiving TRX exists=No
-- Excel Examle Output: https://www.enginatics.com/example/po-headers-releases-and-ap-invoices
-- Library Link: https://www.enginatics.com/reports/po-headers-releases-and-ap-invoices
-- Run Report: https://demo.enginatics.com/


select
haou.name ou,
nvl2(pha.release_num,'RELEASE','PO') type,
pha.segment1 po_number,
pha.release_num,
aia.invoice_num,
xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200) invoice_type,
aia.invoice_date,
aia.invoice_amount,
aia.amount_paid,
decode(aia.payment_status_flag,'Y',fnd_message_cache.get_string ('POS','POS_PAID'),'N',fnd_message_cache.get_string ('POS','POS_NOT_PAID'),'P',fnd_message_cache.get_string('POS','POS_PARTIALLY_PAID')) payment_status,
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
asu.vendor_name,
asu.type_1099,
pvsa.vendor_site_code,
pvsa.address_line1,
pvsa.address_line2,
pvsa.address_line3,
pvsa.city,
pvsa.state,
pvsa.zip,
pvsa.country,
decode (pvsa.phone,null, null,'(' || pvsa.area_code || ') ' || pvsa.phone ) phone,
decode (pvsa.fax,null, null,'(' || pvsa.fax_area_code || ') ' || pvsa.fax) fax,
decode (pvc.last_name,null, null,pvc.last_name || ', ' || pvc.first_name) vendor_contact,
at.name term_name,
hlat1.location_code,
hlat2.location_code,
pha.comments,
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
hr_all_organization_units haou,
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
ap_suppliers asu,
po_vendor_sites_all pvsa,
po_vendor_contacts pvc,
ap_terms at,
hr_locations_all_tl hlat1,
hr_locations_all_tl hlat2,
(select x.* from (select max(aila.line_number) over (partition by aila.invoice_id, aila.po_header_id, aila.po_release_id) max_line_number, aila.* from ap_invoice_lines_all aila where nvl(aila.discarded_flag,'N')='N') x where x.line_number=x.max_line_number) aila,
ap_invoices_all aia
where
1=1 and
haou.organization_id=pha.org_id and
pha.type_lookup_code in ('PLANNED','CONTRACT','BLANKET','STANDARD') and
pha.vendor_id=asu.vendor_id(+) and
pha.vendor_site_id=pvsa.vendor_site_id(+) and
pha.vendor_contact_id=pvc.vendor_contact_id(+) and
pha.terms_id=at.term_id(+) and
pha.ship_to_location_id=hlat1.location_id(+) and
pha.bill_to_location_id=hlat2.location_id(+) and
hlat1.language(+)=userenv('lang') and
hlat2.language(+)=userenv('lang') and
(pha.vendor_contact_id is null or pha.vendor_site_id=pvc.vendor_site_id) and
pha.po_header_id=aila.po_header_id(+) and
nvl(pha.po_release_id,-99)=nvl(aila.po_release_id(+),-99) and
aila.invoice_id=aia.invoice_id(+)
order by
pha.creation_date desc