/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Transactions Available for Reconcilation
-- Description: Cash Management - Transactions Available for Reconcilation

This report allows the user to extract the same information as available in the standard oracle Transactions Available for Reconcilation Report.
-- Excel Examle Output: https://www.enginatics.com/example/ce-transactions-available-for-reconcilation/
-- Library Link: https://www.enginatics.com/reports/ce-transactions-available-for-reconcilation/
-- Run Report: https://demo.enginatics.com/

with ce_avail_trx_v as
(
select
  catv.bank_account_id,
  catv.bank_account_name,
  catv.bank_account_num,
  catv.bank_currency_code,
  catv.bank_name,
  catv.bank_branch_name,
  xxen_util.meaning('JE_LINES','TRAN_ORG_TYPE',260) source,
  'JE_LINES' source_code,
  catv.trx_type,
  catv.clearing_trx_type,
  catv.batch_name,
  catv.agent_name,
  catv.trx_date,
  catv.maturity_date,
  catv.bank_account_amount,
  catv.trx_number,
  catv.type_meaning,
  catv.payment_method,
  catv.currency_code,
  catv.amount,
  catv.journal_category,
  catv.period_name,
  catv.journal_entry_line_number,
  catv.status,
  catv.trx_id,
  catv.org_id,
  catv.legal_entity_id,
  catv.code_combination_id
from ce_101_transactions_v catv
where
  :p_type in ('JE_LINES','ALL')
union all
select
  catv.bank_account_id,
  catv.bank_account_name,
  catv.bank_account_num,
  catv.bank_currency_code,
  catv.bank_name,
  catv.bank_branch_name,
  xxen_util.meaning('XTR_LINES','TRAN_ORG_TYPE',260) source,
  'XTR_LINES' source_code,
  catv.trx_type,
  catv.clearing_trx_type,
  catv.batch_name,
  catv.agent_name,
  catv.trx_date,
  catv.maturity_date,
  catv.bank_account_amount,
  catv.trx_number,
  catv.type_meaning,
  catv.payment_method,
  catv.currency_code,
  catv.amount,
  catv.journal_category,
  catv.period_name,
  catv.journal_entry_line_number,
  catv.status,
  catv.trx_id,
  catv.org_id,
  catv.legal_entity_id,
  null code_combination_id
from ce_185_transactions_v catv
where
  :p_type in ('XTR_LINES','ALL')
union all
select
  catv.bank_account_id,
  catv.bank_account_name,
  catv.bank_account_num,
  catv.bank_currency_code,
  catv.bank_name,
  catv.bank_branch_name,
  xxen_util.meaning('PAYMENTS','TRAN_ORG_TYPE',260) source,
  'PAYMENTS' source_code,
  catv.trx_type,
  catv.clearing_trx_type,
  catv.batch_name,
  catv.agent_name,
  catv.trx_date,
  catv.maturity_date,
  catv.bank_account_amount,
  catv.trx_number,
  catv.type_meaning,
  catv.payment_method,
  catv.currency_code,
  catv.amount,
  catv.journal_category,
  catv.period_name,
  catv.journal_entry_line_number,
  catv.status,
  catv.trx_id,
  catv.org_id,
  catv.legal_entity_id,
  null code_combination_id
from ce_200_transactions_v catv
where
  :p_type in ('PAYMENTS','ALL')
union all
select
  catv.bank_account_id,
  catv.bank_account_name,
  catv.bank_account_num,
  catv.bank_currency_code,
  catv.bank_name,
  catv.bank_branch_name,
  xxen_util.meaning('RECEIPTS','TRAN_ORG_TYPE',260) source,
  'RECEIPTS' source_code,
  catv.trx_type,
  catv.clearing_trx_type,
  catv.batch_name,
  catv.agent_name,
  catv.trx_date,
  catv.maturity_date,
  catv.bank_account_amount,
  catv.trx_number,
  catv.type_meaning,
  catv.payment_method,
  catv.currency_code,
  catv.amount,
  catv.journal_category,
  catv.period_name,
  catv.journal_entry_line_number,
  catv.status,
  catv.trx_id,
  catv.org_id,
  catv.legal_entity_id,
  null code_combination_id
from ce_222_transactions_v catv
where
  :p_type in ('RECEIPTS','ALL')
union all
select
  catv.bank_account_id,
  catv.bank_account_name,
  catv.bank_account_num,
  catv.bank_currency_code,
  catv.bank_name,
  catv.bank_branch_name,
  xxen_util.meaning('PAYROLLS','TRAN_ORG_TYPE',260) source,
  'PAYROLLS' source_code,
  catv.trx_type,
  catv.clearing_trx_type,
  catv.batch_name,
  catv.agent_name,
  catv.trx_date,
  catv.maturity_date,
  catv.bank_account_amount,
  catv.trx_number,
  catv.type_meaning,
  catv.payment_method,
  catv.currency_code,
  catv.amount,
  catv.journal_category,
  catv.period_name,
  catv.journal_entry_line_number,
  catv.status,
  catv.trx_id,
  catv.org_id,
  catv.legal_entity_id,
  null code_combination_id
from ce_801_transactions_v catv
where
  :p_type in ('PAYROLLS','ALL')
union all
select
  catv.bank_account_id,
  catv.bank_account_name,
  catv.bank_account_num,
  catv.bank_currency_code,
  catv.bank_name,
  catv.bank_branch_name,
  xxen_util.meaning('PAYROLLS','TRAN_ORG_TYPE',260) source,
  'PAYROLLS' source_code,
  catv.trx_type,
  catv.clearing_trx_type,
  catv.batch_name,
  catv.agent_name,
  catv.trx_date,
  catv.maturity_date,
  catv.bank_account_amount,
  catv.trx_number,
  catv.type_meaning,
  catv.payment_method,
  catv.currency_code,
  catv.amount,
  catv.journal_category,
  catv.period_name,
  catv.journal_entry_line_number,
  catv.status,
  catv.trx_id,
  catv.org_id,
  catv.legal_entity_id,
  null code_combination_id
from ce_801_eft_transactions_v catv
where
  :p_type in ('PAYROLLS','ALL')
union all
select
  catv.bank_account_id,
  catv.bank_account_name,
  catv.bank_account_num,
  catv.bank_currency_code,
  catv.bank_name,
  catv.bank_branch_name,
  xxen_util.meaning('ROI_LINES','TRAN_ORG_TYPE',260) source,
  'ROI_LINES' source_code,
  catv.trx_type,
  catv.clearing_trx_type,
  catv.batch_name,
  catv.agent_name,
  catv.trx_date,
  catv.maturity_date,
  catv.bank_account_amount,
  catv.trx_number,
  catv.type_meaning,
  catv.payment_method,
  catv.currency_code,
  catv.amount,
  catv.journal_category,
  catv.period_name,
  catv.journal_entry_line_number,
  catv.status,
  catv.trx_id,
  catv.org_id,
  catv.legal_entity_id,
  null code_combination_id
from  ce_999_transactions_v catv
where
  catv.clearing_trx_type != 'XTR_LINE' and -- exclude 185 lines
  :p_type in ('ROI_LINES','ALL')
)
--
-- Main Query Starts Here
--
select
   cat.legal_entity,
   cat.bank_account_num,
   cat.bank_account_name,
   cat.bank_account_currency,
   cat.bank_name,
   cat.bank_branch_name,
   cat.source,
   cat.type,
   case
   when cat.type_code in ('CASH','MISC') and cat.transaction_order = 10 then 'Available Receipts'
   when cat.type_code in ('CASH','MISC') and cat.transaction_order = 20 then 'Reversed Receipts'
   when cat.type_code in ('PAYMENT')     and cat.transaction_order = 30 then 'Available Payments'
   when cat.type_code in ('PAYMENT')     and cat.transaction_order = 40 then 'Voided Payments'
   when cat.type_code in ('PAYROLL')     and cat.transaction_order = 35 then 'Available Payroll Payments'
   when cat.type_code in ('PAYROLL')     and cat.transaction_order = 45 then 'Voided Payroll Payments'
   when cat.type_code in ('REFUND')      and cat.transaction_order = 50 then 'Available Refunds'
   when cat.type_code in ('REFUND')      and cat.transaction_order = 60 then 'Voided Refunds'
   when cat.type_code in ('STATEMENT')   and cat.transaction_order = 75 then 'Unreconciled Statement Lines'
   when cat.type_code in ('STATEMENT')   and cat.transaction_order = 80 then 'Reconciled Statement Lines'
   when cat.type_code in ('CASHFLOW')    and cat.transaction_order = 90 then 'Available Cashflows'
   when cat.type_code in ('JE_LINE')                                    then 'Available Journal Entry Lines'
   when cat.type_code in ('ROI-R')                                      then 'Available Open-Interface Transactions - Receipts'
   when cat.type_code in ('ROI-P')                                      then 'Available Open-Interface Transactions - Payments'
   end type_description,
   cat.effective_date,
   cat.maturity_date,
   cat.agent_name,
   cat.payment_method,
   cat.transaction_number,
   cat.journal_batch_name,
   cat.journal_period,
   cat.journal_category,
   cat.journal_line_number,
   cat.journal_descripton,
   cat.journal_account,
   cat.statement_number,
   cat.line_type,
   cat.transaction_subtype,
   cat.direction,
   cat.currency_code,
   cat.amount,
   round(case when cat.type_code in ('JE_LINE','STATEMENT')
         then cat.account_amount
         else cat.bank_account_amount
         end,fc.precision)  bank_account_amount,
   round(cat.account_amount,fc.precision) net_amount_available,
   --
   case when cat.source_code in ('RECEIPTS','PAYMENTS')
   then cat.organization
   end ar_ap_operating_unit,
   case when cat.source_code in ('PAYROLLS')
   then cat.organization
   end payroll_business_group,
   cat.treasury_legal_entity,
   --
   -- GL Cash Account Details
   cat.gl_company_code,
   cat.gl_company_desc,
   cat.gl_account_code,
   cat.gl_account_desc,
   cat.gl_cost_center_code,
   cat.gl_cost_center_desc,
   cat.gl_cash_account,
   cat.gl_cash_account_desc,
   -- pivot labels
   cat.gl_company_code || ' - ' || cat.gl_company_desc gl_company_pivot_label,
   cat.bank_name || ' - ' || cat.bank_account_num || ' - ' || cat.bank_account_name || ' (' || cat.bank_account_currency || ')' bank_account_pivot_label
from
(
  select
   catv.bank_account_num                 bank_account_num,
   catv.bank_account_name                bank_account_name,
   catv.bank_currency_code               bank_account_currency,
   nvl(xxen_util.meaning(cbagv.bank_account_type,'BANK_ACCOUNT_TYPE',260),cbagv.bank_account_type)
                                         bank_account_type,
   xep.name                              legal_entity,
   catv.bank_name                        bank_name,
   catv.bank_branch_name                 bank_branch_name,
   catv.source                           source,
   catv.source_code                      source_code,
   decode( catv.clearing_trx_type
         , 'MISC'    , 'CASH'
         , 'PAY'     , 'PAYROLL'
         , 'PAY_EFT' , 'PAYROLL'
         , 'XTR_LINE', decode( catv.trx_type
                             , 'PAYMENT', 'ROI-P'
                             , 'CASH'   , 'ROI-R'
                             )
         , 'ROI_LINE', decode( catv.trx_type
                             , 'PAYMENT', 'ROI-P'
                             , 'CASH'   , 'ROI-R'
                            )
                     , catv.clearing_trx_type
         )                               type_code,
   decode( catv.trx_type
         , 'PAYMENT', catv.type_meaning
         , 'REFUND' , catv.type_meaning
         , 'CASH'   , catv.type_meaning
         , 'MISC'   , catv.type_meaning || ' ' || xxen_util.meaning('CASH','TRX_TYPE',260)
         )                               type,
   trunc(catv.trx_date)                  effective_date,
   trunc(nvl(catv.maturity_date
            ,catv.trx_date))             maturity_date,
   decode( catv.clearing_trx_type
         , 'JE_LINE', null
                    , catv.agent_name
         )                               agent_name,
   decode( catv.clearing_trx_type
         , 'JE_LINE', null
                    , catv.payment_method
         )                               payment_method,
   decode( catv.clearing_trx_type
         , 'JE_LINE', null
                    , catv.trx_number
         )                               transaction_number,
   decode( catv.clearing_trx_type
         , 'JE_LINE', catv.batch_name
         )                               journal_batch_name,
   decode( catv.clearing_trx_type
         , 'JE_LINE', catv.period_name
         )                               journal_period,
   decode( catv.clearing_trx_type
         , 'JE_LINE', catv.journal_category
         )                               journal_category,
   decode( catv.clearing_trx_type
         , 'JE_LINE', catv.journal_entry_line_number
         )                               journal_line_number,
   decode( catv.clearing_trx_type
         , 'JE_LINE', catv.trx_number
         )                               journal_descripton,
   decode( catv.clearing_trx_type
         , 'JE_LINE', fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, catv.code_combination_id, 'ALL', 'Y', 'VALUE')
         )                               journal_account,
   null                                  statement_number,
   decode( catv.clearing_trx_type
         , 'JE_LINE', catv.type_meaning
         )                               line_type,
   null                                  transaction_subtype,
   null                                  direction,
   catv.currency_code                    currency_code,
   catv.bank_account_amount              bank_account_amount,
   catv.amount                           amount,
   decode( catv.trx_type
         , 'PAYMENT', decode(catv.status, 'VOIDED', catv.bank_account_amount, -catv.bank_account_amount)
         , 'REFUND' , decode(catv.status, 'VOIDED', catv.bank_account_amount, -catv.bank_account_amount)
         , 'CASH'   , decode(catv.status, 'REVERSED', -catv.bank_account_amount, catv.bank_account_amount)
         , 'MISC'   , decode(catv.status, 'REVERSED', -catv.bank_account_amount, catv.bank_account_amount)
         )                               account_amount,
   decode( catv.clearing_trx_type
         , 'CASH'    , decode(catv.status, 'REVERSED', 20, 10)
         , 'MISC'    , decode(catv.status, 'REVERSED', 20, 10)
         , 'PAYMENT' , decode(catv.status, 'VOIDED'  , 40, 30)
         , 'PAY'     , decode(catv.status, 'V'       , 45, 35)
         , 'PAY_EFT' , decode(catv.status, 'V'       , 45, 35)
         , 'REFUND'  , decode(catv.status,'VOIDED'   , 60, 50)
         , 'JE_LINE' , 70
         , 'XTR_LINE', 85
         , 'ROI_LINE', 85
         )                               transaction_order,
   catv.trx_id                           trx_id,
   haou.name                             organization,
   xep2.name                             treasury_legal_entity,
   --
   -- GL Cash Account Details
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') gl_company_code,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') gl_company_desc,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') gl_account_code,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') gl_account_desc,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') gl_cost_center_code,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION') gl_cost_center_desc,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE') gl_cash_account,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') gl_cash_account_desc
  from
   ce_avail_trx_v            catv,
   ce_bank_accts_gt_v        cbagv,
   ce_system_parameters      csp,
   xle_entity_profiles       xep,
   gl_code_combinations      gcc,
   hr_all_organization_units haou,
   xle_entity_profiles       xep2
  where
   cbagv.bank_account_id            = catv.bank_account_id and
   csp.legal_entity_id          (+) = cbagv.account_owner_org_id and
   xep.legal_entity_id              = cbagv.account_owner_org_id and
   gcc.code_combination_id          = cbagv.asset_code_combination_id and
   haou.organization_id         (+) = catv.org_id and
   xep2.legal_entity_id         (+) = catv.legal_entity_id and
   catv.status                     != decode( nvl(csp.show_void_payment_flag, 'N')
                                            , 'N', decode(catv.clearing_trx_type,'PAY', 'V', 'PAY_EFT', 'V', 'VOIDED')
                                                 , ' x'
                                            ) and
   catv.clearing_trx_type          != 'STATEMENT' and
   nvl(catv.journal_category,'Y')  != decode(catv.clearing_trx_type,'JE_LINE','Revaluation','X') and
   catv.trx_date                   >= csp.cashbook_begin_date and
   (   ( :p_type                   in ('PAYMENTS', 'RECEIPTS', 'AR_AND_AP','ALL') and
         haou.name                  = nvl(:p_operating_unit, haou.name) and
         catv.clearing_trx_type    in ( 'PAYMENT', 'REFUND', 'CASH', 'MISC')
       ) or
       ( :p_type                   in ('XTR_LINES', 'ALL') and
         catv.legal_entity_id       = csp.legal_entity_id and
         xep2.name                  = nvl(:p_legal_entity, xep2.name) and
         catv.clearing_trx_type     = 'XTR_LINE'
       ) or
       ( :p_type                   in ( 'PAYROLLS', 'ALL') and
         catv.legal_entity_id      is null and
         haou.name                  = nvl(:p_business_group, haou.name) and
         catv.clearing_trx_type    in ( 'PAY', 'PAY_EFT')
       ) or
       ( :p_type                   in ('ROI_LINES', 'JE_LINES','ALL') and
         catv.org_id               is null and
         catv.legal_entity_id      is null and
         catv.clearing_trx_type    in ( 'ROI_LINE', 'JE_LINE')
       )
   ) and
   1=1
  union all
  select distinct
   catv.bank_account_num                 bank_account_num,
   catv.bank_account_name                bank_account_name,
   catv.bank_currency_code               bank_account_currency,
   nvl(xxen_util.meaning(cbagv.bank_account_type,'BANK_ACCOUNT_TYPE',260),cbagv.bank_account_type)
                                         bank_account_type,
   xep.name                              legal_entity,
   catv.bank_name                        bank_name,
   catv.bank_branch_name                 bank_branch_name,
   xxen_util.meaning('STATEMENTS','TRAN_ORG_TYPE',260)
                                         source,
   'STATEMENTS'                          source_code,
   catv.clearing_trx_type                type_code,
   catv.type_meaning                     type,
   trunc(catv.trx_date)                  effective_date,
   trunc(catv.maturity_date)             maturity_date,
   null                                  agent_name,
   null                                  payment_method,
   catv.trx_number                       transaction_number,
   null                                  journal_batch_name,
   null                                  journal_period,
   null                                  journal_category,
   to_number(null)                       journal_line_number,
   null                                  journal_descripton,
   null                                  journal_account,
   csh.statement_number                  statement_number,
   catv.type_meaning                     line_type,
   null                                  transaction_subtype,
   null                                  direction,
   catv.currency_code                    currency_code,
   catv.bank_account_amount              bank_account_amount,
   catv.amount                           amount,
   decode( catv.trx_type
         , 'DEBIT'     , -catv.bank_account_amount
         , 'MISC_DEBIT', -catv.bank_account_amount
                       , catv.bank_account_amount
         )                               account_amount,
   decode( catv.clearing_trx_type
         , 'STATEMENT',75
         )                               transaction_order,
   catv.trx_id                           trx_id,
   null                                  organization,
   null                                  treasury_legal_entity,
   --
   -- GL Cash Account Details
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') gl_company_code,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') gl_company_desc,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') gl_account_code,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') gl_account_desc,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') gl_cost_center_code,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION') gl_cost_center_desc,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE') gl_cash_account,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') gl_cash_account_desc
  from
   ce_260_transactions_v     catv,
   ce_bank_accts_gt_v        cbagv,
   ce_statement_headers      csh,
   xle_entity_profiles       xep,
   gl_code_combinations      gcc
  where
   cbagv.bank_account_id      = catv.bank_account_id and
   catv.reference_id          = csh.statement_header_id and
   xep.legal_entity_id        = cbagv.account_owner_org_id and
   gcc.code_combination_id    = cbagv.asset_code_combination_id and
   :p_type                   in ('STATEMENTS','ALL') and
   1=1
  union all
  select
   catv.bank_account_num                 bank_account_num,
   catv.bank_account_name                bank_account_name,
   catv.bank_currency_code               bank_account_currency,
   nvl(xxen_util.meaning(cbagv.bank_account_type,'BANK_ACCOUNT_TYPE',260),cbagv.bank_account_type)
                                         bank_account_type,
   xep.name                              legal_entity,
   catv.bank_name                        bank_name,
   catv.bank_branch_name                 bank_branch_name,
   xxen_util.meaning('CASHFLOWS','TRAN_ORG_TYPE',260)
                                         source,
   'CASHFLOWS'                           source_code,
   catv.clearing_trx_type                type_code,
   catv.type_meaning                     type,
   trunc(nvl(catv.value_date
            ,catv.trx_date))             effective_date,
   trunc(catv.maturity_date)             maturity_date,
   decode( catv.clearing_trx_type
         , 'CASHFLOW', catv.counterparty
                     , catv.agent_name
   )                                     agent_name,
   null                                  payment_method,
   null                                  transaction_number,
   null                                  journal_batch_name,
   null                                  journal_period,
   null                                  journal_category,
   to_number(null)                       journal_line_number,
   null                                  journal_descripton,
   null                                  journal_account,
   null                                  statement_number,
   null                                  line_type,
   catv.trxn_subtype                     transaction_subtype,
   c1.meaning                            direction,
   catv.currency_code                    currency_code,
   decode( catv.trx_type
         ,'PAYMENT', -catv.bank_account_amount
                   , catv.bank_account_amount
         )                               bank_account_amount,
   catv.amount                           amount,
   decode( catv.trx_type
         , 'PAYMENT', -catv.bank_account_amount
                    , catv.bank_account_amount
         )                               account_amount,
   decode(catv.clearing_trx_type
         ,'CASHFLOW', 90)                transaction_order,
   catv.trx_id                           trx_id,
   null                                  organization,
   xep2.name                             treasury_legal_entity,
   --
   -- GL Cash Account Details
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE') gl_company_code,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION') gl_company_desc,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE') gl_account_code,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') gl_account_desc,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE') gl_cost_center_code,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION') gl_cost_center_desc,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE') gl_cash_account,
   fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION') gl_cash_account_desc
  from
   ce_260_cf_transactions_v  catv,
   ce_bank_accts_gt_v        cbagv,
   ce_system_parameters      csp,
   xle_entity_profiles       xep,
   gl_code_combinations      gcc,
   xle_entity_profiles       xep2,
   ce_lookups                c1
  where
   cbagv.bank_account_id      = catv.bank_account_id and
   csp.legal_entity_id        = catv.legal_entity_id and
   xep.legal_entity_id        = cbagv.account_owner_org_id and
   gcc.code_combination_id    = cbagv.asset_code_combination_id and
   xep2.legal_entity_id       = catv.legal_entity_id and
   c1.lookup_type             = 'CE_CASHFLOW_DIRECTION' and
   c1.lookup_code             = catv.trx_type and
   :p_type                   in ('CASHFLOWS','ALL') and
   xep2.name                  = nvl(:p_legal_entity,xep2.name) and
   1=1
) cat,
fnd_currencies fc
where
 fc.currency_code = cat.currency_code
order by
 cat.bank_name,
 cat.bank_account_num,
 cat.transaction_order,
 cat.effective_date