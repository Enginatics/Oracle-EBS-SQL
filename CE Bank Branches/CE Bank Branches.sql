/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Bank Branches
-- Description: This Report is the repository of all bank branches covering both internal and external bank accounts and will list the bank branches along with an indication of usage:
-Internal
-Supplier
-Customer

-- Excel Examle Output: https://www.enginatics.com/example/ce-bank-branches/
-- Library Link: https://www.enginatics.com/reports/ce-bank-branches/
-- Run Report: https://demo.enginatics.com/

select 
cbb.bank_name,
cbb.bank_number,
cbb.bank_name_alt,
cbb.short_bank_name,
cbb.bank_start_date,
cbb.bank_end_date,
cbb.bank_institution_type,
cbb.bank_country,
cbb.bank_branch_name,
cbb.branch_number,
cbb.bank_branch_name_alt,
cbb.bank_branch_type, -- Branch type indicates which list the bank routing number is on. Valid types are ABA, CHIPS, SWIFT, OTHER.
cbb.start_date bank_branch_start_date,
cbb.end_date bank_branch_end_date,
cbb.eft_swift_code,
xxen_util.meaning(cbb.internal_use,'YES_NO',0) branch_internal_use,
xxen_util.meaning(cbb.supplier_use,'YES_NO',0) branch_supplier_use,
xxen_util.meaning(customer_use,'YES_NO',0) branch_customer_use,
cbb.bank_party_id,
cbb.branch_party_id,
--Branch Address details below
cbb.address_line1,
cbb.address_line2,
cbb.address_line3,
cbb.address_line4,
cbb.city,
cbb.state,
cbb.zip,
cbb.country,
cbb.description,
cbb.eft_user_number,
cbb.edi_id_number
from
(select
(select
 'Y'
 from
 ce_bank_accounts cba
 where
 cbbv.branch_party_id = cba.bank_branch_id and
 rownum <= 1
) internal_use,
(select
 'Y'
 from
 iby_ext_bank_accounts ieba,
 iby_pmt_instr_uses_all ipiua,
 iby_external_payees_all iepa,
 ap_suppliers asu
 where
 cbbv.branch_party_id = ieba.branch_id and
 ieba.ext_bank_account_id = ipiua.instrument_id and
 ipiua.ext_pmt_party_id = iepa.ext_payee_id and
 iepa.payee_party_id = asu.party_id and
 ipiua.payment_function = 'PAYABLES_DISB' and
 ipiua.instrument_type = 'BANKACCOUNT' and
 sysdate between ipiua.start_date and nvl(ipiua.end_date,sysdate) and
 iepa.payment_function = 'PAYABLES_DISB' and
 rownum <= 1
) supplier_use,
(select
 'Y'
 from
 iby_ext_bank_accounts ieba,
 iby_pmt_instr_uses_all ipiua,
 iby_external_payers_all iepa
 where
 cbbv.branch_party_id = ieba.branch_id and
 ieba.ext_bank_account_id = ipiua.instrument_id and
 ipiua.ext_pmt_party_id = iepa.ext_payer_id and
 ipiua.payment_function = 'CUSTOMER_PAYMENT' and
 ipiua.instrument_type = 'BANKACCOUNT' and
 sysdate between ipiua.start_date and nvl(ipiua.end_date,sysdate) and
 iepa.payment_function = 'CUSTOMER_PAYMENT' and
 (iepa.cust_account_id is not null or
  iepa.acct_site_use_id is not null
 ) and
 rownum <= 1
) customer_use,
cbbv.*,
cbv.start_date bank_start_date,
cbv.end_date bank_end_date,
ftv.territory_short_name bank_country
from
ce_bank_branches_v cbbv,
ce_banks_v cbv,
fnd_territories_vl ftv
where
cbbv.bank_party_id=cbv.bank_party_id and
ftv.territory_code=cbbv.bank_home_country
) cbb
where 1=1