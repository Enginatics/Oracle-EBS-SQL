/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
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

select
/* Q1. successfuly imported statements with no errors */
cbbv.bank_name           bank_name,
cbbv.bank_branch_name    bank_branch_name,
cbagv.bank_account_name  bank_account_name,
cbagv.bank_account_num   bank_account_number,
cbagv.currency_code      account_currency,
'Processed'              import_status,
null                     error_type,
csh.statement_number     statement_number,
csh.statement_date       statement_date,
(select
 cshi.creation_date
 from
 ce_statement_headers_int cshi
 where
     cshi.statement_number  = csh.statement_number
 and cshi.currency_code     = nvl(csh.currency_code,cbagv.currency_code)
 and cshi.bank_account_num  = cbagv.bank_account_num
 and nvl(cshi.org_id,-99)   = nvl(csh.org_id,-99)
)                        statement_interface_date,
csh.doc_sequence_value   doc_sequence_value,
csl.line_number          line_number,
csl.trx_date             trx_date,
xxen_util.meaning(csl.status,'STATEMENT_LINE_STATUS',260) line_status,
null                     message_name,
nvl(csl.amount,0)        amount,
nvl(csl.currency_code,
    cbagv.currency_code
   )                     trx_currency,
cl2.meaning              trx_type,
csl.bank_trx_number      trx_no,
'CE'                     application
from
ce_lookups                   cl2,
ce_bank_accts_gt_v           cbagv,
ce_bank_branches_v           cbbv,
ce_statement_headers         csh,
ce_statement_lines           csl
where
    1=1
and nvl(:p_show_errors_only,'No') != 'Yes'
and cbbv.branch_party_id           = cbagv.bank_branch_id
and cbagv.bank_account_id          = csh.bank_account_id
and csl.statement_header_id        = csh.statement_header_id
and cl2.lookup_type            (+) = 'BANK_TRX_TYPE'
and cl2.lookup_code            (+) = csl.trx_type
and not exists
(select
 null
 from
 ar_cash_receipts_all         acra,
 ar_cash_receipt_history_all  acrha,
 ce_statement_reconcils_all   csra
 where
     csra.statement_line_id         = csl.statement_line_id
 and csra.reference_type           in ('RECEIPT','DM REVERSAL')
 and csra.current_record_flag       = 'Y'
 and csra.status_flag               = 'M'
 and acrha.cash_receipt_history_id  = csra.reference_id
 and acra.cash_receipt_id           = acrha.cash_receipt_id
 and acra.comments                  = 'Created by Auto Bank Rec'
)
and not exists
(select
 null
 from
 ce_reconciliation_errors clie
 where
     csl.statement_line_id = clie.statement_line_id
 and clie.statement_line_id is not null
 and csl.status != 'EXTERNAL'
)
--
union all
--
select
/* Q2. miscellaneous receipts created */
cbbv.bank_name           bank_name,
cbbv.bank_branch_name    bank_branch_name,
cbagv.bank_account_name  bank_account_name,
cbagv.bank_account_num   bank_account_number,
cbagv.currency_code      account_currency,
'Processed'              import_status,
cl1.meaning              error_type,
csh.statement_number     statement_number,
csh.statement_date       statement_date,
(select
 cshi.creation_date
 from
 ce_statement_headers_int cshi
 where
     cshi.statement_number  = csh.statement_number
 and cshi.currency_code     = nvl(csh.currency_code,cbagv.currency_code)
 and cshi.bank_account_num  = cbagv.bank_account_num
 and nvl(cshi.org_id,-99)   = nvl(csh.org_id,-99)
)                        statement_interface_date,
csh.doc_sequence_value   doc_sequence_value,
csl.line_number          line_number,
csl.trx_date             trx_date,
xxen_util.meaning(csl.status,'STATEMENT_LINE_STATUS',260) line_status,
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
and cbbv.branch_party_id          = cbagv.bank_branch_id
and cbagv.bank_account_id         = csh.bank_account_id
and csh.statement_header_id       = csl.statement_header_id
and csra.statement_line_id        = csl.statement_line_id
and csra.reference_type          in ('RECEIPT','DM REVERSAL')
and csra.current_record_flag      = 'Y'
and csra.status_flag              = 'M'
and acrha.cash_receipt_history_id = csra.reference_id
and acra.cash_receipt_id          = acrha.cash_receipt_id
and acra.comments                 = 'Created by Auto Bank Rec'
and cl1.lookup_type               = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code               = 'MISC_RECEIPT_CREATED'
and cl2.lookup_type           (+) = 'BANK_TRX_TYPE'
and cl2.lookup_code           (+) = csl.trx_type
--
union all
--
select /*+ push_pred(clie) */
/*Q3. reconciliation errors - line level */
cbbv.bank_name                             bank_name,
cbbv.bank_branch_name                      bank_branch_name,
cbagv.bank_account_name                    bank_account_name,
cbagv.bank_account_num                     bank_account_number,
cbagv.currency_code                        account_currency,
'Processed'                                import_status,
cl1.description                            error_type,
csh.statement_number                       statement_no,
csh.statement_date                         statement_date,
(select
 cshi.creation_date
 from
 ce_statement_headers_int cshi
 where
     cshi.statement_number  = csh.statement_number
 and cshi.currency_code     = nvl(csh.currency_code,cbagv.currency_code)
 and cshi.bank_account_num  = cbagv.bank_account_num
 and nvl(cshi.org_id,-99)   = nvl(csh.org_id,-99)
)                                          statement_interface_date,
csh.doc_sequence_value                     doc_sequence_value,
csl.line_number                            line_no,
csl.trx_date                               trx_date,
xxen_util.meaning(csl.status,'STATEMENT_LINE_STATUS',260) line_status,
clie.message_name,
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
(select distinct
 cre.statement_header_id,
 cre.statement_line_id,
 cre.application_short_name,
 listagg (ce_cexinerr_xmlp_pkg.c_prt_message_nameformula(cre.message_name),', ') within group (order by cre.message_name) message_name
 from
 ce_reconciliation_errors cre
 group by
 cre.statement_header_id,
 cre.statement_line_id,
 cre.application_short_name
) clie
where
    1=1
and cbbv.branch_party_id     = cbagv.bank_branch_id
and cbagv.bank_account_id    = csh.bank_account_id
and csh.statement_header_id  = csl.statement_header_id
and csh.statement_header_id  = clie.statement_header_id
and csl.statement_line_id    = clie.statement_line_id
and clie.statement_line_id  is not null
and csl.status              != 'EXTERNAL'
and cl1.lookup_type          = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code          = 'RECONCILIATION'
and cl2.lookup_type      (+) = 'BANK_TRX_TYPE'
and cl2.lookup_code      (+) = csl.trx_type
--
union all
--
select /*+ push_pred(clie) */
/* Q4. reconciliation errors - header level */
cbbv.bank_name                         bank_name,
cbbv.bank_branch_name                  bank_branch_name,
cbagv.bank_account_name                bank_account_name,
cbagv.bank_account_num                 bank_account_number,
cbagv.currency_code                    account_currency,
'Processed'                            import_status,
cl1.description                        error_type,
csh.statement_number                   statement_no,
csh.statement_date                     statement_date,
(select
 cshi.creation_date
 from
 ce_statement_headers_int cshi
 where
     cshi.statement_number  = csh.statement_number
 and cshi.currency_code     = nvl(csh.currency_code,cbagv.currency_code)
 and cshi.bank_account_num  = cbagv.bank_account_num
 and nvl(cshi.org_id,-99)   = nvl(csh.org_id,-99)
)                                      statement_interface_date,
csh.doc_sequence_value                 doc_sequence_value,
0                                      line_no,
to_date(null)                          trx_date,
null                                   line_status,
clie.message_name,
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
(select distinct
 cre.statement_header_id,
 cre.statement_line_id,
 cre.application_short_name,
 listagg (ce_cexinerr_xmlp_pkg.c_prt_message_nameformula(cre.message_name),', ') within group (order by cre.message_name) message_name
 from
 ce_reconciliation_errors cre
 group by
 cre.statement_header_id,
 cre.statement_line_id,
 cre.application_short_name
) clie
where
    1=1
and cbbv.branch_party_id     = cbagv.bank_branch_id
and cbagv.bank_account_id    = csh.bank_account_id
and clie.statement_line_id  is null
and csh.statement_header_id  = clie.statement_header_id
and cl1.lookup_type          = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code          = 'RECONCILIATION'
--
union all
--
(
select /*+ push_pred(clie) */
/*Q5. header interface errors */
cbbv.bank_name                         bank_name,
cbbv.bank_branch_name                  bank_branch_name,
cbagv.bank_account_name                bank_account_name,
cbagv.bank_account_num                 bank_account_number,
cbagv.currency_code                    account_currency,
'Error'                                import_status,
cl1.description                        error_type,
clie.statement_number                  statement_no,
trunc(csh.statement_date)              statement_date,
csh.creation_date                      statement_interface_date,
to_number(null)                        doc_sequence_value,
0                                      line_no,
csh.statement_date                     trx_date,
null                                   line_status,
clie.message_name,
0                                      amount,
' '                                    c_currency_code,
' '                                    trx_type,
' '                                    trx_no,
nvl(clie.application_short_name,'CE')  application_short_name
from
ce_lookups                   cl1,
ce_statement_headers_int     csh,
ce_bank_accts_gt_v           cbagv,
ce_bank_branches_v           cbbv,
(select distinct
 chie.bank_account_num,
 chie.statement_number,
 chie.currency_code,
 chie.application_short_name,
 listagg (ce_cexinerr_xmlp_pkg.c_prt_message_nameformula(chie.message_name),', ') within group (order by chie.message_name) message_name
 from
 ce_header_interface_errors chie
 group by
 chie.bank_account_num,
 chie.statement_number,
 chie.currency_code,
 chie.application_short_name
) clie
where
    1=1
and cbbv.branch_party_id  = cbagv.bank_branch_id
and clie.bank_account_num = cbagv.bank_account_num
and cbagv.currency_code   = csh.currency_code
and csh.bank_account_num  = clie.bank_account_num
and csh.statement_number  = clie.statement_number
and csh.currency_code     = clie.currency_code
and cl1.lookup_type       = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code       = 'STATEMENT'
and nvl(csh.record_status_flag,'N') != 'T' -- not transferred
--
union
--
select /*+ push_pred(clie) */
/*Q6. header interface errors, in case the stmt has been transfered to ce_statement_headers and there're warnings during transfer */
cbbv.bank_name                         bank_name,
cbbv.bank_branch_name                  bank_branch_name,
cbagv.bank_account_name                bank_account_name,
cbagv.bank_account_num                 bank_account_number,
cbagv.currency_code                    account_currency,
'Processed'                            import_status,
cl1.description                        error_type,
clie.statement_number                  statement_no,
csh.statement_date                     statement_date,
(select
 cshi.creation_date
 from
 ce_statement_headers_int cshi
 where
     cshi.statement_number  = csh.statement_number
 and cshi.currency_code     = nvl(csh.currency_code,cbagv.currency_code)
 and cshi.bank_account_num  = cbagv.bank_account_num
 and nvl(cshi.org_id,-99)   = nvl(csh.org_id,-99)
)                                      statement_interface_date,
to_number(null)                        doc_sequence_value,
0                                      line_no,
csh.statement_date                     trx_date,
null                                   line_status,
clie.message_name,
0                                      amount,
' '                                    c_currency_code,
' '                                    trx_type,
' '                                    trx_no,
nvl(clie.application_short_name,'CE')  application_short_name
from
ce_lookups                  cl1,
ce_statement_headers        csh,
ce_bank_accts_gt_v          cbagv,
ce_bank_branches_v          cbbv,
(select distinct
 chie.bank_account_num,
 chie.statement_number,
 chie.currency_code,
 chie.application_short_name,
 listagg (ce_cexinerr_xmlp_pkg.c_prt_message_nameformula(chie.message_name),', ') within group (order by chie.message_name) message_name
 from
 ce_header_interface_errors chie
 group by
 chie.bank_account_num,
 chie.statement_number,
 chie.currency_code,
 chie.application_short_name
) clie
where
    1=1
and cbbv.branch_party_id  = cbagv.bank_branch_id
and csh.bank_account_id   = cbagv.bank_account_id
and clie.bank_account_num = cbagv.bank_account_num
and clie.statement_number = csh.statement_number
and clie.currency_code    = nvl(csh.currency_code,cbagv.currency_code)
and cl1.lookup_type       = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code       = 'STATEMENT'
)
--
union all
--
select /*+ push_pred(clie) */
/*Q7. line interface errors */
cbbv.bank_name                               bank_name,
cbbv.bank_branch_name                        bank_branch_name,
cbagv.bank_account_name                      bank_account_name,
cbagv.bank_account_num                       bank_account_number,
cbagv.currency_code                          account_currency,
'Error'                                      import_status,
cl1.description                              error_type,
clie.statement_number                        statement_no,
trunc(csh.statement_date)                    statement_date,
csh.creation_date                            statement_interface_date,
to_number(null)                              doc_sequence_value,
clie.line_number                             line_no,
csl.trx_date                                 trx_date,
'Error'                                      line_status,
clie.message_name,
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
ce_bank_accts_gt_v           cbagv,
ce_bank_branches_v           cbbv,
(select distinct
 clie.bank_account_num,
 clie.statement_number,
 clie.line_number,
 clie.bank_acct_currency_code,
 clie.application_short_name,
 listagg (ce_cexinerr_xmlp_pkg.c_prt_message_nameformula(clie.message_name),', ') within group (order by clie.message_name) message_name
 from
 ce_line_interface_errors clie
 group by
 clie.bank_account_num,
 clie.statement_number,
 clie.line_number,
 clie.bank_acct_currency_code,
 clie.application_short_name
) clie
where
    1=1
and cbbv.branch_party_id        = cbagv.bank_branch_id
and cbagv.bank_account_num      = csh.bank_account_num
and cbagv.currency_code         = csh.currency_code
and csh.bank_account_num        = csl.bank_account_num
and csh.statement_number        = csl.statement_number
and csh.currency_code           = csl.bank_acct_currency_code
and clie.bank_account_num       = cbagv.bank_account_num
and csl.line_number             = clie.line_number
and csl.statement_number        = clie.statement_number
and csl.bank_account_num        = clie.bank_account_num
and csl.bank_acct_currency_code = clie.bank_acct_currency_code
and curr.currency_code(+)       = csl.currency_code
and cl1.lookup_type             = 'ABR_REPORT_EXCEPTIONS'
and cl1.lookup_code             = 'LINE'
union all
select
/* Q8. statement headers with no lines */
cbbv.bank_name           bank_name,
cbbv.bank_branch_name    bank_branch_name,
cbagv.bank_account_name  bank_account_name,
cbagv.bank_account_num   bank_account_number,
cbagv.currency_code      account_currency,
'Processed'              import_status,
'No Statement Lines'     error_type,
csh.statement_number     statement_number,
csh.statement_date       statement_date,
(select
 cshi.creation_date
 from
 ce_statement_headers_int cshi
 where
     cshi.statement_number  = csh.statement_number
 and cshi.currency_code     = nvl(csh.currency_code,cbagv.currency_code)
 and cshi.bank_account_num  = cbagv.bank_account_num
 and nvl(cshi.org_id,-99)   = nvl(csh.org_id,-99)
)                        statement_interface_date,
csh.doc_sequence_value   doc_sequence_value,
to_number(null)          line_number,
to_date(null)            trx_date,
null                     line_status,
'No Statement Lines'     message_name,
to_number(null)          amount,
null                     trx_currency,
null                     trx_type,
null                     trx_no,
'CE'                     application
from
ce_bank_accts_gt_v           cbagv,
ce_bank_branches_v           cbbv,
ce_statement_headers         csh
where
    1=1
and cbbv.branch_party_id           = cbagv.bank_branch_id
and cbagv.bank_account_id          = csh.bank_account_id
and not exists -- no statement lines
(select
 null
 from
 ce_statement_lines csl
 where
 csl.statement_header_id = csh.statement_header_id
)
and not exists -- will be picked up in Q4 header recon error
(select
 null
 from
 ce_reconciliation_errors cre
 where
     cre.statement_line_id  is null
 and cre.statement_header_id = csh.statement_header_id 
)
and not exists -- will be picked up in Q6 header interface errors
(select
 null
 from
 ce_header_interface_errors chie
 where
     chie.bank_account_num = cbagv.bank_account_num
 and chie.statement_number = csh.statement_number
 and chie.currency_code    = nvl(csh.currency_code,cbagv.currency_code)
)
--
order by
1,2,3,4,9,12