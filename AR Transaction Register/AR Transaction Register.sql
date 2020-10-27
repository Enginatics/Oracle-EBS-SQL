/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Transaction Register
-- Description: Application: Receivables
Source: Transaction Register
Short Name: ARRXINVR
-- Excel Examle Output: https://www.enginatics.com/example/ar-transaction-register/
-- Library Link: https://www.enginatics.com/reports/ar-transaction-register/
-- Run Report: https://demo.enginatics.com/

SELECT
  RX.ORGANIZATION_NAME                   Ledger,
  RX.REC_POSTABLE_FLAG                   Postable,
  RX.REC_BALANCE                         "&bal_segment_p",
  RX.REC_BALANCE_DESC                    "&bal_segment_d",
  RX.TRX_CURRENCY                        Currency,
  ARPT_SQL_FUNC_UTIL.get_lookup_meaning('INV/CM',TRX_TYPES.TYPE) Class,
  RX.TRX_NUMBER                          Invoice_Number,
  RX.DOC_SEQUENCE_VALUE                  Document_Number,
  TRX_TYPES.NAME                         "Type",
  SUBSTRB(BILL_TO_PARTY.PARTY_NAME,1,50) Customer_Name,
  BILL_TO.ACCOUNT_NUMBER                 Customer_Number,
  BILL_TO_SITE.LOCATION                  Customer_Site,
  RX.TRX_DATE                            Invoice_date,
  RX.RECEIVABLES_GL_DATE                 GL_Date,
  RX.TRX_AMOUNT                          Entered_Amount,
  RX.TRX_ACCTD_AMOUNT                    Functional_Amount,
--
  RX.REC_NATACCT                         Receivables_Account,
  RX.REC_NATACCT_DESC                    Receivables_Account_Desc,
  RX.REC_ACCOUNT                         Receivables_Account_Full,
  RX.REC_ACCOUNT_DESC                    Receivables_Account_Full_Desc,
  RX.FUNCTIONAL_CURRENCY_CODE            Functional_Currency,
  RX.EXCHANGE_TYPE                       Exchange_Rate_Type,
  RX.EXCHANGE_DATE                       Exchange_Rate_Date,
  RX.EXCHANGE_RATE                       Exchange_Rate,
  TERMS.NAME                             Payment_Terms,
  RX.TRX_DUE_DATE                        Invoice_Due_Date,
  METHODS.NAME                           Payment_Method,
  ARPT_SQL_FUNC_UTIL.get_lookup_meaning('YES/NO', NVL(BILL_TO_SITE.TAX_HEADER_LEVEL_FLAG, NVL(BILL_TO.TAX_HEADER_LEVEL_FLAG, RX.TAX_HEADER_LEVEL_FLAG))) Tax_Calculation_Level,
  BAS.NAME                               Batch_Source,
  BA.NAME                                Batch_Name,
  RX.CONS_BILL_NUMBER                    Consolidated_Bill_Number,
  DOC_SEQ.NAME                           Document_Sequence_Name,
  SUBSTRB(SHIP_TO_PARTY.PARTY_NAME,1,50) Ship_To_Customer_Name,
  SHIP_TO.ACCOUNT_NUMBER                 Ship_To_Customer_Number,
  SHIP_TO_SITE.LOCATION                  Ship_To_Customer_site
FROM
  AR_TRANSACTIONS_REP_ITF RX,
  RA_TERMS TERMS,
  FND_DOCUMENT_SEQUENCES DOC_SEQ,
  HZ_CUST_ACCOUNTS SHIP_TO,
  HZ_PARTIES SHIP_TO_PARTY,
  HZ_CUST_ACCOUNTS BILL_TO,
  HZ_PARTIES BILL_TO_PARTY,
  HZ_CUST_SITE_USES_all SHIP_TO_SITE,
  HZ_CUST_SITE_USES_all BILL_TO_SITE,
  RA_CUST_TRX_TYPES_all TRX_TYPES,
  AR_RECEIPT_METHODS METHODS,
  RA_BATCHES_ALL BA,
  RA_BATCH_SOURCES_ALL BAS
WHERE
  RX.SHIP_TO_CUSTOMER_ID = SHIP_TO.CUST_ACCOUNT_ID(+)
  AND SHIP_TO.PARTY_ID = SHIP_TO_PARTY.PARTY_ID(+)
  AND RX.SHIP_TO_SITE_USE_ID = SHIP_TO_SITE.SITE_USE_ID(+)
  AND RX.BILL_TO_CUSTOMER_ID = BILL_TO.CUST_ACCOUNT_ID
  AND BILL_TO.PARTY_ID = BILL_TO_PARTY.PARTY_ID
  AND RX.BILL_TO_SITE_USE_ID = BILL_TO_SITE.SITE_USE_ID
  AND RX.CUST_TRX_TYPE_ID = TRX_TYPES.CUST_TRX_TYPE_ID
  AND RX.TERM_ID = TERMS.TERM_ID(+)
  AND RX.DOC_SEQUENCE_ID = DOC_SEQ.DOC_SEQUENCE_ID(+)
  AND RX.RECEIPT_METHOD_ID = METHODS.RECEIPT_METHOD_ID(+)
  AND NVL(RX.ORG_ID, -99) = NVL(TRX_TYPES.ORG_ID, -99)
  AND RX.BATCH_ID = BA.BATCH_ID(+)
  AND RX.BATCH_SOURCE_ID = BAS.BATCH_SOURCE_ID(+)
  AND NVL(RX.ORG_ID, -99) = NVL(BAS.ORG_ID, -99)
 AND RX.REQUEST_ID = FND_GLOBAL.CONC_REQUEST_ID
ORDER BY
  RX.ORGANIZATION_NAME,
  RX.REC_POSTABLE_FLAG,
  RX.REC_BALANCE,
  RX.TRX_CURRENCY,
  ARPT_SQL_FUNC_UTIL.get_lookup_meaning('INV/CM',TRX_TYPES.TYPE),
  RX.TRX_NUMBER,
  RX.DOC_SEQUENCE_VALUE