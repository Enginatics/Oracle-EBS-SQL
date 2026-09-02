/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Bank Statement Upload
-- Description: CE Bank Statement Upload
========================
Loads bank statements (header and lines) into Oracle Cash Management through the bank statement open interface and runs Oracle's Bank Statement Import automatically after upload.

Optionally, AutoReconciliation runs in the same step to match the imported statement lines against AR receipts, AP payments and GL journal lines according to the bank account's transaction codes and matching rules, in the same way as the standard 'Bank Statement Import & AutoReconciliation' concurrent program.

Each row represents one statement line. Statement header information (Account Number, Statement Number, Statement Date, Currency, Control Balances) repeats on every row and the statement header is created once per statement number. Line numbers are assigned automatically per statement when left blank.

Credit and debit control totals are computed automatically from the entered lines and their transaction code types.

Upload Mode
===========

Create
------
Opens an empty spreadsheet to enter new bank statements, for example pasted from a bank portal export.

Create, Update
--------------
Additionally returns statement lines that are still sitting in the bank statement open interface and did not import. Correct them and re-upload; corrected lines replace the previously staged interface records and are imported again.

Notes
=====
- Statements that are already imported into Cash Management cannot be loaded again under the same statement number.
- Rows failing the import show the Cash Management interface error messages in the result file. The standard Bank Statement Import Execution Report provides the same details.
-- Excel Examle Output: https://www.enginatics.com/example/ce-bank-statement-upload/
-- Library Link: https://www.enginatics.com/reports/ce-bank-statement-upload/
-- Run Report: https://demo.enginatics.com/

select
null action_,
null status_,
null message_,
null request_id_,
null modified_columns_,
x.*
from
(
select
cshi.bank_account_num bank_account_number,
cshi.statement_number,
cshi.statement_date,
cshi.currency_code currency,
cshi.control_begin_balance,
cshi.control_end_balance,
csli.line_number,
csli.trx_date transaction_date,
csli.trx_code transaction_code,
csli.amount,
csli.bank_trx_number bank_transaction_number,
csli.trx_text transaction_description,
csli.invoice_text,
csli.customer_text,
csli.effective_date value_date,
:auto_reconcile auto_reconcile,
:gl_date gl_date,
rowidtochar(cshi.rowid) header_row_id,
rowidtochar(csli.rowid) line_row_id,
row_number() over (order by cshi.bank_account_num,cshi.statement_number,csli.line_number) upload_row
from
ce_statement_headers_int cshi,
ce_statement_lines_interface csli
where
1=1 and
nvl(cshi.record_status_flag,'I')<>'T' and
cshi.bank_account_num=csli.bank_account_num(+) and
cshi.statement_number=csli.statement_number(+)
) x