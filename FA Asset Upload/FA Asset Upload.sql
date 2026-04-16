/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Upload
-- Description: Upload to create, update, and retire fixed assets using FA Public APIs.
New assets are created via fa_addition_pub.do_addition. Existing assets are updated via fa_asset_desc_pub.update_desc, fa_reclass_pub.do_reclass, and fa_adjustment_pub.do_adjustment.
Asset retirements are processed via fa_retirement_pub.do_retirement.
Use the Record Type column to select Addition or Retirement processing.
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-upload/
-- Library Link: https://www.enginatics.com/reports/fa-asset-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
null request_id_,
'Addition' record_type,
fav.asset_number,
fav.description,
fav.tag_number,
fcbk.concatenated_segments category,
fav.serial_number,
fakk.concatenated_segments asset_key,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='ASSET TYPE' and fl0.lookup_code=fav.asset_type) asset_type,
fav.current_units units,
fab_p.asset_number parent_asset,
fav.manufacturer_name manufacturer,
fav.model_number model,
fw.warranty_number,
fl.lease_number,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='YESNO' and fl0.lookup_code=fav.in_use_flag) in_use,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='YESNO' and fl0.lookup_code=fav.inventorial) in_physical_inventory,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='PROPERTY TYPE' and fl0.lookup_code=fav.property_type_code) property_type,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='1245/1250 PROPERTY' and fl0.lookup_code=fav.property_1245_1250_code) property_class,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='OWNLEASE' and fl0.lookup_code=fav.owned_leased) ownership,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='NEWUSE' and fl0.lookup_code=fav.new_used) bought,
fav.commitment,
fav.investment_law,
fb.book_type_code book,
fb.cost,
fb.original_cost,
fds.ytd_deprn ytd_depreciation,
fds.deprn_reserve depreciation_reserve,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='SALVAGE_DEPRN_LIMIT_TYPE' and fl0.lookup_code=decode(fb.salvage_type,'AMT','AMOUNT','PCT','PERCENT',fb.salvage_type)) salvage_value_type,
fb.percent_salvage_value,
fb.salvage_value,
fb.reval_ceiling revaluation_ceiling,
fb.reval_amortization_basis revaluation_amortization_basis,
fb.recoverable_cost,
(fb.original_cost-nvl(fds.deprn_reserve,0)) net_book_value,
fb.deprn_method_code depreciation_method,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='YESNO' and fl0.lookup_code=fb.depreciate_flag) depreciate,
floor(fb.life_in_months/12) life_years,
mod(fb.life_in_months,12) life_months,
fb.date_placed_in_service,
fb.prorate_convention_code prorate_convention,
fth.amortization_start_date,
fb.bonus_rule,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='SALVAGE_DEPRN_LIMIT_TYPE' and fl0.lookup_code=decode(fb.deprn_limit_type,'AMT','AMOUNT','PCT','PERCENT',fb.deprn_limit_type)) depreciation_limit_type,
fb.allowed_deprn_limit_amount depreciation_limit_amount,
fb.allowed_deprn_limit depreciation_limit_pct,
fab_g.asset_number group_asset,
null expense_account_alias,
gcck.concatenated_segments expense_account,
gcck.segment1 expense_segment1,
gcck.segment2 expense_segment2,
gcck.segment3 expense_segment3,
gcck.segment4 expense_segment4,
gcck.segment5 expense_segment5,
null location_alias,
flk.concatenated_segments location,
flk.segment1 location_segment1,
flk.segment2 location_segment2,
flk.segment3 location_segment3,
flk.segment4 location_segment4,
papf.full_name employee_name,
papf.employee_number,
fav.attribute_category_code attribute_category,
fav.attribute1,
fav.attribute2,
fav.attribute3,
fav.attribute4,
fav.attribute5,
fav.attribute6,
fav.attribute7,
fav.attribute8,
fav.attribute9,
fav.attribute10,
fav.attribute11,
fav.attribute12,
fav.attribute13,
fav.attribute14,
fav.attribute15,
null date_retired,
null cost_retired,
null units_retired,
null proceeds_of_sale,
null cost_of_removal,
null retirement_type,
null retire_prorate_conv,
null sold_to,
null reference_num,
null trade_in_asset_number,
null transaction_name,
null retire_status
from
fa_additions_vl fav,
fa_books fb,
fa_transaction_headers fth,
fa_book_controls fbc,
gl_ledgers gl,
fa_categories_b_kfv fcbk,
fa_category_books fcb,
fa_deprn_summary fds,
fa_distribution_history fdh,
fa_locations_kfv flk,
gl_code_combinations_kfv gcck,
fa_asset_keywords_kfv fakk,
fa_add_warranties faw,
fa_warranties fw,
fa_leases fl,
fa_additions_b fab_p,
fa_additions_b fab_g,
per_all_people_f papf
where
1=1 and
:p_upload_mode like '%' || xxen_upload.action_update and
nvl(:p_create_empty_file,'N')<>'Y' and
fav.asset_id=fb.asset_id and
fb.date_ineffective is null and
fb.transaction_header_id_in=fth.transaction_header_id and
fb.book_type_code=fbc.book_type_code and
fbc.set_of_books_id=gl.ledger_id and
fav.asset_category_id=fcbk.category_id and
fcbk.category_id=fcb.category_id and
fb.book_type_code=fcb.book_type_code and
fav.asset_id=fds.asset_id and
fb.book_type_code=fds.book_type_code and
fds.period_counter=(select max(fdp.period_counter) from fa_deprn_periods fdp where fdp.book_type_code=fb.book_type_code and fdp.period_close_date is not null) and
fav.asset_id=fdh.asset_id and
fb.book_type_code=fdh.book_type_code and
fdh.date_ineffective is null and
fdh.location_id=flk.location_id and
fdh.code_combination_id=gcck.code_combination_id and
fav.asset_key_ccid=fakk.code_combination_id(+) and
fav.asset_id=faw.asset_id(+) and
faw.warranty_id=fw.warranty_id(+) and
fav.lease_id=fl.lease_id(+) and
fav.parent_asset_id=fab_p.asset_id(+) and
fb.group_asset_id=fab_g.asset_id(+) and
fdh.assigned_to=papf.person_id(+) and
papf.effective_start_date(+)<=trunc(sysdate) and
papf.effective_end_date(+)>=trunc(sysdate)
union all
select
null action_,
null status_,
null message_,
null modified_columns_,
null request_id_,
'Retirement' record_type,
fab.asset_number,
fat.description,
fab.tag_number,
fcbk.concatenated_segments category,
fab.serial_number,
fakk.concatenated_segments asset_key,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='ASSET TYPE' and fl0.lookup_code=fab.asset_type) asset_type,
fab.current_units units,
fab_p.asset_number parent_asset,
fab.manufacturer_name manufacturer,
fab.model_number model,
null warranty_number,
fl.lease_number,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='YESNO' and fl0.lookup_code=fab.in_use_flag) in_use,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='YESNO' and fl0.lookup_code=fab.inventorial) in_physical_inventory,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='PROPERTY TYPE' and fl0.lookup_code=fab.property_type_code) property_type,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='1245/1250 PROPERTY' and fl0.lookup_code=fab.property_1245_1250_code) property_class,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='OWNLEASE' and fl0.lookup_code=fab.owned_leased) ownership,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='NEWUSE' and fl0.lookup_code=fab.new_used) bought,
fab.commitment,
fab.investment_law,
fb.book_type_code book,
fb.cost,
fb.original_cost,
fds.ytd_deprn ytd_depreciation,
fds.deprn_reserve depreciation_reserve,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='SALVAGE_DEPRN_LIMIT_TYPE' and fl0.lookup_code=decode(fb.salvage_type,'AMT','AMOUNT','PCT','PERCENT',fb.salvage_type)) salvage_value_type,
fb.percent_salvage_value,
fb.salvage_value,
fb.reval_ceiling revaluation_ceiling,
fb.reval_amortization_basis revaluation_amortization_basis,
fb.recoverable_cost,
(fb.original_cost-nvl(fds.deprn_reserve,0)) net_book_value,
fb.deprn_method_code depreciation_method,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='YESNO' and fl0.lookup_code=fb.depreciate_flag) depreciate,
floor(fb.life_in_months/12) life_years,
mod(fb.life_in_months,12) life_months,
fb.date_placed_in_service,
fb.prorate_convention_code prorate_convention,
null amortization_start_date,
fb.bonus_rule,
(select fl0.meaning from fa_lookups fl0 where fl0.lookup_type='SALVAGE_DEPRN_LIMIT_TYPE' and fl0.lookup_code=decode(fb.deprn_limit_type,'AMT','AMOUNT','PCT','PERCENT',fb.deprn_limit_type)) depreciation_limit_type,
fb.allowed_deprn_limit_amount depreciation_limit_amount,
fb.allowed_deprn_limit depreciation_limit_pct,
fab_g.asset_number group_asset,
null expense_account_alias,
gcck.concatenated_segments expense_account,
gcck.segment1 expense_segment1,
gcck.segment2 expense_segment2,
gcck.segment3 expense_segment3,
gcck.segment4 expense_segment4,
gcck.segment5 expense_segment5,
null location_alias,
flk.concatenated_segments location,
flk.segment1 location_segment1,
flk.segment2 location_segment2,
flk.segment3 location_segment3,
flk.segment4 location_segment4,
null employee_name,
null employee_number,
fab.attribute_category_code attribute_category,
fab.attribute1,
fab.attribute2,
fab.attribute3,
fab.attribute4,
fab.attribute5,
fab.attribute6,
fab.attribute7,
fab.attribute8,
fab.attribute9,
fab.attribute10,
fab.attribute11,
fab.attribute12,
fab.attribute13,
fab.attribute14,
fab.attribute15,
fr.date_retired,
fr.cost_retired,
fr.units units_retired,
fr.proceeds_of_sale,
fr.cost_of_removal,
fr.retirement_type_code retirement_type,
fr.retirement_prorate_convention retire_prorate_conv,
fr.sold_to,
fr.reference_num,
(select fab2.asset_number from fa_additions_b fab2 where fab2.asset_id=fr.trade_in_asset_id) trade_in_asset_number,
fth.transaction_name,
fr.status retire_status
from
fa_additions_b fab,
fa_additions_tl fat,
fa_retirements fr,
fa_books fb,
fa_transaction_headers fth,
fa_categories_b_kfv fcbk,
fa_category_books fcb,
fa_deprn_summary fds,
fa_distribution_history fdh,
fa_locations_kfv flk,
gl_code_combinations_kfv gcck,
fa_asset_keywords_kfv fakk,
fa_leases fl,
fa_additions_b fab_p,
fa_additions_b fab_g
where
1=1 and
:p_upload_mode like '%' || xxen_upload.action_update and
nvl(:p_create_empty_file,'N')<>'Y' and
fab.asset_id=fat.asset_id and
fat.language=userenv('lang') and
fab.asset_id=fr.asset_id and
fr.book_type_code=fb.book_type_code and
fb.transaction_header_id_out=fr.transaction_header_id_in and
fth.transaction_header_id=fr.transaction_header_id_in and
fab.asset_id=fb.asset_id and
fb.book_type_code=fcb.book_type_code and
fab.asset_category_id=fcbk.category_id and
fcbk.category_id=fcb.category_id and
fds.asset_id=fab.asset_id and
fds.book_type_code=fb.book_type_code and
fds.period_counter=(select max(fdp.period_counter) from fa_deprn_periods fdp where fdp.book_type_code=fb.book_type_code and fdp.period_close_date is not null) and
fab.asset_id=fdh.asset_id and
fdh.book_type_code=fb.book_type_code and
fdh.date_effective<=fth.date_effective and
nvl(fdh.date_ineffective,fth.date_effective+1)>=fth.date_effective and
fdh.location_id=flk.location_id and
fdh.code_combination_id=gcck.code_combination_id and
fab.asset_key_ccid=fakk.code_combination_id(+) and
fab.lease_id=fl.lease_id(+) and
fab.parent_asset_id=fab_p.asset_id(+) and
fb.group_asset_id=fab_g.asset_id(+)