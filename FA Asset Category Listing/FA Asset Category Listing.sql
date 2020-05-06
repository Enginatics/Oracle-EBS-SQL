/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: FA Asset Category Listing
-- Description: Application: Assets
Source: Asset Category Listing (XML) 
Short Name: FAS750_XML
DB package: FA_FAS750_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/fa-asset-category-listing/
-- Library Link: https://www.enginatics.com/reports/fa-asset-category-listing/
-- Run Report: https://demo.enginatics.com/

SELECT
        &CAT_FLEX_ALL_SEG	CAT_ALL,
        CB.BOOK_TYPE_CODE                       BOOK,
        CB.ASSET_COST_ACCT                      A_ACCOUNT,
        CB.DEPRN_RESERVE_ACCT                   R_ACCOUNT,
        CB.DEPRN_EXPENSE_ACCT                   E_ACCOUNT,
        CBD.DEPRN_METHOD                        METHOD,
        CBD.LIFE_IN_MONTHS                      LIFE,
        CBD.PRODUCTION_CAPACITY	PROD,
        CBD.BASIC_RATE		BASIC_RATE,
        CBD.ADJUSTED_RATE		ADJ_RATE,
        CBD.PRORATE_CONVENTION_CODE             CONVENTION,
        decode(CBD.USE_ITC_CEILINGS_FLAG, 'NO',
               decode(CBD.CEILING_NAME, NULL, 'NO', 'YES'), 'YES')
                                                CEIL,
        CBD.PRICE_INDEX_NAME                    PRICE_INDEX, 
	fnd_flex_xml_publisher_apis.process_kff_combination_1('c_cat_all', 'OFA', 'CAT#', 101, NULL, cat.CATEGORY_ID, 'ALL', 'Y', 'VALUE') C_CAT_ALL, 
	FA_FAS750_XMLP_PKG.d_lifeformula(CBD.LIFE_IN_MONTHS, CBD.ADJUSTED_RATE, CBD.PRODUCTION_CAPACITY) D_LIFE
FROM
        FA_CATEGORIES                           CAT,
        FA_SYSTEM_CONTROLS                      SC,
        FA_CATEGORY_BOOKS                       CB,
               FA_CATEGORY_BOOK_DEFAULTS               CBD
WHERE
        CBD.CATEGORY_ID                 = CB.CATEGORY_ID
AND     CBD.BOOK_TYPE_CODE              = CB.BOOK_TYPE_CODE
AND     CAT.CATEGORY_ID                 = CB.CATEGORY_ID
AND     CB.BOOK_TYPE_CODE = :P_BOOK 
ORDER BY
         CB.BOOK_TYPE_CODE,
         &CAT_FLEX_ALL_SEG
