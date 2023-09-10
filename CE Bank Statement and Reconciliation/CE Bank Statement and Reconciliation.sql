/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2023 Enginatics GmbH                   */
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
 csl.original_amount trx_original_amount,
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
&lp_recon_trx_qry
--
-- Main Query Starts Here
select &lp_recon_trx_hint
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
 cebs.trx_original_amount,
 cebs.agent,
 cebs.agent_bank_account,
 cebs.invoice,
 cebs.description,
 cebs.error_messages,
 cebs.line_last_updated_by,
 cebs.line_last_updated_date,
 --
 -- Reconcilation Trx Details
 &lp_recon_trx_col
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
 ce_bank_statements        cebs
 &lp_recon_trx_tab
where
 3=3
 &lp_recon_trx_join
order by
 cebs.legal_entity,
 cebs.bank_name,
 cebs.bank_account_num,
 cebs.statement_date,
 cebs.statement_num,
 cebs.line_num,
 cebs.recon_sort_num
 &lp_recon_trx_ord