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

Default Operating Unit and Default Profile Class
======================================
For creation of new Customers/Customer Sites, the Operating Unit and Profile Class to be used can be defaulted automatically if specified by these parameters

Default <entity> Assign. Level
========================
For the creation of new Customers/Customer Sites, these parameters can be used to explicitly specify the level (Account or Site) to which the Profile Class, Tax Registration, Bank Accounts, Contacts, and Attachments should be assigned to respectively.
Normally the upload will determine the level based on the existence of site level identifying data in the excel row being uploaded. If no site level identifying data is present, then it will be associated the entity with the Account, otherwise the entity will be associated with the site.
This would require a separate excel row to be specified for the customer account and a separate row for the customer site if some entities are to be associated with the customer account and some with the customer site.
These parameters allow you to create the customer account and customer site in a single excel row and explicitly specify for each entity at what level the entity should be associated with.

-- Excel Examle Output: https://www.enginatics.com/example/ar-customer-upload/
-- Library Link: https://www.enginatics.com/reports/ar-customer-upload/
-- Run Report: https://demo.enginatics.com/

with
q_contacts as
(select /*+ inline */
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
(select /*+ inline */
 iepa.cust_account_id              cust_account_id,
 iepa.acct_site_use_id             site_use_id,
 ipiua.instrument_payment_use_id,
 iepa.ext_payer_id,
 ieba.ext_bank_account_id          bank_account_id,
 cbbv.bank_name                    bank_name,
 cbbv.bank_number                  bank_number,
 (select ftv.territory_short_name
  from   fnd_territories_vl ftv
  where  ftv.territory_code = cbbv.bank_home_country
 )                                 bank_country,
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
 xxen_util.meaning(ieba.bank_account_type,'BANK_ACCOUNT_TYPE',260)
                                   bank_acct_type,
 ieba.secondary_account_reference  bank_acct_sec_reference,
 ieba.description                  bank_acct_description,
 ieba.contact_name                 bank_acct_contact,
 ieba.contact_phone                bank_acct_contact_phone,
 ieba.contact_fax                  bank_acct_contact_fax,
 ieba.contact_email                bank_acct_contact_email,
 ipiua.start_date                  bank_acct_assignmt_start_date,
 ipiua.end_date                    bank_acct_assignmt_end_date
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
 ipiua.instrument_type = 'BANKACCOUNT'
 -- and sysdate between ipiua.start_date and nvl(ipiua.end_date,sysdate)
),
q_attachments as
(select /*+ inline */
 fad.attached_document_id attachment_id,
 fad.entity_name,
 fad.pk1_value entity_id,
 fad.seq_num,
 fdd.user_name type,
 fdct.user_name category,
 fdt.title,
 fdt.description,
 case fd.datatype_id
 when 1 then (select fdst.short_text from fnd_documents_short_text fdst where fdst.media_id = fd.media_id)
 when 5 then fd.url
 when 6 then (select fl.file_name from fnd_lobs fl where fl.file_id = fd.media_id)
 else null
 end content,
 case when fd.datatype_id = 6 then fd.media_id else null end file_id
 from
 fnd_attached_documents fad,
 fnd_documents fd,
 fnd_documents_tl fdt, 
 fnd_document_datatypes fdd,
 fnd_document_categories_tl fdct
 where
 fad.document_id = fd.document_id and
 fd.document_id = fdt.document_id and
 fdt.language = userenv('lang') and
 fd.datatype_id = fdd.datatype_id and
 fdd.language = userenv('lang') and
 fd.category_id = fdct.category_id and
 fdct.language = userenv('lang') and
 fd.datatype_id in (1,5,6)
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
null modified_columns_,
:p_upload_mode upload_mode_,
to_number(null) cust_account_row_id,
to_number(null) cust_acct_site_row_id,
to_number(null) cust_site_use_row_id,
to_number(null) cust_profile_row_id,
to_number(null) cust_profile_amt_row_id,
to_number(null) cust_account_role_row_id,
to_number(null) bank_intsr_pay_use_row_id,
to_number(null) tax_registration_row_id,
to_number(null) attachment_row_id,
:p_created_by_module created_by_module,
:p_dflt_prof_assign_lvl dflt_profile_assign_lvl,
:p_dflt_tax_reg_assign_lvl dflt_tax_reg_assign_lvl,
:p_dflt_bank_acct_assign_lvl dflt_bank_acct_assign_lvl,
:p_dflt_ctct_assign_lvl dflt_ctct_assign_lvl,
:p_dflt_attchmt_assign_lvl dflt_attchmt_assign_lvl,
x.*
from
(
--
-- Q1 Account Level Profile or Account with no sites
--
select /*+ push_pred(ctct) push_pred(ba) push_pred(attchmt) */
--
-- party
--
xxen_util.meaning(hp.party_type,'PARTY_TYPE',222) party_type,
hp.party_name,
hp.party_number registry_id,
hp.known_as alias,
hp.organization_name_phonetic name_pronunciation,
hp.duns_number,
(select hop.jgzz_fiscal_code from hz_organization_profiles hop where hop.party_id = hp.party_id and hop.effective_end_date is null and rownum=1)  taxpayer_id,
-- party dff
xxen_util.display_flexfield_context(222,'HZ_PARTIES',hp.attribute_category) party_dff_context,
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
xxen_util.meaning(nvl(zptp0.rounding_level_code,decode(hca.tax_header_level_flag,'Y','HEADER','N','LINE',null)),'ZX_ROUNDING_LEVEL',0) acct_tax_rounding_level,
xxen_util.meaning(nvl(zptp0.rounding_rule_code,hca.tax_rounding_rule),'ZX_ROUNDING_RULE',0) acct_tax_rounding_rule,
xxen_util.meaning(zptp0.inclusive_tax_flag,'YES_NO',0) acct_inclusive_tax,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp0.country_code) acct_tax_reporting_country,
zptp0.registration_type_code acct_tax_reporting_reg_type,
zptp0.rep_registration_number acct_tax_reporting_reg_number,
-- cust account dff
xxen_util.display_flexfield_context(222,'RA_CUSTOMERS_HZ',hca.attribute_category) acct_dff_context,
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
--
hcp1.phone_country_code site_phone_country_code,
hcp1.phone_area_code site_phone_area_code,
hcp1.phone_number site_phone_number,
hcp1.phone_extension site_phone_extension,
xxen_util.meaning(hcp1.phone_line_type,'PHONE_LINE_TYPE',222) site_phone_type,
hcp2.email_address site_email_address,
xxen_util.meaning(hcp2.email_format,'EMAIL_FORMAT',222) site_email_format,
xxen_util.meaning(hcp2.contact_point_purpose,'CONTACT_POINT_PURPOSE',222) site_email_purpose,
hcp3.url site_url,
xxen_util.meaning(hcp3.contact_point_purpose,'CONTACT_POINT_PURPOSE_WEB',222) site_url_purpose,
-- party site dff
xxen_util.display_flexfield_context(222,'HZ_PARTY_SITES',hps.attribute_category) site_dff_context,
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
xxen_util.display_flexfield_context(222,'RA_ADDRESSES_HZ',hcasa.attribute_category) acct_site_dff_context,
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
(select nvl(jrret.resource_name,jrs.name) || ' (' || jrs.salesrep_number || ')' from jtf_rs_salesreps jrs, jtf_rs_resource_extns_tl jrret where jrs.resource_id=jrret.resource_id(+) and jrret.language (+) =userenv('lang') and jrs.salesrep_id = hcsua.primary_salesrep_id and jrs.org_id = hcsua.org_id) site_primary_salesperson,
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
xxen_util.meaning(nvl(zptp1.rounding_level_code,decode(hcsua.tax_header_level_flag,'Y','HEADER','N','LINE',null)),'ZX_ROUNDING_LEVEL',0) site_tax_rounding_level,
xxen_util.meaning(nvl(zptp1.rounding_rule_code,hcsua.tax_rounding_rule),'ZX_ROUNDING_RULE',0) site_tax_rounding_rule,
xxen_util.meaning(zptp1.inclusive_tax_flag,'YES_NO',0) site_inclusive_tax,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp1.country_code) site_tax_reporting_country,
zptp1.registration_type_code site_tax_reporting_reg_type,
zptp1.rep_registration_number site_tax_reporting_reg_number,
hcsua.tax_reference site_use_tax_registration_num,
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
) site_use_tax_classification,
xxen_util.meaning(hcsua.tax_classification,'ZX_PTPTR_GEO_TYPE_CLASS',0) site_use_tax_geography_type,
-- site use dff
xxen_util.display_flexfield_context(222,'RA_SITE_USES_HZ',hcsua.attribute_category) site_use_dff_context,
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
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE22',hcsua.rowid,hcsua.attribute22) hz_cust_site_use_attribute22,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE23',hcsua.rowid,hcsua.attribute23) hz_cust_site_use_attribute23,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE24',hcsua.rowid,hcsua.attribute24) hz_cust_site_use_attribute24,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE25',hcsua.rowid,hcsua.attribute25) hz_cust_site_use_attribute25,
--
-- profile
--
nvl2(hcp.cust_account_profile_id,xxen_util.meaning('ACCOUNT','HZ_CONS_BILL_LEVEL',222),null) profile_assignment_level,
(select hcpc.name from hz_cust_profile_classes hcpc where hcpc.profile_class_id = hcp.profile_class_id) profile_class,
(select ac.name from ar_collectors ac where ac.collector_id = hcp.collector_id) collector,
xxen_util.meaning(hcp.risk_code,'RISK_CODE',222) risk_code,
xxen_util.meaning(hcp.credit_rating,'CREDIT_RATING',222) credit_rating,
xxen_util.meaning(hcp.credit_classification,'AR_CMGT_CREDIT_CLASSIFICATION',222) credit_classification,
xxen_util.meaning(hcp.review_cycle,'PERIODIC_REVIEW_CYCLE',222) review_cycle,
xxen_util.meaning(hcp.account_status,'ACCOUNT_STATUS',222) credit_status,
hcp.tolerance tolerance_pct,
hcp.percent_collectable collectable_pct,
xxen_util.meaning(hcp.credit_checking,'YES_NO',0) credit_check,
xxen_util.meaning(nvl(hcp.credit_hold,nvl2(hcp.cust_account_profile_id,'N',null)),'YES_NO',0) credit_hold,
(select jrrev.resource_name || ' (' ||  jrrev.source_number || ')' from jtf_rs_resource_extns_vl jrrev where jrrev.resource_id = hcp.credit_analyst_id) credit_analyst,
hcp.last_credit_review_date last_credit_review,
hcp.next_credit_review_date next_credit_review,
xxen_util.meaning(hcp.cons_inv_flag,'YES_NO',0) bal_fwd_billing_enable,
xxen_util.meaning(hcp.cons_bill_level,'HZ_CONS_BILL_LEVEL',222) bal_fwd_billing_level,
xxen_util.meaning(hcp.cons_inv_type,'HZ_CONS_INV_TYPE',222) bal_fwd_billing_type,
(select rtv.name from ra_terms_vl rtv where rtv.term_id = hcp.standard_terms) payment_terms,
hcp.discount_grace_days,
xxen_util.meaning(hcp.override_terms,'YES_NO',0) override_terms,
xxen_util.meaning(hcp.discount_terms,'YES_NO',0) allow_discount,
hcp.clearing_days receipt_clearing_days,
xxen_util.meaning(hcp.lockbox_matching_option,'ARLPLB_MATCHING_OPTION',222) match_receipts_by,
(select aah.hierarchy_name from ar_autocash_hierarchies aah where aah.autocash_hierarchy_id = hcp.autocash_hierarchy_id) automatic_cash_rule_set,
(select aah.hierarchy_name from ar_autocash_hierarchies aah where aah.autocash_hierarchy_id = hcp.autocash_hierarchy_id_for_adr) remainder_rule_set,
(select acarsv.automatch_set_name from ar_cash_auto_rule_sets_vl acarsv where acarsv.automatch_set_id = hcp.automatch_set_id) automatch_rule_set,
xxen_util.meaning(hcp.auto_rec_incl_disputed_flag,'YES_NO',0) incl_disputed_in_auto_receipts,
xxen_util.meaning(hcp.send_statements,'YES_NO',0) send_statements,
(select ascy.name from ar_statement_cycles ascy where ascy.statement_cycle_id = hcp.statement_cycle_id) statement_cycle,
xxen_util.meaning(hcp.credit_balance_statements,'YES_NO',0) send_credit_balance_statements,
xxen_util.meaning(hcp.dunning_letters,'YES_NO',0) send_dunning_letters,
(select adls.name from ar_dunning_letter_sets adls where adls.dunning_letter_set_id = hcp.dunning_letter_set_id) dunning_letter_set,
xxen_util.meaning(hcp.tax_printing_option,'TAX_PRINTING_OPTION',222) inv_tax_printing,
(select rgr.name from ra_grouping_rules rgr where rgr.grouping_rule_id = hcp.grouping_rule_id) inv_grouping_rule,
--
xxen_util.meaning(hcp.interest_charges,'YES_NO',0) enable_late_charges,
hcp.charge_begin_date late_chg_beginning_date,
xxen_util.meaning(hcp.late_charge_calculation_trx,'AR_MANDATORY_LATE_CHARGES',222) late_chg_calculation,
xxen_util.meaning(hcp.credit_items_flag,'YES_NO',0) late_chg_incl_credit_items,
xxen_util.meaning(hcp.disputed_transactions_flag,'YES_NO',0) late_chg_incl_dispute_items,
hcp.payment_grace_days late_chg_receipt_grace_days,
xxen_util.meaning(hcp.late_charge_type,'AR_LATE_CHARGE_TYPE',222) late_chg_type,
xxen_util.meaning(hcp.charge_on_finance_charge_flag,'AR_FORMULAE',222) late_chg_interest_calc_formula,
hcp.interest_period_days late_chg_interest_period_days,
xxen_util.meaning(hcp.interest_calculation_period,'AR_CALCULATION_PERIOD',222) late_chg_interest_calc_period,
xxen_util.meaning(hcp.hold_charged_invoices_flag,'YES_NO',0) late_chg_hold_charged_invoices,
xxen_util.meaning(hcp.multiple_interest_rates_flag,'YES_NO',0) late_chg_multiple_int_rates,
--
-- profile amounts
--
hcpa.currency_code prof_amt_currency,
hcpa.overall_credit_limit credit_limit,
hcpa.trx_credit_limit order_credit_limit,
hcpa.auto_rec_min_receipt_amount min_receipt_amount,
hcpa.min_statement_amount,
hcpa.min_dunning_amount,
hcpa.min_dunning_invoice_amount,
--
-- Tax Registrations
--
nvl2(zr.registration_id,xxen_util.meaning('ACCOUNT','HZ_CONS_BILL_LEVEL',222),null) tax_reg_assignment_level,
zr.tax_regime_code tax_reg_regime_code,
zr.tax tax_reg_tax,
zr.tax_jurisdiction_code tax_reg_jurisdiction_code,
zr.rep_party_tax_name tax_reg_company_reporting_name,
zr.registration_type_code tax_reg_type,
zr.registration_number tax_reg_number,
zr.registration_status_code tax_reg_status,
xxen_util.meaning(zr.default_registration_flag,'YES_NO',0) tax_reg_default_flag,
(select hl2.location_Code || ':' || ' ' || hl2.address_Line_1 || ' ' || hl2.town_or_city || ' ' || hl2.region_1 from hr_locations hl2 where hl2.location_id = zr.legal_location_id) tax_reg_legal_address,
zr.registration_reason_code tax_reg_reason,
zr.registration_source_code tax_reg_source,
(select hp2.party_name from zx_party_tax_profile zptp, hz_parties hp2 where zptp.party_id = hp2.party_id and zptp.party_type_code ='TAX_AUTHORITY' and zptp.party_tax_profile_id = zr.tax_authority_id) tax_reg_issuing_authority,
zr.effective_from tax_reg_effective_from,
zr.effective_to tax_reg_effective_to,
xxen_util.meaning(zr.rounding_rule_code,'ZX_ROUNDING_RULE',0) tax_reg_rounding_rule,
xxen_util.meaning(zr.inclusive_tax_flag,'YES_NO',0) tax_reg_tax_inclusive,
xxen_util.meaning(zr.self_assess_flag,'YES_NO',0) tax_reg_self_assessment,
--
-- Bank Accounts
--
nvl2(ba.instrument_payment_use_id,xxen_util.meaning('ACCOUNT','HZ_CONS_BILL_LEVEL',222),null) bank_account_assignment_level,
ba.bank_name,
ba.bank_number,
ba.bank_country,
ba.bank_branch_name,
ba.bank_branch_number,
ba.bank_branch_type,
ba.bank_branch_bic,
ba.bank_acct_name,
ba.bank_acct_num,
ba.bank_acct_check_digits,
ba.bank_acct_currency,
ba.bank_acct_iban,
ba.bank_acct_name_alt,
ba.bank_acct_suffix,
ba.bank_acct_type,
ba.bank_acct_sec_reference,
ba.bank_acct_description,
ba.bank_acct_contact,
ba.bank_acct_contact_phone,
ba.bank_acct_contact_fax,
ba.bank_acct_contact_email,
ba.bank_acct_assignmt_start_date,
ba.bank_acct_assignmt_end_date,
--
-- Contacts
--
nvl2(ctct.cust_account_role_id,xxen_util.meaning('ACCOUNT','HZ_CONS_BILL_LEVEL',222),null) contact_assignment_level,
ctct.contact_prefix,
ctct.contact_first_name,
ctct.contact_middle_name,
ctct.contact_last_name,
ctct.contact_suffix,
ctct.contact_title,
ctct.contact_status,
ctct.contact_email,
ctct.contact_phone_country_code,
ctct.contact_phone_area_code,
ctct.contact_phone_number,
ctct.contact_phone_extension,
ctct.contact_phone_type,
ctct.secondary_phone_country_code,
ctct.secondary_phone_area_code,
ctct.secondary_phone_number,
ctct.secondary_phone_extension,
ctct.secondary_phone_type,
ctct.contact_job_title_code,
ctct.contact_job_title,
ctct.contact_number,
ctct.contact_country,
ctct.contact_address_line1,
ctct.contact_address_line2,
ctct.contact_address_line3,
ctct.contact_address_line4,
ctct.contact_city,
ctct.contact_county,
ctct.contact_state,
ctct.contact_postal_code,
ctct.contact_geography_override,
ctct.contact_mailstop,
--
-- Attachments
--
nvl2(attchmt.attachment_id,xxen_util.meaning('ACCOUNT','HZ_CONS_BILL_LEVEL',222),null) attachment_assignment_level,
attchmt.category attachment_category_,
attchmt.title  attachment_title_,
attchmt.description attachment_description_,
attchmt.type attachment_type_,
attchmt.content attachment_content_,
attchmt.file_id attachment_file_id_,
attchmt.seq_num attachment_seq_,
-- ########
-- IDs
-- ########
hp.party_id,
hps.party_site_id,
hl.location_id,
hca.cust_account_id,
hcasa.cust_acct_site_id,
hcsua.site_use_id,
hcp.cust_account_profile_id,
hcpa.cust_acct_profile_amt_id,
ctct.cust_account_role_id,
ctct.pri_phone_contact_point_id,
ctct.sec_phone_contact_point_id,
ba.instrument_payment_use_id,
zr.registration_id,
attchmt.attachment_id,
hcasa.org_id,
gl.chart_of_accounts_id,
hca.account_number acct_num_hidden,
hou.name ou_hidden
from
hz_parties hp,
hz_cust_accounts hca,
hz_cust_acct_sites_all hcasa,
hz_cust_site_uses_all hcsua,
hz_party_sites hps,
hz_locations hl,
hz_customer_profiles hcp,
hz_cust_profile_amts hcpa,
hr_operating_units hou,
gl_ledgers gl,
hz_contact_points hcp1,
hz_contact_points hcp2,
hz_contact_points hcp3,
zx_party_tax_profile zptp0,
zx_party_tax_profile zptp1,
zx_registrations zr,
q_contacts ctct,
q_bank_accounts ba,
q_attachments attchmt
where
2=2 and
nvl(:p_update_level,'ACCOUNT') = 'ACCOUNT' and
hp.party_id = hca.party_id and
nvl2(hca.cust_account_id,-99,-99) = hcasa.cust_account_id (+) and -- dummy join to return null site level values
hcasa.cust_acct_site_id = hcsua.cust_acct_site_id (+) and
hcasa.org_id = hcsua.org_id (+) and
hcasa.party_site_id = hps.party_site_id (+) and
hps.location_id = hl.location_id (+) and
hcasa.org_id = hou.organization_id (+) and
to_number(hou.set_of_books_id) = gl.ledger_id (+) and
--
hca.cust_account_id = hcp.cust_account_id (+) and
nvl(hcp.site_use_id (+),0) = 0 and
decode(:p_update_profile_amts,'Y',hcp.cust_account_profile_id,0) = hcpa.cust_account_profile_id (+) and
--
hps.party_site_id = hcp1.owner_table_id (+) and
hcp1.owner_table_name (+) = 'HZ_PARTY_SITES' and
hcp1.contact_point_type (+) = 'PHONE' and
hcp1.primary_flag (+) = 'Y' and
hcp1.status (+) = 'A' and
hps.party_site_id = hcp2.owner_table_id (+) and
hcp2.owner_table_name (+) = 'HZ_PARTY_SITES' and
hcp2.contact_point_type (+) = 'EMAIL' and
hcp2.primary_flag (+) = 'Y' and
hcp2.status (+) = 'A' and
hps.party_site_id = hcp3.owner_table_id (+) and
hcp3.owner_table_name (+) = 'HZ_PARTY_SITES' and
hcp3.contact_point_type (+) = 'WEB' and
hcp3.primary_flag (+) = 'Y' and
hcp3.status (+) = 'A' and
--
hp.party_id = zptp0.party_id (+) and
zptp0.party_type_code (+) = 'THIRD_PARTY' and
hps.party_site_id = zptp1.party_id (+) and
zptp1.party_type_code (+) = 'THIRD_PARTY_SITE' and
decode(:p_update_tax_registrations,'Y',zptp0.party_tax_profile_id,null) = zr.party_tax_profile_id (+) and
&lp_tax_reg_status_clause
--
decode(:p_update_contacts,'Y',hca.cust_account_id,0) = ctct.cust_account_id (+) and
nvl(ctct.cust_acct_site_id (+),0) = 0 and
&lp_contact_status_clause
--
decode(:p_update_bank_accts,'Y',hca.cust_account_id,0) = ba.cust_account_id (+) and
nvl(ba.site_use_id (+),0) = 0 and
&lp_bank_acct_status_clause
--
decode(:p_update_attachments,'Y','AR_CUSTOMERS',null) = attchmt.entity_name (+) and
decode(:p_update_attachments,'Y',hca.cust_account_id,null) = attchmt.entity_id (+) and
--
-- to only match accounts with sites meeting the site level parameter restrictions
hca.cust_account_id in
(select
 hca.cust_account_id
 from
 hz_parties hp,
 hz_cust_accounts hca,
 hz_cust_acct_sites_all hcasa,
 hz_cust_site_uses_all hcsua,
 hz_party_sites hps,
 hz_locations hl,
 hz_customer_profiles hcp,
 hr_operating_units hou
 where
 1=1 and
 hp.party_id = hca.party_id and
 hca.cust_account_id = hcasa.cust_account_id (+) and
 (hcasa.org_id is null or mo_global.check_access(hcasa.org_id)='Y') and
 hcasa.cust_acct_site_id = hcsua.cust_acct_site_id (+) and
 hcasa.org_id = hcsua.org_id (+) and
 hcasa.party_site_id = hps.party_site_id (+) and
 hps.location_id = hl.location_id (+) and
 hcasa.org_id = hou.organization_id (+)
)
--
union all
--
-- Q2 Site Level
--
select /*+ push_pred(ctct) push_pred(ba) push_pred(attchmt) */
--
-- party
--
xxen_util.meaning(hp.party_type,'PARTY_TYPE',222) party_type,
hp.party_name,
hp.party_number registry_id,
hp.known_as alias,
hp.organization_name_phonetic name_pronunciation,
hp.duns_number,
(select hop.jgzz_fiscal_code from hz_organization_profiles hop where hop.party_id = hp.party_id and hop.effective_end_date is null and rownum=1)  taxpayer_id,
-- party dff
xxen_util.display_flexfield_context(222,'HZ_PARTIES',hp.attribute_category) party_dff_context,
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
 rcrm.site_use_id is null
) acct_primary_receipt_method,
-- tax
xxen_util.meaning(zptp0.process_for_applicability_flag,'YES_NO',0) acct_allow_tax_applicability,
xxen_util.meaning(zptp0.allow_offset_tax_flag,'YES_NO',0) acct_allow_offset_taxes,
xxen_util.meaning(zptp0.self_assess_flag,'YES_NO',0) acct_self_assessment,
xxen_util.meaning(nvl(zptp0.rounding_level_code,decode(hca.tax_header_level_flag,'Y','HEADER','N','LINE',null)),'ZX_ROUNDING_LEVEL',0) acct_tax_rounding_level,
xxen_util.meaning(nvl(zptp0.rounding_rule_code,hca.tax_rounding_rule),'ZX_ROUNDING_RULE',0) acct_tax_rounding_rule,
xxen_util.meaning(zptp0.inclusive_tax_flag,'YES_NO',0) acct_inclusive_tax,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp0.country_code) acct_tax_reporting_country,
zptp0.registration_type_code acct_tax_reporting_reg_type,
zptp0.rep_registration_number acct_tax_reporting_reg_number,
-- cust account dff
xxen_util.display_flexfield_context(222,'RA_CUSTOMERS_HZ',hca.attribute_category) acct_dff_context,
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
--
hcp1.phone_country_code site_phone_country_code,
hcp1.phone_area_code site_phone_area_code,
hcp1.phone_number site_phone_number,
hcp1.phone_extension site_phone_extension,
xxen_util.meaning(hcp1.phone_line_type,'PHONE_LINE_TYPE',222) site_phone_type,
hcp2.email_address site_email_address,
xxen_util.meaning(hcp2.email_format,'EMAIL_FORMAT',222) site_email_format,
xxen_util.meaning(hcp2.contact_point_purpose,'CONTACT_POINT_PURPOSE',222) site_email_purpose,
hcp3.url site_url,
xxen_util.meaning(hcp3.contact_point_purpose,'CONTACT_POINT_PURPOSE_WEB',222) site_url_purpose,
-- party site dff
xxen_util.display_flexfield_context(222,'HZ_PARTY_SITES',hps.attribute_category) site_dff_context,
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
xxen_util.display_flexfield_context(222,'RA_ADDRESSES_HZ',hcasa.attribute_category) acct_site_dff_context,
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
(select nvl(jrret.resource_name,jrs.name) || ' (' || jrs.salesrep_number || ')' from jtf_rs_salesreps jrs, jtf_rs_resource_extns_tl jrret where jrs.resource_id=jrret.resource_id(+) and jrret.language (+) =userenv('lang') and jrs.salesrep_id = hcsua.primary_salesrep_id and jrs.org_id = hcsua.org_id) site_primary_salesperson,
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
 rcrm.site_use_id = hcsua.site_use_id
) site_primary_receipt_method,
-- tax
xxen_util.meaning(zptp1.process_for_applicability_flag,'YES_NO',0) site_allow_tax_applicability,
xxen_util.meaning(zptp1.allow_offset_tax_flag,'YES_NO',0) site_allow_offset_taxes,
xxen_util.meaning(zptp1.self_assess_flag,'YES_NO',0) site_self_assessment,
xxen_util.meaning(nvl(zptp1.rounding_level_code,decode(hcsua.tax_header_level_flag,'Y','HEADER','N','LINE',null)),'ZX_ROUNDING_LEVEL',0) site_tax_rounding_level,
xxen_util.meaning(nvl(zptp1.rounding_rule_code,hcsua.tax_rounding_rule),'ZX_ROUNDING_RULE',0) site_tax_rounding_rule,
xxen_util.meaning(zptp1.inclusive_tax_flag,'YES_NO',0) site_inclusive_tax,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp1.country_code) site_tax_reporting_country,
zptp1.registration_type_code site_tax_reporting_reg_type,
zptp1.rep_registration_number site_tax_reporting_reg_number,
hcsua.tax_reference site_use_tax_registration_num,
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
) site_use_tax_classification,
xxen_util.meaning(hcsua.tax_classification,'ZX_PTPTR_GEO_TYPE_CLASS',0) site_use_tax_geography_type,
-- site use dff
xxen_util.display_flexfield_context(222,'RA_SITE_USES_HZ',hcsua.attribute_category) site_use_dff_context,
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
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE22',hcsua.rowid,hcsua.attribute22) hz_cust_site_use_attribute22,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE23',hcsua.rowid,hcsua.attribute23) hz_cust_site_use_attribute23,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE24',hcsua.rowid,hcsua.attribute24) hz_cust_site_use_attribute24,
xxen_util.display_flexfield_value(222,'RA_SITE_USES_HZ',hcsua.attribute_category,'ATTRIBUTE25',hcsua.rowid,hcsua.attribute25) hz_cust_site_use_attribute25,
--
-- profile
--
nvl2(hcp.cust_account_profile_id,xxen_util.meaning('SITE','HZ_CONS_BILL_LEVEL',222),null) profile_assignment_level,
(select hcpc.name from hz_cust_profile_classes hcpc where hcpc.profile_class_id = hcp.profile_class_id) profile_class,
(select ac.name from ar_collectors ac where ac.collector_id = hcp.collector_id) collector,
xxen_util.meaning(hcp.risk_code,'RISK_CODE',222) risk_code,
xxen_util.meaning(hcp.credit_rating,'CREDIT_RATING',222) credit_rating,
xxen_util.meaning(hcp.credit_classification,'AR_CMGT_CREDIT_CLASSIFICATION',222) credit_classification,
xxen_util.meaning(hcp.review_cycle,'PERIODIC_REVIEW_CYCLE',222) review_cycle,
xxen_util.meaning(hcp.account_status,'ACCOUNT_STATUS',222) credit_status,
hcp.tolerance tolerance_pct,
hcp.percent_collectable collectable_pct,
xxen_util.meaning(hcp.credit_checking,'YES_NO',0) credit_check,
xxen_util.meaning(nvl(hcp.credit_hold,nvl2(hcp.cust_account_profile_id,'N',null)),'YES_NO',0) credit_hold,
(select jrrev.resource_name || ' (' ||  jrrev.source_number || ')' from jtf_rs_resource_extns_vl jrrev where jrrev.resource_id = hcp.credit_analyst_id) credit_analyst,
hcp.last_credit_review_date last_credit_review,
hcp.next_credit_review_date next_credit_review,
xxen_util.meaning(hcp.cons_inv_flag,'YES_NO',0) bal_fwd_billing_enable,
xxen_util.meaning(hcp.cons_bill_level,'HZ_CONS_BILL_LEVEL',222) bal_fwd_billing_level,
xxen_util.meaning(hcp.cons_inv_type,'HZ_CONS_INV_TYPE',222) bal_fwd_billing_type,
(select rtv.name from ra_terms_vl rtv where rtv.term_id = hcp.standard_terms) payment_terms,
hcp.discount_grace_days,
xxen_util.meaning(hcp.override_terms,'YES_NO',0) override_terms,
xxen_util.meaning(hcp.discount_terms,'YES_NO',0) allow_discount,
hcp.clearing_days receipt_clearing_days,
xxen_util.meaning(hcp.lockbox_matching_option,'ARLPLB_MATCHING_OPTION',222) match_receipts_by,
(select aah.hierarchy_name from ar_autocash_hierarchies aah where aah.autocash_hierarchy_id = hcp.autocash_hierarchy_id) automatic_cash_rule_set,
(select aah.hierarchy_name from ar_autocash_hierarchies aah where aah.autocash_hierarchy_id = hcp.autocash_hierarchy_id_for_adr) remainder_rule_set,
(select acarsv.automatch_set_name from ar_cash_auto_rule_sets_vl acarsv where acarsv.automatch_set_id = hcp.automatch_set_id) automatch_rule_set,
xxen_util.meaning(hcp.auto_rec_incl_disputed_flag,'YES_NO',0) incl_disputed_in_auto_receipts,
xxen_util.meaning(hcp.send_statements,'YES_NO',0) send_statements,
(select ascy.name from ar_statement_cycles ascy where ascy.statement_cycle_id = hcp.statement_cycle_id) statement_cycle,
xxen_util.meaning(hcp.credit_balance_statements,'YES_NO',0) send_credit_balance_statements,
xxen_util.meaning(hcp.dunning_letters,'YES_NO',0) send_dunning_letters,
(select adls.name from ar_dunning_letter_sets adls where adls.dunning_letter_set_id = hcp.dunning_letter_set_id) dunning_letter_set,
xxen_util.meaning(hcp.tax_printing_option,'TAX_PRINTING_OPTION',222) inv_tax_printing,
(select rgr.name from ra_grouping_rules rgr where rgr.grouping_rule_id = hcp.grouping_rule_id) inv_grouping_rule,
--
xxen_util.meaning(hcp.interest_charges,'YES_NO',0) enable_late_charges,
hcp.charge_begin_date late_chg_beginning_date,
xxen_util.meaning(hcp.late_charge_calculation_trx,'AR_MANDATORY_LATE_CHARGES',222) late_chg_calculation,
xxen_util.meaning(hcp.credit_items_flag,'YES_NO',0) late_chg_incl_credit_items,
xxen_util.meaning(hcp.disputed_transactions_flag,'YES_NO',0) late_chg_incl_dispute_items,
hcp.payment_grace_days late_chg_receipt_grace_days,
xxen_util.meaning(hcp.late_charge_type,'AR_LATE_CHARGE_TYPE',222) late_chg_type,
xxen_util.meaning(hcp.charge_on_finance_charge_flag,'AR_FORMULAE',222) late_chg_interest_calc_formula,
hcp.interest_period_days late_chg_interest_period_days,
xxen_util.meaning(hcp.interest_calculation_period,'AR_CALCULATION_PERIOD',222) late_chg_interest_calc_period,
xxen_util.meaning(hcp.hold_charged_invoices_flag,'YES_NO',0) late_chg_hold_charged_invoices,
xxen_util.meaning(hcp.multiple_interest_rates_flag,'YES_NO',0) late_chg_multiple_int_rates,
--
-- profile amounts
--
hcpa.currency_code prof_amt_currency,
hcpa.overall_credit_limit credit_limit,
hcpa.trx_credit_limit order_credit_limit,
hcpa.auto_rec_min_receipt_amount min_receipt_amount,
hcpa.min_statement_amount,
hcpa.min_dunning_amount,
hcpa.min_dunning_invoice_amount,
--
-- Tax Registrations
--
nvl2(zr.registration_id,xxen_util.meaning('SITE','HZ_CONS_BILL_LEVEL',222),null) tax_reg_assignment_level,
zr.tax_regime_code tax_reg_regime_code,
zr.tax tax_reg_tax,
zr.tax_jurisdiction_code tax_reg_jurisdiction_code,
zr.rep_party_tax_name tax_reg_company_reporting_name,
zr.registration_type_code tax_reg_type,
zr.registration_number tax_reg_number,
zr.registration_status_code tax_reg_status,
xxen_util.meaning(zr.default_registration_flag,'YES_NO',0) tax_reg_default_flag,
(select hl2.location_Code || ':' || ' ' || hl2.address_Line_1 || ' ' || hl2.town_or_city || ' ' || hl2.region_1 from hr_locations hl2 where hl2.location_id = zr.legal_location_id) tax_reg_legal_address,
zr.registration_reason_code tax_reg_reason,
zr.registration_source_code tax_reg_source,
(select hp2.party_name from zx_party_tax_profile zptp, hz_parties hp2 where zptp.party_id = hp2.party_id and zptp.party_type_code ='TAX_AUTHORITY' and zptp.party_tax_profile_id = zr.tax_authority_id) tax_reg_issuing_authority,
zr.effective_from tax_reg_effective_from,
zr.effective_to tax_reg_effective_to,
xxen_util.meaning(zr.rounding_rule_code,'ZX_ROUNDING_RULE',0) tax_reg_rounding_rule,
xxen_util.meaning(zr.inclusive_tax_flag,'YES_NO',0) tax_reg_tax_inclusive,
xxen_util.meaning(zr.self_assess_flag,'YES_NO',0) tax_reg_self_assessment,
--
-- Bank Accounts
--
nvl2(ba.instrument_payment_use_id,xxen_util.meaning('SITE','HZ_CONS_BILL_LEVEL',222),null) bank_account_assignment_level,
ba.bank_name,
ba.bank_number,
ba.bank_country,
ba.bank_branch_name,
ba.bank_branch_number,
ba.bank_branch_type,
ba.bank_branch_bic,
ba.bank_acct_name,
ba.bank_acct_num,
ba.bank_acct_check_digits,
ba.bank_acct_currency,
ba.bank_acct_iban,
ba.bank_acct_name_alt,
ba.bank_acct_suffix,
ba.bank_acct_type,
ba.bank_acct_sec_reference,
ba.bank_acct_description,
ba.bank_acct_contact,
ba.bank_acct_contact_phone,
ba.bank_acct_contact_fax,
ba.bank_acct_contact_email,
ba.bank_acct_assignmt_start_date,
ba.bank_acct_assignmt_end_date,
--
-- Contacts
--
nvl2(ctct.cust_account_role_id,xxen_util.meaning('SITE','HZ_CONS_BILL_LEVEL',222),null) contact_assignment_level,
ctct.contact_prefix,
ctct.contact_first_name,
ctct.contact_middle_name,
ctct.contact_last_name,
ctct.contact_suffix,
ctct.contact_title,
ctct.contact_status,
ctct.contact_email,
ctct.contact_phone_country_code,
ctct.contact_phone_area_code,
ctct.contact_phone_number,
ctct.contact_phone_extension,
ctct.contact_phone_type,
ctct.secondary_phone_country_code,
ctct.secondary_phone_area_code,
ctct.secondary_phone_number,
ctct.secondary_phone_extension,
ctct.secondary_phone_type,
ctct.contact_job_title_code,
ctct.contact_job_title,
ctct.contact_number,
ctct.contact_country,
ctct.contact_address_line1,
ctct.contact_address_line2,
ctct.contact_address_line3,
ctct.contact_address_line4,
ctct.contact_city,
ctct.contact_county,
ctct.contact_state,
ctct.contact_postal_code,
ctct.contact_geography_override,
ctct.contact_mailstop,
--
-- Attachments
--
nvl2(attchmt.attachment_id,xxen_util.meaning('SITE','HZ_CONS_BILL_LEVEL',222),null) attachment_assignment_level,
attchmt.category attachment_category_,
attchmt.title  attachment_title_,
attchmt.description attachment_description_,
attchmt.type attachment_type_,
attchmt.content attachment_content_,
attchmt.file_id attachment_file_id_,
attchmt.seq_num attachment_seq_,
-- ########
-- IDs
-- ########
hp.party_id,
hps.party_site_id,
hl.location_id,
hca.cust_account_id,
hcasa.cust_acct_site_id,
hcsua.site_use_id,
hcp.cust_account_profile_id,
hcpa.cust_acct_profile_amt_id,
ctct.cust_account_role_id,
ctct.pri_phone_contact_point_id,
ctct.sec_phone_contact_point_id,
ba.instrument_payment_use_id,
zr.registration_id,
attchmt.attachment_id,
hcasa.org_id,
gl.chart_of_accounts_id,
hca.account_number acct_num_hidden,
hou.name ou_hidden
from
hz_parties hp,
hz_cust_accounts hca,
hz_cust_acct_sites_all hcasa,
hz_cust_site_uses_all hcsua,
hz_party_sites hps,
hz_locations hl,
hz_customer_profiles hcp,
hz_cust_profile_amts hcpa,
hr_operating_units hou,
gl_ledgers gl,
hz_contact_points hcp1,
hz_contact_points hcp2,
hz_contact_points hcp3,
zx_party_tax_profile zptp0,
zx_party_tax_profile zptp1,
zx_registrations zr,
q_contacts ctct,
q_bank_accounts ba,
q_attachments attchmt
where
1=1 and
2=2 and
nvl(:p_update_level,'SITE') = 'SITE' and
hp.party_id = hca.party_id and
hca.cust_account_id = hcasa.cust_account_id and
(hcasa.org_id is null or mo_global.check_access(hcasa.org_id)='Y') and
hcasa.party_site_id = hps.party_site_id  and
hp.party_id = hps.party_id and
hcasa.org_id = hou.organization_id and
to_number(hou.set_of_books_id) = gl.ledger_id and
decode(:p_update_site_uses,'Y',hcasa.cust_acct_site_id,null) = hcsua.cust_acct_site_id (+) and
decode(:p_update_site_uses,'Y',hcasa.org_id,null) = hcsua.org_id (+) and
hps.location_id = hl.location_id (+) and
--
case when hcsua.site_use_code in ('BILL_TO','DUN','STMTS') and hcsua.status = 'A' then hcsua.site_use_id else null end = hcp.site_use_id (+) and
nvl(hcp.status,'A') = 'A' and
decode(:p_update_profile_amts,'Y',hcp.cust_account_profile_id,0) = hcpa.cust_account_profile_id (+) and
--
hps.party_site_id = hcp1.owner_table_id (+) and
hcp1.owner_table_name (+) = 'HZ_PARTY_SITES' and
hcp1.contact_point_type (+) = 'PHONE' and
hcp1.primary_flag (+) = 'Y' and
hcp1.status (+) = 'A' and
hps.party_site_id = hcp2.owner_table_id (+) and
hcp2.owner_table_name (+) = 'HZ_PARTY_SITES' and
hcp2.contact_point_type (+) = 'EMAIL' and
hcp2.primary_flag (+) = 'Y' and
hcp2.status (+) = 'A' and
hps.party_site_id = hcp3.owner_table_id (+) and
hcp3.owner_table_name (+) = 'HZ_PARTY_SITES' and
hcp3.contact_point_type (+) = 'WEB' and
hcp3.primary_flag (+) = 'Y' and
hcp3.status (+) = 'A' and
--
hp.party_id = zptp0.party_id (+) and
zptp0.party_type_code (+) = 'THIRD_PARTY' and
hps.party_site_id = zptp1.party_id (+) and
zptp1.party_type_code (+) = 'THIRD_PARTY_SITE' and
decode(:p_update_tax_registrations,'Y',zptp1.party_tax_profile_id,null) = zr.party_tax_profile_id (+) and
&lp_tax_reg_status_clause
--
decode(:p_update_contacts,'Y',hcasa.cust_account_id,0) = ctct.cust_account_id (+) and
decode(:p_update_contacts,'Y',hcasa.cust_acct_site_id,0) = ctct.cust_acct_site_id (+) and
&lp_contact_status_clause
--
decode(:p_update_bank_accts,'Y',hcsua.site_use_id,0) = ba.site_use_id (+) and
&lp_bank_acct_status_clause
--
decode(:p_update_attachments,'Y','PER_ADDRESSES',null) = attchmt.entity_name (+) and
decode(:p_update_attachments,'Y',hcasa.cust_acct_site_id,null) = attchmt.entity_id (+)
--
) x
where
:p_upload_mode like '%' || xxen_upload.action_update and
nvl(:p_dflt_ou,'?') = nvl(:p_dflt_ou,'?') and
nvl(:p_dflt_profile_class,'?') = nvl(:p_dflt_profile_class,'?')
--
&not_use_first_block
&report_table_select
&report_table_name
&report_table_where_clause
&success_query1
&success_query2
&processed_run
) y
order by
y.party_name,
y.registry_id,
y.acct_number,
nvl2(y.operating_unit,2,1),
y.operating_unit,
y.country,
y.address_line1,
y.site_number,
y.site_use_purpose,
y.site_use_location,
y.prof_amt_currency,
y.tax_reg_regime_code,
y.bank_name,
y.bank_number,
y.bank_branch_name,
y.bank_branch_number,
y.bank_acct_name,
y.bank_acct_num,
y.contact_last_name,
y.contact_first_name,
y.contact_prefix,
y.attachment_seq_