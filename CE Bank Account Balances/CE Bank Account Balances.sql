/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Bank Account Balances
-- Description: Application: Cash Management
Description: Bank Accounts - Balances Report

Provides equivalent functionality to the following standard Oracle Forms/Reports
- Bank Account Balances OAF Page
- Bank Account Balance Range Day Report
- Bank Account Balance Single Date Report
- Bank Account Balance Actual vs Projected Report

Single (As Of) Date Report
- Specify the required Date in the As Of Date parameter
- Specify Yes in the 'Bring Forward Prior Balances' if you want to roll the most recent prior balance entries forward if a balance does not exist on the specified As Of Date
- Specify No in the  'Bring Forward Prior Balances' if you only want to see the balances that have been entered on the specified As Of Date.
- Applicable Templates:
  Pivot: As of Date Summary by Currency and Account
  Detail As of Date/Range Date Report  

Range Day Report
- Specify the required date range in the Balance Date From/To Parameters
- When run in this mode the report shows the balances entered for every date within the date range.
- Balances are not rolled forward in this mode.
- Applicable Templates:
  Detail As of Date/Range Date Report  

Actual vs Projected Report
- The report includes actual and projected balances in both As Of Date and Date Range Modes
- Optionally specify the actual balance type to be compared to the projected balance in the  'Actual vs Projected Balance Type' parameter. When specified, the variance between the actual balance and projected balance will be displayed in the report.
- Applicable Templates:
  Pivot: As of Date Summary by Currency and Account
  Detail As of Date/Range Date Report  

Sources: 
Bank Account Balance Single Date Report (CEBABSGR)
Bank Account Balance Range Day Report (CEBABRGR)
Bank Account Balance Actual vs Projected Report (CEBABAPR)
DB package:  CE_CEXSTMRR_XMLP_PKG (required to initialize security)

-- Excel Examle Output: https://www.enginatics.com/example/ce-bank-account-balances/
-- Library Link: https://www.enginatics.com/reports/ce-bank-account-balances/
-- Run Report: https://demo.enginatics.com/

with ce_bank_acct_bal_qry1 as
(
select
cbab.bank_account_id,
cbab.balance_date_ balance_date,
case when :p_as_of_date is null or nvl(:p_bf_flag,'N')='N' then cbab.balance_date when trunc(cbab.balance_date)=:p_as_of_date and cbab.ledger_balance is not null then cbab.balance_date else cbab2.actual_balance_date end actual_balance_date,
case when :p_as_of_date is null or nvl(:p_bf_flag,'N')='N' then cbab.ledger_balance when trunc(cbab.balance_date)=:p_as_of_date and cbab.ledger_balance is not null then cbab.ledger_balance else cbab2.ledger_balance end ledger_balance,
case when :p_as_of_date is null or nvl(:p_bf_flag,'N')='N' then cbab.available_balance when trunc(cbab.balance_date)=:p_as_of_date and cbab.available_balance is not null then cbab.available_balance else cbab2.available_balance end available_balance,
case when :p_as_of_date is null or nvl(:p_bf_flag,'N')='N' then cbab.value_dated_balance when trunc(cbab.balance_date)=:p_as_of_date and cbab.value_dated_balance is not null then cbab.value_dated_balance else cbab2.value_dated_balance end value_dated_balance,
case when :p_as_of_date is null or nvl(:p_bf_flag,'N')='N' then cbab.one_day_float when trunc(cbab.balance_date)=:p_as_of_date and cbab.one_day_float is not null then cbab.one_day_float else cbab2.one_day_float end one_day_float,
case when :p_as_of_date is null or nvl(:p_bf_flag,'N')='N' then cbab.two_day_float when trunc(cbab.balance_date)=:p_as_of_date and cbab.two_day_float is not null then cbab.two_day_float else cbab2.two_day_float end two_day_float,
case when :p_as_of_date is null or nvl(:p_bf_flag,'N')='N' then cbab.average_close_ledger_mtd when trunc(cbab.balance_date)=:p_as_of_date and cbab.average_close_ledger_mtd is not null then cbab.average_close_ledger_mtd else cbab2.average_close_ledger_mtd end average_close_ledger_mtd,
case when :p_as_of_date is null or nvl(:p_bf_flag,'N')='N' then cbab.average_close_available_mtd when trunc(cbab.balance_date)=:p_as_of_date and cbab.average_close_available_mtd is not null then cbab.average_close_available_mtd else cbab2.average_close_available_mtd end average_close_available_mtd,
case when :p_as_of_date is null or nvl(:p_bf_flag,'N')='N' then cbab.average_close_ledger_ytd when trunc(cbab.balance_date)=:p_as_of_date and cbab.average_close_ledger_ytd is not null then cbab.average_close_ledger_ytd else cbab2.average_close_ledger_ytd end average_close_ledger_ytd,
case when :p_as_of_date is null or nvl(:p_bf_flag,'N')='N' then cbab.average_close_available_ytd when trunc(cbab.balance_date)=:p_as_of_date and cbab.average_close_available_ytd is not null then cbab.average_close_available_ytd else cbab2.average_close_available_ytd end average_close_available_ytd,
case when :p_as_of_date is null or nvl(:p_bf_flag,'N')='N' then cbab.projected_balance when trunc(cbab.balance_date)=:p_as_of_date and cbab.projected_balance is not null then cbab.projected_balance else cpb2.projected_balance end projected_balance,
case when :p_as_of_date is not null and :p_bf_flag='Y' and not (trunc(cbab.balance_date)=:p_as_of_date and cbab.ledger_balance is not null) then 'Ledger ' end ledger_bf,
case when :p_as_of_date is not null and :p_bf_flag='Y' and not (trunc(cbab.balance_date)=:p_as_of_date and cbab.available_balance is not null) then 'Available ' end available_bf,
case when :p_as_of_date is not null and :p_bf_flag='Y' and not (trunc(cbab.balance_date)=:p_as_of_date and cbab.value_dated_balance is not null) then 'ValueDated ' end value_dated_bf,
case when :p_as_of_date is not null and :p_bf_flag='Y' and not (trunc(cbab.balance_date)=:p_as_of_date and cbab.one_day_float is not null) then 'OneDayFloat ' end one_day_float_bf,
case when :p_as_of_date is not null and :p_bf_flag='Y' and not (trunc(cbab.balance_date)=:p_as_of_date and cbab.two_day_float is not null) then 'TwoDayFloat ' end two_day_float_bf,
case when :p_as_of_date is not null and :p_bf_flag='Y' and not (trunc(cbab.balance_date)=:p_as_of_date and cbab.average_close_ledger_mtd is not null) then 'AvgCloseLdgMTD ' end avg_close_ledger_mtd_bf,
case when :p_as_of_date is not null and :p_bf_flag='Y' and not (trunc(cbab.balance_date)=:p_as_of_date and cbab.average_close_available_mtd is not null) then 'AvgCloseAvailMTD ' end avg_close_available_mtd_bf,
case when :p_as_of_date is not null and :p_bf_flag='Y' and not (trunc(cbab.balance_date)=:p_as_of_date and cbab.average_close_ledger_ytd is not null) then 'AvgCloseLdgYTD ' end avg_close_ledger_ytd_bf,
case when :p_as_of_date is not null and :p_bf_flag='Y' and not (trunc(cbab.balance_date)=:p_as_of_date and cbab.average_close_available_ytd is not null) then 'AvgCloseAvailYTD ' end avg_close_available_ytd_bf,
case when :p_as_of_date is not null and :p_bf_flag='Y' and not (trunc(cbab.balance_date)=:p_as_of_date and cbab.projected_balance is not null) then 'Projected ' end projected_bf
from
(
select
nvl(cbab.bank_account_id,cpb.bank_account_id) bank_account_id_,
nvl(cbab.balance_date,cpb.balance_date) balance_date_,
cbab.*,
cpb.projected_balance
from
ce_bank_acct_balances cbab full join
ce_projected_balances cpb
on
cbab.bank_account_id=cpb.bank_account_id and
cbab.balance_date=cpb.balance_date
) cbab,
(
select distinct
cbab.bank_account_id,
max(nvl2(cbab.ledger_balance,cbab.balance_date,null)) over (partition by cbab.bank_account_id) actual_balance_date,
max(cbab.ledger_balance) keep (dense_rank last order by nvl2(cbab.ledger_balance,1,0), cbab.balance_date, cbab.bank_acct_balance_id) over (partition by cbab.bank_account_id) ledger_balance,
max(cbab.available_balance) keep (dense_rank last order by nvl2(cbab.available_balance,1,0), cbab.balance_date, cbab.bank_acct_balance_id) over (partition by cbab.bank_account_id) available_balance,
max(cbab.value_dated_balance) keep (dense_rank last order by nvl2(cbab.value_dated_balance,1,0), cbab.balance_date, cbab.bank_acct_balance_id) over (partition by cbab.bank_account_id) value_dated_balance,
max(cbab.one_day_float) keep (dense_rank last order by nvl2(cbab.one_day_float,1,0), cbab.balance_date, cbab.bank_acct_balance_id) over (partition by cbab.bank_account_id) one_day_float,
max(cbab.two_day_float) keep (dense_rank last order by nvl2(cbab.two_day_float,1,0), cbab.balance_date, cbab.bank_acct_balance_id) over (partition by cbab.bank_account_id) two_day_float,
max(cbab.average_close_ledger_mtd) keep (dense_rank last order by nvl2(cbab.average_close_ledger_mtd,1,0), cbab.balance_date, cbab.bank_acct_balance_id) over (partition by cbab.bank_account_id) average_close_ledger_mtd,
max(cbab.average_close_available_mtd) keep (dense_rank last order by nvl2(cbab.average_close_available_mtd,1,0), cbab.balance_date, cbab.bank_acct_balance_id) over (partition by cbab.bank_account_id) average_close_available_mtd,
max(cbab.average_close_ledger_ytd) keep (dense_rank last order by nvl2(cbab.average_close_ledger_ytd,1,0), cbab.balance_date, cbab.bank_acct_balance_id) over (partition by cbab.bank_account_id) average_close_ledger_ytd,
max(cbab.average_close_available_ytd) keep (dense_rank last order by nvl2(cbab.average_close_available_ytd,1,0), cbab.balance_date, cbab.bank_acct_balance_id) over (partition by cbab.bank_account_id) average_close_available_ytd
from
ce_bank_acct_balances cbab
where
:p_as_of_date is not null and :p_bf_flag='Y' and
cbab.balance_date<:p_as_of_date
) cbab2,
(
select distinct
cpb.bank_account_id,
max(cpb.projected_balance) keep (dense_rank last order by nvl2(cpb.projected_balance,1,0), cpb.balance_date, cpb.projected_balance_id) over (partition by cpb.bank_account_id) projected_balance
from
ce_projected_balances cpb
where
:p_as_of_date is not null and :p_bf_flag='Y' and
cpb.balance_date<:p_as_of_date
) cpb2
where
cbab.bank_account_id_=cbab2.bank_account_id(+) and
cbab.bank_account_id_=cpb2.bank_account_id(+)
),
ce_bank_acct_bal_qry2 as
(
select
xep.name legal_entity,
cbacv.masked_account_num,
cbacv.bank_account_name,
cbacv.currency_code bank_account_currency,
ce_bankacct_ba_report_util.get_rate(cbacv.currency_code,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) exchange_rate,
hpb.party_name bank_name,
hpbb.party_name branch_name,
xxen_util.meaning('BA','BALANCE_SERCH_TYPE',260) balance_type,
cbabq1.balance_date,
cbabq1.ledger_balance,
cbabq1.available_balance,
cbabq1.value_dated_balance,
cbabq1.one_day_float,
cbabq1.two_day_float,
cbabq1.projected_balance,
cbabq1.average_close_ledger_mtd average_closing_ledger_mtd,
cbabq1.average_close_available_mtd average_closing_available_mtd,
cbabq1.average_close_ledger_ytd average_closing_ledger_ytd,
cbabq1.average_close_available_ytd average_closing_available_ytd,
cbacv.min_target_balance,
cbacv.max_target_balance,
cbabq1.ledger_bf,
cbabq1.available_bf,
cbabq1.value_dated_bf,
cbabq1.one_day_float_bf,
cbabq1.two_day_float_bf,
cbabq1.projected_bf,
cbabq1.avg_close_ledger_mtd_bf,
cbabq1.avg_close_available_mtd_bf,
cbabq1.avg_close_ledger_ytd_bf,
cbabq1.avg_close_available_ytd_bf,
'BA' type_code,
cbacv.bank_account_id,
gcc.code_combination_id asset_ccid,
gcc.chart_of_accounts_id coaid,
cbabq1.actual_balance_date
from
ce_bank_acct_bal_qry1 cbabq1,
ce_bank_accts_calc_v cbacv,
ce_bank_accts_gt_v cbagv,
gl_code_combinations gcc,
hz_parties hpb,
hz_parties hpbb,
xle_entity_profiles xep
where
2=2 and
cbabq1.bank_account_id=cbacv.bank_account_id and
cbabq1.bank_account_id=cbagv.bank_account_id and
cbagv.asset_code_combination_id=gcc.code_combination_id(+)  and
cbacv.bank_id=hpb.party_id and
cbacv.bank_branch_id=hpbb.party_id and
cbacv.account_owner_org_id=xep.legal_entity_id
union all
select
xep.name legal_entity,
cbacv.masked_account_num,
cc.name bank_account_name,
cbacv.currency_code bank_account_currency,
ce_bankacct_ba_report_util.get_rate(cbacv.currency_code,:p_rep_currency,to_char(:p_rep_exchange_rate_date,'YYYY/MM/DD HH24:MI:SS'),:p_rep_exchange_rate_type) exchange_rate,
hpb.party_name bank_name,
xxen_util.meaning('CP','BALANCE_SERCH_TYPE',260) balance_type,
hpbb.party_name branch_name,
cbab.balance_date,
to_number(null) ledger_balance,
to_number(null) available_balance,
ce_bal_util.get_pool_balance(cc.cashpool_id, cbab.balance_date) value_dated_balance,
to_number(null) one_day_float,
to_number(null) two_day_float,
to_number(null) projected_balance,
to_number(null) average_closing_ledger_mtd,
to_number(null) average_closing_available_mtd,
to_number(null) average_closing_ledger_ytd,
to_number(null) average_closing_available_ytd,
to_number(null) min_target_balance,
to_number(null) max_target_balance,
null ledger_bf,
null available_bf,
null value_dated_bf,
null one_day_float_bf,
null two_day_float_bf,
null projected_bf,
null avg_close_ledger_mtd_bf,
null avg_close_available_mtd_bf,
null avg_close_ledger_ytd_bf,
null avg_close_available_ytd_bf,
'CP' type_code,
cbacv.bank_account_id,
gcc.code_combination_id asset_ccid,
gcc.chart_of_accounts_id coaid,
to_date(null) actual_balance_date
from
ce_bank_accts_calc_v cbacv,
ce_cashpools cc,
(
select distinct
ccsa.cashpool_id,
cbab.balance_date
from
ce_cashpool_sub_accts ccsa,
ce_bank_acct_balances cbab
where
3=3 and
ccsa.account_id=cbab.bank_account_id
) cbab,
ce_bank_accts_gt_v cbagv,
gl_code_combinations gcc,
hz_parties hpb,
hz_parties hpbb,
xle_entity_profiles xep
where
cbacv.bank_account_id=cc.conc_account_id and
cc.cashpool_id=cbab.cashpool_id and
cbacv.bank_account_id=cbagv.bank_account_id and
cbagv.asset_code_combination_id=gcc.code_combination_id(+)  and
cbacv.bank_id=hpb.party_id and
cbacv.bank_branch_id=hpbb.party_id and
cbacv.account_owner_org_id=xep.legal_entity_id
)
--
-- Main Query Starts Here
--
select
cbab.legal_entity,
cbab.masked_account_num bank_account_num,
cbab.bank_account_name,
cbab.bank_account_currency,
cbab.bank_name,
cbab.branch_name,
cbab.balance_type,
nvl(:p_as_of_date,cbab.balance_date) balance_date,
cbab.ledger_balance,
cbab.available_balance,
cbab.value_dated_balance,
cbab.one_day_float,
cbab.two_day_float,
cbab.average_closing_ledger_mtd,
cbab.average_closing_available_mtd,
cbab.average_closing_ledger_ytd,
cbab.average_closing_available_ytd,
cbab.projected_balance,
case :p_proj_variance_type
when 'C'   then cbab.available_balance - cbab.projected_balance -- available balance
when 'CAM' then cbab.average_closing_available_mtd - cbab.projected_balance -- Avg Closing Avail MTD
when 'CAY' then cbab.average_closing_available_ytd - cbab.projected_balance -- Avg Closing Avail YTD
when 'CLM' then cbab.average_closing_ledger_mtd - cbab.projected_balance -- Avg Closing Ledger MTD
when 'CLY' then cbab.average_closing_ledger_ytd - cbab.projected_balance -- Avg Closing Ledger YTD
when 'I'   then cbab.value_dated_balance - cbab.projected_balance -- Value Dated Balance
when 'L'   then cbab.ledger_balance - cbab.projected_balance -- Ledger Balance
when 'O'   then cbab.one_day_float - cbab.projected_balance -- One Day Float
when 'T'   then cbab.two_day_float - cbab.projected_balance -- Two Day Float
end act_vs_proj_variance,
xxen_util.meaning(:p_proj_variance_type,'BANK_ACC_BAL_TYPE',260) variance_type,
cbab.min_target_balance,
cbab.max_target_balance,
case when :p_as_of_date is not null then
nvl2(cbab.ledger_balance               , cbab.ledger_bf                 , null) ||
nvl2(cbab.available_balance            , cbab.available_bf              , null) ||
nvl2(cbab.value_dated_balance          , cbab.value_dated_bf            , null) ||
nvl2(cbab.one_day_float                , cbab.one_day_float_bf          , null) ||
nvl2(cbab.two_day_float                , cbab.two_day_float_bf          , null) ||
nvl2(cbab.projected_balance            , cbab.projected_bf              , null) ||
nvl2(cbab.average_closing_ledger_mtd   , cbab.avg_close_ledger_mtd_bf   , null) ||
nvl2(cbab.average_closing_available_mtd, cbab.avg_close_available_mtd_bf, null) ||
nvl2(cbab.average_closing_ledger_ytd   , cbab.avg_close_ledger_ytd_bf   , null) ||
nvl2(cbab.average_closing_available_ytd, cbab.avg_close_available_ytd_bf, null)
end as_of_date_balances_bf_flag,
-- Statement Details
csh.statement_number,
csh.statement_date,
csh.control_begin_balance statement_opening_balance,
csh.control_end_balance statement_closing_balance,
-- Reporting Currency
:p_rep_currency reporting_currency,
case when cbab.exchange_rate>0 then to_char(cbab.exchange_rate) else nvl2(:p_rep_currency,'No Exchange Rate',null) end exchange_rate,
case when cbab.exchange_rate>0 then cbab.ledger_balance * cbab.exchange_rate end rep_curr_ledger_balance,
case when cbab.exchange_rate>0 then cbab.available_balance * cbab.exchange_rate end rep_curr_available_balance,
case when cbab.exchange_rate>0 then cbab.value_dated_balance * cbab.exchange_rate end rep_curr_value_dated_balance,
case when cbab.exchange_rate>0 then cbab.one_day_float * cbab.exchange_rate end rep_curr_one_day_float,
case when cbab.exchange_rate>0 then cbab.two_day_float * cbab.exchange_rate end rep_curr_two_day_float,
case when cbab.exchange_rate>0 then cbab.average_closing_ledger_mtd * cbab.exchange_rate end rep_curr_avg_close_ledger_mtd,
case when cbab.exchange_rate>0 then cbab.average_closing_available_mtd * cbab.exchange_rate end rep_curr_avg_close_avail_mtd,
case when cbab.exchange_rate>0 then cbab.average_closing_ledger_ytd * cbab.exchange_rate end rep_curr_avg_close_ledger_ytd,
case when cbab.exchange_rate>0 then cbab.average_closing_available_ytd * cbab.exchange_rate end rep_curr_avg_close_avail_ytd,
case when cbab.exchange_rate>0 then cbab.projected_balance * cbab.exchange_rate end rep_curr_projected_balance,
case when cbab.exchange_rate>0 then
case :p_proj_variance_type
when 'C'   then (cbab.available_balance - cbab.projected_balance) -- available balance
when 'CAM' then (cbab.average_closing_available_mtd - cbab.projected_balance) -- Avg Closing Avail MTD
when 'CAY' then (cbab.average_closing_available_ytd - cbab.projected_balance) -- Avg Closing Avail YTD
when 'CLM' then (cbab.average_closing_ledger_mtd - cbab.projected_balance) -- Avg Closing Ledger MTD
when 'CLY' then (cbab.average_closing_ledger_ytd - cbab.projected_balance) -- Avg Closing Ledger YTD
when 'I'   then (cbab.value_dated_balance - cbab.projected_balance) -- Value Dated Balance
when 'L'   then (cbab.ledger_balance - cbab.projected_balance) -- Ledger Balance
when 'O'   then (cbab.one_day_float - cbab.projected_balance) -- One Day Float
when 'T'   then (cbab.two_day_float - cbab.projected_balance) -- Two Day Float
end * cbab.exchange_rate
end rep_curr_act_vs_proj_variance,
case when cbab.exchange_rate>0 then cbab.min_target_balance * cbab.exchange_rate end rep_curr_min_target_balance,
case when cbab.exchange_rate>0 then cbab.max_target_balance * cbab.exchange_rate end rep_curr_max_target_balance,
-- GL Cash Account Details
nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, null, cbab.asset_ccid, 'GL_BALANCING', 'Y', 'VALUE'),null) gl_company_code,
nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, null, cbab.asset_ccid, 'GL_BALANCING', 'Y', 'DESCRIPTION'),null) gl_company_desc,
nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, null, cbab.asset_ccid, 'GL_ACCOUNT', 'Y', 'VALUE'),null) gl_account_code,
nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, null, cbab.asset_ccid, 'GL_ACCOUNT', 'Y', 'DESCRIPTION'),null) gl_account_desc,
nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, null, cbab.asset_ccid, 'FA_COST_CTR', 'Y', 'VALUE'),null) gl_cost_center_code,
nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, null, cbab.asset_ccid, 'FA_COST_CTR', 'Y', 'DESCRIPTION'),null) gl_cost_center_desc,
nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, null, cbab.asset_ccid, 'ALL', 'Y', 'VALUE'),null) gl_cash_account,
nvl2(cbab.asset_ccid,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cbab.coaid, null, cbab.asset_ccid, 'ALL', 'Y', 'DESCRIPTION'),null) gl_cash_account_desc,
-- pivot labels
cbab.bank_name||' - '||cbab.masked_account_num||' - '||cbab.bank_account_name||' ('|| cbab.bank_account_currency||')' bank_account_pivot_label
from
ce_bank_acct_bal_qry2 cbab,
ce_statement_headers csh
where
1=1 and
decode(cbab.type_code,'BA',cbab.bank_account_id,null)=csh.bank_account_id(+) and
decode(cbab.type_code,'BA',cbab.actual_balance_date,null)=csh.statement_date(+) 
order by
cbab.bank_name,
cbab.masked_account_num,
cbab.balance_date