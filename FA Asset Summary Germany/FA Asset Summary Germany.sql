/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Summary (Germany)
-- Description: Description: Asset Summary Report (Germany)
Application: Assets

This Blitz Report has been extended to allow it to be run across multiple Ledgers and/or Asset Books.

Source: Asset Summary Report (Germany)
Short Name: FASSUMRPT
DB package: XXEN_FA_FAS_XMLP
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-summary-germany/
-- Library Link: https://www.enginatics.com/reports/fa-asset-summary-germany/
-- Run Report: https://demo.enginatics.com/

with fa_summary as
(
select
 x.ledger,
 x.currency,
 x.book_name,
 x.book_class,
 x.asset_number,
 x.asset_description,
 x.cost_account,
 x.cost_account_description,
 x.major_category,
 x.minor_category,
 x.company,
 x.company_description,
 x.account,
 x.account_description,
 x.cost_center,
 x.cost_center_description,
 x.asset_type,
 x.transaction_sub_type,
 sum(nvl(x.original_cost,0))original_cost,
 sum(nvl(x.current_cost,0)) current_cost,
 sum(nvl(x.begin_cost,0)) begin_cost,
 sum(nvl(x.reserve_amount,0)) reserve_amount,
 sum(nvl(x.retirements,0)) retirements,
 sum(nvl(x.changes_of_accounts,0)) changes_of_accounts,
 sum(nvl(x.additions,0)) additions,
 sum(nvl(x.additions,0)) cost_adjustments,
 sum(nvl(x.appreciation_amount,0)) appreciation_amount,
 sum(nvl(x.accum_deprn,0)) accum_deprn,
 sum(nvl(x.deprn_expenses,0)) deprn_expenses
from
 (select distinct
   gsob.name ledger,
   gsob.currency_code currency,
   fbcs.book_type_code book_name,
   fl.meaning book_class,
   fadd.asset_number asset_number,
   fadd.description asset_description,
   decode(fah.asset_type, 'CIP', nvl(fcb.cip_cost_acct,fcb.asset_cost_acct) ,fcb.asset_cost_acct) cost_account,
   gl_flexfields_pkg.get_description(gcc.chart_of_accounts_id,'GL_ACCOUNT',decode(fah.asset_type, 'CIP', nvl(fcb.cip_cost_acct,fcb.asset_cost_acct) ,fcb.asset_cost_acct)) cost_account_description,
   fck.segment1 major_category,
   fck.segment2 minor_category,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acc_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING' , 'Y', 'VALUE') company,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acc_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_BALANCING' , 'Y', 'DESCRIPTION') company_description,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acc_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_ACCOUNT' , 'Y', 'VALUE') account,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acc_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'GL_ACCOUNT' , 'Y', 'DESCRIPTION') account_description,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cc_seg' , 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') cost_center,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cc_seg' , 'SQLGL', 'GL#', gcc.chart_of_accounts_id, null, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION') cost_center_description,
   fah.asset_type asset_type,
   null transaction_sub_type,
   xxen_fa_fas_xmlp.fassumrpt_amount('ASSIGNED_UNITS'     ,fbcs.book_type_code,fdp1.period_name,fdp2.period_name,fadd.asset_id,fck.category_id,fah.asset_type,gcc.code_combination_id,fah.transaction_header_id_in) original_cost,
   xxen_fa_fas_xmlp.fassumrpt_amount('CURRENT_AMOUNT'     ,fbcs.book_type_code,fdp1.period_name,fdp2.period_name,fadd.asset_id,fck.category_id,fah.asset_type,gcc.code_combination_id,fah.transaction_header_id_in) current_cost,
   xxen_fa_fas_xmlp.fassumrpt_amount('BEGIN_COST'         ,fbcs.book_type_code,fdp1.period_name,fdp2.period_name,fadd.asset_id,fck.category_id,fah.asset_type,gcc.code_combination_id,fah.transaction_header_id_in) begin_cost,
   xxen_fa_fas_xmlp.fassumrpt_amount('RESERVE_AMOUNT'     ,fbcs.book_type_code,fdp1.period_name,fdp2.period_name,fadd.asset_id,fck.category_id,fah.asset_type,gcc.code_combination_id,fah.transaction_header_id_in) reserve_amount,
   xxen_fa_fas_xmlp.fassumrpt_amount('RETIREMENT_AMOUNT'  ,fbcs.book_type_code,fdp1.period_name,fdp2.period_name,fadd.asset_id,fck.category_id,fah.asset_type,gcc.code_combination_id,fah.transaction_header_id_in) retirements,
   xxen_fa_fas_xmlp.fassumrpt_amount('CHANGES_OF_ACCOUNTS',fbcs.book_type_code,fdp1.period_name,fdp2.period_name,fadd.asset_id,fck.category_id,fah.asset_type,gcc.code_combination_id,fah.transaction_header_id_in) changes_of_accounts,
   xxen_fa_fas_xmlp.fassumrpt_amount('ADDITIONS_AMOUNT'   ,fbcs.book_type_code,fdp1.period_name,fdp2.period_name,fadd.asset_id,fck.category_id,fah.asset_type,gcc.code_combination_id,fah.transaction_header_id_in) additions,
   xxen_fa_fas_xmlp.fassumrpt_amount('APPRECIATION_AMOUNT',fbcs.book_type_code,fdp1.period_name,fdp2.period_name,fadd.asset_id,fck.category_id,fah.asset_type,gcc.code_combination_id,fah.transaction_header_id_in) appreciation_amount,
   xxen_fa_fas_xmlp.fassumrpt_amount('ACCM_DEPRN_AMT'     ,fbcs.book_type_code,fdp1.period_name,fdp2.period_name,fadd.asset_id,fck.category_id,fah.asset_type,gcc.code_combination_id,fah.transaction_header_id_in) accum_deprn,
   xxen_fa_fas_xmlp.fassumrpt_amount('DEPRN_EXPENSE'      ,fbcs.book_type_code,fdp1.period_name,fdp2.period_name,fadd.asset_id,fck.category_id,fah.asset_type,gcc.code_combination_id,fah.transaction_header_id_in) deprn_expenses,
   fb.cost latest_book_cost
  from
   fa_asset_history fah,
   gl_code_combinations gcc,
   fa_categories_kfv fck,
   fa_category_books fcb,
   fa_additions fadd,
   fa_deprn_periods fdp1,
   fa_deprn_periods fdp2,
   fa_book_controls_sec fbcs,
   fa_books fb,
   fa_system_controls fsc,
   gl_sets_of_books gsob,
   fa_lookups fl
  where
       1=1
   and fah.asset_id = fadd.asset_id
   and fbcs.book_type_code = fb.book_type_code
   and fb.asset_id = fadd.asset_id
   and fb.transaction_header_id_in =
    (select
      max(fb2.transaction_header_id_in)
     from
      fa_books fb2
     where
      fb2.book_type_code = fb.book_type_code
      and fb2.asset_id = fb.asset_id
      and fb2.date_effective <= nvl(fdp2.period_close_date,sysdate)
    )
   and nvl(fb.period_counter_fully_retired,fdp1.period_counter + 1) >= fdp1.period_counter
   and fbcs.book_type_code = fcb.book_type_code
   and fah.category_id = fcb.category_id
   and fah.category_id = fck.category_id
   and gcc.code_combination_id = decode(fah.asset_type, 'CIP', nvl(fcb.wip_cost_account_ccid,fcb.asset_cost_account_ccid) ,fcb.asset_cost_account_ccid)
   and fbcs.book_type_code = fdp1.book_type_code
   and fdp1.book_type_code = fdp2.book_type_code
   and fdp1.period_counter <= fdp2.period_counter
   and upper(fdp1.period_name) = :p_period_open   
   and upper(fdp2.period_name) = :p_period_close   
   and ((fah.date_effective between fdp1.period_open_date and nvl(fdp2.period_close_date,sysdate)) or
        (fah.date_effective < fdp1.period_open_date and fah.date_ineffective > nvl(fdp2.period_close_date,sysdate)) or
        (fah.date_ineffective is null and fah.date_effective <= nvl(fdp2.period_close_date,sysdate)) or
        (fah.date_ineffective between fdp1.period_open_date and nvl(fdp2.period_close_date,sysdate) and fah.date_effective < fdp1.period_open_date)
       )
   and gsob.set_of_books_id = fbcs.set_of_books_id
   and fl.lookup_type = 'BOOK CLASS'
   and fl.lookup_code = fbcs.book_class
  ) x
group by
 x.ledger,
 x.currency,
 x.book_name,
 x.book_class,
 x.asset_number,
 x.asset_description,
 x.cost_account,
 x.cost_account_description,
 x.major_category,
 x.minor_category,
 x.company,
 x.company_description,
 x.account,
 x.account_description,
 x.cost_center,
 x.cost_center_description,
 x.asset_type,
 x.transaction_sub_type,
 x.original_cost
)
--
-- main query starts here
--
select
 fs.ledger,
 fs.currency,
 fs.book_class,
 fs.book_name,
 fs.asset_number,
 fs.asset_description,
 fs.major_category,
 fs.minor_category,
 fs.company,
 fs.company_description,
 fs.account,
 fs.account_description,
 fs.cost_center,
 fs.cost_center_description,
 fs.asset_type,
 --
 case
 when fs.asset_type = 'CIP'
 then fs.current_cost
 when fs.asset_type != 'CIP' and fs.changes_of_accounts <= 0 and fs.current_cost > 0
 then fs.current_cost
 else 0
 end original_asset_cost,
 fs.additions,
 fs.retirements,
 fs.changes_of_accounts,
 fs.appreciation_amount,
 case
 when fs.asset_type = 'CAPITALIZED'
 then fs.accum_deprn
 else null
 end accumulated_depreciation,
 case
 when fs.asset_type = 'CAPITALIZED'
 then fs.deprn_expenses
 else null
 end depreciation_expense,
 fs.current_cost + fs.additions + fs.changes_of_accounts - fs.retirements - fs.accum_deprn nbv_ending_period,
 fs.current_cost - fs.reserve_amount nbv_beginning_period,
 fs.ledger || ' (' || fs.currency || ')' ledger_label,
 fs.book_name || ' (' || fs.book_class || ')' book_label,
 fs.company || ' - ' || fs.company_description company_label,
 fs.account || ' - ' || fs.account_description account_label,
 fs.cost_center || ' - ' || fs.cost_center_description cost_centre_label
from
 fa_summary fs
order by
 fs.ledger,
 fs.book_class,
 fs.book_name,
 fs.major_category,
 fs.minor_category,
 fs.account,
 fs.asset_type,
 fs.cost_center,
 fs.asset_number