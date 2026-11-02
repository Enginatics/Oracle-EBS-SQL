/*************************************************************************/
/*                                                                       */
/*                          (c) Enginatics GmbH                          */
/*                          www.enginatics.com                           */
/*                                                                       */
/*************************************************************************/
-- Report Name: IGI Dossier Maintenance Upload
-- Description: Creates dossier transactions (budget transfers) of Oracle Public Sector Financials International (IGI) through the IGI Dossier table handlers, with status In Process. Check funds, reserve funds and approve them in the Dossier Maintenance window.
-- Rows with the same Dossier Transaction Name, dossier type and ledger form one transaction: the first row creates the header and the source budget line, and every row adds a destination budget line. A row whose transaction already exists adds a destination line to it; the header and existing lines are not updated.
-- The source budget amount is the total of the destination amounts and must not exceed the funds available on the source account. Funds available are the budget less encumbrance and actual balances, for the amount type of the dossier type (PTD, QTD, YTD or PJTD). The destination new balance is its funds available plus the transferred amount.
-- Excel Example Output: https://www.enginatics.com/example/igi-dossier-maintenance-upload/
-- Library Link: https://www.enginatics.com/reports/igi-dossier-maintenance-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null modified_columns_,
gl.name ledger_name,
iddt.dossier_name dossier_type,
iddt.amount_type,
idth.trx_number transaction_number,
idth.dossier_transaction_name,
idth.description,
idth.trx_status status,
idth.parent_trx_number parent_transaction_number,
idts.budget_name source_budget,
idts.period_name source_period,
gcck_s.concatenated_segments source_account,
idts.budget_amount source_budget_amount,
idts.funds_available source_funds_available,
idts.new_balance source_new_balance,
idtd.budget_name dest_budget,
idtd.period_name dest_period,
gcck_d.concatenated_segments dest_account,
idtd.budget_amount dest_budget_amount,
idtd.funds_available dest_funds_available,
idtd.new_balance dest_new_balance,
to_number(null) upload_row
from
igi_dos_trx_headers idth,
igi_dos_doc_types iddt,
gl_ledgers gl,
igi_dos_trx_sources idts,
igi_dos_trx_dest idtd,
gl_code_combinations_kfv gcck_s,
gl_code_combinations_kfv gcck_d
where
1=1 and
idth.dossier_id=iddt.dossier_id and
idth.sob_id=gl.ledger_id and
idth.trx_id=idts.trx_id and
idts.source_trx_id=idtd.source_trx_id and
idth.trx_id=idtd.trx_id and
idts.code_combination_id=gcck_s.code_combination_id(+) and
idtd.code_combination_id=gcck_d.code_combination_id(+)
