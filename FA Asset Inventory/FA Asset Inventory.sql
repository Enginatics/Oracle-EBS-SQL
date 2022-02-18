/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Inventory
-- Description: Imported Oracle standard asset inventory report
Source: Asset Inventory Report (XML)
Short Name: FAS410_XML
DB package: FA_FAS410_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-inventory/
-- Library Link: https://www.enginatics.com/reports/fa-asset-inventory/
-- Run Report: https://demo.enginatics.com/

select
 x.company_name
,x.book
,x.cur_period current_period
,x.d_comp_code1 "&balancing_segment_p"
,x.d_cost_ctr1 "&cost_center_p"
,x.owner
,x.d_location1 location
,x.asset "Asset - Description"
,x.units
,x.serial serial_number
,x.tag tag_number
,fa_fas410_xmlp_pkg.as_nbvformula(x.cost, x.reserve) net_book_value
,x.cost current_cost
,case when x.new > 0 then 'New' else null end new
,x.asset_type
from
(
select
 fsc.company_name,
 fsc.book,
 fsc.cur_period,
 emp.full_name                owner,
 ad.asset_number || ' - ' || ad.description        asset,
 sum(dh.units_assigned)                units,
 ad.serial_number                serial,
 ad.tag_number                tag,
 sum(decode(dd.deprn_source_code,'B', dd.addition_cost_to_clear, dd.cost))        cost,
 sum(dd.deprn_reserve)                reserve,
 decode(greatest(books.date_placed_in_service,nvl(:p_from_date, books.date_placed_in_service))
       ,least(books.date_placed_in_service, nvl(:p_to_date, books.date_placed_in_service))
       ,1,0)                                               new,
 decode(ad.asset_type,'CIP', 'C', 'EXPENSED','E','')        asset_type,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_comp_code', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') d_comp_code1,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') d_cost_ctr1,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_location', 'OFA', 'LOC#', 101, null, loc.location_id, 'ALL', 'Y', 'VALUE') d_location1
from
    (
     select
       company_name,
       category_flex_structure,
       location_flex_structure,
       asset_key_flex_structure,
         fa_fas410_xmlp_pkg.bookformula() book,
         fa_fas410_xmlp_pkg.cur_periodformula(fa_fas410_xmlp_pkg.bookformula()) cur_period,
         fa_fas410_xmlp_pkg.report_nameformula() report_name,
         fa_fas410_xmlp_pkg.accounting_flex_structure_p accounting_flex_structure,
         fa_fas410_xmlp_pkg.currency_code_p currency_code,
         fa_fas410_xmlp_pkg.book_class_p book_class,
         fa_fas410_xmlp_pkg.distribution_source_book_p distribution_source_book,
         fa_fas410_xmlp_pkg.cur_period_pc_p cur_period_pc
       from fa_system_controls
    ) fsc,
    fa_deprn_detail         dd,
    per_people_f            emp,
    fa_additions            ad,
    fa_locations            loc,
    gl_code_combinations    cc,
    fa_books                books,
    fa_distribution_history dh
where
    dh.book_type_code      = :p_book    and
    dh.assigned_to         = emp.person_id(+)      and
    dh.date_effective between nvl(emp.effective_start_date,dh.date_effective)
                                        and nvl(emp.effective_end_date,dh.date_effective) and
    fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') between
    nvl(:p_start_cc,  fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'))  and
    nvl(:p_end_cc ,  fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE')) and
    dh.asset_id            = ad.asset_id            and
    dh.location_id         = loc.location_id        and
    dh.code_combination_id = cc.code_combination_id and
    dh.date_ineffective is null and
    dd.asset_id = dh.asset_id             and
    dd.book_type_code = dh.book_type_code      and
    dd.distribution_id = dh.distribution_id      and
    dd.period_counter =
     (select    max (dd2.period_counter)
      from    fa_deprn_detail dd2
      where    dd2.book_type_code = books.book_type_code and
            dd2.asset_id = books.asset_id and
            dd2.distribution_id = dd.distribution_id
     ) and
   books.book_type_code  = :p_book        and
   books.asset_id = dh.asset_id and
   books.date_placed_in_service between nvl(:p_from_date, books.date_placed_in_service) and nvl(:p_to_date, books.date_placed_in_service) and
   books.period_counter_fully_retired is null   and
   books.date_ineffective is null
group by
   fsc.company_name,
   fsc.book,
   fsc.cur_period,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('d_comp_code', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
   fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'),
   emp.full_name,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('d_location', 'OFA', 'LOC#', 101, null, loc.location_id, 'ALL', 'Y', 'VALUE'),
   ad.asset_number || ' - ' || ad.description,
   dh.units_assigned,
   ad.serial_number,
   ad.tag_number,
   decode(ad.asset_type,'CIP', 'C', 'EXPENSED','E',''),
   decode(greatest(books.date_placed_in_service,nvl(:p_from_date, books.date_placed_in_service))
         ,least(books.date_placed_in_service,nvl(:p_to_date, books.date_placed_in_service))
         ,1, 0),
   decode(dd.deprn_source_code,'B', dd.addition_cost_to_clear, dd.cost),
   dd.deprn_reserve
union all
select
 fsc.company_name,
 fsc.book,
 fsc.cur_period,
 emp.full_name                owner,
 ad.asset_number || ' - ' || ad.description        asset,
 sum(decode(lu.lookup_code
           ,'ADDITION COST',decode(adj.source_type_code
                                  ,'TRANSFER',decode(adj.debit_credit_flag,'DR',1,-1)*dh.units_assigned
                                  ,'RETIREMENT',decode(adj.debit_credit_flag,'DR',1,-1)*dh.units_assigned
                                  ,'CIP RETIREMENT',decode(adj.debit_credit_flag,'DR',1,-1)*dh.units_assigned
                                  ,'RECLASS',decode(adj.debit_credit_flag,'DR',1,-1)*dh.units_assigned,0
                                  )
                           ,0
           )
     )                    units,
 ad.serial_number                serial,
 ad.tag_number                tag,
 sum(decode(lu.lookup_code,
 'ADDITION COST',
 decode(adj.debit_credit_flag, 'DR', 1, -1) * adj.adjustment_amount,0))        cost,
 sum(decode(lu.lookup_code
           ,'DEPRECIATION RESERVE', decode(adj.debit_credit_flag, 'DR', -1, 1) * adj.adjustment_amount
           , 0)
    )    reserve,
 decode(greatest(books.date_placed_in_service,nvl(:p_from_date, books.date_placed_in_service))
       ,least(books.date_placed_in_service,nvl(:p_to_date, books.date_placed_in_service))
       ,1, 0)                new,
 decode(ad.asset_type,'CIP', 'C', 'EXPENSED','E','')        asset_type,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_comp_code', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') d_comp_code1,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') d_cost_ctr1,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_location', 'OFA', 'LOC#', 101, null, loc.location_id, 'ALL', 'Y', 'VALUE') d_location1
from
    (
     select
       company_name,
       category_flex_structure,
       location_flex_structure,
       asset_key_flex_structure,
         fa_fas410_xmlp_pkg.bookformula() book,
         fa_fas410_xmlp_pkg.cur_periodformula(fa_fas410_xmlp_pkg.bookformula()) cur_period,
         fa_fas410_xmlp_pkg.report_nameformula() report_name,
         fa_fas410_xmlp_pkg.accounting_flex_structure_p accounting_flex_structure,
         fa_fas410_xmlp_pkg.currency_code_p currency_code,
         fa_fas410_xmlp_pkg.book_class_p book_class,
         fa_fas410_xmlp_pkg.distribution_source_book_p distribution_source_book,
         fa_fas410_xmlp_pkg.cur_period_pc_p cur_period_pc
       from fa_system_controls
    ) fsc,
    per_people_f            emp,
    fa_additions            ad,
    fa_locations            loc,
    gl_code_combinations    cc,
    fa_books                books,
    fa_adjustments    adj,
    fa_distribution_history dh,
    fa_lookups     lu
where
  dh.book_type_code      = :p_book    and
  dh.assigned_to         = emp.person_id(+)      and
  dh.date_effective between nvl(emp.effective_start_date,dh.date_effective)
                                       and   nvl(emp.effective_end_date,dh.date_effective)  and
    fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') between
    nvl(:p_start_cc,  fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'))  and
    nvl(:p_end_cc ,  fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE')) and
  dh.asset_id            = ad.asset_id            and
  dh.location_id         = loc.location_id        and
  dh.code_combination_id = cc.code_combination_id and
  dh.date_ineffective is null and
    lu.lookup_type = 'JOURNAL ENTRIES' and
    (   (adj.adjustment_type in ('COST','CIP COST') and lu.lookup_code = 'ADDITION COST')
     or (adj.adjustment_type = 'RESERVE' and lu.lookup_code = 'DEPRECIATION RESERVE')
    ) and
    adj.source_type_code not in ('DEPRECIATION','ADDITION', 'CIP ADDITION') and
     adj.book_type_code = :p_book and
    adj.asset_id = dh.asset_id and
    adj.distribution_id = dh.distribution_id and
    adj.period_counter_created = fsc.cur_period_pc and
  books.book_type_code  = :p_book        and
  books.asset_id = dh.asset_id and
  books.date_placed_in_service between
  nvl(:p_from_date, books.date_placed_in_service) and
  nvl(:p_to_date, books.date_placed_in_service) and
  books.period_counter_fully_retired is null   and
  books.date_ineffective is null
    group by
 fsc.company_name,
 fsc.book,
 fsc.cur_period,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('d_comp_code', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),
     fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.chart_of_accounts_id, null, cc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'),
     emp.full_name,
     fnd_flex_xml_publisher_apis.process_kff_combination_1('d_location', 'OFA', 'LOC#', 101, null, loc.location_id, 'ALL', 'Y', 'VALUE'),
   ad.asset_number || ' - ' || ad.description,
     decode(lu.lookup_code,'ADDITION COST',decode(adj.source_type_code
                                                 ,'TRANSFER',decode(adj.debit_credit_flag,'DR',1,-1)*dh.units_assigned
                                                 ,'RETIREMENT',decode(adj.debit_credit_flag,'DR',1,-1)*dh.units_assigned
                                                 ,'CIP RETIREMENT',decode(adj.debit_credit_flag,'DR',1,-1)*dh.units_assigned
                                                 ,'RECLASS',decode(adj.debit_credit_flag,'DR',1,-1)*dh.units_assigned
                                                           ,0)
                                          ,0),
    ad.serial_number,
    ad.tag_number,
    decode(ad.asset_type,'CIP', 'C', 'EXPENSED','E',''),
    decode(greatest(books.date_placed_in_service,nvl(:p_from_date, books.date_placed_in_service))
          ,    least(books.date_placed_in_service,nvl(:p_to_date, books.date_placed_in_service))
          ,    1, 0),
    decode(lu.lookup_code,'ADDITION COST', decode(adj.debit_credit_flag, 'DR', 1, -1) * adj.adjustment_amount,0),
  decode(lu.lookup_code,'DEPRECIATION RESERVE',decode(adj.debit_credit_flag, 'DR', -1, 1) * adj.adjustment_amount,0)
order by  13, 14, 4, 15, 5
) x