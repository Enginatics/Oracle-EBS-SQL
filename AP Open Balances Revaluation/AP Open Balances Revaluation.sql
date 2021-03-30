/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Open Balances Revaluation
-- Description: Imported from BI Publisher
Application: Payables
Source: AP Open Balances Revaluation Report
Short Name: APOBRR
DB package: AP_OPEN_BAL_REV_RPT_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ap-open-balances-revaluation/
-- Library Link: https://www.enginatics.com/reports/ap-open-balances-revaluation/
-- Run Report: https://demo.enginatics.com/

with
 inv as
    (
      SELECT  /*+ leading(ai) index(ai AP_INVOICES_N3) */ 
        HOU.name ou_name,
        &FLEX_SELECT_ALL accounts,
        AI.invoice_currency_code transaction_currency,
        AS1.vendor_name supplier_name,
        AS1.segment1    supplier_number,
        AI.invoice_id invoice_id_tag,
        AI.invoice_num invoice_number,
        AI.invoice_date invoice_date,
        NVL(AI.exchange_rate,1) inv_exch_rate,
        NVL(AI.doc_sequence_value,AI.voucher_num) internal_inv_number,
        AI.Invoice_type_lookup_code transaction_type,
        NVL(DECODE( :p_exchange_rate_type, 'User', REPLACE(:p_exchange_rate,',','.') , ap_open_bal_rev_rpt_pkg.exch_rate_calc( AI.invoice_currency_code ) ),0) exchange_rate,
        DECODE(AI.Invoice_type_lookup_code,'PREPAYMENT' ,-1*(NVL(SUM(NVL(XdL.unrounded_entered_cr,0))-SUM(NVL(XdL.unrounded_entered_dr,0)),0)) ,NVL(SUM(NVL(XdL.unrounded_entered_cr,0))-SUM(NVL(XdL.unrounded_entered_dr,0)),0)) invoice_amt_entered,
        DECODE(AI.Invoice_type_lookup_code,'PREPAYMENT' ,-1*(NVL(SUM(NVL(XdL.unrounded_accounted_cr,0))-SUM(NVL(XdL.unrounded_accounted_dr,0)),0)) ,NVL(SUM(NVL(XdL.unrounded_accounted_cr,0))-SUM(NVL(XdL.unrounded_accounted_dr,0)),0)) invoice_amt_accounted
      FROM 
        ap_invoices AI,
        ap_invoice_distributions AID,
        hr_all_organization_units HOU, --xxecl
        ap_suppliers AS1,
        xla_distribution_links XDL,
        xla_ae_lines XAL,
        gl_import_references GIR,
        gl_je_headers GJH,
        gl_code_combinations GCC
      WHERE
        AS1.vendor_id =AI.vendor_id
        AND AID.invoice_id =AI.invoice_id
        AND AI.payment_status_flag in ('N','P') --xxecl
        AND HOU.organization_id =AI.org_id
        AND XDL.event_id =AID.accounting_event_id
        AND XDL.source_distribution_id_num_1 = AID.invoice_distribution_id
        AND XDL.application_id =200 
        AND XDL.source_distribution_type IN ('AP_PREPAY','AP_INV_DIST','AP_PMT_DIST') --xxecl
      --AND     XDL.rounding_class_code = 'LIABILITY'
        AND XDL.rounding_class_code = DECODE(ai.Invoice_type_lookup_code ,'PREPAYMENT', 'PREPAID_EXPENSE','LIABILITY')
        AND XAL.ae_header_id =XDL.ae_header_id
        AND XAL.ae_line_num =XDL.ae_line_num
        AND XAL.ledger_id =AI.set_of_books_id
        AND XAL.application_id =200 
      --AND     XAL.accounting_class_code   ='LIABILITY'
        AND GCC.code_combination_id =XAL.code_combination_id
        AND GIR.gl_sl_link_id =XAL.gl_sl_link_id
        AND GIR.gl_sl_link_table =XAL.gl_sl_link_table
        AND GJH.je_header_id =GIR.je_header_id
        AND GJH.status ='P'
        AND GJH.ledger_id = &gc_ledger_id
        AND XAL.ACCOUNTING_DATE <= :P_AS_OF_DATE &gc_ou_where &gc_currency &gc_include_dom_inv &gc_supplier 
      GROUP BY 
        HOU.name,
        gcc.CHART_OF_ACCOUNTS_ID,
        gcc.CODE_COMBINATION_ID,
        &FLEX_SELECT_ALL,
        AI.invoice_currency_code,
        AS1.vendor_name,
        AS1.segment1,
        AI.invoice_id,
        AI.invoice_num,
        AI.invoice_date,
        AI.Invoice_type_lookup_code,
        NVL(AI.doc_sequence_value,AI.voucher_num),
        NVL(AI.exchange_rate,1),
        NVL(DECODE( :p_exchange_rate_type, 'User', REPLACE(:p_exchange_rate,',','.') , ap_open_bal_rev_rpt_pkg.exch_rate_calc( AI.invoice_currency_code ) ),0)
    )
,payables1 as
	(
    SELECT
	    aia.invoice_id  
	  , NVL(sum(nvl(XAL.entered_dr,0))-sum(nvl(XAL.entered_cr,0)),0)     pay_inv_amt_due1 
    , NVL(sum(nvl(XAL.accounted_dr,0))-sum(nvl(XAL.accounted_cr,0)),0)   pay_inv_amt_due_er1 
    FROM
     ap_invoices                   aia 
    ,ap_invoice_payments           aip  --xxecl
    ,ap_payment_hist_dists         aphd --xxecl
    ,xla_distribution_links        xdl
    ,xla_events                    xe
    ,xla_ae_lines                  xal
    ,gl_import_references 		     gir
    ,gl_je_headers        		     gjh
    WHERE   aia.invoice_type_lookup_code    NOT IN ('PREPAYMENT')
    AND     aia.payment_status_flag             <> 'Y'
    AND     aia.invoice_id                       = aip.invoice_id -- xxecl
    AND     aip.invoice_payment_id               = aphd.invoice_payment_id --xxecl
    --
    AND     xdl.application_id                   = 200
    AND     xdl.source_distribution_type         = 'AP_PMT_DIST'
    AND     xdl.source_distribution_id_num_1     = aphd.payment_hist_dist_id -- xxecl
    AND     xdl.event_id                         = aphd.accounting_event_id -- xxecl
    AND     xdl.applied_to_entity_code           = 'AP_INVOICES'
    AND     xdl.applied_to_source_id_num_1	     = aia.invoice_id
    --
    AND     xe.application_id                    = 200
    AND     xe.event_id                          = xdl.event_id
    --
    AND 	  xal.ae_header_id					           = xdl.ae_header_id 
    AND 	  xal.ae_line_num						           = xdl.ae_line_num 
    AND 	  xal.application_id					         = 200 
    AND     xal.accounting_class_code   		     = 'LIABILITY' 
    --
    AND 	  gir.gl_sl_link_id					           = xal.gl_sl_link_id 
    AND 	  gir.gl_sl_link_table				         = xal.gl_sl_link_table 
    AND 	  gjh.je_header_id					           = gir.je_header_id 
    AND 	  gjh.status							             = 'P'
    AND     gjh.ledger_id                        = &gc_ledger_id
    AND     xal.accounting_date                 <= :P_AS_OF_DATE
    group by
      aia.invoice_id
   )
,payables2 as
  (
    SELECT  
      ai.invoice_id
    , NVL(SUM(NVL(xdl.unrounded_entered_dr,0)-NVL(xal.unrounded_entered_cr,0)),0)      pay_inv_amt_due2
    , NVL(SUM(NVL(xdl.unrounded_accounted_dr,0)-NVL(xdl.unrounded_accounted_cr,0)),0)      pay_inv_amt_due_er2 
    FROM 
      ap_invoices                  ai
    , ap_invoice_distributions     aid
    , ap_invoice_distributions     aidpre
    , ap_invoices                  aipre
    , ap_prepay_app_dists          apad -- xxecl
    , xla_events                   xe
    , xla_distribution_links       xdl
    , xla_ae_lines                 xal
    , gl_import_references 		     gir
  	, gl_je_headers        		     gjh
    , gl_code_combinations         gcc
    WHERE
           ai.payment_status_flag          <> 'Y'
    AND    aid.invoice_id                   = ai.invoice_id
    AND    aid.line_type_lookup_code        = 'PREPAY' -- xxecl
    AND    aidpre.invoice_distribution_id   = aid.prepay_distribution_id
    AND    aidpre.line_type_lookup_code     = 'ITEM'
    AND    aipre.invoice_id                 = aidpre.invoice_id
    --
    AND    apad.prepay_app_distribution_id  = aid.invoice_distribution_id
    AND    apad.accounting_event_id         = aid.accounting_event_id
    --
    AND    xe.application_id                = 200
    AND    xe.event_id                      = aid.accounting_event_id --xxecl chg from xld.event_id
    AND    xe.event_type_code              IN ('PREPAYMENT UNAPPLIED','PREPAYMENT APPLIED')
    --
    AND    xdl.application_id               = 200
    AND    xdl.event_id                     = aid.accounting_event_id
    AND    xdl.source_distribution_type     = 'AP_PREPAY' --xxecl
    AND    xdl.source_distribution_id_num_1 = apad.prepay_app_dist_id --xxecl
    --
    AND    xal.ae_header_id                 = xdl.ae_header_id
    AND    xal.ae_line_num                  = xdl.ae_line_num
    AND    xal.application_id               = 200
    AND    xal.accounting_class_code        = 'LIABILITY'
    --
    AND 	 gcc.code_combination_id		      = xal.code_combination_id
    AND 	 gir.gl_sl_link_id			          = xal.gl_sl_link_id
    AND 	 gir.gl_sl_link_table		          = xal.gl_sl_link_table
    AND 	 gjh.je_header_id			            = gir.je_header_id
    AND 	 gjh.status					              = 'P'
    AND    gjh.ledger_id                    = &gc_ledger_id
    AND    xal.accounting_date	           <= :P_AS_OF_DATE
    group by
      ai.invoice_id
  )
,payables3 as 
  (
    SELECT  
      ai.invoice_id
    , NVL(sum(NVL(xdl.unrounded_ENTERED_cR,0)-NVL(xdl.unrounded_entered_dr,0)),0)                  pay_inv_amt_due3
    , NVL(sum(NVL(xdl.unrounded_accounted_cr,0)-NVL(xdl.unrounded_accounted_dr,0)),0)              pay_inv_amt_due_er3
    FROM
      ap_invoices              ai 
    , ap_invoice_distributions aid
    , ap_invoice_distributions aidinv
    , ap_invoices              aiinv
    , ap_prepay_app_dists      apad -- xxecl
    , xla_events               xe
    , xla_distribution_links   xdl
    , xla_ae_lines             xal
    , gl_import_references 		 gir
  	, gl_je_headers        		 gjh
  WHERE
           ai.payment_status_flag          <> 'Y'
    AND    aid.invoice_id                   = ai.invoice_id
    AND    aid.line_type_lookup_code        = 'ITEM'
    AND    aidinv.prepay_distribution_id    = aid.invoice_distribution_id
    AND    aidinv.line_type_lookup_code     = 'PREPAY' -- xxecl
    AND    aiinv.invoice_id                 = aidinv.invoice_id
    --
    AND    apad.prepay_app_distribution_id  = aidinv.invoice_distribution_id
    AND    apad.accounting_event_id         = aidinv.accounting_event_id
    --
    AND    xe.event_type_code              IN ('PREPAYMENT APPLIED','PREPAYMENT UNAPPLIED')
    AND    xe.application_id                = 200
    AND    xe.event_id                      = aidinv.accounting_event_id -- xxecl chg from xdl.event_id
    --
    AND    xdl.application_id               = 200
    AND    xdl.event_id                     = aidinv.accounting_event_id
    AND    xdl.source_distribution_type     = 'AP_PREPAY' --xxecl
    AND    xdl.source_distribution_id_num_1 = apad.prepay_app_dist_id --xxecl
    --
    AND    xal.ae_header_id                 = xdl.ae_header_id
    AND    xal.ae_line_num                  = xdl.ae_line_num
    AND    xal.accounting_class_code        = 'PREPAID_EXPENSE'
    AND    xal.application_id               = 200
    AND 	 gir.gl_sl_link_id					      = xal.gl_sl_link_id 
    AND 	 gir.gl_sl_link_table				      = xal.gl_sl_link_table 
    AND 	 gjh.je_header_id					        = gir.je_header_id 
    AND 	 gjh.status							          = 'P'
    AND    gjh.ledger_id                    = &gc_ledger_id
    AND    xal.accounting_date				     <= :P_AS_OF_DATE
    group by
      ai.invoice_id
  	)
,payables4 as 
  (
    SELECT
      ai.invoice_id
    , NVL(SUM(NVL(XDL.UNROUNDED_entered_dr,0))-SUM(NVL(XAL.UNROUNDED_entered_cr,0)),0)     pay_inv_amt_due4
    , NVL(SUM(NVL(XDL.UNROUNDED_accounted_dr,0))-SUM(NVL(XAL.UNROUNDED_accounted_cr,0)),0) pay_inv_amt_due_er4
    FROM
  		ap_invoices                   ai
  	, ap_invoice_distributions      aid
  	, xla_distribution_links 	      xdl
  	, xla_ae_lines 				          xal
  	, gl_import_references 		      gir
  	, gl_je_headers        		      gjh
  	, gl_code_combinations 		      gcc
    WHERE
        ai.invoice_type_lookup_code      = 'PREPAYMENT'
    and ai.payment_status_flag          <> 'Y'
    and aid.invoice_id                   = ai.invoice_id
    and xdl.event_id	                   = aid.accounting_event_id
    and xdl.source_distribution_type     = 'AP_INV_DIST' --xxecl
    and xdl.source_distribution_id_num_1 = aid.invoice_distribution_id
    and xdl.application_id			         = 200
    and xdl.rounding_class_code         in ('RTAX','NRTAX')
    and xal.ae_header_id			           = xdl.ae_header_id
    and xal.ae_line_num                  = xdl.ae_line_num
    and xal.ledger_id                    = ai.set_of_books_id
    and xal.application_id               = 200
    and gcc.code_combination_id          = xal.code_combination_id
    and gir.gl_sl_link_id                = xal.gl_sl_link_id
    and gir.gl_sl_link_table             = xal.gl_sl_link_table
    and gjh.je_header_id                 = gir.je_header_id
    and gjh.status                       = 'P'
    and gjh.ledger_id                    = &gc_ledger_id
    and xal.accounting_date             <= :P_AS_OF_DATE
    group by
      ai.invoice_id
     )
,payables5 as
  (
    SELECT 
     aia.invoice_id
    , SUM(NVL(xdl.unrounded_entered_dr,0)-NVL(xdl.unrounded_entered_cr,0))     prepay_entered_dr1
    , SUM(NVL(xdl.unrounded_accounted_dr,0)-NVL(xdl.unrounded_accounted_cr,0)) prepay_accounted_dr1
    FROM 
      ap_invoices                aia
    , ap_invoice_payments        aip
    , ap_checks                  ac
    , ap_lookup_codes            alc
    , xla_events                 xe
    , xla_distribution_links     xdl
    , xla_ae_lines               xal
    , gl_import_references       gir
    , gl_je_headers              gjh
    , gl_code_combinations       gcc
    WHERE   
            aia.invoice_type_lookup_code  IN ('PREPAYMENT')
    AND     aia.payment_status_flag       <> 'Y'
    AND     aia.invoice_id                 = aip.invoice_id
    AND     ac.check_id                    = aip.check_id
    AND     alc.lookup_type                = 'PAYMENT TYPE' 
    AND     alc.lookup_code                = ac.payment_type_flag 
    --
    AND     xe.application_id              = 200
    AND     xe.event_id                    = aip.accounting_event_id
    --
    AND     xdl.application_id             = 200
    AND     xdl.event_id                   = aip.accounting_event_id -- xxecl chg from xe.event_id
    AND     xdl.source_distribution_type   = 'AP_PMT_DIST'			 			 
    AND     xdl.applied_to_source_id_num_1 = aia.invoice_id
    AND     xdl.applied_to_entity_code     = 'AP_INVOICES'
    --
    AND     xal.application_id             = 200 
    AND     xal.ae_header_id               = xdl.ae_header_id
    AND     xal.ae_line_num                = xdl.ae_line_num
    AND     xal.accounting_class_code      = 'LIABILITY'
    --
    and     gcc.code_combination_id        = xal.code_combination_id
    and     gir.gl_sl_link_id              = xal.gl_sl_link_id
    and     gir.gl_sl_link_table           = xal.gl_sl_link_table
    and     gjh.je_header_id               = gir.je_header_id
    and     gjh.status                     = 'P'
    and     gjh.ledger_id                  = &gc_ledger_id
    and     gjh.ledger_id                  = &gc_ledger_id
    and     xal.accounting_date           <= :P_AS_OF_DATE
    group by
      aia.invoice_id
  ) 
,payables6 as
  ( 
    SELECT  
      aid.parent_invoice_id 
    , NVL(SUM(xdl.unrounded_entered_dr),0)-NVL(SUM(xdl.unrounded_entered_cr),0) inv_cm_amt_due 
    , NVL(SUM(xdl.unrounded_accounted_dr),0)-NVL(SUM(xdl.unrounded_accounted_cr),0) inv_cm_amt_due_er
    FROM 
      ap_invoices                aia
    , ap_invoice_distributions   aid
    , xla_events                 xe
    , xla_distribution_links     xdl
    , xla_ae_lines               xal 
    , gl_import_references 		   gir
    , gl_je_headers        		   gjh
    WHERE
            aia.payment_status_flag         <> 'Y' 
    and     aia.invoice_id                   = aid.invoice_id
    --
    and   	xdl.application_id               = 200
    and     xdl.source_distribution_type     = 'AP_INV_DIST' -- xxecl
    and     xdl.source_distribution_id_num_1 = aid.invoice_distribution_id 
    --
    and     xe.application_id               = 200
    and     xe.event_type_code              in ('CREDIT MEMO VALIDATED','DEBIT MEMO VALIDATED')
    and     xe.event_id                     = xdl.event_id
    --
    and   	xal.ae_header_id                = xdl.ae_header_id
    and   	xal.ae_line_num                 = xdl.ae_line_num
    and   	xal.application_id              = 200
    and   	xal.accounting_class_code       = 'LIABILITY'
    and 	  gir.gl_sl_link_id               = xal.gl_sl_link_id 
    and 	  gir.gl_sl_link_table            = xal.gl_sl_link_table 
    and 	  gjh.je_header_id                = gir.je_header_id 
    and 	  gjh.status                      = 'P'
    and     gjh.ledger_id                   = &gc_ledger_id
    and     xal.accounting_date            <= :P_AS_OF_DATE
    group by
      aid.parent_invoice_id
  ) 
,payables7 as 
  (
    SELECT  
      ai.invoice_id
    , NVL(SUM(NVL(xdl.unrounded_entered_cr,0)-NVL(xdl.unrounded_entered_dr,0)),0)     cm_inv_amt_due
    , NVL(SUM(NVL(xdl.unrounded_accounted_cr,0)-NVL(xdl.unrounded_accounted_dr,0)),0) cm_inv_amt_due_er 
    FROM 
      ap_invoices                      ai
    , ap_invoices                      aicm
    , ap_invoice_distributions         aid
    , ap_invoice_distributions         aidcm
    , xla_events                       xe
    , xla_distribution_links           xdl
    , xla_ae_lines                     xal
    , gl_import_references 		         gir
    , gl_je_headers        		         gjh
    , gl_code_combinations             gcc	
    WHERE
             ai.payment_status_flag           <> 'Y'
      AND    aid.invoice_id                    = ai.invoice_id
      AND    aid.dist_match_type               = 'DIST_CORRECTION'
      AND    aidcm.invoice_distribution_id     = aid.corrected_invoice_dist_id
      AND    aicm.invoice_id                   = aidcm.invoice_id
      --
      AND    xe.event_id                       = aid.accounting_event_id -- xxecl chg from xdl.event_id
      AND    xe.application_id                 = 200
      AND    xe.event_type_code               IN ('CREDIT MEMO VALIDATED','DEBIT MEMO VALIDATED')
      --      
      AND    xdl.application_id                = 200
      AND    xdl.event_id                      = aid.accounting_event_id
      AND    xdl.source_distribution_type     = 'AP_INV_DIST' -- xxecl
      AND    xdl.source_distribution_id_num_1  = aid.invoice_distribution_id 
      --
      AND    xal.ae_header_id                  = xdl.ae_header_id
      AND    xal.ae_line_num                   = xdl.ae_line_num
      AND    xal.application_id                = 200
      AND    xal.accounting_class_code         = 'LIABILITY'
      and 	 gcc.code_combination_id		       = xal.code_combination_id
      and 	 gir.gl_sl_link_id			           = xal.gl_sl_link_id
      and 	 gir.gl_sl_link_table		           = xal.gl_sl_link_table
      and 	 gjh.je_header_id			             = gir.je_header_id
      and 	 gjh.status					               = 'P'
      and    gjh.ledger_id                     = &gc_ledger_id
      AND    XAL.accounting_date		          <= :P_AS_OF_DATE
    group by ai.invoice_id
  )
-- Main Query Starts Here
select
  trx.ou_name               "Operating Unit"
, trx.accounts              "Accounting Flexfield"
, trx.transaction_currency  "Currency" 
, trx.supplier_name         "Trading Partner"
, trx.supplier_number       "Supplier Number"
, trx.invoice_number        "Invoice_Number"
, trx.transaction_type      "Type"
, trx.internal_inv_number   "Internal Invoice Number"
, trx.invoice_date          "Date"
, trx.due_date              "Due Date"
, case trx.transaction_type
  when 'PREPAYMENT'
  then -1 * (trx.invoice_amt_entered + trx.tax_amt)
  else (trx.invoice_amt_entered + trx.tax_amt)
  end                              "Invoice Amount"
, case trx.transaction_type
  when 'PREPAYMENT'
  then to_number(null)
  else trx.inv_amt_due
  end                              "Amount Due"
, trx.inv_exch_rate                "Exchange Rate"
, case trx.transaction_type
  when 'PREPAYMENT'
  then to_number(null)
  else trx.inv_amt_due_er
  end                              "Open Functional Amount"
, to_number(trx.exchange_rate)     "Revaluation Rate"
, case trx.transaction_type
  when 'PREPAYMENT'
  then to_number(null)
  else trx.inv_amt_due_reval
  end                              "Open Revalued Amount"
, case trx.transaction_type
  when 'PREPAYMENT'
  then to_number(null)
  else nvl(trx.inv_amt_due_er,0) - nvl(trx.inv_amt_due_reval,0)
  end                              "Profit/Loss"
, nvl2(trx.exchange_rate,null,'*') "No Revaluation Rate"
from
(
    select
      inv.*
    , NVL(payables4.pay_inv_amt_due4,0)        tax_amt
    , CASE 
      WHEN nvl(payables4.pay_inv_amt_due4,0) <> 0 
      AND inv.transaction_type ='PREPAYMENT' 
      AND (nvl(inv.prepay_entered_dr1,0) - inv.invoice_amt_entered)!=0 
      THEN
           AP_OPEN_BAL_REV_RPT_PKG.vat_calc_amt(nvl(payables3.pay_inv_amt_due3,0)
    		                                       ,nvl(payables4.pay_inv_amt_due4,0)
    		                                       ,inv.invoice_amt_entered)
      ELSE 
          inv.invoice_amt_entered
           -(   nvl(payables1.pay_inv_amt_due1,0)
              + nvl(payables2.pay_inv_amt_due2,0)
              + nvl(payables3.pay_inv_amt_due3,0)
              + nvl(inv.prepay_entered_dr1,0)
              + nvl(payables6.inv_cm_amt_due,0)
              + nvl(payables7.cm_inv_amt_due,0)
           ) 
      END      inv_amt_due
    , CASE 
      WHEN nvl(payables4.pay_inv_amt_due_er4,0) <> 0 
      AND  inv.transaction_type ='PREPAYMENT' 
      AND  (nvl(inv.prepay_entered_dr1,0) - inv.invoice_amt_entered)!=0 
      THEN
           AP_OPEN_BAL_REV_RPT_PKG.vat_calc_amt(nvl(payables3.pay_inv_amt_due_er3,0)
    		                                       ,nvl(payables4.pay_inv_amt_due_er4,0)
    		                                       ,inv.invoice_amt_accounted
    		                                       )
      ELSE inv.invoice_amt_accounted
            -(  nvl(payables1.pay_inv_amt_due_er1,0)
              + nvl(payables2.pay_inv_amt_due_er2,0)
              + nvl(payables3.pay_inv_amt_due_er3,0)
              + nvl(inv.prepay_accounted_dr1,0)
              + nvl(payables6.inv_cm_amt_due_er,0)
              + nvl(payables7.cm_inv_amt_due_er,0)
              ) 
      END   inv_amt_due_er
    , CASE 
      WHEN nvl(payables4.pay_inv_amt_due_er4,0) <> 0 
      AND  inv.transaction_type = 'PREPAYMENT' 
      AND (nvl(inv.prepay_entered_dr1,0) - inv.invoice_amt_entered)!=0 
      THEN
    		  AP_OPEN_BAL_REV_RPT_PKG.amtduereval(AP_OPEN_BAL_REV_RPT_PKG.vat_calc_amt
    		                                       (nvl(payables3.pay_inv_amt_due3,0)
    		                                       ,nvl(payables4.pay_inv_amt_due4,0)
    		                                       ,inv.invoice_amt_entered
    		                                       )
    		                                      ,inv.exchange_rate
    			                 									  ,inv.transaction_currency
    			                 									  )
      ELSE 
          AP_OPEN_BAL_REV_RPT_PKG.amtduereval
            ( (inv.invoice_amt_entered 
                 -(  nvl(payables1.pay_inv_amt_due1,0)
                   + nvl(payables2.pay_inv_amt_due2,0)
                   + nvl(payables3.pay_inv_amt_due3,0)
                   + nvl(inv.prepay_entered_dr1,0)
                   + nvl(payables6.inv_cm_amt_due,0)
                   + nvl(payables7.cm_inv_amt_due,0)
                   )
              )
    		    ,inv.exchange_rate
            ,inv.transaction_currency) 
      END inv_amt_due_reval
    from
      (select 
         inv.*
       , (select min(aps.due_date)
          from ap_payment_schedules aps
          where aps.invoice_id = inv.invoice_id_tag
         )  due_date
       , case when (inv.transaction_type = 'PREPAYMENT' and inv.invoice_amt_entered = nvl(payables5.prepay_entered_dr1,0)) 
              then to_number(0)
      			  when (inv.transaction_type = 'PREPAYMENT' and nvl(payables5.prepay_entered_dr1,0) = 0) 
              then to_number(inv.invoice_amt_entered)
      			  when (inv.transaction_type = 'PREPAYMENT' and payables5.prepay_entered_dr1 is null) 
      			  then to_number(inv.invoice_amt_entered)
              else to_number(0) end  prepay_entered_dr1                
       , case when (inv.transaction_type = 'PREPAYMENT' and inv.invoice_amt_accounted = nvl(payables5.prepay_accounted_dr1,0)) 
      		    then to_number(0)
      			  when (inv.transaction_type = 'PREPAYMENT' and nvl(payables5.prepay_accounted_dr1,0) = 0) 
      		    then to_number(inv.invoice_amt_accounted)
      			  when (inv.transaction_type = 'PREPAYMENT' and payables5.prepay_accounted_dr1 is null) 
      		    then to_number(inv.invoice_amt_accounted)
              else to_number(0) end  prepay_accounted_dr1    
       from 
         inv
       , payables5
       where
         inv.invoice_id_tag = payables5.invoice_id (+)
      ) inv  
    , payables1
    , payables2
    , payables3
    , payables4
    , payables6
    , payables7
    where
        1=1
    and inv.invoice_id_tag = payables1.invoice_id (+)
    and inv.invoice_id_tag = payables2.invoice_id (+)
    and inv.invoice_id_tag = payables3.invoice_id (+)
    and inv.invoice_id_tag = payables4.invoice_id (+)
    and inv.invoice_id_tag = payables6.parent_invoice_id (+)
    and inv.invoice_id_tag = payables7.invoice_id (+)
) trx
where nvl(trx.inv_amt_due,0) != 0
order by
  trx.ou_name 
, trx.accounts
, trx.transaction_currency 
, trx.supplier_name
, trx.invoice_number