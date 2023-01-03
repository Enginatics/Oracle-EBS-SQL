/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Customer Statement
-- Description: Application: Receivables
Source: Customer Statement
Short Name: ARSTMTRPT
DB package: AR_TP_STMT_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ar-customer-statement/
-- Library Link: https://www.enginatics.com/reports/ar-customer-statement/
-- Run Report: https://demo.enginatics.com/

with q_customer as (SELECT 
   hca.cust_account_id customer_party_id,
   hcsu.site_use_id customer_party_site_id,
   AR_TP_STMT_PKG.balance_brought_forward(hca.cust_account_id,hcsu.site_use_id,hcas.org_id) brought_forward_amount,
   hca.account_number customer_number,
   hpar.party_name customer_name,
   hps.party_site_number party_site_number,
   hps.party_site_name party_site_name,
   hpar.address1||' '|| hpar.address2||' '|| hpar.address3||' '|| hpar.address4||' '|| hpar.city ||' '|| hpar.postal_code customer_address,
   hpar.jgzz_fiscal_code customer_tax_payer_id,
   NVL(zptp.rep_registration_number,hpar.tax_reference) customer_tax_ref_number,
   hou.name organization_name,
   hou.organization_id organization_id
  FROM 
   hz_cust_accounts hca,
   hz_parties hpar,
   hz_cust_site_uses_all hcsu,
   hz_cust_acct_sites_all hcas,
   hz_party_sites hps,
   hr_operating_units hou,
   zx_party_tax_profile zptp
  WHERE
   hca.party_id = hpar.party_id
   AND hcsu.cust_acct_site_id = hcas.cust_acct_site_id
   AND hcas.party_site_id = hps.party_site_id
   AND hcsu.site_use_code = 'BILL_TO'
   AND hpar.party_id = hps.party_id
   AND hcas.org_id = hou.organization_id
   AND hpar.party_id = zptp.party_id(+)
   AND zptp.party_type_code(+) = 'THIRD_PARTY'
   AND hcas.org_id = hou.organization_id 
   &gc_reporting_entity 
   &gc_customer_name 
   &gc_cust_category 
   &gc_cust_class 
   ),
q_main as (SELECT 
   'T' trx_type,
   rctt.name transaction_type,
   NULL adjustment_number,
   rct.trx_number transaction_number,
   rctld.gl_date GL_Date,
   rct.trx_date transaction_date,
   apsa.due_date transaction_due_date,
   rct.invoice_currency_code transaction_currency,
   rctld.amount entered_amount,
   rctld.acctd_amount accounted_amount,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   apsa.amount_due_original due_original,
   apsa.amount_due_remaining due_remaining,
   rct.status_trx trx_status,
   rct.bill_to_customer_id customer_party_id,
   rct.bill_to_site_use_id customer_party_site_id
  FROM 
   ra_customer_trx rct,
   ar_payment_schedules_all apsa,
   ra_cust_trx_types_all rctt,
   ra_cust_trx_line_gl_dist_all rctld,
   gl_periods gp,
   gl_ledgers gled
  WHERE
   rct.customer_trx_id = apsa.customer_trx_id(+)
   AND rct.customer_trx_id = rctld.customer_trx_id
   AND rct.cust_trx_type_id = rctt.cust_trx_type_id
   AND rct.org_id = rctt.org_id
   AND gled.period_set_name = gp.period_set_name
   AND gled.accounted_period_type = gp.period_type
   AND gled.ledger_id = rct.set_of_books_id
   AND rctld.gl_date BETWEEN gp.start_date AND gp.end_date
   AND rctld.latest_rec_flag = 'Y'
   AND rctld.account_class = 'REC'
   AND rctt.post_to_gl = 'Y' -- Only Postable to GL are picked
   AND rctt.type IN ('CB','INV','DM','CM','BR','DEP') -- Guarantees are not picked
   AND rctld.gl_date BETWEEN :P_FROM_GL_DATE AND :P_TO_GL_DATE
   AND gp.adjustment_period_flag = 'N'
   AND 1=1 
   &gc_org_id 
   &gc_currency 
   &gc_accounted 
   &gc_incomplete_trx 
  UNION ALL 
  SELECT 
   'R' trx_type,
   arm.name transaction_type,
   NULL adjustment_number,
   acr.receipt_number transaction_number,
   acrh.gl_date GL_Date,
   acr.receipt_date transaction_date,
   apsa.due_date transaction_due_date,
   acr.currency_code transaction_currency,
   acr.amount entered_amount,
   acr.amount * NVL(acr.exchange_rate,1) accounted_amount,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   apsa.amount_due_original due_original,
   apsa.amount_due_remaining due_remaining,
   acrh.status trx_status,
   acr.pay_from_customer customer_party_id,
   acr.customer_site_use_id customer_party_site_id
  FROM 
   ar_cash_receipts acr,
   ar_receipt_methods arm,
   ar_cash_receipt_history_all acrh,
   ar_payment_schedules_all apsa,
   gl_periods gp,
   gl_ledgers gled
  WHERE
   acr.cash_receipt_id = apsa.cash_receipt_id(+)
   AND acr.org_id = apsa.org_id(+)
   AND acr.receipt_method_id = arm.receipt_method_id
   AND acr.cash_receipt_id = acrh.cash_receipt_id
   AND acr.org_id = acrh.org_id
   AND gled.period_set_name = gp.period_set_name
   AND gled.accounted_period_type = gp.period_type
   AND acr.set_of_books_id = gled.ledger_id
   AND acrh.gl_date BETWEEN gp.start_date AND gp.end_date
   AND acrh.first_posted_record_flag = 'Y'
   AND acrh.gl_date BETWEEN :P_FROM_GL_DATE AND :P_TO_GL_DATE
   AND gp.adjustment_period_flag = 'N'
   AND 2=2 
   &gc_rcpt_org_id 
   &gc_rcpt_currency 
   &gc_rcpt_accounted 
  UNION ALL 
  SELECT 
   'R' trx_type,
   arm.name transaction_type,
   NULL adjustment_number,
   acr.receipt_number transaction_number,
   acrh.gl_date GL_Date,
   acr.receipt_date transaction_date,
   apsa.due_date transaction_due_date,
   acr.currency_code transaction_currency,
   acr.amount entered_amount,
   acr.amount * NVL(acr.exchange_rate,1) accounted_amount,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   apsa.amount_due_original due_original,
   apsa.amount_due_remaining due_remaining,
   acrh.status trx_status,
   acr.pay_from_customer customer_party_id,
   acr.customer_site_use_id customer_party_site_id
  FROM 
   ar_cash_receipts acr,
   ar_receipt_methods arm,
   ar_cash_receipt_history_all acrh,
   ar_payment_schedules_all apsa,
   gl_periods gp,
   gl_ledgers gled
  WHERE
   acr.cash_receipt_id = apsa.cash_receipt_id(+)
   AND acr.org_id = apsa.org_id(+)
   AND acr.receipt_method_id = arm.receipt_method_id
   AND acr.cash_receipt_id = acrh.cash_receipt_id
   AND acr.org_id = acrh.org_id
   AND gled.period_set_name = gp.period_set_name
   AND gled.accounted_period_type = gp.period_type
   AND acr.set_of_books_id = gled.ledger_id
   AND acrh.gl_date BETWEEN gp.start_date AND gp.end_date
   AND acr.reversal_date IS NOT NULL
   AND acrh.current_record_flag = 'Y'
   AND acrh.status = 'REVERSED' 
-- To Consider the first status for Reversed Receipts
   AND gp.adjustment_period_flag = 'N'
   AND 3=3 
   &gc_rcpt_org_id 
   &gc_rcpt_currency 
   &gc_rcpt_accounted 
  UNION ALL 
  SELECT 
   'A' trx_type,
   al.meaning transaction_type,
   aa.adjustment_number adjustment_number,
   rct.trx_number transaction_number,
   aa.gl_date GL_Date,
   aa.apply_date transaction_date,
   aa.apply_date transaction_due_date,
   rct.invoice_currency_code transaction_currency,
   aa.amount entered_amount,
   aa.acctd_amount accounted_amount,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   apsa.amount_due_original due_original,
   apsa.amount_due_remaining due_remaining,
   aa.status trx_status,
   rct.bill_to_customer_id customer_party_id,
   rct.bill_to_site_use_id customer_party_site_id
  FROM 
   ar_adjustments aa,
   ar_lookups al,
   ra_customer_trx_all rct,
   ra_cust_trx_types_all rctt,
   ar_payment_schedules_all apsa,
   gl_periods gp,
   gl_ledgers gled
  WHERE
   rct.customer_trx_id = apsa.customer_trx_id(+)
   AND rct.org_id = apsa.org_id(+)
   AND rct.cust_trx_type_id = rctt.cust_trx_type_id
   AND rct.org_id = rctt.org_id
   AND rct.customer_trx_id = aa.customer_trx_id
   AND rct.org_id = aa.org_id
   AND gled.period_set_name = gp.period_set_name
   AND gled.accounted_period_type = gp.period_type
   AND gled.ledger_id = aa.set_of_books_id
   AND al.lookup_type = 'ADJUSTMENT_TYPE'
   AND aa.status = 'A' -- For approved Adjustments
   AND aa.type = al.lookup_code
   AND aa.gl_date BETWEEN gp.start_date AND gp.end_date
   AND aa.gl_date BETWEEN :P_FROM_GL_DATE AND :P_TO_GL_DATE
   AND gp.adjustment_period_flag = 'N'
   AND rctt.post_to_gl = 'Y' -- Only Postable to GL are picked
   AND rctt.type IN ('CB','INV','DM','CM','BR','DEP') -- Guarantees are not picked
   AND 4=4 
   &gc_org_id 
   &gc_currency 
   &gc_adj_accounted 
   &gc_incomplete_trx 
  UNION ALL 
  SELECT 
   'R' trx_type,
   art.name transaction_type,
   NULL adjustment_number,
   acr.receipt_number transaction_number,
   ara.gl_date gl_date,
   ara.apply_date transaction_date,
   ara.apply_date transaction_due_date,
   acr.currency_code transaction_currency,
   -1*(ara.amount_applied) entered_amount,
   -1*(ara.acctd_amount_applied_from) accounted_amount,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   0 due_original,
   0 due_remaining,
   art.status trx_status,
   acr.pay_from_customer customer_party_id,
   acr.customer_site_use_id customer_party_site_id
  FROM 
   ar_cash_receipts acr,
   ar_receivable_applications_all ara,
   ar_receivables_trx_all art,
   gl_periods gp,
   gl_ledgers gled
  WHERE
   acr.cash_receipt_id = ara.cash_receipt_id
   AND acr.org_id = ara.org_id
   AND ara.receivables_trx_id = art.receivables_trx_id
   AND ara.org_id = art.org_id
   AND gled.period_set_name = gp.period_set_name
   AND gled.accounted_period_type = gp.period_type
   AND acr.set_of_books_id = gled.ledger_id
   AND ara.gl_date BETWEEN gp.start_date AND gp.end_date
   AND ara.gl_date BETWEEN :P_FROM_GL_DATE AND :P_TO_GL_DATE
   AND art.type = 'WRITEOFF' 
   --AND art.status                 = 'A' --Only Active Receipt WriteOffs
   AND gp.adjustment_period_flag = 'N' 
   AND 5=5
   &gc_rcpt_org_id 
   &gc_rcpt_currency 
   &gc_app_accounted 
   )
--
-- Main Query Start Here
--
select 
 :p_reporting_entity_name &reporting_entity_col_name,
 q.customer_name,
 q.customer_number,
 q.customer_tax_registration,
 q.customer_site_name,
 q.customer_site_number,
 q.customer_address,
 &lp_operating_unit_column
 q.period_name,
 replace(q.Record_Type,'_',' ') record_type,
 q.balance_bought_forward_debit,
 q.balance_bought_forward_credit,
 q.net_debit,
 q.net_credit,
 q.cumulative_debit,
 q.cumulative_credit,
 q.balance_bought_forward_credit - q.balance_bought_forward_debit balance_bought_forward_amount,
 q.net_credit - q.net_debit net_amount,
 q.cumulative_credit - q.cumulative_debit cumualtive_amount 
 &document_columns
from 
 (select 
   z.*,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.Debit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.customer_party_site_id) - sum(nvl(z.Debit,0)) over (partition by z.customer_party_site_id,z.period_name)
    when 'Customer Site Summary' then sum(nvl(z.bbf,0)) over (partition by z.customer_party_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.bbf,0)) over (partition by z.customer_party_id,z.organization_id)
    when 'Customer Summary' then sum(nvl(z.bbf,0)) over (partition by z.customer_party_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.bbf,0)) over ()
    else null
   end balance_bought_forward_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.Credit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row) - sum(nvl(z.Credit,0)) over (partition by z.customer_party_site_id,z.period_name)
    when 'Customer Site Summary' then 0
    when 'Operating Unit Summary' then 0
    when 'Customer Summary' then 0
    when '&reporting_entity_col_name Summary' then 0
    else null
   end balance_bought_forward_credit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.Debit,0)) over (partition by z.customer_party_site_id,z.period_name)
    when 'Customer Site Summary' then sum(nvl(z.Debit,0)) over (partition by z.customer_party_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.Debit,0)) over (partition by z.customer_party_id,z.organization_id)
    when 'Customer Summary' then sum(nvl(z.Debit,0)) over (partition by z.customer_party_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.Debit,0)) over ()
    else null
   end net_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.Credit,0)) over (partition by z.customer_party_site_id,z.period_name)
    when 'Customer Site Summary' then sum(nvl(z.Credit,0)) over (partition by z.customer_party_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.Credit,0)) over (partition by z.customer_party_id,z.organization_id)
    when 'Customer Summary' then sum(nvl(z.Credit,0)) over (partition by z.customer_party_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.Credit,0)) over ()
    else null
   end net_credit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.Debit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.customer_party_site_id)
    when 'Customer Site Summary' then sum(nvl(z.Debit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.customer_party_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.Debit,0)) over (partition by z.customer_party_id,z.organization_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.customer_party_id,z.organization_id)
    when 'Customer Summary' then sum(nvl(z.Debit,0)) over (partition by z.customer_party_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.customer_party_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.Debit,0)) over () + sum(nvl(z.bbf,0)) over ()
    else null
   end cumulative_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.Credit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row)
    when 'Customer Site Summary' then sum(nvl(z.Credit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row)
    when 'Operating Unit Summary' then sum(nvl(z.Credit,0)) over (partition by z.customer_party_id,z.organization_id order by z.seq rows between unbounded preceding and current row)
    when 'Customer Summary' then sum(nvl(z.Credit,0)) over (partition by z.customer_party_id order by z.seq rows between unbounded preceding and current row)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.Credit,0)) over ()
    else null
   end cumulative_credit
  from 
   (select 
     rownum seq,
     y.*
    from 
     (select 
       x.*
      from 
       (-- dummy period summary record
select distinct 
         'Period Summary' record_type,
         q_customer.customer_name,
         q_customer.customer_number,
         q_customer.customer_tax_ref_number customer_tax_registration,
         q_customer.organization_name operating_unit,
         q_customer.party_site_name customer_site_name,
         q_customer.party_site_number customer_site_number,
         q_customer.customer_address,
         q_main.gp_period_name period_name,
         null Document_Type,
         null Document_Number,
         to_date(null) Document_Date,
         to_date(null) Maturity_Date,
         null Document_Status,
         to_date(null) GL_Date,
         to_number(null) Debit,
         to_number(null) Credit,
         to_number(null) Original_Amount,
         null Currency_Code,
         1 sort_order,
         q_main.gp_start_date period_start_date,
         q_main.gp_period_num period_num,
         q_customer.customer_party_id,
         q_customer.customer_party_site_id,
         q_customer.organization_id,
         to_number(null) bbf
        from 
         q_customer,
         q_main
        where
         q_main.customer_party_id = q_customer.customer_party_id
         and q_main.customer_party_site_id = q_customer.customer_party_site_id 
        union all 
        -- dummy supplier site summary record
        select distinct 
         'Customer Site Summary' record_type,
         q_customer.customer_name,
         q_customer.customer_number,
         q_customer.customer_tax_ref_number customer_tax_registration,
         q_customer.organization_name operating_unit,
         q_customer.party_site_name customer_site_name,
         q_customer.party_site_number customer_site_number,
         q_customer.customer_address,
         null period_name,
         null Document_Type,
         null Document_Number,
         to_date(null) Document_Date,
         to_date(null) Maturity_Date,
         null Document_Status,
         to_date(null) GL_Date,
         to_number(null) Debit,
         to_number(null) Credit,
         to_number(null) Original_Amount,
         null Currency_Code,
         2 sort_order,
         to_date(null) period_start_date,
         to_number(null) period_num,
         q_customer.customer_party_id,
         q_customer.customer_party_site_id,
         q_customer.organization_id,
         q_customer.brought_forward_amount bbf
        from 
         q_customer
        union all 
        -- dummy operating unit summary record
        select distinct 
         'Operating Unit Summary' Record_Type,
         q_customer.customer_name,
         q_customer.customer_number,
         q_customer.customer_tax_ref_number customer_tax_registration,
         q_customer.organization_name operating_unit,
         null customer_site_name,
         null customer_site_number,
         null customer_address,
         null period_name,
         null Document_Type,
         null Document_Number,
         to_date(null) Document_Date,
         to_date(null) Maturity_Date,
         null Document_Status,
         to_date(null) GL_Date,
         to_number(null) Debit,
         to_number(null) Credit,
         to_number(null) Original_Amount,
         null Currency_Code,
         3 sort_order,
         to_date(null) period_start_date,
         to_number(null) period_num,
         q_customer.customer_party_id,
         to_number(null) customer_party_site_id,
         q_customer.organization_id,
         to_number(null) bbf
        from 
         q_customer
        where
         :p_reporting_level != '3000' -- don't show OU Summary when run by OU
        union all 
        -- dummy supplier summary record
        select distinct 
         'Customer Summary' record_type,
         q_customer.customer_name,
         q_customer.customer_number,
         q_customer.customer_tax_ref_number customer_tax_registration,
         null operating_unit,
         null customer_site_name,
         null customer_site_number,
         null customer_address,
         null period_name,
         null Document_Type,
         null Document_Number,
         to_date(null) Document_Date,
         to_date(null) Maturity_Date,
         null Document_Status,
         to_date(null) GL_Date,
         to_number(null) Debit,
         to_number(null) Credit,
         to_number(null) Original_Amount,
         null Currency_Code,
         4 sort_order,
         to_date(null) period_start_date,
         to_number(null) period_num,
         q_customer.customer_party_id,
         to_number(null) customer_party_site_id,
         to_number(null) organization_id,
         to_number(null) bbf
        from 
         q_customer
        union all 
        -- dummy supplier summary record
        select distinct 
         '&reporting_entity_col_name Summary' record_type,
         null customer_name,
         null customer_number,
         null customer_tax_registration,
         null operating_unit,
         null customer_site_name,
         null customer_site_number,
         null customer_address,
         null period_name,
         null Document_Type,
         null Document_Number,
         to_date(null) Document_Date,
         to_date(null) Maturity_Date,
         null Document_Status,
         to_date(null) GL_Date,
         to_number(null) Debit,
         to_number(null) Credit,
         to_number(null) Original_Amount,
         null Currency_Code,
         5 sort_order,
         to_date(null) period_start_date,
         to_number(null) period_num,
         to_number(null) customer_party_id,
         to_number(null) customer_party_site_id,
         to_number(null) organization_id,
         to_number(null) bbf
        from 
         dual
        union all 
        -- transactions
        select 
         'Transaction' record_type,
         q_customer.customer_name,
         q_customer.customer_number,
         q_customer.customer_tax_ref_number customer_tax_registration,
         q_customer.organization_name operating_unit,
         q_customer.party_site_name customer_site_name,
         q_customer.party_site_number customer_site_number,
         q_customer.customer_address,
         q_main.gp_period_name period_name,
         q_main.transaction_type Document_Type,
         nvl(q_main.adjustment_number ,q_main.transaction_number) Document_Number,
         q_main.transaction_date Document_Date,
         q_main.transaction_due_date Maturity_Date,
         case
          when q_main.due_remaining = 0 then
           case q_main.trx_type
            when 'T' then 'Closed'
            when 'R' then 'Fully Applied'
           end
          else
           case q_main.trx_type
            when 'T' then 'Open'
            when 'R' then
             case
              when q_main.due_original - q_main.due_remaining < 0 then 'Partially Applied'
              else 'Not Applied'
             end
            else null
           end
         end ||case q_main.trx_status
          when 'CLEARED' then '/Cleared'
          when 'REVERSED' then '/Reversed'
          else null
         end ||case q_main.trx_type
          when 'A' then 'Approved'
          else null
         end Document_Status,
         q_main.gl_date GL_Date,
         case q_main.trx_type
          when 'R' then to_number(null)
          else q_main.accounted_amount
         end Debit,
         case q_main.trx_type
          when 'R' then
           case q_main.trx_status
            when 'REVERSED' then -1 * q_main.accounted_amount
            else q_main.accounted_amount
           end
          else to_number(null)
         end Credit,
         case q_main.trx_status
          when 'REVERSED' then -1 * q_main.entered_amount
          else q_main.entered_amount
         end Original_Amount,
         q_main.transaction_currency Currency_Code,
         -1 sort_order,
         q_main.gp_start_date period_start_date,
         q_main.gp_period_num period_num,
         q_customer.customer_party_id,
         q_customer.customer_party_site_id,
         q_customer.organization_id,
         to_number(null) bbf
        from 
         q_customer,
         q_main
        where
         q_main.customer_party_id = q_customer.customer_party_id
         and q_main.customer_party_site_id = q_customer.customer_party_site_id ) x
      order by 
       x.customer_name,
       x.customer_number,
       x.customer_party_id,
       x.operating_unit,
       x.customer_site_number,
       x.customer_party_site_id,
       nvl(x.period_start_date,to_date('31/12/4712','DD/MM/YYYY')),
       nvl(x.period_num,99),
       nvl(x.period_name,'####'),
       x.sort_order,
       x.gl_date,
       x.document_date) y) z
  order by 
   z.seq) q
where
 (     (:p_summary_only = 'N' and q.record_type = 'Transaction') 
  or (:p_summary_level = 'Period' and q.record_type not in ('Transaction')) 
  or (:p_summary_level = 'Customer Site' and q.record_type not in ('Period Summary','Transaction')) 
  or (:p_summary_level = 'Operating Unit' and q.record_type not in ('Customer Site Summary','Period Summary','Transaction')) 
  or (:p_summary_level = 'Customer' and q.record_type = 'Customer Summary') 
  or (:p_reporting_level = '3000' and q.record_type = 'Operating_Unit Summary') 
  or (:p_reporting_level = '1000' and q.record_type = 'Ledger Summary') 
) 
order by 
 q.seq