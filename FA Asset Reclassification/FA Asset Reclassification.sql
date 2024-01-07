/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Reclassification
-- Description: Application: Assets
Source: Asset Reclassification Report (XML) - Not Supported: Reserved For Future Use
Short Name: FAS740_XML
DB package: FA_FAS740_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-reclassification/
-- Library Link: https://www.enginatics.com/reports/fa-asset-reclassification/
-- Run Report: https://demo.enginatics.com/

select
 fsc.company_name,
 gsob.name ledger,
 gsob.currency_code currency,
 fbcs.book_type_code book,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('bal_seg', 'SQLGL', 'GL#', gcc_dh.chart_of_accounts_id, NULL, gcc_dh.code_combination_id,'GL_BALANCING','Y','VALUE') balancing_segment,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('bal_seg', 'SQLGL', 'GL#', gcc_dh.chart_of_accounts_id, NULL, gcc_dh.code_combination_id,'GL_BALANCING','Y','DESCRIPTION') balancing_segment_desc,
 decode(fah_start.asset_type,'CIP',fcb_start.cip_cost_acct,fcb_start.asset_cost_acct) from_asset_account,
 decode(fah_start.asset_type, 'CIP','',fcb_start.deprn_reserve_acct) from_reserve_account,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('asset_cat', 'OFA', 'CAT#', fsc.category_flex_structure, null, fc_start.category_id,'ALL','Y','VALUE') from_asset_category,
 decode(fah_end.asset_type,'CIP',fcb_end.cip_cost_acct,fcb_end.asset_cost_acct) to_asset_account,
 decode(fah_end.asset_type,'CIP','', fcb_end.deprn_reserve_acct) to_reserve_account,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('asset_cat', 'OFA', 'CAT#', fsc.category_flex_structure, null, fc_end.category_id,'ALL','Y','VALUE') to_asset_category,
 fa.asset_number asset_number,
 sum(decode(fadj_cost.debit_credit_flag,'DR',1,'CR',-1) * fadj_cost.adjustment_amount) cost_adjustment,
 sum(decode(fadj_resv.debit_credit_flag,'DR',-1,'CR',1)  * nvl(fadj_resv.adjustment_amount,0)) reserve_adjustment,
 fth.transaction_header_id transaction_header_id
from
 fa_system_controls      fsc,
 fa_book_controls_sec    fbcs,
 fa_deprn_periods        fdp,
 fa_deprn_periods        fdp_start,
 fa_deprn_periods        fdp_end,
 fa_additions            fa,
 gl_code_combinations    gcc_dh,
 fa_categories           fc_start,
 fa_categories           fc_end,
 fa_category_books       fcb_start,
 fa_category_books       fcb_end,
 fa_transaction_headers  fth,
 fa_adjustments          fadj_cost,
 fa_adjustments          fadj_resv,
 fa_asset_history        fah_start,
 fa_asset_history        fah_end,
 fa_distribution_history fdh,
 gl_sets_of_books        gsob
where
 1=1 and
 :p_ledger_name=:p_ledger_name and
 fbcs.set_of_books_id = :p_ca_set_of_books_id and
 gsob.set_of_books_id = fbcs.set_of_books_id and
 fdp_start.period_counter = 
 (select
  min(fdp.period_counter)
  from
  fa_deprn_periods fdp2
  where
  fdp2.book_type_code = fbcs.book_type_code and
  fdp2.calendar_period_open_date >= (select fcp.start_date from fa_calendar_periods fcp where fcp.calendar_type = fbcs.deprn_calendar and fcp.period_name = :p_period1)
 ) and
 fdp_end.period_counter = 
 (select
  max(fdp.period_counter)
  from
  fa_deprn_periods fdp2
  where
  fdp2.book_type_code = fbcs.book_type_code and
  fdp2.calendar_period_open_date <= (select fcp.start_date from fa_calendar_periods fcp where fcp.calendar_type = fbcs.deprn_calendar and fcp.period_name = :p_period2)
 ) and
 fdp_start.book_type_code = upper(fbcs.book_type_code) and
 fdp_end.book_type_code = fdp_start.book_type_code and
 fdp.book_type_code = fdp_start.book_type_code and
 fdp.period_counter >= fdp_start.period_counter and
 fdp.period_counter <= nvl(fdp_end.period_counter,fdp.period_counter) and
 fth.book_type_code = fbcs.book_type_code and
 fth.transaction_type_code = 'RECLASS' and
 fth.date_effective >= fdp.period_open_date and
 fth.date_effective <= nvl (fdp.period_close_date, sysdate) and
 fa.asset_id = fth.asset_id and
 fah_start.asset_id = fth.asset_id and
 fah_start.date_ineffective = fth.date_effective and
 fah_end.asset_id = fth.asset_id and
 fah_end.date_effective = fth.date_effective and
 fc_end.category_id = fah_end.category_id and
 fc_start.category_id = fah_start.category_id and
 fcb_end.book_type_code = upper (fbcs.book_type_code) and
 fcb_end.category_id = fah_end.category_id and
 fcb_start.book_type_code = upper (fbcs.book_type_code) and
 fcb_start.category_id = fah_start.category_id and
 fadj_cost.transaction_header_id = fth.transaction_header_id and
 fadj_cost.book_type_code = fbcs.book_type_code and
 fadj_cost.source_type_code = 'RECLASS' and
 fadj_cost.adjustment_type in ('COST','CIP COST') and
 fadj_cost.period_counter_created >= fdp_start.period_counter and
 fadj_cost.period_counter_created <= nvl (fdp_end.period_counter, fdp.period_counter) and
 fadj_resv.transaction_header_id (+) = fadj_cost.transaction_header_id and
 fadj_resv.asset_id (+) = fadj_cost.asset_id and
 fadj_resv.distribution_id (+) = fadj_cost.distribution_id and
 fadj_resv.book_type_code (+) = upper(fbcs.book_type_code) and
 fadj_resv.source_type_code (+) = 'RECLASS' and
 fadj_resv.adjustment_type (+) = 'RESERVE' and
 fadj_resv.period_counter_created(+) = fadj_cost.period_counter_created and
 fadj_resv.adjustment_amount(+) != 0 and
 fdh.book_type_code = fbcs.distribution_source_book and
 fdh.asset_id = fth.asset_id and
 fdh.transaction_header_id_in = nvl(fth.source_transaction_header_id, fth.transaction_header_id) and
 fdh.distribution_id = fadj_cost.distribution_id and
 gcc_dh.code_combination_id = fdh.code_combination_id
group by
 fsc.company_name,
 gsob.name,
 gsob.currency_code,
 fbcs.book_type_code,
 fsc.category_flex_structure,
 gcc_dh.chart_of_accounts_id,
 gcc_dh.code_combination_id,
 decode(fah_start.asset_type,'CIP',fcb_start.cip_cost_acct,fcb_start.asset_cost_acct),
 decode(fah_start.asset_type,'CIP','',fcb_start.deprn_reserve_acct),
 fc_start.category_id,
 decode(fah_end.asset_type,'CIP',fcb_end.cip_cost_acct, fcb_end.asset_cost_acct),
 decode(fah_end.asset_type,'CIP','',fcb_end.deprn_reserve_acct),
 fc_end.category_id,
 fa.asset_number,
 fth.transaction_header_id
order by
 balancing_segment,
 from_asset_account,
 from_reserve_account,
 from_asset_category,
 to_asset_account,
 to_reserve_account,
 to_asset_category,
 asset_number,
 cost_adjustment,
 reserve_adjustment,
 transaction_header_id