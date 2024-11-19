/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Customers and Sites
-- Description: Master data report of customer master data including address, sites, site uses, payment terms, Salesperson, price list and other profile information.
-- Excel Examle Output: https://www.enginatics.com/example/ar-customers-and-sites/
-- Library Link: https://www.enginatics.com/reports/ar-customers-and-sites/
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
 case when hcar.status='A' AND hr.status='A' then 'A' else 'I' end status,
 xxen_util.meaning(case when hcar.status='A' AND hr.status='A' then 'A' else 'I' end,'HZ_CPUI_REGISTRY_STATUS',222) contact_status,
 hprel.email_address contact_email,
 hprel.primary_phone_country_code contact_phone_country_code,
 hprel.primary_phone_area_code contact_phone_area_code,
 hprel.primary_phone_number contact_phone_number,
 hprel.primary_phone_extension contact_phone_extension,
 xxen_util.meaning(hprel.primary_phone_line_type,'PHONE_LINE_TYPE',222) contact_phone_type,
 hcp.phone_country_code contact_sec_phone_country_code,
 hcp.phone_area_code contact_sec_area_code,
 hcp.phone_number contact_sec_phone_number,
 hcp.phone_extension contact_sec_phone_extension,
 xxen_util.meaning(hcp.phone_line_type,'PHONE_LINE_TYPE',222) contact_sec_phone_type,
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
 hps.mailstop contact_mailstop,
 (select distinct listagg(xxen_util.meaning(hrr.responsibility_type,'SITE_USE_CODE',222),', ') within group (order by xxen_util.meaning(hrr.responsibility_type,'SITE_USE_CODE',222)) from hz_role_responsibility hrr where hrr.cust_account_role_id = hcar.cust_account_role_id) contact_roles
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
 iepa.party_id                     party_id,
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
 xxen_util.meaning(ieba.foreign_payment_use_flag,'YES_NO',0)  bank_acct_allow_foreign,
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
),
q_zx_registrations as
(
 select
 xxen_util.meaning(nvl2(hps.party_site_id,'SITE','ACCOUNT'),'HZ_CONS_BILL_LEVEL',222) assign_level,
 nvl(hps.party_id,hp.party_id) party_id,
 hps.party_site_id,
 zr.*
 from
 zx_registrations zr,
 zx_party_tax_profile zptp,
 hz_parties hp,
 hz_party_sites hps
 where
 decode(zptp.party_type_code,'THIRD_PARTY',zptp.party_id,null) = hp.party_id (+) and
 decode(zptp.party_type_code,'THIRD_PARTY_SITE',zptp.party_id,null) = hps.party_site_id (+) and
 zptp.party_tax_profile_id = zr.party_tax_profile_id
)
--
-- Main query starts here
--
select /*+ push_pred(ctct) push_pred(ba) */
x.operating_unit,
x.party_type,
x.party_name,
x.party_number,
x.party_tax_registration_number,
x.taxpayer_id,
x.url,
x.duns_number,
x.sic_code,
x.category,
x.account_number,
x.account_description,
x.reference,
x.site_reference,
x.site_use_reference,
x.account_type,
x.classification,
x.sales_channel,
x.primary_salesrep,
x.site_primary_salesrep,
x.order_type,
x.site_order_type,
x.price_list,
x.site_price_list,
x.location,
x.site_name,
x.site_number,
x.site_name address_description,
x.country,
x.address,
x.address1,
x.address2,
x.address3,
x.address4,
x.city,
x.county,
x.state,
x.province,
x.postal_code,
x.addressee,
x.identifying_address_flag,
x.site_use,
x.site_tax_registration_number,
x.primary_flag,
x.ship_partial,
&column_trx_count
x.latest_trx_date,
x.pay_sched_last_update_date,
x.demand_class,
x.ship_sets,
x.party_status,
x.party_site_status,
x.account_status,
x.site_status,
x.site_use_status,
x.warehouse,
x.site_warehouse,
x.free_on_board,
x.site_free_on_board,
x.freight_term,
x.site_freight_term,
x.ship_method,
x.site_ship_method,
-- Accounts
x.receivables_account,
x.revenue_account,
x.tax_account,
x.freight_account,
x.clearing_account,
x.unbilled_rec_account,
x.unearned_rec_account,
x.receivables_account_desc,
x.revenue_account_desc,
x.tax_account_desc,
x.freight_account_desc,
x.clearing_account_desc,
x.unbilled_rec_account_desc,
x.unearned_rec_account_desc,
-- dff
&dff_columns2
-- regional dffs
&jg_dff_columns
-- Profile Class
x.profile_level,
x.profile_class,
x.site_profile_class,
x.credit_classification,
x.site_credit_classification,
x.payment_term,
x.site_payment_term,
x.send_statement,
x.site_send_statement,
x.statement_cycle,
x.site_statement_cycle,
x.send_credit_balance,
x.site_send_credit_balance,
x.send_dunning_letters,
x.site_send_dunning_letters,
x.dunning_letter,
x.site_dunning_letter,
x.collector_name,
x.site_collector_name,
x.credit_class_code,
x.site_credit_class_code,
-- profile amounts
hcpa.currency_code prof_amt_currency,
hcpa.overall_credit_limit credit_limit,
hcpa.trx_credit_limit order_credit_limit,
hcpa.auto_rec_min_receipt_amount min_receipt_amount,
hcpa.min_statement_amount,
hcpa.min_dunning_amount,
hcpa.min_dunning_invoice_amount,
-- tax profile
xxen_util.meaning(zptp1.process_for_applicability_flag,'YES_NO',0) allow_tax_applicability,
xxen_util.meaning(zptp1.allow_offset_tax_flag,'YES_NO',0) allow_offset_taxes,
xxen_util.meaning(zptp1.self_assess_flag,'YES_NO',0) self_assessment,
xxen_util.meaning(nvl(zptp1.rounding_level_code,decode(x.tax_header_level_flag,'Y','HEADER','N','LINE',null)),'ZX_ROUNDING_LEVEL',0) tax_rounding_level,
xxen_util.meaning(nvl(zptp1.rounding_rule_code,x.tax_rounding_rule),'ZX_ROUNDING_RULE',0) tax_rounding_rule,
xxen_util.meaning(zptp1.inclusive_tax_flag,'YES_NO',0) inclusive_tax,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp1.country_code) tax_reporting_country,
zptp1.registration_type_code tax_reporting_reg_type,
zptp1.rep_registration_number tax_reporting_reg_number,
xxen_util.meaning(zptp2.process_for_applicability_flag,'YES_NO',0) site_allow_tax_applicability,
xxen_util.meaning(zptp2.allow_offset_tax_flag,'YES_NO',0) site_allow_offset_taxes,
xxen_util.meaning(zptp2.self_assess_flag,'YES_NO',0) site_self_assessment,
xxen_util.meaning(nvl(zptp2.rounding_level_code,decode(x.site_tax_header_level_flag,'Y','HEADER','N','LINE',null)),'ZX_ROUNDING_LEVEL',0) site_tax_rounding_level,
xxen_util.meaning(nvl(zptp2.rounding_rule_code,x.site_tax_rounding_rule),'ZX_ROUNDING_RULE',0) site_tax_rounding_rule,
xxen_util.meaning(zptp1.inclusive_tax_flag,'YES_NO',0) site_inclusive_tax,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp2.country_code) site_tax_reporting_country,
zptp2.registration_type_code site_tax_reporting_reg_type,
zptp2.rep_registration_number site_tax_reporting_reg_number,
(select
 zocv.meaning
 from
 zx_output_classifications_v zocv
 where
 zocv.lookup_code = nvl(zptp2.tax_classification_code,x.site_tax_code) and
 zocv.org_id in (x.org_id,-99) and
 rownum <= 1
) site_tax_classification,
-- Tax Registrations
zr.assign_level tax_reg_assign_level,
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
-- Receipt Methods
nvl2(rcrm.receipt_method_id,xxen_util.meaning(nvl2(rcrm.site_use_id,'SITE','ACCOUNT'),'HZ_CONS_BILL_LEVEL',222),null) receipt_method_assign_level,
arm.name receipt_method,
xxen_util.meaning(rcrm.primary_flag,'YES_NO',0) receipt_method_primary_flag,
rcrm.start_date receipt_method_start,
rcrm.end_date receipt_method_end,
-- Bank Accounts
nvl2(ba.instrument_payment_use_id,xxen_util.meaning(nvl2(ba.site_use_id,'SITE','ACCOUNT'),'HZ_CONS_BILL_LEVEL',222),null) bank_account_assign_level,
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
-- Debit Authorizations
ida.alternate_name debit_auth_alternate_name,
ida.priority debit_auth_priority,
xxen_util.meaning(ida.debit_auth_flag,'YES_NO',0) debit_auth_payer_granted,
ida.authorization_reference_number debit_auth_unique_reference_id,
ida.creditor_le_name debit_auth_payee,
ida.creditor_identifier debit_auth_payee_identifier,
xxen_util.meaning(ida.payment_type_code,'IBY_DEBIT_AUTH_TRXN_TYPE',0) debit_auth_type,
xxen_util.meaning(ida.debit_auth_frequency,'IBY_DEBIT_AUTH_TRXN_TYPE',0) debit_auth_frequency,
nvl2(ida.debit_authorization_id,xxen_util.meaning(case when nvl(ida.debit_auth_end,sysdate+1) > sysdate and nvl(ida.auth_cancel_date,sysdate+1) > sysdate then 'A' else 'I' end,'HZ_CPUI_REGISTRY_STATUS',222),null) debit_auth_status,
ida.debit_auth_method debit_auth_method,
ida.debit_auth_reference debit_auth_reference,
xxen_util.meaning(ida.pre_notification_required_flag,'YES_NO',0) debit_auth_pre_notif_req,
ida.auth_sign_date debit_auth_signing_date,
ida.debit_auth_begin debit_auth_begin_date,
ida.debit_auth_end debit_auth_end_date,
ida.debit_auth_fnl_colltn_date debit_auth_final_collect_date,
ida.auth_cancel_date debit_auth_cancel_date,
ida.amendment_reason_code debit_auth_amendment_code,
xxen_util.meaning(ida.amendment_reason_code,'IBY_DEBIT_AUTH_AMEND_REASON',0) debit_auth_amendment_reason,
ida.authorization_revision_number debit_auth_version,
ida.direct_debit_count debit_auth_trx_count,
-- Contacts
nvl2(ctct.cust_account_role_id,xxen_util.meaning(nvl2(ctct.cust_acct_site_id,'SITE','ACCOUNT'),'HZ_CONS_BILL_LEVEL',222),null) contact_assign_level,
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
ctct.contact_sec_phone_country_code,
ctct.contact_sec_area_code,
ctct.contact_sec_phone_number,
ctct.contact_sec_phone_extension,
ctct.contact_sec_phone_type,
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
ctct.contact_roles,
-- audit
x.created_by,
x.creation_date,
x.last_updated_by,
x.last_update_date,
x.account_created_by,
x.account_creation_date,
x.account_last_updated_by,
x.account_last_update_date,
x.site_created_by,
x.site_creation_date,
x.site_last_updated_by,
x.site_last_update_date,
x.profile_created_by,
x.profile_creation_date,
x.profile_last_updated_by,
x.profile_last_update_date,
x.site_profile_created_by,
x.site_profile_creation_date,
x.site_profile_last_updated_by,
x.site_profile_last_update_date,
xxen_util.user_name(hcpa.created_by) profile_amt_created_by,
xxen_util.client_time(hcpa.creation_date) profile_amt_creation_date,
xxen_util.user_name(hcpa.last_updated_by) profile_amt_last_updated_by,
xxen_util.client_time(hcpa.last_update_date) profile_amt_last_update_date,
x.org_id,
x.cust_account_profile_id,
x.site_cust_account_profile_id,
x.cust_account_id,
x.site_use_id
from
(
select
hou.name operating_unit,
initcap(hp.party_type) party_type,
hp.party_name,
hp.party_number,
hp.url,
hp.duns_number,
decode(hp.party_type,'ORGANIZATION',hp.sic_code) sic_code,
(select xxen_util.meaning(hcas.class_code,'CUSTOMER_CATEGORY',222) from hz_code_assignments hcas where hcas.owner_table_name='HZ_PARTIES' and hcas.class_category='CUSTOMER_CATEGORY' and hcas.primary_flag='Y' and hcas.owner_table_id = hp.party_id and rownum <= 1) category,
hca.account_number,
hca.account_name account_description,
hca.orig_system_reference reference,
hcasa.orig_system_reference site_reference,
hcsua.orig_system_reference site_use_reference,
decode(hca.customer_type,'R','External','I','Internal') account_type,
xxen_util.meaning(hca.customer_class_code,'CUSTOMER CLASS',222) classification,
xxen_util.meaning(hca.sales_channel_code,'SALES_CHANNEL',660) sales_channel,
(select
 nvl(jrret.resource_name,jrs.name)
 from
 jtf_rs_salesreps jrs,
 jtf_rs_resource_extns_tl jrret
 where
 jrs.resource_id=jrret.resource_id and
 hca.primary_salesrep_id=jrs.salesrep_id and
 hcsua.org_id=jrs.org_id and
 jrret.language=userenv('lang') and
 jrret.category in ('EMPLOYEE','OTHER','PARTY','PARTNER','SUPPLIER_CONTACT') and
 rownum <= 1
) primary_salesrep,
(select
 nvl(jrret.resource_name,jrs.name)
 from
 jtf_rs_salesreps jrs,
 jtf_rs_resource_extns_tl jrret
 where
 jrs.resource_id=jrret.resource_id and
 hcsua.primary_salesrep_id=jrs.salesrep_id and
 hcsua.org_id=jrs.org_id and
 jrret.language=userenv('lang') and
 jrret.category in ('EMPLOYEE','OTHER','PARTY','PARTNER','SUPPLIER_CONTACT')
) site_primary_salesrep,
(select ottt.name from oe_transaction_types_tl ottt where hca.order_type_id=ottt.transaction_type_id and ottt.language = userenv('lang')) order_type,
(select ottt.name from oe_transaction_types_tl ottt where hcsua.order_type_id=ottt.transaction_type_id and ottt.language = userenv('lang')) site_order_type,
(select qlht.name from qp_list_headers_tl qlht where hca.price_list_id=qlht.list_header_id and qlht.language=userenv('lang')) price_list,
(select qlht.name from qp_list_headers_tl qlht where hcsua.price_list_id=qlht.list_header_id and qlht.language=userenv('lang')) site_price_list,
hcsua.location,
hps.party_site_name site_name,
hps.party_site_number site_number,
ftt.territory_short_name country,
hz_format_pub.format_address (hps.location_id,null,null,' , ') address,
hl.address1,
hl.address2,
hl.address3,
hl.address4,
hl.city,
hl.county,
hl.state,
hl.province,
hl.postal_code,
hps.addressee,
xxen_util.meaning(decode(hps.identifying_address_flag,'Y','Y'),'YES_NO',0) identifying_address_flag,
xxen_util.meaning(hcsua.site_use_code,'SITE_USE_CODE',222) site_use,
xxen_util.meaning(hcsua.primary_flag,'YES_NO',0) primary_flag,
xxen_util.meaning(hcsua.ship_partial,'YES_NO',0) ship_partial,
hp.jgzz_fiscal_code taxpayer_id,
hp.tax_reference party_tax_registration_number,
hcsua.tax_reference site_tax_registration_number,
hca.tax_code tax_code,
hcsua.tax_code site_tax_code,
hca.tax_header_level_flag,
hca.tax_rounding_rule,
hcsua.tax_header_level_flag site_tax_header_level_flag,
hcsua.tax_rounding_rule site_tax_rounding_rule,
coalesce(
(select max(rcta.trx_date) from ra_customer_trx_all rcta where rcta.bill_to_customer_id = hca.cust_account_id and rcta.bill_to_site_use_id = nvl(hcsua.site_use_id,rcta.bill_to_site_use_id) and :detail_level != 'Site'),
(select max(rcta.trx_date) from ra_customer_trx_all rcta where rcta.ship_to_customer_id = hca.cust_account_id and rcta.ship_to_site_use_id = nvl(hcsua.site_use_id,rcta.ship_to_site_use_id) and :detail_level != 'Site'),
(select max(rcta.trx_date) from ra_customer_trx_all rcta, hz_cust_site_uses_all hcsua2 where rcta.ship_to_customer_id = hca.cust_account_id and rcta.bill_to_site_use_id = hcsua2.site_use_id and hcsua2.cust_acct_site_id = hcasa.cust_acct_site_id and :detail_level = 'Site'),
(select max(rcta.trx_date) from ra_customer_trx_all rcta, hz_cust_site_uses_all hcsua2 where rcta.ship_to_customer_id = hca.cust_account_id and rcta.ship_to_site_use_id = hcsua2.site_use_id and hcsua2.cust_acct_site_id = hcasa.cust_acct_site_id and :detail_level = 'Site')
) latest_trx_date,
coalesce(
(select max(xxen_util.client_time(apsa.last_update_date)) from ar_payment_schedules_all apsa where apsa.customer_id = hca.cust_account_id and apsa.customer_site_use_id = nvl(hcsua.site_use_id,apsa.customer_site_use_id) and :detail_level != 'Site'),
(select max(xxen_util.client_time(apsa.last_update_date)) from ar_payment_schedules_all apsa, ra_customer_trx_all rcta where apsa.customer_trx_id = rcta.customer_trx_id and rcta.ship_to_customer_id = hca.cust_account_id and rcta.ship_to_site_use_id = nvl(hcsua.site_use_id,rcta.ship_to_site_use_id) and :detail_level != 'Site'),
(select max(xxen_util.client_time(apsa.last_update_date)) from ar_payment_schedules_all apsa, hz_cust_site_uses_all hcsua2 where apsa.customer_id = hca.cust_account_id and apsa.customer_site_use_id = hcsua2.site_use_id and hcsua2.cust_acct_site_id = hcasa.cust_acct_site_id and :detail_level = 'Site'),
(select max(xxen_util.client_time(apsa.last_update_date)) from ar_payment_schedules_all apsa, ra_customer_trx_all rcta, hz_cust_site_uses_all hcsua2 where apsa.customer_trx_id = rcta.customer_trx_id and rcta.ship_to_customer_id = hca.cust_account_id and rcta.ship_to_site_use_id = hcsua2.site_use_id and hcsua2.cust_acct_site_id = hcasa.cust_acct_site_id and :detail_level = 'Site')
) pay_sched_last_update_date,
xxen_util.meaning(hcsua.demand_class_code,'DEMAND_CLASS',3) demand_class,
xxen_util.meaning(hcsua.ship_sets_include_lines_flag,'YES_NO',0) ship_sets,
decode(hp.status,'A','Active','I','Inactive','D','Deleted') party_status,
decode(hps.status,'A','Active','I','Inactive','D','Deleted') party_site_status,
decode(hca.status,'A','Active','I','Inactive','D','Deleted') account_status,
decode(hcasa.status,'A','Active','I','Inactive','D','Deleted') site_status,
decode(hcsua.status,'A','Active','I','Inactive','D','Deleted') site_use_status,
haouv1.name warehouse,
haouv2.name site_warehouse,
xxen_util.meaning(hca.fob_point,'FOB',222) free_on_board,
xxen_util.meaning(hcsua.fob_point,'FOB',222) site_free_on_board,
xxen_util.meaning(hca.freight_term,'FREIGHT_TERMS',660) freight_term,
xxen_util.meaning(hcsua.freight_term,'FREIGHT_TERMS',660) site_freight_term,
xxen_util.meaning(hca.ship_via,'SHIP_METHOD',3) ship_method,
xxen_util.meaning(hcsua.ship_via,'SHIP_METHOD',3) site_ship_method,
-- Accounts
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_rec is not null then xxen_util.concatenated_segments(hcsua.gl_id_rec) end receivables_account,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_rev is not null then xxen_util.concatenated_segments(hcsua.gl_id_rev) end revenue_account,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_tax is not null then xxen_util.concatenated_segments(hcsua.gl_id_tax) end tax_account,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_freight is not null then xxen_util.concatenated_segments(hcsua.gl_id_freight) end freight_account,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_clearing is not null then xxen_util.concatenated_segments(hcsua.gl_id_clearing) end clearing_account,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_unbilled is not null then xxen_util.concatenated_segments(hcsua.gl_id_unbilled) end unbilled_rec_account,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_unearned is not null then xxen_util.concatenated_segments(hcsua.gl_id_unearned) end unearned_rec_account,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_rec is not null then xxen_util.segments_description(hcsua.gl_id_rec,gsob.chart_of_accounts_id,101,'GL#') end receivables_account_desc,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_rev is not null then xxen_util.segments_description(hcsua.gl_id_rec,gsob.chart_of_accounts_id,101,'GL#') end revenue_account_desc,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_tax is not null then xxen_util.segments_description(hcsua.gl_id_rec,gsob.chart_of_accounts_id,101,'GL#') end tax_account_desc,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_freight is not null then xxen_util.segments_description(hcsua.gl_id_rec,gsob.chart_of_accounts_id,101,'GL#') end freight_account_desc,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_clearing is not null then xxen_util.segments_description(hcsua.gl_id_rec,gsob.chart_of_accounts_id,101,'GL#') end clearing_account_desc,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_unbilled is not null then xxen_util.segments_description(hcsua.gl_id_rec,gsob.chart_of_accounts_id,101,'GL#') end unbilled_rec_account_desc,
case when hcsua.site_use_code = 'BILL_TO' and hcsua.gl_id_unearned is not null then xxen_util.segments_description(hcsua.gl_id_rec,gsob.chart_of_accounts_id,101,'GL#') end unearned_rec_account_desc,
-- dff
&dff_columns
-- Profile Class
xxen_util.meaning(nvl2(hcp2.cust_account_profile_id,'SITE',nvl2(hcp1.cust_account_profile_id,'ACCOUNT',null)),'HZ_CONS_BILL_LEVEL',222) profile_level,
hcpc1.name profile_class,
hcpc2.name site_profile_class,
xxen_util.meaning(hcpc1.credit_classification,'AR_CMGT_CREDIT_CLASSIFICATION',222) credit_classification,
xxen_util.meaning(hcpc2.credit_classification,'AR_CMGT_CREDIT_CLASSIFICATION',222) site_credit_classification,
(select rtt.name from ra_terms_tl rtt where nvl(hcp1.standard_terms,hca.payment_term_id)=rtt.term_id and rtt.language=userenv('lang')) payment_term,
(select rtt.name from ra_terms_tl rtt where nvl(hcp2.standard_terms,hcsua.payment_term_id)=rtt.term_id and rtt.language=userenv('lang')) site_payment_term,
xxen_util.meaning(hcp1.send_statements,'YES_NO',0) send_statement,
xxen_util.meaning(hcp2.send_statements,'YES_NO',0) site_send_statement,
(select ascl.name from ar_statement_cycles ascl where hcp1.statement_cycle_id=ascl.statement_cycle_id) statement_cycle,
(select ascl.name from ar_statement_cycles ascl where hcp2.statement_cycle_id=ascl.statement_cycle_id) site_statement_cycle,
xxen_util.meaning(hcp1.credit_balance_statements,'YES_NO',0) send_credit_balance,
xxen_util.meaning(hcp2.credit_balance_statements,'YES_NO',0) site_send_credit_balance,
xxen_util.meaning(hcp1.dunning_letters,'YES_NO',0) send_dunning_letters,
xxen_util.meaning(hcp2.dunning_letters,'YES_NO',0) site_send_dunning_letters,
(select adls.name from ar_dunning_letter_sets adls where hcp1.dunning_letter_set_id=adls.dunning_letter_set_id) dunning_letter,
(select adls.name from ar_dunning_letter_sets adls where hcp2.dunning_letter_set_id=adls.dunning_letter_set_id) site_dunning_letter,
(select ac.name from ar_collectors ac where hcp1.collector_id=ac.collector_id) collector_name,
(select ac.name from ar_collectors ac where hcp2.collector_id=ac.collector_id) site_collector_name,
hcp1.credit_classification credit_class_code,
hcp2.credit_classification site_credit_class_code,
-- audit
xxen_util.user_name(hp.created_by) created_by,
xxen_util.client_time(hp.creation_date) creation_date,
xxen_util.user_name(hp.last_updated_by) last_updated_by,
xxen_util.client_time(hp.last_update_date) last_update_date,
xxen_util.user_name(hca.created_by) account_created_by,
xxen_util.client_time(hca.creation_date) account_creation_date,
xxen_util.user_name(hca.last_updated_by) account_last_updated_by,
xxen_util.client_time(hca.last_update_date) account_last_update_date,
xxen_util.user_name(hcasa.created_by) site_created_by,
xxen_util.client_time(hcasa.creation_date) site_creation_date,
xxen_util.user_name(hcasa.last_updated_by) site_last_updated_by,
xxen_util.client_time(hcasa.last_update_date) site_last_update_date,
xxen_util.user_name(hcp1.created_by) profile_created_by,
xxen_util.client_time(hcp1.creation_date) profile_creation_date,
xxen_util.user_name(hcp1.last_updated_by) profile_last_updated_by,
xxen_util.client_time(hcp1.last_update_date) profile_last_update_date,
xxen_util.user_name(hcp2.created_by) site_profile_created_by,
xxen_util.client_time(hcp2.creation_date) site_profile_creation_date,
xxen_util.user_name(hcp2.last_updated_by) site_profile_last_updated_by,
xxen_util.client_time(hcp2.last_update_date) site_profile_last_update_date,
nvl(hcsua.org_id,hcasa.org_id) org_id,
hcp1.cust_account_profile_id,
hcp2.cust_account_profile_id site_cust_account_profile_id,
nvl(hcp2.cust_account_profile_id,hcp1.cust_account_profile_id) prof_amt_profile_id,
hp.party_id,
hca.cust_account_id,
hcsua.site_use_id,
hou.set_of_books_id,
hcasa.cust_acct_site_id,
hps.party_site_id,
-- for the regional dffs
hp.global_attribute_category hp_global_att_cat,
hps.global_attribute_category hps_global_att_cat,
hca.global_attribute_category hca_global_att_cat,
hcasa.global_attribute_category hcasa_global_att_cat,
hcsua.global_attribute_category hcsua_global_att_cat,
hp.rowid hp_rowid,
hps.rowid hps_rowid,
hca.rowid hca_rowid,
hcasa.rowid hcasa_rowid,
hcsua.rowid hcsua_rowid
from
hr_operating_units hou,
gl_sets_of_books gsob,
hz_parties hp,
hz_cust_accounts hca,
(select hcasa.* from hz_cust_acct_sites_all hcasa where :detail_level in ('Site','Site Use')) hcasa,
hz_party_sites hps,
hz_locations hl,
fnd_territories_tl ftt,
(select hcsua.* from hz_cust_site_uses_all hcsua where :detail_level='Site Use') hcsua,
(select hcp.* from hz_customer_profiles hcp where hcp.site_use_id is null) hcp1,
(select hcp.* from hz_customer_profiles hcp where hcp.site_use_id is not null and :detail_level='Site Use') hcp2,
hz_cust_profile_classes hcpc1,
hz_cust_profile_classes hcpc2,
hr_all_organization_units_vl haouv1,
hr_all_organization_units_vl haouv2
where
1=1 and
(hcasa.org_id is null or hcasa.org_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)) and
hp.party_id=hca.party_id and
hca.cust_account_id=hcasa.cust_account_id(+) and
hcasa.org_id=hou.organization_id(+) and
to_number(hou.set_of_books_id)=gsob.set_of_books_id(+) and
hcasa.party_site_id=hps.party_site_id(+) and
hps.location_id=hl.location_id(+) and
hl.country=ftt.territory_code(+) and
ftt.language(+)=userenv('lang') and
hcasa.cust_acct_site_id=hcsua.cust_acct_site_id(+) and
hca.cust_account_id=hcp1.cust_account_id(+) and
nvl(hcp1.site_use_id (+),0) = 0 and
hcsua.site_use_id=hcp2.site_use_id(+) and
hcp1.profile_class_id=hcpc1.profile_class_id(+) and
hcp2.profile_class_id=hcpc2.profile_class_id(+) and
hca.warehouse_id=haouv1.organization_id(+) and
hcsua.warehouse_id=haouv2.organization_id(+)
) x,
hz_cust_profile_amts hcpa,
zx_party_tax_profile zptp1,
zx_party_tax_profile zptp2,
q_zx_registrations zr,
ra_cust_receipt_methods rcrm,
ar_receipt_methods arm,
q_bank_accounts ba,
iby_debit_authorizations ida,
q_contacts ctct
where
x.party_id=zptp1.party_id(+) and
zptp1.party_type_code(+)='THIRD_PARTY' and
x.party_site_id=zptp2.party_id(+) and
zptp2.party_type_code(+)='THIRD_PARTY_SITE' and
nvl2(:show_tax_registrations,x.party_id,null) = zr.party_id (+) and
nvl(x.party_site_id,-99) = nvl(zr.party_site_id (+),nvl(x.party_site_id,-99)) and
(:show_tax_registrations = 'Y' or
 zr.party_tax_profile_id is null or
 trunc(sysdate) between nvl(zr.effective_from,trunc(sysdate)) and nvl(zr.effective_to,trunc(sysdate))
) and
--
nvl2(:show_profile_amts,x.prof_amt_profile_id,null) = hcpa.cust_account_profile_id (+) and
--
nvl2(:show_receipt_methods,x.cust_account_id,0) = rcrm.customer_id (+) and
nvl(x.site_use_id,-99) = nvl(rcrm.site_use_id (+),nvl(x.site_use_id,-99)) and
rcrm.receipt_method_id = arm.receipt_method_id (+) and
(:show_receipt_methods = 'Y' or
 rcrm.receipt_method_id is null or
 trunc(sysdate) between nvl(rcrm.start_date,trunc(sysdate)) and nvl(rcrm.end_date,trunc(sysdate))
) and
--
nvl2(:show_bank_accts,x.cust_account_id,null) = ba.cust_account_id (+) and
nvl(x.site_use_id,-99) = nvl(ba.site_use_id (+),nvl(x.site_use_id,-99)) and
(:show_bank_accts = 'Y' or
 ba.instrument_payment_use_id is null or
 trunc(sysdate) between nvl(ba.bank_acct_assignmt_start_date,trunc(sysdate)) and nvl(ba.bank_acct_assignmt_end_date,trunc(sysdate))
) and
nvl2(:show_debit_auth,ba.party_id,null) = ida.debtor_party_id (+) and
nvl2(:show_debit_auth,ba.bank_account_id,null) = ida.external_bank_account_id (+) and
(:show_debit_auth = 'Y' or
 ida.debit_authorization_id is null or
 (nvl(ida.debit_auth_end,sysdate+1) > sysdate and nvl(ida.auth_cancel_date,sysdate+1) > sysdate)
) and
--
nvl2(:show_contacts,x.cust_account_id,0) = ctct.cust_account_id (+) and
nvl(x.cust_acct_site_id,-