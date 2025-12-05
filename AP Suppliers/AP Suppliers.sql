/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Suppliers
-- Description: AP suppliers (po vendors) including supplier sites, contact and bank account information on vendor and site level
-- Excel Examle Output: https://www.enginatics.com/example/ap-suppliers/
-- Library Link: https://www.enginatics.com/reports/ap-suppliers/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
aps.vendor_name supplier,
aps.segment1 supplier_number,
aps.vendor_name_alt alternate_supplier,
hp.known_as  trading_partner,
&dff_columns
xxen_util.meaning(aps.vendor_type_lookup_code,'VENDOR TYPE',201) type,
aps.type_1099 income_tax_type,
decode(aps.organization_type_lookup_code,'INDIVIDUAL',aps.individual_1099,aps.num_1099) taxpayer_id,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp0.country_code) dflt_rep_country_name,
zptp0.rep_registration_number dflt_rep_registrn_number,
zptp0.registration_type_code dflt_rep_registrn_type,
aps.vat_registration_num tax_registration_number,
aps.tax_reporting_name,
xxen_util.yes(aps.federal_reportable_flag) federal_reportable,
xxen_util.yes(aps.state_reportable_flag) state_reportable,
xxen_util.yes(aps.allow_awt_flag) allow_withholding_tax,
(select aag.name from ap_awt_groups aag where aps.awt_group_id=aag.group_id) inv_withholding_tax_group,
(select aag.name from ap_awt_groups aag where aps.pay_awt_group_id=aag.group_id) pay_withholding_tax_group,
aps0.vendor_name parent_supplier_name,
aps0.segment1 parent_supplier_number,
aps.customer_num,
aps.vat_code,
xxen_util.yes(aps.small_business_flag) small_business,
xxen_util.yes(aps.hold_flag) hold_flag,
aps.purchasing_hold_reason,
aps.end_date_active supplier_inactive_date,
aps.min_order_amount,
aps.price_tolerance,
assa.vendor_site_code site_code,
hps.party_site_name address_name,
assa.vendor_site_code_alt alternate_site_name,
xxen_util.yes(assa.primary_pay_site_flag) primary_pay_site,
xxen_util.yes(assa.purchasing_site_flag) purchasing_site,
xxen_util.yes(assa.rfq_only_site_flag) rfq_only,
xxen_util.yes(assa.pay_site_flag) pay_site,
xxen_util.yes(assa.pcard_site_flag) procurement_card,
xxen_util.yes(assa.hold_unmatched_invoices_flag) matching_required,
xxen_util.yes(assa.hold_future_payments_flag) hold_future_payments,
xxen_util.yes(assa.hold_all_payments_flag) hold_all_payments,
assa.inactive_date site_inactive_date,
assa.freight_terms_lookup_code freight_terms,
assa.fob_lookup_code free_on_board_code,
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
nvl(assa.terms_date_basis,aps.terms_date_basis) terms_date_basis,
nvl(assa.pay_group_lookup_code,aps.pay_group_lookup_code) pay_group,
xxen_util.meaning(nvl(assa.pay_date_basis_lookup_code,aps.pay_date_basis_lookup_code),'PAY DATE BASIS',201) pay_date_basis,
atv0.name payment_terms,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp1.country_code) site_dflt_rep_country_name,
zptp1.rep_registration_number site_dflt_rep_registrn_number,
zptp1.registration_type_code site_dflt_rep_registrn_type,
xxen_util.meaning(assa.auto_tax_calc_override,'YES_NO',0) auto_tax_calculation_override,
xxen_util.meaning(assa.auto_tax_calc_flag,'YES_NO',0) auto_tax_calculation,
xxen_util.meaning(assa.allow_awt_flag,'YES_NO',0) site_allow_withholding_tax,
(select aag.name from ap_awt_groups aag where aag.group_id = assa.awt_group_id) site_inv_withholding_tax_group,
(select aag.name from ap_awt_groups aag where aag.group_id = assa.pay_awt_group_id) site_pay_withholding_tax_group,
(select distinct listagg(xxen_util.meaning(ieppm.payment_method_code,'PAYMENT METHOD',200,'Y'),', ') within group (order by ieppm.primary_flag desc, ieppm.payment_method_code) over () payment_method from iby_ext_party_pmt_mthds ieppm where iepa0.ext_payee_id=ieppm.ext_pmt_party_id) payment_method,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where assa.accts_pay_code_combination_id=gcck.code_combination_id) liability_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where assa.prepay_code_combination_id=gcck.code_combination_id) prepayment_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where assa.future_dated_payment_ccid=gcck.code_combination_id) bills_payable_account,
&supplier_bank_account
atv1.name site_payment_terms,
(select distinct listagg(xxen_util.meaning(ieppm.payment_method_code,'PAYMENT METHOD',200,'Y'),', ') within group (order by ieppm.primary_flag desc, ieppm.payment_method_code) over () payment_method from iby_ext_party_pmt_mthds ieppm where iepa1.ext_payee_id=ieppm.ext_pmt_party_id) site_payment_method,
&site_bank_account
&contacts_columns
xxen_util.client_time(aps.creation_date) supplier_creation_date,
xxen_util.user_name(aps.created_by) supplier_created_by,
xxen_util.client_time(aps.last_update_date) supplier_last_update_date,
xxen_util.user_name(aps.last_updated_by) supplier_last_updated_by,
xxen_util.client_time(assa.creation_date) site_creation_date,
xxen_util.user_name(assa.created_by) site_created_by,
xxen_util.client_time(assa.last_update_date) site_last_update_date,
xxen_util.user_name(assa.last_updated_by) site_last_updated_by,
aps.vendor_id,
assa.vendor_site_id
from
hr_all_organization_units_vl haouv,
ap_suppliers aps,
(select assa.* from ap_supplier_sites_all assa where 2=2) assa,
fnd_territories_vl ftv,
(select pvc.* from po_vendor_contacts pvc where '&show_contacts'='Y' and 3=3) pvc,
ap_suppliers aps0,
ap_terms_vl atv0,
ap_terms_vl atv1,
(select iepa.* from iby_external_payees_all iepa where '&show_bank_accounts'='Y' and iepa.payment_function='PAYABLES_DISB' and iepa.party_site_id is null and iepa.supplier_site_id is null and iepa.org_id is null) iepa0,
(select iepa.* from iby_external_payees_all iepa where '&show_bank_accounts'='Y' and iepa.payment_function='PAYABLES_DISB' and iepa.party_site_id is not null) iepa1,
(select ipiua.* from iby_pmt_instr_uses_all ipiua where 4=4 and ipiua.payment_function='PAYABLES_DISB') ipiua0,
(select ipiua.* from iby_pmt_instr_uses_all ipiua where 4=4 and ipiua.payment_function='PAYABLES_DISB') ipiua1,
iby_ext_bank_accounts ieba0,
iby_ext_bank_accounts ieba1,
ce_bank_branches_v cbbv0,
ce_bank_branches_v cbbv1,
hz_parties hp,
hz_party_sites hps,
zx_party_tax_profile zptp0,
zx_party_tax_profile zptp1
where
1=1 and
aps.vendor_id=assa.vendor_id(+) and
assa.org_id=haouv.organization_id(+) and
assa.country=ftv.territory_code(+) and
assa.vendor_site_id=pvc.vendor_site_id(+) and
aps.parent_vendor_id=aps0.vendor_id(+) and
aps.terms_id=atv0.term_id(+) and
assa.terms_id=atv1.term_id(+) and
aps.party_id=iepa0.payee_party_id(+) and
assa.party_site_id=iepa1.party_site_id(+) and
assa.org_id=iepa1.org_id(+) and
assa.vendor_site_id=iepa1.supplier_site_id(+) and 
iepa0.ext_payee_id=ipiua0.ext_pmt_party_id(+) and
iepa1.ext_payee_id=ipiua1.ext_pmt_party_id(+) and
decode(ipiua0.instrument_type,'BANKACCOUNT',ipiua0.instrument_id)=ieba0.ext_bank_account_id(+) and
decode(ipiua1.instrument_type,'BANKACCOUNT',ipiua1.instrument_id)=ieba1.ext_bank_account_id(+) and
ieba0.branch_id=cbbv0.branch_party_id(+) and
ieba1.branch_id=cbbv1.branch_party_id(+) and 
aps.party_id=hp.party_id(+) and
assa.party_site_id=hps.party_site_id(+) and
aps.party_id = zptp0.party_id (+) and
'THIRD_PARTY' = zptp0.party_type_code (+) and
assa.party_site_id = zptp1.party_id (+) and
'THIRD_PARTY_SITE' = zptp1.party_type_code (+)
order by
haouv.name,
aps.vendor_name,
assa.vendor_site_code