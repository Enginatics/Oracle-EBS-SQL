/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Impairments
-- Description: Source: Asset Impairment Report
Short Name: FAXRASIM
DB package:
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-impairments/
-- Library Link: https://www.enginatics.com/reports/fa-asset-impairments/
-- Run Report: https://demo.enginatics.com/

with
--
-- fa_impairment - impairment transaction
--
fa_impairment_q as
(
select
 to_number(:p_set_of_books_id) set_of_books_id,
 fi.book_type_code,
 fdp.period_name impairment_period,
 fcgu.cash_generating_unit cash_gen_unit,
 fcgu.description cash_gen_unit_desc,
 fi.impairment_date,
 fi.impairment_name,
 fi.description,
 fi.status status_code,
 fi.impair_class class_code,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'MASS_TRX_STATUS' and flt.lookup_code = fi.status and flt.language = userenv('lang')) status,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fi.impair_class and flt.language = userenv('lang')) class,
 fav1.asset_number goodwill_asset,
 fav1.description goodwill_asset_desc,
 fav2.asset_number asset,
 fav2.description asset_desc,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fi.impair_loss_acct) loss_account,
 fi.net_book_value,
 fi.net_selling_price,
 fi.value_in_use,
 fi.impairment_amount,
 fi.goodwill_amount,
 fi.user_date,
 fi.date_ineffective,
 fi.reason,
 fi.split_impair_flag,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fi.split1_impair_class and flt.language = userenv('lang')) split1_impair_class,
 fi.split1_reason,
 fi.split1_percent,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fi.split1_loss_acct) split1_loss_account,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fi.split2_impair_class and flt.language = userenv('lang')) split2_impair_class,
 fi.split2_reason,
 fi.split2_percent,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fi.split2_loss_acct) split2_loss_account,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fi.split3_impair_class and flt.language = userenv('lang')) split3_impair_class,
 fi.split3_reason,
 fi.split3_percent,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fi.split3_loss_acct) split3_loss_account,
 fi.cash_generating_unit_id,
 fi.goodwill_asset_id,
 fi.asset_id,
 fi.period_counter_impaired,
 fi.impairment_id
from
 fa_impairments fi,
 fa_cash_gen_units fcgu,
 fa_deprn_periods fdp,
 fa_additions_vl fav1,
 fa_additions_vl fav2
where
 fi.cash_generating_unit_id = fcgu.cash_generating_unit_id (+) and
 fi.book_type_code = fcgu.book_type_code (+) and
 fi.period_counter_impaired = fdp.period_counter (+) and
 fi.book_type_code = fdp.book_type_code (+) and
 fi.goodwill_asset_id = fav1.asset_id (+) and
 fi.asset_id = fav2.asset_id (+) and
 fi.book_type_code = :p_book_type_code and
 fi.period_counter_impaired between :p_start_pc and :p_end_pc
union all
select
 fi.set_of_books_id,
 fi.book_type_code,
 fdp.period_name impairment_period,
 fcgu.cash_generating_unit cash_gen_unit,
 fcgu.description cash_gen_unit_desc,
 fi.impairment_date,
 fi.impairment_name,
 fi.description,
 fi.status status_code,
 fi.impair_class class_code,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'MASS_TRX_STATUS' and flt.lookup_code = fi.status and flt.language = userenv('lang')) status,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fi.impair_class and flt.language = userenv('lang')) class,
 fav1.asset_number goodwill_asset,
 fav1.description goodwill_asset_desc,
 fav2.asset_number asset,
 fav2.description asset_desc,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fi.impair_loss_acct) loss_account,
 fi.net_book_value,
 fi.net_selling_price,
 fi.value_in_use,
 fi.impairment_amount,
 fi.goodwill_amount,
 fi.user_date,
 fi.date_ineffective,
 fi.reason,
 fi.split_impair_flag,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fi.split1_impair_class and flt.language = userenv('lang')) split1_impair_class,
 fi.split1_reason,
 fi.split1_percent,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fi.split1_loss_acct) split1_loss_account,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fi.split2_impair_class and flt.language = userenv('lang')) split2_impair_class,
 fi.split2_reason,
 fi.split2_percent,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fi.split2_loss_acct) split2_loss_account,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fi.split3_impair_class and flt.language = userenv('lang')) split3_impair_class,
 fi.split3_reason,
 fi.split3_percent,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fi.split3_loss_acct) split3_loss_account,
 fi.cash_generating_unit_id,
 fi.goodwill_asset_id,
 fi.asset_id,
 fi.period_counter_impaired,
 fi.impairment_id
from
 fa_mc_impairments fi,
 fa_cash_gen_units fcgu,
 fa_deprn_periods fdp,
 fa_additions_vl fav1,
 fa_additions_vl fav2
where
 fi.cash_generating_unit_id = fcgu.cash_generating_unit_id (+) and
 fi.book_type_code = fcgu.book_type_code (+) and
 fi.period_counter_impaired = fdp.period_counter (+) and
 fi.book_type_code = fdp.book_type_code (+) and
 fi.goodwill_asset_id = fav1.asset_id (+) and
 fi.asset_id = fav2.asset_id (+) and
 fi.book_type_code = :p_book_type_code and
 fi.set_of_books_id = :p_set_of_books_id and
 fi.period_counter_impaired between :p_start_pc and :p_end_pc
),
--
-- fa_itf_impairment - impairment transaction financials
--
fa_itf_impairment_q as
(
select
 to_number(:p_set_of_books_id) set_of_books_id,
 fii.book_type_code,
 fdp.period_name impairment_period,
 fii.impairment_date,
 fcgu.cash_generating_unit cash_gen_unit,
 fcgu.description cash_gen_unit_desc,
 fii.impair_class class_code,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fii.impair_class and flt.language = userenv('LANG')) class,
 fav.asset_number asset,
 fav.description asset_desc,
 fii.goodwill_asset_flag,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fii.impair_loss_acct) loss_account,
 fii.reason,
 --
 fii.cost,
 fii.adjusted_cost,
 fii.deprn_amount,
 fii.net_selling_price,
 fii.value_in_use,
 fii.net_book_value,
 (fii.net_book_value - (fii.impairment_amount + nvl(fii.reval_reserve_adj_amount,0))) new_net_book_value,
 fii.impairment_amount,
 fii.ytd_deprn,
 fii.ytd_impairment,
 fii.reval_reserve_adj_amount,
 --
 fii.split_impair_flag,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fii.split1_impair_class and flt.language = userenv('LANG')) split1_class,
 fii.split1_reason,
 fii.split1_reval_reserve,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fii.split1_loss_acct) split1_loss_account,
 fii.split1_loss_amount,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fii.split2_impair_class and flt.language = userenv('LANG')) split2_class,
 fii.split2_reason,
 fii.split2_reval_reserve,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fii.split2_loss_acct) split2_loss_account,
 fii.split2_loss_amount,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fii.split3_impair_class and flt.language = userenv('LANG')) split3_class,
 fii.split3_reason,
 fii.split3_reval_reserve,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fii.split3_loss_acct) split3_loss_account,
 fii.split3_loss_amount,
 --
 fii.impairment_id,
 fii.cash_generating_unit_id,
 fii.period_counter,
 fii.asset_id
from
 fa_itf_impairments fii,
 fa_cash_gen_units fcgu,
 fa_deprn_periods fdp,
 fa_additions_vl fav
where
 2=2 and
 fii.cash_generating_unit_id = fcgu.cash_generating_unit_id (+) and
 fii.book_type_code = fcgu.book_type_code (+) and
 fii.period_counter = fdp.period_counter (+) and
 fii.book_type_code = fdp.book_type_code (+) and
 fii.asset_id = fav.asset_id (+) and
 fii.book_type_code = :p_book_type_code
union all
select
 to_number(:p_set_of_books_id) set_of_books_id,
 fii.book_type_code,
 fdp.period_name impairment_period,
 fii.impairment_date,
 fcgu.cash_generating_unit cash_gen_unit,
 fcgu.description cash_gen_unit_desc,
 fii.impair_class class_code,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fii.impair_class and flt.language = userenv('LANG')) class,
 fav.asset_number asset,
 fav.description asset_desc,
 fii.goodwill_asset_flag,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fii.impair_loss_acct) loss_account,
 fii.reason,
 --
 fii.cost,
 fii.adjusted_cost,
 fii.deprn_amount,
 fii.net_selling_price,
 fii.value_in_use,
 fii.net_book_value,
 (fii.net_book_value - (fii.impairment_amount + nvl(fii.reval_reserve_adj_amount,0))) new_net_book_value,
 fii.impairment_amount,
 fii.ytd_deprn,
 fii.ytd_impairment,
 fii.reval_reserve_adj_amount,
 --
 fii.split_impair_flag,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fii.split1_impair_class and flt.language = userenv('LANG')) split1_class,
 fii.split1_reason,
 fii.split1_reval_reserve,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fii.split1_loss_acct) split1_loss_account,
 fii.split1_loss_amount,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fii.split2_impair_class and flt.language = userenv('LANG')) split2_class,
 fii.split2_reason,
 fii.split2_reval_reserve,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fii.split2_loss_acct) split2_loss_account,
 fii.split2_loss_amount,
 (select flt.meaning from fa_lookups_tl flt where flt.lookup_type = 'IMPAIRMENT_CLASSIFICATION' and flt.lookup_code = fii.split3_impair_class and flt.language = userenv('LANG')) split3_class,
 fii.split3_reason,
 fii.split3_reval_reserve,
 (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = fii.split3_loss_acct) split3_loss_account,
 fii.split3_loss_amount,
 --
 fii.impairment_id,
 fii.cash_generating_unit_id,
 fii.period_counter,
 fii.asset_id
from
 fa_mc_itf_impairments fii,
 fa_cash_gen_units fcgu,
 fa_deprn_periods fdp,
 fa_additions_vl fav
where
 2=2 and
 fii.cash_generating_unit_id = fcgu.cash_generating_unit_id (+) and
 fii.book_type_code = fcgu.book_type_code (+) and
 fii.period_counter = fdp.period_counter (+) and
 fii.book_type_code = fdp.book_type_code (+) and
 fii.asset_id = fav.asset_id (+) and
 fii.book_type_code = :p_book_type_code and
 fii.set_of_books_id = :p_set_of_books_id
)
--
-- Main Query
--
select
 fbc.book_type_code,
 fbc.book_type_name,
 gsob.name ledger,
 gsob.currency_code,
 fi.impairment_name         impairement_name,
 fi.description             impairement_desc,
 fi.goodwill_asset          goodwill_asset,
 fi.goodwill_asset_desc     goodwill_asset_desc,
 fi.goodwill_amount         goodwill_amount,
 --
 -- Impairment Transaction
 --
 fi.cash_gen_unit           impair_cash_gen_unit,
 fi.cash_gen_unit_desc      impair_cash_gen_unit_desc,
 fi.impairment_period       impair_period,
 fi.impairment_date         impair_date,
 fi.status                  impair_status,
 fi.class                   impair_class,
 fi.asset                   impair_asset,
 fi.asset_desc              impair_asset_desc,
 fi.loss_account            impair_loss_account,
 fi.net_book_value          impair_net_book_value,
 fi.net_selling_price       impair_net_selling_price,
 fi.value_in_use            impair_value_in_use,
 fi.impairment_amount       impair_impairment_amount,
 fi.user_date               impair_user_date,
 fi.date_ineffective        impair_date_ineffective,
 fi.reason                  impair_reason,
 fi.split_impair_flag       impair_split_impair_flag,
 fi.split1_impair_class     impair_split1_impair_class,
 fi.split1_reason           impair_split1_reason,
 fi.split1_percent          impair_split1_percent,
 fi.split1_loss_account     impair_split1_loss_account,
 fi.split2_impair_class     impair_split2_impair_class,
 fi.split2_reason           impair_split2_reason,
 fi.split2_percent          impair_split2_percent,
 fi.split2_loss_account     impair_split2_loss_account,
 fi.split3_impair_class     impair_split3_impair_class,
 fi.split3_reason           impair_split3_reason,
 fi.split3_percent          impair_split3_percent,
 fi.split3_loss_account     impair_split3_loss_account,
 --
 -- Impairment Transaction Financials
 --
 fii.cash_gen_unit          asset_cash_gen_unit,
 fii.cash_gen_unit_desc     asset_cash_gen_unit_desc,
 fii.impairment_period      asset_impairment_period,
 fii.impairment_date        asset_impairment_date,
 fii.class_code             impairment_class_code,
 fii.class                  impairment_class,
 fii.asset                  asset_number,
 fii.asset_desc             asset_desc,
 fii.goodwill_asset_flag,
 fii.loss_account           asset_loss_account,
 fii.reason                 impairment_reason,
 fii.cost,
 fii.adjusted_cost,
 fii.deprn_amount,
 fii.net_selling_price,
 fii.value_in_use,
 fii.net_book_value,
 fii.new_net_book_value,
 fii.impairment_amount,
 fii.ytd_deprn,
 fii.ytd_impairment,
 fii.reval_reserve_adj_amount,
 --
 fii.split_impair_flag,
 fii.split1_class,
 fii.split1_reason,
 fii.split1_reval_reserve,
 fii.split1_loss_account,
 fii.split1_loss_amount,
 fii.split2_class,
 fii.split2_reason,
 fii.split2_reval_reserve,
 fii.split2_loss_account,
 fii.split2_loss_amount,
 fii.split3_class,
 fii.split3_reason,
 fii.split3_reval_reserve,
 fii.split3_loss_account,
 fii.split3_loss_amount,
 --
 -- IDs
 --
 fi.impairment_id,
 fi.cash_generating_unit_id  impair_cgu_id,
 fi.goodwill_asset_id        impair_goodwill_asset_id,
 fi.asset_id                 impair_asset_id,
 fi.period_counter_impaired  impair_period_counter,
 fii.cash_generating_unit_id asset_cgu_id,
 fii.period_counter,
 fii.asset_id                asset_id
from
 fa_impairment_q fi,
 fa_itf_impairment_q fii,
 fa_book_controls fbc,
 gl_sets_of_books gsob
where
 1=1 and
 fi.book_type_code = fii.book_type_code (+) and
 fi.set_of_books_id = fii.set_of_books_id (+) and
 fi.impairment_id = fii.impairment_id (+) and
 fi.book_type_code = fbc.book_type_code and
 fi.set_of_books_id = gsob.set_of_books_id
order by
 nvl(fi.cash_gen_unit_desc,fii.cash_gen_unit_desc),
 nvl(fi.period_counter_impaired,fii.period_counter),
 fi.goodwill_asset,
 nvl(fii.asset,fi.asset)