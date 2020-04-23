/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Inventory Report
-- Description: Application: Assets
Source: Asset Inventory Report (Enginatics)
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-inventory-report/
-- Library Link: https://www.enginatics.com/reports/fa-asset-inventory-report/
-- Run Report: https://demo.enginatics.com/

select 
papf.full_name "Owner",
fnd_flex_xml_publisher_apis.process_kff_combination_1('D_LOCATION','OFA','LOC#',101,null,fl.location_id,'ALL','Y','VALUE')"Location",
fab.asset_number || ' - ' || fat.description "Asset - Description",
sum(fdh.units_assigned * fdd.units_modifier) "Units",
fab.serial_number "Serial Number",
fab.tag_number "Tag",
sum(fdd.cost) "Current Cost",
sum(fdd.reserve) reserve,
case when greatest(fb.date_placed_in_service, nvl(:p_from_date, fb.date_placed_in_service)) = least(fb.date_placed_in_service,nvl(:p_to_date, fb.date_placed_in_service))then 1 else 0 end "New",
decode(fab.asset_type, 'CIP', 'C', 'EXPENSED', 'E', '') "Asset Type",
fnd_flex_xml_publisher_apis.process_kff_combination_1('D_COMP_CODE','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'GL_BALANCING','Y','VALUE')"Comp Code",
fnd_flex_xml_publisher_apis.process_kff_combination_1('D_COST_CTR','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE')"Cost Center"
                                                    
from 
fa_books fb,
fa_additions_b fab,
fa_additions_tl fat,
(select 
fdd.asset_id,
fdd.book_type_code,
fdd.distribution_id,
decode(fdd.deprn_source_code, 'B', fdd.addition_cost_to_clear, fdd.cost) cost,
fdd.deprn_reserve reserve,
1 units_modifier
from fa_deprn_detail fdd
where 
fdd.period_counter = (select max(period_counter) from fa_deprn_detail dd2 where dd2.book_type_code = fdd.book_type_code and dd2.asset_id = fdd.asset_id and dd2.distribution_id = fdd.distribution_id)
and book_type_code = :p_book
union all
select 
fa.asset_id,
fa.book_type_code,
fa.distribution_id,
decode(fl.lookup_code,'ADDITION COST', decode(fa.debit_credit_flag, 'DR', 1, -1)*fa.adjustment_amount,0)cost,
decode(fl.lookup_code,'DEPRECIATION RESERVE',decode(fa.debit_credit_flag, 'DR', -1, 1)*fa.adjustment_amount,0)reserve,
case when fl.lookup_code='ADDITION COST' and fa.source_type_code in('TRANSFER','RETIREMENT','CIP RETIREMENT','RECLASS')
  then decode(fa.debit_credit_flag,'DR',1,-1)
  else 0 
end units_modifier
from 
fa_adjustments fa, 
fa_lookups fl
where 
fl.lookup_type = 'JOURNAL ENTRIES' 
and((fa.adjustment_type in ('COST','CIP COST') and fl.lookup_code = 'ADDITION COST')
or  (fa.adjustment_type = 'RESERVE' and fl.lookup_code = 'DEPRECIATION RESERVE'))
AND fa.source_type_code not in ('DEPRECIATION','ADDITION', 'CIP ADDITION') 
and fa.book_type_code = :P_BOOK 
and fa.period_counter_created = (select max(period_counter) from fa_deprn_detail dd2 where dd2.book_type_code = fa.book_type_code and dd2.asset_id = fa.asset_id and dd2.distribution_id = fa.distribution_id)
) fdd,
fa_distribution_history fdh,
fa_locations fl,
per_all_people_f papf,
gl_code_combinations gcc
where 1=1
and fb.book_type_code = :p_book
and fb.date_placed_in_service between nvl(:p_from_date, fb.date_placed_in_service) and nvl(:p_to_date, fb.date_placed_in_service)
and fb.period_counter_fully_retired is null
and fb.date_ineffective is null
and fab.asset_id = fb.asset_id
and fab.asset_id = fat.asset_id 
and fat.language = userenv('lang')
and fdh.asset_id = fb.asset_id
and fdh.book_type_code = fb.book_type_code
and fdh.date_ineffective is null
and fdh.assigned_to = papf.person_id(+)
and fdh.date_effective between nvl(papf.effective_start_date, fdh.date_effective) and nvl(papf.effective_end_date, fdh.date_effective)
and fdh.code_combination_id = gcc.code_combination_id
and fdd.asset_id = fdh.asset_id
and fdd.book_type_code = fdh.book_type_code
and fdd.distribution_id = fdh.distribution_id
and fdh.location_id = fl.location_id
and fnd_flex_xml_publisher_apis.process_kff_combination_1('D_COST_CTR','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE') 
between
nvl(:p_start_cc,fnd_flex_xml_publisher_apis.process_kff_combination_1('D_COST_CTR','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE')) 
and
nvl(:p_end_cc,fnd_flex_xml_publisher_apis.process_kff_combination_1('D_COST_CTR','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE'))

group by 
papf.full_name,
fnd_flex_xml_publisher_apis.process_kff_combination_1('D_LOCATION','OFA','LOC#',101,null,fl.location_id,'ALL','Y','VALUE'),
fab.asset_number || ' - ' || fat.description,
fab.serial_number,
fab.tag_number,
case when greatest(fb.date_placed_in_service, nvl(:p_from_date, fb.date_placed_in_service)) = least(fb.date_placed_in_service,nvl(:p_to_date, fb.date_placed_in_service))then 1 else 0 end,
decode(fab.asset_type, 'CIP', 'C', 'EXPENSED', 'E', ''),
fnd_flex_xml_publisher_apis.process_kff_combination_1('D_COMP_CODE','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'GL_BALANCING','Y','VALUE'),
fnd_flex_xml_publisher_apis.process_kff_combination_1('D_COST_CTR','SQLGL','GL#',gcc.chart_of_accounts_id,null,gcc.code_combination_id,'FA_COST_CTR','Y','VALUE'),
fnd_flex_xml_publisher_apis.process_kff_combination_1('D_LOCATION','OFA','LOC#',101,null,fl.location_id,'ALL','Y','VALUE')
