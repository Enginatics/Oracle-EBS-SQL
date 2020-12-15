/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2020 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Transaction Register
-- Description: Application: Receivables
Source: Transaction Register
Short Name: ARRXINVR
-- Excel Examle Output: https://www.enginatics.com/example/ar-transaction-register/
-- Library Link: https://www.enginatics.com/reports/ar-transaction-register/
-- Run Report: https://demo.enginatics.com/

select
  rx.organization_name                   ledger,
  rx.rec_postable_flag                   postable,
  rx.rec_balance                         "&bal_segment_p",
  rx.rec_balance_desc                    "&bal_segment_d",
  rx.trx_currency                        currency,
  arpt_sql_func_util.get_lookup_meaning('INV/CM',trx_types.type) class,
  rx.trx_number                          invoice_number,
  rx.doc_sequence_value                  document_number,
  trx_types.name                         "Type",
  substrb(bill_to_party.party_name,1,50) customer_name,
  bill_to.account_number                 customer_number,
  bill_to_site.location                  customer_site,
  rx.trx_date                            invoice_date,
  rx.receivables_gl_date                 gl_date,
  rx.trx_amount                          entered_amount,
  rx.trx_acctd_amount                    functional_amount,
  rx.rec_natacct                         receivables_account,
  rx.rec_natacct_desc                    receivables_account_desc,
  rx.rec_account                         receivables_account_full,
  rx.rec_account_desc                    receivables_account_full_desc,
  rx.functional_currency_code            functional_currency,
  rx.exchange_type                       exchange_rate_type,
  rx.exchange_date                       exchange_rate_date,
  rx.exchange_rate                       exchange_rate,
  terms.name                             payment_terms,
  rx.trx_due_date                        invoice_due_date,
  methods.name                           payment_method,
  arpt_sql_func_util.get_lookup_meaning('YES/NO', nvl(bill_to_site.tax_header_level_flag, nvl(bill_to.tax_header_level_flag, rx.tax_header_level_flag))) tax_calculation_level,
  bas.name                               batch_source,
  ba.name                                batch_name,
  rx.cons_bill_number                    consolidated_bill_number,
  doc_seq.name                           document_sequence_name,
  substrb(ship_to_party.party_name,1,50) ship_to_customer_name,
  ship_to.account_number                 ship_to_customer_number,
  ship_to_site.location                  ship_to_customer_site
from
  ar_transactions_rep_itf rx,
  ra_terms terms,
  fnd_document_sequences doc_seq,
  hz_cust_accounts ship_to,
  hz_parties ship_to_party,
  hz_cust_accounts bill_to,
  hz_parties bill_to_party,
  hz_cust_site_uses_all ship_to_site,
  hz_cust_site_uses_all bill_to_site,
  ra_cust_trx_types_all trx_types,
  ar_receipt_methods methods,
  ra_batches_all ba,
  ra_batch_sources_all bas
where
  rx.ship_to_customer_id = ship_to.cust_account_id(+)
  and ship_to.party_id = ship_to_party.party_id(+)
  and rx.ship_to_site_use_id = ship_to_site.site_use_id(+)
  and rx.bill_to_customer_id = bill_to.cust_account_id
  and bill_to.party_id = bill_to_party.party_id
  and rx.bill_to_site_use_id = bill_to_site.site_use_id
  and rx.cust_trx_type_id = trx_types.cust_trx_type_id
  and rx.term_id = terms.term_id(+)
  and rx.doc_sequence_id = doc_seq.doc_sequence_id(+)
  and rx.receipt_method_id = methods.receipt_method_id(+)
  and nvl(rx.org_id, -99) = nvl(trx_types.org_id, -99)
  and rx.batch_id = ba.batch_id(+)
  and rx.batch_source_id = bas.batch_source_id(+)
  and nvl(rx.org_id, -99) = nvl(bas.org_id, -99)
 and rx.request_id = fnd_global.conc_request_id
order by
  rx.organization_name,
  rx.rec_postable_flag,
  rx.rec_balance,
  rx.trx_currency,
  arpt_sql_func_util.get_lookup_meaning('INV/CM',trx_types.type),
  rx.trx_number,
  rx.doc_sequence_value