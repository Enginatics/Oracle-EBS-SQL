/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Journal Entry Reserve Ledger
-- Description: Imported Oracle standard journal entry reserve ledger report
Source: Journal Entry Reserve Ledger Report (XML)
Short Name: FAS400_XML
DB package: XXEN_FA_FAS_XMLP
-- Excel Examle Output: https://www.enginatics.com/example/fa-journal-entry-reserve-ledger/
-- Library Link: https://www.enginatics.com/reports/fa-journal-entry-reserve-ledger/
-- Run Report: https://demo.enginatics.com/

select
  x.company_name      company_name,
  x.ledger            ledger,
  x.book              book,
  x.currency          currency,
  x.period            period,
  x.bal_segment       balancing_segment,
  x.exp_account       expense_account,
  x.rsv_account       reserve_account,
  x.cost_center       cost_center,
  x.asset_number      asset_number,
  x.asset_desc        asset_description,
  x.start_date        date_placed_in_service,
  x.method            depreciation_method,
  x.d_life            "Life Yr.Mo",
  x.cost              cost,
  x.deprn_amount      depreciation_amount,
  x.ytd_deprn         ytd_depreciation,
  x.deprn_reserve     depreciation_reserve,
  x.percent           percent,
  x.transaction_type  transaction_type,
  x.company_name || ': ' || x.book || ' - ' || x.period || ' (' || x.currency || ')' comp_book_prd_curr_label
from
(
select
  fsc.company_name,
  gl.name ledger,
  :p_book book,
  gl.currency_code currency,
  :p_period1 period,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') bal_segment,
  decode(transaction_type,'B',frlg.reserve_acct, fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') ) exp_account,
  frlg.deprn_reserve_acct rsv_account,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center,
  fa.asset_number,
  fa.description asset_desc,
  frlg.date_placed_in_service start_date,
  frlg.method_code method,
  frlg.life life,
  frlg.rate adj_rate,
  fds.bonus_rate bonus_rate,
  frlg.capacity prod,
  sum(decode(frlg.transaction_type,'B',null,frlg.cost)) cost,
  sum(frlg.deprn_amount) deprn_amount,
  sum(frlg.ytd_deprn) ytd_deprn,
  sum(frlg.deprn_reserve) deprn_reserve,
  sum(decode(frlg.transaction_type,'B',null,nvl(frlg.percent,0))) percent,
  frlg.transaction_type t_type,
  case frlg.transaction_type
  when 'P' then 'Partial Unit Retirement'
  when 'F' then 'Full Retirement'
  when 'T' then 'Transfer Out'
  when 'N' then 'Non-depreciating Asset'
  when 'R' then 'Reclassification'
  when 'B' then 'Bonus Depreciation Amount'
  else frlg.transaction_type
  end transaction_type,
  fa_fas400_xmlp_pkg.d_lifeformula(frlg.life, frlg.rate, fds.bonus_rate, frlg.capacity) d_life
from
  fa_system_controls   fsc,
  gl_ledgers           gl,
  fa_reserve_ledger_gt frlg,
  fa_additions         fa,
  gl_code_combinations gcc,
  &lp_fa_deprn_summary fds
where
  gl.ledger_id            = :p_ca_set_of_books_id and
  fa.asset_id             = frlg.asset_id and
  gcc.code_combination_id = frlg.dh_ccid and
  fds.period_counter  (+) = frlg.period_counter and
  fds.book_type_code  (+) = :p_book and
  fds.asset_id        (+) = frlg.asset_id and
  1=1
group by
  fsc.company_name,
  gl.name,
  :p_book,
  gl.currency_code,
  :p_period1,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
  decode(transaction_type,'B', frlg.reserve_acct,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE')),
  frlg.deprn_reserve_acct,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'),
  fa.asset_number,
  fa.description,
  frlg.date_placed_in_service,
  frlg.method_code,
  frlg.life,
  frlg.rate,
  frlg.capacity,
  fds.bonus_rate,
  frlg.transaction_type
) x
order by
  x.company_name,
  x.ledger,
  x.book,
  x.currency,
  x.period,
  x.bal_segment,
  x.exp_account,
  x.rsv_account,
  x.cost_center,
  x.asset_number,
  x.asset_desc,
  x.method,
  x.d_life,
  x.start_date