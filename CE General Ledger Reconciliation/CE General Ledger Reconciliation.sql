/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: CE General Ledger Reconciliation
-- Description: Application: Cash Management
Description: Bank Statements - General Ledger Reconciliation

Provides equivalent functionality to the following standard Oracle Forms/Reports
- General Ledger Reconciliation Report
  Applicable Templates:
  Pivot: Reconciliation Summary

Source: General Ledger Reconciliation Report
Short Name: CEXRECRE
DB package: CE_CEXRECRE_XMLP_PKG
-- Excel Examle Output: https://www.enginatics.com/example/ce-general-ledger-reconciliation/
-- Library Link: https://www.enginatics.com/reports/ce-general-ledger-reconciliation/
-- Run Report: https://demo.enginatics.com/

with
q_gl_end_bal as
(
  select
    'GL END BALANCE'   record_type,
    null               operating_unit,
    null               transaction_number,
    to_date(null)      gl_date,
    to_date(null)      effective_date,
    null               agent,
    null               payment_method,
    null               transaction_subtype,
    null               je_name,
    to_number(null)    je_line,
    null               je_line_type,
    to_date(null)      je_posted_date,
    null               statement_number,
    to_number(null)    statement_line,
    null               statement_trx_type,
    null               status,
    :c_bank_curr_dsp   currency,
    to_number(null)    transaction_amount,
    to_number(null)    accounted_amount,
    to_number (nvl(bal.period_net_dr,0) - nvl(bal.period_net_cr,0) + nvl(bal.begin_balance_dr,0) - nvl(bal.begin_balance_cr,0))
                       gl_end_balance,
    glcc.code_combination_id
                       cash_account_ccid
  from
    gl_balances bal,
    gl_code_combinations glcc
  where
   bal.actual_flag(+) = 'A' and
   bal.ledger_id(+) = :c_set_of_books_id and
   bal.currency_code(+) = :c_bank_curr_dsp and
   nvl(bal.translated_flag,'R') = 'R' and
   bal.period_name(+) = :p_period_name and
   bal.code_combination_id(+) = glcc.code_combination_id and
   glcc.chart_of_accounts_id = :c_chart_of_accounts_id and
   glcc.template_id is null  and
   glcc.code_combination_id in
    ( select distinct
       case col.cnum
       when 1 then cba2.asset_code_combination_id
       when 2 then cgac2.asset_code_combination_id
       when 3 then cgac2.ap_asset_ccid
       when 4 then cgac2.ar_asset_ccid
       when 5 then cgac2.xtr_asset_ccid
       end
      from
       ce_bank_accounts cba2,
       ce_bank_acct_uses_all cbaua2,
       ce_gl_accounts_ccid cgac2,
       ( select 1 as cnum from dual union all
         select 2 as cnum from dual union all
         select 3 as cnum from dual union all
         select 4 as cnum from dual union all
         select 5 as cnum from dual
       ) col
      where
       cba2.bank_account_id = :p_bank_account_id and
       cbaua2.bank_account_id = cba2.bank_account_id and
       cgac2.bank_acct_use_id = cbaua2.bank_acct_use_id
    )
),
q_stmt_end_bal as
(
  select
    'STMT END BALANCE' record_type,
    null               operating_unit,
    null               transaction_number,
    to_date(null)      gl_date,
    to_date(null)      effective_date,
    null               agent,
    null               payment_method,
    null               transaction_subtype,
    null               je_name,
    to_number(null)    je_line,
    null               je_line_type,
    to_date(null)      je_posted_date,
    null               statement_number,
    to_number(null)    statement_line,
    null               statement_trx_type,
    null               status,
    :c_bank_curr_dsp   currency,
    to_number(null)    transaction_amount,
    to_number(:p_closing_balance)
                       accounted_amount,
    to_number(null)    gl_end_balance,
    to_number(:c_asset_cc_id) cash_account_ccid
  from
    dual
),
q_ar_receipts as
(
  /* query 1: fetch latest receipt history event which has hit gl cash account and is not reconciled
     query 2: fetch unreconciled cleared event for a reversed receipt */
  select
    'RECEIPT'          record_type,
    fnd_access_control_util.get_org_name(cr.org_id)
                       operating_unit,
    cr.receipt_number  transaction_number,
    crh.gl_date        gl_date,
    cr.receipt_date    effective_date,
    hz.party_name      agent,
    arm.name           payment_method,
    null               transaction_subtype,
    null               je_name,
    to_number(null)    je_line,
    null               je_line_type,
    to_date(null)      je_posted_date,
    null               statement_number,
    to_number(null)    statement_line,
    null               statement_trx_type,
    crh.status         status,
    cr.currency_code   currency,
    cr.amount          transaction_amount,
    decode(:c_bank_curr_dsp,
           :c_gl_currency_code, decode(crh.status,'REVERSED',-crh.acctd_amount,crh.acctd_amount),
                                decode(crh.status,'REVERSED',-crh.amount,crh.amount)
          )            accounted_amount,
    to_number(null)    gl_end_balance,
    gla.ar_asset_ccid cash_account_ccid
  from
    ar_cash_receipts cr,
    ar_cash_receipt_history crh,
    hz_cust_accounts cu,
    hz_parties hz,
    ar_receipt_methods arm,
    ce_bank_acct_uses_ou_v bau,
    ce_bank_accounts ba,
    ce_gl_accounts_ccid gla,
    ce_system_parameters sys
  where
    cr.cash_receipt_id = crh.cash_receipt_id and
    cr.remit_bank_acct_use_id = bau.bank_acct_use_id and
    bau.bank_account_id = :p_bank_account_id and
    bau.org_id = cr.org_id and
    bau.bank_account_id = ba.bank_account_id and
    ba.account_owner_org_id = sys.legal_entity_id and
    bau.ar_use_enable_flag = 'Y' and
    gla.bank_acct_use_id = bau.bank_acct_use_id and
    crh.account_code_combination_id = gla.ar_asset_ccid and
    crh.status in('REMITTED', 'CLEARED', 'REVERSED') and
    crh.gl_date <= :c_as_of_date and
    crh.gl_date >= sys.cashbook_begin_date and
    decode(crh.status,'REMITTED',nvl(crh.reversal_created_from,'X'),crh.created_from) <> 'RATE ADJUSTMENT TRIGGER' and
    not ( crh.status = 'REMITTED' and
          crh.created_from = 'RATE ADJUSTMENT TRIGGER' and
          crh.reversal_created_from is null and
          crh.amount = - 1 * cr.amount
        ) and
    not ( crh.status ='CLEARED' and
          nvl(crh.reversal_created_from,'x') ='RATE ADJUSTMENT TRIGGER'
        ) and
    crh.posting_control_id > 0 and
    not exists
      ( select 1
        from ar_cash_receipt_history_all crh_r
        where
          crh_r.cash_receipt_history_id = crh.reversal_cash_receipt_hist_id and
          crh_r.gl_date <= :c_as_of_date and
          crh_r.posting_control_id > 0 and
          crh_r.created_from <> 'RATE ADJUSTMENT TRIGGER'
      ) and
    cu.cust_account_id(+) = cr.pay_from_customer and
    hz.party_id(+) = cu.party_id and
    arm.receipt_method_id = cr.receipt_method_id and
    cr.status <> 'REV' and
    not exists
      ( select null
        from
          ce_statement_recon_gt_v sr,
          ce_statement_lines sl,
          ce_statement_headers sh
        where
          sr.reference_id = crh.cash_receipt_history_id and
          sr.reference_type = 'RECEIPT' and
          sr.status_flag = 'M' and
          sr.current_record_flag = 'Y' and
          sl.statement_line_id = sr.statement_line_id and
          sl.statement_header_id = sh.statement_header_id and
          sh.bank_account_id = :p_bank_account_id and
          sh.statement_date <= :c_as_of_date
        union
        /* this union is required for receipts with rate adjustment that are reconciled. for such cases, the reference will be of the rate adjustment record */
        select null
        from
          ce_statement_recon_gt_v sr,
          ce_statement_lines sl,
          ce_statement_headers sh,
          ar_cash_receipt_history crh_rc
        where
          sr.reference_id = crh_rc.cash_receipt_history_id and
          sr.reference_type = 'RECEIPT' and
          sr.status_flag = 'M' and
          sr.current_record_flag = 'Y' and
          sl.statement_line_id = sr.statement_line_id and
          sl.statement_header_id = sh.statement_header_id and
          sh.bank_account_id = :p_bank_account_id and
          sh.statement_date <= :c_as_of_date and
          crh_rc.created_from = 'RATE ADJUSTMENT TRIGGER' and
          crh_rc.cash_receipt_id = cr.cash_receipt_id
      ) and
    /* not exists to filter out receipts reversed without remittance */
    not exists
      ( select 1
        from
          ar_cash_receipt_history_all crh2
        where
          crh.cash_receipt_history_id = crh2.reversal_cash_receipt_hist_id and
          crh.status = 'REVERSED' and
          crh2.status = 'CONFIRMED'
      )
  union all
  select
    'RECEIPT'          record_type,
    fnd_access_control_util.get_org_name(cr.org_id)
                       operating_unit,
    cr.receipt_number  transaction_number,
    crh.gl_date        gl_date,
    cr.receipt_date    effective_date,
    hz.party_name      agent,
    arm.name           payment_method,
    null               transaction_subtype,
    null               je_name,
    to_number(null)    je_line,
    null               je_line_type,
    to_date(null)      je_posted_date,
    null               statement_number,
    to_number(null)    statement_line,
    null               statement_trx_type,
    crh.status         status,
    cr.currency_code   currency,
    cr.amount          transaction_amount,
    decode(:c_bank_curr_dsp,:c_gl_currency_code,crh.acctd_amount,crh.amount)
                       accounted_amount,
    to_number(null)    gl_end_balance,
    gla.ar_asset_ccid  cash_account_ccid
  from
    ar_cash_receipts cr,
    ar_cash_receipt_history crh2,
    ar_cash_receipt_history crh,
    hz_cust_accounts cu,
    hz_parties hz,
    ar_receipt_methods arm,
    ce_bank_acct_uses_ou_v bau,
    ce_gl_accounts_ccid gla,
    ce_bank_accounts ba,
    ce_system_parameters sys
  where
    cr.cash_receipt_id = crh.cash_receipt_id and
    cr.remit_bank_acct_use_id = bau.bank_acct_use_id and
    bau.bank_account_id = :p_bank_account_id and
    bau.org_id = cr.org_id and
    bau.bank_account_id = ba.bank_account_id and
    ba.account_owner_org_id = sys.legal_entity_id and
    bau.ar_use_enable_flag = 'Y' and
    gla.bank_acct_use_id = bau.bank_acct_use_id and
    crh.account_code_combination_id = gla.ar_asset_ccid and
    crh.status in('REMITTED', 'CLEARED') and
    crh.gl_date <= :c_as_of_date and
    crh.gl_date >= sys.cashbook_begin_date and
    crh.gl_posted_date is not null and
    crh.created_from <> 'RATE ADJUSTMENT TRIGGER' and
    crh2.cash_receipt_id = crh.cash_receipt_id and
    crh2.cash_receipt_history_id = crh.reversal_cash_receipt_hist_id and
    crh2.status = 'REVERSED' and
    crh2.gl_date <= :c_as_of_date and
    crh2.gl_date >= sys.cashbook_begin_date and
    cu.cust_account_id(+) = cr.pay_from_customer and
    hz.party_id(+) = cu.party_id and
    arm.receipt_method_id = cr.receipt_method_id and
    (cr.status <> 'REV' or
     (cr.status = 'REV' and crh.reversal_gl_date > :c_as_of_date)
    ) and
    not exists
      ( select null
        from
          ce_statement_recon_gt_v sr,
          ce_statement_lines sl,
          ce_statement_headers sh
        where
          sr.reference_id = crh.cash_receipt_history_id and
          sr.reference_type = 'RECEIPT' and
          sr.status_flag = 'M' and
          sr.current_record_flag = 'Y' and
          sl.statement_line_id = sr.statement_line_id and
          sl.statement_header_id = sh.statement_header_id and
          sh.bank_account_id = :p_bank_account_id and
          sh.statement_date <= :c_as_of_date
      )
),
q_ap_payments as
(
  /* query 1: checks have not hit gl cash, but are reconciled. (query 1 of union)
     query 2: checks have hit gl cash, but are not reconciled. (query 2 of union) */
  select
    'PAYMENT'                record_type,
    fnd_access_control_util.get_org_name(c.org_id)
                             operating_unit,
    to_char(c.check_number)  transaction_number,
    xle.event_date           gl_date,
    c.check_date             effective_date,
    c.vendor_name            agent,
    c.payment_method_code    payment_method,
    null                     transaction_subtype,
    null                     je_name,
    to_number(null)          je_line,
    null                     je_line_type,
    to_date(null)            je_posted_date,
    null                     statement_number,
    to_number(null)          statement_line,
    null                     statement_trx_type,
    c.status_lookup_code     status,
    c.currency_code          currency,
    c.amount                 transaction_amount,
    decode(:c_bank_curr_dsp,
           :c_gl_currency_code,nvl(nvl(c.cleared_base_amount,c.base_amount),c.amount)
                              ,c.amount
          )                  accounted_amount,
    to_number(null)          gl_end_balance,
    coalesce(gla.ap_asset_ccid,gla.asset_code_combination_id,ba.asset_code_combination_id) cash_account_ccid
  from
    ap_checks_all c,
    ce_bank_acct_uses_all bau,
    ce_gl_accounts_ccid gla,
    ce_security_profiles_gt ou,
    ce_bank_accounts ba,
    ce_system_parameters sys,
    xla_transaction_entities trx,
    xla_events xle
  where
    c.check_date <=   trunc(:c_as_of_date) + 1 - 1/24/60/60 and
    c.ce_bank_acct_use_id = bau.bank_acct_use_id and
    c.org_id = bau.org_id and
    bau.bank_account_id = :p_bank_account_id and
    gla.bank_acct_use_id = bau.bank_acct_use_id and
    bau.org_id = ou.organization_id and
    ou.organization_type = 'OPERATING_UNIT' and
    bau.bank_account_id = ba.bank_account_id and
    ba.account_owner_org_id = sys.legal_entity_id and
    trx.application_id = 200 and
    trx.ledger_id = sys.set_of_books_id and
    nvl(trx.source_id_int_1,-99) = c.check_id and
    trx.entity_code = 'AP_PAYMENTS' and
    xle.application_id = trx.application_id and
    xle.entity_id = trx.entity_id and
    xle.event_type_code not in ('PAYMENT CANCELLED','REFUND CANCELLED') and
    xle.event_number =
      ( select max(event_number)
        from
          xla_events xe2
        where xe2.application_id = xle.application_id and
          xe2.entity_id = xle.entity_id and
          xe2.event_date <= :c_as_of_date and
          xe2.event_date >= sys.cashbook_begin_date and
          xe2.event_status_code = 'P' and
          xe2.event_type_code not in
            ('PAYMENT MATURITY ADJUSTED',
             'MANUAL PAYMENT ADJUSTED',
             'PAYMENT ADJUSTED',
             'PAYMENT CLEARING ADJUSTED',
             'MANUAL REFUND ADJUSTED',
             'REFUND ADJUSTED'
            )
      ) and
    exists
      ( select  /*+ push_subq no_unnest*/ 1
        from
          ap_payment_history_all h2
        where
          h2.check_id = c.check_id and
          h2.transaction_type like decode(c.void_date, null, h2.transaction_type,'%CANCEL%')
      ) and
    not exists
      ( select null
        from
          xla_ae_headers xeh,
          xla_ae_lines ael1
        where
          xeh.event_id = xle.event_id and
          xeh.application_id = xle.application_id and
          ael1.application_id = xeh.application_id and
          xeh.entity_id = xle.entity_id and
          ael1.ae_header_id = xeh.ae_header_id and
          xeh.event_type_code not in
            ('PAYMENT UNCLEARED',
             'PAYMENT CANCELLED',
             'REFUND CANCELLED'
            ) and
          ael1.accounting_class_code = 'CASH'
      ) and
    /* check that payment is reconciled */
    exists
      ( select null
        from
          ce_statement_reconcils_all csr,
          ce_statement_lines csl,
          ce_statement_headers csh
        where
          csr.reference_id = c.check_id and
          csr.current_record_flag = 'Y' and
          csr.reference_type = 'PAYMENT' and
          csr.status_flag = 'M' and
          csr.statement_line_id = csl.statement_line_id and
          csl.statement_header_id = csh.statement_header_id and
          csh.statement_date <= :c_as_of_date and
          csh.statement_date >= sys.cashbook_begin_date
      )
  union all
  select
    'PAYMENT'                record_type,
    fnd_access_control_util.get_org_name(c.org_id)
                             operating_unit,
    to_char(c.check_number)  transaction_number,
    aeh.accounting_date      gl_date,
    c.check_date             effective_date,
    c.vendor_name            agent,
    c.payment_method_code    payment_method,
    null                     transaction_subtype,
    null                     je_name,
    to_number(null)          je_line,
    null                     je_line_type,
    to_date(null)            je_posted_date,
    null                     statement_number,
    to_number(null)          statement_line,
    null                     statement_trx_type,
    c.status_lookup_code     status,
    c.currency_code          currency,
    c.amount                 transaction_amount,
    -1*decode(:c_bank_curr_dsp,
              :c_gl_currency_code,nvl(nvl(c.cleared_base_amount,c.base_amount),c.amount)
                                 ,c.amount
             )               accounted_amount,
    to_number(null)          gl_end_balance,
    coalesce(gla.ap_asset_ccid,gla.asset_code_combination_id,ba.asset_code_combination_id) cash_account_ccid
  from
    ap_checks_all c,
    ce_bank_acct_uses_all bau,
    ce_gl_accounts_ccid gla,
    ce_security_profiles_gt ou,
    ce_bank_accounts ba,
    ce_system_parameters sys,
    xla_transaction_entities trx,
    xla_ae_headers aeh
  where
    c.check_date <=  trunc(:c_as_of_date) + 1 - 1/24/60/60 and
    c.ce_bank_acct_use_id = bau.bank_acct_use_id and
    c.org_id = bau.org_id and
    bau.bank_account_id = :p_bank_account_id and
    gla.bank_acct_use_id = bau.bank_acct_use_id and
    bau.org_id = ou.organization_id and
    ou.organization_type = 'OPERATING_UNIT' and
    bau.bank_account_id = ba.bank_account_id and
    ba.account_owner_org_id = sys.legal_entity_id and
    nvl(trx.source_id_int_1,-99) = c.check_id and
    trx.entity_code = 'AP_PAYMENTS' and
    trx.application_id = 200 and
    trx.ledger_id = sys.set_of_books_id and
    aeh.entity_id = trx.entity_id and
    aeh.application_id = trx.application_id and
    aeh.application_id = 200 and
    /* fetch latest accounted event before as_of_date and check that it hits the gl cash account */
    aeh.event_type_code in
      ('PAYMENT CLEARED',
       'PAYMENT CREATED',
       'REFUND RECORDED',
       'PAYMENT MATURED'
      ) and
    aeh.ledger_id = sys.set_of_books_id and
    aeh.event_id =
      ( select max(event_id)
        from
          xla_events xe
        where
          xe.application_id = 200 and
          xe.entity_id = trx.entity_id and
          xe.event_number =
            ( select max(event_number)
              from
                xla_events xe2
              where
                xe2.application_id = 200 and
                xe2.entity_id = xe.entity_id and
                xe2.event_date <= :c_as_of_date and
                xe2.event_date >= sys.cashbook_begin_date and
                xe2.event_status_code = 'P' and
                xe2.event_type_code not in
                  ('PAYMENT MATURITY ADJUSTED',
                   'MANUAL PAYMENT ADJUSTED',
                   'PAYMENT ADJUSTED',
                   'PAYMENT CLEARING ADJUSTED',
                   'MANUAL REFUND ADJUSTED',
                   'REFUND ADJUSTED'
                  )
            )
      ) and
    exists
      ( select 'x'
        from
          xla_ae_lines ael
        where
          aeh.ae_header_id = ael.ae_header_id and
          ael.application_id = 200 and
          ael.accounting_class_code = 'CASH'
      ) and
    exists
      ( select 1
        from
          ap_payment_history_all h2
        where
          h2.check_id = c.check_id and
          h2.transaction_type like decode(c.void_date, null, h2.transaction_type, '%CANCEL%')
      ) and
    /* check that payment is not reconciled */
    not exists
      ( select /*+ push_subq no_unnest */ null
        from
          ce_statement_reconcils_all csr,
          ce_statement_lines csl,
          ce_statement_headers csh
        where
          csr.reference_id = c.check_id and
          csr.reference_type = 'PAYMENT' and
          csr.status_flag = 'M' and
          csr.current_record_flag = 'Y' and
          csr.statement_line_id = csl.statement_line_id and
          csl.statement_header_id = csh.statement_header_id and
          csh.statement_date <= :c_as_of_date
      )
),
q_cashflows as
(
  select
    'CASHFLOW'               record_type,
    null                     operating_unit,
    to_char(ca.cashflow_id)  transaction_number,
    ch.accounting_date       gl_date,
    ca.cashflow_date         effective_date,
    nvl(xle.name,ca.customer_text) agent,
    null                     payment_method,
    trxn.transaction_sub_type_name transaction_subtype,
    null                     je_name,
    to_number(null)          je_line,
    null                     je_line_type,
    to_date(null)            je_posted_date,
    null                     statement_number,
    to_number(null)          statement_line,
    null                     statement_trx_type,
    l1.meaning               status,
    ca.cashflow_currency_code currency,
    ca.cashflow_amount       transaction_amount,
    decode(ca.cashflow_direction,'RECEIPT',(-1),'PAYMENT',(1)) * nvl(ch.cleared_amount,ca.cashflow_amount)
                             accounted_amount,
    to_number(null)          gl_end_balance,
    coalesce(gla.xtr_asset_ccid,gla.asset_code_combination_id,ba.asset_code_combination_id) cash_account_ccid
  from
    ce_cashflows ca,
    ce_cashflow_acct_h ch,
    ce_bank_accounts ba,
    ce_bank_acct_uses_all bau,
    ce_gl_accounts_ccid gla,
    ce_trxns_subtype_codes trxn,
    xle_firstparty_information_v xle,
    ce_lookups l1,
    ce_system_parameters sys
  where
    ca.cashflow_bank_account_id  = :p_bank_account_id and
    ca.cashflow_legal_entity_id  = sys.legal_entity_id and
    ca.cashflow_id  = ch.cashflow_id and
    ba.bank_account_id = ca.cashflow_bank_account_id and
    bau.bank_account_id = ca.cashflow_bank_account_id and
    bau.legal_entity_id = ca.cashflow_legal_entity_id and
    gla.bank_acct_use_id = bau.bank_acct_use_id and
    ca.source_trxn_subtype_code_id = trxn.trxn_subtype_code_id(+) and
    ch.accounting_date  >= sys.cashbook_begin_date and
    ca.counterparty_party_id = xle.party_id(+) and
    l1.lookup_type = 'CASHFLOW_STATUS_CODE' and
    l1.lookup_code = ca.cashflow_status_code and
    ca.cashflow_status_code = 'RECONCILED' and
    ch.event_id =
      ( select nvl(max(a.event_id),-1)
        from
          ce_cashflow_acct_h a
        where
          a.cashflow_id = ch.cashflow_id and
          trunc(a.accounting_date) <= :c_as_of_date
      ) and
    ch.event_type = decode(ca.source_trxn_type,'BAT','CE_BAT_CLEARED','STMT','CE_STMT_RECORDED') and
    ch.status_code = 'UNACCOUNTED'
  union
  select
    'CASHFLOW'               record_type,
    null                     operating_unit,
    to_char(ca.cashflow_id)  transaction_number,
    ch.accounting_date       gl_date,
    ca.cashflow_date         effective_date,
    nvl(xle.name,ca.customer_text) agent,
    null                     payment_method,
    trxn.transaction_sub_type_name transaction_subtype,
    null                     je_name,
    to_number(null)          je_line,
    null                     je_line_type,
    to_date(null)            je_posted_date,
    null                     statement_number,
    to_number(null)          statement_line,
    null                     statement_trx_type,
    l1.meaning               status,
    ca.cashflow_currency_code currency,
    ca.cashflow_amount       transaction_amount,
    decode(ca.cashflow_direction,'RECEIPT',(1),'PAYMENT',(-1)) * nvl(ch.cleared_amount,ca.cashflow_amount)
                             accounted_amount,
    to_number(null)          gl_end_balance,
    coalesce(gla.xtr_asset_ccid,gla.asset_code_combination_id,ba.asset_code_combination_id) cash_account_ccid
  from
    ce_cashflows ca,
    ce_cashflow_acct_h ch,
    ce_bank_accounts ba,
    ce_bank_acct_uses_all bau,
    ce_gl_accounts_ccid gla,
    xla_events e,
    xla_ae_headers eh,
    xla_ae_lines el,
    ce_trxns_subtype_codes trxn,
    xle_firstparty_information_v xle,
    ce_lookups l1,
    ce_system_parameters sys
  where
    ca.cashflow_bank_account_id = :p_bank_account_id and
    ca.source_trxn_subtype_code_id = trxn.trxn_subtype_code_id(+) and
    ca.cashflow_legal_entity_id = sys.legal_entity_id and
    ca.cashflow_id = ch.cashflow_id and
    ba.bank_account_id = ca.cashflow_bank_account_id and
    bau.bank_account_id = ca.cashflow_bank_account_id and
    bau.legal_entity_id = ca.cashflow_legal_entity_id and
    gla.bank_acct_use_id = bau.bank_acct_use_id and
    ch.event_id = e.event_id and
    eh.event_id = e.event_id and
    el.ae_header_id = eh.ae_header_id and
    el.accounting_class_code = 'CASH' and
    ch.accounting_date >= sys.cashbook_begin_date and
    ca.counterparty_party_id = xle.party_id(+) and
    l1.lookup_type = 'CASHFLOW_STATUS_CODE' and
    l1.lookup_code = ca.cashflow_status_code and
    ca.cashflow_status_code = 'CLEARED' and
    ch.event_id =
      ( select nvl(max(a.event_id),-1)
        from
          ce_cashflow_acct_h a
        where
          a.cashflow_id = ch.cashflow_id and
          trunc(a.accounting_date) <= :c_as_of_date
      ) and
    ch.event_type = decode(ca.source_trxn_type,'BAT','CE_BAT_CLEARED','STMT','CE_STMT_RECORDED') and
    ch.status_code = 'ACCOUNTED'
  union
  select
    'CASHFLOW'               record_type,
    null                     operating_unit,
    to_char(ca.cashflow_id)  transaction_number,
    ch.accounting_date       gl_date,
    ca.cashflow_date         effective_date,
    nvl(xle.name,ca.customer_text) agent,
    null                     payment_method,
    trxn.transaction_sub_type_name transaction_subtype,
    null                     je_name,
    to_number(null)          je_line,
    null                     je_line_type,
    to_date(null)            je_posted_date,
    null                     statement_number,
    to_number(null)          statement_line,
    null                     statement_trx_type,
    l1.meaning               status,
    ca.cashflow_currency_code currency,
    ca.cashflow_amount       transaction_amount,
    decode(ca.cashflow_direction,'RECEIPT',(-1),'PAYMENT',(1)) * nvl(ch.cleared_amount,ca.cashflow_amount)
                             accounted_amount,
    to_number(null)          gl_end_balance,
    coalesce(gla.xtr_asset_ccid,gla.asset_code_combination_id,ba.asset_code_combination_id) cash_account_ccid
  from
    ce_cashflows ca,
    ce_cashflow_acct_h ch,
    ce_bank_accounts ba,
    ce_bank_acct_uses_all bau,
    ce_gl_accounts_ccid gla,
    ce_trxns_subtype_codes trxn,
    xle_firstparty_information_v xle,
    ce_lookups l1,
    ce_system_parameters sys
  where
    ca.cashflow_bank_account_id   = :p_bank_account_id and
    ca.source_trxn_subtype_code_id = trxn.trxn_subtype_code_id(+) and
    ca.cashflow_legal_entity_id = sys.legal_entity_id and
    ca.cashflow_id = ch.cashflow_id and
    ba.bank_account_id = ca.cashflow_bank_account_id and
    bau.bank_account_id = ca.cashflow_bank_account_id and
    bau.legal_entity_id = ca.cashflow_legal_entity_id and
    gla.bank_acct_use_id = bau.bank_acct_use_id and
    ch.accounting_date >= sys.cashbook_begin_date and
    ca.counterparty_party_id = xle.party_id(+) and
    l1.lookup_type = 'CASHFLOW_STATUS_CODE' and
    l1.lookup_code = ca.cashflow_status_code and
    ca.cashflow_status_code = 'CREATED' and
    ch.event_id =
      ( select nvl(max(a.event_id),-1)
        from
          ce_cashflow_acct_h a
        where
          a.cashflow_id = ch.cashflow_id and
          trunc(a.accounting_date) <= :c_as_of_date
      ) and
    ( (ch.event_type = 'CE_BAT_UNCLEARED' and
       ch.status_code  = 'ACCOUNTED'
      ) or
      (ch.event_type  = 'CE_BAT_CREATED'
      )
    ) and
    exists
      ( select null
        from
          ce_statement_lines csl,
          ce_statement_headers csh,
          ce_transaction_codes_v cod
        where
          csl.trx_type in ('DEBIT','CREDIT','SWEEP_IN','SWEEP_OUT') and
          csl.trx_code = cod.trx_code and
          cod.bank_account_id = :p_bank_account_id and
          cod.reconcile_flag = 'CE' and
          csl.bank_trx_number = ca.bank_trxn_number and
          csh.statement_header_id = csl.statement_header_id and
          csh.bank_account_id = :p_bank_account_id
      )
),
q_gl_je_lines as
(
  select
    'JE_LINE'          record_type,
    null               operating_unit,
    null               transaction_number,
    jel.effective_date gl_date,
    jel.effective_date effective_date,
    null               agent,
    null               payment_method,
    null               transaction_subtype,
    jeh.name           je_name,
    jel.je_line_num    je_line,
    cel.meaning        je_line_type,
    jeh.posted_date    je_posted_date,
    null               statement_number,
    to_number(null)    statement_line,
    null               statement_trx_type,
    gll.meaning        status,
    jeh.currency_code  currency,
    decode(nvl(jel.entered_dr,0),0, jel.entered_cr, jel.entered_dr)
                       transaction_amount,
    decode(:c_bank_curr_dsp,
           :c_gl_currency_code,decode(nvl(jel.accounted_dr,0),0, nvl(-1*jel.accounted_cr,0), nvl(jel.accounted_dr,0)),
                               decode(nvl(jel.entered_dr,0)  ,0, nvl(-1*jel.entered_cr,0)  , nvl(jel.entered_dr,0))
          )            accounted_amount,
    to_number(null)    gl_end_balance,
    aba.asset_ccid     cash_account_ccid
  from
    gl_je_lines jel,
    gl_je_headers jeh,
    ce_lookups cel,
    gl_lookups gll,
    gl_sets_of_books sob,
    ( select
        cba.bank_account_id,
        cba.currency_code,
        cba.asset_code_combination_id asset_ccid
      from ce_bank_accounts cba
      union
      select
        cba.bank_account_id,
        cba.currency_code,
        cgl.ar_asset_ccid asset_ccid
      from
        ce_bank_accounts cba,
        ce_bank_acct_uses_ou_v cbu,
        ce_gl_accounts_ccid cgl
      where
        cba.bank_account_id = cbu.bank_account_id and
        cbu.bank_acct_use_id = cgl.bank_acct_use_id and
        cgl.ar_asset_ccid is not null
      union
      select
        cba.bank_account_id,
        cba.currency_code,
        cgl.ap_asset_ccid asset_ccid
      from
        ce_bank_accounts cba,
        ce_bank_acct_uses_ou_v cbu,
        ce_gl_accounts_ccid cgl
      where
        cba.bank_account_id = cbu.bank_account_id and
        cbu.bank_acct_use_id = cgl.bank_acct_use_id and
        cgl.ap_asset_ccid is not null
    ) aba
  where
    jel.ledger_id = to_number(:c_set_of_books_id) and
    jel.code_combination_id = aba.asset_ccid and
    aba.bank_account_id = :p_bank_account_id and
    sob.set_of_books_id = to_number(:c_set_of_books_id) and
    decode(aba.currency_code,sob.currency_code, jeh.currency_code, aba.currency_code) = jeh.currency_code and
    jel.status = 'P' and
    jel.effective_date <= :c_as_of_date and
    jel.effective_date >= to_date(:c_cashbook_begin_date) and
    jeh.je_header_id = jel.je_header_id and
    jeh.je_source not in
      ('Payables',
       'Receivables',
       'AP Translator',
       'AR Translator',
       'Treasury',
       'Cash Management',
       'Consolidation',
       'Payroll'
      ) and
    jeh.je_category <> 'Revaluation' and
    cel.lookup_type = 'TRX_TYPE' and
    cel.lookup_code = decode(decode(nvl(jel.entered_dr,0),0,nvl(jel.accounted_dr,0),jel.entered_dr),
                             0, 'JE_CREDIT'
                              , 'JE_DEBIT'
                            ) and
    (decode(nvl(jel.entered_dr,0), 0, nvl(jel.accounted_dr, 0), jel.entered_dr) = 0 or
     decode(nvl(jel.entered_cr,0), 0, nvl(jel.accounted_cr, 0), jel.entered_cr) = 0
    ) and
    gll.lookup_type = 'MJE_BATCH_STATUS' and
    gll.lookup_code = jel.status and
    jeh.actual_flag = 'A' and
    not exists
      ( select
          null
        from
          ce_statement_recon_gt_v sr,
          ce_statement_lines sl,
          ce_statement_headers sh
        where
          sr.reference_id = jel.je_line_num and
        sr.reference_type = 'JE_LINE' and
        sr.je_header_id = jel.je_header_id and
        sr.status_flag = 'M' and
        sr.current_record_flag = 'Y' and
        sl.statement_line_id = sr.statement_line_id and
        sl.statement_header_id = sh.statement_header_id and
        sh.statement_date <= :c_as_of_date and
        sh.statement_date >= to_date(:c_cashbook_begin_date)
      )
),
q_stmt_error_lines as
(
  select
    'STMT_LINE_ERROR'  record_type,
    null               operating_unit,
    null               transaction_number,
    sh.gl_date         gl_date,
    sl.trx_date        effective_date,
    null               agent,
    null               payment_method,
    null               transaction_subtype,
    null               je_name,
    to_number(null)    je_line,
    null               je_line_type,
    to_date(null)      je_posted_date,
    sh.statement_number statement_number,
    sl.line_number     statement_line,
    sl.trx_type        statement_trx_type,
    'ERROR'            status,
    nvl(sl.currency_code,nvl(sh.currency_code,aba.currency_code))
                       currency,
    decode(nvl(sl.currency_code,nvl(sh.currency_code,aba.currency_code)),
           sob.currency_code, sl.amount,nvl(sl.original_amount, sl.amount)
          )            transaction_amount,
    decode(sl.trx_type,
           'CREDIT'     , - sl.amount,
           'MISC_CREDIT', - sl.amount,
           'STOP'       , - sl.amount,
           'DEBIT'      , sl.amount,
           'MISC_DEBIT' , sl.amount,
           'NSF'        , sl.amount,
           'REJECTED'   , sl.amount,
                          0
          )            accounted_amount,
    to_number(null)    gl_end_balance,
    aba.asset_code_combination_id cash_account_ccid
  from
    ce_statement_lines sl,
    ce_statement_headers sh,
    ce_bank_accts_gt_v aba,
    gl_sets_of_books sob,
    ce_system_parameters sys
  where
    sl.statement_header_id = sh.statement_header_id and
    sh.bank_account_id = :p_bank_account_id and
    sh.statement_date <= :c_as_of_date and
    sh.statement_date >= sys.cashbook_begin_date and
    sl.status = 'ERROR' and
    aba.bank_account_id = sh.bank_account_id and
    sob.set_of_books_id = sys.set_of_books_id and
    sys.legal_entity_id = aba.account_owner_org_id
)
--
-- Main Query Starts Here
--
select
  (select xep.name legal_entity
   from   xle_entity_profiles xep,
          ce_bank_accounts cba
   where  xep.legal_entity_id = cba.account_owner_org_id and
          cba.bank_account_id = :p_bank_account_id
  )                     legal_entity,
  :c_name               ledger,
  :p_period_name        period,
  :c_account_number_dsp bank_account_num,
  :c_account_name_dsp   bank_account_name,
  :c_bank_curr_dsp      bank_account_currency,
  :c_bank_name_dsp      bank_name,
  :c_bank_branch_dsp    bank_branch,
  case x.seq
  when 1 then 'General Ledger Cash Account Balance'
  when 2 then 'Bank Statement Closing Balance'
  when 3 then 'Unreconciled Receipts'
  when 4 then 'Unreconciled Payments'
  when 5 then 'Unreconciled Cashflows'
  when 6 then 'Unreconciled Journal Lines'
  when 7 then 'Stmnt Lines Marked As Errors'
  end                        record_type,
  x.gl_date,
  x.effective_date,
  x.currency,
  x.transaction_amount,
  x.accounted_amount,
  x.operating_unit,
  x.agent,
  x.transaction_number,
  x.payment_method,
  x.transaction_subtype,
  x.je_name,
  x.je_line,
  x.je_line_type,
  x.je_posted_date,
  x.statement_number,
  x.statement_line,
  x.statement_trx_type,
  x.status,
  x.gl_end_balance,
  case when x.seq = 1
  then sum(x.gl_end_balance) over () - sum(x.accounted_amount) over ()
  else to_number(null)
  end   difference_amount,
  --gl cash account
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', :c_chart_of_accounts_id, NULL, x.cash_account_ccid, 'GL_BALANCING', 'Y', 'VALUE') gl_company_code,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', :c_chart_of_accounts_id, NULL, x.cash_account_ccid, 'GL_BALANCING', 'Y', 'DESCRIPTION') gl_company_desc,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', :c_chart_of_accounts_id, NULL, x.cash_account_ccid, 'GL_ACCOUNT', 'Y', 'VALUE') gl_account_code,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', :c_chart_of_accounts_id, NULL, x.cash_account_ccid, 'GL_ACCOUNT', 'Y', 'DESCRIPTION') gl_account_desc,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', :c_chart_of_accounts_id, NULL, x.cash_account_ccid, 'FA_COST_CTR', 'Y', 'VALUE') gl_cost_center_code,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', :c_chart_of_accounts_id, NULL, x.cash_account_ccid, 'FA_COST_CTR', 'Y', 'DESCRIPTION') gl_cost_center_desc,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', :c_chart_of_accounts_id, NULL, x.cash_account_ccid, 'ALL', 'Y', 'VALUE') gl_cash_account,
  fnd_flex_xml_publisher_apis.process_kff_combination_1('acct_flex_bal_seg', 'SQLGL', 'GL#', :c_chart_of_accounts_id, NULL, x.cash_account_ccid, 'ALL', 'Y', 'DESCRIPTION') gl_cash_account_desc,
  -- pivot labels
  :c_bank_name_dsp || ' - ' || :c_account_number_dsp || ' - ' || :c_account_name_dsp || ' (' || :c_bank_curr_dsp || ')' bank_account,
  case x.seq
  when 1 then 'A: General Ledger Cash Account Balance'
  when 2 then 'B: Bank Statement Closing Balance'
  when 3 then 'C: + Unreconciled Receipts'
  when 4 then 'D: +/- Unreconciled Payments'
  when 5 then 'E: +/- Unreconciled Cashflows'
  when 6 then 'F: +/- Unreconciled Journal Lines'
  when 7 then 'G: +/- Stmnt Lines Marked As Errors'
  end                        record_type_label,
  x.seq
from
  ( select 1 seq, q_gl_end_bal.* from q_gl_end_bal
    union all
    select 2 seq, q_stmt_end_bal.* from q_stmt_end_bal
    union all
    select 3 seq, q_ar_receipts.* from q_ar_receipts
    union all
    select 4 seq, q_ap_payments.* from q_ap_payments
    union all
    select 5 seq, q_cashflows.* from q_cashflows
    union all
    select 6 seq, q_gl_je_lines.* from q_gl_je_lines
    union all
    select 7 seq, q_stmt_error_lines.* from q_stmt_error_lines
  ) x
where
  1=1
order by
  x.seq,
  x.gl_date nulls  first,
  x.effective_date nulls first,
  x.agent,
  x.je_name,
  x.je_line,
  x.statement_number,
  x.statement_line,
  x.transaction_number