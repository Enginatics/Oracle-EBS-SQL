/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Cost
-- Description: Asset Costs Summary/Detail Report

Equivalent to Oracle Standard Reports:
Cost Summary Report
Cost Detail Report

DB package: XXEN_FA_FAS_XMLP
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-cost/
-- Library Link: https://www.enginatics.com/reports/fa-asset-cost/
-- Run Report: https://demo.enginatics.com/

select
  x.company_name,
  x.ledger,
  x.book                 book,
  x.currency             currency,
  x.balancing_segment    balancing_segment,
  x.asset_account        asset_account,
  x.cost_center          cost_center,
  x.asset_number         asset_number,
  x.asset_description    asset_description,
  -- cost
  sum(x.begin_amount)         beginning_balance,
  sum(x.addition_amount)      additions,
  sum(x.adjustment_amount)    adjustments,
  sum(x.retirement_amount)    retirements,
  sum(x.revaluation_amount)   revaluations,
  sum(x.reclass_amount)       reclassifications,
  sum(x.transfer_amount)      transfers,
  sum(x.end_amount)           ending_balance,
  sum(case nvl(x.end_amount,0) - (nvl(x.begin_amount,0) + nvl(x.addition_amount,0) + nvl(x.revaluation_amount,0) + nvl(x.reclass_amount,0) - nvl(x.retirement_amount,0) + nvl(x.adjustment_amount,0) + nvl(x.transfer_amount,0))
      when 0 then to_number(null)
      else nvl(x.end_amount,0) - (nvl(x.begin_amount,0) + nvl(x.addition_amount,0) + nvl(x.revaluation_amount,0) + nvl(x.reclass_amount,0) - nvl(x.retirement_amount,0) + nvl(x.adjustment_amount,0) + nvl(x.transfer_amount,0))
      end
     ) out_of_balance_amount,
  max(x.out_of_balance_flag) out_of_balance_flag,
  -- reserve
&lp_reserve_cols1
  --
  x.company_name || ': ' || x.book || ' (' || x.currency || ')' comp_book_curr_label
from
(
  select /*+ push_pred(fah) */
    fsc.company_name,
    gl.name ledger,
    :p_book book,
    gl.currency_code currency,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg','SQLGL','GL#',nvl(gcc_dh.chart_of_accounts_id,gcc_dh.chart_of_accounts_id),null,nvl(gcc_dh.code_combination_id,gcc_dh.code_combination_id),'GL_BALANCING','Y','VALUE') balancing_segment,
    nvl2(gcc_aj.code_combination_id,
         fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg','SQLGL','GL#',gcc_aj.chart_of_accounts_id,null,gcc_aj.code_combination_id,'GL_ACCOUNT','Y','VALUE'),
         fbrg.category_books_account
        ) asset_account,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',nvl(gcc_dh.chart_of_accounts_id,gcc_dh.chart_of_accounts_id),null,nvl(gcc_dh.code_combination_id,gcc_dh.code_combination_id),'FA_COST_CTR','Y','VALUE') cost_center,
    fa.asset_id,
    fa.asset_number,
    fa.description asset_description,
    -- cost
    nvl(round(sum(decode(fbrg.source_type_code,  'BEGIN', nvl(fbrg.amount,0) , null)), fc.precision),0) begin_amount,
    round(sum(decode(fbrg.source_type_code,   'ADDITION', nvl(fbrg.amount,0) , null)), fc.precision) addition_amount,
    round(sum(decode(fbrg.source_type_code, 'ADJUSTMENT', nvl(fbrg.amount,0) , null)), fc.precision) adjustment_amount,
    round(sum(decode(fbrg.source_type_code, 'RETIREMENT', -nvl(fbrg.amount,0), null)), fc.precision) retirement_amount,
    round(sum(decode(fbrg.source_type_code,'REVALUATION', nvl(fbrg.amount,0) , null)), fc.precision) revaluation_amount,
    round(sum(decode(fbrg.source_type_code,    'RECLASS', nvl(fbrg.amount,0) , null)), fc.precision) reclass_amount,
    round(sum(decode(fbrg.source_type_code,   'TRANSFER', nvl(fbrg.amount,0) , null)), fc.precision) transfer_amount,
    nvl(round(sum(decode(fbrg.source_type_code,    'END', nvl(fbrg.amount,0) , null)), fc.precision),0) end_amount,
    fa_fascosts_xmlp_pkg.out_of_balanceformula
      ( nvl(round(sum(decode(fbrg.source_type_code,  'BEGIN', nvl(fbrg.amount,0) ,null)), fc.precision),0)
      , round(sum(decode(fbrg.source_type_code,   'ADDITION', nvl(fbrg.amount,0) ,null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code,'REVALUATION', nvl(fbrg.amount,0) ,null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code,    'RECLASS', nvl(fbrg.amount,0) ,null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, 'RETIREMENT', -nvl(fbrg.amount,0),null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, 'ADJUSTMENT', nvl(fbrg.amount,0) ,null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code,   'TRANSFER', nvl(fbrg.amount,0) ,null)), fc.precision)
      , 0
      , nvl(round(sum(decode(fbrg.source_type_code,    'END', nvl(fbrg.amount,0) ,null)), fc.precision),0)
      ) out_of_balance_flag,
    -- reserve
    fah.deprn_reserve_acct reserve_account,
    to_number(null) reserve_begin_amount,
    to_number(null) reserve_addition_amount,
    to_number(null) reserve_depreciation_amount,
    to_number(null) reserve_revaluation_amount,
    to_number(null) reserve_tax_amount,
    to_number(null) reserve_retirement_amount,
    to_number(null) reserve_reclass_amount,
    to_number(null) reserve_transfer_amount,
    to_number(null) reserve_end_amount,
    to_number(null) reserve_adjustment_amount,
    null reserve_out_of_balance_flag,
    null reserve_reval_tax_flag
  from
    fa_system_controls    fsc,
    gl_ledgers            gl,
    fnd_currencies        fc,
    fa_balances_report_gt fbrg,
    (select
     fah.asset_id,
     fcb.book_type_code,
     fcb.asset_cost_acct,
     max(fcb.deprn_reserve_acct) deprn_reserve_acct
     from
     fa_asset_history fah,
     fa_category_books fcb
     where
     fah.category_id = fcb.category_id
     group by
     fah.asset_id,
     fcb.book_type_code,
     fcb.asset_cost_acct
     having
     count(distinct fcb.deprn_reserve_acct) = 1
    ) fah,
    fa_additions          fa,
    gl_code_combinations  gcc_dh,
    gl_code_combinations  gcc_aj
  where
    gl.ledger_id                  = :p_ca_set_of_books_id and
    gl.currency_code              = fc.currency_code and
    fbrg.asset_id                 > 0 and
    decode(:p_show_reserve,'Y',fbrg.asset_id) = fah.asset_id (+) and
    decode(:p_show_reserve,'Y',:p_book) = fah.book_type_code (+) and
    nvl2(gcc_aj.code_combination_id,
         fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg','SQLGL','GL#',gcc_aj.chart_of_accounts_id,null,gcc_aj.code_combination_id,'GL_ACCOUNT','Y','VALUE'),
         fbrg.category_books_account
        )                         = fah.asset_cost_acct (+) and
    fbrg.asset_id                 = fa.asset_id and
    fbrg.distribution_ccid        = gcc_dh.code_combination_id (+) and
    fbrg.adjustment_ccid          = gcc_aj.code_combination_id (+) and
    --
    1=1
  group by
    fsc.company_name,
    gl.name,
    :p_book,
    gl.currency_code,
    fc.precision,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg','SQLGL','GL#',nvl(gcc_dh.chart_of_accounts_id,gcc_dh.chart_of_accounts_id),null,nvl(gcc_dh.code_combination_id,gcc_dh.code_combination_id),'GL_BALANCING','Y','VALUE'),
    nvl2(gcc_aj.code_combination_id,
         fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg','SQLGL','GL#',gcc_aj.chart_of_accounts_id,null,gcc_aj.code_combination_id,'GL_ACCOUNT','Y','VALUE'),
         fbrg.category_books_account
        ),
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',nvl(gcc_dh.chart_of_accounts_id,gcc_dh.chart_of_accounts_id),null,nvl(gcc_dh.code_combination_id,gcc_dh.code_combination_id),'FA_COST_CTR','Y','VALUE'),
    fa.asset_id,
    fa.asset_number,
    fa.description,
    fah.deprn_reserve_acct
  union all
  select /*+ push_pred(fah) */
    fsc.company_name,
    gl.name ledger,
    :p_book book,
    gl.currency_code currency,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg','SQLGL','GL#',nvl(gcc_dh.chart_of_accounts_id,gcc_dh.chart_of_accounts_id),null,nvl(gcc_dh.code_combination_id,gcc_dh.code_combination_id),'GL_BALANCING','Y','VALUE') balancing_segment,
    fah.asset_cost_acct asset_account,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',nvl(gcc_dh.chart_of_accounts_id,gcc_dh.chart_of_accounts_id),null,nvl(gcc_dh.code_combination_id,gcc_dh.code_combination_id),'FA_COST_CTR','Y','VALUE') cost_center,
    fa.asset_id,
    fa.asset_number,
    fa.description asset_description,
    -- cost
    to_number(null) begin_amount,
    to_number(null) addition_amount,
    to_number(null) adjustment_amount,
    to_number(null) retirement_amount,
    to_number(null) revaluation_amount,
    to_number(null) reclass_amount,
    to_number(null) transfer_amount,
    to_number(null) end_amount,
    null out_of_balance_flag,
    -- reserve
    nvl2(gcc_aj.code_combination_id,
         fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg','SQLGL','GL#',gcc_aj.chart_of_accounts_id,null,gcc_aj.code_combination_id,'GL_ACCOUNT','Y','VALUE'),
         fbrg.category_books_account
        ) reserve_account,
    nvl(round(sum(decode(fbrg.source_type_code,   'BEGIN', nvl(fbrg.amount,0) , null)), fc.precision),0) reserve_begin_amount,
    round(sum(decode(fbrg.source_type_code,    'ADDITION', nvl(fbrg.amount,0) , null)), fc.precision) reserve_addition_amount,
    round(sum(decode(fbrg.source_type_code,'DEPRECIATION', nvl(fbrg.amount,0) , null)), fc.precision) reserve_depreciation_amount,
    round(sum(decode(fbrg.source_type_code, 'REVALUATION', nvl(fbrg.amount,0) , null)), fc.precision) reserve_revaluation_amount,
    round(sum(decode(fbrg.source_type_code,         'TAX', nvl(fbrg.amount,0) , null)), fc.precision) reserve_tax_amount,
    round(sum(decode(fbrg.source_type_code,  'RETIREMENT', -nvl(fbrg.amount,0), null)), fc.precision) reserve_retirement_amount,
    round(sum(decode(fbrg.source_type_code,    'RECLASS', nvl(fbrg.amount,0) , null)), fc.precision) reserve_reclass_amount,
    round(sum(decode(fbrg.source_type_code,   'TRANSFER', nvl(fbrg.amount,0) , null)), fc.precision) reserve_transfer_amount,
    nvl(round(sum(decode(fbrg.source_type_code,    'END', nvl(fbrg.amount,0) , null)), fc.precision),0) reserve_end_amount,
    nvl(round(sum(decode(fbrg.source_type_code,    'TAX', nvl(fbrg.amount,0),null)), fc.precision),0) +  nvl(round(sum(decode(fbrg.source_type_code, 'REVALUATION', nvl(fbrg.amount,0),null)), fc.precision),0) reserve_adjustment_amount,
    fa_fasrsves_xmlp_pkg.out_of_balanceformula
      ( nvl(round(sum(decode(fbrg.source_type_code,   'BEGIN', nvl(fbrg.amount,0)  , null)), fc.precision),0)
      , round(sum(decode(fbrg.source_type_code,    'ADDITION', nvl(fbrg.amount,0)  , null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code,'DEPRECIATION', nvl(fbrg.amount,0)  , null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code,     'RECLASS', nvl(fbrg.amount,0)  , null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code,  'RETIREMENT', - nvl(fbrg.amount,0), null)), fc.precision)
      , nvl(round(sum(decode(fbrg.source_type_code,     'TAX', nvl(fbrg.amount,0),null)), fc.precision),0) + nvl(round(sum(decode(fbrg.source_type_code, 'REVALUATION', nvl(fbrg.amount,0),null)), fc.precision),0)
      , round(sum(decode(fbrg.source_type_code,    'TRANSFER', nvl(fbrg.amount,0)  , null)), fc.precision)
      , nvl(round(sum(decode(fbrg.source_type_code,     'END', nvl(fbrg.amount,0)  , null)), fc.precision),0)
      ) reserve_out_of_balance_flag,
    fa_fasrsves_xmlp_pkg.reval_tax_flagformula
      ( round(sum(decode(fbrg.source_type_code, 'REVALUATION', nvl(fbrg.amount,0), null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, 'TAX'        , nvl(fbrg.amount,0), null)), fc.precision)
      ) reserve_reval_tax_flag
  from
    fa_system_controls    fsc,
    gl_ledgers            gl,
    fnd_currencies        fc,
    fa_balances_report_gt fbrg,
    (select
     fah.asset_id,
     fcb.book_type_code,
     fcb.deprn_reserve_acct,
     max(fcb.asset_cost_acct) asset_cost_acct
     from
     fa_asset_history fah,
     fa_category_books fcb
     where
     fah.category_id = fcb.category_id
     group by
     fah.asset_id,
     fcb.book_type_code,
     fcb.deprn_reserve_acct
     having
     count(distinct fcb.asset_cost_acct) = 1
    ) fah,
    fa_additions          fa,
    gl_code_combinations  gcc_dh,
    gl_code_combinations  gcc_aj
  where
    :p_show_reserve = 'Y' and
    gl.ledger_id = :p_ca_set_of_books_id and
    gl.currency_code = fc.currency_code and
    fbrg.asset_id < 0 and
    -fbrg.asset_id = fah.asset_id (+) and
    nvl2(gcc_aj.code_combination_id,
         fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg','SQLGL','GL#',gcc_aj.chart_of_accounts_id,null,gcc_aj.code_combination_id,'GL_ACCOUNT','Y','VALUE'),
         fbrg.category_books_account
        ) = fah.deprn_reserve_acct (+) and
    :p_book = fah.book_type_code (+) and
    -fbrg.asset_id = fa.asset_id and
    fbrg.distribution_ccid = gcc_dh.code_combination_id (+) and
    fbrg.adjustment_ccid = gcc_aj.code_combination_id (+) and
    --
    1=1
  group by
    fsc.company_name,
    gl.name,
    :p_book,
    gl.currency_code,
    fc.precision,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg','SQLGL','GL#',nvl(gcc_dh.chart_of_accounts_id,gcc_dh.chart_of_accounts_id),null,nvl(gcc_dh.code_combination_id,gcc_dh.code_combination_id),'GL_BALANCING','Y','VALUE'),
    fah.asset_cost_acct,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',nvl(gcc_dh.chart_of_accounts_id,gcc_dh.chart_of_accounts_id),null,nvl(gcc_dh.code_combination_id,gcc_dh.code_combination_id),'FA_COST_CTR','Y','VALUE'),
    fa.asset_id,
    fa.asset_number,
    fa.description,
    nvl2(gcc_aj.code_combination_id,
         fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg','SQLGL','GL#',gcc_aj.chart_of_accounts_id,null,gcc_aj.code_combination_id,'GL_ACCOUNT','Y','VALUE'),
         fbrg.category_books_account
        )
) x
group by
  x.company_name,
  x.ledger,
  x.book,
  x.currency,
  x.balancing_segment,
  x.asset_account,
  x.reserve_account,
  x.cost_center,
  x.asset_number,
  x.asset_description
order by
  x.company_name,
  x.ledger,
  x.book,
  x.balancing_segment,
  x.asset_account,
  x.reserve_account,
  x.cost_center,
  x.asset_number