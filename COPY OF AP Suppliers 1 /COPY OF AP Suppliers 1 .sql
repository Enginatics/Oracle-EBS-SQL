/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: COPY OF: AP Suppliers (1)
-- Description: AP suppliers (po vendors) including supplier sites and contact information
-- Excel Examle Output: https://www.enginatics.com/example/copy-of-ap-suppliers-1/
-- Library Link: https://www.enginatics.com/reports/copy-of-ap-suppliers-1/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
asu.vendor_name supplier,
asu.segment1 supplier_number,
xxen_util.meaning(asu.vendor_type_lookup_code,'VENDOR TYPE',201) type,
asu.type_1099 income_tax_type,
decode(asu.organization_type_lookup_code,'INDIVIDUAL',asu.individual_1099,asu.num_1099) taxpayer_id,
asu.vat_registration_num tax_registration_number,
asu0.vendor_name parent_supplier_name,
asu0.segment1 parent_supplier_number,
asu.customer_num,
asu.vat_code,
decode(asu.small_business_flag,'Y','Y') small_business_flag,
decode(asu.hold_flag,'Y','Y') hold_flag,
asu.purchasing_hold_reason,
asu.min_order_amount,
asu.price_tolerance,
assa.vendor_site_code site_code,
assa.address_line1,
assa.address_line2,
assa.address_line3,
assa.address_line4,
assa.city,
assa.state,
assa.zip,
assa.county,
assa.province,
nvl(ftv.territory_short_name,assa.country) country,
assa.area_code,
assa.phone,
assa.fax_area_code,
assa.fax,
assa.supplier_notif_method,
assa.email_address,
nvl(assa.terms_date_basis,asu.terms_date_basis) terms_date_basis,
nvl(assa.pay_group_lookup_code,asu.pay_group_lookup_code) pay_group,
nvl(att1.name,att0.name) payment_terms,
xxen_util.meaning(nvl(assa.pay_date_basis_lookup_code,asu.pay_date_basis_lookup_code),'PAY DATE BASIS',201) pay_date_basis
&contacts_columns
from
hr_all_organization_units_vl haouv,
ap_suppliers asu,
ap_supplier_sites_all assa,
fnd_territories_vl ftv,
(select pvc.* from po_vendor_contacts pvc where '&show_contacts'='Y' and nvl(pvc.inactive_date,sysdate)>=sysdate) pvc,
ap_suppliers asu0,
ap_terms_tl att0,
ap_terms_tl att1
where
1=1 and
asu.vendor_id=assa.vendor_id(+) and
assa.org_id=haouv.organization_id(+) and
assa.country=ftv.territory_code(+) and
assa.vendor_site_id=pvc.vendor_site_id(+) and
asu.parent_vendor_id=asu0.vendor_id(+) and
asu.terms_id=att0.term_id(+) and
assa.terms_id=att1.term_id(+) and
att0.language(+)=userenv('lang') and
att1.language(+)=userenv('lang')