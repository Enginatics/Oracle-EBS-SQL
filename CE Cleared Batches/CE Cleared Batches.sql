/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Cleared Batches
-- Description: Description: Transactions - Cleared Payment/Receipt Batches
Application: Cash Management
Source: Cleared Transactions Report
Short Name: CEXCLEAR
DB package: CE_CEXCLEAR_XMLP_PKG (required to initialize security)
-- Excel Examle Output: https://www.enginatics.com/example/ce-cleared-batches/
-- Library Link: https://www.enginatics.com/reports/ce-cleared-batches/
-- Run Report: https://demo.enginatics.com/

with q_cleared_batches as
(
select --Q3 payment batch
 cbagv.bank_account_id,
 cbagv.bank_account_name,
 cbagv.bank_account_num,
 hp_bank.party_name bank_name,
 hp_branch.party_name branch_name,
 xep.name legal_entity,
 'PAYMENT' type,
 ipia.payment_date batch_date,
 ipia.payment_currency_code currency_code,
 20 transaction_order,
 ipia.payment_instruction_id batch_id,
 to_char(ipia.payment_instruction_id ) batch_name,
 to_char(ipia.payment_instruction_id ) remittance_number,
 (select sum(nvl(aca2.amount,0))
	 from   ap_checks_all aca2,
        	iby_payments_all ipa2
	 where  ipa2.payment_instruction_id = ipia.payment_instruction_id and
  	      aca2.payment_id = ipa2.payment_id
 ) amount,
 (select sum(nvl(aca2.base_amount, nvl(aca2.amount,0)))
	 from   ap_checks_all aca2,
        	iby_payments_all ipa2
	 where  ipa2.payment_instruction_id = ipia.payment_instruction_id and
  	      aca2.payment_id = ipa2.payment_id
 ) account_amount,
 (select sum(nvl(aca2.cleared_amount,0))
	 from   ap_checks_all aca2,
         iby_payments_all ipa2
	 where  ipa2.payment_instruction_id = ipia.payment_instruction_id and
         aca2.payment_id = ipa2.payment_id and
		       aca2.cleared_date is not null
 ) cleared_amount,
 (select sum(round(nvl(aca2.cleared_amount,0) * nvl(aca2.exchange_rate,1),2))
	 from   ap_checks_all aca2,
         iby_payments_all ipa2
	 where  ipa2.payment_instruction_id = ipia.payment_instruction_id and
         aca2.payment_id = ipa2.payment_id and
		       aca2.cleared_date is not null
 ) account_cleared_amount,
 cspg.name org_name,
 cbagv.currency_code bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 iby_pay_instructions_all ipia,
 ce_bank_accts_gt_v       cbagv,
 ce_lookups               cl,
 hz_parties               hp_bank,
 hz_parties               hp_branch,
 ce_bank_acct_uses_all    cbaua,
 xle_entity_profiles      xep,
 ce_security_profiles_gt  cspg,
 gl_code_combinations     gcc
where
 ipia.internal_bank_account_id = cbagv.bank_account_id and
 cbagv.bank_branch_id = hp_branch.party_id and
 cbagv.bank_id = hp_bank.party_id and
 cbagv.bank_account_id = cbaua.bank_account_id and
 cbagv.ap_use_allowed_flag = 'Y' and
 cbaua.org_id = ipia.org_id and
 xep.legal_entity_id = cbagv.account_owner_org_id and
 cbaua.org_id = cspg.organization_id and
 cspg.organization_type = 'OPERATING_UNIT' and
 gcc.code_combination_id (+) = cbagv.asset_code_combination_id and
 cl.lookup_type = 'BATCH_TYPE' and
 cl.lookup_code = 'PAYMENT' and
 :p_type in ('AR_AND_AP', 'PAYMENTS','ALL') and
 :p_batch_or_trx = 'B' and
 cspg.name = NVL(:p_operating_unit, cspg.name ) and
 exists
  (select
    null
   from
    ap_checks_all     aca2,
    iby_fd_payments_v ifpv2
   where
    ifpv2.payment_instruction_id = ipia.payment_instruction_id and
    aca2.payment_id = ifpv2.payment_id and
    aca2.org_id = cbaua.org_id and
    aca2.cleared_date is not null and
    aca2.cleared_date >= nvl(:p_date_from, aca2.cleared_date) and
    aca2.cleared_date <= nvl(:p_date_to,aca2.cleared_date)
  )
union all --Q4 receipt batch
select
 cbagv.bank_account_id,
 cbagv.bank_account_name,
 cbagv.bank_account_num,
 hp_bank.party_name bank_name,
 hp_branch.party_name branch_name,
 xep.name legal_entity,
 'RECEIPT' type,
 aba.batch_date batch_date,
 aba.currency_code currency_code,
 10 transaction_order,
 aba.batch_id batch_id,
 aba.name batch_name,
 aba.bank_deposit_number remittance_number,
 (select sum(nvl(arch2.amount,0))
  from   ar_cash_receipt_history arch2
  where  arch2.batch_id = aba.batch_id and
         arch2.status = 'CLEARED' and
         arch2.current_record_flag = 'Y'
 ) amount,
 (select sum(nvl(arch2.acctd_amount,0))
  from   ar_cash_receipt_history arch2
  where  arch2.batch_id = aba.batch_id and
         arch2.status = 'CLEARED' and
         arch2.current_record_flag = 'Y'
 ) account_amount,
 (select sum(nvl(arch2.amount,0))
  from   ar_cash_receipt_history arch2
  where  arch2.batch_id = aba.batch_id and
         arch2.status = 'CLEARED' and
         arch2.current_record_flag = 'Y'
 ) cleared_amount,
 (select sum(nvl(arch2.acctd_amount,0))
  from   ar_cash_receipt_history arch2
  where  arch2.batch_id = aba.batch_id and
         arch2.status = 'CLEARED' and
         arch2.current_record_flag = 'Y'
 ) account_cleared_amount,
 cspg.name org_name,
 cbagv.currency_code bacurr,
 gcc.code_combination_id asset_ccid,
 gcc.chart_of_accounts_id coaid
from
 ar_batches_all           aba,
 ce_bank_accts_gt_v       cbagv,
 ce_lookups               cl,
 hz_parties               hp_bank,
 hz_parties               hp_branch,
 ce_bank_acct_uses_all    cbaua,
 xle_entity_profiles      xep,
 ce_security_profiles_gt  cspg,
 gl_code_combinations     gcc
where
 cbagv.bank_branch_id = hp_branch.party_id and
 cbagv.bank_id = hp_bank.party_id and
 cbagv.bank_account_id = cbaua.bank_account_id and
 cbaua.ar_use_enable_flag = 'Y' and
 xep.legal_entity_id = cbagv.account_owner_org_id and
 cbaua.org_id = cspg.organization_id and
 cspg.organization_type = 'OPERATING_UNIT' and
 gcc.code_combination_id (+)  = cbagv.asset_code_combination_id and
 cbaua.bank_acct_use_id = aba.remit_bank_acct_use_id and
 cbaua.org_id = aba.org_id and
 cl.lookup_type = 'BATCH_TYPE' and
 cl.lookup_code = 'RECEIPT' and
 :p_type in ('AR_AND_AP', 'RECEIPTS','ALL') and
 :p_batch_or_trx = 'B' and
 cspg.name = NVL(:p_operating_unit, cspg.name ) and
 exists
  (select
    null
   from
    ar_cash_receipt_history_all acrha1,
    ar_cash_receipt_history_all acrha2
   where
    acrha1.cash_receipt_id = acrha2.cash_receipt_id and
    acrha2.batch_id = aba.batch_id and
    acrha2.org_id = cbaua.org_id and
    acrha1.status = 'CLEARED' and
    acrha1.trx_date >= nvl(:p_date_from, acrha1.trx_date) and
    acrha1.trx_date <= nvl(:p_date_to,acrha1.trx_date) and
    acrha1.current_record_flag = 'Y'
  )
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
 case q.type
 when 'RECEIPT' then 'Remittance Batch'
 when 'PAYMENT' then 'Payment Batch'
 else 'Other'
 end cleared_batch_type,
 q.batch_date "Remit/Payment Date",
 q.batch_name,
 q.remittance_number "Deposit/Reference Number",
 q.currency_code batch_currency,
 q.amount,
 q.account_amount,
 q.cleared_amount,
 q.account_cleared_amount,
 case when q.type = 'PAYMENT'
 then -1 * q.cleared_amount
 else q.cleared_amount
 end net_cleared_amount,
 case when q.type = 'PAYMENT'
 then -1 * q.account_cleared_amount
 else q.account_cleared_amount
 end net_account_cleared_amount,
 q.org_name operating_unit,
 --
 -- GL Cash Account Details
 nvl2(q.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'GL_BALANCING', 'Y', 'VALUE'),null) gl_company_code,
 nvl2(q.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'GL_BALANCING', 'Y', 'DESCRIPTION'),null) gl_company_desc,
 nvl2(q.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'GL_ACCOUNT', 'Y', 'VALUE'),null) gl_account_code,
 nvl2(q.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'GL_ACCOUNT', 'Y', 'DESCRIPTION'),null) gl_account_desc,
 nvl2(q.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'FA_COST_CTR', 'Y', 'VALUE'),null) gl_cost_center_code,
 nvl2(q.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'FA_COST_CTR', 'Y', 'DESCRIPTION'),null) gl_cost_center_desc,
 nvl2(q.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'ALL', 'Y', 'VALUE'),null) gl_cash_account,
 nvl2(q.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', q.coaid, NULL, q.asset_ccid, 'ALL', 'Y', 'DESCRIPTION'),null) gl_cash_account_desc,
 -- pivot labels
 q.bank_name || ' - ' || q.bank_account_num || ' - ' || q.bank_account_name || ' (' || q.bacurr || ')' bank_account_pivot_label,
 q.transaction_order
from
 q_cleared_batches q
where 1=1
order by
 q.legal_entity,
 q.bank_name,
 q.bank_account_num,
 q.transaction_order,
 q.batch_date