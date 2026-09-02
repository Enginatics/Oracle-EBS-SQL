/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoice Hold Upload
-- Description: Releases and places AP invoice holds in bulk - the Excel equivalent of the Invoice Workbench Holds tab.

Download the open holds with the download parameters, pick a Release Name (and optionally overwrite the defaulted Release Reason) on the rows to release, and upload. Each hold row is released through the same Oracle logic as the form, including the invoice holds workflow abort, the hold business event and the E-Business Tax synchronization. To place a new manual hold, add a row with the invoice reference and a Hold Name, leaving the Release Name blank.

Holds are identified by Operating Unit, Invoice Number, Supplier and Hold Name, so rows can also be pasted from an external list instead of downloaded. When an invoice has several open holds of the same name (for example matching holds on different purchase order shipments), the PO Number, PO Line, PO Shipment or Invoice Line columns identify the exact hold.

By default only user releasable holds are downloaded - system holds such as Line Variance or Distribution Variance cannot be released manually and are removed by correcting the invoice and revalidating. Set User Releasable Only to No to review them.

Releasing all holds of an invoice does not submit Invoice Validation - the invoice status is derived by Oracle and updates automatically, exactly as after releasing holds in the form.
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoice-hold-upload/
-- Library Link: https://www.enginatics.com/reports/ap-invoice-hold-upload/
-- Run Report: https://demo.enginatics.com/

select
to_char(null) action_,
to_char(null) status_,
to_char(null) message_,
null modified_columns_,
haouv.name operating_unit,
aps.vendor_name supplier,
aps.segment1 supplier_number,
assa.vendor_site_code supplier_site,
aia.invoice_num invoice_number,
aia.invoice_date,
aia.invoice_amount,
aia.invoice_currency_code currency,
alc.displayed_field hold_name,
aha.hold_reason,
aha.hold_date,
decode(aha.held_by,5,(select alc_sys.displayed_field from ap_lookup_codes alc_sys where alc_sys.lookup_type='NLS TRANSLATION' and alc_sys.lookup_code='SYSTEM'),xxen_util.user_name(aha.held_by)) held_by,
pha.segment1 po_number,
pola.line_num po_line,
plla.shipment_num po_shipment,
aha.line_number invoice_line,
aha.hold_details,
null release_name,
null release_reason,
aha.hold_id,
null upload_row
from
ap_holds_all aha,
ap_invoices_all aia,
ap_suppliers aps,
ap_supplier_sites_all assa,
hr_all_organization_units_vl haouv,
ap_hold_codes ahc,
ap_lookup_codes alc,
po_line_locations_all plla,
po_lines_all pola,
po_headers_all pha
where
1=1 and
aha.release_lookup_code is null and
aha.invoice_id=aia.invoice_id and
aia.org_id=haouv.organization_id and
aia.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
aia.vendor_id=aps.vendor_id(+) and
aia.vendor_site_id=assa.vendor_site_id(+) and
aha.hold_lookup_code=ahc.hold_lookup_code and
alc.lookup_type='HOLD CODE' and
alc.lookup_code=aha.hold_lookup_code and
aha.line_location_id=plla.line_location_id(+) and
plla.po_line_id=pola.po_line_id(+) and
plla.po_header_id=pha.po_header_id(+)