/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Suppliers
-- Description: AP suppliers (po vendors) including supplier sites, contact and bank account information on vendor and site level
-- When India Localization is installed, the following GST columns are also included: GST Registration No, GST PAN No, GST TAN No.
-- Duplicate Match restricts the output to suppliers sharing a match key with at least one other supplier and lists the shared keys. Names are compared in upper case without punctuation, spaces and legal form suffixes (Inc, Ltd, GmbH, SA and similar), the other keys without punctuation and spaces. Bank accounts are shown masked.
-- Spend Last 12 Months is the total of the supplier's invoices dated in the last twelve months, excluding cancelled invoices, in each operating unit's functional currency.
-- Excel Example Output: https://www.enginatics.com/example/ap-suppliers/
-- Library Link: https://www.enginatics.com/reports/ap-suppliers/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
aps.vendor_name supplier,
aps.segment1 supplier_number,
&dup_columns
aps.vendor_name_alt alternate_supplier,
hp.known_as  trading_partner,
&dff_columns
xxen_util.meaning(aps.vendor_type_lookup_code,'VENDOR TYPE',201) type,
aps.type_1099 income_tax_type,
decode(aps.organization_type_lookup_code,'INDIVIDUAL',aps.individual_1099,aps.num_1099) taxpayer_id,
(select papf.employee_number from per_all_people_f papf where papf.person_id=aps.employee_id and rownum<=1) employee_number,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp0.country_code) dflt_rep_country_name,
zptp0.rep_registration_number dflt_rep_registrn_number,
zptp0.registration_type_code dflt_rep_registrn_type,
xxen_util.meaning(zptp0.allow_offset_tax_flag,'YES_NO',0) allow_offset_tax,
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
xxen_util.meaning(case when nvl(aps.end_date_active,trunc(sysdate)+1)>trunc(sysdate) then 'A' else 'I' end,'REGISTRY_STATUS',222) supplier_status,
aps.end_date_active supplier_inactive_date,
aps.min_order_amount,
aps.price_tolerance,
assa.vendor_site_code site_code,
(select trunc(max(aia.invoice_date)) from ap_invoices_all aia where aia.vendor_site_id=assa.vendor_site_id) last_invoice_date,
hps.party_site_name address_name,
assa.vendor_site_code_alt alternate_site_name,
xxen_util.yes(assa.primary_pay_site_flag) primary_pay_site,
xxen_util.yes(assa.purchasing_site_flag) purchasing_site,
xxen_util.yes(assa.rfq_only_site_flag) rfq_only,
xxen_util.yes(assa.pay_site_flag) pay_site,
xxen_util.yes(assa.pcard_site_flag) procurement_card,
xxen_util.yes(assa.hold_unmatched_invoices_flag) matching_required,
xxen_util.meaning(assa.pay_on_code,'PAY ON CODE',201) pay_on,
xxen_util.meaning(assa.pay_on_receipt_summary_code,'ERS INVOICE_SUMMARY',201) invoice_summary_level,
xxen_util.yes(assa.create_debit_memo_flag) create_debit_memo_from_rts,
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
xxen_util.meaning(zptp1.allow_offset_tax_flag,'YES_NO',0) site_allow_offset_tax,
(select zicv.meaning from zx_input_classifications_v zicv where zicv.lookup_code=zptp1.tax_classification_code and zicv.org_id in (assa.org_id,-99) and rownum<=1) site_tax_classification,
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
&contact_responsibility_columns
&il_reg_columns
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
(
select
pvc.vendor_contact_id,
pvc.vendor_site_id,
pvc.vendor_id,
pvc.per_party_id,
pvc.prefix,
pvc.first_name,
pvc.middle_name,
pvc.last_name,
pvc.title,
pvc.area_code,
pvc.phone,
pvc.email_address,
pvc.inactive_date
from
po_vendor_contacts pvc
where '&show_contacts'='Y' and 3=3
union all
select
pvc.*
from
(
select
to_number(null) vendor_contact_id,
to_number(null) vendor_site_id,
aps.vendor_id,
hzr.subject_id per_party_id,
nvl(hp.person_pre_name_adjunct,hp.salutation) prefix,
substr(hp.person_first_name,1,15) first_name,
substr(hp.person_middle_name,1,15) middle_name,
substr(hp.person_last_name,1,15) last_name,
substr(hp.person_title,1,30) title,
hp2.primary_phone_area_code area_code,
hp2.primary_phone_number phone,
hp2.email_address,
hzr.end_date inactive_date
from
ap_suppliers aps,
hz_relationships hzr,
hz_parties hp,
hz_parties hp2
where
aps.party_id=hzr.object_id and
hzr.object_type='ORGANIZATION' and
hzr.subject_type='PERSON' and
hzr.relationship_type='CONTACT' and
hzr.relationship_code='CONTACT_OF' and
hzr.directional_flag='F' and
hzr.status in ('A','I') and
hzr.subject_id=hp.party_id and
hzr.party_id=hp2.party_id and
hzr.subject_id in (select hpua.party_id from hz_party_usg_assignments hpua where hpua.party_usage_code='SUPPLIER_CONTACT' and hpua.status_flag in ('A','I')) and
not exists (select null from ap_supplier_contacts asco where hzr.relationship_id=asco.relationship_id and (asco.org_party_site_id is not null or asco.vendor_site_id is null))
) pvc
where '&show_contacts'='Y' and 3=3
) pvc,
(
select
fu.person_party_id,
listagg(fu.user_name,chr(10)) within group (order by fu.user_name) contact_user_name,
case when count(*)=count(fu.end_date) then max(fu.end_date) end contact_user_inactive_date
from
fnd_user fu
where
'&show_contact_responsibilities'='Y' and
fu.person_party_id in (select asco.per_party_id from ap_supplier_contacts asco union select hpua.party_id from hz_party_usg_assignments hpua where hpua.party_usage_code='SUPPLIER_CONTACT')
group by
fu.person_party_id
) cu,
(
select
x.person_party_id,
listagg(x.responsibility_name,chr(10)) within group (order by x.responsibility_name, x.application_name) contact_responsibilities,
listagg(x.application_name,chr(10)) within group (order by x.responsibility_name, x.application_name) contact_applications
from
(
select distinct
fu.person_party_id,
frv.responsibility_name,
fav.application_name
from
fnd_user fu,
fnd_user_resp_groups_direct furgd,
fnd_responsibility_vl frv,
fnd_application_vl fav
where
'&show_contact_responsibilities'='Y' and
fu.person_party_id in (select asco.per_party_id from ap_supplier_contacts asco union select hpua.party_id from hz_party_usg_assignments hpua where hpua.party_usage_code='SUPPLIER_CONTACT') and
fu.user_id=furgd.user_id and
furgd.security_group_id=0 and
(furgd.end_date is null or furgd.end_date>sysdate) and
furgd.responsibility_id=frv.responsibility_id and
furgd.responsibility_application_id=frv.application_id and
furgd.responsibility_application_id=fav.application_id
) x
group by
x.person_party_id
) cr,
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
&dup_from
&il_from
where
1=1 and
aps.vendor_id=assa.vendor_id(+) and
assa.org_id=haouv.organization_id(+) and
assa.country=ftv.territory_code(+) and
assa.vendor_id=pvc.vendor_id(+) and
nvl(assa.vendor_site_id,-99)=nvl(pvc.vendor_site_id(+),nvl(assa.vendor_site_id,-99)) and
pvc.per_party_id=cu.person_party_id(+) and
pvc.per_party_id=cr.person_party_id(+) and
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
&il_where
order by
haouv.name,
aps.vendor_name,
assa.vendor_site_code
