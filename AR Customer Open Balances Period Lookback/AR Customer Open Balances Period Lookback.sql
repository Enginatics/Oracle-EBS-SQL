/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AR Customer Open Balances Period Lookback
-- Description: Report: AR Customer Open Balances Period Lookback
Application: Receivables
Description:
Customer Open Balances summary showing
- Open Balances as of the specified 'As of Date' and as of <n> periods prior to the 'As of Date' period.
- Maximum Open Balance in the prior <n> periods prior to the 'As of Date' period

All balances are show in the functional currency.

Parameters:
As of Date - the report will be run as of this date. Defaults to the current system date.
Look Back <n> periods - number of periods prior to the 'As of Date' period to show
Max Open over last <n> Periods - number of periods prior to the 'As of Date' period to consider in the Maximum Open Balance amount calculation

-- Excel Examle Output: https://www.enginatics.com/example/ar-customer-open-balances-period-lookback/
-- Library Link: https://www.enginatics.com/reports/ar-customer-open-balances-period-lookback/
-- Run Report: https://demo.enginatics.com/

select
  trx.legal_entity                 legal_entity
, trx.legal_entity_identifier      legal_entity_identifier
, trx.ledger                       ledger
, trx.ou_name                      operating_unit
, trx.account_number               customer_number
, trx.customer_name                customer_name
, sum(trx.inv_amt_due_p0)          "Open Amount Acctd Current"
--
&lp_amt_due_max_col
&lp_amt_due_cols1
&lp_reval_cols
&lp_amt_due_max_col_reval
&lp_amt_due_cols1_reval
--
from
  ( select
      xep.name                      legal_entity 
    , xep.legal_entity_identifier   legal_entity_identifier
    , gl.name                       ledger
    , hou.name                      ou_name
    , rcta.invoice_currency_code    currency_code
    , nvl(rcta.exchange_rate,1)     orig_invoice_rate
    , hp.party_name                 customer_name
    , hca.account_number            account_number
    , rcta.trx_number               invoice_number
    , ''                            lookup_code
    , rcta.trx_date                 invoice_date
    , rcta.doc_sequence_value       internal_invoice_no
    , rctt.type                     transaction_type
    , rcta.customer_trx_id          cust_trx_id
    --
    , rctlgd.amount                          invoice_entered_amt
    , nvl(rctlgd.acctd_amount,rctlgd.amount) invoice_entered_amt_acctd
    -- inv_amt_due_acctd
    , sum( case when aps.gl_date <= :p_as_of_date then 1 else 0 end *
          ((aps.amount_due_original * nvl(aps.exchange_rate,1))
           - nvl( ( select sum(ara.acctd_amount_applied_to + nvl(ara.acctd_earned_discount_taken,0) + nvl(ara.acctd_unearned_discount_taken,0))
                    from   ar_receivable_applications_all ara
                    where  ara.status                      = 'APP'
                    and    ara.applied_customer_trx_id     = aps.customer_trx_id
                    and    ara.applied_payment_schedule_id = aps.payment_schedule_id
                    and    ara.org_id                      = aps.org_id
                    and    ara.gl_date                    <= :p_as_of_date
                  )
                , 0)
           + nvl( ( select sum(ara.acctd_amount_applied_from)
                    from   ar_receivable_applications_all ara
                    where  ara.status                  = 'APP'
                    and    ara.application_type       != 'CASH'
                    and    rctt.type                   = 'CM'
                    and    ara.customer_trx_id         = aps.customer_trx_id
                    and    ara.payment_schedule_id     = aps.payment_schedule_id
                    and    ara.org_id                  = aps.org_id
                    and    ara.gl_date                <= :p_as_of_date
                  )
                , 0)
           + nvl( ( select sum(ara.acctd_amount)
                    from ar_adjustments_all ara
                    where ara.customer_trx_id   = aps.customer_trx_id
                    and ara.payment_schedule_id = aps.payment_schedule_id
                    and ara.org_id              = aps.org_id
                    and ara.gl_date            <= :p_as_of_date
                  )
                , 0)
           )
          )  inv_amt_due_p0
    --
    &lp_amt_due_cols2
    --
    , gl.currency_code ledger_currency
    , max(decode(gl.currency_code,:p_reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gl.currency_code=gdr.from_currency and gdr.to_currency=:p_reval_currency and :p_reval_conv_date=gdr.conversion_date and gdct.user_conversion_type=:p_reval_conv_type and gdct.conversion_type=gdr.conversion_type))) reval_conv_rate
    from
      hr_operating_units           hou
    , gl_ledgers                   gl
    , ra_customer_trx_all          rcta
    , ar_payment_schedules_all     aps
    , ra_cust_trx_types_all        rctt
    , ra_cust_trx_line_gl_dist_all rctlgd
    , hz_cust_accounts             hca
    , hz_parties                   hp
    , ar_system_parameters_all     sp
    , xle_entity_profiles          xep
    where
        hou.set_of_books_id              = sp.set_of_books_id
    and gl.ledger_id                     = sp.set_of_books_id
    and rcta.customer_trx_id             = aps.customer_trx_id
    and rcta.org_id                      = hou.organization_id
    and aps.org_id                       = rcta.org_id
    and rcta.cust_trx_type_id            = rctt.cust_trx_type_id
    and rcta.org_id                      = rctt.org_id
    and rctlgd.org_id                    = rctt.org_id
    and aps.customer_trx_id              = rctlgd.customer_trx_id
    and rctlgd.account_class             = 'REC'
    and rctlgd.latest_rec_flag           = 'Y'
    and rcta.bill_to_customer_id         = hca.cust_account_id
    and hp.party_id                      = hca.party_id
    and xep.legal_entity_id (+)          = rcta.legal_entity_id
    and sp.org_id                        = rcta.org_id
    and aps.gl_date_closed               > :p_first_gl_date
    and aps.gl_date                     <= :p_as_of_date
    and 1=1
    group by
      xep.name
    , xep.legal_entity_identifier
    , gl.name
    , gl.currency_code
    , hou.name
    , rcta.invoice_currency_code
    , nvl(rcta.exchange_rate,1)
    , rctlgd.amount
    , nvl(rctlgd.acctd_amount,rctlgd.amount)
    , hp.party_name
    , hca.account_number
    , rcta.trx_number
    , rcta.trx_date
    , rcta.doc_sequence_value
    , rcta.invoice_currency_code
    , rctt.type
    , hca.cust_account_id
    , rcta.customer_trx_id
    union
    select
      xep.name                                      legal_entity
    , xep.legal_entity_identifier                   legal_entity_identifier 
    , gl.name                                       ledger
    , hou.name                                      ou_name
    , substr(acr.currency_code,1,3)                 currency_code
    , nvl(acr.exchange_rate,1)                      orig_invoice_rate    
    , hp.party_name                                 customer_name
    , hca.account_number                            account_number
    , acr.receipt_number                            invoice_number
    , al.lookup_code                                lookup_code
    , acr.receipt_date                              invoice_date    
    , acr.doc_sequence_value                        int_invoice_number
    , decode(ara.status,'ACC','*' || al.meaning)    transaction_type  
    , hca.cust_account_id                           cust_trx_id
    , acr.amount                                    orig_amt
    , acr.amount * nvl(acr.exchange_rate,1)         orig_amt_acctd
    , 0 - sum(case when ara.gl_date <= :p_as_of_date then nvl(ara.acctd_amount_applied_from,0) else 0 end) inv_amt_due_p0
    --
    &lp_amt_due_cols3
    --
    , gl.currency_code ledger_currency
    , max(decode(gl.currency_code,:p_reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gl.currency_code=gdr.from_currency and gdr.to_currency=:p_reval_currency and :p_reval_conv_date=gdr.conversion_date and gdct.user_conversion_type=:p_reval_conv_type and gdct.conversion_type=gdr.conversion_type))) reval_conv_rate
    from
      hr_operating_units             hou
    , gl_ledgers                     gl
    , ar_receivable_applications_all ara
    , ar_lookups                     al
    , ar_cash_receipts_all           acr
    , ar_cash_receipt_history_all    acrh
    , ar_payment_schedules_all       aps
    , hz_cust_accounts               hca
    , hz_parties                     hp
    , ar_system_parameters_all       sp
    , xle_entity_profiles            xep
    where
        hou.set_of_books_id              = sp.set_of_books_id
    and gl.ledger_id                     = sp.set_of_books_id
    and acr.org_id                       = hou.organization_id
    and acr.org_id                       = ara.org_id
    and hca.cust_account_id              = acr.pay_from_customer
    and hca.party_id                     = hp.party_id
    and acr.cash_receipt_id              = ara.cash_receipt_id
    and acrh.cash_receipt_id             = ara.cash_receipt_id
    and ara.cash_receipt_history_id      = acrh.cash_receipt_history_id
    and aps.cash_receipt_id              = acr.cash_receipt_id
    and al.lookup_type                   = 'PAYMENT_TYPE'
    and ara.status                       = al.lookup_code
    and ara.status                       = 'ACC'
    and not exists
        ( select 'X'
          from ar_cash_receipt_history_all crhin
          where crhin.cash_receipt_id = acr.cash_receipt_id
          and   crhin.org_id = acr.org_id
          and crhin.status = 'REVERSED'
        )
    and nvl(ara.confirmed_flag,'Y')      = 'Y'
    and nvl(acr.confirmed_flag,'Y')      = 'Y'
    and xep.legal_entity_id (+)          = acr.legal_entity_id
    and sp.org_id                        = acr.org_id
    and aps.gl_date_closed               > :p_first_gl_date
    and aps.gl_date                     <= :p_as_of_date
    and 2=2
    group by
      xep.name
    , xep.legal_entity_identifier
    , gl.name
    , gl.currency_code
    , hou.name
    , hca.cust_account_id
    , hp.party_name
    , hca.account_number
    , decode(ara.status,'ACC','*' || al.meaning)
    , acr.receipt_number
    , acr.doc_sequence_value
    , acr.receipt_date
    , al.lookup_code
    , acr.amount
    , nvl(acr.exchange_rate,1)
    , substr(acr.currency_code,1,3)
    , acr.currency_code
    union
    select
      xep.name                                      legal_entity 
    , xep.legal_entity_identifier                   legal_entity_identifier 
    , gl.name                                       ledger
    , hou.name                                      ou_name
    , substr(acr.currency_code,1,3)                 currency_code
    , nvl(acr.exchange_rate,1)                      orig_invoice_rate    
    , hp.party_name                                 customer_name
    , hca.account_number                            account_number
    , acr.receipt_number                            invoice_number
    , al.lookup_code                                lookup_code
    , acr.receipt_date                              invoice_date    
    , acr.doc_sequence_value                        int_invoice_number
    , decode(ara.status,'UNAPP','*' || al.meaning)  transaction_type  
    , hca.cust_account_id                           cust_trx_id
    , acr.amount                                    orig_amt
    , acr.amount * nvl(acr.exchange_rate,1)         orig_amt_acctd
    , 0 - sum(case when ara.gl_date <= :p_as_of_date then nvl(ara.acctd_amount_applied_from,0) else 0 end) inv_amt_due_p0    
    --
    &lp_amt_due_cols3
    --
    , gl.currency_code ledger_currency
    , max(decode(gl.currency_code,:p_reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gl.currency_code=gdr.from_currency and gdr.to_currency=:p_reval_currency and :p_reval_conv_date=gdr.conversion_date and gdct.user_conversion_type=:p_reval_conv_type and gdct.conversion_type=gdr.conversion_type))) reval_conv_rate
    from
      hr_operating_units             hou
    , gl_ledgers                     gl
    , ar_receivable_applications_all ara
    , ar_lookups                     al
    , ar_cash_receipts_all           acr
    , ar_cash_receipt_history_all    acrh
    , ar_payment_schedules_all       aps
    , hz_cust_accounts               hca
    , hz_parties                     hp
    , ar_system_parameters_all       sp
    , xle_entity_profiles            xep
    where
        hou.set_of_books_id              = sp.set_of_books_id
    and gl.ledger_id                     = sp.set_of_books_id
    and acr.org_id                       = hou.organization_id
    and acr.org_id                       = ara.org_id
    and hca.cust_account_id              = acr.pay_from_customer
    and hca.party_id                     = hp.party_id
    and acr.cash_receipt_id              = ara.cash_receipt_id
    and acrh.cash_receipt_id             = ara.cash_receipt_id
    and ara.cash_receipt_history_id      = acrh.cash_receipt_history_id
    and aps.cash_receipt_id              = acr.cash_receipt_id
    and al.lookup_type                   = 'PAYMENT_TYPE'
    and ara.status                       = al.lookup_code
    and ara.status                       = 'UNAPP'
    and not exists
        ( select 'X'
          from ar_cash_receipt_history_all crhin
          where crhin.cash_receipt_id = acr.cash_receipt_id
          and   crhin.org_id = acr.org_id
          and   crhin.status = 'REVERSED'
        )
    and nvl(ara.confirmed_flag,'Y')      = 'Y'
    and nvl(acr.confirmed_flag,'Y')      = 'Y'
    and xep.legal_entity_id (+)          = acr.legal_entity_id
    and sp.org_id                        = acr.org_id
    and aps.gl_date_closed               > :p_first_gl_date
    and aps.gl_date                     <= :p_as_of_date
    and 2=2
    group by
      xep.name
    , xep.legal_entity_identifier
    , gl.name
    , gl.currency_code
    , hou.name
    , hca.cust_account_id
    , hp.party_name
    , hca.account_number
    , decode(ara.status,'UNAPP','*' || al.meaning)
    , acr.receipt_number
    , acr.doc_sequence_value
    , acr.receipt_date
    , al.lookup_code
    , acr.amount
    , nvl(acr.exchange_rate,1)
    , substr(acr.currency_code,1,3)
    , acr.currency_code
    union
    select
      xep.name                                      legal_entity 
    , xep.legal_entity_identifier                   legal_entity_identifier 
    , gl.name                                       ledger
    , hou.name                                      ou_name
    , substr(acr.currency_code,1,3)                 currency_code
    , nvl(acr.exchange_rate,1)                      orig_invoice_rate    
    , hp.party_name                                 customer_name
    , hca.account_number                            account_number
    , acr.receipt_number                            invoice_number
    , al.lookup_code                                lookup_code
    , acr.receipt_date                              invoice_date    
    , acr.doc_sequence_value                        int_invoice_number
    , decode(ara.status,'OTHER ACC','*' || al.meaning)  transaction_type  
    , hca.cust_account_id                           cust_trx_id
    , acr.amount                                    orig_amt
    , acr.amount * nvl(acr.exchange_rate,1)         orig_amt_acctd
    , 0 - sum(case when ara.gl_date <= :p_as_of_date then nvl(ara.acctd_amount_applied_from,0) else 0 end) inv_amt_due_p0    
    --
    &lp_amt_due_cols3
    --
    , gl.currency_code ledger_currency
    , max(decode(gl.currency_code,:p_reval_currency,1,(select gdr.conversion_rate from gl_daily_conversion_types gdct, gl_daily_rates gdr where gl.currency_code=gdr.from_currency and gdr.to_currency=:p_reval_currency and :p_reval_conv_date=gdr.conversion_date and gdct.user_conversion_type=:p_reval_conv_type and gdct.conversion_type=gdr.conversion_type))) reval_conv_rate
    from
      hr_operating_units             hou
    , gl_ledgers                     gl
    , ar_receivable_applications_all ara
    , ar_lookups                     al
    , ar_cash_receipts_all           acr
    , ar_cash_receipt_history_all    acrh
    , ar_payment_schedules_all       aps
    , hz_cust_accounts               hca
    , hz_parties                     hp
    , ar_system_parameters_all       sp
    , xle_entity_profiles            xep
    where
        hou.set_of_books_id              = sp.set_of_books_id
    and gl.ledger_id                     = sp.set_of_books_id
    and acr.org_id                       = hou.organization_id
    and acr.org_id                       = ara.org_id
    and hca.cust_account_id              = acr.pay_from_customer
    and hca.party_id                     = hp.party_id
    and acr.cash_receipt_id              = ara.cash_receipt_id
    and acrh.cash_receipt_id             = ara.cash_receipt_id
    and ara.cash_receipt_history_id      = acrh.cash_receipt_history_id
    and aps.cash_receipt_id              = acr.cash_receipt_id
    and al.lookup_type                   = 'PAYMENT_TYPE'
    and ara.status                       = al.lookup_code
    and ara.status                       = 'OTHER ACC'
    and not exists
        ( select 'X'
          from ar_cash_receipt_history_all crhin
          where crhin.cash_receipt_id = acr.cash_receipt_id
          and   crhin.status = 'REVERSED'
          and   crhin.org_id = acr.org_id
        )
    and nvl(ara.confirmed_flag,'Y')      = 'Y'
    and nvl(acr.confirmed_flag,'Y')      = 'Y'
    and xep.legal_entity_id (+)          = acr.legal_entity_id
    and sp.org_id                        = acr.org_id
    and aps.gl_date_closed               > :p_first_gl_date
    and aps.gl_date                     <= :p_as_of_date
    and 2=2
    group by
      xep.name
    , xep.legal_entity_identifier
    , gl.name
    , gl.currency_code
    , hou.name
    , hca.cust_account_id
    , hp.party_name
    , hca.account_number
    , decode(ara.status,'OTHER ACC','*' || al.meaning)
    , acr.receipt_number
    , acr.doc_sequence_value
    , acr.receipt_date
    , al.lookup_code
    , acr.amount
    , nvl(acr.exchange_rate,1)
    , substr(acr.currency_code,1,3)
    , acr.currency_code
  ) trx
where
    :p_periods_range = :p_periods_range
and :p_max_open_periods_range = :p_max_open_periods_range
group by
  trx.legal_entity
, trx.legal_entity_identifier 
, trx.ledger
, trx.ledger_currency
, trx.reval_conv_rate
, trx.ou_name
, trx.customer_name
, trx.account_number
&lp_having_clause
order by
  ledger
, operating_unit
, customer_number
, customer_name