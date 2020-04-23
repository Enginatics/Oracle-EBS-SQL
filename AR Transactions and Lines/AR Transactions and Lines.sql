/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Transactions and Lines
-- Description: Receivables transactions and line details including additional columns specifically for service (OKS) and lease (OKL) contracts.
Note: This report shows completed transactions only as it is based on table ar_payment_schedules_all.
-- Excel Examle Output: https://www.enginatics.com/example/ar-transactions-and-lines
-- Library Link: https://www.enginatics.com/reports/ar-transactions-and-lines
-- Run Report: https://demo.enginatics.com/


select
x.invoice_number,
x.trx_number,
to_number(to_char(x.trx_date,'MM')) trx_month,
x.trx_date,
x.class,
x.type,
x.reference,
x.purchase_order,
x.credited_invoice,
x.credited_invoice_line,
x.account_number,
x.party_name,
x.currency,
decode(x.first_line,'Y',x.total_due_original) total_due_original,
decode(x.first_line,'Y',x.total_payment_applied) total_payment_applied,
decode(x.first_line,'Y',x.total_adjustment) total_adjustment,
decode(x.first_line,'Y',x.total_credit) total_credit,
decode(x.first_line,'Y',x.total_due_remaining) total_due_remaining,
decode(x.first_line,'Y',x.dispute_amount) dispute_amount,
x.status,
x.payment_term,
x.invoicing_rule,
x.due_date,
x.overdue_days,
x.ship_date,
x.receipt_method,
x.payment_method,
x.instrument_number,
x.print_option,
x.first_printed_date,
x.customer_reference,
x.comments,
x.bill_to_location,
x.bill_to_address,
null ship_to_city,
null ship_to_state,
x.taxpayer_id,
x.sales_rep,
----------line---------
x.line,
x.item,
x.description,
x.uom_code,
x.quantity,
x.unit_price,
x.amount,
x.tax_rate,
x.tax_amount,
x.amount+nvl(x.tax_amount,0) amount_incl_tax,
x.category,
x.sales_order,
x.sales_order_line,
x.sales_order_date,
gcck.concatenated_segments revenue_account,
&account_columns
----------oks contracts----------
nvl(okhab.contract_number,x.okl_contract_number) contract_number,
nvl(x.contract_line,oklt1.name) contract_line,
cii.serial_number,
xxen_util.meaning(olsb.lty_code,'OKC_LINE_TYPE',0)||decode(x.usage_type,'VRT',' Actual','FRT',' Fixed','NPR',' Negotiated') contract_line_type,
nvl(x.date_billed_from,case when x.invoicing_rule='Advance' then x.billing_due_date when x.invoicing_rule='Arrears' then add_months(x.billing_due_date,-x.frequency)+1 end) date_billed_from,
nvl(x.date_billed_to,case when x.invoicing_rule='Advance' then add_months(x.billing_due_date,x.frequency)-1 when x.invoicing_rule='Arrears' then x.billing_due_date end) date_billed_to,
x.end_read,
x.end_read_date,
x.actual,
x.result,
x.date_terminated,
x.covered_item,
x.installed_counter,
----------OKL contracts----------
x.frequency,
x.okl_stream_type,
x.billing_due_date,
round(x.first_printed_date-decode(x.class_,'INV',x.billing_due_date)) contract_billing_delay,
x.operating_unit,
x.created_by,
xxen_util.client_time(x.creation_date) creation_date,
x.customer_trx_id,
x.customer_trx_line_id
from
(
select
haouv.name operating_unit,
acia.cons_billing_number invoice_number,
rcta.trx_number,
apsa.trx_date,
xxen_util.meaning(apsa.class,'INV/CM/ADJ',222)||case when apsa.class='CM' and obcl.bill_action='TR' then ' termination' end class,
apsa.class class_,
rctta.name type,
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
hca.account_number,
hp.party_name,
hcsua.location bill_to_location,
hz_format_pub.format_address(hps.location_id,null,null,' , ') bill_to_address,
hp.jgzz_fiscal_code taxpayer_id,
apsa.invoice_currency_code currency,
apsa.amount_due_original total_due_original,
apsa.amount_applied total_payment_applied,
apsa.amount_adjusted total_adjustment,
apsa.amount_credited total_credit,
apsa.amount_due_remaining total_due_remaining,
case when rctta.accounting_affect_flag='Y' and apsa.amount_in_dispute<>0 then apsa.amount_in_dispute end dispute_amount,
xxen_util.meaning(apsa.status,'PAYMENT_SCHEDULE_STATUS',222) status,
rtt.name payment_term,
decode(rcta.invoicing_rule_id,-3,'Arrears','Advance') invoicing_rule,
apsa.due_date,
case when apsa.class in ('INV','DM') and apsa.status='OP' then greatest(trunc(sysdate)-apsa.due_date,0) end overdue_days,
rcta.ship_date_actual ship_date,
arm.name receipt_method,
ifpct.payment_channel_name payment_method,
decode(ipiua.instrument_type,'BANKACCOUNT',ieba.masked_bank_account_num,'CREDITCARD',ic.masked_cc_number) instrument_number,
xxen_util.meaning(rcta.printing_option,'INVOICE_PRINT_OPTIONS',222) print_option,
rcta.printing_original_date first_printed_date,
rcta.customer_reference,
rcta.comments,
jrret.resource_name sales_rep,
----------line----------
decode(rctla.line_type,'FREIGHT',null,rctla.line_number) line,
nvl((select msibk.concatenated_segments from mtl_system_items_b_kfv msibk where rctla.inventory_item_id=msibk.inventory_item_id and nvl(rctla.warehouse_id,ospa.parameter_value)=msibk.organization_id),xxen_util.meaning(rctla.line_type,'STD_LINE_TYPE',222)) item,
rctla.description,
muomt.unit_of_measure_tl uom_code,
nvl(rctla.quantity_credited,rctla.quantity_invoiced) quantity,
rctla.unit_selling_price unit_price,
rctla.extended_amount amount,
(select rctla2.tax_rate from ra_customer_trx_lines_all rctla2 where rctla.customer_trx_line_id=rctla2.link_to_cust_trx_line_id and rctla2.line_type='TAX' and rownum=1) tax_rate,
(select sum(rctla2.extended_amount) from ra_customer_trx_lines_all rctla2 where rctla.customer_trx_line_id=rctla2.link_to_cust_trx_line_id and rctla2.line_type='TAX') tax_amount,
nvl(rctla.interface_line_context,rbsa.name) category,
nvl(rctla.sales_order,rctla.interface_line_attribute1) sales_order,
rctla.sales_order_line,
rctla.sales_order_date,
(select rctlgda.code_combination_id from ra_cust_trx_line_gl_dist_all rctlgda where rctla.customer_trx_line_id=rctlgda.customer_trx_line_id and rctlgda.account_class='REV' and rctlgda.account_set_flag='N' and rctlgda.gl_date is not null and rctlgda.amount is not null and rctlgda.acctd_amount is not null and nvl(rctlgda.ccid_change_flag,'Y')='Y' and rownum=1) revenue_account_id,
xxen_util.user_name(rctla.created_by) created_by,
rctla.creation_date,
rctla.customer_trx_id,
rctla.customer_trx_line_id,
decode(rctla.customer_trx_line_id,min(rctla.customer_trx_line_id) keep (dense_rank first order by decode(rctla.line_type,'FREIGHT',null,rctla.line_number)) over (partition by apsa.payment_schedule_id),'Y') first_line,
----------OKS contracts----------
oklb1.line_number||nvl2(oklb2.line_number,'.',null)||oklb2.line_number contract_line,
okslb1.usage_type,
obsl.date_billed_from,
obsl.date_billed_to,
ccv.counter_reading end_read,
ccv.value_timestamp end_read_date,
obsld.actual,
decode(oklb2.lse_id,13,obsld.result) result,
nvl(oklb2.date_terminated,oklb.date_terminated) date_terminated,
msiv2.concatenated_segments||nvl2(msiv2.description,' - '||msiv2.description,null) covered_item,
cc.name installed_counter,
----------OKL contracts----------
nvl(round(months_between(obsl.date_billed_to+1,obsl.date_billed_from),2),ocasb.frequency) frequency,
ostb.code okl_stream_type,
nvl(decode(rcta.invoicing_rule_id,-3,obsl.date_billed_to+1,obsl.date_billed_from),decode(rctla.interface_line_context,'OKS CONTRACTS',decode(rcta.invoicing_rule_id,-3,to_date(rctla.interface_line_attribute5,'YYYY/MM/DD HH24:MI:SS')+1,to_date(rctla.interface_line_attribute4,'YYYY/MM/DD HH24:MI:SS')),ose.stream_element_date)) billing_due_date,
case when rctla.interface_line_context in ('OKL_CONTRACTS','OKL_INVESTOR') then rctla.interface_line_attribute1 end okl_contract_number,
nvl(
decode(oki2.jtot_object1_code,'OKX_CUSTPROD',oki2.object1_id1,'OKX_COUNTER',ccg.source_object_id),
(
select
oki3.object1_id1
from
okc_k_lines_b oklb2,
okc_k_lines_b oklb3,
okc_k_items oki3
where
case when oklb.lse_id in (49,53) then (select to_number(oki2.object1_id1) from okc_k_items oki2 where ocasb.kle_id=oki2.cle_id and oki2.jtot_object1_code='OKX_COVASST' and rownum=1) else ocasb.kle_id end=oklb2.cle_id and
oklb2.lse_id=43 and
oklb3.lse_id=45 and
oklb2.id=oklb3.cle_id and
oklb3.id=oki3.cle_id and
oki3.jtot_object1_code='OKX_IB_ITEM' and
rownum=1
)
) instance_id,
nvl(oklb2.dnz_chr_id,ocasb.khr_id) dnz_chr_id,
case when oklb.lse_id in (49,53) then oklb.cle_id else ocasb.kle_id end oklb1_id,
nvl(oklb2.lse_id,oklb.lse_id) lse_id
from
hr_all_organization_units haouv,
ar_payment_schedules_all apsa,
ra_customer_trx_all rcta,
ra_customer_trx_lines_all rctla,
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
ar_receipt_methods arm,
iby_fndcpt_pmt_chnnls_tl ifpct,
iby_fndcpt_tx_extensions ifte,
iby_pmt_instr_uses_all ipiua,
iby_creditcard ic,
iby_ext_bank_accounts ieba,
mtl_units_of_measure_tl muomt,
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_tl jrret,
----------OKS contracts----------
oks_bill_txn_lines obtl,
oks_bill_cont_lines obcl,
oks_bill_sub_lines obsl,
oks_bill_sub_line_dtls obsld,
cs_counter_values ccv,
(select oki2.* from okc_k_items oki2 where oki2.jtot_object1_code in ('OKX_COVITEM','OKX_CUSTPROD','OKX_COUNTER')) oki2,
okc_k_lines_b oklb2,
okc_k_lines_b oklb1,
oks_k_lines_b okslb1,
cs_counters cc,
cs_counter_groups ccg,
mtl_system_items_vl msiv2,
----------OKL contracts----------
(
select
ocasb.*,
(select decode(orb.object1_id1,'A',12,'S',6,'Q',3,'M',1) from okc_rules_b orb where orgb.id=orb.rgp_id and orb.rule_information7 is null and orb.rule_information_category='LASLL' and rownum=1) frequency
from
okl_cnsld_ar_strms_b ocasb,
(select * from okc_rule_groups_b orgb where orgb.rgd_code='LALEVL') orgb
where
ocasb.kle_id=orgb.cle_id(+)
) ocasb,
okl_strm_type_b ostb,
okl_strm_elements ose,
okc_k_lines_b oklb
where
1=1 and
apsa.payment_schedule_id>0 and
apsa.org_id=haouv.organization_id and
rcta.org_id=haouv.organization_id and
rctla.org_id=haouv.organization_id and
apsa.class in ('INV','CB','DM','CM','GUAR','DEP','BR') and
apsa.customer_trx_id=rcta.customer_trx_id and
apsa.customer_trx_id=rctla.customer_trx_id and
rctla.line_type<>'TAX' and
apsa.org_id=ospa.org_id(+) and
ospa.parameter_code(+)='MASTER_ORGANIZATION_ID' and
apsa.term_id=rtt.term_id(+) and
rtt.language(+)=userenv('lang') and
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
rcta.receipt_method_id=arm.receipt_method_id(+) and
arm.payment_channel_code=ifpct.payment_channel_code(+) and
ifpct.language(+)=userenv('lang') and
rcta.payment_trxn_extension_id=ifte.trxn_extension_id(+) and
ifte.instr_assignment_id=ipiua.instrument_payment_use_id(+) and
decode(ipiua.instrument_type,'CREDITCARD',ipiua.instrument_id)=ic.instrid(+) and
decode(ipiua.instrument_type,'BANKACCOUNT',ipiua.instrument_id)=ieba.ext_bank_account_id(+) and
rctla.uom_code=muomt.uom_code(+) and
muomt.language(+)=userenv('lang') and
case when rcta.primary_salesrep_id>0 then rcta.primary_salesrep_id end=jrs.salesrep_id(+) and
case when rcta.primary_salesrep_id>0 then rcta.org_id end=jrs.org_id(+) and
jrs.resource_id=jrret.resource_id(+) and
jrret.language(+)=userenv('lang') and
----------OKS contracts----------
decode(rctla.interface_line_context,'OKS CONTRACTS',rctla.interface_line_attribute3)=obtl.bill_instance_number(+) and
obtl.bsl_id=obsl.id(+) and
obsl.bcl_id=obcl.id(+) and
obtl.bsl_id=obsld.bsl_id(+) and
obsld.ccr_id=ccv.counter_value_id(+) and
obsl.cle_id=oki2.cle_id(+) and
decode(oki2.jtot_object1_code,'OKX_COVITEM',oki2.object1_id1)=msiv2.inventory_item_id(+) and
decode(oki2.jtot_object1_code,'OKX_COVITEM',oki2.object1_id2)=msiv2.organization_id(+) and
decode(oki2.jtot_object1_code,'OKX_COUNTER',oki2.object1_id1)=cc.counter_id(+) and
cc.counter_group_id=ccg.counter_group_id(+) and
ccg.source_object_code(+)='CP' and
obsl.cle_id=oklb2.id(+) and
oklb2.cle_id=oklb1.id(+) and
oklb2.cle_id=okslb1.cle_id(+) and
----------OKL contracts----------
decode(rctla.interface_line_context,'OKL_CONTRACTS',rctla.interface_line_attribute10||rctla.interface_line_attribute11)=ocasb.id(+) and
ocasb.sty_id=ostb.id(+) and
ocasb.sel_id=ose.id(+) and
ocasb.kle_id=oklb.id(+)
) x,
gl_code_combinations_kfv gcck,
okc_line_styles_b olsb,
csi_item_instances cii,
okc_k_headers_all_b okhab,
okc_k_lines_tl oklt1
where
x.revenue_account_id=gcck.code_combination_id(+) and
x.lse_id=olsb.id(+) and
x.instance_id=cii.instance_id(+) and
x.dnz_chr_id=okhab.id(+) and
x.oklb1_id=oklt1.id(+) and
oklt1.language(+)=userenv('lang')
order by
x.operating_unit,
x.party_name,
x.account_number,
x.trx_date desc,
x.invoice_number desc,
x.trx_number desc,
x.line,
x.item