/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
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
  x.begin_amount         beginning_balance,
  x.addition_amount      additions,
  x.adjustment_amount    adjustments,
  x.retirement_amount    retirements,
  x.revaluation_amount   revaluations,
  x.reclass_amount       reclassifications,
  x.transfer_amount      transfers,
  x.end_amount           ending_balance,
  x.out_of_balance_flag,
  case nvl(x.end_amount,0) - (nvl(x.begin_amount,0) + nvl(x.addition_amount,0) + nvl(x.revaluation_amount,0) + nvl(x.reclass_amount,0) - nvl(x.retirement_amount,0) + nvl(x.adjustment_amount,0) + nvl(x.transfer_amount,0) - nvl(x.capitalization_amount,0))
  when 0 then to_number(null)
  else nvl(x.end_amount,0) - (nvl(x.begin_amount,0) + nvl(x.addition_amount,0) + nvl(x.revaluation_amount,0) + nvl(x.reclass_amount,0) - nvl(x.retirement_amount,0) + nvl(x.adjustment_amount,0) + nvl(x.transfer_amount,0) - nvl(x.capitalization_amount,0))
  end out_of_balance_amount,
  x.company_name || ': ' || x.book || ' (' || x.currency || ')' comp_book_curr_label
from
(
  select
    fsc.company_name,
    gl.name ledger,
    :p_book book,
    gl.currency_code currency,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg','SQLGL','GL#',gcc_dh.chart_of_accounts_id,null,gcc_dh.code_combination_id,'GL_BALANCING','Y','VALUE') balancing_segment,
    nvl2(gcc_aj.code_combination_id,
         fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg','SQLGL','GL#',gcc_aj.chart_of_accounts_id,null,gcc_aj.code_combination_id,'GL_ACCOUNT','Y','VALUE'),
         fbrg.category_books_account
        ) asset_account,
    fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',gcc_dh.chart_of_accounts_id,null,gcc_dh.code_combination_id,'FA_COST_CTR','Y','VALUE') cost_center,
    fa.asset_number,
    fa.description asset_description,
    --
    nvl(round(sum(decode(fbrg.source_type_code, 'BEGIN'                                                , nvl(fbrg.amount,0) , null)), fc.precision),0) begin_amount,
    round(sum(decode(fbrg.source_type_code, decode(:p_report_type,'COST','ADDITION','CIP ADDITION')    , nvl(fbrg.amount,0) , null)), fc.precision)    addition_amount,
    round(sum(decode(fbrg.source_type_code, decode(:p_report_type,'COST','ADJUSTMENT','CIP ADJUSTMENT'), nvl(fbrg.amount,0) , null)), fc.precision)    adjustment_amount,
    round(sum(decode(fbrg.source_type_code, decode(:p_report_type,'COST','RETIREMENT','CIP RETIREMENT'), -nvl(fbrg.amount,0), null)), fc.precision)    retirement_amount,
    round(sum(decode(fbrg.source_type_code, decode(:p_report_type,'CIP COST','ADDITION')               , -nvl(fbrg.amount,0), null)), fc.precision)    capitalization_amount,
    round(sum(decode(fbrg.source_type_code, 'REVALUATION'                                              , nvl(fbrg.amount,0) , null)), fc.precision)    revaluation_amount,
    round(sum(decode(fbrg.source_type_code, 'RECLASS'                                                  , nvl(fbrg.amount,0) , null)), fc.precision)    reclass_amount,
    round(sum(decode(fbrg.source_type_code, 'TRANSFER'                                                 , nvl(fbrg.amount,0) , null)), fc.precision)    transfer_amount,
    nvl(round(sum(decode(fbrg.source_type_code, 'END'                                                  , nvl(fbrg.amount,0) , null)), fc.precision),0) end_amount,
    --
    fa_fascosts_xmlp_pkg.out_of_balanceformula
      ( nvl(round(sum(decode(fbrg.source_type_code, 'BEGIN'                                                 , nvl(fbrg.amount,0) ,null)), fc.precision),0)
      , round(sum(decode(fbrg.source_type_code, decode(:p_report_type,'COST','ADDITION','CIP ADDITION' )    , nvl(fbrg.amount,0) ,null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, 'REVALUATION'                                               , nvl(fbrg.amount,0) ,null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, 'RECLASS'                                                   , nvl(fbrg.amount,0) ,null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, decode(:p_report_type,'COST','RETIREMENT','CIP RETIREMENT') , -nvl(fbrg.amount,0),null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, decode(:p_report_type,'COST','ADJUSTMENT','CIP ADJUSTMENT') , nvl(fbrg.amount,0) ,null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, 'TRANSFER'                                                  , nvl(fbrg.amount,0) ,null)), fc.precision)
      , round(sum(decode(fbrg.source_type_code, decode(:p_report_type,'CIP COST','ADDITION')                , -nvl(fbrg.amount,0),null)), fc.precision)
      , nvl(round(sum(decode(fbrg.source_type_code, 'END'                                                   , nvl(fbrg.amount,0) ,null)), fc.precision),0)
      ) out_of_balance_flag
  from
    fa_system_controls    fsc,
    gl_ledgers            gl,
    fnd_currencies        fc,
    fa_balances_report_gt fbrg,
    fa_additions          fa,
    gl_code_combinations  gcc_dh,
    gl_code_combinations  gcc_aj

  where
    gl.ledger_id                   = :p_ca_set_of_books_id and
    fc.currency_code               = gl.currency_code and
    fa.asset_id                    = fbrg.asset_id and
    gcc_dh.code_combination_id     = fbrg.distribution_ccid and
    gcc_aj.code_combination_id (+) = fbrg.adjustment_ccid and
    1=1
  group by
    fsc.company_name,
    gl.name,
    :p_book,
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
  x.asset_account,
  x.cost_center,
  x.asset_number