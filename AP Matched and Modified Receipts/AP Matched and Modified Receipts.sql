/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Matched and Modified Receipts
-- Description: Imported from BI Publisher
Description: Matched and Modified Receipts Report
Application: Payables
Source: Matched and Modified Receipts Report (XML) - Not Supported: Reserved For Future Use
Short Name: APXMTMRR_XML
DB package: AP_APXMTMRR_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ap-matched-and-modified-receipts/
-- Library Link: https://www.enginatics.com/reports/ap-matched-and-modified-receipts/
-- Run Report: https://demo.enginatics.com/

select
 rsh.receipt_num receipt_number,
 trunc(rsh.creation_date) receipt_creation_date,
 trunc(rsh.last_update_date) receipt_last_modified,
 pv.vendor_name supplier,
 pvs.vendor_site_code supplier_site,
 rsl.line_num receipt_line_num,
 rsl.quantity_received received_qty,
 rct1.primary_quantity adjustment_qty,
 trunc(rct1.creation_date) adjustment_date,
 po.segment1 po_number,
 ai.invoice_num invoice_number,
 alc.displayed_field invoice_status,
 ail.line_number invoice_line_number,
 ail.quantity_invoiced billed_qty,
 trunc(ail.creation_date) invoice_line_creation_date,
 haouv.name operating_unit,
 rct1.transaction_id adjutment_transaction_id
from
 ap_invoices_all ai,
 ap_invoice_lines_all ail,
 po_vendors pv,
 po_vendor_sites_all pvs,
 po_headers_all po,
 rcv_shipment_headers rsh,
 rcv_shipment_lines rsl,
 rcv_transactions rct,
 rcv_transactions rct1,
 ap_lookup_codes alc,
 hr_all_organization_units_vl haouv
where
 1=1 and
 ai.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11) and
 ai.invoice_id=ail.invoice_id and
 rct.transaction_id = ail.rcv_transaction_id and
 pv.vendor_id = ai.vendor_id and
 pvs.vendor_site_id = ai.vendor_site_id and
 po.po_header_id = rsl.po_header_id and
 rsl.shipment_line_id = rct.shipment_line_id and
 rct.shipment_header_id = rsh.shipment_header_id and
 rct1.shipment_header_id = rct.shipment_header_id and
 rct1.shipment_line_id = rct.shipment_line_id and
 rct1.transaction_type in ('CORRECT','RETURN TO VENDOR','REJECT','RETURN TO RECEIVING','ACCEPT') and
 rct1.creation_date > ail.creation_date and
 alc.lookup_type(+) ='NLS TRANSLATION' and
 alc.lookup_code = nvl(:p_approval_status,ap_invoices_pkg.get_approval_status(ai.invoice_id,ai.invoice_amount,ai.payment_status_flag,ai.invoice_type_lookup_code)) and
 ai.org_id = haouv.organization_id and
 (:p_approval_status is null or
  (upper(:p_approval_status)  = 'PAID' and ai.payment_status_flag in ('Y','P')) or
  (upper(:p_approval_status) != 'PAID' and ap_invoices_pkg.get_approval_status(ai.invoice_id,ai.invoice_amount,ai.payment_status_flag,ai.invoice_type_lookup_code) = :p_approval_status)
 )
order by
 pv.vendor_name,
 pvs.vendor_site_code,
 rsh.receipt_num,
 rsl.line_num,
 rct1.transaction_id,
 ai.invoice_num,
 ail.line_number