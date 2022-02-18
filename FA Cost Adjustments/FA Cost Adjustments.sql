/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Cost Adjustments
-- Description: Imported from BI Publisher
Description: Cost Adjustments Report
Application: Assets
Source: Cost Adjustments Report (XML)
Short Name: FAS840_XML
DB package: FA_FAS840_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/fa-cost-adjustments/
-- Library Link: https://www.enginatics.com/reports/fa-cost-adjustments/
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
  x.asset_number,
  x.asset_description,
  x.category category,
  x.period,
  sum(decode(x.unit_sum,x.units,x.old_cost1+x.old_cost-x.old_cost_rsum,x.old_cost1)) old_cost,
  sum(decode(x.unit_sum,x.units,x.new_cost1+x.new_cost-x.new_cost_rsum,x.new_cost1)) new_cost,
  sum(decode(x.unit_sum,x.units,x.new_cost1+x.new_cost-x.new_cost_rsum,x.new_cost1) - decode(x.unit_sum,x.units,x.old_cost1+x.old_cost-x.old_cost_rsum,x.old_cost1)) net_change,
  x.transaction_number,
  x.company_name || ': ' || x.book || ' (' || x.currency || ')' comp_book_curr_label
from
  ( select
      fsc.company_name,
      gl.name ledger,
      fdp.book_type_code book,
      gl.currency_code currency,
      fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'GL_BALANCING','Y','VALUE') balancing_segment,
      fl.meaning asset_type,
      decode(fah.asset_type, 'CIP', fcb.cip_cost_acct, fcb.asset_cost_acct) asset_account,
      fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE') cost_center,
      fa.asset_number asset_number,
      fa.description  asset_description,
      fnd_flex_xml_publisher_apis.process_kff_combination_1('cat_flex_all_seg', 'OFA', 'CAT#', fsc.category_flex_structure, NULL, fc.category_id, 'ALL', 'Y', 'VALUE') category,
      fdp.period_name period,
      round((fb_old.cost * nvl(fdh.units_assigned,fah.units)/fah.units), fcu.precision) old_cost1,
      (round((fb_old.cost * nvl(fdh.units_assigned,fah.units)/fah.units), fcu.precision) + round(((fb_new.cost - fb_old.cost)* nvl(fdh.units_assigned,fah.units)/fah.units), fcu.precision)) new_cost1,
      sum(round((fb_old.cost * nvl(fdh.units_assigned,fah.units)/fah.units), fcu.precision)) over(partition by fth.transaction_header_id,fdh.asset_id order by fdh.distribution_id) old_cost_rsum,
      sum((round((fb_old.cost * nvl(fdh.units_assigned,fah.units)/fah.units), fcu.precision) + round(((fb_new.cost - fb_old.cost)* nvl(fdh.units_assigned,fah.units)/fah.units), fcu.precision))) over(partition by fth.transaction_header_id,fdh.asset_id order by fdh.distribution_id) new_cost_rsum,
      sum(nvl(fdh.units_assigned,fah.units)) over (partition by fth.transaction_header_id,fdh.asset_id order by fdh.distribution_id) unit_sum,
      fah.units units,
      fb_old.cost old_cost,
      fb_new.cost new_cost,
      fth.transaction_header_id transaction_number
    from
      fa_system_controls      fsc,
      gl_ledgers              gl,
      fnd_currencies          fcu,
      fa_asset_history        fah,
      fa_additions            fa,
      fa_categories           fc,
      fa_category_books       fcb,
      &lp_fa_books            fb_old,
      &lp_fa_books            fb_new,
      fa_lookups              fl,
      &lp_fa_deprn_periods    fdp,
      fa_distribution_history fdh,
      gl_code_combinations    gcc,
      fa_transaction_headers  fth
    where
      gl.ledger_id = :p_ca_set_of_books_id and
      fcu.currency_code = gl.currency_code and
      fdp.book_type_code = :p_book and
      fdp.period_counter >= :period1_pc and
      fdp.period_counter <= nvl(:period2_pc, fdp.period_counter) and
      fth.book_type_code = fdp.book_type_code and
      fth.date_effective between fdp.period_open_date and nvl(fdp.period_close_date, sysdate) and
      fth.transaction_type_code in ('ADJUSTMENT','CIP ADJUSTMENT') and
      fb_old.transaction_header_id_out = fth.transaction_header_id and
      fb_old.book_type_code = fth.book_type_code and
      fb_new.transaction_header_id_in = fth.transaction_header_id and
      fb_new.book_type_code = fth.book_type_code and
      fa.asset_id = fth.asset_id and
      fl.lookup_type = 'ASSET TYPE' and
      fcb.category_id = fah.category_id and
      fcb.book_type_code = fth.book_type_code and
      fc.category_id = fcb.category_id and
      fah.asset_id = fa.asset_id and
      fah.asset_type = fl.lookup_code and
      fth.transaction_header_id >= fah.transaction_header_id_in and
      fth.transaction_header_id < nvl(fah.transaction_header_id_out, fth.transaction_header_id + 1) and
      fth.asset_id = fdh.asset_id and
      :p_distribution_source_book = fdh.book_type_code and
      fth.transaction_header_id >= fdh.transaction_header_id_in and
      fth.transaction_header_id < nvl(fdh.transaction_header_id_out, fth.transaction_header_id + 1) and
      fdh.code_combination_id = gcc.code_combination_id and
      round((fb_old.cost * nvl(fdh.units_assigned,fah.units)/fah.units), fcu.precision) != round((fb_new.cost * nvl(fdh.units_assigned,fah.units)/fah.units), fcu.precision)
  ) x
group by
  x.company_name,
  x.ledger,
  x.book,
  x.currency,
  x.balancing_segment,
  x.asset_type,
  x.cost_center,
  x.asset_account,
  x.asset_number,
  x.asset_description,
  x.category,
  x.period,
  x.transaction_number
order by
  x.company_name,
  x.ledger,
  x.book,
  x.currency,
  x.balancing_segment,
  x.asset_type,
  x.asset_account,
  x.cost_center,
  x.asset_number,
  x.transaction_number