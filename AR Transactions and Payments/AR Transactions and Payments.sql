/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Transactions and Payments
-- Description: Detail AR customer billing history including payments / cash receipts, excluding any entered or incomplete transactions.
-- Excel Examle Output: https://www.enginatics.com/example/ar-transactions-and-payments/
-- Library Link: https://www.enginatics.com/reports/ar-transactions-and-payments/
-- Run Report: https://demo.enginatics.com/

select
x.legal_entity,
x.legal_entity_identifier,
x.ledger,
x.operating_unit,
x.invoice_number,
x.transaction_number,
x.transaction_date,
x.class,
x.type,
x.reference,
x.credited_or_paid_invoice,
x.account_number,
x.party_name,
x.currency,
x.due_original,
x.payment_applied,
x.adjustment,
x.credit,
x.due_remaining,
x.dispute_amount,
&reval_cols
x.state,
x.status,
x.last_date_cash_applied,
x.actual_date_closed,
x.payment_sched_gl_date,
x.payment_sched_gl_date_closed,
x.payment_term,
x.invoicing_rule,
x.due_date,
x.overdue_days,
x.ship_date,
arm.name receipt_method,
ifpct.payment_channel_name payment_method,
decode(ipiua.instrument_type,'BANKACCOUNT',ieba.masked_bank_account_num,'CREDITCARD',ic.masked_cc_number) instrument_number,
nvl(ifte.payment_system_order_number,nvl2(ifte.trxn_extension_id,substr(iby_fndcpt_trxn_pub.get_tangible_id(fa.application_short_name,ifte.order_id,ifte.trxn_ref_number1,ifte.trxn_ref_number2),1,80),null)) pson,
hp2.party_name bank_name,
hp3.party_name bank_branch,
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
nvl(xep1.name,xep2.name) legal_entity,
nvl(xep1.legal_entity_identifier,xep2.legal_entity_identifier) legal_entity_identifier,
gl.name ledger,
hou.name operating_unit,
acia.cons_billing_number invoice_number,
nvl(rcta.trx_number,acra.receipt_number) transaction_number,
apsa.trx_date transaction_date,
xxen_util.meaning(apsa.class,'INV/CM/ADJ',222) class,
nvl(rctta.name,'Standard') type,
nvl(rcta.ct_reference,acra.customer_receipt_reference) reference,
decode(apsa.class,'PMT',
(
select distinct
listagg(z.trx_number,', ') within group (order by z.trx_number) over (partition by z.cash_receipt_id) applied_trx
from
(
select
y.*
from
(
select
sum(lengthb(x.trx_number)+2) over (partition by x.cash_receipt_id order by x.trx_number rows between unbounded preceding and current row) length,
x.*
from
(
select
araa.cash_receipt_id,
nvl2(acia0.cons_billing_number,acia0.cons_billing_number||' - ',null)||rcta0.trx_number trx_number
from
ar_receivable_applications_all araa,
ra_customer_trx_all rcta0,
ar_cons_inv_trx_all acita0,
ar_cons_inv_all acia0
where
araa.display='Y' and
araa.status='APP' and
araa.applied_customer_trx_id=rcta0.customer_trx_id and
rcta0.customer_trx_id=acita0.customer_trx_id(+) and
acita0.cons_inv_id=acia0.cons_inv_id(+)
) x
) y
where y.length<=4000
) z
where
apsa.cash_receipt_id=z.cash_receipt_id
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
) credited_or_paid_invoice,
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
nvl(xxen_util.meaning(acrha.status,'RECEIPT_CREATION_STATUS',222),decode(apsa.status,'CL','Closed',decode(apsa.amount_due_remaining,apsa.amount_due_original,'Open','Partially Paid'))) state,
apsa.status,
(
select
max(ara.apply_date)
from
ar_receivable_applications_all ara
where
apsa.status = 'OP' and
ara.applied_customer_trx_id = apsa.customer_trx_id and
ara.applied_payment_schedule_id = apsa.payment_schedule_id and
ara.cash_receipt_id is not null and
ara.reversal_gl_date is null
) last_date_cash_applied,
decode(apsa.status,'OP',to_date(null),apsa.actual_date_closed) actual_date_closed,
apsa.gl_date payment_sched_gl_date,
decode(apsa.status,'OP',to_date(null),apsa.gl_date_closed) payment_sched_gl_date_closed,
rtt.name payment_term,
decode(rcta.invoicing_rule_id,-3,'Arrears',-2,'Advance') invoicing_rule,
apsa.due_date,
case when apsa.class in ('INV','DM') and apsa.status='OP' then greatest(trunc(sysdate)-apsa.due_date,0) end overdue_days,
rcta.ship_date_actual ship_date,
hop.organization_name remit_bank_name,
hp4.party_name remit_bank_branch,
case when cba.bank_account_id is not null then ce_bank_and_account_util.get_masked_bank_acct_num(cba.bank_account_id) end remit_bank_account,
xxen_util.meaning(rcta.printing_option,'INVOICE_PRINT_OPTIONS',222) print_option,
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
nvl(rcta.payment_trxn_extension_id,acra.payment_trxn_extension_id) payment_trxn_extension_id,
-- reval
gl.currency_code ledger_currency,
decode(gl.currency_code,:p_reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gl.currency_code=gdr.from_currency and gdr.to_currency=:p_reval_currency and :p_reval_conv_date=gdr.conversion_date and gdct.user_conversion_type=:p_reval_conv_type and gdct.conversion_type=gdr.conversion_type)) reval_conv_rate,
apsa.amount_due_original * nvl(apsa.exchange_rate,1) acctd_due_original,
apsa.amount_applied * nvl(apsa.exchange_rate,1) acctd_payment_applied,
apsa.amount_adjusted * nvl(apsa.exchange_rate,1) acctd_adjustment,
apsa.amount_credited * nvl(apsa.exchange_rate,1) acctd_credit,
apsa.acctd_amount_due_remaining,
case when rctta.accounting_affect_flag='Y' and apsa.amount_in_dispute<>0 then apsa.amount_in_dispute * nvl(apsa.exchange_rate,1) end acctd_dispute_amount
from
gl_ledgers gl,
hr_operating_units hou,
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
jtf_rs_salesreps jrs,
jtf_rs_resource_extns_tl jrret,
ar_cash_receipts_all acra,
ar_cash_receipt_history_all acrha,
ce_bank_acct_uses_all cbaua,
ce_bank_accounts cba,
hz_parties hp4,
hz_relationships hr,
(select hop.* from hz_organization_profiles hop where sysdate between hop.effective_start_date and nvl(hop.effective_end_date,sysdate)) hop,
xle_entity_profiles xep1,
xle_entity_profiles xep2
where
1=1 and
apsa.payment_schedule_id>0 and
gl.ledger_id=hou.set_of_books_id and
hou.organization_id=apsa.org_id and
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
case when rcta.primary_salesrep_id>0 then rcta.primary_salesrep_id end=jrs.salesrep_id(+) and
case when rcta.primary_salesrep_id>0 then rcta.org_id end=jrs.org_id(+) and
jrs.resource_id=jrret.resource_id(+) and
jrret.language(+)=userenv('lang') and
apsa.cash_receipt_id=acra.cash_receipt_id(+) and
apsa.cash_receipt_id=acrha.cash_receipt_id(+) and
acrha.current_record_flag(+)='Y' and
acra.remit_bank_acct_use_id=cbaua.bank_acct_use_id(+) and
cbaua.bank_account_id=cba.bank_account_id(+) and
cba.bank_branch_id=hp4.party_id(+) and
hp4.party_id=hr.subject_id(+) and
hr.relationship_type(+)='BANK_AND_BRANCH' and
hr.relationship_code(+)='BRANCH_OF' and
hr.status(+)='A' and
hr.subject_table_name(+)='HZ_PARTIES' and
hr.subject_type(+)='ORGANIZATION' and
hr.object_table_name(+)='HZ_PARTIES' and
hr.object_type(+)='ORGANIZATION' and
hr.object_id=hop.party_id(+) and
xep1.legal_entity_id(+)=rcta.legal_entity_id and
xep2.legal_entity_id(+)=acra.legal_entity_id
) x,
ar_receipt_methods arm,
iby_fndcpt_pmt_chnnls_tl ifpct,
iby_fndcpt_tx_extensions ifte,
fnd_application fa,
iby_pmt_instr_uses_all ipiua,
iby_ext_bank_accounts ieba,
hz_parties hp2,
hz_parties hp3,
iby_creditcard ic
where
x.receipt_method_id=arm.receipt_method_id(+) and
arm.payment_channel_code=ifpct.payment_channel_code(+) and
ifpct.language(+)=userenv('lang') and
x.payment_trxn_extension_id=ifte.trxn_extension_id(+) and
ifte.origin_application_id=fa.application_id(+) and
ifte.instr_assignment_id=ipiua.instrument_payment_use_id(+) and
decode(ipiua.instrument_type,'BANKACCOUNT',ipiua.instrument_id)=ieba.ext_bank_account_id(+) and
ieba.bank_id=hp2.party_id(+) and
ieba.branch_id=hp3.party_id(+) and
decode(ipiua.instrument_type,'CREDITCARD',ipiua.instrument_id)=ic.instrid(+)
order by
x.operating_unit,
x.transaction_date desc,
x.invoice_number desc,
x.transaction_number desc