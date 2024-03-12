/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Past Due Invoice
-- Description: Detail past due AR invoice report with invoice number, days past due, amount past due and currency code
-- Excel Examle Output: https://www.enginatics.com/example/ar-past-due-invoice/
-- Library Link: https://www.enginatics.com/reports/ar-past-due-invoice/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
apsa.invoice_currency_code currency,
hp.party_name customer_name,
hca.account_number,
apsa.trx_number invoice_number,
xxen_util.meaning(apsa.class,'INV/CM/ADJ',222) class,
rctta.name invoice_type,
rcta.purchase_order,
apsa.trx_date invoice_date,
apsa.due_date,
apsa.amount_due_original invoice_amount,
apsa.tax_original tax_amount,
arpt_sql_func_util.get_balance_due_as_of_date(payment_schedule_id,:p_as_of_date,class) balance_due,
:p_as_of_date-trunc(apsa.due_date) days_past_due,
ac.name collector,
rs.name salesperson,
xxen_util.user_name(rcta.created_by) created_by,
xxen_util.client_time(rcta.creation_date) creation_date,
xxen_util.user_name(rcta.last_updated_by) last_updated_by,
xxen_util.client_time(rcta.last_update_date) last_update_date,
apsa.payment_schedule_id,
hcp.cust_account_profile_id,
hcp1.cust_account_profile_id hcp1_cust_account_profile_id
from
hr_all_organization_units_vl haouv,
ar_payment_schedules_all apsa,
ra_customer_trx_all rcta,
ra_cust_trx_types_all rctta,
hz_cust_accounts hca,
hz_parties hp,
ra_salesreps rs,
hz_customer_profiles hcp,
hz_customer_profiles hcp1,
ar_collectors ac
where
1=1 and
apsa.actual_date_closed>:p_as_of_date and
arpt_sql_func_util.get_balance_due_as_of_date(payment_schedule_id,:p_as_of_date,class)!=0 and
haouv.organization_id=apsa.org_id and
apsa.customer_trx_id=rcta.customer_trx_id and
rcta.cust_trx_type_id=rctta.cust_trx_type_id and
rcta.org_id=rctta.org_id and
rcta.bill_to_customer_id=hca.cust_account_id and
hca.party_id=hp.party_id and
rcta.primary_salesrep_id=rs.salesrep_id(+) and
hca.cust_account_id=hcp.cust_account_id and
hcp.site_use_id is null and
apsa.customer_site_use_id=hcp1.site_use_id(+) and
nvl(hcp1.collector_id, hcp.collector_id)=ac.collector_id
order by
decode(upper(:p_order_by),'SALESPERSON',rs.name, 'CUSTOMER',hp.party_name,null),
decode(upper(:p_order_by),'BALANCE DUE',arpt_sql_func_util.get_balance_due_as_of_date(payment_schedule_id,:p_as_of_date,class),0)