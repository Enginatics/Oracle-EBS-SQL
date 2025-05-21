/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Unaccounted Transaction Sweep
-- Description: Imported from BI Publisher
Application: Receivables
Source: Unaccounted Transaction Sweep
Short Name: ARTRXSWP
DB package: ar_unaccounted_trx_sweep
-- Excel Examle Output: https://www.enginatics.com/example/ar-unaccounted-transaction-sweep/
-- Library Link: https://www.enginatics.com/reports/ar-unaccounted-transaction-sweep/
-- Run Report: https://demo.enginatics.com/

select 
ar_unaccounted_trx_sweep.get_ledger_name ledger_name,
unaccounted_ar.*
from 
(select
gt.document_type,
gt.org_id org_id, 
org.name org_name,
party.party_number "Customer Number/Payee Number",
party.party_name "Customer Name/Payee Name",
gt.customer_trx_id "Trx Id/Receipt Id/BR Id/ADJ Id",
gt.trx_number "Trx Num/Rct Num/BR Num",
null adj_number,
fnd_date.date_to_chardate(gt.gl_date)gl_date,
gt.currency_code,
to_char(ps.amount_due_original,fnd_currency.get_format_mask(gt.currency_code, 40))amount,
xae.encoded_msg accounting_error_message,
gt.account_class dist_type,
null oth_doc_type,
to_number(to_char(gt.amount_dr,fnd_currency.get_format_mask(gt.currency_code, 40)))entered_debit,
to_number(to_char(gt.amount_cr,fnd_currency.get_format_mask(gt.currency_code, 40)))entered_credit,
to_number(to_char(gt.acctd_amount_dr,fnd_currency.get_format_mask(gt.currency_code,40)))accounted_debit,
to_number(to_char(gt.acctd_amount_cr,fnd_currency.get_format_mask(gt.currency_code, 40)))accounted_credt,
glcc.concatenated_segments dist_account_code
from
ar_period_close_excps_gt gt,
hz_cust_accounts acct,
hz_parties party,
ar_payment_schedules_all ps,
hr_operating_units org,
xla_accounting_errors xae,
ra_cust_trx_line_gl_dist_all gld,
gl_code_combinations_kfv glcc
where
gt.document_type='UNACCT_TRX' and
org.organization_id=gt.org_id and
acct.cust_account_id=gt.customer_id and
party.party_id=acct.party_id and
ps.customer_trx_id=gt.customer_trx_id and
xae.event_id(+)=gt.event_id and
gld.cust_trx_line_gl_dist_id(+)=gt.cust_trx_line_gl_dist_id and
glcc.code_combination_id(+)=gld.code_combination_id
union all
select 
gt.document_type,
gt.org_id org_id, 
org.name org_name,
party.party_number "Customer Number/Payee Number",
party.party_name "Customer Name/Payee Name",
gt.cash_receipt_id "Trx Id/Receipt Id/BR Id/ADJ Id",
gt.receipt_number "Trx Num/Rct Num/BR Num",
null adj_number,
fnd_date.date_to_chardate(gt.gl_date)gl_date,
gt.currency_code,
to_char(ps.amount_due_original,fnd_currency.get_format_mask(gt.currency_code, 40))amount,
xae.encoded_msg accounting_error_message,
gt.dist_source_type dist_type,
null oth_doc_type,
to_number(to_char(gt.amount_dr,fnd_currency.get_format_mask(gt.currency_code, 40)))entered_debit,
to_number(to_char(gt.amount_cr,fnd_currency.get_format_mask(gt.currency_code, 40)))entered_credit,
to_number(to_char(gt.acctd_amount_dr,fnd_currency.get_format_mask(gt.currency_code,40)))accounted_debit,
to_number(to_char(gt.acctd_amount_cr,fnd_currency.get_format_mask(gt.currency_code, 40)))accounted_credt,
glcc.concatenated_segments dist_account_code
from
ar_period_close_excps_gt gt,
hz_cust_accounts acct,
hr_operating_units org,
hz_parties party,
xla_accounting_errors xae,
ar_distributions_all dst,
gl_code_combinations_kfv glcc,
ar_payment_schedules_all ps
where
gt.document_type = 'UNACCT_RCT' and
org.organization_id=gt.org_id and
xae.event_id(+)=gt.event_id and
acct.cust_account_id=gt.customer_id and
party.party_id=acct.party_id and
ps.cash_receipt_id=gt.cash_receipt_id and
dst.line_id(+) = gt.dist_line_id and
glcc.code_combination_id(+) = dst.code_combination_id
union all
select
gt.document_type,
gt.org_id org_id, 
org.name org_name,
party.party_number "Customer Number/Payee Number",
party.party_name "Customer Name/Payee Name",
gt.customer_trx_id "Trx Id/Receipt Id/BR Id/ADJ Id",
gt.trx_number "Trx Num/Rct Num/BR Num",
null adj_number,
fnd_date.date_to_chardate(gt.gl_date)gl_date,
gt.currency_code,
to_char(ps.amount_due_original,fnd_currency.get_format_mask(gt.currency_code, 40))amount,
xae.encoded_msg accounting_error_message,
gt.dist_source_type dist_type,
null oth_doc_type,
to_number(to_char(gt.amount_dr,fnd_currency.get_format_mask(gt.currency_code, 40)))entered_debit,
to_number(to_char(gt.amount_cr,fnd_currency.get_format_mask(gt.currency_code, 40)))entered_credit,
to_number(to_char(gt.acctd_amount_dr,fnd_currency.get_format_mask(gt.currency_code,40)))accounted_debit,
to_number(to_char(gt.acctd_amount_cr,fnd_currency.get_format_mask(gt.currency_code, 40)))accounted_credt,
glcc.concatenated_segments dist_account_code
from
ar_period_close_excps_gt gt,
hz_cust_accounts acct,
hr_operating_units org,
hz_parties party,
xla_accounting_errors xae,
ar_payment_schedules_all ps,
ar_distributions_all dst,
gl_code_combinations_kfv glcc
where
gt.document_type = 'UNACCT_BR' and
org.organization_id=gt.org_id and
xae.event_id(+)=gt.event_id and
acct.cust_account_id=gt.customer_id and
party.party_id=acct.party_id and
ps.customer_trx_id=gt.customer_trx_id and
gt.dist_line_id=dst.line_id(+) and
glcc.code_combination_id(+)=dst.code_combination_id
union all
select
gt.document_type,
gt.org_id org_id, 
org.name org_name,
party.party_number  "Customer Number/Payee Number",
party.party_name "Customer Name/Payee Name",
gt.customer_trx_id  "Trx Id/Receipt Id/BR Id/ADJ Id",
gt.trx_number "Trx Num/Rct Num/BR Num",
gt.adjustment_number adj_number,
fnd_date.date_to_chardate(gt.gl_date)gl_date,
gt.currency_code,
to_char(adj.amount,fnd_currency.get_format_mask(gt.currency_code, 40))amount,
xae.encoded_msg accounting_error_message,
gt.dist_source_type dist_type,
null oth_doc_type,
to_number(to_char(gt.amount_dr,fnd_currency.get_format_mask(gt.currency_code, 40)))entered_debit,
to_number(to_char(gt.amount_cr,fnd_currency.get_format_mask(gt.currency_code, 40)))entered_credit,
to_number(to_char(gt.acctd_amount_dr,fnd_currency.get_format_mask(gt.currency_code,40)))accounted_debit,
to_number(to_char(gt.acctd_amount_cr,fnd_currency.get_format_mask(gt.currency_code, 40)))accounted_credt,
glcc.concatenated_segments dist_account_code
from
ar_period_close_excps_gt gt,
hz_cust_accounts acct,
hr_operating_units org,
xla_accounting_errors xae,
hz_parties party,
ar_adjustments_all adj,
ar_distributions_all dst,
gl_code_combinations_kfv glcc
where
gt.document_type = 'UNACCT_ADJ' and
org.organization_id=gt.org_id and
xae.event_id(+)=gt.event_id and
acct.cust_account_id=gt.customer_id and
party.party_id=acct.party_id and
adj.adjustment_id=gt.adjustment_id and
gt.dist_line_id=dst.line_id(+) and
glcc.code_combination_id(+)=dst.code_combination_id
union all
select 
gt.document_type,
gt.org_id org_id, 
org.name org_name,
null  "Customer Number/Payee Number",
null  "Customer Name/Payee Name",
null "Trx Id/Receipt Id/BR Id/ADJ Id",
trx.trx_number "Trx Num/Rct Num/BR Num",
null adj_number,
fnd_date.date_to_chardate(gt.gl_date)gl_date,
gt.currency_code,
null amount ,
xae.encoded_msg accounting_error_message,
null dist_type,
decode(gt.customer_trx_id, null, 'RECEIPTS', 'TRANSACTIONS')oth_doc_type,
gt.amount_dr entered_debit,
gt.amount_cr entered_credit,
null accounted_debit,
null accounted_credit,
null dist_account_code
from ar_period_close_excps_gt gt,
ra_customer_trx_all trx,
xla_accounting_errors xae,
hr_operating_units org
where gt.document_type = 'OTHER_EXCEPTIONS' and 
org.organization_id=gt.org_id and
xae.event_id(+)=gt.event_id and
trx.customer_trx_id = gt.customer_trx_id 
)unaccounted_ar