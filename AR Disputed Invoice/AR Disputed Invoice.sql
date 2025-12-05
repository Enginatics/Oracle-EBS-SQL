/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Disputed Invoice
-- Description: Imported Oracle standard disputed invoice report
Source: Disputed Invoice Report (XML)
Short Name: ARXDIR_XML
DB package: AR_ARXDIR_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ar-disputed-invoice/
-- Library Link: https://www.enginatics.com/reports/ar-disputed-invoice/
-- Run Report: https://demo.enginatics.com/

select
 x.company_name
,x.currency_main  currency
,x.cons_number    billing_number
,x.type
,x.due_date
,x.customer_name
,x.customer_number
,x.collector
,x.invoice_amount
,x.balance_due
,x.dispute_amount
,x.notes
from
(
select
  sob.company_name,
  ar_payment_schedules.invoice_currency_code currency_main,
  decode(upper(:p_order_by),'CUSTOMER',cust.account_number,null) dummy_customer_number,
  decode(upper(:p_order_by),'CUSTOMER',substrb(party.party_name,1,50),null) dummy_customer_name,
  ar_payment_schedules.trx_number number_,
  ra_cust_trx_types.name type,
  ar_payment_schedules.due_date due_date,
  substrb(party.party_name,1,50) customer_name,
  cust.account_number customer_number,
  cust.cust_account_id customer_id,
  ar_collectors.name collector,
  ar_payment_schedules.amount_due_original invoice_amount,
  ar_payment_schedules.amount_due_remaining balance_due,
  ar_payment_schedules.amount_in_dispute dispute_amount,
  ar_payment_schedules.customer_trx_id customer_trx_id,
  decode(sob.functional_acct_unit, null, round( ar_payment_schedules.amount_due_original * nvl(ar_payment_schedules.exchange_rate, 1), sob.functional_currency_precision), round( ( ar_payment_schedules.amount_due_original * nvl(ar_payment_schedules.exchange_rate, 1))/ sob.functional_acct_unit ) * sob.functional_acct_unit ) func_amount_due,
  ar_payment_schedules.acctd_amount_due_remaining func_amount_rem,
  decode(sob.functional_acct_unit, null, round( ar_payment_schedules.amount_in_dispute * nvl(ar_payment_schedules.exchange_rate, 1), sob.functional_currency_precision), round( ( ar_payment_schedules.amount_in_dispute * nvl(ar_payment_schedules.exchange_rate, 1))/ sob.functional_acct_unit ) * sob.functional_acct_unit ) func_amount_dis,
  &lp_query_show_bill_mo cons_bill_number,
  ar_arxdir_xmlp_pkg.c_data_not_foundformula(ar_payment_schedules.invoice_currency_code) c_data_not_found,
  ar_arxdir_xmlp_pkg.c_currency_summary_labelformul(ar_payment_schedules.invoice_currency_code) c_currency_summary_label,
  ar_arxdir_xmlp_pkg.c_cust_summary_labelformula(decode ( upper ( :p_order_by ) , 'CUSTOMER' , substrb ( party.party_name , 1 , 50 ) , null )) c_cust_summary_label,
  ar_arxdir_xmlp_pkg.cons_numberformula(ar_payment_schedules.trx_number, &lp_query_show_bill_mo) cons_number,
  notes.text notes
from
  (select sob.name  company_name,
          sob.set_of_books_id,
          sob.chart_of_accounts_id     coa_id,
          sob.currency_code            functional_currency,
          cur.precision                functional_currency_precision,
          cur.minimum_accountable_unit functional_acct_unit
   from   gl_sets_of_books     sob,
          fnd_currencies       cur
    where sob.currency_code = cur.currency_code
  ) sob,
  hr_operating_units hou,
  ar_payment_schedules_all ar_payment_schedules,
  ra_customer_trx_all,
  ra_cust_trx_types_all  ra_cust_trx_types,
  hz_cust_accounts cust,
  hz_parties party,
  hz_customer_profiles cust_cp,
  hz_customer_profiles site_cp,
  &lp_table_show_bill_mo ar_collectors,
  ( select distinct
        y.customer_trx_id
      , listagg(y.text,chr(10)) within group (order by y.text) over (partition by y.customer_trx_id) text
      from
        ( select
            arn.customer_trx_id
          , arn.text
          , sum(lengthb(arn.text)+1) over (partition by arn.customer_trx_id order by arn.note_id rows between unbounded preceding and current row) lengthb
          from
            ( select
                ar_notes.customer_trx_id
              , ar_notes.note_id
              , ar_notes.text
              from
                ar_notes
            ) arn
        ) y
      where
        y.lengthb <= 4000
    )    notes
where
      cust.party_id = party.party_id
  and ar_payment_schedules.customer_trx_id = ra_customer_trx_all.customer_trx_id
  and ra_customer_trx_all.set_of_books_id = sob.set_of_books_id
  and  ra_customer_trx_all.org_id = hou.organization_id
  and  hou.set_of_books_id = sob.set_of_books_id
  and ar_payment_schedules.cust_trx_type_id = ra_cust_trx_types.cust_trx_type_id
  and ar_payment_schedules.org_id = ra_cust_trx_types.org_id
  and ar_payment_schedules.customer_id = cust.cust_account_id
  and cust.cust_account_id = cust_cp.cust_account_id
  and cust_cp.site_use_id is null
  and ar_payment_schedules.customer_site_use_id = site_cp.site_use_id(+)
  and nvl(site_cp.collector_id,cust_cp.collector_id) = ar_collectors.collector_id
  and ar_payment_schedules.amount_in_dispute != 0
  and ra_customer_trx_all.customer_trx_id = notes.customer_trx_id (+)
  and 1=1
  &lp_due_date_low
  &lp_due_date_high
  &lp_item_number_low
  &lp_item_number_high
  &lp_customer_name_low
  &lp_customer_name_high
  &lp_customer_number_low
  &lp_customer_number_high
  &lp_collector_low
  &lp_collector_high
  &lp_where_show_bill_mo
  &lp_order_by
) x