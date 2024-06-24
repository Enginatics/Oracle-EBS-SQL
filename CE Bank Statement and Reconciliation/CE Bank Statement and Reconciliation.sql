/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE Bank Statement and Reconciliation
-- Description: Application: Cash Management
Description: Bank Statements - Bank Statement Details and Reconciliation

Provides equivalent functionality to the following standard Oracle Forms/Reports
- Bank Statements and Reconciliation Form
  Applicable Templates:
  Pivot: Bank Statement by Transaction Type
  Bank Statement Detail
  Bank Statement Detail with Reconciled Trxs
- Bank Statement Summary Report
   Applicable Templates:
   Pivot: Bank Statement by Transaction Type
   Bank Statement Summary
- Bank Statement Detail Report
   Applicable Templates:
  Pivot: Bank Statement by Transaction Type
  Bank Statement Detail
  Bank Statement Detail with Reconciled Trxs

This Blitz Report offers an extended set of parameters over and above the standard form/reports to search for specific reconciled transactions.

Sources: 
Bank Statement Detail Report (CEXSTMRR)
Bank Statement Summary Report (CEXSTMSR)
DB package:  CE_CEXSTMRR_XMLP_PKG (required to initialize security)

-- Excel Examle Output: https://www.enginatics.com/example/ce-bank-statement-and-reconciliation/
-- Library Link: https://www.enginatics.com/reports/ce-bank-statement-and-reconciliation/
-- Run Report: https://demo.enginatics.com/

with ce_bank_statements as
(
select /*+ ordered index(hpb hz_parties_u1) index(hpbb hz_parties_u1) index(xep xle_entity_profiles_u1) index(gcc gl_code_combinations_u1) push_pred(nsf_recon) push_pred(oth_recon) */
 -- Statement Details
 xep.name legal_entity,
 cbagv.masked_account_num bank_account_num,
 cbagv.bank_account_name bank_account_name,
 nvl(xxen_util.meaning(cbagv.bank_account_type,'BANK_ACCOUNT_TYPE',260),cbagv.bank_account_type) bank_account_type,
 cbagv.currency_code bank_account_currency,
 hpb.party_name bank_name,
 hpbb.party_name branch_name,
 csh.statement_number statement_num,
 csh.doc_sequence_value document_number,
 trunc(csh.statement_date) statement_date,
 trunc(csh.gl_date) gl_date,
 csh.check_digits,
 csh.control_begin_balance control_opening_balance,
 nvl(csh.control_total_cr,0) - nvl(csh.control_total_dr,0) control_net_movement,
 csh.control_end_balance control_closing_balance,
 csh.control_total_cr control_receipts,
 csh.control_total_dr control_payments,
 nvl(csh.control_cr_line_count,0) + nvl(csh.control_dr_line_count,0) control_lines_count,
 csh.control_cr_line_count control_receipts_count,
 csh.control_dr_line_count control_payments_count,
 csh.cashflow_balance,
 csh.int_calc_balance value_dated_balance,
 csh.one_day_float,
 csh.two_day_float,
 xxen_util.meaning(csh.auto_loaded_flag,'YES_NO',0) auto_loaded_flag,
 xxen_util.meaning(csh.statement_complete_flag,'YES_NO',0) statement_complete_flag,
 xxen_util.meaning(cbagv.multi_currency_allowed_flag,'YES_NO',0) multi_currency_flag,
 --
 -- Statement Line Details
 csl.line_number line_num,
 xxen_util.meaning(csl.trx_type,'BANK_TRX_TYPE',260) trx_type,
 csl.trx_code code,
 csl.bank_trx_number trx_number,
 trunc(csl.trx_date) trx_date,
 trunc(csl.effective_date) value_date,
 xxen_util.meaning(csl.status,'STATEMENT_LINE_STATUS',260) status,
 csl.status     status_code,
 -- credit/debit amounts
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,case when csl.trx_type in ('MISC_CREDIT','CREDIT','STOP','SWEEP_IN') then csl.amount else null end
         ,null
       ) receipt_amount,
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,case when csl.trx_type in ('MISC_DEBIT','DEBIT','REJECTED','NSF','SWEEP_OUT') then csl.amount else null end
         ,null
       ) payment_amount,
 -- net amounts
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,case when csl.trx_type in ('MISC_DEBIT','DEBIT','REJECTED','NSF','SWEEP_OUT') then -1 else 1 end  * csl.amount
         ,null
       ) net_amount,
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,case when csl.trx_type in ('MISC_DEBIT','DEBIT','REJECTED','NSF','SWEEP_OUT') then -1 else 1 end
          *  decode(csl.status
                   ,'EXTERNAL',csl.amount
                              ,decode(csl.trx_type,'NSF',nsf_recon.amount_matched,oth_recon.amount_matched)
                   )
         ,null
       ) net_reconciled_amount,
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,case when csl.trx_type in ('MISC_DEBIT','DEBIT','REJECTED','NSF','SWEEP_OUT') then -1 else 1 end
            * decode(csl.status
                    ,'EXTERNAL',to_number(null)
                               ,decode(sign(csl.amount - nvl(decode(csl.trx_type,'NSF',nsf_recon.amount_matched,oth_recon.amount_matched),0))
                                      ,1,csl.amount - nvl(decode(csl.trx_type,'NSF',nsf_recon.amount_matched,oth_recon.amount_matched),0)
                                        ,null
                                      )
                    )
         ,null
       ) net_unreconciled_amount,
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,case when csl.trx_type in ('MISC_DEBIT','DEBIT','REJECTED','NSF','SWEEP_OUT') then -1 else 1 end
            * decode(csl.status
                    ,'EXTERNAL',to_number(null)
                               ,decode(sign(csl.amount - nvl(decode(csl.trx_type,'NSF',nsf_recon.amount_matched,oth_recon.amount_matched),0))
                                      ,-1,-(csl.amount - nvl(decode(csl.trx_type,'NSF',nsf_recon.amount_matched,oth_recon.amount_matched),0))
                                        ,null
                                      )
                    )
         ,null
       ) net_overreconciled_amount,
 -- amounts
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,csl.amount
         ,null
       ) amount,
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,decode(csl.status
                ,'EXTERNAL',csl.amount
                           ,decode(csl.trx_type,'NSF',nsf_recon.amount_matched,oth_recon.amount_matched)
                )
         ,null
       ) reconciled_amount,
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,decode(csl.status
                ,'EXTERNAL',to_number(null)
                           ,decode(sign(csl.amount - nvl(decode(csl.trx_type,'NSF',nsf_recon.amount_matched,oth_recon.amount_matched),0))
                                  ,1,csl.amount - nvl(decode(csl.trx_type,'NSF',nsf_recon.amount_matched,oth_recon.amount_matched),0)
                                    ,null
                                  )
                )
         ,null
       ) unreconciled_amount,
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,decode(csl.status
                ,'EXTERNAL',to_number(null)
                           ,decode(sign(csl.amount - nvl(decode(csl.trx_type,'NSF',nsf_recon.amount_matched,oth_recon.amount_matched),0))
                                  ,-1,-(csl.amount - nvl(decode(csl.trx_type,'NSF',nsf_recon.amount_matched,oth_recon.amount_matched),0))
                                     ,null
                                  )
                )
         ,null
       ) overreconciled_amount,
 --
 -- counts
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,1
         ,null
       ) line_count,
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,case when csl.trx_type in ('MISC_CREDIT','CREDIT','STOP','SWEEP_IN') then 1 else 0 end
         ,null
       ) receipt_line_count,
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,case when csl.trx_type in ('MISC_DEBIT','DEBIT','REJECTED','NSF','SWEEP_OUT') then 1 else 0 end
         ,null
       ) payment_line_count,
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,decode(csl.status,'UNRECONCILED',1,'ERROR',1,0)
         ,null
       ) unreconciled_line_count,
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,decode(csl.trx_type,'NSF',nsf_recon.count_matched,oth_recon.count_matched)
         ,null
       ) reconciled_trx_count,
 -- charges
 decode(count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row)
       ,1,decode(csl.charges_amount,0,to_number(null),csl.charges_amount)
         ,null
       ) charges_amount,
 --
 csl.currency_code trx_currency,
 trunc(csl.exchange_rate_date) exchange_date,
 ( select gdct.user_conversion_type
   from gl_daily_conversion_types gdct
   where gdct.conversion_type = csl.exchange_rate_type
 ) exchange_rate_type,
 csl.exchange_rate,
 csl.original_amount line_original_amount,
 (select
  sum(
  case
  when crtv.application_id = 101
  then nvl((select nvl(gjl.entered_dr,gjl.entered_cr) from gl_je_lines gjl where gjl.je_header_id = crtv.cash_receipt_id and gjl.je_line_num = crtv.trx_id),0)
  when crtv.application_id = 200
  then nvl((select aca.amount from ap_checks_all aca where aca.check_id = crtv.trx_id),0)
  when crtv.application_id = 222
  then nvl((select nvl(acrha.amount+nvl(acrha.factor_discount_amount,0), acrha.amount+nvl(acrha.factor_discount_amount,0)) from ar_cash_receipt_history_all acrha where acrha.cash_receipt_history_id = crtv.trx_id),0)
  when crtv.application_id = 260 and crtv.clearing_trx_type = 'CASHFLOW'
  then nvl((select cc.cashflow_amount
            from ce_cashflows cc, fnd_currencies fc where cc.cashflow_id = crtv.trx_id and cc.cashflow_currency_code = fc.currency_code),0)
  when crtv.application_id = 260 and crtv.clearing_trx_type = 'STATEMENT'
  then nvl((select csl.amount from ce_statement_lines csl where csl.statement_line_id = crtv.trx_id),0)
  when crtv.application_id = 801 and crtv.clearing_trx_type = 'PAY_EFT'
  then nvl((select ppp.value from pay_assignment_actions paa, pay_pre_payments ppp where paa.assignment_action_id = crtv.trx_id and paa.pre_payment_id = ppp.pre_payment_id),0)
  when crtv.application_id = 801 and crtv.clearing_trx_type = 'PAY' and crtv.status = 'V'
  then nvl((select ppp.value from  pay_action_interlocks pai, pay_assignment_actions paa, pay_pre_payments ppp where pai.locking_action_id = crtv.trx_id and pai.locked_action_id = paa.assignment_action_id and paa.pre_payment_id = ppp.pre_payment_id),0)
  when crtv.application_id = 801 and crtv.clearing_trx_type = 'PAY' and nvl(crtv.status,'X') != 'V'
  then nvl((select ppp.value from pay_assignment_actions paa, pay_pre_payments ppp where paa.assignment_action_id = crtv.trx_id and paa.pre_payment_id = ppp.pre_payment_id),0)
  when crtv.application_id = 999
  then nvl((select civ.amount from ce_999_interface_v civ where civ.trx_id = crtv.trx_id),0)
  when crtv.application_id = 185
  then nvl((select abs(xss.settlement_amount) from xtr_settlement_summary xss where xss.settlement_summary_id = crtv.trx_id),0)
  end
  )
  from
  ce_reconciled_transactions_v crtv
  where
  crtv.statement_line_id = csl.statement_line_id
 ) trx_original_amount,
 (select
  sum(
  case
  when crtv.application_id = 101
  then nvl((select nvl(gjl.accounted_dr,gjl.accounted_cr) from gl_je_lines gjl where gjl.je_header_id = crtv.cash_receipt_id and gjl.je_line_num = crtv.trx_id),0)
  when crtv.application_id = 200
  then nvl((select nvl(aca.base_amount,aca.amount) from ap_checks_all aca where aca.check_id = crtv.trx_id),0)
  when crtv.application_id = 222
  then nvl((select nvl(acrha.acctd_amount+nvl(acrha.acctd_factor_discount_amount,0), acrha.amount+nvl(acrha.factor_discount_amount,0)) from ar_cash_receipt_history_all acrha where acrha.cash_receipt_history_id = crtv.trx_id),0)
  when crtv.application_id = 260 and crtv.clearing_trx_type = 'CASHFLOW'
  then nvl((select nvl(cc.base_amount,decode(fc.minimum_accountable_unit, null, round((cc.cashflow_amount * nvl(cc.cashflow_exchange_rate,1)), nvl(fc.precision,2)), (round(((cc.cashflow_amount * nvl(cc.cashflow_exchange_rate,1))/fc.minimum_accountable_unit),0) * fc.minimum_accountable_unit)))
            from ce_cashflows cc, fnd_currencies fc where cc.cashflow_id = crtv.trx_id and cc.cashflow_currency_code = fc.currency_code),0)
  when crtv.application_id = 260 and crtv.clearing_trx_type = 'STATEMENT'
  then nvl((select nvl(csl.original_amount,csl.amount) from ce_statement_lines csl where csl.statement_line_id = crtv.trx_id),0)
  when crtv.application_id = 801 and crtv.clearing_trx_type = 'PAY_EFT'
  then nvl((select nvl(ppp.base_currency_value, ppp.value) from pay_assignment_actions paa, pay_pre_payments ppp where paa.assignment_action_id = crtv.trx_id and paa.pre_payment_id = ppp.pre_payment_id),0)
  when crtv.application_id = 801 and crtv.clearing_trx_type = 'PAY' and crtv.status = 'V'
  then nvl((select nvl(ppp.base_currency_value, ppp.value) from  pay_action_interlocks pai, pay_assignment_actions paa, pay_pre_payments ppp where pai.locking_action_id = crtv.trx_id and pai.locked_action_id = paa.assignment_action_id and paa.pre_payment_id = ppp.pre_payment_id),0)
  when crtv.application_id = 801 and crtv.clearing_trx_type = 'PAY' and nvl(crtv.status,'X') != 'V'
  then nvl((select nvl(ppp.base_currency_value, ppp.value) from pay_assignment_actions paa, pay_pre_payments ppp where paa.assignment_action_id = crtv.trx_id and paa.pre_payment_id = ppp.pre_payment_id),0)
  when crtv.application_id = 999
  then nvl((select nvl(civ.acctd_amount,civ.amount) from ce_999_interface_v civ where civ.trx_id = crtv.trx_id),0)
  when crtv.application_id = 185
  then nvl((select abs(xss.settlement_amount) from xtr_settlement_summary xss where xss.settlement_summary_id = crtv.trx_id),0)
  end
  )
  from
  ce_reconciled_transactions_v crtv
  where
  crtv.statement_line_id = csl.statement_line_id
 ) trx_original_amount_acctd,
 --
 nvl( csl.customer_text
    , ( select /*+ push_pred */ crtv.agent_name
        from   ce_reconciled_transactions_v crtv
        where  crtv.statement_line_id = csl.statement_line_id and
               rownum=1
      )
    ) agent,
 csl.bank_account_text agent_bank_account,
 csl.invoice_text invoice,
 csl.trx_text description,
 ( select /*+ push_pred */ distinct
     listagg(crev.error_message,', ') within group (order by crev.error_message) over ()
   from
     ( select distinct
         crev.statement_header_id,
         crev.statement_line_id,
         fnd_message.get_string(crev.application_short_name,crev.message_name) error_message
       from
         ce_reconciliation_errors_v crev
     ) crev
   where
     crev.statement_header_id = csl.statement_header_id and
     crev.statement_line_id   = csl.statement_line_id
 ) error_messages,
 xxen_util.user_name(csl.last_updated_by) line_last_updated_by,
 xxen_util.client_time(csl.last_update_date) line_last_updated_date,
 --
 -- GL Cash Account Details
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'VALUE'),null)  gl_company_code,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_BALANCING', 'Y', 'DESCRIPTION'),null)  gl_company_desc,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'VALUE'),null)  gl_account_code,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'GL_ACCOUNT', 'Y', 'DESCRIPTION'),null)  gl_account_desc,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'VALUE'),null)  gl_cost_center_code,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'FA_COST_CTR', 'Y', 'DESCRIPTION'),null)  gl_cost_center_desc,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'VALUE'),null)  gl_cash_account,
 nvl2(gcc.code_combination_id,fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', gcc.chart_of_accounts_id, NULL, gcc.code_combination_id, 'ALL', 'Y', 'DESCRIPTION'),null) gl_cash_account_desc,
 --
 csh.statement_header_id,
 csl.statement_line_id,
 count(csl.statement_line_id) over (partition by csl.statement_line_id order by csl.statement_line_id rows between unbounded preceding and current row) recon_sort_num,
 decode(csl.status,'EXTERNAL','N',decode(sign(csl.amount - nvl(decode(csl.trx_type,'NSF',nsf_recon.amount_matched,oth_recon.amount_matched),0)),1,'Y','N')) unrecon_amount_exists_flag
from
 ce_bank_accts_gt_v        cbagv,
 ce_statement_headers      csh,
 ce_statement_lines        csl,
 hz_parties                hpb,
 hz_parties                hpbb,
 xle_entity_profiles       xep,
 gl_code_combinations      gcc,
 ( select
     csra.statement_line_id,
     sum( decode(csra.reference_type
                ,'RECEIPT',decode(acra.type
                                 ,'MISC',decode(acrha.status,'CLEARED',nvl(-csra.amount,0),nvl(csra.amount,0))
                                 , nvl(csra.amount,0)
                                 )
                          ,nvl(csra.amount,0)
                )
        ) amount_matched,
     count(*) count_matched
   from
     ce_statement_reconcils_all csra,
     ar_cash_receipt_history_all acrha,
     ar_cash_receipts_all acra
   where
     csra.status_flag = 'M' and
     csra.current_record_flag = 'Y' and
     csra.reference_id = acrha.cash_receipt_history_id (+) and
     acrha.cash_receipt_id = acra.cash_receipt_id (+)
   group by
     csra.statement_line_id
 ) nsf_recon,
 ( select
     csl.statement_line_id,
     sum(decode(decode(csl.trx_type,'MISC_CREDIT','RECEIPT','CREDIT','RECEIPT','MISC_DEBIT','PAYMENT','SWEEP_IN','RECEIPT','SWEEP_OUT','PAYMENT','DEBIT','PAYMENT','OTHERS')
               , 'RECEIPT', decode(csra.reference_type,'PAYMENT',nvl(-csra.amount,0),nvl(csra.amount,0))
               , 'PAYMENT', decode(csra.reference_type,'RECEIPT',nvl(-csra.amount,0),nvl(csra.amount,0))
                          , nvl(csra.amount,0)
               )
        ) amount_matched,
     count(*) count_matched
   from
     ce_statement_reconcils_all csra,
     ce_statement_lines         csl
   where
     csra.statement_line_id = csl.statement_line_id and
     csra.status_flag = 'M' and
     csra.current_record_flag = 'Y'
   group by
     csl.statement_line_id
 ) oth_recon
where
 csh.bank_account_id             = cbagv.bank_account_id and
 csl.statement_header_id         = csh.statement_header_id and
 hpb.party_id                    = cbagv.bank_id and
 hpbb.party_id                   = cbagv.bank_branch_id and
 xep.legal_entity_id             = cbagv.account_owner_org_id and
 gcc.code_combination_id     (+) = cbagv.asset_code_combination_id and
 nsf_recon.statement_line_id (+) = decode(csl.trx_type,'NSF',csl.statement_line_id,null) and
 oth_recon.statement_line_id (+) = decode(csl.trx_type,'NSF',null,csl.statement_line_id) and
 1=1
)
,ce_recon_transactions as
(
select  /*+ push_pred */
 crtv.statement_line_id,
 crtv.type_meaning recon_trx_type,
 crtv.trx_number recon_trx_number,
 crtv.currency_code recon_trx_currency,
 crtv.amount recon_trx_amount,
 crtv.bank_account_amount recon_bank_account_amount,
 case when crtv.status in ('STOP INITIATED', 'VOIDED', 'V')
 then to_number(null)
 else crtv.amount_cleared
 end recon_trx_amount_cleared,
 trunc(crtv.cleared_date) recon_trx_cleared_date,
 trunc(crtv.maturity_date) recon_trx_maturity_date,
 trunc(crtv.value_date) recon_trx_value_date,
 trunc(crtv.gl_date) recon_trx_gl_date,
 trunc(crtv.trx_date) recon_trx_date,
 trunc(crtv.exchange_rate_date) recon_trx_exchange_rate_date,
 crtv.exchange_rate_type recon_trx_exchange_rate_type,
 crtv.exchange_rate_dsp recon_trx_exchange_rate,
 crtv.bank_charges recon_trx_bank_charges,
 crtv.bank_errors recon_trx_bank_errors,
 crtv.remittance_number recon_trx_remittance_number,
 crtv.batch_name recon_trx_batch_name,
 case when crtv.cash_receipt_id is not null
       and crtv.application_id = 222
 then ( select ifte.payment_system_order_number
        from   ar_cash_receipts_all acra,
               iby_fndcpt_tx_extensions ifte
        where  acra.payment_trxn_extension_id = ifte.trxn_extension_id(+)
        and    acra.cash_receipt_id = crtv.cash_receipt_id
        and    rownum=1
      )
 else null
 end recon_trx_pson,
 crtv.agent_name recon_trx_agent_name,
 crtv.reference_type_dsp recon_trx_reference_type,
 case
 when crtv.reference_type = 'REMITTANCE'
 then ( select aba.name
        from   ar_batches_all aba
        where  aba.batch_id = crtv.reference_id
        and    rownum=1)
 when crtv.reference_type = 'PAYMENT_BATCH'
 then to_char(crtv.reference_id)
 when crtv.reference_type = 'RECEIPT'
 then ( select acra.receipt_number
        from   ar_cash_receipts_all acra
        where  acra.cash_receipt_id = crtv.reference_id
        and    rownum=1)
 when crtv.reference_type in ('PAYMENT','REFUND')
 then ( select to_char(aca.check_number)
        from   ap_checks_all aca
        where  aca.check_id = crtv.reference_id
        and    rownum=1)
 end recon_trx_reference_number,
 haou.name recon_trx_operating_unit,
 crtv.status_dsp recon_trx_status
from
 ce_reconciled_transactions_v crtv,
 hr_all_organization_units    haou
where
 2=2 and
 :p_show_trx is not null and
 haou.organization_id (+) = crtv.org_id
)
--
-- Main Query Starts Here
select /*+ use_nl(crt cebs) */
 cebs.legal_entity,
 cebs.bank_account_num,
 cebs.bank_account_name,
 cebs.bank_account_type,
 cebs.bank_account_currency,
 cebs.bank_name,
 cebs.branch_name,
 cebs.statement_num,
 cebs.document_number,
 cebs.statement_date,
 cebs.gl_date,
 cebs.check_digits,
 cebs.control_opening_balance,
 cebs.control_net_movement,
 cebs.control_closing_balance,
 cebs.control_receipts,
 cebs.control_payments,
 cebs.control_lines_count,
 cebs.control_receipts_count,
 cebs.control_payments_count,
 --
 case
 when nvl(cebs.control_receipts,0) = nvl(sum(cebs.receipt_amount) over (partition by cebs.statement_header_id),0) and
      nvl(cebs.control_payments,0) = nvl(sum(cebs.payment_amount) over (partition by cebs.statement_header_id),0)
 then null
 else 'Yes'
 end control_amount_error,
 case
 when nvl(cebs.control_receipts_count,0) = nvl(sum(cebs.receipt_line_count) over (partition by cebs.statement_header_id),0) and
      nvl(cebs.control_payments_count,0) = nvl(sum(cebs.payment_line_count) over (partition by cebs.statement_header_id),0)
 then null
 else 'Yes'
 end control_count_error,
 --
 cebs.cashflow_balance,
 cebs.value_dated_balance,
 cebs.one_day_float,
 cebs.two_day_float,
 cebs.auto_loaded_flag,
 cebs.statement_complete_flag,
 cebs.multi_currency_flag,
 --
 -- Statement Line Details
 cebs.line_num,
 cebs.trx_type,
 cebs.code,
 cebs.trx_number,
 cebs.trx_date,
 cebs.value_date,
 cebs.status,
 cebs.receipt_amount,
 cebs.payment_amount,
 cebs.net_amount,
 cebs.net_reconciled_amount,
 cebs.net_unreconciled_amount,
 cebs.net_overreconciled_amount,
 cebs.amount,
 cebs.reconciled_amount,
 cebs.unreconciled_amount,
 cebs.overreconciled_amount,
 cebs.line_count,
 cebs.receipt_line_count,
 cebs.payment_line_count,
 cebs.unreconciled_line_count,
 cebs.reconciled_trx_count,
 cebs.charges_amount,
 cebs.trx_currency,
 cebs.exchange_date,
 cebs.exchange_rate_type,
 cebs.exchange_rate,
 cebs.line_original_amount,
 cebs.trx_original_amount,
 cebs.trx_original_amount_acctd,
 decode(sign(cebs.net_reconciled_amount),-1,-1,1) * abs(cebs.trx_original_amount) net_trx_original_amount,
 decode(sign(cebs.net_reconciled_amount),-1,-1,1) * abs(cebs.trx_original_amount) net_trx_original_amount_acctd, 
 cebs.agent,
 cebs.agent_bank_account,
 cebs.invoice,
 cebs.description,
 cebs.error_messages,
 cebs.line_last_updated_by,
 cebs.line_last_updated_date,
 --
 -- Reconcilation Trx Details
 crt.recon_trx_type,
 crt.recon_trx_number,
 crt.recon_trx_currency,
 crt.recon_trx_amount,
 crt.recon_bank_account_amount,
 crt.recon_trx_amount_cleared,
 crt.recon_trx_cleared_date,
 crt.recon_trx_maturity_date,
 crt.recon_trx_value_date,
 crt.recon_trx_gl_date,
 crt.recon_trx_date,
 crt.recon_trx_exchange_rate_date,
 crt.recon_trx_exchange_rate_type,
 crt.recon_trx_exchange_rate,
 crt.recon_trx_bank_charges,
 crt.recon_trx_bank_errors,
 crt.recon_trx_remittance_number,
 crt.recon_trx_batch_name,
 crt.recon_trx_pson,
 crt.recon_trx_agent_name,
 crt.recon_trx_reference_type,
 crt.recon_trx_reference_number,
 crt.recon_trx_operating_unit,
 crt.recon_trx_status,
 --
 -- GL Cash Account Details
 cebs.gl_company_code,
 cebs.gl_company_desc,
 cebs.gl_account_code,
 cebs.gl_account_desc,
 cebs.gl_cost_center_code,
 cebs.gl_cost_center_desc,
 cebs.gl_cash_account,
 cebs.gl_cash_account_desc,
 --
 cebs.statement_header_id,
 cebs.statement_line_id,
 cebs.recon_sort_num,
 -- pivot labels
 cebs.gl_company_code || ' - ' || cebs.gl_company_desc gl_company_pivot_label,
 cebs.bank_name || ' - ' || cebs.bank_account_num || ' - ' || cebs.bank_account_name || ' (' ||  cebs.bank_account_currency || ')' bank_account_pivot_label,
 to_char(cebs.statement_date,'YYYY-MM-DD') || ' - ' || cebs.statement_num  statement_num_pivot_label
from
 ce_bank_statements    cebs,
 ce_recon_transactions crt
where
 3=3 and 
 cebs.statement_line_id = crt.statement_line_id (+)
order by
 cebs.legal_entity,
 cebs.bank_name,
 cebs.bank_account_num,
 cebs.statement_date,
 cebs.statement_num,
 cebs.line_num,
 cebs.recon_sort_num,
 lpad(crt.recon_trx_number, 240)