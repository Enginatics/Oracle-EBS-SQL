/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Retirements
-- Description: Imported from BI Publisher
Description: Asset Retirements Report
Application: Assets
Source: Asset Retirements Report (XML)
Short Name: FAS440_XML
DB package: FA_FAS440_XMLP_PKG

-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-retirements/
-- Library Link: https://www.enginatics.com/reports/fa-asset-retirements/
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
  x.asset_desciption,
  x.date_placed_in_service,
  x.date_retired,
  x.period,
  x.transaction_type,
  x.cost_retired,
  x.net_book_value_retired,
  x.proceeds_of_sale,
  x.removal_cost,
  x.reval_reserve_retired,
  (  -x.net_book_value_retired
   + x.proceeds_of_sale
   - x.removal_cost
   + x.reval_reserve_retired
  ) gain_loss,
  x.transaction_number,
  x.company_name || ': ' || x.book || ' (' || x.currency || ')' comp_book_curr_label
from
  (select   /*+ ordered */
     fsc.company_name,
     gsob.name ledger,
     fb.book_type_code book,
     gsob.currency_code currency,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') balancing_segment,
     fl.meaning        asset_type,
     decode(fah.asset_type,'CIP', fcb.cip_cost_acct,fcb.asset_cost_acct) asset_account,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center,
     fa.asset_number,
     fa.description asset_desciption,
     fr.date_retired,
     (select fdp.period_name from fa_deprn_periods fdp where fdp.book_type_code=fb.book_type_code and fth.date_effective >= fdp.calendar_period_open_date and fth.date_effective < fdp.calendar_period_close_date + 1 and rownum<=1) period,
     fth.transaction_type_code,
     (select flv.meaning from fa_lookups_vl flv where flv.lookup_type='FAXOLTRX' and fth.transaction_type_code=flv.lookup_code) transaction_type,
     fth.asset_id,
     fb.date_placed_in_service,
     sum(decode(fadj.adjustment_type,'COST',1, 'CIP COST',1,0)        * decode(fadj.debit_credit_flag,'DR',-1,'CR', 1,0) * fadj.adjustment_amount) cost_retired,
     sum(decode(fadj.adjustment_type,'NBV RETIRED',-1,0)              * decode(fadj.debit_credit_flag,'DR',-1,'CR', 1,0) * fadj.adjustment_amount) net_book_value_retired,
     sum(decode(fadj.adjustment_type,'PROCEEDS CLR',1,'PROCEEDS',1,0) * decode(fadj.debit_credit_flag,'DR', 1,'CR',-1,0) * fadj.adjustment_amount) proceeds_of_sale,
     sum(decode(fadj.adjustment_type,'REMOVALCOST',-1,0)              * decode(fadj.debit_credit_flag,'DR',-1,'CR', 1,0) * fadj.adjustment_amount) removal_cost,
     sum(decode(fadj.adjustment_type,'REVAL RSV RET',1,0)             * decode(fadj.debit_credit_flag,'DR',-1,'CR', 1,0) * fadj.adjustment_amount) reval_reserve_retired,
     fth.transaction_header_id transaction_number
   from
     fa_system_controls      fsc,
     gl_sets_of_books        gsob,
     fa_transaction_headers  fth,
     fa_additions            fa,
     &lp_fa_books            fb,
     &lp_fa_retirements      fr,
     &lp_fa_adjustments      fadj,
     fa_distribution_history fdh,
     gl_code_combinations    gcc,
     fa_asset_history        fah,
     fa_category_books       fcb,
     fa_lookups              fl
   where
     gsob.set_of_books_id = :p_ca_set_of_books_id and
     fth.date_effective >= :period1_pod and
     fth.date_effective <= :period2_pcd and
     fth.book_type_code =  :p_book and
     fth.transaction_key = 'R' and
     fr.book_type_code = :p_book and
     fr.asset_id = fb.asset_id and
     decode(fth.transaction_type_code,'REINSTATEMENT', fr.transaction_header_id_out,fr.transaction_header_id_in) = fth.transaction_header_id and
     fa.asset_id = fth.asset_id and
     fadj.asset_id = fr.asset_id and
     fadj.book_type_code = :p_book and
     fadj.adjustment_type not in
       (select
          'PROCEEDS'
        from
          &lp_fa_adjustments fadj1
        where
          fadj1.book_type_code  = fadj.book_type_code and
          fadj1.asset_id        = fadj.asset_id and
          fadj1.transaction_header_id = fadj.transaction_header_id and
          fadj1.adjustment_type = 'PROCEEDS CLR'
       ) and
     fadj.transaction_header_id = fth.transaction_header_id and
     fah.asset_id = fa.asset_id and
     fah.date_effective <= fth.date_effective and
     nvl(fah.date_ineffective, fth.date_effective+1) > fth.date_effective and
     fl.lookup_code = fah.asset_type and
     fl.lookup_type = 'ASSET TYPE' and
     fb.transaction_header_id_out = fth.transaction_header_id and
     fb.book_type_code = :p_book and
     fb.asset_id = fa.asset_id and
     fcb.category_id = fah.category_id and
     fcb.book_type_code = :p_book and
     fdh.distribution_id = fadj.distribution_id and
     fth.asset_id = fdh.asset_id and
     gcc.code_combination_id  = fdh.code_combination_id
   group by
     fsc.company_name,
     gsob.name,
     fb.book_type_code,
     gsob.currency_code,
     fl.meaning,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'),
     fth.transaction_type_code,
     fth.asset_id,
     fcb.asset_cost_acct,
     fcb.cip_cost_acct,
     fa.asset_number,
     fa.description,
     fb.date_placed_in_service,
     fr.date_retired,
     fth.date_effective,
     fth.transaction_header_id,
     fah.asset_type,
     fr.gain_loss_amount
   union
   select  /*+ ordered */
     fsc.company_name,
     gsob.name ledger,
     fb.book_type_code book,
     gsob.currency_code currency,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') balancing_segment,
     fl.meaning        asset_type,
     decode (fah.asset_type,'CIP', fcb.cip_cost_acct,fcb.asset_cost_acct) asset_account,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center,
     fa.asset_number,
     fa.description asset_desciption,
     fr.date_retired,
     (select fdp.period_name from fa_deprn_periods fdp where fdp.book_type_code=fb.book_type_code and fth.date_effective >= fdp.calendar_period_open_date and fth.date_effective < fdp.calendar_period_close_date + 1 and rownum<=1) period,
     fth.transaction_type_code,
     (select flv.meaning from fa_lookups_vl flv where flv.lookup_type='FAXOLTRX' and fth.transaction_type_code=flv.lookup_code) transaction_type,
     fth.asset_id,
     fb.date_placed_in_service,
     0  cost_retired,
     0  net_book_value_retired,
     nvl(fr.proceeds_of_sale,0) proceeds_of_sale,
     nvl(fr.cost_of_removal,0) removal_cost,
	    0		reval_reserve_retired,
     fth.transaction_header_id transaction_number
   from
     fa_system_controls      fsc,
     gl_sets_of_books        gsob,
     fa_transaction_headers  fth,
     fa_additions            fa,
     &lp_fa_books            fb,
     &lp_fa_retirements      fr,
     (select
        fdh.*
      from
        fa_transaction_headers  fth1,
        fa_distribution_history fdh,
        fa_book_controls        fbc,
        fa_transaction_headers  fth2
      where
        fth1.book_type_code          = :p_book and
        fth1.transaction_type_code  in ( 'FULL RETIREMENT', 'PARTIAL RETIREMENT') and
        fth1.date_effective    between :period1_pod and :period2_pcd and
        fth1.asset_id                = fdh.asset_id and
        fbc.book_type_code           = fth1.book_type_code and
        fbc.distribution_source_book = fdh.book_type_code and
        fth1.date_effective         <= nvl(fdh.date_ineffective,fth1.date_effective) and
        fth1.asset_id                = fth2.asset_id and
        fth2.book_type_code          = :p_book and
        fth2.transaction_type_code   = 'REINSTATEMENT' and
        fth2.date_effective    between :period1_pod and :period2_pcd and
        fth2.date_effective         >=  fdh.date_effective
     )                       fdh,
     gl_code_combinations    gcc,
     fa_asset_history        fah,
     fa_category_books       fcb,
     fa_lookups              fl
   where
     gsob.set_of_books_id = :p_ca_set_of_books_id and
     fth.date_effective >= :period1_pod and
     fth.date_effective <= :period2_pcd and
     fth.book_type_code =  :p_book and
     fth.transaction_key = 'R' and
     fr.book_type_code = :p_book and
     fr.asset_id = fb.asset_id and
     fr.transaction_header_id_out = fth.transaction_header_id and
     fa.asset_id = fth.asset_id and
     fah.asset_id = fa.asset_id and
     fah.date_effective <= fth.date_effective and
     nvl(fah.date_ineffective, fth.date_effective+1) > fth.date_effective and
     fl.lookup_code = fah.asset_type and
     fl.lookup_type = 'ASSET TYPE' and
     fb.transaction_header_id_out = fth.transaction_header_id and
     fb.book_type_code = :p_book and
     fb.asset_id = fa.asset_id and
     fcb.category_id = fah.category_id and
     fcb.book_type_code = :p_book and
     fth.asset_id = fdh.asset_id and
     gcc.code_combination_id = fdh.code_combination_id and
     fth.transaction_type_code = 'REINSTATEMENT' and
     fr.cost_retired = 0 and
     fr.cost_of_removal = 0 and
     fr.proceeds_of_sale = 0
   group by
     fsc.company_name,
     gsob.name,
     fb.book_type_code,
     gsob.currency_code,
     fl.meaning,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
     fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'),
     fth.transaction_type_code,
     fth.asset_id,
     fcb.asset_cost_acct,
     fcb.cip_cost_acct,
     fa.asset_number,
     fa.description,
     fb.date_placed_in_service,
     fr.date_retired,
     fth.date_effective,
     fth.transaction_header_id,
     fah.asset_type,
     fr.gain_loss_amount,
     fr.status,
     fr.proceeds_of_sale,
     fr.cost_of_removal
  ) x
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
  x.date_retired