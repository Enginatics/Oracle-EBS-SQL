/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
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
hp.party_name,
hca.account_number,
hcsua.location bill_to_location,
hz_format_pub.format_address(hps.location_id,null,null,' , ') bill_to_address,
hz_format_pub.format_address(nvl(hps2.location_id,hps3.location_id),null,null,' , ') ship_to_address_invoice,
hz_format_pub.format_address(hps4.location_id,null,null,' , ') ship_to_address_order,
hp.jgzz_fiscal_code taxpayer_id,
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
apsa.due_date,
case when apsa.class in ('INV','DM') and apsa.status='OP' then greatest(trunc(sysdate)-apsa.due_date,0) end overdue_days,
decode(rcta.invoicing_rule_id,-3,'Arrears','Advance') invoicing_rule,
rtt.name payment_term,
rcta.ship_date_actual ship_date,
arm.name receipt_method,
decode(apsa.status,'OP',to_date(null),apsa.actual_date_closed) actual_date_closed,
apsa.gl_date payment_sched_gl_date,
decode(apsa.status,'OP',to_date(null),apsa.gl_date_closed) payment_sched_gl_date_closed,
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
rctla.*
from
ra_customer_trx_lines_all rctla
where
'&enable_rctla'='Y' and
rctla.line_type in ('LINE','FREIGHT','CB')
) rctla,
(
select distinct
rctla2.link_to_cust_trx_line_id,
sum(rctla2.extended_amount) over (partition by rctla2.link_to_cust_trx_line_id) extended_amount,
listagg(rctla2.tax_rate,', ') within group (order by rctla2.tax_rate) over (partition by rctla2.link_to_cust_trx_line_id) tax_rates
from
ra_customer_trx_lines_all rctla2
where
'&enable_rctla'='Y' and
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
'&enable_rctlgda'='Y' and
rctla3.customer_trx_line_id=rctlgda.customer_trx_line_id and
rctlgda.account_set_flag='N'
) rctlgda,
gl_code_combinations_kfv gcck,
ra_batch_sources_all rbsa,
ra_batches_all rba,
ra_cust_trx_types_all rctta,
ra_terms_tl rtt,
ar_cons_inv_all acia,
oe_sys_parameters_all ospa,
hz_cust_accounts hca,
hz_parties hp,
hz_cust_site_uses_all hcsua,
ra_territories_kfv rtk,
hz_cust_acct_sites_all hcasa,
hz_party_sites hps,
-- inv line, header and order ship to
hz_cust_site_uses_all hcsua2,
hz_cust_acct_sites_all hcasa2,
hz_party_sites hps2,
hz_cust_site_uses_all hcsua3,
hz_cust_acct_sites_all hcasa3,
hz_party_sites hps3,
hz_cust_site_uses_all hcsua4,
hz_cust_acct_sites_all hcasa4,
hz_party_sites hps4,
--
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
rcta.org_id=ospa.org_id(+) and
ospa.parameter_code(+)='MASTER_ORGANIZATION_ID' and
apsa.customer_id=hca.cust_account_id and
hca.party_id=hp.party_id and
apsa.customer_site_use_id=hcsua.site_use_id and
hcsua.territory_id=rtk.territory_id(+) and
hcsua.cust_acct_site_id=hcasa.cust_acct_site_id and
hcasa.party_site_id=hps.party_site_id and
rcta.primary_salesrep_id=jrs.salesrep_id(+) and
rcta.org_id=jrs.org_id(+) and
jrs.resource_id=jrrev.resource_id(+) and
case when rctla.interface_line_context in ('INTERCOMPANY','ORDER ENTRY') then rctla.interface_line_attribute6 end=oola.line_id(+) and
oola.header_id=ooha.header_id(+) and
-- inv line, header, oe ship to
rctla.ship_to_site_use_id=hcsua2.site_use_id(+) and
hcsua2.cust_acct_site_id=hcasa2.cust_acct_site_id(+) and
hcasa2.party_site_id=hps2.party_site_id(+) and
rcta.ship_to_site_use_id=hcsua3.site_use_id(+) and
hcsua3.cust_acct_site_id=hcasa3.cust_acct_site_id(+) and
hcasa3.party_site_id=hps3.party_site_id(+) and
oola.ship_to_org_id=hcsua4.site_use_id(+) and
hcsua4.cust_acct_site_id=hcasa4.cust_acct_site_id(+) and
hcasa4.party_site_id=hps4.party_site_id(+) and
--
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
party_name,
account_number,
trx_date,
payment_sched_gl_date,
invoice_number,
trx_number,
apsa.terms_sequence_number
&order_by_line
&order_by_distribution