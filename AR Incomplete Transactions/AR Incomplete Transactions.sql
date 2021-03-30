/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Incomplete Transactions
-- Description: Detail incomplete transaction report
-- Excel Examle Output: https://www.enginatics.com/example/ar-incomplete-transactions/
-- Library Link: https://www.enginatics.com/reports/ar-incomplete-transactions/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
rcta.trx_number trx_number,
rcta.trx_date,
xxen_util.meaning(rctta.type,'INV/CM/ADJ',222) class,
rctta.name type,
rcta.ct_reference reference,
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
) credited_invoice,
hca.account_number,
hp.party_name,
hcsua.location bill_to_location,
hz_format_pub.format_address (hps.location_id,null,null,' , ') bill_to_address,
hp.jgzz_fiscal_code taxpayer_id,
rcta.invoice_currency_code currency,
(select sum(rctla.extended_amount) from ra_customer_trx_lines_all rctla where rcta.customer_trx_id=rctla.customer_trx_id and rctla.line_type in ('LINE','CB','CHARGES')) amount,
decode(rcta.status_trx,'CL','Closed','Open') state,
rcta.status_trx status,
rtv.name payment_term,
decode(rcta.invoicing_rule_id,-3,'Arrears',-2,'Advance') invoicing_rule,
rcta.term_due_date,
rcta.ship_date_actual ship_date,
xxen_util.meaning(rcta.printing_option,'INVOICE_PRINT_OPTIONS',222) print_option,
rcta.printing_original_date first_printed_date,
rcta.customer_reference,
rcta.comments,
jrret.resource_name sales_rep,
nvl(rcta.interface_header_context,rbsa.name) category,
xxen_util.user_name(rcta.created_by) created_by,
xxen_util.client_time(rcta.creation_date) creation_date,
xxen_util.user_name(rcta.last_updated_by) last_updated_by,
xxen_util.client_time(rcta.last_update_date) last_update_date,
arm.name receipt_method
&payment_method_column
from
hr_all_organization_units_vl haouv,
ra_customer_trx_all rcta,
oe_sys_parameters_all ospa,
ra_batch_sources_all rbsa,
ra_cust_trx_types_all rctta,
ra_terms_vl rtv,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_tl jrret,
ar_receipt_methods arm
&payment_method_table
where
1=1 and
rcta.complete_flag='N' and
rcta.org_id=haouv.organization_id(+) and
rcta.org_id=ospa.org_id(+) and
ospa.parameter_code(+)='MASTER_ORGANIZATION_ID' and
rcta.term_id=rtv.term_id(+) and
rcta.cust_trx_type_id=rctta.cust_trx_type_id(+) and
rcta.org_id=rctta.org_id(+) and
nvl2(rcta.interface_header_context,null,rcta.batch_source_id)=rbsa.batch_source_id(+) and
nvl2(rcta.interface_header_context,null,rcta.org_id)=rbsa.org_id(+) and
rcta.bill_to_customer_id=hca.cust_account_id(+) and
hca.party_id=hp.party_id(+) and
rcta.bill_to_site_use_id=hcsua.site_use_id(+) and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id(+) and
hcasa.party_site_id=hps.party_site_id(+) and
case when rcta.primary_salesrep_id>0 then rcta.primary_salesrep_id end=jrs.salesrep_id(+) and
case when rcta.primary_salesrep_id>0 then rcta.org_id end=jrs.org_id(+) and
jrs.resource_id=jrret.resource_id(+) and
jrret.language(+)=userenv('lang') and
rcta.receipt_method_id=arm.receipt_method_id(+)
&payment_method_join
order by
haouv.name,
rcta.trx_date desc,
rcta.trx_number desc