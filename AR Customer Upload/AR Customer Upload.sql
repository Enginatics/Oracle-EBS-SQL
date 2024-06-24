/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Customer Upload
-- Description: AR Customer Upload
This upload can be used to create and/or update Customer Accounts, Customer Sites and/or Customer Site Uses.
Additionally, the upload supports:
- the creation/update of the Customer Profiles and Customer Profile Amounts at Customer and Customer Site Level
- the creation/update of bank Accounts at the Customer and Customer Site Level
- the creation/update of Contact information at the Customer and Customer Site level

The following parameters determine the behaviour of the upload.

Upload Mode
===========
Create – In this mode the user starts with a blank Excel. Use this mode to create new customers.
Create, Update – In this mode the existing customer information is first downloaded into the excel based on the other parameters specified. Use this mode to update existing customer information, or to add/update additional supplementary information to the Customers and or Customer Sites (like customer profile information, customer profile amounts, bank accounts, contacts). This mode can also be used to create new Customers.

Update Level
===========
This parameter determines if you want to download the Customer Profiles, Bank Accounts, and Contacts at the Customer Level, Customer Site Level or Both  
Customer – only Customer Level information is downloaded to excel.
Site – only Customer Site level information is downloaded to the excel
Blank – Customer and Customer Site level information is downloaded to the Excel.
In the excel you can create/update the customer profiles, bank accounts, and/or contacts at the customer level by leaving the Site Level columns null.

Update Profile Amounts
===================
Set to Yes to download the Customer Profile Amounts assigned to the Customer and/or Customer Site profiles.

Update Bank Accounts
================
Set to Yes to download the Bank Accounts assigned to the Customers and/or Customer Sites

Update Contacts
==============
Set to Yes to download the Contacts assigned to the Customers and/or Customer Sites

Contact Status
============
Determines the status of the contacts to be downloaded. By default, only active contacts will be downloaded. But his can be changed to download all contacts, or inactive contacts only.

-- Excel Examle Output: https://www.enginatics.com/example/ar-customer-upload/
-- Library Link: https://www.enginatics.com/reports/ar-customer-upload/
-- Run Report: https://demo.enginatics.com/

with
q_contacts as
(select
 hcar.cust_account_role_id,
 hcar.cust_account_id,
 hcar.cust_acct_site_id cust_acct_site_id,
 case when hcar.status='A' AND hr.status='A' then 'A' else 'I' end contact_status_code,
 hprel.primary_phone_contact_pt_id pri_phone_contact_point_id,
 hcp.contact_point_id sec_phone_contact_point_id,
 --
 xxen_util.meaning(hpsub.person_pre_name_adjunct,'CONTACT_TITLE',222) contact_prefix,
 hpsub.person_first_name contact_first_name,
 hpsub.person_middle_name contact_middle_name,
 hpsub.person_last_name contact_last_name,
 hpsub.person_name_suffix contact_suffix,
 hpsub.person_title contact_title,
 xxen_util.meaning(case when hcar.status='A' AND hr.status='A' then 'A' else 'I' end,'HZ_CPUI_REGISTRY_STATUS',222) contact_status,
 hprel.email_address contact_email,
 hprel.primary_phone_country_code contact_phone_country_code,
 hprel.primary_phone_area_code contact_phone_area_code,
 hprel.primary_phone_number contact_phone_number,
 hprel.primary_phone_extension contact_phone_extension,
 xxen_util.meaning(hprel.primary_phone_line_type,'PHONE_LINE_TYPE',222) contact_phone_type,
 hcp.phone_country_code secondary_phone_country_code,
 hcp.phone_area_code secondary_phone_area_code,
 hcp.phone_number secondary_phone_number,
 hcp.phone_extension secondary_phone_extension,
 xxen_util.meaning(hcp.phone_line_type,'PHONE_LINE_TYPE',222) secondary_phone_type,
 xxen_util.meaning(hoc.job_title_code,'RESPONSIBILITY',222) contact_job_title_code,
 hoc.job_title contact_job_title,
 hoc.contact_number,
 (select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = hl.country) contact_country,
 hl.address1 contact_address_line1,
 hl.address2 contact_address_line2,
 hl.address3 contact_address_line3,
 hl.address4 contact_address_line4,
 hl.city contact_city,
 hl.county contact_county,
 hl.state contact_state,
 hl.postal_code contact_postal_code,
 hl.sales_tax_geocode contact_geography_override,
 hps.mailstop contact_mailstop
 from
 hz_cust_account_roles hcar,
 hz_relationships hr,
 hz_parties hprel,
 hz_parties hpsub,
 hz_parties hpobj,
 hz_org_contacts hoc,
 hz_cust_accounts hca,
 hz_party_sites hps,
 hz_locations hl,
 (select
  hcp.contact_point_id,
  hcp.owner_table_id party_id,
  hcp.phone_country_code,
  hcp.phone_area_code,
  hcp.phone_number,
  hcp.phone_extension,
  hcp.phone_line_type,
  row_number() over (partition by hcp.owner_table_id order by hcp.last_update_date desc,hcp.contact_point_id desc) row_num
  from
  hz_contact_points hcp
  where
  hcp.owner_table_name = 'HZ_PARTIES' and
  hcp.contact_point_type = 'PHONE' and
  hcp.status = 'A' and
  nvl(hcp.primary_flag,'N') != 'Y'
 ) hcp
 where
 hcar.role_type = 'CONTACT' and
 hcar.party_id = hr.party_id and
 hr.party_id = hprel.party_id and
 hr.subject_id = hpsub.party_id and
 hr.object_id = hpobj.party_id and
 hr.relationship_id = hoc.party_relationship_id and
 hcar.cust_account_id = hca.cust_account_id and
 hr.object_id = hca.party_id and
 hprel.party_id = hps.party_id(+) and
 nvl(hps.identifying_address_flag(+),'Y') = 'Y' and
 nvl(hps.status(+),'A') = 'A' and
 hps.location_id = hl.location_id (+) and
 hprel.party_id = hcp.party_id (+) and
 hcp.row_num (+) = 1 and
 ((hcar.status='A' AND hr.status='A') or
  ((hcar.status ='I' OR hr.status='I') AND hpsub.status='A' and hpobj.status= 'A' AND hr.status <> 'M')
 )
),
q_bank_accounts as
(select
 iepa.ext_payer_id,
 ieba.ext_bank_account_id          bank_account_id,
 iepa.cust_account_id,
 iepa.acct_site_use_id             site_use_id,
 cbbv.bank_name                    bank_name,
 cbbv.bank_number                  bank_number,
 (select ftv.territory_short_name
  from   fnd_territories_vl ftv
  where  ftv.territory_code = cbbv.bank_home_country
 ) bank_country,
 cbbv.bank_branch_name             bank_branch_name,
 cbbv.branch_number                bank_branch_number,
 cbbv.bank_branch_type             bank_branch_type,
 cbbv.eft_swift_code               bank_branch_bic,
 ieba.bank_account_name            bank_acct_name,
 ieba.bank_account_num             bank_acct_num,
 ieba.check_digits                 bank_acct_check_digits,
 ieba.currency_code                bank_acct_currency,
 --xxen_util.meaning(ieba0.foreign_payment_use_flag,'YES_NO',0)  bank_allow_foreign_pay,
 ieba.iban                         bank_acct_iban,
 ieba.bank_account_name_alt        bank_acct_name_alt,
 ieba.account_suffix               bank_acct_suffix,
 ieba.start_date                   bank_acct_start_date,
 ieba.end_date                     bank_acct_end_date,
 xxen_util.meaning(ieba.bank_account_type,'BANK_ACCOUNT_TYPE',260)
                                    bank_acct_type,
 ieba.secondary_account_reference  bank_acct_sec_reference,
 ieba.description                  bank_acct_description,
 ieba.contact_name                 bank_acct_contact,
 ieba.contact_phone                bank_acct_contact_phone,
 ieba.contact_fax                  bank_acct_contact_fax,
 ieba.contact_email                bank_acct_contact_email
 from
 iby_external_payers_all iepa,
 iby_pmt_instr_uses_all ipiua,
 iby_ext_bank_accounts ieba,
 ce_bank_branches_v cbbv
 where
 iepa.ext_payer_id = ipiua.ext_pmt_party_id and
 ipiua.instrument_id = ieba.ext_bank_account_id and
 ieba.branch_id = cbbv.branch_party_id and
 iepa.payment_function = 'CUSTOMER_PAYMENT' and
 ipiua.payment_function = 'CUSTOMER_PAYMENT' and
 ipiua.instrument_type = 'BANKACCOUNT' and
 sysdate between ipiua.start_date and nvl(ipiua.end_date,sysdate)
)
--
-- main query starts here
--
select
y.*
from
(
select
null action_,
null status_,
null message_,
null request_id_,
:p_upload_mode upload_mode_,
to_number(null) cust_account_row_id,
to_number(null) cust_acct_site_row_id,
to_number(null) cust_site_use_row_id,
to_number(null) cust_profile_row_id,
to_number(null) cust_profile_amt_row_id,
to_number(null) cust_account_role_row_id,
to_number(null) bank_account_row_id,
:p_created_by_module created_by_module,
:p_validate_dff validate_dff_attributes,
x.*
from
(
--
-- Q1 Account Level Profile or Account with no sites
--
select
--
-- party
--
xxen_util.meaning(hp.party_type,'PARTY_TYPE',222) party_type,
hp.party_name,
hp.party_number registry_id,
hp.known_as alias,
hp.organization_name_phonetic name_pronunciation,
hp.duns_number,
-- party dff
hp.attribute_category party_dff_context,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE1',hp.rowid,hp.attribute1) hz_party_attribute1,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE2',hp.rowid,hp.attribute2) hz_party_attribute2,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE3',hp.rowid,hp.attribute3) hz_party_attribute3,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE4',hp.rowid,hp.attribute4) hz_party_attribute4,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE5',hp.rowid,hp.attribute5) hz_party_attribute5,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE6',hp.rowid,hp.attribute6) hz_party_attribute6,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE7',hp.rowid,hp.attribute7) hz_party_attribute7,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE8',hp.rowid,hp.attribute8) hz_party_attribute8,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE9',hp.rowid,hp.attribute9) hz_party_attribute9,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE10',hp.rowid,hp.attribute10) hz_party_attribute10,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE11',hp.rowid,hp.attribute11) hz_party_attribute11,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE12',hp.rowid,hp.attribute12) hz_party_attribute12,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE13',hp.rowid,hp.attribute13) hz_party_attribute13,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE14',hp.rowid,hp.attribute14) hz_party_attribute14,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE15',hp.rowid,hp.attribute15) hz_party_attribute15,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE16',hp.rowid,hp.attribute16) hz_party_attribute16,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE17',hp.rowid,hp.attribute17) hz_party_attribute17,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE18',hp.rowid,hp.attribute18) hz_party_attribute18,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE19',hp.rowid,hp.attribute19) hz_party_attribute19,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE20',hp.rowid,hp.attribute20) hz_party_attribute20,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE21',hp.rowid,hp.attribute21) hz_party_attribute21,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE22',hp.rowid,hp.attribute22) hz_party_attribute22,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE23',hp.rowid,hp.attribute23) hz_party_attribute23,
xxen_util.display_flexfield_value(222,'HZ_PARTIES',hp.attribute_category,'ATTRIBUTE24',hp.rowid,hp.attribute24) hz_party_attribute24,
--
-- cust account
--
hca.account_number acct_number,
hca.account_name acct_description,
hca.orig_system_reference acct_orig_sys_ref,
xxen_util.meaning(hca.status,'REGISTRY_STATUS',222) acct_status,
hca.account_established_date acct_established_date,
xxen_util.meaning(hca.customer_class_code,'CUSTOMER CLASS',222) acct_classification,
xxen_util.meaning(hca.customer_type,'CUSTOMER_TYPE',222) acct_type,
xxen_util.meaning(hca.sales_channel_code,'SALES_CHANNEL',660) acct_sales_channel,
-- account order management
(select qslhv.name from qp_secu_list_headers_v qslhv where qslhv.list_header_id = hca.price_list_id) acct_price_list,
hca.item_cross_ref_pref acct_item_type_identifier,
xxen_util.meaning(hca.date_type_preference,'REQUEST_DATE_TYPE',660) acct_request_date_type,
xxen_util.meaning(hca.freight_term,'FREIGHT_TERMS',660) acct_freight_terms,
xxen_util.meaning(hca.fob_point,'FOB',222) acct_fob_point,
(select osmv.meaning from oe_ship_methods_v osmv where osmv.lookup_code = hca.ship_via) acct_ship_method,
(select haouv.name from hr_all_organization_units_vl haouv where haouv.organization_id = hca.warehouse_id) acct_warehouse,
hca.dates_negative_tolerance acct_earliest_schedule_limit,
hca.dates_positive_tolerance acct_latest_schedule_limit,
xxen_util.meaning(hca.invoice_quantity_rule,'INVOICE_BASIS',660) acct_overship_invoice_base,
hca.over_shipment_tolerance acct_over_shipment_tolerance,
hca.under_shipment_tolerance acct_under_shipment_tolerance,
hca.over_return_tolerance acct_over_return_tolerance,
hca.under_return_tolerance acct_under_return_tolerance,
--xxen_util.meaning(hca.cancel_unshipped_lines_flag,'YES_NO',0) acct_cancel_unshipped_lines, /*not in r1213 */
xxen_util.meaning(hca.sched_date_push_flag,'YES_NO',0) acct_push_group_schedule_date,
xxen_util.meaning(hca.arrivalsets_include_lines_flag,'YES_NO',0) acct_lines_in_arrival_sets,
xxen_util.meaning(hca.ship_sets_include_lines_flag,'YES_NO',0) acct_lines_in_ship_sets,
(select
 rm.name receipt_method
 from
 ra_cust_receipt_methods rcrm,
 ar_receipt_methods rm
 where
 rcrm.receipt_method_id = rm.receipt_method_id and
 rcrm.primary_flag = 'Y' and
 trunc(sysdate) between nvl(rcrm.start_date,trunc(sysdate)) and nvl(rcrm.end_date,trunc(sysdate)) and
 rcrm.customer_id = hca.cust_account_id and
 rcrm.site_use_id is null and
 rownum <= 1
) acct_primary_receipt_method,
-- tax
xxen_util.meaning(zptp0.process_for_applicability_flag,'YES_NO',0) acct_allow_tax_applicability,
xxen_util.meaning(zptp0.allow_offset_tax_flag,'YES_NO',0) acct_allow_offset_taxes,
xxen_util.meaning(zptp0.self_assess_flag,'YES_NO',0) acct_self_assessment,
xxen_util.meaning(nvl(zptp0.rounding_level_code,decode(hca.tax_header_level_flag,'Y','HEADER','LINE')),'ZX_ROUNDING_LEVEL',0) acct_tax_rounding_level,
xxen_util.meaning(nvl(zptp0.rounding_rule_code,hca.tax_rounding_rule),'ZX_ROUNDING_RULE',0) acct_tax_rounding_rule,
xxen_util.meaning(zptp0.inclusive_tax_flag,'YES_NO',0) acct_inclusive_tax,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp0.country_code) acct_tax_reporting_country,
zptp0.registration_type_code acct_tax_reporting_reg_type,
zptp0.rep_registration_number acct_tax_reporting_reg_number,
-- cust account dff
hca.attribute_category acct_dff_context,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE1',hca.rowid,hca.attribute1) hz_cust_acct_attribute1,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE2',hca.rowid,hca.attribute2) hz_cust_acct_attribute2,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE3',hca.rowid,hca.attribute3) hz_cust_acct_attribute3,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE4',hca.rowid,hca.attribute4) hz_cust_acct_attribute4,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE5',hca.rowid,hca.attribute5) hz_cust_acct_attribute5,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE6',hca.rowid,hca.attribute6) hz_cust_acct_attribute6,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE7',hca.rowid,hca.attribute7) hz_cust_acct_attribute7,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE8',hca.rowid,hca.attribute8) hz_cust_acct_attribute8,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE9',hca.rowid,hca.attribute9) hz_cust_acct_attribute9,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE10',hca.rowid,hca.attribute10) hz_cust_acct_attribute10,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE11',hca.rowid,hca.attribute11) hz_cust_acct_attribute11,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE12',hca.rowid,hca.attribute12) hz_cust_acct_attribute12,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE13',hca.rowid,hca.attribute13) hz_cust_acct_attribute13,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE14',hca.rowid,hca.attribute14) hz_cust_acct_attribute14,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE15',hca.rowid,hca.attribute15) hz_cust_acct_attribute15,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE16',hca.rowid,hca.attribute16) hz_cust_acct_attribute16,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE17',hca.rowid,hca.attribute17) hz_cust_acct_attribute17,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE18',hca.rowid,hca.attribute18) hz_cust_acct_attribute18,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE19',hca.rowid,hca.attribute19) hz_cust_acct_attribute19,
xxen_util.display_flexfield_value(222,'RA_CUSTOMERS_HZ',hca.attribute_category,'ATTRIBUTE20',hca.rowid,hca.attribute20) hz_cust_acct_attribute20,
--
-- party site
--
hps.party_site_number site_number,
hps.party_site_name site_name,
hps.addressee site_addressee,
xxen_util.meaning(hps.identifying_address_flag,'YES_NO',0) site_identifying_address,
xxen_util.meaning(hps.status,'REGISTRY_STATUS',222) site_status,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = hl.country) country,
hl.address1 address_line1,
hl.address2 address_line2,
hl.address3 address_line3,
hl.address4 address_line4,
hl.city,
hl.county,
hl.state,
hl.postal_code,
--hl.province,
--xxen_util.meaning(hl.address_style,'ADDRESS_STYLE',0) address_style,
hl.sales_tax_geocode geography_code_override,
hz_format_pub.format_address(hl.location_id,null,null,', ') site_address,
-- party site dff
hps.attribute_category site_dff_context,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE1',hps.rowid,hps.attribute1) hz_party_site_attribute1,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE2',hps.rowid,hps.attribute2) hz_party_site_attribute2,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE3',hps.rowid,hps.attribute3) hz_party_site_attribute3,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE4',hps.rowid,hps.attribute4) hz_party_site_attribute4,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE5',hps.rowid,hps.attribute5) hz_party_site_attribute5,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE6',hps.rowid,hps.attribute6) hz_party_site_attribute6,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE7',hps.rowid,hps.attribute7) hz_party_site_attribute7,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE8',hps.rowid,hps.attribute8) hz_party_site_attribute8,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE9',hps.rowid,hps.attribute9) hz_party_site_attribute9,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE10',hps.rowid,hps.attribute10) hz_party_site_attribute10,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE11',hps.rowid,hps.attribute11) hz_party_site_attribute11,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE12',hps.rowid,hps.attribute12) hz_party_site_attribute12,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE13',hps.rowid,hps.attribute13) hz_party_site_attribute13,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE14',hps.rowid,hps.attribute14) hz_party_site_attribute14,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE15',hps.rowid,hps.attribute15) hz_party_site_attribute15,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE16',hps.rowid,hps.attribute16) hz_party_site_attribute16,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE17',hps.rowid,hps.attribute17) hz_party_site_attribute17,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE18',hps.rowid,hps.attribute18) hz_party_site_attribute18,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE19',hps.rowid,hps.attribute19) hz_party_site_attribute19,
xxen_util.display_flexfield_value(222,'HZ_PARTY_SITES',hps.attribute_category,'ATTRIBUTE20',hps.rowid,hps.attribute20) hz_party_site_attribute20,
--
-- cust account site
--
hou.name operating_unit,
xxen_util.meaning(decode(hps.status || hcasa.status,null,null,'AA','A','I'),'REGISTRY_STATUS',222) acct_site_status,
-- hcasa.customer_category_code, /* need to determine the LOV on this. No entries in R1213 and Demo*/
(select rt.name from ra_territories rt where rt.territory_id = hcasa.territory_id) territory,
hcasa.translated_customer_name translated_cust_name,
hcasa.ece_tp_location_code edi_location,
-- account site dff
hcasa.attribute_category acct_site_dff_context,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE1',hcasa.rowid,hcasa.attribute1) hz_cust_acct_site_attribute1,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE2',hcasa.rowid,hcasa.attribute2) hz_cust_acct_site_attribute2,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE3',hcasa.rowid,hcasa.attribute3) hz_cust_acct_site_attribute3,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE4',hcasa.rowid,hcasa.attribute4) hz_cust_acct_site_attribute4,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE5',hcasa.rowid,hcasa.attribute5) hz_cust_acct_site_attribute5,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE6',hcasa.rowid,hcasa.attribute6) hz_cust_acct_site_attribute6,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE7',hcasa.rowid,hcasa.attribute7) hz_cust_acct_site_attribute7,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE8',hcasa.rowid,hcasa.attribute8) hz_cust_acct_site_attribute8,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE9',hcasa.rowid,hcasa.attribute9) hz_cust_acct_site_attribute9,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE10',hcasa.rowid,hcasa.attribute10) hz_cust_acct_site_attribute10,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE11',hcasa.rowid,hcasa.attribute11) hz_cust_acct_site_attribute11,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE12',hcasa.rowid,hcasa.attribute12) hz_cust_acct_site_attribute12,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE13',hcasa.rowid,hcasa.attribute13) hz_cust_acct_site_attribute13,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE14',hcasa.rowid,hcasa.attribute14) hz_cust_acct_site_attribute14,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE15',hcasa.rowid,hcasa.attribute15) hz_cust_acct_site_attribute15,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE16',hcasa.rowid,hcasa.attribute16) hz_cust_acct_site_attribute16,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE17',hcasa.rowid,hcasa.attribute17) hz_cust_acct_site_attribute17,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE18',hcasa.rowid,hcasa.attribute18) hz_cust_acct_site_attribute18,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE19',hcasa.rowid,hcasa.attribute19) hz_cust_acct_site_attribute19,
xxen_util.display_flexfield_value(222,'RA_ADDRESSES_HZ',hcasa.attribute_category,'ATTRIBUTE20',hcasa.rowid,hcasa.attribute20) hz_cust_acct_site_attribute20,
--
-- cust account site use
--
xxen_util.meaning(hcsua.site_use_code,'SITE_USE_CODE',222) site_use_purpose,
hcsua.location site_use_location,
(select hcsua2.location from hz_cust_site_uses_all hcsua2 where hcsua2.site_use_id = hcsua.bill_to_site_use_id) bill_to_site_use_location,
xxen_util.meaning(hcsua.primary_flag,'YES_NO',0) primary_site_use,
xxen_util.meaning(hcsua.status,'REGISTRY_STATUS',222) site_use_status,
-- bill to accounts
case when hcsua.site_use_code = 'BILL_TO' then (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = hcsua.gl_id_rec) else null end receivables_account,
case when hcsua.site_use_code = 'BILL_TO' then (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = hcsua.gl_id_rev) else null end revenue_account,
case when hcsua.site_use_code = 'BILL_TO' then (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = hcsua.gl_id_tax) else null end tax_account,
case when hcsua.site_use_code = 'BILL_TO' then (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = hcsua.gl_id_freight) else null end freight_account,
case when hcsua.site_use_code = 'BILL_TO' then (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = hcsua.gl_id_clearing) else null end clearing_account,
case when hcsua.site_use_code = 'BILL_TO' then (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = hcsua.gl_id_unbilled) else null end unbilled_rec_account,
case when hcsua.site_use_code = 'BILL_TO' then (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = hcsua.gl_id_unearned) else null end unearned_rec_account,
case when hcsua.site_use_code = 'BILL_TO' then (select arta.name from ar_receivables_trx_all arta where arta.type = 'FINCHRG' and arta.receivables_trx_id = hcsua.finchrg_receivables_trx_id and arta.org_id = hcsua.org_id) else null end charges_activity,
--
(select rtk.concatenated_segments from ra_territories_kfv rtk where rtk.territory_id = hcsua.territory_id) site_territory,
(select rtv.name from ra_terms_vl rtv where rtv.term_id = hcsua.payment_term_id) site_payment_terms,
(select nvl(jrret.resource_name,jrs.name) from jtf_rs_salesreps jrs, jtf_rs_resource_extns_tl jrret where jrs.resource_id=jrret.resource_id(+) and jrret.language (+) =userenv('lang') and jrs.salesrep_id = hcsua.primary_salesrep_id and jrs.org_id = hcsua.org_id) site_primary_salesperson,
(select hpc.party_name || ' (' || acv.orig_system_reference || ')' from ar_contacts_v acv, hz_parties hpc where acv.contact_party_id = hpc.party_id and acv.contact_id = hcsua.contact_id and acv.customer_id = hca.cust_account_id and rownum <= 1) site_contact,
hcsua.sic_code site_sic_code,
-- site use order management
(select ottt.name from oe_transaction_types_tl ottt where ottt.transaction_type_id = hcsua.order_type_id and ottt.language = userenv('lang')) site_order_type,
(select qslhv.name from qp_secu_list_headers_v qslhv where qslhv.list_header_id = hcsua.price_list_id) site_price_list,
hcsua.item_cross_ref_pref site_item_type_identifier,
xxen_util.meaning(hcsua.date_type_preference,'REQUEST_DATE_TYPE',660) site_request_date_type,
xxen_util.meaning(hcsua.freight_term,'FREIGHT_TERMS',660) site_freight_terms,
xxen_util.meaning(hcsua.fob_point,'FOB',222) site_fob_point,
(select osmv.meaning from oe_ship_methods_v osmv where osmv.lookup_code = hcsua.ship_via) site_ship_method,
(select haouv.name from hr_all_organization_units_vl haouv where haouv.organization_id = hcsua.warehouse_id) site_warehouse,
hcsua.dates_negative_tolerance site_earliest_schedule_limit,
hcsua.dates_positive_tolerance site_latest_schedule_limit,
xxen_util.meaning(hcsua.invoice_quantity_rule,'INVOICE_BASIS',660) site_overship_invoice_base,
hcsua.over_shipment_tolerance site_over_shipment_tolerance,
hcsua.under_shipment_tolerance site_under_shipment_tolerance,
hcsua.over_return_tolerance site_over_return_tolerance,
hcsua.under_return_tolerance site_under_return_tolerance,
xxen_util.meaning(hcsua.sched_date_push_flag,'YES_NO',0) site_push_group_schedule_date,
xxen_util.meaning(hcsua.arrivalsets_include_lines_flag,'YES_NO',0) site_lines_in_arrival_sets,
xxen_util.meaning(hcsua.ship_sets_include_lines_flag,'YES_NO',0) site_lines_in_ship_sets,
xxen_util.meaning(hcsua.demand_class_code,'DEMAND_CLASS',3) site_demand_class,
(select
 rm.name receipt_method
 from
 ra_cust_receipt_methods rcrm,
 ar_receipt_methods rm
 where
 rcrm.receipt_method_id = rm.receipt_method_id and
 rcrm.primary_flag = 'Y' and
 trunc(sysdate) between nvl(rcrm.start_date,trunc(sysdate)) and nvl(rcrm.end_date,trunc(sysdate)) and
 rcrm.customer_id = hca.cust_account_id and
 rcrm.site_use_id = hcsua.site_use_id and
 rownum <= 1
) site_primary_receipt_method,
-- tax
xxen_util.meaning(zptp1.process_for_applicability_flag,'YES_NO',0) site_allow_tax_applicability,
xxen_util.meaning(zptp1.allow_offset_tax_flag,'YES_NO',0) site_allow_offset_taxes,
xxen_util.meaning(zptp1.self_assess_flag,'YES_NO',0) site_self_assessment,
xxen_util.meaning(nvl(zptp1.rounding_level_code,decode(hcsua.tax_header_level_flag,'Y','HEADER','LINE')),'ZX_ROUNDING_LEVEL',0) site_tax_rounding_level,
xxen_util.meaning(nvl(zptp1.rounding_rule_code,hcsua.tax_rounding_rule),'ZX_ROUNDING_RULE',0) site_tax_rounding_rule,
xxen_util.meaning(zptp1.inclusive_tax_flag,'YES_NO',0) site_inclusive_tax,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp1.country_code) site_tax_reporting_country,
zptp1.registration_type_code site_tax_reporting_reg_type,
zptp1.rep_registration_number site_tax_reporting_reg_number,
hcsua.tax_reference site_tax_registration_number,
(select
 zocv.meaning
 from
 zx_output_classifications_v zocv
 where
 zocv.lookup_code = nvl(zptp1.tax_classification_code,hcsua.tax_code) and
 zocv.org_id in (hcsua.org_id,-99) and
 zocv.enabled_flag = 'Y' and
 sysdate between nvl(zocv.start_date_active,sysdate) and nvl(zocv.end_date_active,sysdate) and
 rownum <= 1
) site_tax_classification,
xxen_util.meaning(hcsua.tax_classification,'ZX_PTPTR_GEO_TYPE_CLASS',0) site_tax_geography_type,
-- site use dff
hcsua.attribute_category site_use_dff_context,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE1',hcsua.rowid,hcsua.attribute1) hz_cust_site_use_attribute1,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE2',hcsua.rowid,hcsua.attribute2) hz_cust_site_use_attribute2,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE3',hcsua.rowid,hcsua.attribute3) hz_cust_site_use_attribute3,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE4',hcsua.rowid,hcsua.attribute4) hz_cust_site_use_attribute4,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE5',hcsua.rowid,hcsua.attribute5) hz_cust_site_use_attribute5,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE6',hcsua.rowid,hcsua.attribute6) hz_cust_site_use_attribute6,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE7',hcsua.rowid,hcsua.attribute7) hz_cust_site_use_attribute7,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE8',hcsua.rowid,hcsua.attribute8) hz_cust_site_use_attribute8,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE9',hcsua.rowid,hcsua.attribute9) hz_cust_site_use_attribute9,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE10',hcsua.rowid,hcsua.attribute10) hz_cust_site_use_attribute10,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE11',hcsua.rowid,hcsua.attribute11) hz_cust_site_use_attribute11,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE12',hcsua.rowid,hcsua.attribute12) hz_cust_site_use_attribute12,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE13',hcsua.rowid,hcsua.attribute13) hz_cust_site_use_attribute13,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE14',hcsua.rowid,hcsua.attribute14) hz_cust_site_use_attribute14,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE15',hcsua.rowid,hcsua.attribute15) hz_cust_site_use_attribute15,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE16',hcsua.rowid,hcsua.attribute16) hz_cust_site_use_attribute16,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE17',hcsua.rowid,hcsua.attribute17) hz_cust_site_use_attribute17,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE18',hcsua.rowid,hcsua.attribute18) hz_cust_site_use_attribute18,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE19',hcsua.rowid,hcsua.attribute19) hz_cust_site_use_attribute19,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE20',hcsua.rowid,hcsua.attribute20) hz_cust_site_use_attribute20,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE21',hcsua.rowid,hcsua.attribute21) hz_cust_site_use_attribute21,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE22',hcsua.rowid,hcsua.attribute22) hz_cust_site_use_attribut