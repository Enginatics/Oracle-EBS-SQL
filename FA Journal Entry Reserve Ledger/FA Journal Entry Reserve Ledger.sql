/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Journal Entry Reserve Ledger
-- Description: Imported Oracle standard journal entry reserve ledger report
Source: Journal Entry Reserve Ledger Report (XML)
Short Name: FAS400_XML
DB package: FA_FAS400_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/fa-journal-entry-reserve-ledger/
-- Library Link: https://www.enginatics.com/reports/fa-journal-entry-reserve-ledger/
-- Run Report: https://demo.enginatics.com/

select 
  x.company_name    company
, x.book                     book
, x.Currency_Code     currency
, x.period1                 period
, x.comp_code          "&balancing_segment_p"
, x.gl_account           "Expense Accout"
, x.rsv_account         "Reserve Account"
, x.cost_center         "&cost_center_p"
, x.asset_number      "Asset - Description"
, x.start_date            "Date Placed In Service"
, x.method                "Deprn Method"
, x.d_life                    "Life Yr.Mo" 
,x.cost
,x.deprn_amount    "Depreciation Amount"
,x.ytd_deprn            "YTD Depreciation"
,x.deprn_reserve   "Depreciation Reserve"
,x.percent
,x.t_type      "Transaction Type"
from
(
SELECT 
  fsc.Company_Name,
  fsc.book,
  fsc.Currency_Code,
  fsc.period1,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'GL_BALANCING', 'Y', 'VALUE') COMP_CODE,
  decode(TRANSACTION_TYPE,'B',RSV.RESERVE_ACCT, fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'GL_ACCOUNT', 'Y', 'VALUE') ) GL_ACCOUNT,
  RSV.DEPRN_RESERVE_ACCT RSV_ACCOUNT,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE') COST_CENTER,
  AD.ASSET_NUMBER || '-' || AD.DESCRIPTION ASSET_NUMBER,
  DATE_PLACED_IN_SERVICE START_DATE,
  METHOD_CODE METHOD,
  RSV.LIFE LIFE,
  RSV.RATE ADJ_RATE,
  DS.BONUS_RATE BONUS_RATE,
  RSV.CAPACITY PROD,
  SUM(decode(transaction_type,'B',NULL,COST)) COST,
  SUM(RSV.DEPRN_AMOUNT) DEPRN_AMOUNT,
  SUM(RSV.YTD_DEPRN) YTD_DEPRN,
  SUM(RSV.DEPRN_RESERVE) DEPRN_RESERVE,
  sum(decode(transaction_type,'B',NULL,nvl(PERCENT,0))) PERCENT,
  TRANSACTION_TYPE T_TYPE,
  FA_FAS400_XMLP_PKG.d_lifeformula(RSV.LIFE, RSV.RATE, DS.BONUS_RATE, RSV.CAPACITY) D_LIFE
FROM 
  (
    SELECT Company_Name,
                 Category_Flex_Structure,
                 Location_Flex_Structure,
                 Asset_Key_Flex_Structure,
                 'P' a_partial_retirement,
                 'F' a_full_retirement,
                 'T' a_transfer_out,
                 'N' a_non_depreciate,
                 'R' a_reclass,
                 'B' a_bonus, 
    	FA_FAS400_XMLP_PKG.bookformula() Book, 
    	FA_FAS400_XMLP_PKG.period1formula() Period1, 
    	FA_FAS400_XMLP_PKG.report_nameformula() Report_Name,
       '&c_do_insertformula'    c_do_insertformula,
    	FA_FAS400_XMLP_PKG.Accounting_Flex_Structure_p Accounting_Flex_Structure,
    	FA_FAS400_XMLP_PKG.Currency_Code_p Currency_Code,
    	FA_FAS400_XMLP_PKG.Book_Class_p Book_Class,
    	FA_FAS400_XMLP_PKG.Distribution_Source_Book_p Distribution_Source_Book,
    	FA_FAS400_XMLP_PKG.Period1_PC_p Period1_PC,
    	FA_FAS400_XMLP_PKG.Period1_PCD_p Period1_PCD,
    	FA_FAS400_XMLP_PKG.Period1_POD_p Period1_POD,
    	FA_FAS400_XMLP_PKG.Period1_FY_p Period1_FY,
    	FA_FAS400_XMLP_PKG.Period_Closed_p Period_Closed
FROM   FA_SYSTEM_CONTROLS
  ) FSC,
  FA_RESERVE_LEDGER_GT RSV,
  FA_ADDITIONS AD,
  GL_CODE_COMBINATIONS CC,
  &lp_fa_deprn_summary DS
WHERE
  RSV.ASSET_ID = AD.ASSET_ID
  AND RSV.DH_CCID = CC.CODE_COMBINATION_ID
  AND DS.PERIOD_COUNTER (+) = RSV.PERIOD_COUNTER
  AND DS.BOOK_TYPE_CODE (+) = :P_Book
  AND DS.ASSET_ID (+) = RSV.ASSET_ID 
  AND 1=1
GROUP BY 
  fsc.Company_Name,
  fsc.book,
  fsc.Currency_Code,
  fsc.period1,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'GL_BALANCING', 'Y', 'VALUE'),
  decode(transaction_type,'B', RSV.RESERVE_ACCT,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_acct_seg', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'GL_ACCOUNT', 'Y', 'VALUE')),
  RSV.DEPRN_RESERVE_ACCT,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_cost_seg', 'SQLGL', 'GL#', cc.CHART_OF_ACCOUNTS_ID, NULL, cc.CODE_COMBINATION_ID, 'FA_COST_CTR', 'Y', 'VALUE'),
  AD.ASSET_NUMBER,
  AD.DESCRIPTION,
  DATE_PLACED_IN_SERVICE,
  METHOD_CODE,
  RSV.LIFE,
  RSV.RATE,
  RSV.CAPACITY,
  DS.BONUS_RATE,
  TRANSACTION_TYPE
ORDER BY 
  1,2,3,4,5,6,7,8,9,10,11,13,14,15,12,16,17,18,19,20,21
) x