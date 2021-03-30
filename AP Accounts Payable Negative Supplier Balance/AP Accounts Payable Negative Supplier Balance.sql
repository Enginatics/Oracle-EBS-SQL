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
 x.ACCOUNT "Liability Account"
,x.THIRD_PARTY_NAME "Supplier Name"
&sum_or_detail_cols
from
 (select
    xtb.ACCOUNT
  ,xtb.THIRD_PARTY_NAME
  ,xtb.USER_TRX_IDENTIFIER_VALUE_3
  ,xtb.USER_TRX_IDENTIFIER_VALUE_10
  ,xtb.USER_TRX_IDENTIFIER_VALUE_8
  ,xtb.LEDGER_CURRENCY_CODE
  ,xtb.SRC_ACCTD_ROUNDED_ORIG_AMT
  ,xtb.SRC_ACCTD_ROUNDED_REM_AMT
  ,sum(xtb.SRC_ACCTD_ROUNDED_REM_AMT) over(partition by xtb.ACCOUNT,xtb.THIRD_PARTY_NAME)  sum_supp_liability
  from 
    (       &P_SQL_STATEMENT
     AND :L_RUN_DETAIL_REPORT = 'Y'
    ) xtb
 ) x
where
      1=1
and x.sum_supp_liability < 0
&summary_group_by