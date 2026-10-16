/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Fixed Assets Book
-- Description: Assets held in a depreciation book with their cost, depreciation and net book value as at the end of the selected period.
-- Replaces the Oracle standard RXi: Fixed Assets Book report. The rows are extracted by the same routine its RX-only: Fixed Assets Book data program uses, so cost and depreciation figures are identical. The two seeded RXi attribute sets, Default and Book Details, are shipped as the templates of the same names; each puts the asset detail on the report sheet and the RXi group subtotals on a pivot sheet beside it.
-- One row per asset distribution, so an asset split over several cost centers or employees appears once per distribution. Units and Percent give the share of the asset in that distribution; Cost and the depreciation amounts are the distribution's share, not the asset total.
-- Cost, YTD Depreciation and LTD Depreciation are the balances of the last depreciation run on or before the selected period. Depreciation Amount is filled only where that run is the selected period itself, and is zero for an asset whose last run is earlier.
-- NBV at Period End is Cost less LTD Depreciation less impairment reserve, so it is lower than Cost less LTD Depreciation for an impaired asset. NBV at Beginning of Fiscal Year adds YTD Depreciation back.
-- Assets placed in service after the end of the selected period are excluded, as are assets fully retired before the start of the fiscal year that period falls in.
-- Drill Down into Group Assets adds the member assets of group assets, which are otherwise represented by their group asset alone.
-- The segment description columns are read in full from the flexfield value sets. The Oracle report prints the bare code for every value after the first one it looks up per value set, and cuts the descriptions it does print to the segment's display width.
-- Excel Example Output: https://www.enginatics.com/example/fa-fixed-assets-book/
-- Library Link: https://www.enginatics.com/reports/fa-fixed-assets-book/
-- Run Report: https://demo.enginatics.com/

select
x.ledger,
x.book,
x.period,
x.currency,
x.balancing_segment,
x.balancing_segment_description,
x.expense_account,
x.expense_account_description,
x.cost_center,
x.cost_center_description,
x.asset_cost_account,
x.asset_cost_account_description,
x.reserve_account,
x.reserve_account_description,
x.asset_category,
x.asset_category_description,
x.major_category,
x.major_category_description,
x.minor_category,
x.minor_category_description,
x.category_segment,
x.category_segment_description,
x.asset_number,
x.asset_description,
x.tag_number,
x.serial_number,
x.asset_key,
x.location,
x.group_asset_number,
x.inventorial,
x.employee_name,
x.employee_number,
x.units,
x.percent,
x.date_placed_in_service,
x.depreciation_method,
x."Life Yr.Mo",
x.adjusted_rate,
x.cost,
x.salvage_value,
x.depreciation_amount,
x.ytd_depreciation,
x.ltd_depreciation,
x.nbv_beginning_fiscal_year,
x.nbv_at_period_end
from
(
select
gl.name ledger,
:p_book book,
:p_period1 period,
gl.currency_code currency,
gcc.balancing_segment,
gcc.balancing_segment_description,
gcc.expense_account,
gcc.expense_account_description,
gcc.cost_center,
gcc.cost_center_description,
fcb.asset_cost_acct asset_cost_account,
xxen_util.segment_description(fcb.asset_cost_acct,gcc.account_column_name,gcc.chart_of_accounts_id) asset_cost_account_description,
frlg.deprn_reserve_acct reserve_account,
xxen_util.segment_description(frlg.deprn_reserve_acct,gcc.account_column_name,gcc.chart_of_accounts_id) reserve_account_description,
fcv.asset_category,
fcv.asset_category_description,
fcv.major_category,
fcv.major_category_description,
fcv.minor_category,
fcv.minor_category_description,
fcv.category_segment,
fcv.category_segment_description,
fa.asset_number,
fa.description asset_description,
fa.tag_number,
fa.serial_number,
(select fakk.concatenated_segments from fa_asset_keywords_kfv fakk where fa.asset_key_ccid=fakk.code_combination_id) asset_key,
(select flk.concatenated_segments from fa_locations_kfv flk where fdh.location_id=flk.location_id) location,
decode(fa.asset_type,'GROUP',fa.asset_number,nvl(fa_grp.asset_number,(select flv.meaning from fa_lookups_vl flv where fa.asset_type=flv.lookup_code and flv.lookup_type='ASSET TYPE'))) group_asset_number,
xxen_util.yes(case when fa.inventorial='YES' then 'Y' end) inventorial,
substrb(papf.full_name,1,50) employee_name,
substrb(papf.employee_number,1,15) employee_number,
fdh.units_assigned units,
nvl(fdh.units_assigned,0)/nvl(fah.units,1)*100 percent,
frlg.date_placed_in_service,
frlg.method_code depreciation_method,
floor(frlg.life/12)+mod(frlg.life,12)/100 "Life Yr.Mo",
frlg.rate adjusted_rate,
frlg.cost,
fb.salvage_value,
frlg.deprn_amount depreciation_amount,
frlg.ytd_deprn ytd_depreciation,
frlg.deprn_reserve ltd_depreciation,
frlg.cost-frlg.deprn_reserve-nvl(frlg.impairment_reserve,0)+frlg.ytd_deprn nbv_beginning_fiscal_year,
frlg.cost-frlg.deprn_reserve-nvl(frlg.impairment_reserve,0) nbv_at_period_end
from
fa_book_controls fbc,
fa_deprn_periods fdp,
gl_ledgers gl,
fa_reserve_ledger_gt frlg,
fa_distribution_history fdh,
fa_additions fa,
fa_additions fa_grp,
fa_asset_history fah,
fa_fiscal_year ffy,
fa_category_books fcb,
(
select /*+ no_merge */
y.*,
coalesce(xxen_util.segment_description(y.balancing_segment,y.balancing_column_name,y.chart_of_accounts_id),y.balancing_segment_description_) balancing_segment_description,
coalesce(xxen_util.segment_description(y.expense_account,y.account_column_name,y.chart_of_accounts_id),y.expense_account_description_) expense_account_description,
coalesce(xxen_util.segment_description(y.cost_center,y.cost_center_column_name,y.chart_of_accounts_id),y.cost_center_description_) cost_center_description
from
(
select
gcc.code_combination_id,
gcc.chart_of_accounts_id,
gfs.balancing_column_name,
gfs.account_column_name,
gfs.cost_center_column_name,
fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_bal_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'GL_BALANCING','Y','VALUE') balancing_segment,
fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_bal_seg_d','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'GL_BALANCING','Y','DESCRIPTION') balancing_segment_description_,
fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_acct_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'GL_ACCOUNT','Y','VALUE') expense_account,
fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_acct_seg_d','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'GL_ACCOUNT','Y','DESCRIPTION') expense_account_description_,
fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_cc_seg','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE') cost_center,
fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_cc_seg_d','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','DESCRIPTION') cost_center_description_
from
gl_code_combinations gcc,
(
select
fifs.id_flex_num,
max(case when fsav.segment_attribute_type='GL_BALANCING' then fifs.application_column_name end) balancing_column_name,
max(case when fsav.segment_attribute_type='GL_ACCOUNT' then fifs.application_column_name end) account_column_name,
max(case when fsav.segment_attribute_type='FA_COST_CTR' then fifs.application_column_name end) cost_center_column_name
from
fnd_id_flex_segments fifs,
fnd_segment_attribute_values fsav
where
fifs.application_id=101 and
fifs.id_flex_code='GL#' and
fifs.application_id=fsav.application_id and
fifs.id_flex_code=fsav.id_flex_code and
fifs.id_flex_num=fsav.id_flex_num and
fifs.application_column_name=fsav.application_column_name and
fsav.segment_attribute_type in ('GL_BALANCING','GL_ACCOUNT','FA_COST_CTR') and
fsav.attribute_value='Y'
group by
fifs.id_flex_num
) gfs
where
gcc.code_combination_id in (select frlg.dh_ccid from fa_reserve_ledger_gt frlg) and
gcc.chart_of_accounts_id=gfs.id_flex_num
) y
) gcc,
(
select /*+ no_merge */
y.*,
coalesce(xxen_util.segment_description(y.major_category,y.major_category_column_name,y.category_flex_structure,null,140,'CAT#'),y.major_category_description_) major_category_description,
coalesce(xxen_util.segment_description(y.minor_category,y.minor_category_column_name,y.category_flex_structure,y.major_category,140,'CAT#'),xxen_util.segment_description(y.minor_category,y.minor_category_column_name,y.category_flex_structure,null,140,'CAT#'),y.minor_category_description_) minor_category_description,
coalesce(xxen_util.segment_description(y.category_segment,y.category_segment_column_name,y.category_flex_structure,null,140,'CAT#'),xxen_util.segment_description(y.category_segment,y.category_segment_column_name,y.category_flex_structure,y.major_category,140,'CAT#'),y.category_segment_description_) category_segment_description
from
(
select
fcv.category_id,
fcv.property_type_code,
fcv.description asset_category_description,
fsc.category_flex_structure,
(select fcbk.concatenated_segments from fa_categories_b_kfv fcbk where fcv.category_id=fcbk.category_id) asset_category,
(select fifs.application_column_name from fnd_id_flex_segments fifs, fnd_segment_attribute_values fsav where fifs.application_id=140 and fifs.id_flex_code='CAT#' and fsc.category_flex_structure=fifs.id_flex_num and fifs.application_id=fsav.application_id and fifs.id_flex_code=fsav.id_flex_code and fifs.id_flex_num=fsav.id_flex_num and fifs.application_column_name=fsav.application_column_name and fsav.segment_attribute_type='BASED_CATEGORY' and fsav.attribute_value='Y') major_category_column_name,
(select fifs.application_column_name from fnd_id_flex_segments fifs, fnd_segment_attribute_values fsav where fifs.application_id=140 and fifs.id_flex_code='CAT#' and fsc.category_flex_structure=fifs.id_flex_num and fifs.application_id=fsav.application_id and fifs.id_flex_code=fsav.id_flex_code and fifs.id_flex_num=fsav.id_flex_num and fifs.application_column_name=fsav.application_column_name and fsav.segment_attribute_type='MINOR_CATEGORY' and fsav.attribute_value='Y') minor_category_column_name,
(select fifs.application_column_name from fnd_id_flex_segments fifs where fifs.application_id=140 and fifs.id_flex_code='CAT#' and fsc.category_flex_structure=fifs.id_flex_num and fifs.segment_num=:category_segment_number) category_segment_column_name,
fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_maj_cat','OFA','CAT#',fsc.category_flex_structure,null,fcv.category_id,'BASED_CATEGORY','N','VALUE') major_category,
fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_maj_cat_d','OFA','CAT#',fsc.category_flex_structure,null,fcv.category_id,'BASED_CATEGORY','N','DESCRIPTION') major_category_description_,
fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_min_cat','OFA','CAT#',fsc.category_flex_structure,null,fcv.category_id,'MINOR_CATEGORY','N','VALUE') minor_category,
fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_min_cat_d','OFA','CAT#',fsc.category_flex_structure,null,fcv.category_id,'MINOR_CATEGORY','N','DESCRIPTION') minor_category_description_,
case when :category_segment_number is not null then fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_cat_seg','OFA','CAT#',fsc.category_flex_structure,null,fcv.category_id,:category_segment_number,'N','VALUE') end category_segment,
case when :category_segment_number is not null then fnd_flex_xml_publisher_apis.process_kff_combination_1('fa_book_cat_seg_d','OFA','CAT#',fsc.category_flex_structure,null,fcv.category_id,:category_segment_number,'N','DESCRIPTION') end category_segment_description_
from
fa_system_controls fsc,
fa_categories_vl fcv
where
fcv.category_id in (select fcb.category_id from fa_category_books fcb where fcb.book_type_code=:p_book)
) y
) fcv,
fa_books fb,
fa_category_book_defaults fcbd,
per_all_people_f papf
where
fbc.book_type_code=:p_book and
fbc.set_of_books_id=gl.ledger_id and
fdp.book_type_code=:p_book and
fdp.period_name=:p_period1 and
frlg.asset_id=fa.asset_id and
frlg.asset_id=fdh.asset_id and
frlg.dh_ccid=fdh.code_combination_id and
frlg.distribution_id=fdh.distribution_id and
fdh.date_effective<frlg.date_effective and
nvl(fdh.date_ineffective,sysdate)>=frlg.date_effective and
frlg.dh_ccid=gcc.code_combination_id and
fcb.book_type_code=:p_book and
fcb.category_id=fah.category_id and
fah.asset_id=fa.asset_id and
fah.date_effective<frlg.date_effective and
nvl(fah.date_ineffective,sysdate)>=frlg.date_effective and
fb.group_asset_id=fa_grp.asset_id(+) and
ffy.fiscal_year_name=fbc.fiscal_year_name and
frlg.date_placed_in_service between ffy.start_date and ffy.end_date and
frlg.date_placed_in_service<=trunc(fdp.calendar_period_close_date) and
fb.book_type_code=:p_book and
fb.asset_id=frlg.asset_id and
fb.date_effective<frlg.date_effective and
nvl(fb.date_ineffective,sysdate)>=frlg.date_effective and
fcv.category_id=fah.category_id and
fcbd.category_id=fah.category_id and
fcbd.book_type_code=:p_book and
frlg.date_placed_in_service between fcbd.start_dpis and nvl(fcbd.end_dpis,frlg.date_placed_in_service) and
fdh.assigned_to=papf.person_id(+) and
trunc(sysdate) between papf.effective_start_date(+) and papf.effective_end_date(+) and
(fb.group_asset_id is null or :p_drill_down is not null or exists (
select
null
from
fa_books fb_grp,
fa_transaction_headers fth,
fa_deprn_periods fdp_grp
where
fb.transaction_header_id_in=fb_grp.transaction_header_id_out and
fb_grp.transaction_header_id_out=fth.transaction_header_id and
fb_grp.group_asset_id is null and
fdp_grp.book_type_code=:p_book and
fdp_grp.period_counter=frlg.period_counter and
fth.date_effective between fdp_grp.period_open_date and nvl(fdp_grp.period_close_date,fth.date_effective)
)) and
1=1
) x
where
2=2
