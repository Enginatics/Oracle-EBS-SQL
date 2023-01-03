/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: PSA Budgetary Control Transactions
-- Description: Imported from Concurrent Program
Description: Budgetary Control Results Report Program
Application: Public Sector Financials
Source: Budgetary Control Results Report
Short Name: PSABCRRP
DB package: XXEN_PSA

The Expand Amounts Yes/No Parameter determines whether or not the Budget, Encumbrances, Expenditures, and Funds Available Amounts are displayed on the same excel row (Expand=No) or are split into separate excel rows (Expand=Yes) in the generated excel.

The following templates are provided with this report:

Budgetary Control Transactions Pivot
===========================
Corresponds to the standard Oracle Budgetary Control Status Report.
Budget, Encumbrances, Expenditures, and Funds Available Amounts are displayed on separate rows in the generated Excel

Budgetary Control Transactions Extract
============================
Flat File one row per transaction extract.
Budget, Encumbrances, Expenditures, and Funds Available Amounts are included as separate columns on the same excel row

-- Excel Examle Output: https://www.enginatics.com/example/psa-budgetary-control-transactions/
-- Library Link: https://www.enginatics.com/reports/psa-budgetary-control-transactions/
-- Run Report: https://demo.enginatics.com/

select
gl.name ledger,
pbrg.application_name,
pbrg.application_short_name,
--
pbrg.accounting_flexfield account_combination,
nvl(pbrg.account_type_meaning,xxen_util.meaning(gcck.gl_account_type,'ACCOUNT_TYPE',0)) account_type,
--
pbrg.period_name period,
pbrg.period_year,
pbrg.period_num,
pbrg.quarter_num,
--
pbrg.batch_reference,
pbrg.document_reference,
pbrg.document_status,
pbrg.actual_flag_meaning actual_flag,
pbrg.vendor_name supplier,
pbrg.vendor_site_name supplier_site,
decode(pbrg.line_reference,'''Summary''','Summary',pbrg.line_reference) line_reference,
pbrg.funds_check_status result_status_type,
pbrg.funds_check_level_meaning funds_check_level,
pbrg.result_message,
--
pbrg.available_total_balance previous_funds_availabe,
pbrg.amount base_amount,
pbrg.current_funds_available current_funds_available,
pbrg.amount_type_meaning amount_type,
pbrg.boundary,
pbrg.funding_budget_name,
pbrg.budget_type,
pbrg.encumbrance_type,
--
&lp_expand_columns
--
pbrg.currency_code,
--
pbrg.je_source_name,
pbrg.je_category_name,
pbrg.je_batch_name,
pbrg.je_header_name,
decode(pbrg.journal_line_number,'''Summary''','Summary',pbrg.journal_line_number) journal_line_number,
pbrg.debit_credit_indicator,
pbrg.summary_account_indicator,
--
pbrg.document_sequence_number,
pbrg.je_batch_id,
pbrg.event_id,
pbrg.ae_header_id,
pbrg.ae_line_num,
pbrg.po_line_number,
pbrg.po_dist_line_number,
pbrg.po_ship_line_number,
pbrg.req_line_number,
pbrg.req_dist_line_number,
pbrg.inv_line_number,
--
pbrg.budget_level,
pbrg.treasury_symbol,
pbrg.funds_check_status_code,
pbrg.result_code,
pbrg.error_source
from
&lp_expand_tables
psa_bc_results_gt pbrg,
gl_ledgers gl,
gl_code_combinations_kfv gcck
where
pbrg.ledger_id=gl.ledger_id and
pbrg.ccid=gcck.code_combination_id(+) and
1=1
order by
&lp_order_by
pbrg.accounting_flexfield,
pbrg.period_year,
pbrg.period_num,
pbrg.application_name,
pbrg.actual_flag_meaning desc,
pbrg.batch_reference,
pbrg.document_reference,
pbrg.document_status
&lp_expand_order_by