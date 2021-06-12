/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Transactions and Lines
-- Description: AR transaction report.
Can be run at Header, Line and/or Distribution Level
Optionally include special columns for service contracts (OKS) and lease contracts (OKL) data
-- Excel Examle Output: https://www.enginatics.com/example/ar-transactions-and-lines/
-- Library Link: https://www.enginatics.com/reports/ar-transactions-and-lines/
-- Run Report: https://demo.enginatics.com/

with ar_inv as
(
select
 gl.name ledger,
 haouv.name operating_unit,
 acia.cons_billing_number invoice_number,
 rcta.trx_number,
 rcta.trx_date,
 xxen_util.meaning(apsa.class,'INV/CM/ADJ',222) class,
 apsa.class class_,
 rctta.name type,
 rbsa.name batch_source,
 rba.name batch_name,
 rcta.ct_reference reference,
 rcta.purchase_order,
 ( select nvl2(acia0.cons_billing_number,acia0.cons_billing_number||' - ',null)||rcta0.trx_number credited_invoice
   from  ra_customer_trx_all rcta0,
         ar_cons_inv_trx_all acita0,
         ar_cons_inv_all acia0
   where rcta.previous_customer_trx_id = rcta0.customer_trx_id and
         rcta0.customer_trx_id = acita0.customer_trx_id(+) and
         acita0.cons_inv_id = acia0.cons_inv_id(+)
 ) credited_invoice,
 ( select rctla0.line_number
   from   ra_customer_trx_lines_all rctla0
   where  rctla.previous_customer_trx_line_id = rctla0.customer_trx_line_id
 ) credited_invoice_line,
 hca.account_number,
 hp.party_name,
 hcsua.location bill_to_location,
 hz_format_pub.format_address(hps.location_id,null,null,' , ') bill_to_address,
 hp.jgzz_fiscal_code taxpayer_id,
 rcta.invoice_currency_code currency,
 apsa.amount_due_original total_due_original,
 apsa.tax_original        tax_amount,
 apsa.amount_applied total_payment_applied,
 apsa.amount_adjusted total_adjustment,
 apsa.amount_credited total_credit,
 apsa.amount_due_remaining total_due_remaining,
 apsa.amount_due_original * nvl(apsa.exchange_rate,1) accounted_total_due_original,
 apsa.tax_original * nvl(apsa.exchange_rate,1) accounted_tax_amount,   
 apsa.acctd_amount_due_remaining accounted_total_due_remaining,
 case when rctta.accounting_affect_flag='Y' and apsa.amount_in_dispute<>0 then apsa.amount_in_dispute end dispute_amount,
 xxen_util.meaning(apsa.status,'PAYMENT_SCHEDULE_STATUS',222) status,
 decode(rcta.invoicing_rule_id,-3,'Arrears','Advance') invoicing_rule,
 rtt.name payment_term,
 apsa.number_of_due_dates,
 apsa.terms_sequence_number,
 apsa.due_date,
 case when apsa.class in ('INV','DM') and apsa.status='OP' then greatest(trunc(sysdate)-apsa.due_date,0) end overdue_days,
 rcta.ship_date_actual ship_date,
 arm.name receipt_method,
 apsa.actual_date_closed,
 apsa.gl_date payment_sched_gl_date,
 apsa.gl_date_closed payment_sched_gl_date_closed,
 ifpct.payment_channel_name payment_method,
 decode(ipiua.instrument_type,'BANKACCOUNT',ieba.masked_bank_account_num,'CREDITCARD',ic.masked_cc_number) instrument_number,
 xxen_util.meaning(rcta.printing_option,'INVOICE_PRINT_OPTIONS',222) print_option,
 rcta.printing_original_date first_printed_date,
 rcta.customer_reference,
 rcta.comments,
 jrrev.resource_name salesperson,
 rtk.concatenated_segments sales_region,
 rtk.name sales_region_name, 
 xxen_util.user_name(rcta.created_by) trx_created_by,
 rcta.creation_date trx_creation_date,
 rcta.last_update_date trx_last_updated,
 rcta.customer_trx_id,
 apsa.payment_schedule_id,   
 case apsa.payment_schedule_id
 when lag(apsa.payment_schedule_id,1,-1) over (order by rcta.customer_trx_id,nvl(apsa.terms_sequence_number,1),nvl(rctla.line_number,-1))
 then 'N'
 else 'Y'
 end first_psched,
 ----------line----------
 decode(rctla.line_type,'FREIGHT',null,rctla.line_number) line_number,
 xxen_util.meaning(rctla.line_type,'STD_LINE_TYPE',222) line_type,
 ( select msibk.concatenated_segments
   from   mtl_system_items_b_kfv msibk
   where  msibk.inventory_item_id = rctla.inventory_item_id
   and    msibk.organization_id   = nvl(rctla.warehouse_id,ospa.parameter_value)
 ) item,
 rctla.description line_description,
 ( select muomt.unit_of_measure_tl
   from   mtl_units_of_measure_tl muomt
   where  muomt.uom_code = rctla.uom_code and
          muomt.language = userenv('lang') and
          rownum = 1
 ) uom_code,
 nvl(rctla.quantity_credited,rctla.quantity_invoiced) quantity,
 rctla.unit_selling_price unit_price,
 rctla.extended_amount line_amount,
 ( select 
    sum(rctla2.extended_amount)
   from  
    ra_customer_trx_lines_all rctla2
   where 
    rctla.customer_trx_line_id=rctla2.link_to_cust_trx_line_id and
    rctla2.line_type='TAX'
 ) line_tax_amount,
 rctla.extended_amount * nvl(apsa.exchange_rate,1) line_accounted_amount,   
 ( select 
    sum(rctla2.extended_amount) * nvl(apsa.exchange_rate,1)
   from  
    ra_customer_trx_lines_all rctla2
   where 
    rctla.customer_trx_line_id=rctla2.link_to_cust_trx_line_id and
    rctla2.line_type='TAX'
 ) line_accounted_tax_amount,   
 ( select 
    listagg (rctla2.tax_rate,', ') within group (order by rctla2.tax_rate)
   from   
    ra_customer_trx_lines_all rctla2
   where  
    rctla.customer_trx_line_id = rctla2.link_to_cust_trx_line_id and
    rctla2.line_type='TAX'
 ) tax_rates,
 rctla.interface_line_context,
 nvl( rctla.sales_order
    , case rctla.interface_line_context
      when 'ORDER ENTRY'  then rctla.interface_line_attribute1
      when 'INTERCOMPANY' then rctla.interface_line_attribute1
      end
    ) sales_order,
 rctla.sales_order_line,
 rctla.sales_order_date,
 case when rctla.interface_line_context in ('INTERCOMPANY','ORDER ENTRY')
 then (select 
        jrrev2.resource_name
       from
        oe_order_lines_all oola,
        oe_order_headers_all ooha,
        jtf_rs_salesreps jrs2,
        jtf_rs_resource_extns_vl jrrev2
       where  
        oola.line_id = to_number(rctla.interface_line_attribute6) and
        ooha.header_id = oola.header_id and
        jrs2.salesrep_id = ooha.salesrep_id and
        jrs.org_id = ooha.org_id and
        jrrev2.resource_id = jrs2.resource_id
      )
 end sales_order_salesperson,
 case when rctla.interface_line_context in ('OKL_CONTRACTS','OKL_INVESTOR') then rctla.interface_line_attribute1 end okl_contract_number,
 case when rctla.interface_line_context in ('OKS_CONTRACTS') then to_date(rctla.interface_line_attribute4,'YYYY/MM/DD HH24:MI:SS') end oks_billed_from,
 case when rctla.interface_line_context in ('OKS_CONTRACTS') then to_date(rctla.interface_line_attribute5,'YYYY/MM/DD HH24:MI:SS') end oks_billed_to,
 case when rctla.interface_line_context in ('OKS_CONTRACTS') then case rcta.invoicing_rule_id when -3 then to_date(rctla.interface_line_attribute5,'YYYY/MM/DD HH24:MI:SS')+1 else to_date(rctla.interface_line_attribute4,'YYYY/MM/DD HH24:MI:SS') end end oks_billing_due_date,
 xxen_util.user_name(rctla.created_by) line_created_by,
 rctla.creation_date line_creation_date,
 rctla.last_update_date line_last_updated,
 rctla.customer_trx_line_id,
 case rctla.customer_trx_line_id when lag(rctla.customer_trx_line_id,1,-1) over (order by rcta.customer_trx_id,nvl(apsa.terms_sequence_number,1),nvl(rctla.line_number,-1),rctlgda2.gl_date,decode(rctlgda2.account_class,'TAX',2,1),xxen_util.concatenated_segments(rctlgda2.code_combination_id),sign(rctlgda2.amount),rctlgda2.account_class) then 'N' else 'Y' end first_line,
 ----------distribution----------
 xxen_util.concatenated_segments(rctlgda1.code_combination_id) receivables_account,
 xxen_util.segments_description(rctlgda1.code_combination_id) receivables_account_description, 
 xxen_util.meaning(rctlgda2.account_class,'AUTOGL_TYPE',222) dist_class,
 rctlgda2.gl_date dist_gl_date,
 rctlgda2.gl_posted_date dist_gl_posted_date,
 rctlgda2.percent dist_percent,
 rctlgda2.amount dist_amount,
 rctlgda2.acctd_amount dist_accounted_amount,
 rctlgda2.tax_rate dist_tax_rate,
 xxen_util.concatenated_segments(rctlgda2.code_combination_id) dist_account,
 xxen_util.segments_description(rctlgda2.code_combination_id) dist_account_description,
 xxen_util.user_name(rctlgda2.created_by) dist_created_by,
 rctlgda2.creation_date dist_creation_date,
 rctlgda2.last_update_date dist_last_updated,
 rctlgda2.code_combination_id dist_code_combination_id,
 rctlgda2.cust_trx_line_gl_dist_id
from
 -- invoice info
 ra_customer_trx_all rcta,
 ar_payment_schedules_all apsa,
 (select rctla.* from ra_customer_trx_lines_all rctla where '&enable_rctla'='Y') rctla,  -- lines
 ra_cust_trx_line_gl_dist_all rctlgda1,
 (select
   rctla3.customer_trx_id,
   nvl(rctla3.link_to_cust_trx_line_id,rctla3.customer_trx_line_id) customer_trx_line_id,
   rctlgda3.cust_trx_line_gl_dist_id,
   rctlgda3.account_class,
   decode(rctlgda3.account_class,'TAX',rctla3.tax_rate) tax_rate,
   rctlgda3.gl_date,
   trunc(rctlgda3.gl_posted_date) gl_posted_date,
   rctlgda3.percent,
   rctlgda3.code_combination_id,
   rctlgda3.amount amount,
   rctlgda3.acctd_amount acctd_amount,
   rctlgda3.created_by,
   rctlgda3.creation_date,
   rctlgda3.last_update_date
  from
   ra_cust_trx_line_gl_dist_all rctlgda3,
   ra_customer_trx_lines_all rctla3,
   gl_code_combinations gcc
  where
   '&enable_rctlgda'='Y' and
   rctlgda3.account_set_flag = 'N' and
   rctla3.customer_trx_id = rctlgda3.customer_trx_id  and
   rctla3.customer_trx_line_id = rctlgda3.customer_trx_line_id and
   gcc.code_combination_id = rctlgda3.code_combination_id and
   2=2
 ) rctlgda2, -- distributions
 ra_batch_sources_all rbsa,
 ra_batches_all rba,
 ra_cust_trx_types_all rctta,
 ra_terms_tl rtt,
 ar_receipt_methods arm,
 ar_cons_inv_all acia,
 gl_ledgers gl,
 hr_all_organization_units_vl haouv,
 oe_sys_parameters_all ospa,
 -- customer info
 hz_cust_accounts hca,
 hz_cust_acct_sites_all hcasa,
 hz_cust_site_uses_all hcsua,
 hz_parties hp,
 hz_party_sites hps,
 ra_territories_kfv rtk,
 -- salesrep info
 jtf_rs_salesreps jrs,
 jtf_rs_resource_extns_vl jrrev,
 -- payment info
 iby_fndcpt_pmt_chnnls_tl ifpct,
 iby_fndcpt_tx_extensions ifte,
 iby_pmt_instr_uses_all ipiua,
 iby_creditcard ic,
 iby_ext_bank_accounts ieba
where
 1=1 and
 apsa.customer_trx_id = rcta.customer_trx_id and
 apsa.payment_schedule_id > 0 and
 rctla.customer_trx_id(+) = decode(nvl(apsa.terms_sequence_number,1),1,apsa.customer_trx_id) and
 rctla.line_type(+) <> 'TAX' and
 rctlgda1.customer_trx_id = rcta.customer_trx_id and
 rctlgda1.account_class = 'REC' and
 rctlgda1.latest_rec_flag = 'Y'  and
 rctlgda2.customer_trx_id(+) = rctla.customer_trx_id and
 rctlgda2.customer_trx_line_id(+) = rctla.customer_trx_line_id and
 rbsa.batch_source_id(+) = rcta.batch_source_id and
 rbsa.org_id(+) = rcta.org_id and
 rba.batch_id(+) = rcta.batch_id and
 rba.org_id(+) = rcta.org_id and
 rctta.cust_trx_type_id = rcta.cust_trx_type_id and
 rctta.org_id = rcta.org_id and
 rtt.term_id(+) =  apsa.term_id and
 rtt.language(+) = userenv('lang') and
 arm.receipt_method_id(+) = rcta.receipt_method_id and
 acia.cons_inv_id(+) = apsa.cons_inv_id and
 --
 gl.ledger_id = rcta.set_of_books_id and
 haouv.organization_id = rcta.org_id and
 ospa.org_id(+) = rcta.org_id and
 ospa.parameter_code(+) = 'MASTER_ORGANIZATION_ID' and
 --
 hca.cust_account_id = apsa.customer_id and
 hp.party_id = hca.party_id and
 hcsua.site_use_id = apsa.customer_site_use_id and
 rtk.territory_id(+) = hcsua.territory_id and
 hcasa.cust_acct_site_id = hcsua.cust_acct_site_id and
 hps.party_site_id = hcasa.party_site_id and
 --
 jrs.salesrep_id(+) = rcta.primary_salesrep_id and
 jrs.org_id(+) = rcta.org_id and
 jrrev.resource_id(+) = jrs.resource_id and
 --
 ifpct.payment_channel_code(+) = arm.payment_channel_code and
 ifpct.language(+) = userenv('lang') and
 ifte.trxn_extension_id(+) = rcta.payment_trxn_extension_id and
 ipiua.instrument_payment_use_id(+) = ifte.instr_assignment_id and
 ic.instrid(+) = decode(ipiua.instrument_type,'CREDITCARD',ipiua.instrument_id) and
 ieba.ext_bank_account_id(+) = decode(ipiua.instrument_type,'BANKACCOUNT',ipiua.instrument_id) and
 exists -- need this to still apply line and distribution level criteria in case report is run at header or line display level
  (select null
   from  
     ra_cust_trx_line_gl_dist_all rctlgda3,
     ra_customer_trx_lines_all rctla3,
     gl_code_combinations gcc
   where
     rctlgda3.account_set_flag = 'N' and
     rctlgda3.customer_trx_line_id is not null and
     rctla3.customer_trx_id = rctlgda3.customer_trx_id and
     rctla3.customer_trx_line_id = rctlgda3.customer_trx_line_id and    
     rctla3.customer_trx_id = rcta.customer_trx_id and
     nvl(rctla3.link_to_cust_trx_line_id,
         rctla3.customer_trx_line_id)  = nvl(rctla.customer_trx_line_id,nvl(rctla3.link_to_cust_trx_line_id,rctla3.customer_trx_line_id)) and
     rctlgda3.cust_trx_line_gl_dist_id = nvl(rctlgda2.cust_trx_line_gl_dist_id,rctlgda3.cust_trx_line_gl_dist_id) and
     gcc.code_combination_id = rctlgda3.code_combination_id and
     2=2
  )
)
&contracts_query
--
-- Main Query Starts Here
--
select
ar_inv.ledger,
ar_inv.operating_unit,
ar_inv.invoice_number,
ar_inv.trx_number,
ar_inv.trx_date,
to_number(to_char(ar_inv.trx_date,'MM')) trx_month,
ar_inv.class,
ar_inv.type,
ar_inv.batch_source,
ar_inv.batch_name,
ar_inv.reference,
ar_inv.purchase_order,
ar_inv.credited_invoice,
ar_inv.credited_invoice_line,
ar_inv.party_name,
ar_inv.account_number,
ar_inv.bill_to_location,
ar_inv.bill_to_address,
ar_inv.taxpayer_id,
ar_inv.currency,
ar_inv.number_of_due_dates,
ar_inv.terms_sequence_number,
decode(ar_inv.first_psched,'Y',ar_inv.total_due_original) total_due_original,
decode(ar_inv.first_psched,'Y',ar_inv.tax_amount) tax_amount,
decode(ar_inv.first_psched,'Y',ar_inv.total_payment_applied) total_payment_applied,
decode(ar_inv.first_psched,'Y',ar_inv.total_adjustment) total_adjustment,
decode(ar_inv.first_psched,'Y',ar_inv.total_credit) total_credit,
decode(ar_inv.first_psched,'Y',ar_inv.total_due_remaining) total_due_remaining,
decode(ar_inv.first_psched,'Y',ar_inv.dispute_amount) dispute_amount,
decode(ar_inv.first_psched,'Y',ar_inv.accounted_total_due_original) accounted_total_due_original,
decode(ar_inv.first_psched,'Y',ar_inv.accounted_tax_amount) accounted_tax_amount,
decode(ar_inv.first_psched,'Y',ar_inv.accounted_total_due_remaining) accounted_total_due_remaining, 
ar_inv.status,
ar_inv.due_date,
ar_inv.overdue_days,
ar_inv.invoicing_rule,
ar_inv.payment_term,
ar_inv.ship_date,
ar_inv.receipt_method,
ar_inv.actual_date_closed,
ar_inv.payment_sched_gl_date,
ar_inv.payment_sched_gl_date_closed,
ar_inv.payment_method,
ar_inv.instrument_number,
ar_inv.print_option,
ar_inv.first_printed_date,
ar_inv.customer_reference,
ar_inv.comments,
ar_inv.salesperson,
ar_inv.sales_region,
ar_inv.sales_region_name,
ar_inv.receivables_account,
ar_inv.receivables_account_description,
------------
&invoice_detail_columns
&contracts_columns
&gcc_dist_segment_columns
&trx_audit_columns
from
ar_inv,
gl_code_combinations_kfv gcck
&contracts_tables
where
3=3 and
gcck.code_combination_id (+) = ar_inv.dist_code_combination_id
&contracts_joins
order by
ar_inv.operating_unit,
ar_inv.party_name,
ar_inv.account_number,
ar_inv.trx_date,
ar_inv.payment_sched_gl_date,
ar_inv.invoice_number,
ar_inv.trx_number,
nvl(ar_inv.terms_sequence_number,1),
ar_inv.line_number,
ar_inv.dist_gl_date,
decode(ar_inv.dist_class,'Tax',2,1),
ar_inv.dist_account,
sign(ar_inv.dist_amount),
ar_inv.dist_class,
ar_inv.dist_tax_rate