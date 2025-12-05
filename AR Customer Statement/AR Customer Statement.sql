/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
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

with q_customer as (select 
   hca.cust_account_id customer_party_id,
   hcsu.site_use_id customer_party_site_id,
   ar_tp_stmt_pkg.balance_brought_forward(hca.cust_account_id,hcsu.site_use_id,hcas.org_id) brought_forward_amount,
   hca.account_number customer_number,
   hpar.party_name customer_name,
   hps.party_site_number party_site_number,
   hps.party_site_name party_site_name,
   hpar.address1||' '|| hpar.address2||' '|| hpar.address3||' '|| hpar.address4||' '|| hpar.city ||' '|| hpar.postal_code customer_address,
   hpar.jgzz_fiscal_code customer_tax_payer_id,
   nvl(zptp.rep_registration_number,hpar.tax_reference) customer_tax_ref_number,
   hou.name organization_name,
   hou.organization_id organization_id
  from 
   hz_cust_accounts hca,
   hz_parties hpar,
   hz_cust_site_uses_all hcsu,
   hz_cust_acct_sites_all hcas,
   hz_party_sites hps,
   hr_operating_units hou,
   zx_party_tax_profile zptp
  where
   hca.party_id = hpar.party_id
   and hcsu.cust_acct_site_id = hcas.cust_acct_site_id
   and hcas.party_site_id = hps.party_site_id
   and hcsu.site_use_code = 'BILL_TO'
   and hpar.party_id = hps.party_id
   and hcas.org_id = hou.organization_id
   and hpar.party_id = zptp.party_id(+)
   and zptp.party_type_code(+) = 'THIRD_PARTY'
   and hcas.org_id = hou.organization_id 
   &gc_reporting_entity 
   &gc_customer_name 
   &gc_cust_category 
   &gc_cust_class 
   ),
q_main as (select 
   'T' trx_type,
   rctt.name transaction_type,
   null adjustment_number,
   rct.trx_number transaction_number,
   rctld.gl_date gl_date,
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
  from 
   ra_customer_trx rct,
   ar_payment_schedules_all apsa,
   ra_cust_trx_types_all rctt,
   ra_cust_trx_line_gl_dist_all rctld,
   gl_periods gp,
   gl_ledgers gled
  where
   rct.customer_trx_id = apsa.customer_trx_id(+)
   and rct.customer_trx_id = rctld.customer_trx_id
   and rct.cust_trx_type_id = rctt.cust_trx_type_id
   and rct.org_id = rctt.org_id
   and gled.period_set_name = gp.period_set_name
   and gled.accounted_period_type = gp.period_type
   and gled.ledger_id = rct.set_of_books_id
   and rctld.gl_date between gp.start_date and gp.end_date
   and rctld.latest_rec_flag = 'Y'
   and rctld.account_class = 'REC'
   and rctt.post_to_gl = 'Y' -- Only Postable to GL are picked
   and rctt.type in ('CB','INV','DM','CM','BR','DEP') -- Guarantees are not picked
   and rctld.gl_date between :p_from_gl_date and :p_to_gl_date
   and gp.adjustment_period_flag = 'N'
   and 1=1 
   &gc_org_id 
   &gc_currency 
   &gc_accounted 
   &gc_incomplete_trx 
  union all 
  select 
   'R' trx_type,
   arm.name transaction_type,
   null adjustment_number,
   acr.receipt_number transaction_number,
   acrh.gl_date gl_date,
   acr.receipt_date transaction_date,
   apsa.due_date transaction_due_date,
   acr.currency_code transaction_currency,
   acr.amount entered_amount,
   acr.amount * nvl(acr.exchange_rate,1) accounted_amount,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   apsa.amount_due_original due_original,
   apsa.amount_due_remaining due_remaining,
   acrh.status trx_status,
   acr.pay_from_customer customer_party_id,
   acr.customer_site_use_id customer_party_site_id
  from 
   ar_cash_receipts acr,
   ar_receipt_methods arm,
   ar_cash_receipt_history_all acrh,
   ar_payment_schedules_all apsa,
   gl_periods gp,
   gl_ledgers gled
  where
   acr.cash_receipt_id = apsa.cash_receipt_id(+)
   and acr.org_id = apsa.org_id(+)
   and acr.receipt_method_id = arm.receipt_method_id
   and acr.cash_receipt_id = acrh.cash_receipt_id
   and acr.org_id = acrh.org_id
   and gled.period_set_name = gp.period_set_name
   and gled.accounted_period_type = gp.period_type
   and acr.set_of_books_id = gled.ledger_id
   and acrh.gl_date between gp.start_date and gp.end_date
   and acrh.first_posted_record_flag = 'Y'
   and acrh.gl_date between :p_from_gl_date and :p_to_gl_date
   and gp.adjustment_period_flag = 'N'
   and 2=2 
   &gc_rcpt_org_id 
   &gc_rcpt_currency 
   &gc_rcpt_accounted 
  union all 
  select 
   'R' trx_type,
   arm.name transaction_type,
   null adjustment_number,
   acr.receipt_number transaction_number,
   acrh.gl_date gl_date,
   acr.receipt_date transaction_date,
   apsa.due_date transaction_due_date,
   acr.currency_code transaction_currency,
   acr.amount entered_amount,
   acr.amount * nvl(acr.exchange_rate,1) accounted_amount,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   apsa.amount_due_original due_original,
   apsa.amount_due_remaining due_remaining,
   acrh.status trx_status,
   acr.pay_from_customer customer_party_id,
   acr.customer_site_use_id customer_party_site_id
  from 
   ar_cash_receipts acr,
   ar_receipt_methods arm,
   ar_cash_receipt_history_all acrh,
   ar_payment_schedules_all apsa,
   gl_periods gp,
   gl_ledgers gled
  where
   acr.cash_receipt_id = apsa.cash_receipt_id(+)
   and acr.org_id = apsa.org_id(+)
   and acr.receipt_method_id = arm.receipt_method_id
   and acr.cash_receipt_id = acrh.cash_receipt_id
   and acr.org_id = acrh.org_id
   and gled.period_set_name = gp.period_set_name
   and gled.accounted_period_type = gp.period_type
   and acr.set_of_books_id = gled.ledger_id
   and acrh.gl_date between gp.start_date and gp.end_date
   and acr.reversal_date is not null
   and acrh.current_record_flag = 'Y'
   and acrh.status = 'REVERSED' 
   and acrh.gl_date between :p_from_gl_date and :p_to_gl_date
-- To Consider the first status for Reversed Receipts
   and gp.adjustment_period_flag = 'N'
   and 3=3 
   &gc_rcpt_org_id 
   &gc_rcpt_currency 
   &gc_rcpt_accounted 
  union all 
  select 
   'A' trx_type,
   al.meaning transaction_type,
   aa.adjustment_number adjustment_number,
   rct.trx_number transaction_number,
   aa.gl_date gl_date,
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
  from 
   ar_adjustments aa,
   ar_lookups al,
   ra_customer_trx_all rct,
   ra_cust_trx_types_all rctt,
   ar_payment_schedules_all apsa,
   gl_periods gp,
   gl_ledgers gled
  where
   rct.customer_trx_id = apsa.customer_trx_id(+)
   and rct.org_id = apsa.org_id(+)
   and rct.cust_trx_type_id = rctt.cust_trx_type_id
   and rct.org_id = rctt.org_id
   and rct.customer_trx_id = aa.customer_trx_id
   and rct.org_id = aa.org_id
   and gled.period_set_name = gp.period_set_name
   and gled.accounted_period_type = gp.period_type
   and gled.ledger_id = aa.set_of_books_id
   and al.lookup_type = 'ADJUSTMENT_TYPE'
   and aa.status = 'A' -- For approved Adjustments
   and aa.type = al.lookup_code
   and aa.gl_date between gp.start_date and gp.end_date
   and aa.gl_date between :p_from_gl_date and :p_to_gl_date
   and gp.adjustment_period_flag = 'N'
   and rctt.post_to_gl = 'Y' -- Only Postable to GL are picked
   and rctt.type in ('CB','INV','DM','CM','BR','DEP') -- Guarantees are not picked
   and 4=4 
   &gc_org_id 
   &gc_currency 
   &gc_adj_accounted 
   &gc_incomplete_trx 
  union all 
  select 
   'R' trx_type,
   art.name transaction_type,
   null adjustment_number,
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
  from 
   ar_cash_receipts acr,
   ar_receivable_applications_all ara,
   ar_receivables_trx_all art,
   gl_periods gp,
   gl_ledgers gled
  where
   acr.cash_receipt_id = ara.cash_receipt_id
   and acr.org_id = ara.org_id
   and ara.receivables_trx_id = art.receivables_trx_id
   and ara.org_id = art.org_id
   and gled.period_set_name = gp.period_set_name
   and gled.accounted_period_type = gp.period_type
   and acr.set_of_books_id = gled.ledger_id
   and ara.gl_date between gp.start_date and gp.end_date
   and ara.gl_date between :p_from_gl_date and :p_to_gl_date
   and art.type = 'WRITEOFF' 
   --AND art.status                 = 'A' --Only Active Receipt WriteOffs
   and gp.adjustment_period_flag = 'N' 
   and 5=5
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
 replace(q.record_type,'_',' ') record_type,
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
    when 'Period Summary' then sum(nvl(z.debit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.customer_party_site_id) - sum(nvl(z.debit,0)) over (partition by z.customer_party_site_id,z.period_name)
    when 'Customer Site Summary' then sum(nvl(z.bbf,0)) over (partition by z.customer_party_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.bbf,0)) over (partition by z.customer_party_id,z.organization_id)
    when 'Customer Summary' then sum(nvl(z.bbf,0)) over (partition by z.customer_party_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.bbf,0)) over ()
    else null
   end balance_bought_forward_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.credit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row) - sum(nvl(z.credit,0)) over (partition by z.customer_party_site_id,z.period_name)
    when 'Customer Site Summary' then 0
    when 'Operating Unit Summary' then 0
    when 'Customer Summary' then 0
    when '&reporting_entity_col_name Summary' then 0
    else null
   end balance_bought_forward_credit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.debit,0)) over (partition by z.customer_party_site_id,z.period_name)
    when 'Customer Site Summary' then sum(nvl(z.debit,0)) over (partition by z.customer_party_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.debit,0)) over (partition by z.customer_party_id,z.organization_id)
    when 'Customer Summary' then sum(nvl(z.debit,0)) over (partition by z.customer_party_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.debit,0)) over ()
    else null
   end net_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.credit,0)) over (partition by z.customer_party_site_id,z.period_name)
    when 'Customer Site Summary' then sum(nvl(z.credit,0)) over (partition by z.customer_party_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.credit,0)) over (partition by z.customer_party_id,z.organization_id)
    when 'Customer Summary' then sum(nvl(z.credit,0)) over (partition by z.customer_party_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.credit,0)) over ()
    else null
   end net_credit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.debit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.customer_party_site_id)
    when 'Customer Site Summary' then sum(nvl(z.debit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.customer_party_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.debit,0)) over (partition by z.customer_party_id,z.organization_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.customer_party_id,z.organization_id)
    when 'Customer Summary' then sum(nvl(z.debit,0)) over (partition by z.customer_party_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.customer_party_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.debit,0)) over () + sum(nvl(z.bbf,0)) over ()
    else null
   end cumulative_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.credit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row)
    when 'Customer Site Summary' then sum(nvl(z.credit,0)) over (partition by z.customer_party_site_id order by z.seq rows between unbounded preceding and current row)
    when 'Operating Unit Summary' then sum(nvl(z.credit,0)) over (partition by z.customer_party_id,z.organization_id order by z.seq rows between unbounded preceding and current row)
    when 'Customer Summary' then sum(nvl(z.credit,0)) over (partition by z.customer_party_id order by z.seq rows between unbounded preceding and current row)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.credit,0)) over ()
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
         null document_type,
         null document_number,
         to_date(null) document_date,
         to_date(null) maturity_date,
         null document_status,
         to_date(null) gl_date,
         to_number(null) debit,
         to_number(null) credit,
         to_number(null) original_amount,
         null currency_code,
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
         null document_type,
         null document_number,
         to_date(null) document_date,
         to_date(null) maturity_date,
         null document_status,
         to_date(null) gl_date,
         to_number(null) debit,
         to_number(null) credit,
         to_number(null) original_amount,
         null currency_code,
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
         'Operating Unit Summary' record_type,
         q_customer.customer_name,
         q_customer.customer_number,
         q_customer.customer_tax_ref_number customer_tax_registration,
         q_customer.organization_name operating_unit,
         null customer_site_name,
         null customer_site_number,
         null customer_address,
         null period_name,
         null document_type,
         null document_number,
         to_date(null) document_date,
         to_date(null) maturity_date,
         null document_status,
         to_date(null) gl_date,
         to_number(null) debit,
         to_number(null) credit,
         to_number(null) original_amount,
         null currency_code,
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
         null document_type,
         null document_number,
         to_date(null) document_date,
         to_date(null) maturity_date,
         null document_status,
         to_date(null) gl_date,
         to_number(null) debit,
         to_number(null) credit,
         to_number(null) original_amount,
         null currency_code,
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
         null document_type,
         null document_number,
         to_date(null) document_date,
         to_date(null) maturity_date,
         null document_status,
         to_date(null) gl_date,
         to_number(null) debit,
         to_number(null) credit,
         to_number(null) original_amount,
         null currency_code,
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
         q_main.transaction_type document_type,
         nvl(q_main.adjustment_number ,q_main.transaction_number) document_number,
         q_main.transaction_date document_date,
         q_main.transaction_due_date maturity_date,
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
         end document_status,
         q_main.gl_date gl_date,
         case q_main.trx_type
          when 'R' then to_number(null)
          else q_main.accounted_amount
         end debit,
         case q_main.trx_type
          when 'R' then
           case q_main.trx_status
            when 'REVERSED' then -1 * q_main.accounted_amount
            else q_main.accounted_amount
           end
          else to_number(null)
         end credit,
         case q_main.trx_status
          when 'REVERSED' then -1 * q_main.entered_amount
          else q_main.entered_amount
         end original_amount,
         q_main.transaction_currency currency_code,
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