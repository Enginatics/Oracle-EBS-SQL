/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Tax Reserve Ledger
-- Description: Imported Oracle standard tax reserve ledger report
Source: Tax Reserve Ledger Report (XML)
Short Name: FAS480_XML
DB package: FA_FAS480_XMLP_PKG
Custom Package: XXEN_FA_FAS480_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/fa-tax-reserve-ledger/
-- Library Link: https://www.enginatics.com/reports/fa-tax-reserve-ledger/
-- Run Report: https://demo.enginatics.com/

select
 x.company_name
,x.book
,x.currency_code
,:p_period1 period
,x.fiscal_year
,x.comp_code_dsp1  "&balancing_segment_p"
,x.gl_account      "Asset Account"
,x.rsv_account     "Reserve Account"
,x.asset_number    "Asset Number - Description"
,x.start_date      "Date Placed In Service"
,x.method          "Depreciation Method"
,x.d_life          "Life Yr.Mo"
,x.cost
,x.deprn_amount    "Depreciation Amount"
,x.ytd_deprn       "YTD Depreciation"
,x.deprn_reserve   "Depreciation Reserve"
,x.t_type          "Transaction Type"
from
(
SELECT 
  fsc.Company_Name,
  fsc.book,
  fsc.Currency_Code,
  FY.FISCAL_YEAR FISCAL_YEAR,
  CB.ASSET_COST_ACCT GL_ACCOUNT,
  RSV.DEPRN_RESERVE_ACCT RSV_ACCOUNT,
  AD.ASSET_NUMBER ||' - '|| AD.DESCRIPTION ASSET_NUMBER,
  RSV.DATE_PLACED_IN_SERVICE START_DATE,
  RSV.METHOD_CODE METHOD,
  RSV.LIFE LIFE,
  RSV.RATE ADJ_RATE,
  DS.BONUS_RATE BONUS_RATE,
  RSV.CAPACITY PROD,
  ROUND(SUM(RSV.COST),:P_MIN_PRECISION) COST,
  ROUND(SUM(RSV.DEPRN_AMOUNT),:P_MIN_PRECISION) DEPRN_AMOUNT,
  ROUND(SUM(RSV.YTD_DEPRN),:P_MIN_PRECISION) YTD_DEPRN,
  ROUND(SUM(RSV.DEPRN_RESERVE),:P_MIN_PRECISION) DEPRN_RESERVE,
  RSV.TRANSACTION_TYPE T_TYPE,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('comp_code_dsp', 'SQLGL', 'GL#', dhcc.CHART_OF_ACCOUNTS_ID, NULL, dhcc.CODE_COMBINATION_ID, 'GL_BALANCING', 'Y', 'VALUE') COMP_CODE_DSP1,
  FA_FAS480_XMLP_PKG.d_lifeformula(RSV.LIFE, RSV.RATE, DS.BONUS_RATE, RSV.CAPACITY) D_LIFE
FROM 
  (
   SELECT 
     Company_Name,
     Category_Flex_Structure,
     Location_Flex_Structure,
     Asset_Key_Flex_Structure, 
     FA_FAS480_XMLP_PKG.bookformula() Book, 
     FA_FAS480_XMLP_PKG.period1_pcformula() Period1_PC, 
     FA_FAS480_XMLP_PKG.report_nameformula('&balancing_segment_p', FA_SYSTEM_CONTROLS.Company_Name) Report_Name, 
     FA_FAS480_XMLP_PKG.Accounting_Flex_Structure_p Accounting_Flex_Structure,
     FA_FAS480_XMLP_PKG.Fiscal_Year_Name_p Fiscal_Year_Name,
     FA_FAS480_XMLP_PKG.Currency_Code_p Currency_Code,
     FA_FAS480_XMLP_PKG.Book_Class_p Book_Class,
     FA_FAS480_XMLP_PKG.Distribution_Source_Book_p Distribution_Source_Book,
     FA_FAS480_XMLP_PKG.Period1_PCD_p Period1_PCD,
     FA_FAS480_XMLP_PKG.Period1_POD_p Period1_POD,
     FA_FAS480_XMLP_PKG.Period1_FY_p Period1_FY,
     FA_FAS480_XMLP_PKG.C_ERRBUF_p C_ERRBUF,
     FA_FAS480_XMLP_PKG.C_RETCODE_p C_RETCODE
    FROM   
     FA_SYSTEM_CONTROLS
  ) fsc,
  FA_DEPRN_SUMMARY DS,
  FA_ADDITIONS AD,
  FA_ASSET_HISTORY AH,
  FA_FISCAL_YEAR FY,
  FA_CATEGORY_BOOKS CB,
  GL_CODE_COMBINATIONS DHCC,
  FA_RESERVE_LEDGER_GT RSV
WHERE
  RSV.ASSET_ID = AD.ASSET_ID
  AND RSV.DH_CCID = DHCC.CODE_COMBINATION_ID
  AND DS.PERIOD_COUNTER = RSV.PERIOD_COUNTER
  AND DS.BOOK_TYPE_CODE = fsc.Book
  AND DS.ASSET_ID = RSV.ASSET_ID
  AND CB.CATEGORY_ID = AH.CATEGORY_ID
  AND CB.BOOK_TYPE_CODE = :P_Book
  AND AH.ASSET_ID = AD.ASSET_ID
  AND AH.DATE_EFFECTIVE < RSV.DATE_EFFECTIVE
  AND nvl(AH.DATE_INEFFECTIVE, SYSDATE) >= RSV.DATE_EFFECTIVE
  AND FY.FISCAL_YEAR_NAME = fsc.FISCAL_YEAR_NAME
  AND RSV.DATE_PLACED_IN_SERVICE BETWEEN FY.START_DATE AND FY.END_DATE
GROUP BY 
  fsc.Company_Name,
  fsc.book,
  fsc.Currency_Code,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('comp_code_dsp', 'SQLGL', 'GL#', dhcc.CHART_OF_ACCOUNTS_ID, NULL, dhcc.CODE_COMBINATION_ID, 'GL_BALANCING', 'Y', 'VALUE'),
  FY.FISCAL_YEAR,
  CB.ASSET_COST_ACCT,
  RSV.DEPRN_RESERVE_ACCT,
  AD.ASSET_NUMBER ||' - '|| AD.DESCRIPTION,
  RSV.DATE_PLACED_IN_SERVICE,
  RSV.METHOD_CODE,
  RSV.LIFE,
  RSV.RATE,
  DS.BONUS_RATE,
  RSV.CAPACITY,
  RSV.TRANSACTION_TYPE
ORDER BY 
  19,
  1,
  2,
  3,
  4,
  5,
  6,
  7
) x