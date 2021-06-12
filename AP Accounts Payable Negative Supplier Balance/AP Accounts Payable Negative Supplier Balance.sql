/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Accounts Payable Negative Supplier Balance
-- Description: Application: Payables
Source: Accounts Payable Negative Supplier Balance
Short Name: APXNVBAL
DB package: XLA_TB_AP_REPORT_PVT
-- Excel Examle Output: https://www.enginatics.com/example/ap-accounts-payable-negative-supplier-balance/
-- Library Link: https://www.enginatics.com/reports/ap-accounts-payable-negative-supplier-balance/
-- Run Report: https://demo.enginatics.com/

select 
 x.account liability_account
,x.third_party_name supplier_name
&sum_or_detail_cols
from
 (select
    xtb.account
  ,xtb.third_party_name
  ,xtb.user_trx_identifier_value_3
  ,xtb.user_trx_identifier_value_10
  ,xtb.user_trx_identifier_value_8
  ,xtb.ledger_currency_code
  ,xtb.src_acctd_rounded_orig_amt
  ,xtb.src_acctd_rounded_rem_amt
  ,sum(xtb.src_acctd_rounded_rem_amt) over(partition by xtb.account,xtb.third_party_name)  sum_supp_liability
  from 
    (       &p_sql_statement
     and :l_run_detail_report = 'Y'
    ) xtb
 ) x
where
      1=1
and x.sum_supp_liability < 0
&summary_group_by