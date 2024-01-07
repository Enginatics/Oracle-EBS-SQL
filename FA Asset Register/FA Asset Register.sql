/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Register
-- Description: Application: Assets
Source: Asset Register Report (XML)
Short Name: FAS600_XML
DB package: FA_FAS600_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-register/
-- Library Link: https://www.enginatics.com/reports/fa-asset-register/
-- Run Report: https://demo.enginatics.com/

with
q_assets as
(
select
 ad.asset_number,
 ad2.description,
 ad.tag_number,
 ad.serial_number,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('cat_flex_all_seg', 'OFA', 'CAT#', :p_cat_flex_id, NULL, cat.category_id, 'ALL', 'Y', 'VALUE') asset_category,
 cat.description category_desc,
 ad.manufacturer_name,
 ad.model_number,
 lookups_pt.meaning property_type,
 lookups_12.meaning property_class,
 lookups_nu.meaning new_used,
 lookups_iu.meaning in_use_flag,
 lookups_ol.meaning owned_leased,
 lookups_at.meaning asset_type,
 p_ad.asset_number  parent_asset_number,
 p_ad2.description  parent_asset_desc,
 ad.current_units total_units,
 ad.asset_id,
 bk.book_type_code
from
 fa_asset_history ah,
 fa_books bk,
 fa_categories cat,
 fa_lookups lookups_at,
 fa_lookups lookups_nu,
 fa_lookups lookups_ol,
 fa_lookups lookups_iu,
 fa_lookups lookups_pt,
 fa_lookups lookups_12,
 fa_additions_tl ad2,
 fa_additions_b ad,
 fa_additions_tl p_ad2,
 fa_additions_b p_ad
where
 1=1 and
 ad.asset_id = ad2.asset_id and
 ad2.language = userenv('LANG') and
 ah.asset_id = ad.asset_id and
 ah.date_effective <= sysdate and
 nvl(ah.date_ineffective, sysdate+1) > sysdate and
 ah.category_id = cat.category_id and
 bk.asset_id = ad.asset_id and
 bk.book_type_code = :p_book and
 bk.date_ineffective is null and
 --
 p_ad.asset_id (+) = ad.parent_asset_id and
 p_ad2.asset_id (+) = p_ad.asset_id and
 p_ad2.language (+) = userenv('LANG') and
 --
 lookups_at.lookup_code = ad.asset_type and
 lookups_at.lookup_type = 'ASSET TYPE' and
 lookups_nu.lookup_code = ad.new_used and
 lookups_nu.lookup_type = 'NEWUSE' and
 lookups_ol.lookup_code = ad.owned_leased and
 lookups_ol.lookup_type = 'OWNLEASE' and
 lookups_iu.lookup_code = ad.in_use_flag and
 lookups_iu.lookup_type = 'YESNO' and
 lookups_pt.lookup_code(+) = ad.property_type_code and
 lookups_pt.lookup_type(+) = 'PROPERTY TYPE' and
 lookups_12.lookup_code(+) = ad.property_1245_1250_code and
 lookups_12.lookup_type(+) = '1245/1250 PROPERTY'
),
q_books as
(
select
 books.asset_id,
 books.book_type_code book,
 bc.book_class,
 trunc(books.date_placed_in_service) date_placed_in_service,
 books.prorate_convention_code prorate_convention,
 trunc(books.prorate_date) prorate_date,
 (cat.number_per_fiscal_year - cap.period_num + 1) months_deprn_in_first_yr,
 lu_df.meaning depreciate,
 lu_dwa.meaning depreciate_when_placed_in_serv,
 trunc(books.deprn_start_date) deprn_start_date,
 books.deprn_method_code deprn_method,
 to_char(trunc(books.life_in_months/12) + (mod(books.life_in_months,12)/100), '90D00') life_in_yr_mo,
 (books.basic_rate * 100) basic_rate_pct,
 (books.adjusted_rate * 100) adjusted_rate_pct,
 books.production_capacity capacity,
 decode(dp_ds.fiscal_year, bc.current_fiscal_year, ds.ytd_production, null) ytd_production,
 ds.ltd_production ltd_production,
 books.unit_of_measure unit_of_measure,
 lu_ly.meaning depreciate_in_last_year,
 pd2.period_name period_reserved,
 pd1.period_name period_retired,
 (itc.itc_amount_rate * 100) itc_rate_pct,
 books.itc_amount itc_amount,
 books.itc_basis itc_basis,
 (itc.basis_reduction_rate * 100) basis_reduction_rate_pct,
 (itc.basis_reduction_rate * books.original_cost) basis_reduction,
 nvl(ds.reval_reserve,0) revaluation_reserve,
 books.ceiling_name ceiling_name,
 ceil.ceiling_type ceiling_type,
 books.bonus_rule bonus_rule,
 books.salvage_value salvage_value,
 books.rate_adjustment_factor rate_adjustment_factor,
 books.original_cost original_cost,
 books.cost cost,
 books.adjusted_recoverable_cost recoverable_cost,
 books.adjusted_cost depreciable_basis,
 (books.cost - ds.deprn_reserve) net_book_value,
 ds.deprn_reserve deprn_reserve,
 decode(dp_ds.fiscal_year, bc.current_fiscal_year, ds.ytd_deprn, 0) ytd_deprn
from
 fa_books books,
 fa_book_controls bc,
 fa_deprn_periods pd1,
 fa_deprn_periods pd2,
 fa_ceiling_types ceil,
 fa_deprn_summary ds,
 fa_deprn_periods dp_ds,
 fa_methods meth,
 fa_itc_rates itc,
 fa_convention_types cot,
 fa_calendar_periods cap,
 fa_calendar_types cat,
 fa_lookups lu_df,
 fa_lookups lu_ly,
 fa_lookups lu_dwa
where
 :p_incl_book = 'Y' and
 books.book_type_code = bc.book_type_code and
 books.date_ineffective is null and
 bc.book_class in ('CORPORATE', 'TAX') and
 pd1.book_type_code(+) = books.book_type_code and
 pd2.book_type_code(+) = books.book_type_code and
 pd1.period_counter(+) = nvl(books.period_counter_fully_retired,0) and
 pd2.period_counter(+) = nvl(books.period_counter_fully_reserved,0) and
 ceil.ceiling_name(+) = books.ceiling_name and
 ds.asset_id = books.asset_id and
 ds.book_type_code = books.book_type_code and
 ds.period_counter =
  (select
    max(ds1.period_counter)
   from
    fa_deprn_summary ds1
   where
    ds1.asset_id=ds.asset_id and
    ds1.book_type_code= ds.book_type_code) and
 dp_ds.period_counter = decode(bc.initial_period_counter, ds.period_counter, ds.period_counter + 1, ds.period_counter) and
 dp_ds.book_type_code = books.book_type_code and
 meth.method_code = books.deprn_method_code and
 nvl(meth.life_in_months, -1) = nvl(books.life_in_months, -1) and
 itc.itc_amount_id(+) = books.itc_amount_id and
 cot.prorate_convention_code = books.prorate_convention_code and
 cap.calendar_type = bc.prorate_calendar and
 books.prorate_date between cap.start_date and cap.end_date and
 cap.calendar_type = cat.calendar_type and
 lu_df.lookup_code = books.depreciate_flag and
 lu_df.lookup_type = 'YESNO' and
 lu_ly.lookup_code = meth.depreciate_lastyear_flag and
 lu_ly.lookup_type = 'YESNO' and
 lu_dwa.lookup_code = cot.depr_when_acquired_flag and
 lu_dwa.lookup_type = 'YESNO'
),
d_distributions as
(
select
 dh.asset_id asset_id,
 bc.book_type_code,
 dh.book_type_code book,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'ALL', 'Y', 'VALUE') gl_account,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_location', 'OFA', 'LOC#', :p_loc_flex_id, null, loc.location_id, 'ALL', 'Y', 'VALUE') location,
 emp.employee_number employee_number,
 emp.full_name employee_name,
 dh.units_assigned assigned_units
from
 fa_locations loc,
 gl_code_combinations cc,
 per_all_people_f emp,
 fa_distribution_history dh,
 fa_book_controls bc
where
 dh.code_combination_id = cc.code_combination_id and
 dh.assigned_to is not null and
 dh.assigned_to = emp.person_id and
 dh.date_effective between emp.effective_start_date and emp.effective_end_date and
 dh.location_id = loc.location_id and
 dh.date_ineffective is null and
 dh.book_type_code = bc.distribution_source_book
union all
select
 dh.asset_id asset_id,
 bc.book_type_code,
 dh.book_type_code book,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'ALL', 'Y', 'VALUE') gl_account,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_location', 'OFA', 'LOC#', :p_loc_flex_id, null, loc.location_id, 'ALL', 'Y', 'VALUE')location,
 null,
 null,
 dh.units_assigned distribution_units
from
 fa_locations loc,
 gl_code_combinations cc,
 fa_distribution_history dh,
 fa_book_controls bc
where
 dh.code_combination_id = cc.code_combination_id and
 dh.assigned_to is null and
 dh.location_id = loc.location_id and
 dh.date_ineffective is null and
 dh.book_type_code = bc.distribution_source_book
union all
select
 dh.asset_id asset_id,
 bc.book_type_code,
 dh.book_type_code book,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'ALL', 'Y', 'VALUE') gl_account,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_location', 'OFA', 'LOC#', :p_loc_flex_id, null, loc.location_id, 'ALL', 'Y', 'VALUE') location,
 null,
 null,
 dh.units_assigned distribution_units
from
 fa_locations loc,
 gl_code_combinations cc,
 fa_distribution_history dh,
 fa_book_controls bc
where
 dh.code_combination_id = cc.code_combination_id and
 dh.assigned_to is not null and
 dh.location_id = loc.location_id and
 dh.date_ineffective is null and
 dh.book_type_code = bc.distribution_source_book and
 not exists
  (select
    employee_id
   from
    fa_employees
   where
    employee_id = dh.assigned_to)
),
q_invoices as
(
select
 ai.asset_id asset_id,
 ai.invoice_number,
 ai.invoice_line_number||' - '||ai.ap_distribution_line_number invoice_line_number,
 ai.description invoice_descripton,
 po.segment1 vendor_number,
 po.vendor_name,
 ai.po_number
from
 fa_asset_invoices ai,
 po_vendors po
where
 ai.po_vendor_id = po.vendor_id(+) and
 ai.date_ineffective is null
)
--
-- Main Query Starts Here
--
select
x.*
from
(
 --
 -- Q1 Asset Books
 --
 select /*+ push_pred(books) */
 assets.asset_number,
 assets.description,
 assets.tag_number,
 assets.serial_number,
 assets.asset_category,
 assets.category_desc,
 assets.manufacturer_name,
 assets.model_number,
 assets.property_type,
 assets.property_class,
 assets.new_used,
 assets.in_use_flag,
 assets.owned_leased,
 assets.asset_type,
 assets.parent_asset_number,
 assets.parent_asset_desc,
 assets.total_units,
 --
 'Book' record_type,
 -- Books
 books.book,
 books.book_class,
 books.date_placed_in_service,
 books.prorate_convention,
 books.prorate_date,
 books.months_deprn_in_first_yr,
 books.depreciate,
 books.depreciate_when_placed_in_serv,
 books.deprn_start_date,
 books.deprn_method,
 books.life_in_yr_mo,
 books.basic_rate_pct,
 books.adjusted_rate_pct,
 books.capacity,
 books.ytd_production,
 books.ltd_production,
 books.unit_of_measure,
 books.depreciate_in_last_year,
 books.period_reserved,
 books.period_retired,
 books.itc_rate_pct,
 books.itc_amount,
 books.itc_basis,
 books.basis_reduction_rate_pct,
 books.basis_reduction,
 books.revaluation_reserve,
 books.ceiling_name,
 books.ceiling_type,
 books.bonus_rule,
 books.salvage_value,
 books.rate_adjustment_factor,
 books.original_cost,
 books.cost,
 books.recoverable_cost,
 books.depreciable_basis,
 books.net_book_value,
 books.deprn_reserve,
 books.ytd_deprn,
 -- Distributions
 null gl_account,
 null location,
 null employee_number,
 null employee_name,
 to_number(null) assigned_units,
 -- Invoices
 null invoice_number,
 null invoice_line_number,
 null invoice_descripton,
 null vendor_number,
 null vendor_name,
 null po_number
 from
 q_assets        assets,
 q_books         books
 where
 (:p_incl_book = 'Y' or (:p_incl_book = 'N' and :p_incl_dist = 'N' and :p_incl_inv = 'N')) and
 assets.asset_id = books.asset_id (+)
 union all
 --
 -- Q2 Asset Distributions
 --
 select /*+ push_pred(dist) */
 assets.asset_number,
 assets.description,
 assets.tag_number,
 assets.serial_number,
 assets.asset_category,
 assets.category_desc,
 assets.manufacturer_name,
 assets.model_number,
 assets.property_type,
 assets.property_class,
 assets.new_used,
 assets.in_use_flag,
 assets.owned_leased,
 assets.asset_type,
 assets.parent_asset_number,
 assets.parent_asset_desc,
 assets.total_units,
 --
 'Distribution' record_type,
 -- Books
 dist.book,
 null book_class,
 to_date(null) date_placed_in_service,
 null prorate_convention,
 to_date(null) prorate_date,
 to_number(null) months_deprn_in_first_yr,
 null depreciate,
 null depreciate_when_placed_in_serv,
 to_date(null) deprn_start_date,
 null deprn_method,
 null life_in_yr_mo,
 to_number(null) basic_rate_pct,
 to_number(null) adjusted_rate_pct,
 to_number(null) capacity,
 to_number(null) ytd_production,
 to_number(null) ltd_production,
 null unit_of_measure,
 null depreciate_in_last_year,
 null period_reserved,
 null period_retired,
 to_number(null) itc_rate_pct,
 to_number(null) itc_amount,
 to_number(null) itc_basis,
 to_number(null) basis_reduction_rate_pct,
 to_number(null) basis_reduction,
 to_number(null) revaluation_reserve,
 null ceiling_name,
 null ceiling_type,
 null bonus_rule,
 to_number(null) salvage_value,
 to_number(null) rate_adjustment_factor,
 to_number(null) original_cost,
 to_number(null) cost,
 to_number(null) recoverable_cost,
 to_number(null) depreciable_basis,
 to_number(null) net_book_value,
 to_number(null) deprn_reserve,
 to_number(null) ytd_deprn,
 -- Distributions
 dist.gl_account,
 dist.location,
 dist.employee_number,
 dist.employee_name,
 dist.assigned_units,
 -- Invoices
 null invoice_number,
 null invoice_line_number,
 null invoice_descripton,
 null vendor_number,
 null vendor_name,
 null po_number
 from
 q_assets        assets,
 d_distributions dist
 where
 :p_incl_dist = 'Y' and
 assets.asset_id       = dist.asset_id and
 assets.book_type_code = dist.book_type_code
 union all
 --
 -- Q3 Asset Invoices
 --
 select /*+ push_pred(inv) */
 assets.asset_number,
 assets.description,
 assets.tag_number,
 assets.serial_number,
 assets.asset_category,
 assets.category_desc,
 assets.manufacturer_name,
 assets.model_number,
 assets.property_type,
 assets.property_class,
 assets.new_used,
 assets.in_use_flag,
 assets.owned_leased,
 assets.asset_type,
 assets.parent_asset_number,
 assets.parent_asset_desc,
 assets.total_units,
 --
 'Invoice' record_type,
 -- Books
 null book,
 null book_class,
 to_date(null) date_placed_in_service,
 null prorate_convention,
 to_date(null) prorate_date,
 to_number(null) months_deprn_in_first_yr,
 null depreciate,
 null depreciate_when_placed_in_serv,
 to_date(null) deprn_start_date,
 null deprn_method,
 null life_in_yr_mo,
 to_number(null) basic_rate_pct,
 to_number(null) adjusted_rate_pct,
 to_number(null) capacity,
 to_number(null) ytd_production,
 to_number(null) ltd_production,
 null unit_of_measure,
 null depreciate_in_last_year,
 null period_reserved,
 null period_retired,
 to_number(null) itc_rate_pct,
 to_number(null) itc_amount,
 to_number(null) itc_basis,
 to_number(null) basis_reduction_rate_pct,
 to_number(null) basis_reduction,
 to_number(null) revaluation_reserve,
 null ceiling_name,
 null ceiling_type,
 null bonus_rule,
 to_number(null) salvage_value,
 to_number(null) rate_adjustment_factor,
 to_number(null) original_cost,
 to_number(null) cost,
 to_number(null) recoverable_cost,
 to_number(null) depreciable_basis,
 to_number(null) net_book_value,
 to_number(null) deprn_reserve,
 to_number(null) ytd_deprn,
 -- Distributions
 null gl_account,
 null location,
 null employee_number,
 null employee_name,
 to_number(null) assigned_units,
 -- Invoice
 inv.invoice_number,
 inv.invoice_line_number,
 inv.invoice_descripton,
 inv.vendor_number,
 inv.vendor_name,
 inv.po_number
 from
 q_assets        assets,
 q_invoices      inv
 where
 :p_incl_inv = 'Y' and
 assets.asset_id = inv.asset_id
) x
order by
x.asset_number,
decode(x.record_type,'Book',1,'Distribution',2,3),
x.book_class,
x.book,
x.gl_account,
x.location,
x.employee_name,
x.invoice_number,
x.invoice_line_number