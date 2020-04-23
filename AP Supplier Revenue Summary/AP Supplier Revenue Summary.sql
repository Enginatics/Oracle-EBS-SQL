/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Supplier Revenue Summary
-- Description: AP suppliers (po vendors) revenue summary across different operating units
-- Excel Examle Output: https://www.enginatics.com/example/ap-supplier-revenue-summary
-- Library Link: https://www.enginatics.com/reports/ap-supplier-revenue-summary
-- Run Report: https://demo.enginatics.com/


select distinct
&columns
asu.vendor_name supplier_name,
xxen_util.meaning(asu.vendor_type_lookup_code,'VENDOR TYPE',201) type,
asu.segment1 supplier_number,
asu.vat_registration_num tax_registration_number,
max(assa.vendor_site_code) keep (dense_rank last order by assa.vendor_site_id) over (partition by nvl(assa.location_id,assa.vendor_id) &partition_by) site_code,
max(assa.address_line1) keep (dense_rank last order by assa.vendor_site_id) over (partition by nvl(assa.location_id,assa.vendor_id) &partition_by) address_line1,
max(assa.address_line2) keep (dense_rank last order by assa.vendor_site_id) over (partition by nvl(assa.location_id,assa.vendor_id) &partition_by) address_line2,
max(assa.city) keep (dense_rank last order by assa.vendor_site_id) over (partition by nvl(assa.location_id,assa.vendor_id) &partition_by) city,
max(assa.zip) keep (dense_rank last order by assa.vendor_site_id) over (partition by nvl(assa.location_id,assa.vendor_id) &partition_by) zip,
max(ftv.territory_short_name) keep (dense_rank last order by assa.vendor_site_id) over (partition by nvl(assa.location_id,assa.vendor_id) &partition_by) country,
max(att.name) keep (dense_rank last order by assa.vendor_site_id) over (partition by nvl(assa.location_id,assa.vendor_id) &partition_by) payment_terms,
sum(case when aia.gl_date>=(select gps.start_date from gl_period_statuses gps where gps.application_id=101 and hou.set_of_books_id=gps.ledger_id and gps.period_year=to_char(sysdate,'YYYY') and gps.period_num=1) then aia.invoice_amount end) over (partition by nvl(assa.location_id,assa.vendor_id),aia.invoice_currency_code &partition_by) amount_ytd,
sum(case when aia.gl_date>=sysdate-365 then aia.invoice_amount end) over (partition by nvl(assa.location_id,assa.vendor_id),aia.invoice_currency_code &partition_by) amount_1_year,
sum(aia.invoice_amount) over (partition by nvl(assa.location_id,assa.vendor_id),aia.invoice_currency_code &partition_by) amount_total,
aia.invoice_currency_code currency
from
ap_suppliers asu,
ap_supplier_sites_all assa,
fnd_territories_vl ftv,
ap_terms_tl att,
ap_invoices_all aia,
hr_operating_units hou,
gl_ledgers gl
where
1=1 and
asu.vendor_id=assa.vendor_id and
assa.country=ftv.territory_code(+) and
assa.terms_id=att.term_id(+) and
att.language(+)=userenv('lang') and
assa.vendor_site_id=aia.vendor_site_id and
assa.org_id=hou.organization_id and
hou.set_of_books_id=gl.ledger_id