/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Past Due Invoice
-- Description: Application: Receivables
Source: Past Due Invoice Report
Short Name: ARXPDI_XML
-- Excel Examle Output: https://www.enginatics.com/example/ar-past-due-invoice
-- Library Link: https://www.enginatics.com/reports/ar-past-due-invoice
-- Run Report: https://demo.enginatics.com/


select
apsa.invoice_currency_code currency,
hp.party_name customer_name,
hca.account_number,
apsa.trx_number invoice_number,
apsa.class,
rctta.name invoice_type,
rcta.purchase_order,
apsa.trx_date invoice_date,
apsa.due_date,
apsa.amount_due_original invoice_amount,
apsa.tax_original tax_amount,
arpt_sql_func_util.get_balance_due_as_of_date(payment_schedule_id,:p_as_of_date,class) balance_due,
:p_as_of_date-trunc(apsa.due_date) days_past_due,
ac.name collector,
rs.name salesperson
from
hz_customer_profiles hcp,
hz_customer_profiles hcp1,
ar_collectors ac,
hz_cust_accounts hca,
hz_parties hp,
ra_customer_trx_all rcta,
ra_salesreps rs,
ar_payment_schedules_all apsa,
ra_cust_trx_types_all rctta
where
apsa.actual_date_closed>:p_as_of_date and
arpt_sql_func_util.get_balance_due_as_of_date(payment_schedule_id,:p_as_of_date,class)!=0 and
1=1 and
hca.cust_account_id=rcta.bill_to_customer_id and
hca.party_id=hp.party_id and
rcta.customer_trx_id=apsa.customer_trx_id and
rcta.primary_salesrep_id=rs.salesrep_id (+) and
hcp.cust_account_id=hca.cust_account_id and
hcp.site_use_id is null and
hcp1.site_use_id (+)=apsa.customer_site_use_id and
ac.collector_id=nvl(hcp1.collector_id, hcp.collector_id) and
rctta.cust_trx_type_id=rcta.cust_trx_type_id and
rctta.org_id=rcta.org_id
order by
decode(upper(:p_order_by),'SALESPERSON',rs.name, 'CUSTOMER',hp.party_name,null),
decode(upper(:p_order_by),'BALANCE DUE',arpt_sql_func_util.get_balance_due_as_of_date(payment_schedule_id,:p_as_of_date,class),0)