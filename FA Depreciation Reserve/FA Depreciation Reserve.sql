/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Depreciation Reserve
-- Description: Depreciation Reserve Summary/Detail Report

Equivalent to Oracle Standard Reports:
Reserve Summary Report
Reserve Detail Report

DB package: XXEN_FA_FAS_XMLP
-- Excel Examle Output: https://www.enginatics.com/example/fa-depreciation-reserve/
-- Library Link: https://www.enginatics.com/reports/fa-depreciation-reserve/
-- Run Report: https://demo.enginatics.com/

with
-- Not using fa_balances_reports_gt as it does not have enough columns
-- to cater for running the reports across multiple book type codes and balance types (COST + RESERVE)
fa_balances_report_q as
(
select
  mfq.char1    book_type_code
, mfq.char2    balance_type
, mfq.number1  asset_id
, mfq.number2  distribution_ccid
, mfq.number3  adjustment_ccid
, mfq.char3    category_books_account
, mfq.char4    source_type_code
, mfq.number4  amount
, mfq.char5    cost_account
, mfq.number5  cost_begin_balance
, mfq.number6  group_asset_id
, mfq.number7  set_of_books_id
, mfq.number8  impairment_amt
, mfq.number9  impairment_beg_rsv
, mfq.number10 impairment_end_rsv
, mfq.char6    impairment_beg_rsv_acct
, mfq.char7    impairment_end_rsv_acct
from
msc_form_query mfq
)
--
-- Main Query
--
select
  x.company_name         company_name,
  x.ledger               ledger,
  x.book                 book,
  x.currency             currency,
  x.balancing_segment    balancing_segment,
  x.reserve_account      reserve_account,
  x.cost_center          cost_center,
  x.asset_number         asset_number,
  x.asset_description    asset_description,
  x.begin_amount         beginning_balance,
  x.addition_amount      additions,
  x.depreciation_amount  depreciation,
  x.adjustment_amount    adjustments,
  x.retirement_amount    retirements,
  x.reclass_amount       reclassifications,
  x.transfer_amount      transfers,
  x.end_amount           ending_balance,
  x.out_of_balance_flag  out_of_balance_flag,
  case nvl(x.end_amount,0) - (nvl(x.begin_amount,0) + nvl(x.addition_amount,0) + nvl(x.depreciation_amount,0) + nvl(x.reclass_amount,0) - nvl(x.retirement_amount,0) + nvl(x.adjustment_amount,0) + nvl(x.transfer_amount,0))
  when 0 then to_number(null)
  else nvl(x.end_amount,0) - (nvl(x.begin_amount,0) + nvl(x.addition_amount,0) + nvl(x.depreciation_amount,0) + nvl(x.reclass_amount,0) - nvl(x.retirement_amount,0) + nvl(x.adjustment_amount,0) + nvl(x.transfer_amount,0))
  end out_of_balance_amount,
  --
  case x.reval_tax_flag
  when 'R' then 'Revaluation Adjustment'
  when 'T' then 'Tax Adjustment'
  when 'B' then 'Revaluation and Tax Adjustments'
  end                    adjustment_type,
  case fa_fasrsves_xmlp_pkg.reval_tax_flagformula
       ( sum(x.revaluation_amount) over (partition by x.book,x.balancing_segment,x.reserve_account,x.cost_center)
       , sum(x.tax_amount) over (partition by x.book,x.balancing_segment,x.reserve_account,x.cost_center)
       )
  when 'R' then 'Revaluation Adjustment'
  when 'T' then 'Tax Adjustment'
  when 'B' then 'Revaluation and Tax Adjustments'
  end                    cost_ctr_adj_type,
  --
  -- Impairments
  --
  x.begin_impairment,
  x.impairment,
  x.end_impairment,
  x.impair_reserve_acct impairment_reserve_account,
  case when x.impair_reserve_acct != x.impair_reserve_acct_old
  then
   '*'
  else
   null
  end impairment_rsv_acct_chg_flag,
  --
  x.company_name || ': ' || x.book || ' (' || x.currency || ')' comp_book_curr_label
from
(
  select
    fsc.company_name,
    gl.name ledger,
    fbrg.book_type_code book,
    gl.currency_code currency,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg','SQLGL','GL#',gcc_dh.chart_of_accounts_id,null,gcc_dh.code_combination_id,'GL_BALANCING','Y','VALUE') balancing_segment,
    nvl2(gcc_aj.code_combination_id,
         fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg','SQLGL','GL#',gcc_aj.chart_of_accounts_id,null,gcc_aj.code_combination_id,'GL_ACCOUNT','Y','VALUE'),
         fbrg.category_books_account
        ) reserve_account,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',gcc_dh.chart_of_accounts_id,null,gcc_dh.code_combination_id,'FA_COST_CTR','Y','VALUE') cost_center,
    fa.asset_number,
    fa.description asset_description,
    nvl(round(sum(decode(fbrg.source_type_code, 'BEGIN'   , nvl(fbrg.amount,0) , null)), fc.precision),0) begin_amount,
    round(sum(decode(fbrg.source_type_code, 'ADDITION'    , nvl(fbrg.amount,0) , null)), fc.precision) addition_amount,
    round(sum(decode(fbrg.source_type_code, 'DEPRECIATION', nvl(fbrg.amount,0) , null)), fc.precision) depreciation_amount,
    round(sum(decode(fbrg.source_type_code, 'REVALUATION' , nvl(fbrg.amount,0) , null)), fc.precision) revaluation_amount,
    round(sum(decode(fbrg.source_type_code, 'TAX'         , nvl(fbrg.amount,0) , null)), fc.precision) tax_amount,
    round(sum(decode(fbrg.source_type_code, 'RETIREMENT'  , -nvl(fbrg.amount,0), null)), fc.precision) retirement_amount,
    round(sum(decode(fbrg.source_type_code, 'RECLASS'     , nvl(fbrg.amount,0) , null)), fc.precision) reclass_amount,
    round(sum(decode(fbrg.source_type_code, 'TRANSFER'    , nvl(fbrg.amount,0) , null)), fc.precision) transfer_amount,
    nvl(round(sum(decode(fbrg.source_type_code, 'END'     , nvl(fbrg.amount,0) , null)), fc.precision),0) end_amount,
    --
    nvl(round(sum(decode(fbrg.source_type_code, 'TAX'         , nvl(fbrg.amount,0),null)), fc.precision),0)
    + nvl(round(sum(decode(fbrg.source_type_code, 'REVALUATION' , nvl(fbrg.amount,0),null)), fc.precision),0) adjustment_amount,
    --
    fa_fasrsves_xmlp_pkg.out_of_balanceformula
      ( nvl(round(sum(decode(fbrg.source_type_code, 'BEGIN'   , nvl(fbrg.amount,0)  , null)), fc.precision),0)
      , round(sum(decode(fbrg.source_type_code, 'ADDITION'    , nvl(fbrg.amount,0)  , null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, 'DEPRECIATION', nvl(fbrg.amount,0)  , null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, 'RECLASS'     , nvl(fbrg.amount,0)  , null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, 'RETIREMENT'  , - nvl(fbrg.amount,0), null)), fc.precision)
      , nvl(round(sum(decode(fbrg.source_type_code, 'TAX'     , nvl(fbrg.amount,0),null)), fc.precision),0)
        + nvl(round(sum(decode(fbrg.source_type_code, 'REVALUATION' , nvl(fbrg.amount,0),null)), fc.precision),0)
      , round(sum(decode(fbrg.source_type_code, 'TRANSFER'    , nvl(fbrg.amount,0)  , null)), fc.precision)
      , nvl(round(sum(decode(fbrg.source_type_code, 'END'     , nvl(fbrg.amount,0)  , null)), fc.precision),0)
      ) out_of_balance_flag,
    fa_fasrsves_xmlp_pkg.reval_tax_flagformula
      ( round(sum(decode(fbrg.source_type_code, 'REVALUATION', nvl(fbrg.amount,0), null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, 'TAX'        , nvl(fbrg.amount,0), null)), fc.precision)
      ) reval_tax_flag,
    --
    -- Impairments
    --
    nvl(round(sum(decode(fbrg.source_type_code,'BEGIN',nvl(fbrg.impairment_beg_rsv,0) , null)), fc.precision),0) begin_impairment,
    nvl(round(sum(decode(fbrg.source_type_code,'DEPRECIATION',nvl(fbrg.impairment_amt,0) , null)), fc.precision),0) impairment,
    nvl(round(sum(decode(fbrg.source_type_code,'END',nvl(fbrg.impairment_end_rsv,0) , null)), fc.precision),0) end_impairment,
    max(decode(fbrg.source_type_code,'BEGIN',fbrg.impairment_beg_rsv_acct)) impair_reserve_acct_old,
    max(decode(fbrg.source_type_code,'END',fbrg.impairment_end_rsv_acct)) impair_reserve_acct
  from
    fa_system_controls      fsc,
    gl_ledgers              gl,
    fnd_currencies          fc,
    fa_balances_report_q    fbrg,
    fa_additions            fa,
    gl_code_combinations    gcc_dh,
    gl_code_combinations    gcc_aj
  where
    gl.ledger_id                   = fbrg.set_of_books_id and
    fc.currency_code               = gl.currency_code and
    fa.asset_id                    = fbrg.asset_id and
    gcc_dh.code_combination_id     = fbrg.distribution_ccid and
    gcc_aj.code_combination_id (+) = fbrg.adjustment_ccid and
    1=1
  group by
    fsc.company_name,
    gl.name,
    fbrg.book_type_code,
    gl.currency_code,
    fc.precision,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg','SQLGL','GL#',gcc_dh.chart_of_accounts_id,null,gcc_dh.code_combination_id,'GL_BALANCING','Y','VALUE'),
    nvl2(gcc_aj.code_combination_id,
         fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg','SQLGL','GL#',gcc_aj.chart_of_accounts_id,null,gcc_aj.code_combination_id,'GL_ACCOUNT','Y','VALUE'),
         fbrg.category_books_account
        ),
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',gcc_dh.chart_of_accounts_id,null,gcc_dh.code_combination_id,'FA_COST_CTR','Y','VALUE'),
    fa.asset_number,
    fa.description
) x
order by
  x.company_name,
  x.ledger,
  x.book,
  x.balancing_segment,
  x.reserve_account,
  x.cost_center,
  x.asset_number