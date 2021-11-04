/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Tax Reserve Ledger
-- Description: Imported Oracle standard tax reserve ledger report
Source: Tax Reserve Ledger Report (XML)
Short Name: FAS480_XML
DB package: FA_FAS480_XMLP_PKG
Custom Package: XXEN_FA_FAS_XMLP
-- Excel Examle Output: https://www.enginatics.com/example/fa-tax-reserve-ledger/
-- Library Link: https://www.enginatics.com/reports/fa-tax-reserve-ledger/
-- Run Report: https://demo.enginatics.com/

select
  x.company_name      company_name,
  x.ledger            ledger,
  x.book              book,
  x.currency          currency,
  x.period            period,
  x.fiscal_year       fiscal_year,
  x.bal_segment       balancing_segment,
  x.ast_account       asset_account,
  x.rsv_account       reserve_account,
  x.asset_number      asset_number,
  x.asset_desc        asset_description,
  x.start_date        date_placed_in_service,
  x.method            depreciation_method,
  x.d_life            "Life Yr.Mo",
  x.cost              cost,
  x.deprn_amount      depreciation_amount,
  x.ytd_deprn         ytd_depreciation,
  x.deprn_reserve     depreciation_reserve,
  x.transaction_type  transaction_type,
  x.company_name || ': ' || x.book || ' - ' || x.period || ' (' || x.currency || ')' comp_book_prd_curr_label,
  'FY: ' || x.fiscal_year fiscal_year_label
from
(
select
  fsc.company_name,
  gl.name ledger,
  :p_book book,
  gl.currency_code currency,
  :p_period1 period,
  ffy.fiscal_year,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') bal_segment,
  frlg.asset_cost_acct ast_account,
  frlg.deprn_reserve_acct rsv_account,
  fa.asset_number,
  fa.description asset_desc,
  frlg.date_placed_in_service start_date,
  frlg.method_code method,
  frlg.life life,
  frlg.rate adj_rate,
  frlg.bonus_rate bonus_rate,
  frlg.capacity prod,
  round(sum(frlg.cost),fc.precision) cost,
  round(sum(frlg.deprn_amount),fc.precision) deprn_amount,
  round(sum(frlg.ytd_deprn),fc.precision) ytd_deprn,
  round(sum(frlg.deprn_reserve),fc.precision) deprn_reserve,
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
  fa_fas480_xmlp_pkg.d_lifeformula(frlg.life, frlg.rate, frlg.bonus_rate, frlg.capacity) d_life
from
  fa_system_controls   fsc,
  gl_ledgers           gl,
  fnd_currencies       fc,
  fa_book_controls     fbc,
  fa_reserve_ledger_gt frlg,
  fa_additions         fa,
  gl_code_combinations gcc,
  fa_fiscal_year       ffy
where
  gl.ledger_id                = :p_ca_set_of_books_id and
  fc.currency_code            = gl.currency_code and
  fbc.book_type_code          = :p_book and
  fa.asset_id                 = frlg.asset_id and
  gcc.code_combination_id     = frlg.dh_ccid and
  ffy.fiscal_year_name        = fbc.fiscal_year_name and
  frlg.date_placed_in_service between ffy.start_date and ffy.end_date and
  1=1
group by
  fsc.company_name,
  gl.name,
  :p_book,
  gl.currency_code,
  fc.precision,
  :p_period1,
  ffy.fiscal_year,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
  frlg.asset_cost_acct,
  frlg.deprn_reserve_acct,
  fa.asset_number,
  fa.description,
  frlg.date_placed_in_service,
  frlg.method_code,
  frlg.life,
  frlg.rate,
  frlg.bonus_rate,
  frlg.capacity,
  frlg.transaction_type
) x
order by
  x.company_name,
  x.ledger,
  x.book,
  x.currency,
  x.period,
  x.bal_segment,
  x.fiscal_year,
  x.ast_account,
  x.rsv_account,
  x.asset_number,
  x.asset_desc,
  x.method,
  x.d_life,
  x.start_date