/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: JA India - TDS Certificates
-- Description: Imported from BI Publisher
Description: Form 16A report
Application: Asia/Pacific Localizations
Source: India - TDS Certificates (XML)
Short Name: JAINITCR_XML
DB package: JA_JAINITCR_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ja-india-tds-certificates/
-- Library Link: https://www.enginatics.com/reports/ja-india-tds-certificates/
-- Run Report: https://demo.enginatics.com/

select distinct
haouv.name,
decode(haouv.location_id,null,haouv.internal_address_line,loc.address_line_1 ||','|| loc.address_line_2 ||','|| loc.address_line_3 ||','||loc.town_or_city||','||loc.postal_code||','|| loc.country ) address,
jap.org_tan_num tan_no,
jrg.attribute_value pan_no,
aps0.vendor_name,
aps0.vendor_id tds_id,
afrm.tds_tax_section tds_section,
aps.vendor_name vendor_name2,
assa.address_line1 ||','|| assa.address_line2 ||','|| assa.address_line3 ||','|| assa.city||','||assa.zip||','||assa.state||','||assa.country site_address,
aps.vat_registration_num,
afrm.from_date,
afrm.to_date,
afrm.certificate_num certificate_id,
upper(afrm.print_flag) print_flag1,
afrm.org_id  org_id,
aps.vendor_id  ven_id,
ja_jainitcr_xmlp_pkg.cf_ven_pan_noformula(aps.vendor_id) vendor_pan_no,
ja_jainitcr_xmlp_pkg.cf_3formula(frmd.tds_invoice_amt) total_tax,
api2.invoice_date,
frmd.tds_invoice_amt,
frmd.tds_tax_rate,
apip.accounting_date,
frmd.invoice_payment_id,
api1.invoice_id,
apc.bank_account_name ,
jatp.check_number chq ,
jatp.check_deposit_date "Check_Deposit_Date",
jatp.bank_name "Check_Deposit_Bank",
jatp.challan_no "Check_Challan_No",
apc.bank_account_id,
frmd.invoice_amount invoice_amt,
frmd.tds_invoice_id, 
ja_jainitcr_xmlp_pkg.bank_branchformula(jatp.challan_no, frmd.tds_invoice_id, aps0.vendor_id) bank_branch_name, 
ja_jainitcr_xmlp_pkg.cf_check_dep_dateformula(jatp.check_number) cf_check_dep_date, 
ja_jainitcr_xmlp_pkg.cf_tds_amtformula(frmd.tds_invoice_id, frmd.tds_invoice_amt) cf_tds_amt, 
ja_jainitcr_xmlp_pkg.cf_bsr_codeformula(apc.bank_account_id) bank_branch_code,
ja_jainitcr_xmlp_pkg.cp_cess_amt_p cp_cess_amt,
ja_jainitcr_xmlp_pkg.cp_surcharge_amt_p cp_surcharge_amt,
ja_jainitcr_xmlp_pkg.cp_sh_cess_amt_p cp_sh_cess_amt
from
hr_all_organization_units_vl haouv,
hr_locations loc,
ap_suppliers aps,
ap_supplier_sites_all assa,
jai_ap_tds_f16_hdrs_all afrm,
ap_suppliers aps0,
jai_ap_tds_org_tan_v jap,
jai_rgm_org_regns_v  jrg,
jai_ap_tds_cert_nums jatcn,
(
select invoice_id,
certificate_num,
fin_yr,
tax_authority_id,
line_num,
org_id,
max(org_tan_num)  org_tan_num,
max(tds_invoice_id)   tds_invoice_id,
max(tds_inv_date) tds_inv_date,
max(tds_tax_rate) tds_tax_rate,
max(invoice_payment_id) invoice_payment_id,
sum(taxable_basis)    invoice_amount,
sum(tds_invoice_amt)   tds_invoice_amt
from jai_ap_tds_f16_dtls_v frmd
group by tax_authority_id, fin_yr, certificate_num, line_num, invoice_id,org_id
) frmd,
ap_invoices_all api1,
ap_invoices_all api2,
ap_invoice_payments_all apip,
ap_checks_all apc,
jai_ap_tds_payments jatp
where
2=2 and
haouv.organization_id(+)=afrm.org_id and
haouv.location_id=loc.location_id(+) and
jap.organization_id=afrm.org_id and
jrg.organization_id=afrm.org_id and
jatcn.organization_id=afrm.org_id and
jrg.regime_code='TDS' and
jrg.registration_type='OTHERS' and
jrg.attribute_type_code='OTHERS' and
jrg.attribute_code='PAN NO' and
aps.vendor_id=afrm.vendor_id and
aps0.vendor_id=afrm.tax_authority_id and
assa.vendor_site_id=afrm.vendor_site_id AND
api1.invoice_id=frmd.invoice_id and
apip.invoice_payment_id = frmd.invoice_payment_id and
api2.invoice_id=frmd.tds_invoice_id and
apc.check_id(+)=apip.check_id and
apc.check_id =jatp.check_id  and
frmd.tds_inv_date=api2.invoice_date and
frmd.fin_yr=afrm.fin_yr and
frmd.org_tan_num=afrm.org_tan_num and
frmd.tds_invoice_amt>0 and
frmd.certificate_num=afrm.certificate_num
order by 
afrm.certificate_num,
api2.invoice_date,
api1.invoice_id,
frmd.invoice_amount,
apc.bank_account_name ,
frmd.tds_invoice_amt,
apc.bank_account_id,
frmd.tds_invoice_id, 
jatp.check_number