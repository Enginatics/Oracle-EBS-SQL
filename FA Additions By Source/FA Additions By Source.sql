/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Additions By Source
-- Description: Application: Assets
Source: Additions By Source Report
Short Name: FASASSBS

-- Excel Examle Output: https://www.enginatics.com/example/fa-additions-by-source/
-- Library Link: https://www.enginatics.com/reports/fa-additions-by-source/
-- Run Report: https://demo.enginatics.com/

select
 fas.source,
 fas.company,
 fas.company_desc,
 fas.asset_type,
 fas.account,
 fas.account_desc,
 fas.cost_center,
 fas.cost_center_desc,
 fas.asset_number,
 fas.asset_description,
 fas.vendor_number,
 fas.invoice_number,
 fas.invoice_line,
 fas.invoice_description,
 fas.original_invoice_cost,
 fas.current_invoice_cost,
 fas.asset_cost,
 (select flv.meaning from fa_lookups_vl flv where flv.lookup_type = 'INVOICE TRANSACTION TYPE' and flv.lookup_code = fas.trx_flag) trx_flag,
 case when fas.asset_cost is not null and fas.asset_type_code = 'CIP'
 then case when sum(fas.current_invoice_cost) over (partition by fas.source,fas.company,fas.asset_type,fas.account,fas.cost_center,fas.asset_number)
             != sum(fas.asset_cost) over (partition by fas.source,fas.company,fas.asset_type,fas.account,fas.cost_center,fas.asset_number)
           then sum(fas.asset_cost) over (partition by fas.source,fas.company,fas.asset_type,fas.account,fas.cost_center,fas.asset_number)
              - sum(fas.current_invoice_cost) over (partition by fas.source,fas.company,fas.asset_type,fas.account,fas.cost_center,fas.asset_number)
           else to_number(null) end
 end unbalanced_amount,
 case when fas.asset_cost is not null and fas.asset_type_code = 'CIP'
 then case when sum(fas.current_invoice_cost) over (partition by fas.source,fas.company,fas.asset_type,fas.account,fas.cost_center,fas.asset_number)
             != sum(fas.asset_cost) over (partition by fas.source,fas.company,fas.asset_type,fas.account,fas.cost_center,fas.asset_number)
           then 'Y' else 'N' end
 end unbalanced_flag,
 fas.company || ' - ' || fas.company_desc company_label,
 fas.account || ' - ' || fas.account_desc account_label,
 fas.cost_center || ' - ' || fas.cost_center_desc cost_center_label,
 fas.asset_number || ' - ' || fas.asset_description asset_label
from
(
select
 decode(th.mass_reference_id,null,'Manual','Mass Additions') source,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') company,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') company_desc,
 ah.asset_type asset_type_code,
 falu.meaning asset_type,
 decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct) account,
 gl_flexfields_pkg.get_description(dhcc.chart_of_accounts_id,'GL_ACCOUNT',decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct)) account_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION') cost_center_desc,
 --
 ad.asset_number,
 ad.description asset_description,
 null vendor_number,
 null invoice_number,
 to_number(null) invoice_line,
 null invoice_description,
 to_number(null) original_invoice_cost,
 to_number(null) current_invoice_cost,
 sum(nvl(dd.addition_cost_to_clear, 0)) asset_cost,
 null trx_flag,
 1 ord_by
from
 fa_distribution_history dh,
 fa_asset_history ah,
 fa_category_books cb,
 fa_lookups falu,
 fa_additions ad,
 gl_code_combinations dhcc,
 fa_transaction_headers th,
 fa_deprn_detail dd,
 fa_deprn_periods dp
where
 dp.book_type_code =:p_book
 and dp.period_counter >=:period1_pc
 and dp.period_counter <= nvl(:period2_pc, dp.period_counter)
 and th.asset_id = dd.asset_id
 and th.date_effective >= dp.period_open_date
 and th.date_effective < nvl(dp.period_close_date, sysdate)
 and th.book_type_code = :p_book
 and th.transaction_type_code in ('TRANSFER IN','TRANSFER IN/VOID')
 and th.transaction_header_id =
  (select
    min(transaction_header_id)
   from
    fa_transaction_headers thvoid
   where
    thvoid.book_type_code = th.book_type_code
    and thvoid.transaction_type_code in ('TRANSFER IN/VOID', 'TRANSFER IN')
    and thvoid.asset_id = th.asset_id)
 and dh.book_type_code = :p_distrib_source_book
 and dh.asset_id = dd.asset_id
 and dhcc.code_combination_id = dh.code_combination_id
 and dd.book_type_code = :p_book
 and dd.deprn_source_code = 'B'
 and dd.distribution_id = dh.distribution_id
 and dd.period_counter = dp.period_counter - 1
 and cb.category_id = ah.category_id
 and cb.book_type_code = :p_book
 and ad.asset_id = dd.asset_id
 and ah.asset_id = ad.asset_id
 and ah.date_effective <= nvl(dp.period_close_date, sysdate)
 and nvl(ah.date_ineffective,sysdate+1) > nvl(dp.period_close_date, sysdate)
 and ah.asset_type = falu.lookup_code
 and falu.lookup_type = 'ASSET TYPE'
group by
 decode(th.mass_reference_id,null,'Manual','Mass Additions'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION'),
 ah.asset_type,
 falu.meaning,
 decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct),
 gl_flexfields_pkg.get_description(dhcc.chart_of_accounts_id,'GL_ACCOUNT',decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct)),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION'),
 ad.asset_number,
 ad.description
union all
select
 decode(th.mass_reference_id,null,'Manual','Mass Additions') source,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') company,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') company_desc,
 ah.asset_type asset_type_code,
 falu.meaning asset_type,
 decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct) account,
 gl_flexfields_pkg.get_description(dhcc.chart_of_accounts_id,'GL_ACCOUNT',decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct)) account_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION') cost_center_desc,
 --
 ad.asset_number,
 ad.description asset_descripton,
 null vendor_number,
 null invoice_number,
 to_number(null) invoice_line,
 null invoice_description,
 to_number(null) original_invoice_cost,
 to_number(null) current_invoice_cost,
 sum(decode(adj.debit_credit_flag, 'DR',1,-1) * adj.adjustment_amount) asset_cost,
 null trx_flag,
 1 ord_by
from
 fa_transaction_headers th,
 fa_transaction_headers thdis,
 fa_additions ad,
 fa_asset_history ah,
 fa_category_books cb,
 fa_distribution_history dh,
 gl_code_combinations dhcc,
 gl_code_combinations ajcc,
 fa_lookups falu,
 fa_adjustments adj,
 fa_deprn_periods dp
where
 dp.book_type_code = :p_book
 and dp.period_counter >= :period1_pc
 and dp.period_counter <= nvl(:period2_pc,dp.period_counter)
 and th.date_effective >= dp.period_open_date
 and th.date_effective < nvl(dp.period_close_date, sysdate)
 and th.book_type_code = :p_book
 and th.transaction_type_code = 'ADDITION'
 and thdis.transaction_type_code = 'TRANSFER IN'
 and thdis.book_type_code = :p_book
 and thdis.asset_id = th.asset_id
 and thdis.date_effective < dp.period_open_date
 and adj.book_type_code = :p_book
 and adj.asset_id = th.asset_id
 and adj.source_type_code = 'ADDITION'
 and adj.adjustment_type = 'COST'
 and adj.period_counter_created = dp.period_counter
 and adj.code_combination_id = ajcc.code_combination_id
 and dh.book_type_code = :p_book
 and dh.asset_id = th.asset_id
 and dh.distribution_id = adj.distribution_id
 and dh.code_combination_id = dhcc.code_combination_id
 and cb.category_id = ah.category_id
 and cb.book_type_code = :p_book
 and ad.asset_id = th.asset_id
 and ah.asset_id = th.asset_id
 and ah.date_effective <= th.date_effective
 and nvl(ah.date_ineffective,sysdate+1) > th.date_effective
 and ah.asset_type = falu.lookup_code
 and falu.lookup_type = 'ASSET TYPE'
group by
 decode(th.mass_reference_id,null,'Manual','Mass Additions'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION'),
 ah.asset_type,
 falu.meaning,
 decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct),
 gl_flexfields_pkg.get_description(dhcc.chart_of_accounts_id,'GL_ACCOUNT',decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct)),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION'),
 ad.asset_number,
 ad.description
union all
select
 decode(th.mass_reference_id,null,'Manual','Mass Additions') source,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') company,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') company_desc,
 ah.asset_type asset_type_code,
 falu.meaning asset_type,
 decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct) account,
 gl_flexfields_pkg.get_description(dhcc.chart_of_accounts_id,'GL_ACCOUNT',decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct)) account_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION') cost_center_desc,
 --
 ad.asset_number,
 ad.description asset_description,
 po_vend.segment1 vendor_number,
 ai_in.invoice_number invoice_number,
 ai_in.invoice_line_number||' - '||ai_in.ap_distribution_line_number invoice_line,
 ai_in.description invoice_description,
 ai_in.payables_cost original_invoice_cost,
 round(sum(dh.units_assigned/ah.units * ai_in.fixed_assets_cost), :precision) current_invoice_cost,
 to_number(null) asset_cost,
 case when it.transaction_type in ('INVOICE ADDITION', 'INVOICE ADJUSTMENT', 'INVOICE TRANSFER','INVOICE REINSTATE')
 then it.transaction_type else null end trx_flag,
 2 ord_by
from
 fa_asset_invoices ai_in,
 fa_invoice_transactions it,
 fa_transaction_headers th,
 fa_distribution_history dh,
 fa_asset_history ah,
 fa_category_books cb,
 fa_lookups falu,
 po_vendors po_vend,
 fa_additions ad,
 gl_code_combinations dhcc,
 fa_deprn_detail dd,
 fa_deprn_periods dp
where
 dp.book_type_code = :p_book
 and dp.period_counter >= :period1_pc
 and dp.period_counter <= nvl(:period2_pc,dp.period_counter)
 and th.asset_id = dd.asset_id
 and th.date_effective >= dp.period_open_date
 and th.date_effective < nvl(dp.period_close_date, sysdate)
 and th.book_type_code = :p_book
 and th.transaction_type_code in ('TRANSFER IN','TRANSFER IN/VOID')
 and th.transaction_header_id =
  (select
    min(transaction_header_id)
   from
    fa_transaction_headers thvoid
   where
    thvoid.book_type_code = th.book_type_code
    and thvoid.transaction_type_code in ('TRANSFER IN/VOID', 'TRANSFER IN')
    and thvoid.asset_id = th.asset_id)
 and dh.book_type_code = :p_distrib_source_book
 and dh.asset_id = dd.asset_id
 and dhcc.code_combination_id = dh.code_combination_id
 and dd.book_type_code = :p_book
 and dd.deprn_source_code = 'B'
 and dd.distribution_id = dh.distribution_id
 and dd.period_counter = dp.period_counter - 1
 and cb.category_id = ah.category_id
 and cb.book_type_code = :p_book
 and ad.asset_id = dd.asset_id
 and ah.asset_id = ad.asset_id
 and ah.date_effective <= nvl(dp.period_close_date, sysdate)
 and nvl(ah.date_ineffective,sysdate+1) > nvl(dp.period_close_date, sysdate)
 and ah.asset_type = falu.lookup_code
 and falu.lookup_type = 'ASSET TYPE'
 and it.invoice_transaction_id = ai_in.invoice_transaction_id_in
 and ai_in.asset_id = th.asset_id
 and ai_in.date_effective <= nvl(dp.period_close_date, sysdate)
 and nvl(ai_in.date_ineffective, sysdate+1) > nvl(dp.period_close_date, sysdate)
 and ai_in.deleted_flag = 'NO'
 and po_vend.vendor_id(+) = ai_in.po_vendor_id
group by
 decode(th.mass_reference_id,null,'Manual','Mass Additions'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION'),
 ah.asset_type,
 falu.meaning,
 decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct),
 gl_flexfields_pkg.get_description(dhcc.chart_of_accounts_id,'GL_ACCOUNT',decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct)),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION'),
 ad.asset_number,
 ad.description,
 po_vend.segment1,
 ai_in.invoice_number,
 ai_in.invoice_line_number||' - '||ai_in.ap_distribution_line_number,
 ai_in.description,
 ai_in.payables_cost,
 case when it.transaction_type in ('INVOICE ADDITION', 'INVOICE ADJUSTMENT', 'INVOICE TRANSFER','INVOICE REINSTATE')
 then it.transaction_type else null end
union all
select
 decode(th.mass_reference_id,null,'Manual','Mass Additions') source,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') company,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') company_desc,
 ah.asset_type asset_type_code,
 falu.meaning asset_type,
 decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct) account,
 gl_flexfields_pkg.get_description(dhcc.chart_of_accounts_id,'GL_ACCOUNT',decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct)) account_desc,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION') cost_center_desc,
 --
 ad.asset_number,
 ad.description asset_description,
 po_vend.segment1 vendor_number,
 ai_in.invoice_number invoice_number,
 ai_in.invoice_line_number||' - '||ai_in.ap_distribution_line_number invoice_line,
 ai_in.description invoice_description,
 ai_in.payables_cost original_invoice_cost,
 round(sum(dh.units_assigned/ah.units * ai_in.fixed_assets_cost),:precision) current_invoice_cost,
 to_number(null) asset_cost,
 case when it.transaction_type in ('INVOICE ADDITION', 'INVOICE ADJUSTMENT', 'INVOICE TRANSFER','INVOICE REINSTATE')
 then it.transaction_type else null end trx_flag,
 2 ord_by
from
 fa_asset_invoices ai_in,
 fa_invoice_transactions it,
 fa_transaction_headers thdis,
 fa_distribution_history dh,
 fa_asset_history ah,
 fa_category_books cb,
 fa_lookups falu,
 po_vendors po_vend,
 fa_additions ad,
 gl_code_combinations dhcc,
 fa_transaction_headers th,
 fa_deprn_periods dp
where
 dp.book_type_code = :p_book
 and dp.period_counter >=:period1_pc
 and dp.period_counter <= nvl(:period2_pc,dp.period_counter)
 and th.date_effective >= dp.period_open_date
 and th.date_effective < nvl(dp.period_close_date, sysdate)
 and th.book_type_code = :p_book
 and th.transaction_type_code = 'ADDITION'
 and thdis.transaction_type_code = 'TRANSFER IN'
 and thdis.book_type_code = :p_book
 and thdis.asset_id = th.asset_id
 and thdis.date_effective < dp.period_open_date
 and dh.book_type_code = :p_book
 and dh.asset_id = th.asset_id
 and dh.code_combination_id = dhcc.code_combination_id
 and dh.date_effective <= th.date_effective
 and nvl(dh.date_ineffective, sysdate) > th.date_effective
 and cb.category_id = ah.category_id
 and cb.book_type_code = :p_book
 and ad.asset_id = th.asset_id
 and ah.asset_id = th.asset_id
 and ah.date_effective <= th.date_effective
 and nvl(ah.date_ineffective,sysdate+1) > th.date_effective
 and ah.asset_type = falu.lookup_code
 and falu.lookup_type = 'ASSET TYPE'
 and it.invoice_transaction_id = ai_in.invoice_transaction_id_in
 and ai_in.asset_id = th.asset_id
 and ai_in.date_effective <= nvl(dp.period_close_date, sysdate)
 and nvl(ai_in.date_ineffective, sysdate+1) > nvl(dp.period_close_date, sysdate)
 and ai_in.deleted_flag = 'NO'
 and po_vend.vendor_id(+) = ai_in.po_vendor_id
group by
 decode(th.mass_reference_id,null,'Manual','Mass Additions'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, NULL, dhcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION'),
 ah.asset_type,
 falu.meaning,
 decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct),
 gl_flexfields_pkg.get_description(dhcc.chart_of_accounts_id,'GL_ACCOUNT',decode(ah.asset_type, 'CIP', cb.cip_cost_acct, cb.asset_cost_acct)),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'),
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', dhcc.chart_of_accounts_id, null, dhcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION'),
 ad.asset_number,
 ad.description,
 po_vend.segment1,
 ai_in.invoice_number,
 ai_in.invoice_line_number||' - '||ai_in.ap_distribution_line_number,
 ai_in.description,
 ai_in.payables_cost,
 case when it.transaction_type in ('INVOICE ADDITION', 'INVOICE ADJUSTMENT', 'INVOICE TRANSFER','INVOICE REINSTATE')
 then it.transaction_type else null end
) fas
order by
 fas.source,
 fas.company,
 fas.asset_type,
 fas.account,
 fas.cost_center,
 fas.asset_number,
 fas.asset_description,
 fas.ord_by,
 fas.vendor_number,
 fas.invoice_number,
 fas.invoice_line,
 fas.invoice_description