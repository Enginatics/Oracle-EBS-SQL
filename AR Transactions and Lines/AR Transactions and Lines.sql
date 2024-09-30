/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
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

select
gl.name ledger,
haouv.name operating_unit,
acia.cons_billing_number invoice_number,
rcta.trx_number,
rcta.trx_date,
to_number(to_char(rcta.trx_date,'MM')) trx_month,
rcta.billing_date,
to_number(to_char(rcta.billing_date,'MM')) billing_month,
xxen_util.meaning(apsa.class,'INV/CM/ADJ',222) class,
rctta.name type,
rbsa.name batch_source,
rba.name batch_name,
rcta.ct_reference reference,
rcta.purchase_order,
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
(select rctla0.line_number from ra_customer_trx_lines_all rctla0 where rctla.previous_customer_trx_line_id=rctla0.customer_trx_line_id) credited_invoice_line,
hp0.party_name sold_to_customer,
hca0.account_number sold_to_customer_number,
hp5.party_name paying_customer,
hca5.account_number paying_customer_number,
hcsua5.location paying_location,
hp1.party_name bill_to_customer,
hca1.account_number bill_to_customer_number,
hcsua1.location bill_to_location,
hz_format_pub.format_address(hps1.location_id,null,null,' , ') bill_to_address,
ftv1.territory_short_name bill_to_country,
coalesce(hcsua1.tax_reference,hp1.tax_reference,hp1.jgzz_fiscal_code) bill_to_tax_reference,
hp3.party_name ship_to_customer,
hca3.account_number ship_to_customer_number,
nvl(hcsua2.location,hcsua3.location) ship_to_location,
hz_format_pub.format_address(nvl(hps2.location_id,hps3.location_id),null,null,' , ') ship_to_address,
nvl(ftv2.territory_short_name,ftv3.territory_short_name) ship_to_country,
coalesce(hcsua2.tax_reference,hcsua3.tax_reference,hp2.tax_reference,hp3.tax_reference,hp2.jgzz_fiscal_code,hp3.jgzz_fiscal_code) ship_to_tax_reference,
hz_format_pub.format_address(hps4.location_id,null,null,' , ') ship_to_address_order,
rcta.invoice_currency_code currency,
apsa.number_of_due_dates,
apsa.terms_sequence_number,
case when apsa.terms_sequence_number=1 and rctla.not_first_line is null and rctlgda.not_first_line is null then apsa.amount_due_original end total_due_original,
case when apsa.terms_sequence_number=1 and rctla.not_first_line is null and rctlgda.not_first_line is null then apsa.tax_original end tax_amount,
case when apsa.terms_sequence_number=1 and rctla.not_first_line is null and rctlgda.not_first_line is null then apsa.amount_applied end total_payment_applied,
case when apsa.terms_sequence_number=1 and rctla.not_first_line is null and rctlgda.not_first_line is null then apsa.amount_adjusted end total_adjustment,
case when apsa.terms_sequence_number=1 and rctla.not_first_line is null and rctlgda.not_first_line is null then apsa.amount_credited end total_credit,
case when apsa.terms_sequence_number=1 and rctla.not_first_line is null and rctlgda.not_first_line is null then apsa.amount_due_remaining end total_due_remaining,
case when apsa.terms_sequence_number=1 and rctla.not_first_line is null and rctlgda.not_first_line is null then case when rctta.accounting_affect_flag='Y' and apsa.amount_in_dispute<>0 then apsa.amount_in_dispute end end dispute_amount,
case when apsa.terms_sequence_number=1 and rctla.not_first_line is null and rctlgda.not_first_line is null then apsa.amount_due_original*nvl(apsa.exchange_rate,1) end accounted_total_due_original,
case when apsa.terms_sequence_number=1 and rctla.not_first_line is null and rctlgda.not_first_line is null then apsa.tax_original*nvl(apsa.exchange_rate,1) end accounted_tax_amount,
case when apsa.terms_sequence_number=1 and rctla.not_first_line is null and rctlgda.not_first_line is null then apsa.acctd_amount_due_remaining end accounted_total_due_remaining,
xxen_util.meaning(apsa.status,'PAYMENT_SCHEDULE_STATUS',222) status,
rtt.name payment_term,
decode(rcta.invoicing_rule_id,-3,'Arrears','Advance') invoicing_rule,
apsa.due_date,
case when apsa.class in ('INV','DM') and apsa.status='OP' then greatest(trunc(sysdate)-apsa.due_date,0) end overdue_days,
rcta.ship_date_actual ship_date,
decode(apsa.status,'OP',to_date(null),apsa.actual_date_closed) actual_date_closed,
apsa.gl_date payment_sched_gl_date,
decode(apsa.status,'OP',to_date(null),apsa.gl_date_closed) payment_sched_gl_date_closed,
arm.name receipt_method,
ifpct.payment_channel_name payment_method,
decode(ipiua.instrument_type,'BANKACCOUNT',ieba.masked_bank_account_num,'CREDITCARD',ic.masked_cc_number) instrument_number,
xxen_util.meaning(rcta.printing_option,'INVOICE_PRINT_OPTIONS',222) print_option,
rcta.printing_original_date first_printed_date,
rcta.customer_reference,
rcta.comments,
jrrev.resource_name salesperson,
rtk.concatenated_segments sales_region,
rtk.name sales_region_name,
xxen_util.concatenated_segments(rctlgda0.code_combination_id) receivables_account,
xxen_util.segments_description(rctlgda0.code_combination_id) receivables_account_desc,
rctlgda0.gl_date receivables_account_gl_date,
&category_columns
&line_columns
&distribution_columns
&segment_columns
&contracts_columns
xxen_util.user_name(rcta.created_by) trx_created_by,
xxen_util.client_time(rcta.creation_date) trx_creation_date,
xxen_util.user_name(rcta.last_updated_by) trx_last_updated_by,
xxen_util.client_time(rcta.last_update_date) trx_last_update_date,
&trx_audit_columns
rcta.customer_trx_id,
apsa.payment_schedule_id
from
gl_ledgers gl,
hr_all_organization_units_vl haouv,
ra_customer_trx_all rcta,
ar_payment_schedules_all apsa,
(
select
decode(rctla.customer_trx_line_id,min(rctla.customer_trx_line_id) keep (dense_rank first order by decode(rctla.line_type,'LINE',1,2), rctla.line_number) over (partition by rctla.customer_trx_id),null,'Y') not_first_line,
case when rctla.interface_line_context in ('OKL_CONTRACTS','OKL_INVESTOR') then rctla.interface_line_attribute1 end okl_contract_number,
case when rctla.interface_line_context in ('OKS_CONTRACTS') then to_date(rctla.interface_line_attribute4,'YYYY/MM/DD HH24:MI:SS') end oks_billed_from,
case when rctla.interface_line_context in ('OKS_CONTRACTS') then to_date(rctla.interface_line_attribute5,'YYYY/MM/DD HH24:MI:SS') end oks_billed_to,
nvl(rctla.warehouse_id,ospa.parameter_value) organization_id,
rctla.*
from
ra_customer_trx_lines_all rctla,
oe_sys_parameters_all ospa
where
'&show_rctla'='Y' and
rctla.line_type in ('LINE','FREIGHT','CB') and
rctla.org_id=ospa.org_id(+) and
ospa.parameter_code(+)='MASTER_ORGANIZATION_ID'
) rctla,
(
select distinct
rctla2.link_to_cust_trx_line_id,
sum(rctla2.extended_amount) over (partition by rctla2.link_to_cust_trx_line_id) extended_amount,
listagg(rctla2.tax_rate,', ') within group (order by rctla2.tax_rate) over (partition by rctla2.link_to_cust_trx_line_id) tax_rates
from
ra_customer_trx_lines_all rctla2
where
'&show_rctla'='Y' and
rctla2.line_type='TAX'
) rctla2,
ra_cust_trx_line_gl_dist_all rctlgda0,
(
select
decode(rctlgda.cust_trx_line_gl_dist_id,min(rctlgda.cust_trx_line_gl_dist_id) keep (dense_rank first order by decode(rctlgda.account_class,'TAX',2,1)) over (partition by rctla3.link_to_cust_trx_line_id),null,'Y') not_first_line,
rctla3.link_to_cust_trx_line_id,
rctla3.tax_rate,
rctlgda.*
from
(
select rctla.link_to_cust_trx_line_id, rctla.customer_trx_line_id, rctla.tax_rate from ra_customer_trx_lines_all rctla where rctla.link_to_cust_trx_line_id is not null union all
select rctla.customer_trx_line_id, rctla.customer_trx_line_id, rctla.tax_rate from ra_customer_trx_lines_all rctla where rctla.link_to_cust_trx_line_id is null
) rctla3,
ra_cust_trx_line_gl_dist_all rctlgda
where
2=2 and
&gl_distribution_where_clause2
'&show_rctlgda'='Y' and
rctla3.customer_trx_line_id=rctlgda.customer_trx_line_id and
rctlgda.account_set_flag='N'
) rctlgda,
mtl_system_items_vl msiv,
gl_code_combinations_kfv gcck,
ra_batch_sources_all rbsa,
ra_batches_all rba,
ra_cust_trx_types_all rctta,
ra_terms_tl rtt,
ar_cons_inv_all acia,
hz_cust_accounts hca0, --sold_to
hz_cust_accounts hca1, --bill_to
hz_cust_accounts hca2, --ship_to invoice line
hz_cust_accounts hca3, --ship_to invoice header
hz_cust_accounts hca5, --paying
hz_parties hp0,
hz_parties hp1,
hz_parties hp2,
hz_parties hp3,
hz_parties hp5,
hz_cust_site_uses_all hcsua1, --bill_to
hz_cust_site_uses_all hcsua2, --ship_to invoice line
hz_cust_site_uses_all hcsua3, --ship_to invoice header
hz_cust_site_uses_all hcsua4, --ship_to order line
hz_cust_site_uses_all hcsua5,
hz_cust_acct_sites_all hcasa1,
hz_cust_acct_sites_all hcasa2,
hz_cust_acct_sites_all hcasa3,
hz_cust_acct_sites_all hcasa4,
hz_party_sites hps1,
hz_party_sites hps2,
hz_party_sites hps3,
hz_party_sites hps4,
hz_locations hl1,
hz_locations hl2,
hz_locations hl3,
fnd_territories_vl ftv1,
fnd_territories_vl ftv2,
fnd_territories_vl ftv3,
ra_territories_kfv rtk,
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_vl jrrev,
oe_order_lines_all oola,
oe_order_headers_all ooha,
jtf_rs_salesreps jrs2,
jtf_rs_resource_extns_vl jrrev2,
ar_receipt_methods arm,
iby_fndcpt_pmt_chnnls_tl ifpct,
iby_fndcpt_tx_extensions ifte,
iby_pmt_instr_uses_all ipiua,
iby_creditcard ic,
iby_ext_bank_accounts ieba
&contracts_query
&contracts_tables
where
1=1 and
&gl_distribution_where_clause
gl.ledger_id=rcta.set_of_books_id and
haouv.organization_id=rcta.org_id and
rcta.customer_trx_id=apsa.customer_trx_id and
decode(apsa.terms_sequence_number,1,apsa.customer_trx_id)=rctla.customer_trx_id(+) and
rctla.customer_trx_line_id=rctla2.link_to_cust_trx_line_id(+) and
rcta.customer_trx_id=rctlgda0.customer_trx_id and
rctlgda0.account_class='REC' and
rctlgda0.latest_rec_flag='Y' and
rctla.customer_trx_line_id=rctlgda.link_to_cust_trx_line_id(+) and
rctla.inventory_item_id=msiv.inventory_item_id(+) and
rctla.organization_id=msiv.organization_id(+) and
rctlgda.code_combination_id=gcck.code_combination_id(+) and
rcta.batch_source_id=rbsa.batch_source_id(+) and
rcta.org_id=rbsa.org_id(+) and
rcta.batch_id=rba.batch_id(+) and
rcta.org_id=rba.org_id(+) and
rcta.cust_trx_type_id=rctta.cust_trx_type_id and
rcta.org_id=rctta.org_id and
apsa.term_id=rtt.term_id(+) and
rtt.language(+)=userenv('lang') and
apsa.cons_inv_id=acia.cons_inv_id(+) and
rcta.sold_to_customer_id=hca0.cust_account_id(+) and
apsa.customer_id=hca1.cust_account_id(+) and
rctla.ship_to_customer_id=hca2.cust_account_id(+) and
rcta.ship_to_customer_id=hca3.cust_account_id(+) and
rcta.paying_customer_id=hca5.cust_account_id(+) and
hca0.party_id=hp0.party_id(+) and
hca1.party_id=hp1.party_id(+) and
hca2.party_id=hp2.party_id(+) and
hca3.party_id=hp3.party_id(+) and
hca5.party_id=hp5.party_id(+) and
apsa.customer_site_use_id=hcsua1.site_use_id(+) and
rctla.ship_to_site_use_id=hcsua2.site_use_id(+) and
rcta.ship_to_site_use_id=hcsua3.site_use_id(+) and
oola.ship_to_org_id=hcsua4.site_use_id(+) and
rcta.paying_site_use_id=hcsua5.site_use_id(+) and
hcsua1.cust_acct_site_id=hcasa1.cust_acct_site_id(+) and
hcsua2.cust_acct_site_id=hcasa2.cust_acct_site_id(+) and
hcsua3.cust_acct_site_id=hcasa3.cust_acct_site_id(+) and
hcsua4.cust_acct_site_id=hcasa4.cust_acct_site_id(+) and
hcasa1.party_site_id=hps1.party_site_id(+) and
hcasa2.party_site_id=hps2.party_site_id(+) and
hcasa3.party_site_id=hps3.party_site_id(+) and
hcasa4.party_site_id=hps4.party_site_id(+) and
hps1.location_id=hl1.location_id(+) and
hps2.location_id=hl2.location_id(+) and
hps3.location_id=hl3.location_id(+) and
hl1.country=ftv1.territory_code(+) and
hl2.country=ftv2.territory_code(+) and
hl3.country=ftv3.territory_code(+) and
hcsua1.territory_id=rtk.territory_id(+) and
rcta.primary_salesrep_id=jrs.salesrep_id(+) and
rcta.org_id=jrs.org_id(+) and
jrs.resource_id=jrrev.resource_id(+) and
case when rctla.interface_line_context in ('INTERCOMPANY','ORDER ENTRY') then rctla.interface_line_attribute6 end=oola.line_id(+) and
oola.header_id=ooha.header_id(+) and
ooha.salesrep_id=jrs2.salesrep_id(+) and
ooha.org_id=jrs2.org_id(+) and
jrs2.resource_id=jrrev2.resource_id(+) and
rcta.receipt_method_id=arm.receipt_method_id(+) and
arm.payment_channel_code=ifpct.payment_channel_code(+) and
ifpct.language(+)=userenv('lang') and
rcta.payment_trxn_extension_id=ifte.trxn_extension_id(+) and
ifte.instr_assignment_id=ipiua.instrument_payment_use_id(+) and
decode(ipiua.instrument_type,'CREDITCARD',ipiua.instrument_id)=ic.instrid(+) and
decode(ipiua.instrument_type,'BANKACCOUNT',ipiua.instrument_id)=ieba.ext_bank_account_id(+)
&contracts_joins
order by
operating_unit,
hp1.party_name,
hca1.account_number,
trx_date,
payment_sched_gl_date,
invoice_number,
trx_number,
apsa.terms_sequence_number
&order_by_line
&order_by_distribution