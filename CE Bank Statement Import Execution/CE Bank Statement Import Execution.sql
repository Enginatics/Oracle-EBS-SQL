/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Bank Statement Import Execution
-- Description: Application: Cash Management
Source: Bank Statement Import Execution Report
Short Name: CEIMPERR
DB package: CE_CEXINERR_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ce-bank-statement-import-execution/
-- Library Link: https://www.enginatics.com/reports/ce-bank-statement-import-execution/
-- Run Report: https://demo.enginatics.com/

select /* miscellaneous receipts created */
cbbv.bank_name           bank_name,
cbbv.bank_branch_name    bank_branch_name,
cbagv.bank_account_name  bank_account_name,
cbagv.bank_account_num   bank_account_number,
cbagv.currency_code      account_currency,
cl1.meaning              error_type,
csh.statement_number     statement_number,
csh.statement_date       statement_date,
csh.doc_sequence_value   doc_sequence_value,
csl.line_number          line_number,
csl.trx_date             trx_date,
null                     message_name,
nvl(csl.amount,0)        amount,
acra.currency_code       trx_currency,
cl2.meaning              trx_type,
acra.receipt_number      trx_no,
'CE'                     application
from
ce_lookups                   cl1,
ce_lookups                   cl2,
ce_bank_accts_gt_v           cbagv,
ce_bank_branches_v           cbbv,
ce_statement_headers         csh,
ce_statement_lines           csl,
ar_cash_receipts_all         acra,
ar_cash_receipt_history_all  acrha,
ce_statement_reconcils_all   csra
where
    1=1
and cbbv.branch_party_id = cbagv.bank_branch_id
and cbagv.bank_account_id = csh.bank_account_id
and csh.statement_header_id = csl.statement_header_id
and csra.statement_line_id = csl.statement_line_id
and csra.reference_type in ('RECEIPT','DM REVERSAL')
and csra.current_record_flag = 'Y'
and csra.status_flag = 'M'
and acrha.cash_receipt_history_id = csra.reference_id
and acra.cash_receipt_id = acrha.cash_receipt_id
and acra.comments = 'Created by Auto Bank Rec'
and cl1.lookup_type = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code = 'MISC_RECEIPT_CREATED'
and cl2.lookup_type = 'BANK_TRX_TYPE'
and cl2.lookup_code = csl.trx_type
union all
select /* reconciliation errors - line level */
cbbv.bank_name                             bank_name,
cbbv.bank_branch_name                      bank_branch_name,
cbagv.bank_account_name                    bank_account_name,
cbagv.bank_account_num                     bank_account_number,
cbagv.currency_code                        account_currency,
cl1.description                            error_type,
csh.statement_number                       statement_no,
csh.statement_date                         statement_date,
csh.doc_sequence_value                     doc_sequence_value,
csl.line_number                            line_no,
csl.trx_date                               trx_date,
ce_cexinerr_xmlp_pkg.c_prt_message_nameformula(clie.message_name) message_name,
nvl(csl.amount,0)                          amount,
nvl(csl.currency_code,cbagv.currency_code) c_currency_code,
cl2.meaning                                trx_type,
csl.bank_trx_number                        trx_no,
nvl(clie.application_short_name,'CE')      application_short_name
from
ce_lookups                  cl1,
ce_lookups                  cl2,
ce_bank_accts_gt_v          cbagv,
ce_bank_branches_v          cbbv,
ce_statement_headers        csh,
ce_statement_lines          csl,
ce_reconciliation_errors    clie
where
    1=1
and cbbv.branch_party_id = cbagv.bank_branch_id
and cbagv.bank_account_id = csh.bank_account_id
and csh.statement_header_id = csl.statement_header_id
and csh.statement_header_id = clie.statement_header_id
and csl.statement_line_id = clie.statement_line_id
and clie.statement_line_id is not null
and csl.status != 'EXTERNAL'
and cl1.lookup_type = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code = 'RECONCILIATION'
and cl2.lookup_type = 'BANK_TRX_TYPE'
and cl2.lookup_code = csl.trx_type
union all
select /* reconciliation errors - header level */
cbbv.bank_name                         bank_name,
cbbv.bank_branch_name                  bank_branch_name,
cbagv.bank_account_name                bank_account_name,
cbagv.bank_account_num                 bank_account_number,
cbagv.currency_code                    account_currency,
cl1.description                        error_type,
csh.statement_number                   statement_no,
csh.statement_date                     statement_date,
csh.doc_sequence_value                 doc_sequence_value,
0                                      line_no,
to_date(null)                          trx_date,
ce_cexinerr_xmlp_pkg.c_prt_message_nameformula(clie.message_name) message_name,
to_number(null)                        amount,
cbagv.currency_code                    c_currency_code,
null                                   trx_type,
null                                   trx_no,
nvl(clie.application_short_name,'CE')  application_short_name
from
ce_lookups                   cl1,
ce_bank_accts_gt_v           cbagv,
ce_bank_branches_v           cbbv,
ce_statement_headers         csh,
ce_reconciliation_errors     clie
where
    1=1
and cbbv.branch_party_id = cbagv.bank_branch_id
and cbagv.bank_account_id = csh.bank_account_id
and clie.statement_line_id is null
and csh.statement_header_id = clie.statement_header_id
and cl1.lookup_type = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code = 'RECONCILIATION'
union all
(
select /* header interface errors */
cbbv.bank_name                         bank_name,
cbbv.bank_branch_name                  bank_branch_name,
cbagv.bank_account_name                bank_account_name,
cbagv.bank_account_num                 bank_account_number,
cbagv.currency_code                    account_currency,
cl1.description                        error_type,
clie.statement_number                  statement_no,
csh.statement_date                     statement_date,
to_number(null)                        doc_sequence_value,
1                                      line_no,
csh.statement_date                     trx_date,
ce_cexinerr_xmlp_pkg.c_prt_message_nameformula(clie.message_name) message_name,
0                                      amount,
' '                                    c_currency_code,
' '                                    trx_type,
' '                                    trx_no,
nvl(clie.application_short_name,'CE')  application_short_name
from
ce_lookups                   cl1,
ce_statement_headers_int     csh,
ce_header_interface_errors   clie,
ce_bank_accts_gt_v           cbagv,
ce_bank_branches_v           cbbv
where
    1=1
and cbbv.branch_party_id = cbagv.bank_branch_id
and clie.bank_account_num = cbagv.bank_account_num
and cbagv.currency_code = csh.currency_code
and csh.bank_account_num = clie.bank_account_num
and csh.statement_number = clie.statement_number
and  csh.currency_code      = clie.currency_code
and cl1.lookup_type = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code = 'STATEMENT'
union
select /* header interface errors, in case the stmt has been transfered to ce_statement_headers and there're warnings during transfer */
cbbv.bank_name                         bank_name,
cbbv.bank_branch_name                  bank_branch_name,
cbagv.bank_account_name                bank_account_name,
cbagv.bank_account_num                 bank_account_number,
cbagv.currency_code                    account_currency,
cl1.description                        error_type,
clie.statement_number                  statement_no,
csh.statement_date                     statement_date,
to_number(null)                        doc_sequence_value,
1                                      line_no,
csh.statement_date                     trx_date,
ce_cexinerr_xmlp_pkg.c_prt_message_nameformula(clie.message_name) message_name,
0                                      amount,
' '                                    c_currency_code,
' '                                    trx_type,
' '                                    trx_no,
nvl(clie.application_short_name,'CE')  application_short_name
from
ce_lookups                  cl1,
ce_statement_headers        csh,
ce_header_interface_errors  clie,
ce_bank_accts_gt_v          cbagv,
ce_bank_branches_v          cbbv
where
    1=1
and cbbv.branch_party_id = cbagv.bank_branch_id
and csh.bank_account_id = cbagv.bank_account_id
and clie.bank_account_num = cbagv.bank_account_num
and clie.statement_number = csh.statement_number
and clie.currency_code = csh.currency_code
and cl1.lookup_type = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code = 'STATEMENT'
)
union all
select  /* line interface errors */
cbbv.bank_name                               bank_name,
cbbv.bank_branch_name                        bank_branch_name,
cbagv.bank_account_name                      bank_account_name,
cbagv.bank_account_num                       bank_account_number,
cbagv.currency_code                          account_currency,
cl1.description                              error_type,
clie.statement_number                        statement_no,
csh.statement_date                           statement_date,
to_number(null)                              doc_sequence_value,
clie.line_number                             line_no,
csl.trx_date                                 trx_date,
ce_cexinerr_xmlp_pkg.c_prt_message_nameformula(clie.message_name) message_name,
nvl(csl.amount,0)                            amount,
nvl(curr.currency_code, cbagv.currency_code) c_currency_code,
' '                                          trx_type,
' '                                          trx_no,
nvl(clie.application_short_name,'CE')        application_short_name
from
fnd_currencies               curr,
ce_lookups                   cl1,
ce_statement_headers_int     csh,
ce_statement_lines_interface csl,
ce_line_interface_errors     clie,
ce_bank_accts_gt_v           cbagv,
ce_bank_branches_v           cbbv
where
    1=1
and cbbv.branch_party_id = cbagv.bank_branch_id
and cbagv.bank_account_num = csh.bank_account_num
and cbagv.currency_code = csh.currency_code
and csh.bank_account_num = csl.bank_account_num
and csh.statement_number = csl.statement_number
and csh.currency_code   = csl.bank_acct_currency_code
and clie.bank_account_num = cbagv.bank_account_num
and csl.line_number = clie.line_number
and csl.statement_number = clie.statement_number
and csl.bank_account_num = clie.bank_account_num
and csl.bank_acct_currency_code = clie.bank_acct_currency_code
and curr.currency_code(+) = csl.currency_code
and cl1.lookup_type = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code = 'LINE'
order by
1,2,3,4,6,8,10