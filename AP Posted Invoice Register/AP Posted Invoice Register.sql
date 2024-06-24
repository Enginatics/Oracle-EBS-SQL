/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Posted Invoice Register
-- Description: Application: Payables
Description: Payables Posted Invoice Register

This report provides equivalent functionality to the Oracle standard Payables Posted Invoice Register report.

For scheduling the report to run periodically, use the relative period from/to offset parameters. These are the relative period offsets to the current period, so when the current period changes, the included periods will also automatically be updated when the report is re-run.

Templates
- Pivot: Summary by Account, Invoice Currency
  Equivalent to standard report in Summarize Report = Yes Mode 
- Pivot: Summary by Account, Batch, Invoice Currency
  Equivalent to standard report in Summarize=No Order By=Journal Entry Batch
- Pivot: Summary by Account, Invoice Currency, Batch
  Equivalent to standard report in Summarize=No Order By=Entered Currency
- Detail
  Provides detail listing of the posted invoices

Additional data fields are available. Run the report without a template to see full list available fields

Source: Payables Posted Invoice Register
Short Name: APXPOINV
DB package: XLA_JELINES_RPT_PKG

Also requires custom package XXEN_XLA package to be installed to initialize the hidden parameters removed from the report to simplify scheduling of the report.
-- Excel Examle Output: https://www.enginatics.com/example/ap-posted-invoice-register/
-- Library Link: https://www.enginatics.com/reports/ap-posted-invoice-register/
-- Run Report: https://demo.enginatics.com/

select
 x.application_name
,x.ledger_short_name
,x.ledger_description
,x.ledger_name
,x.ledger_currency
-- posting account data
,x.accounting_code_combination  account
,x.code_combination_description account_description
,x.control_account_flag
-- gl data
,x.period_name
,x.gl_date
,x.gl_batch_name
,x.je_source_name     gl_journal_source
,x.je_category_name   gl_journal_category
,x.gl_je_name         gl_journal_name
,x.gl_line_number     gl_journal_line_num
,x.header_description
,x.line_description
-- amounts
,x.entered_currency invoice_currency
,x.entered_dr
,x.entered_cr
,x.unrounded_accounted_dr
,x.unrounded_accounted_cr
,x.accounted_dr
,x.accounted_cr
,x.statistical_amount
-- source transaction data
,x.user_trx_identifier_value_1  supplier_name
,x.transaction_number           invoice_number
,x.transaction_date             invoice_date
,x.user_trx_identifier_value_10 invoice_description
,to_number(x.user_trx_identifier_value_4)  invoice_amount
-- other gl specific data
,x.gl_default_effective_date
,x.gl_batch_status
,x.posted_date        gl_posted_date
,x.external_reference gl_external_reference
,x.reference_1        gl_reference_1
,x.reference_4        gl_reference_4
,x.gl_doc_sequence_name
,x.gl_doc_sequence_value
-- other date, status, type data
,x.gl_transfer_date
,x.reference_date
,x.completed_date
,x.journal_entry_status
,x.transfer_to_gl_status
,x.balance_type_code
,x.balance_type
,x.budget_name
,x.encumbrance_type
,x.fund_status
-- sla specific data
,x.event_date                        sla_event_date
,x.event_number                      sla_event_number
,x.event_class_code                  sla_event_class_code
,x.event_class_name                  sla_event_class_name
,x.event_type_code                   sla_event_type_code
,x.event_type_name                   sla_event_type_name
,nvl2(x.event_id,x.line_number,null) sla_line_number
,x.accounting_class_code             sla_accounting_class_code
,x.accounting_class_name             sla_accounting_class_name
,x.accounting_sequence_name          sla_accounting_seq_name
,x.accounting_sequence_version       sla_accounting_seq_version
,x.accounting_sequence_number        sla_accounting_seq_number
,x.reporting_sequence_name           sla_reporting_seq_name
,x.reporting_sequence_version        sla_reporting_seq_version
,x.reporting_sequence_number         sla_reporting_seq_number
,x.document_category                 sla_document_category
,x.document_sequence_name            sla_document_seq_name
,x.document_sequence_number          sla_document_seq_number
-- period data points
,x.period_year
,x.period_number
,x.period_start_date
,x.period_end_date
,x.period_year_start_date
,x.period_year_end_date
-- exchange type/rate data
,x.conversion_rate
,x.conversion_rate_date
,x.conversion_rate_type_code
,x.conversion_rate_type
,x.reconciliation_reference
,x.party_type_code
,x.party_type
-- sla or gl line attributes
,x.attribute_category
,x.attribute1
,x.attribute2
,x.attribute3
,x.attribute4
,x.attribute5
,x.attribute6
,x.attribute7
,x.attribute8
,x.attribute9
,x.attribute10
-- sla trx identifiers
,x.user_trx_identifier_name_1
,x.user_trx_identifier_value_1
,x.user_trx_identifier_name_2
,x.user_trx_identifier_value_2
,x.user_trx_identifier_name_3
,x.user_trx_identifier_value_3
,x.user_trx_identifier_name_4
,x.user_trx_identifier_value_4
,x.user_trx_identifier_name_5
,x.user_trx_identifier_value_5
,x.user_trx_identifier_name_6
,x.user_trx_identifier_value_6
,x.user_trx_identifier_name_7
,x.user_trx_identifier_value_7
,x.user_trx_identifier_name_8
,x.user_trx_identifier_value_8
,x.user_trx_identifier_name_9
,x.user_trx_identifier_value_9
,x.user_trx_identifier_name_10
,x.user_trx_identifier_value_10
-- sla or gl audit colummns
,x.created_by
,x.creation_date
,x.last_update_date
--
,x.accounting_code_combination || ' (' || x.code_combination_description || ')' account_pivot_label
from
(select
   &p_main_col_start
   &p_uti_col
   &lp_template_columns
   &lp_init_sql
 from
   (&lp_template_table
    &p_sla_col_1
    &p_gl_columns
    &p_sla_col_2
    &p_party_details
    &p_sla_qualifier_segment
    &p_sla_col_3
    &p_trx_identifiers_1
    &p_trx_identifiers_2
    &p_trx_identifiers_3
    &p_trx_identifiers_4
    &p_trx_identifiers_5
    &p_sla_legal_ent_col
    &p_sla_from
    &p_sla_seg_desc_from
    &p_gl_view
    &p_sla_legal_ent_from
    &p_party_from
    &p_sla_join
    &p_sla_seg_desc_join
    &p_other_param_filter
    &p_gl_join
    &p_sla_legal_ent_join
    &p_party_join
    &p_union_all
    &p_gl_col_1
    &p_gl_party_details
    &p_gl_qualifier_segment
    &p_gl_col_2
    &p_gl_legal_ent_col
    &p_gl_from
    &p_gl_seg_desc_from
    &p_gl_legal_ent_from
    &p_gl_where
    &p_gl_seg_desc_join
    &p_gl_legal_ent_join
    &p_other_union
   ) table1
   &p_le_from
   &p_other_from
 where
   nvl(:p_operating_unit,'?') = nvl(:p_operating_unit,'?') and
   nvl(:p_relative_period_from,'?') = nvl(:p_relative_period_from,'?') and
   nvl(:p_relative_period_to,'?') = nvl(:p_relative_period_to,'?') and
   nvl(:p_report_code,'?') = nvl(:p_report_code,'?') and
   1=1
   &p_trx_id_filter
   &p_le_join
   &p_other_join
) x