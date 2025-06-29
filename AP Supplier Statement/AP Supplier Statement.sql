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

with
q_main as
 (select
   'I' transaction_type,
   asup.segment1 vendor_number,
   asup.vendor_name vendor_name,
   asup.vendor_name_alt vendor_name_alt,
   ass.vendor_site_code vendor_site_code,
   ass.vendor_site_code_alt vendor_site_code_alt,
   ass.address_line1 ||' '|| ass.address_line2 ||' '|| ass.address_line3 ||' '|| ass.city ||' '|| ass.state ||' '|| ass.zip vendor_site_address,
   ass.vat_registration_num vat_registration_num,
   hro.name organization_name,
   ap_tp_stmt_pkg.balance_brought_forward(ass.vendor_id,ass.vendor_site_id,ass.org_id) balance_brought_forward,
   alc.displayed_field lookup_value,
   ai.invoice_type_lookup_code lookup_code,
   ai.invoice_num doc_number,
   to_char(ai.doc_sequence_value) voucher_number,
   ai.invoice_date doc_date,
   ai.payment_status_flag,
   ai.gl_date,
   ai.invoice_currency_code currency_code,
   ai.invoice_amount entered_amount,
   nvl(ai.base_amount,round(ai.invoice_amount * nvl(ai.exchange_rate,1),2)) accounted_amount,
   --
   to_number(null) paid_amount,
   to_number(null) inv_disc_taken,
   to_number(null) inv_paid_amount,
   to_number(null) paid_exchange_rate,
   nvl(ai.exchange_rate,1) inv_exchange_rate,
   --
   ai.description description,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   ap_invoices_pkg.get_posting_status (ai.invoice_id) posting_status,
   ap_invoices_pkg.get_wfapproval_status(ai.invoice_id,ai.org_id) approval_status,
   ap_tp_stmt_pkg.invoice_validate_status(ai.invoice_id) validate_status,
   ai.cancelled_date cancel_date,
   (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = ai.accts_pay_code_combination_id) liability_account,
   ai.vendor_id,
   ai.vendor_site_id,
   hro.organization_id,
   'I' || ai.invoice_id id
  from
   ap_invoices ai,
   ap_suppliers asup,
   ap_supplier_sites_all ass,
   hr_operating_units hro,
   gl_periods gp,
   gl_ledgers gled,
   ap_lookup_codes alc
  where
       ai.vendor_id = asup.vendor_id
   and asup.enabled_flag = 'Y'
   and ai.vendor_site_id = ass.vendor_site_id
   and ass.org_id = hro.organization_id
   and gled.period_set_name = gp.period_set_name
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
   and 3=3
   &gc_reporting_entity
   &gc_unapproved_trx
   &gc_currency
   &gc_validate_inv
   &gc_org_id
  union all
  select
   decode(ai.invoice_type_lookup_code,'PREPAYMENT','A','P') transaction_type,
   asup.segment1 vendor_number,
   asup.vendor_name vendor_name,
   asup.vendor_name_alt vendor_name_alt,
   ass.vendor_site_code vendor_site_code,
   ass.vendor_site_code_alt vendor_site_code_alt,
   ass.address_line1 ||' '|| ass.address_line2 ||' '|| ass.address_line3 ||' '|| ass.city ||' '|| ass.state ||' '|| ass.zip vendor_site_address,
   ass.vat_registration_num vat_registration_num,
   hro.name organization_name,
   ap_tp_stmt_pkg.balance_brought_forward(ass.vendor_id,ass.vendor_site_id,ass.org_id) balance_brought_forward,
   alc.displayed_field lookup_value,
   ac.payment_method_lookup_code lookup_code,
   to_char(ac.check_number)||'/'||ai.invoice_num doc_number,
   to_char(ac.doc_sequence_value) voucher_number,
   ac.check_date doc_date,
   null payment_status_flag,
   aip.accounting_date gl_date,
   ac.currency_code currency_code,
   aip.amount entered_amount,
   nvl(aip.payment_base_amount,round(aip.amount * nvl(aip.exchange_rate,1),2)) accounted_amount,
   --
   -- for Gain/Loss Calculation
   aip.amount                              paid_amount,
   aip.discount_taken                      inv_disc_taken,
   aip.amount + nvl(aip.discount_taken,0)  inv_paid_amount,
   nvl(aip.exchange_rate,1)                paid_exchange_rate,
   nvl(case
       when nvl(aip.exchange_rate,1) = 1
       then 1
       when ai.invoice_type_lookup_code='PREPAYMENT'
       then (select
             nvl(ai2.exchange_rate,1)
             from
             ap_prepay_history aph2,
             ap_invoices ai2
             where
             aph2.prepay_invoice_id = ai.invoice_id and
             aph2.invoice_id = ai2.invoice_id and
             ai2.invoice_currency_code = ai2.payment_currency_code and
             ai2.payment_currency_code = ac.currency_code and
             rownum <= 1
            )
       else null
       end,
       case
       when ai.invoice_currency_code = ai.payment_currency_code
       and  ai.payment_currency_code = ac.currency_code
       then nvl(ai.exchange_rate,1)
       else nvl(aip.exchange_rate,1)
       end
   )  inv_exchange_rate,
   --
   ac.description description ,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   aip.accrual_posted_flag posting_status,
   alc1.displayed_field approval_status,
   null validate_status,
   to_date(null) cancel_date,
   (select gcck.concatenated_segments from gl_code_combinations_kfv gcck where gcck.code_combination_id = ai.accts_pay_code_combination_id) liability_account,
   ac.vendor_id,
   ac.vendor_site_id,
   hro.organization_id,
   'P' || aip.invoice_payment_id id
  from
   ap_invoices ai,
   ap_invoice_payments aip,
   ap_checks ac,
   ap_suppliers asup,
   ap_supplier_sites_all ass,
   hr_operating_units hro,
   gl_periods gp,
   gl_ledgers gled,
   ap_lookup_codes alc,
   ap_lookup_codes alc1
  where
       aip.check_id = ac.check_id
   and aip.invoice_id = ai.invoice_id
   and ac.vendor_id = asup.vendor_id
   and asup.enabled_flag = 'Y'
   and ac.vendor_site_id = ass.vendor_site_id
   and ass.org_id = hro.organization_id
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
   and 3=3
   &gc_reporting_entity
   &gc_pmt_accounted
   &gc_pmt_org_id
   &gc_pmt_currency
 ),
q_supplier as
 (select
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
   ap_tp_stmt_pkg.balance_brought_forward(ass.vendor_id,ass.vendor_site_id,ass.org_id) balance_brought_forward,
   row_number() over (partition by asup.vendor_id order by ass.vendor_site_code) site_count
  from
   ap_suppliers asup,
   ap_supplier_sites_all ass,
   hr_operating_units hro
  where
       asup.vendor_id = ass.vendor_id
   and ass.org_id = hro.organization_id
   and asup.enabled_flag = 'Y'
   and 3=3
   &gc_reporting_entity
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
 replace(q.record_type,'_',' ') record_type
 &lp_report_level_columns
from
 (select
   z.*,
   case when z.record_type like '%Summary' then 0 else null end balance_bought_forward_debit,
   case when z.record_type like '%Summary' then sum(nvl(z.bbf,0)) over (partition by z.vendor_id,z.organization_id,z.vendor_site_id) else null end balance_bought_forward_credit,
   case z.record_type
    when 'Supplier Site Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_id,z.organization_id,z.vendor_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_id,z.organization_id)
    when 'Supplier Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_id)
    else null
   end net_debit,
   case z.record_type
    when 'Supplier Site Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_id,z.organization_id,z.vendor_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_id,z.organization_id)
    when 'Supplier Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_id)
    else null
   end net_credit,
   case z.record_type
    when 'Supplier Site Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_id,z.organization_id,z.vendor_site_id order by z.seq rows between unbounded preceding and current row)
    when 'Operating Unit Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_id,z.organization_id order by z.seq rows between unbounded preceding and current row)
    when 'Supplier Summary' then sum(nvl(z.debit,0)) over (partition by z.vendor_id order by z.seq rows between unbounded preceding and current row)
    else null
   end cumulative_debit,
   case z.record_type
    when 'Supplier Site Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_id,z.organization_id,z.vendor_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_id,z.organization_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_id,z.organization_id)
    when 'Supplier Summary' then sum(nvl(z.credit,0)) over (partition by z.vendor_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_id)
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
       (-- summary record
        select
         nvl(:p_summary_level,'Supplier') || ' Summary' record_type,
         q_supplier.vendor_name vendor_name,
         q_supplier.vendor_number vendor_number,
         q_supplier.vendor_name_alt vendor_alternative_name,
         case when nvl(:p_summary_level,'Supplier') = 'Supplier Site' then q_supplier.vat_registration_num else null end vendor_tax_registration,
         case when nvl(:p_summary_level,'Supplier') in ('Supplier Site','Operating Unit') then q_supplier.organization_name else null end operating_unit,
         case when nvl(:p_summary_level,'Supplier') = 'Supplier Site' then q_supplier.vendor_site_code else null end vendor_site_code,
         case when nvl(:p_summary_level,'Supplier') = 'Supplier Site' then q_supplier.vendor_site_code_alt else null end  vendor_site_alternative_code,
         case when nvl(:p_summary_level,'Supplier') = 'Supplier Site' then q_supplier.vendor_site_address else null end vendor_site_address,
         null period_name,
         null document_type,
         null document_number,
         null voucher_number,
         to_date(null) document_date,
         null document_status,
         to_date(null) gl_date,
         null description,
         to_number(null) debit,
         to_number(null) credit,
         to_number(null) currency_gain_loss,
         to_number(null) discount_taken,
         --
         to_number(null) original_amount,
         null currency_code,
         null liability_account,
         1 sort_order,
         to_date(null) period_start_date,
         to_number(null) period_num,
         q_supplier.vendor_id,
         case when nvl(:p_summary_level,'Supplier') = 'Supplier Site' then q_supplier.vendor_site_id else null end vendor_site_id,
         case when nvl(:p_summary_level,'Supplier') in ('Supplier Site','Operating Unit') then q_supplier.organization_id else null end organization_id,
         sum(q_supplier.balance_brought_forward) bbf
        from
         q_supplier
        where
         :p_report_level in ('BOTH','SUMMARY')
        group by
         q_supplier.vendor_name,
         q_supplier.vendor_number,
         q_supplier.vendor_name_alt,
         case when nvl(:p_summary_level,'Supplier') = 'Supplier Site' then q_supplier.vat_registration_num else null end,
         case when nvl(:p_summary_level,'Supplier') in ('Supplier Site','Operating Unit') then q_supplier.organization_name else null end,
         case when nvl(:p_summary_level,'Supplier') = 'Supplier Site' then q_supplier.vendor_site_code else null end,
         case when nvl(:p_summary_level,'Supplier') = 'Supplier Site' then q_supplier.vendor_site_code_alt else null end,
         case when nvl(:p_summary_level,'Supplier') = 'Supplier Site' then q_supplier.vendor_site_address else null end,
         q_supplier.vendor_id,
         case when nvl(:p_summary_level,'Supplier') = 'Supplier Site' then q_supplier.vendor_site_id else null end,
         case when nvl(:p_summary_level,'Supplier') in ('Supplier Site','Operating Unit') then q_supplier.organization_id else null end
        union all
        -- transaction records
        select
         'Transaction' record_type,
         q_main.vendor_name vendor_name,
         q_main.vendor_number vendor_number,
         q_main.vendor_name_alt vendor_alternative_name,
         q_main.vat_registration_num vendor_tax_registration,
         q_main.organization_name operating_unit,
         q_main.vendor_site_code vendor_site_code,
         q_main.vendor_site_code_alt vendor_site_alternative_code,
         q_main.vendor_site_address vendor_site_address,
         q_main.gp_period_name period_name,
         case q_main.transaction_type
          when 'A' then 'Prepayment Application'
          else q_main.lookup_value
         end document_type,
         q_main.doc_number document_number,
         q_main.voucher_number,
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
         --
         case q_main.transaction_type
          when 'I' then to_number(null)
          else round(q_main.inv_paid_amount * q_main.inv_exchange_rate,2)
         end debit,
         case q_main.transaction_type
          when 'I' then q_main.accounted_amount
          else to_number(null)
         end credit,
         case when q_main.transaction_type != 'I'
         and  q_main.inv_exchange_rate != q_main.paid_exchange_rate
         and  round(q_main.paid_amount * q_main.inv_exchange_rate,2) - round(q_main.paid_amount * q_main.paid_exchange_rate,2) != 0
         then round(q_main.paid_amount * q_main.inv_exchange_rate,2) - round(q_main.paid_amount * q_main.paid_exchange_rate,2)
         else null
         end  currency_gain_loss,
         decode(nvl(q_main.inv_disc_taken,0),0,to_number(null),round(q_main.inv_paid_amount * q_main.inv_exchange_rate,2) - round(q_main.paid_amount * q_main.inv_exchange_rate,2)) discount_taken,
         --
         q_main.entered_amount original_amount,
         q_main.currency_code,
         q_main.liability_account,
         -1 sort_order,
         q_main.gp_start_date period_start_date,
         q_main.gp_period_num period_num,
         q_main.vendor_id,
         q_main.vendor_site_id,
         q_main.organization_id,
         to_number(null) bbf
        from
         q_main
       ) x
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
     (:p_incl_zero_bal_sup = 'Y' or nvl(y.supplier_closing_balance,0) != 0)
   ) z
  order by
   z.seq
 ) q
where
 (   (:p_report_level = 'BOTH')
  or (:p_report_level = 'TRANSACTION' and q.record_type = 'Transaction')
  or (:p_report_level = 'SUMMARY' and q.record_type like '%Summary')
 )
order by
 q.seq