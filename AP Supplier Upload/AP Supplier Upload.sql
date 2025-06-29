/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Supplier Upload
-- Description: This upload can be used to create and/or update Suppliers, Supplier Sites, Supplier Bank Accounts, and Supplier Contacts
-- Excel Examle Output: https://www.enginatics.com/example/ap-supplier-upload/
-- Library Link: https://www.enginatics.com/reports/ap-supplier-upload/
-- Run Report: https://demo.enginatics.com/

with
q_bank_accounts as
(select /*+ inline */
 iepa.payee_party_id,
 iepa.party_site_id,
 iepa.org_id,
 iepa.supplier_site_id,
 ipiua.instrument_payment_use_id,
 iepa.ext_payee_id,
 ieba.ext_bank_account_id bank_account_id,
 case when iepa.supplier_site_id is not null
 then xxen_util.meaning('SITE','POS_SBD_BYR_USAGE_LIST',0)
 when iepa.org_id is not null
 then xxen_util.meaning('ADDRESS_OU','POS_SBD_BYR_USAGE_LIST',0)
 when iepa.party_site_id is not null
 then xxen_util.meaning('ADDRESS','POS_SBD_BYR_USAGE_LIST',0)
 else xxen_util.meaning('SUPPLIER','POS_SBD_BYR_USAGE_LIST',0)
 end                               bank_assignment_level,
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
 xxen_util.meaning(ieba.foreign_payment_use_flag,'YES_NO',0) bank_acct_allow_foreign_pay,
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
 iby_external_payees_all iepa,
 iby_pmt_instr_uses_all ipiua,
 iby_ext_bank_accounts ieba,
 ce_bank_branches_v cbbv
 where
 iepa.ext_payee_id = ipiua.ext_pmt_party_id and
 ipiua.instrument_id = ieba.ext_bank_account_id and
 ieba.branch_id = cbbv.branch_party_id and
 iepa.payment_function = 'PAYABLES_DISB' and
 ipiua.payment_function = 'PAYABLES_DISB' and
 ipiua.instrument_type = 'BANKACCOUNT'
)
--
-- Main query starts here
--
select
x.*
from
(
select /*+ push_pred(ba0) push_pred(ba1) */ distinct
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
:p_upload_mode upload_mode_,
to_char(null) vend_row_id,
to_char(null) site_row_id,
to_char(null) site_contact_row_id,
to_char(null) vend_bank_intsr_pay_use_row_id,
to_char(null) site_bank_intsr_pay_use_row_id,
-- ########
-- Vendor
-- ########
aps.vendor_name supplier_name,
aps.vendor_name_alt alt_supplier_name,
hp.known_as alias,
aps.segment1 supplier_number,
aps.end_date_active inactive_date,
-- ## Vendor Organization
xxen_util.meaning(aps.vendor_type_lookup_code,'VENDOR TYPE',201) vendor_type,
xxen_util.meaning(aps.organization_type_lookup_code,'ORGANIZATION TYPE',201) organization_type,
decode(aps.organization_type_lookup_code,'INDIVIDUAL',aps.individual_1099,aps.num_1099) taxpayer_id,
zptp0.rep_registration_number tax_registration_number,
zptp0.registration_type_code tax_registration_type,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp0.country_code) tax_country_name,
hp.duns_number_c duns_number,
aps.standard_industry_class sic,
aps.ni_number,
nvl2(aps1.segment1,aps1.vendor_name || ' (' || aps1.segment1 || ')',null) parent_supplier,
aps.customer_num,
xxen_util.meaning(aps.one_time_flag,'YES_NO',0) one_time_flag,
xxen_util.meaning(aps.small_business_flag,'YES_NO',0) small_business_flag,
hp.url,
-- # Party dff
xxen_util.display_flexfield_context(222,'HZ_PARTIES',hp.attribute_category) party_attribute_category,
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
-- # Vendor DFF
xxen_util.display_flexfield_context(201,'PO_VENDORS',aps.attribute_category) vendor_attribute_category,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE1',aps.rowid,aps.attribute1) vendor_attribute1,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE2',aps.rowid,aps.attribute2) vendor_attribute2,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE3',aps.rowid,aps.attribute3) vendor_attribute3,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE4',aps.rowid,aps.attribute4) vendor_attribute4,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE5',aps.rowid,aps.attribute5) vendor_attribute5,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE6',aps.rowid,aps.attribute6) vendor_attribute6,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE7',aps.rowid,aps.attribute7) vendor_attribute7,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE8',aps.rowid,aps.attribute8) vendor_attribute8,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE9',aps.rowid,aps.attribute9) vendor_attribute9,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE10',aps.rowid,aps.attribute10) vendor_attribute10,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE11',aps.rowid,aps.attribute11) vendor_attribute11,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE12',aps.rowid,aps.attribute12) vendor_attribute12,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE13',aps.rowid,aps.attribute13) vendor_attribute13,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE14',aps.rowid,aps.attribute14) vendor_attribute14,
xxen_util.display_flexfield_value(201,'PO_VENDORS',aps.attribute_category,'ATTRIBUTE15',aps.rowid,aps.attribute15) vendor_attribute15,
-- ## Vendor Purchasing Options
aps.min_order_amount min_order_amount,
xxen_util.meaning(aps.hold_flag,'YES_NO',0) purchasing_hold_flag,
aps.purchasing_hold_reason,
xxen_util.meaning(aps.create_debit_memo_flag,'YES_NO',0) create_dm_for_rts,
--(select he.full_name from hr_employees he where he.employee_id = aps.hold_by) held_by,
--aps.hold_date,
-- ## Vendor Receiving Options
xxen_util.meaning(aps.enforce_ship_to_location_code,'RECEIVING CONTROL LEVEL',201) enforce_ship_to_location,
(select rrh.routing_name from rcv_routing_headers rrh where rrh.routing_header_id = aps.receiving_routing_id) receipt_routing,
case aps.inspection_required_flag || aps.receipt_required_flag
when 'NN' then '2-Way'
when 'NY' then '3-Way'
when 'YY' then '4-Way'
else null
end match_approval_level,
xxen_util.meaning(aps.inspection_required_flag,'YES_NO',0) inspection_required,
xxen_util.meaning(aps.receipt_required_flag,'YES_NO',0) receipt_required,
aps.qty_rcv_tolerance qty_received_tolerance,
xxen_util.meaning(aps.qty_rcv_exception_code,'RECEIVING CONTROL LEVEL',201) qty_received_exception,
aps.days_early_receipt_allowed,
aps.days_late_receipt_allowed,
xxen_util.meaning(aps.allow_substitute_receipts_flag,'YES_NO',0) allow_substitute_receipts,
xxen_util.meaning(aps.allow_unordered_receipts_flag,'YES_NO',0) allow_unordered_receipts,
xxen_util.meaning(aps.receipt_days_exception_code,'RECEIVING CONTROL LEVEL',201) receipt_days_exception,
-- ## Vendor Invoicing Options
aps.invoice_currency_code,
aps.payment_currency_code,
aps.invoice_amount_limit,
xxen_util.meaning(aps.match_option,'POS_INVOICE_MATCH_OPTION',0) invoice_match_option,
aps.payment_priority,
(select atv.name from ap_terms_vl atv where atv.term_id = aps.terms_id) payment_terms,
xxen_util.meaning(aps.terms_date_basis,'TERMS DATE BASIS',200) terms_date_basis,
xxen_util.meaning(aps.pay_date_basis_lookup_code,'PAY DATE BASIS',200) pay_date_basis,
xxen_util.meaning(aps.pay_group_lookup_code,'PAY GROUP',201) pay_group,
xxen_util.meaning(aps.always_take_disc_flag,'YES_NO',0) always_take_discount,
xxen_util.meaning(aps.exclude_freight_from_discount,'YES_NO',0) exclude_freight_from_discount,
xxen_util.meaning(aps.auto_calculate_interest_flag,'YES_NO',0) create_interest_invoices,
-- ## Vendor Invoicing - Payment Holds
xxen_util.meaning(aps.hold_all_payments_flag,'YES_NO',0) hold_all_invoices,
xxen_util.meaning(aps.hold_unmatched_invoices_flag,'YES_NO',0) hold_unmatched_invoices,
xxen_util.meaning(aps.hold_future_payments_flag,'YES_NO',0) hold_unvalidated_invoices,
aps.hold_reason payments_hold_reason,
-- ## Vendor Tax details - Income Tax
xxen_util.meaning(aps.federal_reportable_flag,'YES_NO',0) federal_reportable,
--select income_tax_type, description from ap_income_tax_types where (inactive_date is null or inactive_date > sysdate)
aps.type_1099 income_tax_type,
xxen_util.meaning(aps.state_reportable_flag,'YES_NO',0) state_reportable,
xxen_util.meaning(aps.allow_awt_flag,'YES_NO',0) allow_withholding_tax,
(select aag.name from ap_awt_groups aag where aag.group_id = aps.awt_group_id) inv_withholding_tax_group,
(select aag.name from ap_awt_groups aag where aag.group_id = aps.pay_awt_group_id) pay_withholding_tax_group,
-- ## Vendor Tax Details - Transaction Tax
xxen_util.meaning(zptp0.rounding_level_code,'ZX_ROUNDING_LEVEL',0) tax_rounding_level,
nvl(xxen_util.meaning(zptp0.rounding_rule_code,'ZX_ROUNDING_RULE',0),xxen_util.meaning(:p_default_tax_rounding_rule,'AP_TAX_ROUNDING_RULE',200)) tax_rounding_rule,
xxen_util.meaning(nvl(zptp0.inclusive_tax_flag,:p_default_inclusive_tax),'YES_NO',0) inclusive_tax,
xxen_util.meaning(nvl(zptp0.process_for_applicability_flag,'Y'),'YES_NO',0) allow_tax_applicability,
xxen_util.meaning(nvl(zptp0.self_assess_flag,'N'),'YES_NO',0) self_assessment,
xxen_util.meaning(nvl(zptp0.allow_offset_tax_flag,:p_default_allow_offset_taxes),'YES_NO',0) allow_offset_taxes,
zptp0.tax_classification_code tax_classification,
aps.offset_vat_code,
-- ## Vendor Tax Details - Tax Reporting
aps.tax_reporting_name,
aps.name_control tax_reporting_name_control,
aps.tax_verification_date tax_reporting_verif_date,
-- # Vendor Payment Details
(select
 ipmv.payment_method_name
 from
 iby_ext_party_pmt_mthds ieppm,
 iby_payment_methods_vl ipmv
 where
 ieppm.payment_method_code = ipmv.payment_method_code and
 ieppm.primary_flag = 'Y' and
 ieppm.payment_function='PAYABLES_DISB' and
 ieppm.payment_flow = 'DISBURSEMENTS' and
 nvl(ieppm.inactive_date,trunc(sysdate+1)) > trunc(sysdate) and
 nvl(ipmv.inactive_date,trunc(sysdate+1)) > trunc(sysdate) and
 ieppm.ext_pmt_party_id = iepa0.ext_payee_id and
 rownum <= 1
) default_payment_method,
xxen_util.meaning(nvl(iepa0.exclusive_payment_flag,:p_default_pay_document_alone),'YES_NO',0) pay_each_document_alone,
xxen_util.meaning(iepa0.bank_charge_bearer,'IBY_BANK_CHARGE_BEARER',0) bank_charge_bearer,
(select iprv.meaning from iby_payment_reasons_vl iprv where iprv.payment_reason_code = iepa0.payment_reason_code) payment_reason,
iepa0.payment_reason_comments payment_reason_comments,
(select ifv.format_name from iby_formats_vl ifv where ifv.format_code = iepa0.payment_format_code) payee_payment_format,
--xxen_util.meaning(iepa0.service_level_code,'IBY_SERVICE_LEVEL',0) payment_service_level,
(select idcv.meaning from iby_delivery_channels_vl idcv where idcv.delivery_channel_code = iepa0.delivery_channel_code) payment_delivery_channel,
(select ibiv.meaning from iby_bank_instructions_vl ibiv where ibiv.bank_instruction_code = iepa0.bank_instruction1_code) bank_instruction1,
(select ibiv.meaning from iby_bank_instructions_vl ibiv where ibiv.bank_instruction_code = iepa0.bank_instruction2_code) bank_instruction2,
iepa0.bank_instruction_details bank_instruction_details,
iepa0.payment_text_message1 payment_text_message1,
iepa0.payment_text_message2 payment_text_message2,
iepa0.payment_text_message3 payment_text_message3,
xxen_util.meaning(iepa0.remit_advice_delivery_method,'IBY_DELIVERY_METHODS',0) remit_advice_del_method,
iepa0.remit_advice_email remit_advice_email,
iepa0.remit_advice_fax remit_advice_fax,
iepa0.ece_tp_location_code ece_tp_location_code,
iepa0.settlement_priority settlement_priority,
-- ########
-- Vendor Bank Accounts
-- ########
ba0.bank_name                      vendor_bank_name,
ba0.bank_number                    vendor_bank_number,
ba0.bank_country                   vendor_bank_country,
ba0.bank_branch_name               vendor_bank_branch_name,
ba0.bank_branch_number             vendor_bank_branch_number,
ba0.bank_branch_type               vendor_bank_branch_type,
ba0.bank_branch_bic                vendor_bank_branch_bic,
ba0.bank_acct_name                 vendor_bank_acct_name,
ba0.bank_acct_num                  vendor_bank_acct_num,
ba0.bank_acct_check_digits         vendor_bank_acct_check_digits,
ba0.bank_acct_currency             vendor_bank_acct_currency,
ba0.bank_acct_allow_foreign_pay    vendor_bank_acct_allow_foreign,
ba0.bank_acct_iban                 vendor_bank_acct_iban,
ba0.bank_acct_name_alt             vendor_bank_acct_name_alt,
ba0.bank_acct_suffix               vendor_bank_acct_suffix,
ba0.bank_acct_type                 vendor_bank_acct_type,
ba0.bank_acct_sec_reference        vendor_bank_acct_sec_reference,
ba0.bank_acct_description          vendor_bank_acct_description,
ba0.bank_acct_contact              vendor_bank_acct_contact,
ba0.bank_acct_contact_phone        vendor_bank_acct_contact_phone,
ba0.bank_acct_contact_fax          vendor_bank_acct_contact_fax,
ba0.bank_acct_contact_email        vendor_bank_acct_contact_email,
ba0.bank_acct_assignmt_start_date  vendor_bank_acct_assign_start,
ba0.bank_acct_assignmt_end_date    vendor_bank_acct_assign_end,
-- ########
-- Party Site/Address
-- ########
hps.party_site_name address_name,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = hl.country) country,
hl.address1 address_line1,
hl.address2 address_line2,
hl.address3 address_line3,
hl.address4 address_line4,
hl.city,
hl.county,
hl.state,
hl.postal_code zip,
hl.province,
xxen_util.meaning(hl.address_style,'ADDRESS_STYLE',0) address_style,
initcap(fl.nls_language) address_language,
xxen_util.meaning(hps.status,'REGISTRY_STATUS',222) address_status,
--
hcp1.phone_area_code address_phone_area_code,
hcp1.phone_number address_phone_number,
hcp2.phone_area_code address_fax_area_code,
hcp2.phone_number address_fax_number,
hcp3.email_address address_email_address,
(select xxen_util.meaning('Y','YES_NO',0) from hz_party_site_uses hpsu where hpsu.party_site_id = assa.party_site_id and hpsu.site_use_type = 'PURCHASING' and hpsu.status = 'A') purchasing_address,
(select xxen_util.meaning('Y','YES_NO',0) from hz_party_site_uses hpsu where hpsu.party_site_id = assa.party_site_id and hpsu.site_use_type = 'PAY' and hpsu.status = 'A') pay_address,
(select xxen_util.meaning('Y','YES_NO',0) from hz_party_site_uses hpsu where hpsu.party_site_id = assa.party_site_id and hpsu.site_use_type = 'RFQ' and hpsu.status = 'A') rfq_only_address,
-- ########
-- Vendor Site
-- ########
assa.vendor_site_code site_name,
assa.vendor_site_code_alt alt_site_name,
hou.name operating_unit,
assa.inactive_date site_inactive_date,
xxen_util.meaning(assa.supplier_notif_method,'DOCUMENT_COMMUNICATION_METHOD',201) site_notification_method,
assa.area_code site_phone_area_code,
assa.phone site_phone_number,
assa.fax_area_code site_fax_area_code,
assa.fax site_fax_number,
assa.email_address site_email_address,
decode(assa.purchasing_site_flag,'Y',xxen_util.meaning('Y','YES_NO',0),null) purchasing_site,
decode(assa.pay_site_flag,'Y',xxen_util.meaning('Y','YES_NO',0),null) pay_site,
decode(assa.rfq_only_site_flag,'Y',xxen_util.meaning('Y','YES_NO',0),null) rfq_only_site,
decode(assa.tax_reporting_site_flag,'Y',xxen_util.meaning('Y','YES_NO',0),null) tax_reporting_site,
zptp1.rep_registration_number site_tax_reg_number,
zptp1.registration_type_code site_tax_reg_type,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp1.country_code) site_tax_reg_country,
assa.customer_num site_customer_num,
-- # Party Site dff
xxen_util.display_flexfield_context(222,'HZ_PARTY_SITES',hps.attribute_category) party_site_attribute_category,
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
-- # Vendor Site DFF
xxen_util.display_flexfield_context(201,'PO_VENDOR_SITES',assa.attribute_category) site_attribute_category,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE1',assa.rowid,assa.attribute1) site_attribute1,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE2',assa.rowid,assa.attribute2) site_attribute2,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE3',assa.rowid,assa.attribute3) site_attribute3,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE4',assa.rowid,assa.attribute4) site_attribute4,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE5',assa.rowid,assa.attribute5) site_attribute5,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE6',assa.rowid,assa.attribute6) site_attribute6,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE7',assa.rowid,assa.attribute7) site_attribute7,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE8',assa.rowid,assa.attribute8) site_attribute8,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE9',assa.rowid,assa.attribute9) site_attribute9,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE10',assa.rowid,assa.attribute10) site_attribute10,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE11',assa.rowid,assa.attribute11) site_attribute11,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE12',assa.rowid,assa.attribute12) site_attribute12,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE13',assa.rowid,assa.attribute13) site_attribute13,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE14',assa.rowid,assa.attribute14) site_attribute14,
xxen_util.display_flexfield_value(201,'PO_VENDOR_SITES',assa.attribute_category,'ATTRIBUTE15',assa.rowid,assa.attribute15) site_attribute15,
-- ## Vendor Site Purchasing Options
(select hl.location_code from hr_locations hl where hl.location_id = assa.ship_to_location_id) site_ship_to_location,
(select hl.location_code from hr_locations hl where hl.location_id = assa.bill_to_location_id) site_bill_to_location,
xxen_util.meaning(assa.ship_via_lookup_code,'SHIP_METHOD',3) site_ship_via,
xxen_util.meaning(assa.pay_on_code,'ERS PAY_ON_CODE',201) site_pay_on,
(select assa2.vendor_site_code from ap_supplier_sites_all assa2 where assa2.vendor_site_id = assa.default_pay_site_id) site_alt_pay_site,
xxen_util.meaning(assa.pay_on_receipt_summary_code,'ERS INVOICE_SUMMARY',201)  site_invoice_summary_level,
xxen_util.meaning(assa.create_debit_memo_flag,'YES_NO',0) site_create_dm_for_rts,
xxen_util.meaning(assa.gapless_inv_num_flag,'YES_NO',0) site_gapless_inv_numbering,
assa.selling_company_identifier site_selling_company_identif,
xxen_util.meaning(assa.fob_lookup_code,'FOB',201) site_fob,
xxen_util.meaning(assa.freight_terms_lookup_code,'FREIGHT TERMS',201) site_freight_terms,
xxen_util.meaning(assa.shipping_control,'SHIPPING CONTROL',201) site_transportation_arranged,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = assa.country_of_origin_code) site_country_of_origin,
--assa.ack_lead_time site_ack_days_lead_time,
-- # Vendor Site Invoicing Options
assa.invoice_currency_code site_invoice_currency_code,
assa.payment_currency_code site_payment_currency_code,
assa.invoice_amount_limit site_invoice_amount_limit,
xxen_util.meaning(assa.match_option,'POS_INVOICE_MATCH_OPTION',0) site_invoice_match_option,
assa.payment_priority site_payment_priority,
(select atv.name from ap_terms_vl atv where atv.term_id = assa.terms_id) site_payment_terms,
xxen_util.meaning(assa.terms_date_basis,'TERMS DATE BASIS',200) site_terms_date_basis,
xxen_util.meaning(assa.pay_date_basis_lookup_code,'PAY DATE BASIS',200) site_pay_date_basis,
xxen_util.meaning(assa.pay_group_lookup_code,'PAY GROUP',201) site_pay_group,
xxen_util.meaning(assa.always_take_disc_flag,'YES_NO',0) site_always_take_discount,
xxen_util.meaning(assa.exclude_freight_from_discount,'YES_NO',0) site_excl_freight_from_disc,
(select att.tolerance_name from ap_tolerance_templates att where att.tolerance_id = assa.tolerance_id and tolerance_type = 'GOODS') site_invoice_tolerance,
(select att.tolerance_name from ap_tolerance_templates att where att.tolerance_id = assa.services_tolerance_id and tolerance_type = 'SERVICES') site_service_tolerance,
assa.retainage_rate site_retainage_rate_pct,
-- ## Vendor Site Invoicing - Payment Holds
xxen_util.meaning(assa.hold_all_payments_flag,'YES_NO',0) site_hold_all_invoices,
xxen_util.meaning(assa.hold_unmatched_invoices_flag,'YES_NO',0) site_hold_unmatched_invoices,
xxen_util.meaning(assa.hold_future_payments_flag,'YES_NO',0) site_hold_unvalidated_invoices,
assa.hold_reason site_payments_hold_reason,
-- # Vendor Site Accounting
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where assa.accts_pay_code_combination_id=gcck.code_combination_id) liability_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where assa.prepay_code_combination_id=gcck.code_combination_id) prepayment_account,
(select gcck.concatenated_segments from gl_code_combinations_kfv gcck where assa.future_dated_payment_ccid=gcck.code_combination_id) bills_payable_account,
(select adsa.distribution_set_name from ap_distribution_sets_all adsa where adsa.distribution_set_id = assa.distribution_set_id) distribution_set,
-- # Vendor Site Tax Details
xxen_util.meaning(assa.allow_awt_flag,'YES_NO',0) site_allow_withholding_tax,
(select aag.name from ap_awt_groups aag where aag.group_id = assa.awt_group_id) site_inv_withholding_tax_group,
(select aag.name from ap_awt_groups aag where aag.group_id = assa.pay_awt_group_id) site_pay_withholding_tax_group,
xxen_util.meaning(nvl(zptp1.rounding_level_code,zptp0.rounding_level_code),'ZX_ROUNDING_LEVEL',0) site_tax_rounding_level,
nvl(xxen_util.meaning(nvl(zptp1.rounding_rule_code,zptp0.rounding_rule_code),'ZX_ROUNDING_RULE',0),xxen_util.meaning(:p_default_tax_rounding_rule,'AP_TAX_ROUNDING_RULE',200)) site_tax_rounding_rule,
xxen_util.meaning(nvl(zptp1.inclusive_tax_flag,nvl(zptp0.inclusive_tax_flag,:p_default_inclusive_tax)),'YES_NO',0) site_inclusive_tax,
xxen_util.meaning(nvl(zptp1.process_for_applicability_flag,nvl(zptp0.process_for_applicability_flag,'Y')),'YES_NO',0) site_calculate_tax,
xxen_util.meaning(nvl(zptp1.allow_offset_tax_flag,nvl(zptp0.allow_offset_tax_flag,:p_default_allow_offset_taxes)),'YES_NO',0) site_allow_offset_taxes,
assa.vat_code site_tax_classification,
-- # Vendor Site Payment Details
(select
 ipmv.payment_method_name
 from
 iby_ext_party_pmt_mthds ieppm,
 iby_payment_methods_vl ipmv
 where
 ieppm.payment_method_code = ipmv.payment_method_code and
 ieppm.primary_flag = 'Y' and
 ieppm.payment_function='PAYABLES_DISB' and
 ieppm.payment_flow = 'DISBURSEMENTS' and
 nvl(ieppm.inactive_date,trunc(sysdate+1)) > trunc(sysdate) and
 nvl(ipmv.inactive_date,trunc(sysdate+1)) > trunc(sysdate) and
 ieppm.ext_pmt_party_id = iepa1.ext_payee_id and
 rownum <= 1
) site_default_payment_method,
xxen_util.meaning(nvl(iepa1.exclusive_payment_flag,nvl(iepa0.exclusive_payment_flag,:p_default_pay_document_alone)),'YES_NO',0) site_pay_each_document_alone,
xxen_util.meaning(assa.bank_charge_bearer,'BANK CHARGE BEARER',200) site_deduct_charge_from_bank,
xxen_util.meaning(iepa1.bank_charge_bearer,'IBY_BANK_CHARGE_BEARER',0) site_bank_charge_bearer,
(select iprv.meaning from iby_payment_reasons_vl iprv where iprv.payment_reason_code = iepa1.payment_reason_code) site_payment_reason,
iepa1.payment_reason_comments site_payment_reason_comments,
(select ifv.format_name from iby_formats_vl ifv where ifv.format_code = iepa1.payment_format_code) site_payee_payment_format,
--xxen_util.meaning(iepa1.service_level_code,'IBY_SERVICE_LEVEL',0) site_payment_service_level,
(select idcv.meaning from iby_delivery_channels_vl idcv where idcv.delivery_channel_code = iepa1.delivery_channel_code) site_payment_delivery_channel,
(select ibiv.meaning from iby_bank_instructions_vl ibiv where ibiv.bank_instruction_code = iepa1.bank_instruction1_code) site_bank_instruction1,
(select ibiv.meaning from iby_bank_instructions_vl ibiv where ibiv.bank_instruction_code = iepa1.bank_instruction2_code) site_bank_instruction2,
iepa1.bank_instruction_details site_bank_instruction_details,
iepa1.payment_text_message1 site_payment_text_message1,
iepa1.payment_text_message2 site_payment_text_message2,
iepa1.payment_text_message3 site_payment_text_message3,
xxen_util.meaning(iepa1.remit_advice_delivery_method,'IBY_DELIVERY_METHODS',0) site_remit_advice_del_method,
iepa1.remit_advice_email site_remit_advice_email,
iepa1.remit_advice_fax site_remit_advice_fax,
iepa1.ece_tp_location_code site_ece_tp_location_code,
iepa1.settlement_priority site_settlement_priority,
-- ########
-- Vendor Site Bank Accounts
-- ########
ba1.bank_assignment_level          site_bank_assignment_level,
ba1.bank_name                      site_bank_name,
ba1.bank_number                    site_bank_number,
ba1.bank_country                   site_bank_country,
ba1.bank_branch_name               site_bank_branch_name,
ba1.bank_branch_number             site_bank_branch_number,
ba1.bank_branch_type               site_bank_branch_type,
ba1.bank_branch_bic                site_bank_branch_bic,
ba1.bank_acct_name                 site_bank_acct_name,
ba1.bank_acct_num                  site_bank_acct_num,
ba1.bank_acct_check_digits         site_bank_acct_check_digits,
ba1.bank_acct_currency             site_bank_acct_currency,
ba1.bank_acct_allow_foreign_pay    site_bank_acct_allow_foreign,
ba1.bank_acct_iban                 site_bank_acct_iban,
ba1.bank_acct_name_alt             site_bank_acct_name_alt,
ba1.bank_acct_suffix               site_bank_acct_suffix,
ba1.bank_acct_type                 site_bank_acct_type,
ba1.bank_acct_sec_reference        site_bank_acct_sec_reference,
ba1.bank_acct_description          site_bank_acct_description,
ba1.bank_acct_contact              site_bank_acct_contact,
ba1.bank_acct_contact_phone        site_bank_acct_contact_phone,
ba1.bank_acct_contact_fax          site_bank_acct_contact_fax,
ba1.bank_acct_contact_email        site_bank_acct_contact_email,
ba1.bank_acct_assignmt_start_date  site_bank_acct_assign_start,
ba1.bank_acct_assignmt_end_date    site_bank_acct_assign_end,
-- ########
-- Vendor Site Contacts
-- ########
xxen_util.meaning(nvl(hpc.person_pre_name_adjunct,hpc.salutation),'CONTACT_TITLE',222) contact_title,
hpc.person_first_name contact_first_name,
hpc.person_middle_name contact_middle_name,
hpc.person_last_name contact_last_name,
hpc.known_as contact_alternate_name,
hpc.person_title contact_job_title,
(select hoc.department
 from hz_org_contacts hoc
 where hoc.org_contact_id = asco.org_contact_id
) contact_department,
nvl(
 (select hcp.email_address
  from   hz_contact_points hcp
  where  hcp.contact_point_id =
  (select
   distinct first_value(hcp2.contact_point_id) over (order by hcp2.last_update_date desc, hcp2.contact_point_id desc rows between unbounded preceding and unbounded following)
   from
   hz_contact_points hcp2
   where
   hcp2.owner_table_name = 'HZ_PARTIES' and
   hcp2.owner_table_id = asco.rel_party_id and
   hcp2.contact_point_type = 'EMAIL' and
   hcp2.status = 'A'
  )
 ),
 hpr.email_address
) contact_email_address,
hpr.url contact_url,
case when hpr.primary_phone_line_type='GEN' then hpr.primary_phone_area_code else null end contact_phone_area_code,
case when hpr.primary_phone_line_type='GEN' then hpr.primary_phone_number else null end contact_phone_number,
case when hpr.primary_phone_line_type='GEN' then hpr.primary_phone_extension else null end contact_phone_ext,
(select hcp.phone_area_code
 from   hz_contact_points hcp
 where  hcp.contact_point_id =
 (select
  distinct first_value(hcp2.contact_point_id) over (order by hcp2.last_update_date desc, hcp2.contact_point_id desc rows between unbounded preceding and unbounded following)
  from
  hz_contact_points hcp2
  where
  hcp2.owner_table_name = 'HZ_PARTIES' and
  hcp2.owner_table_id = asco.rel_party_id and
  hcp2.contact_point_type = 'PHONE' and
  hcp2.phone_line_type = 'GEN' and
  hcp2.primary_flag = 'N' and
  hcp2.status = 'A'
 )
) contact_alt_phone_area_code,
(select hcp.phone_number
 from   hz_contact_points hcp
 where  hcp.contact_point_id =
 (select
  distinct first_value(hcp2.contact_point_id) over (order by hcp2.last_update_date desc, hcp2.contact_point_id desc rows between unbounded preceding and unbounded following)
  from
  hz_contact_points hcp2
  where
  hcp2.owner_table_name = 'HZ_PARTIES' and
  hcp2.owner_table_id = asco.rel_party_id and
  hcp2.contact_point_type = 'PHONE' and
  hcp2.phone_line_type = 'GEN' and
  hcp2.primary_flag = 'N' and
  hcp2.status = 'A'
 )
) contact_alt_phone_number,
(select hcp.phone_area_code
 from   hz_contact_points hcp
 where  hcp.contact_point_id =
 (select
  distinct first_value(hcp2.contact_point_id) over (order by hcp2.last_update_date desc, hcp2.contact_point_id desc rows between unbounded preceding and unbounded following)
  from
  hz_contact_points hcp2
  where
  hcp2.owner_table_name = 'HZ_PARTIES' and
  hcp2.owner_table_id = asco.rel_party_id and
  hcp2.contact_point_type = 'PHONE' and
  hcp2.phone_line_type = 'FAX' and
  hcp2.status = 'A'
 )
) contact_fax_area_code,
(select hcp.phone_number
 from   hz_contact_points hcp
 where  hcp.contact_point_id =
 (select
  distinct first_value(hcp2.contact_point_id) over (order by hcp2.last_update_date desc, hcp2.contact_point_id desc rows between unbounded preceding and unbounded following)
  from
  hz_contact_points hcp2
  where
  hcp2.owner_table_name = 'HZ_PARTIES' and
  hcp2.owner_table_id = asco.rel_party_id and
  hcp2.contact_point_type = 'PHONE' and
  hcp2.phone_line_type = 'FAX' and
  hcp2.status = 'A'
 )
) contact_fax_number,
(select hr.end_date from hz_relationships hr where hr.relationship_id = asco.relationship_id and hr.directional_flag = 'F' and trunc(hr.end_date) != to_date('31/12/4712','DD/MM/YYYY')) contact_inactive_date,
-- # Contacts DFF
xxen_util.display_flexfield_context(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category) contact_attribute_category,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE1',asco.rowid,asco.attribute1) contact_attribute1,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE2',asco.rowid,asco.attribute2) contact_attribute2,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE3',asco.rowid,asco.attribute3) contact_attribute3,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE4',asco.rowid,asco.attribute4) contact_attribute4,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE5',asco.rowid,asco.attribute5) contact_attribute5,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE6',asco.rowid,asco.attribute6) contact_attribute6,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE7',asco.rowid,asco.attribute7) contact_attribute7,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE8',asco.rowid,asco.attribute8) contact_attribute8,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE9',asco.rowid,asco.attribute9) contact_attribute9,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE10',asco.rowid,asco.attribute10) contact_attribute10,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE11',asco.rowid,asco.attribute11) contact_attribute11,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE12',asco.rowid,asco.attribute12) contact_attribute12,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE13',asco.rowid,asco.attribute13) contact_attribute13,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE14',asco.rowid,asco.attribute14) contact_attribute14,
xxen_util.display_flexfield_value(200,'AP_SUPPLIER_CONTACTS',asco.attribute_category,'ATTRIBUTE15',asco.rowid,asco.attribute15) contact_attribute15,
-- ########
-- IDs
-- ########
aps.vendor_id,
hp.party_id,
assa.vendor_site_id,
assa.party_site_id,
assa.org_id,
asco.vendor_contact_id,
ba0.instrument_payment_use_id supplier_bank_intsr_pay_use_id,
ba1.instrument_payment_use_id site_bank_instr_pay_use_id,
-- defaults
:p_default_tax_rounding_rule default_tax_rounding_rule,
:p_default_inclusive_tax default_inclusive_tax_flag,
:p_default_allow_offset_taxes default_allow_offset_tax_flag,
:p_default_pay_document_alone default_pay_alone_flag,
:p_site_bank_assign_level default_site_bank_assign_lvl
from
ap_suppliers aps,
hz_parties hp,
zx_party_tax_profile zptp0,
ap_suppliers aps1,
iby_external_payees_all iepa0,  -- to get the supplier level payment distribution
q_bank_accounts ba0,
--
ap_supplier_sites_all assa,
hz_party_sites hps,
hz_locations hl,
fnd_languages fl,
hr_operating_units hou,
gl_ledgers gl,
hz_contact_points hcp1,
hz_contact_points hcp2,
hz_contact_points hcp3,
zx_party_tax_profile zptp1,
iby_external_payees_all iepa1,  -- to get the site level payment distribution
q_bank_accounts ba1,
--
ap_supplier_contacts asco,
hz_parties hpc,
hz_parties hpr
--
where
:p_upload_mode like '%' || xxen_upload.action_update and
1=1 and
aps.employee_id is null and
aps.parent_vendor_id = aps1.vendor_id(+) and
aps.party_id = hp.party_id and
aps.party_id = zptp0.party_id (+) and
'THIRD_PARTY' = zptp0.party_type_code (+) and
--
aps.party_id = iepa0.payee_party_id (+) and
nvl(iepa0.party_site_id (+),0) = 0 and
iepa0.payment_function (+) = 'PAYABLES_DISB' and
--
decode(:p_show_vendor_banks,'Y',aps.party_id) = ba0.payee_party_id (+) and
nvl(ba0.party_site_id (+),0) = 0 and
--
decode(:p_show_vendor_sites,'Y',aps.vendor_id,-1) = assa.vendor_id (+) and
(assa.org_id is null or mo_global.check_access(assa.org_id)='Y') and
assa.party_site_id = hps.party_site_id (+) and
hps.location_id = hl.location_id (+) and
hl.language = fl.language_code (+) and
assa.org_id = hou.organization_id (+) and
hou.set_of_books_id = gl.ledger_id (+) and
--
hps.party_site_id = hcp1.owner_table_id (+) and
hcp1.owner_table_name (+) = 'HZ_PARTY_SITES' and
hcp1.contact_point_type (+) = 'PHONE' and
hcp1.phone_line_type (+) = 'GEN' and
hcp1.primary_flag (+) = 'Y' and
hcp1.status (+) = 'A' and
hps.party_site_id = hcp2.owner_table_id (+) and
hcp2.owner_table_name (+) = 'HZ_PARTY_SITES' and
hcp2.contact_point_type (+) = 'PHONE' and
hcp2.phone_line_type (+) = 'FAX' and
hcp2.status (+) = 'A' and
hps.party_site_id = hcp3.owner_table_id (+) and
hcp3.owner_table_name (+) = 'HZ_PARTY_SITES' and
hcp3.contact_point_type (+) = 'EMAIL' and
hcp3.primary_flag (+) = 'Y' and
hcp3.status (+) = 'A' and
--
assa.party_site_id = zptp1.party_id (+) and
'THIRD_PARTY_SITE' = zptp1.party_type_code (+) and
--
assa.party_site_id = iepa1.party_site_id (+) and
assa.vendor_site_id = iepa1.supplier_site_id (+) and
iepa1.payment_function (+) = 'PAYABLES_DISB' and
--
decode(:p_show_site_banks,'Y',assa.party_site_id) = ba1.party_site_id (+) and
assa.org_id = nvl(ba1.org_id (+),assa.org_id) and
assa.vendor_site_id = nvl(ba1.supplier_site_id (+),assa.vendor_site_id) and
--
decode(:p_show_site_contacts,'Y',assa.party_site_id,-99) = asco.org_party_site_id (+) and
(asco.vendor_contact_id is null or
 asco.vendor_contact_id = xxen_ap_upload.get_vendor_contact_id(assa.vendor_site_id,aps.party_id,assa.party_site_id,asco.relationship_id,asco.rel_party_id)
) and
asco.per_party_id = hpc.party_id (+) and
asco.rel_party_id = hpr.party_id (+)
--
&not_use_first_block
&report_table_select
&report_table_name
&report_table_where_clause
&success_query1
&success_query2
&processed_run
) x
order by
x.supplier_name,
x.supplier_number,
x.operating_unit,
x.country,
x.site_name,
x.contact_last_name,
x.contact_first_name,
x.site_bank_name,
x.site_bank_number,
x.site_bank_branch_name,
x.site_bank_branch_number,
x.site_bank_acct_name,
x.site_bank_acct_num