/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
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
 x.Company_Name
,x.Currency_Main  currency
,x.cons_number    billing_number
,x.Type
,x.Due_Date
,x.Customer_Name
,x.Customer_Number
,x.Collector
,x.Invoice_Amount
,x.Balance_Due
,x.Dispute_Amount
,x.notes
from
(
select
  sob.Company_Name,
  ar_payment_schedules.invoice_currency_code Currency_Main,
  DECODE(UPPER(:p_order_by),'CUSTOMER',CUST.ACCOUNT_NUMBER,NULL) Dummy_Customer_Number,
  DECODE(UPPER(:p_order_by),'CUSTOMER',SUBSTRB(PARTY.PARTY_NAME,1,50),NULL) Dummy_Customer_Name,
  ar_payment_schedules.trx_number Number_,
  ra_cust_trx_types.name Type,
  ar_payment_schedules.due_date Due_Date,
  SUBSTRB(PARTY.PARTY_NAME,1,50) Customer_Name,
  CUST.ACCOUNT_NUMBER Customer_Number,
  CUST.CUST_ACCOUNT_ID Customer_Id,
  ar_collectors.name Collector,
  ar_payment_schedules.amount_due_original Invoice_Amount,
  ar_payment_schedules.amount_due_remaining Balance_Due,
  ar_payment_schedules.amount_in_dispute Dispute_Amount,
  ar_payment_schedules.customer_trx_id Customer_Trx_Id,
  DECODE(sob.functional_acct_unit, NULL, ROUND( ar_payment_schedules.amount_due_original * NVL(ar_payment_schedules.exchange_rate, 1), sob.Functional_Currency_Precision), ROUND( ( ar_payment_schedules.amount_due_original * NVL(ar_payment_schedules.exchange_rate, 1))/ sob.functional_acct_unit ) * sob.functional_acct_unit ) func_amount_due,
  ar_payment_schedules.acctd_amount_due_remaining func_amount_rem,
  DECODE(sob.functional_acct_unit, NULL, ROUND( ar_payment_schedules.amount_in_dispute * NVL(ar_payment_schedules.exchange_rate, 1), sob.Functional_Currency_Precision), ROUND( ( ar_payment_schedules.amount_in_dispute * NVL(ar_payment_schedules.exchange_rate, 1))/ sob.functional_acct_unit ) * sob.functional_acct_unit ) func_amount_dis,
  &lp_query_show_bill_mo cons_bill_number,
  AR_ARXDIR_XMLP_PKG.c_data_not_foundformula(ar_payment_schedules.invoice_currency_code) C_DATA_NOT_FOUND,
  AR_ARXDIR_XMLP_PKG.c_currency_summary_labelformul(ar_payment_schedules.invoice_currency_code) C_CURRENCY_SUMMARY_LABEL,
  AR_ARXDIR_XMLP_PKG.c_cust_summary_labelformula(DECODE ( UPPER ( :p_order_by ) , 'CUSTOMER' , SUBSTRB ( PARTY.PARTY_NAME , 1 , 50 ) , NULL )) C_CUST_SUMMARY_LABEL,
  AR_ARXDIR_XMLP_PKG.cons_numberformula(ar_payment_schedules.trx_number, &lp_query_show_bill_mo) cons_number,
  notes.text notes
from
  (SELECT sob.name  Company_Name,
          sob.set_of_books_id,
          sob.chart_of_accounts_id     coa_id,
          sob.currency_code            Functional_Currency,
          cur.precision                Functional_Currency_Precision,
          cur.minimum_accountable_unit functional_acct_unit
   FROM   gl_sets_of_books     sob,
          fnd_currencies       cur
    WHERE sob.currency_code = cur.currency_code
  ) sob,
  hr_operating_units hou,
  ar_payment_schedules_all ar_payment_schedules,
  ra_customer_trx_all,
  ra_cust_trx_types_all  ra_cust_trx_types,
  hz_cust_accounts cust,
  hz_parties party,
  HZ_customer_profiles cust_cp,
  HZ_customer_profiles site_cp,
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
  AND ar_payment_schedules.cust_trx_type_id = ra_cust_trx_types.cust_trx_type_id
  AND ar_payment_schedules.org_id = ra_cust_trx_types.org_id
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