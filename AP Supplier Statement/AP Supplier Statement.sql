/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Supplier Statement
-- Description: Application: Payables
Source: Supplier Statement
Short Name: APTPSTMT
DB package: AP_TP_STMT_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ap-supplier-statement/
-- Library Link: https://www.enginatics.com/reports/ap-supplier-statement/
-- Run Report: https://demo.enginatics.com/

with q_supplier as (select
   asup.segment1 vendor_number,
   asup.vendor_name vendor_name,
   asup.vendor_name_alt vendor_name_alt,
   asup.vendor_id vendor_id,
   ass.vendor_site_id vendor_site_id,
   ass.vendor_site_code vendor_site_code,
   ass.vendor_site_code_alt vendor_site_code_alt,
   ass.address_line1 ||' '|| ass.address_line2 ||' '|| ass.address_line3 ||' '|| ass.city ||' '|| ass.state ||' '|| ass.zip vendor_site_address,
   ass.vat_registration_num vat_registration_num,
   hro.name organization_name,
   hro.organization_id organization_id,
   ap_tp_stmt_pkg.balance_brought_forward(ass.vendor_id,ass.vendor_site_id,ass.org_id) balance_brought_forward
  from
   ap_suppliers asup,
   ap_supplier_sites_all ass,
   hr_operating_units hro
  where
   asup.vendor_id = ass.vendor_id
   and ass.org_id = hro.organization_id
   and asup.enabled_flag = 'Y'
   &gc_reporting_entity
   &gc_supplier_name
   &gc_vend_type
   &gc_pay_group
   ),
q_main as (select
   'I' transaction_type,
   alc.displayed_field lookup_value,
   ai.invoice_type_lookup_code lookup_code,
   ai.invoice_num doc_number,
   ai.invoice_date doc_date,
   ai.payment_status_flag,
   ai.gl_date,
   ai.invoice_currency_code currency_code,
   ai.invoice_amount entered_amount,
   ai.invoice_amount * nvl(ai.exchange_rate,1) accounted_amount,
   to_number(null) currency_gain_loss,
   to_number(null) discount_taken,
   ai.description description,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   ap_invoices_pkg.get_posting_status (ai.invoice_id) posting_status,
   ap_invoices_pkg.get_wfapproval_status(ai.invoice_id,ai.org_id) approval_status,
   ap_tp_stmt_pkg.invoice_validate_status(ai.invoice_id) validate_status,
   ai.cancelled_date cancel_date,
   ai.vendor_id,
   ai.vendor_site_id,
   'I' || ai.invoice_id id
  from
   ap_invoices ai,
   gl_periods gp,
   gl_ledgers gled,
   ap_lookup_codes alc
  where
       gled.period_set_name = gp.period_set_name
   and gled.accounted_period_type = gp.period_type
   and gp.adjustment_period_flag ='N'
   and gled.ledger_id = ai.set_of_books_id
   and ai.invoice_type_lookup_code = alc.lookup_code
   and ai.invoice_type_lookup_code <> 'PREPAYMENT'
   and alc.lookup_type = 'INVOICE TYPE'
   and ai.gl_date between gp.start_date and gp.end_date
   and ai.gl_date between :p_from_gl_date and :p_to_gl_date
   and ap_invoices_pkg.get_posting_status(ai.invoice_id) = decode(:p_accounted,'ACCOUNTED','Y' ,'UNACCOUNTED','N' ,ap_invoices_pkg.get_posting_status(ai.invoice_id))
   and 1=1
   &gc_unapproved_trx
   &gc_currency
   &gc_validate_inv
   &gc_org_id
  union all
  select
   'P' transaction_type,
   alc.displayed_field lookup_value,
   ac.payment_method_lookup_code lookup_code,
   to_char(ac.check_number)||'/'||ai.invoice_num doc_number,
   ac.check_date doc_date,
   null payment_status_flag,
   aip.accounting_date gl_date,
   ac.currency_code currency_code,
   aip.amount entered_amount,
   -- aip.amount * nvl(aip.exchange_rate,1) accounted_amount,
   (select sum(apda.base_amount) from ap_payment_distributions_all apda where apda.invoice_payment_id = aip.invoice_payment_id) accounted_amount,
   (select sum(apda.base_amount) from ap_payment_distributions_all apda where apda.invoice_payment_id = aip.invoice_payment_id and apda.line_type_lookup_code in ('GAIN','LOSS')) currency_gain_loss,
   (select sum(apda.base_amount) from ap_payment_distributions_all apda where apda.invoice_payment_id = aip.invoice_payment_id and apda.line_type_lookup_code = 'DISCOUNT') discount_taken,
   ac.description description ,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   aip.accrual_posted_flag posting_status,
   alc1.displayed_field approval_status,
   null validate_status,
   to_date(null) cancel_date,
   ac.vendor_id,
   ac.vendor_site_id,
   'P' || aip.invoice_payment_id id
  from
   ap_invoices ai,
   ap_invoice_payments aip,
   ap_checks ac,
   gl_periods gp,
   gl_ledgers gled,
   ap_lookup_codes alc,
   ap_lookup_codes alc1
  where
   aip.check_id = ac.check_id
   and aip.invoice_id = ai.invoice_id
   and gled.period_set_name = gp.period_set_name
   and gled.accounted_period_type = gp.period_type
   and gp.adjustment_period_flag ='N'
   and gled.ledger_id = aip.set_of_books_id
   and ac.payment_type_flag = alc.lookup_code
   and alc.lookup_type = 'PAYMENT TYPE'
   and alc1.lookup_type = 'CHECK STATE'
   and ac.status_lookup_code = alc1.lookup_code
   and aip.accounting_date between gp.start_date and gp.end_date
   and aip.accounting_date between :p_from_gl_date and :p_to_gl_date
   and 2=2
   &gc_pmt_accounted
   &gc_pmt_org_id
   &gc_pmt_currency
   )
--
-- main query start here
--
select
 :p_reporting_entity_name &reporting_entity_col_name,
 q.vendor_name supplier_name,
 q.vendor_number supplier_number,
 q.vendor_alternative_name supplier_alt_name,
 q.vendor_tax_registration supplier_tax_registration,
 q.vendor_site_code supplier_site_code,
 q.vendor_site_alternative_code supplier_site_alt_code,
 q.vendor_site_address supplier_site_address,
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
    when 'Period Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row) - sum(nvl(z.debit,0)) over (partition by z.vendor_site_id,z.period_name)
    when 'Supplier Site Summary' then 0
    when 'Operating Unit Summary' then 0
    when 'Supplier Summary' then 0
    when '&reporting_entity_col_name Summary' then 0
    else null
   end balance_bought_forward_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_site_id) - sum(nvl(z.credit,0)) over (partition by z.vendor_site_id,z.period_name)
    when 'Supplier Site Summary' then sum(nvl(z.bbf,0)) over (partition by z.vendor_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.bbf,0)) over (partition by z.vendor_id,z.organization_id)
    when 'Supplier Summary' then sum(nvl(z.bbf,0)) over (partition by z.vendor_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.bbf,0)) over ()
    else null
   end balance_bought_forward_credit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_site_id,z.period_name)
    when 'Supplier Site Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_id,z.organization_id)
    when 'Supplier Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.debit,0)) over ()
    else null
   end net_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_site_id,z.period_name)
    when 'Supplier Site Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_id,z.organization_id)
    when 'Supplier Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.credit,0)) over ()
    else null
   end net_credit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row)
    when 'Supplier Site Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row)
    when 'Operating Unit Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_id,z.organization_id order by z.seq rows between unbounded preceding and current row)
    when 'Supplier Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_id order by z.seq rows between unbounded preceding and current row)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.debit,0)) over ()
    else null
   end cumulative_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_site_id)
    when 'Supplier Site Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_id,z.organization_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_id,z.organization_id)
    when 'Supplier Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.credit,0)) over () + sum(nvl(z.bbf,0)) over ()
    else null
   end cumulative_credit
  from
   (select
     rownum seq,
     y.*
    from
     (select
       x.*,
       sum(nvl(x.bbf,0)) over (partition by x.vendor_id) +
       sum(nvl(x.credit,0)) over (partition by x.vendor_id) -
       sum(nvl(x.debit,0)) over (partition by x.vendor_id) supplier_closing_balance
      from
       (-- dummy period summary record
         select distinct
         'Period Summary' record_type,
         q_supplier.vendor_name vendor_name,
         q_supplier.vendor_number vendor_number,
         q_supplier.vendor_name_alt vendor_alternative_name,
         q_supplier.vat_registration_num vendor_tax_registration,
         q_supplier.organization_name operating_unit,
         q_supplier.vendor_site_code vendor_site_code,
         q_supplier.vendor_site_code_alt vendor_site_alternative_code,
         q_supplier.vendor_site_address vendor_site_address,
         q_main.gp_period_name period_name,
         null document_type,
         null document_number,
         to_date(null) document_date,
         null document_status,
         to_date(null) gl_date,
         null description,
         to_number(null) debit,
         to_number(null) credit,
         to_number(null) currency_gain_loss,
         to_number(null) discount_taken,
         to_number(null) original_amount,
         null currency_code,
         1 sort_order,
         q_main.gp_start_date period_start_date,
         q_main.gp_period_num period_num,
         q_supplier.vendor_id,
         q_supplier.vendor_site_id,
         q_supplier.organization_id,
         to_number(null) bbf
        from
         q_supplier,
         q_main
        where
         q_main.vendor_id = q_supplier.vendor_id
         and q_main.vendor_site_id = q_supplier.vendor_site_id
        union all
        -- dummy supplier site summary record
        select distinct
         'Supplier Site Summary' record_type,
         q_supplier.vendor_name vendor_name,
         q_supplier.vendor_number vendor_number,
         q_supplier.vendor_name_alt vendor_alternative_name,
         q_supplier.vat_registration_num vendor_tax_registration,
         q_supplier.organization_name operating_unit,
         q_supplier.vendor_site_code vendor_site_code,
         q_supplier.vendor_site_code_alt vendor_site_alternative_code,
         q_supplier.vendor_site_address vendor_site_address,
         null period_name,
         null document_type,
         null document_number,
         to_date(null) document_date,
         null document_status,
         to_date(null) gl_date,
         null description,
         to_number(null) debit,
         to_number(null) credit,
         to_number(null) currency_gain_loss,
         to_number(null) discount_taken,
         to_number(null) original_amount,
         null currency_code,
         2 sort_order,
         to_date(null) period_start_date,
         to_number(null) period_num,
         q_supplier.vendor_id,
         q_supplier.vendor_site_id,
         q_supplier.organization_id,
         q_supplier.balance_brought_forward bbf
        from
         q_supplier
        union all
        -- dummy operating unit summary record
        select distinct
         'Operating Unit Summary' record_type,
         q_supplier.vendor_name vendor_name,
         q_supplier.vendor_number vendor_number,
         q_supplier.vendor_name_alt vendor_alternative_name,
         null vendor_tax_registration,
         q_supplier.organization_name operating_unit,
         null vendor_site_code,
         null vendor_site_alternative_code,
         null vendor_site_address,
         null period_name,
         null document_type,
         null document_number,
         to_date(null) document_date,
         null document_status,
         to_date(null) gl_date,
         null description,
         to_number(null) debit,
         to_number(null) credit,
         to_number(null) currency_gain_loss,
         to_number(null) discount_taken,
         to_number(null) original_amount,
         null currency_code,
         3 sort_order,
         to_date(null) period_start_date,
         to_number(null) period_num,
         q_supplier.vendor_id,
         to_number(null) vendor_site_id,
         q_supplier.organization_id,
         to_number(null) bbf
        from
         q_supplier
        where
         :p_reporting_level != '3000' -- don't show ou summary when run by ou
        union all
        -- dummy supplier summary record
        select distinct
         'Supplier Summary' record_type,
         q_supplier.vendor_name vendor_name,
         q_supplier.vendor_number vendor_number,
         q_supplier.vendor_name_alt vendor_alternative_name,
         null vendor_tax_registration,
         null operating_unit,
         null vendor_site_code,
         null vendor_site_alternative_code,
         null vendor_site_address,
         null period_name,
         null document_type,
         null document_number,
         to_date(null) document_date,
         null document_status,
         to_date(null) gl_date,
         null description,
         to_number(null) debit,
         to_number(null) credit,
         to_number(null) currency_gain_loss,
         to_number(null) discount_taken,
         to_number(null) original_amount,
         null currency_code,
         4 sort_order,
         to_date(null) period_start_date,
         to_number(null) period_num,
         q_supplier.vendor_id,
         to_number(null) vendor_site_id,
         to_number(null) organization_id,
         to_number(null) bbf
        from
         q_supplier
        union all
        -- dummy reporting entity summary record
        select distinct
         '&reporting_entity_col_name Summary' record_type,
         null vendor_name,
         null vendor_number,
         null vendor_alternative_name,
         null vendor_tax_registration,
         null operating_unit,
         null vendor_site_code,
         null vendor_site_alternative_code,
         null vendor_site_address,
         null period_name,
         null document_type,
         null document_number,
         to_date(null) document_date,
         null document_status,
         to_date(null) gl_date,
         null description,
         to_number(null) debit,
         to_number(null) credit,
         to_number(null) currency_gain_loss,
         to_number(null) discount_taken,
         to_number(null) original_amount,
         null currency_code,
         5 sort_order,
         to_date(null) period_start_date,
         to_number(null) period_num,
         to_number(null) vendor_id,
         to_number(null) vendor_site_id,
         to_number(null) organization_id,
         to_number(null) bbf
        from
         dual
        union all
        -- transactions
        select
         'Transaction' record_type,
         q_supplier.vendor_name vendor_name,
         q_supplier.vendor_number vendor_number,
         q_supplier.vendor_name_alt vendor_alternative_name,
         q_supplier.vat_registration_num vendor_tax_registration,
         q_supplier.organization_name operating_unit,
         q_supplier.vendor_site_code vendor_site_code,
         q_supplier.vendor_site_code_alt vendor_site_alternative_code,
         q_supplier.vendor_site_address vendor_site_address,
         q_main.gp_period_name period_name,
         case q_main.transaction_type
          when 'A' then 'Prepayment Application'
          else q_main.lookup_value
         end document_type,
         q_main.doc_number document_number,
         q_main.doc_date document_date,
         nvl2(q_main.cancel_date,'Cancelled/ ',null) || case q_main.validate_status
          when 'Y' then 'Validated/ '
          when 'N' then 'Un-Validated/ '
          else null
         end ||case q_main.posting_status
          when 'Y' then 'Accounted'
          when 'N' then 'Not Accounted'
          else null
         end ||case q_main.lookup_code
          when 'PA' then '/ Applied'
          else null
         end document_status,
         q_main.gl_date,
         q_main.description,
         case q_main.transaction_type
          when 'I' then to_number(null)
          else q_main.accounted_amount
         end debit,
         case q_main.transaction_type
          when 'I' then q_main.accounted_amount
          else to_number(null)
         end credit,
         q_main.currency_gain_loss,
         q_main.discount_taken,
         q_main.entered_amount original_amount,
         q_main.currency_code,
         -1 sort_order,
         q_main.gp_start_date period_start_date,
         q_main.gp_period_num period_num,
         q_supplier.vendor_id,
         q_supplier.vendor_site_id,
         q_supplier.organization_id,
         to_number(null) bbf
        from
         q_supplier,
         q_main
        where
         q_main.vendor_id = q_supplier.vendor_id
         and q_main.vendor_site_id = q_supplier.vendor_site_id ) x
      order by
       x.vendor_name,
       x.vendor_number,
       x.operating_unit,
       x.vendor_site_code,
       nvl(x.period_start_date,to_date('31/12/4712','DD/MM/YYYY')),
       nvl(x.period_num,99),
       nvl(x.period_name,'####'),
       x.sort_order,
       x.gl_date,
       x.document_date
     ) y
    where
     (:p_incl_zero_bal_sup = 'Y' or y.vendor_id is null or nvl(y.supplier_closing_balance,0) != 0)
   ) z
  order by
   z.seq) q
where
 (   (:p_summary_only = 'N' and q.record_type = 'Transaction')
  or (:p_summary_level = 'Period' and q.record_type not in ('Transaction'))
  or (:p_summary_level = 'Supplier Site' and q.record_type not in ('Period Summary','Transaction'))
  or (:p_summary_level = 'Operating Unit' and q.record_type not in ('Supplier Site Summary','Period Summary','Transaction'))
  or (:p_summary_level = 'Supplier' and q.record_type = 'Supplier Summary')
  or (:p_reporting_level = '3000' and q.record_type = 'Operating_Unit Summary')
  or (:p_reporting_level = '1000' and q.record_type = 'Ledger Summary')
 )
order by
 q.seq