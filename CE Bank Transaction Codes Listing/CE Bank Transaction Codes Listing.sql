/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Bank Transaction Codes Listing
-- Description: Imported from BI Publisher
Description: Bank Transaction Codes
Application: Cash Management
Source: Bank Transaction Codes Listing 
Short Name: CEXTRXCD
DB package: CE_CEXTRXCD_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ce-bank-transaction-codes-listing/
-- Library Link: https://www.enginatics.com/reports/ce-bank-transaction-codes-listing/
-- Run Report: https://demo.enginatics.com/

select 
ctcv.bank_name bank_name,
ctcv.bank_branch_name bank_branch_name,
ctcv.bank_account_name account_name,
ctcv.bank_account_num account_number,
ctcv.bank_account_currency_code currency,
ctcv.type_dsp type,
ctcv.trx_code code,
ctcv.description description,
ctcv.domain_code domain,
ctcv.family_code family,
ctcv.sub_family_code sub_family,
ctcv.start_date start_date,
ctcv.end_date end_date,
ctcv.reconcile_flag_dsp transaction_source,
ctcv.reconciliation_sequence reconciliation_sequence,
ctcv.payroll_payment_format_dsp payroll_payment_format,
ctcv.payroll_matching_order,
cl2.meaning matching_against,
cl1.meaning correction_method,
ctcv.create_misc_trx_flag_dsp create_misc_trx_flag,
ctcv.receivables_activity receivables_activity,
ctcv.payment_method payment_method,
ctcv.request_id request_id
from
ce_internal_bank_accounts_v cibav, 
ce_transaction_codes_v ctcv,
ce_lookups cl1,
ce_lookups cl2
where
1=1 and 
ctcv.bank_account_id = cibav.bank_account_id and
cl1.lookup_code(+) = ctcv.correction_method and 
cl1.lookup_type(+) = 'CORRECTION_METHOD' and 
cl2.lookup_code(+) = ctcv.matching_against and 
cl2.lookup_type(+) = 'CORRECTION_MATCHING' 
order by 
 ctcv.bank_name,
 ctcv.bank_branch_name,
 ctcv.bank_account_name,
 ctcv.bank_account_num,
 ctcv.bank_account_currency_code,
 ctcv.reconciliation_sequence,
 ctcv.type_dsp,
 ctcv.trx_code