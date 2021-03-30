/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
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
 x.Company_Name
,x.book
,x.Cur_Period "Current Period"
,x.d_comp_code1 "&balancing_segment_p"
,x.d_cost_ctr1      "&cost_center_p"
,x.owner
,x.d_location1     "Location"
,x.asset           "Asset - Description"
,x.units
,x.serial          "Serial Number"
,x.tag             "Tag Number"
,FA_FAS410_XMLP_PKG.as_nbvformula(x.COST, x.RESERVE) "Net Book Value"
,x.cost            "Current Cost"
,case when x.new > 0
   then 'New'
   else null
   end             "New"
,x.asset_type
from
(
select
 fsc.company_name,
 fsc.book,
 fsc.Cur_Period,
 EMP.FULL_NAME				OWNER,
 AD.ASSET_NUMBER || ' - ' || AD.DESCRIPTION		ASSET,
 sum(DH.UNITS_ASSIGNED)				UNITS,
 AD.SERIAL_NUMBER				SERIAL,
 AD.TAG_NUMBER				TAG,
 sum(decode(dd.deprn_source_code,'B', dd.addition_cost_to_clear, dd.cost))		COST,
 sum(dd.deprn_reserve)				RESERVE,
 decode(greatest(BOOKS.DATE_PLACED_IN_SERVICE,NVL(:P_FROM_DATE, BOOKS.DATE_PLACED_IN_SERVICE))
       ,least(BOOKS.DATE_PLACED_IN_SERVICE, NVL(:P_TO_DATE, BOOKS.DATE_PLACED_IN_SERVICE))
       ,1,0)                                               NEW,
 decode(AD.ASSET_TYPE,'CIP', 'C', 'EXPENSED','E','')		ASSET_TYPE,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_comp_code', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'GL_BALANCING', 'Y', 'VALUE') D_COMP_CODE1,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE') D_COST_CTR1,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_location', 'OFA', 'LOC#', 101, NULL, loc.LOCATION_ID, 'ALL', 'Y', 'VALUE') D_LOCATION1
FROM
    (
     SELECT
       Company_Name,
       Category_Flex_Structure,
       Location_Flex_Structure,
       Asset_Key_Flex_Structure,
	     FA_FAS410_XMLP_PKG.bookformula() Book,
	     FA_FAS410_XMLP_PKG.cur_periodformula(FA_FAS410_XMLP_PKG.bookformula()) Cur_Period,
	     FA_FAS410_XMLP_PKG.report_nameformula() Report_Name,
	     FA_FAS410_XMLP_PKG.Accounting_Flex_Structure_p Accounting_Flex_Structure,
	     FA_FAS410_XMLP_PKG.Currency_Code_p Currency_Code,
	     FA_FAS410_XMLP_PKG.Book_Class_p Book_Class,
	     FA_FAS410_XMLP_PKG.Distribution_Source_Book_p Distribution_Source_Book,
	     FA_FAS410_XMLP_PKG.Cur_Period_PC_p Cur_Period_PC
	   FROM FA_SYSTEM_CONTROLS
    ) fsc,
    fa_deprn_detail         dd,
    per_people_f            emp,
    fa_additions            ad,
    fa_locations            loc,
    gl_code_combinations    cc,
    fa_books                books,
    fa_distribution_history dh
WHERE
    dh.book_type_code      = :P_BOOK    AND
    dh.assigned_to         = emp.person_id(+)      AND
    dh.date_effective between nvl(emp.effective_start_date,dh.date_effective)
                                        and nvl(emp.effective_end_date,dh.date_effective) AND
    fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE') between
    NVL(:P_START_CC,  fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE'))  AND
    NVL(:P_END_CC ,  fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE')) AND
    dh.asset_id            = ad.asset_id            AND
    dh.location_id         = loc.location_id        AND
    dh.code_combination_id = cc.code_combination_id AND
    dh.date_ineffective is null AND
    dd.asset_id = dh.asset_id             AND
    dd.book_type_code = dh.book_type_code      AND
    dd.distribution_id = dh.distribution_id      AND
    dd.period_counter =
     (SELECT    max (dd2.period_counter)
      FROM    fa_deprn_detail dd2
      WHERE	dd2.book_type_code = books.book_type_code and
            dd2.asset_id = books.asset_id and
            dd2.distribution_id = dd.distribution_id
     ) AND
   books.book_type_code  = :P_BOOK        AND
   books.asset_id = dh.asset_id and
   books.date_placed_in_service between nvl(:P_FROM_DATE, books.date_placed_in_service) and nvl(:P_TO_DATE, books.date_placed_in_service) AND
   books.period_counter_fully_retired is null   AND
   books.date_ineffective is null
group by
   fsc.company_name,
   fsc.book,
   fsc.Cur_Period,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('d_comp_code', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'GL_BALANCING', 'Y', 'VALUE'),
   fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE'),
   emp.full_name,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('d_location', 'OFA', 'LOC#', 101, NULL, loc.LOCATION_ID, 'ALL', 'Y', 'VALUE'),
   AD.ASSET_NUMBER || ' - ' || AD.DESCRIPTION,
   dh.units_assigned,
   ad.serial_number,
   ad.tag_number,
   decode(AD.ASSET_TYPE,'CIP', 'C', 'EXPENSED','E',''),
   decode(greatest(BOOKS.DATE_PLACED_IN_SERVICE,NVL(:P_FROM_DATE, BOOKS.DATE_PLACED_IN_SERVICE))
         ,least(BOOKS.DATE_PLACED_IN_SERVICE,NVL(:P_TO_DATE, BOOKS.DATE_PLACED_IN_SERVICE))
         ,1, 0),
   decode(dd.deprn_source_code,'B', dd.addition_cost_to_clear, dd.cost),
   dd.deprn_reserve
UNION ALL
select
 fsc.company_name,
 fsc.book,
 fsc.Cur_Period,
 EMP.FULL_NAME				OWNER,
 AD.ASSET_NUMBER || ' - ' || AD.DESCRIPTION		ASSET,
 sum(decode(LU.LOOKUP_CODE
           ,'ADDITION COST',decode(adj.source_type_code
                                  ,'TRANSFER',decode(adj.debit_credit_flag,'DR',1,-1)*DH.UNITS_ASSIGNED
                                  ,'RETIREMENT',decode(adj.debit_credit_flag,'DR',1,-1)*DH.UNITS_ASSIGNED
                                  ,'CIP RETIREMENT',decode(adj.debit_credit_flag,'DR',1,-1)*DH.UNITS_ASSIGNED
                                  ,'RECLASS',decode(adj.debit_credit_flag,'DR',1,-1)*DH.UNITS_ASSIGNED,0
                                  )
                           ,0
           )
     )					UNITS,
 AD.SERIAL_NUMBER				SERIAL,
 AD.TAG_NUMBER				TAG,
 sum(DECODE(LU.LOOKUP_CODE,
 'ADDITION COST',
 DECODE(ADJ.DEBIT_CREDIT_FLAG, 'DR', 1, -1) * ADJ.ADJUSTMENT_AMOUNT,0))		COST,
 sum(DECODE(LU.LOOKUP_CODE
           ,'DEPRECIATION RESERVE', DECODE(ADJ.DEBIT_CREDIT_FLAG, 'DR', -1, 1) * ADJ.ADJUSTMENT_AMOUNT
           , 0)
    )	RESERVE,
 decode(greatest(BOOKS.DATE_PLACED_IN_SERVICE,NVL(:P_FROM_DATE, BOOKS.DATE_PLACED_IN_SERVICE))
       ,least(BOOKS.DATE_PLACED_IN_SERVICE,NVL(:P_TO_DATE, BOOKS.DATE_PLACED_IN_SERVICE))
       ,1, 0)                NEW,
 decode(AD.ASSET_TYPE,'CIP', 'C', 'EXPENSED','E','')		ASSET_TYPE,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_comp_code', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'GL_BALANCING', 'Y', 'VALUE') D_COMP_CODE1,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE') D_COST_CTR1,
 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_location', 'OFA', 'LOC#', 101, NULL, loc.LOCATION_ID, 'ALL', 'Y', 'VALUE') D_LOCATION1
FROM
    (
     SELECT
       Company_Name,
       Category_Flex_Structure,
       Location_Flex_Structure,
       Asset_Key_Flex_Structure,
	     FA_FAS410_XMLP_PKG.bookformula() Book,
	     FA_FAS410_XMLP_PKG.cur_periodformula(FA_FAS410_XMLP_PKG.bookformula()) Cur_Period,
	     FA_FAS410_XMLP_PKG.report_nameformula() Report_Name,
	     FA_FAS410_XMLP_PKG.Accounting_Flex_Structure_p Accounting_Flex_Structure,
	     FA_FAS410_XMLP_PKG.Currency_Code_p Currency_Code,
	     FA_FAS410_XMLP_PKG.Book_Class_p Book_Class,
	     FA_FAS410_XMLP_PKG.Distribution_Source_Book_p Distribution_Source_Book,
	     FA_FAS410_XMLP_PKG.Cur_Period_PC_p Cur_Period_PC
	   FROM FA_SYSTEM_CONTROLS
    ) fsc,
    per_people_f            emp,
    fa_additions            ad,
    fa_locations            loc,
    gl_code_combinations    cc,
    fa_books                books,
    fa_adjustments	adj,
    fa_distribution_history dh,
    fa_lookups 	lu
WHERE
  dh.book_type_code      = :P_BOOK    AND
  dh.assigned_to         = emp.person_id(+)      AND
  dh.date_effective between nvl(emp.effective_start_date,dh.date_effective)
                                       and   nvl(emp.effective_end_date,dh.date_effective)  AND
	fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE') between
	NVL(:P_START_CC,  fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE'))  AND
	NVL(:P_END_CC ,  fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE')) AND
  dh.asset_id            = ad.asset_id            AND
  dh.location_id         = loc.location_id        AND
  dh.code_combination_id = cc.code_combination_id AND
  dh.date_ineffective is null AND
	lu.lookup_type = 'JOURNAL ENTRIES' and
	(   (adj.adjustment_type in ('COST','CIP COST') and lu.lookup_code = 'ADDITION COST')
	 or (adj.adjustment_type = 'RESERVE' and lu.lookup_code = 'DEPRECIATION RESERVE')
	) AND
	adj.source_type_code not in ('DEPRECIATION','ADDITION', 'CIP ADDITION') and
 	adj.book_type_code = :P_BOOK and
	adj.asset_id = dh.asset_id and
	adj.distribution_id = dh.distribution_id and
	adj.period_counter_created = fsc.CUR_PERIOD_PC AND
  books.book_type_code  = :P_BOOK        AND
  books.asset_id = dh.asset_id and
  books.date_placed_in_service between
  nvl(:P_FROM_DATE, books.date_placed_in_service) and
  nvl(:P_TO_DATE, books.date_placed_in_service) AND
  books.period_counter_fully_retired is null   AND
  books.date_ineffective is null
	group by
 fsc.company_name,
 fsc.book,
 fsc.Cur_Period,
	 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_comp_code', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'GL_BALANCING', 'Y', 'VALUE'),
	 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_cost_ctr', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE'),
	 emp.full_name,
	 fnd_flex_xml_publisher_apis.process_kff_combination_1('d_location', 'OFA', 'LOC#', 101, NULL, loc.LOCATION_ID, 'ALL', 'Y', 'VALUE'),
   AD.ASSET_NUMBER || ' - ' || AD.DESCRIPTION,
	 decode(LU.LOOKUP_CODE,'ADDITION COST',decode(adj.source_type_code
	                                             ,'TRANSFER',decode(adj.debit_credit_flag,'DR',1,-1)*DH.UNITS_ASSIGNED
	                                             ,'RETIREMENT',decode(adj.debit_credit_flag,'DR',1,-1)*DH.UNITS_ASSIGNED
	                                             ,'CIP RETIREMENT',decode(adj.debit_credit_flag,'DR',1,-1)*DH.UNITS_ASSIGNED
	                                             ,'RECLASS',decode(adj.debit_credit_flag,'DR',1,-1)*DH.UNITS_ASSIGNED
	                                                       ,0)
	                                      ,0),
	ad.serial_number,
	ad.tag_number,
	decode(AD.ASSET_TYPE,'CIP', 'C', 'EXPENSED','E',''),
	decode(greatest(BOOKS.DATE_PLACED_IN_SERVICE,NVL(:P_FROM_DATE, BOOKS.DATE_PLACED_IN_SERVICE))
	      ,	least(BOOKS.DATE_PLACED_IN_SERVICE,NVL(:P_TO_DATE, BOOKS.DATE_PLACED_IN_SERVICE))
	      ,	1, 0),
	DECODE(LU.LOOKUP_CODE
	      ,'ADDITION COST', DECODE(ADJ.DEBIT_CREDIT_FLAG, 'DR', 1, -1) * ADJ.ADJUSTMENT_AMOUNT
	                      ,0),
  DECODE(LU.LOOKUP_CODE
        ,'DEPRECIATION RESERVE',DECODE(ADJ.DEBIT_CREDIT_FLAG, 'DR', -1, 1) * ADJ.ADJUSTMENT_AMOUNT
                               , 0)
ORDER BY  13, 14, 4, 15, 5
) x