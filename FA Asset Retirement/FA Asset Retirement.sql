/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Retirement
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-retirement/
-- Library Link: https://www.enginatics.com/reports/fa-asset-retirement/
-- Run Report: https://demo.enginatics.com/

 SELECT ret.ROWID ret_rowid,
          ret.retirement_id,
          ret.book_type_code,
          ret.asset_id,
          ret.transaction_header_id_in,
          ret.date_retired,
          ret.date_effective,
          ret.cost_retired,
          ret.status,
          ret.last_update_date,
          ret.last_updated_by,
          ret.retirement_prorate_convention,
          ret.transaction_header_id_out,
          ret.units,
          ret.cost_of_removal,
          ret.nbv_retired,
          ret.gain_loss_amount,
          ret.proceeds_of_sale,
          ret.gain_loss_type_code,
          ret.retirement_type_code,
          ret.itc_recaptured,
          ret.itc_recapture_id,
          ret.reference_num,
          ret.sold_to,
          ret.trade_in_asset_id,
          ret.stl_method_code,
          ret.stl_life_in_months,
          ret.stl_deprn_amount,
          ret.created_by,
          ret.creation_date,
          ret.last_update_login,
          ret.attribute1 ret_attribute1,
          ret.attribute2 ret_attribute2,
          ret.attribute3 ret_attribute3,
          ret.attribute4 ret_attribute4,
          ret.attribute5 ret_attribute5,
          ret.attribute6 ret_attribute6,
          ret.attribute7 ret_attribute7,
          ret.attribute8 ret_attribute8,
          ret.attribute9 ret_attribute9,
          ret.attribute10 ret_attribute10,
          ret.attribute11 ret_attribute11,
          ret.attribute12 ret_attribute12,
          ret.attribute13 ret_attribute13,
          ret.attribute14 ret_attribute14,
          ret.attribute15 ret_attribute15,
          ret.attribute_category_code ret_attribute_category_code,
          ret.reval_reserve_retired,
          ret.unrevalued_cost_retired,
          ad.asset_number asset_number,
          bks.cost cost,
          ah.units current_units,
          trade_in.asset_number trade_in_asset_number,
          adt.description trade_in_asset_desc,
          th.transaction_name,
          th.attribute1,
          th.attribute2,
          th.attribute3,
          th.attribute4,
          th.attribute5,
          th.attribute6,
          th.attribute7,
          th.attribute8,
          th.attribute9,
          th.attribute10,
          th.attribute11,
          th.attribute12,
          th.attribute13,
          th.attribute14,
          th.attribute15,
          th.attribute_category_code,
          bc.current_fiscal_year,
          bc.fiscal_year_name,
          fy.start_date fy_start_date,
          fy.end_date fy_end_date,
          th.invoice_transaction_id,
          bks.group_asset_id group_asset_id,
          ret.recognize_gain_loss recognize_gain_loss,
          ret.recapture_reserve_flag recapture_reserve_flag,
          ret.limit_proceeds_flag limit_proceeds_flag,
          ret.terminal_gain_loss terminal_gain_loss,
          ret.reduction_rate reduction_rate,
          ret.eofy_reserve eofy_reserve,
          ret.reserve_retired reserve_retired,
          ret.recapture_amount recapture_amount,
          th.date_effective transaction_date_effective
     FROM fa_retirements ret,
          fa_additions_b ad,
          fa_books bks,
          fa_book_controls bc,
          fa_fiscal_year fy,
          fa_asset_history ah,
          fa_additions_b trade_in,
          fa_additions_tl adt,
          fa_transaction_headers th
    WHERE ad.asset_id = ret.asset_id
      AND bks.book_type_code = ret.book_type_code
      AND bks.asset_id = ret.asset_id
      AND bks.transaction_header_id_out = ret.transaction_header_id_in
      AND bks.date_ineffective > ah.date_effective
      AND bks.date_ineffective <= NVL (ah.date_ineffective, SYSDATE)
      AND ah.asset_id = ret.asset_id
      AND trade_in.asset_id(+) = ret.trade_in_asset_id
      AND th.transaction_header_id = ret.transaction_header_id_in
      AND bc.book_type_code = ret.book_type_code
      AND fy.fiscal_year_name = bc.fiscal_year_name
      AND fy.fiscal_year = bc.current_fiscal_year
      AND adt.asset_id(+) = trade_in.asset_id

      AND adt.language(+) = USERENV ('LANG')