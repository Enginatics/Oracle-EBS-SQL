/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Cleared Transactions
-- Description: Application: Cash Management
Description: Transactions - Cleared Payment/Receipt Transactions

Provides equivalent functionality to the following standard Oracle Forms/Reports
- Cleared Transactions Report
  Applicable Templates:
  Pivot: Cleared Transactions Summary
  Pivot: Cleared Batches Summary

Source: Cleared Transactions Report (CEXCLEAR)
DB package: CE_CEXCLEAR_XMLP_PKG (required to initialize security)

-- Excel Examle Output: https://www.enginatics.com/example/ce-cleared-transactions/
-- Library Link: https://www.enginatics.com/reports/ce-cleared-transactions/
-- Run Report: https://demo.enginatics.com/

with q_cleared_transactions as
(
select --Q1 Cleared Payments
 cbagv.bank_account_id            bank_account_id,
 cbagv.bank_account_name          bank_account_name,
 cbagv.masked_account_num         bank_account_num,
 hp_bank.party_name               bank_name,
 hp_branch.party_name             branch_name,
 xep.name                         legal_entity,
 'PAYMENT'                        type1,
 'PAYMENT'                        type2,
 aca.vendor_name                  supplier_customer,
 aca.check_date                   trx_date,
 aca.future_pay_due_date          maturity_date,
 to_char(aca.check_number)        trx_number,
 ipmv.payment_method_name         payment_method,
 aca.currency_code                transaction_currency,
 30                               transaction_order,
 ipa.payment_instruction_id       batch_id,
 nvl2(ipa.payment_instruction_id
     ,aca.checkrun_name,null)     batch_name,
 to_char(ipa.payment_instruction_id)
                                  remittance_number,
 ipia.payment_currency_code       batch_currency,
 nvl2(cbagv2.masked_account_num,
      hp_batch_bank.party_name || ' - ' || cbagv2.masked_account_num || ' - ' || cbagv2.bank_account_name,
      null)                       batch_bank_account,
 ipa.payment_date                 batch_date,
 aca.cleared_date                 cleared_date,
 aca.amount                       amount,
 decode( aca.currency_code
       , cbagv.currency_code, aca.amount
                            , nvl(aca.base_amount,aca.amount)
 )                                account_amount,
 decode(aca.currency_code
       , cbagv.currency_code, aca.cleared_amount
                          , nvl(aca.cleared_base_amount,aca.cleared_amount)
       )                          account_cleared_amount,
 cspg.name                        org_name,
 cbagv.currency_code                bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 ap_checks_all                    aca,
 iby_payment_methods_vl           ipmv,
 iby_payments_all                 ipa,
 iby_pay_instructions_all         ipia,
 ce_bank_accts_gt_v               cbagv,
 ce_bank_accts_gt_v               cbagv2,
 hz_parties                       hp_bank,
 hz_parties                       hp_branch,
 hz_parties                       hp_batch_bank,
 ce_bank_acct_uses_all            cbaua,
 ce_security_profiles_gt          cspg,
 xle_entity_profiles              xep,
 hr_all_organization_units        haou,
 gl_code_combinations             gcc
where
 aca.cleared_date is not null and
 ipmv.payment_method_code = aca.payment_method_code and
 ipa.payment_id (+) = aca.payment_id and
 ipia.payment_instruction_id (+) = ipa.payment_instruction_id and
 cbagv2.bank_account_id (+) = ipia.internal_bank_account_id and
 hp_batch_bank.party_id (+) =  cbagv2.bank_id and
 cbagv.bank_branch_id = hp_branch.party_id and
 cbagv.bank_id = hp_bank.party_id and
 cbagv.bank_account_id = cbaua.bank_account_id and
 cbaua.bank_acct_use_id = aca.ce_bank_acct_use_id and
 cbaua.ap_use_enable_flag = 'Y' and
 cbaua.org_id = cspg.organization_id and
 cspg.organization_type = 'OPERATING_UNIT' and
 cbaua.org_id = aca.org_id and
 xep.legal_entity_id = cbagv.account_owner_org_id and
 haou.organization_id = cbaua.org_id and
 gcc.code_combination_id = cbagv.asset_code_combination_id and
 aca.cleared_date >= nvl(:p_date_from, aca.cleared_date) and
 aca.cleared_date <= nvl(:p_date_to, aca.cleared_date) and
 :p_batch_or_trx = 'T' and
 :p_type in ('AR_AND_AP', 'PAYMENTS','ALL') and
 haou.name = nvl(:p_operating_unit,haou.name)
union all
select --Q2 Cleared Receipts
 cbagv.bank_account_id,
 cbagv.bank_account_name,
 cbagv.masked_account_num,
 hp_bank.party_name bank_name,
 hp_branch.party_name branch_name,
 xep.name legal_entity,
 'RECEIPT' type1,
 'RECEIPT' type2,
 hp.party_name supplier_customer,
 acr.receipt_date trx_date,
 apsa.due_date maturity_date,
 acr.receipt_number trx_number,
 arm.name payment_method,
 acr.currency_code transaction_currency,
 10 transaction_order,
 aba.batch_id batch_id,
 aba.name batch_name,
 aba.bank_deposit_number remittance_number,
 aba.currency_code batch_currency,
 nvl2(cbagv2.masked_account_num,
      hp_batch_bank.party_name || ' - ' || cbagv2.masked_account_num || ' - ' || cbagv2.bank_account_name,
      null) batch_bank_account,
 aba.batch_date batch_date,
 acrha.trx_date cleared_date,
 acr.amount amount,
 decode(acr.currency_code, cbagv.currency_code, acrha.amount, nvl(acrha.acctd_amount, acrha.amount)) account_amount,
 decode(acr.currency_code, cbagv.currency_code, acrha.amount, nvl(acrha.acctd_amount, acrha.amount)) account_cleared_amount,
 cspg.name org_name,
 cbagv.currency_code bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 ar_cash_receipts             acr,
 ar_cash_receipt_history_all  acrha,
 ar_batches_all               aba,
 ce_bank_accts_gt_v           cbagv,
 ce_bank_acct_uses_all        cbaua2,
 ce_bank_accts_gt_v           cbagv2,
 ce_lookups                   cl,
 hz_cust_accounts             hca,
 hz_parties                   hp,
 ar_payment_schedules_all     apsa,
 ar_receipt_methods           arm,
 hz_parties                   hp_bank,
 hz_parties                   hp_branch,
 hz_parties                   hp_batch_bank,
 ce_bank_acct_uses_all        cbaua,
 ce_security_profiles_gt      cspg,
 xle_entity_profiles          xep,
 hr_all_organization_units    haou,
 gl_code_combinations         gcc
where
 cl.lookup_type = 'TRX_TYPE' and
 cl.lookup_code = acr.type and
 acr.cash_receipt_id = acrha.cash_receipt_id and
 aba.batch_id (+) = acrha.batch_id and
 cbaua2.bank_acct_use_id (+) = aba.remit_bank_acct_use_id and
 cbaua2.org_id (+) = aba.org_id and
 cbagv2.bank_account_id (+) = cbaua2.bank_account_id and
 hp_batch_bank.party_id (+) = cbagv2.bank_id and
 hca.cust_account_id(+) = acr.pay_from_customer and
 hp.party_id(+) = hca.party_id and
 apsa.cash_receipt_id(+) = acr.cash_receipt_id and
 arm.receipt_method_id = acr.receipt_method_id and
 cbagv.bank_branch_id = hp_branch.party_id and
 cbagv.bank_id = hp_bank.party_id and
 cbagv.bank_account_id = cbaua.bank_account_id and
 cbaua.ar_use_enable_flag = 'Y' and
 cbaua.org_id = cspg.organization_id and
 cspg.organization_type = 'OPERATING_UNIT' and
 cbaua.bank_acct_use_id = acr.remit_bank_acct_use_id and
 cbaua.org_id = acr.org_id and
 xep.legal_entity_id = cbagv.account_owner_org_id and
 haou.organization_id = cbaua.org_id and
 gcc.code_combination_id = cbagv.asset_code_combination_id and
 acrha.status in ('CLEARED', 'RISK_ELIMINATED') and
 acrha.current_record_flag = 'Y' and
 acrha.trx_date >= nvl(:p_date_from, acrha.trx_date) and
 acrha.trx_date <= nvl(:p_date_to, acrha.trx_date) and
 :p_batch_or_trx = 'T' and
 :p_type in ('AR_AND_AP', 'RECEIPTS', 'ALL') and
 haou.name = nvl(:p_operating_unit,haou.name)
union all --Q5 payroll payments
select
 cbagv.bank_account_id,
 cbagv.bank_account_name,
 cbagv.masked_account_num,
 hp_bank.party_name bank_name,
 hp_branch.party_name branch_name,
 xep.name legal_entity,
 'PAYROLL' type1,
 'PAYMENT' type2,
 c801rv.vendor_name supplier_customer,
 c801rv.trx_date trx_date,
 c801rv.maturity_date maturity_date,
 c801rv.trx_number trx_number,
 popm.org_payment_method_name payment_method,
 c801rv.currency_code transaction_currency,
 40 transaction_order,
 to_number(null) batch_id,
 null batch_name,
 null remittance_number,
 null batch_currency,
 null batch_bank_account,
 to_date(null) batch_date,
 c801rv.cleared_date cleared_date,
 c801rv.amount amount,
 c801rv.bank_account_amount account_amount,
 c801rv.amount_cleared account_cleared_amount,
 fnd_access_control_util.get_org_name(c801rv.org_id) org_name,
 cbagv.currency_code bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 ce_801_reconciled_v       c801rv,
 hz_parties                hp_bank,
 hz_parties                hp_branch,
 ce_bank_accts_gt_v        cbagv,
 pay_pre_payments          ppp,
 pay_assignment_actions    paa,
 pay_org_payment_methods_f popm,
 xle_entity_profiles       xep,
 hr_all_organization_units haou,
 gl_code_combinations      gcc
where
 ppp.org_payment_method_id = popm.org_payment_method_id and
 paa.assignment_action_id = c801rv.trx_id and
 paa.pre_payment_id = ppp.pre_payment_id and
 cbagv.bank_account_id = c801rv.bank_account_id and
 cbagv.bank_branch_id = hp_branch.party_id and
 cbagv.bank_id = hp_bank.party_id and
 xep.legal_entity_id = cbagv.account_owner_org_id and
 haou.organization_id = c801rv.org_id and
 gcc.code_combination_id = cbagv.asset_code_combination_id and
 c801rv.cleared_date >= nvl(:p_date_from, c801rv.cleared_date) and
 c801rv.cleared_date <= nvl(:p_date_to, c801rv.cleared_date) and
 c801rv.trx_date between popm.effective_start_date and popm.effective_end_date and
 :p_batch_or_trx = 'T' and
 :p_type in ( 'PAYROLLS', 'ALL') and
 haou.name = nvl(:p_business_group, haou.name)
union all --Q6 eft payroll
select
 cbagv.bank_account_id,
 cbagv.bank_account_name,
 cbagv.masked_account_num,
 hp_bank.party_name bank_name,
 hp_branch.party_name branch_name,
 xep.name legal_entity,
 'PAYROLL' type1,
 'PAYMENT' type2,
 c801erv.vendor_name supplier_customer,
 c801erv.trx_date trx_date,
 c801erv.maturity_date maturity_date,
 c801erv.trx_number trx_number,
 popm.org_payment_method_name payment_method,
 c801erv.currency_code transaction_currency,
 40 transaction_order,
 c801erv.batch_id batch_id,
 c801erv.batch_name batch_name,
 null remittance_number,
 null batch_currency,
 null batch_bank_account,
 to_date(null) batch_date,
 c801erv.cleared_date cleared_date,
 c801erv.amount amount,
 c801erv.bank_account_amount account_amount,
 c801erv.amount_cleared account_cleared_amount,
 fnd_access_control_util.get_org_name(c801erv.org_id) org_name,
 cbagv.currency_code bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 ce_801_eft_reconciled_v   c801erv,
 ce_bank_accts_gt_v        cbagv,
 hz_parties                hp_bank,
 hz_parties                hp_branch,
 pay_pre_payments          ppp,
 pay_assignment_actions    paa,
 pay_org_payment_methods_f popm,
 xle_entity_profiles       xep,
 hr_all_organization_units haou,
 gl_code_combinations      gcc
where
 ppp.org_payment_method_id = popm.org_payment_method_id and
 paa.assignment_action_id = c801erv.trx_id and
 paa.pre_payment_id = ppp.pre_payment_id and
 cbagv.bank_account_id = c801erv.bank_account_id and
 cbagv.bank_branch_id = hp_branch.party_id and
 cbagv.bank_id = hp_bank.party_id and
 xep.legal_entity_id = cbagv.account_owner_org_id and
 haou.organization_id = c801erv.org_id and
 gcc.code_combination_id = cbagv.asset_code_combination_id and
 c801erv.cleared_date >= nvl(:p_date_from, c801erv.cleared_date) and
 c801erv.cleared_date <= nvl(:p_date_to, c801erv.cleared_date) and
 c801erv.trx_date between popm.effective_start_date and popm.effective_end_date and
 :p_batch_or_trx = 'T' and
 :p_type in ( 'PAYROLLS', 'ALL') and
 haou.name = nvl(:p_business_group, haou.name)
union all --Q7 roi_line
select
 cbagv.bank_account_id,
 cbagv.bank_account_name,
 cbagv.masked_account_num,
 cbbv.bank_name,
 cbbv.bank_branch_name branch_name,
 xep.name legal_entity,
 'ROI_LINE' type1,
 'RECEIPT' type2,
 null supplier_customer,
 c999iv.trx_date trx_date,
 to_date(null) maturity_date,
 c999iv.trx_number trx_number,
 null payment_method,
 c999iv.currency_code transaction_currency,
 50 transaction_order,
 to_number(null) batch_id,
 null batch_name,
 null remittance_number,
 null batch_currency,
 null batch_bank_account,
 to_date(null) batch_date,
 c999iv.cleared_date cleared_date,
 c999iv.amount amount,
 decode(c999iv.currency_code, cbagv.currency_code, c999iv.amount, nvl(c999iv.acctd_amount, c999iv.amount)) account_amount,
 decode(c999iv.currency_code, cbagv.currency_code, c999iv.cleared_amount, nvl(c999iv.acctd_cleared_amount, c999iv.cleared_amount)) account_cleared_amount,
 null org_name,
 cbagv.currency_code bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 ce_999_interface_v   c999iv,
 ce_bank_accts_gt_v   cbagv,
 ce_bank_branches_v   cbbv,
 xle_entity_profiles  xep,
 gl_code_combinations gcc
where
 cbagv.bank_branch_id = cbbv.branch_party_id and
 cbagv.bank_account_id = c999iv.bank_account_id and
 xep.legal_entity_id = cbagv.account_owner_org_id and
 gcc.code_combination_id = cbagv.asset_code_combination_id and
 c999iv.status = nvl(cbagv.recon_oi_cleared_status, '#') and
 c999iv.cleared_date >= nvl(:p_date_from, c999iv.cleared_date) and
 c999iv.cleared_date <= nvl(:p_date_to, c999iv.cleared_date) and
 :p_batch_or_trx = 'T' and
 :p_type in ('ROI_LINES', 'ALL') and
 c999iv.trx_type = 'CASH'
union all
select --Q8 roi_line
 cbagv.bank_account_id,
 cbagv.bank_account_name,
 cbagv.masked_account_num,
 cbbv.bank_name,
 cbbv.bank_branch_name branch_name,
 xep.name legal_entity,
 'ROI_LINE' type1,
 'PAYMENT' type2,
 null supplier_customer,
 c999iv.trx_date trx_date,
 to_date(null) maturity_date,
 c999iv.trx_number trx_number,
 null payment_method,
 c999iv.currency_code transaction_currency,
 60 transaction_order,
 to_number(null) batch_id,
 null batch_name,
 null remittance_number,
 null batch_currency,
 null batch_bank_account,
 to_date(null) batch_date,
 c999iv.cleared_date cleared_date,
 c999iv.amount amount,
 decode(c999iv.currency_code, cbagv.currency_code, c999iv.amount, nvl(c999iv.acctd_amount, c999iv.amount)) account_amount,
 decode(c999iv.currency_code, cbagv.currency_code, c999iv.cleared_amount, nvl(c999iv.acctd_cleared_amount, c999iv.cleared_amount)) account_cleared_amount,
 null org_name,
 cbagv.currency_code bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 ce_999_interface_v   c999iv,
 ce_bank_accts_gt_v   cbagv,
 ce_bank_branches_v   cbbv,
 xle_entity_profiles  xep,
 gl_code_combinations gcc
where
 cbagv.bank_branch_id = cbbv.branch_party_id and
 cbagv.bank_account_id = c999iv.bank_account_id and
 c999iv.status = nvl(cbagv.recon_oi_cleared_status, '#') and
 xep.legal_entity_id = cbagv.account_owner_org_id and
 gcc.code_combination_id = cbagv.asset_code_combination_id and
 c999iv.cleared_date >= nvl(:p_date_from, c999iv.cleared_date) and
 c999iv.cleared_date <= nvl(:p_date_to, c999iv.cleared_date) and
 :p_batch_or_trx = 'T' and
 :p_type in ('ROI_LINES','ALL') and
 c999iv.trx_type = 'PAYMENT'
union all
select --Q9 xtr_line
 cbagv.bank_account_id,
 cbagv.bank_account_name,
 cbagv.masked_account_num,
 cbbv.bank_name,
 cbbv.bank_branch_name branch_name,
 xep.name legal_entity,
 'XTR_LINE' type1,
 'RECEIPT' type2,
 null supplier_customer,
 c185rv.trx_date trx_date,
 to_date(null) maturity_date,
 c185rv.trx_number trx_number,
 null payment_method,
 c185rv.currency_code transaction_currency,
 50 transaction_order,
 to_number(null) batch_id,
 null batch_name,
 null remittance_number,
 null batch_currency,
 null batch_bank_account,
 to_date(null) batch_date,
 c185rv.cleared_date cleared_date,
 c185rv.amount amount,
 c185rv.bank_account_amount account_amount,
 c185rv.amount_cleared account_cleared_amount,
 xep2.name org_name,
 cbagv.currency_code bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 ce_185_reconciled_v  c185rv,
 ce_bank_accts_gt_v   cbagv,
 ce_bank_branches_v   cbbv,
 xle_entity_profiles  xep,
 xle_entity_profiles  xep2,
 gl_code_combinations gcc
where
 cbagv.bank_branch_id = cbbv.branch_party_id and
 cbagv.bank_account_id = c185rv.bank_account_id and
 xep.legal_entity_id = cbagv.account_owner_org_id and
 xep2.legal_entity_id = c185rv.legal_entity_id and
 gcc.code_combination_id = cbagv.asset_code_combination_id and
 c185rv.cleared_date >= nvl(:p_date_from, c185rv.cleared_date) and
 c185rv.cleared_date <= nvl(:p_date_to, c185rv.cleared_date) and
 :p_batch_or_trx = 'T' and
 :p_type in ( 'XTR_LINES', 'ALL') and
 c185rv.trx_type = 'CASH' and
 xep2.name = nvl(:p_legal_entity,xep2.name)
union all
select --Q10 xtr_line
 cbagv.bank_account_id,
 cbagv.bank_account_name,
 cbagv.masked_account_num,
 cbbv.bank_name bank_name,
 cbbv.bank_branch_name branch_name,
 xep.name legal_entity,
 'XTR_LINE' type2,
 'PAYMENT' type2,
 null supplier_customer,
 c185rv.trx_date trx_date,
 to_date(null) maturity_date,
 c185rv.trx_number trx_number,
 null payment_method,
 c185rv.currency_code transaction_currency,
 60 transaction_order,
 to_number(null) batch_id,
 null batch_name,
 null remittance_number,
 null batch_currency,
 null batch_bank_account,
 to_date(null) batch_date,
 c185rv.cleared_date cleared_date,
 c185rv.amount amount,
 c185rv.bank_account_amount account_amount,
 c185rv.amount_cleared account_cleared_amount,
 xep2.name org_name,
 cbagv.currency_code bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 ce_185_reconciled_v  c185rv,
 ce_bank_accts_gt_v   cbagv,
 ce_bank_branches_v   cbbv,
 xle_entity_profiles  xep,
 xle_entity_profiles  xep2,
 gl_code_combinations gcc
where
 cbagv.bank_branch_id = cbbv.branch_party_id and
 cbagv.bank_account_id = c185rv.bank_account_id and
 xep.legal_entity_id = cbagv.account_owner_org_id and
 xep2.legal_entity_id = c185rv.legal_entity_id and
 gcc.code_combination_id = cbagv.asset_code_combination_id and
 c185rv.cleared_date >= nvl(:p_date_from, c185rv.cleared_date) and
 c185rv.cleared_date <= nvl(:p_date_to, c185rv.cleared_date) and
 :p_batch_or_trx = 'T' and
 :p_type in ( 'XTR_LINES', 'ALL') and
 c185rv.trx_type = 'PAYMENT' and
 xep2.name = nvl(:p_legal_entity,xep2.name)
union all --Q11 cashflow receipt
select
 cbagv.bank_account_id,
 cbagv.bank_account_name,
 cbagv.masked_account_num,
 hp_bank.party_name bank_name,
 hp_branch.party_name branch_name,
 cspg.name legal_entity,
 'CASHFLOW' type1,
 'RECEIPT' type2,
 null supplier_customer,
 cc.cashflow_date trx_date,
 to_date(null) maturity_date,
 nvl(cc.bank_trxn_number, cc.cashflow_id) trx_number,
 null payment_method,
 cc.cashflow_currency_code transaction_currency,
 70 transaction_order,
 to_number(null) batch_id,
 null batch_name,
 null remittance_number,
 null batch_currency,
 null batch_bank_account,
 to_date(null) batch_date,
 cc.cleared_date cleared_date,
 cc.cashflow_amount amount,
 decode(cc.cashflow_currency_code, cbagv.currency_code, cc.cashflow_amount, nvl(cc.base_amount, cc.cashflow_amount)) account_amount,
 ccah.cleared_amount account_cleared_amount,
 xep2.name org_name,
 cbagv.currency_code bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 ce_bank_accts_gt_v      cbagv,
 ce_cashflows            cc,
 ce_cashflow_acct_h      ccah,
 hz_parties              hp_bank,
 hz_parties              hp_branch,
 ce_security_profiles_gt cspg,
 xle_entity_profiles     xep2,
 gl_code_combinations    gcc
where
 cbagv.bank_branch_id = hp_branch.party_id and
 cbagv.bank_id = hp_bank.party_id and
 cbagv.account_owner_org_id = cspg.organization_id and
 cspg.organization_type = 'LEGAL_ENTITY' and
 cbagv.bank_account_id = cc.cashflow_bank_account_id and
 cbagv.account_owner_org_id = cc.cashflow_legal_entity_id and
 xep2.legal_entity_id = cc.cashflow_legal_entity_id and
 gcc.code_combination_id = cbagv.asset_code_combination_id and
 cc.cashflow_status_code in ('CLEARED','RECONCILED') and
 cc.cleared_date >= nvl(:p_date_from, cc.cleared_date) and
 cc.cleared_date <= nvl(:p_date_to, cc.cleared_date) and
 cc.cashflow_direction = 'RECEIPT' and
 ccah.cashflow_id = cc.cashflow_id and
 ccah.current_record_flag = 'Y' and
 ccah.event_type in ('CE_BAT_CLEARED','CE_STMT_RECORDED') and
 :p_batch_or_trx = 'T' and
 :p_type in ('CASHFLOWS', 'ALL') and
 xep2.name = nvl(:p_legal_entity,xep2.name)
union all --Q12 cashflow payments
select
 cbagv.bank_account_id,
 cbagv.bank_account_name,
 cbagv.masked_account_num,
 hp_bank.party_name bank_name,
 hp_branch.party_name branch_name,
 cspg.name legal_entity,
 'CASHFLOW' type1,
 'PAYMENT' type2,
 null supplier_customer,
 cc.cashflow_date trx_date,
 to_date(null) maturity_date,
 nvl(cc.bank_trxn_number, cc.cashflow_id) trx_number,
 null payment_method,
 cc.cashflow_currency_code transaction_currency,
 80 transaction_order,
 to_number(null) batch_id,
 null batch_name,
 null remittance_number,
 null batch_currency,
 null batch_bank_account,
 to_date(null) batch_date,
 cc.cleared_date cleared_date,
 ccah.cleared_amount account_cleared_amount,
 cc.cashflow_amount amount,
 decode(cc.cashflow_currency_code, cbagv.currency_code, cc.cashflow_amount, nvl(cc.base_amount, cc.cashflow_amount)) account_amount,
 xep2.name org_name,
 cbagv.currency_code bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 ce_bank_accts_gt_v      cbagv,
 ce_cashflows            cc,
 ce_cashflow_acct_h      ccah,
 hz_parties              hp_bank,
 hz_parties              hp_branch,
 ce_security_profiles_gt cspg,
 xle_entity_profiles     xep2,
 gl_code_combinations    gcc
where
 cbagv.bank_branch_id = hp_branch.party_id and
 cbagv.bank_id = hp_bank.party_id and
 cbagv.account_owner_org_id = cspg.organization_id and
 cspg.organization_type = 'LEGAL_ENTITY' and
 cbagv.bank_account_id = cc.cashflow_bank_account_id and
 cbagv.account_owner_org_id = cc.cashflow_legal_entity_id and
 xep2.legal_entity_id = cc.cashflow_legal_entity_id and
 gcc.code_combination_id = cbagv.asset_code_combination_id and
 cc.cashflow_status_code in ('CLEARED','RECONCILED') and
 cc.cleared_date >= nvl(:p_date_from, cc.cleared_date) and
 cc.cleared_date <= nvl(:p_date_to, cc.cleared_date) and
 cc.cashflow_direction = 'PAYMENT' and
 ccah.cashflow_id = cc.cashflow_id and
 ccah.current_record_flag = 'Y' and
 ccah.event_type IN ('CE_BAT_CLEARED','CE_STMT_RECORDED') and
 :p_batch_or_trx = 'T' and
 :p_type IN ('CASHFLOWS', 'ALL') and
 xep2.name = nvl(:p_legal_entity,xep2.name)
)
--
-- Main Query Starts Here
--
select
 q.legal_entity,
 q.bank_account_name,
 q.bank_account_num,
 q.bacurr bank_account_currency,
 q.bank_name,
 q.branch_name,
 case q.transaction_order
 when 10 then 'Receipts'
 when 30 then 'Payments'
 when 40 then 'Payroll Payments'
 when 50 then 'Open Interface Receipts'
 when 60 then 'Open Interface Payments'
 when 70 then 'Cashflow Receipts'
 when 80 then 'Cashflow Payments'
 else 'Other'
 end cleared_transaction_type,
 q.supplier_customer agent,
 q.trx_date "Remit/Payment Date",
 q.maturity_date,
 q.payment_method,
 q.trx_number "Receipt/Payment Number",
 q.batch_id,
 q.batch_name,
 q.batch_date,
 nvl(q.batch_bank_account,'Batch Bank Not Specified')  batch_bank_account,
 nvl(q.batch_currency,'Batch Currency Not Specified') batch_currency,
 q.transaction_currency,
 q.amount,
 q.account_amount,
 q.cleared_date,
 q.account_cleared_amount,
 case when q.type2 = 'PAYMENT'
 then -1 * q.account_cleared_amount
 else q.account_cleared_amount
 end net_account_cleared_amount,
 case when q.type1 not in ('PAYROLL','XTR_LINE','CASHFLOW')
 then q.org_name
 end operating_unit,
 case when q.type1 in ('PAYROLL')
 then q.org_name
 end payroll_business_group,
 case when q.type1 in ('XTR_LINE','CASHFLOW')
 then q.org_name
 end treasury_legal_entity,
 --
 -- GL Cash Account Details
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'GL_BALANCING', 'Y', 'VALUE') gl_company_code,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'GL_BALANCING', 'Y', 'DESCRIPTION') gl_company_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'GL_ACCOUNT', 'Y', 'VALUE') gl_account_code,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') gl_account_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'FA_COST_CTR', 'Y', 'VALUE') gl_cost_center_code,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'FA_COST_CTR', 'Y', 'DESCRIPTION') gl_cost_center_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'ALL', 'Y', 'VALUE') gl_cash_account,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'ALL', 'Y', 'DESCRIPTION') gl_cash_account_desc,
 -- pivot labels
 q.bank_name || ' - ' || q.bank_account_num || ' - ' || q.bank_account_name || ' (' || q.bacurr || ')' bank_account_pivot_label,
 q.org_name organization_pivot_label,
 case when to_char(q.batch_id) || q.batch_name is null
 then 'Unbatched Transactions'
 else 'Batched Transactions'
 end  batched_unbatched_flag,
 case when to_char(q.batch_id) || q.batch_name is null
 then 'Unbatched Transactions'
 else to_char(q.batch_date,'YYYY/MM/DD') || ': ' || q.batch_name || ' (' || q.batch_id || ')'
 end batch_pivot_label,
 q.transaction_order
from
 q_cleared_transactions q
where 1=1
order by
 q.legal_entity,
 q.bank_name,
 q.bank_account_num,
 q.transaction_order,
 q.trx_date