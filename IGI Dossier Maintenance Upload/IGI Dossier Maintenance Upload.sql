/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: IGI Dossier Maintenance Upload
-- Description: Upload to create and maintain dossier transactions (budget transfers) for Oracle Public Sector Financials International (IGI). Supports header creation with source and destination budget lines using the seeded IGI Dossier Maintenance APIs.
-- Excel Examle Output: https://www.enginatics.com/example/igi-dossier-maintenance-upload/
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
idtd.new_balance dest_new_balance
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