/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
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

with q_supplier as (SELECT 
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
   AP_TP_STMT_PKG.balance_brought_forward(ass.vendor_id,ass.vendor_site_id,ass.org_id) balance_brought_forward
  FROM 
   ap_suppliers asup,
   ap_supplier_sites_all ass,
   hr_operating_units hro
  WHERE
   asup.vendor_id = ass.vendor_id
   AND ass.org_id = hro.organization_id
   AND asup.enabled_flag = 'Y' 
   &gc_reporting_entity 
   &gc_supplier_name 
   &gc_vend_type 
   &gc_pay_group 
   ),
q_main as (SELECT 
   'I' transaction_type,
   alc.displayed_field lookup_value,
   ai.invoice_type_lookup_code lookup_code,
   ai.invoice_num doc_number,
   TO_CHAR(ai.invoice_date, 'DD-MON-YYYY') doc_date,
   ai.payment_status_flag payment_status_flag,
   TO_CHAR(ai.gl_date, 'DD-MON-YYYY') gl_date,
   ai.invoice_currency_code currency_code,
   ai.invoice_amount * NVL(ai.exchange_rate,1) accounted_amount,
   ai.invoice_amount entered_amount,
   ai.description description,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   AP_INVOICES_PKG.get_posting_status (ai.invoice_id) posting_status,
   AP_INVOICES_PKG.get_wfapproval_status(ai.invoice_id,ai.org_id) approval_status,
   AP_TP_STMT_PKG.invoice_validate_status(ai.invoice_id) validate_status,
   fnd_date.date_to_chardate(ai.cancelled_date) cancel_date,
   ai.vendor_id,
   ai.vendor_site_id,
   'I' || ai.invoice_id id
  FROM 
   ap_invoices ai,
   gl_periods gp,
   gl_ledgers gled,
   ap_lookup_codes alc
  WHERE
   gled.period_set_name = gp.period_set_name
   AND gled.accounted_period_type = gp.period_type
   AND gp.adjustment_period_flag ='N'
   AND gled.ledger_id = ai.set_of_books_id
   AND ai.invoice_type_lookup_code = alc.lookup_code
   AND ai.invoice_type_lookup_code <> 'PREPAYMENT'
   AND alc.lookup_type = 'INVOICE TYPE'
   AND ai.gl_date BETWEEN gp.start_date AND gp.end_date
   AND ai.gl_date BETWEEN :P_FROM_GL_DATE AND :P_TO_GL_DATE
   AND AP_INVOICES_PKG.get_posting_status(ai.invoice_id) = DECODE(:P_ACCOUNTED,'ACCOUNTED','Y' ,'UNACCOUNTED','N' ,AP_INVOICES_PKG.get_posting_status(ai.invoice_id))
   and 1=1 
   &gc_unapproved_trx 
   &gc_currency 
   &gc_validate_inv 
   &gc_org_id 
  UNION ALL 
  SELECT 
   'P' transaction_type,
   alc.displayed_field lookup_value,
   ac.payment_method_lookup_code lookup_code,
   to_char(ac.check_number)||'/'||ai.invoice_num doc_number,
   TO_CHAR(ac.check_date, 'DD-MON-YYYY') doc_date,
   NULL payment_status_flag,
   TO_CHAR(aip.accounting_date, 'DD-MON-YYYY') gl_date,
   ac.currency_code currency_code,
   aip.amount * NVL(aip.exchange_rate,1) accounted_amount,
   aip.amount entered_amount,
   ac.description description ,
   gp.period_name gp_period_name,
   gp.period_num gp_period_num,
   gp.start_date gp_start_date,
   aip.accrual_posted_flag posting_status,
   alc1.displayed_field approval_status,
   NULL validate_status,
   NULL cancel_date,
   ac.vendor_id,
   ac.vendor_site_id,
   'P' || aip.invoice_payment_id id
  FROM 
   ap_invoices ai,
   ap_invoice_payments aip,
   ap_checks ac,
   gl_periods gp,
   gl_ledgers gled,
   ap_lookup_codes alc,
   ap_lookup_codes alc1
  WHERE
   aip.check_id = ac.check_id
   AND aip.invoice_id = ai.invoice_id
   AND gled.period_set_name = gp.period_set_name
   AND gled.accounted_period_type = gp.period_type
   AND gp.adjustment_period_flag ='N'
   AND gled.ledger_id = aip.set_of_books_id
   AND ac.payment_type_flag = alc.lookup_code
   AND alc.lookup_type = 'PAYMENT TYPE'
   AND alc1.lookup_type = 'CHECK STATE'
   AND ac.status_lookup_code = alc1.lookup_code
   AND aip.accounting_date BETWEEN gp.start_date AND gp.end_date
   AND aip.accounting_date BETWEEN :P_FROM_GL_DATE AND :P_TO_GL_DATE
   AND 2=2 
   &gc_pmt_accounted 
   &gc_pmt_org_id 
   &gc_pmt_currency 
   )
--
-- Main Query Start Here
--
select 
 :p_reporting_entity_name &reporting_entity_col_name ,
 q.Vendor_name supplier_name,
 q.Vendor_Number supplier_number,
 q.Vendor_Alternative_Name supplier_alt_name,
 q.Vendor_Tax_Registration supplier_tax_registration,
 q.Vendor_Site_Code supplier_site_code,
 q.Vendor_Site_Alternative_Code supplier_site_alt_code,
 q.vendor_site_address supplier_site_address, 
 &lp_operating_unit_column
 q.Period_Name,
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
    when 'Period Summary' then sum(nvl(z.Debit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row) - sum(nvl(z.Debit,0)) over (partition by z.vendor_site_id,z.period_name)
    when 'Supplier Site Summary' then 0
    when 'Operating Unit Summary' then 0
    when 'Supplier Summary' then 0
    when '&reporting_entity_col_name Summary' then 0
    else null
   end balance_bought_forward_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.Credit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_site_id) - sum(nvl(z.Credit,0)) over (partition by z.vendor_site_id,z.period_name)
    when 'Supplier Site Summary' then sum(nvl(z.bbf,0)) over (partition by z.vendor_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.bbf,0)) over (partition by z.vendor_id,z.organization_id)
    when 'Supplier Summary' then sum(nvl(z.bbf,0)) over (partition by z.vendor_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.bbf,0)) over ()
    else null
   end balance_bought_forward_credit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.Debit,0)) over (partition by z.vendor_site_id,z.period_name)
    when 'Supplier Site Summary' then sum(nvl(z.Debit,0)) over (partition by z.vendor_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.Debit,0)) over (partition by z.vendor_id,z.organization_id)
    when 'Supplier Summary' then sum(nvl(z.Debit,0)) over (partition by z.vendor_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.Debit,0)) over ()
    else null
   end net_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.Credit,0)) over (partition by z.vendor_site_id,z.period_name)
    when 'Supplier Site Summary' then sum(nvl(z.Credit,0)) over (partition by z.vendor_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.Credit,0)) over (partition by z.vendor_id,z.organization_id)
    when 'Supplier Summary' then sum(nvl(z.Credit,0)) over (partition by z.vendor_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.Credit,0)) over ()
    else null
   end net_credit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.Debit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row)
    when 'Supplier Site Summary' then sum(nvl(z.Debit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row)
    when 'Operating Unit Summary' then sum(nvl(z.Debit,0)) over (partition by z.vendor_id,z.organization_id order by z.seq rows between unbounded preceding and current row)
    when 'Supplier Summary' then sum(nvl(z.Debit,0)) over (partition by z.vendor_id order by z.seq rows between unbounded preceding and current row)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.Debit,0)) over ()
    else null
   end cumulative_debit,
   case z.record_type
    when 'Period Summary' then sum(nvl(z.Credit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_site_id)
    when 'Supplier Site Summary' then sum(nvl(z.Credit,0)) over (partition by z.vendor_site_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_site_id)
    when 'Operating Unit Summary' then sum(nvl(z.Credit,0)) over (partition by z.vendor_id,z.organization_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_id,z.organization_id)
    when 'Supplier Summary' then sum(nvl(z.Credit,0)) over (partition by z.vendor_id order by z.seq rows between unbounded preceding and current row) + sum(nvl(z.bbf,0)) over (partition by z.vendor_id)
    when '&reporting_entity_col_name Summary' then sum(nvl(z.Credit,0)) over () + sum(nvl(z.bbf,0)) over ()
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
         'Period Summary' Record_Type,
         q_supplier.vendor_name Vendor_name,
         q_supplier.vendor_number Vendor_Number,
         q_supplier.vendor_name_alt Vendor_Alternative_Name,
         q_supplier.vat_registration_num Vendor_Tax_Registration,
         q_supplier.organization_name Operating_Unit,
         q_supplier.vendor_site_code Vendor_Site_Code,
         q_supplier.vendor_site_code_alt Vendor_Site_Alternative_Code,
         q_supplier.vendor_site_address vendor_site_address,
         q_main.gp_period_name Period_Name,
         null Document_Type,
         null Document_Number,
         null Document_Date,
         null Document_Status,
         null GL_Date,
         null Description,
         to_number(null) Debit,
         to_number(null) Credit,
         to_number(null) Original_Amount,
         null Currency_Code,
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
         'Supplier Site Summary' Record_Type,
         q_supplier.vendor_name Vendor_name,
         q_supplier.vendor_number Vendor_Number,
         q_supplier.vendor_name_alt Vendor_Alternative_Name,
         q_supplier.vat_registration_num Vendor_Tax_Registration,
         q_supplier.organization_name Operating_Unit,
         q_supplier.vendor_site_code Vendor_Site_Code,
         q_supplier.vendor_site_code_alt Vendor_Site_Alternative_Code,
         q_supplier.vendor_site_address vendor_site_address,
         null Period_Name,
         null Document_Type,
         null Document_Number,
         null Document_Date,
         null Document_Status,
         null GL_Date,
         null Description,
         to_number(null) Debit,
         to_number(null) Credit,
         to_number(null) Original_Amount,
         null Currency_Code,
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
         'Operating Unit Summary' Record_Type,
         q_supplier.vendor_name Vendor_name,
         q_supplier.vendor_number Vendor_Number,
         q_supplier.vendor_name_alt Vendor_Alternative_Name,
         null Vendor_Tax_Registration,
         q_supplier.organization_name Operating_Unit,
         null Vendor_Site_Code,
         null Vendor_Site_Alternative_Code,
         null vendor_site_address,
         null Period_Name,
         null Document_Type,
         null Document_Number,
         null Document_Date,
         null Document_Status,
         null GL_Date,
         null Description,
         to_number(null) Debit,
         to_number(null) Credit,
         to_number(null) Original_Amount,
         null Currency_Code,
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
         :p_reporting_level != '3000' -- don't show OU Summary when run by OU
        union all 
        -- dummy supplier summary record
        select distinct 
         'Supplier Summary' Record_Type,
         q_supplier.vendor_name Vendor_name,
         q_supplier.vendor_number Vendor_Number,
         q_supplier.vendor_name_alt Vendor_Alternative_Name,
         null Vendor_Tax_Registration,
         null Operating_Unit,
         null Vendor_Site_Code,
         null Vendor_Site_Alternative_Code,
         null vendor_site_address,
         null Period_Name,
         null Document_Type,
         null Document_Number,
         null Document_Date,
         null Document_Status,
         null GL_Date,
         null Description,
         to_number(null) Debit,
         to_number(null) Credit,
         to_number(null) Original_Amount,
         null Currency_Code,
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
         '&reporting_entity_col_name Summary' Record_Type,
         null Vendor_name,
         null Vendor_Number,
         null Vendor_Alternative_Name,
         null Vendor_Tax_Registration,
         null Operating_Unit,
         null Vendor_Site_Code,
         null Vendor_Site_Alternative_Code,
         null vendor_site_address,
         null Period_Name,
         null Document_Type,
         null Document_Number,
         null Document_Date,
         null Document_Status,
         null GL_Date,
         null Description,
         to_number(null) Debit,
         to_number(null) Credit,
         to_number(null) Original_Amount,
         null Currency_Code,
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
         'Transaction' Record_Type,
         q_supplier.vendor_name Vendor_name,
         q_supplier.vendor_number Vendor_Number,
         q_supplier.vendor_name_alt Vendor_Alternative_Name,
         q_supplier.vat_registration_num Vendor_Tax_Registration,
         q_supplier.organization_name Operating_Unit,
         q_supplier.vendor_site_code Vendor_Site_Code,
         q_supplier.vendor_site_code_alt Vendor_Site_Alternative_Code,
         q_supplier.vendor_site_address vendor_site_address,
         q_main.gp_period_name Period_Name,
         case q_main.transaction_type
          when 'A' then 'Prepayment Application'
          else q_main.lookup_value
         end Document_Type,
         q_main.doc_number Document_Number,
         q_main.doc_date Document_Date,
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
         end Document_Status,
         q_main.gl_date GL_Date,
         q_main.description Description,
         case q_main.transaction_type
          when 'I' then to_number(null)
          else q_main.accounted_amount
         end Debit,
         case q_main.transaction_type
          when 'I' then q_main.accounted_amount
          else to_number(null)
         end Credit,
         q_main.entered_amount Original_Amount,
         q_main.currency_code Currency_Code,
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
       x.document_date) y) z
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