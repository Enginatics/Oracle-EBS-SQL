/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Transactions and Payments 11i
-- Description: Detail AR customer billing history including payments, excluding any entered or incomplete transactions.
-- Excel Examle Output: https://www.enginatics.com/example/ar-transactions-and-payments-11i/
-- Library Link: https://www.enginatics.com/reports/ar-transactions-and-payments-11i/
-- Run Report: https://demo.enginatics.com/

select
x.operating_unit,
x.invoice_number,
x.trx_number,
x.trx_date,
x.class,
x.type,
x.reference,
x.credited_invoice,
x.account_number,
x.party_name,
x.currency,
x.due_original,
x.payment_applied,
x.adjustment,
x.credit,
x.due_remaining,
x.dispute_amount,
x.state,
x.status,
x.payment_term,
x.invoicing_rule,
x.due_date,
x.overdue_days,
x.ship_date,
arm.name receipt_method,
replace(initcap(arm.payment_type_code),'_',' ') payment_method,
abac.bank_account_num                           instrument_number,
x.payment_server_order_num                   pson,
abbc.bank_name                                  bank_name,
abbc.bank_branch_name                           bank_branch,
x.remit_bank_name,
x.remit_bank_branch,
x.remit_bank_account,
x.print_option,
x.first_printed_date,
x.customer_reference,
x.comments,
x.bill_to_location,
x.bill_to_address,
x.taxpayer_id,
x.sales_rep,
x.category,
xxen_util.user_name(x.created_by) created_by,
xxen_util.client_time(x.creation_date) creation_date,
xxen_util.user_name(x.last_updated_by) last_updated_by,
xxen_util.client_time(x.last_update_date) last_update_date
from
(
select
haouv.name operating_unit,
acia.cons_billing_number invoice_number,
nvl(rcta.trx_number,acra.receipt_number) trx_number,
apsa.trx_date,
flv1.meaning class,
nvl(rctta.name,'Standard') type,
nvl(rcta.ct_reference,acra.customer_receipt_reference) reference,
decode(apsa.class,'PMT',
(
select distinct
listagg(nvl2(acia0.cons_billing_number,acia0.cons_billing_number||' - ',null)||rcta0.trx_number,', ') within group (order by rcta0.trx_number) over (partition by araa.cash_receipt_id) applied_trx
from
ar_receivable_applications_all araa,
ra_customer_trx_all rcta0,
ar_cons_inv_trx_all acita0,
ar_cons_inv_all acia0
where
apsa.cash_receipt_id=araa.cash_receipt_id and
araa.display='Y' and
araa.status='APP' and
araa.applied_customer_trx_id=rcta0.customer_trx_id and
rcta0.customer_trx_id=acita0.customer_trx_id(+) and
acita0.cons_inv_id=acia0.cons_inv_id(+)
),
(
select
nvl2(acia0.cons_billing_number,acia0.cons_billing_number||' - ',null)||rcta0.trx_number credited_invoice
from
ra_customer_trx_all rcta0,
ar_cons_inv_trx_all acita0,
ar_cons_inv_all acia0
where
rcta.previous_customer_trx_id=rcta0.customer_trx_id and
rcta0.customer_trx_id=acita0.customer_trx_id(+) and
acita0.cons_inv_id=acia0.cons_inv_id(+)
)
) credited_invoice,
hca.account_number,
hp.party_name,
hcsua.location bill_to_location,
hz_format_pub.format_address (hps.location_id,null,null,' , ') bill_to_address,
hp.jgzz_fiscal_code taxpayer_id,
apsa.invoice_currency_code currency,
apsa.amount_due_original due_original,
apsa.amount_applied payment_applied,
apsa.amount_adjusted adjustment,
apsa.amount_credited credit,
apsa.amount_due_remaining due_remaining,
case when rctta.accounting_affect_flag='Y' and apsa.amount_in_dispute<>0 then apsa.amount_in_dispute end dispute_amount,
nvl(flv3.meaning,decode(apsa.status,'CL','Closed',decode(apsa.amount_due_remaining,apsa.amount_due_original,'Open','Partially Paid'))) state,
apsa.status,
rtt.name payment_term,
decode(rcta.invoicing_rule_id,-3,'Arrears',-2,'Advance') invoicing_rule,
apsa.due_date,
case when apsa.class in ('INV','DM') and apsa.status='OP' then greatest(trunc(sysdate)-apsa.due_date,0) end overdue_days,
rcta.ship_date_actual ship_date,
acra.payment_server_order_num,
abbr.bank_name                                  remit_bank_name,
abbr.bank_branch_name                           remit_bank_branch,
abar.bank_account_num                           remit_bank_account,
flv2.meaning print_option,
rcta.printing_original_date first_printed_date,
rcta.customer_reference,
nvl(rcta.comments,acra.comments) comments,
jrret.resource_name sales_rep,
decode(apsa.class,'PMT','CASH RECEIPT',nvl(rcta.interface_header_context,rbsa.name)) category,
nvl(rcta.created_by,acra.created_by) created_by,
nvl(rcta.creation_date,acra.creation_date) creation_date,
nvl(rcta.last_updated_by,acra.last_updated_by) last_updated_by,
nvl(rcta.last_update_date,acra.last_update_date) last_update_date,
nvl(rcta.receipt_method_id,acra.receipt_method_id) receipt_method_id,
nvl(rcta.customer_bank_account_id,acra.customer_bank_account_id) customer_bank_account_id
from
hr_all_organization_units_vl haouv,
ar_payment_schedules_all apsa,
ra_customer_trx_all rcta,
oe_sys_parameters_all ospa,
ra_batch_sources_all rbsa,
ra_cust_trx_types_all rctta,
ra_terms_tl rtt,
ar_cons_inv_all acia,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
fnd_lookup_values flv1,
fnd_lookup_values flv2,
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_tl jrret,
ar_cash_receipts_all acra,
ar_cash_receipt_history_all acrha,
fnd_lookup_values flv3,
ap_bank_accounts_all  abar,
ap_bank_branches      abbr
where
1=1 and
apsa.payment_schedule_id>0 and
apsa.org_id=haouv.organization_id and
apsa.customer_trx_id=rcta.customer_trx_id(+) and
apsa.org_id=ospa.org_id(+) and
ospa.parameter_code(+)='MASTER_ORGANIZATION_ID' and
apsa.term_id=rtt.term_id(+) and
rtt.language(+)=userenv('LANG') and
rcta.cust_trx_type_id=rctta.cust_trx_type_id(+) and
rcta.org_id=rctta.org_id(+) and
nvl2(rcta.interface_header_context,null,rcta.batch_source_id)=rbsa.batch_source_id(+) and
nvl2(rcta.interface_header_context,null,rcta.org_id)=rbsa.org_id(+) and
apsa.cons_inv_id=acia.cons_inv_id(+) and
apsa.customer_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
apsa.customer_site_use_id=hcsua.site_use_id(+) and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id(+) and
hcasa.party_site_id=hps.party_site_id(+) and
apsa.class=flv1.lookup_code(+) and
rcta.printing_option=flv2.lookup_code(+) and
flv1.lookup_type(+)='INV/CM/ADJ' and
flv2.lookup_type(+)='INVOICE_PRINT_OPTIONS' and
flv1.view_application_id(+)=222 and
flv2.view_application_id(+)=222 and
flv1.language(+)=userenv('lang') and
flv2.language(+)=userenv('lang') and
flv1.security_group_id(+)=0 and
flv2.security_group_id(+)=0 and
case when rcta.primary_salesrep_id>0 then rcta.primary_salesrep_id end=jrs.salesrep_id(+) and
case when rcta.primary_salesrep_id>0 then rcta.org_id end=jrs.org_id(+) and
jrs.resource_id=jrret.resource_id(+) and
jrret.language(+)=userenv('lang') and
apsa.cash_receipt_id=acra.cash_receipt_id(+) and
apsa.cash_receipt_id=acrha.cash_receipt_id(+) and
acrha.current_record_flag(+)='Y' and
acrha.status=flv3.lookup_code(+) and
flv3.lookup_type(+)='RECEIPT_CREATION_STATUS' and
flv3.view_application_id(+)=222 and
flv3.language(+)=userenv('lang') and
flv3.security_group_id(+)=0 and
acra.remittance_bank_account_id = abar.bank_account_id (+) and
abar.bank_branch_id = abbr.bank_branch_id (+) 
) x,
ar_receipt_methods arm,
ap_bank_accounts_all  abac,
ap_bank_branches      abbc
where
x.receipt_method_id=arm.receipt_method_id(+) and
x.customer_bank_account_id = abac.bank_account_id (+) and
abac.bank_branch_id = abbc.bank_branch_id (+)
order by
x.operating_unit,
x.trx_date desc,
x.invoice_number desc,
x.trx_number desc