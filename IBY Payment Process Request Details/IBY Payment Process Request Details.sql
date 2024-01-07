/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: IBY Payment Process Request Details
-- Description: Payment manager process request details including statuses, paid or rejected documents, amounts and rejection eror messages
-- Excel Examle Output: https://www.enginatics.com/example/iby-payment-process-request-details/
-- Library Link: https://www.enginatics.com/reports/iby-payment-process-request-details/
-- Run Report: https://demo.enginatics.com/

select
xep.name legal_entity,
hou.name operating_unit,
ipsr.call_app_pay_service_req_code payment_process_request,
xxen_util.client_time(aisca.creation_date) creation_date,
trunc(sysdate)-trunc(aisca.creation_date) age,
trunc(aisca.check_date) check_date,
aisca.pay_from_date,
aisca.pay_thru_date,
(select count(*) from iby_payments_all ipa where ipsr.payment_service_request_id=ipa.payment_service_request_id and ipa.payment_status not in ('REMOVED','REMOVED_DOCUMENT_SPOILED','REMOVED_INSTRUCTION_TERMINATED','REMOVED_REQUEST_TERMINATED','REMOVED_PAYMENT_STOPPED','FAILED_BY_REJECTION_LEVEL','FAILED_BY_CALLING_APP','REJECTED')) payments,
(select count(distinct ipa.payment_instruction_id) from iby_payments_all ipa where ipsr.payment_service_request_id=ipa.payment_service_request_id) payment_instructions,
ap_payment_util_pkg.get_selected_ps_count(aisca.checkrun_id, ipsr.payment_service_request_id) selected_scheduled_payments,
ap_payment_util_pkg.get_rejected_ps_count(ipsr.payment_service_request_id) rejected_scheduled_payments,
xxen_util.meaning(ap_payment_util_pkg.get_payment_status_flag(ipsr.payment_service_request_id),'PSR_PAYMENTS_RECORDED',200) payments_recorded,
nvl2(ipsr.payment_service_request_id,xxen_util.meaning(ap_payment_util_pkg.get_psr_status(ipsr.payment_service_request_id,ipsr.payment_service_request_status),'IBY_REQUEST_STATUSES',0),xxen_util.meaning(aisca.status,'CHECK BATCH STATUS',200)) payment_process_request_status,
xxen_util.meaning(ipsr.payment_rejection_level_code,'IBY_PAYMENT_REJECTION_LEVELS',0) payment_rejection_level,
xxen_util.meaning(ipsr.process_type,'IBY_PROCESS_TYPES',0) process_type,
ipia.payment_instruction_id payment_instruction_reference,
ipia.pay_admin_assigned_ref_code pay_admin_assigned_reference,
xxen_util.meaning(ipia.payment_instruction_status,'IBY_PAY_INSTRUCTION_STATUSES',0) payment_instruction_status,
ipa.payment_reference_number,
ipa.paper_document_number,
ipa.payment_amount,
ipa.payment_date,
ipa.payment_currency_code currency,
xxen_util.meaning(ipa.payment_status,'IBY_PAYMENT_STATUSES',0) payment_status,
nvl(ipa.payee_party_name,hp1.party_name) trading_partner,
fav.application_name source_product,
idpa.calling_app_doc_ref_number document_reference_number,
xxen_util.meaning(idpa.document_type,'IBY_DOCUMENT_TYPES',0) document_type,
xxen_util.meaning(idpa.document_status,'IBY_DOCS_PAYABLE_STATUSES',0) document_status,
idpa.document_date,
idpa.document_amount,
idpa.document_currency_code document_currency,
idpa.payment_amount amount_paid,
idpa.payment_currency_code payment_currency,
idpa.payment_date document_payment_date,
ieba.masked_bank_account_num payee_bank_account,
ieba.masked_iban iban,
iebav.bank_name payee_bank_name,
idpa.bank_charge_bearer,
xxen_util.meaning(idpa.exclusive_payment_flag,'YES_NOW',0) pay_each_document_alone,
iprv.meaning payment_reason,
idpa.payment_reason_comments,
ipmv.payment_method_name payment_method,
iappv.payment_profile_name payment_process_profile,
hz_format_pub.format_address(hps.location_id,null,null,',',null,null,null,null) payee_address,
ifv.format_name payment_format,
idcv.meaning delivery_channel,
idpa.settlement_priority,
idpa.unique_remittance_identifier,
idpa.uri_check_digit,
idpa.remittance_message1,
idpa.remittance_message2,
idpa.remittance_message3,
xxen_util.meaning(idpa.payment_function,'IBY_PAYMENT_FUNCTIONS',0) payment_function,
ittv.name processing_transaction_type,
cba.bank_account_name internal_bank_account,
idpa.amount_withheld,
ite.error_message document_validation_error,
(select ivsv.validation_set_display_name from iby_validation_sets_vl ivsv where ite.validation_set_code=ivsv.validation_set_code) document_validation_set,
xxen_util.meaning(ite.error_status,'IBY_TRANSACTION_ERROR_STATUSES',0) document_error_status,
ite.error_date document_date_failed,
ite.pass_date document_date_passed,
ite.override_date document_override_date,
ite.override_justification doc_override_justification,
ite2.error_message payment_validation_error,
(select ivsv.validation_set_display_name from iby_validation_sets_vl ivsv where ite2.validation_set_code=ivsv.validation_set_code) payment_validation_set,
xxen_util.meaning(ite2.error_status,'IBY_TRANSACTION_ERROR_STATUSES',0) payment_error_status,
ite2.error_date payment_date_failed,
ite2.pass_date payment_date_passed,
ite2.override_date payment_override_date,
ite2.override_justification payment_override_justification,
xxen_util.user_name(aisca.created_by) request_created_by,
xxen_util.user_name(aisca.last_updated_by) request_last_updated_by,
xxen_util.user_name(idpa.created_by) document_created_by,
xxen_util.client_time(idpa.creation_date) document_creation_date,
xxen_util.user_name(idpa.last_updated_by) document_last_updated_by,
xxen_util.client_time(idpa.last_update_date) document_last_update_date,
idpa.payment_service_request_id,
aisca.checkrun_id,
idpa.payment_id,
idpa.document_payable_id
from
iby_pay_service_requests ipsr,
ap_inv_selection_criteria_all aisca,
iby_docs_payable_all idpa,
hz_parties hp1,
hz_parties hp2,
hz_party_sites hps,
fnd_application_vl fav,
iby_ext_bank_accounts_v iebav,
iby_ext_bank_accounts ieba,
iby_payment_reasons_vl iprv,
iby_payment_methods_vl ipmv,
iby_acct_pmt_profiles_vl iappv,
iby_formats_vl ifv,
iby_delivery_channels_vl idcv,
iby_trxn_types_vl ittv,
iby_payments_all ipa,
iby_pay_instructions_all ipia,
hr_operating_units hou,
gl_ledgers gl,
xle_entity_profiles xep,
ce_bank_accounts cba,
(
select distinct
ite.transaction_id,
listagg(ite.error_message,chr(10)) within group (order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) error_message,
max(ite.validation_set_code) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) validation_set_code,
max(ite.error_status) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) error_status,
max(ite.error_date) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) error_date,
max(ite.pass_date) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) pass_date,
max(ite.override_date) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) override_date,
max(ite.override_justification) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) override_justification
from
iby_transaction_errors ite
where
ite.transaction_type='DOCUMENT_PAYABLE'
) ite,
(
select distinct
ite.transaction_id,
listagg(ite.error_message,chr(10)) within group (order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) error_message,
max(ite.validation_set_code) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) validation_set_code,
max(ite.error_status) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) error_status,
max(ite.error_date) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) error_date,
max(ite.pass_date) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) pass_date,
max(ite.override_date) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) override_date,
max(ite.override_justification) keep (dense_rank last order by ite.transaction_error_id) over (partition by ite.transaction_id &partition_by_error) override_justification
from
iby_transaction_errors ite
where
ite.transaction_type='PAYMENT'
) ite2
where
1=1 and
ipsr.call_app_pay_service_req_code=aisca.checkrun_name(+) and
ipsr.payment_service_request_id=idpa.payment_service_request_id and
idpa.payee_party_id=hp1.party_id and
idpa.inv_payee_party_id=hp2.party_id(+) and
idpa.party_site_id=hps.party_site_id(+) and
idpa.calling_app_id=fav.application_id and
idpa.external_bank_account_id=iebav.bank_account_id(+) and
idpa.external_bank_account_id=ieba.ext_bank_account_id(+) and
idpa.payment_reason_code=iprv.payment_reason_code(+) and
idpa.payment_method_code=ipmv.payment_method_code(+) and
idpa.payment_profile_id=iappv.payment_profile_id(+) and
idpa.payment_format_code=ifv.format_code(+) and
idpa.delivery_channel_code=idcv.delivery_channel_code(+) and
idpa.pay_proc_trxn_type_code=ittv.pay_proc_trxn_type_code(+) and
idpa.payment_id=ipa.payment_id(+) and
ipa.payment_instruction_id=ipia.payment_instruction_id(+) and
decode(idpa.org_type,'OPERATING_UNIT',idpa.org_id)=hou.organization_id(+) and
(hou.organization_id is null or hou.organization_id in (select mgoat.organization_id from mo_glob_org_access_tmp mgoat union select fnd_global.org_id from dual where fnd_release.major_version=11)) and
hou.set_of_books_id=gl.ledger_id(+) and
idpa.legal_entity_id=xep.legal_entity_id(+) and
idpa.internal_bank_account_id=cba.bank_account_id(+) and
idpa.document_payable_id=ite.transaction_id(+) and
idpa.payment_id=ite2.transaction_id(+)
order by
xep.name,
hou.name,
creation_date desc,
idpa.payment_id desc