/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Additions
-- Description: Imported from BI Publisher
Description: Asset Additions Report
Application: Assets
Source: Asset Additions Report (XML)
Short Name: FAS420_XML
DB package: FA_FAS420_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-additions/
-- Library Link: https://www.enginatics.com/reports/fa-asset-additions/
-- Run Report: https://demo.enginatics.com/

select
  x.company_name,
  x.ledger,
  x.book,
  x.currency,
  x.balancing_segment,
  x.asset_type,
  x.asset_account,
  x.cost_center,
  x.reserve_account,
  x.asset_number,
  x.asset_description,
  x.asset_category,
  x.tag_number,
  x.manufacturer_name,
  x.serial_number,
  x.model_number,
  x.date_placed_in_service,
  x.method depreciation_method,
  x.d_life "Life Yr.Mo",
  x.cost initial_cost,
  x.ytd_depreciation,
  x.initial_depreciation_reserve,
  x.period_effective,
  x.period_entered,
  x.thid transaction_number,
  x.company_name || ': ' || x.book || ' (' || x.currency || ')' comp_book_curr_label
from
  (
   select
     fsc.company_name,
     gsob.name ledger,
     fbc.book_type_code book,
     gsob.currency_code currency,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') balancing_segment,
     fl.meaning asset_type,
     decode(fah.asset_type, 'CIP', fcb.cip_cost_acct,fcb.asset_cost_acct) asset_account,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center,
     decode(fah.asset_type, 'CIP', null,fcb.deprn_reserve_acct) reserve_account,
     fa.asset_number,
     fa.description asset_description,
     fcbk.concatenated_segments asset_category,
     fa.tag_number,
     fa.manufacturer_name,
     fa.serial_number,
     fa.model_number,
     fb.date_placed_in_service,
     fb.deprn_method_code method,
     fb.life_in_months life,
     fb.adjusted_rate adj_rate,
     decode (fah.asset_type, 'CIP', 0,nvl(fds.bonus_rate,0)) bonus_rate,
     fb.production_capacity prod,
     fa_fas420_xmlp_pkg.d_lifeformula(fb.life_in_months, fb.adjusted_rate, decode (fah.asset_type, 'CIP', 0,nvl(fds.bonus_rate,0)), fb.production_capacity) d_life,
     sum(nvl(decode(fadj.debit_credit_flag,'DR',1,-1) * fadj.adjustment_amount, fdd.addition_cost_to_clear) ) cost,
     sum(nvl(fdd.ytd_deprn,0)) ytd_depreciation,
     sum(fdd.deprn_reserve) initial_depreciation_reserve,
     (select fcp.period_name from fa_calendar_periods fcp where fcp.calendar_type=fbc.deprn_calendar and fth.transaction_date_entered between fcp.start_date and fcp.end_date) period_effective,
     (select fdp.period_name from fa_deprn_periods fdp where fdp.book_type_code=fbc.book_type_code and fth.date_effective between fdp.period_open_date and nvl(fdp.period_close_date,fth.date_effective)) period_entered,
     fth.transaction_header_id thid
   from
     fa_system_controls      fsc,
     fa_lookups              fl,
     fa_additions            fa,
     fa_asset_history        fah,
     fa_transaction_headers  fth,
     fa_category_books       fcb,
     fa_categories_b_kfv     fcbk,
     fa_distribution_history fdh,
     gl_code_combinations    gcc,
     &lp_fa_adjustments      fadj,
     &lp_fa_books            fb,
     &lp_fa_deprn_summary    fds,
     &lp_fa_deprn_detail     fdd,
     fnd_currencies          fc,
     &lp_fa_book_controls    fbc,
     gl_sets_of_books        gsob
   where
     2=2 and
     fbc.set_of_books_id = :p_ca_set_of_books_id and
     fth.book_type_code in (select fbcs.book_type_code from fa_book_controls_sec fbcs) and
     fadj.book_type_code = fth.book_type_code and
     fadj.transaction_header_id = fth.transaction_header_id and
     ((fadj.source_type_code = 'CIP ADDITION' and fadj.adjustment_type = 'CIP COST') or
      (fadj.source_type_code = 'ADDITION' and fadj.adjustment_type = 'COST')
     ) and
     fdh.distribution_id = fadj.distribution_id and
     gcc.code_combination_id = fdh.code_combination_id and
     fl.lookup_type = 'ASSET TYPE' and
     fah.asset_type =  fl.lookup_code and
     fa.asset_id = fth.asset_id and
     fah.asset_id = fth.asset_id and
     fth.date_effective >= fah.date_effective and
     fth.date_effective < nvl(fah.date_ineffective, sysdate) and
     fb.transaction_header_id_in = fth.transaction_header_id and
     fcb.book_type_code = fth.book_type_code and
     fcb.category_id = fah.category_id and
     fbc.book_type_code = fth.book_type_code and
     fah.category_id = fcbk.category_id and
     gsob.set_of_books_id = fbc.set_of_books_id and
     gsob.currency_code = fc.currency_code and
     fdd.book_type_code (+) = fadj.book_type_code and
     fdd.distribution_id (+) = fadj.distribution_id and
     fdd.deprn_source_code (+) = 'B' and
     fds.book_type_code (+) = fadj.book_type_code and
     fds.asset_id (+) = fadj.asset_id and
     fds.period_counter (+) = fadj.period_counter_created
   group by
     fsc.company_name,
     gsob.name,
     fbc.book_type_code,
     fbc.deprn_calendar,
     gsob.currency_code,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
     fl.meaning,
     decode(fah.asset_type, 'CIP', fcb.cip_cost_acct,fcb.asset_cost_acct),
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'),
     decode(fah.asset_type, 'CIP', null,fcb.deprn_reserve_acct),
     fa.asset_number,
     fa.description,
     fcbk.concatenated_segments,
     fa.tag_number,
     fa.manufacturer_name,
     fa.serial_number,
     fa.model_number,
     fb.date_placed_in_service,
     fb.deprn_method_code,
     fb.life_in_months,
     fb.production_capacity,
     fb.adjusted_rate,
     decode (fah.asset_type, 'CIP', 0,nvl(fds.bonus_rate,0)),
     fth.transaction_header_id,
     fth.date_effective,
     fth.transaction_date_entered,
     fc.precision
   union
   select distinct --0 cost assets
     fsc.company_name,
     gsob.name ledger,
     fbc.book_type_code book,
     gsob.currency_code currency,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') balancing_segment,
     fl.meaning asset_type,
     decode(fah.asset_type, 'CIP', fcb.cip_cost_acct, fcb.asset_cost_acct) asset_account,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center,
     decode(fah.asset_type, 'CIP', null, fcb.deprn_reserve_acct) reserve_account,
     fa.asset_number,
     fa.description asset_description,
     fcbk.concatenated_segments asset_category,
     fa.tag_number,
     fa.manufacturer_name,
     fa.serial_number,
     fa.model_number,
     fb.date_placed_in_service,
     fb.deprn_method_code method,
     fb.life_in_months life,
     fb.adjusted_rate adj_rate,
     decode (fah.asset_type, 'CIP', 0, nvl(fds.bonus_rate,0)) bonus_rate,
     fb.production_capacity prod,
     fa_fas420_xmlp_pkg.d_lifeformula(fb.life_in_months, fb.adjusted_rate, decode (fah.asset_type, 'CIP', 0,nvl(fds.bonus_rate,0)), fb.production_capacity) d_life,
     0 cost,
     0 ytd_depreciation,
     0 initial_depreciation_reserve,
     (select fcp.period_name from fa_calendar_periods fcp where fcp.calendar_type=fbc.deprn_calendar and fth.transaction_date_entered between fcp.start_date and fcp.end_date) period_effective,
     (select fdp.period_name from fa_deprn_periods fdp where fdp.book_type_code=fbc.book_type_code and fth.date_effective between fdp.period_open_date and nvl(fdp.period_close_date,fth.date_effective)) period_entered,
     fth.transaction_header_id thid
   from
     fa_system_controls      fsc,
     fa_lookups              fl,
     fa_additions            fa,
     fa_asset_history        fah,
     fa_category_books       fcb,
     fa_categories_b_kfv     fcbk,
     gl_code_combinations    gcc,
     fa_distribution_history fdh,
     &lp_fa_books            fb,
     &lp_fa_deprn_summary    fds,
     fnd_currencies          fc,
     &lp_fa_book_controls    fbc,
     gl_sets_of_books        gsob,
     (select
        fth.book_type_code,
        fth.transaction_header_id,
        fth.asset_id,
        fth.date_effective,
        fth.transaction_date_entered,
        dp.period_counter
      from
        fa_transaction_headers fth,
        &lp_fa_book_controls   fbc,
        &lp_fa_deprn_periods   dp
      where
        2=2 and
        fth.book_type_code = fbc.book_type_code and 
        fth.book_type_code in (select fbcs.book_type_code from fa_book_controls_sec fbcs) and
        fth.transaction_type_code in ('ADDITION', 'CIP ADDITION') and
        dp.book_type_code = fth.book_type_code and
        fth.date_effective between dp.period_open_date and nvl (dp.period_close_date, sysdate)
     )                       fth
   where
     fbc.set_of_books_id = :p_ca_set_of_books_id and
     fdh.asset_id = fth.asset_id and
     fth.date_effective >= fdh.date_effective and
     fth.date_effective < nvl(fdh.date_ineffective, sysdate) and
     gcc.code_combination_id = fdh.code_combination_id and
     fl.lookup_type = 'ASSET TYPE' and
     fah.asset_type =  fl.lookup_code and
     fa.asset_id = fth.asset_id and
     fah.asset_id = fth.asset_id and
     fth.date_effective >= fah.date_effective and
     fth.date_effective < nvl(fah.date_ineffective, sysdate)  and
     fb.transaction_header_id_in = fth.transaction_header_id and
     fb.cost = 0 and
     fcb.book_type_code = fth.book_type_code and
     fcb.category_id = fah.category_id and
     fbc.book_type_code = fth.book_type_code and
     fah.category_id = fcbk.category_id and
     gsob.set_of_books_id = fbc.set_of_books_id and
     gsob.currency_code = fc.currency_code and
     fds.book_type_code (+) = fth.book_type_code and
     fds.asset_id (+) = fth.asset_id and
     fds.period_counter (+) = fth.period_counter
  ) x
where
:p_ledger_name=:p_ledger_name and
1=1
order by
  x.company_name,
  x.ledger,
  x.book,
  x.currency,
  x.balancing_segment,
  x.asset_type,
  x.asset_account,
  x.cost_center,
  x.reserve_account,
  x.asset_number