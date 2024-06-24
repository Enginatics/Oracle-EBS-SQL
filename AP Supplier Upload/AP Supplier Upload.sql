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

select
x.*
from
(
select distinct
null action_,
null status_,
null message_,
null request_id_,
:p_upload_mode upload_mode_,
to_char(null) supplier_row_id,
to_char(null) site_row_id,
to_char(null) site_contact_row_id,
to_char(null) supplier_bank_acct_row_id,
to_char(null) site_bank_acct_row_id,
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
nvl(zptp0.rep_registration_number,aps.vat_registration_num) tax_registration_number,
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
-- # Vendor DFF
aps.attribute_category vendor_attribute_category,
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
nvl(xxen_util.meaning(zptp0.rounding_rule_code,'ZX_ROUNDING_RULE',0),:p_default_tax_rounding_rule) tax_rounding_rule,
xxen_util.meaning(nvl(zptp0.inclusive_tax_flag,'N'),'YES_NO',0) inclusive_tax,
xxen_util.meaning(nvl(zptp0.process_for_applicability_flag,'Y'),'YES_NO',0) allow_tax_applicability,
xxen_util.meaning(nvl(zptp0.self_assess_flag,'N'),'YES_NO',0) self_assessment,
xxen_util.meaning(nvl(zptp0.allow_offset_tax_flag,'N'),'YES_NO',0) allow_offset_taxes,
nvl(zptp0.tax_classification_code,aps.vat_code) tax_classification,
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
xxen_util.meaning(nvl(iepa0.exclusive_payment_flag,'N'),'YES_NO',0) pay_each_document_alone,
xxen_util.meaning(iepa0.bank_charge_bearer,'IBY_BANK_CHARGE_BEARER',0) bank_charge_bearer,
(select iprv.meaning from iby_payment_reasons_vl iprv where iprv.payment_reason_code = iepa0.payment_reason_code) payment_reason,
iepa0.payment_reason_comments payment_reason_comments,
(select ifv.format_name from iby_formats_vl ifv where ifv.format_code = iepa0.payment_format_code) payee_payment_format,
xxen_util.meaning(iepa0.service_level_code,'IBY_SERVICE_LEVEL',0) payment_service_level,
xxen_util.meaning(iepa0.delivery_channel_code,'IBY_LOCAL_INSTRUMENT',0) payment_delivery_channel,
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
cbbv0.bank_name                    vendor_bank_name,
cbbv0.bank_number                  vendor_bank_number,
(select ftv.territory_short_name
 from   fnd_territories_vl ftv
 where  ftv.territory_code = cbbv0.bank_home_country
) vendor_bank_country,
cbbv0.bank_branch_name             vendor_bank_branch_name,
cbbv0.branch_number                vendor_bank_branch_number,
cbbv0.bank_branch_type             vendor_bank_branch_type,
cbbv0.eft_swift_code               vendor_bank_branch_bic,
ieba0.bank_account_name            vendor_bank_acct_name,
ieba0.bank_account_num             vendor_bank_acct_num,
ieba0.check_digits                 vendor_bank_acct_check_digits,
ieba0.currency_code                vendor_bank_acct_currency,
--xxen_util.meaning(ieba0.foreign_payment_use_flag,'YES_NO',0)  vendor_bank_allow_foreign_pay,
ieba0.iban                         vendor_bank_acct_iban,
ieba0.bank_account_name_alt        vendor_bank_acct_name_alt,
ieba0.account_suffix               vendor_bank_acct_suffix,
ieba0.start_date                   vendor_bank_acct_start_date,
ieba0.end_date                     vendor_bank_acct_end_date,
xxen_util.meaning(ieba0.bank_account_type,'BANK_ACCOUNT_TYPE',260)
                                   vendor_bank_acct_type,
ieba0.secondary_account_reference  vendor_bank_acct_sec_reference,
ieba0.description                  vendor_bank_acct_description,
ieba0.contact_name                 vendor_bank_acct_contact,
ieba0.contact_phone                vendor_bank_acct_contact_phone,
ieba0.contact_fax                  vendor_bank_acct_contact_fax,
ieba0.contact_email                vendor_bank_acct_contact_email,
-- ########
-- Vendor Site
-- ########
hps.party_site_name address_name,
assa.vendor_site_code site_name,
assa.vendor_site_code_alt alt_site_name,
hou.name operating_unit,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = assa.country) country,
assa.address_line1,
assa.address_line2,
assa.address_line3,
assa.city,
assa.county,
assa.state,
assa.zip,
assa.province,
xxen_util.meaning(assa.address_style,'ADDRESS_STYLE',0) address_style,
initcap(fl.nls_language) language,
assa.area_code,
assa.phone,
assa.fax_area_code,
assa.fax,
assa.customer_num site_customer_num,
assa.inactive_date site_inactive_date,
xxen_util.meaning(assa.purchasing_site_flag,'YES_NO',0) purchasing_site,
xxen_util.meaning(assa.pay_site_flag,'YES_NO',0) pay_site,
xxen_util.meaning(assa.rfq_only_site_flag,'YES_NO',0) rfq_only_site,
xxen_util.meaning(assa.tax_reporting_site_flag,'YES_NO',0) tax_reporting_site,
nvl(zptp1.rep_registration_number,assa.vat_registration_num) site_tax_reg_number,
zptp1.registration_type_code site_tax_reg_type,
(select territory_short_name from fnd_territories_vl ftv where ftv.territory_code = zptp1.country_code) site_tax_reg_country,
-- # Vendor Site DFF
assa.attribute_category site_attribute_category,
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
xxen_util.meaning(nvl(zptp1.rounding_level_code,zptp1.rounding_level_code),'ZX_ROUNDING_LEVEL',0) site_tax_rounding_level,
nvl(xxen_util.meaning(nvl(zptp1.rounding_rule_code,zptp0.rounding_rule_code),'ZX_ROUNDING_RULE',0),:p_default_tax_rounding_rule) site_tax_rounding_rule,
xxen_util.meaning(nvl(zptp1.inclusive_tax_flag,nvl(zptp0.inclusive_tax_flag,'N')),'YES_NO',0) site_inclusive_tax,
xxen_util.meaning(nvl(zptp1.process_for_applicability_flag,nvl(zptp0.process_for_applicability_flag,'Y')),'YES_NO',0) site_calculate_tax,
xxen_util.meaning(nvl(zptp1.allow_offset_tax_flag,nvl(zptp0.allow_offset_tax_flag,'N')),'YES_NO',0) site_allow_offset_taxes,
nvl(zptp1.tax_classification_code,assa.vat_code) site_tax_classification,
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
xxen_util.meaning(nvl(iepa1.exclusive_payment_flag,nvl(iepa0.exclusive_payment_flag,'N')),'YES_NO',0) site_pay_each_document_alone,
xxen_util.meaning(assa.bank_charge_bearer,'BANK CHARGE BEARER',200) site_deduct_charge_from_bank,
xxen_util.meaning(iepa1.bank_charge_bearer,'IBY_BANK_CHARGE_BEARER',0) site_bank_charge_bearer,
(select iprv.meaning from iby_payment_reasons_vl iprv where iprv.payment_reason_code = iepa1.payment_reason_code) site_payment_reason,
iepa1.payment_reason_comments site_payment_reason_comments,
(select ifv.format_name from iby_formats_vl ifv where ifv.format_code = iepa1.payment_format_code) site_payee_payment_format,
xxen_util.meaning(iepa1.service_level_code,'IBY_SERVICE_LEVEL',0) site_payment_service_level,
xxen_util.meaning(iepa1.delivery_channel_code,'IBY_LOCAL_INSTRUMENT',0) site_payment_delivery_channel,
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
cbbv1.bank_name                    site_bank_name,
cbbv1.bank_number                  site_bank_number,
(select ftv.territory_short_name
 from   fnd_territories_vl ftv
 where  ftv.territory_code = cbbv1.bank_home_country
) site_bank_country,
cbbv1.bank_branch_name             site_bank_branch_name,
cbbv1.branch_number                site_bank_branch_number,
cbbv1.bank_branch_type             site_bank_branch_type,
cbbv1.eft_swift_code               site_bank_branch_bic,
ieba1.bank_account_name            site_bank_acct_name,
ieba1.bank_account_num             site_bank_acct_num,
ieba1.check_digits                 site_bank_acct_check_digits,
ieba1.currency_code                site_bank_acct_currency,
--xxen_util.meaning(ieba1.foreign_payment_use_flag,'YES_NO',0)  site_bank_allow_foreign_pay,
ieba1.iban                         site_bank_acct_iban,
ieba1.bank_account_name_alt        site_bank_acct_name_alt,
ieba1.account_suffix               site_bank_acct_suffix,
ieba1.start_date                   site_bank_acct_start_date,
ieba1.end_date                     site_bank_acct_end_date,
xxen_util.meaning(ieba1.bank_account_type,'BANK_ACCOUNT_TYPE',260)
                                   site_bank_acct_type,
ieba1.secondary_account_reference  site_bank_acct_sec_reference,
ieba1.description                  site_bank_acct_description,
ieba1.contact_name                 site_bank_acct_contact,
ieba1.contact_phone                site_bank_acct_contact_phone,
ieba1.contact_fax                  site_bank_acct_contact_fax,
ieba1.contact_email                site_bank_acct_contact_email,
-- ########
-- Vendor Site Contacts
-- ########
xxen_util.meaning(pvc.prefix,'CONTACT_TITLE',222) contact_title,
pvc.first_name contact_first_name,
pvc.middle_name contact_middle_name,
pvc.last_name contact_last_name,
(select hp.known_as
 from   hz_parties hp
 where  hp.party_id = pvc.per_party_id
) contact_alternate_name,
pvc.title contact_job_title,
pvc.department contact_department,
pvc.email_address contact_email_address,
pvc.url contact_url,
pvc.area_code contact_phone_area_code,
pvc.phone contact_phone_number,
(select hp.primary_phone_extension
 from   hz_parties hp
 where  hp.party_id = pvc.rel_party_id
) contact_phone_ext,
pvc.alt_area_code contact_alt_phone_area_code,
pvc.alt_phone contact_alt_phone_number,
pvc.fax_area_code contact_fax_area_code,
pvc.fax contact_fax_number,
decode(pvc.inactive_date,to_date('31/12/4712','DD/MM/YYYY'),to_date(null),pvc.inactive_date) contact_inactive_date,
-- # Contacts DFF
pvc.attribute_category contact_attribute_category,
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
pvc.vendor_contact_id,
gl.ledger_id set_of_books_id,
gl.chart_of_accounts_id,
ieba0.ext_bank_account_id supplier_bank_account_id,
ieba1.ext_bank_account_id site_bank_account_id
from
ap_suppliers aps,
hz_parties hp,
zx_party_tax_profile zptp0,
ap_suppliers aps1,
(select iepa.* from iby_external_payees_all iepa where iepa.payment_function='PAYABLES_DISB' and iepa.party_site_id is null and iepa.supplier_site_id is null) iepa0,
(select ipiua.* from iby_pmt_instr_uses_all ipiua where ipiua.payment_function='PAYABLES_DISB' and sysdate between ipiua.start_date and nvl(ipiua.end_date,sysdate)) ipiua0,
iby_ext_bank_accounts ieba0,
ce_bank_branches_v cbbv0,
--
ap_supplier_sites_all assa,
hz_party_sites hps,
fnd_languages fl,
hr_operating_units hou,
gl_ledgers gl,
zx_party_tax_profile zptp1,
(select iepa.* from iby_external_payees_all iepa where iepa.payment_function='PAYABLES_DISB' and iepa.supplier_site_id is not null) iepa1,
(select ipiua.* from iby_pmt_instr_uses_all ipiua where ipiua.payment_function='PAYABLES_DISB' and sysdate between ipiua.start_date and nvl(ipiua.end_date,sysdate)) ipiua1,
iby_ext_bank_accounts ieba1,
ce_bank_branches_v cbbv1,
--
po_vendor_contacts pvc,
ap_supplier_contacts asco
--
where
:p_upload_mode like '%' || xxen_upload.action_update and
1=1 and
aps.employee_id is null and
aps.parent_vendor_id = aps1.vendor_id(+) and
aps.party_id = hp.party_id and
aps.party_id = zptp0.party_id (+) and
'THIRD_PARTY' = zptp0.party_type_code (+) and
aps.party_id = iepa0.payee_party_id(+) and
decode(xxen_util.lookup_code(:p_show_vendor_banks,'YES_NO',0),'Y',iepa0.ext_payee_id,-99) = ipiua0.ext_pmt_party_id(+) and
decode(ipiua0.instrument_type,'BANKACCOUNT',ipiua0.instrument_id) = ieba0.ext_bank_account_id(+) and
ieba0.branch_id=cbbv0.branch_party_id(+) and
--
decode(xxen_util.lookup_code(:p_show_vendor_sites,'YES_NO',0),'Y',aps.vendor_id,-1) = assa.vendor_id (+) and
(assa.org_id is null or mo_global.check_access(assa.org_id)='Y') and
assa.party_site_id = hps.party_site_id (+) and
assa.language = fl.language_code (+) and
assa.org_id = hou.organization_id (+) and
hou.set_of_books_id = gl.ledger_id (+) and
assa.party_site_id = zptp1.party_id (+) and
'THIRD_PARTY_SITE' = zptp1.party_type_code (+) and
assa.party_site_id = iepa1.party_site_id (+) and
assa.vendor_site_id = iepa1.supplier_site_id (+) and
decode(xxen_util.lookup_code(:p_show_site_banks,'YES_NO',0),'Y',iepa1.ext_payee_id,-99) = ipiua1.ext_pmt_party_id(+) and
decode(ipiua1.instrument_type,'BANKACCOUNT',ipiua1.instrument_id) = ieba1.ext_bank_account_id(+) and
ieba1.branch_id=cbbv1.branch_party_id(+) and
--
decode(xxen_util.lookup_code(:p_show_site_contacts,'YES_NO',0),'Y',assa.vendor_site_id,-99) = pvc.vendor_site_id (+) and
pvc.vendor_contact_id = asco.vendor_contact_id (+)
--
&not_use_first_block
&report_table_select
&report_table_name
&report_table_where_clause
&success_query
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