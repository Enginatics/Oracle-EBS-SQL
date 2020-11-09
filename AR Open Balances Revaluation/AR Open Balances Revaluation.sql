/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Open Balances Revaluation
-- Description: Imported from BI Publisher
Application: Receivables
Source: AR Open Balances Revaluation Report
Short Name: AROBRR
DB package: ar_obalrev_pkg
-- Excel Examle Output: https://www.enginatics.com/example/ar-open-balances-revaluation/
-- Library Link: https://www.enginatics.com/reports/ar-open-balances-revaluation/
-- Run Report: https://demo.enginatics.com/

select 
  trx.ou_name                  "Operating Unit"
, trx.accounting_flexfield     "Accounting Flexfield"
, trx.currency_code            "Currency"
, trx.customer_name            "Trading Partner"
, trx.account_number           "Customer Number"
, trx.invoice_number           "Invoice/Receipt Number"
, trx.transaction_type         "Transaction Type"
, trx.internal_invoice_no      "Internal Invoice Number"
, trx.invoice_date             "Invoice/Receipt Date"
, trx.invoice_amt_entered      "Invoice/Receipt Amount"
, trx.inv_amt_due              "Amount Due"
, trx.orig_invoice_rate         "Exchange Rate"
, trx.inv_amt_due_er           "Open Functional Amount" 
, to_number(trx.exchange_rate)            "Revaluation Rate"
, trx.inv_amt_due_reval        "Open Revalued Amount"
, nvl(trx.inv_amt_due_reval,0) 
   - nvl(trx.inv_amt_due_er,0)  "Profit/Loss"
, nvl2(trx.exchange_rate,null,'*') "No Revaluation Rate"
from
(
SELECT hou.name                     ou_name
      ,&flex_select_all             accounting_flexfield
      ,rcta.invoice_currency_code   currency_code
      ,nvl(rcta.exchange_rate,1) orig_invoice_rate
      ,hp.party_name                customer_name	 
      ,hca.account_number 
      ,rcta.trx_number              invoice_number
	  , ''                          lookup_code 
	  , rcta.trx_date               invoice_date
	  ,rcta.doc_sequence_value      internal_invoice_no
	  ,rctt.type                    transaction_type
	  ,rcta.customer_trx_id         cust_trx_id
	   , DECODE(:p_exchange_rate_type,'User',REPLACE(:p_exchange_rate,',','.')
		        ,NVL(ar_obalrev_pkg.get_rate(rcta.invoice_currency_code),0)) 
				                    exchange_rate	  
	  ,SUM(aps.amount_due_original) invoice_amt_entered
	  ,SUM(aps.amount_due_original) test
      ,0                            invoice_amt_accounted                                 
      ,SUM(aps.amount_due_original) -   NVL(
                                             (
                                              SELECT SUM(ara.amount_applied)
                                              FROM   ar_receivable_applications ara
                                              WHERE  ara.status                  = 'APP'
                                              AND    ara.applied_customer_trx_id = rcta.customer_trx_id
                                              AND    ara.gl_date                 <= &gd_date_to),0
                                              ) +
										NVL(
                                             (
                                              SELECT SUM(ara.amount_applied)
                                              FROM   ar_receivable_applications ara
                                              WHERE  ara.status                  = 'APP'
											  AND    ara.application_type       != 'CASH'
											  AND    rctt.type                   = 'CM'
                                              AND    ara.customer_trx_id = rcta.customer_trx_id
                                              AND    ara.gl_date                 <= &gd_date_to),0
                                              ) + 
											  NVL(
                                                  (
                                                  SELECT SUM(ara.amount)
                                                    FROM ar_adjustments ara
                                                   WHERE ara.customer_trx_id = rcta.customer_trx_id
                                                   AND   ara.gl_date <= &gd_date_to),0
                                                   ) inv_amt_due
      ,  NVL(APS.exchange_rate,1) * (SUM(aps.amount_due_original) -   NVL(
                                             (
                                              SELECT SUM(ara.amount_applied)
                                              FROM   ar_receivable_applications ara
                                              WHERE  ara.status                  = 'APP'
                                              AND    ara.applied_customer_trx_id = rcta.customer_trx_id
                                              AND    ara.gl_date                 <= &gd_date_to),0
                                              ) +
										NVL(
                                             (
                                              SELECT SUM(ara.amount_applied)
                                              FROM   ar_receivable_applications ara
                                              WHERE  ara.status                  = 'APP'
											  AND    ara.application_type       != 'CASH'
											  AND    rctt.type                   = 'CM'
                                              AND    ara.customer_trx_id = rcta.customer_trx_id
                                              AND    ara.gl_date                 <= &gd_date_to),0
                                              ) + 
											  NVL(
                                                  (
                                                  SELECT SUM(ara.amount)
                                                    FROM ar_adjustments ara
                                                   WHERE ara.customer_trx_id = rcta.customer_trx_id
                                                   AND   ara.gl_date <= &gd_date_to),0
                                                   )    )  inv_amt_due_er
      ,(SUM(APS.amount_due_original) -  NVL(
                                             (
                                              SELECT SUM(ara.amount_applied)
                                              FROM   ar_receivable_applications ara
                                              WHERE  ara.status                  = 'APP'
                                              AND    ara.applied_customer_trx_id = rcta.customer_trx_id
                                              AND    ara.gl_date                 <= &gd_date_to),0
                                              ) +
										NVL(
                                             (
                                              SELECT SUM(ara.amount_applied)
                                              FROM   ar_receivable_applications ara
                                              WHERE  ara.status                  = 'APP'
											  AND    ara.application_type       != 'CASH'
											  AND    rctt.type                   = 'CM'
                                              AND    ara.customer_trx_id = rcta.customer_trx_id
                                              AND    ara.gl_date                 <= &gd_date_to),0
                                              ) +
										  NVL(
                                                   (
                                                     SELECT SUM(ARA.amount)
                                                       FROM ar_adjustments ARA
                                                      WHERE ARA.customer_trx_id = RCtA.customer_trx_id
                                                      AND   ara.gl_date <= &gd_date_to
													),0
                                                    )
		 ) * NVL(DECODE(:p_exchange_rate_type,'User',REPLACE(:p_exchange_rate,',','.')
		        ,NVL(ar_obalrev_pkg.get_rate(rcta.invoice_currency_code),0)),0) inv_amt_due_reval                            
  FROM  hr_operating_units           hou
       ,ra_customer_trx              rcta
       ,ar_payment_schedules         aps
       ,ra_cust_trx_types            rctt
       ,ra_cust_trx_line_gl_dist     rctlgd
       ,gl_code_combinations         gcc
       ,xla_distribution_links       xdl
       ,xla_ae_lines                 xal
       ,gl_import_references         gir
       ,gl_je_headers                gjh
       ,hz_cust_accounts             hca
       ,hz_parties                   hp
       ,ar_system_parameters         sp
  WHERE HOU.set_of_books_id          = sp.set_of_books_id
  AND   RCtA.customer_trx_id        = APS.customer_trx_id
  AND   RCtA.org_id                 = HOU.organization_id
  AND   APS.org_id                  = RCtA.org_id
  AND   RCtA.cust_trx_type_id       = RCTT.cust_trx_type_id
  AND   RCtA.org_id                 = RCTT.org_id
  AND   RCTLGD.org_id               = RCTT.org_id
  AND   APS.customer_trx_id         = RCTLGD.customer_trx_id
--  AND   gcc.code_combination_id     = RCTLGD.code_combination_id 
  AND   aps.gl_date                <= &gd_date_to
  AND   rctlgd.account_class        ='REC'
  AND   RCTLGD.latest_rec_flag      ='Y'
  AND   xdl.source_distribution_id_num_1 =rctlgd.cust_trx_line_gl_dist_id
  AND   xdl.SOURCE_DISTRIBUTION_TYPE = 'RA_CUST_TRX_LINE_GL_DIST_ALL'
  AND   xdl.application_id =222
  AND   xal.ae_header_id =xdl.ae_header_id
  AND   xal.ae_line_num =xdl.ae_line_num
  AND   xal.application_id =222
  AND   xal.accounting_class_code ='RECEIVABLE'
  AND   gcc.code_combination_id =xal.code_combination_id
  AND   gir.gl_sl_link_id =xal.gl_sl_link_id
  AND   gir.gl_sl_link_table =xal.gl_sl_link_table
  AND   gjh.je_header_id =gir.je_header_id 
  AND   gjh.status ='P'
  AND   gjh.ledger_id = sp.set_of_books_id
  AND   sp.org_id = :P_ORG_ID
  AND   rcta.bill_to_customer_id   = hca.cust_account_id
  AND   hp.party_id                = hca.party_id
  --AND   HCA.account_number = :P_CUSTOMER
  AND   &gc_trx_date_where1
  AND   &gc_ou_where1
  AND   &gc_customer_where1       
  AND   &gc_currency_where1
  AND   &gc_incl_domestic_inv_where1  
 GROUP BY  hou.name
      ,&flex_select_all
      ,rcta.invoice_currency_code
      ,nvl(rcta.exchange_rate,1)
      ,hp.party_name
      ,hca.account_number
      ,rcta.trx_number
	  , ''
	  , rcta.trx_date
	  ,rcta.doc_sequence_value
	  ,rctt.type
	  ,hca.cust_account_id
	   , DECODE(:p_exchange_rate_type,'User',REPLACE(:p_exchange_rate,',','.')
		        ,NVL(ar_obalrev_pkg.get_rate(rcta.invoice_currency_code),0))
	,rcta.customer_trx_id
	,   NVL(APS.exchange_rate,1)  -- added for bug 18327012
HAVING  NVL((SUM(APS.amount_due_original) -  NVL(
                                             (
                                              SELECT SUM(ara.amount_applied)
                                              FROM   ar_receivable_applications ara
                                              WHERE  ara.status                  = 'APP'
                                              AND    ara.applied_customer_trx_id = rcta.customer_trx_id
                                              AND    ara.gl_date                 <= &gd_date_to),0
                                              ) +
										NVL(
                                             (
                                              SELECT SUM(ara.amount_applied)
                                              FROM   ar_receivable_applications ara
                                              WHERE  ara.status                  = 'APP'
											  AND    ara.application_type       != 'CASH'
											  AND    rctt.type                   = 'CM'
                                              AND    ara.customer_trx_id = rcta.customer_trx_id
                                              AND    ara.gl_date                 <= &gd_date_to),0
                                              ) +
											  NVL(
                                                           (
                                                             SELECT SUM(ARA.amount)
                                                               FROM ar_adjustments ARA
                                                              WHERE ARA.customer_trx_id = RCtA.customer_trx_id
                                                              AND   ara.gl_date <= &gd_date_to),0)),0
            ) <> 0
UNION
SELECT abc.op_name                         ou_name,
  abc.accounting_flexfield                 accounting_flexfield,
  abc.currency_code                        currency_code,
  abc.orig_invoice_rate,
  hp.party_name                            customer_name,
  hca.account_number,
  abc.invoice_number                       invoice_number,
  abc.lookup_code   	                   lookup_code,
  abc.receipt_date                         invoice_date,
 abc.int_invoice_number                    internal_invoice_no,
  abc.trans_type                           transaction_type,
  abc.custid                               cust_trx_id,  
  abc.exchange_rate                        exchange_rate,  
  abc.orig_amt                        invoice_amt_entered,
  NVL(ar_obalrev_pkg.test(abc.invoice_number,abc.orig_amt),0) test,
  0                                        invoice_amt_accounted,
  0-abc.original_amount                      inv_amt_due,  
  0-abc.historic_amount                      inv_amt_due_er,
  0-abc.closing_amount                       inv_amt_due_reval
FROM
  (
SELECT hou.name op_name,
     &flex_select_all accounting_flexfield,
     hca.cust_account_id custid,     
     decode(ara.status,    'ACC',    '*' || al.meaning) trans_type,
     acr.receipt_number invoice_number,
     acr.doc_sequence_value int_invoice_number,     
     acr.receipt_date,
	 al.lookup_code,   	
     acr.amount orig_amt,
     nvl(acr.exchange_rate,    1) orig_invoice_rate,
     SUBSTR(acr.currency_code,    1,    3) currency_code,
    (SUM(nvl(ara.amount_applied,0))) original_amount,
    (SUM(nvl(acr.exchange_rate,    1) *nvl(ara.amount_applied,    0))) historic_amount,
    ((SUM(NVL(ara.amount_applied,0))) *(DECODE(:p_exchange_rate_type,'User',REPLACE(:p_exchange_rate,',','.')
		        ,NVL(ar_obalrev_pkg.get_rate(acr.currency_code),0)))) closing_amount,
	DECODE(:p_exchange_rate_type,'User',REPLACE(:p_exchange_rate,',','.')
		        ,NVL(ar_obalrev_pkg.get_rate(acr.currency_code),0)) exchange_rate
   FROM hr_operating_units hou,
     ar_receivable_applications ara,
     ar_lookups al,
     ar_cash_receipts acr,
     ar_cash_receipt_history acrh,
     hz_cust_accounts hca,
     gl_code_combinations gcc,
	 ar_distributions ads,
	 xla_distribution_links xdl,
	 xla_ae_lines xal,
	 gl_import_references  gir,
     gl_je_headers gjh,
     ar_system_parameters sp
   WHERE hou.set_of_books_id = sp.set_of_books_id
   AND acr.org_id = hou.organization_id
   AND acr.org_id = ara.org_id
   AND hca.cust_account_id = acr.pay_from_customer
   AND acr.cash_receipt_id = ara.cash_receipt_id
   AND acrh.cash_receipt_id = ara.cash_receipt_id
   AND ara.cash_receipt_history_id = acrh.cash_receipt_history_id
   AND al.lookup_type = 'PAYMENT_TYPE'
   AND ara.status = al.lookup_code
--   AND gcc.code_combination_id = ara.code_combination_id 
   --AND trate.tran_curr_code(+) = acr.currency_code
   AND ara.status = 'ACC'
   AND not exists(
   select 'X' from ar_cash_receipt_history crhin
   where crhin.cash_receipt_id = acr.cash_receipt_id
   AND crhin.status = 'REVERSED'
   )   
   AND nvl(ara.confirmed_flag,    'Y') = 'Y'
   AND nvl(acr.confirmed_flag,    'Y') = 'Y'   
   AND ads.source_id = acrh.CASH_RECEIPT_HISTORY_ID
   AND xdl.source_distribution_id_num_1 = ads.line_id
   AND xdl.application_id =222
   AND xal.ae_header_id =xdl.ae_header_id
   AND 	xal.ae_line_num =xdl.ae_line_num
   AND 	xal.application_id =222
   AND  xal.accounting_class_code ='ACC'
   AND 	gcc.code_combination_id =xal.code_combination_id
   AND  gir.gl_sl_link_id =xal.gl_sl_link_id
   AND 	gir.gl_sl_link_table =xal.gl_sl_link_table
   AND 	gjh.je_header_id =gir.je_header_id
   AND  gjh.ledger_id = sp.set_of_books_id
   AND sp.org_id = :P_ORG_ID
   AND 	gjh.status ='P'
   AND &gc_trx_date_where
   AND &gc_incl_domestic_inv_where
   AND &gc_customer_where
   AND &gc_currency_where
   AND &gc_ou_where
  GROUP BY hou.name,
     &flex_select_all,
     hca.cust_account_id,
     decode(ara.status,    'ACC',    '*' || al.meaning),
     acr.receipt_number,
     acr.doc_sequence_value,     
     acr.receipt_date,al.lookup_code,
	 acr.amount,
     nvl(acr.exchange_rate,    1),
     SUBSTR(acr.currency_code,    1,    3),
     acr.currency_code HAVING SUM(ara.amount_applied) <> 0
   UNION
   SELECT hou.name op_name,
     &flex_select_all accounting_flexfield,
     hca.cust_account_id custid,
     decode(ara.status,    'UNAPP',    '*' || al.meaning) trans_type,
     acr.receipt_number invoice_number,
     acr.doc_sequence_value int_invoice_number,     
     acr.receipt_date,
	 al.lookup_code ,  	
     acr.amount orig_amt,
     nvl(acr.exchange_rate,    1) orig_invoice_rate,
     SUBSTR(acr.currency_code,    1,    3) currency_code,
    (SUM(ara.amount_applied)) original_amount,
    (SUM(nvl(acr.exchange_rate,    1) *nvl(ara.amount_applied,    0))) historic_amount,
    (SUM(ara.amount_applied)) *(DECODE(:p_exchange_rate_type,'User',REPLACE(:p_exchange_rate,',','.')
		        ,NVL(ar_obalrev_pkg.get_rate(acr.currency_code),0))) closing_amount,
    DECODE(:p_exchange_rate_type,'User',REPLACE(:p_exchange_rate,',','.')
		        ,NVL(ar_obalrev_pkg.get_rate(acr.currency_code),0)) exchange_rate
   FROM hr_operating_units hou,
     ar_receivable_applications ara,
     ar_lookups al,
     ar_cash_receipts acr,
     ar_cash_receipt_history acrh,
     hz_cust_accounts hca,
     gl_code_combinations gcc,	 
	 ar_distributions ads,
	 xla_distribution_links xdl,
	 xla_ae_lines xal,
     gl_import_references  gir,
     gl_je_headers gjh,
     ar_system_parameters sp
   WHERE hou.set_of_books_id = sp.set_of_books_id
   AND acr.org_id = hou.organization_id
   AND acr.org_id = ara.org_id
   AND hca.cust_account_id = acr.pay_from_customer
   AND acr.cash_receipt_id = ara.cash_receipt_id
   AND acrh.cash_receipt_id = ara.cash_receipt_id
   AND ara.cash_receipt_history_id = acrh.cash_receipt_history_id
   AND al.lookup_type = 'PAYMENT_TYPE'
   AND ara.status = al.lookup_code
--   AND gcc.code_combination_id = ara.code_combination_id
   AND ara.status = 'UNAPP'
   AND nvl(ara.confirmed_flag,    'Y') = 'Y'
   AND nvl(acr.confirmed_flag,    'Y') = 'Y'   
   AND ads.source_id = acrh.cash_receipt_history_id
   AND xdl.source_distribution_id_num_1 = ads.line_id
   AND xdl.application_id =222
   AND xal.ae_header_id =xdl.ae_header_id
   AND 	xal.ae_line_num =xdl.ae_line_num
   AND 	xal.application_id =222
   AND  xal.accounting_class_code ='UNAPP'
    AND ads.source_type <> 'BANK_CHARGES'     -- added to exclude Bank Charges 18327012
	AND ads.source_table='CRH'               -- added to exclude Bank Charges 18327012
	AND xdl.SOURCE_DISTRIBUTION_TYPE='AR_DISTRIBUTIONS_ALL'  --for bug  18327012
 AND 	gcc.code_combination_id =xal.code_combination_id
   AND  gir.gl_sl_link_id =xal.gl_sl_link_id
   AND 	gir.gl_sl_link_table =xal.gl_sl_link_table
   AND 	gjh.je_header_id =gir.je_header_id
   AND  gjh.ledger_id = sp.set_of_books_id
   AND  sp.org_id = :P_ORG_ID
   AND 	gjh.status ='P'
   AND not exists(
   select 'X' from ar_cash_receipt_history crhin
   where crhin.cash_receipt_id = acr.cash_receipt_id
   AND crhin.status = 'REVERSED'
   )
   AND &gc_trx_date_where
   AND &gc_incl_domestic_inv_where
   AND &gc_customer_where
   AND &gc_currency_where
   AND &gc_ou_where
  GROUP BY hou.name,
     &flex_select_all,
     hca.cust_account_id,
     decode(ara.status,    'UNAPP',    '*' || al.meaning),
     acr.receipt_number,
     acr.doc_sequence_value,     
     acr.receipt_date,al.lookup_code,
	 acr.amount,
     nvl(acr.exchange_rate,    1),
     SUBSTR(acr.currency_code,    1,    3),
     acr.currency_code HAVING SUM(ara.amount_applied) <> 0)
abc,
  hz_cust_accounts hca,
  hz_parties hp
WHERE hca.party_id = hp.party_id
 AND hca.cust_account_id = abc.custid
 AND &gc_customer_where1
) trx
ORDER BY 
  trx.ou_name
, trx.accounting_flexfield
, trx.currency_code
, trx.customer_name
, trx.invoice_number