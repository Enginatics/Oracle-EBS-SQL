/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Invoice Audit Listing(GST)
-- Description: Imported Oracle standard 'Invoice Audit Listing' report
Application: Payables
Source: Invoice Audit Listing
Short Name: APXINLST
-- Excel Examle Output: https://www.enginatics.com/example/ap-invoice-audit-listing-gst/
-- Library Link: https://www.enginatics.com/reports/ap-invoice-audit-listing-gst/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
aia.invoice_num invoice_number,
aia.invoice_date,
aia.invoice_currency_code currency_code,
aia.invoice_amount,
aia.description,
xxen_util.meaning(aia.invoice_type_lookup_code,'INVOICE TYPE',200) invoice_type,
nvl(aps.vendor_name,hp.party_name) vendor_name,
nvl(aps.segment1,hp.party_number) vendor_number,
nvl(to_char(aia.doc_sequence_value),aia.voucher_num) voucher_number,
&il_reg_columns
&il_columns_amt
&il_columns_rate
&il_columns_rec
&il_columns_tp
from
hr_all_organization_units_vl haouv,
ap_invoices_all aia,
ap_suppliers aps,
hz_parties hp
&il_from
where
1=1 and
haouv.organization_id=aia.org_id and
aia.vendor_id=aps.vendor_id(+) and
aia.party_id=hp.party_id
&il_where
order by
aia.invoice_date,
aia.invoice_currency_code,
aia.invoice_amount,
upper(aps.vendor_name),
upper(aia.invoice_num)